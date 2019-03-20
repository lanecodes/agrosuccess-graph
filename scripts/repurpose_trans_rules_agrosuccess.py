"""
repurpose_trans_rules_agrosuccess.py
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The objectives of this script are are:
1. Map land cover types represented in Millington 2009 to land cover types 
   represented in AgroSuccess.
2. Identify land cover types present in Millington 2009 and not in AgroSuccess, 
   and vice versa. 
3. Reconcile these differences to produce a succession transition table for 
   agrosuccess: `agrosuccess_succession.csv`. This can be consumed by cymod to 
   create a land cover transition graph. Variable and state names (rather than 
   codes) should be used in this table.

- Input is the file ../data/tmp/millington_succession.csv
- Output is the file ../data/created/agrosuccess_succession.csv

"""
import os 
import sys
import logging
import warnings

import pandas as pd

from config import DIRS, exit_if_file_missing
from constants import (
    Succession,
    Aspect,
    SeedPresence,
    Water,
    MillingtonLct as MLct,
    AgroSuccessLct as AsLct,
) 

# ------------------- Replace codes with human readable names------------------
def get_translator(trans_enum):
    """Make a function which uses an enum to translate a dataframe column."""
    def code_translator(df, col_name, post_proc_func=None):
        """Replace codes with names in the :obj:`pandas.DataFrame` column.
        
        Args:
            df (:obj:`pandas.DataFrame`): Datafame containing column to 
                convert.
            col_name (str): Name of the column to convert.
            post_proc_func (function, optional): Function to apply to each 
                enum member name after it's been used to replace a codes in 
                the column.
        """
        df.loc[:,col_name] = df[col_name].apply(lambda x: trans_enum(x).alias)
        if post_proc_func:
            df.loc[:,col_name] = df[col_name].apply(post_proc_func)
        return df
    return code_translator

def millington_trans_table_codes_to_names(df):
    """Replace state/condition codes in Millington trans table with names."""
    for state_col in ["start", "delta_D"]:
        df.loc[:,state_col] = df[state_col].apply(lambda x: MLct(x).alias) 

    for seed_col in ["pine", "oak", "deciduous"]:
        df.loc[:,seed_col] = df[seed_col].apply(
            lambda x: True if SeedPresence(x).alias=="true" else False)

    cond_enum_d = {"succession": Succession, "aspect": Aspect, "water": Water}
    for cond, e in cond_enum_d.items():
        df.loc[:,cond] = df[cond].apply(lambda x: e(x).alias)

    return df

# -------------- Convert 1:1 mapped state names to AgroSuccess-----------------
def convert_millington_names_to_agrosuccess(df, start_col, end_col):
    """Apply 1:1 mappings to rename states to match AgroSuccess conventions."""
    map_dict = {
    MLct.PINE: AsLct.PINE,
    MLct.HOLM_OAK: AsLct.OAK,
    MLct.DECIDUOUS: AsLct.DECIDUOUS,
    MLct.WATER_QUARRY: AsLct.WATER_QUARRY,
    MLct.BURNT: AsLct.BURNT,
    MLct.TRANSITION_FOREST: AsLct.TRANS_FOREST,    
    }

    unmapped_m_lcts = [lct.name for lct in MLct 
        if lct not in map_dict.keys()]
    assert unmapped_m_lcts == ["PASTURE", "HOLM_OAK_W_PASTURE", "CROPLAND", 
        "SCRUBLAND", "URBAN"], "LCTs in Millington, not used in AgroSuccess"

    unmapped_as_lcts = [lct.name for lct in AsLct 
        if lct not in map_dict.values()]
    assert unmapped_as_lcts == ['BARLEY', 'WHEAT', 'DAL', 'SHRUBLAND'],\
        "LCTs in AgroSuccess, not used in Millington"

    for col in [start_col, end_col]:
        for k, v in map_dict.items():
            df.loc[:,col] = df[col].replace(k.alias, v.alias)    
    return df

# --------------------- Drop URBAN and HOLM_OAK_W_PASTURE ---------------------
def state_is_exclusive_source_of_other_state(trans_df, state_name, start_col,
        end_col):
    """True if at least one state is only accessible from `state_name`."""
    def tgt_states(df, src_lct_name):
        """Get the states which can originate from `src_lct_name`.

        Exclude the `src_lct_name` state itself.

        Returns:
            list: Names of states which have `src_lct_name` as their source.
        """
        all_trans = df.groupby(by=[start_col, end_col]).size().reset_index()
        if len(all_trans[all_trans[start_col] == src_lct_name]) == 0:
            warnings.warn("No start state called '{0}'".format(src_lct_name))
            return []
        else:
            tgt_trans = all_trans[(all_trans[start_col] == src_lct_name) 
                                  & (all_trans[end_col] != src_lct_name)]
            return list(tgt_trans[end_col].values)    

    def src_states(df, tgt_lct_name):
        """Get the states which `tgt_lct_name` can transition from.

        Exclude the `tgt_lct_name` state itself.

        Returns:
            list: Names of states which can transition to `tgt_lct_name`.    
        """
        start_col = "start"
        end_col = "delta_D"
        all_trans = df.groupby(by=[start_col, end_col]).size().reset_index()
        src_trans = all_trans[(all_trans[end_col] == tgt_lct_name) 
                              & (all_trans[start_col] != tgt_lct_name)]
        return list(src_trans[start_col].values)
    
    states_from_state_name = tgt_states(trans_df, state_name)
    exclusive_source_for = []
    for other_state in states_from_state_name:
        other_state_sources = src_states(trans_df, other_state)
        other_state_sources.remove(state_name)
        if len(other_state_sources) < 1:
            exclusive_source_for.append(other_state)
    if exclusive_source_for:
        print("{0} is the only source for states: {1}".format(
            state_name, ", ".join(exclusive_source_for)))
        return True
    else:
        return False

def drop_holm_oak_w_pasture_and_urban(df, start_col, end_col):
    """Remove rows with excluded land cover types as start or end state.
    
    The `URBAN` and `HOLM_OAK_W_PASTURE` land cover types used in Millington 
    2009 are not needed in AgroSuccess so should be removed entirely. To 
    ensure model integrity I will check that there are no land cover types 
    which *only* come about by transition *from* `URBAN` or 
    `HOLM_OAK_W_PASTURE`.
    """
    def row_excludes_lct(row, lct_name):
        """Return True if row doesn't have lct as start or end state."""
        start_col = "start"
        end_col = "delta_D"
        if row[start_col] == lct_name or row[end_col] == lct_name:
            return False
        else:
            return True
    
    # Confirm removing these states won't leave any other states in the model
    # inaccessbile, and remove it.
    for state in [MLct.HOLM_OAK_W_PASTURE.alias, MLct.URBAN.alias]:
        assert state_is_exclusive_source_of_other_state(df, state, start_col,
                    end_col) == False
        no_rows = len(df.index)
        df = df[df.apply(lambda x: row_excludes_lct(x, state), axis=1)]
        assert len(df.index) < no_rows   
    return df

# ------------ Replace 'cropland' with 'barley', 'wheat' and 'DAL' --------
def replace_cropland_with_new_crop_types(df, start_col, end_col):
    """Replace Millington's cropland state with wheat, barley and DAL.
    
    Args:
        df (:obj:`pandas.DataFrame`): Original transition table containing 
            'cropland' as a land cover state.
            
    Returns:
        df: A new dataframe where rows representing transitions involving 
            cropland are replaced with rows describing transitions involving
            wheat, barley and DAL (depleated agricultural land) states.
    """
    # There are no transitions where cropland is the target state. 
    # Correspondingly no transitions have the new cropland land cover types
    # as their target state. This makes sense, as cropland is something which
    # humans need to create.
    assert len(df[df[end_col] == MLct.CROPLAND.alias].index) == 0
    
    # Rows from old table where cropland is the transition's starting state
    from_cropland = df[df[start_col] == MLct.CROPLAND.alias]
    
    new_crop_dfs = []
    for crop in [AsLct.WHEAT.alias, AsLct.BARLEY.alias, AsLct.DAL.alias]:
        new_crop = from_cropland.copy()
        new_crop.loc[:,start_col] = crop
        new_crop_dfs.append(new_crop)

    new_df = df.copy()
    # remove old cropland rows
    new_df = new_df[new_df[start_col] != MLct.CROPLAND.alias] 
    new_df = pd.concat([new_df] + new_crop_dfs)

    assert (len(new_df.index) == len(df.index) - len(from_cropland.index)                                 
        + 3*len(from_cropland.index)), "Each transition rule starting with "\
        + "'cropland' should be replaced by one each from 'wheat', 'barley' "\
        + "and 'DAL' but the resulting numbers of rows don't tally."

    return new_df

# -- Unify 'pasture' and 'scrubland' types in Millington table to -------------
# -- AgroSuccess 'shrubland' type ---------------------------------------------
def remove_transitions_bw_pasture_and_scrubland(df, start_col, end_col):
    """Drop transitions between pasture and scrubland.
    
    These two land cover types to subsequently removed and replaced with
    'shrubland' type.
    """
    scrub_to_pasture = ((df[start_col] == MLct.PASTURE.alias) 
                        & (df[end_col] == MLct.SCRUBLAND.alias))
    pasture_to_scrub = ((df[start_col] == MLct.SCRUBLAND.alias) 
                        & (df[end_col] == MLct.PASTURE.alias))
    return df[~scrub_to_pasture & ~pasture_to_scrub]  

def duplicates_start_with_pasture_or_scrubland(df, start_col, end_col):
    """DataFrame with duplicated transitions.
    
    All have 'pasture' or 'shrubland' as their start state.
    """
    cond_cols = ["succession", "aspect", "pine", "oak", "deciduous", "water"]
    rel_start_df = df[(df[start_col] == MLct.PASTURE.alias) 
                    | (df[start_col] == MLct.SCRUBLAND.alias)]
    duplicate_check_cols = cond_cols + [end_col]
    duplicates = rel_start_df[rel_start_df.duplicated(duplicate_check_cols, 
        keep=False)]
    duplicates = duplicates.sort_values(duplicate_check_cols)
    return duplicates

def duplicates_end_with_pasture_or_scrubland(df, start_col, end_col):
    """DataFrame with duplicated transitions.
    
    All have 'pasture' or 'shrubland' as their end state.
    """
    cond_cols = ["succession", "aspect", "pine", "oak", "deciduous", "water"]
    rel_start_df = df[(df[end_col] == MLct.PASTURE.alias) 
                        | (df[end_col] == MLct.SCRUBLAND.alias)]
    duplicate_check_cols = cond_cols + [start_col]
    duplicates = rel_start_df[rel_start_df.duplicated(duplicate_check_cols, 
        keep=False)]
    duplicates = duplicates.sort_values(duplicate_check_cols)
    return duplicates

def replace_pasture_scrubland_with_shrubland(df, start_col, end_col):
    """Merge pasture and scrubland state transitions into 'shrubland'.
    
    1. Remove transitions /between/ scrubland and pasture and vice versa.
    2. Check there are no duplicate transitions which would be caused by an
       identical set of conditions leading from or to both pasture and 
       scrubland being merged. 
    3. Rename all instances of either 'scrubland' or 'pasture' to 'shrubland'
    4. Check for duplicates again.    
    """
    df = remove_transitions_bw_pasture_and_scrubland(df, start_col, end_col)
    
    duplicates_start = duplicates_start_with_pasture_or_scrubland(df,
                            start_col, end_col)
    assert len(duplicates_start.index) == 0, "No duplicates expected."

    duplicates_end = duplicates_end_with_pasture_or_scrubland(df, 
                            start_col, end_col)
    assert len(duplicates_end.index) == 0, "No duplicates expected."
    
    for col in [start_col, end_col]:
        for lct in [MLct.SCRUBLAND.alias, MLct.PASTURE.alias]:
            df.loc[:,col] = df[col].replace(lct, AsLct.SHRUBLAND.alias)   
    
    cond_cols = ["succession", "aspect", "pine", "oak", "deciduous", "water"]
    cond_cols += [start_col, end_col]
    assert len(df[df.duplicated(cond_cols)].index) == 0, "There should be "\
        + "no duplicated rows."
    
    return df

# ----- Remove transitions starting and ending with same state ----------------
def remove_end_same_as_start_transitions(df, start_col, end_col):
    """Remove rows corresponding to transitions where start equals end state.
    
    Millington 2009 used a methodology where if a combination of conditions
    didn't result in a transition, this would be represented in the model by
    specifying a transition with start and end state being the same, and a 
    transition time of 0 years. 
    
    AgroSuccess will handle 'no transition' rules differently, so these dummy
    transitions should be excluded.    
    """
    def start_different_to_end(row):
        if row[start_col] == row[end_col]:
            return False
        else:
            return True
        
    return df[df.apply(start_different_to_end, axis=1)]

# ----------------------- Sort and reindex transition table -------------------
def sort_and_reindex_trans_table(df, start_col, end_col):
    coded_to_named_d = {"tmp_code_start": start_col, "tmp_code_end": end_col}
    for k, v in coded_to_named_d.items():
        df.loc[:,k] = df[v].apply(lambda x: AsLct.from_alias(x).value)
    
    cond_cols = ["succession", "aspect", "pine", "oak", "deciduous", "water"]
    s_cols = ["tmp_code_start", "tmp_code_end"] + cond_cols
    df = df.sort_values(by=s_cols)
    df = df.reset_index()
    df.index.name = "transID"
    df = df.drop(["index"] + list(coded_to_named_d.keys()), axis=1)
    return df


if __name__ == "__main__":
    # I've done my best to remove instances of setting with copy but this warning
    # keeps surfacing. Suppressed as I don't think it's causing a problem.
    warnings.simplefilter("ignore", 
        category=pd.core.common.SettingWithCopyWarning)
    
    # Change working directory to location of script
    os.chdir(DIRS["scripts"])

    # Check necessary files and directories exist
    SRC_FILE = os.path.join(
        DIRS["data"]["tmp"], "millington_succession.csv")
    exit_if_file_missing(SRC_FILE)

    # set up logging
    LOG_FILE = os.path.join(
        DIRS["logs"], os.path.basename(__file__).split(".py")[0] + ".log")
    logging.basicConfig(filename=LOG_FILE, filemode='w', level=logging.INFO)

    # Make reference to output file name
    OUT_FILE = os.path.join(
        DIRS["data"]["created"], "agrosuccess_succession.csv")

    # Process Millington transition table
    START_COL = "start"
    END_COL = "delta_D"
    m_df = pd.read_csv(SRC_FILE)
    m_df = millington_trans_table_codes_to_names(m_df)
    as_df = m_df.copy()
    as_df = convert_millington_names_to_agrosuccess(as_df, START_COL, END_COL)
    as_df = drop_holm_oak_w_pasture_and_urban(as_df, START_COL, END_COL)
    as_df = replace_cropland_with_new_crop_types(as_df, START_COL, END_COL)
    as_df = replace_pasture_scrubland_with_shrubland(as_df, START_COL, END_COL)
    as_df = remove_end_same_as_start_transitions(as_df, START_COL, END_COL)
    as_df = sort_and_reindex_trans_table(as_df, START_COL, END_COL)
    as_df.to_csv(OUT_FILE)



# coding: utf-8

# # Repurpose Millington2009 transition rules
# 

# The objectives of this notebook are:
# 1. Map land cover types represented in Millington 2009 to land cover types represented in AgroSuccess.
# 2. Identify land cover types present in Millington 2009 and not in AgroSuccess, and vice versa. 
# 3. Reconcile these differences to produce a succession transition table for agrosuccess: `agrosuccess_succession.csv`. This can be consumed by cymod to create a land cover transition graph. Variable and state names (rather than codes) should be used in this table.

# In[38]:


import os
import sys
import warnings
from enum import Enum
import pandas as pd

# Add AgroSuccessGraph scripts to path
sys.path.insert(0, "../scripts")
from clean_millington_trans_table import (
    Succession,
    Aspect,
    SeedPresence,
    Water,
    MillingtonLct,
)


# ## 0. Load Millington Succession Transition table

# In[3]:


m_table_file = os.path.join("tmp", "millington_succession.csv")
m_df = pd.read_csv(m_table_file)
print(m_df.head())


# Use the `MillingtonLct` and state code enums to replace state and environmental condition codes with their names

# In[4]:


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
        df[col_name] = df[col_name].apply(lambda x: trans_enum(x).name)
        if post_proc_func:
            df[col_name] = df[col_name].apply(post_proc_func)
        return df
    return code_translator

def millington_trans_table_codes_to_names(df):
    """Replace state/condition codes in Millington trans table with names."""
    for state_col in ["start", "delta_D"]:
        df = get_translator(MillingtonLct)(df, state_col, lambda x: x.lower())

    for seed_col in ["pine", "oak", "deciduous"]:
        df = get_translator(SeedPresence)(
            df, seed_col, lambda x: True if x=="TRUE" else False)

    df = get_translator(Succession)(df, "succession", lambda x: x.lower())
    df = get_translator(Aspect)(df, "aspect", lambda x: x.lower())
    df = get_translator(Water)(df, "water", lambda x: x.lower())
    return df


# In[5]:


m_df = millington_trans_table_codes_to_names(m_df)
print(m_df.head())


# ### 0.1. Compare Millington land cover types to AgroSuccess types

# In[6]:


def show_enum(e):
    line_len = max([len(item.name) for item in e])
    print(e.__name__ + "\n" + "-"*len(e.__name__))
    for item in e:
        print("{0: <{1}} {2}".format(item.name, line_len + 5, item.value))


# The land cover types represented in AgroSuccess are specified by the following class:

# In[7]:


class AgroSuccessLct(Enum):
    """Land cover types and corresponding codes used in AgroSuccess."""
    WATER_QUARRY = 0
    BURNT = 1
    BARLEY = 2
    WHEAT = 3
    DAL = 4
    SHRUBLAND = 5
    PINE = 6
    TRANS_FOREST = 7
    DECIDUOUS = 8
    OAK = 9   


# Comparing these types to AgroSuccessLct we get the following

# In[8]:


show_enum(MillingtonLct)
print("")
show_enum(AgroSuccessLct)


# The simple 1:1 mappings are as follows:

# In[9]:


m_to_a_lct = {
    MillingtonLct.PINE: AgroSuccessLct.PINE,
    MillingtonLct.HOLM_OAK: AgroSuccessLct.OAK,
    MillingtonLct.DECIDUOUS: AgroSuccessLct.DECIDUOUS,
    MillingtonLct.WATER_QUARRY: AgroSuccessLct.WATER_QUARRY,
    MillingtonLct.BURNT: AgroSuccessLct.BURNT,
    MillingtonLct.TRANSITION_FOREST: AgroSuccessLct.TRANS_FOREST,    
}


# In[10]:


unmapped_m_lcts = [lct.name for lct in MillingtonLct 
                   if lct not in m_to_a_lct.keys()]
assert unmapped_m_lcts     == ["PASTURE", "HOLM_OAK_W_PASTURE", "CROPLAND", "SCRUBLAND", "URBAN"]    , "LCTs in Millington, not used in AgroSuccess"

unmapped_as_lcts = [lct.name for lct in AgroSuccessLct 
                    if lct not in m_to_a_lct.values()]
assert unmapped_as_lcts == ['BARLEY', 'WHEAT', 'DAL', 'SHRUBLAND']    , "LCTs in AgroSuccess, not used in Millington"


# These results suggest the following modifications to repurpose the Millington 2009 transition rules for AgroSuccess:
# 
# 1. Apply 1:1 mappings to rename relevant states to match AgroSuccess conventions
# 2. Remove the URBAN and HOLM_OAK_W_PASTURE land cover types
# 3. Replace 'cropland' with 'barley', 'wheat' and 'DAL'
# 4. Unify 'pasture' and 'scrubland' types in Millington table to AgroSuccess 'shrubland' type

# ## 1. Apply map of Millington land cover types to AgroSuccess types to transition table

# In[11]:


START_COL = "start"
END_COL = "delta_D"
as_df = m_df.copy()

def convert_millington_names_to_agrosuccess(df, map_dict, start_col, end_col):
    for col in [start_col, end_col]:
        for k, v in map_dict.items():
            df[col] = df[col].replace(k.name.lower(), v.name.lower())    
    return df


# In[12]:


as_df = convert_millington_names_to_agrosuccess(as_df, m_to_a_lct, START_COL, 
            END_COL)


# ## 2. Drop URBAN and HOLM_OAK_W_PASTURE

#  The `URBAN` and `HOLM_OAK_W_PASTURE` land cover types used in Millington 2009 are not needed in AgroSuccess so should be removed entirely. To ensure model integrity I will check that there are no land cover types which *only* come about by transition *from* `URBAN` or `HOLM_OAK_W_PASTURE`. I.e.

# In[13]:


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


# In[14]:


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
    for state in ["holm_oak_w_pasture", "urban"]:
        assert state_is_exclusive_source_of_other_state(df, state, start_col,
                    end_col) == False
        no_rows = len(df.index)
        df = df[df.apply(lambda x: row_excludes_lct(x, state), axis=1)]
        assert len(df.index) < no_rows   
    return df


# In[15]:


as_df = drop_holm_oak_w_pasture_and_urban(as_df, START_COL, END_COL)


# Outstanding queries about mapping from Millington LCTs to AgroSuccess LCTs
# 1. How should I Map CROPLAND to BARLEY, WHEAT and DAL?
# 2. Why doesn't shrubland appear in MillingtonLct? shrubland appears in the Millington2009 paper but not in James's thesis. I seem to remember discussing whether that might map directly to another landcover type in the thesis. Possibly pasture or scrubland?
# 3. Might it make sense to drop HOLM_OAK_WITH_PASTURE, URBAN, PASTURE, SCRUBLAND?

# The problem is what to do about transitions going from another state to cropland in Millington2009. In that case, which of my new type (Barley, Wheat or DAL) should the cell transition to?

# **Query**: what do land cover classes 7, 8, 10 and 11 given in supplementary materials correspond to? They all transition *to* shrubland (land cover class 5) an so are similar to the 'burnt' class but differ in succession pathway and duration of time spent in class before transition to shrubland.

# ## 3. Replace 'cropland' with 'barley', 'wheat' and 'DAL'

# Find states transitioning from cropland to something else:

# In[16]:


as_df[as_df[START_COL] == "cropland"][END_COL].unique()


# So all cropland transitions to pasture. What transitions to cropland?

# In[17]:


as_df[as_df[END_COL] == "cropland"][START_COL].unique()


# Nothing. Okay so although `MillingtonLct.CROPLAND` doesn't map 1:1 with anything in `AgroSuccessLct`, we can replace rows matching  `as_df["start"] == "cropland"` with the same conditions starting with `"wheat"`, `barley` or `"dal"`

# In[18]:


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
    assert len(df[df[end_col] == "cropland"].index) == 0
    
    # Rows from old table where cropland is the transition's starting state
    from_cropland = df[df[start_col] == "cropland"]
    
    new_crop_dfs = []
    for crop in ["wheat", "barley", "dal"]:
        new_crop = from_cropland.copy()
        new_crop.loc[:, start_col] = crop
        new_crop_dfs.append(new_crop)

    new_df = df.copy()
    new_df = new_df[new_df[start_col] != "cropland"] # remove old cropland rows
    new_df = pd.concat([new_df] + new_crop_dfs)

    assert len(new_df.index) == len(df.index) - len(from_cropland.index)                                 + 3*len(from_cropland.index), "Each "        + "transition rule starting with 'cropland' should be replaced by "        + "one each from 'wheat', 'barley' and 'DAL' but the resulting "        + "numbers of rows don't tally."
    
    return new_df


# In[19]:


as_df = replace_cropland_with_new_crop_types(as_df, START_COL, END_COL)


# In[20]:


len(as_df.index)


# In[21]:


as_df.head()


# ## 4. Unify 'pasture' and 'scrubland' types in Millington table to AgroSuccess 'shrubland' type

# 1. List transitions starting with pasture or scrubland with duplicate conditions
# 2. list transitions ending with pasture or scrubland with duplicate conditions

# In[27]:


def remove_transitions_bw_pasture_and_scrubland(df, start_col, end_col):
    """Drop transitions between pasture and scrubland.
    
    These two land cover types to subsequently removed and replaced with
    'shrubland' type.
    """
    scrub_to_pasture = (df[start_col] == "pasture") & (df[end_col] == "scrubland")
    pasture_to_scrub = (df[start_col] == "scrubland") & (df[end_col] == "pasture")
    return df[~scrub_to_pasture & ~pasture_to_scrub]  

def duplicates_start_with_pasture_or_scrubland(df, start_col, end_col):
    """DataFrame with duplicated transitions.
    
    All have 'pasture' or 'shrubland' as their start state.
    """
    cond_cols = ["succession", "aspect", "pine", "oak", "deciduous", "water"]
    rel_start_df = df[(df[start_col] == "pasture") | (df[start_col] == "scrubland")]
    duplicate_check_cols = cond_cols + [end_col]
    duplicates = rel_start_df[rel_start_df.duplicated(duplicate_check_cols, keep=False)]
    duplicates = duplicates.sort_values(duplicate_check_cols)
    return duplicates

def duplicates_end_with_pasture_or_scrubland(df, start_col, end_col):
    """DataFrame with duplicated transitions.
    
    All have 'pasture' or 'shrubland' as their end state.
    """
    cond_cols = ["succession", "aspect", "pine", "oak", "deciduous", "water"]
    rel_start_df = df[(df[end_col] == "pasture") | (df[end_col] == "scrubland")]
    duplicate_check_cols = cond_cols + [start_col]
    duplicates = rel_start_df[rel_start_df.duplicated(duplicate_check_cols, keep=False)]
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
        for lct in ["scrubland", "pasture"]:
            df[col] = df[col].replace(lct, "shrubland")   
    
    cond_cols = ["succession", "aspect", "pine", "oak", "deciduous", "water"]
    cond_cols += [start_col, end_col]
    assert len(df[df.duplicated(cond_cols)].index) == 0, "There should be "        + "no duplicated rows."
    
    return df


# In[28]:


as_df = replace_pasture_scrubland_with_shrubland(as_df, START_COL, END_COL)


# In[31]:


as_df.groupby([START_COL, END_COL]).size()


# ## 5. Remove transitions starting and ending with same state

# In[34]:


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


# In[62]:


as_df = remove_end_same_as_start_transitions(as_df, START_COL, END_COL)


# ## 6. Sort and reindex transition table

# In[78]:


def sort_and_reindex_trans_table(df, start_col, end_col):
    def enum_name_from_code(e, name):
        for item in e:
            if item.name == name:
                return item.value
    
    df.loc[:,"tmp_code_start"] = df[start_col].apply(
        lambda x: enum_name_from_code(AgroSuccessLct, x.upper()))
    df.loc[:,"tmp_code_end"] = df[end_col].apply(
        lambda x: enum_name_from_code(AgroSuccessLct, x.upper()))
    
    cond_cols = ["succession", "aspect", "pine", "oak", "deciduous", "water"]
    s_cols = ["tmp_code_start", "tmp_code_end"] + cond_cols
    df = df.sort_values(by=s_cols)
    df = df.reset_index()
    df.index.name = "transID"
    df = df.drop(["index", "tmp_code_start", "tmp_code_end"], axis=1)
    return df


# In[79]:


as_df = sort_and_reindex_trans_table(as_df, START_COL, END_COL)


# ## 7. Write completed table to file

# In[80]:


as_df.to_csv(os.path.join("created", "agrosuccess_succession.csv"))
#! /usr/bin/env python
import os
import datetime
import pandas as pd

def get_header_str(project_path, start_code, end_code):
    """Return a string which will make up the header portion of the Cypher 
       file which will specify the SuccessionTrajectory between 
       ``start_code`` and ``end_code`` along with all the possible 
       combinations of EnvironConditions which cause that transition.

    """
    header_str = """
    //==============================================================================
    // file: {0}/{1}_to_{2}_w.cql
    // modified: {3}
    // dependencies:
    //     abstract/LandCoverType_w.cql
    // external parameters:
    //     model_ID, used to identify model created nodes belong to 
    // description:
    //     Create the Successiontrajectory representing the possibility of 
    //     transition between the {1} and {2} LandCoverState-s. Also specify all 
    //     combinations of environmental conditions which can lead to this 
    //     transition.
    //==============================================================================

    {{
     "priority":1
    }}
    """.format(project_path, start_code, end_code, str(datetime.date.today()))
    return header_str

def get_succession_traj_query(start_code, end_code):
    """Return a string containing the appropriate query to create a 
       SuccessionTrajectory between ``start_code`` and ``end_code``

    """
    traj_query = """
    MATCH
      (srcLCT:LandCoverType {{code:\"{0}\", model_ID:$model_ID}}),
      (tgtLCT:LandCoverType {{code:\"{1}\", model_ID:$model_ID}})
    CREATE
      (traj:SuccessionTrajectory {{model_ID:$model_ID}})
    MERGE (srcLCT)<-[:SOURCE]-(traj)-[:TARGET]->(tgtLCT);

    """.format(start_code, end_code)
    return traj_query

def get_env_cond_query(row):
    """Given a pandas dataframe row, construct query to load environmental
       conditions.
    
    """
    succ = 'secondary' if row['succession'] == 1 else 'regeneration'
    aspe = 'south' if row['aspect'] == 1 else 'north'
    pine = 'true' if row['pine'] == 1 else 'false'
    oak = 'true' if row['oak'] == 1 else 'false'
    decid = 'true' if row['deciduous'] == 1 else 'false'
    if row['water'] == 0:
        water = 'xeric'
    elif row['water'] == 1:
        water = 'mesic'
    else:
        water = 'hydric'
    delta_t = row['delta_T']
    
    env_cond_query = """
    MERGE 
      (ec:EnvironCondition {{model_ID:$model_ID,
                            succession:\"{0}\", 
                            aspect:\"{1}\", 
                            pine:{2},
                            oak:{3},
                            deciduous:{4},
                            water:\"{5}\",
                            delta_t:\"{6}\"}})
    WITH ec
    MATCH 
      (:LandCoverType {{code:\"{7}\", model_ID:$model_ID}})
      <-[:SOURCE]-(traj:SuccessionTrajectory {{model_ID:$model_ID}})-[:TARGET]->
      (:LandCoverType {{code:\"{8}\", model_ID:$model_ID}}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    """.format(succ, aspe, pine, oak, decid, water, delta_t,
               row['start_code'], row['end_code'])
    return env_cond_query

def get_file_dict(df):
    d = {}
    for index, row in df.iterrows():
        start = row['start_code']
        end = row['end_code']
        fname = start +'_to_'+ end +'_w.cql'
        if fname not in d:
            d[fname] = get_header_str('succession', start, end) +\
                       get_succession_traj_query(start, end)
        d[fname] += get_env_cond_query(row)

    return d
                                            

    
        

if __name__ == """__main__""":
    df = pd.read_pickle('traj.pkl')
    d = get_file_dict(df)
    for k in d.keys():
        with open(os.path.join('succession', k), 'w') as f:
            f.write(d[k])
                  
        
#    print get_env_cond_query(df.iloc[130])
#    print get_header_str('succession', 'Pine', 'Oak') + get_succession_traj_query('pine', 'oak')



    

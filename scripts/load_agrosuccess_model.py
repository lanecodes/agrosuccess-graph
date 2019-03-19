#! /opt/miniconda3/envs/graphs27/bin/python
from __future__ import print_function
import sys
import os
import warnings; warnings.simplefilter("ignore")
import numpy as np
import pandas as pd

from cymod import ServerGraphLoader, NodeLabels, read_params_file

SUCCESSION_TABLE_PATH = "../data/created/agrosuccess_succession.csv"
PARAMS_FILE = "../global_parameters.json"
REFRESH_GRAPH = True

def agrosuccess_succession_df(path_to_succession_csv):
    """Read succession transition table as :obj:pd.DataFrame`.

    Returns:
        :obj:`pd.DataFrame`: Transition table for the AgroSuccess model.
    """
    df = pd.read_csv(path_to_succession_csv)
   
    return df

if not os.path.exists(SUCCESSION_TABLE_PATH):
    sys.exit("Succession table file " + SUCCESSION_TABLE_PATH
             + " does not exist.")

# Initialise database connection
sgl = ServerGraphLoader("neo4j", "password")

# Load parameters from external file
params = read_params_file(PARAMS_FILE)

# Specify custom node labels
labels = NodeLabels({"State": "LandCoverType", 
                     "Transition": "LandCoverTransition",
                     "Condition" : "EnvironCondition"})

# Delete existing data matching global parameters
if REFRESH_GRAPH:
    print("Deleting old data matching global params: ", str(params))
    sgl.refresh_graph(params)

# Load tabular data
print("Loading cypher queries from", SUCCESSION_TABLE_PATH, "...")
sgl.load_tabular(agrosuccess_succession_df(SUCCESSION_TABLE_PATH), 
    'start', 'delta_D', labels=labels, global_params=params)

# Commit queries to database
print("Committing queries to database...")
sgl.commit()
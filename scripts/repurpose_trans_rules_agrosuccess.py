"""
repurpose_trans_rules_agrosuccess.py
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Input is the file ../data/tmp/millington_succession.csv
- Output is the file 

"""
import os 
import sys
import subprocess

import pandas as pd

# -------------- SET UP DIRECTORIES, CHECK INPUT FILES PRESENT ----------------
# Change working directory to location of script
os.chdir(os.path.dirname(os.path.abspath(__file__)))

# Create references to directories and files
DATA_DIR = os.path.abspath(os.path.join("..", "data"))
CREATED_DIR = os.path.join(DATA_DIR, "created")
TMP_DIR = os.path.join(DATA_DIR, "tmp")
for d in [CREATED_DIR, TMP_DIR]:
    try:
        os.makedirs(d)
    except FileExistsError:
        pass

SRC_FILE = os.path.join(TMP_DIR, "millington_succession.csv")
if not os.path.isfile(SRC_FILE):
    sys.exit("Source file {0} does not exist.".format(SRC_FILE))

OUT_FILE = os.path.join(CREATED_DIR, "agrosuccess_succession.csv")

LOG_FILE = os.path.basename(__file__).split(".py")[0] + ".log"
if os.path.exists(LOG_FILE):
    os.remove(LOG_FILE)

print(OUT_FILE)
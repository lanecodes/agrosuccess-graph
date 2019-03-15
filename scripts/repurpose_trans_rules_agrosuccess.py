"""
repurpose_trans_rules_agrosuccess.py
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Input is the file ../data/tmp/millington_succession.csv
- Output is the file ../data/created/agrosuccess_succession.csv

"""
import os 
import logging

import pandas as pd
from config import DIRS, exit_if_file_missing

# TODO Add functions required to repurpose Millington succession table for 
# Agrosuccess

if __name__ == "__main__":
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


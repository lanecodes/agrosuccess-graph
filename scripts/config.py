"""
config.py
~~~~~~~~~

Common configuration settings for scripts used to make the AgroSuccess 
succession rules table.
"""
import os 
import sys

DATA_DIR = os.path.abspath(os.path.join("..", "data"))
THIS_DIR = os.path.dirname(os.path.abspath(__file__))
DIRS = {
    "scripts": THIS_DIR,
    "logs": os.path.join(THIS_DIR, "logs"),
    "data": {
        "raw": os.path.join(DATA_DIR, "raw"),
        "created": os.path.join(DATA_DIR, "created"),
        "tmp": os.path.join(DATA_DIR, "tmp"),
    },
}

def ensure_dirs_exist(dir_list):
    """Given list of dir names, recursively create dirs if they don't exist."""
    for d in dir_list:
        try:
            os.makedirs(d)
        except FileExistsError:
            pass

def exit_if_file_missing(fname):
    """Exit program if given file name doesn't exit."""
    if not os.path.isfile(fname):
        sys.exit("Source file {0} does not exist.".format(fname))

# Check if all data and logs directories exist, make them if not
ensure_dirs_exist(list(DIRS["data"].values()) + [DIRS["logs"]])
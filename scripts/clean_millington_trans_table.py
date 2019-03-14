"""
clean_millington_trans_table.py
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Extract succession pathday data published by Millington et al. 2009.

In their paper, Millington, Wainwright and Perry (2009) describe a landscape 
fire-succession model which represents the variaous ways in which landscape 
vegetation can evolve under different environmental conditions. An important 
component of this model is a representation of the different pathways along 
which a particular patch of the landscape might evolve, contingent on other 
environmental variables appearing endogenously within the model. For example, 
during the course of secondary succession following a wildfire, a patch of 
shrubland might (all else being equal) transform into a deciduous forest under 
hydric (wet) conditions, or a pine forest under xeric (dry) conditions. 
Alternatively succession pathways might be disturbance-mediated: if fires are 
infrequent, incumbent resprouting oak trees may regenerate into an oak forest 
once more, whereas frequent fire may favour pine species whose seeds lie 
dormant in the soil awaiting stand-clearing fires to reduce light competition.

These succession pathways (among many other possibilities) are represented in 
Fig. 2 of the referenced paper. They are also provided as a table in the 
paper's supplementary materials in a file called 
1-s2.0-S1364815209000863-mmc1.doc. In this script we perform some rudimentary 
data cleansing to extract this data and record it in a more easily 
machine-readable .csv format.

- Input is the file ../data/raw/1-s2.0-S1364815209000863-mmc1.doc
- Output is the file ../data/tmp/millington_succession.csv

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
RAW_DIR = os.path.join(DATA_DIR, "raw")
TMP_DIR = os.path.join(DATA_DIR, "tmp")
for d in [RAW_DIR, TMP_DIR]:
    try:
        os.makedirs(d)
    except FileExistsError:
        pass

SRC_FILE = os.path.join(RAW_DIR, "1-s2.0-S1364815209000863-mmc1.doc")
if not os.path.isfile(SRC_FILE):
    sys.exit("Source file {0} does not exist.".format(SRC_FILE))

OUT_FILE = os.path.join(TMP_DIR, "millington_succession.csv")

LOG_FILE = os.path.basename(__file__).split(".py")[0] + ".log"
if os.path.exists(LOG_FILE):
    os.remove(LOG_FILE)


# ----------------------- CONVERT .DOC FILE TO HTML ---------------------------
# Uses the soffice command which comes with Libreoffice. 
# Output of soffice --version at time of writing:
# > LibreOffice 5.1.6.2 10m0(Build:2)
table_html_file_base = os.path.basename(SRC_FILE).split(".doc")[0] + ".html"
table_html_file = os.path.join(TMP_DIR, table_html_file_base)
if not os.path.exists(table_html_file):
    with open(LOG_FILE, "a") as lf:
        subprocess.run(["soffice", "--convert-to", 
            "html:XHTML Writer File:UTF8", SRC_FILE], stdout=lf)
    
    # Move html file to temp directory
    os.rename(table_html_file_base, table_html_file)

# ----------------- EXTRACT HTML TABLE WITH PANDAS ----------------------------
# Get dataframe from the html using pandas
with open(table_html_file, "r") as f:
    df = pd.read_html(f.read())[0]

df.columns = ['start', 'succession', 'aspect', 'pine', 'oak', 'deciduous', 
    'water', 'delta_D', 'delta_T']
df.drop(0, inplace=True)
df.to_csv(OUT_FILE, index=False, encoding='ascii')
print("Millington transition table written to " + OUT_FILE)

# ----------------- REMOVE TEMPORARY HTML FILE --------------------------------
os.remove(table_html_file)

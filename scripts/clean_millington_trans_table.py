"""
clean_millington_trans_table.py
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Extract succession pathday data published by Millington et al. 2009.

In their paper, Millington, Wainwright and Perry (2009) describe a landscape 
fire-succession model which represents the various ways in which landscape
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
import subprocess
import logging
import pandas as pd
from config import DIRS, exit_if_file_missing
from constants import MillingtonPaperLct

def convert_doc_to_html(doc_file, output_dir, overwrite=True):
    """Use Libreoffice's `soffice` command to convert .doc file to .html.

    Tested with LibreOffice 5.1.6.2 10m0(Build:2) in Mar 2019.

    Returns:
        str: Name of the output html file.
    """  
    html_basename = os.path.basename(doc_file).split(".doc")[0] + ".html"
    html_fname = os.path.join(output_dir, html_basename)
    cmd = ["soffice", "--convert-to", "html:XHTML Writer File:UTF8", doc_file]

    if overwrite or not os.path.exists(html_fname):
        try:
            output = subprocess.check_output(cmd)
        except subprocess.CalledProcessError as e:
            logging.error("libreoffice failed to convert .doc file to .html")
            raise e
    
    # Move html file to output directory
    script_dir_name = os.path.dirname(os.path.realpath(__file__))
    html_output_file = os.path.join(script_dir_name, html_basename)
    try:
        os.rename(html_output_file, html_fname)
    except FileNotFoundError:
        raise FileNotFoundError(html_output_file + " expected to exist. "\
            + "soffice command may not have run. Check libreoffice not "\
            + "already visiting file.")

    return html_fname

def millington_succession_html_to_csv(html_file, csv_fname):
    """Scrapes the table from Millington 2009 supplementary materials.
    
    Returns:
        str: Name of the resulting csv file.
    """
    # Get dataframe from the html using pandas
    with open(html_file, "r") as f:
        df = pd.read_html(f.read())[0]

    df.columns = [
        'start', 
        'succession', 
        'aspect', 
        'pine', 
        'oak', 
        'deciduous', 
        'water', 
        'delta_D', 
        'delta_T',
    ]
    
    # First row in extracted table is header info
    df.drop(0, inplace=True)
    df.to_csv(csv_fname, index=False, encoding='ascii')
    logging.info("Millington transition table written to " + csv_fname)
    
    return csv_fname


if __name__ == "__main__":
    # Change working directory to location of script
    os.chdir(DIRS["scripts"])

    # Check necessary files and directories exist
    SRC_FILE = os.path.join(
        DIRS["data"]["raw"], "1-s2.0-S1364815209000863-mmc1.doc")
    exit_if_file_missing(SRC_FILE)

    # set up logging
    LOG_FILE = os.path.join(
        DIRS["logs"], os.path.basename(__file__).split(".py")[0] + ".log")
    logging.basicConfig(filename=LOG_FILE, filemode='w', level=logging.INFO)

    # Make reference to output file name
    OUT_FILE = os.path.join(DIRS["data"]["tmp"], "millington_succession.csv")

    # Convert .doc file from Millington2009 sup. materials to html file
    html_fname = convert_doc_to_html(SRC_FILE, DIRS["data"]["tmp"])
    
    # Convert intermediate html file to csv
    millington_succession_html_to_csv(html_fname, OUT_FILE)

    # remove temporary html file
    os.remove(html_fname)

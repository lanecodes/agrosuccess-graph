# AgroSuccess Graph

## Requirements

- [Docker](https://docs.docker.com/install/)
- [Conda](https://docs.conda.io/en/latest/)
- [Libre Office](https://www.libreoffice.org/), specifically the `soffice`
  command should be available to your shell.

## Input data

The main piece of input data external to this repository is the file
`1-s2.0-S1364815209000863-mmc1.doc`. This can be found in the supplementary
materials of [Millington et al. 2009][Millington2009], and should be
downloaded and placed in the directory `./data/raw/`. This file forms the
basis for the exological transition pathways available in the model.

Additional input data is provided by the Cypher queries in the `./views`
directory, but this should be checked in under version control as part of this
repository.

## Setup

Install and initialise the Python environment

```bash
conda env create -f as_model_env.yml
conda activate as_model
```

Run the scripts needed to transform source data into the AgroSuccess model

```bash
cd scripts
python clean_millington_trans_table.py
python repurpose_trans_rules_agrosuccess.py
cd ../
```

Create and start the Docker container. Note this should only need to be run
once. The container can then be stopped and started using
`docker stop as-neo4j` and `docker start as-neo4j`, where `as-neo4j` is the
name of the container.

```bash
./create-container.sh
```

## Loading a model into the database

Navigate to the scripts directory and run Python code against the database to
load the AgroSuccess model specified by the Cypher files in the `views` directory
into the database.

```bash
cd scripts
python load_agrosuccess_model.py
```

Multiple versions of the model can be loaded into the database at once by
changing the `model_ID` parameter in `global_parameters.json` before running
`load_agrosuccess_model.py` to load the new version of the model into the database.
Model nodes corresponding to different model versions can be distinguished by
their `model_ID` property.

The graph can now be visualised using the
[Neo4j browser](https://neo4j.com/developer/neo4j-browser/) by visiting
`http://localhost:7474` in your browser.

## Note on location of data and logs

Docker handles the storage locations of the database and its logs behind the
scenes. To see where on your machine the data and logs are stored, consult the
`Mountpoint` values in the results of the following commands, in which
`as-neo4j-data` and `as-neo4j-logs` are the names of the volumes for data and
logs respectively.

```bash
docker volume inspect as-neo4j-data
docker volume inspect as-neo4j-logs
```

### Known issues

There is a known issue related to how Neo4j permissions interact with Docker
bind mounts (see issues
[here](https://github.com/neo4j/docker-neo4j/issues/130)). This complicates
mapping Neo4j logs to a local volume as is
[advised](https://neo4j.com/developer/docker-run-neo4j/) on the Neo4j website.
The workaround, which is implemented in the script `create-container.sh`, is
to use Docker volumes rather than file system mounts.

## TODO

### Fix `visualisation_summary_w.cql` bug

Because `load_agrosuccess_model.py` first loads all Cypher and then loads all tabular data, there are no transitions for `visualisation_summary_w.cql` to match at the time its loaded. This should be fixed by modifying Cymod so that during the call to `ServerGraphLoader.commit`, all queries added to the queue by `ServerGraphLoader.load_cypher` and `ServerGraphLoader.load_tabular` are sorted before running the commits. This might involve adding an optional parameter to `load_tabular` to specify what the priority of the queries derived from the table should be.

This shouldn't cause a problem for the use of the non-summarised data in
simulations. It is more an inconvenience to need to manually evaluate the
Cypher in `visualisation_summary_w.cql` after the graph has been fully loaded.

## Changelog

### [Unreleased]

#### 2 - 2020-07-03 - Update land-cover type code aliases

The enum which we used to use to map between land-cover type aliases and
numerical codes found in the Millington, 2009 supplementary materials turned
out to not correspond to the land cover state codes used in Table 4.1 of
James' thesis as first thought. Here we correct for that mistake.

##### ADDED

- New enum in `constants.py` called `MillingtonPaperLct` which encodes the
  corrected mapping between numerical codes in the long table in the
  supplementary materials of Millington et al. 2009 and the name of land-cover
  states.
- Analytical scripts made to check consistency between `MillingtonPaperLct` and
  the long transition rule table are included in `scripts/check_lct_codes.py`
  and `scripts/summarise_millington_table.py`, as well as notes in
  `data/raw/millington-land-cover-state-codes.csv`.

##### CHANGED

- The enum in `constants.py` which was called `MillingtonLct` has been renamed
  to `MillingtonThesisLct`. This contains the land-cover state code mapping
  used in the thesis.
- References to `MillingtonLct` in `repurpose_trans_rules_agrosuccess.py`,
  `clean_millington_trans_table.py` changed to refer to `MillingtonPaperLct`.

#### 1 - 2020-05-20 - Remove machine-generated succession Cypher files

An older version of [Cymod](https://github.com/lanecodes/cymod) (before v0.0.3) produced machine generated cypher files based on the Millington succession rules table. These were written to `/views/succession` and placed under version control in `3e9c481` on 2018-05-01.

on 2019-01-25 TransTableProcessor was added to Cymod in Cymod commit [e79fa54](https://github.com/lanecodes/cymod/commit/e79fa545d68e59f4608bdb99992402ed4f6ec7fb), and GraphLoader gained the functionality to load tabular transition table data directly into a database in Cymod commit [c091c06](https://github.com/lanecodes/cymod/commit/c091c06f3b049d272df2925d6ab11f7865330552) on 2019-02-14.

On 2019-03-19 (commit `06a7544 `) we add the script `load_agrosuccess_model.py` to AgroSuccess Graph which loads data from the Millington table into the graph database directly, but to not remove the older machine generated Cypher files containing the same information.

##### Removed

- Delete old machine-generated Cypher files describing succession processes which are now loaded directly from csv to graph database using Cymod.

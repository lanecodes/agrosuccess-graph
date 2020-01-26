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
load the Gredos model specified by the Cypher files in the `views` directory
into the database.

```bash
cd scripts
python load_agrosuccess_model.py
```

Multiple versions of the model can be loaded into the database at once by
changing the `model_ID` parameter in `global_parameters.json` before running
`load_gredos_model.py` to load the new version of the model into the database.
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

{
    "priority": 3
}

MATCH (env:SuccessionTrajectory {model_ID: "AgroSuccess-dev"})
WITH env
MATCH (src:LandCoverType)
      <-[:SOURCE]-(env)-[:TARGET]->
      (tgt:LandCoverType)
MERGE (src)-[tr:TRANSITIONS_TO {model_ID: "AgroSuccess-dev"}]->(tgt)

RETURN tr, src, tgt;

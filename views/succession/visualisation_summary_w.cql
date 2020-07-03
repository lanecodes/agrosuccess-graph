{
    "priority": 3
}

MATCH (trj:SuccessionTrajectory {model_ID:$model_ID})
WITH trj
MATCH (src:LandCoverType)
      <-[:SOURCE]-(trj)-[:TARGET]->
      (tgt:LandCoverType)
WITH src, trj, tgt
MATCH (env:EnvironCondition)-[:CAUSES]->(trj)
WITH src, tgt, min(env.delta_t) AS min_delta_t, max(env.delta_t) AS max_delta_t
MERGE (src)-[tr:TRANSITIONS_TO {
       model_ID:$model_ID,
       min_delta_t: min_delta_t,
       max_delta_t: max_delta_t
      }]->(tgt)
RETURN tr, src, tgt;

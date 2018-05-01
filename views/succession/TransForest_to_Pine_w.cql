
    //==============================================================================
    // file: succession/TransForest_to_Pine_w.cql
    // modified: 2018-05-01
    // dependencies:
    //     abstract/LandCoverType_w.cql
    // external parameters:
    //     model_ID, used to identify model created nodes belong to 
    // description:
    //     Create the Successiontrajectory representing the possibility of 
    //     transition between the TransForest and Pine LandCoverState-s. Also specify all 
    //     combinations of environmental conditions which can lead to this 
    //     transition.
    //==============================================================================

    {
     "priority":1
    }
    
    MATCH
      (srcLCT:LandCoverType {code:"TransForest", model_ID:$model_ID}),
      (tgtLCT:LandCoverType {code:"Pine", model_ID:$model_ID})
    CREATE
      (traj:SuccessionTrajectory {model_ID:$model_ID})
    MERGE (srcLCT)<-[:SOURCE]-(traj)-[:TARGET]->(tgtLCT);

    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"north", 
                            pine:false,
                            oak:false,
                            deciduous:false,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:false,
                            oak:false,
                            deciduous:false,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:false,
                            oak:false,
                            deciduous:true,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:false,
                            oak:true,
                            deciduous:false,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:false,
                            oak:true,
                            deciduous:true,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:true,
                            oak:false,
                            deciduous:false,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:true,
                            oak:false,
                            deciduous:true,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"north", 
                            pine:true,
                            oak:false,
                            deciduous:false,
                            water:"xeric",
                            delta_t:"25"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"north", 
                            pine:true,
                            oak:false,
                            deciduous:true,
                            water:"xeric",
                            delta_t:"25"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:true,
                            oak:true,
                            deciduous:false,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:true,
                            oak:true,
                            deciduous:true,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:false,
                            oak:false,
                            deciduous:false,
                            water:"mesic",
                            delta_t:"25"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"north", 
                            pine:false,
                            oak:false,
                            deciduous:true,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:false,
                            oak:false,
                            deciduous:true,
                            water:"mesic",
                            delta_t:"30"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"north", 
                            pine:true,
                            oak:false,
                            deciduous:false,
                            water:"mesic",
                            delta_t:"25"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"north", 
                            pine:true,
                            oak:false,
                            deciduous:true,
                            water:"mesic",
                            delta_t:"25"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:true,
                            oak:false,
                            deciduous:false,
                            water:"mesic",
                            delta_t:"30"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:true,
                            oak:false,
                            deciduous:true,
                            water:"mesic",
                            delta_t:"30"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:true,
                            oak:false,
                            deciduous:false,
                            water:"hydric",
                            delta_t:"30"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"north", 
                            pine:true,
                            oak:false,
                            deciduous:false,
                            water:"hydric",
                            delta_t:"30"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"south", 
                            pine:true,
                            oak:true,
                            deciduous:false,
                            water:"hydric",
                            delta_t:"30"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"secondary", 
                            aspect:"north", 
                            pine:true,
                            oak:true,
                            deciduous:false,
                            water:"hydric",
                            delta_t:"30"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"regeneration", 
                            aspect:"south", 
                            pine:true,
                            oak:false,
                            deciduous:true,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"regeneration", 
                            aspect:"south", 
                            pine:true,
                            oak:false,
                            deciduous:false,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"regeneration", 
                            aspect:"south", 
                            pine:true,
                            oak:true,
                            deciduous:true,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
    MERGE 
      (ec:EnvironCondition {model_ID:$model_ID,
                            succession:"regeneration", 
                            aspect:"south", 
                            pine:true,
                            oak:true,
                            deciduous:false,
                            water:"xeric",
                            delta_t:"20"})
    WITH ec
    MATCH 
      (:LandCoverType {code:"TransForest", model_ID:$model_ID})
      <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
      (:LandCoverType {code:"Pine", model_ID:$model_ID}) 
    MERGE 
      (ec)-[:CAUSES]->(traj);
    
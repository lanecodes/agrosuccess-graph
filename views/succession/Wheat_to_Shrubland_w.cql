
//==============================================================================
        // file: succession/Wheat_to_Shrubland_w.cql
        // modified: 2018-08-10
        // dependencies:
        //     abstract/LandCoverType_w.cql
        // external parameters:
        //     model_ID, used to identify model created nodes belong to 
        // description:
        //     Create the Successiontrajectory representing the possibility of 
        //     transition between the Wheat and Shrubland LandCoverState-s. Also specify all 
        //     combinations of environmental conditions which can lead to this 
        //     transition.
        //==============================================================================

        {
         "priority":1
        }
        
        MATCH
          (srcLCT:LandCoverType {code:"Wheat", model_ID:$model_ID}),
          (tgtLCT:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        CREATE
          (traj:SuccessionTrajectory {model_ID:$model_ID})
        MERGE (srcLCT)<-[:SOURCE]-(traj)-[:TARGET]->(tgtLCT);

        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"xeric",
                                deciduous:false,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"xeric",
                                deciduous:true,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"xeric",
                                deciduous:false,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"xeric",
                                deciduous:true,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"xeric",
                                deciduous:false,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"xeric",
                                deciduous:true,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"xeric",
                                deciduous:false,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"xeric",
                                deciduous:true,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"xeric",
                                deciduous:false,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"xeric",
                                deciduous:true,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"xeric",
                                deciduous:false,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"xeric",
                                deciduous:true,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"xeric",
                                deciduous:false,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"xeric",
                                deciduous:true,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"xeric",
                                deciduous:false,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"xeric",
                                deciduous:true,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"mesic",
                                deciduous:false,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"mesic",
                                deciduous:true,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"mesic",
                                deciduous:false,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"mesic",
                                deciduous:true,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"mesic",
                                deciduous:false,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"mesic",
                                deciduous:true,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"mesic",
                                deciduous:false,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"mesic",
                                deciduous:true,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"mesic",
                                deciduous:false,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"mesic",
                                deciduous:true,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"mesic",
                                deciduous:false,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"mesic",
                                deciduous:true,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"mesic",
                                deciduous:false,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"mesic",
                                deciduous:true,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"mesic",
                                deciduous:false,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"mesic",
                                deciduous:true,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"hydric",
                                deciduous:false,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"hydric",
                                deciduous:true,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"hydric",
                                deciduous:false,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"hydric",
                                deciduous:true,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"hydric",
                                deciduous:false,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"hydric",
                                deciduous:true,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"hydric",
                                deciduous:false,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"hydric",
                                deciduous:true,
                                aspect:"north",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"hydric",
                                deciduous:false,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"hydric",
                                deciduous:true,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"hydric",
                                deciduous:false,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"hydric",
                                deciduous:true,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"hydric",
                                deciduous:false,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"hydric",
                                deciduous:true,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"hydric",
                                deciduous:false,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"hydric",
                                deciduous:true,
                                aspect:"south",
                                succession:"regeneration",
                                delta_t:3})
        WITH ec
        MATCH
          (:LandCoverType {code:"Wheat", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
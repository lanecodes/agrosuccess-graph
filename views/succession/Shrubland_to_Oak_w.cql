
//==============================================================================
        // file: succession/Shrubland_to_Oak_w.cql
        // modified: 2018-08-10
        // dependencies:
        //     abstract/LandCoverType_w.cql
        // external parameters:
        //     model_ID, used to identify model created nodes belong to 
        // description:
        //     Create the Successiontrajectory representing the possibility of 
        //     transition between the Shrubland and Oak LandCoverState-s. Also specify all 
        //     combinations of environmental conditions which can lead to this 
        //     transition.
        //==============================================================================

        {
         "priority":1
        }
        
        MATCH
          (srcLCT:LandCoverType {code:"Shrubland", model_ID:$model_ID}),
          (tgtLCT:LandCoverType {code:"Oak", model_ID:$model_ID})
        CREATE
          (traj:SuccessionTrajectory {model_ID:$model_ID})
        MERGE (srcLCT)<-[:SOURCE]-(traj)-[:TARGET]->(tgtLCT);

        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"mesic",
                                deciduous:true,
                                aspect:"north",
                                succession:"secondary",
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"mesic",
                                deciduous:true,
                                aspect:"north",
                                succession:"secondary",
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"mesic",
                                deciduous:true,
                                aspect:"south",
                                succession:"secondary",
                                delta_t:20})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"mesic",
                                deciduous:true,
                                aspect:"south",
                                succession:"secondary",
                                delta_t:20})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"hydric",
                                deciduous:true,
                                aspect:"north",
                                succession:"secondary",
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"hydric",
                                deciduous:true,
                                aspect:"north",
                                succession:"secondary",
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"hydric",
                                deciduous:true,
                                aspect:"north",
                                succession:"secondary",
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"hydric",
                                deciduous:true,
                                aspect:"north",
                                succession:"secondary",
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:false,
                                water:"hydric",
                                deciduous:true,
                                aspect:"south",
                                succession:"secondary",
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:false,
                                water:"hydric",
                                deciduous:true,
                                aspect:"south",
                                succession:"secondary",
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:false,
                                pine:true,
                                water:"hydric",
                                deciduous:true,
                                aspect:"south",
                                succession:"secondary",
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
        MERGE
          (ec:EnvironCondition {model_ID:$model_ID,
                                oak:true,
                                pine:true,
                                water:"hydric",
                                deciduous:true,
                                aspect:"south",
                                succession:"secondary",
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
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
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
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
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
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
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
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
                                delta_t:15})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
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
                                delta_t:20})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
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
                                delta_t:20})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
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
                                delta_t:20})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
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
                                delta_t:20})
        WITH ec
        MATCH
          (:LandCoverType {code:"Shrubland", model_ID:$model_ID})
          <-[:SOURCE]-(traj:SuccessionTrajectory {model_ID:$model_ID})-[:TARGET]->
          (:LandCoverType {code:"Oak", model_ID:$model_ID})
        MERGE
          (ec)-[:CAUSES]->(traj);
        
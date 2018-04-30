//==============================================================================
// file: landcover_change/AgroPastoralist/activities_w.cql
// modified: 2018-04-30
// dependencies:
//     abstract/Agent_w.cql
//     abstract/LandCoverType_w.cql  
// external parameters:
//     model_ID, used to identify model created nodes belong to 
// description:
//     Create nodes representing land cover changes made by agents with the
//     Agropastoralist type.
//==============================================================================

{
  "priority": 1
}

// 1. Planting wheat on burnt ground
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Burnt", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Wheat", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Plant wheat on previously burnt ground",
	effort:1})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);
    
// 2. Planting barley on burnt ground
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Burnt", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Barley", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Plant barley on previously burnt ground",
	effort:1})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);

// 3. Restore depleated agricultural land for wheat planting 
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"DAL", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Wheat", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Restore depleated agricultural land and plant wheat",
	effort:5})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);

// 4. Restore depleated agricultural land for barley planting 
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"DAL", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Barley", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Restore depleated agricultural land and plant barley",
	effort:5})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);


// 5. Clear shrubland for wheat planting 
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Shrubland", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Wheat", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Clear shrubland for wheat planting",
	effort:2})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);

// 6. Clear shrubland for barley planting 
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Shrubland", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Barley", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Clear shrubland for barley planting",
	effort:2})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);

// 7. Clear pine forest for wheat planting 
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Pine", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Wheat", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Clear pine forest by burning and plant wheat",
	effort:3})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);

// 8. Clear pine forest for barley planting 
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Pine", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Barley", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Clear pine forest by burning and plant barley",
	effort:3})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);

// 9. Clear deciduous forest and plant wheat
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Deciduous", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Wheat", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Clear deciduous forest by burning and plant wheat",
	effort:3})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);

// 10. Clear deciduous forest and plant barley
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Deciduous", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Barley", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Clear deciduous forest by burning and plant barley",
	effort:3})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);
      
// 11. Clear transition forest by burning and plant wheat
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"TransForest", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Wheat", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Clear transition forest by burning and plant wheat",
	effort:3})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);

// 12. Clear transition forest by burning and plant barley
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"TransForest", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Barley", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Clear transition forest by burning and plant barley",
	effort:3})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);

// 13. Clear oak forest by burning and plant wheat
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Oak", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Wheat", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Clear oak forest by burning and plant wheat",
	effort:4})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);

// 14. Clear oak forest by burning and plant barley
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Oak", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Barley", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Clear oak forest by burning and plant barley",
	effort:4})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);
      
// 15. Convert barley to wheat
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Barley", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Wheat", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Convert barley to wheat",
	effort:1})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);

// 16. Convert wheat to barley
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Wheat", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Barley", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Convert wheat to barley",
	effort:1})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);

// 17. Re-plant wheat
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Wheat", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Wheat", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Re-plant wheat",
	effort:1})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);
      
// 17. Re-plant barley
MATCH
     (a:AgentType {code:"Agropastoralist", model_ID:$model_ID}),
     (srcLCT:LandCoverType {code:"Barley", model_ID:$model_ID}),
     (tgtLCT:LandCoverType {code:"Barley", model_ID:$model_ID})
CREATE
      (eea:EcoEngineeringActivity
       {model_ID:$model_ID,
	description:"Re-plant barley",
	effort:1})
MERGE (a)-[:PRACTICES]->(eea)
MERGE (srcLCT)<-[:SOURCE]-(eea)-[:TARGET]->(tgtLCT);

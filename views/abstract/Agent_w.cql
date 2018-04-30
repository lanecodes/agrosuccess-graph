//==============================================================================
// file: abstract/Agent_w.cql
// modified: 2018-04-30
// dependencies:
//     none
// external parameters:
//     model_ID, used to identify model created nodes belong to 
// description:
//     Create nodes representing the agents in the model.
//==============================================================================

{
  "priority": 0
}

// 1. AgroPastoralist
CREATE (:AgentType {description:"Agropastoralist", code:"Agropastoralist",
		    model_ID:$model_ID});

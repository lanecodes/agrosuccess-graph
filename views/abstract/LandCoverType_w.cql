//==============================================================================
// file: abstract/LandCoverType_w.cql
// author: Andrew Lane
// modified: 2018-04-27
// dependencies:
//     none
// external parameters:
//     model_ID, used to identify model created nodes belong to 
// description:
//     Create nodes representing land cover states in the AgroSuccess model.       
//==============================================================================

{
  "priority": 0
}

// 1. Water/ Quarry
CREATE (:LandCoverType {description:"Water/ Quarry", code:"WaterQuarry",
			num:0,
			model_ID:$model_ID,
			fertility:-1,
			digestible_matter:-1,
 			wood_value:-1,
			land_cover_conversion_cost:-1});

// 2. Burnt
CREATE (:LandCoverType {description:"Burnt", code:"Burnt",
			num:1,
			model_ID:$model_ID,
			fertility:5,
			digestible_matter:1,
 			wood_value:1,
			land_cover_conversion_cost:1});

// 3. Barley
CREATE (:LandCoverType {description:"Barley", code:"Barley",
			num:2,
			model_ID:$model_ID,
			fertility:4,
			digestible_matter:2,
 			wood_value:-1,
			land_cover_conversion_cost:1});

// 4. Wheat
CREATE (:LandCoverType {description:"Wheat", code:"Wheat",
			num:3,
			model_ID:$model_ID,
			fertility:4,
			digestible_matter:2,
 			wood_value:-1,
			land_cover_conversion_cost:1});

// 5. Depleated agricultural land 
CREATE (:LandCoverType {description:"Depleated Agricultural Land", code:"DAL",
			num:4,
			model_ID:$model_ID,
			fertility:1,
			digestible_matter:2,
 			wood_value:-1,
			land_cover_conversion_cost:5});

// 6. Shrubland
CREATE (:LandCoverType {description:"Shrubland", code:"Shrubland",
			num:5,
			model_ID:$model_ID,
			fertility:2,
			digestible_matter:5,
 			wood_value:-1,
			land_cover_conversion_cost:2});

// 7. Pine
CREATE (:LandCoverType {description:"Pine", code:"Pine",
			num:6,
			model_ID:$model_ID,
			fertility:2,
			digestible_matter:2,
 			wood_value:5,
			land_cover_conversion_cost:3});

// 8. Transition forest
CREATE (:LandCoverType {description:"Transition Forest", code:"TransForest",
			num:7,
			model_ID:$model_ID,
			fertility:3,
			digestible_matter:4,
 			wood_value:4,
			land_cover_conversion_cost:3});

// 9. Deciduous
CREATE (:LandCoverType {description:"Deciduous", code:"Deciduous",
			num:8,
			model_ID:$model_ID,
			fertility:3,
			digestible_matter:5,
 			wood_value:4,
			land_cover_conversion_cost:3});

// 10. Oak
CREATE (:LandCoverType {description:"Oak", code:"Oak",
			num:9,
			model_ID:$model_ID,
			fertility:3,
			digestible_matter:4,
 			wood_value:3,
			land_cover_conversion_cost:4});

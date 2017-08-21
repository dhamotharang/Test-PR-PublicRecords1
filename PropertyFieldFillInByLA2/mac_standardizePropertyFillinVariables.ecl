// mac_standardizePropertyFillinVariables.ecl
import PropertyFieldFillInByLA2;
/*
This macro inputs a property dataset with an unknown record layout except for the following: 1) it has fields for
each of the variables, where the variables are: AssessedAmount, Baths, Bedrooms, BuildingAge, BuildingArea,
Rooms, and Stories; and 2) it has geolink, cleanaid, and seqno. This function extracts the fields that are used for the
LA fill-in process, and it standardizes and normalizes them. These processes are done by the transform, 
initializePropertyFillInVariables.

Finally, the code sets nPropertiesInGroup to the number of properties in the geolink.
By the way, because this routine clears field values that are out-of-range, LA will attempt to fill-in
these variables.

USAGE EXAMPLE:
mac_standardizePropertyFillinVariables(BaseWithAverageHedonics, PropertyVariablesDS);
*/
EXPORT mac_standardizePropertyFillinVariables( pOriginalPropertyDS, OutPropertyVariablesDS ) := MACRO
// Calculates distance in miles
EXPORT real calcEuclideanDistance( 
                                    string10 a_geo_lat
                                  , string11 a_geo_long
                                  , string10 b_geo_lat
                                  , string11 b_geo_long
                                 ) := FUNCTION

real Degrees2Radians( real degrees ) := FUNCTION
  real Deg2Rad := 0.0174532925199; //number of radians in a degree
return degrees * Deg2Rad;
END;
  real edistance := 
   sqrt( 
         power(69.1, 2) * power(((real)b_geo_lat - (real)a_geo_lat), 2) 
         + power((69.1*cos(Degrees2Radians((real)b_geo_lat))), 2) * power(((real)b_geo_long - (real)a_geo_long), 2)
       );
return edistance;
END;


// USAGE: BitVector := makeBitVector(AssessedAmountBit,BathsBit,BedroomsBit,BuildingAgeBit,BuildingAreaBit,RoomsBit,StoriesBit);
makeBitVector(AssessedAmountBit,BathsBit,BedroomsBit,BuildingAgeBit,BuildingAreaBit,RoomsBit,StoriesBit) := FUNCTION

unsigned1 BitVector :=
             AssessedAmountBit
             +(BathsBit << 1)
             +(BedroomsBit << 2)
             +(BuildingAgeBit << 3)
             +(BuildingAreaBit << 4)
             +(RoomsBit << 5)
             +(StoriesBit << 6)
						 ;

return BitVector;
END;


layout_PropertyFillInVariables initializePropertyFillInVariables( recordof(pOriginalPropertyDS) x ) := TRANSFORM
self.AssessedAmount 		:= x.AssessedAmount;
self.Baths 							:= x.Baths;
self.Bedrooms 					:= x.Bedrooms;
self.BuildingAge 				:= x.BuildingAge;
self.BuildingArea 			:= x.BuildingArea;
self.Rooms 							:= x.Rooms;
self.Stories 						:= x.Stories;

// New Variables
self.Fireplaces					:= x.Fireplaces;
self.Garage							:= x.Garage;
self.Construction				:= x.Construction_Type;
self.Exterior						:= x.Exterior_Walls;
self.Foundation					:= x.Foundation;
self.Air_Conditioning_Type		:= x.Air_Conditioning_Type;
self.Heating						:= x.Heating;
self.Roof_Cover					:= x.Roof_Cover;
self.Floor_Cover				:= x.Floor_Cover;
self.Garage_sqft				:= x.Garage_sqft;
self.Basement_sqft			:= x.Basement_sqft;
self.Basement						:= x.Basement;
self.Fuel_Type					:= x.Fuel_Type;


normBaths := 
   IF (
       (x.Baths > 0) 
        and (x.Baths < 8)
        , x.Baths,  0
   );
    
self.BathsRes :=
    if(
       (normBaths > 1) and (normBaths < 6)
       , (normBaths-2.0798322)/1.1568194
       , IF(
            normBaths = 1
            , (0 -2.0798322)/1.1568194
            , IF(
                 normBaths < 8
                 , (5 + (normBaths-5)/2 - 2.0798322)/1.1568194
                 , IF(
                      normBaths >= 8
                      , (8-2.0798322)/1.1568194
                      , 999
                   )
              )
         )
    );
normBedrooms := 
   IF (
       (x.Bedrooms > 0) 
        and (x.Bedrooms < 8)
        , x.Bedrooms,  0
   );
self.BedroomsRes :=
    IF (
        (normBedrooms > 1) and (normBedrooms < 6)
        , (normBedrooms-3.3420002)/0.8757833
        , IF(
             normBedrooms = 1
             , (0 -3.3420002)/0.8757833
             , IF(
                  normBedrooms < 9
                  , (5 + (normBedrooms-5)/2 -3.3420002)/0.8757833
                  , IF(
                       normBedrooms >= 9
                       , (10 -3.3420002)/ 0.8714978
                       , 999
                    )
               )
          )
    );
normBuildingArea := 
   IF (
       (x.BuildingArea > 250) 
       and (x.BuildingArea < 8733)
       , x.BuildingArea,  0
   );
normRooms := 
   IF (
       (x.Rooms > 0) 
       and (x.Rooms < 15)
       , x.Rooms,  0
   );
	 
normBuildingAge := 
   IF (
       (x.BuildingAge > 0) 
       , x.BuildingAge,  0
   );

BAgeRes :=
   IF (
        normBuildingAge <= 50,  normBuildingAge,
         min((normBuildingAge-50)/2 + 50, 80)
      );
			
			
normStories := 
   IF (
       (x.Stories > 0) 
       and (x.Stories <= 3)
       , x.Stories,  0
   );


normAssessedAmount := 
		IF (
       (x.AssessedAmount >= 35000) 
       and (x.AssessedAmount <= 3000000)
       , x.AssessedAmount,  0	 
   );


normFireplaces 				:= if(x.Fireplaces > 0, x.Fireplaces,0);
normGarage 						:= if(x.Garage > 0, x.Garage,0);
normConstruction			:= if(x.Construction_Type > 0, x.Construction_Type,0);
normExterior					:= if(x.Exterior_Walls > 0, x.Exterior_Walls,0);
normFoundation				:= if(x.Foundation > 0, x.Foundation,0);
normHeating						:= if(x.Heating > 0, x.Heating,0);
normAir_Conditioning	:= if(x.Air_Conditioning_Type > 0, x.Air_Conditioning_Type,0);
normRoof_Cover				:= if(x.Roof_Cover > 0, x.Roof_Cover,0);
normFloor_Cover				:= if(x.Floor_Cover > 0, x.Floor_Cover,0);
normFuel_Type					:= if(x.Fuel_Type > 0, x.Fuel_Type,0);
normBasement					:= if(x.Basement > 0, x.Basement,0);
normGarageSqft 				:= if(x.Garage_sqft > 0, x.Garage_sqft,0);
normBasementSqft 			:= if(x.Basement_sqft > 0, x.Basement_sqft,0);

	 
AssessedAmountBit 		:= IF ( normAssessedAmount > 0, 1, 0);
BathsBit 							:= IF ( normBaths > 0, 1, 0);
BedroomsBit 					:= IF ( normBedrooms > 0, 1, 0);
BuildingAgeBit 				:= IF ( normBuildingAge > 0, 1, 0);
BuildingAreaBit 			:= IF ( normBuildingArea >0 , 1, 0);
RoomsBit 							:= IF ( normRooms >0 , 1, 0);
StoriesBit 						:= IF ( normStories > 0, 1, 0);

// Adding New Variable
FireplacesBit					:= IF ( normFireplaces > 0, 1, 0);
GarageBit							:= IF ( normGarage > 0, 1, 0);
ConstructionBit				:= IF ( normConstruction > 0, 1, 0);
ExteriorBit						:= IF ( normExterior > 0, 1, 0);
FoundationBit					:= IF ( normFoundation > 0, 1, 0);
Air_ConditioningBit		:= IF ( normAir_Conditioning > 0, 1, 0);
HeatingBit						:= IF ( normHeating > 0, 1, 0);
Roof_CoverBit					:= IF ( normRoof_Cover > 0, 1, 0);
Floor_CoverBit				:= IF ( normFloor_Cover > 0, 1, 0);

//Additional Variables
Fuel_TypeBit					:= IF ( normFuel_Type > 0, 1, 0);
BasementBit						:= IF ( normBasement > 0, 1, 0);
Garage_sqftBit				:= IF	( normGarageSqft > 0,1,0);
Basement_sqftBit			:= IF	(	normBasementSqft >0,1,0);

BitVector := makeBitVector(AssessedAmountBit,BathsBit,BedroomsBit,BuildingAgeBit,BuildingAreaBit,RoomsBit,StoriesBit);

self.BitVector 					:= BitVector;
self.AssessedAmountBit 	:= AssessedAmountBit;
self.BathsBit 					:= BathsBit;
self.BedroomsBit 				:= BedroomsBit;
self.BuildingAgeBit 		:= BuildingAgeBit;
self.BuildingAreaBit 		:= BuildingAreaBit;
self.RoomsBit 					:= RoomsBit;
self.StoriesBit 				:= StoriesBit;

//Adding New Variables 
self.FireplacesBit			:= FireplacesBit;
self.GarageBit					:= GarageBit;
self.ConstructionBit		:= ConstructionBit;
self.ExteriorBit				:= ExteriorBit;
self.FoundationBit			:= FoundationBit;
self.Air_ConditioningBit	:= Air_ConditioningBit;
self.HeatingBit					:= HeatingBit;
self.Roof_CoverBit			:= Roof_CoverBit;
self.Floor_CoverBit			:= Floor_CoverBit;
self.Garage_sqftBit			:= Garage_sqftBit;	
self.Basement_sqftBit		:= Basement_sqftBit;	
self.BasementBit				:= BasementBit;
self.Fuel_TypeBit				:= Fuel_TypeBit;

self.Bites := BuildingAgeBit + BuildingAreaBit + BedroomsBit + BathsBit 
							+ StoriesBit + RoomsBit + AssessedAmountBit; 
							
self.normAssessedAmount := normAssessedAmount;
self.normBaths 					:= normBaths;
self.normBedrooms 			:= normBedrooms;
self.normBuildingAge 		:= normBuildingAge;
self.normBuildingArea 	:= normBuildingArea;
self.normRooms 					:= normRooms;
self.normStories 				:= normStories;
self.normFireplaces			:= normFireplaces;
self.normGarage					:= normGarage;
self.normConstruction		:= normConstruction;
self.normExterior				:= normExterior;	
self.normFoundation			:= normFoundation;
self.normHeating				:= normHeating;
self.normAir_Conditioning	:= normAir_Conditioning;
self.normRoof_Cover			:= normRoof_Cover;
self.normFloor_Cover		:= normFloor_Cover;
self.normFuel_Type			:= normFuel_Type;
self.normBasement				:= normBasement;
self.normGarageSqft			:= normGarageSqft;
self.normBasementSqft		:= normBasementSqft;


self.lAssessedValueRen := (ln(normAssessedAmount) -  12.3671024)/0.6516154;
self.BAgeResRen := (BAgeRes-37.8235640)/22.8434289;
self.lbareaRen := (ln(normBuildingArea) - 7.5491902) / 0.4145020;
self.RoomsRen := (normRooms - 7.1370077) /1.7673422;
self.StoriesRen := (normStories - 1.6345381) / 0.5282658;
    
self.county_code := x.county;
self.state_code := x.st;
self := x;
END;

layout_PropertyFillInVariables setPropertyCountsInGroup( layout_PropertyFillInVariables l, layout_PropertyFillInVariables r ) := TRANSFORM
   self.nPropertiesInGroup :=
     IF( (l.geolink = r.geolink)
         , l.nPropertiesInGroup
         , r.seqno
     );
   self := r;
END;

/*
  Initialize/setup/standardize all the fields needed in the Local Averaging algorithm.
  Plus, count the number of properties in each geoblock and place that count is the field,
  nPropertiesInGroup, of every record (property).
*/
OutPropertyVariablesDS :=
   sort(
        iterate(
                sort(
                     distribute(
                                project(
                                        pOriginalPropertyDS
                                        , initializePropertyFillInVariables(left)
                                )
                                , hash64(geolink)
                     )
                     , geolink, -seqno
                     , local
                )
                ,setPropertyCountsInGroup(left,right)
                ,local
        )
        ,geolink, seqno
        ,local
   );
//set_debug := 0 : stored('debug');
//integer set_debug := stored('my_debug');
#IF ( set_debug >= 1 )
#uniquename(PropVariablesFilename)
%PropVariablesFilename% := '~thor_data400::temp::propertyfieldfillinbyla2::'+pversion+'::NormalizedPropertyVariablesDS';
output(OutPropertyVariablesDS,,%PropVariablesFilename%,OVERWRITE);
#END
ENDMACRO;

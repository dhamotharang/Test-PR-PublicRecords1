// calcAdaptiveAndEuclideanDistanceForUseInLA.ecl
import PropertyFieldFillInByLA2;
/*
This function inputs a property file with the layout of PropertyFieldFillInByLA2.layout_PropertyFillInVariables.

This function creates a dataset with the following record layout: PropertyFieldFillInByLA2.layout_PropertyPairs.

This function calculates values needed for computing the the local average in mac_FillinSpecificEmptyVariables.
These values include the Adaptive Distance and Euclidean distance.

Also, this function filters pairs of properties by removing pairs that aren't close enough to one another.

Lastly, this function asures that two properties have some Hedonic data before it calculates the adaptive
distance.

USAGE EXAMPLE
PropertyPairsDS := calcAdaptiveAndEuclideanDistanceForUseInLA(PropertyVariablesDS);
*/
EXPORT calcAdaptiveAndEuclideanDistanceForUseInLA(
                                                  string pversion
                                                  , dataset(PropertyFieldFillInByLA2.layout_PropertyFillInVariables) pPropertyFillInVariables
                                                 ) := FUNCTION
																								 
layout_Pairs := PropertyFieldFillInByLA2.layout_PropertyPairs;
layout_Variables := PropertyFieldFillInByLA2.layout_PropertyFillInVariables;

// output(pPropertyFillInVariables,,'~thor_data400::temp::PropertyFieldFillinByLA2::pPropertyFillInVariables',OVERWRITE);	 


boolean SomeHedonicData( layout_Variables a, layout_Variables b ) := FUNCTION
  boolean rc :=
     ((a.Bites >= 2) or (a.AssessedAmountBit = 1))
     and ((b.Bites >= 2) or (b.AssessedAmountBit = 1));
  return rc;
END;

boolean isCloseEnough( integer nPropertiesInGroup, real edistance ) := FUNCTION
  boolean b :=
    IF( ( nPropertiesInGroup >= 10000 ) and ( edistance > 0.5 )
       , false       
       , IF( ( nPropertiesInGroup >= 5000 ) and ( edistance > 1 )
            , false       
            , IF( ( nPropertiesInGroup >= 1000 ) and ( edistance > 2 )
                 , false
                 // , IF( ( nPropertiesInGroup >= 400 ) and ( edistance > 5 )
								 // , false
								 , IF( ( nPropertiesInGroup < 1000 ) and ( edistance < 2 )
										, false       
								    , true
                   )
              )
         )
    );
return b;
END;


layout_Pairs calcAdaptiveDistanceForUseInLA( layout_Variables a, layout_Variables b ) := TRANSFORM
     // , SKIP( not isCloseEnough( 
                               // a.nPropertiesInGroup
                               // , PropertyFieldFillInByLA2.calcEuclideanDistance(//miles
                                                                                // a.geo_lat
                                                                                // , a.geo_long
                                                                                // , b.geo_lat
                                                                                // , b.geo_long
                                 // ) 
                  // ) 
       // )
EuclidDistance := PropertyFieldFillInByLA2.calcEuclideanDistance( a.geo_lat, a.geo_long, b.geo_lat, b.geo_long);//miles
  
DistToRes := min(EuclidDistance, 0.5) + (0.5/9) * min(max(EuclidDistance - 0.5, 0),9.5);
BuildingAreaBitSynergy := max(a.BuildingAreaBit * b.BuildingAreaBit, 0);  /* logic var to tell what analysis variables are present */
BedroomsBitSynergy := max(a.BedroomsBit * b.BedroomsBit, 0);              /* max used to eliminate nulls from VAR&index */
StoriesBitSynergy := max(a.StoriesBit * b.StoriesBit, 0);
BuildingAgeBitSynergy := max(a.BuildingAgeBit * b.BuildingAgeBit, 0);
BathsBitSynergy := max(a.BathsBit * b.BathsBit, 0);
RoomsBitSynergy := max(a.RoomsBit * b.RoomsBit, 0);
AssessedAmountBitSynergy := max(a.AssessedAmountBit * b.AssessedAmountBit, 0);

self.hasHedonic := SomeHedonicData( a, b );
self.a_seqno := a.seqno;
self.EnoughBitSynergy := 
      (AssessedAmountBitSynergy*2 
       + BuildingAgeBitSynergy 
       + BuildingAreaBitSynergy
       + RoomsBitSynergy 
       + BedroomsBitSynergy 
       + StoriesBitSynergy 
       + BathsBitSynergy
			 ) >= 2;
			 
BiteSynergy := 
   RoomsBitSynergy  
   + BathsBitSynergy 
   + StoriesBitSynergy 
   + BedroomsBitSynergy 
   + BuildingAreaBitSynergy
   + BuildingAgeBitSynergy 
   + AssessedAmountBitSynergy;
	 
DistToBAge := IF(BuildingAgeBitSynergy>0,abs(a.BAgeResRen -b.BAgeResRen), 0);
DistToBedrooms := IF(BedroomsBitSynergy>0,abs(a.BedroomsRes - b.BedroomsRes),0);
DistToRooms := IF(RoomsBitSynergy>0,abs(a.RoomsRen - b.RoomsRen),0);
DistToBaths := IF(BathsBitSynergy>0,abs(a.BathsRes - b.BathsRes),0);
DistTolbareaRen := IF(BuildingAreaBitSynergy>0,abs(a.lbareaRen -b.lbareaRen),0);
DistToStoriesRen := IF(StoriesBitSynergy>0,abs(a.StoriesRen - b.StoriesRen),0);
DistTolAssessedValueRen := IF(AssessedAmountBitSynergy>0,abs(a.lAssessedValueRen - b.lAssessedValueRen),0);

InnardsSynergy := 
   RoomsBitSynergy  
   + BathsBitSynergy 
   + StoriesBitSynergy 
   + BedroomsBitSynergy;
FF2 := 
  7/(
     max(
         2*BuildingAgeBitSynergy 
         + 2*BuildingAreaBitSynergy
         + 2*AssessedAmountBitSynergy 
         + min(InnardsSynergy,1)
         ,1
        )
    );
self.adistance :=  
if((BiteSynergy > 1) or (AssessedAmountBitSynergy = 1),
		sqrt(
         (
          4 * power(DistToBAge, 2)
          + power(2, 2) * power(DistTolbareaRen, 2)
          + power(5, 2) * power(DistTolAssessedValueRen, 2)
          + power(
                  max(InnardsSynergy,1)
                  , (-0.5)
                 ) * (
                      power(DistToBedrooms, 2)
                      + power(DistToRooms, 2)
                      + power(DistToStoriesRen, 2)
                      + power(DistToBaths, 2)
                     )
          ) * power(FF2, 2) 
          + power(DistToRes, 2)
       ),
					999);

self.edistance 					 := EuclidDistance; 
self.a_cleanaid          := a.cleanaid;
self.a_ogeolink          := a.ogeolink;
self.a_Baths             := a.Baths;
self.a_BathsBit          := a.BathsBit;
self.a_Bedrooms          := a.Bedrooms;
self.a_BedroomsBit       := a.BedroomsBit;
self.a_BuildingArea      := a.BuildingArea;
self.a_BuildingAreaBit   := a.BuildingAreaBit;
self.a_Rooms             := a.Rooms;
self.a_RoomsBit          := a.RoomsBit;
self.a_BuildingAge       := a.BuildingAge;
self.a_BuildingAgeBit    := a.BuildingAgeBit;
self.a_Stories           := a.Stories;
self.a_StoriesBit        := a.StoriesBit;
self.a_AssessedAmount    := a.AssessedAmount;
self.a_AssessedAmountBit := a.AssessedAmountBit;
self.a_Bites             := a.Bites;
self.a_Fireplaces				 := a.Fireplaces;
self.a_FireplacesBit		 := a.FireplacesBit;
self.a_Garage					 	 := a.Garage;
self.a_GarageBit				 := a.GarageBit;
self.a_Construction	 		 := a.Construction;
self.a_ConstructionBit	 := a.ConstructionBit;
self.a_Heating					 := a.Heating;
self.a_HeatingBit				 := a.HeatingBit;
self.a_Exterior			 		 := a.Exterior;
self.a_ExteriorBit			 := a.ExteriorBit;
self.a_Foundation		 		 := a.Foundation;
self.a_FoundationBit		 := a.FoundationBit;
self.a_Air_Conditioning_Type	 	:= a.Air_Conditioning_Type;
self.a_Air_ConditioningBit			:= a.Air_ConditioningBit;
self.a_Roof_Cover				 	:= a.Roof_Cover;
self.a_Roof_CoverBit			:= a.Roof_CoverBit;
self.a_Floor_Cover		 	 	:= a.Floor_Cover;
self.a_Floor_CoverBit		 	:= a.Floor_CoverBit;
self.a_Garage_sqft			 	:= a.Garage_sqft;
self.a_Garage_sqftBit		 	:= a.Garage_sqftBit;
self.a_Basement_sqft		 	:= a.Basement_sqft;
self.a_Basement_sqftBit	 	:= a.Basement_sqftBit;
self.a_Fuel_Type				 	:= a.Fuel_Type;
self.a_Fuel_TypeBit				:= a.Fuel_TypeBit;
self.a_Basement						:= a.Basement;
self.a_BasementBit				:= a.BasementBit;

self.b_seqno             := b.seqno;
self.b_cleanaid          := b.cleanaid;
self.b_ogeolink          := b.ogeolink;
self.b_Baths             := b.Baths;
self.b_BathsBit          := b.BathsBit;
self.b_Bedrooms          := b.Bedrooms;
self.b_BedroomsBit       := b.BedroomsBit;
self.b_BuildingArea      := b.BuildingArea;
self.b_BuildingAreaBit   := b.BuildingAreaBit;
self.b_Rooms             := b.Rooms;
self.b_RoomsBit          := b.RoomsBit;
self.b_BuildingAge       := b.BuildingAge;
self.b_BuildingAgeBit    := b.BuildingAgeBit;
self.b_Stories           := b.Stories;
self.b_StoriesBit        := b.StoriesBit;
self.b_AssessedAmount    := b.AssessedAmount;
self.b_AssessedAmountBit := b.AssessedAmountBit;
self.b_Bites             := b.Bites;
self.b_Fireplaces				 := b.Fireplaces;
self.b_FireplacesBit		 := b.FireplacesBit;
self.b_Garage					 	 := b.Garage;
self.b_GarageBit				 := b.GarageBit;
self.b_Garage_sqft			 := b.Garage_sqft;
self.b_Garage_sqftBit		 := b.Garage_sqftBit;
self.b_Construction	 		 := b.Construction;
self.b_ConstructionBit	 := b.ConstructionBit;
self.b_Heating					 := b.Heating;
self.b_HeatingBit				 := b.HeatingBit;
self.b_Exterior			 		 := b.Exterior;
self.b_ExteriorBit			 := b.ExteriorBit;
self.b_Foundation		 		 := b.Foundation;
self.b_FoundationBit		 := b.FoundationBit;
self.b_Air_Conditioning_Type	 	:= b.Air_Conditioning_Type;
self.b_Air_ConditioningBit			:= b.Air_ConditioningBit;
self.b_Roof_Cover				 	:= b.Roof_Cover;
self.b_Roof_CoverBit			:= b.Roof_CoverBit;
self.b_Floor_Cover		 	 	:= b.Floor_Cover;
self.b_Floor_CoverBit		 	:= b.Floor_CoverBit;
self.b_Basement_sqft		 	:= b.Basement_sqft;
self.b_Basement_sqftBit	 	:= b.Basement_sqftBit;
self.b_Fuel_Type				 	:= b.Fuel_Type;
self.b_Fuel_TypeBit			 	:= b.Fuel_TypeBit;
self.b_Basement						:= b.Basement;
self.b_BasementBit				:= b.BasementBit;

self := a;
END;

Distr_and_sorted_pPropertyFillInVariables :=
    sort(
         distribute(pPropertyFillInVariables,hash64(geolink))
         , geolink
         , local
    );

unsigned1 com( unsigned1 z ) := FUNCTION
unsigned1 bit8:=128;
return BNOT(z+bit8);
END;

b_hasNeededValues( unsigned1 a_BitVector, unsigned1 b_BitVector ) := FUNCTION
return IF((com(a_BitVector) & b_BitVector) > 0, true, false);

END;

PropertyPairsDS :=
   join(
        Distr_and_sorted_pPropertyFillInVariables
        , Distr_and_sorted_pPropertyFillInVariables
       , (left.geolink=right.geolink)
           // and b_hasNeededValues(left.BitVector, right.BitVector)
					 and (left.cleanaid <> right.cleanaid)
        ,calcAdaptiveDistanceForUseInLA(left,right)
        ,local
   );
	 
// output(PropertyPairsDS,,'~thor_data400::temp::PropertyFieldFillinByLA2::PropertyPairsDS_temp',OVERWRITE);	 
return PropertyPairsDS;
END;

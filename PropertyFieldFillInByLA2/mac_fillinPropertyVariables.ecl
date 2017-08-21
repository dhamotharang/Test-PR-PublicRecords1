// mac_fillinPropertyVariables.ecl
import PropertyFieldFillinByLA2;

/* 

 This goes through the whole Local Averaging Process. Here are the steps.
  
 step 0: Standardizes and normalizes the variables to be filled. Plus, it adds a few fields used by other steps,
         like seqno.
 step 1: Switch to groups of geolinks to make sure we have as many as 500 SFDs in many more groups.
 step 2: Calculates the adaptive & Euclidean distances between each property, P, and every other property of the
         same county that meets minimal criteria. (note. the adaptive distance is used by the 'fill-in'
         step.)
 step 3: There are 7 macros in this step. Each attempts to fill-in all NULL occurrences of one particular 
         variable using the adaptive distance version of local averaging (i.e. LA1). The variables are filled
         in alphabetic order. 
 step 4: Updates NormalizedPropertyVariablesDS with any variables filled-in by LA1.
 step 5: There are 7 macros in this step. Each attempts to fill-in all NULL occurrences of one particular 
         variable using the Euclidean distance version of local averaging (i.e. LA2). The variables are filled
         in alphabetic order. 
 step 6: Updates la1_UpdatedPropertyVariablesDS with any variables filled-in by LA2.
 step 7: Updates original input dataset, i.e. OutPropertyDS

*/
EXPORT mac_fillinPropertyVariables(
                                   pversion
                                   , InPropertyDS
                                   , UniqueIdWithInPropertyDS
                                   , OutPropertyDS
                                   , CleanAidFilterSet='[]'
                                   , adistance_threshold=2.5
                                  ) := MACRO

//integer set_debug := stored('my_debug');

// step 0: Standardizes and normalizes the variables to be filled. Plus, it adds a few fields used by other steps,
//         like seqno.
PropertyFieldFillinByLA2.mac_standardizePropertyFillinVariables(UniqueIdWithInPropertyDS, NormalizedPropertyVariablesDS0 );
  
// step 1: Switch to groups of geolinks to make sure we have as many as 500 SFDs in many more groups.
PropertyFieldFillinByLA2.mac_replacePropertyGeolinkWithGlinkGroupName(
     NormalizedPropertyVariablesDS0
     , NormalizedPropertyVariablesDS
);

// step 2: Calculates the adaptive & Euclidean distances between each property, P, and every other property of the
//         same county that meets minimal criteria. (note. the adaptive distance is used by the 'fill-in'
//         step.)

PropertyPairsDS := 
    PropertyFieldFillinByLA2.calcAdaptiveAndEuclideanDistanceForUseInLA(pversion,NormalizedPropertyVariablesDS);
// output(PropertyPairsDS,,'~thor_data400::temp::PropertyFieldFillinByL2::PropertyPairsDS_calculated',OVERWRITE);	 
    
la1_PropertyPairsDS := 
   IF(CleanAidFilterSet=[]
      , PropertyPairsDS(
                        ( adistance < adistance_threshold )
                        and (hasHedonic=true)
                        and (EnoughBitSynergy=true)
											 )
      , PropertyPairsDS
												(
                        (a_cleanaid IN CleanAidFilterSet)
                        and ( adistance < adistance_threshold )
                        and (hasHedonic=true)
                        and (EnoughBitSynergy=true)
											 )
 );
// output(la1_PropertyPairsDS,,'~thor_data400::temp::PropertyFieldFillinByLA2::'+pversion+'::la1_PropertyPairsDS_temp',OVERWRITE);


// step 3: There are 7 macros in this step. Each attempts to fill-in all NULL occurrences of one particular 
//         variable using the adaptive distance version of local averaging (i.e. LA1). The variables are filled
//         in alphabetic order. 

la1_DistanceType:= 'adaptive';
numeric_VariableType := 'numr';
char_VariableType := 'char';

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , AssessedAmount
     , AssessedAmountBit
     , AssessedAmount_ftype
     , a_AssessedAmount
     , b_AssessedAmount
     , a_AssessedAmountBit
     , b_AssessedAmountBit
     , a_AssessedAmount_ftype
     , b_AssessedAmount_ftype
		 , numeric_VariableType
		 , b_cleanaid
		 , la1_AssessedAmount_outdata
     , 'la1_AssessedAmount_outdata'
);

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Baths
     , BathsBit
     , Baths_ftype
     , a_Baths
     , b_Baths
     , a_BathsBit
     , b_BathsBit
     , a_Baths_ftype
     , b_Baths_ftype
		 , numeric_VariableType
		 , b_cleanaid
	   , la1_Baths_outdata
     , 'la1_Baths_outdata'
);
PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Bedrooms
     , BedroomsBit
     , Bedrooms_ftype
     , a_Bedrooms
     , b_Bedrooms
     , a_BedroomsBit
     , b_BedroomsBit
     , a_Bedrooms_ftype
     , b_Bedrooms_ftype
		 , numeric_VariableType
		 , b_cleanaid
	   , la1_Bedrooms_outdata
     , 'la1_Bedrooms_outdata'
);
PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , BuildingAge
     , BuildingAgeBit
     , BuildingAge_ftype
     , a_BuildingAge
     , b_BuildingAge
     , a_BuildingAgeBit
     , b_BuildingAgeBit
     , a_BuildingAge_ftype
     , b_BuildingAge_ftype
		 , numeric_VariableType
		 , b_cleanaid
		 , la1_BuildingAge_outdata
     , 'la1_BuildingAge_outdata'
);

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , BuildingArea
     , BuildingAreaBit
     , BuildingArea_ftype
     , a_BuildingArea
     , b_BuildingArea
     , a_BuildingAreaBit
     , b_BuildingAreaBit
     , a_BuildingArea_ftype
     , b_BuildingArea_ftype
		 , numeric_VariableType
		 , b_cleanaid
		 , la1_BuildingArea_outdata
     , 'la1_BuildingArea_outdata'
);

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Rooms
     , RoomsBit
     , Rooms_ftype
     , a_Rooms
     , b_Rooms
     , a_RoomsBit
     , b_RoomsBit
     , a_Rooms_ftype
     , b_Rooms_ftype
		 , numeric_VariableType
		 , b_cleanaid
		 , la1_Rooms_outdata
     , 'la1_Rooms_outdata'
);

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Stories
     , StoriesBit
     , Stories_ftype
     , a_Stories
     , b_Stories
     , a_StoriesBit
     , b_StoriesBit
     , a_Stories_ftype
     , b_Stories_ftype
		 , numeric_VariableType
		 , b_cleanaid
		 , la1_Stories_outdata
     , 'la1_Stories_outdata'
);

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Air_Conditioning_Type
     , Air_ConditioningBit
     , Air_Conditioning_ftype
     , a_Air_Conditioning_Type
     , b_Air_Conditioning_Type
     , a_Air_ConditioningBit
     , b_Air_ConditioningBit
     , a_Air_Conditioning_ftype
     , b_Air_Conditioning_ftype
		 , char_VariableType
		 , b_cleanaid
     , la1_Air_Conditioning_outdata
     , 'la1_Air_Conditioning_outdata'
);	

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Basement
     , BasementBit
     , Basement_ftype
     , a_Basement
     , b_Basement
     , a_BasementBit
     , b_BasementBit
     , a_Basement_ftype
     , b_Basement_ftype
		 , char_VariableType
		 , b_cleanaid
     , la1_Basement_outdata
     , 'la1_Basement_outdata'
);

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Basement_sqft
     , Basement_sqftBit
     , Basement_sqft_ftype
     , a_Basement_sqft
     , b_Basement_sqft
     , a_Basement_sqftBit
     , b_Basement_sqftBit
     , a_Basement_sqft_ftype
     , b_Basement_sqft_ftype
		 , char_VariableType
		 , b_cleanaid
     , la1_Basement_sqft_outdata
     , 'la1_Basement_sqft_outdata'
);

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Construction
     , ConstructionBit
     , Construction_ftype
     , a_Construction
     , b_Construction
     , a_ConstructionBit
     , b_ConstructionBit
     , a_Construction_ftype
     , b_Construction_ftype
		 , char_VariableType
		 , b_cleanaid
     , la1_Construction_outdata
     , 'la1_Construction_outdata'
);

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Exterior
     , ExteriorBit
     , Exterior_ftype
     , a_Exterior
     , b_Exterior
     , a_ExteriorBit
     , b_ExteriorBit
     , a_Exterior_ftype
     , b_Exterior_ftype
		 , char_VariableType
		 , b_cleanaid
     , la1_Exterior_outdata
     , 'la1_Exterior_outdata'
);

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Fireplaces
     , FireplacesBit
     , Fireplaces_ftype
		 , a_Fireplaces
     , b_Fireplaces
     , a_FireplacesBit
     , b_FireplacesBit
     , a_Fireplaces_ftype
     , b_Fireplaces_ftype
		 , char_VariableType
		 , b_cleanaid
		 , la1_Fireplaces_outdata
     , 'la1_Fireplaces_outdata'
);

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Floor_Cover
     , Floor_CoverBit
     , Floor_Cover_ftype
     , a_Floor_Cover
     , b_Floor_Cover
     , a_Floor_CoverBit
     , b_Floor_CoverBit
     , a_Floor_Cover_ftype
     , b_Floor_Cover_ftype
		 , char_VariableType
		 , b_cleanaid
     , la1_Floor_Cover_outdata
     , 'la1_Floor_Cover_outdata'
);	

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Foundation
     , FoundationBit
     , Foundation_ftype
     , a_Foundation
     , b_Foundation
     , a_FoundationBit
     , b_FoundationBit
     , a_Foundation_ftype
     , b_Foundation_ftype
		 , char_VariableType
		 , b_cleanaid
     , la1_Foundation_outdata
     , 'la1_Foundation_outdata'
);
	
PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Fuel_Type
     , Fuel_TypeBit
     , Fuel_Type_ftype
     , a_Fuel_Type
     , b_Fuel_Type
     , a_Fuel_TypeBit
     , b_Fuel_TypeBit
     , a_Fuel_Type_ftype
     , b_Fuel_Type_ftype
		 , char_VariableType
		 , b_cleanaid
     , la1_Fuel_Type_outdata
     , 'la1_Fuel_Type_outdata'
);

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Garage
     , GarageBit
     , Garage_ftype
     , a_Garage
     , b_Garage
     , a_GarageBit
     , b_GarageBit
     , a_Garage_ftype
     , b_Garage_ftype
		 , char_VariableType
		 , b_cleanaid
     , la1_Garage_outdata
     , 'la1_Garage_outdata'
);	

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Garage_sqft
     , Garage_sqftBit
     , Garage_sqft_ftype
     , a_Garage_sqft
     , b_Garage_sqft
     , a_Garage_sqftBit
     , b_Garage_sqftBit
     , a_Garage_sqft_ftype
     , b_Garage_sqft_ftype
		 , char_VariableType
		 , b_cleanaid
     , la1_Garage_sqft_outdata
     , 'la1_Garage_sqft_outdata'
);

PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Heating
     , HeatingBit
     , Heating_ftype
     , a_Heating
     , b_Heating
     , a_HeatingBit
     , b_HeatingBit
     , a_Heating_ftype
     , b_Heating_ftype
		 , char_VariableType
		 , b_cleanaid
     , la1_Heating_outdata
     , 'la1_Heating_outdata'
);
	
PropertyFieldFillinByLA2.mac_FillinSpecificEmptyVariable_tim_20131105(
     NormalizedPropertyVariablesDS
     , la1_PropertyPairsDS
     , la1_DistanceType
     , adistance
		 , Roof_Cover
     , Roof_CoverBit
     , Roof_Cover_ftype
     , a_Roof_Cover
     , b_Roof_Cover
     , a_Roof_CoverBit
     , b_Roof_CoverBit
     , a_Roof_Cover_ftype
     , b_Roof_Cover_ftype
		 , char_VariableType
		 , b_cleanaid
     , la1_Roof_Cover_outdata
     , 'la1_Roof_Cover_outdata'
);


// step 4: Updates NormalizedPropertyVariablesDS with any variables filled-in by LA1.
// NormalizedPropertyVariablesDSToUpdate := IF(CleanAidFilterSet=[], NormalizedPropertyVariablesDS, NormalizedPropertyVariablesDS(cleanaid IN CleanAidFilterSet));
NormalizedPropertyVariablesDSToUpdate := NormalizedPropertyVariablesDS;
// output(PropertyPairsDS,,'~thor_data400::temp::PropertyFieldFillinByLA2::NormalizedPropertyVariablesDSToUpdate',OVERWRITE);	 

la1_UpdatedPropertyVariablesDS := 
   PropertyFieldFillinByLA2.updateLAFilledInFields(
                          NormalizedPropertyVariablesDSToUpdate
													,la1_AssessedAmount_outdata
													,la1_Baths_outdata
                          ,la1_Bedrooms_outdata
                          ,la1_BuildingAge_outdata
                          ,la1_BuildingArea_outdata
													,la1_Rooms_outdata
													,la1_Stories_outdata
													,la1_Air_Conditioning_outdata
													,la1_Basement_outdata
													,la1_Basement_sqft_outdata
													,la1_Construction_outdata
													,la1_Exterior_outdata
													,la1_Fireplaces_outdata
													,la1_Floor_Cover_outdata
													,la1_Foundation_outdata
													,la1_Fuel_Type_outdata
													,la1_Garage_outdata
													,la1_Garage_sqft_outdata
													,la1_Heating_outdata
													,la1_Roof_Cover_outdata
                          );
													


// output(la1_PropertyPairsDS,,'~thor_data400::temp::PropertyFieldFillinByLA2::'+pversion+'::la1_PropertyPairsDS',OVERWRITE);
// output(la1_UpdatedPropertyVariablesDS,,'~thor_data400::temp::PropertyFieldFillinByLA2::la1_UpdatedPropertyVariablesDS',OVERWRITE);

integer setReal2Integer( string3 r_ftype, real l_var, real r_var ) := FUNCTION
  real value := IF(r_ftype='', l_var, r_var);
return round(value);
END;

real	round_code(real	r)	:= 	function
		string		strNumber	:=	(string)r;
		unsigned	strIndex	:=	stringlib.stringfind(strNumber,'.',1);
		unsigned2	vIntegral	:=	if(strIndex	!=	0,(unsigned2)strNumber[1..strIndex-1],0);
		unsigned2	vFraction	:=	if(strIndex	!=	0,(unsigned2)strNumber[strIndex+1..3],0);
		real			vRound		:=	if(vFraction%10	<=	5, 0, 1);
		
		return	if(strIndex	!=	0,vIntegral	+	vRound,r);
	end;

// recordof(InPropertyDS) updateOriginalPropertyDS( recordof(srt_UniquePropertyDS) l, recordof(ds_la2UpdatedPropertyVariableDS) r ) := TRANSFORM
dsInProperty := PROJECT(InPropertyDS,PropertyFieldFillInByLA2.layouts.update);

recordof(dsInProperty) updateOriginalPropertyDS( recordof(UniqueIdWithInPropertyDS) l, recordof(la1_UpdatedPropertyVariablesDS) r ) := TRANSFORM
  self.AssessedAmount := setReal2Integer(r.AssessedAmount_ftype,l.AssessedAmount,r.AssessedAmount);
  self.Baths 					:= if(r.Baths_ftype = '',l.Baths,r.Baths);
  self.Bedrooms 			:= setReal2Integer(r.Bedrooms_ftype,l.Bedrooms,r.Bedrooms);
  self.BuildingAge 		:= setReal2Integer(r.BuildingAge_ftype,l.BuildingAge,r.BuildingAge);
  self.BuildingArea 	:= setReal2Integer(r.BuildingArea_ftype,l.BuildingArea,r.BuildingArea);
  self.Rooms 					:= setReal2Integer(r.Rooms_ftype,l.Rooms,r.Rooms);
  self.Stories 				:= if(r.Stories_ftype = '',l.Stories,r.Stories);
	
//Adding New Variables	
	self.Fireplaces								:= if(r.Fireplaces_ftype = '',l.Fireplaces,r.Fireplaces);
	self.Garage										:= if(r.Garage_ftype ='',l.Garage, round_code(r.Garage) );
	self.Construction_Type				:= if(r.Construction_ftype ='',l.Construction_Type, round_code(r.Construction) );
	self.Exterior_Walls						:= if(r.Exterior_ftype ='',l.Exterior_Walls, round_code(r.Exterior) );
	self.Foundation								:= if(r.Foundation_ftype ='',l.Foundation, r.Foundation);
	self.Roof_Cover								:= if(r.Roof_Cover_ftype ='',l.Roof_Cover,  round_code(r.Roof_Cover) );
	self.Heating									:= if(r.Heating_ftype ='',l.Heating, round_code(r.Heating) );
	self.Air_Conditioning_Type		:= if(r.Air_Conditioning_ftype ='',l.Air_Conditioning_Type, round_code(r.Air_Conditioning_Type) );
	self.Floor_Cover							:= if(r.Floor_Cover_ftype ='',l.Floor_Cover, round_code(r.Floor_Cover) );
	
//Additional Variables	
	self.garage_sqft							:= if(r.Garage_sqft_ftype = '',l.garage_sqft,r.garage_sqft);
	self.basement_sqft						:= if(r.Basement_sqft_ftype = '',l.basement_sqft, r.Basement_sqft);
	self.Fuel_Type								:= if(r.Fuel_Type_ftype ='',l.Fuel_Type, round_code(r.Fuel_Type) );
	self.Basement									:= if(r.Basement_ftype ='',l.Basement, round_code(r.Basement) );
	
//LA_TYPE	
	self.AssessedAmount_ftype				:= if(r.AssessedAmount_ftype = '', '', r.AssessedAmount_ftype);	
	self.Baths_ftype 								:= if(r.Baths_ftype = '', '', r.Baths_ftype);	
	self.Bedrooms_ftype 						:= if(r.Bedrooms_ftype = '', '', r.Bedrooms_ftype);
	self.BuildingAge_ftype 					:= if(r.BuildingAge_ftype = '', '', r.BuildingAge_ftype);
	self.BuildingArea_ftype 				:= if(r.BuildingArea_ftype = '', '', r.BuildingArea_ftype);
	self.Rooms_ftype 								:= if(r.Rooms_ftype = '', '', r.Rooms_ftype);
	self.Stories_ftype 							:= if(r.Stories_ftype = '', '', r.Stories_ftype);
	
	self.Air_Conditioning_ftype 		:= if(r.Air_Conditioning_ftype = '', '', r.Air_Conditioning_ftype);	
	self.Basement_ftype 						:= if(r.Basement_ftype ='','', r.Basement_ftype );
	self.Basement_sqft_ftype 				:= if(r.Basement_sqft_ftype = '', '', r.Basement_sqft_ftype);
	self.Construction_ftype 				:= if(r.Construction_ftype = '', '', r.Construction_ftype);
	self.Exterior_ftype 						:= if(r.Exterior_ftype = '', '', r.Exterior_ftype);
	self.Fireplaces_ftype 					:= if(r.Fireplaces_ftype = '', '', r.Fireplaces_ftype);
	self.Floor_Cover_ftype 					:= if(r.Floor_Cover_ftype = '', '', r.Floor_Cover_ftype);
	self.Foundation_ftype	 					:= if(r.Foundation_ftype = '', '', r.Foundation_ftype);
	self.Fuel_Type_ftype 						:= if(r.Fuel_Type_ftype = '', '', r.Fuel_Type_ftype);
 	self.Heating_ftype 							:= if(r.Heating_ftype = '', '', r.Heating_ftype);	
	self.Garage_ftype 							:= if(r.Garage_ftype = '', '', r.Garage_ftype);
	self.Garage_sqft_ftype 					:= if(r.Garage_sqft_ftype = '', '', r.Garage_sqft_ftype);
	self.Roof_Cover_ftype 					:= if(r.Roof_Cover_ftype = '', '', r.Roof_Cover_ftype);
	
  self := l;   
END;


OutPropertyDS := 
  project(
          join(
               sort(UniqueIdWithInPropertyDS,geolink,cleanaid,local)
               ,project(
                        dedup(
                              sort(
                                   distribute(
                                              la1_UpdatedPropertyVariablesDS
                                              ,hash64(ogeolink)
                                   )
                                   , ogeolink,cleanaid
                                   , local
                              )
                              ,ogeolink,cleanaid
                              ,local
                        )
                        ,transform(recordof(la1_UpdatedPropertyVariablesDS)
                                   ,self.geolink := left.ogeolink
                                   ,self := left;
                         )
                 )
                , (left.geolink=right.geolink) and (left.cleanaid=right.cleanaid)
                , updateOriginalPropertyDS( LEFT, RIGHT )
                , LEFT OUTER
                , local
          )
          , recordof(dsInProperty)
  );

output(OutPropertyDS,,'~thor_data400::temp::propertyfieldfillinbyla2::OutPropertyDS',OVERWRITE);	 
ENDMACRO;
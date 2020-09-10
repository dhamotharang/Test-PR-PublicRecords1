export	Populate_Default_Data	:=
module
	
	export	Mac_Default_Data(pInDataset,pField,pSrcField,pCodesV3FieldName,pOutDataset)	:=
	macro		
		#uniquename(dCensusTractDefaultData)
		// Dedup the dataset to make sure that we have only one xmlxref for a given fipscode, census tract and trade
		%dCensusTractDefaultData%	:=	dedup(	sort(	PropertyCharacteristics.Files.Codes.CensusDefaultDataLookup,
																								fips_code,census_tract,trade_id,-default_value,common_code
																							),
																					fips_code,census_tract,trade_id
																				);

		// Get trade id from the field name
		#uniquename(vTradeID)
		%vTradeID%	:=	PropertyCharacteristics.Files.Codes.CodesV3(	field_name2	=	'BLUBK'	and
																																	field_name	=	'TRADE'	and
																																	long_desc		=	pCodesV3FieldName
																																)[1].code;

		// Transform to get default material code using the census tract default table
		#uniquename(tCenusTractDefaultData)
		recordof(pInDataset)	%tCenusTractDefaultData%(pInDataset	le,%dCensusTractDefaultData%	ri)	:=
		transform
			self.pField			:=	if(le.pField	!=	'',le.pField,ri.common_code);
			self.pSrcField	:=	if(	le.pField	!=	'',
															le.pSrcField,
															if(ri.common_code	!=	'','DEFLT','')
														);
			self						:=	le;
		end;
		
		#uniquename(dCensusTractDefault)
		%dCensusTractDefault%	:=	join(	pInDataset,
																		%dCensusTractDefaultData%,
																		right.trade_id																					=	(integer)%vTradeID%	and
																		left.county																							=	right.fips_code			and
																		(integer)left.geo_blk[1..4]	+	'.'	+	left.geo_blk[5..6]	=	right.census_tract,
																		%tCenusTractDefaultData%(left,right),
																		left outer,
																		lookup
																	);
		
		// Dedup the dataset to make sure that we have only one xmlxref for a given fipscode, census tract and trade
		#uniquename(dZipCodeDefaultData)
		%dZipCodeDefaultData%	:=	dedup(	sort(	PropertyCharacteristics.Files.Codes.ZipCodeDefaultDataLookup,
																						zip_code,trade_id,-default_value,common_code
																					),
																			zip_code,trade_id
																		);

		// Transform to get default material code using the zip code default table
		#uniquename(tZipCodeDefaultData)
		recordof(pInDataset)	%tZipCodeDefaultData%(%dCensusTractDefault%	le,%dZipCodeDefaultData%	ri)	:=
		transform
			self.pField			:=	if(le.pField	!=	'',le.pField,ri.common_code);
			self.pSrcField	:=	if(	le.pField	!=	'',
															le.pSrcField,
															if(ri.common_code	!=	'','DEFLT','')
														);
			self						:=	le;
		end;
		
		#uniquename(dZipCodeDefault)
		%dZipCodeDefault%	:=	join(	%dCensusTractDefault%,
																%dZipCodeDefaultData%,
																right.trade_id	=	(integer)%vTradeID%	and
																left.zip				=	right.zip_code,
																%tZipCodeDefaultData%(left,right),
																left outer,
																lookup
															);
		
		// Transform to rectify the default common code mapping issues(for example, climate control maps to 3 different fields)
		#uniquename(tCheckDefaultCodeMapping)
		recordof(pInDataset)	%tCheckDefaultCodeMapping%(%dZipCodeDefault%	le,PropertyCharacteristics.Files.Codes.CodesV3	ri)	:=
		transform
			self.pField			:=	if(	le.pSrcField	!=	'DEFLT',
															le.pField,
															if(ri.long_desc	!=	'',le.pField,'')
														);
			self.pSrcField	:=	if(	le.pSrcField	!=	'DEFLT',
															le.pSrcField,
															if(ri.long_desc	!=	'',le.pSrcField,'')
														);
			self						:=	le;
		end;
		
		#uniquename(dCheckDefaultCodeMapping)
		%dCheckDefaultCodeMapping%	:=	join(	%dZipCodeDefault%,
																					PropertyCharacteristics.Files.Codes.CodesV3,
																					right.field_name2	=	'COMMN'	and
																					left.pField				=	right.code,
																					%tCheckDefaultCodeMapping%(left,right),
																					left outer,
																					lookup
																				);
		
		pOutDataset	:=	%dZipCodeDefault%;
	endmacro;
	
	export	Mac_Populate_Default_Data(pInDataset,pOutDataset)	:=
	macro
		// Default Data for AC
		#uniquename(dDefData_AC)
		PropertyCharacteristics.Populate_Default_Data.Mac_Default_Data(pInDataset,AIR_CONDITIONING_TYPE,SRC_AIR_CONDITIONING_TYPE,'CLIMATE_CONTROL',%dDefData_AC%);
		
		// Default Data for Heating
		#uniquename(dDefData_Heating)
		PropertyCharacteristics.Populate_Default_Data.Mac_Default_Data(%dDefData_AC%,HEATING,SRC_HEATING,'CLIMATE_CONTROL',%dDefData_Heating%);
		
		// Default Data for Fuel Type
		#uniquename(dDefData_Fuel)
		PropertyCharacteristics.Populate_Default_Data.Mac_Default_Data(%dDefData_Heating%,FUEL_TYPE,SRC_FUEL_TYPE,'CLIMATE_CONTROL',%dDefData_Fuel%);
		
		// Default Data for Floor Type
		#uniquename(dDefData_Floor)
		PropertyCharacteristics.Populate_Default_Data.Mac_Default_Data(%dDefData_Fuel%,FLOOR_TYPE,SRC_FLOOR_TYPE,'FLOORING',%dDefData_Floor%);
		
		// Default Data for Construction Type
		#uniquename(dDefData_ConstType)
		PropertyCharacteristics.Populate_Default_Data.Mac_Default_Data(%dDefData_Floor%,CONSTRUCTION_TYPE,SRC_CONSTRUCTION_TYPE,'EXTERIOR_FINISH',%dDefData_ConstType%);
		
		// Default Data for Exterior Wall
		#uniquename(dDefData_ExtWall)
		PropertyCharacteristics.Populate_Default_Data.Mac_Default_Data(%dDefData_ConstType%,EXTERIOR_WALL,SRC_EXTERIOR_WALL,'EXTERIOR_FINISH',%dDefData_ExtWall%);
		
		// Default Data forRoof Cover
		#uniquename(dDefData_RoofCover)
		PropertyCharacteristics.Populate_Default_Data.Mac_Default_Data(%dDefData_ExtWall%,ROOF_COVER,SRC_ROOF_COVER,'ROOFING',%dDefData_RoofCover%);
		
		// Default Data for Foundation
		#uniquename(dDefData_Foundation)
		PropertyCharacteristics.Populate_Default_Data.Mac_Default_Data(%dDefData_RoofCover%,FOUNDATION,SRC_FOUNDATION,'FOUNDATION',%dDefData_Foundation%);
		
		// Default Data for Fireplace Type
		#uniquename(dDefData_Fireplace)
		PropertyCharacteristics.Populate_Default_Data.Mac_Default_Data(%dDefData_Foundation%,FIREPLACE_TYPE,SRC_FIREPLACE_TYPE,'FIREPLACE',%dDefData_Fireplace%);
		
		// Default Data for Parking Type
		#uniquename(dDefData_Parking)
		PropertyCharacteristics.Populate_Default_Data.Mac_Default_Data(%dDefData_Fireplace%,PARKING_TYPE,SRC_PARKING_TYPE,'PARKING',%dDefData_Parking%);
		
		// Default Data for Garage Type
		#uniquename(dDefData_Garage)
		PropertyCharacteristics.Populate_Default_Data.Mac_Default_Data(%dDefData_Parking%,GARAGE,SRC_GARAGE,'PARKING',%dDefData_Garage%);
		
		// Default Data for Basement Finish
		#uniquename(dDefData_Basement)
		PropertyCharacteristics.Populate_Default_Data.Mac_Default_Data(%dDefData_Garage%,BASEMENT_FINISH,SRC_BASEMENT_FINISH,'BASEMENT',%dDefData_Basement%);
		
		pOutDataset	:=	%dDefData_Basement%;
	endmacro;
	

// Fill-in Non Coded Fields
	export	Mac_Populate_Attribute_Default_Data(pInDataset,pOutDataset)	:=
	macro
	#uniquename(dAttributeDefault_fips)
	%dAttributeDefault_fips%  := PROJECT(PropertyFieldFillinByLA2.file_base,
																					TRANSFORM(recordof(PropertyFieldFillinByLA2.file_base),
																					fips_state := codes.st2FipsCode(left.st);
																					self.fips_county	:= fips_state;
																					SELF := LEFT));
	#uniquename(dAttributeDefault)
		// Dedup the dataset to make sure that we have condense dataset for a given fipscode, census tract and zipcode
		%dAttributeDefault%	:=	dedup(sort(distribute(%dAttributeDefault_fips%,hash(prim_range, prim_name, sec_range, zip, addr_suffix, predir, postdir, geo_blk)),
																				prim_range, prim_name, sec_range, zip, addr_suffix, predir, postdir, geo_blk,local),
																					prim_range, prim_name, sec_range, zip, addr_suffix, predir, postdir, geo_blk, local 
																				);

// Append sequence number
// #uniquename(dAttributeDefault)
// ut.MAC_Sequence_Records(pInDataset,property_rid,dPropertySeqNum);																				
																				
	#uniquename(tAttributeDefault)
	// Slim down the layout to keep only fields required for field fill-in
rSlimFillInFields_layout	:=
record
	pInDataset.property_rid;
	pInDataset.prim_range;
	pInDataset.predir;
	pInDataset.prim_name;
	pInDataset.addr_suffix;
	pInDataset.postdir;
	pInDataset.unit_desig;
	pInDataset.sec_range;
	pInDataset.p_city_name;
	pInDataset.v_city_name;
	pInDataset.st;
	pInDataset.zip;
	pInDataset.zip4;
	pInDataset.county;
	pInDataset.geo_blk;
	
	pInDataset.no_of_baths;
	pInDataset.src_no_of_baths;
	
	pInDataset.no_of_bedrooms;
	pInDataset.src_no_of_bedrooms;
	
	pInDataset.no_of_stories;
	pInDataset.src_no_of_stories;
	
	pInDataset.no_of_fireplaces;
	pInDataset.src_no_of_fireplaces;
	
	pInDataset.no_of_rooms;
	pInDataset.src_no_of_rooms;
	
	pInDataset.garage_square_footage;
	pInDataset.src_garage_square_footage;
	
	pInDataset.building_square_footage;
	pInDataset.src_building_square_footage;
	
	pInDataset.total_assessed_value;
	pInDataset.src_total_assessed_value;
	
	pInDataset.year_built;
	pInDataset.src_year_built;

	pInDataset.air_conditioning_type;
	pInDataset.src_air_conditioning_type;
	
	pInDataset.heating;
	pInDataset.src_heating;
	
	pInDataset.exterior_wall;
	pInDataset.src_exterior_wall;
	
	pInDataset.construction_type;
	pInDataset.src_construction_type;
	
	pInDataset.floor_type;
	pInDataset.src_floor_type;
	
	pInDataset.roof_cover;
	pInDataset.src_roof_cover;
	
	pInDataset.foundation;
	pInDataset.src_foundation;
	
	pInDataset.garage;
	pInDataset.src_garage;

/*	Futute Phase		
	pInDataset.basement_square_footage;
	pInDataset.src_basement_square_footage;
	
	pInDataset.basement_finish;
	pInDataset.src_basement_finish;

	pInDataset.fuel_type;
	pInDataset.src_fuel_type;	
	
	dPropertySeqNum.sewer;
	dPropertySeqNum.src_sewer;
	
	dPropertySeqNum.water;
	dPropertySeqNum.src_water;
	
	dPropertySeqNum.pool_type;
	dPropertySeqNumt.src_pool_type;
	
	pInDataset.style_type;
	dPropertySeqNum.src_style_type;
	
*/	
end;

// dLNslimFillInFields	:=	project(pInDataset,rSlimFillInFields_layout);	
	
PropertyCharacteristics.Layouts.TempBase	%tAttributeDefault%(pInDataset le, %dAttributeDefault%	ri)	:=
		transform
		  string vBaths  					:= (string) PropertyCharacteristics.Functions.round2decimal(ri.baths);
			string vStories 				:= (string) PropertyCharacteristics.Functions.round2decimal(ri.stories);
			string vBedrooms				:= (string)	ri.bedrooms;
			string vRooms						:= (string)	ri.rooms;
			string vBuilding_sqft		:= (string) ri.buildingarea;
			string vAssessedAmount	:= (string) ri.assessedAmount;
			string vFireplaces			:= (string) ri.Fireplaces;
			string vGarage_SqFt 		:= (string) ri.garage_sqft;
			// string vBasement_SqFt 	:= (string) ri.basement_sqft;
			
			vCurrentYear   					:= (integer)ut.getdate[1..4] + 1;
			vYearBuilt 							:= if(ri.BuildingAge != 0,
																			(string) (vCurrentYear - ri.buildingAge),
																			 ''
																		); 																						
			
		  self.no_of_baths					:=	if(	PropertyCharacteristics.Functions.fn_remove_zeroes(le.no_of_baths)	=	'',
																					if(	PropertyCharacteristics.Functions.fn_remove_zeroes(vBaths) != '',
																									vBaths,	''
																									),
																			le.no_of_baths
																		);
																		
			self.src_no_of_baths			:=	if(	le.src_no_of_baths	!=	'',	le.src_no_of_baths,
																			if(self.no_of_baths	!=	'','DEFLT','')
																		);
																		
			self.no_of_bedrooms				:=	if(	PropertyCharacteristics.Functions.fn_remove_zeroes(le.no_of_bedrooms)	=	'',
																			if(	PropertyCharacteristics.Functions.fn_remove_zeroes(vBedrooms)	!=	'',
																						vBedrooms,''
																						),
																			le.no_of_bedrooms
																		);
																		
			self.src_no_of_bedrooms		:=	if(	le.src_no_of_bedrooms	!=	'', le.src_no_of_bedrooms,
																			if(self.no_of_bedrooms	!=	'','DEFLT','')
																		);
			self.no_of_stories				:=	if(	PropertyCharacteristics.Functions.fn_remove_zeroes(le.no_of_stories)	=	'',
																			if(	PropertyCharacteristics.Functions.fn_remove_zeroes(vStories)	!=	'',
																						vStories, ''
																						),
																			le.no_of_stories
																		);
																		
			self.src_no_of_stories		:=	if(	le.src_no_of_stories	!=	'',	le.src_no_of_stories,
																			if(self.no_of_stories	!=	'','DEFLT','')
																		);
			self.no_of_fireplaces			:=	if(	PropertyCharacteristics.Functions.fn_remove_zeroes(le.no_of_fireplaces)	=	'',
																				if( PropertyCharacteristics.Functions.fn_remove_zeroes(vFireplaces)	!=	'',
																							vFireplaces, ''
																					),
																			le.no_of_fireplaces
																		);
    		
			self.src_no_of_fireplaces	:=	if(	le.src_no_of_fireplaces	!=	'',	le.src_no_of_fireplaces,
																			if(self.no_of_fireplaces	!=	'','DEFLT','')
																		);

			self.no_of_rooms					:= if(PropertyCharacteristics.Functions.fn_remove_zeroes(le.no_of_rooms) = '',
																			if(PropertyCharacteristics.Functions.fn_remove_zeroes(vRooms) != '',
																						vRooms,	''
																						),	
																			le.no_of_rooms);
																					
																						
			self.src_no_of_rooms			:= if(le.src_no_of_rooms != '',le.src_no_of_rooms,
																		if(self.no_of_rooms != '', 'DEFLT','')
																		);
																							
			self.garage_square_footage					:= if(trim(le.garage_square_footage)	= '',
																								if(PropertyCharacteristics.Functions.fn_remove_zeroes(vGarage_SqFt) !=  '',
																										vGarage_SqFt, ''
																										),
																							le.garage_square_footage
																							);
																							
																							
			self.src_garage_square_footage			:= if(le.src_garage_square_footage != '',le.src_garage_square_footage,
																									if(self.garage_square_footage != '', 'DEFLT','')
																							);
																						
			self.building_square_footage				:=	if(PropertyCharacteristics.Functions.fn_remove_zeroes(le.building_square_footage) = '',
																								if(PropertyCharacteristics.Functions.fn_remove_zeroes(vBuilding_sqft) != '',
																										vBuilding_sqft, ''
																										),
																								le.building_square_footage
																							);
																								
																								
			self.src_building_square_footage		:= if(le.src_building_square_footage != '',	le.src_building_square_footage,
																								if(self.building_square_footage != '', 'DEFLT','')
																								);
																								
			self.total_assessed_value							:= if(PropertyCharacteristics.Functions.fn_remove_zeroes(le.total_assessed_value) = '',
																							 if(PropertyCharacteristics.Functions.fn_remove_zeroes(vAssessedAmount) != '',
																											vAssessedAmount,''
																										),
																									le.total_assessed_value
																							);
																												
			self.src_total_assessed_value					:= if(le.src_total_assessed_value != '', le.src_total_assessed_value,
																								if(self.total_assessed_value != '', 'DEFLT','')
																								);
																								
			
			self.year_built											:= if(PropertyCharacteristics.Functions.fn_remove_zeroes(le.year_built) = '',
																								if(PropertyCharacteristics.Functions.fn_remove_zeroes(vYearBuilt) != '',
																										vYearBuilt, ''
																										),
																								le.year_built
																							);
																								
			self.src_year_built									:= if(le.src_year_built != '',le.src_year_built,
																								if(self.year_built != '', 'DEFLT','')
																								);	
			
																							

			self.air_conditioning_type						:= if(trim(le.air_conditioning_type)	= '',
																									if(trim(ri.air_conditioning_type_code) !=  '',
																										ri.air_conditioning_type_code, ''
																										),
																											le.air_conditioning_type
																									);
																									
			self.src_air_conditioning_type				:= if(le.src_air_conditioning_type != '',le.src_air_conditioning_type,
																									if(self.air_conditioning_type != '', 'DEFLT','')
																							);
	
			self.heating													:= if(trim(le.heating)	= '',
																									if(trim(ri.heating_code) !=  '',
																										ri.heating_code, ''
																										),
																											le.heating
																									);
																									
			self.src_heating											:= if(le.src_heating != '',le.src_heating,
																									if(self.heating != '', 'DEFLT','')
																							);
	
			self.exterior_wall										:= if(trim(le.exterior_wall)	= '',
																									if(trim(ri.exterior_walls_code) !=  '',
																										ri.exterior_walls_code, ''
																										),
																											le.exterior_wall
																									);
																									
			self.src_exterior_wall								:= if(le.src_exterior_wall != '',le.src_exterior_wall,
																									if(self.exterior_wall != '', 'DEFLT','')
																							);
	
			self.construction_type								:= if(trim(le.construction_type)	= '',
																									if(trim(ri.construction_type_code) !=  '',
																										ri.construction_type_code, ''
																										),
																											le.construction_type
																									);
																									
			self.src_construction_type						:= if(le.src_construction_type != '',le.src_construction_type,
																									if(self.construction_type != '', 'DEFLT','')
																							);
	
			self.floor_type												:= if(trim(le.floor_type)	= '',
																									if(trim(ri.floor_cover_code) !=  '',
																										ri.floor_cover_code, ''
																										),
																											le.floor_type
																									);
																									
			self.src_floor_type										:= if(le.src_floor_type != '',le.src_floor_type,
																									if(self.floor_type != '', 'DEFLT','')
																							);
	
			self.roof_cover												:= if(trim(le.roof_cover)	= '',
																									if(trim(ri.roof_cover_code) !=  '',
																										ri.roof_cover_code, ''
																										),
																											le.roof_cover
																									);
																									
			self.src_roof_cover										:= if(le.src_roof_cover != '',le.src_roof_cover,
																									if(self.roof_cover != '', 'DEFLT','')
																							);
	
			self.foundation												:= if(trim(le.foundation)	= '',
																									if(trim(ri.foundation_code) !=  '',
																										ri.foundation_code, ''
																										),
																											le.foundation
																									);
																									
			self.src_foundation										:= if(le.src_foundation != '',le.src_foundation,
																									if(self.foundation != '', 'DEFLT','')
																							);
	
			self.garage														:= if(trim(le.garage)	= '',
																									if(trim(ri.garage_code) !=  '',
																										ri.garage_code, ''
																										),
																											le.garage
																									);
																									
			self.src_garage												:= if(le.src_garage != '',le.src_garage,
																									if(self.garage != '', 'DEFLT','')
																							);
		
/* Future Phase		
    	self.basement_square_footage					:= if(trim(le.basement_square_footage)	= '',
																								if(PropertyCharacteristics.Functions.fn_remove_zeroes(vBasement_SqFt) !=  '',
																										vBasement_SqFt, ''
																										),
																							le.basement_square_footage
																							);
																							
																							
			self.src_basement_square_footage			:= if(le.src_basement_square_footage != '',le.src_basement_square_footage,
																									if(self.basement_square_footage != '', 'DEFLT','')
																							);
			
			self.basement_finish									:= if(trim(le.basement_finish)	= '',
																									if(trim(ri.basement_code) !=  '',
																										ri.basement_code, ''
																										),
																											le.basement_finish
																									);
																									
			self.src_basement_finish							:= if(le.src_basement_finish != '',le.src_basement_finish,
																									if(self.basement_finish != '', 'DEFLT','')
																							);
	
			self.fuel_type												:= if(trim(le.fuel_type)	= '',
																									if(trim(ri.fuel_type_code) !=  '',
																										ri.fuel_type_code, ''
																										),
																											le.fuel_type
																									);
																									
			self.src_fuel_type										:= if(le.src_fuel_type != '',le.src_fuel_type,
																									if(self.fuel_type != '', 'DEFLT','')
																							);
	
*/
			
			self						:=	le;
		end;
		
		#uniquename(dDefault)
		%dDefault%	:=	join(	pInDataset,	%dAttributeDefault%,
													 left.prim_range 			= right.prim_range
                           and left.prim_name 	= right.prim_name
                           and left.sec_range 	= right.sec_range
                           and left.zip 				= right.zip 
                           and left.addr_suffix = right.addr_suffix
                           and left.predir 			= right.predir 
                           and left.postdir 		= right.postdir
													 and left.geo_blk 		= right.geo_blk,
                          %tAttributeDefault%(left,right), left outer, nolocal	);
				
		
pOutDataset := %dDefault%;
	
	endmacro;
	
export	Mac_Populate_Attribute_Default_Data_F_and_G(pInDataset,pOutDataset)	:=
	macro
	#uniquename(dAttributeDefault_fips)
	%dAttributeDefault_fips%  := PROJECT(PropertyFieldFillinByLA2.file_base,
																					TRANSFORM(recordof(PropertyFieldFillinByLA2.file_base),
																					fips_state := codes.st2FipsCode(left.st);
																					self.fips_county	:= fips_state;
																					SELF := LEFT));
	#uniquename(dAttributeDefault)
		// Dedup the dataset to make sure that we have condense dataset for a given fipscode, census tract and zipcode
		%dAttributeDefault%	:=	dedup(sort(distribute(%dAttributeDefault_fips%,hash(prim_range, prim_name, sec_range, zip, addr_suffix, predir, postdir, geo_blk)),
																				prim_range, prim_name, sec_range, zip, addr_suffix, predir, postdir, geo_blk,local),
																					prim_range, prim_name, sec_range, zip, addr_suffix, predir, postdir, geo_blk, local 
																				);

// Append sequence number
// #uniquename(dAttributeDefault)
// ut.MAC_Sequence_Records(pInDataset,property_rid,dPropertySeqNum);																				
																				
	#uniquename(tAttributeDefault)
	// Slim down the layout to keep only fields required for field fill-in
rSlimFillInFields_layout	:=
record
	pInDataset.property_rid;
	pInDataset.prim_range;
	pInDataset.predir;
	pInDataset.prim_name;
	pInDataset.addr_suffix;
	pInDataset.postdir;
	pInDataset.unit_desig;
	pInDataset.sec_range;
	pInDataset.p_city_name;
	pInDataset.v_city_name;
	pInDataset.st;
	pInDataset.zip;
	pInDataset.zip4;
	pInDataset.county;
	pInDataset.geo_blk;
	
	pInDataset.no_of_baths;
	pInDataset.src_no_of_baths;
	
	pInDataset.no_of_bedrooms;
	pInDataset.src_no_of_bedrooms;
	
	pInDataset.no_of_stories;
	pInDataset.src_no_of_stories;
	
	pInDataset.no_of_fireplaces;
	pInDataset.src_no_of_fireplaces;
	
	pInDataset.no_of_rooms;
	pInDataset.src_no_of_rooms;
	
	pInDataset.garage_square_footage;
	pInDataset.src_garage_square_footage;
	
	pInDataset.building_square_footage;
	pInDataset.src_building_square_footage;
	
	pInDataset.total_assessed_value;
	pInDataset.src_total_assessed_value;
	
	pInDataset.year_built;
	pInDataset.src_year_built;

	pInDataset.air_conditioning_type;
	pInDataset.src_air_conditioning_type;
	
	pInDataset.heating;
	pInDataset.src_heating;
	
	pInDataset.exterior_wall;
	pInDataset.src_exterior_wall;
	
	pInDataset.construction_type;
	pInDataset.src_construction_type;
	
	pInDataset.floor_type;
	pInDataset.src_floor_type;
	
	pInDataset.roof_cover;
	pInDataset.src_roof_cover;
	
	pInDataset.foundation;
	pInDataset.src_foundation;
	
	pInDataset.garage;
	pInDataset.src_garage;

/*	Futute Phase		
	pInDataset.basement_square_footage;
	pInDataset.src_basement_square_footage;
	
	pInDataset.basement_finish;
	pInDataset.src_basement_finish;

	pInDataset.fuel_type;
	pInDataset.src_fuel_type;	
	
	dPropertySeqNum.sewer;
	dPropertySeqNum.src_sewer;
	
	dPropertySeqNum.water;
	dPropertySeqNum.src_water;
	
	dPropertySeqNum.pool_type;
	dPropertySeqNumt.src_pool_type;
	
	pInDataset.style_type;
	dPropertySeqNum.src_style_type;
	
*/	
end;

// dLNslimFillInFields	:=	project(pInDataset,rSlimFillInFields_layout);	
	
PropertyCharacteristics.Layouts.TempBase	%tAttributeDefault%(pInDataset le, %dAttributeDefault%	ri)	:=
		transform
		  string vBaths  					:= (string) PropertyCharacteristics.Functions.round2decimal(ri.baths);
			string vStories 				:= (string) PropertyCharacteristics.Functions.round2decimal(ri.stories);
			string vBedrooms				:= (string)	ri.bedrooms;
			string vRooms						:= (string)	ri.rooms;
			string vBuilding_sqft		:= (string) ri.buildingarea;
			string vAssessedAmount	:= (string) ri.assessedAmount;
			string vFireplaces			:= (string) ri.Fireplaces;
			string vGarage_SqFt 		:= (string) ri.garage_sqft;
			// string vBasement_SqFt 	:= (string) ri.basement_sqft;
			
			vCurrentYear   					:= (integer)ut.getdate[1..4] + 1;
			vYearBuilt 							:= if(ri.BuildingAge != 0,
																			(string) (vCurrentYear - ri.buildingAge),
																			 ''
																		); 																						
			
		  self.no_of_baths					:=	if(trim(le.no_of_baths,left,right)=	'',
																					if(	PropertyCharacteristics.Functions.fn_remove_zeroes(vBaths) != '',
																									vBaths,	''
																									),
																			le.no_of_baths
																		);
																		
			self.src_no_of_baths			:=	if(	le.src_no_of_baths	!=	'',	le.src_no_of_baths,
																			if(self.no_of_baths	!=	'','DEFLT','')
																		);
																		
			self.no_of_bedrooms				:=	if(	trim(le.no_of_bedrooms,left,right)	=	'',
																			if(	PropertyCharacteristics.Functions.fn_remove_zeroes(vBedrooms)	!=	'',
																						vBedrooms,''
																						),
																			le.no_of_bedrooms
																		);
																		
			self.src_no_of_bedrooms		:=	if(	le.src_no_of_bedrooms	!=	'', le.src_no_of_bedrooms,
																			if(self.no_of_bedrooms	!=	'','DEFLT','')
																		);
			self.no_of_stories				:=	if(	trim(le.no_of_stories,left,right)	=	'',
																			if(	PropertyCharacteristics.Functions.fn_remove_zeroes(vStories)	!=	'',
																						vStories, ''
																						),
																			le.no_of_stories
																		);
																		
			self.src_no_of_stories		:=	if(	le.src_no_of_stories	!=	'',	le.src_no_of_stories,
																			if(self.no_of_stories	!=	'','DEFLT','')
																		);
			self.no_of_fireplaces			:=	if(	trim(le.no_of_fireplaces,left,right)	=	'',
																				if( PropertyCharacteristics.Functions.fn_remove_zeroes(vFireplaces)	!=	'',
																							vFireplaces, ''
																					),
																			le.no_of_fireplaces
																		);
    		
			self.src_no_of_fireplaces	:=	if(	le.src_no_of_fireplaces	!=	'',	le.src_no_of_fireplaces,
																			if(self.no_of_fireplaces	!=	'','DEFLT','')
																		);

			self.no_of_rooms					:= if(trim(le.no_of_rooms,left,right)= '',
																			if(PropertyCharacteristics.Functions.fn_remove_zeroes(vRooms) != '',
																						vRooms,	''
																						),	
																			le.no_of_rooms);
																					
																						
			self.src_no_of_rooms			:= if(le.src_no_of_rooms != '',le.src_no_of_rooms,
																		if(self.no_of_rooms != '', 'DEFLT','')
																		);
																							
			self.garage_square_footage					:= if(trim(le.garage_square_footage)	= '',
																								if(PropertyCharacteristics.Functions.fn_remove_zeroes(vGarage_SqFt) !=  '',
																										vGarage_SqFt, ''
																										),
																							le.garage_square_footage
																							);
																							
																							
			self.src_garage_square_footage			:= if(le.src_garage_square_footage != '',le.src_garage_square_footage,
																									if(self.garage_square_footage != '', 'DEFLT','')
																							);
																						
			self.building_square_footage				:=	if(PropertyCharacteristics.Functions.fn_remove_zeroes(le.building_square_footage) = '',
																								if(PropertyCharacteristics.Functions.fn_remove_zeroes(vBuilding_sqft) != '',
																										vBuilding_sqft, ''
																										),
																								le.building_square_footage
																							);
																								
																								
			self.src_building_square_footage		:= if(le.src_building_square_footage != '',	le.src_building_square_footage,
																								if(self.building_square_footage != '', 'DEFLT','')
																								);
																								
			self.total_assessed_value							:= if(PropertyCharacteristics.Functions.fn_remove_zeroes(le.total_assessed_value) = '',
																							 if(PropertyCharacteristics.Functions.fn_remove_zeroes(vAssessedAmount) != '',
																											vAssessedAmount,''
																										),
																									le.total_assessed_value
																							);
																												
			self.src_total_assessed_value					:= if(le.src_total_assessed_value != '', le.src_total_assessed_value,
																								if(self.total_assessed_value != '', 'DEFLT','')
																								);
																								
			
			self.year_built											:= if(PropertyCharacteristics.Functions.fn_remove_zeroes(le.year_built) = '',
																								if(PropertyCharacteristics.Functions.fn_remove_zeroes(vYearBuilt) != '',
																										vYearBuilt, ''
																										),
																								le.year_built
																							);
																								
			self.src_year_built									:= if(le.src_year_built != '',le.src_year_built,
																								if(self.year_built != '', 'DEFLT','')
																								);	
			
																							

			self.air_conditioning_type						:= if(trim(le.air_conditioning_type)	= '',
																									if(trim(ri.air_conditioning_type_code) !=  '',
																										ri.air_conditioning_type_code, ''
																										),
																											le.air_conditioning_type
																									);
																									
			self.src_air_conditioning_type				:= if(le.src_air_conditioning_type != '',le.src_air_conditioning_type,
																									if(self.air_conditioning_type != '', 'DEFLT','')
																							);
	
			self.heating													:= if(trim(le.heating)	= '',
																									if(trim(ri.heating_code) !=  '',
																										ri.heating_code, ''
																										),
																											le.heating
																									);
																									
			self.src_heating											:= if(le.src_heating != '',le.src_heating,
																									if(self.heating != '', 'DEFLT','')
																							);
	
			self.exterior_wall										:= if(trim(le.exterior_wall)	= '',
																									if(trim(ri.exterior_walls_code) !=  '',
																										ri.exterior_walls_code, ''
																										),
																											le.exterior_wall
																									);
																									
			self.src_exterior_wall								:= if(le.src_exterior_wall != '',le.src_exterior_wall,
																									if(self.exterior_wall != '', 'DEFLT','')
																							);
	
			self.construction_type								:= if(trim(le.construction_type)	= '',
																									if(trim(ri.construction_type_code) !=  '',
																										ri.construction_type_code, ''
																										),
																											le.construction_type
																									);
																									
			self.src_construction_type						:= if(le.src_construction_type != '',le.src_construction_type,
																									if(self.construction_type != '', 'DEFLT','')
																							);
	
			self.floor_type												:= if(trim(le.floor_type)	= '',
																									if(trim(ri.floor_cover_code) !=  '',
																										ri.floor_cover_code, ''
																										),
																											le.floor_type
																									);
																									
			self.src_floor_type										:= if(le.src_floor_type != '',le.src_floor_type,
																									if(self.floor_type != '', 'DEFLT','')
																							);
	
			self.roof_cover												:= if(trim(le.roof_cover)	= '',
																									if(trim(ri.roof_cover_code) !=  '',
																										ri.roof_cover_code, ''
																										),
																											le.roof_cover
																									);
																									
			self.src_roof_cover										:= if(le.src_roof_cover != '',le.src_roof_cover,
																									if(self.roof_cover != '', 'DEFLT','')
																							);
	
			self.foundation												:= if(trim(le.foundation)	= '',
																									if(trim(ri.foundation_code) !=  '',
																										ri.foundation_code, ''
																										),
																											le.foundation
																									);
																									
			self.src_foundation										:= if(le.src_foundation != '',le.src_foundation,
																									if(self.foundation != '', 'DEFLT','')
																							);
	
			self.garage														:= if(trim(le.garage)	= '',
																									if(trim(ri.garage_code) !=  '',
																										ri.garage_code, ''
																										),
																											le.garage
																									);
																									
			self.src_garage												:= if(le.src_garage != '',le.src_garage,
																									if(self.garage != '', 'DEFLT','')
																							);
		
/* Future Phase		
    	self.basement_square_footage					:= if(trim(le.basement_square_footage)	= '',
																								if(PropertyCharacteristics.Functions.fn_remove_zeroes(vBasement_SqFt) !=  '',
																										vBasement_SqFt, ''
																										),
																							le.basement_square_footage
																							);
																							
																							
			self.src_basement_square_footage			:= if(le.src_basement_square_footage != '',le.src_basement_square_footage,
																									if(self.basement_square_footage != '', 'DEFLT','')
																							);
			
			self.basement_finish									:= if(trim(le.basement_finish)	= '',
																									if(trim(ri.basement_code) !=  '',
																										ri.basement_code, ''
																										),
																											le.basement_finish
																									);
																									
			self.src_basement_finish							:= if(le.src_basement_finish != '',le.src_basement_finish,
																									if(self.basement_finish != '', 'DEFLT','')
																							);
	
			self.fuel_type												:= if(trim(le.fuel_type)	= '',
																									if(trim(ri.fuel_type_code) !=  '',
																										ri.fuel_type_code, ''
																										),
																											le.fuel_type
																									);
																									
			self.src_fuel_type										:= if(le.src_fuel_type != '',le.src_fuel_type,
																									if(self.fuel_type != '', 'DEFLT','')
																							);
	
*/
			
			self						:=	le;
		end;
		
		#uniquename(dDefault)
		%dDefault%	:=	join(	pInDataset,	%dAttributeDefault%,
													 left.prim_range 			= right.prim_range
                           and left.prim_name 	= right.prim_name
                           and left.sec_range 	= right.sec_range
                           and left.zip 				= right.zip 
                           and left.addr_suffix = right.addr_suffix
                           and left.predir 			= right.predir 
                           and left.postdir 		= right.postdir
													 and left.geo_blk 		= right.geo_blk,
                          %tAttributeDefault%(left,right), left outer, nolocal	);
				
		
pOutDataset := %dDefault%;
	
	endmacro;

end;
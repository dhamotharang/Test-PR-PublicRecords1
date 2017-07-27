import	codes,ut,std;

dLNProp2Common	:=	PropertyCharacteristics.Map_LNProperty_Common(not regexfind('UNKNOWN', trim(property_city_state_zip)));;

// Map to temp base layout
PropertyCharacteristics.Layouts.TempBase	tMap2Base(dLNProp2Common	pInput)	:=
transform
	self.dt_vendor_first_reported	:=	(unsigned)pInput.process_date;
	self.dt_vendor_last_reported	:=	(unsigned)pInput.process_date;
	self.vendor										:=	pInput.vendor_source;
	self.vendor_source						:=	if(pInput.vendor_source	=	'OKCTY','C','D');
	self													:=	pInput;
	self													:=	[];
end;

dLNProp2TempBase	:=	project(dLNProp2Common,tMap2Base(left));

// Clean AID is assigned for each unique cleaned address, however small variations in fields p_city_name aren't collapsed into one clean aid
// As all the rollup logic is being done on clean aid, collapsing all the different varaitions of one cleaned address into one clean aid
dLNPropAddrCollapseAceAID	:=	PropertyCharacteristics.Functions.fnCollapseAceAID(dLNProp2TempBase);

// Rollup the property records based on vendor source and property address
// Also keep the most recent tax and deed information for a few selected fields
PropertyCharacteristics.Mac_Property_Rollup(dLNPropAddrCollapseAceAID,dLNPropRollup,false);

// Append sequence number
ut.MAC_Sequence_Records(dLNPropRollup,property_rid,dLNAppendSeqNum);

// Slim down the layout to keep only fields which have codes
rSlim2CodeFields_layout	:=
record
	dLNAppendSeqNum.property_rid;
	dLNAppendSeqNum.census_tract;
	dLNAppendSeqNum.zip;
	dLNAppendSeqNum.county;
	dLNAppendSeqNum.air_conditioning_type;
	dLNAppendSeqNum.heating;
	dLNAppendSeqNum.fuel_type;
	dLNAppendSeqNum.exterior_wall;
	dLNAppendSeqNum.construction_type;
	dLNAppendSeqNum.floor_type;
	dLNAppendSeqNum.roof_cover;
	dLNAppendSeqNum.foundation;
	dLNAppendSeqNum.fireplace_type;
	dLNAppendSeqNum.parking_type;
	dLNAppendSeqNum.garage;
	dLNAppendSeqNum.basement_finish;
	dLNAppendSeqNum.sewer;
	dLNAppendSeqNum.water;
	dLNAppendSeqNum.land_use_code;
	dLNAppendSeqNum.property_type_code;
	dLNAppendSeqNum.pool_type;
	dLNAppendSeqNum.style_type;
	dLNAppendSeqNum.location_influence_code;
	dLNAppendSeqNum.full_part_sale;
	dLNAppendSeqNum.interest_rate_type_code;
	dLNAppendSeqNum.loan_type_code;
	dLNAppendSeqNum.sale_type_code;
	dLNAppendSeqNum.stories_type;
	dLNAppendSeqNum.structure_quality;
	dLNAppendSeqNum.frame_type;
	dLNAppendSeqNum.no_of_stories;
	
	dLNAppendSeqNum.src_no_of_stories;
	dLNAppendSeqNum.src_air_conditioning_type;
	dLNAppendSeqNum.src_heating;
	dLNAppendSeqNum.src_fuel_type;
	dLNAppendSeqNum.src_exterior_wall;
	dLNAppendSeqNum.src_construction_type;
	dLNAppendSeqNum.src_floor_type;
	dLNAppendSeqNum.src_roof_cover;
	dLNAppendSeqNum.src_foundation;
	dLNAppendSeqNum.src_fireplace_type;
	dLNAppendSeqNum.src_parking_type;
	dLNAppendSeqNum.src_garage;
	dLNAppendSeqNum.src_basement_finish;
	dLNAppendSeqNum.src_sewer;
	dLNAppendSeqNum.src_water;
	dLNAppendSeqNum.src_land_use_code;
	dLNAppendSeqNum.src_property_type_code;
	dLNAppendSeqNum.src_pool_type;
	dLNAppendSeqNum.src_style_type;
	dLNAppendSeqNum.src_location_influence_code;
	dLNAppendSeqNum.src_full_part_sale;
	dLNAppendSeqNum.src_interest_rate_type_code;
	dLNAppendSeqNum.src_loan_type_code;
	dLNAppendSeqNum.src_sale_type_code;
	dLNAppendSeqNum.src_stories_type;
	dLNAppendSeqNum.src_structure_quality;
	dLNAppendSeqNum.src_frame_type;
		
	dLNAppendSeqNum.tax_dt_no_of_stories;
	dLNAppendSeqNum.tax_dt_air_conditioning_type;
	dLNAppendSeqNum.tax_dt_heating;
	dLNAppendSeqNum.tax_dt_fuel_type;
	dLNAppendSeqNum.tax_dt_exterior_wall;
	dLNAppendSeqNum.tax_dt_construction_type;
	dLNAppendSeqNum.tax_dt_floor_type;
	dLNAppendSeqNum.tax_dt_roof_cover;
	dLNAppendSeqNum.tax_dt_foundation;
	dLNAppendSeqNum.tax_dt_fireplace_type;
	dLNAppendSeqNum.tax_dt_parking_type;
	dLNAppendSeqNum.tax_dt_garage;
	dLNAppendSeqNum.tax_dt_basement_finish;
	dLNAppendSeqNum.tax_dt_sewer;
	dLNAppendSeqNum.tax_dt_water;
	dLNAppendSeqNum.tax_dt_land_use_code;
	dLNAppendSeqNum.tax_dt_property_type_code;
	dLNAppendSeqNum.tax_dt_pool_type;
	dLNAppendSeqNum.tax_dt_style_type;
	dLNAppendSeqNum.tax_dt_location_influence_code;
	dLNAppendSeqNum.rec_dt_full_part_sale;
	dLNAppendSeqNum.rec_dt_interest_rate_type_code;
	dLNAppendSeqNum.rec_dt_loan_type_code;
	dLNAppendSeqNum.rec_dt_sale_type_code;
	dLNAppendSeqNum.tax_dt_stories_type;
	dLNAppendSeqNum.tax_dt_structure_quality;
	dLNAppendSeqNum.tax_dt_frame_type;
		
	dLNAppendSeqNum.living_area_square_footage;
	dLNAppendSeqNum.basement_square_footage;
	dLNAppendSeqNum.garage_square_footage;
	
		
//Added New Fields to Evaluate Bug: 146154. 108962, 108094	
  dLNAppendSeqNum.no_of_units;
	dLNAppendSeqNum.no_of_baths;
	dLNAppendSeqNum.no_of_full_baths;
	dLNAppendSeqNum.no_of_half_baths;
	dLNAppendSeqNum.no_of_fireplaces;
	dLNAppendSeqNum.fireplace_ind;
	
	dLNAppendSeqNum.src_no_of_units;
	dLNAppendSeqNum.src_no_of_baths;
	dLNAppendSeqNum.src_no_of_full_baths;
	dLNAppendSeqNum.src_no_of_half_baths;
  dLNAppendSeqNum.src_no_of_fireplaces;
	dLNAppendSeqNum.src_fireplace_ind;
	dLNAppendSeqNum.src_garage_square_footage;
	
	dLNAppendSeqNum.tax_dt_no_of_units;
	dLNAppendSeqNum.tax_dt_no_of_fireplaces;
	dLNAppendSeqNum.tax_dt_fireplace_ind;
	dLNAppendSeqNum.tax_dt_no_of_baths;
	dLNAppendSeqNum.tax_dt_garage_square_footage;
	
	dLNAppendSeqNum.roof_type;
	dLNAppendSeqNum.src_roof_type;
	dLNAppendSeqNum.tax_dt_roof_type;
	dataset(PropertyCharacteristics.Layout_Codes.TradeMaterials)	insurbase_codes;
end;

dLNSlim2CodeFields	:=	project(dLNAppendSeqNum,rSlim2CodeFields_layout);

// Join to codesV3 and get the common codes
// File - CodesV3 
dCodesV3			:=	PropertyCharacteristics.Files.Codes.CodesV3;


// Code 1 - Air conditioning type
rSlim2CodeFields_layout	tACCommonCode(dLNSlim2CodeFields	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.air_conditioning_type				:=	if(	delimiterIndex	!=	0,
																						std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																						''
																					);
	self.src_air_conditioning_type		:=	if(self.air_conditioning_type	!=	'',le.src_air_conditioning_type,'');
	self.tax_dt_air_conditioning_type	:=	if(self.air_conditioning_type	!=	'',le.tax_dt_air_conditioning_type,'');
	self															:=	le;
end;

dACCommonCode	:=	join(	dLNSlim2CodeFields,
												dCodesV3(field_name	=	'AIR_CONDITIONING_TYPE'),
												std.str.cleanspaces(left.air_conditioning_type)			=	std.str.cleanspaces(right.code)	and
												std.str.cleanspaces(left.src_air_conditioning_type)	=	std.str.cleanspaces(right.field_name2),
												tACCommonCode(left,right),
												left outer,
												lookup
											);

// Code 2 - Basement finish
rSlim2CodeFields_layout	tBasementCommonCode(dACCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.basement_finish				:=	if(	delimiterIndex	!=	0,
																			std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																			''
																		);
	self.src_basement_finish		:=	if(self.basement_finish	!=	'',le.src_basement_finish,'');
	self.tax_dt_basement_finish	:=	if(self.basement_finish	!=	'',le.tax_dt_basement_finish,'');
	self												:=	le;
end;

dBasementCommonCode	:=	join(	dACCommonCode,
															dCodesV3(field_name	=	'BASEMENT_FINISH'),
															std.str.cleanspaces(left.basement_finish)			=	std.str.cleanspaces(right.code)	and
															std.str.cleanspaces(left.src_basement_finish)	=	std.str.cleanspaces(right.field_name2),
															tBasementCommonCode(left,right),
															left outer,
															lookup
														);

// Code 3 - Construction type
rSlim2CodeFields_layout	tConstTypeCommonCode(dBasementCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.construction_type				:=	if(	delimiterIndex	!=	0,
																				std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																				''
																			);
	self.src_construction_type		:=	if(self.construction_type	!=	'',le.src_construction_type,'');
	self.tax_dt_construction_type	:=	if(self.construction_type	!=	'',le.tax_dt_construction_type,'');
	self													:=	le;
end;

dConstTypeCommonCode	:=	join(	dBasementCommonCode,
																dCodesV3(field_name	=	'CONSTRUCTION_TYPE'),
																std.str.cleanspaces(left.construction_type)			=	std.str.cleanspaces(right.code)	and
																std.str.cleanspaces(left.src_construction_type)	=	std.str.cleanspaces(right.field_name2),
																tConstTypeCommonCode(left,right),
																left outer,
																lookup
															);

// Code 4 - Exterior walls
rSlim2CodeFields_layout	tExtWallCommonCode(dConstTypeCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.exterior_wall				:=	if(	delimiterIndex	!=	0,
																		std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																		''
																	);
	self.src_exterior_wall		:=	if(self.exterior_wall	!=	'',le.src_exterior_wall,'');
	self.tax_dt_exterior_wall	:=	if(self.exterior_wall	!=	'',le.tax_dt_exterior_wall,'');
	self											:=	le;
end;

dExtWallCommonCode	:=	join(	dConstTypeCommonCode,
															dCodesV3(field_name	=	'EXTERIOR_WALL'),
															std.str.cleanspaces(left.exterior_wall)			=	std.str.cleanspaces(right.code)	and
															std.str.cleanspaces(left.src_exterior_wall)	=	std.str.cleanspaces(right.field_name2),
															tExtWallCommonCode(left,right),
															left outer,
															lookup
														);

// Code 5 - Fireplace type
rSlim2CodeFields_layout	tFireplaceCommonCode(dExtWallCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.fireplace_type					:=	if(	delimiterIndex	!=	0,
																			std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																			''
																		);
	self.src_fireplace_type			:=	if(self.fireplace_type	!=	'',le.src_fireplace_type,'');
	self.tax_dt_fireplace_type	:=	if(self.fireplace_type	!=	'',le.tax_dt_fireplace_type,'');
	self												:=	le;
end;

dFireplaceCommonCode	:=	join(	dExtWallCommonCode,
																dCodesV3(field_name	=	'FIREPLACE_TYPE'),
																std.str.cleanspaces(left.fireplace_type)			=	std.str.cleanspaces(right.code)	and
																std.str.cleanspaces(left.src_fireplace_type)	=	std.str.cleanspaces(right.field_name2),
																tFireplaceCommonCode(left,right),
																left outer,
																lookup
															);

// Code 6 - Floor type
rSlim2CodeFields_layout	tFloorCommonCode(dFireplaceCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.floor_type					:=	if(	delimiterIndex	!=	0,
																	std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																	''
																);
	self.src_floor_type			:=	if(self.floor_type	!=	'',le.src_floor_type,'');
	self.tax_dt_floor_type	:=	if(self.floor_type	!=	'',le.tax_dt_floor_type,'');
	self										:=	le;
end;

dFloorCommonCode	:=	join(	dFireplaceCommonCode,
														dCodesV3(field_name	=	'FLOOR_COVER'),
														std.str.cleanspaces(left.floor_type)			=	std.str.cleanspaces(right.code)	and
														std.str.cleanspaces(left.src_floor_type)	=	std.str.cleanspaces(right.field_name2),
														tFloorCommonCode(left,right),
														left outer,
														lookup
													);

// Code 7 - Foundation type
rSlim2CodeFields_layout	tFoundationCommonCode(dFloorCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.foundation					:=	if(	delimiterIndex	!=	0,
																	std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																	''
																);
	self.src_foundation			:=	if(self.foundation	!=	'',le.src_foundation,'');
	self.tax_dt_foundation	:=	if(self.foundation	!=	'',le.tax_dt_foundation,'');
	self										:=	le;
end;

dFoundationCommonCode	:=	join(	dFloorCommonCode,
																dCodesV3(field_name	=	'FOUNDATION_TYPE'),
																std.str.cleanspaces(left.foundation)			=	std.str.cleanspaces(right.code)	and
																std.str.cleanspaces(left.src_foundation)	=	std.str.cleanspaces(right.field_name2),
																tFoundationCommonCode(left,right),
																left outer,
																lookup
															);

// Code 8 - Fuel type
rSlim2CodeFields_layout	tFuelCommonCode(dFoundationCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.fuel_type				:=	if(	delimiterIndex	!=	0,
																std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																''
															);
	self.src_fuel_type		:=	if(self.fuel_type	!=	'',le.src_fuel_type,'');
	self.tax_dt_fuel_type	:=	if(self.fuel_type	!=	'',le.tax_dt_fuel_type,'');
	self									:=	le;
end;

dFuelCommonCode	:=	join(	dFoundationCommonCode,
													dCodesV3(field_name	=	'FUEL_TYPE'),
													std.str.cleanspaces(left.fuel_type)			=	std.str.cleanspaces(right.code)	and
													std.str.cleanspaces(left.src_fuel_type)	=	std.str.cleanspaces(right.field_name2),
													tFuelCommonCode(left,right),
													left outer,
													lookup
												);

// Code 9 - Garage type
rSlim2CodeFields_layout	tGarageCommonCode(dFuelCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.garage					:=	if(	delimiterIndex	!=	0,
															std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
															''
														);
	self.src_garage			:=	if(self.garage	!=	'',le.src_garage,'');
	self.tax_dt_garage	:=	if(self.garage	!=	'',le.tax_dt_garage,'');
	self								:=	le;
end;

dGarageCommonCode	:=	join(	dFuelCommonCode,
														dCodesV3(field_name	=	'GARAGE_TYPE'),
														std.str.cleanspaces(left.garage)			=	std.str.cleanspaces(right.code)	and
														std.str.cleanspaces(left.src_garage)	=	std.str.cleanspaces(right.field_name2),
														tGarageCommonCode(left,right),
														left outer,
														lookup
													);

// Code 10 - Heating type
rSlim2CodeFields_layout	tHeatingCommonCode(dGarageCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.heating				:=	if(	delimiterIndex	!=	0,
															std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
															''
														);
	self.src_heating		:=	if(self.heating	!=	'',le.src_heating,'');
	self.tax_dt_heating	:=	if(self.heating	!=	'',le.tax_dt_heating,'');
	self								:=	le;
end;

dHeatingCommonCode	:=	join(	dGarageCommonCode,
															dCodesV3(field_name	=	'HEATING_TYPE'),
															std.str.cleanspaces(left.heating)			=	std.str.cleanspaces(right.code)	and
															std.str.cleanspaces(left.src_heating)	=	std.str.cleanspaces(right.field_name2),
															tHeatingCommonCode(left,right),
															left outer,
															lookup
														);

// Code 11 - Parking type
rSlim2CodeFields_layout	tParkingCommonCode(dHeatingCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.parking_type					:=	if(	delimiterIndex	!=	0,
																		std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																		''
																	);
	self.src_parking_type			:=	if(self.parking_type	!=	'',le.src_parking_type,'');
	self.tax_dt_parking_type	:=	if(self.parking_type	!=	'',le.tax_dt_parking_type,'');
	self											:=	le;
end;

dParkingCommonCode	:=	join(	dHeatingCommonCode,
															dCodesV3(field_name	=	'PARKING_TYPE'),
															std.str.cleanspaces(left.parking_type)			=	std.str.cleanspaces(right.code)	and
															std.str.cleanspaces(left.src_parking_type)	=	std.str.cleanspaces(right.field_name2),
															tParkingCommonCode(left,right),
															left outer,
															lookup
														);

// Code 12 - Pool type
rSlim2CodeFields_layout	tPoolCommonCode(dParkingCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.pool_type				:=	if(	delimiterIndex	!=	0,
																std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																''
															);
	self.src_pool_type		:=	if(self.pool_type	!=	'',le.src_pool_type,'');
	self.tax_dt_pool_type	:=	if(self.pool_type	!=	'',le.tax_dt_pool_type,'');
	self									:=	le;
end;

dPoolCommonCode	:=	join(	dParkingCommonCode,
													dCodesV3(field_name	=	'POOL_TYPE'),
													std.str.cleanspaces(left.pool_type)			=	std.str.cleanspaces(right.code)	and
													std.str.cleanspaces(left.src_pool_type)	=	std.str.cleanspaces(right.field_name2),
													tPoolCommonCode(left,right),
													left outer,
													lookup
												);

// Code 13 - Roof cover type
rSlim2CodeFields_layout	tRoofCommonCode(dPoolCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.roof_cover					:=	if(	delimiterIndex	!=	0,
																	std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																	''
																);
	self.src_roof_cover			:=	if(self.roof_cover	!=	'',le.src_roof_cover,'');
	self.tax_dt_roof_cover	:=	if(self.roof_cover	!=	'',le.tax_dt_roof_cover,'');
	self										:=	le;
end;

dRoofCommonCode	:=	join(	dPoolCommonCode,
													dCodesV3(field_name	=	'ROOF_COVER_TYPE'),
													std.str.cleanspaces(left.roof_cover)			=	std.str.cleanspaces(right.code)	and
													std.str.cleanspaces(left.src_roof_cover)	=	std.str.cleanspaces(right.field_name2),
													tRoofCommonCode(left,right),
													left outer,
													lookup
												);

// Code 14 - Sewer type
rSlim2CodeFields_layout	tSewerCommonCode(dRoofCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.sewer				:=	if(	delimiterIndex	!=	0,
														std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
														''
													);
	self.src_sewer		:=	if(self.sewer	!=	'',le.src_sewer,'');
	self.tax_dt_sewer	:=	if(self.sewer	!=	'',le.tax_dt_sewer,'');
	self							:=	le;
end;

dSewerCommonCode	:=	join(	dRoofCommonCode,
														dCodesV3(field_name	=	'SEWER_TYPE'),
														std.str.cleanspaces(left.sewer)			=	std.str.cleanspaces(right.code)	and
														std.str.cleanspaces(left.src_sewer)	=	std.str.cleanspaces(right.field_name2),
														tSewerCommonCode(left,right),
														left outer,
														lookup
													);

// Code 15 - Style type
rSlim2CodeFields_layout	tStyleCommonCode(dSewerCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.style_type					:=	if(	delimiterIndex	!=	0,
																	std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																	''
																);
	self.src_style_type			:=	if(self.style_type	!=	'',le.src_style_type,'');
	self.tax_dt_style_type	:=	if(self.style_type	!=	'',le.tax_dt_style_type,'');
	self										:=	le;
end;

dStyleCommonCode	:=	join(	dSewerCommonCode,
														dCodesV3(field_name	=	'STYLE_TYPE'),
														std.str.cleanspaces(left.style_type)			=	std.str.cleanspaces(right.code)	and
														std.str.cleanspaces(left.src_style_type)	=	std.str.cleanspaces(right.field_name2),
														tStyleCommonCode(left,right),
														left outer,
														lookup
													);

// Code 16 - Water type
rSlim2CodeFields_layout	tWaterCommonCode(dStyleCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.water				:=	if(	delimiterIndex	!=	0,
														std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
														''
													);
	self.src_water		:=	if(self.water	!=	'',le.src_water,'');
	self.tax_dt_water	:=	if(self.water	!=	'',le.tax_dt_water,'');
	self							:=	le;
end;

dWaterCommonCode	:=	join(	dStyleCommonCode,
														dCodesV3(field_name	=	'WATER_TYPE'),
														std.str.cleanspaces(left.water)			=	std.str.cleanspaces(right.code)	and
														std.str.cleanspaces(left.src_water)	=	std.str.cleanspaces(right.field_name2),
														tWaterCommonCode(left,right),
														left outer,
														lookup
													);

// Code 17 - Frame type
rSlim2CodeFields_layout	tFrameCommonCode(dWaterCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.frame_type					:=	if(	delimiterIndex	!=	0,
																	std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																	''
																);
	self.src_frame_type			:=	if(self.frame_type	!=	'',le.src_frame_type,'');
	self.tax_dt_frame_type	:=	if(self.frame_type	!=	'',le.tax_dt_frame_type,'');
	self										:=	le;
end;

dFrameCommonCode	:=	join(	dWaterCommonCode,
														dCodesV3(field_name	=	'FRAME'),
														std.str.cleanspaces(left.frame_type)			=	std.str.cleanspaces(right.code)	and
														std.str.cleanspaces(left.src_frame_type)	=	std.str.cleanspaces(right.field_name2),
														tFrameCommonCode(left,right),
														left outer,
														lookup
													);

// Code 18 - Land Use Code
rSlim2CodeFields_layout	tLandUseCommonCode(dFrameCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.land_use_code				:=	if(	delimiterIndex	!=	0,
																		std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																		''
																	);
	self.src_land_use_code		:=	if(self.land_use_code	!=	'',le.src_land_use_code,'');
	self.tax_dt_land_use_code	:=	if(self.land_use_code	!=	'',le.tax_dt_land_use_code,'');
	self											:=	le;
end;

dLandUseCommonCode	:=	join(	dFrameCommonCode,
															dCodesV3(field_name	=	'LAND_USE_CODE'),
															std.str.cleanspaces(left.land_use_code)			=	std.str.cleanspaces(right.code)	and
															std.str.cleanspaces(left.src_land_use_code)	=	std.str.cleanspaces(right.field_name2),
															tLandUseCommonCode(left,right),
															left outer,
															lookup
														);

// Code 19 - Location Influence
rSlim2CodeFields_layout	tLocInfluenceCommonCode(dLandUseCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.location_influence_code				:=	if(	delimiterIndex	!=	0,
																							std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																							''
																						);
	self.src_location_influence_code		:=	if(self.location_influence_code	!=	'',le.src_location_influence_code,'');
	self.tax_dt_location_influence_code	:=	if(self.location_influence_code	!=	'',le.tax_dt_location_influence_code,'');
	self																:=	le;
end;

dLocInfluenceCommonCode	:=	join(	dLandUseCommonCode,
																	dCodesV3(field_name	=	'LOCATION_INFLUENCE'),
																	std.str.cleanspaces(left.location_influence_code)			=	std.str.cleanspaces(right.code)	and
																	std.str.cleanspaces(left.src_location_influence_code)	=	std.str.cleanspaces(right.field_name2),
																	tLocInfluenceCommonCode(left,right),
																	left outer,
																	lookup
																);

// Code 20 - Property Indicator
rSlim2CodeFields_layout	tPropertyTypeCommonCode(dLocInfluenceCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.property_type_code					:=	if(	delimiterIndex	!=	0,
																					std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																					''
																				);
	self.src_property_type_code			:=	if(self.property_type_code	!=	'',le.src_property_type_code,'');
	self.tax_dt_property_type_code	:=	if(self.property_type_code	!=	'',le.tax_dt_property_type_code,'');
	self														:=	le;
end;

dPropTypeCommonCode	:=	join(	dLocInfluenceCommonCode,
															dCodesV3(field_name	=	'PROPERTY_IND'),
															std.str.cleanspaces(left.property_type_code)			=	std.str.cleanspaces(right.code)	and
															std.str.cleanspaces(left.src_property_type_code)	=	std.str.cleanspaces(right.field_name2),
															tPropertyTypeCommonCode(left,right),
															left outer,
															lookup
														);

// Code 21 - Quality
rSlim2CodeFields_layout	tQaulityCommonCode(dPropTypeCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.structure_quality				:=	if(	delimiterIndex	!=	0,
																				std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																				''
																			);
	self.src_structure_quality		:=	if(self.structure_quality	!=	'',le.src_structure_quality,'');
	self.tax_dt_structure_quality	:=	if(self.structure_quality	!=	'',le.tax_dt_structure_quality,'');
	self													:=	le;
end;

dQualityCommonCode	:=	join(	dPropTypeCommonCode,
															dCodesV3(field_name	=	'QUALITY'),
															std.str.cleanspaces(left.structure_quality)			=	std.str.cleanspaces(right.code)	and
															std.str.cleanspaces(left.src_structure_quality)	=	std.str.cleanspaces(right.field_name2),
															tQaulityCommonCode(left,right),
															left outer,
															lookup
														);

// Code 22 - Interest Rate Type Code
rSlim2CodeFields_layout	tIntRateTypeCommonCode(dQualityCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.interest_rate_type_code				:=	if(	delimiterIndex	!=	0,
																							std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																							''
																						);
	self.src_interest_rate_type_code		:=	if(self.interest_rate_type_code	!=	'',le.src_interest_rate_type_code,'');
	self.rec_dt_interest_rate_type_code	:=	if(self.interest_rate_type_code	!=	'',le.rec_dt_interest_rate_type_code,'');
	self																:=	le;
end;

dIntRateTypeCommonCode	:=	join(	dQualityCommonCode,
																	dCodesV3(field_name	=	'TYPE_FINANCING'),
																	std.str.cleanspaces(left.interest_rate_type_code)			=	std.str.cleanspaces(right.code)	and
																	std.str.cleanspaces(left.src_interest_rate_type_code)	=	std.str.cleanspaces(right.field_name2),
																	tIntRateTypeCommonCode(left,right),
																	left outer,
																	lookup
																);

// Code 23 - Loan type
rSlim2CodeFields_layout	tLoanTypeCommonCode(dIntRateTypeCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.loan_type_code					:=	if(	delimiterIndex	!=	0,
																			std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																			''
																		);
	self.src_loan_type_code			:=	if(self.loan_type_code	!=	'',le.src_loan_type_code,'');
	self.rec_dt_loan_type_code	:=	if(self.loan_type_code	!=	'',le.rec_dt_loan_type_code,'');
	self												:=	le;
end;

dLoanTypeCommonCode	:=	join(	dIntRateTypeCommonCode,
															dCodesV3(field_name	=	'MORTGAGE_LOAN_TYPE_CODE'),
															std.str.cleanspaces(left.loan_type_code)			=	std.str.cleanspaces(right.code)	and
															std.str.cleanspaces(left.src_loan_type_code)	=	std.str.cleanspaces(right.field_name2),
															tLoanTypeCommonCode(left,right),
															left outer,
															lookup
														);

// Code 24 - Sale Code
rSlim2CodeFields_layout	tSaleCommonCode(dLoanTypeCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.sale_type_code					:=	if(	delimiterIndex	!=	0,
																			std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																			''
																		);
	self.src_sale_type_code			:=	if(self.sale_type_code	!=	'',le.src_sale_type_code,'');
	self.rec_dt_sale_type_code	:=	if(self.sale_type_code	!=	'',le.rec_dt_sale_type_code,'');
	self												:=	le;
end;

dSaleTypeCommonCode	:=	join(	dLoanTypeCommonCode,
															dCodesV3(field_name	=	'SALE_TRANS_CODE'),
															std.str.cleanspaces(left.sale_type_code)			=	std.str.cleanspaces(right.code)	and
															std.str.cleanspaces(left.src_sale_type_code)	=	std.str.cleanspaces(right.field_name2),
															tSaleCommonCode(left,right),
															left outer,
															lookup
														);

// Code 25 - Full Part Sale
rSlim2CodeFields_layout	tFullPartSaleCommonCode(dSaleTypeCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.full_part_sale					:=	if(	delimiterIndex	!=	0,
																			std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																			''
																		);
	self.src_full_part_sale			:=	if(self.full_part_sale	!=	'',le.src_full_part_sale,'');
	self.rec_dt_full_part_sale	:=	if(self.full_part_sale	!=	'',le.rec_dt_full_part_sale,'');
	self												:=	le;
end;

dFullPartSaleCommonCode	:=	join(	dSaleTypeCommonCode,
																	dCodesV3(field_name	=	'SALE_CODE'),
																	std.str.cleanspaces(left.full_part_sale)			=	std.str.cleanspaces(right.code)	and
																	std.str.cleanspaces(left.src_full_part_sale)	=	std.str.cleanspaces(right.field_name2),
																	tFullPartSaleCommonCode(left,right),
																	left outer,
																	lookup
																);

// Code 26 - Stories type
rSlim2CodeFields_layout	tStoriesCommonCode(dFullPartSaleCommonCode	le,dCodesV3	ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.stories_type					:=	if(	delimiterIndex	!=	0,
																		std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																		''
																	);
	self.src_stories_type			:=	if(self.stories_type	!=	'',le.src_stories_type,'');
	self.tax_dt_stories_type	:=	if(self.stories_type	!=	'',le.tax_dt_stories_type,'');
	self											:=	le;
end;

dStoriesCommonCode	:=	join(	dFullPartSaleCommonCode,
															dCodesV3(field_name	=	'STORIES_TYPE'),
															std.str.cleanspaces(left.stories_type)			=	std.str.cleanspaces(right.code)	and
															std.str.cleanspaces(left.src_stories_type)	=	std.str.cleanspaces(right.field_name2),
															tStoriesCommonCode(left,right),
															left outer,
															lookup
														);


// Populate the "no_of_stories" field from "stories_type" code if it's null
// Bug 142040- Discontine Defaulting to half_stories
rSlim2CodeFields_layout	tPopulateStories(dStoriesCommonCode	pInput)	:=
transform
	string	tmpNoStories	:=	if(pInput.stories_type != '' and regexfind('^\\d*\\.?\\d\\*$', trim(pInput.stories_type)), pInput.stories_type,'');
	
	self.no_of_stories				:=	if(	pInput.no_of_stories	in	['','0'],
																		if(tmpNoStories	!=	'',tmpNoStories,''),
																		PropertyCharacteristics.Functions.fn_remove_zeroes(pInput.no_of_stories)
																	);
	self.src_no_of_stories		:=	if(pInput.no_of_stories	in	['','0'] and tmpNoStories != '',pInput.src_stories_type,
																		if(self.no_of_stories	!=	'',pInput.src_no_of_stories,
																				''));
	self.tax_dt_no_of_stories	:=	if(pInput.no_of_stories	in	['','0'] and tmpNoStories != '',pInput.tax_dt_stories_type,
																		if(self.no_of_stories	!=	'',pInput.tax_dt_no_of_stories,
																			''));
	self											:=	pInput;
end;

dNoOfStories	:=	project(dStoriesCommonCode,tPopulateStories(left));



// Populate the "Garage_Type" field from "GASF" or "Parking_Type code if it's null-- Bug 108094
rSlim2CodeFields_layout	tPopulateGarage(dNoOfStories	pInput)	:=
transform
//Translation do not exist if converted to Garage_Type
	set_Parking_excluded := ['BS1','CIB','GAS','SG1','SG2','SG3','AMN','DSC','BR1','BR2','BR3','BR4','CG1','CG2','CG3',
													 'FR1','FR2','FR3','FR4','UDA','ADP','ASP','CAP','CUP','CVC','DEP','DGP','GAP','OAP','OFP',
													 'ONP','OOP','OSP','OTP','OUP','PAP','ROP','SBP','SCP','UNP','VNL'
													 ];
	string vGarage := 	if(pInput.garage = '',
														map(pInput.src_garage_square_footage = 'FARES' and pInput.garage_square_footage != '' and (integer)pInput.garage_square_footage	< 200		=>	'AT1',
																pInput.src_garage_square_footage = 'FARES' and (integer)pInput.garage_square_footage	between	201	and	400														=>	'AT2',
																pInput.src_garage_square_footage = 'FARES' and (integer)pInput.garage_square_footage	> 400																					=>	'AT3',
																pInput.src_garage_square_footage = 'OKCTY' and pInput.garage_square_footage != '' 																									=>  'GAR', 
														''),
																	'');
	string vGarageDefault	:= if(trim(pInput.garage) = '' and trim(pInput.parking_type) != '' 
																and pInput.parking_type not in set_parking_excluded,
																		pInput.parking_type,
																		'');
  convertParkingType		:= case(vGarageDefault,
																'DT0' => 'DGC',
																'PFG' => 'PRF',
																'MNG' => 'MNC',
																'MWG' => 'MWO',
																'SBG' => 'SLT',
																'SEG' => 'STE',
																'SG0' => 'SGO',
																'STG' => 'STU',
																'WOG' => 'WOO',
																'ATG' => 'AT0',
																'AUG' => 'AUF',
																'DFG' => 'DFN',
																'UDG' => 'UFD',
																'GCL' => 'ECL',
																'PMG' => 'PML',
																'MBG' => 'MBF',
																'CNG' => 'CRE',
																'CG0' => 'CNB',
																'UAF' => 'AAF',
																'FNG' => 'FNC',
																'DTG' => 'DT0',
																'FR0' => 'FRC',
																'MTG' => 'MTL',
																'DP0' => 'DTC',
																'UP0' => 'UF0',
																'CNB' => 'CNC',
																'DP1' => 'DT1',
																'DP2' => 'DT2',	vGarageDefault);
	
	self.garage				:=	if(pInput.garage != '', ut.CleanSpacesAndUpper(pInput.garage),
																	if(vGarage != '',vGarage,
																			if(convertParkingType != '', convertParkingType,
																			'')));
	self.src_garage		:=	if(pInput.garage	!=	'',pInput.src_garage,
													if(vGarage != '',pInput.src_garage_square_footage,
														if(vGarageDefault != '', pInput.src_parking_type,
																			'')));
	self.tax_dt_garage	:=	if(pInput.garage	!=	'',pInput.tax_dt_garage,
															if(vGarage != '',pInput.tax_dt_garage_square_footage,
																	if(vGarageDefault != '', pInput.tax_dt_parking_type,		
																		'')));
	self											:=	pInput;
end;

dGarageConvert	:=	project(dNoOfStories,tPopulateGarage(left));

// Populate the "no_of_fireplaces" field from "fireplace_ind" -- Bug 108962
// Populate the "no_of_baths" field from "no_of_full_bath" & "no_of_half_bath" with the same source -- Bug 146154
rSlim2CodeFields_layout	tPopulateFireplace_Bath(dGarageConvert	pInput)	:=
transform
  self.no_of_units					:= if(regexfind('[A-Za-z\\-]',trim(pInput.no_of_units)),'',pInput.no_of_units);
	self.src_no_of_units			:= if(regexfind('[A-Za-z\\-]',trim(pInput.no_of_units)),'',pInput.src_no_of_units);
	self.tax_dt_no_of_units		:= if(regexfind('[A-Za-z\\-]',trim(pInput.no_of_units)),'',pInput.tax_dt_no_of_units);
  
	string vNo_of_fireplace := if(pInput.fireplace_ind = 'Y' and trim(pInput.no_of_fireplaces) = '', '1',
																if(pInput.fireplace_ind = 'N' and trim(pInput.no_of_fireplaces) = '','0',
																		''));
	
	self.no_of_fireplaces			:= if(vNo_of_fireplace != '',vNo_of_fireplace, pInput.no_of_fireplaces);
	self.src_no_of_fireplaces := if(vNo_of_fireplace != '',pInput.src_fireplace_ind,
																	if(self.no_of_fireplaces != '', pInput.src_no_of_fireplaces,
																			''));
  self.tax_dt_no_of_fireplaces :=  if(vNo_of_fireplace != '',pInput.tax_dt_fireplace_ind,
																			if(self.no_of_fireplaces != '', pInput.tax_dt_no_of_fireplaces,
																					''));																				
	
	real vTotalBaths	:= (real)pInput.no_of_full_baths + ((real)pInput.no_of_half_baths * 0.50);
	string8 str_vTotalBaths := realformat(vTotalBaths,8,2);
	self.no_of_baths				:= if(pInput.src_no_of_full_baths = 'FARES' and pInput.src_no_of_half_baths = 'FARES',
																	str_vTotalBaths,
																if(pInput.src_no_of_full_baths = 'OKCTY' and pInput.src_no_of_half_baths = 'OKCTY',
																		str_vTotalBaths,
																					pInput.no_of_baths));	
	
	self.src_no_of_baths		:=	if(vTotalBaths != 0 and pInput.src_no_of_full_baths = 'FARES' and pInput.src_no_of_half_baths = 'FARES',
																			pInput.src_no_of_full_baths,
																		if(vTotalBaths != 0 and pInput.src_no_of_full_baths = 'OKCTY' and pInput.src_no_of_half_baths = 'OKCTY',
																						pInput.src_no_of_full_baths,
																							if(self.no_of_baths != '', pInput.src_no_of_baths,
																									'')));
																			
	// self.tax_dt_no_of_baths	:=	if(self.src_no_of_baths != '', pInput.tax_dt_no_of_baths,'');
	self											:=	pInput;
end;

dFireplaceBathConvert	:=	project(dGarageConvert,tPopulateFireplace_Bath(left));

//DF-18255
// Code 27 - Roof type
rSlim2CodeFields_layout	tRoofTypeCommonCode(dFireplaceBathConvert	le, dCodesV3 ri)	:=
transform
	unsigned	delimiterIndex	:=	stringlib.stringfind(ri.long_desc,'|',1);
	
	self.roof_type					:=	if(	delimiterIndex	!=	0,
																		std.str.cleanspaces(ri.long_desc[1..delimiterIndex-1]),
																		''
																	);
	self.src_roof_type			:=	if(self.roof_type	!=	'',le.src_roof_type,'');
	self.tax_dt_roof_type		:=	if(self.roof_type	!=	'',le.tax_dt_roof_type,'');
	self										:=	le;
end;

dRoofTypeCommonCode	:=	join(	dFireplaceBathConvert,
													dCodesV3(field_name	=	'ROOF_TYPE'),
													std.str.cleanspaces(left.roof_type)			=	std.str.cleanspaces(right.code)	and
													std.str.cleanspaces(left.src_roof_type)	= std.str.cleanspaces(right.field_name2),
													tRoofTypeCommonCode(left,right),
													left outer,
													lookup
												);

dLNStandardizedCodes	:=	dRoofTypeCommonCode;


// Populate insurbase codes
// Bug 31814- Remove Insurbase Codes
// PropertyCharacteristics.Get_IB_Common_Codes.Mac_Get_IBCode(dLNStandardizedCodes,'LN',dLNInsurbaseCode);

// Bring back to the original base layout
PropertyCharacteristics.Layouts.TempBase	tReformat2Base(dLNAppendSeqNum	le,dLNStandardizedCodes	ri)	:=
transform
	self.property_rid	:=	le.property_rid;
	self							:=	ri;
	self							:=	le;
end;

dLNReformat2Base	:=	join(	distribute(dLNAppendSeqNum,property_rid),
														distribute(dLNStandardizedCodes,property_rid),
														left.property_rid	=	right.property_rid,
														tReformat2Base(left,right),
														local
													);

export	LNProperty2Base	:=	dLNReformat2Base	:	persist('~thor_data400::persist::propertyinfo::lnproperty2base_v2');
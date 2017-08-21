import	codes,ut, PropertyCharacteristics;
#OPTION('multiplePersistInstances',FALSE);

export	map_property_codes(dataset(recordof(PropertyCharacteristics.Layouts.Base)) in_property) := function


// Append sequence number
ut.MAC_Sequence_Records(in_property ,property_rid,dLNAppendSeqNum);

// Slim down the layout to keep only fields which have codes
rSlim2CodeFields_layout	:=
record
	dLNAppendSeqNum.property_rid;
	dLNAppendSeqNum.air_conditioning_type;
	dLNAppendSeqNum.heating;
	dLNAppendSeqNum.fuel_type;
	dLNAppendSeqNum.exterior_wall;
	dLNAppendSeqNum.construction_type;
	dLNAppendSeqNum.floor_type;
	dLNAppendSeqNum.roof_cover;
	dLNAppendSeqNum.foundation;
	dLNAppendSeqNum.garage;
	dLNAppendSeqNum.basement_finish;
	dLNAppendSeqNum.sewer;
	dLNAppendSeqNum.water;
	dLNAppendSeqNum.pool_type;
	dLNAppendSeqNum.style_type;
	
	string3 cnvrt_air_conditioning_type := '';
	string3 cnvrt_heating 							:= '';
	string3 cnvrt_fuel_type             := '';
	string3 cnvrt_exterior_wall					:= '';
	string3 cnvrt_construction_type			:= '';
	string3 cnvrt_floor_type						:= '';
	string3 cnvrt_roof_cover						:= '';
	string3 cnvrt_foundation						:= '';
	string3 cnvrt_garage								:= '';
	string3 cnvrt_basement_finish				:= '';
	string3 cnvrt_sewer									:= '';
	string3 cnvrt_water									:= '';
	string3 cnvrt_pool_type							:= '';
	string3 cnvrt_style_type						:= '';
end;

dLNSlim2CodeFields	:=	project(dLNAppendSeqNum,rSlim2CodeFields_layout);

// Join to codesV3 and get the common codes
// File - CodesV3
dCodesLA	:=	PropertyFieldFillInByLA2.in_file_codes;

// Code 1 - Air conditioning type
rSlim2CodeFields_layout	tACCommonCode(dLNSlim2CodeFields	le, dCodesLA	ri)	:=
transform
	// self.air_conditioning_type				:= le.air_conditioning_type	
	self.cnvrt_air_conditioning_type	:= ri.loc_avg;
	self :=	le;
	self := [];
end;

dACCommonCode	:=	join(	dLNSlim2CodeFields,	dCodesLA(field_name	=	'AIR_CONDITIONING_TYPE'),
												stringlib.stringcleanspaces(left.air_conditioning_type)			=	stringlib.stringcleanspaces(right.code_2),	
												tACCommonCode(left,right),
												left outer,
												lookup
											);

// Code 2 - Basement finish
rSlim2CodeFields_layout	tBasementCommonCode(dACCommonCode	le, dCodesLA	ri)	:=
transform
	self.cnvrt_basement_finish	:=	ri.loc_avg;
	self												:=	le;
	self := [];
end;

dBasementCommonCode	:=	join(	dACCommonCode, dCodesLA(field_name	=	'BASEMENT_FINISH'),
															stringlib.stringcleanspaces(left.basement_finish)			=	stringlib.stringcleanspaces(right.code_2),
															tBasementCommonCode(left,right),
															left outer,
															lookup
														);

// Code 3 - Construction type
rSlim2CodeFields_layout	tConstTypeCommonCode(dBasementCommonCode	le, dCodesLA	ri)	:=
transform
	self.cnvrt_construction_type		:=	ri.loc_avg;
	self													:=	le;
	self := [];
end;

dConstTypeCommonCode	:=	join(	dBasementCommonCode, 	dCodesLA(field_name	=	'CONSTRUCTION_TYPE'),
																stringlib.stringcleanspaces(left.construction_type)			=	stringlib.stringcleanspaces(right.code_2),
																tConstTypeCommonCode(left,right),
																left outer,
																lookup
															);

// Code 4 - Exterior walls
rSlim2CodeFields_layout	tExtWallCommonCode(dConstTypeCommonCode	le, dCodesLA	ri)	:=
transform
	
	self.cnvrt_exterior_wall	:=	ri.loc_avg;
	self											:=	le;
	self := [];
end;

dExtWallCommonCode	:=	join(	dConstTypeCommonCode,	dCodesLA(field_name	=	'EXTERIOR_WALL'),
															stringlib.stringcleanspaces(left.exterior_wall)			=	stringlib.stringcleanspaces(right.code_2),	
															tExtWallCommonCode(left,right),
															left outer,
															lookup
														);

// Code 5 - Floor type
rSlim2CodeFields_layout	tFloorCommonCode(dExtWallCommonCode	le, dCodesLA	ri)	:=
transform
	self.cnvrt_floor_type		:=	ri.loc_avg;
	self										:=	le;
	self := [];
end;

dFloorCommonCode	:=	join(	dExtWallCommonCode,	dCodesLA(field_name	=	'FLOOR_COVER'),
														stringlib.stringcleanspaces(left.floor_type)			=	stringlib.stringcleanspaces(right.code_2),
														tFloorCommonCode(left,right),
														left outer,
														lookup
													);

// Code 6 - Foundation type
rSlim2CodeFields_layout	tFoundationCommonCode(dFloorCommonCode	le,dCodesLA	ri)	:=
transform
	
	self.cnvrt_foundation		:=	ri.loc_avg;
	self										:=	le;
	self := [];
end;

dFoundationCommonCode	:=	join(	dFloorCommonCode, dCodesLA(field_name	=	'FOUNDATION_TYPE'),
																stringlib.stringcleanspaces(left.foundation)			=	stringlib.stringcleanspaces(right.code_2),
																tFoundationCommonCode(left,right),
																left outer,
																lookup
															);

// Code 7 - Fuel type
rSlim2CodeFields_layout	tFuelCommonCode(dFoundationCommonCode	le,dCodesLA	ri)	:=
transform
	self.cnvrt_fuel_type	:=	ri.loc_avg;
	self									:=	le;
	self := [];
end;

dFuelCommonCode	:=	join(	dFoundationCommonCode,	dCodesLA(field_name	=	'FUEL_TYPE'),
													stringlib.stringcleanspaces(left.fuel_type)			=	stringlib.stringcleanspaces(right.code_2),
													tFuelCommonCode(left,right),
													left outer,
													lookup
												);

// Code 8 - Garage type
rSlim2CodeFields_layout	tGarageCommonCode(dFuelCommonCode	le,dCodesLA	ri)	:=
transform
	self.cnvrt_garage		:=	ri.loc_avg;
	self								:=	le;
	self := [];
end;

dGarageCommonCode	:=	join(	dFuelCommonCode,dCodesLA(field_name	=	'GARAGE_TYPE'),
														stringlib.stringcleanspaces(left.garage)			=	stringlib.stringcleanspaces(right.code_2),
														tGarageCommonCode(left,right),
														left outer,
														lookup
													);

// Code 9 - Heating type
rSlim2CodeFields_layout	tHeatingCommonCode(dGarageCommonCode	le,dCodesLA	ri)	:=
transform

	self.cnvrt_heating	:=	ri.loc_avg;
	self								:=	le;
	self := [];
end;

dHeatingCommonCode	:=	join(	dGarageCommonCode, 	dCodesLA(field_name	=	'HEATING_TYPE'),
															stringlib.stringcleanspaces(left.heating)			=	stringlib.stringcleanspaces(right.code_2),
															tHeatingCommonCode(left,right),
															left outer,
															lookup
														);



// Code 10 - Pool type
rSlim2CodeFields_layout	tPoolCommonCode(dHeatingCommonCode	le,dCodesLA	ri)	:=
transform
	
	self.cnvrt_pool_type	:=	ri.loc_avg;
	self									:=	le;
	self := [];
end;

dPoolCommonCode	:=	join(	dHeatingCommonCode, dCodesLA(field_name	=	'POOL_TYPE'),
													stringlib.stringcleanspaces(left.pool_type)			=	stringlib.stringcleanspaces(right.code_2),
													tPoolCommonCode(left,right),
													left outer,
													lookup
												);

// Code 11 - Roof cover type
rSlim2CodeFields_layout	tRoofCommonCode(dPoolCommonCode	le,dCodesLA	ri)	:=
transform
	
	self.cnvrt_roof_cover		:=	ri. loc_avg;
	self										:=	le;
	self := [];
end;

dRoofCommonCode	:=	join(	dPoolCommonCode, dCodesLA(field_name	=	'ROOF_COVER_TYPE'),
													stringlib.stringcleanspaces(left.roof_cover)			=	stringlib.stringcleanspaces(right.code_2),
													tRoofCommonCode(left,right),
													left outer,
													lookup
												);

// Code 12 - Sewer type
rSlim2CodeFields_layout	tSewerCommonCode(dRoofCommonCode	le,dCodesLA	ri)	:=
transform
	self.cnvrt_sewer	:=	ri.loc_avg;
	self							:=	le;
	self := [];
end;

dSewerCommonCode	:=	join(	dRoofCommonCode, dCodesLA(field_name	=	'SEWER_TYPE'),
														stringlib.stringcleanspaces(left.sewer)			=	stringlib.stringcleanspaces(right.code_2),
														tSewerCommonCode(left,right),
														left outer,
														lookup
													);

// Code 13 - Style type
rSlim2CodeFields_layout	tStyleCommonCode(dSewerCommonCode	le,dCodesLA	ri)	:=
transform
	self.cnvrt_style_type		:=	ri.loc_avg;
	self										:=	le;
	self := [];
end;

dStyleCommonCode	:=	join(	dSewerCommonCode, dCodesLA(field_name	=	'STYLE_TYPE'),
														stringlib.stringcleanspaces(left.style_type)			=	stringlib.stringcleanspaces(right.code_2),
														tStyleCommonCode(left,right),
														left outer,
														lookup
													);

// Code 14 - Water type
rSlim2CodeFields_layout	tWaterCommonCode(dStyleCommonCode	le,dCodesLA	ri)	:=
transform
	self.cnvrt_water	:=	ri.loc_avg;
	self							:=	le;
	self := [];
end;

dWaterCommonCode	:=	join(	dStyleCommonCode, dCodesLA(field_name	=	'WATER_TYPE'),
														stringlib.stringcleanspaces(left.water)			=	stringlib.stringcleanspaces(right.code_2),
														tWaterCommonCode(left,right),
														left outer,
														lookup
													);


rLayout := RECORD
PropertyCharacteristics.Layouts.Base;
string3 cnvrt_air_conditioning_type;
string3 cnvrt_heating;
string3 cnvrt_fuel_type;
string3 cnvrt_exterior_wall;
string3 cnvrt_construction_type;
string3 cnvrt_floor_type;
string3 cnvrt_roof_cover;
string3 cnvrt_foundation;
string3 cnvrt_garage;
string3 cnvrt_basement_finish;
string3 cnvrt_sewer;
string3 cnvrt_water;
string3 cnvrt_pool_type;
string3 cnvrt_style_type;
end;

// Bring back to the original base layout
rLayout	tReformat2Base(dLNAppendSeqNum	le, dWaterCommonCode	ri)	:=
transform
	self.property_rid	:=	le.property_rid;
	self							:=	ri;
	self							:=	le;
end;

dLNReformat2Base	:=	join(	distribute(dLNAppendSeqNum,property_rid),
														distribute(dWaterCommonCode,property_rid),
														left.property_rid	=	right.property_rid,
														tReformat2Base(left,right),
														local
														) : persist('~thor_data400::persist::propertyfieldfillinByLA2::property_code_cnv');
													


return dLNReformat2Base;

end;
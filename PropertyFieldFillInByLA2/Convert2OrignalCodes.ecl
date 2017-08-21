import	ut, std;


export	Convert2OrignalCodes(dataset(recordof(PropertyFieldFillInByLA2.Layouts.layout_BaseWithAverageHedonics)) in_LocalizedAverage) := function

/*
// Append sequence number
ut.MAC_Sequence_Records(in_LocalizedAverage,seqno,dLocalizedAvgSeqNum);


// Slim down the layout to keep only fields which have codes
rSlim2CodeFields_layout	:=
record
	dLocalizedAvgSeqNum.seqno;
	dLocalizedAvgSeqNum.air_conditioning_type;
	dLocalizedAvgSeqNum.heating;
	dLocalizedAvgSeqNum.fuel_type;
	dLocalizedAvgSeqNum.exterior_walls;
	dLocalizedAvgSeqNum.construction_type;
	dLocalizedAvgSeqNum.floor_cover;
	dLocalizedAvgSeqNum.roof_cover;
	dLocalizedAvgSeqNum.foundation;
	dLocalizedAvgSeqNum.garage;
	dLocalizedAvgSeqNum.basement;
	
// Future phase	
	// in_LocalizedAverage.sewer;
	// in_LocalizedAverage.water;
	// in_LocalizedAverage.pool_type;
	// in_LocalizedAverage.style_type;
	
	string3 air_conditioning_type_code 	:= '';
	string3 heating_code								:= '';
	string3 fuel_type_code							:= '';
	string3 exterior_walls_code					:= '';
	string3 construction_type_code			:= '';
	string3 floor_cover_code						:= '';
	string3 roof_cover_code							:= '';
	string3 foundation_code							:= '';
	string3 garage_code									:= '';
	string3 basement_code								:= '';

//Future phase	
	// string3 sewer_code;
	// string3 water_code;
	// string3 pool_type_code;
	// string3 style_type_code;
end;

dLNSlim2CodeFields	:=	project(dLocalizedAvgSeqNum,rSlim2CodeFields_layout);
*/

dLNSlim2CodeFields	:=	project(in_LocalizedAverage, transform(PropertyFieldFillInByLA2.Layouts.base, self := left, self := []));

// Join to codeLA and get conversion codes
dCodesLA	:=	PropertyFieldFillInByLA2.in_file_codes;

// Code 1 - Air conditioning type
PropertyFieldFillInByLA2.Layouts.base	tACCommonCode(dLNSlim2CodeFields	le, dCodesLA	ri)	:=
transform
	// self.air_conditioning_type				:= le.air_conditioning_type	
	self.air_conditioning_type_code	:= ri.code_2;
	self :=	le;
	self := [];
end;

dACCommonCode	:=	join(	dLNSlim2CodeFields,	dCodesLA(field_name	=	'AIR_CONDITIONING_TYPE'),
												(string)left.air_conditioning_type			=	STD.Str.CleanSpaces(right.loc_avg),	
												tACCommonCode(left,right),
												left outer,
												lookup
											);

// Code 2 - Basement finish
PropertyFieldFillInByLA2.Layouts.base	tBasementCommonCode(dACCommonCode	le, dCodesLA	ri)	:=
transform
	self.basement_code	:=	ri.code_2;
	self												:=	le;
	self := [];
end;

dBasementCommonCode	:=	join(	dACCommonCode, dCodesLA(field_name	=	'BASEMENT_FINISH'),
															(string)left.basement			=	STD.Str.CleanSpaces(right.loc_avg),
															tBasementCommonCode(left,right),
															left outer,
															lookup
														);

// Code 3 - Construction type
PropertyFieldFillInByLA2.Layouts.base	tConstTypeCommonCode(dBasementCommonCode	le, dCodesLA	ri)	:=
transform
	self.construction_type_code		:=	ri.code_2;
	self													:=	le;
	self := [];
end;

dConstTypeCommonCode	:=	join(	dBasementCommonCode, 	dCodesLA(field_name	=	'CONSTRUCTION_TYPE'),
																(string)left.construction_type			=	STD.Str.CleanSpaces(right.loc_avg),
																tConstTypeCommonCode(left,right),
																left outer,
																lookup
															);

// Code 4 - Exterior walls
PropertyFieldFillInByLA2.Layouts.base	tExtWallCommonCode(dConstTypeCommonCode	le, dCodesLA	ri)	:=
transform
	
	self.exterior_walls_code		:=	ri.code_2;
	self											:=	le;
	self := [];
end;

dExtWallCommonCode	:=	join(	dConstTypeCommonCode,	dCodesLA(field_name	=	'EXTERIOR_WALL'),
															(string)left.exterior_walls			=	STD.Str.CleanSpaces(right.loc_avg),	
															tExtWallCommonCode(left,right),
															left outer,
															lookup
														);

// Code 5 - Floor type
PropertyFieldFillInByLA2.Layouts.base	tFloorCommonCode(dExtWallCommonCode	le, dCodesLA	ri)	:=
transform
	self.floor_cover_code		:=	ri.code_2;
	self										:=	le;
	self := [];
end;

dFloorCommonCode	:=	join(	dExtWallCommonCode,	dCodesLA(field_name	=	'FLOOR_COVER'),
														(string)left.floor_cover			=	STD.Str.CleanSpaces(right.loc_avg),
														tFloorCommonCode(left,right),
														left outer,
														lookup
													);

// Code 6 - Foundation type
PropertyFieldFillInByLA2.Layouts.base	tFoundationCommonCode(dFloorCommonCode	le,dCodesLA	ri)	:=
transform
	
	self.foundation_code		:=	ri.code_2;
	self										:=	le;
	self := [];
end;

dFoundationCommonCode	:=	join(	dFloorCommonCode, dCodesLA(field_name	=	'FOUNDATION_TYPE'),
																(string)left.foundation			=	STD.Str.CleanSpaces(right.loc_avg),
																tFoundationCommonCode(left,right),
																left outer,
																lookup
															);

// Code 7 - Fuel type
PropertyFieldFillInByLA2.Layouts.base	tFuelCommonCode(dFoundationCommonCode	le,dCodesLA	ri)	:=
transform
	self.fuel_type_code	:=	ri.code_2;
	self									:=	le;
	self := [];
end;

dFuelCommonCode	:=	join(	dFoundationCommonCode,	dCodesLA(field_name	=	'FUEL_TYPE'),
													(string)left.fuel_type			=	STD.Str.CleanSpaces(right.loc_avg),
													tFuelCommonCode(left,right),
													left outer,
													lookup
												);

// Code 8 - Garage type
PropertyFieldFillInByLA2.Layouts.base	tGarageCommonCode(dFuelCommonCode	le,dCodesLA	ri)	:=
transform
	self.garage_code		:=	ri.code_2;
	self								:=	le;
	self := [];
end;

dGarageCommonCode	:=	join(	dFuelCommonCode,dCodesLA(field_name	=	'GARAGE_TYPE'),
														(string)left.garage			=	STD.Str.CleanSpaces(right.loc_avg),
														tGarageCommonCode(left,right),
														left outer,
														lookup
													);

// Code 9 - Heating type
PropertyFieldFillInByLA2.Layouts.base	tHeatingCommonCode(dGarageCommonCode	le,dCodesLA	ri)	:=
transform

	self.heating_code	:=	ri.code_2;
	self								:=	le;
	self := [];
end;

dHeatingCommonCode	:=	join(	dGarageCommonCode, 	dCodesLA(field_name	=	'HEATING_TYPE'),
															(string)left.heating			=	STD.Str.CleanSpaces(right.loc_avg),
															tHeatingCommonCode(left,right),
															left outer,
															lookup
														);


// Code 10 - Roof cover type
PropertyFieldFillInByLA2.Layouts.base	tRoofCommonCode(dHeatingCommonCode	le,dCodesLA	ri)	:=
transform
	
	self.roof_cover_code		:=	ri.code_2;
	self										:=	le;
	self := [];
end;

dRoofCommonCode	:=	join(	dHeatingCommonCode, dCodesLA(field_name	=	'ROOF_COVER_TYPE'),
													(string)left.roof_cover			=	STD.Str.CleanSpaces(right.loc_avg),
													tRoofCommonCode(left,right),
													left outer,
													lookup
												);

output(dRoofCommonCode	,,'~thor_data400::temp::propertyfieldfillinbyla2::Reformat_Base',overwrite);	
											
return dRoofCommonCode;

end;
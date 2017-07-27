import VehicleV2,ut, vehicleCodes, vehlic, codes;

veh_exp := VehicleV2.Experian_Updating_as_VehicleV2;

//veh_exp := dataset('~thor_data400::persist::experian_updating_as_vehicleV2', VehicleV2.Layout_Experian_Updating_temp_module.Layout_Experian_Updating_as_VehicleV2, flat);

//generate vehicle key

VehicleV2.Layout_Experian_Updating_temp_module.layout_temp_main tformat(veh_exp L) := transform

	self.vehicle_key				:= trim(if(	L.vina_vinflag = 'T' and l.vina_body_style not in  ['IC'],
																			L.vina_vin, 
																			if(	L.vina_vinflag = 'T' and l.vina_body_style in  ['IC'],
																					L.orig_vin,
																					//if VINA takes a 17 character VIN and "converts" it to 16 characters, take the orig_vin
																					if(	l.vina_vinflag='F' and
																							length(trim(l.orig_vin))=17 and
																							length(trim(l.vina_vin))!= 17,
																							l.orig_vin,
																							if(	L.orig_vin[1..4] in ['', 'NONE', 'HMDE','HOME','UNK', 'N0NE', 'UNKN'] or
																									StringLib.StringFilterOut(L.orig_vin, '0|*') = '' or
																									regexfind('HOMEMADE$|H0MEMADE|NONE|N0NE|UNKNOWN|VEHICLE|UNKNOWN|UNKOWN|UNK0WN|NUMBER', L.orig_vin) or
																									L.orig_vin in ['N/A', 'N', 'NR', 'NA', 'ASPT', '01', 'SPCN', 'O', 'NO VIN', 'UKN'],  
																									(string30)hash64(L.state_origin,L.orig_vin,L.TITLE_NUMBERxBG9,L.vina_make_desc, L.year_make), 
																									(string30)hash64(L.state_origin, L.orig_vin, L.vina_make_desc, L.year_make)
																								)
																						)
																				)
																		),
																		left,right
																	);
    
	orig_veh_type_code			:= L.Vehicle_Type;
	orig_vehicle_type_desc	:= vehicleV2.getVehTypeDesc(orig_veh_type_code[1]);
	best_major_color_desc		:= VehicleCodes.getColor(L.best_Major_Color_Code);
	best_minor_color_desc		:= VehicleCodes.getColor(L.best_Minor_Color_Code);
	model_year							:= map(	L.Model_Year<>'' => L.Model_Year,
																	L.Best_Model_Year<>'' => L.Best_Model_Year,
																	L.Year_make
																);
	self.model_year					:= model_year;
	make_descrip						:= L.vina_make_desc;
	self.make_desc					:= if( stringlib.StringToUpperCase(make_descrip) = stringlib.StringToUpperCase(L.make_desc)[1..length(trim(make_descrip))] or L.make_desc = '',make_descrip, '');
	self.vehicle_type_desc	:= orig_vehicle_type_desc;
	self.series_desc				:= L.vina_series_desc;
	model_descrip						:= L.vina_model_desc;
	self.model_desc					:= if( stringlib.StringToUpperCase(model_descrip)[1..length(l.model_desc)] = stringlib.StringToUpperCase(l.model_desc) or l.model_desc='',model_descrip,'');
	self.body_style_desc		:= L.VINA_Body_Style_Desc;
	self.major_color_desc		:= best_major_color_desc;
	self.minor_color_desc		:= best_minor_color_desc;
	
	self										:= L;
	
end;

veh_main_dist := distribute(project(veh_exp, tformat(left)), hash(vehicle_key));

veh_main_sort := sort(veh_main_dist,
											vehicle_key,
											state_origin,
											source_code,
											ORIG_VIN,
											model_year,
											make_desc,
											series_desc,
											VEHICLE_TYPE_desc,
											MODEL_desc,
											body_style_desc,
											Net_Weight,
											Number_Of_Axles,
											MAJOR_COLOR_desc,
											MINOR_COLOR_desc, 
											-dt_vendor_first_reported,
											-REGISTRATION_EFFECTIVE_DATE,
											-REGISTRATION_EXPIRATION_DATE,
											-TITLE_ISSUE_DATE,
											local);

veh_main_dedup := dedup(veh_main_sort,
												vehicle_key,
												state_origin,
												source_code,
												ORIG_VIN,
												model_year,
												make_desc,
												series_desc,
												VEHICLE_TYPE_desc,
												MODEL_desc,
												body_style_desc,
												Net_Weight,
												Number_Of_Axles,
												MAJOR_COLOR_desc,
												MINOR_COLOR_desc, 
												local);


veh_main_dedup iterationkey1(veh_main_dedup L, veh_main_dedup R) := transform
	self.REGISTRATION_EFFECTIVE_DATE := if(	L.vehicle_key = R.vehicle_key,
																					if((unsigned6)L.REGISTRATION_EFFECTIVE_DATE <> (unsigned6)R.REGISTRATION_EFFECTIVE_DATE,
																							R.REGISTRATION_EFFECTIVE_DATE,
																							''
																						),
																					R.REGISTRATION_EFFECTIVE_DATE
																				);

	self.REGISTRATION_expiration_DATE := if(L.vehicle_key = R.vehicle_key,
																					if((unsigned6)L.REGISTRATION_expiration_DATE <> (unsigned6)R.REGISTRATION_expiration_DATE,
																							R.REGISTRATION_expiration_DATE,
																							''
																						),
																					R.REGISTRATION_expiration_DATE
																				);

	self.TITLE_ISSUE_DATE							:= if(L.vehicle_key = R.vehicle_key,
																					if((unsigned6)L.TITLE_ISSUE_DATE <> (unsigned6)R.TITLE_ISSUE_DATE,
																							R.TITLE_ISSUE_DATE,
																							''
																						),
																					R.TITLE_ISSUE_DATE
																				);

	self.dt_first_seen								:= if(L.vehicle_key = R.vehicle_key,
																					if(	L.dt_first_seen <> R.dt_first_seen,
																							R.dt_first_seen,
																							0
																						),
																					R.dt_first_seen
																				);

	self.dt_vendor_first_reported			:= IF(L.vehicle_key = R.vehicle_key,
																					if(	L.dt_vendor_first_reported <> R.dt_vendor_first_reported,
																							R.dt_vendor_first_reported,
																							0
																						),
																					R.dt_vendor_first_reported
																				);

	self.iteration_key_temp						:= trim(if(	self.REGISTRATION_EFFECTIVE_DATE <> '' or
																								self.TITLE_ISSUE_DATE <> '' or
																								self.REGISTRATION_expiration_DATE <> '', 
																								validate_date.fEarliestNonZeroDate(	validate_date.fEarliestNonZeroDate(self.REGISTRATION_EFFECTIVE_DATE,self.TITLE_ISSUE_DATE),self.REGISTRATION_expiration_DATE),
																								validate_date.fEarliestNonZeroDate((string8)self.dt_first_seen, (string8)self.dt_vendor_first_reported)
																							),
																							all
																						)
																			+ R.state_origin + R.source_code;

	SELF															:= R;
end;

main_iterate1				:= iterate(	sort(veh_main_dedup,vehicle_key,dt_vendor_first_reported, TITLE_ISSUE_DATE, local),
																iterationkey1(left, right),
																local
															);

main_iterate1_sort	:= sort(main_iterate1, vehicle_key, iteration_key_temp, dt_vendor_first_reported, local);

main_iterate1_sort iterationkey2(main_iterate1_sort L, main_iterate1_sort R) := transform
	self.iteration_key	:= if(L.vehicle_key = R.vehicle_key and
														L.iteration_key_temp = r.iteration_key_temp,
														if(	L.dt_vendor_first_reported <> R.dt_vendor_first_reported and
																R.dt_vendor_first_reported != 0,
																R.dt_vendor_first_reported + R.state_origin + R.source_code,
																R.dt_vendor_last_reported + R.state_origin + R.source_code
															),
														R.iteration_key_temp
													);
	self								:= R;
end;

main_iterate2 := iterate(main_iterate1_sort,iterationkey2(left, right), local);

export Mapping_Experian_Updating_temp_Main := main_iterate2 : persist('~thor_data400::persist::experian_updating_temp_main');
import vehicleV2,VehicleCodes;

veh_exp := VehicleV2.Experian_Updating_as_VehicleV2;

//veh_exp := dataset('~thor_data400::persist::experian_updating_as_vehicleV2', VehicleV2.Layout_Experian_Updating_temp_module.Layout_Experian_Updating_as_VehicleV2, flat);

VehicleV2.Layout_Experian_Updating_temp_module.Layout_Experian_Updating_as_VehicleV2 tformat(veh_exp L) := transform

	self.vehicle_key				:=   trim(if(	L.vina_vinflag = 'T' and l.vina_body_style not in  ['IC'],
																				L.vina_vin, 
																				if(	L.vina_vinflag = 'T' and l.vina_body_style in  ['IC'],
																						L.orig_vin,
																						//if VINA takes a 17 character VIN and "converts" it to 16 characters, take the orig_vin
																						if(	l.vina_vinflag='F' and length(trim(l.orig_vin))=17 and
																								length(trim(l.vina_vin))!= 17,
																								l.orig_vin,
																								if(	L.orig_vin[1..4] in ['', 'NONE', 'HMDE','HOME','UNK', 'N0NE', 'UNKN'] or
																										StringLib.StringFilterOut(L.orig_vin, '0|*') = '' or
																										regexfind('HOMEMADE$|H0MEMADE|NONE|N0NE|UNKNOWN|VEHICLE|UNKNOWN|UNKOWN|UNK0WN|NUMBER', L.orig_vin) or
																										L.orig_vin in ['N/A', 'N', 'NR', 'NA', 'ASPT', '01', 'SPCN', 'O', 'NO VIN', 'UKN'],  
																										(string30)hash64(L.state_origin, L.orig_vin, L.TITLE_NUMBERxBG9, L.vina_make_desc, L.year_make), 
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
																	L.Year_make);
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

//distribute works on the big dataset

veh_exp_dist := distribute(	project(veh_exp, tformat(left)),
														hash(vehicle_key,
																 state_origin,
																 source_code,
																 ORIG_VIN ,
																 model_year ,
																 make_desc ,
																 series_desc,
																 VEHICLE_TYPE_desc,
																 MODEL_desc,
																 body_style_desc,
																 Net_Weight,
																 Number_Of_Axles,
																 MAJOR_COLOR_desc,
																 MINOR_COLOR_desc
																)
													);
	   
	   
veh_exp_sort := sort(	veh_exp_dist,
											vehicle_key,
											state_origin,
											source_code,
											ORIG_VIN ,
											model_year ,
											make_desc ,
											series_desc,
											VEHICLE_TYPE_desc,
											MODEL_desc,
											body_style_desc,
											Net_Weight,
											Number_Of_Axles,
											MAJOR_COLOR_desc,
											MINOR_COLOR_desc, 
											-dt_vendor_first_reported,
											-REGISTRATION_EFFECTIVE_DATE ,
											-REGISTRATION_EXPIRATION_DATE ,
											-TITLE_ISSUE_DATE,
											local
										);
	   
	   
exp_temp_main := VehicleV2.Mapping_experian_updating_TEMP_main;
//exp_temp_main := dataset('~thor_data400::persist::experian_updating_temp_main', VehicleV2.Layout_Experian_Updating_temp_module.layout_temp_main, flat);
//distribute works the big dataset

exp_temp_main_dist := distribute(	exp_temp_main,
																	hash(	vehicle_key,
																				state_origin,
																				source_code,
																				ORIG_VIN ,
																				model_year ,
																				make_desc ,
																				series_desc,
																				VEHICLE_TYPE_desc,
																				MODEL_desc,
																				body_style_desc,
																				Net_Weight,
																				Number_Of_Axles,
																				MAJOR_COLOR_desc,
																				MINOR_COLOR_desc 
																			)
																);
  
	   
exp_temp_main_sort := sort(	exp_temp_main_dist, 
														vehicle_key,
														state_origin,
														source_code,
														ORIG_VIN ,
														model_year ,
														make_desc ,
														series_desc,
														VEHICLE_TYPE_desc,
														MODEL_desc,
														body_style_desc,
														Net_Weight,
														Number_Of_Axles,
														MAJOR_COLOR_desc,
														MINOR_COLOR_desc,
														local
													);
	   
//denormalize temp main with vehicle_key and iteration key with old vehicle file

veh_exp_sort tdenormalize(veh_exp_sort L, exp_temp_main_sort R) := transform
	self.iteration_key	:= R.iteration_key;
	self								:= L;
end;

veh_denormalize := join(veh_exp_sort,
												exp_temp_main_sort,
												left.vehicle_key = right.vehicle_key and 
												left.state_origin = right.state_origin and
												left.source_code = right.source_code and 
												left.ORIG_VIN = right.ORIG_VIN and
												left.Model_YEAR = right.model_YEAR and
												left.MAKE_desc = right.MAKE_desc and
												left.series_desc = right.series_desc and
												left.VEHICLE_TYPE_desc = right.VEHICLE_TYPE_desc and
												left.MODEL_desc = right.MODEL_desc and 
												left.BODY_style_desc = right.BODY_style_desc and
												left.Net_Weight = right.Net_Weight and 
												left.Number_Of_Axles = right.Number_Of_Axles and      
												left.MAJOR_COLOR_desc = right.MAJOR_COLOR_desc and
												left.MINOR_COLOR_desc = right.MINOR_COLOR_desc,
												tdenormalize(left, right),
												local
											);
							 
export Mapping_Experian_Updating_Temp_Party := dedup(veh_denormalize, all, local):persist('~thor_data400::persist::experian_updating_temp_party') ;

// export Mapping_Experian_Updating_Temp_Party := dedup(veh_denormalize, all, local);
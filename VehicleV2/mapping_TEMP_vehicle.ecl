import ut,Vehlic,vehicleV2,VehicleCodes;

veh_in	:=	VehicleV2.File_Vehicles;

// veh_in	:=	dataset(ut.foreign_prod+'~thor_data400::temp::vehiclesv2_slim',VehicleV2.Layout_temp_module.Layout_vehiclesV2_slim,flat);

// set up vehicle_key
VehicleV2.Layout_temp_module.Layout_vehiclesV2_slim taddkeys(veh_in L)	:=
transform
	self.vehicle_key  			:=	trim(if(L.vina_vinflag = 'T',L.VINA_vin,
																		//if VINA takes a 17 character VIN and "converts" it to 16 characters,take the orig_vin
																		if(l.vina_vinflag='F' and length(trim(l.orig_vin))=17 and length(trim(l.VINA_vin))!= 17,l.orig_vin,
																		if(L.orig_vin[1..4] in ['','NONE','HMDE','HOME','UNK','N0NE','UNKN'] or StringLib.StringFilterOut(L.orig_vin,'0|*') = '' 
																		or regexfind('HOMEMADE$|H0MEMADE|NONE|N0NE|UNKNOWN|VEHICLE|UNKNOWN|UNKOWN|UNK0WN|NUMBER',L.orig_vin) or L.orig_vin in ['N/A','N','NR','NA','ASPT','01','SPCN','O','NO VIN','UKN'], 
																		(string30)hash64(L.state_origin,L.orig_vin,L.TITLE_NUMBERxBG9,L.make_description,L.year_make),
																		(string30)hash64(L.state_origin,L.orig_vin,L.make_description,L.year_make)))),
																		left,right
																	);

	orig_veh_type_code			:=	VehicleV2.translate_DI_orig_vehicle_type(L.orig_vehicle_type_desc);
	best_major_color_desc		:=	VehicleCodes.getColor(L.best_Major_Color_Code);
	best_minor_color_desc		:=	VehicleCodes.getColor(L.best_Minor_Color_Code);
	model_year							:=	map(	L.Model_Year			<>	'' => L.Model_Year,
																		L.Best_Model_Year	<>	'' => L.Best_Model_Year,
																		L.Year_make
																	);
	self.model_year					:=	model_year;
	make_descrip						:=	L.make_description;
	self.make_desc					:=	if( stringlib.StringToUpperCase(make_descrip) = stringlib.StringToUpperCase(L.make_desc)[1..length(trim(make_descrip))] or L.make_desc = '',
																	make_descrip,
																	''
																);
	self.vehicle_type_desc	:=	vehicleV2.getVehTypeDesc(orig_veh_type_code);
	self.series_desc				:=	L.series_description;
	model_descrip						:=	L.model_description;
	self.model_desc					:=	if( stringlib.StringToUpperCase(model_descrip)[1..length(l.model_desc)] = stringlib.StringToUpperCase(l.model_desc) or l.model_desc='',
																	model_descrip,
																	''
																);
	self.body_style_desc		:=	L.body_style_description;
	self.major_color_desc		:=	best_major_color_desc;
	self.minor_color_desc		:=	best_minor_color_desc;
	self										:=	L;
end;

veh_vin_pro 	:=	project(veh_in,taddkeys(left));

veh_vin_dist	:=	distribute(	veh_vin_pro,
															hash(	vehicle_key,
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
																		GROSS_WEIGHT,
																		Number_Of_Axles,
																		MAJOR_COLOR_desc,
																		MINOR_COLOR_desc,
																		vehicle_use,
																		orig_vehicle_use_desc
																	)
														);

veh_vin_sort	:=	sort(	veh_vin_dist,
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
												GROSS_WEIGHT,
												Number_Of_Axles,
												MAJOR_COLOR_desc,
												MINOR_COLOR_desc,
												vehicle_use,
												orig_vehicle_use_desc,		  
											 -dt_vendor_first_reported,
											 -REGISTRATION_EFFECTIVE_DATE,
											 -REGISTRATION_Expiration_DATE,
											 -TITLE_ISSUE_DATE,
											 local
										 );

// distribute vehicle temp main
temp_main	:=	VehicleV2.Mapping_TEMP_main;

temp_main_dist	:=	distribute(	temp_main,
																hash(	vehicle_key,
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
																			GROSS_WEIGHT,
																			Number_Of_Axles,
																			MAJOR_COLOR_desc,
																			MINOR_COLOR_desc,
																			vehicle_use,
																			orig_vehicle_use_desc
																		)
															);

temp_main_sort	:=	sort(	temp_main_dist,
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
													GROSS_WEIGHT,
													Number_Of_Axles,
													MAJOR_COLOR_desc,
													MINOR_COLOR_desc,
													vehicle_use,
													orig_vehicle_use_desc,
													local
												);	   

//denormalize temp main with vehicle_key and iteration key with old vehicle file
veh_vin_sort tdenormalize(veh_vin_sort L,temp_main_dist R)	:=
transform
	self.iteration_key	:=	R.iteration_key;
	self								:=	L;
end;

veh_denormalize	:=	join(	veh_vin_sort,	   
													temp_main_sort,
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
													left.gross_weight = right.gross_weight and
													left.Number_Of_Axles = right.Number_Of_Axles and      
													left.MAJOR_COLOR_desc = right.MAJOR_COLOR_desc and
													left.MINOR_COLOR_desc = right.MINOR_COLOR_desc and
													left.vehicle_use = right.vehicle_use and 
													left.orig_vehicle_use_desc = right.orig_vehicle_use_desc,
													tdenormalize(left,right),
													local
												);	

veh_dedup	:=	dedup(veh_denormalize,all,local);

export mapping_TEMP_vehicle	:=	veh_dedup : persist('~thor_data400::persist::vehicleV2::vehiclev1_temp');
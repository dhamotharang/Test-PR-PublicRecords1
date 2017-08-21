/*2010-06-01T13:21:08Z (Krishna Gummadi)

*/
import ut,Vehlic,vehicleV2,VehicleCodes;

dVehIn	:=	VehicleV2.File_Vehicles;

// dVehIn	:=	dataset(ut.foreign_prod+'~thor_data400::temp::vehiclesv2_slim',VehicleV2.Layout_temp_module.Layout_vehiclesV2_slim,flat);

// generate vehicle_key
VehicleV2.Layout_temp_module.Layout_temp_main taddkeys(dVehIn L)	:=	transform

	self.vehicle_key  			:=	trim(	if(L.vina_vinflag = 'T',L.VINA_vin,
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
	model_year							:=	map(	L.Model_Year			<>'' => L.Model_Year,
																		L.Best_Model_Year	<>'' => L.Best_Model_Year,
																		L.Year_make
																	);
	self.model_year					:=	model_year;
	make_descrip						:=	L.make_description;
	self.make_desc 					:= if( stringlib.StringToUpperCase(make_descrip) = stringlib.StringToUpperCase(L.make_desc)[1..length(trim(make_descrip))] or L.make_desc = '',make_descrip,'');
	self.vehicle_type_desc	:= vehicleV2.getVehTypeDesc(orig_veh_type_code);
	self.series_desc				:=	L.series_description;
	model_descrip						:=	L.model_description;
	self.model_desc					:=	if( stringlib.StringToUpperCase(model_descrip)[1..length(l.model_desc)] = stringlib.StringToUpperCase(l.model_desc) or l.model_desc='',model_descrip,'');
	self.body_style_desc		:=	L.body_style_description;
	self.major_color_desc		:=	best_major_color_desc;
	self.minor_color_desc		:=	best_minor_color_desc;

	self										:=	L;
end;
		
dVehicleKey 	:=	project(dVehIn,taddkeys(left));
		
dVehicleKeyDist	:=	distribute(dVehicleKey,hash(vehicle_key));

dVehicleKeySort	:=	sort(	dVehicleKeyDist,
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
													-Net_Weight,				//DF-8238 keep the record with highest weight at the top
													GROSS_WEIGHT,
													Number_Of_Axles,
													MAJOR_COLOR_desc,
													MINOR_COLOR_desc,
													-dt_vendor_first_reported,
													-REGISTRATION_EFFECTIVE_DATE ,
													-REGISTRATION_expiration_DATE,
													-TITLE_ISSUE_DATE,
													local
												);

dVehicleKeyDedup	:=	dedup(	dVehicleKeySort,
															left.vehicle_key=right.vehicle_key and
															left.state_origin=right.state_origin and
															left.source_code=right.source_code and
															left.ORIG_VIN=right.ORIG_VIN  and
															left.model_year=right.model_year  and
															left.make_desc=right.make_desc  and
															left.series_desc=right.series_desc and
															left.VEHICLE_TYPE_desc=right.VEHICLE_TYPE_desc and
															left.MODEL_desc=right.MODEL_desc and
															left.body_style_desc=right.body_style_desc and
															//BUG DF-8238 - will only keep 1 record if the other record has net_weight is not present.
															(left.Net_Weight=right.Net_Weight or right.Net_Weight='') and
															left.GROSS_WEIGHT=right.GROSS_WEIGHT and
															left.Number_Of_Axles=right.Number_Of_Axles and
															left.MAJOR_COLOR_desc=right.MAJOR_COLOR_desc and
															left.MINOR_COLOR_desc=right.MINOR_COLOR_desc,
															local
														);


VehicleV2.Layout_temp_module.Layout_temp_main iterationkey1(dVehicleKeyDedup L,dVehicleKeyDedup R)	:=
transform
	self.REGISTRATION_EFFECTIVE_DATE	:=	if(	L.vehicle_key = R.vehicle_key,
																						if(	(unsigned6)L.REGISTRATION_EFFECTIVE_DATE <> (unsigned6)R.REGISTRATION_EFFECTIVE_DATE,
																								R.REGISTRATION_EFFECTIVE_DATE,
																								''
																							),
																						R.REGISTRATION_EFFECTIVE_DATE
																					);

	self.REGISTRATION_expiration_DATE	:=	if(	L.vehicle_key = R.vehicle_key,
																						if(	(unsigned6)L.REGISTRATION_expiration_DATE <> (unsigned6)R.REGISTRATION_expiration_DATE,
																								R.REGISTRATION_expiration_DATE,
																								''
																							),
																						R.REGISTRATION_expiration_DATE
																					);

	self.TITLE_ISSUE_DATE							:=	if(	L.vehicle_key = R.vehicle_key,
																						if(	(unsigned6)L.TITLE_ISSUE_DATE <> (unsigned6)R.TITLE_ISSUE_DATE,
																								R.TITLE_ISSUE_DATE,
																								''
																							),
																						R.TITLE_ISSUE_DATE
																					);

	self.dt_first_seen								:=	if(	L.vehicle_key = R.vehicle_key,
																						if(	L.dt_first_seen <> R.dt_first_seen,
																								R.dt_first_seen,
																								0
																							),
																						R.dt_first_seen
																					);

	self.dt_vendor_first_reported			:=	IF(	L.vehicle_key = R.vehicle_key,
																						if(	L.dt_vendor_first_reported <> R.dt_vendor_first_reported,
																								R.dt_vendor_first_reported,
																								0
																							),
																						R.dt_vendor_first_reported
																					);

	self.iteration_key_temp						:=	trim(	if(self.REGISTRATION_EFFECTIVE_DATE <> '' or self.TITLE_ISSUE_DATE <> '' or self.REGISTRATION_expiration_DATE <> '',
																							validate_date.fEarliestNonZeroDate(validate_date.fEarliestNonZeroDate(self.REGISTRATION_EFFECTIVE_DATE,self.TITLE_ISSUE_DATE),
																							self.REGISTRATION_expiration_DATE),validate_date.fEarliestNonZeroDate((string8)self.dt_first_seen,(string8)self.dt_vendor_first_reported)),
																							all
																						) + R.state_origin + R.source_code;

	SELF															:=	R;
end;

dIterateKey1	:=	iterate(sort(dVehicleKeyDedup,vehicle_key,dt_vendor_first_reported,TITLE_ISSUE_DATE),iterationkey1(left,right),local);

dIterateKey1Sort	:=	sort(dIterateKey1,vehicle_key,iteration_key_temp,dt_vendor_first_reported,local);

VehicleV2.Layout_temp_module.Layout_temp_main iterationkey2(dIterateKey1Sort	L,dIterateKey1Sort	R)	:=
transform
	self.iteration_key	:=	if(	L.vehicle_key = R.vehicle_key and L.iteration_key_temp = r.iteration_key_temp,
															if(	L.dt_vendor_first_reported <> R.dt_vendor_first_reported and R.dt_vendor_first_reported != 0,
																	R.dt_vendor_first_reported + R.state_origin + R.source_code,
																	R.dt_vendor_last_reported + R.state_origin + R.source_code
																),
															R.iteration_key_temp
														);
	self								:=	R;
end;

dIterateKey2	:=	iterate(dIterateKey1Sort,iterationkey2(left,right),local);

export	mapping_TEMP_main	:=	dIterateKey2	:	persist('~thor_data400::persist::vehicleV2::vehicleV1_temp_main');
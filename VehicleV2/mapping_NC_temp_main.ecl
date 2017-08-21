import codes,ut,VehicleV2,vehicleCodes,vehlic;

// NC Vehicle base file
dNCBase	:=	VehicleV2.Files.Base.NC;

dNCBaseDist	:=	distribute(dNCBase,hash(vehicle_key));
dNCBaseSort	:=	sort(	dNCBaseDist,
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
											-Orig_Net_Weight,						//DF-8238 keep the highest net weight at the top
											NUMBER_OF_AXLES,
											MAJOR_COLOR_desc,
											MINOR_COLOR_desc,
											-dt_vendor_first_reported,
											-REGISTRATION_EFFECTIVE_DATE ,
											-REGISTRATION_expiration_DATE,
											-TITLE_ISSUE_DATE ,
											local
										);
		 
dNCBaseDedup	:=	dedup(	dNCBaseSort,
													left.vehicle_key=right.vehicle_key and
													left.state_origin=right.state_origin and
													left.source_code=right.source_code and
													left.ORIG_VIN=right.ORIG_VIN and
													left.model_year=right.model_year and
													left.make_desc=right.make_desc and
													left.series_desc=right.series_desc and
													left.VEHICLE_TYPE_desc=right.VEHICLE_TYPE_desc and
													left.MODEL_desc=right.MODEL_desc and
													left.body_style_desc=right.body_style_desc and
													//BUG DF-8238 - will only keep 1 record if the other record has net_weight is not present.
													(left.Orig_Net_Weight=right.Orig_Net_Weight or right.Orig_Net_Weight='') and
													left.NUMBER_OF_AXLES=right.NUMBER_OF_AXLES and
													left.MAJOR_COLOR_desc=right.MAJOR_COLOR_desc and
													left.MINOR_COLOR_desc=right.MINOR_COLOR_desc,
													local
												);

// Append temporary iteration key
rNCTemp_layout	:=
record
	VehicleV2.Layout_NC.NC_as_VehicleV2_Layout;
	string15	Iteration_Key_Temp	:=	'';
end;

dNCAppendTmpIterationKey	:=	project(dNCBaseDedup,rNCTemp_layout);

rNCTemp_layout	iterationkey1(dNCAppendTmpIterationKey	L,dNCAppendTmpIterationKey	R)	:=
transform
	self.REGISTRATION_EFFECTIVE_DATE	:=	if(	L.vehicle_key	=	R.vehicle_key,
																						if(	(unsigned6)L.REGISTRATION_EFFECTIVE_DATE	<>	(unsigned6)R.REGISTRATION_EFFECTIVE_DATE,
																								R.REGISTRATION_EFFECTIVE_DATE,
																								''
																							),
																						R.REGISTRATION_EFFECTIVE_DATE
																					);

	self.REGISTRATION_expiration_DATE	:=	if(	L.vehicle_key = R.vehicle_key,
																						if(	(unsigned6)L.REGISTRATION_expiration_DATE	<>	(unsigned6)R.REGISTRATION_expiration_DATE,
																								R.REGISTRATION_expiration_DATE,
																								''
																							),
																						R.REGISTRATION_expiration_DATE
																					);

	self.TITLE_ISSUE_DATE 						:=	if(	L.vehicle_key	=	R.vehicle_key,
																						if(	(unsigned6)L.TITLE_ISSUE_DATE	<>	(unsigned6)R.TITLE_ISSUE_DATE,
																								R.TITLE_ISSUE_DATE,
																								''
																							),
																						R.TITLE_ISSUE_DATE
																					);

	self.dt_first_seen 								:=	if(	L.vehicle_key	=	R.vehicle_key,
																						if(	L.dt_first_seen	<>	R.dt_first_seen,
																								R.dt_first_seen,
																								0
																							),
																						R.dt_first_seen
																					);

	self.dt_vendor_first_reported 		:=	if(	L.vehicle_key	=	R.vehicle_key,
																						if(	L.dt_vendor_first_reported	<>	R.dt_vendor_first_reported,
																								R.dt_vendor_first_reported,
																								0
																							),
																						R.dt_vendor_first_reported
																					);

	self.iteration_key_temp 					:=	trim(	MAP(	self.REGISTRATION_EFFECTIVE_DATE	<>	''	or	self.REGISTRATION_expiration_DATE	<>	''	=>	validate_date.fEarliestNonZeroDate(self.REGISTRATION_EFFECTIVE_DATE,self.REGISTRATION_expiration_DATE),
																										self.dt_first_seen								<>	0		or	self.dt_vendor_first_reported			<>	0		=>	validate_date.fEarliestNonZeroDate((string8)self.dt_first_seen,(string8)self.dt_vendor_first_reported),
																										self.TITLE_ISSUE_DATE							<>	''																								=> self.TITLE_ISSUE_DATE,
																										(string8)R.dt_vendor_last_reported
																									),
																							all
																						)	+	R.state_origin	+	R.source_code;
	self															:=	R;
end;

main_iterate1 			:=	iterate(	sort(	dNCAppendTmpIterationKey,
																				vehicle_key,
																				-dt_vendor_first_reported,
																				-REGISTRATION_EFFECTIVE_DATE,
																				local
																			),
																	iterationkey1(left,right),
																	local
																);

main_iterate1_sort 	:=	sort(	main_iterate1,
															vehicle_key,
															-iteration_key_temp,
															-dt_vendor_first_reported,
															-TITLE_ISSUE_DATE,
															local
														);

rNCTemp_layout	iterationkey2(main_iterate1_sort	L,main_iterate1_sort	R)	:=
transform
	self.iteration_key	:=	if(	L.vehicle_key	=	R.vehicle_key	and	L.iteration_key_temp	=	r.iteration_key_temp,
															MAP(	L.iteration_key_temp						<>	R.iteration_key_temp						and	R.iteration_key_temp						!=	''	=>	R.iteration_key_temp						+	R.state_origin	+	R.source_code,
																		L.REGISTRATION_EFFECTIVE_DATE		<>	R.REGISTRATION_EFFECTIVE_DATE		and	R.REGISTRATION_EFFECTIVE_DATE		!=	''	=>	R.REGISTRATION_EFFECTIVE_DATE		+ R.state_origin	+	R.source_code,
																		L.dt_first_seen									<>	R.dt_first_seen									and	R.dt_first_seen									!=	0		=>	R.dt_first_seen									+	R.state_origin	+	R.source_code,
																		L.TITLE_ISSUE_DATE							<>	R.TITLE_ISSUE_DATE							and	R.TITLE_ISSUE_DATE							!=	''	=>	R.TITLE_ISSUE_DATE							+	R.state_origin	+	R.source_code,			
																		L.dt_vendor_first_reported			<>	R.dt_vendor_first_reported			and	R.dt_vendor_first_reported			!=	0		=>	R.dt_vendor_first_reported			+	R.state_origin	+	R.source_code,		
																		L.dt_vendor_last_reported				<>	R.dt_vendor_last_reported				and	R.dt_vendor_last_reported				!=	0		=>	R.dt_vendor_last_reported				+	R.state_origin	+	R.source_code,
																		L.REGISTRATION_expiration_DATE	<>	R.REGISTRATION_expiration_DATE	and	R.REGISTRATION_expiration_DATE	!=	''	=>	R.REGISTRATION_expiration_DATE	+	R.state_origin	+	R.source_code,
																		(string8)R.dt_vendor_last_reported
																	),
																		R.iteration_key_temp
														);
	self								:=	R;
end;

main_iterate2	:=	iterate(main_iterate1_sort,iterationkey2(left,right),local);

dNCTempMain	:=	project(main_iterate2,VehicleV2.Layout_NC.NC_as_VehicleV2_Layout);

export Mapping_NC_Temp_Main 	:= dNCTempMain : persist('~thor_data400::persist::vehicleV2::nc_temp_main');
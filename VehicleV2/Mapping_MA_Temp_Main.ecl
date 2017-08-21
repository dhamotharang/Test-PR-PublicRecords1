import ut,VehicleV2,VehicleCodes,CODES,vehlic;

// OH Vehicle base file
dMABase	:=	VehicleV2.Files.Base.MA;

dMABaseDist		:=	distribute(dMABase,hash(vehicle_key));
dMABaseSort		:=	sort(	dMABaseDist,
												vehicle_key,
												state_origin,
												source_code,
												ORIG_VIN,
												year_make,
												make_code,
												series_desc,
												MODEL_desc,
												body_style_desc,
												VEHICLE_TYPE,
												Orig_Gross_Weight,
												//Number_Of_Axles,
												MAJOR_COLOR_CODE,
												MINOR_COLOR_CODE,
												-dt_vendor_first_reported,
												-REGISTRATION_EFFECTIVE_DATE ,
												-REGISTRATION_expiration_DATE,
												-TITLE_ISSUE_DATE ,
												local
											);
		 
dMABaseDedup	:=	dedup(	dMABaseSort,
													vehicle_key,
													state_origin,
													source_code,
													ORIG_VIN,
													year_make,
													make_code,
													series_desc,
													MODEL_desc,
													body_style_desc,
													VEHICLE_TYPE,
													Orig_Gross_Weight,
													MAJOR_COLOR_CODE,
													MINOR_COLOR_CODE,
													local
												);

// Append temporary iteration key
rMATemp_layout	:=
record
	VehicleV2.Layout_MA.MA_as_VehicleV2;
	string15	Iteration_Key_Temp	:=	'';
end;

dMAAppendTempIterationKey	:=	project(dMABaseDedup,rMATemp_layout);

// Generate iteration key
rMATemp_layout	iterationkey1(dMAAppendTempIterationKey	L,dMAAppendTempIterationKey	R)	:=
transform
	self.REGISTRATION_EFFECTIVE_DATE	:=	if(	L.vehicle_key	=	R.vehicle_key,
																						if(	(unsigned6)L.REGISTRATION_EFFECTIVE_DATE	<>	(unsigned6)R.REGISTRATION_EFFECTIVE_DATE,
																								R.REGISTRATION_EFFECTIVE_DATE,
																								''
																							),
																						R.REGISTRATION_EFFECTIVE_DATE
																					);

	self.REGISTRATION_EXPIRATION_DATE	:=	if(	L.vehicle_key = R.vehicle_key,
																						if(	(unsigned6)L.REGISTRATION_EXPIRATION_DATE	<>	(unsigned6)R.REGISTRATION_EXPIRATION_DATE,
																								R.REGISTRATION_EXPIRATION_DATE,
																								''
																							),
																						R.REGISTRATION_EXPIRATION_DATE
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

	self.iteration_key_temp						:=	trim(	if(				self.registration_effective_date	<>	''
																										or	self.title_issue_date							<>	''
																										or	self.registration_expiration_date	<>	'', 
																										validate_date.fEarliestNonZeroDate(validate_date.fEarliestNonZeroDate(self.registration_effective_date,self.title_issue_date),self.registration_expiration_date),
																										validate_date.fEarliestNonZeroDate((string8)self.dt_first_seen,(string8)self.dt_vendor_first_reported)
																									),
																							all
																						)
																				+ r.state_origin	+	r.source_code;


	self															:=	R;
end;

dMAMainIterate1 :=	ungroup(iterate(group(sort(	dMAAppendTempIterationKey,
																								vehicle_key,
																								-dt_vendor_first_reported,
																								-TITLE_ISSUE_DATE,
																								local
																							),
																					vehicle_key,
																					dt_vendor_first_reported,
																					TITLE_ISSUE_DATE),
																		iterationkey1(left,right))
														);


dMAMainIterate1Sort 	:=	sort(	dMAMainIterate1,
																vehicle_key,
																iteration_key_temp,
																-dt_vendor_first_reported,
																local
															);

rMATemp_layout	iterationkey2(dMAMainIterate1Sort	L,dMAMainIterate1Sort	R)	:=
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

dMAMainIterate2	:=	ungroup(iterate(group(dMAMainIterate1Sort,
																									vehicle_key,
																									iteration_key_temp,
																									dt_vendor_first_reported),
																						iterationkey2(left,right)));
																						
dMATempMain	:=	project(dMAMainIterate2,VehicleV2.Layout_MA.MA_as_VehicleV2);

export Mapping_MA_Temp_Main 	:= dMATempMain	:	persist('~thor_data400::persist::vehicleV2::ma_temp_main');

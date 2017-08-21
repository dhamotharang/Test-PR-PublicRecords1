import ut,VehicleV2,VehicleCodes,CODES,vehlic;

// OH Vehicle base file
dOHBase	:=	VehicleV2.Files.Base.OH;

dOHBaseDist		:=	distribute(dOHBase,hash(vehicle_key));
dOHBaseSort		:=	sort(	dOHBaseDist,
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
												-Orig_Net_Weight,					//DF-8238 keep the record with highest net weight at the top
												Number_Of_Axles,
												MAJOR_COLOR_desc,
												MINOR_COLOR_desc,
												-dt_vendor_first_reported,
												-REGISTRATION_EFFECTIVE_DATE ,
												-REGISTRATION_expiration_DATE,
												-TITLE_ISSUE_DATE ,
												local
											);
		 
dOHBaseDedup	:=	dedup(	dOHBaseSort,
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
													(left.Orig_Net_Weight=right.Orig_Net_Weight or right.Orig_Net_Weight='') and
													left.Number_Of_Axles=right.Number_Of_Axles and
													left.MAJOR_COLOR_desc=right.MAJOR_COLOR_desc and
													left.MINOR_COLOR_desc=right.MINOR_COLOR_desc,
													local
												);

// Append temporary iteration key
rOHTemp_layout	:=
record
	VehicleV2.Layout_OH.OH_as_VehicleV2;
	string15	Iteration_Key_Temp	:=	'';
end;

dOHAppendTempIterationKey	:=	project(dOHBaseDedup,rOHTemp_layout);

// Generate iteration key
rOHTemp_layout	iterationkey1(dOHAppendTempIterationKey	L,dOHAppendTempIterationKey	R)	:=
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

dOHMainIterate1 :=	iterate(	sort(	dOHAppendTempIterationKey,
																		vehicle_key,
																		-dt_vendor_first_reported,
																		-REGISTRATION_EFFECTIVE_DATE,
																		local
																	),
															iterationkey1(left,right),
															local
														);

dOHMainIterate1Sort 	:=	sort(	dOHMainIterate1,
																vehicle_key,
																-iteration_key_temp,
																-dt_vendor_first_reported,
																-TITLE_ISSUE_DATE,
																local
															);

rOHTemp_layout	iterationkey2(dOHMainIterate1Sort	L,dOHMainIterate1Sort	R)	:=
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

dOHMainIterate2	:=	iterate(dOHMainIterate1Sort,iterationkey2(left,right),local);

dOHTempMain	:=	project(dOHMainIterate2,VehicleV2.Layout_OH.OH_as_VehicleV2);

export Mapping_OH_Temp_Main 	:= dOHTempMain	:	persist('~thor_data400::persist::vehicleV2::oh_temp_main');
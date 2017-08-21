import codes,ut,vehicleV2,vehiclecodes,vehlic;

dVehExperianBase	:=	VehicleV2.Files.Base.Experian;

// Reformat to the temp main layout
dExperianTempMain	:=	project(dVehExperianBase,VehicleV2.Layout_Experian.layout_temp_main);

// dedup records based on vehicle characteristics
dVehExpTempMain_Dist := distribute(dExperianTempMain,hash(vehicle_key));

dVehExpTempMain_Sort := sort(	dVehExpTempMain_Dist,
															vehicle_key,
															state_origin,
															source_code,
															orig_vin,
															model_year,
															make_desc,
															model_desc,
															series_desc,
															vehicle_type_desc,
															body_style_desc,
															-net_weight,							//BUG DF-8238 - sort net_weight in reverse order to keep the recorder with net_weight present
															number_of_axles,
															major_color_desc,
															minor_color_desc, 
															-dt_vendor_first_reported,
															-registration_effective_date,
															-registration_expiration_date,
															-title_issue_date,
															local
														);

dVehExpTempMain_Dedup := dedup(	dVehExpTempMain_Sort,
																left.vehicle_key=right.vehicle_key and 
																left.state_origin=right.state_origin and
																left.source_code=right.source_code and
																left.orig_vin=right.orig_vin and
																left.model_year=right.model_year and
																left.make_desc=right.make_desc and
																left.model_desc=right.model_desc and
																left.series_desc=right.series_desc and
																left.vehicle_type_desc=right.vehicle_type_desc and
																left.body_style_desc=right.body_style_desc and
																//BUG DF-8238 - will only keep 1 record if the other record has net_weight is not present.
																(left.net_weight=right.net_weight or right.net_weight='') and
																left.number_of_axles=right.number_of_axles and
																left.major_color_desc=right.major_color_desc and
																left.minor_color_desc=right.minor_color_desc,
																local
															);

// calculate iteration key for the vehicle
VehicleV2.Layout_Experian.layout_temp_main	tIterationKey1(dVehExpTempMain_Dedup	le,dVehExpTempMain_Dedup	ri)	:=
transform
	self.registration_effective_date :=	if(	le.vehicle_key	=	ri.vehicle_key,
																					if((unsigned6)le.registration_effective_date	<>	(unsigned6)ri.registration_effective_date,
																							ri.registration_effective_date,
																							''
																						),
																					ri.registration_effective_date
																				);

	self.registration_expiration_date :=	if(	le.vehicle_key	=	ri.vehicle_key,
																						if((unsigned6)le.registration_expiration_date	<>	(unsigned6)ri.registration_expiration_date,
																								ri.registration_expiration_date,
																								''
																							),
																						ri.registration_expiration_date
																					);

	self.title_issue_date							:=	if(	le.vehicle_key	=	ri.vehicle_key,
																						if((unsigned6)le.title_issue_date	<>	(unsigned6)ri.title_issue_date,
																								ri.title_issue_date,
																								''
																							),
																						ri.title_issue_date
																					);

	self.dt_first_seen								:=	if(	le.vehicle_key	=	ri.vehicle_key,
																						if(	le.dt_first_seen	<>	ri.dt_first_seen,
																								ri.dt_first_seen,
																								0
																							),
																						ri.dt_first_seen
																					);

	self.dt_vendor_first_reported			:=	if(	le.vehicle_key	=	ri.vehicle_key,
																						if(	le.dt_vendor_first_reported	<>	ri.dt_vendor_first_reported,
																								ri.dt_vendor_first_reported,
																								0
																							),
																						ri.dt_vendor_first_reported
																					);

	self.iteration_key_temp						:=	trim(	if(				self.registration_effective_date	<>	''
																										or	self.title_issue_date							<>	''
																										or	self.registration_expiration_date	<>	'', 
																										validate_date.fEarliestNonZeroDate(validate_date.fEarliestNonZeroDate(self.registration_effective_date,self.title_issue_date),self.registration_expiration_date),
																										validate_date.fEarliestNonZeroDate((string8)self.dt_first_seen,(string8)self.dt_vendor_first_reported)
																									),
																							all
																						)
																				+ ri.state_origin	+	ri.source_code;

	self															:=	ri;
end;

dvehiclesIterate1				:= iterate(	sort(dVehExpTempMain_Dedup,vehicle_key,dt_vendor_first_reported,title_issue_date,local),
																		tIterationKey1(left,right),
																		local
																	);

dvehiclesIterate1_sort	:= sort(dvehiclesIterate1,vehicle_key,iteration_key_temp,dt_vendor_first_reported,local);

VehicleV2.Layout_Experian.layout_temp_main	tIterationKey2(dvehiclesIterate1_sort	le,dvehiclesIterate1_sort	ri)	:=
transform
	self.iteration_key	:=	if(			le.vehicle_key				=	ri.vehicle_key
															and	le.iteration_key_temp	=	ri.iteration_key_temp,
															if(			le.dt_vendor_first_reported <> ri.dt_vendor_first_reported
																	and	ri.dt_vendor_first_reported != 0,
																	ri.dt_vendor_first_reported	+	ri.state_origin	+	ri.source_code,
																	ri.dt_vendor_last_reported	+	ri.state_origin	+	ri.source_code
																),
															ri.iteration_key_temp
														);
	self								:= ri;
end;

dvehiclesIterate2 := iterate(dvehiclesIterate1_sort,tIterationKey2(left,right),local);

export	Map_Experian_Main_Temp	:=	dvehiclesIterate2	:	persist('~thor_data400::persist::vehiclev2::experian_main_temp');
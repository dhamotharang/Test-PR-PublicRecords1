import	codes,header,ut,vehicleV2,VehicleCodes,vehlic;

dVehExperianBase	:=	vehicleV2.Files.Base.Experian;

// Join to the main file and obtain the iteration key
dVehExperianBaseDist	:=	distribute(	dVehExperianBase,
																			hash(vehicle_key,
																					 state_origin,
																					 source_code,
																					 orig_vin,
																					 model_year,
																					 make_desc,
																					 series_desc,
																					 vehicle_type_desc,
																					 model_desc,
																					 body_style_desc,
																					 // net_weight,		//DF-8238
																					 number_of_axles,
																					 major_color_desc,
																					 minor_color_desc
																					)
																			);
	   
	   
dVehExperianBaseSort	:=	sort(	dVehExperianBaseDist,
																vehicle_key,
																state_origin,
																source_code,
																orig_vin,
																model_year,
																make_desc,
																series_desc,
																vehicle_type_desc,
																model_desc,
																body_style_desc,
																// net_weight,						//DF-8238
																number_of_axles,
																major_color_desc,
																minor_color_desc,
																-dt_vendor_first_reported,
																-registration_effective_date,
																-registration_expiration_date,
																-title_issue_date,
																local
															);
	   
	   
dExpMainTemp	:=	VehicleV2.Map_Experian_Main_Temp;

dExpMainTempDist	:=	distribute(	dExpMainTemp,
																	hash(	vehicle_key,
																				state_origin,
																				source_code,
																				orig_vin,
																				model_year,
																				make_desc,
																				series_desc,
																				vehicle_type_desc,
																				model_desc,
																				body_style_desc,
																				// net_weight,				//DF-8238
																				number_of_axles,
																				major_color_desc,
																				minor_color_desc 
																			)
																	);
  
	   
dExpMainTempSort	:=	sort(	dExpMainTempDist,
														vehicle_key,
														state_origin,
														source_code,
														orig_vin,
														model_year,
														make_desc,
														series_desc,
														vehicle_type_desc,
														model_desc,
														body_style_desc,
														// net_weight,				//DF-8238
														number_of_axles,
														major_color_desc,
														minor_color_desc,
														local
													);

recordof(dVehExperianBaseSort) tIterationKey(dVehExperianBaseSort	le,dExpMainTempDist	ri)	:=
transform
	self.iteration_key	:=	ri.iteration_key;
	self								:=	le;
end;

dExpPartyIterationKey	:=	join(	dVehExperianBaseSort,
																dExpMainTempDist,
																left.vehicle_key					=	right.vehicle_key						and
																left.state_origin					=	right.state_origin					and
																left.source_code					=	right.source_code						and
																left.orig_vin							=	right.orig_vin							and
																left.model_year						=	right.model_year						and
																left.make_desc						=	right.make_desc							and
																left.series_desc					=	right.series_desc						and
																left.vehicle_type_desc		=	right.vehicle_type_desc			and
																left.model_desc						=	right.model_desc						and
																left.body_style_desc			=	right.body_style_desc				and																
																// left.net_weight						=	right.net_weight						and			//DF-8238
																left.number_of_axles			=	right.number_of_axles				and
																left.major_color_desc			=	right.major_color_desc			and
																left.minor_color_desc			=	right.minor_color_desc,
																tIterationKey(left,right),
																local
															);

export Map_Experian_Party_Temp := dedup(dExpPartyIterationKey,all,local)	:	persist('~thor_data400::persist::vehiclev2::experian_party_temp');
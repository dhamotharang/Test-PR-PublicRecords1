import ut, didville, VehicleV2_Services;

export RealTime_Batch_Service_V2_records(dataset(Batch_Layout.RealTime_InLayout_V2) inputdata, 
																				 VehicleV2_Services.IParam.RTBatch_V2_params in_mod, BOOLEAN Is_VehV2 = False) := function
	
	input_clean := VehicleV2_Services.Functions_RTBatch_V2.clean(inputdata, in_mod);
	// 127542 - Fetch -in-house VIN matched records. Is_VehV2 keeps other services logic as it is. 
	// Use_date and Select_year to check if the options are true.Used for filtering in-house recs based on date/no. of years entered.
	vin_recs := VehicleV2_Services.Vin_Batch_Service_records(project(input_clean, VehicleV2_Services.Functions_RTBatch_V2.to_vin(left)),in_mod);
		
	licplate_recs := VehicleV2_Services.LicPlate_Batch_Service_records(project(input_clean, VehicleV2_Services.Functions_RTBatch_V2.to_licplate(left)),in_mod);

	not_in_licplate_recs := join(vin_recs, licplate_recs, left.acctno = right.acctno, left only);
	default_recs := not_in_licplate_recs + licplate_recs;

	inhouse_recs_ := map(in_mod.operation = VehicleV2_Services.Constant.LICPLATEANDSTATE_VAL => licplate_recs,
											in_mod.operation = VehicleV2_Services.Constant.VIN_VAL => vin_recs,								
											default_recs) ((reg_latest_effective_date <> '' and reg_latest_expiration_date <> '') OR NonDMVSource );
											
	// 127542 - ONLY FOR VEHICLES-V2 Added SSN ,DOB,NAME - Fields on which inhouse data will be filtered.
	// Is_VehV2 will take care that other services are not affected.
	// LicPlate data will be filtered on the current plate match and not on historical plate.
	inhouse_recs := join(input_clean, inhouse_recs_,
																											LEFT.acctno = RIGHT.acctno
															 AND	(~Is_VehV2
															 OR (((LEFT.dob='') OR (LEFT.dob = RIGHT.reg_1_dob OR LEFT.dob = RIGHT.reg_2_dob))
															 AND ((LEFT.ssn='') OR (LEFT.ssn = RIGHT.reg_1_ssn OR LEFT.ssn = RIGHT.reg_2_ssn))
															 AND ((LEFT.plate='') OR (LEFT.plate = RIGHT.Reg_True_License_Plate))
															 AND ((LEFT.name_first='') OR TRIM(LEFT.name_first) = RIGHT.reg_1_fname 
																												 OR TRIM(LEFT.name_first) = RIGHT.reg_2_fname)))
															 AND  (LEFT.date <> '' OR (VehicleV2_Services.Functions_RTBatch_V2.ValidExpirationDate(RIGHT.reg_latest_expiration_date) OR Is_VehV2)),
		transform(VehicleV2_Services.Layouts_RTBatch_V2.rec_out,
			self.hit_flag := 'IN';
			self := right;
			self := []));

	not_in_inhouse_recs := join(input_clean, inhouse_recs, left.acctno = right.acctno, left only);
	// 127542 - For Experian Hit gateways whether data in found in-house or not.
	// 					For Polk Hit gateways only if no in-house data found. 	
	prep_realtime_recs := if(in_mod.AlwaysHitGateway , input_clean, Project(not_in_inhouse_recs,recordof(input_clean)));
	
	valid_cityst_zip := ((prep_realtime_recs.p_city_name <> '' AND prep_realtime_recs.st <> '') OR (prep_realtime_recs.z5 <> ''));
	
	valid_input := prep_realtime_recs.name_last <> '' AND prep_realtime_recs.addr1 <> '' AND valid_cityst_zip
								 OR
								 prep_realtime_recs.vinin <> ''
								 OR
								 prep_realtime_recs.plate <> '' AND (prep_realtime_recs.platestate <> '' OR prep_realtime_recs.st <> '')
								 OR
								 prep_realtime_recs.comp_name <> '' AND prep_realtime_recs.addr1 <> '' AND valid_cityst_zip;

	for_realtime_recs := project(prep_realtime_recs(valid_input), VehicleV2_Services.Batch_Layout.RealTime_InLayout);
	
	rejected_recs := join(not_in_inhouse_recs, for_realtime_recs, left.acctno = right.acctno, 
		transform(VehicleV2_Services.Layouts_RTBatch_V2.rec_out,
			self.acctno := left.acctno;
			self.hit_flag := 'REJ';
			self := []), left only);

	realtime_recs_ := VehicleV2_Services.RealTime_Batch_Service_Records(for_realtime_recs, in_mod.operation, in_mod.GatewayNameMatch,in_mod.Is_UseDate);
	
	realtime_recs := project(realtime_recs_, transform(VehicleV2_Services.Layouts_RTBatch_V2.rec_out,
		self.hit_flag := if(left.vin <> '', 'RT', 'NO');
		self := left;
		self := []));
		
	recs := inhouse_recs + realtime_recs + rejected_recs;
	
	// end of inhouse and realtime processing - beginning of best info fetch
	
	ut.MAC_Sequence_Records(recs, seq, recs_seq) // don't want to lose recs within accounts when calling did_service_common_function (best info)
	
	for_bestinfo_reg1_recs := project(recs_seq(hit_flag in ['RT', 'IN']), VehicleV2_Services.Functions_RTBatch_V2.to_reg1(left)) (lname <> '');
	for_bestinfo_reg2_recs := project(recs_seq(hit_flag in ['RT', 'IN']), VehicleV2_Services.Functions_RTBatch_V2.to_reg2(left)) (lname <> '');

	dedup_results := in_mod.dedup_results_l;
	appends := stringlib.stringtouppercase(in_mod.append_l);
	verify := stringlib.stringtouppercase(in_mod.verify_l);
	thresh_num := (unsigned2)in_mod.thresh_val;
	fuzzy := stringlib.stringtouppercase(in_mod.fuzzy_l);

	hhidplus := stringlib.stringfind(appends,'HHID_PLUS',1)<>0;
	edabest := stringlib.stringfind(appends,'BEST_EDA',1)<>0;	
	
	bestinfo_reg1_recs := didville.did_service_common_function(
													file_in            := for_bestinfo_reg1_recs, 
													appends_value      := appends, 
													verify_value       := verify,
													fuzzy_value        := fuzzy,
													dedup_flag         := dedup_results,
													threshold_value    := thresh_num,
													glb_flag           := false,
													patriot_flag       := in_mod.patriotproc,
													lookups_flag       := false,
													livingsits_flag    := false,
													hhidplus_value     := hhidplus,
													edabest_value      := edabest,
													glb_purpose_value  := in_mod.glb,
													include_minors     := in_mod.show_minors,
													appType            := in_mod.application_type,
													dppa_purpose_value := in_mod.dppa,
													IndustryClass_val  := in_mod.industry_class,
													DRM_val            := in_mod.DataRestrictionMask,
													GetSSNBest         := in_mod.GetSSNBest
												);

	bestinfo_reg2_recs := didville.did_service_common_function(
													file_in            := for_bestinfo_reg2_recs, 
													appends_value      := appends, 
													verify_value       := verify,
													fuzzy_value        := fuzzy,
													dedup_flag         := dedup_results,
													threshold_value    := thresh_num,
													glb_flag           := false,
													patriot_flag       := in_mod.patriotproc,
													lookups_flag       := false,
													livingsits_flag    := false,
													hhidplus_value     := hhidplus,
													edabest_value      := edabest,
													glb_purpose_value  := in_mod.glb,
													include_minors     := in_mod.show_minors,
													appType            := in_mod.application_type,
													dppa_purpose_value := in_mod.dppa,
													IndustryClass_val  := in_mod.industry_class,
													DRM_val            := in_mod.DataRestrictionMask,
													GetSSNBest         := in_mod.GetSSNBest
												);
					
	reg1 := ungroup(bestinfo_reg1_recs);
	reg2 := ungroup(bestinfo_reg2_recs);
 
	best_recs := VehicleV2_Services.Get_Ranked_Best_Addr(project(reg1 + reg2, DidVille.Layout_Did_OutBatch));
	res_w_reg1 := join(recs_seq, if(in_mod.includeRanking, best_recs,reg1), left.seq = right.seq and (unsigned)left.reg_1_did = right.did, transform(VehicleV2_Services.Layouts_RTBatch_V2.rec_out,
		self.reg_1_ssn := if (in_mod.include_ssn, right.best_ssn, '');
		self.reg_1_dob := if (in_mod.include_dob, right.best_dob, '');
		self.reg_1_best_addr1 := if (in_mod.include_addr, right.best_addr1, '');
		self.reg_1_best_city := if (in_mod.include_addr, right.best_city, '');
		self.reg_1_best_state := if (in_mod.include_addr, right.best_state, '');
		self.reg_1_best_zip := if (in_mod.include_addr, right.best_zip, '');
		self.reg_1_best_phone := if (in_mod.include_phone, right.best_phone, '');
		self := left), left outer);
	res_w_reg1_reg2 := join(res_w_reg1, if(in_mod.includeRanking, best_recs,reg2), left.seq = right.seq and (unsigned)left.reg_2_did = right.did, transform(VehicleV2_Services.Layouts_RTBatch_V2.rec_out,
		self.reg_2_ssn := if (in_mod.include_ssn, right.best_ssn, '');
		self.reg_2_dob := if (in_mod.include_dob, right.best_dob, '');
		self.reg_2_best_addr1 := if (in_mod.include_addr, right.best_addr1, '');
		self.reg_2_best_city := if (in_mod.include_addr, right.best_city, '');
		self.reg_2_best_state := if (in_mod.include_addr, right.best_state, '');
		self.reg_2_best_zip := if (in_mod.include_addr, right.best_zip, '');
		self.reg_2_best_phone := if (in_mod.include_phone, right.best_phone, '');
		self := left), left outer);
	
	res := join(input_clean, res_w_reg1_reg2, left.acctno = right.acctno);

	// output(recs_seq,NAMED('recs_seq'));
	// output(for_bestinfo_reg1_recs,NAMED('for_bestinfo_reg1_recs'));
	// output(for_bestinfo_reg2_recs,NAMED('for_bestinfo_reg2_recs'));
	// output(bestinfo_reg1_recs,NAMED('bestinfo_reg1_recs'));
	// output(bestinfo_reg2_recs,NAMED('bestinfo_reg2_recs'));
	// output(best_recs,NAMED('best_recs'));
	// output(res_w_reg1,NAMED('res_w_reg1'));
	// output(res_w_reg1_reg2,NAMED('res_w_reg1_reg2'));
	return res;
end;

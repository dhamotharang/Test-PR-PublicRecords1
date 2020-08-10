IMPORT ut, didville, VehicleV2_Services, STD;

EXPORT RealTime_Batch_Service_V2_records(DATASET(Batch_Layout.RealTime_InLayout_V2) inputdata,
                                         VehicleV2_Services.IParam.RTBatch_V2_params in_mod, BOOLEAN Is_VehV2 = FALSE) := FUNCTION
  
  input_clean := VehicleV2_Services.Functions_RTBatch_V2.clean(inputdata, in_mod);
  // 127542 - Fetch -in-house VIN matched records. Is_VehV2 keeps other services logic as it is.
  // Use_date and Select_year to check if the options are true.Used for filtering in-house recs based on date/no. of years entered.
  vin_recs := VehicleV2_Services.Vin_Batch_Service_records(PROJECT(input_clean, VehicleV2_Services.Functions_RTBatch_V2.to_vin(LEFT)),in_mod);
    
  licplate_recs := VehicleV2_Services.LicPlate_Batch_Service_records(PROJECT(input_clean, VehicleV2_Services.Functions_RTBatch_V2.to_licplate(LEFT)),in_mod);

  not_in_licplate_recs := JOIN(vin_recs, licplate_recs, LEFT.acctno = RIGHT.acctno, LEFT only);
  default_recs := not_in_licplate_recs + licplate_recs;

  inhouse_recs_ := MAP(in_mod.operation = VehicleV2_Services.Constant.LICPLATEANDSTATE_VAL => licplate_recs,
                      in_mod.operation = VehicleV2_Services.Constant.VIN_VAL => vin_recs,
                      default_recs) ((reg_latest_effective_date <> '' AND reg_latest_expiration_date <> '') OR NonDMVSource );
                      
  // 127542 - ONLY FOR VEHICLES-V2 Added SSN ,DOB,NAME - Fields on which inhouse data will be filtered.
  // Is_VehV2 will take care that other services are not affected.
  // LicPlate data will be filtered on the current plate match and not on historical plate.
  inhouse_recs := JOIN(input_clean, inhouse_recs_,
                                                      LEFT.acctno = RIGHT.acctno
                               AND (~Is_VehV2
                               OR (((LEFT.dob='') OR (LEFT.dob = RIGHT.reg_1_dob OR LEFT.dob = RIGHT.reg_2_dob))
                               AND ((LEFT.ssn='') OR (LEFT.ssn = RIGHT.reg_1_ssn OR LEFT.ssn = RIGHT.reg_2_ssn))
                               AND ((LEFT.plate='') OR (LEFT.plate = RIGHT.Reg_True_License_Plate))
                               AND ((LEFT.name_first='') OR TRIM(LEFT.name_first) = RIGHT.reg_1_fname
                                                         OR TRIM(LEFT.name_first) = RIGHT.reg_2_fname)))
                               AND (LEFT.date <> '' OR (VehicleV2_Services.Functions_RTBatch_V2.ValidExpirationDate(RIGHT.reg_latest_expiration_date) OR Is_VehV2)),
    TRANSFORM(VehicleV2_Services.Layouts_RTBatch_V2.rec_out,
      SELF.hit_flag := 'IN';
      SELF := RIGHT;
      SELF := []));

  not_in_inhouse_recs := JOIN(input_clean, inhouse_recs, LEFT.acctno = RIGHT.acctno, LEFT only);
  // 127542 - For Experian Hit gateways whether data in found in-house or not.
  // For Polk Hit gateways only IF no in-house data found.
  prep_realtime_recs := IF(in_mod.AlwaysHitGateway , input_clean, PROJECT(not_in_inhouse_recs,RECORDOF(input_clean)));
  
  valid_cityst_zip := ((prep_realtime_recs.p_city_name <> '' AND prep_realtime_recs.st <> '') OR (prep_realtime_recs.z5 <> ''));
  
  valid_input := prep_realtime_recs.name_last <> '' AND prep_realtime_recs.addr1 <> '' AND valid_cityst_zip
                 OR
                 prep_realtime_recs.vinin <> ''
                 OR
                 prep_realtime_recs.plate <> '' AND (prep_realtime_recs.platestate <> '' OR prep_realtime_recs.st <> '')
                 OR
                 prep_realtime_recs.comp_name <> '' AND prep_realtime_recs.addr1 <> '' AND valid_cityst_zip;

  for_realtime_recs := PROJECT(prep_realtime_recs(valid_input), VehicleV2_Services.Batch_Layout.RealTime_InLayout);
  
  rejected_recs := JOIN(not_in_inhouse_recs, for_realtime_recs, LEFT.acctno = RIGHT.acctno,
    TRANSFORM(VehicleV2_Services.Layouts_RTBatch_V2.rec_out,
      SELF.acctno := LEFT.acctno;
      SELF.hit_flag := 'REJ';
      SELF := []), LEFT only);

  realtime_recs_ := VehicleV2_Services.RealTime_Batch_Service_Records(for_realtime_recs, in_mod.operation, in_mod.GatewayNameMatch,in_mod.Is_UseDate);
  
  realtime_recs := PROJECT(realtime_recs_, TRANSFORM(VehicleV2_Services.Layouts_RTBatch_V2.rec_out,
    SELF.hit_flag := IF(LEFT.vin <> '', 'RT', 'NO');
    SELF := LEFT;
    SELF := []));
    
  recs := inhouse_recs + realtime_recs + rejected_recs;
  
  // end of inhouse and realtime processing - beginning of best info fetch
  
  ut.MAC_Sequence_Records(recs, seq, recs_seq) // don't want to lose recs within accounts when calling did_service_common_FUNCTION (best info)
  
  for_bestinfo_reg1_recs := PROJECT(recs_seq(hit_flag in ['RT', 'IN']), VehicleV2_Services.Functions_RTBatch_V2.to_reg1(LEFT)) (lname <> '');
  for_bestinfo_reg2_recs := PROJECT(recs_seq(hit_flag in ['RT', 'IN']), VehicleV2_Services.Functions_RTBatch_V2.to_reg2(LEFT)) (lname <> '');

  dedup_results := in_mod.dedup_results_l;
  appends := STD.STR.ToUpperCase(in_mod.append_l);
  verify := STD.STR.ToUpperCase(in_mod.verIFy_l);
  thresh_num := (UNSIGNED2)in_mod.thresh_val;
  fuzzy := STD.STR.ToUpperCase(in_mod.fuzzy_l);

  hhidplus := STD.STR.Find(appends,'HHID_PLUS',1)<>0;
  edabest := STD.STR.Find(appends,'BEST_EDA',1)<>0;
  
  bestinfo_reg1_recs := didville.did_service_common_function(
    file_in := for_bestinfo_reg1_recs,
    appends_value := appends,
    verify_value := verify,
    fuzzy_value := fuzzy,
    dedup_flag := dedup_results,
    threshold_value := thresh_num,
    glb_flag := FALSE,
    patriot_flag := in_mod.patriotproc,
    lookups_flag := FALSE,
    livingsits_flag := FALSE,
    hhidplus_value := hhidplus,
    edabest_value := edabest,
    glb_purpose_value := in_mod.glb,
    include_minors := in_mod.show_minors,
    appType := in_mod.application_type,
    dppa_purpose_value := in_mod.dppa,
    IndustryClass_val := in_mod.industry_class,
    DRM_val := in_mod.DataRestrictionMask,
    GetSSNBest := in_mod.GetSSNBest
  );

  bestinfo_reg2_recs := didville.did_service_common_function(
    file_in := for_bestinfo_reg2_recs,
    appends_value := appends,
    verify_value := verify,
    fuzzy_value := fuzzy,
    dedup_flag := dedup_results,
    threshold_value := thresh_num,
    glb_flag := FALSE,
    patriot_flag := in_mod.patriotproc,
    lookups_flag := FALSE,
    livingsits_flag := FALSE,
    hhidplus_value := hhidplus,
    edabest_value := edabest,
    glb_purpose_value := in_mod.glb,
    include_minors := in_mod.show_minors,
    appType := in_mod.application_type,
    dppa_purpose_value := in_mod.dppa,
    IndustryClass_val := in_mod.industry_class,
    DRM_val := in_mod.DataRestrictionMask,
    GetSSNBest := in_mod.GetSSNBest
  );
          
  reg1 := UNGROUP(bestinfo_reg1_recs);
  reg2 := UNGROUP(bestinfo_reg2_recs);
 
  best_recs := VehicleV2_Services.Get_Ranked_Best_Addr(PROJECT(reg1 + reg2, DidVille.Layout_Did_OutBatch));
  res_w_reg1 := JOIN(recs_seq, IF(in_mod.includeRanking, best_recs,reg1), LEFT.seq = RIGHT.seq AND (UNSIGNED)LEFT.reg_1_did = RIGHT.did, TRANSFORM(VehicleV2_Services.Layouts_RTBatch_V2.rec_out,
    SELF.reg_1_ssn := IF (in_mod.include_ssn, RIGHT.best_ssn, '');
    SELF.reg_1_dob := IF (in_mod.include_dob, RIGHT.best_dob, '');
    SELF.reg_1_best_addr1 := IF (in_mod.include_addr, RIGHT.best_addr1, '');
    SELF.reg_1_best_city := IF (in_mod.include_addr, RIGHT.best_city, '');
    SELF.reg_1_best_state := IF (in_mod.include_addr, RIGHT.best_state, '');
    SELF.reg_1_best_zip := IF (in_mod.include_addr, RIGHT.best_zip, '');
    SELF.reg_1_best_phone := IF (in_mod.include_phone, RIGHT.best_phone, '');
    SELF := LEFT), LEFT OUTER);
  res_w_reg1_reg2 := JOIN(res_w_reg1, IF(in_mod.includeRanking, best_recs,reg2), LEFT.seq = RIGHT.seq AND (UNSIGNED)LEFT.reg_2_did = RIGHT.did, TRANSFORM(VehicleV2_Services.Layouts_RTBatch_V2.rec_out,
    SELF.reg_2_ssn := IF (in_mod.include_ssn, RIGHT.best_ssn, '');
    SELF.reg_2_dob := IF (in_mod.include_dob, RIGHT.best_dob, '');
    SELF.reg_2_best_addr1 := IF (in_mod.include_addr, RIGHT.best_addr1, '');
    SELF.reg_2_best_city := IF (in_mod.include_addr, RIGHT.best_city, '');
    SELF.reg_2_best_state := IF (in_mod.include_addr, RIGHT.best_state, '');
    SELF.reg_2_best_zip := IF (in_mod.include_addr, RIGHT.best_zip, '');
    SELF.reg_2_best_phone := IF (in_mod.include_phone, RIGHT.best_phone, '');
    SELF := LEFT), LEFT OUTER);
  
  res := JOIN(input_clean, res_w_reg1_reg2, LEFT.acctno = RIGHT.acctno);

  RETURN res;
END;

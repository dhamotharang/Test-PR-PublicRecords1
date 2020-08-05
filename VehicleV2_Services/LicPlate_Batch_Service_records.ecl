IMPORT doxie, Autokey_batch, Address, VehicleV2, BatchServices, AutokeyB2, AutoStandardI,VehicleV2_Services,STD;

EXPORT LicPlate_Batch_Service_records(DATASET(Batch_Layout.LicPlate_InLayout) data_in,
                                      VehicleV2_Services.IParam.VehicleBatch_params in_param) := FUNCTION

  // Keys
  keyVDID := VehicleV2.Key_Vehicle_DID;
  keyVLP := VehicleV2.Key_Vehicle_Lic_plate;

  // Aliases
  Consts := VehicleV2.Constant;
  LICPlateBatchInput := Batch_Layout.LicPlate_InLayout;
  AutoKeyBatchInput := Autokey_batch.Layouts.rec_inBatchMaster;
  ResultFlat := Batch_Layout.layout_out;
  OutRec := Batch_Layout.final_layout;


  // Constants
  STRING BLNK := '';
  STRING NOT_NUMBER := '\\D+';
  UNSIGNED MaxDIDs := 100;
  UNSIGNED MaxPLs := 2000;
  SET OF STRING NoLICPlates := ['', 'NOPLATE', 'NO PLATE'];


  // Helper functions
  trimBoth(STRING input) := TRIM(input, LEFT, RIGHT);
  toUpper(STRING input) := STD.STR.ToUpperCase(trimBoth(input));

  blankOrMatch(STRING lStr, STRING rStr) := FUNCTION
    STRING lStr_m := trimBoth(lStr);
    RETURN lStr_m = BLNK OR lStr_m = rStr;
  END;

  descUnmatch(STRING lStr, STRING rStr) := lStr <> BLNK AND STD.STR.Find(toUpper(rStr), toUpper(lStr), 1) = 0;

  // Records/Transforms
  VehicleV2_Services.Layout_VKeysWithInput cleanInput(LICPlateBatchInput input) := TRANSFORM
    state_in := toUpper(input.st);
    dlstate_in := toUpper(input.dlstate);
    plstate_in := toUpper(input.PlateState);

    SELF.name_first := toUpper(input.name_first);
    SELF.name_middle := toUpper(input.name_middle);
    SELF.name_last := toUpper(input.name_last);
    SELF.name_suffix := toUpper(input.name_suffix);
    SELF.p_city_name := toUpper(input.p_city_name);
    SELF.st := IF(LENGTH(state_in) > 2, Address.Map_State_Name_To_Abbrev(state_in), state_in);
    SELF.ssn := REGEXREPLACE(NOT_NUMBER, input.ssn, BLNK);
    SELF.dl := toUpper(input.dl);
    SELF.dlstate := IF(LENGTH(dlstate_in) > 2, Address.Map_State_Name_To_Abbrev(dlstate_in), dlstate_in);
    SELF.Plate := toUpper(input.Plate);
    SELF.PlateState := IF(LENGTH(plstate_in) > 2, Address.Map_State_Name_To_Abbrev(plstate_in), plstate_in);
    SELF.make := toUpper(input.make);
    SELF.model := toUpper(input.model);
    SELF.color := toUpper(input.color);
    SELF := input;
    SELF := [];
  END;

  AcctRec := RECORD(VehicleV2_Services.Layout_Vehicle_Key)
    LICPlateBatchInput.acctno;
    UNSIGNED6 did := 0;
    LICPlateBatchInput.Plate;
  END;

  AcctRec fromKeyVDID(AcctRec l, keyVDID r) := TRANSFORM
    SELF.did := r.Append_DID;
    SELF := r;
    SELF := l;
  END;

  AcctRec fromKeyVLP(VehicleV2_Services.Layout_VKeysWithInput l, keyVLP r, BOOLEAN isDD = FALSE) := TRANSFORM
    SELF.Plate := r.license_plate;
    SELF.is_deep_dive := isDD;
    SELF := r;
    SELF := l;
  END;

  OutRec toOutput(ResultFlat l, VehicleV2_Services.Layout_VKeysWithInput r) := TRANSFORM,
  SKIP(descUnmatch(r.year, l.model_year) OR descUnmatch(r.make, l.make_desc) OR
       descUnmatch(r.model, l.model_desc) OR descUnmatch(r.color, l.major_color_desc))
       
    _effective_date := IF(in_param.Is_UseDate, Functions_RTBatch_V2.min_date(l.reg_latest_effective_date, l.reg_earliest_effective_date), l.reg_latest_effective_date);

    BOOLEAN filterByDate := LENGTH(TRIM(r.date))=8 AND _effective_date<>'' AND l.reg_latest_expiration_date<>'';

    BOOLEAN filterByYear := LENGTH(TRIM(r.date))=4 AND _effective_date<>'' AND (~in_param.Is_UseDate OR l.reg_latest_expiration_date<>'');

    BOOLEAN keepRec := MAP(filterByDate => r.date BETWEEN _effective_date AND l.reg_latest_expiration_date
                        , filterByYear => IF(in_param.Is_UseDate, r.date BETWEEN _effective_date[1..4] AND l.reg_latest_expiration_date[1..4]
                                                         ,l.reg_latest_effective_date[1..4] >= r.date),
                           TRUE);
    SELF.acctNo := IF(keepRec,l.acctNo,SKIP);
    SELF := l;
  END;

  // Main
  BOOLEAN return_current_only := in_param.ReturnCurrent;
  BOOLEAN return_fullname_only := in_param.FullNameMatch;
  UNSIGNED2 rsltsPerInput := AutoStandardI.InterfaceTranslator.MaxResults_val.val(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.InterfaceTranslator.MaxResults_val.params));

  cfgs := MODULE(BatchServices.Interfaces.i_AK_Config)
    EXPORT useAllLookups := TRUE;
    EXPORT skip_set := Consts.autokey_skip_set;
  END;

  // Search via AutoKey
  input_c := PROJECT(data_in, cleanInput(LEFT));
  input_ak := PROJECT(input_c(Plate IN NoLICPlates), AutoKeyBatchInput);
  fids := UNGROUP(Autokey_batch.get_fids(input_ak, Consts.str_autokeyname, cfgs));
  pl_rec := DATASET([], VehicleV2_Services.assorted_layouts.layout_common);
  AutokeyB2.mac_get_payload(fids, Consts.str_autokeyname, pl_rec, with_pl, append_did, append_bdid, Consts.autokey_typeStr);
  with_pl_x := PROJECT(with_pl, TRANSFORM(AcctRec, SELF.did := LEFT.append_did, SELF := LEFT, SELF := []));
  fromAK := DEDUP(SORT(with_pl_x, acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin),
                  acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin);

  // Search via DID lookup
  notFoundAccts := JOIN(input_ak, fromAK, LEFT.acctno = RIGHT.acctno, TRANSFORM(LEFT), LEFT ONLY);
  dDidsAcctno := BatchServices.Functions.fn_find_dids_and_append_to_acctno(notFoundAccts);
  dWithDIDs := JOIN(notFoundAccts, dDidsAcctno,
    LEFT.acctno = RIGHT.acctno,
    TRANSFORM(AcctRec,
      SELF.did := RIGHT.did,
      SELF := LEFT,
      SELF.vehicle_key := '',
      SELF.iteration_key:= ''),
    LEFT OUTER);
  fromDIDLkup := JOIN(dWithDIDs, keyVDID,
                      KEYED(LEFT.did = RIGHT.Append_DID),
                      fromKeyVDID(LEFT, RIGHT),
                      LIMIT(VehicleV2_Services.Constant.VEHICLE_BATCH_LIMIT));

  // Merge/Sort/Dedup
  m_s_d := DEDUP(SORT(fromAK + fromDIDLkup, acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin),
                 acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin);

  // Make a choice
  did_acctno := IF(cfgs.RunDeepDive AND EXISTS(notFoundAccts), m_s_d, fromAK);

  // Search by license plate number
  input_lp := input_c(trimBoth(Plate) NOT IN NoLICPlates);
  withLPInput := JOIN(input_lp, keyVLP,
                      KEYED(trimBoth(LEFT.Plate) = RIGHT.license_plate AND
                            blankOrMatch(LEFT.PlateState, RIGHT.state_origin)),
                      fromKeyVLP(LEFT, RIGHT, TRUE),
                      LIMIT(MaxPLs, SKIP));
  
  lp_acctno := DEDUP(SORT(withLPInput, acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin),
                     acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin);

  acctNos := DEDUP(SORT(did_acctno + lp_acctno, acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin),
                   acctno, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin);

  acctNos_i := JOIN(acctNos, input_c,
                    LEFT.acctno = RIGHT.acctno,
                    TRANSFORM(VehicleV2_Services.Layout_VKeysWithInput, SELF := LEFT, SELF := RIGHT), KEEP(1));

  // Get matches
  matches_tmp := VehicleV2_Services.Batch_transforms.get_flatLayout(acctNos_i, return_current_only);
  
  matches_d := DEDUP(SORT(matches_tmp, acctno, vin, -vendor_date, vendor_first_reported_date, -is_current),
                     acctno, vin, vendor_date, vendor_first_reported_date, is_current);
  
  NameMatches(fname1, mname1, lname1, fname2, mname2, lname2) := MACRO
      DataLib.NameMatch(fname1, mname1, lname1, fname2, mname2, lname2) <= Constant.NAME_MATCH_MAX_VAL
  ENDMACRO;

  FullNamesMatch() := MACRO
      trimBoth(RIGHT.name_first) = BLNK
      OR
      (trimBoth(LEFT.own_1_fname) = BLNK
        AND trimBoth(LEFT.own_2_fname) = BLNK
        AND trimBoth(LEFT.reg_1_fname) = BLNK
        AND trimBoth(LEFT.reg_2_fname) = BLNK)
      OR
      NameMatches(LEFT.own_1_fname, LEFT.own_1_mname, LEFT.own_1_lname,
            RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last)
      OR
      NameMatches(LEFT.own_2_fname, LEFT.own_2_mname, LEFT.own_2_lname,
            RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last)
      OR
      NameMatches(LEFT.reg_1_fname, LEFT.reg_1_mname, LEFT.reg_1_lname,
            RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last)
      OR
      NameMatches(LEFT.reg_2_fname, LEFT.reg_2_mname, LEFT.reg_2_lname,
            RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last)
  ENDMACRO;

  matches_xlt := JOIN(matches_d, input_c, LEFT.acctno = RIGHT.acctno AND (~return_fullname_only OR FullNamesMatch()), toOutput(LEFT, RIGHT));
  
  // To make MaxResults work, uncomment the following line.
  // rslt := TOPN(GROUP(SORT(matches_xlt, acctno), acctno), rsltsPerInput, acctno, -is_current, penalt, -vendor_date);
  rslt := SORT(matches_xlt, acctno, -is_current, penalt, -reg_latest_effective_date, -reg_latest_expiration_date, -vendor_date);

  RETURN rslt;

END;

IMPORT BatchServices, FCRAGateway_Services, Gateway, InsuranceHeader_RemoteLinking, STD;
IMPORT $;

//This function utilizes remote linking logic to return matches where lexID validation has failed.
EXPORT fn_get_remote_linking_matches(DATASET(BatchServices.layout_BankruptcyV3_Batch_in) bk_requests,
  DATASET(BatchServices.layout_BankruptcyV3_Batch_out) bk_results, DATASET(Gateway.layouts.config) gateways) := FUNCTION

  toUpper := STD.Str.ToUpperCase;
  bk_out_layout := BatchServices.layout_BankruptcyV3_Batch_out;
  bk_in_layout := BatchServices.layout_BankruptcyV3_Batch_in;
  bk_rl_layout := BatchServices.layout_BankruptcyV3_Remote_Linking;

  //Add sequenceNo to bk_results so we can join with RL matches later.
  bk_results_seq := PROJECT(bk_results,
    TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_out, SELF.sequenceNumber := COUNTER, SELF := LEFT));

  //Normalize bk results to process AKAs in debtor_2_* through debtor_5_* and place them in the debtor_1 field.
  bk_out_layout normalize_bk_results(bk_out_layout L, INTEGER C) := TRANSFORM
    SELF.sequenceNumber := L.sequenceNumber;

    //Require at least a first name in order to normalize the AKAs. This will skip blank entries, which are common.
    fname := CHOOSE(C, L.debtor_1_fname, L.debtor_2_fname, L.debtor_3_fname, L.debtor_4_fname, L.debtor_5_fname, '');
    SELF.debtor_1_fname := IF(fname = '', SKIP, fname);

    //Assign AKAs to debtor_1 field based on counter.
    SELF.debtor_1_name_suffix := CHOOSE(C, L.debtor_1_name_suffix, L.debtor_2_name_suffix, L.debtor_3_name_suffix, L.debtor_4_name_suffix, L.debtor_5_name_suffix, '');
    SELF.debtor_1_mname := CHOOSE(C, L.debtor_1_mname, L.debtor_2_mname, L.debtor_3_mname, L.debtor_4_mname, L.debtor_5_mname, '');
    SELF.debtor_1_lname := CHOOSE(C, L.debtor_1_lname, L.debtor_2_lname, L.debtor_3_lname, L.debtor_4_lname, L.debtor_5_lname, '');

    //Assign the rest of the needed PII.
    SELF.debtor_did := L.debtor_did;
    SELF.debtor_ssnmatch := L.debtor_ssnmatch;
    SELF.debtor_ssn := L.debtor_ssn;
    SELF.debtor_prim_name := L.debtor_prim_name;
    SELF.debtor_prim_range := L.debtor_prim_range;
    SELF.debtor_sec_range := L.debtor_sec_range;
    SELF.debtor_p_city_name := L.debtor_p_city_name;
    SELF.debtor_st := L.debtor_st;
    SELF.debtor_zip := L.debtor_zip;

    //Keep the acctno so we can join the request data to it.
    SELF.acctno := L.acctno;

    //The rest of the data is removed. Since this is only for creating an RL request we have no need of it.
    SELF := [];
  END;

  bk_results_normalized := NORMALIZE(bk_results_seq, $.consts.NAMES_PER_PARTY, normalize_bk_results(LEFT, COUNTER));

  bk_rl_layout add_request_data(bk_in_layout L, bk_out_layout R) := TRANSFORM
    //This sequence number comes from the original bk results.
    SELF.sequenceNumber := R.sequenceNumber;

    //Choose the best SSN.
    SELF.best_ssn := INTFORMAT((INTEGER)IF(R.debtor_ssnmatch <> '', R.debtor_ssnmatch, R.debtor_ssn), 9, 1);

    //Grab values from output, and uppercase them.
    SELF.debtor_1_fname := toUpper(R.debtor_1_fname);
    SELF.debtor_1_mname := toUpper(R.debtor_1_mname);
    SELF.debtor_1_lname := toUpper(R.debtor_1_lname);
    SELF.debtor_1_name_suffix := toUpper(R.debtor_1_name_suffix);
    SELF.debtor_prim_name := toUpper(R.debtor_prim_name);
    SELF.debtor_prim_range := toUpper(R.debtor_prim_range);
    SELF.debtor_sec_range := toUpper(R.debtor_sec_range);
    SELF.debtor_p_city_name := toUpper(R.debtor_p_city_name);
    SELF.debtor_st := toUpper(R.debtor_st);
    SELF.debtor_zip := INTFORMAT((INTEGER)R.debtor_zip, 5, 1);
    SELF.debtor_did := R.debtor_did;

    //Grab the values from input, and uppercase them.
    SELF.did := L.did;
    SELF.ssn := INTFORMAT((INTEGER)L.ssn, 9, 1);
    SELF.name_suffix := toUpper(L.name_suffix);
    SELF.name_first := toUpper(L.name_first);
    SELF.name_middle := toUpper(L.name_middle);
    SELF.name_last := toUpper(L.name_last);
    SELF.prim_name := toUpper(L.prim_name);
    SELF.prim_range := toUpper(L.prim_range);
    SELF.sec_range := toUpper(L.sec_range);
    SELF.p_city_name := toUpper(L.p_city_name);
    SELF.st := toUpper(L.st);
    SELF.z5 := INTFORMAT((INTEGER)L.z5, 5, 1);

    //Intialize hash, conf_score, reference_id, and best_lexid.
    SELF.reference_id := 0;
    SELF.hash_val := 0;
    SELF.conf_score := 0;
    SELF.best_lexID := 0;
  END;

  //Join the input data.
  bk_data_for_rl := JOIN(bk_requests, bk_results_normalized, LEFT.acctno = RIGHT.acctno, add_request_data(LEFT, RIGHT));

  //This function calculates the has of every PII field used to generate an RL request.
  INTEGER calculate_hash(bk_rl_layout bk_data) := FUNCTION
    RETURN HASH(bk_data.did + bk_data.ssn + bk_data.name_suffix + bk_data.name_first + bk_data.name_middle +
      bk_data.name_last + bk_data.prim_name + bk_data.prim_range + bk_data.sec_range +
      bk_data.p_city_name + bk_data.st + bk_data.z5 + bk_data.debtor_1_fname + bk_data.debtor_1_mname +
      bk_data.debtor_1_lname + bk_data.debtor_1_name_suffix + bk_data.debtor_did + bk_data.debtor_prim_name +
      bk_data.debtor_prim_range + bk_data.debtor_sec_range + bk_data.debtor_p_city_name + bk_data.debtor_st +
      bk_data.debtor_zip + bk_data.best_ssn);
  END;

  //Add the hash value for each row. This still contains the sequence number for the original BK Results.
  //We will use the hash to join the deduped RL results back to this, and then back to original BK Results.
  //Also, add a referenceID number for remote linking.
  bk_data_for_rl_w_hash := PROJECT(bk_data_for_rl, TRANSFORM(bk_rl_layout,
    SELF.hash_val := calculate_hash(LEFT), SELF.reference_id := COUNTER, SELF := LEFT));

  //Remove duplicate hash values.
  bk_data_for_rl_dd := DEDUP(SORT(bk_data_for_rl_w_hash, hash_val), hash_val);

  //Create an RL request, then join each result back by reference ID.
  InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout_Batch
    create_rl_request(bk_data_for_rl L) := TRANSFORM
      SELF.Inquiry_Lexid := L.did;
      SELF.SSN_Inq := L.ssn;
      SELF.SNAME_Inq := L.name_suffix;
      SELF.FNAME_Inq := L.name_first;
      SELF.MNAME_Inq := L.name_middle;
      SELF.LNAME_Inq := L.name_last;
      SELF.PRIM_NAME_Inq := L.prim_name;
      SELF.PRIM_RANGE_Inq := L.prim_range;
      SELF.SEC_RANGE_Inq := L.sec_range;
      SELF.CITY_Inq := L.p_city_name;
      SELF.ST_Inq := L.st;
      SELF.ZIP_Inq := L.z5;
      SELF.Results_Lexid := (UNSIGNED6)L.debtor_did;
      SELF.SSN_Res := L.best_ssn;
      SELF.SNAME_Res := L.debtor_1_name_suffix;
      SELF.LNAME_Res := L.debtor_1_lname;
      SELF.FNAME_Res := L.debtor_1_fname;
      SELF.MNAME_Res := L.debtor_1_mname;
      SELF.PRIM_NAME_Res := L.debtor_prim_name;
      SELF.PRIM_RANGE_Res := L.debtor_prim_range;
      SELF.SEC_RANGE_Res := L.debtor_sec_range;
      SELF.CITY_Res := L.debtor_p_city_name;
      SELF.ST_Res := L.debtor_st;
      SELF.ZIP_Res := L.debtor_zip;
      SELF.ReferenceID := L.reference_id;

      //There are quite a few fields for RL requests which are N/A for this service.
      SELF := [];
  END;

  //Create the RL request and call the function.
  remote_linking_request := PROJECT(bk_data_for_rl_dd, create_rl_request(LEFT));
  rl_results := Gateway.SoapCall_RemoteLinking_Batch(remote_linking_request, gateways);

  //Add remote linking results which are matches to the deduped bk_data by reference_id.
  rl_matches_dd := JOIN(bk_data_for_rl_dd, rl_results(match), LEFT.reference_id = RIGHT.ReferenceID,
    TRANSFORM(bk_rl_layout,
      SELF.conf_score := RIGHT.conf,
      SELF.best_lexID := RIGHT.best_lexID,
      SELF := LEFT));

  //Join back to undeduped by HASH val. Any row with the same hash would have generated the same RL request,
  //the left dataset has a sequenceNumber from the original bk results.
  rl_matches := JOIN(bk_data_for_rl_w_hash, rl_matches_dd, LEFT.hash_val = RIGHT.hash_val,
    TRANSFORM(bk_rl_layout,
      SELF.conf_score := RIGHT.conf_score,
      SELF.best_lexID := RIGHT.best_lexID,
      SELF := LEFT));

  //Sort and dedupe by sequenceNumber, and highest conf score
  rl_matches_sorted := DEDUP(SORT(rl_matches, sequenceNumber, -conf_score), sequenceNumber);

  //Add RL data to original bk results by sequence Number. There will be duplicate sequence numbers for each AKA.
  //Keep the RL data from the highest scoring match only.
  bk_out_w_rl_layout := RECORD(bk_out_layout)
    INTEGER conf;
    UNSIGNED6 best_lexID;
  END;

  bk_results_w_rl_data := JOIN(bk_results_seq, rl_matches_sorted, LEFT.sequenceNumber = RIGHT.sequenceNumber,
    TRANSFORM(bk_out_w_rl_layout, SELF.conf := RIGHT.conf_score, SELF.best_lexID := RIGHT.best_lexID, SELF := LEFT));

  //Remove ambiguous matches.
  rl_best_lexIDs := FCRAGateway_Services.fm_keep_best_remote_linking_matches(bk_results_w_rl_data);

  //Transform remote_linking matched results back into original layout and set inquiry_did to best_lexID value.
  rl_batch_out := PROJECT(rl_best_lexIDs,
    TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_out,
      SELF.inquiry_Lexid := (STRING)LEFT.best_lexID, SELF := LEFT));

  // DEBUG-------------------------
  // OUTPUT(bk_results_seq, NAMED('bk_results_seq'));
  // OUTPUT(bk_results_normalized, NAMED('bk_results_normalized'));
  // OUTPUT(bk_data_for_rl, NAMED('bk_data_for_rl'));
  // OUTPUT(bk_data_for_rl_w_hash, NAMED('bk_data_for_rl_w_hash'));
  // OUTPUT(bk_data_for_rl_dd, NAMED('bk_data_for_rl_dd'));
  // OUTPUT(remote_linking_request, NAMED('remote_linking_request'));
  // OUTPUT(rl_results, NAMED('rl_results'));
  // OUTPUT(rl_matches_dd, NAMED('rl_matches_dd'));
  // OUTPUT(rl_matches, NAMED('rl_matches'));
  // OUTPUT(rl_matches_sorted, NAMED('rl_matches_sorted'));
  // OUTPUT(bk_results_w_rl_data, NAMED('bk_results_w_rl_data'));
  // OUTPUT(rl_best_lexIDs, NAMED('rl_best_lexIDs'));
  // OUTPUT(rl_batch_out, NAMED('rl_batch_out'));
  // ------------------------------

  RETURN rl_batch_out;

END;

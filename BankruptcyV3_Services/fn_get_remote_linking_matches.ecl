IMPORT BatchServices, FCRAGateway_Services, Gateway, InsuranceHeader_RemoteLinking, STD;

//This function utilizes remote linking logic to return matches where lexID validation has failed.
EXPORT fn_get_remote_linking_matches(DATASET(BatchServices.layout_BankruptcyV3_Batch_in) inquiry,
  DATASET(BatchServices.layout_BankruptcyV3_Batch_out) results, DATASET(Gateway.layouts.config) gateways) := FUNCTION

  results_seq := PROJECT(results,
    TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_out, SELF.sequenceNumber := COUNTER, SELF := LEFT));

  toUpper := STD.Str.ToUpperCase;

  InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout_Batch
    create_rl_request(BatchServices.layout_BankruptcyV3_Batch_out L, BatchServices.layout_BankruptcyV3_Batch_in R) := TRANSFORM
      SELF.Inquiry_Lexid := R.did;
      SELF.SSN_Inq := INTFORMAT((integer)R.ssn, 9, 1);
      SELF.SNAME_Inq := toUpper(R.name_suffix);
      SELF.FNAME_Inq := toUpper(R.name_first);
      SELF.MNAME_Inq := toUpper(R.name_middle);
      SELF.LNAME_Inq := toUpper(R.name_last);
      SELF.PRIM_NAME_Inq := toUpper(R.prim_name);
      SELF.PRIM_RANGE_Inq := toUpper(R.prim_range);
      SELF.SEC_RANGE_Inq := toUpper(R.sec_range);
      SELF.CITY_Inq := toUpper(R.p_city_name);
      SELF.ST_Inq := toUpper(R.st);
      SELF.ZIP_Inq := toUpper(R.z5);
      SELF.Results_Lexid := (unsigned6)L.debtor_did;
      SELF.SSN_Res := INTFORMAT((integer)L.debtor_ssn, 9, 1);
      SELF.SNAME_Res := toUpper(L.debtor_1_name_suffix);
      SELF.FNAME_Res := toUpper(L.debtor_1_fname);
      SELF.MNAME_Res := toUpper(L.debtor_1_mname);
      SELF.LNAME_Res := toUpper(L.debtor_1_lname);
      SELF.PRIM_NAME_Res := toUpper(L.debtor_prim_name);
      SELF.PRIM_RANGE_Res := toUpper(L.debtor_prim_range);
      SELF.SEC_RANGE_Res := toUpper(L.debtor_sec_range);
      SELF.CITY_Res := toUpper(L.debtor_p_city_name);
      SELF.ST_Res := toUpper(L.debtor_st);
      SELF.ZIP_Res := toUpper(L.debtor_zip);
      SELF.ReferenceID := L.sequenceNumber;
      SELF := [];
  END;

  ds_remote_linking_request := JOIN(results_seq, inquiry,
    LEFT.acctno = RIGHT.acctno, create_rl_request(LEFT, RIGHT), KEEP(1));

  ds_remote_linking_results := Gateway.SoapCall_RemoteLinking_Batch(ds_remote_linking_request, gateways);

  //Define layout with just enough RL data added to results.
  bk_with_rl_layout := RECORD(BatchServices.layout_BankruptcyV3_Batch_out)
    InsuranceHeader_RemoteLinking.Layouts.ServiceOutputLayout_Batch.conf;
    InsuranceHeader_RemoteLinking.Layouts.ServiceOutputLayout_Batch.ReferenceID;
    InsuranceHeader_RemoteLinking.Layouts.ServiceOutputLayout_Batch.best_lexID;
  END;

  bk_with_rl_layout add_rl_data(BatchServices.layout_BankruptcyV3_Batch_out L,
    InsuranceHeader_RemoteLinking.Layouts.ServiceOutputLayout_Batch R) := TRANSFORM
      SELF.ReferenceID := R.ReferenceID;
      SELF.conf := R.conf;
      SELF.best_lexID := R.best_lexID;
      SELF := L;
  END;

  //Add remote linking results back to the relevant bk results if they are a match.
  ds_remote_linking_matches := JOIN(results_seq, ds_remote_linking_results(match),
    LEFT.sequenceNumber = RIGHT.ReferenceID, add_rl_data(LEFT, RIGHT));

  //Keep only best lexID matches.
  ds_rl_best_lexIDs := FCRAGateway_Services.fm_keep_best_remote_linking_matches(ds_remote_linking_matches);

  //Transform remote_linking matched results back into original layout and set inquiry_did to best_lexID value.
  ds_rl_batch_out := PROJECT(ds_rl_best_lexIDs,
    TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_out,
      SELF.inquiry_Lexid := (STRING)LEFT.best_lexID,
      SELF := LEFT));

  RETURN ds_rl_batch_out;

END;
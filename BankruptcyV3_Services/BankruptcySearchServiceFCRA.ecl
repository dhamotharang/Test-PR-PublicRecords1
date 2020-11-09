// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT doxie, Text_Search, FCRA, AutoStandardI, WSInput;

EXPORT BankruptcySearchServiceFCRA(
  ) :=
    MACRO

    //The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_BankruptcyV3_Services_BankruptcySearchServiceFCRA();

    doxie.MAC_Header_Field_Declare(TRUE);
    #CONSTANT('SearchIgnoresAddressOnly',TRUE);
    #STORED('ScoreThreshold',10);
    #STORED('PenaltThreshold',10);
    #CONSTANT('DisplayMatchedParty',TRUE);
    #CONSTANT('NoDeepDive', TRUE);


    /* fetch sorting params */
    INTEGER1 state_sort := 0 : STORED('StateSort');
    INTEGER1 case_sort := 0 : STORED('CaseSort');
    INTEGER1 fdate_sort := 0 : STORED('FileDateSort');
    INTEGER1 lname_sort := 0 : STORED('LastNameSort');
    INTEGER1 cname_sort := 0 : STORED('CompanyNameSort');
    BOOLEAN suppress_withdrawn_bankruptcy := FALSE : STORED('SuppressWithdrawnBankruptcy');
    BOOLEAN Enable_CaseNumFilterSrch := FALSE : STORED('EnableCaseNumberFilterSearch');
    STRING attorney_name_pre := '' : STORED('AttorneyName');
    STRING attorney_name := Std.Str.ToUpperCase(attorney_name_pre);
    STRING court_code_pre := '' : STORED('CourtCode');
    STRING court_code := Std.Str.ToUpperCase(court_code_pre);
    STRING state_value_ucase := Std.Str.ToUpperCase(state_val);
    EnableCaseNumFilter := CaseNumber_value != '' AND Enable_CaseNumFilterSrch;

    cleanCaseNumber(STRING str) := FUNCTION
        arrayOfWords := STD.Str.SplitWords(str,'-');
        cleanStr := arrayOfWords[1] + arrayOfWords[2];
    RETURN(cleanStr);
    END;

    STRING CaseNumber_value_ucase := Std.Str.ToUpperCase(
      IF(EnableCaseNumFilter AND attorney_name <> '', cleanCaseNumber(CaseNumber_value),
        CaseNumber_value)
    );

    //Check if the customer is a Collections customer
    fcra_subj_only := FALSE : STORED ('ApplyNonsubjectRestrictions');
    BOOLEAN isCollections := application_type_value IN AutoStandardI.Constants.COLLECTION_TYPES;
    BOOLEAN returnByDidOnly := fcra_subj_only OR isCollections;
    // Adjust party-type: only [D]ebtors should be used for collections:
    STRING party_type_adj := IF (returnByDidOnly, BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR, party_type);
    nss_default := Suppress.Constants.NonSubjectSuppression.doNothing;
    nss := ut.GetNonSubjectSuppression(nss_default);

    // for FCRA FFD
    valFFDOptionsMask := FFD.FFDMask.Get(inApplicationType := application_type_value);
    BOOLEAN ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(valFFDOptionsMask);
    INTEGER8 inFCRAPurpose := FCRA.FCRAPurpose.Get();

    //------------------------------------------------------------------------------------
    //call gateway only when returnByDidOnly is true
    //if more than one DID is found this call will fail the service with desired error message
    UNSIGNED6 input_did := (UNSIGNED6) did_value;

    // gateways := Gateway.Constants.void_gateway : stored ('gateways', few);
    gateways := Gateway.Configuration.Get();
    picklist_res := FCRA.PickListSoapcall.non_esdl(gateways, TRUE, ~EnableCaseNumFilter AND returnByDidOnly AND (input_did = 0));
    UNSIGNED6 subj_did := IF(returnByDidOnly AND (input_did = 0), (UNSIGNED6) picklist_res[1].Records[1].UniqueId, input_did);
    //------------------------------------------------------------------------------------

    recs := bankruptcyv3_Services.bankruptcy_raw(TRUE).search_view(
      in_ssn_mask := ssn_mask_value,
      in_party_type := party_type_adj,
      in_filing_jurisdiction := FilingJurisdiction_value,
      suppress_withdrawn_bankruptcy := suppress_withdrawn_bankruptcy,
      EnableCaseNumberFilter := EnableCaseNumFilter,
      in_state := state_value_ucase,
      in_ssn := ssn_value,
      in_lname := lname_value,
      in_fname := fname_value,
      in_case_number := CaseNumber_value_ucase,
      in_did := input_did,
      in_city := city_value,
      in_Attorney_Name := Attorney_Name,
      in_court_code := court_code
    );
    rec_out := RECORD
      bankruptcyv3_services.layouts.layout_rollup,
      Text_Search.Layout_ExternalKey,
    END;

    rec_out addExt ( recs l) := TRANSFORM
      SELF := l;
      SELF.ExternalKey := l.TMSID;
    END;
    recs2 := PROJECT(recs, addext(LEFT));

    // sort recs (before MAC_Marshall_Results so that SkipRecords and MaxResultsThisTime are sorted
    recs_srt := bankruptcyv3_services.fn_sort_output(recs2, state_sort, case_sort,
      fdate_sort, lname_sort, cname_sort);

    recs_filt := recs_srt(~returnByDidOnly OR (UNSIGNED6)matched_party.did = subj_did OR EnableCaseNumFilter );

    rec_out xformNonSubject(rec_out L) := TRANSFORM
      debtors_supp := PROJECT(L.debtors((UNSIGNED6)did = subj_did),
        TRANSFORM(BankruptcyV3_Services.layouts.layout_party,
          SELF.names :=
            PROJECT(LEFT.names, TRANSFORM(BankruptcyV3_Services.layouts.layout_name,
              SELF.orig_name := '';
              SELF := LEFT;
            ));
          SELF := LEFT;
        ));
      debtors_restricted := debtors_supp +
        PROJECT(L.debtors(~((UNSIGNED6)did = subj_did)),
          TRANSFORM(BankruptcyV3_Services.layouts.layout_party,
            SELF.names :=
              PROJECT(LEFT.names,
                TRANSFORM(BankruptcyV3_Services.layouts.layout_name,
                  SELF.lname := FCRA.Constants.FCRA_Restricted;
                  SELF := [];
              ));
            SELF := [];
          ));
      SELF.debtors := MAP(
        nss = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => debtors_restricted,
        nss = Suppress.Constants.NonSubjectSuppression.returnBlank => debtors_supp,
        L.debtors
      );
      SELF := L;
    END;
    rsrt_nss := PROJECT(recs_filt, xformNonSubject(LEFT));

    rsrt_final := IF(nss <> Suppress.Constants.NonSubjectSuppression.doNothing,
       rsrt_nss, recs_filt);

    //*************FCRA FFD --- getting FFD statements for matched parties only

    //projecting to common layout for fn_fcra_ffd call
    temp_rollup := PROJECT(rsrt_final, bankruptcyv3_services.layouts.layout_rollup);

    matched_recs := PROJECT(temp_rollup, TRANSFORM(bankruptcyv3_services.layouts.Matched_party_rec, SELF := LEFT.matched_party));

    matched_rec_dids := PROJECT(DEDUP(matched_recs, did, ALL),
      TRANSFORM(FFD.Layouts.DidBatch,
      SELF.acctno := FFD.Constants.SingleSearchAcctno;
      SELF.did := (UNSIGNED6) LEFT.did;
    ));

    ds_subj_did := DATASET([{FFD.Constants.SingleSearchAcctno, subj_did}],FFD.Layouts.DidBatch);

    // even if no data found we still need to check for alerts and consumer level statements for subject
    dsDIDs := IF(EXISTS(matched_rec_dids(did>0)), matched_rec_dids(did>0), ds_subj_did);

    // Call the person context
    pc_recs_prelim := FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Bankruptcy, valFFDOptionsMask);

    // for record level statement/dispute filter to keep data only if subject is debtor
    pc_recs_rlvl := JOIN(pc_recs_prelim(RecordType IN FFD.Constants.RecordType.RecordLevel),
      matched_recs(party_type IN BankruptcyV3_Services.consts.DEBTOR_TYPES),
      (UNSIGNED6) LEFT.LexId = (UNSIGNED6) RIGHT.did,
      TRANSFORM(LEFT), KEEP(1), LIMIT(0));

    pc_recs := pc_recs_rlvl + pc_recs_prelim(RecordType IN FFD.Constants.RecordType.ConsumerLevel);

    // Slim down the PersonContext
    slim_pc_recs := FFD.SlimPersonContext(pc_recs);

    // get FFD compliance records
    temp_results_ffd := BankruptcyV3_Services.fn_fcra_ffd(temp_rollup, slim_pc_recs, valFFDOptionsMask);

    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, inFCRAPurpose, valFFDOptionsMask)[1];
    suppress_results_due_alerts := alert_indicators.suppress_records;

    // add back to search layout
    all_results := JOIN(rsrt_final, temp_results_ffd,
      LEFT.tmsid = RIGHT.tmsid,
      TRANSFORM(rec_out,
      SELF.StatementIds := RIGHT.StatementIds;
      SELF.isDisputed := RIGHT.isDisputed;
      SELF := RIGHT; // to get statementids AND isdisputed for debtors child DATASET
      SELF:= LEFT));

    final := IF(suppress_results_due_alerts, DATASET([], rec_out), all_results);

    CaseNumberErrorCode :=
      FCRA.Functions.CheckCaseNumMinInput(CaseNumber_value_ucase, fname_value,
        lname_value,ssn_value,state_value_ucase,(UNSIGNED6)did_value,
          city_value, attorney_name , court_code);

    IF(EnableCaseNumFilter AND CaseNumberErrorCode != 0,
       FAIL(CaseNumberErrorCode, ut.MapMessageCodes(CaseNumberErrorCode)));

    IF(EnableCaseNumFilter AND COUNT(final(matched_party.did != final[1].matched_party.did)) > 0,
          FAIL(ut.constants_MessageCodes.FCRA_CASE_NUM_MORE_THAN_1_REC_RETURNED,
               ut.MapMessageCodes(ut.constants_MessageCodes.FCRA_CASE_NUM_MORE_THAN_1_REC_RETURNED)));

    // get FFD statements
    // Consumer Level statements will always be returned along with any alert messages.
    all_statements := IF(ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
    consumer_statements := IF( EXISTS(final), all_statements,
      all_statements(StatementType IN FFD.Constants.RecordType.StatementConsumerLevel));

    consumer_alerts := FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, valFFDOptionsMask);
    matched_party_lexid := dsDIDs[1].did;
    search_lexId := IF(matched_party_lexid > 0 AND ~EXISTS(dsDIDs(did <> matched_party_lexid)), matched_party_lexid, 0);

    // in case if results contain data for more than one matched LexId and no resolved LexId based on input there will be no Consumer data populated
    input_consumer := FFD.MAC.PrepareConsumerRecord(search_lexId, FALSE);

    doxie.MAC_Marshall_Results(final, recs_marshalled);

    OUTPUT(recs_marshalled, NAMED('Results'));
    OUTPUT (consumer_statements, NAMED ('ConsumerStatements'));
    OUTPUT (consumer_alerts, NAMED ('ConsumerAlerts'));
    OUTPUT (input_consumer, NAMED ('Consumer'));

ENDMACRO;

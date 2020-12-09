
 IMPORT $, DeathV2_Services, Doxie, dx_death_master, FCRA, FFD, Gateway, IESP, Liensv2, risk_indicators, Risk_Reporting, STD;

EXPORT LiensRetrieval_Records($.IParam.liensRetrieval_params input,
                              DATASET(iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalRequest) input_request) := FUNCTION

  srchby := GLOBAL(input_request[1].SearchBy);

  gateways := Gateway.Configuration.Get();

  picklist_req := PROJECT(input_request, TRANSFORM(iesp.person_picklist.t_PersonPickListRequest,
                  SELF.Options.ReturnUniqueIdsOnly := TRUE,
                 SELF:=LEFT, SELF := []));

  picklist_resp := FCRA.PickListSoapcall.esdl(gateways,picklist_req,TRUE,, TRUE)[1];
  
  resolved_did := IF(picklist_resp._Header.Status!=0, 0, (UNSIGNED6)picklist_resp.Records[1].UniqueId);

  ds_did := DATASET([{resolved_did}],doxie.layout_references);

  ds_best := PROJECT(ds_did,TRANSFORM(doxie.layout_best, SELF := LEFT, SELF := []));

  dsDIDs := DATASET([{FFD.Constants.SingleSearchAcctno,
                        (UNSIGNED)resolved_did}],FFD.Layouts.DidBatch);
  //Call the person context
  pc_recs := FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Liens, input.FFDOptionsMask);

  //Slim down the PersonContext
  slim_pc_recs := FFD.SlimPersonContext(pc_recs);

  consumer_statements := FFD.prepareConsumerStatements(PC_Recs);
  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, input.FCRAPurpose, input.FFDOptionsMask)[1];

  ds_flags := FFD.GetFlagFile(ds_best, pc_recs);

  liens_srch_recs := IF(~alert_indicators.suppress_records, LiensV2_Services.liens_raw.Retrieval_view_fcra.by_did (ds_did, ds_flags,
                                                                          slim_pc_recs, input.FFDOptionsMask, input.FCRAPurpose));
 //filtering the search records based on input pri
 //(filing type id and (filing number or (book and page))) or orig_rmsid
//and
//(agency name/county/state or agency id)

  in_filing_type_id := TRIM(STD.Str.ToUpperCase(srchby.FilingTypeID));
  in_filing_number := TRIM(STD.Str.ToUpperCase(srchby.FilingNumber));
  in_filing_page := TRIM(STD.Str.ToUpperCase(srchby.FilingPage));
  in_filing_book := TRIM(STD.Str.ToUpperCase(srchby.FilingBook));
  in_record_id := TRIM(STD.Str.ToUpperCase(srchby.RecordID));
  in_agency_name := TRIM(STD.Str.ToUpperCase(srchby.Agency));
  in_agency_county := TRIM(STD.Str.ToUpperCase(srchby.AgencyCounty));
  in_agency_state := TRIM(STD.Str.ToUpperCase(srchby.AgencyState));
  in_agency_id := TRIM(STD.Str.ToUpperCase(srchby.AgencyID));

  filtered_liens_byinput := liens_srch_recs(((Filing_Type_ID = in_filing_type_id AND
                              (filing_number = in_filing_number OR (filing_page = in_filing_page AND filing_book = in_filing_book)))
                               OR orig_rmsid = in_record_id)
                              AND
                              ((agency = in_agency_name AND agency_county = in_agency_county AND agency_state = in_agency_state)
                              OR AgencyID = in_agency_id));
    
  filtered_liens := filtered_liens_byinput(agencyId <> '' AND ~isDisputed);
  // search should resolve to single record, if yes, drop the disputed records
  invalid_search_recs := resolved_did <> 0 AND COUNT(filtered_liens) != 1;

  liens_recs := IF(invalid_search_recs,
                      DATASET([],$.layout_liens_retrieval.search_recs),
                      filtered_liens);

 // if initial request, call okc court runner. if deferred request, call dte
  gw_cfg_okc := IF(~input.DeferredTaskRequest, gateways(Gateway.Configuration.IsOKCcourtrunner(ServiceName))[1]);
 // call okc gateway
  call_okc := gw_cfg_okc.url <> '' AND EXISTS(liens_recs(orig_rmsid <>''));
 // call_dte gateway
  call_dte := input.DeferredTaskRequest AND EXISTS(liens_recs);

  search_recs := IF(EXISTS(liens_recs),
                   IF(~input.DeferredTaskRequest,
                    $.GetRetrievalGateway_Records.callOKC_courtrunner(input.TransactionId,
                                                                      liens_recs, gw_cfg_okc, call_okc),
                    $.GetRetrievalGateway_Records.callDTE_getrequestInfo(input,
                                                                        liens_recs, gateways, call_dte)));


  dte_gateway_success := input.DeferredTaskRequest AND EXISTS(search_recs(did <> 0));
  OKC_gateway_success := ~input.DeferredTaskRequest AND search_recs[1].IsOKCSuccess;
  // gateway_failed includes g/w network failures and exceptions returned from gateway and
  // excludes did not found and no recs found
  gateway_failed := (UNSIGNED)search_recs[1].error_code <> 0 AND search_recs[1].error_code NOT IN [$.constants.LIENS_RETRIEVAL.NO_RECS_FOUND_CODE,
                                                          FCRA.Constants.ALERT_CODE.NO_DID_FOUND];
  // do not show CS for okc submission request & do not show CS if dte gateway request fails
  BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(input.FFDOptionsMask) AND dte_gateway_success;
  // do not show alerts for okc submission success or gateway failures
  BOOLEAN NoshowAlerts := OKC_gateway_success OR gateway_failed;
  // do not return UniqueID under Records in case of 222A, gateway failure and OKC success
  no_dte_did_resolved := input.DeferredTaskRequest AND search_recs[1].error_code = FCRA.Constants.ALERT_CODE.NO_DID_FOUND;
  no_didresolved := resolved_did = 0 OR no_dte_did_resolved;
  BOOLEAN NoShowUniqueID := no_didresolved OR OKC_gateway_success OR gateway_failed;
  // Specific conditions where Inquiry History (IH) logging should not occur. See RR-20093
  // - There was an error during processing (e.g. a error talking to gateway, or any other error) – we would not be returning anything of value
  // - We could not determine the LexID associated with the PII .. there is nothing meaningful we are returning
  // - We have deferred the request – we are returning nothing meaningful/of-value (yet .. when the resubmission occurs we will be (hopefully) returning something of value, and that is when IH logging should occur)
  BOOLEAN NoInquiryLogging := resolved_did = 0 OR gateway_failed OR OKC_gateway_success;
                                
  // add deceased flag
  recs_w_deceasedflag := dx_death_master.Get.byDid(ds_did, did, input,,,,Data_Services.data_env.iFCRA);

  // add alerts
  get_alerts() := FUNCTION

     BOOLEAN is_legal_hold := alert_indicators.consumer_flags.alert_legal_flag <> '' AND alert_indicators.suppress_records;
     BOOLEAN subjectdeceased := recs_w_deceasedflag[1].death.is_deceased;
     BOOLEAN isRIState := picklist_resp._Header.Status = 305;// Rhode island verification
    // when dte resolved lexid is 0, do not return alerts
    consumer_alerts := IF(~no_dte_did_resolved, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, input.FFDOptionsMask));
    cs_alerts_rv := PROJECT(consumer_alerts, TRANSFORM(iesp.riskview2.t_RiskView2Alert,
                                             SELF.Code := LEFT.code,
                                             SELF.Description := LEFT.Message));
    // Adding all consumer alerts and alerts specific to court runner
    //as per dempsey, if there's legal hold no other laerts should be triggered except that.
    alerts := cs_alerts_rv +
              IF(no_didresolved AND ~isRIstate AND ~is_legal_hold , DATASET([{FCRA.Constants.ALERT_CODE.NO_DID_FOUND,
                                                    risk_indicators.getHRIDesc(FCRA.Constants.ALERT_CODE.NO_DID_FOUND)}], iesp.riskview2.t_RiskView2Alert)) +
              IF(subjectdeceased AND ~is_legal_hold, DATASET([{FCRA.Constants.ALERT_CODE.SUBJECT_DECEASED_CODE,
                                                    risk_indicators.getHRIDesc(FCRA.Constants.ALERT_CODE.SUBJECT_DECEASED_CODE)}], iesp.riskview2.t_RiskView2Alert)) +
              IF(isRIstate AND ~is_legal_hold, DATASET([{FCRA.Constants.ALERT_CODE.STATE_EXCEPTION,
                                                     FCRA.Constants.getAlertDescription(FCRA.Constants.ALERT_CODE.STATE_EXCEPTION)}], iesp.riskview2.t_RiskView2Alert));

   RETURN alerts;

 END;

// returning data from DTE
  iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalRecord toRecords($.layout_liens_Retrieval.final_rec L) := TRANSFORM

     SELF.UniqueId := (STRING) L.did;
     SELF.DefendantName := iesp.ECL2ESP.SetName(L.fname, L.mname, L.lname, L.name_suffix,'');
     SELF.DefendantAddress := iesp.ECL2ESP.SetAddress(L.prim_name, L.prim_range,
                                                   L.predir, L.postdir, L.addr_suffix, L.unit_desig, L.sec_range,
                                                   L.p_city_name, L.st, L.zip, L.zip4, '', '',
                                                   L.orig_address1);
     SELF.SSN := L.ssn;
     SELF.FilingDate := iesp.ECL2ESP.toDate((INTEGER)L.filing_date);
     SELF.FilingTypeID := L.Filing_Type_ID;
     SELF.ReleaseDate := iesp.ECL2ESP.toDate((INTEGER)L.release_date);
     SELF.Amount := L.amount;
     SELF.IsDisputed := L.isDisputed;
     SELF.StatementIds := L.StatementIds;

   END;

   iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalRecord toReturnLexid() := TRANSFORM
     SELF.UniqueId := (STRING) IF(NoShowUniqueID, 0, resolved_did);
     SELF := [];

   END;

   ds_liens := IF(input.DeferredTaskRequest,
                  PROJECT(search_recs, toRecords(LEFT)),
                  DATASET([toReturnLexid()]));
   
   iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalResponse toFinal() := TRANSFORM

      is_court_id_blank := EXISTS(filtered_liens_byinput) AND EXISTS(filtered_liens_byinput(agencyId = ''));
      ds_courtid_excep := DATASET([{$.Constants.LIENS_RETRIEVAL.ERRORSOURCE,
                                 $.Constants.LIENS_RETRIEVAL.COURTID_BLANK_ERRORCODE,
                                 '',
                                 $.Constants.LIENS_RETRIEVAL.COURTID_BLANK_EXCEPTION}], iesp.share.t_WsException);

     invalid_recs := invalid_search_recs OR search_recs[1].error_code = $.constants.LIENS_RETRIEVAL.NO_RECS_FOUND_CODE;

     ds_norecs_excep := DATASET([{$.Constants.LIENS_RETRIEVAL.ERRORSOURCE,
                                 (INTEGER) $.Constants.LIENS_RETRIEVAL.NO_RECS_FOUND_CODE,
                                  '',
                                   $.Constants.LIENS_RETRIEVAL.NO_RECS_FOUND_EXCEPTION}], iesp.share.t_WsException);

      // OKC exceptions
      OKC_task_exceptions := search_recs[1].error_code <> '0' AND search_recs[1].error_code IN [$.constants.LIENS_RETRIEVAL.OKC_TASK_ERRORS];
      ds_task_exceptions := DATASET([{$.Constants.LIENS_RETRIEVAL.ERRORSOURCE,
                                     search_recs[1].error_code,
                                     '',
                                     search_recs[1].error_desc}], iesp.share.t_WsException);
   
      // considering n/w errors excluding okc exceptions, no did found, no records found exception
      gateway_network_failures := (UNSIGNED)search_recs[1].error_code <> 0 AND search_recs[1].error_code NOT IN [$.constants.LIENS_RETRIEVAL.OKC_TASK_ERRORS,
                                                                    $.constants.LIENS_RETRIEVAL.NO_RECS_FOUND_CODE,
                                                                    FCRA.Constants.ALERT_CODE.NO_DID_FOUND];
                                                                    
      ds_gateway_excep := DATASET([{$.Constants.LIENS_RETRIEVAL.ERRORSOURCE,
                                 $.Constants.LIENS_RETRIEVAL.GATEWAY_FAILURE_CODE,
                                 '',
                                 $.Constants.LIENS_RETRIEVAL.GATEWAY_EXCEPTION}], iesp.share.t_WsException);
                                   
      SELF._Header.Exceptions:= MAP(is_court_id_blank => ds_courtid_excep,
                                  invalid_recs => ds_norecs_excep,
                                  gateway_network_failures => ds_gateway_excep,
                                  OKC_task_exceptions => ds_task_exceptions,
                                  DATASET([], iesp.share.t_WsException));
      
      //returns in case of okc submission success
      SELF._Header.Message := IF(OKC_gateway_success, $.Constants.LIENS_RETRIEVAL.OKC_SUBMISSION_MESSAGE, '');
      SELF._Header:= iesp.ECL2ESP.GetHeaderRow();
      SELF.RecordCount := COUNT(ds_liens);
      SELF.InputEcho := srchby;
      SELF.Records := ds_liens;
      SELF.Alerts := IF(NoshowAlerts, DATASET([], iesp.riskview2.t_RiskView2Alert), SORT(get_alerts(), Code));
      SELF.ConsumerStatements := IF(showConsumerStatements, consumer_statements);
      SELF.Consumer := IF(NoInquiryLogging,
                           ROW([],iesp.share_fcra.t_FcraConsumer),
                           FFD.MAC.PrepareConsumerRecord(resolved_did, TRUE, srchby));

   END;

  FINAL := DATASET([toFinal()]);

RETURN FINAL;
END;


 IMPORT $, DeathV2_Services, Doxie, dx_death_master, FCRA, FFD, Gateway, IESP, Liensv2, risk_indicators, Risk_Reporting;

EXPORT LiensRetrieval_Records($.IParam.liensRetrieval_params input,
                              DATASET(iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalRequest) input_request) := FUNCTION

  srchby := GLOBAL(input_request[1].SearchBy);

  BOOLEAN isCollections              := FCRA.FCRAPurpose.isCollections(input.FCRAPurpose);

  gateways := Gateway.Configuration.Get();

  picklist_req := PROJECT(input_request, TRANSFORM(iesp.person_picklist.t_PersonPickListRequest,
                  SELF.Options.ReturnUniqueIdsOnly := TRUE,
                 SELF:=LEFT, SELF := []));

  picklist_resp := FCRA.PickListSoapcall.esdl(gateways,picklist_req,true,, true)[1];
  
  resolved_did := IF(picklist_resp._Header.Status!=0, 0, (UNSIGNED6)picklist_resp.Records[1].UniqueId);

  ds_did  := DATASET([{resolved_did}],doxie.layout_references);

  ds_best := PROJECT(ds_did,TRANSFORM(doxie.layout_best, SELF := LEFT, SELF := []));

  dsDIDs := DATASET([{FFD.Constants.SingleSearchAcctno,
                        (UNSIGNED)resolved_did}],FFD.Layouts.DidBatch);
  //Call the person context
  pc_recs := FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Liens, input.FFDOptionsMask);

  //Slim down the PersonContext
  slim_pc_recs    := FFD.SlimPersonContext(pc_recs);

  consumer_statements := FFD.prepareConsumerStatements(PC_Recs);
  alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, input.FCRAPurpose, input.FFDOptionsMask)[1];

  ds_flags := FFD.GetFlagFile(ds_best, pc_recs);

  liens_srch_recs := LiensV2_Services.liens_raw.Retrieval_view_fcra.by_did (ds_did, ds_flags,
                                                                          slim_pc_recs, input.FFDOptionsMask, input.FCRAPurpose);
 //filtering the search records based on input pri
  filtered_liens_byinput := liens_srch_recs(((Filing_Type_ID = srchby.FilingTypeID AND
                              (filing_number = srchby.FilingNumber OR (filing_page = srchby.FilingPage AND filing_book = srchby.FilingBook)))
                               OR orig_rmsid = srchby.RecordID)
                              AND
                              ((agency = srchby.Agency AND agency_county = srchby.AgencyCounty AND agency_state = srchby.AgencyState)
                              OR AgencyID = srchby.AgencyID));
    
  filtered_liens := filtered_liens_byinput(agencyId <> '' AND ~isDisputed);
  // search should resolve to single record, if yes, drop the disputed records
  invalid_recs := COUNT(filtered_liens) != 1;

  liens_recs    := IF(invalid_recs,
                      DATASET([],$.layout_liens_retrieval.search_recs),
                      filtered_liens);

  IsValidRequest := ~alert_indicators.suppress_records AND EXISTS(liens_recs);

 // if initial request, call okc court runner. if deferred request, call dte
  gw_cfg_okc := IF(~input.DeferredTaskRequest, gateways(Gateway.Configuration.IsOKCcourtrunner(ServiceName))[1]);
 // call okc gateway
  call_okc := gw_cfg_okc.url <> '' AND EXISTS(liens_recs(orig_rmsid <>''));
 // call_dte gateway
  call_dte := input.DeferredTaskRequest AND EXISTS(liens_recs);

  search_recs :=   IF(IsValidRequest,
                   IF(~input.DeferredTaskRequest,
                    $.GetRetrievalGateway_Records.callOKC_courtrunner(input.TransactionId,
                                                                      liens_recs, gw_cfg_okc, call_okc),
                    $.GetRetrievalGateway_Records.callDTE_getrequestInfo(input,
                                                                        liens_recs, gateways, call_dte)));

  // do not show CS if gateway request fails
  is_gateway_success :=   (~input.DeferredTaskRequest AND search_recs[1].error_code = '' AND search_recs[1].IsOKCSuccess) OR
                          (input.DeferredTaskRequest AND EXISTS(search_recs(did <> 0)));

  BOOLEAN showConsumerStatements     := FFD.FFDMask.isShowConsumerStatements(input.FFDOptionsMask) AND  is_gateway_success;
                                   
  // add deceased flag
  recs_w_deceasedflag := dx_death_master.Get.byDid(ds_did, did, input,,,,Data_Services.data_env.iFCRA);

  // add alerts
  get_alerts() := FUNCTION

     BOOLEAN is_legal_hold   := alert_indicators.consumer_flags.alert_legal_flag <> '' AND alert_indicators.suppress_records;
     BOOLEAN subjectdeceased := recs_w_deceasedflag[1].death.is_deceased;
     BOOLEAN nodidresolved   := resolved_did = 0 OR If(input.DeferredTaskRequest,
                                search_recs[1].error_code = FCRA.Constants.ALERT_CODE.NO_DID_FOUND, FALSE);
     BOOLEAN is_OKCsubmitted := search_recs[1].IsOKCSuccess;
     BOOLEAN isRIState := picklist_resp._Header.Status = 305;// Rhode island verification

    consumer_alerts := FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, input.FFDOptionsMask);
    cs_alerts_rv := PROJECT(consumer_alerts, TRANSFORM(iesp.riskview2.t_RiskView2Alert,
                                             SELF.Code := LEFT.code,
                                             SELF.Description := LEFT.Message));
    // Adding all consumer alerts and alerts specific to court runner
    //as per dempsey, if there's legal hold no other laerts should be triggered except that.
    alerts :=  cs_alerts_rv +
              IF(nodidresolved   AND ~is_legal_hold , DATASET([{FCRA.Constants.ALERT_CODE.NO_DID_FOUND,
                                                    risk_indicators.getHRIDesc(FCRA.Constants.ALERT_CODE.NO_DID_FOUND)}], iesp.riskview2.t_RiskView2Alert)) +
              IF(subjectdeceased AND ~is_legal_hold, DATASET([{FCRA.Constants.ALERT_CODE.SUBJECT_DECEASED_CODE,
                                                    risk_indicators.getHRIDesc(FCRA.Constants.ALERT_CODE.SUBJECT_DECEASED_CODE)}], iesp.riskview2.t_RiskView2Alert)) +
              IF(is_OKCsubmitted AND ~is_legal_hold, DATASET([{$.Constants.LIENS_RETRIEVAL.OKC_SUBMISSION_SUCCESS_CODE,
                                                     $.Constants.LIENS_RETRIEVAL.OKC_SUBMISSION_MESSAGE}], iesp.riskview2.t_RiskView2Alert)) +
              IF(isRIstate AND ~is_legal_hold, DATASET([{FCRA.Constants.ALERT_CODE.STATE_EXCEPTION,
                                                     FCRA.Constants.getAlertMessage(FCRA.Constants.ALERT_CODE.STATE_EXCEPTION)}], iesp.riskview2.t_RiskView2Alert));


   RETURN alerts;

 END;

// returning data from DTE
  iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalRecord toRecords($.layout_liens_Retrieval.final_rec L) := TRANSFORM

     SELF.UniqueId := (string)L.did;
     SELF.DefendantName := iesp.ECL2ESP.SetName(L.fname, L.mname, L.lname, L.name_suffix,'');
     SELF.DefendantAddress := iesp.ECL2ESP.SetAddress(L.prim_name, L.prim_range,
                                                   L.predir, L.postdir, L.addr_suffix, L.unit_desig, L.sec_range,
                                                   L.p_city_name, L.st, L.zip, L.zip4, '', '',
                                                   L.orig_address1);
     SELF.SSN := L.ssn;
     SELF.FilingDate := iesp.ECL2ESP.toDate((integer)L.filing_date);
     SELF.FilingTypeID := L.Filing_Type_ID;
     SELF.ReleaseDate := iesp.ECL2ESP.toDate((integer)L.release_date);
     SELF.Amount := L.amount;
     SELF.IsDisputed := L.isDisputed;
     SELF.StatementIds := L.StatementIds;

   END;

   ds_liens := IF(input.DeferredTaskRequest,
                  PROJECT(search_recs, toRecords(LEFT)));

   iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalResponse toFinal() := TRANSFORM


      is_gateway_excep  := search_recs[1].error_code = $.constants.LIENS_RETRIEVAL.GATEWAY_FAILURE_CODE;
      ds_gateway_excep  := DATASET([{$.Constants.LIENS_RETRIEVAL.ERRORSOURCE,
															   $.Constants.LIENS_RETRIEVAL.GATEWAY_FAILURE_CODE,
															   '',
															   $.Constants.LIENS_RETRIEVAL.GATEWAY_EXCEPTION}], iesp.share.t_WsException);

      is_court_id_blank := EXISTS(filtered_liens_byinput) AND  EXISTS(filtered_liens_byinput(agencyId = ''));
      ds_courtid_excep  := DATASET([{$.Constants.LIENS_RETRIEVAL.ERRORSOURCE,
															   $.Constants.LIENS_RETRIEVAL.COURTID_BLANK_ERRORCODE,
															   '',
															   $.Constants.LIENS_RETRIEVAL.COURTID_BLANK_EXCEPTION}], iesp.share.t_WsException);

     ds_norecs_excep  := DATASET([{$.Constants.LIENS_RETRIEVAL.ERRORSOURCE,
															    $.Constants.LIENS_RETRIEVAL.NO_RECS_FOUND_CODE,
															    '',
															     $.Constants.LIENS_RETRIEVAL.NO_RECS_FOUND_EXCEPTION}], iesp.share.t_WsException);

      SELF._Header.Exceptions:= MAP(is_court_id_blank => ds_courtid_excep,
                                  invalid_recs        => ds_norecs_excep,
                                  is_gateway_excep    => ds_gateway_excep,
                                  DATASET([], iesp.share.t_WsException));
      
      SELF._Header:= iesp.ECL2ESP.GetHeaderRow();
      SELF.RecordCount := COUNT(ds_liens);
      SELF.InputEcho := srchby;
      SELF.Records := ds_liens;
      SELF.Alerts := get_alerts();
      SELF.ConsumerStatements := IF(showConsumerStatements, consumer_statements);
      SELF.Consumer := FFD.MAC.PrepareConsumerRecord(resolved_did, TRUE, srchby);

   END;

  FINAL := DATASET([toFinal()]);

RETURN FINAL;
END;
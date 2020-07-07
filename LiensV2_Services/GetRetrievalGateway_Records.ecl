IMPORT $, Address, AutoKeyI, BatchShare, DeferredTask, Doxie, FCRA, FFD, Gateway, iesp, Liensv2, STD, risk_indicators, Risk_Reporting;

EXPORT GetRetrievalGateway_Records := MODULE

  EXPORT callOKC_courtrunner(STRING32 TransactionID,
                             DATASET($.layout_liens_retrieval.search_recs) srch_recs,
                             Gateway.Layouts.Config gw_cfg_okc,
                             BOOLEAN call_gateway = FALSE) := FUNCTION

    iesp.okc_courtrunner_request.t_OkcCourtRunnerRequest setRequest($.layout_liens_retrieval.search_recs L) := TRANSFORM


        LJType := MAP(L.filing_type_desc in risk_indicators.iid_constants.setSuitsFCRA => '',
                L.rmsid = '' => '',
                L.filing_type_desc in risk_indicators.iid_constants.setPRJudgment => risk_indicators.iid_constants.JudgmentText,
                L.filing_type_desc in risk_indicators.iid_constants.setPREviction => risk_indicators.iid_constants.EvictionText,
                L.filing_type_desc in risk_indicators.iid_constants.setPRLien => risk_indicators.iid_constants.LienText,
                L.filing_type_desc NOT in risk_indicators.iid_constants.setPROther => risk_indicators.iid_constants.OtherText,
                '');
         is_Lien := LJType = risk_indicators.iid_constants.LienText;
         is_Jgmt := LJType IN [
                                                risk_indicators.iid_constants.JudgmentText,
                                                risk_indicators.iid_constants.EvictionText,
                                                risk_indicators.iid_constants.OtherText
                                                ];

          SELF.SearchBy.ProceedingTypeId := MAP(is_Jgmt => 1,
                                         is_Lien => 2,
                                         0);


           SELF.SearchBy.RMSId            := L.orig_rmsid;
           SELF.Options.TransactionId     := TransactionId;
           SELF := [];

    END;
    okc_in := PROJECT(srch_recs, setRequest(LEFT));

    okc_response := IF(call_gateway, Gateway.SoapCall_OKCCourtRunner(okc_in,gw_cfg_okc));

    output_okc := PROJECT(okc_response, TRANSFORM($.layout_liens_Retrieval.final_rec,
                          SELF.isOKCSuccess := LEFT.Response.Result.IsSuccess,
                          SELF.error_code   := IF(LEFT.Response._Header.message <> '', $.constants.LIENS_RETRIEVAL.GATEWAY_FAILURE_CODE, ''),
                          SELF              := []));
   // logging the xml request for deferred task usage
    rec_w_xmlreq := RECORD
      iesp.okc_courtrunner_request.t_OkcCourtRunnerResponseEx;
      STRING50 RMSID;
      STRING50 TMSID;
      STRING10 ORIG_RMSID;
    END;

    okc_w_xmlreq := PROJECT(okc_response, TRANSFORM(rec_w_xmlreq,
                                                    SELF.tmsid := srch_recs[1].tmsid,
                                                    SELF.rmsid := srch_recs[1].rmsid,
                                                    SELF.orig_rmsid  :=  srch_recs[1].orig_rmsid,
                                                    SELF := LEFT));

    IF(exists(okc_w_xmlreq(Response.Result.TaskID <> '')), 
       OUTPUT(PROJECT(okc_w_xmlreq, TRANSFORM(Risk_Reporting.Layouts.LOG_DTE_Layout,
                                  SELF.TaskId            := LEFT.Response.Result.TaskID;
                                  SELF.TaskDescription   := $.Constants.LIENS_RETRIEVAL.OKC_TASK_DESC;
                                  SELF.Request_XML       := '<RMSID>' + LEFT.RMSID + '</RMSID>' + '<TMSID>' + LEFT.TMSID + '</TMSID>' + '<ORIG_RMSID>' + LEFT.ORIG_RMSID + '</ORIG_RMSID>')),
       NAMED('LOG_Deferred_Task_ESP')));

  RETURN output_okc;

  END;

  EXPORT callDTE_getrequestInfo($.IParam.liensRetrieval_params input_params,
                                DATASET($.layout_liens_retrieval.search_recs) lien_srch_recs,
                                DATASET(Gateway.Layouts.Config) in_gateways,
                                BOOLEAN callgwy = FALSE
                               ) := FUNCTION

    gw_cfg_dte := in_gateways(Gateway.Configuration.IsDTEGetRequestInfo(ServiceName))[1];
    call_dte   := callgwy AND gw_cfg_dte.url <> '';

    batch_mod := MODULE(PROJECT(input_params, BatchShare.IParam.BatchParams, OPT))
    export dataset (Gateway.layouts.config) gateways := in_gateways;
    END;

    iesp.DTE_GetRequestInfo.t_DTEGetRequestInfoRequest setDTErequest() := TRANSFORM

      SELF.TransactionId := input_params.DeferredTransactionID;
      SELF := [];
    END;

    dte_in := DATASET([setDTErequest()]);

    dte_out := Gateway.Soapcall_DTEGetRequestInfo(dte_in,gw_cfg_dte,,, call_dte);

    valid_response := dte_out.ResponseJSON[1].ErrorCode = '';

    dte_gw_recs    := IF(valid_response, dte_out, DATASET([],{dte_out}));

   // get record level statements to the dte record by using tmsid/rmsid/did saved from original submitted okc request
    ref_rec := RECORD
      STRING50 RMSID{xpath('LiensRMSID')};
      STRING50 TMSID{xpath('LiensTMSID')};
    END;

    Ids_from_request :=  PROJECT(dte_gw_recs, TRANSFORM(ref_rec,
                                out := FROMXML(ref_rec,LEFT.Response.DteRequest.TaskExs[1].RequestOpaqueContent);
                                SELF.RMSID := out.rmsid,
                                SELF.TMSID := out.tmsid,
                                SELF := LEFT));

    //find the matched lien in liens search records (resolved from input pii and pri)
    matched_lien := JOIN(lien_srch_recs, Ids_from_request,
                           LEFT.tmsid = RIGHT.tmsid AND
                           LEFT.rmsid = RIGHT.rmsid,
                           TRANSFORM($.layout_liens_retrieval.search_recs,
                            SELF := LEFT), KEEP(1), LIMIT(0));

    //get filing_date from case - there will be only one case
    case_filing_date := dte_gw_recs.ResponseJSON[1].Case[1].FilingDate;


    // get parties and lexid them
    $.layout_liens_Retrieval.layout_workrec todidville(DeferredTask.Layouts.PartiesLayout pinfo, integer c)  := TRANSFORM

      clean_addr := Address.GetCleanAddress(pinfo.Address1,Address.Addr2FromComponents(pinfo.city,pinfo.state,pinfo.zip),
			                                      Address.Components.Country.US).results;

      SELF.acctno := (STRING)c;
      SELf.name_first  := pinfo.Fname;
      SELF.name_middle := pinfo.Mname;
      SELF.name_last   := pinfo.Lname;
      SELF.name_suffix := pinfo.NameSuffix;
      SELF.ssn := pinfo.SSN;
      SELF.prim_range  := clean_addr.prim_range;
      SELF.predir      := clean_addr.predir;
      SELF.prim_name   := clean_addr.prim_name;
      SELF.addr_suffix := clean_addr.suffix;
      SELF.postdir     := clean_addr.postdir;
      SELF.unit_desig  := clean_addr.unit_desig;
      SELF.sec_range   := clean_addr.sec_range;
      SELF.p_city_name := pinfo.City;
      SELF.st   := pinfo.State;
      SELF.z5   := pinfo.Zip;
      SELF.zip4 := pinfo.Zip4;
      SELF.FilingTypeId := pinfo.FilingTypeId;
      SELF.ReleaseDate := pinfo.ReleaseDate;
      SELF.Amount := pinfo.amount;
      SELF := [];

    END;

    get_parties :=  NORMALIZE(dte_gw_recs,
                             LEFT.ResponseJSON.Parties(STD.Str.ToUpperCase(PartyType) = $.Constants.LIENS_RETRIEVAL.DEFENDANT),
                             todidville(RIGHT, counter));

    BatchShare.MAC_SequenceInput (get_parties, ds_party_sequenced);
    BatchShare.MAC_AppendPicklistDID(ds_party_sequenced, ds_did_out, batch_mod, TRUE);

    $.layout_liens_Retrieval.final_rec toFinal($.layout_liens_Retrieval.layout_workrec L,
                                               $.layout_liens_retrieval.search_recs R) := TRANSFORM

     SELF.did             := L.did;
     SELF.fname           := L.name_first;
     SELF.mname           := L.name_middle;
     SELF.lname           := L.name_last;
     SELF.name_suffix      := L.name_suffix;
     SELF.ssn             := L.ssn;
     SELF.orig_address1   := L.addr;
     SELF.prim_range      := L.prim_range;
     SELF.prim_name       := L.prim_name;
     SELF.predir          := L.predir;
     SELF.addr_suffix     := L.addr_suffix;
     SELF.postdir         := L.postdir;
     SELF.unit_desig      := L.unit_desig;
     SELF.sec_range       := L.sec_range;
     SELF.p_city_name     := L.p_city_name;
     SELF.st              := L.st;
     SELF.zip             := L.z5;
     SELF.zip4            := L.zip4;
     SELF.release_date    := L.ReleaseDate;
     SELF.Filing_Type_ID  := L.FilingTypeId;
     SELF.amount          := L.Amount;
     SELF.filing_date     := IF(FCRA.lien_is_ok((STRING) STD.Date.Today(), case_filing_date), case_filing_date, '');
     SELF.isOKCSuccess    := FALSE; //false for dte call
     SELF.isDisputed      := R.isDisputed;
     SELF.StatementIds    := R.StatementIds;

    END;

    // Lexid validation defendant vs input pii resolved lexid, and attach record level statements and isdisputed flag
    output_dte := JOIN(ds_did_out, matched_lien,
                      LEFT.did = RIGHT.did,
                      toFinal(LEFT,RIGHT));

    resolved_to_none := COUNT(output_dte) != 1;
    err_response := ~valid_response OR resolved_to_none; // if no match/more than one match

    $.layout_liens_Retrieval.final_rec ErrorOut() := TRANSFORM

       SELF.error_code := MAP(~valid_response => $.constants.LIENS_RETRIEVAL.GATEWAY_FAILURE_CODE,
                              resolved_to_none => FCRA.Constants.ALERT_CODE.NO_DID_FOUND,
                              '');
        SELF := [];
    END;

    error_ds := DATASET([ErrorOut()]);

    res_ds := IF(err_response,
                 error_ds,
                 output_dte);

    RETURN res_ds;
  END;

END;
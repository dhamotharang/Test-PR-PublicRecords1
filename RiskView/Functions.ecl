IMPORT IESP, Risk_Indicators, Riskview, Gateway, Risk_Reporting, STD;

EXPORT Functions := MODULE

EXPORT JuLiProcessDTE(STRING DeferredTransactionID,  grouped dataset(risk_indicators.Layout_Boca_Shell) clam, dataset(Gateway.Layouts.Config) gateways, dataset(riskview.layouts.layout_riskview5_search_results) riskview5_final_results) := FUNCTION

RecsToDTE := DATASET([TRANSFORM(IESP.DTE_GetRequestInfo.t_DTEGetRequestInfoRequest, SELF.TransactionID := DeferredTransactionID; SELF := [];)]);

GetRequestInfoGW := gateways(STD.Str.ToLowerCase(ServiceName)=Gateway.Constants.ServiceName.GetRequestInfo)[1];

makeDTEGatewayCall := GetRequestInfoGW.URL <> '';

GetRequestInfo := Gateway.Soapcall_DTEGetRequestInfo(RecsToDTE, GetRequestInfoGW, pMakeGatewayCall := makeDTEGatewayCall);

rec := RECORD
STRING50 RMSID{xpath('RMSID')};
STRING50 TMSID{xpath('TMSID')};
END;

GetRequestTMSIDandRMSID := PROJECT(GetRequestInfo, TRANSFORM({RECORDOF(LEFT), STRING RMSID{xpath('RMSID')}, STRING TMSID{xpath('TMSID')}},
out := FROMXML(rec,LEFT.Response.DteRequest.TaskExs[1].RequestOpaqueContent);
SELF.RMSID := out.rmsid;
SELF.TMSID := out.tmsid;
SELF := LEFT;));

LiensAppendSuppressFlag := JOIN(GetRequestTMSIDandRMSID, clam[1].LnJ_datasets.lnjliens, 
LEFT.RMSID = RIGHT.RMSID AND LEFT.TMSID = RIGHT.TMSID, 
TRANSFORM(RECORDOF(RIGHT), 
SELF.SuppressRecord := IF(LEFT.Response.DTERequest.TaskExs[1].TaskStatus <> '0', TRUE, FALSE);
SELF := RIGHT;
));

JudgmentsAppendSuppressFlag := JOIN(GetRequestTMSIDandRMSID, clam[1].LnJ_datasets.lnjjudgments, 
LEFT.RMSID = RIGHT.RMSID AND LEFT.TMSID = RIGHT.TMSID, 
TRANSFORM(RECORDOF(RIGHT), 
SELF.SuppressRecord := IF(LEFT.Response.DTERequest.TaskExs[1].TaskStatus <> '0', TRUE, FALSE);
SELF := RIGHT;
));

riskview5_suppressed := PROJECT(riskview5_final_results, 
TRANSFORM(RECORDOF(LEFT), 
SELF.LnJLiens := LiensAppendSuppressFlag(SuppressRecord = FALSE);
SELF.LnJJudgments := JudgmentsAppendSuppressFlag(SuppressRecord = FALSE);
SELF := LEFT;));

// OUTPUT(riskview5_suppressed, NAMED('DTE_OUTPUT')); // Debugging output

RETURN riskview5_suppressed;
END; // JuLiProcessDTE END

EXPORT JuLiProcessStatusRefresh(grouped dataset(risk_indicators.Layout_Boca_Shell) clam, dataset(Gateway.Layouts.Config) gateways, dataset(riskview.layouts.layout_riskview5_search_results) riskview5_final_results, boolean ExcludeStatusRefresh, string10 StatusRefreshWaitPeriod, string10 ESPInterfaceVersion) := FUNCTION

StatusRefreshModule := RiskView.InitiateStatusRefresh(clam[1].LnJ_datasets, gateways, 5, 0, true);
StatusRefreshResults := StatusRefreshModule.StatusRefresh;
StatusRefreshRecommendGWError := StatusRefreshModule.RefreshRecommendedGatewayError;
StatusRefreshGWError := StatusRefreshModule.RefreshGatewayError;
Suppressed_Liens := StatusRefreshModule.SuppressRecordsLiens();
Suppressed_Judgments :=  StatusRefreshModule.SuppressRecordsJudgments();

riskview5_status_refresh_error := IF(StatusRefreshRecommendGWError OR StatusRefreshGWError, 
PROJECT(riskview5_final_results, TRANSFORM(RECORDOF(LEFT),
SELF.Exception_Code := '22OKC';
SELF := LEFT;
)));

riskview5_suppressed := IF(~StatusRefreshRecommendGWError OR ~StatusRefreshGWError,
IF(ExcludeStatusRefresh = TRUE, PROJECT(riskview5_final_results, 
TRANSFORM(RECORDOF(LEFT), 
SELF.LnJLiens := Suppressed_Liens(HighRiskCheck = FALSE);
SELF.LnJJudgments := Suppressed_Judgments(HighRiskCheck = FALSE);
SELF := LEFT;)),
PROJECT(riskview5_final_results, 
TRANSFORM(RECORDOF(LEFT), 
SELF.LnJLiens := [];
SELF.LnJJudgments := [];
SELF := LEFT;))));

// OUTPUT(riskview5_suppressed, NAMED('StatusRefreshOutput')); // Debugging output

/* ****************************************************************
*  Deferred Task ESP (DTE) Logging Functionality  *
******************************************************************/
StatusRefreshWithRequestXML := PROJECT(StatusRefreshResults, TRANSFORM({RECORDOF(StatusRefreshResults), STRING50 RMSID, STRING50 TMSID}, 
SELF.RMSID := IF(clam[1].LnJ_datasets.lnjliens[1].rmsid <> '', clam[1].LnJ_datasets.lnjliens[1].rmsid, clam[1].LnJ_datasets.lnjjudgments[1].rmsid);
SELF.TMSID := IF(clam[1].LnJ_datasets.lnjliens[1].tmsid <> '', clam[1].LnJ_datasets.lnjliens[1].tmsid, clam[1].LnJ_datasets.lnjjudgments[1].tmsid);
SELF := LEFT;));
IF(COUNT(StatusRefreshWithRequestXML(Response.Result.TaskID <> '')) > 0, 
OUTPUT(PROJECT(StatusRefreshWithRequestXML, 
TRANSFORM(Risk_Reporting.Layouts.LOG_DTE_Layout,
SELF.TaskID := LEFT.Response.Result.TaskID;
SELF.TaskDescription := 'Status Refresh Task';
SELF.Request_XML := '<Request_XML><RMSID>' + LEFT.RMSID + '</RMSID>' + '<TMSID>' + LEFT.TMSID + '</TMSID></Request_XML>';
)), NAMED('LOG_Deferred_Task_ESP')));

RETURN MAP(StatusRefreshRecommendGWError OR StatusRefreshGWError => riskview5_status_refresh_error,
                          (REAL)ESPInterfaceVersion >= 2.4 AND (REAL)ESPInterfaceVersion < 2.5 => riskview5_final_results,
                          riskview5_suppressed);
END; // JuLiProcessStatusRefresh END

  EXPORT Format_riskview_attrs(Dataset(riskview.layouts.layout_riskview5_search_results) Search_results,
                               STRING20 AttributesVersionRequest
                              ) := FUNCTION
     
    Invalid_addr_request := Trim(Std.Str.ToLowerCase(AttributesVersionRequest)) not in RiskView.Constants.valid_attributes;
    FIS_custom_addr_request := Trim(Std.Str.ToLowerCase(AttributesVersionRequest)) = RiskView.Constants.FIS_custom_attr_request;

    emptyNameValuePairs := Dataset([], iesp.share.t_NameValuePair);

    nameValuePairsVersion5 :=  NORMALIZE(Search_results, 202, RiskView.Transforms.intoVersion5(LEFT, COUNTER))(trim(value)<>'');
    nameValuePairsFIS := NORMALIZE(Search_results, 8, RiskView.Transforms.intoFISattrs(LEFT, COUNTER));
    
    //Assign tags to sort the order of the attribute groups
    Version5Tagged := PROJECT(nameValuePairsVersion5, TRANSFORM({iesp.share.t_NameValuePair, UNSIGNED1 Tag}, SELF.Tag := 1; SELF := LEFT));
    FISTagged      := PROJECT(nameValuePairsFIS, TRANSFORM({iesp.share.t_NameValuePair, UNSIGNED1 Tag}, SELF.Tag := 2; SELF := LEFT));
    
    FIS_attr_set := PROJECT(SORT(Version5Tagged + FISTagged, Tag), TRANSFORM(iesp.share.t_NameValuePair, SELF := LEFT));
     
    FullAttrSet := Map(Invalid_addr_request    => emptyNameValuePairs,     //invalid request, return nothing
                       FIS_custom_addr_request => FIS_attr_set,            //FIS custom attrs requested, return v5 set plus FIS custom set
                                                  nameValuePairsVersion5); //Otherwise return the normal v5 set
     
     Return FullAttrSet;
     
  END;

END; // Functions Module END

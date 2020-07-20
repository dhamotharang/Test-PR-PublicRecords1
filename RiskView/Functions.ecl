IMPORT IESP, Risk_Indicators, Riskview, Gateway, Risk_Reporting, STD;

EXPORT Functions := MODULE

EXPORT JuLiProcessDTE(DATASET({string32 DeferredTransactionID}) DeferredTransactionIDs,  grouped dataset(risk_indicators.Layout_Boca_Shell) clam, dataset(Gateway.Layouts.Config) gateways, dataset(riskview.layouts.layout_riskview5_search_results) riskview5_final_results, BOOLEAN InvokeDTE = FALSE) := FUNCTION

RecsToDTE := PROJECT(DeferredTransactionIDs,TRANSFORM(IESP.DTE_GetRequestInfo.t_DTEGetRequestInfoRequest, SELF.TransactionID := LEFT.DeferredTransactionID; SELF := [];));

GetRequestInfoGW := gateways(STD.Str.ToLowerCase(ServiceName)=Gateway.Constants.ServiceName.GetRequestInfo)[1];

makeDTEGatewayCall := GetRequestInfoGW.URL <> '' AND InvokeDTE = TRUE;

GetRequestInfo := Gateway.Soapcall_DTEGetRequestInfo(RecsToDTE, GetRequestInfoGW, pMakeGatewayCall := makeDTEGatewayCall);

LiensAppendSuppressFlag := JOIN(GetRequestInfo, clam[1].LnJ_datasets.lnjliens, 
LEFT.RMSID = RIGHT.RMSID AND LEFT.TMSID = RIGHT.TMSID, 
TRANSFORM(RECORDOF(RIGHT), 
SELF.SuppressRecord := IF(LEFT.TaskStatus <> '0', TRUE, FALSE);
SELF := RIGHT;
));

JudgmentsAppendSuppressFlag := JOIN(GetRequestInfo, clam[1].LnJ_datasets.lnjjudgments, 
LEFT.RMSID = RIGHT.RMSID AND LEFT.TMSID = RIGHT.TMSID, 
TRANSFORM(RECORDOF(RIGHT), 
SELF.SuppressRecord := IF(LEFT.TaskStatus <> '0', TRUE, FALSE);
SELF := RIGHT;
));

riskview5_suppressed := PROJECT(riskview5_final_results, 
TRANSFORM(RECORDOF(LEFT), 
SELF.LnJLiens := LiensAppendSuppressFlag(SuppressRecord = FALSE);
SELF.LnJJudgments := JudgmentsAppendSuppressFlag(SuppressRecord = FALSE);
SELF := LEFT;));

RETURN riskview5_suppressed;
END; // JuLiProcessDTE END

EXPORT JuLiProcessStatusRefresh(grouped dataset(risk_indicators.Layout_Boca_Shell) clam, dataset(Gateway.Layouts.Config) gateways, dataset(riskview.layouts.layout_riskview5_search_results) riskview5_final_results, boolean ExcludeStatusRefresh, string10 StatusRefreshWaitPeriod, string10 ESPInterfaceVersion, boolean IsBatch, dataset(RiskView.Layouts.layout_riskview_input) riskview_in, BOOLEAN InvokeStatusRefresh = FALSE) := FUNCTION

LNJRow := PROJECT(UNGROUP(clam), 
TRANSFORM(Risk_Indicators.Layouts_Derog_Info.LJ_DataSets, 
SELF.lnjliens := LEFT.LnJ_datasets.lnjliens;
SELF.lnjjudgments := LEFT.LnJ_datasets.lnjjudgments;));

StatusRefreshModule := RiskView.InitiateStatusRefresh(LNJRow, gateways, 5, 0, true, StatusRefreshWaitPeriod, InvokeStatusRefresh);
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

/* ****************************************************************
*  Deferred Task ESP (DTE) Logging Functionality  *
******************************************************************/

{RECORDOF(StatusRefreshResults), INTEGER Seq} AppendStatusRefreshSeq(StatusRefreshResults L, INTEGER c) := TRANSFORM
  SELF.Seq := c;
  SELF := L;
END;

StatusRefreshWithRequestXML := PROJECT(StatusRefreshResults, AppendStatusRefreshSeq(LEFT,COUNTER));

LiensFormatted := PROJECT(Suppressed_Liens, TRANSFORM({STRING LexID, STRING RMSID, STRING TMSID, BOOLEAN HighRiskCheck},
SELF.LexID := (STRING)LEFT.Did;
SELF.RMSID := LEFT.RMSID;
SELF.TMSID := LEFT.TMSID;
SELF.HighRiskCheck := LEFT.HighRiskCheck;));

JudgmentsFormatted := PROJECT(Suppressed_Judgments, TRANSFORM({STRING LexID, STRING RMSID, STRING TMSID, BOOLEAN HighRiskCheck},
SELF.LexID := (STRING)LEFT.Did;
SELF.RMSID := LEFT.RMSID;
SELF.TMSID := LEFT.TMSID;
SELF.HighRiskCheck := LEFT.HighRiskCheck;));

SuppressedLNJ := (LiensFormatted + JudgmentsFormatted)(HighRiskCheck = TRUE);

{RECORDOF(SuppressedLNJ), INTEGER Seq} AppendLNJSeq(SuppressedLNJ L, INTEGER c) := TRANSFORM
  SELF.Seq := c;
  SELF := L;
END;

SuppressedLNJ_w_seq := PROJECT(SuppressedLNJ, AppendLNJSeq(LEFT, COUNTER));

JoinStatusRefreshWithLNJ := JOIN(SuppressedLNJ_w_seq, StatusRefreshWithRequestXML, LEFT.Seq = RIGHT.Seq, 
TRANSFORM(RECORDOF({StatusRefreshWithRequestXML, INTEGER LexID, STRING RMSID, STRING TMSID}),
SELF.LexID := (INTEGER)LEFT.LexID;
SELF.RMSID := LEFT.RMSID;
SELF.TMSID := LEFT.TMSID;
SELF := RIGHT;)
);

GetAccountNumbers := JOIN(JoinStatusRefreshWithLNJ, riskview_in, 
LEFT.LexID = (INTEGER)RIGHT.LexID,
TRANSFORM({RECORDOF(LEFT), STRING AcctNo},
SELF.AcctNo := RIGHT.AcctNo;
SELF := LEFT;));

IF(IsBatch = FALSE AND COUNT(JoinStatusRefreshWithLNJ(Response.Result.TaskID <> '')) > 0 AND InvokeStatusRefresh = TRUE, 
OUTPUT(PROJECT(JoinStatusRefreshWithLNJ, 
TRANSFORM(Risk_Reporting.Layouts.LOG_DTE_Layout,
SELF.TaskID := LEFT.Response.Result.TaskID;
SELF.TaskDescription := 'Status Refresh Task';
SELF.Request_XML := '<Request_XML><RMSID>' + LEFT.RMSID + '</RMSID>' + '<TMSID>' + LEFT.TMSID + '</TMSID></Request_XML>';
)), NAMED('LOG_Deferred_Task_ESP')));

IF(IsBatch = TRUE AND COUNT(GetAccountNumbers(Response.Result.TaskID <> '')) > 0 AND InvokeStatusRefresh = TRUE, 
OUTPUT(PROJECT(GetAccountNumbers, 
TRANSFORM({STRING AcctNo, Risk_Reporting.Layouts.LOG_DTE_Layout},
SELF.AcctNo := LEFT.AcctNo;
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

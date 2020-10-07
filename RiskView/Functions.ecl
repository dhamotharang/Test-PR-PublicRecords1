IMPORT IESP, Risk_Indicators, Riskview, Gateway, Risk_Reporting, STD;

EXPORT Functions := MODULE

EXPORT JuLiProcessDTE(DATASET({string32 DeferredTransactionID}) DeferredTransactionIDs,  grouped dataset(risk_indicators.Layout_Boca_Shell) clam, dataset(Gateway.Layouts.Config) gateways, dataset(riskview.layouts.layout_riskview5_search_results) riskview5_final_results, BOOLEAN InvokeDTE = FALSE) := FUNCTION

RecsToDTE := PROJECT(DeferredTransactionIDs,TRANSFORM(IESP.DTE_GetRequestInfo.t_DTEGetRequestInfoRequest, SELF.TransactionID := LEFT.DeferredTransactionID; SELF := [];));

GetRequestInfoGW := gateways(STD.Str.ToLowerCase(ServiceName)=Gateway.Constants.ServiceName.GetRequestInfo)[1];

makeDTEGatewayCall := GetRequestInfoGW.URL <> '' AND InvokeDTE = TRUE;

GetRequestInfo := Gateway.Soapcall_DTEGetRequestInfo(RecsToDTE, GetRequestInfoGW, pMakeGatewayCall := makeDTEGatewayCall);

ErrorInXMLorJSON := GetRequestInfo[1].ErrorCode = '44' OR GetRequestInfo[1].ErrorCode = '45' OR (INTEGER)GetRequestInfo[1].ErrorCode < 0;

LiensAppendSuppressFlag := JOIN(GetRequestInfo, clam[1].LnJ_datasets.lnjliens, 
LEFT.RMSID = RIGHT.RMSID AND LEFT.TMSID = RIGHT.TMSID, 
TRANSFORM({RECORDOF(RIGHT), BOOLEAN HasError}, 
SELF.SuppressRecord := IF(LEFT.TaskStatus <> '0' OR LEFT.ErrorMessage <> '' OR ErrorInXMLorJSON, TRUE, FALSE);
SELF.HasError := IF(ErrorInXMLorJSON, TRUE, FALSE);
SELF := RIGHT;
));

JudgmentsAppendSuppressFlag := JOIN(GetRequestInfo, clam[1].LnJ_datasets.lnjjudgments, 
LEFT.RMSID = RIGHT.RMSID AND LEFT.TMSID = RIGHT.TMSID, 
TRANSFORM({RECORDOF(RIGHT), BOOLEAN HasError},
SELF.SuppressRecord := IF(LEFT.TaskStatus <> '0' OR LEFT.ErrorMessage <> '' OR ErrorInXMLorJSON, TRUE, FALSE);
SELF.HasError := IF(ErrorInXMLorJSON, TRUE, FALSE);
SELF := RIGHT;
));

JudgmentsANDLiensHasErrorRecords := (COUNT(LiensAppendSuppressFlag(HasError = TRUE)) + COUNT(JudgmentsAppendSuppressFlag(HasError = TRUE))) > 0;

riskview5_suppressed := PROJECT(riskview5_final_results, 
TRANSFORM(RECORDOF(LEFT),
SELF.Exception_Code := IF(JudgmentsANDLiensHasErrorRecords, '-1', '');
SELF.LnJLiens := PROJECT(LiensAppendSuppressFlag(SuppressRecord = FALSE), TRANSFORM(RECORDOF(clam[1].LnJ_datasets.lnjliens), SELF := LEFT));
SELF.LnJJudgments := PROJECT(JudgmentsAppendSuppressFlag(SuppressRecord = FALSE), TRANSFORM(RECORDOF(clam[1].LnJ_datasets.lnjjudgments), SELF := LEFT));
SELF := LEFT;));

RETURN riskview5_suppressed;
END; // JuLiProcessDTE END

EXPORT JuLiProcessStatusRefresh(grouped dataset(risk_indicators.Layout_Boca_Shell) clam, dataset(Gateway.Layouts.Config) gateways, dataset(riskview.layouts.layout_riskview5_search_results) riskview5_final_results, boolean ExcludeStatusRefresh, string10 StatusRefreshWaitPeriod, string10 ESPInterfaceVersion, boolean IsBatch, dataset(RiskView.Layouts.layout_riskview_input) riskview_in, BOOLEAN InvokeStatusRefresh = FALSE) := FUNCTION

{Risk_Indicators.Layouts_Derog_Info.LJ_DataSets, STRING UID} LNJAppendUID(risk_indicators.Layout_Boca_Shell L, INTEGER c) := TRANSFORM
UID := 'LNJ' + (STRING)c + '|';
SELF.UID := UID;
lnjliens := PROJECT(L.LnJ_datasets.lnjliens, TRANSFORM(Risk_Indicators.Layouts_Derog_Info.Liens, SELF.UID := UID; SELF := LEFT));
SELF.lnjliens := lnjliens;
lnjjudgments := PROJECT(L.LnJ_datasets.lnjjudgments, TRANSFORM(Risk_Indicators.Layouts_Derog_Info.Judgments, SELF.UID := UID; SELF := LEFT));
SELF.lnjjudgments := lnjjudgments;
END;

LNJRow := PROJECT(UNGROUP(clam), LNJAppendUID(LEFT,COUNTER));

StatusRefreshModule := RiskView.InitiateStatusRefresh(LNJRow, gateways, 5, 0, true, StatusRefreshWaitPeriod, InvokeStatusRefresh, ExcludeStatusRefresh);
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

IsHighRiskLiens := COUNT(Suppressed_Liens(HighRiskCheck = TRUE)) > 0;
IsHighRiskJudgments := COUNT(Suppressed_Judgments(HighRiskCheck = TRUE)) > 0;

riskview5_suppressed := IF(~StatusRefreshRecommendGWError OR ~StatusRefreshGWError,
IF(ExcludeStatusRefresh = TRUE, PROJECT(riskview5_final_results, 
TRANSFORM(RECORDOF(LEFT), 
SELF.LnJLiens := Suppressed_Liens(HighRiskCheck = FALSE);
SELF.LnJJudgments := Suppressed_Judgments(HighRiskCheck = FALSE);
SELF := LEFT;)),
PROJECT(riskview5_final_results, 
TRANSFORM(RECORDOF(LEFT), 
SELF.LnJLiens := IF(IsHighRiskLiens OR IsHighRiskJudgments, DATASET([], RECORDOF(Suppressed_Liens)), Suppressed_Liens);
SELF.LnJJudgments :=  IF(IsHighRiskLiens OR IsHighRiskJudgments, DATASET([], RECORDOF(Suppressed_Judgments)), Suppressed_Judgments);
SELF := LEFT;))));

riskview_final_results_with_deferred := IF(COUNT(StatusRefreshResults) > 0,
                                                                    PROJECT(riskview5_final_results, 
                                                                    TRANSFORM(RECORDOF(LEFT), 
                                                                    SELF.Status_Code := IF(ExcludeStatusRefresh, '', Riskview.Constants.Deferred_request_code); 
                                                                    SELF.Message :=  IF(ExcludeStatusRefresh, '', Riskview.Constants.Deferred_request_desc);
                                                                    SELF.TransactionID :=  IF(ExcludeStatusRefresh, '', StatusRefreshResults[1].response._Header.TransactionID);
                                                                    SELF := LEFT;)),
                                                                    riskview5_final_results);
                                                                    
riskview5_suppressed_with_deferred := IF(COUNT(StatusRefreshResults) > 0,
                                                                    PROJECT(riskview5_suppressed, 
                                                                    TRANSFORM(RECORDOF(LEFT), 
                                                                    SELF.Status_Code :=  IF(ExcludeStatusRefresh, '', Riskview.Constants.Deferred_request_code);
                                                                    SELF.Message :=  IF(ExcludeStatusRefresh, '', Riskview.Constants.Deferred_request_desc);
                                                                    SELF.TransactionID :=  IF(ExcludeStatusRefresh, '', StatusRefreshResults[1].response._Header.TransactionID);
                                                                    SELF := LEFT;)),
                                                                    riskview5_suppressed);
                                                                    
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

{RECORDOF(riskview_in), STRING UID} InputAppendUID(Riskview_In L, INTEGER c) := TRANSFORM
UID := 'LNJ' + (STRING)c;
SELF.UID := UID;
SELF := L;
END;

riskview_in_w_UID := PROJECT(Riskview_In, InputAppendUID(LEFT,COUNTER));

GetAccountNumbers := JOIN(JoinStatusRefreshWithLNJ, riskview_in_w_UID, 
REGEXFIND('^[^|]+', LEFT.Response._Header.QueryID, 0) = RIGHT.UID,
TRANSFORM({RECORDOF(LEFT), STRING AcctNo},
SELF.AcctNo := RIGHT.AcctNo;
SELF := LEFT;));

IF(IsBatch = FALSE AND COUNT(JoinStatusRefreshWithLNJ(Response.Result.TaskID <> '')) > 0 AND InvokeStatusRefresh = TRUE AND ExcludeStatusRefresh = FALSE, 
OUTPUT(PROJECT(JoinStatusRefreshWithLNJ, 
TRANSFORM(Risk_Reporting.Layouts.LOG_DTE_Layout,
SELF.TaskID := LEFT.Response.Result.TaskID;
SELF.TaskDescription := 'Status Refresh Task';
SELF.Request_XML := '<Request_XML><RMSID>' + LEFT.RMSID + '</RMSID>' + '<TMSID>' + LEFT.TMSID + '</TMSID></Request_XML>';
)), NAMED('LOG_Deferred_Task_ESP')));

IF(IsBatch = TRUE AND COUNT(GetAccountNumbers(Response.Result.TaskID <> '')) > 0 AND InvokeStatusRefresh = TRUE AND ExcludeStatusRefresh = FALSE, 
OUTPUT(PROJECT(GetAccountNumbers, 
TRANSFORM({STRING AcctNo, Risk_Reporting.Layouts.LOG_DTE_Layout},
SELF.AcctNo := LEFT.AcctNo;
SELF.TaskID := LEFT.Response.Result.TaskID;
SELF.TaskDescription := 'Status Refresh Task';
SELF.Request_XML := '<Request_XML><RMSID>' + LEFT.RMSID + '</RMSID>' + '<TMSID>' + LEFT.TMSID + '</TMSID></Request_XML>';
)), NAMED('LOG_Deferred_Task_ESP')));

RETURN MAP(StatusRefreshRecommendGWError OR StatusRefreshGWError => riskview5_status_refresh_error,
                          (REAL)ESPInterfaceVersion <= 2.5 => riskview_final_results_with_deferred,
                          riskview5_suppressed_with_deferred);
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

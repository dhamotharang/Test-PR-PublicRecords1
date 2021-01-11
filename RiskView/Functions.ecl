IMPORT IESP, Risk_Indicators, Riskview, Gateway, Risk_Reporting, STD;

EXPORT Functions := MODULE

EXPORT JuLiProcessDTE(DATASET({STRING32 DeferredTransactionID}) DeferredTransactionIDs,  
                                                GROUPED DATASET(risk_indicators.Layout_Boca_Shell) Clam, 
                                                DATASET(Gateway.Layouts.Config) Gateways, 
                                                DATASET(Riskview.Layouts.Layout_Riskview5_Search_Results) RiskviewFinalResults, 
                                                BOOLEAN InvokeDTE = FALSE) := FUNCTION

    RecsToDTE := PROJECT(DeferredTransactionIDs,TRANSFORM(IESP.DTE_GetRequestInfo.t_DTEGetRequestInfoRequest, SELF.TransactionID := LEFT.DeferredTransactionID; SELF := [];));

    GetRequestInfoGW := Gateways(STD.Str.ToLowerCase(ServiceName) = Gateway.Constants.ServiceName.GetRequestInfo)[1];

    MakeDTEGatewayCall := GetRequestInfoGW.URL <> '' AND InvokeDTE = TRUE;

    GetRequestInfo := Gateway.Soapcall_DTEGetRequestInfo(RecsToDTE, GetRequestInfoGW, pMakeGatewayCall := MakeDTEGatewayCall);

    ErrorInXMLorJSON := GetRequestInfo[1].ErrorCode = '44' OR GetRequestInfo[1].ErrorCode = '45' OR (INTEGER)GetRequestInfo[1].ErrorCode < 0;

    LiensAppendSuppressFlag := JOIN(clam[1].LnJ_datasets.lnjliens, GetRequestInfo, 
        LEFT.RMSID = RIGHT.RMSID AND LEFT.TMSID = RIGHT.TMSID, 
        TRANSFORM({RECORDOF(LEFT), BOOLEAN HasError}, 
        IsDeferredLien := LEFT.RMSID = RIGHT.RMSID AND LEFT.TMSID = RIGHT.TMSID;
        FirstDefendant := RIGHT.responsejson.parties(STD.Str.ToUpperCase(PartyType) = Riskview.Constants.DefendantDesc)[1];
        ErrorCondition := (INTEGER)RIGHT.TaskStatus <> 0 OR RIGHT.ErrorMessage <> '' OR ErrorInXMLorJSON;
        CleanedReleaseDate := (STRING)STD.Date.FromStringToDate(FirstDefendant.ReleaseDate, '%m/%d/%Y');
        SELF.SuppressRecord := IF(ErrorCondition OR ((FirstDefendant.FilingType <> LEFT.LienType OR CleanedReleaseDate <> LEFT.ReleaseDate) AND IsDeferredLien), TRUE, FALSE);
        SELF.HasError := IF(ErrorCondition, TRUE, FALSE);
        SELF := LEFT;
    ), LEFT OUTER);

    JudgmentsAppendSuppressFlag := JOIN(clam[1].LnJ_datasets.lnjjudgments, GetRequestInfo,
        LEFT.RMSID = RIGHT.RMSID AND LEFT.TMSID = RIGHT.TMSID, 
        TRANSFORM({RECORDOF(LEFT), BOOLEAN HasError},
        IsDeferredJudgment := LEFT.RMSID = RIGHT.RMSID AND LEFT.TMSID = RIGHT.TMSID;
        FirstDefendant := RIGHT.responsejson.parties(STD.Str.ToUpperCase(PartyType) = Riskview.Constants.DefendantDesc)[1];
        ErrorCondition := (INTEGER)RIGHT.TaskStatus <> 0 OR RIGHT.ErrorMessage <> '' OR ErrorInXMLorJSON;
        CleanedReleaseDate := (STRING)STD.Date.FromStringToDate(FirstDefendant.ReleaseDate, '%m/%d/%Y');
        SELF.SuppressRecord := IF(ErrorCondition OR ((FirstDefendant.FilingType <> LEFT.JudgmentType OR CleanedReleaseDate <> LEFT.ReleaseDate) AND IsDeferredJudgment), TRUE, FALSE);
        SELF.HasError := IF(ErrorCondition, TRUE, FALSE);
        SELF := LEFT;
    ), LEFT OUTER);

    JudgmentsANDLiensHasErrorRecords := (COUNT(LiensAppendSuppressFlag(HasError = TRUE)) + COUNT(JudgmentsAppendSuppressFlag(HasError = TRUE))) > 0;

    riskview5_suppressed := PROJECT(RiskviewFinalResults, 
        TRANSFORM(Riskview.Layouts.Layout_Riskview5_Search_Results,
        SELF.Exception_Code := IF(JudgmentsANDLiensHasErrorRecords, Riskview.Constants.DTEError, '');
        SELF.LnJLiens := PROJECT(LiensAppendSuppressFlag(SuppressRecord = FALSE), TRANSFORM(RECORDOF(clam[1].LnJ_datasets.lnjliens), SELF := LEFT));
        SELF.LnJJudgments := PROJECT(JudgmentsAppendSuppressFlag(SuppressRecord = FALSE), TRANSFORM(RECORDOF(clam[1].LnJ_datasets.lnjjudgments), SELF := LEFT));
        SELF := LEFT;));

    RETURN riskview5_suppressed;
END; // JuLiProcessDTE END

EXPORT JuLiProcessStatusRefresh(GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) Clam, 
                                                                DATASET(Gateway.Layouts.Config) Gateways, 
                                                                DATASET(Riskview.Layouts.Layout_Riskview5_Search_Results) RiskviewFinalResults, 
                                                                BOOLEAN ExcludeStatusRefresh, STRING10 StatusRefreshWaitPeriod, 
                                                                BOOLEAN IsBatch, 
                                                                DATASET(RiskView.Layouts.Layout_Riskview_Input) RiskviewIn, 
                                                                BOOLEAN InvokeStatusRefresh = FALSE,
                                                                INTEGER GatewayWaitTime = 5, 
                                                                INTEGER GatewayRetries = 0,
                                                                BOOLEAN TestOKCStatusRefresh = TRUE) := FUNCTION

    // We need a unique identifier besides LexID to link particular Liens/Judgments back to a given AcctNo/Person
    {Risk_Indicators.Layouts_Derog_Info.LJ_DataSets, STRING UID} LNJAppendUID(risk_indicators.Layout_Boca_Shell L, INTEGER c) := TRANSFORM
        UID := 'LNJ' + (STRING)c + '|';
        SELF.UID := UID;
        SELF.LnJLiens := IF(COUNT(L.LnJ_datasets.lnjliens((INTEGER)Seq > 0)) > 0, PROJECT(L.LnJ_datasets.lnjliens, TRANSFORM(Risk_Indicators.Layouts_Derog_Info.Liens, SELF.UID := UID + (STRING)hash(LEFT.orig_rmsid, LEFT.did); SELF := LEFT)), DATASET([], Risk_Indicators.Layouts_Derog_Info.Liens));
        SELF.LnJJudgments := IF(COUNT(L.LnJ_datasets.lnjjudgments((INTEGER)Seq > 0)) > 0, PROJECT(L.LnJ_datasets.lnjjudgments, TRANSFORM(Risk_Indicators.Layouts_Derog_Info.Judgments, SELF.UID := UID + (STRING)hash(LEFT.orig_rmsid, LEFT.did); SELF := LEFT)), DATASET([], Risk_Indicators.Layouts_Derog_Info.Judgments));
    END;

    LNJRow := PROJECT(UNGROUP(clam), LNJAppendUID(LEFT,COUNTER));

    // Adds a matching UID prefix for batch so we can join the input dataset to the status refresh result to get AcctNo
    {RiskView.Layouts.Layout_Riskview_Input, STRING UID} InputAppendUID(RiskView.Layouts.Layout_Riskview_Input L, INTEGER c) := TRANSFORM
        UID := 'LNJ' + (STRING)c;
        SELF.UID := UID;
        SELF := L;
    END;

    RiskviewInWithUID := PROJECT(RiskviewIn, InputAppendUID(LEFT,COUNTER));

    {Riskview.Layouts.Layout_Riskview5_Search_Results, STRING UID} RiskviewFinalAppendUID(Riskview.Layouts.Layout_Riskview5_Search_Results L, INTEGER c) := TRANSFORM
        UID := 'LNJ' + (STRING)c;
        SELF.UID := UID;
        SELF := L;
    END;

    RiskviewFinalWithUID := PROJECT(RiskviewFinalResults, RiskviewFinalAppendUID(LEFT,COUNTER));

    /* ****************************************************************
    *                Grab all status refresh result datasets                * 
    ******************************************************************/
    StatusRefreshModule := RiskView.InitiateStatusRefresh(LNJRow, gateways, GatewayWaitTime, GatewayRetries, TestOKCStatusRefresh, StatusRefreshWaitPeriod, InvokeStatusRefresh, ExcludeStatusRefresh);
    StatusRefreshResults := StatusRefreshModule.StatusRefresh;
    StatusRefreshRecommendGWError := StatusRefreshModule.RefreshRecommendedGatewayError;
    StatusRefreshGWError := StatusRefreshModule.RefreshGatewayError;
    SuppressedLiens := StatusRefreshModule.SuppressRecordsLiens;
    SuppressedJudgments :=  StatusRefreshModule.SuppressRecordsJudgments;

    RiskviewStatusRefreshError := IF(StatusRefreshRecommendGWError OR StatusRefreshGWError, 
        PROJECT(RiskviewFinalResults, TRANSFORM(Riskview.Layouts.Layout_Riskview5_Search_Results,
        SELF.Exception_Code := Riskview.Constants.OKCError;
        SELF := LEFT;)));

    IsHighRiskLiens := COUNT(SuppressedLiens(HighRiskCheck = TRUE)) > 0;
    IsHighRiskJudgments := COUNT(SuppressedJudgments(HighRiskCheck = TRUE)) > 0;

    /* 
    If a Lien/Judgment is identified as high risk and ExcludeStatusRefresh = TRUE, exclude it from the report output. 
    Otherwise, if any Lien/Judgment is identified as high risk and ExcludeStatusRefresh = FALSE, suppress the entire report output.
    */
    RiskviewResultSuppressed := IF(~StatusRefreshRecommendGWError OR ~StatusRefreshGWError,
        IF(ExcludeStatusRefresh = TRUE, PROJECT(RiskviewFinalWithUID, 
        TRANSFORM(Riskview.Layouts.Layout_Riskview5_Search_Results, 
        SELF.LnJLiens := SuppressedLiens(HighRiskCheck = FALSE AND REGEXFIND('^[^|]+', UID, 0) = LEFT.UID);
        SELF.LnJJudgments := SuppressedJudgments(HighRiskCheck = FALSE AND REGEXFIND('^[^|]+', UID, 0) = LEFT.UID);
        SELF := LEFT;)),
        PROJECT(RiskviewFinalWithUID, 
        TRANSFORM(Riskview.Layouts.Layout_Riskview5_Search_Results, 
        SELF.LnJLiens := IF(IsHighRiskLiens OR IsHighRiskJudgments, DATASET([], RECORDOF(SuppressedLiens)), SuppressedLiens(REGEXFIND('^[^|]+', UID, 0) = LEFT.UID));
        SELF.LnJJudgments :=  IF(IsHighRiskLiens OR IsHighRiskJudgments, DATASET([], RECORDOF(SuppressedJudgments)), SuppressedJudgments(REGEXFIND('^[^|]+', UID, 0) = LEFT.UID));
        SELF := LEFT;))));
                                                                   
    RiskviewResultDeferred := IF(COUNT(StatusRefreshResults) > 0,
        PROJECT(RiskviewResultSuppressed, 
        TRANSFORM(Riskview.Layouts.Layout_Riskview5_Search_Results, 
        SELF.Status_Code :=  IF(ExcludeStatusRefresh, '', Riskview.Constants.Deferred_request_code);
        SELF.Message :=  IF(ExcludeStatusRefresh, '', Riskview.Constants.Deferred_request_desc);
        SELF.TransactionID :=  IF(ExcludeStatusRefresh, '', StatusRefreshResults[1].response._Header.TransactionID);
        SELF := LEFT;)),
        RiskviewResultSuppressed);
                                                                        
    /* ****************************************************************
    *  Deferred Task ESP (DTE) Logging Functionality           *
    ******************************************************************/

    LnJSlimLayout := RECORD
        STRING RMSID;
        STRING TMSID;
        BOOLEAN HighRiskCheck;
        STRING UID;
    END;

    LiensFormatted := PROJECT(SuppressedLiens, TRANSFORM(LnJSlimLayout, SELF := LEFT));

    JudgmentsFormatted := PROJECT(SuppressedJudgments, TRANSFORM(LnJSlimLayout, SELF := LEFT));

    HighRiskLNJ := (LiensFormatted + JudgmentsFormatted)(HighRiskCheck = TRUE);

    JoinStatusRefreshWithLNJ := IF(~ExcludeStatusRefresh, JOIN(HighRiskLNJ, StatusRefreshResults, LEFT.UID = RIGHT.Response._Header.QueryID, 
        TRANSFORM({StatusRefreshResults, STRING RMSID, STRING TMSID},
        SELF.RMSID := LEFT.RMSID;
        SELF.TMSID := LEFT.TMSID;
        SELF := RIGHT;)));

    LNJGetAccountNumbers := JOIN(JoinStatusRefreshWithLNJ, RiskviewInWithUID, 
        REGEXFIND('^[^|]+', LEFT.Response._Header.QueryID, 0) = RIGHT.UID,
        TRANSFORM({JoinStatusRefreshWithLNJ, STRING AcctNo},
        SELF.AcctNo := RIGHT.AcctNo;
        SELF := LEFT;));

    // Batch and XML have two different outputs for this child dataset. This does the logging for ESP/Batch and they move it to the DTE.
    IF(IsBatch = FALSE AND COUNT(JoinStatusRefreshWithLNJ(Response.Result.TaskID <> '')) > 0 AND InvokeStatusRefresh = TRUE AND ExcludeStatusRefresh = FALSE, 
        OUTPUT(PROJECT(JoinStatusRefreshWithLNJ, 
        TRANSFORM(Risk_Reporting.Layouts.LOG_DTE_Layout,
        SELF.TaskID := LEFT.Response.Result.TaskID;
        SELF.TaskDescription := 'Status Refresh Task';
        SELF.Request_XML := '<Request_XML><RMSID>' + LEFT.RMSID + '</RMSID>' + '<TMSID>' + LEFT.TMSID + '</TMSID></Request_XML>';
        )), NAMED('LOG_Deferred_Task_ESP')));

    IF(IsBatch = TRUE AND COUNT(LNJGetAccountNumbers(Response.Result.TaskID <> '')) > 0 AND InvokeStatusRefresh = TRUE AND ExcludeStatusRefresh = FALSE, 
        OUTPUT(PROJECT(LNJGetAccountNumbers, 
        TRANSFORM({STRING AcctNo, Risk_Reporting.Layouts.LOG_DTE_Layout},
        SELF.AcctNo := LEFT.AcctNo;
        SELF.TaskID := LEFT.Response.Result.TaskID;
        SELF.TaskDescription := 'Status Refresh Task';
        SELF.Request_XML := '<Request_XML><RMSID>' + LEFT.RMSID + '</RMSID>' + '<TMSID>' + LEFT.TMSID + '</TMSID></Request_XML>';
        )), NAMED('LOG_Deferred_Task_ESP')));

    RETURN IF(StatusRefreshRecommendGWError OR StatusRefreshGWError, RiskviewStatusRefreshError, RiskviewResultDeferred);
END; // JuLiProcessStatusRefresh END

  EXPORT Format_riskview_attrs(Dataset(riskview.layouts.layout_riskview5_search_results) Search_results,
                               STRING20 AttributesVersionRequest
                              ) := FUNCTION
     
    Invalid_addr_request := Trim(Std.Str.ToLowerCase(AttributesVersionRequest)) not in RiskView.Constants.valid_attributes;
    FIS_custom_addr_request := Trim(Std.Str.ToLowerCase(AttributesVersionRequest)) = RiskView.Constants.FIS_custom_attr_request;

    emptyNameValuePairs := Dataset([], iesp.share.t_NameValuePair);

    nameValuePairsVersion5 :=  NORMALIZE(Search_results, 203, RiskView.Transforms.intoVersion5(LEFT, COUNTER))(trim(value)<>'');
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

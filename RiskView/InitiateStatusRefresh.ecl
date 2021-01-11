IMPORT Risk_Indicators, Gateway, IESP, STD;

EXPORT InitiateStatusRefresh(DATASET({Risk_Indicators.Layouts_Derog_Info.LJ_DataSets, STRING UID}) LnJDataset,
                                                      DATASET(Gateway.Layouts.Config) Gateways, 
                                                      INTEGER GatewayWaitTime = 5, 
                                                      INTEGER GatewayRetries = 0, 
                                                      BOOLEAN TestOKCStatusRefresh = FALSE,
                                                      STRING5 StatusRefreshWaitPeriod = '',
                                                      BOOLEAN IncludeStatusRefreshChecks = FALSE,
                                                      BOOLEAN ExcludeStatusRefresh = FALSE
                                                      ) := MODULE
											
SHARED HighRiskLayoutIn := RECORD
    STRING UID;
    STRING7 CourtID;
    STRING2 FilingTypeID;
    BOOLEAN HighRiskCheck := FALSE;
    STRING17 RMSID;
    BOOLEAN IsRefreshRecommended;
END;

SHARED LiensDS := LnJDataset.lnjliens;

SHARED JudgmentsDS := LnJDataset.lnjjudgments;

SHARED GWInputLiens := PROJECT(LiensDS, TRANSFORM(HighRiskLayoutIn,
    SELF.UID := LEFT.UID;
    SELF.CourtID := LEFT.AgencyID;
    SELF.FilingTypeID := LEFT.LienTypeID;
    SELF.HighRiskCheck := LEFT.HighRiskCheck;
    SELF.RMSID := LEFT.orig_RMSID;
    SELF := [];
));

SHARED GWInputJudgments := PROJECT(JudgmentsDS, TRANSFORM(HighRiskLayoutIn,
    SELF.UID := LEFT.UID;
    SELF.CourtID := LEFT.AgencyID;
    SELF.FilingTypeID := LEFT.JudgmentTypeID;
    SELF.HighRiskCheck := LEFT.HighRiskCheck;
    SELF.RMSID := LEFT.orig_RMSID;
    SELF := [];
));

SHARED GWInput := GWInputLiens + GWInputJudgments;

SHARED CleanedGWInput := GWInput(HighRiskCheck = TRUE);

/* ****************************************************************
*      OKC Status Refresh Recommended Gateway Call    *
******************************************************************/
SHARED StatusRefreshRecommendedGatewayCfg := Gateways(STD.Str.ToLowerCase(ServiceName)='okcstatusrefreshrecommended')[1];

SHARED MakeStatusRefreshRecommendedGatewayCall := StatusRefreshRecommendedGatewayCfg.url != '' AND IncludeStatusRefreshChecks = TRUE;

SHARED StatusRefreshRecommendedGWInput := PROJECT(CleanedGWInput, 
                                                     TRANSFORM(iesp.okc_statusrefreshrecommended_request.t_OkcStatusRefreshRecommendedRequest,
                                                     SELF.User.QueryID := LEFT.UID;
                                                     SELF.SearchBy.CourtID := LEFT.CourtID;
                                                     SELF.SearchBy.FileTypeId := LEFT.FilingTypeID;
                                                     SELF.User.ReferenceCode := StatusRefreshRecommendedGatewayCfg.TransactionId;
                                                     SELF.Options.Blind := Gateway.Configuration.GetBlindOption(StatusRefreshRecommendedGatewayCfg);
                                                     SELF.Options.TestOkcStatusRefreshRecommendedService := TestOKCStatusRefresh;
                                                     SELF := [];));
	
EXPORT StatusRefreshRecommended := Gateway.SoapCall_OKCStatusRefreshRecommended(StatusRefreshRecommendedGWInput, StatusRefreshRecommendedGatewayCfg, GatewayWaitTime, GatewayRetries, MakeStatusRefreshRecommendedGatewayCall);

EXPORT RefreshRecommendedGatewayError := COUNT(StatusRefreshRecommended(response._Header.message <> '')) > 0;

/* ****************************************************************
*                    OKC Status Refresh Gateway Call  		          *
******************************************************************/
SHARED StatusRefreshGatewayCfg := gateways(STD.Str.ToLowerCase(ServiceName)='okcstatusrefresh')[1];
	
SHARED MakeStatusRefreshGatewayCall := StatusRefreshGatewayCfg.url!=''  AND IncludeStatusRefreshChecks = TRUE AND ExcludeStatusRefresh = FALSE;
					
SHARED StatusRefreshGWInput := JOIN(StatusRefreshRecommended, CleanedGWInput, 
                                                                  LEFT.Response._Header.QueryId = RIGHT.UID AND
                                                                  LEFT.Response.Result.IsRefreshRecommended = TRUE,
                                                                  TRANSFORM(iesp.okc_statusrefresh_request.t_OkcStatusRefreshRequest,
                                                                  SELF.User.QueryID := RIGHT.UID;
                                                                  SELF.User.ReferenceCode := StatusRefreshGatewayCfg.TransactionId;
                                                                  SELF.Options.Blind := Gateway.Configuration.GetBlindOption(StatusRefreshGatewayCfg);
                                                                  SELF.SearchBy.RMSID := RIGHT.RMSID;
                                                                  NumDays := IF(StatusRefreshWaitPeriod <> '', (UNSIGNED)StatusRefreshWaitPeriod, 14);
                                                                  AdjustedCustomerDueDate := (STRING10)STD.Date.AdjustDate(STD.Date.Today(), 0, 0, NumDays);
                                                                  SELF.SearchBy.CustomerDueDate :=  AdjustedCustomerDueDate[5..6] + '/' + AdjustedCustomerDueDate[7..8] + '/' + AdjustedCustomerDueDate[1..4];
                                                                  SELF := [];));
                          
EXPORT StatusRefresh := Gateway.SoapCall_OKCStatusRefresh(StatusRefreshGWInput, StatusRefreshGatewayCfg, GatewayWaitTime, GatewayRetries, makeStatusRefreshGatewayCall);		

EXPORT RefreshGatewayError := COUNT(StatusRefresh(response._Header.message <> '')) > 0;

EXPORT SuppressRecordsJudgments := FUNCTION

RecsToSuppress := JOIN(JudgmentsDS, StatusRefreshRecommended, 
    LEFT.UID = RIGHT.Response._Header.QueryId,
    TRANSFORM(Risk_Indicators.Layouts_Derog_Info.Judgments, 
    SELF.HighRiskCheck := RIGHT.Response.Result.IsRefreshRecommended;
    SELF := LEFT),
    LEFT OUTER);
    
RETURN RecsToSuppress;
END;

EXPORT SuppressRecordsLiens := FUNCTION

RecsToSuppress := JOIN(LiensDS, StatusRefreshRecommended, 
    LEFT.UID = RIGHT.Response._Header.QueryId,
    TRANSFORM(Risk_Indicators.Layouts_Derog_Info.Liens, 
    SELF.HighRiskCheck := RIGHT.Response.Result.IsRefreshRecommended;
    SELF := LEFT),
    LEFT OUTER);

RETURN RecsToSuppress;
END;

END;
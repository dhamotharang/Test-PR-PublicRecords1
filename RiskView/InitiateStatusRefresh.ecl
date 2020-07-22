IMPORT Risk_Indicators, Gateway, IESP, STD;

EXPORT InitiateStatusRefresh(ROW(Risk_Indicators.Layouts_Derog_Info.LJ_DataSets) LnJDataset,
											dataset(Gateway.Layouts.Config) gateways, 
											pWaitTime = 5, 
											pRetries = 0, 
											BOOLEAN TestOKCStatusRefresh = FALSE,
                                            string5 StatusRefreshWaitPeriod = '',
                                            boolean IncludeStatusRefreshChecks = FALSE
											) := MODULE
											
SHARED HighRisk_Layout_In := RECORD
    string7 CourtID;
    string2 FilingTypeID;
    boolean highriskcheck := FALSE;
    string17 RMSID;
    boolean IsRefreshRecommended;
END;

SHARED gw_input_liens := PROJECT(LnJDataset.lnjliens, TRANSFORM(HighRisk_Layout_In,
    SELF.CourtID := LEFT.AgencyID;
    SELF.FilingTypeID := LEFT.LienTypeID;
    SELF.highriskcheck := LEFT.highriskcheck;
    SELF.RMSID := LEFT.orig_RMSID;
    SELF := [];
));

SHARED gw_input_judgments := PROJECT(LnJDataset.lnjjudgments, TRANSFORM(HighRisk_Layout_In,
    SELF.CourtID := LEFT.AgencyID;
    SELF.FilingTypeID := LEFT.JudgmentTypeID;
    SELF.highriskcheck := LEFT.highriskcheck;
    SELF.RMSID := LEFT.orig_RMSID;
    SELF := [];
));
	
SHARED gw_input := gw_input_liens + gw_input_judgments;

SHARED cleaned_gw_input := gw_input(highriskcheck = true);

/* ****************************************************************
*      OKC Status Refresh Recommended Gateway Call  		*
******************************************************************/
SHARED StatusRefreshRecommendedGatewayCfg := gateways(STD.Str.ToLowerCase(ServiceName)='okcstatusrefreshrecommended')[1];

SHARED makeStatusRefreshRecommendedGatewayCall := StatusRefreshRecommendedGatewayCfg.url!='' AND IncludeStatusRefreshChecks = TRUE;

SHARED high_risk_gw_input := PROJECT(cleaned_gw_input, 
                                                        TRANSFORM(iesp.okc_statusrefreshrecommended_request.t_OkcStatusRefreshRecommendedRequest,
                                                        SELF.SearchBy.CourtID := LEFT.CourtID;
                                                        SELF.SearchBy.FileTypeId := LEFT.FilingTypeID;
                                                        SELF.User.ReferenceCode := StatusRefreshRecommendedGatewayCfg.TransactionId;
                                                        SELF.Options.Blind := Gateway.Configuration.GetBlindOption(StatusRefreshRecommendedGatewayCfg);
                                                        SELF.Options.TestOkcStatusRefreshRecommendedService := TestOKCStatusRefresh;
                                                        SELF := [];));
	
EXPORT StatusRefreshRecommended := Gateway.SoapCall_OKCStatusRefreshRecommended(high_risk_gw_input, StatusRefreshRecommendedGatewayCfg, pWaitTime, pRetries, makeStatusRefreshRecommendedGatewayCall);

EXPORT RefreshRecommendedGatewayError := COUNT(StatusRefreshRecommended(response._Header.message <> '')) > 0;

/* ****************************************************************
*                    OKC Status Refresh Gateway Call  		              *
******************************************************************/
SHARED StatusRefreshGatewayCfg := gateways(STD.Str.ToLowerCase(ServiceName)='okcstatusrefresh')[1];
	
SHARED makeStatusRefreshGatewayCall := StatusRefreshGatewayCfg.url!=''  AND IncludeStatusRefreshChecks = TRUE;
					
SHARED status_refresh_gw_input := JOIN(StatusRefreshRecommended, cleaned_gw_input, 
                                                                  LEFT.Response.Result.CourtID = RIGHT.CourtID AND
                                                                  LEFT.Response.Result.FileTypeID = RIGHT.FilingTypeID AND
                                                                  LEFT.Response.Result.IsRefreshRecommended = TRUE,
                                                                  TRANSFORM(iesp.okc_statusrefresh_request.t_OkcStatusRefreshRequest,
                                                                      SELF.User.ReferenceCode := StatusRefreshGatewayCfg.TransactionId;
                                                                      SELF.Options.Blind := Gateway.Configuration.GetBlindOption(StatusRefreshGatewayCfg);
                                                                      SELF.SearchBy.RMSID := RIGHT.RMSID;
                                                                      NumDays := IF(StatusRefreshWaitPeriod <> '', (UNSIGNED)StatusRefreshWaitPeriod, 14);
                                                                      AdjustedCustomerDueDate := (STRING10)STD.Date.AdjustDate(STD.Date.Today(), 0, 0, NumDays);
                                                                      SELF.SearchBy.CustomerDueDate :=  AdjustedCustomerDueDate[5..6] + '/' + AdjustedCustomerDueDate[7..8] + '/' + AdjustedCustomerDueDate[1..4];
                                                                      SELF := [])
                                                                   );
                          
EXPORT StatusRefresh := Gateway.SoapCall_OKCStatusRefresh(status_refresh_gw_input, StatusRefreshGatewayCfg, pWaitTime, pRetries, makeStatusRefreshGatewayCall);		

EXPORT RefreshGatewayError := COUNT(StatusRefresh(response._Header.message <> '')) > 0;

EXPORT SuppressRecordsJudgments() := FUNCTION

SuppressRecordsLayout := RECORD
    Risk_Indicators.Layouts_Derog_Info.Judgments;
END;

RecsToSuppress := JOIN(StatusRefreshRecommended, LnJDataset.lnjjudgments, 
    LEFT.Response.Result.CourtID = RIGHT.AgencyID AND
    LEFT.Response.Result.FileTypeID = RIGHT.JudgmentTypeID,
    TRANSFORM(SuppressRecordsLayout, 
    SELF.HighRiskCheck := LEFT.Response.Result.IsRefreshRecommended;
    SELF := RIGHT));

RETURN RecsToSuppress;
END;

EXPORT SuppressRecordsLiens() := FUNCTION

SuppressRecordsLayout := RECORD
    Risk_Indicators.Layouts_Derog_Info.Liens;
END;

RecsToSuppress := JOIN(StatusRefreshRecommended, LnJDataset.lnjliens, 
    LEFT.Response.Result.CourtID = RIGHT.AgencyID AND
    LEFT.Response.Result.FileTypeID = RIGHT.LienTypeID,
    TRANSFORM(SuppressRecordsLayout, 
    SELF.HighRiskCheck := LEFT.Response.Result.IsRefreshRecommended;
    SELF := RIGHT));

RETURN RecsToSuppress;
END;

END;
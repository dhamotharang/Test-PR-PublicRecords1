IMPORT Risk_Indicators, Gateway, IESP, STD;

EXPORT InitiateStatusRefresh(ROW(Risk_Indicators.Layouts_Derog_Info.LJ_DataSets) LnJDataset,
											dataset(Gateway.Layouts.Config) gateways, 
											pWaitTime = 5, 
											pRetries = 0, 
											BOOLEAN TestOKCStatusRefresh = FALSE
											) := FUNCTION
									
HighRisk_Layout_In := RECORD
	string7 CourtID;
	string2 FilingTypeID;
	boolean highriskcheck := FALSE;
	string17 RMSID;
	boolean IsRefreshRecommended;
END;

gw_input_liens := PROJECT(LnJDataset.lnjliens, TRANSFORM(HighRisk_Layout_In,
	SELF.CourtID := LEFT.AgencyID;
	SELF.FilingTypeID := LEFT.LienTypeID;
	SELF.highriskcheck := LEFT.highriskcheck;
	SELF.RMSID := LEFT.orig_RMSID;
	SELF := [];
	));

gw_input_judgments := PROJECT(LnJDataset.lnjjudgments, TRANSFORM(HighRisk_Layout_In,
	SELF.CourtID := LEFT.AgencyID;
	SELF.FilingTypeID := LEFT.JudgmentTypeID;
	SELF.highriskcheck := LEFT.highriskcheck;
	SELF.RMSID := LEFT.orig_RMSID;
	SELF := [];
	));
	
gw_input := gw_input_liens + gw_input_judgments;

cleaned_gw_input := gw_input(highriskcheck = true);

/* ****************************************************************
*      OKC Status Refresh Recommended Gateway Call  		*
******************************************************************/
StatusRefreshRecommendedGatewayCfg := gateways(STD.Str.ToLowerCase(ServiceName)='okcstatusrefreshrecommended')[1];

makeStatusRefreshRecommendedGatewayCall := StatusRefreshRecommendedGatewayCfg.url!='';

high_risk_gw_input := PROJECT(cleaned_gw_input, 
										 TRANSFORM(iesp.okc_statusrefreshrecommended_request.t_OkcStatusRefreshRecommendedRequest,
																SELF.SearchBy.CourtID := LEFT.CourtID;
																SELF.SearchBy.FileTypeId := LEFT.FilingTypeID;
																SELF.User.ReferenceCode := StatusRefreshRecommendedGatewayCfg.TransactionId;
																SELF.Options.Blind := Gateway.Configuration.GetBlindOption(StatusRefreshRecommendedGatewayCfg);
																SELF.Options.TestOkcStatusRefreshRecommendedService := TestOKCStatusRefresh;
																SELF := [];));
	
StatusRefreshRecommended := Gateway.SoapCall_OKCStatusRefreshRecommended(high_risk_gw_input, StatusRefreshRecommendedGatewayCfg, pWaitTime, pRetries, makeStatusRefreshRecommendedGatewayCall);
					
/* ****************************************************************
*                    OKC Status Refresh Gateway Call  		              *
******************************************************************/
StatusRefreshGatewayCfg := gateways(STD.Str.ToLowerCase(ServiceName)='okcstatusrefresh')[1];
	
makeStatusRefreshGatewayCall := StatusRefreshGatewayCfg.url!='';
					
status_refresh_gw_input := JOIN(StatusRefreshRecommended, cleaned_gw_input, 
LEFT.Response.Result.CourtID = RIGHT.CourtID AND
LEFT.Response.Result.FileTypeID = RIGHT.FilingTypeID AND
LEFT.Response.Result.IsRefreshRecommended = TRUE,
TRANSFORM(iesp.okc_statusrefresh_request.t_OkcStatusRefreshRequest,
														SELF.User.ReferenceCode := StatusRefreshGatewayCfg.TransactionId;
														SELF.Options.Blind := Gateway.Configuration.GetBlindOption(StatusRefreshGatewayCfg);
														SELF.SearchBy.RMSID := RIGHT.RMSID;
													/* Customer Due Date isn't a parameter that OKC is using, but it's still required for the gateway call. 
														In case OKC does start using it one day, a default of two weeks in the future is good enough coverage.
														Customer Due Date must also be of the form 'MM/DD/YYYY' for the gateway to accept it. */
														AdjustedCustomerDueDate := (STRING10)STD.Date.AdjustDate(STD.Date.Today(), 0, 0, 14);
														SELF.SearchBy.CustomerDueDate :=  AdjustedCustomerDueDate[5..6] + '/' + AdjustedCustomerDueDate[7..8] + '/' + AdjustedCustomerDueDate[1..4];
														SELF := []));
					
StatusRefresh := Gateway.SoapCall_OKCStatusRefresh(status_refresh_gw_input, StatusRefreshGatewayCfg, pWaitTime, pRetries, makeStatusRefreshGatewayCall);		
					
RETURN StatusRefresh;
END;
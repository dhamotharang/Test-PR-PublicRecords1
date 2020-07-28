EXPORT fnRunPersonStatsDeltaDashboard() := FUNCTION
	IMPORT RAMPS_WebServices, STD, FraudGovPlatform_Analytics;
	
	//Constants - this is a dashboard currently ONLY used in CERT for QA purposes. This dashboard does NOT yet exists in PROD
	runProd 		:= FALSE;
	useProdData := TRUE;
	newVersion 	:= TRUE;
	dspToUse		:= FraudGovPlatform_Analytics.Constants.RampsWebServices.DspQa;	
	hpccConnection  := FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionQa;

	//Input Parameters
	cmpUuid 						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.PersonStatsDeltaDashboard.CompositionUuid;
	vizVersion 					:= FraudGovPlatform_Analytics.Constants.RampsWebServices.PersonStatsDeltaDashboard.VizServiceVersion;
	reqSource 					:= FraudGovPlatform_Analytics.Constants.RampsWebServices.reqSource;																
	encodedCreds 				:= FraudgovPlatform_Analytics.Constants.RampsWebServices.DataBuildRampsCertCreds;		
	eclCompileStrategy	:= FraudGovPlatform_Analytics.Constants.RampsWebServices.EclCompileStrategy;											
	keepEcl 						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.KeepEcl;					
	forceRun						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.ForceRun;
	
	//Files used to create the dashboard
	inputLogicalOldPersonStatsFilename	:= STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.PersonStatsDeltaDashboard.Filenames(useProdData).InputLogicalOldPersonStatsFilename, '::', '%3A%3A');
	inputLogicalNewPersonStatsFilename := STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.PersonStatsDeltaDashboard.Filenames(useProdData).InputLogicalNewPersonStatsFilename, '::', '%3A%3A');
	
	fileNames	:= '&InputLogicalOldPersonStatsFilename='+inputLogicalOldPersonStatsFilename
		+'&InputLogicalNewPersonStatsFilename='+inputLogicalNewPersonStatsFilename;

	dRunComposition := RAMPS_WebServices.macRunComposition(cmpUuid, encodedCreds, 
		dspToUse, hpccConnection, reqSource,
		eclCompileStrategy, keepEcl, 
		vizVersion, filenames, forceRun);
	RETURN dRunComposition;
END;
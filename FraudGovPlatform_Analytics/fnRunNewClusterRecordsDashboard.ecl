EXPORT fnRunNewClusterRecordsDashboard() := FUNCTION
	IMPORT RAMPS_WebServices, STD, FraudGovPlatform_Analytics;
	
	//Constants - this is a dashboard currently ONLY used in CERT for QA purposes. This dashboard does NOT yet exists in PROD
	runProd 		:= FALSE;
	useProdData := TRUE;
	newVersion 	:= TRUE;
	dspToUse		:= FraudGovPlatform_Analytics.Constants.RampsWebServices.DspQa;
	
	//Input Parameters
	cmpUuid 						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.NewClusterRecordsDashboard.CompositionUuid;
	vizVersion 					:= FraudGovPlatform_Analytics.Constants.RampsWebServices.NewClusterRecordsDashboard.VizServiceVersion;
	reqSource 					:= FraudGovPlatform_Analytics.Constants.RampsWebServices.reqSource;																
	encodedCreds 				:= FraudGovPlatform_Analytics.Constants.RampsWebServices.EncodedCredentials;			
	hpccConnection 			:= FraudGovPlatform_Analytics.configFunctions.getHpccConnection(runProd, newVersion);
	eclCompileStrategy	:= FraudGovPlatform_Analytics.Constants.RampsWebServices.EclCompileStrategy;											
	keepEcl 						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.KeepEcl;					
	forceRun						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.ForceRun;
	
	//Files used to create the dashboard
	inputLogicalOldClusterDetailsFilename	:= STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.NewClusterRecordsDashboard.Filenames(useProdData).InputLogicalOldClusterDetailsFilename, '::', '%3A%3A');
	inputLogicalNewClusterDetailsFilename := STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.NewClusterRecordsDashboard.Filenames(useProdData).InputLogicalNewClusterDetailsFilename, '::', '%3A%3A');
	inputLogicalNewEntityStatsFilename 		:= STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.NewClusterRecordsDashboard.Filenames(useProdData).InputLogicalNewEntityStatsFilename, '::', '%3A%3A');
	
	fileNames	:= '&InputLogicalOldClusterDetailsFilename='+inputLogicalOldClusterDetailsFilename
		+'&InputLogicalNewClusterDetailsFilename='+inputLogicalNewClusterDetailsFilename
		+'&InputLogicalNewEntityStatsFilename='+inputLogicalNewEntityStatsFilename;

	dRunComposition := RAMPS_WebServices.macRunComposition(cmpUuid, encodedCreds, 
		dspToUse, hpccConnection, reqSource,
		eclCompileStrategy, keepEcl, 
		vizVersion, filenames, forceRun);
	RETURN dRunComposition;
END;
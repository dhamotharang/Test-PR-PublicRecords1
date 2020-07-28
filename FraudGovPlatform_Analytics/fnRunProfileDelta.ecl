EXPORT fnRunProfileDelta() := FUNCTION
	IMPORT RAMPS_WebServices, STD, FraudGovPlatform_Analytics;
	
	//Constants - this is a dashboard currently ONLY used in CERT for QA purposes. This dashboard does NOT yet exists in PROD
	runProd 		:= FALSE;
	useProdData := TRUE;
	newVersion 	:= TRUE;
	dspToUse		:= FraudGovPlatform_Analytics.Constants.RampsWebServices.DspQa;	
	hpccConnection  := FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionQa;

	//Input Parameters
	cmpUuid 						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.ProfileDeltaDashboard.CompositionUuid;
	vizVersion 					:= FraudGovPlatform_Analytics.Constants.RampsWebServices.ProfileDeltaDashboard.VizServiceVersion;
	reqSource 					:= FraudGovPlatform_Analytics.Constants.RampsWebServices.reqSource;																
	encodedCreds 				:= FraudgovPlatform_Analytics.Constants.RampsWebServices.DataBuildRampsCertCreds;		
	eclCompileStrategy	:= FraudGovPlatform_Analytics.Constants.RampsWebServices.EclCompileStrategy;											
	keepEcl 						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.KeepEcl;					
	forceRun						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.ForceRun;
  deleteOldIndexes    := FraudGovPlatform_Analytics.Constants.RampsWebServices.DeleteOldIndexes;
  useDspNext          := TRUE;
	
	//Files used to create the dashboard
	inputLogicalOldProfileFilename	:= STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.ProfileDeltaDashboard.Filenames(useProdData).InputLogicalOldProfileFilename, '::', '%3A%3A');
	inputLogicalNewProfileFilename := STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.ProfileDeltaDashboard.Filenames(useProdData).InputLogicalNewProfileFilename, '::', '%3A%3A');
	
	fileNames	:= '&InputLogicalFatherProfileFilename='+inputLogicalOldProfileFilename
		+'&InputLogicalBuiltProfileFilename='+inputLogicalNewProfileFilename;

	dRunComposition := RAMPS_WebServices.macRunComposition(cmpUuid, encodedCreds, 
		dspToUse, hpccConnection, reqSource,
		eclCompileStrategy, keepEcl, 
		vizVersion, filenames, forceRun, deleteOldIndexes, ,useDspNext);
	RETURN dRunComposition;
END;
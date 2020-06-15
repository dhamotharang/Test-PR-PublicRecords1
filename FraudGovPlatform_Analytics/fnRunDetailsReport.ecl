EXPORT fnRunDetailsReport(BOOLEAN runProd = FALSE,//set to TRUE it will run against DSP Prod on the RAMPS Prod cluster. Set to FALSE it will run against DSP QA on the RAMPS Cert cluster
	BOOLEAN useProdData = FALSE,										//set to TRUE it will use the files generated in Thor Prod, else it will use the files generated in Dataland
	BOOLEAN updateROSE = FALSE,											//set to TRUE it will run from the specified DSP on ramps dev cluster for ROSE environment
  STRING deltabaseDate = '20200512',              //Last date a record was added to deltabase
  STRING deltabaseTime = '235520',                 //Last time a record was added to deltabase
  BOOLEAN useDspQa = FALSE                        //option to use DSP QA instead of DSP Cert - temporary while we work on DSP Cert Next
	) := FUNCTION
	IMPORT RAMPS_WebServices, STD, Data_Services, FraudGovPlatform_Analytics;
	
	//Input Parameters
  newVersion          := FALSE;
	cmpUuid 						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.DetailsReport.CompositionUuid;
	vizVersion 					:= FraudGovPlatform_Analytics.Constants.RampsWebServices.DetailsReport.VizServiceVersion;
	reqSource 					:= FraudGovPlatform_Analytics.Constants.RampsWebServices.reqSource;																
	encodedCreds 				:= FraudGovPlatform_Analytics.configFunctions.getCredentials(runProd, updateROSE);			
	dspToUse						:= FraudGovPlatform_Analytics.configFunctions.getDspToUse(runProd, updateROSE, useDspQa);
	hpccConnection 			:= FraudGovPlatform_Analytics.configFunctions.getHpccConnection(runProd, newVersion, updateROSE);
	eclCompileStrategy	:= FraudGovPlatform_Analytics.Constants.RampsWebServices.EclCompileStrategy;											
	keepEcl 						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.KeepEcl;					
	forceRun						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.ForceRun;
  deleteOldIndexes    := FraudGovPlatform_Analytics.Constants.RampsWebServices.DeleteOldIndexes;
  useDspNext          := TRUE;
	
	//Files used to create the dashboard
	inputLogicalEventPivotFilename  := STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.DetailsReport.Filenames(useProdData).InputEventPivot, '::', '%3A%3A');
	inputLogicalEntityStatsFilename := STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.DetailsReport.Filenames(useProdData).InputLogicalEntityStats, '::', '%3A%3A');
	inputLogicalEntityRulesFilename := STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.DetailsReport.Filenames(useProdData).InputLogicalEntityRules, '::', '%3A%3A');
	
	fileNames	:= '&InputLogicalEventPivotFilename='+inputLogicalEventPivotFilename
		+'&InputLogicalEntityStatsFilename='+inputLogicalEntityStatsFilename
		+'&InputLogicalEntityRulesFilename='+inputLogicalEntityRulesFilename;
  
  globalVariables := '&BuildDate=' + deltabaseDate
    +'&BuildTime=' + deltabaseTime;

	dRunComposition := RAMPS_WebServices.macRunComposition(cmpUuid, encodedCreds, 
		dspToUse, hpccConnection, reqSource,
		eclCompileStrategy, keepEcl, 
		vizVersion, filenames, forceRun, deleteOldIndexes, globalVariables, useDspNext);
	RETURN dRunComposition;
END;
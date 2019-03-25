EXPORT fnRunCustomerDashboard(STRING serviceVersion,	//to version the dashboard services.
	BOOLEAN runProd = FALSE,														//set to TRUE it will run against DSP Prod on the RAMPS Prod cluster. Set to FALSE it will run against DSP QA on the RAMPS Cert cluster
	BOOLEAN useProdData = FALSE,												//set to TRUE it will use the files generated in Thor Prod, else it will use the files generated in Dataland
	BOOLEAN newVersion = FALSE													//set to FALSE it will create the new indexes but not automatically update the existing dashboard service to use them
	) := FUNCTION
	IMPORT RAMPS_WebServices, STD, Data_Services, FraudGovPlatform_Analytics;
	
	//Input Parameters
	cmpUuid 						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.CustomerDashboard.CompositionUuid;
	reqSource 					:= FraudGovPlatform_Analytics.Constants.RampsWebServices.reqSource;																
	encodedCreds 				:= FraudGovPlatform_Analytics.Constants.RampsWebServices.EncodedCredentials;			
	vizVersion 					:= serviceVersion;						
	dspToUse						:= FraudGovPlatform_Analytics.configFunctions.getDspToUse(runProd);
	hpccConnection 			:= FraudGovPlatform_Analytics.configFunctions.getHpccConnection(runProd, newVersion);
	eclCompileStrategy	:= FraudGovPlatform_Analytics.Constants.RampsWebServices.EclCompileStrategy;											
	keepEcl 						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.KeepEcl;					
	
	//Files used to create the dashboard
	inputLogicalGraphFilename 			:= STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.CustomerDashboard.Filenames(useProdData).InputLogicalGraph, '::', '%3A%3A');
	inputLogicalEntityStatsFilename := STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.CustomerDashboard.Filenames(useProdData).InputLogicalEntityStats, '::', '%3A%3A');
	
	fileNames	:= '&InputLogicalGraphFilename='+inputLogicalGraphFilename
		+'&InputLogicalEntityStatsFilename='+inputLogicalEntityStatsFilename;

	dRunComposition := RAMPS_WebServices.macRunComposition(cmpUuid, encodedCreds, 
		dspToUse, hpccConnection, reqSource,
		eclCompileStrategy, keepEcl, 
		vizVersion, filenames);
	RETURN dRunComposition;
END;
﻿EXPORT fnRunCustomerDashboard1_1(BOOLEAN runProd = FALSE,//set to TRUE it will run against DSP Prod on the RAMPS Prod cluster. Set to FALSE it will run against DSP QA on the RAMPS Cert cluster
	BOOLEAN useProdData = FALSE,												//set to TRUE it will use the files generated in Thor Prod, else it will use the files generated in Dataland
	BOOLEAN newVersion = FALSE,													//set to FALSE it will create the new indexes but not automatically update the existing dashboard service to use them
	BOOLEAN updateROSE = FALSE													//set to TRUE it will run from the specified DSP on ramps dev cluster for ROSE environment
	) := FUNCTION
	IMPORT RAMPS_WebServices, STD, Data_Services, FraudGovPlatform_Analytics;
	
	//Input Parameters
	cmpUuid							:= FraudGovPlatform_Analytics.Constants.RampsWebServices.CustomerDashboard1_1.CompositionUuid;
	vizVersion 					:= FraudGovPlatform_Analytics.Constants.RampsWebServices.CustomerDashboard1_1.VizServiceVersion;
	reqSource 					:= FraudGovPlatform_Analytics.Constants.RampsWebServices.reqSource;																
	encodedCreds 				:= FraudGovPlatform_Analytics.Constants.RampsWebServices.EncodedCredentials;			
	dspToUse						:= FraudGovPlatform_Analytics.configFunctions.getDspToUse(runProd);
	hpccConnection 			:= FraudGovPlatform_Analytics.configFunctions.getHpccConnection(runProd, newVersion, updateROSE);
	eclCompileStrategy	:= FraudGovPlatform_Analytics.Constants.RampsWebServices.EclCompileStrategy;											
	keepEcl 						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.KeepEcl;					
	forceRun						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.ForceRun;
	
	//Files used to create the dashboard
	inputLogicalClusterFilename 							:= STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.CustomerDashboard1_1.Filenames(useProdData).InputLogicalCluster, '::', '%3A%3A');
	inputLogicalIdentitiesAndElementsFilename	:= STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.CustomerDashboard1_1.Filenames(useProdData).InputLogicalIdentitiesAndElements, '::', '%3A%3A');
	inputLogicalEntityStatsFilename 					:= STD.Str.FindReplace(FraudGovPlatform_Analytics.Constants.RampsWebServices.CustomerDashboard1_1.Filenames(useProdData).InputLogicalEntityStats, '::', '%3A%3A');
		
	fileNames	:= '&InputLogicalClusterFilename='+inputLogicalClusterFilename
		+'&InputLogicalIdentitiesAndElementsFilename='+inputLogicalIdentitiesAndElementsFilename
		+'&InputLogicalEntityStatsFilename='+inputLogicalEntityStatsFilename;

	dRunComposition := RAMPS_WebServices.macRunComposition(cmpUuid, encodedCreds, 
		dspToUse, hpccConnection, reqSource,
		eclCompileStrategy, keepEcl, 
		vizVersion, fileNames, forceRun);
	RETURN dRunComposition;
END;
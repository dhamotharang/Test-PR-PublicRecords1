EXPORT fnRunCustomerDashboard(STRING serviceVersion,	//to version the dashboard services.
	BOOLEAN runProd = FALSE,														//set to TRUE it will run against DSP Prod on the RAMPS Prod cluster. Set to FALSE it will run against DSP QA on the RAMPS Cert cluster
	BOOLEAN useProdData = FALSE													//set to TRUE it will use the files generated in Thor Prod, else it will use the files generated in Dataland
	) := FUNCTION
	IMPORT RAMPS_WebServices, STD, Data_Services, FraudGovPlatform_Analytics;
	
	//Input Parameters
	cmpUuid 						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.CustomerDashboard.CompositionUuid;
	reqSource 					:= FraudGovPlatform_Analytics.Constants.RampsWebServices.reqSource;																
	encodedCreds 				:= FraudGovPlatform_Analytics.Constants.RampsWebServices.EncodedCredentials;			
	vizVersion 					:= serviceVersion;						
	dspToUse						:= IF(runProd, FraudGovPlatform_Analytics.Constants.RampsWebServices.DspProd, FraudGovPlatform_Analytics.Constants.RampsWebServices.DspQa);
	hpccConnection 			:= IF(runProd, FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionProd, FraudGovPlatform_Analytics.Constants.RampsWebServices.HpccConnectionQa);
	eclCompileStrategy	:= FraudGovPlatform_Analytics.Constants.RampsWebServices.EclCompileStrategy;											
	keepEcl 						:= FraudGovPlatform_Analytics.Constants.RampsWebServices.KeepEcl;							
	
	//Files used to create the dashboard
	fileLocation										:= IF(useProdData, Data_Services.foreign_prod, Data_Services.foreign_dataland);
	inputLogicalGraphFilename 			:= STD.Str.FindReplace(fileLocation + FraudGovPlatform_Analytics.Constants.RampsWebServices.CustomerDashboard.InputLogicalGraphFilename, '::', '%3A%3A');
	inputLogicalEntityStatsFilename := STD.Str.FindReplace(fileLocation + FraudGovPlatform_Analytics.Constants.RampsWebServices.CustomerDashboard.InputLogicalEntityStatsFilename, '::', '%3A%3A');
	
	fileNames	:= '&InputLogicalGraphFilename='+inputLogicalGraphFilename
		+'&InputLogicalEntityStatsFilename='+inputLogicalEntityStatsFilename;

	dRunComposition := RAMPS_WebServices.macRunComposition(cmpUuid, encodedCreds, 
		dspToUse, hpccConnection, reqSource,
		eclCompileStrategy, keepEcl, 
		vizVersion, filenames);
	RETURN dRunComposition;
END;

EXPORT GenerateDashboards(
	BOOLEAN runProd = FALSE,																	//set to TRUE it will run against DSP Prod on the RAMPS Prod cluster. Set to FALSE it will run against DSP QA on the RAMPS Cert cluster
	BOOLEAN useProdData = FALSE																//set to TRUE it will use the files generated in Thor Prod, else it will use the files generated in Dataland
	) := FUNCTION
	#OPTION('soapTraceLevel',10);

	IMPORT FraudGovPlatform_Analytics, STD;
	vizVersion 			:= '3';	
	fileName 				:= '~' + FraudGovPlatform_Analytics.Constants.RampsWebServices.fileScope + 'dashboardruns';
	custLogicalfilename := filename+'::customer::'+vizVersion+'::'+(STRING8)STD.Date.Today();
	clusterLogicalfilename := filename+'::clusterdetails::'+vizVersion+'::'+(STRING8)STD.Date.Today();

	//Currently we need to run this in thor in order to create the log file
	//In the future we will be wrapping the HTTPCALL in a NOTHOR action because we don't want to 
	//risk this running multiple times
	dRunCustDashboard					:= DATASET(FraudGovPlatform_Analytics.fnRunCustomerDashboard(vizVersion, runProd, useProdData));
	dRunClusDetailsDashboard	:= DATASET(FraudGovPlatform_Analytics.fnRunClusterDetailsDashboard(vizVersion, runProd, useProdData));
	RunCustDashboard 					:= OUTPUT(dRunCustDashboard,,custLogicalfilename, thor, overwrite);
	RunClusDetailsDashboard 	:= OUTPUT(dRunClusDetailsDashboard,,clusterLogicalfilename, thor, overwrite);

	CreateSuper := IF(~(STD.File.SuperFileExists(filename)), STD.File.CreateSuperFile(filename),output('Superfile already exists. Skipping creating superfile.'));
	AddFileToSuper := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.AddSuperFile(filename, custLogicalfilename),
		STD.File.AddSuperFile(filename, clusterLogicalfilename),
		STD.File.FinishSuperFileTransaction());
		
	//We want to run the Customer Dashboard first because it runs much faster than the Cluster dashboard	
	RETURN SEQUENTIAL(CreateSuper, RunCustDashboard, RunClusDetailsDashboard, AddFileToSuper);
END;

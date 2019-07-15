
EXPORT GenerateDashboards(
	BOOLEAN runProd = FALSE,			//set to TRUE it will run against DSP Prod on the RAMPS Prod cluster. Set to FALSE it will run against DSP QA on the RAMPS Cert cluster
	BOOLEAN useProdData = FALSE,	//set to TRUE it will use the files generated in Thor Prod, else it will use the files generated in Dataland
	BOOLEAN newVersion = FALSE		//set to FALSE it will create the new indexes but not automatically update the existing dashboard service to use them
	) := FUNCTION
	#OPTION('soapTraceLevel',10);

	IMPORT FraudGovPlatform_Analytics, STD;

/*
	//Currently we need to run this in thor in order to create the log file
	//In the future we will be wrapping the HTTPCALL in a NOTHOR action because we don't want to 
	//risk this running multiple times

	fileName 				:= '~' + FraudGovPlatform_Analytics.Constants.RampsWebServices.fileScope + 'dashboardruns';
	custLogicalfilename := filename+'::customer::'+vizVersion+'::'+(STRING8)STD.Date.Today();
	clusterLogicalfilename := filename+'::clusterdetails::'+vizVersion+'::'+(STRING8)STD.Date.Today();

	dRunCustDashboard					:= DATASET(FraudGovPlatform_Analytics.fnRunCustomerDashboard(runProd, useProdData, newVersion));
	dRunClusDetailsDashboard	:= DATASET(FraudGovPlatform_Analytics.fnRunClusterDetailsDashboard(runProd, useProdData, newVersion));
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
*/
	dRunCustDashboard					:= FraudGovPlatform_Analytics.fnRunCustomerDashboard(runProd, useProdData, newVersion);
	dRunClusDetailsDashboard	:= FraudGovPlatform_Analytics.fnRunClusterDetailsDashboard(runProd, useProdData, newVersion);
	RunCustDashboard 					:= OUTPUT(dRunCustDashboard);
	RunClusDetailsDashboard 	:= OUTPUT(dRunClusDetailsDashboard);
	
	//QA Dashboards - ONLY run when runProd is set to FALSE
	dRunPersonStatsDeltaDashboard		:= FraudGovPlatform_Analytics.fnRunPersonStatsDeltaDashboard();
	dRunNewClusterRecordsDashboard	:= FraudGovPlatform_Analytics.fnRunNewClusterRecordsDashboard();
	RunPersonStatsDeltaDashboard		:= OUTPUT(dRunPersonStatsDeltaDashboard);
	RunNewClusterRecordsDashboard 	:= OUTPUT(dRunNewClusterRecordsDashboard);
	RETURN PARALLEL(SEQUENTIAL(RunCustDashboard, RunClusDetailsDashboard), IF(~runProd, SEQUENTIAL(RunPersonStatsDeltaDashboard, RunNewClusterRecordsDashboard)));
END;

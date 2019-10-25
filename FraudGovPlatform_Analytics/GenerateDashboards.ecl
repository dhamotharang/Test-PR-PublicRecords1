﻿EXPORT GenerateDashboards(
	BOOLEAN runProd = FALSE,			//set to TRUE it will run against DSP Prod on the RAMPS Prod cluster. Set to FALSE it will run against DSP QA on the RAMPS Cert cluster
	BOOLEAN useProdData = FALSE,	//set to TRUE it will use the files generated in Thor Prod, else it will use the files generated in Dataland
	BOOLEAN newVersion = FALSE,		//set to FALSE it will create the new indexes but not automatically update the existing dashboard service to use them
	BOOLEAN updateROSE = FALSE		//set to TRUE it will run from the specified DSP  on ramps dev cluster for ROSE environment
	) := FUNCTION
	#OPTION('soapTraceLevel',10);
	
	IMPORT FraudGovPlatform_Analytics, STD,_control , FraudGovPlatform;
	
	ThorName:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor','Thor400_Dev',	'Thor400_44');

	//Currently we need to run this in thor in order to create the log file
	//In the future we will be wrapping the HTTPCALL in a NOTHOR action because we don't want to 
	//risk this running multiple times

	CustSuperFileName 				:= FraudGovPlatform.Filenames().CustomerDashboard;
	Cust1_1SuperFileName 			:= FraudGovPlatform.Filenames().CustomerDashboard1_1;
	ClusterSuperFileName			:= FraudGovPlatform.Filenames().ClusterDetails;
	custLogicalfilename				:= CustSuperFileName +'::'+(STRING8)STD.Date.Today();
	cust1_1Logicalfilename		:= Cust1_1SuperFileName +'::'+(STRING8)STD.Date.Today();
	clusterLogicalfilename		:= ClusterSuperFileName +'::'+(STRING8)STD.Date.Today();

	dRunCustDashboard							:= DATASET(FraudGovPlatform_Analytics.fnRunCustomerDashboard(runProd, useProdData, newVersion, updateROSE));
	dRunCustDashboard1_1					:= DATASET(FraudGovPlatform_Analytics.fnRunCustomerDashboard1_1(runProd, useProdData, newVersion, updateROSE));
	dRunClusDetailsDashboard			:= DATASET(FraudGovPlatform_Analytics.fnRunClusterDetailsDashboard(runProd, useProdData, newVersion, updateROSE));
	
	//Dashboards for Non Prod environment
	RunCustDashboard 					:= OUTPUT(dRunCustDashboard);
	RunCustDashboard1_1				:= OUTPUT(dRunCustDashboard1_1);
	RunClusDetailsDashboard 	:= OUTPUT(dRunClusDetailsDashboard);
	
	//PROD Dashboards Code Begin
	//Dashboards for Prod environment to create dashboard output files
	RunCustDashboard_Prod					:= OUTPUT(dRunCustDashboard,,custLogicalfilename,  cluster(ThorName),compressed,overwrite);
	RunCustDashboard1_1_Prod			:= OUTPUT(RunCustDashboard1_1,,cust1_1Logicalfilename,  cluster(ThorName),compressed,overwrite);
	RunClusDetailsDashboard_Prod	:= OUTPUT(dRunClusDetailsDashboard,,clusterLogicalfilename,cluster(ThorName),compressed, overwrite);

	CreateSuper := Sequential(IF(~(STD.File.SuperFileExists(CustSuperFileName)), STD.File.CreateSuperFile(CustSuperFileName),output('CustomerDash Superfile already exists. Skipping creating superfile.')),
															IF(~(STD.File.SuperFileExists(Cust1_1SuperFileName)), STD.File.CreateSuperFile(Cust1_1SuperFileName),output('CustomerDash 1_1 Superfile already exists. Skipping creating superfile.')),
															IF(~(STD.File.SuperFileExists(ClusterSuperFileName)), STD.File.CreateSuperFile(ClusterSuperFileName),output('ClusterDetails Superfile already exists. Skipping creating superfile.')),
															STD.File.StartSuperFileTransaction(),
															STD.File.ClearSuperfile(CustSuperFileName,true),
															STD.File.ClearSuperfile(Cust1_1SuperFileName,true),
															STD.File.ClearSuperfile(ClusterSuperFileName,true),
															STD.File.FinishSuperFileTransaction();
														);
														
	AddFileToSuper := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.AddSuperFile(CustSuperFileName, custLogicalfilename),
		STD.File.AddSuperFile(CustSuperFileName, cust1_1Logicalfilename),
		STD.File.AddSuperFile(ClusterSuperFileName, clusterLogicalfilename),
		STD.File.FinishSuperFileTransaction());
		
	//PROD Dashboards Code End
	
	//We want to run the Customer Dashboard first because it runs much faster than the Cluster dashboard	

	
	//QA Dashboards - ONLY run when runProd is set to FALSE
	dRunPersonStatsDeltaDashboard		:= FraudGovPlatform_Analytics.fnRunPersonStatsDeltaDashboard();
	dRunNewClusterRecordsDashboard	:= FraudGovPlatform_Analytics.fnRunNewClusterRecordsDashboard();
	RunPersonStatsDeltaDashboard		:= OUTPUT(dRunPersonStatsDeltaDashboard);
	RunNewClusterRecordsDashboard 	:= OUTPUT(dRunNewClusterRecordsDashboard);
	RETURN PARALLEL(If(runProd,
											SEQUENTIAL(CreateSuper,RunCustDashboard_Prod,RunCust1_1Dashboard_Prod,RunClusDetailsDashboard_Prod,AddFileToSuper),
											SEQUENTIAL(RunCustDashboard, RunCust1_1Dashboard, RunClusDetailsDashboard)
											)
								, IF(~runProd AND ~updateROSE, SEQUENTIAL(RunPersonStatsDeltaDashboard, RunNewClusterRecordsDashboard))
									);
END;

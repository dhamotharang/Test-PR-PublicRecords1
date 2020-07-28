EXPORT GenerateDashboards(
	BOOLEAN runProd = FALSE,			//set to TRUE it will run against DSP Prod on the RAMPS Prod cluster. Set to FALSE it will run against DSP QA on the RAMPS Cert cluster
	BOOLEAN useProdData = FALSE,	//set to TRUE it will use the files generated in Thor Prod, else it will use the files generated in Dataland
	BOOLEAN newVersion = FALSE,		//set to FALSE it will create the new indexes but not automatically update the existing dashboard service to use them
	BOOLEAN updateROSE = FALSE, 	//set to TRUE it will run from the specified DSP  on ramps dev cluster for ROSE environment
  BOOLEAN updateCustomerDash    = TRUE,
  BOOLEAN updateCustomerDash1_1 = TRUE,
  BOOLEAN updateHighRiskId      = TRUE,
  BOOLEAN updateClusterDetails  = TRUE
	) := FUNCTION
	#OPTION('soapTraceLevel',10);
	
	IMPORT FraudGovPlatform_Analytics, STD,_control , FraudGovPlatform;
	
	ThorName:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor','Thor400_Dev',	'Thor400_36');

	//Currently we need to run this in thor in order to create the log file
	//In the future we will be wrapping the HTTPCALL in a NOTHOR action because we don't want to 
	//risk this running multiple times

	CustSuperFileName 				:= FraudGovPlatform.Filenames().CustomerDashboard;
	Cust1_1SuperFileName 			:= FraudGovPlatform.Filenames().CustomerDashboard1_1;
	HighRiskIdSuperFileName 	:= FraudGovPlatform.Filenames().HighRiskIdentity;
	ClusterSuperFileName			:= FraudGovPlatform.Filenames().ClusterDetails;
	custLogicalfilename				:= CustSuperFileName +'::'+(STRING8)STD.Date.Today();
	cust1_1Logicalfilename		:= Cust1_1SuperFileName +'::'+(STRING8)STD.Date.Today();
	highriskidLogicalfilename	:= HighRiskIdSuperFileName +'::'+(STRING8)STD.Date.Today();
	clusterLogicalfilename		:= ClusterSuperFileName +'::'+(STRING8)STD.Date.Today();

	dRunCustDashboard							:= DATASET(FraudGovPlatform_Analytics.fnRunCustomerDashboard(runProd, useProdData, newVersion, updateROSE));
	dRunCustDashboard1_1					:= DATASET(FraudGovPlatform_Analytics.fnRunCustomerDashboard1_1(runProd, useProdData, newVersion, updateROSE));
	dRunHighRiskIdentity					:= DATASET(FraudGovPlatform_Analytics.fnRunHighRiskIdentity(runProd, useProdData, newVersion, updateROSE));
	dRunClusDetailsDashboard			:= DATASET(FraudGovPlatform_Analytics.fnRunClusterDetailsDashboard(runProd, useProdData, newVersion, updateROSE));
	
	//Dashboards for Non Prod environment
	RunCustDashboard 					:= OUTPUT(dRunCustDashboard);
	RunCustDashboard1_1				:= OUTPUT(dRunCustDashboard1_1);
	RunHighRiskIdentity				:= OUTPUT(dRunHighRiskIdentity);
	RunClusDetailsDashboard 	:= OUTPUT(dRunClusDetailsDashboard);
	
	//PROD Dashboards Code Begin
	//Dashboards for Prod environment to create dashboard output files
	RunCustDashboard_Prod					:= OUTPUT(dRunCustDashboard,,custLogicalfilename,  cluster(ThorName),compressed,overwrite);
	RunCustDashboard1_1_Prod			:= OUTPUT(dRunCustDashboard1_1,,cust1_1Logicalfilename,  cluster(ThorName),compressed,overwrite);
	RunClusDetailsDashboard_Prod	:= OUTPUT(dRunClusDetailsDashboard,,clusterLogicalfilename,cluster(ThorName),compressed, overwrite);
	RunHighRiskIdentity_Prod			:= OUTPUT(dRunHighRiskIdentity,,highriskidLogicalfilename,cluster(ThorName),compressed, overwrite);

	CreateSuper := Sequential(IF(~(STD.File.SuperFileExists(CustSuperFileName)), STD.File.CreateSuperFile(CustSuperFileName),output('CustomerDash Superfile already exists. Skipping creating superfile.')),
															IF(~(STD.File.SuperFileExists(Cust1_1SuperFileName)), STD.File.CreateSuperFile(Cust1_1SuperFileName),output('CustomerDash 1_1 Superfile already exists. Skipping creating superfile.')),
															IF(~(STD.File.SuperFileExists(ClusterSuperFileName)), STD.File.CreateSuperFile(ClusterSuperFileName),output('ClusterSuperFileName Superfile already exists. Skipping creating superfile.')),
															IF(~(STD.File.SuperFileExists(highriskidSuperFileName)), STD.File.CreateSuperFile(highriskidSuperFileName),output('highriskidentity Superfile already exists. Skipping creating superfile.')),															IF(~(STD.File.SuperFileExists(ClusterSuperFileName)), STD.File.CreateSuperFile(ClusterSuperFileName),output('ClusterDetails Superfile already exists. Skipping creating superfile.')),
															STD.File.StartSuperFileTransaction(),
															IF(updateCustomerDash, STD.File.ClearSuperfile(CustSuperFileName,true)),
															IF(updateCustomerDash1_1, STD.File.ClearSuperfile(Cust1_1SuperFileName,true)),
															IF(updateHighRiskId, STD.File.ClearSuperfile(HighRiskIdSuperFileName,true)),
															IF(updateClusterDetails, STD.File.ClearSuperfile(ClusterSuperFileName,true)),
															STD.File.FinishSuperFileTransaction();
														);
														
	AddFileToSuper := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		IF(updateCustomerDash, STD.File.AddSuperFile(CustSuperFileName, custLogicalfilename)),
		IF(updateCustomerDash1_1, STD.File.AddSuperFile(Cust1_1SuperFileName, cust1_1Logicalfilename)),
		IF(updateHighRiskId, STD.File.AddSuperFile(highriskidSuperFileName, highriskidLogicalfilename)),
		IF(updateClusterDetails, STD.File.AddSuperFile(ClusterSuperFileName, clusterLogicalfilename)),
		STD.File.FinishSuperFileTransaction());
		
	//PROD Dashboards Code End
	
	//We want to run the Customer Dashboard first because it runs much faster than the Cluster dashboard	

	RETURN PARALLEL(IF(runProd,
											SEQUENTIAL(CreateSuper,IF(updateCustomerDash, RunCustDashboard_Prod), IF(updateCustomerDash1_1, RunCustDashboard1_1_Prod), IF(updateHighRiskId, RunHighRiskIdentity_Prod), IF(updateClusterDetails, RunClusDetailsDashboard_Prod),AddFileToSuper),
											SEQUENTIAL(RunCustDashboard, RunCustDashboard1_1, RunHighRiskIdentity, RunClusDetailsDashboard)
											));
END;

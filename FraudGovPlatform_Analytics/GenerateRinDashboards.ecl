EXPORT GenerateRinDashboards(
	BOOLEAN runProd = FALSE,			//set to TRUE it will run against DSP Prod on the RAMPS Prod cluster. Set to FALSE it will run against DSP QA on the RAMPS Cert cluster
	BOOLEAN useProdData = FALSE,	//set to TRUE it will use the files generated in Thor Prod, else it will use the files generated in Dataland
	BOOLEAN updateROSE = FALSE,		//set to TRUE it will run from the specified DSP  on ramps dev cluster for ROSE environment
  BOOLEAN updateDashboard     = TRUE,
  BOOLEAN updateFindLeads     = TRUE,
  BOOLEAN updateDetailsReport = TRUE,
  BOOLEAN updateLinksChart    = TRUE
	) := FUNCTION
	#OPTION('soapTraceLevel',10);
	
	IMPORT FraudGovPlatform_Analytics, STD,_control , FraudGovPlatform;
	
	ThorName:=IF(_control.ThisEnvironment.Name <> 'Prod_Thor','Thor400_Dev',	'Thor400_36');

	//Currently we need to run this in thor in order to create the log file
	//In the future we will be wrapping the HTTPCALL in a NOTHOR action because we don't want to 
	//risk this running multiple times

	FindLeadsSuperFileName        := FraudGovPlatform.Filenames().FindLeads;
	DashboardSuperFileName 		    := FraudGovPlatform.Filenames().Dashboard;
	LinksChartSuperFileName 		  := FraudGovPlatform.Filenames().LinksChart;
	DetailsReportSuperFileName    := FraudGovPlatform.Filenames().DetailsReport;
	findLeadsLogicalfilename      := FindLeadsSuperFileName +'::'+(STRING8)STD.Date.Today();
	dashboardLogicalfilename	    := DashboardSuperFileName +'::'+(STRING8)STD.Date.Today();
	linksChartLogicalfilename	    := LinksChartSuperFileName +'::'+(STRING8)STD.Date.Today();
	detailsreportLogicalfilename	:= DetailsReportSuperFileName +'::'+(STRING8)STD.Date.Today();
  
  //Get latest Deltabase date
	base_in := Fraudgovplatform.files().base.agencyactivitydate.built;
  MaxDeltaBaseDate := base_in[1].reported_date;
  MaxDeltaBaseTime := base_in[1].reported_time;

	dRunFindLeads   							:= DATASET(FraudGovPlatform_Analytics.fnRunFindLeads(runProd, useProdData, updateROSE));
	dRunDashboard       					:= DATASET(FraudGovPlatform_Analytics.fnRunDashboard(runProd, useProdData, updateROSE));
	dRunLinksChart       					:= DATASET(FraudGovPlatform_Analytics.fnRunLinksChart(runProd, useProdData, updateROSE));
	dRunDetailsReport             := DATASET(FraudGovPlatform_Analytics.fnRunDetailsReport(runProd, useProdData, updateROSE, (STRING)MaxDeltaBaseDate, (STRING)MaxDeltaBaseTime));
	
	//Dashboards for Non Prod environment
	RunFindLeadsDashboard     := OUTPUT(dRunFindLeads);
	RunDashboard      				:= OUTPUT(dRunDashboard);
	RunLinksChart      				:= OUTPUT(dRunLinksChart);
	RunDetailsReport				  := OUTPUT(dRunDetailsReport);
	
	//PROD Dashboards Code Begin
	//Dashboards for Prod environment to create dashboard output files
	RunFindLeadsDashboard_Prod    := OUTPUT(dRunFindLeads,,findLeadsLogicalfilename,  cluster(ThorName),compressed,overwrite);
	RunDashboard_Prod		      	  := OUTPUT(dRunDashboard,,dashboardLogicalfilename,  cluster(ThorName),compressed,overwrite);
	RunLinksChart_Prod		      	:= OUTPUT(dRunLinksChart,,linksChartLogicalfilename,  cluster(ThorName),compressed,overwrite);
	RunDetailsReport_Prod	        := OUTPUT(dRunDetailsReport,,detailsreportLogicalfilename,cluster(ThorName),compressed, overwrite);

	CreateSuper := Sequential(IF(~(STD.File.SuperFileExists(FindLeadsSuperFileName)), STD.File.CreateSuperFile(FindLeadsSuperFileName),output('FindLeads Superfile already exists. Skipping creating superfile.')),
															IF(~(STD.File.SuperFileExists(DashboardSuperFileName)), STD.File.CreateSuperFile(DashboardSuperFileName),output('Dashboard Superfile already exists. Skipping creating superfile.')),
															IF(~(STD.File.SuperFileExists(LinksChartSuperFileName)), STD.File.CreateSuperFile(LinksChartSuperFileName),output('LinksChart Superfile already exists. Skipping creating superfile.')),
															IF(~(STD.File.SuperFileExists(DetailsReportSuperFileName)), STD.File.CreateSuperFile(DetailsReportSuperFileName),output('DetailsReport Superfile already exists. Skipping creating superfile.')),
															STD.File.StartSuperFileTransaction(),
															IF(updateFindLeads, STD.File.ClearSuperfile(FindLeadsSuperFileName,true)),
															IF(updateDashboard, STD.File.ClearSuperfile(DashboardSuperFileName,true)),
															IF(updateLinksChart, STD.File.ClearSuperfile(LinksChartSuperFileName,true)),
															IF(updateDetailsReport, STD.File.ClearSuperfile(DetailsReportSuperFileName,true)),
															STD.File.FinishSuperFileTransaction();
														);
														
	AddFileToSuper := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		IF(updateFindLeads, STD.File.AddSuperFile(FindLeadsSuperFileName, findLeadsLogicalfilename)),
		IF(updateDashboard, STD.File.AddSuperFile(DashboardSuperFileName, dashboardLogicalfilename)),
		IF(updateLinksChart, STD.File.AddSuperFile(LinksChartSuperFileName, linksChartLogicalfilename)),
		IF(updateDetailsReport, STD.File.AddSuperFile(DetailsReportSuperFileName, detailsreportLogicalfilename)),
		STD.File.FinishSuperFileTransaction());
		
	//PROD Dashboards Code End
	
  //QA Dashboards
	dRunProfileDeltaDashboard		:= FraudGovPlatform_Analytics.fnRunProfileDelta();
	RunProfileDeltaDashboard		:= OUTPUT(dRunProfileDeltaDashboard);

	RETURN PARALLEL(IF(runProd,
											SEQUENTIAL(CreateSuper,IF(updateDashboard, RunDashboard_Prod), IF(updateFindLeads, RunFindLeadsDashboard_Prod), IF(updateDetailsReport, RunDetailsReport_Prod), IF(updateLinksChart, RunLinksChart_Prod),AddFileToSuper),
											SEQUENTIAL(RunFindLeadsDashboard, RunDashboard, RunDetailsReport, RunLinksChart)
											)
								, IF(~runProd AND ~updateROSE, SEQUENTIAL(RunProfileDeltaDashboard))
									);
END;

EXPORT GenerateRinDashboards(
	BOOLEAN runProd = FALSE,			//set to TRUE it will run against DSP Prod on the RAMPS Prod cluster. Set to FALSE it will run against DSP QA on the RAMPS Cert cluster
	BOOLEAN useProdData = FALSE,	//set to TRUE it will use the files generated in Thor Prod, else it will use the files generated in Dataland
	BOOLEAN updateROSE = FALSE,		//set to TRUE it will run from the specified DSP  on ramps dev cluster for ROSE environment
  STRING  MaxDeltaBaseDate = '20200601', //Max Deltabase Date
  STRING  MaxDeltaBaseTime = '235520'    //Max Deltabase Time
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
  
  //Get latest Deltabase date from main fraudgov file
  DeltabaseSources        := [4,5,6,7];
  FileIn                  := 'fraudgov::base::built::Main';
  fraudgov_dataset_Input  := dataset(data_services.foreign_prod+FileIn, /*FraudShared.Layouts.Base.*/Main, thor); 
  dDeltabase              := fraudgov_dataset_Input(Rin_Source IN DeltabaseSources);
  STRING MaxDeltaBaseDate := (STRING)(MAX(dDeltabase,(integer)dDeltabase.reported_date));
  STRING MaxDeltaBaseTime := (STRING)(MAX(dDeltabase,(integer)dDeltabase.reported_time));

	dRunFindLeads   							:= DATASET(FraudGovPlatform_Analytics.fnRunFindLeads(runProd, useProdData, updateROSE));
	dRunDashboard       					:= DATASET(FraudGovPlatform_Analytics.fnRunDashboard(runProd, useProdData, updateROSE));
	dRunLinksChart       					:= DATASET(RinDev.FraudGovPlatform_Analytics.fnRunLinksChart(runProd, useProdData, updateROSE));
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
															STD.File.ClearSuperfile(FindLeadsSuperFileName,true),
															STD.File.ClearSuperfile(DashboardSuperFileName,true),
															STD.File.ClearSuperfile(LinksChartSuperFileName,true),
															STD.File.ClearSuperfile(DetailsReportSuperFileName,true),
															STD.File.FinishSuperFileTransaction();
														);
														
	AddFileToSuper := SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.AddSuperFile(FindLeadsSuperFileName, findLeadsLogicalfilename),
		STD.File.AddSuperFile(DashboardSuperFileName, dashboardLogicalfilename),
		STD.File.AddSuperFile(LinksChartSuperFileName, linksChartLogicalfilename),
		STD.File.AddSuperFile(DetailsReportSuperFileName, detailsreportLogicalfilename),
		STD.File.FinishSuperFileTransaction());
		
	//PROD Dashboards Code End
	
	RETURN PARALLEL(IF(runProd,
											SEQUENTIAL(CreateSuper,RunFindLeadsDashboard_Prod,RunDashboard_Prod,RunLinksChart_Prod,RunDetailsReport_Prod,AddFileToSuper),
											SEQUENTIAL(RunFindLeadsDashboard, RunDashboard, RunLinksChart, RunDetailsReport)
											));
END;

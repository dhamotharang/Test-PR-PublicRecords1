#workunit('name', 'AddressShell and BusinessShell Daily Data Collection');
#OPTION('AllowAutoSwitchQueue', true);
#option('allowedClusters', 'thor50_dev02,thor50_dev');

import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking, zz_bbraaten2;
import sghatti,Gateway, Scoring_Project_ISS;
import ut ;

//Here are the URLs to run data collections for testing non-FCRA OSS roxie
// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
// cert128 702 - roxiestaging.sc.seisint.com:9876

//******** Uncomment roxie to run ************
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 

// roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';  // OSS VIP

//**** RUNTIME SETTINGS ******
gateway_ip := '';
no_of_threads := 1;
Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 0;
//***** UNIQUE OUPUT FILE TAG *********
// filetag := 'TESTING';  // i.e. vehicles_cert_130

filetag := ut.GetDate  +'_1';  

message:=output('Daily_Data_Collection_Address_shell_jobs_failed');
message1:=output('Daily_Data_Collection_Business_shell_jobs_failed');


AddressShell_Attributes_V1_BATCH_Generic_infile :=   scoring_project_pip.Input_Sample_Names.AddressShell_Attributes_V1_BATCH_Generic_infile;
AddressShell_Attributes_V1_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.AddressShell_Attributes_V1_BATCH_Generic_outfile + filetag ;


BusinessShell_Attributes_V2_XML_Generic_infile :=   scoring_project_pip.Input_Sample_Names.BusinessShell_Attributes_V2_XML_Generic_infile;
BusinessShell_Attributes_V2_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.BusinessShell_Attributes_V2_XML_Generic_outfile + filetag ;

AddressShell:= Scoring_Project_ISS.AddressShell_Attributes_V1_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,AddressShell_Attributes_V1_BATCH_Generic_infile,AddressShell_Attributes_V1_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);

BusinessShell:= Scoring_Project_ISS.BusinessShell_Attributes_V2_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,BusinessShell_Attributes_V2_XML_Generic_infile,BusinessShell_Attributes_V2_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message1,10);

AddressShellReport := Scoring_Project_Macros.Address_Shell_Tracking_DailyReport;

BusinessShell_Tracking_Report := Scoring_Project_Macros.BusinessShell_Tracking_Report;
BusinessShell_NonSBFE_Report := Scoring_Project_Macros.BusinessShell_NonSBFE_Report;
BusinessShell_SBFE_Report := Scoring_Project_Macros.BusinessShell_SBFE_Report;

sequential(AddressShell,BusinessShell, AddressShellReport, BusinessShell_Tracking_Report, BusinessShell_NonSBFE_Report, BusinessShell_SBFE_Report);

 // :   WHEN(CRON('00 6 * * *')), 
// FAILURE(FileServices.SendEmail( Scoring_Project_DailyTracking.email_distribution.DDT_fail_list,'Daily Data Collection Addressshell & BusinessShell job failed','The failed workunit is:' + workunit + FailMessage));



EXPORT BusinessShell_AddressShell_Collections_Macro_Call := 'todo';
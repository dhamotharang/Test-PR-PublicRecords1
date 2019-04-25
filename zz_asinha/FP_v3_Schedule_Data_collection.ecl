import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking;
import sghatti,Gateway;
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
no_of_threads := 5;
Timeout := 120;
Retry_time := 3;
no_of_recs_to_run :=0;
//***** UNIQUE OUPUT FILE TAG *********
// filetag := 'TESTING';  // i.e. vehicles_cert_130

filetag := ut.GetDate  +'_1'; 

message:=output('Daily_Data_Collection_NONFCRA_Macro_3_jobs_failed');



FP_V3_Generic_FP31505_0_infile    := '~Scoring_Project::in::FraudPoint_XML_FP31505_0_20160404';

FP_V3_XML_Generic_FP31505_0_outfile := scoring_project_pip.Output_Sample_Names.FP_V3_XML_Generic_FP31505_0_outfile + filetag ;
FP_V3_BATCH_Generic_FP31505_0_outfile := scoring_project_pip.Output_Sample_Names.FP_V3_BATCH_Generic_FP31505_0_outfile + filetag ;


FP_v3 := zz_asinha.FP_v3_Scores_and_Attributes_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_V3_Generic_FP31505_0_infile,FP_V3_XML_Generic_FP31505_0_outfile,no_of_recs_to_run):RECOVERY(message,10);

FP_v3;
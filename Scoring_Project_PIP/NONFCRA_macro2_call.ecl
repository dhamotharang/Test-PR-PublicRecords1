#workunit('name', 'Daily Data Collection nonFCRA Macro 2');


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
no_of_threads := 2;
Timeout := 15;
Retry_time := 3;
no_of_recs_to_run := 0;
no_of_recs_to_run_paro := 1000;
//***** UNIQUE OUPUT FILE TAG *********
// filetag := 'TESTING';  // i.e. vehicles_cert_130

filetag := ut.GetDate  +'_1';  

message:=output('Daily_Data_Collection_NONFCRA_Macro_2_jobs_failed');

// LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile := scoring_project_pip.Output_Sample_Names.LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile + filetag ;
// LI_v4_attributes_batch_test := scoring_project_pip.Test_LI_Attributes_V4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,LI_Generic_msn1210_1_infile,LI_Attributes_V4_BATCH_Generic_msn1106_0_historydate_201207_outfile,no_of_recs_to_run):RECOVERY(message,10);


IT61_Scores_Paro_msn605_infile   												:= scoring_project_pip.Input_Sample_Names.IT61_Scores_BATCH_Paro_msn605_rsn804_infile;  
PRIO_Scores_Chase_PIO2_infile 													:= scoring_project_pip.Input_Sample_Names.PRIO_Scores_Chase_PIO2_infile;
BC10_Scores_Chase_BNK4_infile 													:=  scoring_project_pip.Input_Sample_Names.BC10_Scores_Chase_BNK4_infile;
CBBL_Scores_XML_Chase_infile														:=  scoring_project_pip.Input_Sample_Names.CBBL_Scores_XML_Chase_infile;

IT61_Scores_Paro_msn605_outfile_cert 										:= scoring_project_pip.Output_Sample_Names.IT61_Scores_BATCH_Paro_msn605_rsn804_outfile + filetag  ;  
PRIO_Scores_XML_Chase_PIO2_outfile 											:= scoring_project_pip.Output_Sample_Names.PRIO_Scores_XML_Chase_PIO2_outfile + filetag ;
PRIO_Scores_BATCH_Chase_PIO2_outfile 										:= scoring_project_pip.Output_Sample_Names.PRIO_Scores_BATCH_Chase_PIO2_outfile + filetag ;
BC10_Scores_XML_Chase_BNK4_outfile 											:= scoring_project_pip.Output_Sample_Names.BC10_Scores_XML_Chase_BNK4_outfile + filetag ;
BC10_Scores_BATCH_Chase_BNK4_outfile 										:= scoring_project_pip.Output_Sample_Names.BC10_Scores_BATCH_Chase_BNK4_outfile + filetag ;
CBBL_Scores_XML_Chase_outfile 													:= scoring_project_pip.Output_Sample_Names.CBBL_Scores_XML_Chase_outfile + filetag ;

IT61_Scores_Paro_msn605																	:= Scoring_Project_PIP.Paro_IT60_Batch_Cert_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,IT61_Scores_Paro_msn605_infile,IT61_Scores_Paro_msn605_outfile_cert,no_of_recs_to_run_paro):RECOVERY(message,10);
Chase_PIO2_XML 																					:= scoring_project_pip.Chase_PIO2_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,PRIO_Scores_Chase_PIO2_infile,PRIO_Scores_XML_Chase_PIO2_outfile,no_of_recs_to_run):RECOVERY(message,10);
Chase_PIO2_batch 																				:= scoring_project_pip.Chase_PIO2_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,PRIO_Scores_Chase_PIO2_infile,PRIO_Scores_BATCH_Chase_PIO2_outfile,no_of_recs_to_run):RECOVERY(message,10);
Chase_BNK4_xml 																					:= scoring_project_pip.Chase_BNK4_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,BC10_Scores_Chase_BNK4_infile,BC10_Scores_XML_Chase_BNK4_outfile,no_of_recs_to_run):RECOVERY(message,10);
Chase_BNK4_batch 																				:= scoring_project_pip.Chase_BNK4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,BC10_Scores_Chase_BNK4_infile,BC10_Scores_BATCH_Chase_BNK4_outfile,no_of_recs_to_run):RECOVERY(message,10);
Chase_CBBL 																							:= scoring_project_pip.Chase_CBBL_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,CBBL_Scores_XML_Chase_infile,CBBL_Scores_XML_Chase_outfile,no_of_recs_to_run):RECOVERY(message,10);





sequential(
						IT61_Scores_Paro_msn605,
						Chase_PIO2_XML,
            Chase_PIO2_batch,
						Chase_BNK4_xml,
						Chase_BNK4_batch,
						Chase_CBBL
						
              );

EXPORT NONFCRA_macro2_call := 'todo';
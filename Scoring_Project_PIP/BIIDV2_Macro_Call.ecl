#workunit('name', 'nonFCRA BIID20 Macro');

import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking;
import sghatti,Gateway;
import ut ;

roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; 

//**** RUNTIME SETTINGS ******
gateway_ip := '';
no_of_threads := 2;
Timeout := 15;
Retry_time := 3;
no_of_recs_to_run := 0;
//***** UNIQUE OUPUT FILE TAG *********

filetag := ut.GetDate + '_1'; 

message:=output('Daily_Data_Collection_NONFCRA_BIID20_Macro_jobs_failed');

// BIID_Scores_XML_Generic_infile 													:= scoring_project_pip.Input_Sample_Names.BIID_Scores_XML_Generic_infile;
// BIID_Scores_BATCH_Generic_infile 												:= scoring_project_pip.Input_Sample_Names.BIID_Scores_XML_Generic_infile;
BIIDv2_Scores_XML_Generic_infile 												:= scoring_project_pip.Input_Sample_Names.BIIDv2_Scores_XML_Generic_infile;

// BIID_Scores_XML_Generic_outfile 												:= scoring_project_pip.Output_Sample_Names.BIID_Scores_XML_Generic_outfile + filetag ;
// BIID_Scores_BATCH_Generic_outfile 											:= scoring_project_pip.Output_Sample_Names.BIID_Scores_BATCH_Generic_outfile + filetag ;
BIIDv2_Scores_XML_Generic_outfile 												:= scoring_project_pip.Output_Sample_Names.BIIDv2_Scores_xml_Generic_outfile + filetag ;


// chase_BIID_batch 																				:= scoring_project_pip.Chase_BIID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,BIID_Scores_Batch_Chase_infile,BIID_Scores_Batch_Chase_outfile,no_of_recs_to_run):RECOVERY(message,10);
// BIID_XML 																								:= scoring_project_pip.Business_Instant_Id_XML_Mcro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,BIID_Scores_XML_Generic_infile,BIID_Scores_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
// BIID_batch 																							:= scoring_project_pip.Business_Instant_Id_Batch_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,BIID_Scores_BATCH_Generic_infile,BIID_Scores_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
BIIDv2_XML																							:= scoring_project_pip.Business_Instant_Id_v2_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,BIIDv2_Scores_XML_Generic_infile,BIIDv2_Scores_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
// BIIDv2_XML																							:= scoring_project_pip.biid_test_macro;

// sequential(
						// chase_BIID_batch,
						// BIID_XML,
						// BIID_batch,
						BIIDv2_XML;
						// );

// EXPORT BIIDV2_Macro_Call := 'todo';
#workunit('name', 'Daily Data Collection nonFCRA Macro 3');



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
no_of_recs_to_run :=0;
//***** UNIQUE OUPUT FILE TAG *********
// filetag := 'TESTING';  // i.e. vehicles_cert_130

filetag := ut.GetDate  +'_1'; 

message:=output('Daily_Data_Collection_NONFCRA_Macro_3_jobs_failed');

// FP_V2_Generic_FP1109_0_infile    := scoring_project_pip.Input_Sample_Names.FP_V2_Generic_FP1109_0_infile;
// FP_V2_XML_Generic_FP1109_0_outfile := scoring_project_pip.Output_Sample_Names.FP_V2_XML_Generic_FP1109_0_outfile + filetag ;
// FP_V2_BATCH_Generic_FP1109_0_outfile := scoring_project_pip.Output_Sample_Names.FP_V2_BATCH_Generic_FP1109_0_outfile + filetag ;
// FP_ScoresAttributes_XML := scoring_project_pip.FP_Scores_and_Attributes_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_V2_Generic_FP1109_0_infile,FP_V2_XML_Generic_FP1109_0_outfile,no_of_recs_to_run):RECOVERY(message,10);
// FP_ScoresAttributes_BATCH := scoring_project_pip.FP_Scores_and_Attributes_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_V2_Generic_FP1109_0_infile,FP_V2_BATCH_Generic_FP1109_0_outfile,no_of_recs_to_run):RECOVERY(message,10);



IID_Scores_V0_XML_Generic_infile 												:= scoring_project_pip.Input_Sample_Names.IID_Scores_V0_XML_Generic_infile;
IID_Scores_V0_BATCH_Generic_infile 											:= scoring_project_pip.Input_Sample_Names.IID_Scores_V0_BATCH_Generic_infile;
BIID_Scores_Batch_Chase_infile 													:= scoring_project_pip.Input_Sample_Names.BIID_Scores_Batch_Chase_infile;
BIID_Scores_XML_Generic_infile 													:= scoring_project_pip.Input_Sample_Names.BIID_Scores_XML_Generic_infile;
BIID_Scores_BATCH_Generic_infile 												:= scoring_project_pip.Input_Sample_Names.BIID_Scores_XML_Generic_infile;
Profile_Booster_Capone_infile 													:= scoring_project_pip.Input_Sample_Names.Profile_booster_Capone_infile;



IID_Scores_V0_XML_Generic_outfile 											:= scoring_project_pip.Output_Sample_Names.IID_Scores_V0_XML_Generic_outfile + filetag ;
IID_Scores_V0_BATCH_Generic_outfile 										:= scoring_project_pip.Output_Sample_Names.IID_Scores_V0_BATCH_Generic_outfile + filetag ;
BIID_Scores_Batch_Chase_outfile 												:= scoring_project_pip.Output_Sample_Names.BIID_Scores_Batch_Chase_outfile + filetag ;
BIID_Scores_XML_Generic_outfile 												:= scoring_project_pip.Output_Sample_Names.BIID_Scores_XML_Generic_outfile + filetag ;
BIID_Scores_BATCH_Generic_outfile 											:= scoring_project_pip.Output_Sample_Names.BIID_Scores_BATCH_Generic_outfile + filetag ;
Profile_Booster_Capone_outfile 													:= scoring_project_pip.Output_Sample_Names.Profile_Booster_Capone_outfile + filetag ;



instant_id_xml 																					:= scoring_project_pip.Instant_ID_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,IID_Scores_V0_XML_Generic_infile,IID_Scores_V0_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
instant_id_batch 																				:= scoring_project_pip.Instant_ID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,IID_Scores_V0_BATCH_Generic_infile,IID_Scores_V0_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
chase_BIID_batch 																				:= scoring_project_pip.Chase_BIID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,BIID_Scores_Batch_Chase_infile,BIID_Scores_Batch_Chase_outfile,no_of_recs_to_run):RECOVERY(message,10);
BIID_XML 																								:= scoring_project_pip.Business_Instant_Id_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,BIID_Scores_XML_Generic_infile,BIID_Scores_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
BIID_batch 																							:= scoring_project_pip.Business_Instant_Id_Batch_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,BIID_Scores_BATCH_Generic_infile,BIID_Scores_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
PB_capone 																							:= scoring_project_pip.CapitalOne_Profile_Booster_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Profile_booster_Capone_infile,Profile_Booster_Capone_outfile,no_of_recs_to_run):RECOVERY(message,10);


sequential(
						instant_id_xml,
						instant_id_batch,
            chase_BIID_batch,
						BIID_XML,
						BIID_batch,
						PB_capone
						);

EXPORT NONFCRA_macro3_call := 'todo';
 
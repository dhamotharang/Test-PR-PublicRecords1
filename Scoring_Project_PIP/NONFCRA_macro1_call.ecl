#workunit('name', 'Daily Data Collection nonFCRA Macro 1');

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
//***** UNIQUE OUPUT FILE TAG *********
// filetag := '_1';  // i.e. vehicles_cert_130

filetag := ut.GetDate  +'_1'; 

message:=output('Daily_Data_Collection_NONFCRA_Macro_1_jobs_failed');


// no longer monitoring 7/12 oked by product
// bestbuy := scoring_project_pip.BestBuy_CDS_CDN1109_1_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile,ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_outfile,no_of_recs_to_run):RECOVERY(message,10);
// ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile :=   scoring_project_pip.Input_Sample_Names.ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile;
// ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_outfile := scoring_project_pip.Output_Sample_Names.ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_outfile + filetag ;


ITA_Attributes_V3_BATCH_CapOne_infile 									:= scoring_project_pip.Input_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_infile;
LI_Generic_msn1210_1_infile  														:= scoring_project_pip.Input_Sample_Names.LI_Generic_msn1210_1_infile;
FP_V2_American_Express_FP1109_0_infile   								:= scoring_project_pip.Input_Sample_Names.FP_V2_American_Express_FP1109_0_infile;  //added 8/2 FP v201 american express smaple


ITA_Attributes_V3_BATCH_CapOne_outfile 									:= scoring_project_pip.Output_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_outfile + filetag ;
LI_Scores_V4_XML_Generic_msn1106_0_outfile 							:= scoring_project_pip.Output_Sample_Names.LI_Scores_V4_XML_Generic_msn1106_0_outfile + filetag ;
LI_Attributes_V4_XML_Generic_msn1106_0_outfile 					:= scoring_project_pip.Output_Sample_Names.LI_Attributes_V4_XML_Generic_msn1106_0_outfile + filetag ;
LI_Scores_V4_BATCH_Generic_msn1106_0_outfile 						:= scoring_project_pip.Output_Sample_Names.LI_Scores_V4_BATCH_Generic_msn1106_0_outfile + filetag ;
LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile 				:= scoring_project_pip.Output_Sample_Names.LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile + filetag ;
FP_V2_XML_American_Express_FP1109_0_outfile 						:= scoring_project_pip.Output_Sample_Names.FP_V2_XML_American_Express_FP1109_0_outfile + filetag ;

//replaced with new macro 1 soapcall 2 files

// LI_v4_scores_xml 																				:= scoring_project_pip.LI_Scores_V4_XML(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,LI_Generic_msn1210_1_infile,LI_Scores_V4_XML_Generic_msn1106_0_outfile,no_of_recs_to_run):RECOVERY(message,10);
// LI_v4_attributes_xml 																		:= scoring_project_pip.LI_Attributes_V4_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,LI_Generic_msn1210_1_infile,LI_Attributes_V4_XML_Generic_msn1106_0_outfile,no_of_recs_to_run):RECOVERY(message,10);
// LI_v4_scores_batch 																			:= scoring_project_pip.LI_Scores_V4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,LI_Generic_msn1210_1_infile,LI_Scores_V4_BATCH_Generic_msn1106_0_outfile,no_of_recs_to_run):RECOVERY(message,10);
// LI_v4_attributes_batch 																	:= scoring_project_pip.LI_Attributes_V4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,LI_Generic_msn1210_1_infile,LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile,no_of_recs_to_run):RECOVERY(message,10);

CapitalOne_batch_ITA_new																:= scoring_project_pip.CapitalOne_ITA_V3_BATCH_Macro_new(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,ITA_Attributes_V3_BATCH_CapOne_infile,ITA_Attributes_V3_BATCH_CapOne_outfile,no_of_recs_to_run):RECOVERY(message,10);
LI_v4_scores_attr_xml  																  := Scoring_Project_PIP.LI_Score_Attributes_V4_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,LI_Generic_msn1210_1_infile,LI_Scores_V4_XML_Generic_msn1106_0_outfile,LI_Attributes_V4_XML_Generic_msn1106_0_outfile,no_of_recs_to_run):RECOVERY(message,10);
LI_v4_scores_attr_batch   															:= Scoring_Project_PIP.LI_Score_Attributes_V4_Batch_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,LI_Generic_msn1210_1_infile,LI_Scores_V4_BATCH_Generic_msn1106_0_outfile,LI_Attributes_V4_BATCH_Generic_msn1106_0_outfile,no_of_recs_to_run):RECOVERY(message,10);
FP_AmericanExpress_XML 																	:= scoring_project_pip.FPv201_American_Express_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_V2_American_Express_FP1109_0_infile,FP_V2_XML_American_Express_FP1109_0_outfile,no_of_recs_to_run):RECOVERY(message,10);



sequential(
						CapitalOne_batch_ITA_new,
						LI_v4_scores_attr_xml,
						LI_v4_scores_attr_batch,
						FP_AmericanExpress_XML
                );

EXPORT NONFCRA_macro1_call := 'todo';
 
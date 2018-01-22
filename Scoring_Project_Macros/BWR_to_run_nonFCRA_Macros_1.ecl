EXPORT BWR_to_run_nonFCRA_Macros_1 := 'todo';

import sghatti ;

//Here are the URLs to run data collections for testing non-FCRA OSS roxie
// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
// cert128 702 - roxiestaging.sc.seisint.com:9876

//******** Uncomment roxie to run ************
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 
// roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';  // OSS VIP
roxieIP := RiskWise.shortcuts.Dev196 ;//dev196
neutralroxieIP := RiskWise.shortcuts.Dev196 ;//dev196
//**** RUNTIME SETTINGS ******
gateway_ip := '';
no_of_threads := 15;
Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 10;

//Version parameter to run bocashell macro
bs_version := 50;

//***** UNIQUE OUPUT FILE TAG *********
filetag := 'Address_Cleaner_401';  // i.e. vehicles_cert_130

// Input / Output file names


bocashell_50_cert_nonfcra_infile_name := MAP(bs_version = 50 => '~bweiner::in::aetna_4630_50k_sample_in', 
																					   bs_version = 41 => '~nmontpetit::in::ge_cap_100302_pii', '');
bocashell_50_cert_nonfcra_outfile_name := MAP(bs_version = 50 =>'~scoringqa::out::tracking::bocashell50::cert_bs_50_nonFCRA_NO_EDINA_' + filetag + '_'  + ut.GetDate ,
																						bs_version = 41 => '~nmontpetit::out::bs_41_tracking_edina_nonfcra_NO_EDINA_' + filetag + '_'  + ut.GetDate, '');
			



chase_BIID_batch_infile_name := '~scoring_project::in::biid_batch_chase_generic_20140701';
chase_BIID_batch_outfile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_Chase'  + '_'  + ut.GetDate + filetag;

iid_xml_infile_name_25000 := '~Scoring_Project::in::InstantID_XML_Generic_Version0_20140408';
iid_xml_outfile_name := '~ScoringQA::out::NONFCRA::instantid_xml_generic'  + '_' + ut.GetDate + filetag;

iid_batch_infile_name_25000 := '~Scoring_Project::in::InstantID_XML_Generic_Version0_20140408';
iid_batch_outfile_name := '~ScoringQA::out::NONFCRA::instantid_batch_generic'  + '_' + ut.GetDate + filetag;



biid_xml_inFile_name := '~scoring_project::in::biid_batch_general_generic_20140722';
biid_xml_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_xml_generic'  + '_' + ut.GetDate + filetag;


biid_batch_inFile_name := '~scoring_project::in::biid_batch_general_generic_20140722';
biid_batch_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_generic'  + '_' + ut.GetDate + filetag;
 
 FP_XML_infile_name    := '~Scoring_Project::in::FraudPoint_XML_Generic_FP1109_0_20140408'; 
FP_XML_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_xml_generic_fp1109_0_v2'+ '_'  + ut.GetDate  + filetag;

FP_BATCH_infile_name := '~Scoring_Project::in::FraudPoint_XML_Generic_FP1109_0_20140408'; 
FP_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_batch_generic_fp1109_0_v2'+ '_' + ut.GetDate + filetag;



li_v3_attributes_xml_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v3_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v3'+ '_'  + ut.GetDate  + filetag ;

li_v3_attributes_batch_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v3_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v3'+ '_'  + ut.GetDate  + filetag ;

li_v4_scores_xml_infile_name    := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_scores_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_msn1106_0_v4'+ '_' + ut.GetDate  + filetag;


li_v4_attributes_xml_infile_name    := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v4'+ '_'  + ut.GetDate  + filetag ;



Chase_BNK4_xml_inFile_name := '~Scoring_Project::in::BC1O_XML_Chase_bnk4_20140416';
Chase_BNK4_xml_outfile_name := '~ScoringQA::out::NONFCRA::BNK4_xml_chase_BD3605_0'  + '_' + ut.GetDate  + filetag;

Chase_BNK4_batch_inFile_name := '~Scoring_Project::in::BC1O_XML_Chase_bnk4_20140416';
Chase_BNK4_batch_outFile_name := '~ScoringQA::out::NONFCRA::BNK4_batch_chase_BD3605_0'  + '_' + ut.GetDate  + filetag;


Chase_PIO2_xml_inFile_name := '~Scoring_Project::in::PRIO_XML_Chase_pi02_20140415';
Chase_PIO2_xml_outFile_name := '~ScoringQA::out::NONFCRA::PI02_xml_chase_FP3710_0'  + '_' + ut.GetDate  + filetag;

Chase_PIO2_batch_inFile_name := '~Scoring_Project::in::PRIO_XML_Chase_pi02_20140415';
Chase_PIO2_batch_outFile_name := '~ScoringQA::out::NONFCRA::PI02_batch_chase_FP3710_0'  + '_' + ut.GetDate  + filetag;

Chase_CBBL_inFile_name:='~Scoring_Project::in::cbbl_xml_chase_20140827';
Chase_CBBL_outfile_name := '~ScoringQA::out::NONFCRA::cbbl_xml_chase'  + '_' + ut.GetDate  + filetag;


Paro_it60_XML_infile_name:='~Scoring_Project::in::IT60_Batch_Paro_Msn605_20140701';
Paro_it60_outfile_name := '~ScoringQA::out::NONFCRA::IT60_xml_paro_Msn605'  + '_' + ut.GetDate  + filetag;

Paro_it60_BATCH_infile_name := '~Scoring_Project::in::IT60_Batch_Paro_Msn605_20140701';
Paro_it60_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::IT60_batch_paro_Msn605'  + '_' + ut.GetDate  + filetag;

Paro_it61_XML_infile_name:='~scoring_project::in::it61_xml_paro_msn605_rsn804_20140730';
Paro_it61_outfile_name := '~ScoringQA::out::NONFCRA::IT61_xml_paro_MSN605_RSN804'  + '_' + ut.GetDate  + filetag;


Paro_it61_BATCH_infile_name := '~Scoring_Project::in::IT61_Batch_Paro_MSN605_RSN804_20140701';
Paro_it61_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::IT61_batch_paro_MSN605_RSN804'  + '_' + ut.GetDate  + filetag;


//added
CapitalOne_batch_infile_name :=  '~Scoring_Project::in::ITA_v3_Batch_CapitalOne_Attributes_20140625';
CapitalOne_batch_outfile_name := '~ScoringQA::out::NONFCRA::ITA_batch_CapitalOne_attributes_v3'+ '_'  + ut.GetDate  + filetag ;


bbuy_infile_name := '~scoring_project::in::chargebackdefender_xml_bestbuy_cdn1109_1_20140319';
bbuy_outFile_Name := '~ScoringQA::out::NONFCRA::ChargebackDefender_xml_BestBuy_CDN1109_1'  + '_' + ut.GetDate  + filetag ;

li_v4_scores_batch_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_scores_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_msn1106_0_v4'+ '_'  + ut.GetDate  + filetag ;

 li_v4_attributes_batch_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v4'+ '_'  + ut.GetDate  + filetag ;


//testing data with hitory date 201207 as per nathan request 07/17/2014
li_v4_attributes_batch_outFile_name_test := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v4'+  '_historydate_201207' +'_' + ut.GetDate + filetag   ;
LI_v4_attributes_batch_test := Scoring_Project_Macros.Test_LI_Attributes_V4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_attributes_batch_infile_name,li_v4_attributes_batch_outFile_name_test,no_of_recs_to_run);



//*********************************************************************************************
//  Commands to call the Macro.  Should not need modification
// (ROXIE_IP,Gateway, Threads, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun)
//*********************************************************************************************

/*************************************************NEW ADDITIONS*****************************************************************************/

chase_BIID_batch := Scoring_Project_Macros.Chase_BIID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,chase_BIID_batch_infile_name,chase_BIID_batch_outfile_name,no_of_recs_to_run);
// chase_BIID_batch;

bocashell_cert_nonfcra := Scoring_Project_Macros.BocaShell_50_nonFCRA_cert_MACRO( bs_version, roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_50_cert_nonfcra_infile_name,bocashell_50_cert_nonfcra_outfile_name,no_of_recs_to_run);
// bocashell_cert_nonfcra;

/*************************************************************************************************************************************************************/

// FP_Scores_XML := Scoring_Project_Macros.FP_Scores_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_Scores_XML_infile_name,FP_Scores_XML_outfile_name,no_of_recs_to_run);




Chase_BNK4_xml := Scoring_Project_Macros.Chase_BNK4_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_xml_inFile_name,Chase_BNK4_xml_outfile_name,no_of_recs_to_run);
// Chase_BNK4_xml;

Chase_BNK4_batch := Scoring_Project_Macros.Chase_BNK4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_batch_inFile_name,Chase_BNK4_batch_outFile_name,no_of_recs_to_run);
// Chase_BNK4_batch;

Chase_PIO2_XML := Scoring_Project_Macros.Chase_PIO2_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_xml_inFile_name,Chase_PIO2_xml_outfile_name,no_of_recs_to_run);
// Chase_PIO2_XML;

Chase_PIO2_batch := Scoring_Project_Macros.Chase_PIO2_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_batch_inFile_name,Chase_PIO2_batch_outfile_name,no_of_recs_to_run);
// Chase_PIO2_batch;

Chase_CBBL := Scoring_Project_Macros.Chase_CBBL_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_CBBL_inFile_name,Chase_CBBL_outfile_name,no_of_recs_to_run);
// Chase_CBBL;

FP_ScoresAttributes_XML := Scoring_Project_Macros.FP_Scores_and_Attributes_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_XML_infile_name,FP_XML_outfile_name,no_of_recs_to_run);
// FP_ScoresAttributes_XML;

FP_ScoresAttributes_BATCH := Scoring_Project_Macros.FP_Scores_and_Attributes_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_BATCH_infile_name,FP_BATCH_outfile_name,no_of_recs_to_run);
// FP_ScoresAttributes_BATCH;

Paro_IT60_XML := Scoring_Project_Macros.Paro_IT60_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it60_XML_infile_name,Paro_it60_outfile_name,no_of_recs_to_run);
// Paro_IT60_XML;

Paro_IT60_BATCH := Scoring_Project_Macros.Paro_IT60_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it60_BATCH_infile_name,Paro_it60_BATCH_outfile_name,no_of_recs_to_run);
// Paro_IT60_BATCH;

Paro_IT61_XML := Scoring_Project_Macros.Paro_IT61_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it61_XML_infile_name,Paro_it61_outfile_name,no_of_recs_to_run);
// Paro_IT61_XML;

Paro_IT61_BATCH := Scoring_Project_Macros.Paro_IT61_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it61_BATCH_infile_name,Paro_it61_BATCH_outfile_name,no_of_recs_to_run);
// Paro_IT61_BATCH;


Sequential(chase_BIID_batch, Paro_IT61_BATCH,  Paro_IT61_XML, Paro_IT60_BATCH, Paro_IT60_XML, FP_ScoresAttributes_BATCH,  
 FP_ScoresAttributes_XML, Chase_CBBL, Chase_PIO2_batch, Chase_PIO2_XML, Chase_BNK4_batch, Chase_BNK4_xml);

// Sequential(Paro_IT61_BATCH,  Paro_IT61_XML, Paro_IT60_BATCH, Paro_IT60_XML, FP_ScoresAttributes_BATCH, FP_Scores_XML, 
 // FP_ScoresAttributes_XML, Chase_CBBL, Chase_PIO2_batch, Chase_PIO2_XML, Chase_BNK4_batch, Chase_BNK4_xml):
 // WHEN(CRON('45 4 * * *')), //every day at 5.10 AM
    // FAILURE(FileServices.SendEmail( 'suman.burjukindi@lexisnexis.com','CRON job failed','The failed workunit is:' + workunit + FailMessage));
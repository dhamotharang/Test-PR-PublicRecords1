EXPORT bwr_nonfcra_w_params_slim(STRING roxieIP, STRING gateway_ip, INTEGER no_of_threads, INTEGER no_of_recs_to_run, STRING filetag) := FUNCTION

IMPORT sghatti, RiskWise, ut, Scoring_Project_Macros, Gateway, Scoring_Project_PIP; 

Timeout := 120;
Retry_time := 3;

Chase_BNK4_xml_inFile_name := Scoring_Project_PIP.Input_Sample_Names.Chase_BNK4_xml_inFile_name;  //  '~Scoring_Project::in::BC1O_XML_Chase_bnk4_20140416';
Chase_BNK4_xml_outfile_name := '~ScoringQA::out::NONFCRA::BNK4_xml_chase_BD3605_0_' + ut.GetDate + '_' + filetag;

Chase_BNK4_batch_inFile_name := Scoring_Project_PIP.Input_Sample_Names.Chase_BNK4_batch_inFile_name;  //  '~Scoring_Project::in::BC1O_XML_Chase_bnk4_20140416';
Chase_BNK4_batch_outFile_name := '~ScoringQA::out::NONFCRA::BNK4_batch_chase_BD3605_0_' + ut.GetDate + '_' + filetag;

Chase_PIO2_xml_inFile_name := Scoring_Project_PIP.Input_Sample_Names.Chase_PIO2_xml_inFile_name;  //  '~Scoring_Project::in::PRIO_XML_Chase_pi02_20140415';
Chase_PIO2_xml_outFile_name := '~ScoringQA::out::NONFCRA::PI02_xml_chase_FP3710_0_' + ut.GetDate + '_' + filetag;

Chase_PIO2_batch_inFile_name := Scoring_Project_PIP.Input_Sample_Names.Chase_PIO2_batch_inFile_name;  //  '~Scoring_Project::in::PRIO_XML_Chase_pi02_20140415';
Chase_PIO2_batch_outFile_name := '~ScoringQA::out::NONFCRA::PI02_batch_chase_FP3710_0_' + ut.GetDate + '_' + filetag;

Chase_CBBL_inFile_name := Scoring_Project_PIP.Input_Sample_Names.Chase_CBBL_inFile_name;  // '~Scoring_Project::in::cbbl_xml_chase_20140827';
Chase_CBBL_outfile_name := '~ScoringQA::out::NONFCRA::cbbl_xml_chase_' + ut.GetDate + '_' + filetag;

// CapitalOne_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.ITA_CapitalOne_batch_infile_name;  //   '~Scoring_Project::in::ITA_v3_Batch_CapitalOne_Attributes_20141001';
CapitalOne_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.ITA_CapitalOne_batch_infile_jan_full_file;  //   '~Scoring_Project::in::ITA_v3_Batch_CapitalOne_Attributes_jan_full_file_20150206';
CapitalOne_batch_outfile_name := '~ScoringQA::out::NONFCRA::ITA_batch_CapitalOne_attributes_v3_' + ut.GetDate + '_' + filetag;

bbuy_infile_name := Scoring_Project_PIP.Input_Sample_Names.bbuy_infile_name;  //  '~Scoring_Project::in::ChargeBackDefender_XML_BestBuy_cdn1109_1_20141001';
bbuy_outFile_Name := '~ScoringQA::out::NONFCRA::ChargebackDefender_xml_BestBuy_CDN1109_1_' + ut.GetDate + '_' + filetag;

li_v4_scores_batch_infile_name     := Scoring_Project_PIP.Input_Sample_Names.li_v4_scores_batch_infile_name    ;  //  '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_scores_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_msn1106_0_v4_' + ut.GetDate + '_' + filetag;

li_v4_attributes_batch_infile_name     := Scoring_Project_PIP.Input_Sample_Names.li_v4_attributes_batch_infile_name    ;  //  '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v4_' + ut.GetDate + '_' + filetag;

li_v3_attributes_xml_infile_name     := Scoring_Project_PIP.Input_Sample_Names.li_v3_attributes_xml_infile_name    ;  //  '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v3_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v3_' + ut.GetDate + '_' + filetag;

li_v3_attributes_batch_infile_name     := Scoring_Project_PIP.Input_Sample_Names.li_v3_attributes_batch_infile_name    ;  //  '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v3_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v3_' + ut.GetDate + '_' + filetag;

li_v4_scores_xml_infile_name    := Scoring_Project_PIP.Input_Sample_Names.li_v4_scores_xml_infile_name   ;  //  '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_scores_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_msn1106_0_v4_' + ut.GetDate + '_' + filetag;

li_v4_attributes_xml_infile_name    := Scoring_Project_PIP.Input_Sample_Names.li_v4_attributes_xml_infile_name   ;  //  '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v4_' + ut.GetDate + '_' + filetag;

chase_BIID_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.chase_BIID_batch_infile_name;  //  '~scoring_project::in::biid_batch_chase_generic_20141016';
chase_BIID_batch_outfile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_Chase_' + ut.GetDate + '_' + filetag;

Paro_it60_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.Paro_it60_XML_infile_name;  // '~Scoring_Project::in::IT60_Batch_Paro_Msn605_20140701';
Paro_it60_outfile_name := '~ScoringQA::out::NONFCRA::IT60_xml_paro_Msn605_' + ut.GetDate + '_' + filetag;

Paro_it60_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.Paro_it60_BATCH_infile_name;  //  '~Scoring_Project::in::IT60_Batch_Paro_Msn605_20140701';
Paro_it60_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::IT60_batch_paro_Msn605_' + ut.GetDate + '_' + filetag;

Paro_it61_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.Paro_it61_BATCH_infile_name;  //  '~Scoring_Project::in::IT61_Batch_Paro_MSN605_RSN804_20140701';
Paro_it61_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::IT61_batch_paro_MSN605_RSN804_' + ut.GetDate + '_' + filetag;

Paro_it61_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.Paro_it61_XML_infile_name;  // '~scoring_project::in::it61_xml_paro_msn605_rsn804_20140730';
Paro_it61_outfile_name := '~ScoringQA::out::NONFCRA::IT61_xml_paro_MSN605_RSN804_' + ut.GetDate + '_' + filetag;

biid_xml_inFile_name := Scoring_Project_PIP.Input_Sample_Names.biid_xml_inFile_name;  //  '~scoring_project::in::biid_xml_general_generic_20140827';
biid_xml_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_xml_generic_' + ut.GetDate + '_' + filetag;

biid_batch_inFile_name := Scoring_Project_PIP.Input_Sample_Names.biid_batch_inFile_name;  //  '~scoring_project::in::biid_batch_general_generic_20140722';
biid_batch_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_generic_' + ut.GetDate + '_' + filetag;

iid_xml_infile_name := Scoring_Project_PIP.Input_Sample_Names.iid_xml_full;  //  '~Scoring_Project::in::InstantID_XML_Generic_Version0_20141001';
iid_xml_outfile_name := '~ScoringQA::out::NONFCRA::instantid_xml_generic_' + ut.GetDate + '_' + filetag;

iid_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.iid_batch_infile_name;  //  '~scoring_project::in::instantid_batch_generic_version0_20141013';
iid_batch_outfile_name := '~ScoringQA::out::NONFCRA::instantid_batch_generic_' + ut.GetDate + '_' + filetag;

FP_XML_infile_name    := Scoring_Project_PIP.Input_Sample_Names.FP_XML_infile_name   ;  //  '~Scoring_Project::in::FraudPoint_XML_Generic_FP1109_0_20140408'; 
FP_XML_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_xml_generic_fp1109_0_v2_' + ut.GetDate + '_' + filetag;

FP_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.FP_BATCH_infile_name;  //  '~Scoring_Project::in::FraudPoint_XML_Generic_FP1109_0_20140408'; 
FP_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_batch_generic_fp1109_0_v2_' + ut.GetDate + '_' + filetag;


bestbuy := Scoring_Project_Macros.BestBuy_CDS_CDN1109_1_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,bbuy_infile_name,bbuy_outFile_Name,no_of_recs_to_run);
LI_v3_attributes_xml := Scoring_Project_Macros.LI_Attributes_V3_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v3_attributes_xml_infile_name,li_v3_attributes_xml_outfile_name,no_of_recs_to_run);
LI_v3_attributes_batch := Scoring_Project_Macros.LI_Attributes_V3_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v3_attributes_batch_infile_name,li_v3_attributes_batch_outfile_name,no_of_recs_to_run);
LI_v4_scores_xml := Scoring_Project_Macros.LI_Scores_V4_XML(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_scores_xml_infile_name,li_v4_scores_xml_outfile_name,no_of_recs_to_run);
LI_v4_attributes_xml := Scoring_Project_Macros.LI_Attributes_V4_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_attributes_xml_infile_name,li_v4_attributes_xml_outfile_name,no_of_recs_to_run);
LI_v4_scores_batch := Scoring_Project_Macros.LI_Scores_V4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_scores_batch_infile_name,li_v4_scores_batch_outfile_name,no_of_recs_to_run);
LI_v4_attributes_batch := Scoring_Project_Macros.LI_Attributes_V4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_attributes_batch_infile_name,li_v4_attributes_batch_outfile_name,no_of_recs_to_run);
CapitalOne_batch_ITA:= Scoring_Project_Macros.CapitalOne_ITA_V3_BATCH_Macro_new(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,CapitalOne_batch_infile_name,CapitalOne_batch_outfile_name,no_of_recs_to_run);
Chase_BNK4_xml := Scoring_Project_Macros.Chase_BNK4_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_xml_inFile_name,Chase_BNK4_xml_outfile_name,no_of_recs_to_run);
Chase_BNK4_batch := Scoring_Project_Macros.Chase_BNK4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_batch_inFile_name,Chase_BNK4_batch_outFile_name,no_of_recs_to_run);
Chase_PIO2_XML := Scoring_Project_Macros.Chase_PIO2_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_xml_inFile_name,Chase_PIO2_xml_outfile_name,no_of_recs_to_run);
Chase_PIO2_batch := Scoring_Project_Macros.Chase_PIO2_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_batch_inFile_name,Chase_PIO2_batch_outfile_name,no_of_recs_to_run);
Chase_CBBL := Scoring_Project_Macros.Chase_CBBL_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_CBBL_inFile_name,Chase_CBBL_outfile_name,no_of_recs_to_run);
Paro_IT60_XML := Scoring_Project_Macros.Paro_IT60_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it60_XML_infile_name,Paro_it60_outfile_name,no_of_recs_to_run);
Paro_IT60_BATCH := Scoring_Project_Macros.Paro_IT60_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it60_BATCH_infile_name,Paro_it60_BATCH_outfile_name,no_of_recs_to_run);
Paro_IT61_XML := Scoring_Project_Macros.Paro_IT61_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it61_XML_infile_name,Paro_it61_outfile_name,no_of_recs_to_run);
Paro_IT61_BATCH := Scoring_Project_Macros.Paro_IT61_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it61_BATCH_infile_name,Paro_it61_BATCH_outfile_name,no_of_recs_to_run);
FP_ScoresAttributes_XML := Scoring_Project_Macros.FP_Scores_and_Attributes_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_XML_infile_name,FP_XML_outfile_name,no_of_recs_to_run);
FP_ScoresAttributes_BATCH := Scoring_Project_Macros.FP_Scores_and_Attributes_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_BATCH_infile_name,FP_BATCH_outfile_name,no_of_recs_to_run);
chase_BIID_batch := Scoring_Project_Macros.Chase_BIID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,chase_BIID_batch_infile_name,chase_BIID_batch_outfile_name,no_of_recs_to_run);
instant_id_xml := Scoring_Project_Macros.Instant_ID_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_xml_infile_name,iid_xml_outfile_name,no_of_recs_to_run);
instant_id_batch := Scoring_Project_Macros.Instant_ID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_batch_infile_name,iid_batch_outfile_name,no_of_recs_to_run);
BIID_XML := Scoring_Project_Macros.Business_Instant_Id_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,biid_xml_inFile_name,biid_xml_outFile_name,no_of_recs_to_run);
BIID_batch := Scoring_Project_Macros.Business_Instant_Id_Batch_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,biid_batch_inFile_name,biid_batch_outFile_name,no_of_recs_to_run);
 
// ****************************************************************************************************************
RETURN sequential(
										// Chase_BNK4_xml,
										Chase_BNK4_batch,
										// Chase_PIO2_XML,
										Chase_PIO2_batch,
										Chase_CBBL,
										// Paro_IT60_XML,
										// Paro_IT60_BATCH,
										// Paro_IT61_XML,
										Paro_IT61_BATCH,
										bestbuy,
										// LI_v3_attributes_xml,
										// LI_v3_attributes_batch,
										// LI_v4_attributes_xml,
										LI_v4_attributes_batch,
										CapitalOne_batch_ITA,
										// LI_v4_scores_xml,
										LI_v4_scores_batch,
										FP_ScoresAttributes_XML,
										// FP_ScoresAttributes_BATCH,
										chase_BIID_batch,
										instant_id_xml
										// instant_id_batch,
										// BIID_XML,
										// BIID_batch
										);
END;
EXPORT bwr_BIP_all (STRING neutralroxieIP, STRING fcra_roxieIP, INTEGER no_of_threads, INTEGER no_of_recs_to_run, STRING filetag) := FUNCTION

IMPORT sghatti, RiskWise, ut, Scoring_Project_Macros, Gateway, Scoring_Project_PIP; 

Timeout := 120;
Retry_time := 3;
roxieIP := neutralroxieIP;
gateway_ip := neutralroxieIP;

//***** NONFCRA **********************************************************************************************************************
Chase_BNK4_xml_inFile_name := Scoring_Project_PIP.Input_Sample_Names.BC10_Scores_Chase_BNK4_infile;;  //  '~Scoring_Project::in::BC1O_XML_Chase_bnk4_20140416';
Chase_BNK4_xml_outfile_name := '~ScoringQA::out::NONFCRA::BNK4_xml_chase_BD3605_0_' + ut.GetDate + '_' + filetag;

Chase_BNK4_batch_inFile_name := Scoring_Project_PIP.Input_Sample_Names.BC10_Scores_Chase_BNK4_infile;  //  '~Scoring_Project::in::BC1O_XML_Chase_bnk4_20140416';
Chase_BNK4_batch_outFile_name := '~ScoringQA::out::NONFCRA::BNK4_batch_chase_BD3605_0_' + ut.GetDate + '_' + filetag;

Chase_PIO2_xml_inFile_name := Scoring_Project_PIP.Input_Sample_Names.PRIO_Scores_Chase_PIO2_infile;  //  '~Scoring_Project::in::PRIO_XML_Chase_pi02_20140415';
Chase_PIO2_xml_outFile_name := '~ScoringQA::out::NONFCRA::PI02_xml_chase_FP3710_0_' + ut.GetDate + '_' + filetag;

Chase_PIO2_batch_inFile_name := Scoring_Project_PIP.Input_Sample_Names.PRIO_Scores_Chase_PIO2_infile;  //  '~Scoring_Project::in::PRIO_XML_Chase_pi02_20140415';
Chase_PIO2_batch_outFile_name := '~ScoringQA::out::NONFCRA::PI02_batch_chase_FP3710_0_' + ut.GetDate + '_' + filetag;

Chase_CBBL_inFile_name := Scoring_Project_PIP.Input_Sample_Names.CBBL_Scores_XML_Chase_infile;  // '~Scoring_Project::in::cbbl_xml_chase_20140827';
Chase_CBBL_outfile_name := '~ScoringQA::out::NONFCRA::cbbl_xml_chase_' + ut.GetDate + '_' + filetag;

Chase_CBBL_inFile_name_FPScore_ONLY := Scoring_Project_PIP.Input_Sample_Names.Chase_CBBL_fpscore_only_infile;  // ONLY FOR FP SCORE.  ATTRIBUTES WILL BE WRONG. June, July, Aug Sample.  18,483 Sample size
Chase_CBBL_outfile_name_FPScore_ONLY := '~ScoringQA::out::NONFCRA::cbbl_xml_chase_FPScore_ONLY_' + ut.GetDate + '_' + filetag;

// CapitalOne_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_infile;  //   '~Scoring_Project::in::ITA_v3_Batch_CapitalOne_Attributes_20141001';
CapitalOne_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.ITA_CapitalOne_batch_infile_jan_full_file;  //   '~Scoring_Project::in::ITA_v3_Batch_CapitalOne_Attributes_jan_full_file_20150206';
CapitalOne_batch_outfile_name := '~ScoringQA::out::NONFCRA::ITA_batch_CapitalOne_attributes_v3_' + ut.GetDate + '_' + filetag;

bbuy_infile_name := Scoring_Project_PIP.Input_Sample_Names.ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile;  //  '~Scoring_Project::in::ChargeBackDefender_XML_BestBuy_cdn1109_1_20141001';
bbuy_outFile_Name := '~ScoringQA::out::NONFCRA::ChargebackDefender_xml_BestBuy_CDN1109_1_' + ut.GetDate + '_' + filetag;

li_v4_scores_batch_infile_name     := Scoring_Project_PIP.Input_Sample_Names.LI_Generic_msn1210_1_infile;  //  '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_scores_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_msn1106_0_v4_' + ut.GetDate + '_' + filetag;

li_v4_attributes_batch_infile_name     := Scoring_Project_PIP.Input_Sample_Names.LI_Generic_msn1210_1_infile;  //  '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v4_' + ut.GetDate + '_' + filetag;

// li_v3_attributes_xml_infile_name     := Scoring_Project_PIP.Input_Sample_Names.li_v3_attributes_xml_infile_name    ;  //  '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
// li_v3_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v3_' + ut.GetDate + '_' + filetag;

// li_v3_attributes_batch_infile_name     := Scoring_Project_PIP.Input_Sample_Names.li_v3_attributes_batch_infile_name    ;  //  '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
// li_v3_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v3_' + ut.GetDate + '_' + filetag;

li_v4_scores_xml_infile_name    := Scoring_Project_PIP.Input_Sample_Names.LI_Generic_msn1210_1_infile   ;  //  '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_scores_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_msn1106_0_v4_' + ut.GetDate + '_' + filetag;

li_v4_attributes_xml_infile_name    := Scoring_Project_PIP.Input_Sample_Names.LI_Generic_msn1210_1_infile   ;  //  '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v4_' + ut.GetDate + '_' + filetag;

// chase_BIID_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.BIID_Scores_Batch_Chase_infile;  //  '~scoring_project::in::biid_batch_chase_generic_20141016';
chase_BIID_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.BIP_Chase_BIID_infile_name;  //  '~scoring_project::in::biid_batch_chase_generic_20141016';
chase_BIID_batch_outfile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_Chase_' + ut.GetDate + '_' + filetag;

Paro_it60_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.IT60_Scores_Paro_msn605_infile;  // '~Scoring_Project::in::IT60_Batch_Paro_Msn605_20140701';
Paro_it60_outfile_name := '~ScoringQA::out::NONFCRA::IT60_xml_paro_Msn605_' + ut.GetDate + '_' + filetag;

Paro_it60_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.IT60_Scores_Paro_msn605_infile;  //  '~Scoring_Project::in::IT60_Batch_Paro_Msn605_20140701';
Paro_it60_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::IT60_batch_paro_Msn605_' + ut.GetDate + '_' + filetag;

Paro_it61_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.IT61_Scores_BATCH_Paro_msn605_rsn804_infile;  //  '~Scoring_Project::in::IT61_Batch_Paro_MSN605_RSN804_20140701';
Paro_it61_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::IT61_batch_paro_MSN605_RSN804_' + ut.GetDate + '_' + filetag;

Paro_it61_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.IT61_Scores_XML_Paro_msn605_rsn804_infile;  // '~scoring_project::in::it61_xml_paro_msn605_rsn804_20140730';
Paro_it61_outfile_name := '~ScoringQA::out::NONFCRA::IT61_xml_paro_MSN605_RSN804_' + ut.GetDate + '_' + filetag;

// biid_xml_inFile_name := Scoring_Project_PIP.Input_Sample_Names.BIID_Scores_XML_Generic_infile;  //  '~scoring_project::in::biid_xml_general_generic_20140827';
biid_xml_inFile_name := Scoring_Project_PIP.Input_Sample_Names.BIP_BIID_infile_name;  //  '~scoring_project::in::biid_xml_general_generic_20140827';
biid_xml_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_xml_generic_' + ut.GetDate + '_' + filetag;

// biid_batch_inFile_name := Scoring_Project_PIP.Input_Sample_Names.biid_batch_inFile_name;  //  '~scoring_project::in::biid_batch_general_generic_20140722';
biid_batch_inFile_name := Scoring_Project_PIP.Input_Sample_Names.BIID_Scores_BATCH_Generic_infile;  //  '~scoring_project::in::biid_batch_general_generic_20140722';
biid_batch_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_generic_' + ut.GetDate + '_' + filetag;

// iid_xml_infile_name := Scoring_Project_PIP.Input_Sample_Names.IID_Scores_V0_XML_Generic_infile;  //  '~Scoring_Project::in::InstantID_XML_Generic_Version0_20141001';
iid_xml_infile_name := Scoring_Project_PIP.Input_Sample_Names.iid_xml_full;  //  '~Scoring_Project::in::InstantID_XML_Generic_Version0_20141001';
iid_xml_outfile_name := '~ScoringQA::out::NONFCRA::instantid_xml_generic_' + ut.GetDate + '_' + filetag;

iid_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.IID_Scores_V0_BATCH_Generic_infile;  //  '~scoring_project::in::instantid_batch_generic_version0_20141013';
iid_batch_outfile_name := '~ScoringQA::out::NONFCRA::instantid_batch_generic_' + ut.GetDate + '_' + filetag;

FP_XML_infile_name    := Scoring_Project_PIP.Input_Sample_Names.FP_V2_Generic_FP1109_0_infile   ;  //  '~Scoring_Project::in::FraudPoint_XML_Generic_FP1109_0_20140408'; 
FP_XML_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_xml_generic_fp1109_0_v2_' + ut.GetDate + '_' + filetag;

FP_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.FP_V2_Generic_FP1109_0_infile;  //  '~Scoring_Project::in::FraudPoint_XML_Generic_FP1109_0_20140408'; 
FP_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_batch_generic_fp1109_0_v2_' + ut.GetDate + '_' + filetag;

//***** FCRA **********************************************************************************************************************

Experian_RVA_30_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V3_XML_Experian_infile;  
Experian_RVA_30_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Experian_attributes_v3_' + ut.GetDate + '_' + filetag;

Experian_RVA_30_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V3_BATCH_Experian_infile;  
Experian_RVA_30_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_Experian_attributes_v3_' + ut.GetDate + '_' + filetag;

CapitalOne_RVAttributes_V3_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V3_BATCH_CapOne_infile;  
CapitalOne_RVAttributes_V3_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v3_' + ut.GetDate + '_' + filetag;

CapitalOne_RVAttributes_V2_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V2_BATCH_CapOne_infile;  
CapitalOne_RVAttributes_V2_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_V2_' + ut.GetDate + '_' + filetag;

CreditAcceptanceCorp_RV2_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V2_BATCH_CreditAcceptance_infile;  
CreditAcceptanceCorp_RV2_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_creditacceptancecorp_attributes_v2_' + ut.GetDate + '_' + filetag;

T_Mobile_RVT1212_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_XML_Tmobile_rvt1212_1_infile;  
T_Mobile_RVT1212_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1212_1_v4_' + ut.GetDate + '_' + filetag;

T_Mobile_RVT1210_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_XML_Tmobile_rvt1210_1_infile;  
T_Mobile_RVT1210_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1210_1_v4_' + ut.GetDate + '_' + filetag;

Santander_RVA1304_1_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_XML_Santander_1304_1_infile;  
Santander_RVA1304_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_1_v3_' + ut.GetDate + '_' + filetag;

Santander_RVA1304_2_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_XML_Santander_1304_2_infile;  
Santander_RVA1304_2_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_2_v3_' + ut.GetDate + '_' + filetag;

RV_V3_ENOVA_XML_Scores_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_V4_XML_ENOVA_infile;  
RV_V3_ENOVA_XML_Scores_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_enova_rvg1103_0_v4_' + ut.GetDate + '_' + filetag;

RV_Scores_V4_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V4_Generic_infile;  
RV_Scores_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v4_' + ut.GetDate + '_' + filetag;

RV_Scores_V3_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V3_Generic_infile;  
RV_Scores_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v3_' + ut.GetDate + '_' + filetag;

RV_Attributes_V4_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V4_Generic_infile;  
RV_Attributes_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v4_' + ut.GetDate + '_' + filetag;

RV_Attributes_V3_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V3_Generic_infile;  
RV_Attributes_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v3_' + ut.GetDate + '_' + filetag;

RV_Attributes_V3_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V3_Generic_infile;  
RV_Attributes_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v3_' + ut.GetDate + '_' + filetag;

RV_Attributes_V4_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V4_Generic_infile;  
RV_Attributes_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v4_' + ut.GetDate + '_' + filetag;

// RV_Attributes_V2_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V2_BATCH_infile_name;  
// RV_Attributes_V2_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v2_' + ut.GetDate + '_' + filetag;

RV_Scores_V4_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V4_Generic_infile;  
RV_Scores_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v4_' + ut.GetDate + '_' + filetag;

RV_Scores_V3_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V3_Generic_infile;  
RV_Scores_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v3_' + ut.GetDate + '_' + filetag;

Regional_Acceptance_RVA1008_1_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile;  
Regional_Acceptance_RVA1008_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_RegionalAcceptance_RVA1008_1_v4_' + ut.GetDate + '_' + filetag;

RV_Scores_Attributes_V5_XMl_Generic_infile :=  scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;
RV_Scores_Attributes_V5_XML_Generic_outfile := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_attributes_v5_' + ut.GetDate + '_' + filetag;
RV_Scores_Attributes_V5_XML_Generic_prescreen_outfile := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_attributes_v5_prescreen_' + ut.GetDate + '_' + filetag;


//***** SHELL **********************************************************************************************************************

bocashell_infile_name :=  Scoring_Project_PIP.Input_Sample_Names.bocashell_infile_name;																						
bocashell_41_cert_fcra_outfile_name := '~scoringqa::out::bs_41_tracking_edina_fcra_NO_EDINA_' + filetag + '_'  + ut.GetDate;
bocashell_41_cert_nonfcra_outfile_name := '~scoringqa::out::bs_41_tracking_edina_nonfcra_NO_EDINA_' + filetag + '_'  + ut.GetDate;
bocashell_50_cert_fcra_outfile_name := '~scoringqa::out::tracking::bocashell50::cert_bs_50_FCRA_NO_EDINA_' + filetag + '_'  + ut.GetDate;
bocashell_50_cert_nonfcra_outfile_name := '~scoringqa::out::tracking::bocashell50::cert_bs_50_nonFCRA_NO_EDINA_' + filetag + '_'  + ut.GetDate;

// *********************************************************************************************************************************************************
bestbuy := Scoring_Project_Macros.BestBuy_CDS_CDN1109_1_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,bbuy_infile_name,bbuy_outFile_Name,no_of_recs_to_run);
// LI_v3_attributes_xml := Scoring_Project_Macros.LI_Attributes_V3_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v3_attributes_xml_infile_name,li_v3_attributes_xml_outfile_name,no_of_recs_to_run);
// LI_v3_attributes_batch := Scoring_Project_Macros.LI_Attributes_V3_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v3_attributes_batch_infile_name,li_v3_attributes_batch_outfile_name,no_of_recs_to_run);
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
Chase_CBBL_FPScore_ONLY := Scoring_Project_Macros.Chase_CBBL_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_CBBL_inFile_name_FPScore_ONLY,Chase_CBBL_outfile_name_FPScore_ONLY,no_of_recs_to_run);
Paro_IT60_XML := Scoring_Project_Macros.Paro_IT60_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it60_XML_infile_name,Paro_it60_outfile_name,no_of_recs_to_run);
Paro_IT60_BATCH := Scoring_Project_Macros.Paro_IT60_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it60_BATCH_infile_name,Paro_it60_BATCH_outfile_name,no_of_recs_to_run);
Paro_IT61_XML := Scoring_Project_Macros.Paro_IT61_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it61_XML_infile_name,Paro_it61_outfile_name,no_of_recs_to_run);
Paro_IT61_BATCH := Scoring_Project_Macros.Paro_IT61_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it61_BATCH_infile_name,Paro_it61_BATCH_outfile_name,no_of_recs_to_run);
FP_ScoresAttributes_XML := Scoring_Project_Macros.FP_Scores_and_Attributes_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_XML_infile_name,FP_XML_outfile_name,no_of_recs_to_run);
FP_ScoresAttributes_BATCH := Scoring_Project_Macros.FP_Scores_and_Attributes_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_BATCH_infile_name,FP_BATCH_outfile_name,no_of_recs_to_run);
chase_BIID_batch := Scoring_Project_Macros.Chase_BIID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,chase_BIID_batch_infile_name,chase_BIID_batch_outfile_name,no_of_recs_to_run);
// instant_id_xml_new := Scoring_Project_Macros.Instant_ID_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_xml_infile_new,iid_xml_outfile_new,no_of_recs_to_run);
// instant_id_batch_new := Scoring_Project_Macros.Instant_ID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_batch_infile_new,iid_batch_outfile_new,no_of_recs_to_run);
instant_id_xml := Scoring_Project_Macros.Instant_ID_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_xml_infile_name,iid_xml_outfile_name,no_of_recs_to_run);
instant_id_batch := Scoring_Project_Macros.Instant_ID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_batch_infile_name,iid_batch_outfile_name,no_of_recs_to_run);
BIID_XML := Scoring_Project_Macros.Business_Instant_Id_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,biid_xml_inFile_name,biid_xml_outFile_name,no_of_recs_to_run);
BIID_batch := Scoring_Project_Macros.Business_Instant_Id_Batch_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,biid_batch_inFile_name,biid_batch_outFile_name,no_of_recs_to_run);

RV_Attributes_V4_XML := Scoring_Project_Macros.RV_Attributes_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V4_XML_infile_name,RV_Attributes_V4_XML_outfile_name,no_of_recs_to_run);
RV_Attributes_V3_XML := Scoring_Project_Macros.RV_Attributes_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_XML_infile_name,RV_Attributes_V3_XML_outfile_name,no_of_recs_to_run);
RV_Scores_V4_XML := Scoring_Project_Macros.RV_Scores_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V4_XML_infile_name,RV_Scores_V4_XML_outfile_name,no_of_recs_to_run);
RV_Scores_V3_XML := Scoring_Project_Macros.RV_Scores_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V3_XML_infile_name,RV_Scores_V3_XML_outfile_name,no_of_recs_to_run);
Experian_RVA_30_XML := Scoring_Project_Macros.Experian_RVA_30_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Experian_RVA_30_XML_infile_name,Experian_RVA_30_XML_outfile_name,no_of_recs_to_run);
Experian_RVA_30_BATCH := Scoring_Project_Macros.Experian_RVA_30_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Experian_RVA_30_BATCH_infile_name,Experian_RVA_30_BATCH_outfile_name,no_of_recs_to_run);
Regional_Acceptance_RVA1008_1 := Scoring_Project_Macros.Regional_Acceptance_RVA1008_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Regional_Acceptance_RVA1008_1_infile_name,Regional_Acceptance_RVA1008_1_outfile_name,no_of_recs_to_run);
RV_Scores_V4_BATCH := Scoring_Project_Macros.RV_Scores_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V4_BATCH_infile_name,RV_Scores_V4_BATCH_outfile_name,no_of_recs_to_run);
RV_Scores_V3_BATCH := Scoring_Project_Macros.RV_Scores_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V3_BATCH_infile_name,RV_Scores_V3_BATCH_outfile_name,no_of_recs_to_run);
RV_Attributes_V3_BATCH := Scoring_Project_Macros.RV_Attributes_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_BATCH_infile_name,RV_Attributes_V3_BATCH_outfile_name,no_of_recs_to_run);
RV_Attributes_V4_BATCH := Scoring_Project_Macros.RV_Attributes_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V4_BATCH_infile_name,RV_Attributes_V4_BATCH_outfile_name,no_of_recs_to_run);
// RV_Attributes_V2_BATCH := Scoring_Project_Macros.RV_Attributes_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V2_BATCH_infile_name,RV_Attributes_V2_BATCH_outfile_name,no_of_recs_to_run);
RV_V3_ENOVA_XML_Scores := Scoring_Project_Macros.RV_Scores_V3_ENOVA_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_ENOVA_XML_Scores_infile_name,RV_V3_ENOVA_XML_Scores_outfile_name,no_of_recs_to_run);
CapitalOne_RVAttributes_V2 := Scoring_Project_Macros.CapitalOne_RVAttributes_V2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CapitalOne_RVAttributes_V2_infile_name,CapitalOne_RVAttributes_V2_outfile_name,no_of_recs_to_run);
CapitalOne_RVAttributes_V3 := Scoring_Project_Macros.CapitalOne_RVAttributes_V3_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CapitalOne_RVAttributes_V3_infile_name,CapitalOne_RVAttributes_V3_outfile_name,no_of_recs_to_run);
CreditAcceptanceCorp_RV2_BATCH := Scoring_Project_Macros.CreditAcceptanceCorp_RV_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CreditAcceptanceCorp_RV2_BATCH_infile_name,CreditAcceptanceCorp_RV2_BATCH_outfile_name,no_of_recs_to_run);
T_Mobile_RVT1212 := Scoring_Project_Macros.T_Mobile_RVT1212_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,T_Mobile_RVT1212_infile_name,T_Mobile_RVT1212_outfile_name,no_of_recs_to_run);
T_Mobile_RVT1210 := Scoring_Project_Macros.T_Mobile_RVT1210_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,T_Mobile_RVT1210_infile_name,T_Mobile_RVT1210_outfile_name,no_of_recs_to_run);
Santander_RVA1304_1 := Scoring_Project_Macros.Santander_RVA1304_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1304_1_infile_name,Santander_RVA1304_1_outfile_name,no_of_recs_to_run);
Santander_RVA1304_2 := Scoring_Project_Macros.Santander_RVA1304_2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1304_2_infile_name,Santander_RVA1304_2_outfile_name,no_of_recs_to_run);
RV_Scores_Attributes_V5_XML := Scoring_Project_PIP.RV_Scores_Attributes_V5_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_Attributes_V5_XMl_Generic_infile,RV_Scores_Attributes_V5_XML_Generic_outfile,no_of_recs_to_run);
RV_Scores_Attributes_V5_XML_Prescreen := Scoring_Project_PIP.RV_Scores_Attributes_V5_XML_Prescreen_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_Attributes_V5_XMl_Generic_infile,RV_Scores_Attributes_V5_XML_Generic_prescreen_outfile,no_of_recs_to_run);


bocashell_cert_fcra_41 := Scoring_Project_Macros.BocaShell_50_FCRA_cert_MACRO( 41, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_infile_name,bocashell_41_cert_fcra_outfile_name,no_of_recs_to_run);
bocashell_cert_nonfcra_41 := Scoring_Project_Macros.BocaShell_50_nonFCRA_cert_MACRO( 41, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_infile_name,bocashell_41_cert_nonfcra_outfile_name,no_of_recs_to_run);
bocashell_cert_fcra_50 := Scoring_Project_Macros.BocaShell_50_FCRA_cert_MACRO( 50, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_infile_name, bocashell_50_cert_fcra_outfile_name, no_of_recs_to_run);
bocashell_cert_nonfcra_50 := Scoring_Project_Macros.BocaShell_50_nonFCRA_cert_MACRO( 50, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_infile_name,bocashell_50_cert_nonfcra_outfile_name, no_of_recs_to_run);
 
// ****************************************************************************************************************



dc_nonFCRA := sequential(
										Chase_BNK4_xml,
										Chase_BNK4_batch,
										Chase_PIO2_XML,
										Chase_PIO2_batch,
										Chase_CBBL,
										// Chase_CBBL_FPScore_ONLY,
										// Paro_IT60_XML,
										// Paro_IT60_BATCH,
										// Paro_IT61_XML,
										// Paro_IT61_BATCH,
										bestbuy,
										// LI_v3_attributes_xml,
										// LI_v3_attributes_batch,
										LI_v4_attributes_xml,
										LI_v4_attributes_batch,
										CapitalOne_batch_ITA,
										LI_v4_scores_xml,
										LI_v4_scores_batch,
										FP_ScoresAttributes_XML,
										FP_ScoresAttributes_BATCH,
										chase_BIID_batch,
										instant_id_xml,
										instant_id_batch,
										BIID_XML,
										BIID_batch
										);

dc_FCRA := sequential(	
										RV_V3_ENOVA_XML_Scores,
										CapitalOne_RVAttributes_V2,
										CapitalOne_RVAttributes_V3,
										CreditAcceptanceCorp_RV2_BATCH,
										T_Mobile_RVT1212,
										T_Mobile_RVT1210,
										Santander_RVA1304_1,
										Santander_RVA1304_2,
										// Experian_RVA_30_XML,
										Experian_RVA_30_BATCH,
										Regional_Acceptance_RVA1008_1,
										RV_Attributes_V3_BATCH,
										RV_Attributes_V4_BATCH,
										RV_Scores_V4_BATCH,
										RV_Scores_V3_BATCH,
										// RV_Attributes_V2_BATCH,
										RV_Attributes_V4_XML,
										RV_Attributes_V3_XML,
										RV_Scores_V4_XML,
										RV_Scores_V3_XML,
										RV_Scores_Attributes_V5_XML,
										RV_Scores_Attributes_V5_XML_Prescreen
										);
										
dc_shell := Sequential(
										bocashell_cert_fcra_41,
										bocashell_cert_nonfcra_41,
										bocashell_cert_fcra_50,
										bocashell_cert_nonfcra_50
										);


NonFCRA_Ordered := sequential(
										bocashell_cert_nonfcra_41,										
										Chase_BNK4_batch,
										Chase_PIO2_batch,
										Chase_CBBL,
										// Chase_CBBL_FPScore_ONLY,
										bestbuy,
										LI_v4_attributes_batch,
										CapitalOne_batch_ITA,
										LI_v4_scores_batch,
										FP_ScoresAttributes_BATCH,
										chase_BIID_batch,
										instant_id_batch,
										BIID_batch,
										Chase_BNK4_xml,										
										Chase_PIO2_XML,										
										LI_v4_scores_xml,										
										FP_ScoresAttributes_XML,
										LI_v4_attributes_xml,											
										BIID_XML,										
										instant_id_xml,									
										bocashell_cert_nonfcra_50										
										);


FCRA_Ordered := sequential(
										bocashell_cert_fcra_41,
										RV_V3_ENOVA_XML_Scores,
										CapitalOne_RVAttributes_V2,
										CapitalOne_RVAttributes_V3,
										CreditAcceptanceCorp_RV2_BATCH,
										T_Mobile_RVT1212,
										T_Mobile_RVT1210,
										Santander_RVA1304_1,
										Santander_RVA1304_2,
										Experian_RVA_30_XML,
										Experian_RVA_30_BATCH,
										Regional_Acceptance_RVA1008_1,
										RV_Attributes_V3_BATCH,
										RV_Attributes_V4_BATCH,
										RV_Scores_V4_BATCH,
										RV_Scores_V3_BATCH,
										// RV_Scores_Attributes_V5_XML,
										// RV_Scores_Attributes_V5_XML_Prescreen,
										// RV_Attributes_V2_BATCH,
										RV_Attributes_V4_XML,
										RV_Attributes_V3_XML,
										RV_Scores_V4_XML,
										RV_Scores_V3_XML,										
										bocashell_cert_fcra_50
										);





// RETURN sequential(dc_shell, dc_nonFCRA, dc_FCRA);
// RETURN sequential(dc_shell, dc_NonFCRA);
// RETURN sequential(NonFCRA_Ordered);
// RETURN sequential(FCRA_Ordered);
// RETURN sequential(dc_nonFCRA, dc_FCRA);

Return Sequential(RV_Scores_Attributes_V5_XML, RV_Scores_Attributes_V5_XML_Prescreen);

END;
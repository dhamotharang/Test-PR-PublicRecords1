EXPORT Core_Testing_Products (STRING neutralroxieIP, STRING fcra_roxieIP, INTEGER no_of_threads, INTEGER no_of_recs_to_run, INTEGER no_of_recs_to_run_2, INTEGER no_of_recs_to_run_3, STRING filetag) := FUNCTION

IMPORT sghatti, RiskWise, ut, STD, data_services, Scoring_Project_Macros, Gateway, Risk_Indicators, models, RiskProcessing, scoring_project_pip, Scoring_Project_ISS; 


Timeout := 120;
Retry_time := 3;
roxieIP := neutralroxieIP;
gateway_ip := neutralroxieIP;
FP_v3_filetag := (String8)std.date.Today()  + '_' + filetag; 

//***** NONFCRA **********************************************************************************************************************
Chase_BNK4_xml_inFile_name := Scoring_Project_PIP.Input_Sample_Names.BC10_Scores_Chase_BNK4_infile;
Chase_BNK4_xml_outfile_name := '~ScoringQA::out::NONFCRA::BNK4_xml_chase_BD3605_0_' + (String8)Std.Date.Today() + '_' + filetag;

Chase_BNK4_batch_inFile_name := Scoring_Project_PIP.Input_Sample_Names.BC10_Scores_Chase_BNK4_infile;
Chase_BNK4_batch_outFile_name := '~ScoringQA::out::NONFCRA::BNK4_batch_chase_BD3605_0_' + (String8)Std.Date.Today() + '_' + filetag;

Chase_PIO2_xml_inFile_name := Scoring_Project_PIP.Input_Sample_Names.PRIO_Scores_Chase_PIO2_infile;
Chase_PIO2_xml_outFile_name := '~ScoringQA::out::NONFCRA::PI02_xml_chase_FP3710_0_' + (String8)Std.Date.Today() + '_' + filetag;

Chase_PIO2_batch_inFile_name := Scoring_Project_PIP.Input_Sample_Names.PRIO_Scores_Chase_PIO2_infile;
Chase_PIO2_batch_outFile_name := '~ScoringQA::out::NONFCRA::PI02_batch_chase_FP3710_0_' + (String8)Std.Date.Today() + '_' + filetag;

Chase_CBBL_inFile_name := Scoring_Project_PIP.Input_Sample_Names.CBBL_Scores_XML_Chase_infile;
Chase_CBBL_outfile_name := '~ScoringQA::out::NONFCRA::cbbl_xml_chase_' + (String8)Std.Date.Today() + '_' + filetag;

Chase_CBBL_inFile_name_FPScore_ONLY := Scoring_Project_PIP.Input_Sample_Names.Chase_CBBL_fpscore_only_infile;  // ONLY FOR FP SCORE.  ATTRIBUTES WILL BE WRONG. June, July, Aug Sample.  18,483 Sample size
Chase_CBBL_outfile_name_FPScore_ONLY := '~ScoringQA::out::NONFCRA::cbbl_xml_chase_FPScore_ONLY_' + (String8)Std.Date.Today() + '_' + filetag;

CapitalOne_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.ITA_Attributes_V3_BATCH_CapOne_infile;
// CapitalOne_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.ITA_CapitalOne_batch_infile_jan_full_file;    //  separate core testing sample 
CapitalOne_batch_outfile_name := '~ScoringQA::out::NONFCRA::ITA_batch_CapitalOne_attributes_v3_' + (String8)Std.Date.Today() + '_' + filetag;

bbuy_infile_name := Scoring_Project_PIP.Input_Sample_Names.ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile;
bbuy_outFile_Name := '~ScoringQA::out::NONFCRA::ChargebackDefender_xml_BestBuy_CDN1109_1_' + (String8)Std.Date.Today() + '_' + filetag;

li_v4_scores_batch_infile_name     := Scoring_Project_PIP.Input_Sample_Names.LI_Generic_msn1210_1_infile;
li_v4_scores_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_msn1106_0_v4_' + (String8)Std.Date.Today() + '_' + filetag;

li_v4_attributes_batch_infile_name     := Scoring_Project_PIP.Input_Sample_Names.LI_Generic_msn1210_1_infile; 
li_v4_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v4_' + (String8)Std.Date.Today() + '_' + filetag;

li_v4_scores_xml_infile_name    := Scoring_Project_PIP.Input_Sample_Names.LI_Generic_msn1210_1_infile;  
li_v4_scores_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_msn1106_0_v4_' + (String8)Std.Date.Today() + '_' + filetag;

li_v4_attributes_xml_infile_name    := Scoring_Project_PIP.Input_Sample_Names.LI_Generic_msn1210_1_infile;  
li_v4_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v4_' + (String8)Std.Date.Today() + '_' + filetag;

chase_BIID_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.BIID_Scores_Batch_Chase_infile;
// chase_BIID_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.BIP_Chase_BIID_infile_name;  //   separate core testing sample 
chase_BIID_batch_outfile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_Chase_' + (String8)Std.Date.Today() + '_' + filetag;

biid_xml_inFile_name := Scoring_Project_PIP.Input_Sample_Names.BIID_Scores_XML_Generic_infile;  
// biid_xml_inFile_name := Scoring_Project_PIP.Input_Sample_Names.BIP_BIID_infile_name;  //   separate core testing sample 
biid_xml_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_xml_generic_' + (String8)Std.Date.Today() + '_' + filetag;

biid_batch_inFile_name := Scoring_Project_PIP.Input_Sample_Names.BIID_Scores_BATCH_Generic_infile;
// biid_batch_inFile_name := Scoring_Project_PIP.Input_Sample_Names.BIP_BIID_infile_name;  //   separate core testing sample 
biid_batch_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_generic_' + (String8)Std.Date.Today() + '_' + filetag;

iid_xml_infile_name := Scoring_Project_PIP.Input_Sample_Names.IID_Scores_V0_XML_Generic_infile;  
// iid_xml_infile_name := Scoring_Project_PIP.Input_Sample_Names.iid_xml_full;  //  Core Feb 2015 Refresh
iid_xml_outfile_name := '~ScoringQA::out::NONFCRA::instantid_xml_generic_' + (String8)Std.Date.Today() + '_' + filetag;

iid_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.IID_Scores_V0_BATCH_Generic_infile;
iid_batch_outfile_name := '~ScoringQA::out::NONFCRA::instantid_batch_generic_' + (String8)Std.Date.Today() + '_' + filetag;

FP_XML_infile_name    := Scoring_Project_PIP.Input_Sample_Names.FP_V2_Generic_FP1109_0_infile; 
FP_XML_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_xml_generic_fp1109_0_v2_' + (String8)Std.Date.Today() + '_' + filetag;

FP_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.FP_V2_Generic_FP1109_0_infile;
FP_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_batch_generic_fp1109_0_v2_' + (String8)Std.Date.Today() + '_' + filetag;

FP_V2_American_Express_FP1109_0_infile    := scoring_project_pip.Input_Sample_Names.FP_V2_American_Express_FP1109_0_infile;
FP_V2_XML_American_Express_FP1109_0_outfile := '~ScoringQA::out::NONFCRA::fraudpoint_xml_American_Express_fp1109_0_v201_' + (String8)Std.Date.Today() + '_' + filetag ;

FP_V3_Generic_FP31505_0_infile := scoring_project_pip.Input_Sample_Names.FP_V3_Generic_FP31505_0_infile;
FP_V3_XML_Generic_FP31505_0_outfile := '~ScoringQA::out::NONFCRA::fraudpoint_xml_generic_fp31505_0_v3_';

Profile_Booster_Capone_infile := scoring_project_pip.Input_Sample_Names.Profile_booster_Capone_infile;
Profile_Booster_Capone_outfile := '~ScoringQA::out::NONFCRA::Profile_Booster_Batch_CapitalOne_attributes_v1_'+ (String8)Std.Date.Today() + '_' + filetag;


//***** FCRA **********************************************************************************************************************

Experian_RVA_30_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V3_XML_Experian_infile;  
Experian_RVA_30_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Experian_attributes_v3_' + (String8)Std.Date.Today() + '_' + filetag;

Experian_RVA_30_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V3_BATCH_Experian_infile;  
Experian_RVA_30_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_Experian_attributes_v3_' + (String8)Std.Date.Today() + '_' + filetag;

CapitalOne_RVAttributes_V3_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V3_BATCH_CapOne_infile;  
CapitalOne_RVAttributes_V3_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v3_' + (String8)Std.Date.Today() + '_' + filetag;

CapitalOne_RVAttributes_V2_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V2_BATCH_CapOne_infile;  
CapitalOne_RVAttributes_V2_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_V2_' + (String8)Std.Date.Today() + '_' + filetag;

CapitalOne_RVAttributes_V5_infile_name := scoring_project_pip.Input_Sample_Names.RV_Attributes_V2_BATCH_CapOne_infile;
CapitalOne_RVAttributes_V5_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v5_' + (String8)Std.Date.Today() + '_' + filetag;

CreditAcceptanceCorp_RV2_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V2_BATCH_CreditAcceptance_infile;  
CreditAcceptanceCorp_RV2_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_creditacceptancecorp_attributes_v2_' + (String8)Std.Date.Today() + '_' + filetag;

T_Mobile_RVT1212_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_XML_Tmobile_rvt1212_1_infile;  
T_Mobile_RVT1212_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1212_1_v4_' + (String8)Std.Date.Today() + '_' + filetag;

T_Mobile_RVT1210_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_XML_Tmobile_rvt1210_1_infile;  
T_Mobile_RVT1210_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1210_1_v4_' + (String8)Std.Date.Today() + '_' + filetag;

Santander_RVA1304_1_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_XML_Santander_1304_1_infile;  
Santander_RVA1304_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_1_v3_' + (String8)Std.Date.Today() + '_' + filetag;

Santander_RVA1304_2_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_XML_Santander_1304_2_infile;  
Santander_RVA1304_2_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_2_v3_' + (String8)Std.Date.Today() + '_' + filetag;

RV_V3_ENOVA_XML_Scores_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_V4_XML_ENOVA_infile;  
RV_V3_ENOVA_XML_Scores_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_enova_rvg1103_0_v4_' + (String8)Std.Date.Today() + '_' + filetag;

RV_Scores_V4_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V4_Generic_infile;  
RV_Scores_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v4_' + (String8)Std.Date.Today() + '_' + filetag;

RV_Scores_V3_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V3_Generic_infile;  
RV_Scores_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v3_' + (String8)Std.Date.Today() + '_' + filetag;

RV_Attributes_V4_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V4_Generic_infile;  
RV_Attributes_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v4_' + (String8)Std.Date.Today() + '_' + filetag;

RV_Attributes_V3_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V3_Generic_infile;  
RV_Attributes_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v3_' + (String8)Std.Date.Today() + '_' + filetag;

RV_Attributes_V3_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V3_Generic_infile;  
RV_Attributes_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v3_' + (String8)Std.Date.Today() + '_' + filetag;

RV_Attributes_V4_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V4_Generic_infile;  
RV_Attributes_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v4_' + (String8)Std.Date.Today() + '_' + filetag;

// RV_Attributes_V2_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V2_BATCH_infile_name;  
// RV_Attributes_V2_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v2_' + (String8)Std.Date.Today() + '_' + filetag;

RV_Scores_V4_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V4_Generic_infile;  
RV_Scores_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v4_' + (String8)Std.Date.Today() + '_' + filetag;

RV_Scores_V3_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V3_Generic_infile;  
RV_Scores_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v3_' + (String8)Std.Date.Today() + '_' + filetag;

Regional_Acceptance_RVA1008_1_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile;  
Regional_Acceptance_RVA1008_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_RegionalAcceptance_RVA1008_1_v4_' + (String8)Std.Date.Today() + '_' + filetag;

RV_Scores_Attributes_V5_XMl_Generic_infile :=  scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;
RV_Scores_Attributes_V5_XML_Generic_outfile := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_attributes_v5_' + (String8)Std.Date.Today() + '_' + filetag;
// RV_Scores_Attributes_V5_XML_Generic_prescreen_outfile := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_attributes_v5_prescreen_' + (String8)Std.Date.Today() + '_' + filetag;  //removed in favor of Capone v5 prescreen



//***** SHELLS **********************************************************************************************************************

bocashell_infile_name :=  Scoring_Project_PIP.Input_Sample_Names.bocashell_infile_name;																						
bocashell_41_fcra_outfile_name := '~scoringqa::out::bs_41_fcra_NO_EDINA_' + (String8)Std.Date.Today() + '_' + filetag;
bocashell_41_nonfcra_outfile_name := '~scoringqa::out::bs_41_nonfcra_NO_EDINA_' + (String8)Std.Date.Today() + '_' + filetag;
bocashell_50_fcra_outfile_name := '~scoringqa::out::bs_50_FCRA_NO_EDINA_' + (String8)Std.Date.Today() + '_' + filetag;
bocashell_50_nonfcra_outfile_name := '~scoringqa::out::bs_50_nonFCRA_NO_EDINA_' + (String8)Std.Date.Today() + '_' + filetag;

AddressShell_Attributes_V1_BATCH_Generic_infile :=   scoring_project_pip.Input_Sample_Names.AddressShell_Attributes_V1_BATCH_Generic_infile;
AddressShell_Attributes_V1_BATCH_Generic_outfile := '~ScoringQA::out::AddressShell_V1_Batch_Generic_' + (String8)Std.Date.Today() + '_' + filetag;

BusinessShell_Attributes_V2_XML_Generic_infile :=   scoring_project_pip.Input_Sample_Names.BusinessShell_Attributes_V2_XML_Generic_infile;
BusinessShell_Attributes_V2_XML_Generic_outfile := '~ScoringQA::out::NONFCRA::BusinessShell_xml_generic_attributes_v2_' + (String8)Std.Date.Today() + '_' + filetag;

PhoneShell_infile_name := data_services.foreign_prod + 'thor_200::out::inquiry_acclogs::inquiry_test::collections::internal_w20140218-105428';  //Used in Relatives Testing
PhoneShell_outfile_name := '~ScoringQA::out::phone_shell_' + (String8)std.date.Today() + '_' + filetag;


// *******NONFCRA MACROS***************************************************************************************************************************

bestbuy := scoring_project_pip.BestBuy_CDS_CDN1109_1_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,bbuy_infile_name,bbuy_outFile_Name,no_of_recs_to_run);

LI_v4_scores_xml := scoring_project_pip.LI_Scores_V4_XML(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_scores_xml_infile_name,li_v4_scores_xml_outfile_name,no_of_recs_to_run);

LI_v4_attributes_xml := scoring_project_pip.LI_Attributes_V4_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_attributes_xml_infile_name,li_v4_attributes_xml_outfile_name,no_of_recs_to_run);

LI_v4_scores_batch := scoring_project_pip.LI_Scores_V4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_scores_batch_infile_name,li_v4_scores_batch_outfile_name,no_of_recs_to_run);

LI_v4_attributes_batch := scoring_project_pip.LI_Attributes_V4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_attributes_batch_infile_name,li_v4_attributes_batch_outfile_name,no_of_recs_to_run);

CapitalOne_batch_ITA:= scoring_project_pip.CapitalOne_ITA_V3_BATCH_Macro_new(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,CapitalOne_batch_infile_name,CapitalOne_batch_outfile_name,no_of_recs_to_run);

Chase_BNK4_xml := scoring_project_pip.Chase_BNK4_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_xml_inFile_name,Chase_BNK4_xml_outfile_name,no_of_recs_to_run);

Chase_BNK4_batch := scoring_project_pip.Chase_BNK4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_batch_inFile_name,Chase_BNK4_batch_outFile_name,no_of_recs_to_run);

Chase_PIO2_XML := scoring_project_pip.Chase_PIO2_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_xml_inFile_name,Chase_PIO2_xml_outfile_name,no_of_recs_to_run);

Chase_PIO2_batch := scoring_project_pip.Chase_PIO2_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_batch_inFile_name,Chase_PIO2_batch_outfile_name,no_of_recs_to_run);

Chase_CBBL := scoring_project_pip.Chase_CBBL_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_CBBL_inFile_name,Chase_CBBL_outfile_name,no_of_recs_to_run);

Chase_CBBL_FPScore_ONLY := scoring_project_pip.Chase_CBBL_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_CBBL_inFile_name_FPScore_ONLY,Chase_CBBL_outfile_name_FPScore_ONLY,no_of_recs_to_run);

FP_ScoresAttributes_XML := scoring_project_pip.FP_Scores_and_Attributes_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_XML_infile_name,FP_XML_outfile_name,no_of_recs_to_run);

FP_ScoresAttributes_BATCH := scoring_project_pip.FP_Scores_and_Attributes_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_BATCH_infile_name,FP_BATCH_outfile_name,no_of_recs_to_run);

FP_AmericanExpress_XML := scoring_project_pip.FPv201_American_Express_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_V2_American_Express_FP1109_0_infile,FP_V2_XML_American_Express_FP1109_0_outfile,no_of_recs_to_run);

FP_v3_ScoresAttributes_XML := scoring_project_pip.FP_v3_Scores_and_Attributes_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_V3_Generic_FP31505_0_infile,FP_V3_XML_Generic_FP31505_0_outfile,no_of_recs_to_run_2, FP_v3_filetag);

chase_BIID_batch := scoring_project_pip.Chase_BIID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,chase_BIID_batch_infile_name,chase_BIID_batch_outfile_name,no_of_recs_to_run);

instant_id_xml := scoring_project_pip.Instant_ID_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_xml_infile_name,iid_xml_outfile_name,no_of_recs_to_run);

instant_id_batch := scoring_project_pip.Instant_ID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_batch_infile_name,iid_batch_outfile_name,no_of_recs_to_run);

BIID_XML := scoring_project_pip.Business_Instant_Id_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,biid_xml_inFile_name,biid_xml_outFile_name,no_of_recs_to_run);

BIID_batch := scoring_project_pip.Business_Instant_Id_Batch_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,biid_batch_inFile_name,biid_batch_outFile_name,no_of_recs_to_run);

PB_capone := scoring_project_pip.CapitalOne_Profile_Booster_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Profile_booster_Capone_infile,Profile_Booster_Capone_outfile,no_of_recs_to_run);


// ***************FCRA MACROS********************************************************
RV_Attributes_V4_XML := scoring_project_pip.RV_Attributes_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V4_XML_infile_name,RV_Attributes_V4_XML_outfile_name,no_of_recs_to_run_3);

RV_Attributes_V3_XML := scoring_project_pip.RV_Attributes_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_XML_infile_name,RV_Attributes_V3_XML_outfile_name,no_of_recs_to_run_3);

RV_Scores_V4_XML := scoring_project_pip.RV_Scores_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V4_XML_infile_name,RV_Scores_V4_XML_outfile_name,no_of_recs_to_run_3);

RV_Scores_V3_XML := scoring_project_pip.RV_Scores_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V3_XML_infile_name,RV_Scores_V3_XML_outfile_name,no_of_recs_to_run_3);

Experian_RVA_30_XML := scoring_project_pip.Experian_RVA_30_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Experian_RVA_30_XML_infile_name,Experian_RVA_30_XML_outfile_name,no_of_recs_to_run_3);

Experian_RVA_30_BATCH := scoring_project_pip.Experian_RVA_30_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Experian_RVA_30_BATCH_infile_name,Experian_RVA_30_BATCH_outfile_name,no_of_recs_to_run_3);

Regional_Acceptance_RVA1008_1 := scoring_project_pip.Regional_Acceptance_RVA1008_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Regional_Acceptance_RVA1008_1_infile_name,Regional_Acceptance_RVA1008_1_outfile_name,no_of_recs_to_run_3);

RV_Scores_V4_BATCH := scoring_project_pip.RV_Scores_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V4_BATCH_infile_name,RV_Scores_V4_BATCH_outfile_name,no_of_recs_to_run_3);

RV_Scores_V3_BATCH := scoring_project_pip.RV_Scores_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V3_BATCH_infile_name,RV_Scores_V3_BATCH_outfile_name,no_of_recs_to_run_3);

RV_Attributes_V3_BATCH := scoring_project_pip.RV_Attributes_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_BATCH_infile_name,RV_Attributes_V3_BATCH_outfile_name,no_of_recs_to_run_3);

RV_Attributes_V4_BATCH := scoring_project_pip.RV_Attributes_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V4_BATCH_infile_name,RV_Attributes_V4_BATCH_outfile_name,no_of_recs_to_run_3);

// RV_Attributes_V2_BATCH := scoring_project_pip.RV_Attributes_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V2_BATCH_infile_name,RV_Attributes_V2_BATCH_outfile_name,no_of_recs_to_run_3);

RV_V3_ENOVA_XML_Scores := scoring_project_pip.RV_Scores_V3_ENOVA_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_ENOVA_XML_Scores_infile_name,RV_V3_ENOVA_XML_Scores_outfile_name,no_of_recs_to_run_3);

CapitalOne_RVAttributes_V2 := scoring_project_pip.CapitalOne_RVAttributes_V2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CapitalOne_RVAttributes_V2_infile_name,CapitalOne_RVAttributes_V2_outfile_name,no_of_recs_to_run_3);

CapitalOne_RVAttributes_V3 := scoring_project_pip.CapitalOne_RVAttributes_V3_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CapitalOne_RVAttributes_V3_infile_name,CapitalOne_RVAttributes_V3_outfile_name,no_of_recs_to_run_3);

CapitalOne_RVAttributes_V5 := scoring_project_pip.CapitalOne_RVAttributes_V5_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CapitalOne_RVAttributes_V5_infile_name,CapitalOne_RVAttributes_V5_outfile_name,no_of_recs_to_run_3);


CreditAcceptanceCorp_RV2_BATCH := scoring_project_pip.CreditAcceptanceCorp_RV_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CreditAcceptanceCorp_RV2_BATCH_infile_name,CreditAcceptanceCorp_RV2_BATCH_outfile_name,no_of_recs_to_run_3);

T_Mobile_RVT1212 := scoring_project_pip.T_Mobile_RVT1212_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,T_Mobile_RVT1212_infile_name,T_Mobile_RVT1212_outfile_name,no_of_recs_to_run_3);

T_Mobile_RVT1210 := scoring_project_pip.T_Mobile_RVT1210_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,T_Mobile_RVT1210_infile_name,T_Mobile_RVT1210_outfile_name,no_of_recs_to_run_3);

Santander_RVA1304_1 := scoring_project_pip.Santander_RVA1304_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1304_1_infile_name,Santander_RVA1304_1_outfile_name,no_of_recs_to_run_3);

Santander_RVA1304_2 := scoring_project_pip.Santander_RVA1304_2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1304_2_infile_name,Santander_RVA1304_2_outfile_name,no_of_recs_to_run_3);

RV_Scores_Attributes_V5_XML := Scoring_Project_PIP.RV_Scores_Attributes_V5_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_Attributes_V5_XMl_Generic_infile,RV_Scores_Attributes_V5_XML_Generic_outfile,no_of_recs_to_run_3);

// RV_Scores_Attributes_V5_XML_Prescreen := Scoring_Project_PIP.RV_Scores_Attributes_V5_XML_Prescreen_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_Attributes_V5_XMl_Generic_infile,RV_Scores_Attributes_V5_XML_Generic_prescreen_outfile,no_of_recs_to_run_3);    //removed in favor of CapOne v5 prescreen



bocashell_41_fcra := Scoring_Project_PIP.BocaShell_41_FCRA_cert_MACRO( 41, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_infile_name,bocashell_41_fcra_outfile_name,no_of_recs_to_run);
bocashell_41_nonfcra := Scoring_Project_PIP.BocaShell_41_nonFCRA_cert_MACRO( 41, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_infile_name,bocashell_41_nonfcra_outfile_name,no_of_recs_to_run);
bocashell_50_fcra := Scoring_Project_PIP.BocaShell_50_FCRA_cert_MACRO( 50, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_infile_name,bocashell_50_fcra_outfile_name,no_of_recs_to_run);
bocashell_50_nonfcra := Scoring_Project_PIP.BocaShell_50_nonFCRA_cert_MACRO( 50, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_infile_name,bocashell_50_nonfcra_outfile_name,no_of_recs_to_run);

AddressShell:=Scoring_Project_ISS.AddressShell_Attributes_V1_BATCH_Macro(neutralroxieIP, '',no_of_threads,Timeout,Retry_time,AddressShell_Attributes_V1_BATCH_Generic_infile,AddressShell_Attributes_V1_BATCH_Generic_outfile,no_of_recs_to_run);

BusinessShell:=Scoring_Project_ISS.BusinessShell_Attributes_V2_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,BusinessShell_Attributes_V2_XML_Generic_infile,BusinessShell_Attributes_V2_XML_Generic_outfile,no_of_recs_to_run);

PhoneShell := zz_bkarnatz.PhoneShell_Macro(roxieIP, gateway_ip, no_of_threads,Timeout,Retry_time,PhoneShell_infile_name,PhoneShell_outfile_name,no_of_recs_to_run_2);

// ****************************************************************************************************************



NonFCRA_Ordered := sequential(
										bocashell_41_nonfcra,		
										Chase_BNK4_xml,
										Chase_BNK4_batch,
										Chase_PIO2_XML,
										Chase_PIO2_batch,	
										Chase_CBBL,
										chase_BIID_batch,	
										BIID_XML,									
										BIID_batch,			
										instant_id_xml,										
										instant_id_batch,
										CapitalOne_batch_ITA,
										LI_v4_scores_xml,									
										LI_v4_scores_batch,
										LI_v4_attributes_xml,								
										LI_v4_attributes_batch,						
										FP_ScoresAttributes_XML,											
										FP_ScoresAttributes_BATCH,									
										FP_AmericanExpress_XML,							
										FP_v3_ScoresAttributes_XML,										
										bocashell_50_nonfcra,		
										PhoneShell,
										BusinessShell,
										PB_capone
										
										
										// Chase_CBBL_FPScore_ONLY,   //diff sample than chase_cbbl
										
										// bestbuy,      //REMOVED/BB no longer using this model  7/22/16
									);


FCRA_Ordered := sequential(
										bocashell_41_fcra,									
										CapitalOne_RVAttributes_V3,
										CapitalOne_RVAttributes_V5,
										Experian_RVA_30_XML,
										Experian_RVA_30_BATCH,
										RV_Attributes_V3_XML,						
										RV_Attributes_V3_BATCH,
										RV_Scores_V3_XML,						  												
										RV_Scores_V3_BATCH,										
										RV_Attributes_V4_XML,																	
										RV_Attributes_V4_BATCH,
										RV_Scores_V4_XML,																		
										RV_Scores_V4_BATCH,
										RV_Scores_Attributes_V5_XML,		
										bocashell_50_fcra					  
										
										
										// RV_Scores_Attributes_V5_XML_Prescreen,   //Removed in favor of CapOne RVA v5 prescreen										
										// RV_V3_ENOVA_XML_Scores,      //REMOVED/No Longer Monitoring  7/22/16										
										// Regional_Acceptance_RVA1008_1,      //REMOVED/No Longer Monitoring	  7/22/16									
										// CreditAcceptanceCorp_RV2_BATCH,      //REMOVED/No Longer Monitoring  7/22/16
										// T_Mobile_RVT1212,      //REMOVED/No Longer Monitoring  7/22/16
										// T_Mobile_RVT1210,      //REMOVED/No Longer Monitoring  7/22/16
										// Santander_RVA1304_1,      //REMOVED/No Longer Monitoring  7/22/16
										// Santander_RVA1304_2,      //REMOVED/No Longer Monitoring  7/22/16										
										// RV_Attributes_V2_BATCH,	 //Removed/No Longer Monitoring		
										// CapitalOne_RVAttributes_V2,	//Removed/No Long Monitoring 3/29/17									
										
										
										
										);


// RETURN sequential(NonFCRA_Ordered);
// RETURN sequential(FCRA_Ordered);
RETURN sequential(NonFCRA_Ordered, FCRA_Ordered);
// RETURN sequential(bocashell_41_nonfcra,bocashell_50_nonfcra,bocashell_41_fcra, bocashell_50_fcra);

// Return RV_Scores_Attributes_V5_XML;

END;
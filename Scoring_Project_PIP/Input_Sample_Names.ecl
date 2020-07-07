EXPORT Input_Sample_Names := module

Import ut;

// Scoring QA daily data collection input samples list

//**************FCRA Input Samples Names****************************

///////////////////please keep old file names in case we need to revert back to an old sample/////////////////////////////

// export RV_Attributes_V3_XML_Experian_infile := '~scoring_project::in::riskview_v3_xml_experian_attributes_20141204' ;
// export RV_Attributes_V3_XML_Experian_infile := '~scoring_project::in::riskview_v3_xml_experian_attributes_20160419' ;
// export RV_Attributes_V3_XML_Experian_infile := '~scoring_project::in::riskview_v3_xml_experian_attributes_20161017' ;
// export RV_Attributes_V3_XML_Experian_infile := '~scoring_project::in::riskview_v3_xml_experian_attributes_20180507' ;
export RV_Attributes_V3_XML_Experian_infile := '~scoring_project::in::riskview_v3_xml_experian_attributes_20191029' ;

// export RV_Attributes_V3_BATCH_Experian_infile := '~scoring_project::in::riskview_v3_batch_experian_attributes_20141120' ; 
// export RV_Attributes_V3_BATCH_Experian_infile :=  '~scoring_project::in::riskview_v3_xml_experian_attributes_20160419' ;
// export RV_Attributes_V3_BATCH_Experian_infile := '~scoring_project::in::riskview_v3_xml_experian_attributes_20161017'; 
// export RV_Attributes_V3_BATCH_Experian_infile := '~scoring_project::in::riskview_v3_xml_experian_attributes_20180507'; 
export RV_Attributes_V3_BATCH_Experian_infile := '~scoring_project::in::riskview_v3_xml_experian_attributes_20191029'; 

// export RV_V4_Generic_infile :=  '~scoring_project::in::riskview_xml_generic_version4_20141212';
// export RV_V4_Generic_infile :=  '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20160419';
// export RV_V4_Generic_infile :=  '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20161110';
// export RV_V4_Generic_infile :=  '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20180507';
export RV_V4_Generic_infile :=  '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20191029';

// export RV_V3_Generic_infile :=  '~scoring_project::in::riskview_xml_generic_version3_20141205';
// export RV_V3_Generic_infile :=  '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20160419';
// export RV_V3_Generic_infile :=  '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20161110';
// export RV_V3_Generic_infile :=  '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20180507';
export RV_V3_Generic_infile :=  '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20191029';

export IV_Attributes_infile := '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20160419';

//**************Non FCRA Input Samples Names****************************
EXPORT SOCIO_Monitoring_v5_infile       := '~scoringqa::in::socio_v5';        
//EXPORT SocioEconomic_V5_infile          := '~scoringqa::out::socioeconomic_v5_batch_20190621_1';
// Export Profile_booster_Capone_infile := '~scoring_project::in::Profile_Booster_Capone_20160912';
// Export Profile_booster_Capone_infile    := '~scoring_project::in::Profile_Booster_Capone_20180226';
Export Profile_booster_Capone_infile    := '~scoring_project::in::Profile_Booster_Capone_20191029';

// export BC10_Scores_Chase_BNK4_infile := '~Scoring_Project::in::BC1O_XML_Chase_bnk4_20141110';
// export BC10_Scores_Chase_BNK4_infile := '~scoring_project::in::bc1o_xml_chase_bnk4_20160525';
// export BC10_Scores_Chase_BNK4_infile := '~scoring_project::in::bc1o_xml_chase_bnk4_20161117';
// export BC10_Scores_Chase_BNK4_infile := '~scoring_project::in::bc1o_xml_chase_bnk4_20180507';
export BC10_Scores_Chase_BNK4_infile := '~scoring_project::in::bc1o_xml_chase_bnk4_20191029';

// export PRIO_Scores_Chase_PIO2_infile := '~Scoring_Project::in::PRIO_XML_Chase_pi02_20141031';
// export PRIO_Scores_Chase_PIO2_infile := '~scoring_project::in::prio_xml_chase_pi02_20160520';
// export PRIO_Scores_Chase_PIO2_infile := '~scoring_project::in::prio_xml_chase_pi02_20161206';
// export PRIO_Scores_Chase_PIO2_infile := '~	scoring_project::in::prio_xml_chase_pi02_20180507';
export PRIO_Scores_Chase_PIO2_infile := '~scoring_project::in::prio_xml_chase_pi02_20191029';

// export CBBL_Scores_XML_Chase_infile :='~scoring_project::in::cbbl_xml_chase_20141216';
// export CBBL_Scores_XML_Chase_infile :='~scoring_project::in::cbbl_xml_chase_20160525';//
// export CBBL_Scores_XML_Chase_infile :='~scoring_project::in::cbbl_xml_chase_20170210';
// export CBBL_Scores_XML_Chase_infile :='~scoring_project::in::cbbl_xml_chase_20180507';
export CBBL_Scores_XML_Chase_infile :='~scoring_project::in::cbbl_xml_chase_20191029';

// export ITA_Attributes_V3_BATCH_CapOne_infile := '~Scoring_Project::in::ITA_v3_Batch_CapitalOne_Attributes_20141001';
// export ITA_Attributes_V3_BATCH_CapOne_infile := '~scoring_project::in::ita_v3_batch_capitalone_attributes_20160613';
// export ITA_Attributes_V3_BATCH_CapOne_infile := '~scoring_project::in::ita_v3_batch_capitalone_attributes_20161208';
// export ITA_Attributes_V3_BATCH_CapOne_infile := '~scoring_project::in::ita_v3_batch_capitalone_attributes_20180521';
export ITA_Attributes_V3_BATCH_CapOne_infile := '~scoring_project::in::ita_v3_batch_capitalone_attributes_20191029';

// export LI_Generic_msn1210_1_infile := '~scoring_project::in::leadintegrity_xml_generic_msn1210_1_20141028'; 
// export LI_Generic_msn1210_1_infile := '~scoring_project::in::leadintegrity_xml_generic_msn1210_1_20160519'; 
// export LI_Generic_msn1210_1_infile := '~scoring_project::in::leadintegrity_xml_generic_msn1210_1_20161206'; 
// export LI_Generic_msn1210_1_infile := '~scoring_project::in::leadintegrity_xml_generic_msn1210_1_20180507'; 
export LI_Generic_msn1210_1_infile := '~scoring_project::in::leadintegrity_xml_generic_msn1210_1_20191029'; 

export IT61_Scores_BATCH_Paro_msn605_rsn804_infile := '~scoring_project::in::it61_batch_paro_msn605_rsn804_20141105';

// export BIID_Scores_Batch_Chase_infile := '~scoring_project::in::biid_batch_chase_generic_20150306';  
// export BIID_Scores_Batch_Chase_infile := '~scoring_project::in::biid_batch_chase_generic_20160824'; 
// export BIID_Scores_Batch_Chase_infile := '~scoring_project::in::biid_batch_chase_generic_20170330';
// export BIID_Scores_Batch_Chase_infile := '~scoring_project::in::biid_batch_chase_generic_20180508';
export BIID_Scores_Batch_Chase_infile := '~scoring_project::in::biid_batch_chase_generic_20191029';

// export BIID_Scores_XML_Generic_infile := '~scoring_project::in::biid_xml_general_generic_20150223 ';
// export BIID_Scores_XML_Generic_infile := '~scoring_project::in::biid_xml_general_generic_20160602';//
// export BIID_Scores_XML_Generic_infile := '~scoring_project::in::biid_xml_general_generic_20161213';
// export BIID_Scores_XML_Generic_infile := '~scoring_project::in::biid_xml_general_generic_20180507';
export BIID_Scores_XML_Generic_infile := '~scoring_project::in::biid_xml_general_generic_20191029';

// export BIID_Scores_BATCH_Generic_infile := '~Scoring_Project::in::BIID_Batch_General_Generic_20141219';
// export BIID_Scores_BATCH_Generic_infile := '~scoring_project::in::biid_xml_general_generic_20160602';//
// export BIID_Scores_BATCH_Generic_infile := '~scoring_project::in::biid_xml_general_generic_20161213';
// export BIID_Scores_BATCH_Generic_infile := '~scoring_project::in::biid_xml_general_generic_20180507';
export BIID_Scores_BATCH_Generic_infile := '~scoring_project::in::biid_xml_general_generic_20191029';

export BIIDv2_Scores_XML_Generic_infile := '~scoring_project::in::biid2_xml_20180507_csv';

// export IID_Scores_V0_XML_Generic_infile := '~Scoring_Project::in::InstantID_XML_Generic_Version0_20141001';
// export IID_Scores_V0_XML_Generic_infile := '~scoring_project::in::instantid_xml_generic_version0_20160602';
// export IID_Scores_V0_XML_Generic_infile := '~scoring_project::in::instantid_xml_generic_version0_20161215';
// export IID_Scores_V0_XML_Generic_infile := '~scoring_project::in::instantid_xml_generic_version0_20180507';
export IID_Scores_V0_XML_Generic_infile := '~scoring_project::in::instantid_xml_generic_version0_20191029';

// export IID_Scores_V0_BATCH_Generic_infile := '~scoring_project::in::instantid_batch_generic_version0_20141013';
// export IID_Scores_V0_BATCH_Generic_infile := '~scoring_project::in::instantid_batch_generic_version0_20160527';
// export IID_Scores_V0_BATCH_Generic_infile := '~scoring_project::in::instantid_batch_generic_version0_20170131';
// export IID_Scores_V0_BATCH_Generic_infile := '~scoring_project::in::instantid_xml_generic_version0_20180507';  //made shared sample wiht XML like ALL other samples, saves on time scraping logs
export IID_Scores_V0_BATCH_Generic_infile := '~scoring_project::in::instantid_xml_generic_version0_20191029';  

// export FP_V2_American_Express_FP1109_0_infile    := '~scoring_project::in:fraudpoint_xml_American_Express_fp1109_0_20160729'; 
// export FP_V2_American_Express_FP1109_0_infile    := '~scoring_project::in:fraudpoint_xml_American_Express_fp1109_0_20161206';
// export FP_V2_American_Express_FP1109_0_infile    := '~scoring_project::in:fraudpoint_xml_american_express_fp1109_0_20180507';
export FP_V2_American_Express_FP1109_0_infile    := '~scoring_project::in::fraudpoint_xml_american_express_fp1109_0_20191029';

// export FP_V3_Generic_FP31505_0_infile    := '~Scoring_Project::in::FraudPoint_XML_FP31505_0_20160419';
// export FP_V3_Generic_FP31505_0_infile    := '~Scoring_Project::in::FraudPoint_XML_FP31505_0_20161220'; 
// export FP_V3_Generic_FP31505_0_infile    := '~scoring_project::in::fraudpoint_xml_fp31505_0_20180507'; 
export FP_V3_Generic_FP31505_0_infile    := '~scoring_project::in::fraudpoint_xml_fp31505_0_20191029'; 

// export bocashell_infile_name := '~scoring_project::in::bocashell_v3_v4_v5_input_20140528';
// export bocashell_infile_name := '~scoring_project::in::bocashell_v3_v4_v5_input_20160419';
// export bocashell_infile_name := '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20161110';
// export bocashell_infile_name := '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20180507';
export bocashell_infile_name := '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20191029';


export bocashell_infile_name_prod_copy := '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20180507_Prod_Copy';
// export bocashell_infile_name_prod_copy := '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20161110';

// export AddressShell_Attributes_V1_BATCH_Generic_infile := '~Scoring_Project::in::Address_Shell_Batch_20151022'; 
// export AddressShell_Attributes_V1_BATCH_Generic_infile := '~scoring_project::in::address_shell_batch_20160809'; // added P507 inputs from insurance to file
// export AddressShell_Attributes_V1_BATCH_Generic_infile := '~scoring_project::in::address_shell_batch_20170330';
export AddressShell_Attributes_V1_BATCH_Generic_infile := '~scoring_project::in::address_shell_batch_20180508';

// export BusinessShell_Attributes_V2_XML_Generic_infile := '~scoring_project::in::businessshell_xml_20151204'; // this PII file created by karthik using Bridgett sample, email 
// export BusinessShell_Attributes_V2_XML_Generic_infile := '~scoring_project::in::businessshell_xml_20160825';
export BusinessShell_Attributes_V2_XML_Generic_infile := '~scoring_project::in::businessshell_xml_20180507';

export PhoneShell_Attributes_XML_Generic_infile := '~scoring_project::in::phoneshell_inquirytest_collectionsinternal_w20190501-121441';


/* ********** CORE TESTING SAMPLES **************** */
export ITA_CapitalOne_batch_infile_jan_full_file :=  '~Scoring_Project::in::ITA_v3_Batch_CapitalOne_Attributes_jan_full_file_20150206';
export iid_xml_full := '~Scoring_Project::in::InstantID_XML_Generic_Full_Feb_refresh_20150209';
export chase_BIID_batch_infile_name_new := '~scoring_project::in::biid_batch_chase_generic_20150306';
export BIP_Chase_BIID_infile_name := '~scoring_project::in::biid_batch_chase_bip_feb_flatfile_20150305';
export BIP_BIID_infile_name := '~Scoring_Project::in::BIID_Xml_Full_File_20150223';
export Chase_CBBL_fpscore_only_infile := '~scoring_project::in::cbbl_xml_chase_fp_score_only_infile_20150903';    //ONLY FOR CHASE CBBL SCORE(cmpyaddrscore), CBBL ATTRIBUTES WILL BE WRONG
export Heather_RV_V5_572k_infile := '~scoring_project::in::Heather_RVA_572k';       // Used in Fido Inquiry Build Testing for RVA V4 & V5
export Heather_RV_V5_315k_infile := '~scoring_project::in::Heather_RVA_315k';  			// Used in Fido Inquiry Build Testing for RVA V4 & V5
export phone_shell_core_testing_copy := '~Scoring_Project::in::phoneshell_inquiry_test_internal_w20140218-105428_copy';


/* ********** RETIRED SAMPLES KEEP JUST IN CASE**************** */
// export RV_Attributes_V3_BATCH_CapOne_infile := '~Scoring_Project::in::RiskView_v3_Batch_CapitalOne_Attributes_20141112'; 
// export RV_Attributes_V3_BATCH_CapOne_infile := '~scoring_project::in::riskview_v2_v3_batch_capitalone_attributes_20160419'; 
export RV_Attributes_V3_BATCH_CapOne_infile := '~scoring_project::in::riskview_v2_v3_batch_capitalone_attributes_20161130';//retired 
// export RV_Attributes_V2_BATCH_CapOne_infile := '~Scoring_Project::in::RiskView_v2_Batch_CapitalOne_Attributes_20141112'; 
// export RV_Attributes_V2_BATCH_CapOne_infile := '~scoring_project::in::riskview_v2_v3_batch_capitalone_attributes_20160419'; 
export RV_Attributes_V2_BATCH_CapOne_infile := '~scoring_project::in::riskview_v2_v3_batch_capitalone_attributes_20161130'; //retired
// export RV_Attributes_V2_BATCH_CreditAcceptance_infile := '~Scoring_Project::in::RiskView_v2_Xml_CreditAcceptance_Attributes_20141209';  //switching to runway cert 
export RV_Scores_XML_Tmobile_rvt1212_1_infile:= '~Scoring_Project::in::Riskview_XML_Tmobile_rvt1212_1_20141001';  //switching to runway cert
export RV_Scores_XML_Tmobile_rvt1210_1_infile:= '~Scoring_Project::in::Riskview_XML_Tmobile_rvt1210_1_20141001';  //switching to runway cert
export RV_Scores_XML_Santander_1304_1_infile := '~Scoring_Project::in::RiskView_XML_Santander_1304_1_20141020';  //switching to runway cert
export RV_Scores_XML_Santander_1304_2_infile := '~Scoring_Project::in::RiskView_XML_Santander_1304_2_20141020';  //switching to runway cert
export RV_Scores_V4_XML_ENOVA_infile := '~scoring_project::in::riskview_v4_xml_enova_attributes_20141211' ;  //switching to runway cert
export RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile := '~Scoring_Project::in::Riskview_XML_RegionalAcceptance_rva1008_1_20141001' ;  //switching to runway cert
//do not need to monitor - product says not being used by customer
export ChargeBackDefender_Scores_XML_BestBuy_cdn1109_1_infile := '~Scoring_Project::in::ChargeBackDefender_XML_BestBuy_cdn1109_1_20141001';   
// export FP_V2_Generic_FP1109_0_infile    := '~Scoring_Project::in::FraudPoint_XML_Generic_FP1109_0_20141020'; 
// export FP_V2_Generic_FP1109_0_infile    := '~scoring_project::in::fraudpoint_xml_generic_fp1109_0_20160422'; //retired
export FP_V2_Generic_FP1109_0_infile    := '~scoring_project::in::fraudpoint_xml_generic_fp1109_0_20160422_scoringcopy'; 
export IT60_Scores_Paro_msn605_infile:='~scoring_project::in::it60_batch_paro_msn605_20141106';
export IT61_Scores_XML_Paro_msn605_rsn804_infile:='~scoring_project::in::it61_xml_paro_msn605_rsn804_20141216';
export infile_DHDB := '~scoring_project::in::lien_judgement_change_sample_ins_dhdb';//bs 41, RV v3 & RV v4
export infile_life := '~scoring_project::in::lien_judgement_change_sample_ins_life';  //BS 41 only
 export person_context_test :='~bbraaten::in::person_context_sample_20180625';
export modeling_ph_file := '~scoringqa::in::shell_2_0_testfile_may_july_2018_input.csv'; 
 
end;
EXPORT Data_collection_File_names := module
import ut ;


no_of_recs_to_run := 0;

filetag := '_1'; 

//*****************************************************************FCRA Products File Names List****************************************************************************************************//


Experian_RVA_30_XML_infile_name := '~Scoring_Project::in::RiskView_v3_Xml_Experian_Attributes_20140728' ;
Experian_RVA_30_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Experian_attributes_v3'+ '_' + ut.GetDate  + filetag ;

Experian_RVA_30_BATCH_infile_name := '~scoring_project::in::riskview_v3_batch_experian_attributes_20140710' ; 
Experian_RVA_30_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_Experian_attributes_v3' + '_' + ut.GetDate  + filetag ;

CapitalOne_RVAttributes_V3_infile_name := '~scoring_project::in::riskview_v3_batch_capitalone_attributes_20140709'; 
CapitalOne_RVAttributes_V3_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v3' + '_' + ut.GetDate  + filetag ;

CapitalOne_RVAttributes_V2_infile_name     := '~Scoring_Project::in::RiskView_v2_Batch_CapitalOne_Attributes_20140716'; 
CapitalOne_RVAttributes_V2_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_V2' + '_' + ut.GetDate  + filetag ;

CreditAcceptanceCorp_RV2_BATCH_infile_name := '~scoring_project::in::riskview_v2_xml_creditacceptance_attributes_20140711'; 
CreditAcceptanceCorp_RV2_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_creditacceptancecorp_attributes_v2' + '_' + ut.GetDate  + filetag ;

T_Mobile_RVT1212_infile_name:= '~Scoring_Project::in::Riskview_XML_Tmobile_rvt1212_1_20141001';
T_Mobile_RVT1212_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1212_1_v4'+ '_' + ut.GetDate  + filetag ;

T_Mobile_RVT1210_infile_name:= '~Scoring_Project::in::Riskview_XML_Tmobile_rvt1210_1_20141001';
T_Mobile_RVT1210_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1210_1_v4'+ '_' + ut.GetDate  + filetag ;

Santander_RVA1304_1_infile_name := '~Scoring_Project::in::RiskView_XML_Santander_1304_1_20140414';
Santander_RVA1304_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_1_v3' + '_' + ut.GetDate  + filetag ;

Santander_RVA1304_2_infile_name := '~Scoring_Project::in::RiskView_XML_Santander_1304_2_20140414';
Santander_RVA1304_2_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_2_v3' + '_' + ut.GetDate  + filetag ;

RV_V3_ENOVA_XML_Scores_infile_name := '~scoring_project::in::riskview_v4_xml_enova_attributes_20140718' ;
RV_V3_ENOVA_XML_Scores_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_enova_rvg1103_0_v4' + '_' + ut.GetDate  + filetag ;

RV_Scores_V4_XML_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140805';
RV_Scores_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v4' + '_'  + ut.GetDate  + filetag ;

RV_Scores_V3_XML_infile_name :=  '~scoring_project::in::riskview_xml_generic_version3_20140805';
RV_Scores_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v3'+ '_'  + ut.GetDate  + filetag ;

RV_Attributes_V4_XML_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140805';
RV_Attributes_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v4' + '_' + ut.GetDate  + filetag ;

RV_Attributes_V3_XML_infile_name :=  '~scoring_project::in::riskview_xml_generic_version3_20140805';
RV_Attributes_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v3' + '_' + ut.GetDate  + filetag ;

RV_Attributes_V3_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version3_20140805';
RV_Attributes_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v3' + '_' + ut.GetDate  + filetag ;

RV_Attributes_V4_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140805';
RV_Attributes_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v4' + '_' + ut.GetDate  + filetag ;

RV_Attributes_V2_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140805';
RV_Attributes_V2_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v2' + '_' + ut.GetDate  + filetag ;

RV_Scores_V4_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140805';
RV_Scores_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v4' + '_' + ut.GetDate  + filetag;
   
RV_Scores_V3_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version3_20140805';
RV_Scores_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v3' + '_' + ut.GetDate  + filetag;
    
Regional_Acceptance_RVA1008_1_infile_name := '~Scoring_Project::in::Riskview_XML_RegionalAcceptance_rva1008_1_20141001' ;
Regional_Acceptance_RVA1008_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_RegionalAcceptance_RVA1008_1_v4' + '_' + ut.GetDate  + filetag ;


//*****************************************************************NON FCRA File Names Products List****************************************************************************************************//


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

CapitalOne_batch_infile_name :=  '~Scoring_Project::in::ITA_v3_Batch_CapitalOne_Attributes_20141001';
CapitalOne_batch_outfile_name_new := '~ScoringQA::out::NONFCRA::ITA_batch_CapitalOne_attributes_v3'+ '_'  + ut.GetDate  + filetag ;

bbuy_infile_name := '~Scoring_Project::in::ChargeBackDefender_XML_BestBuy_cdn1109_1_20141001';
bbuy_outFile_Name := '~ScoringQA::out::NONFCRA::ChargebackDefender_xml_BestBuy_CDN1109_1'  + '_' + ut.GetDate  + filetag ;

li_v4_scores_batch_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_scores_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_msn1106_0_v4'+ '_'  + ut.GetDate  + filetag ;

li_v4_attributes_batch_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v4'+ '_'  + ut.GetDate  + filetag ;
li_v4_attributes_batch_outFile_name_test := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v4'+  '_historydate_201207' +'_' + ut.GetDate + filetag   ;

li_v3_attributes_xml_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v3_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v3'+ '_'  + ut.GetDate  + filetag ;

li_v3_attributes_batch_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v3_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v3'+ '_'  + ut.GetDate  + filetag ;

li_v4_scores_xml_infile_name    := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_scores_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_msn1106_0_v4'+ '_' + ut.GetDate  + filetag;

li_v4_attributes_xml_infile_name    := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v4'+ '_'  + ut.GetDate  + filetag ;

chase_BIID_batch_infile_name := '~scoring_project::in::biid_batch_chase_generic_20141016';
chase_BIID_batch_outfile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_Chase'  + '_'  + ut.GetDate + filetag;

Paro_it60_XML_infile_name:='~Scoring_Project::in::IT60_Batch_Paro_Msn605_20140701';
Paro_it60_outfile_name := '~ScoringQA::out::NONFCRA::IT60_xml_paro_Msn605'  + '_' + ut.GetDate  + filetag;

Paro_it60_BATCH_infile_name := '~Scoring_Project::in::IT60_Batch_Paro_Msn605_20140701';
Paro_it60_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::IT60_batch_paro_Msn605'  + '_' + ut.GetDate  + filetag;

Paro_it61_BATCH_infile_name := '~Scoring_Project::in::IT61_Batch_Paro_MSN605_RSN804_20140701';
Paro_it61_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::IT61_batch_paro_MSN605_RSN804'  + '_' + ut.GetDate  + filetag;

Paro_it61_XML_infile_name:='~scoring_project::in::it61_xml_paro_msn605_rsn804_20140730';
Paro_it61_outfile_name := '~ScoringQA::out::NONFCRA::IT61_xml_paro_MSN605_RSN804'  + '_' + ut.GetDate  + filetag;

biid_xml_inFile_name := '~scoring_project::in::biid_xml_general_generic_20140827';
biid_xml_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_xml_generic'  + '_' + ut.GetDate + filetag;

biid_batch_inFile_name := '~scoring_project::in::biid_batch_general_generic_20140722';
biid_batch_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_generic'  + '_' + ut.GetDate + filetag;

iid_xml_infile_name_25000 := '~Scoring_Project::in::InstantID_XML_Generic_Version0_20141001';
iid_xml_outfile_name := '~ScoringQA::out::NONFCRA::instantid_xml_generic'  + '_' + ut.GetDate + filetag;

iid_batch_infile_name_25000 := '~scoring_project::in::instantid_batch_generic_version0_20141013';
iid_batch_outfile_name := '~ScoringQA::out::NONFCRA::instantid_batch_generic'  + '_' + ut.GetDate + filetag;

FP_XML_infile_name    := '~Scoring_Project::in::FraudPoint_XML_Generic_FP1109_0_20140408'; 
FP_XML_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_xml_generic_fp1109_0_v2'+ '_'  + ut.GetDate  + filetag;

FP_BATCH_infile_name := '~Scoring_Project::in::FraudPoint_XML_Generic_FP1109_0_20140408'; 
FP_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_batch_generic_fp1109_0_v2'+ '_' + ut.GetDate + filetag;

end;
EXPORT bwr_fcra_w_params (STRING neutralroxieIP, STRING fcra_roxieIP, INTEGER no_of_threads, INTEGER no_of_recs_to_run, STRING filetag) := FUNCTION

import RiskWise, sghatti, ut,Scoring_Project_Macros, Scoring_Project_PIP;

Timeout := 120;
Retry_time := 3;

Experian_RVA_30_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.Experian_RVA_30_XML_infile_name;  
Experian_RVA_30_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Experian_attributes_v3_' + ut.GetDate + '_' + filetag;

Experian_RVA_30_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.Experian_RVA_30_BATCH_infile_name;  
Experian_RVA_30_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_Experian_attributes_v3_' + ut.GetDate + '_' + filetag;

CapitalOne_RVAttributes_V3_infile_name := Scoring_Project_PIP.Input_Sample_Names.CapitalOne_RVAttributes_V3_infile_name;  
CapitalOne_RVAttributes_V3_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v3_' + ut.GetDate + '_' + filetag;

CapitalOne_RVAttributes_V2_infile_name := Scoring_Project_PIP.Input_Sample_Names.CapitalOne_RVAttributes_V2_infile_name;  
CapitalOne_RVAttributes_V2_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_V2_' + ut.GetDate + '_' + filetag;

CreditAcceptanceCorp_RV2_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.CreditAcceptanceCorp_RV2_BATCH_infile_name;  
CreditAcceptanceCorp_RV2_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_creditacceptancecorp_attributes_v2_' + ut.GetDate + '_' + filetag;

T_Mobile_RVT1212_infile_name := Scoring_Project_PIP.Input_Sample_Names.T_Mobile_RVT1212_infile_name;  
T_Mobile_RVT1212_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1212_1_v4_' + ut.GetDate + '_' + filetag;

T_Mobile_RVT1210_infile_name := Scoring_Project_PIP.Input_Sample_Names.T_Mobile_RVT1210_infile_name;  
T_Mobile_RVT1210_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1210_1_v4_' + ut.GetDate + '_' + filetag;

Santander_RVA1304_1_infile_name := Scoring_Project_PIP.Input_Sample_Names.Santander_RVA1304_1_infile_name;  
Santander_RVA1304_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_1_v3_' + ut.GetDate + '_' + filetag;

Santander_RVA1304_2_infile_name := Scoring_Project_PIP.Input_Sample_Names.Santander_RVA1304_2_infile_name;  
Santander_RVA1304_2_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_2_v3_' + ut.GetDate + '_' + filetag;

RV_V3_ENOVA_XML_Scores_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_V3_ENOVA_XML_Scores_infile_name;  
RV_V3_ENOVA_XML_Scores_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_enova_rvg1103_0_v4_' + ut.GetDate + '_' + filetag;

RV_Scores_V4_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_V4_XML_infile_name;  
RV_Scores_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v4_' + ut.GetDate + '_' + filetag;

RV_Scores_V3_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_V3_XML_infile_name;  
RV_Scores_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_allflagships_v3_' + ut.GetDate + '_' + filetag;

RV_Attributes_V4_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V4_XML_infile_name;  
RV_Attributes_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v4_' + ut.GetDate + '_' + filetag;

RV_Attributes_V3_XML_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V3_XML_infile_name;  
RV_Attributes_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v3_' + ut.GetDate + '_' + filetag;

RV_Attributes_V3_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V3_BATCH_infile_name;  
RV_Attributes_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v3_' + ut.GetDate + '_' + filetag;

RV_Attributes_V4_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V4_BATCH_infile_name;  
RV_Attributes_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v4_' + ut.GetDate + '_' + filetag;

RV_Attributes_V2_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Attributes_V2_BATCH_infile_name;  
RV_Attributes_V2_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v2_' + ut.GetDate + '_' + filetag;

RV_Scores_V4_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_V4_BATCH_infile_name;  
RV_Scores_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v4_' + ut.GetDate + '_' + filetag;

RV_Scores_V3_BATCH_infile_name := Scoring_Project_PIP.Input_Sample_Names.RV_Scores_V3_BATCH_infile_name;  
RV_Scores_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v3_' + ut.GetDate + '_' + filetag;

Regional_Acceptance_RVA1008_1_infile_name := Scoring_Project_PIP.Input_Sample_Names.Regional_Acceptance_RVA1008_1_infile_name;  
Regional_Acceptance_RVA1008_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_RegionalAcceptance_RVA1008_1_v4_' + ut.GetDate + '_' + filetag;

/*
Experian_RVA_30_XML_infile_name := '~Scoring_Project::in::RiskView_v3_Xml_Experian_Attributes_20140728' ;
Experian_RVA_30_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Experian_attributes_v3'+ '_' + ut.GetDate  + filetag ;

Experian_RVA_30_BATCH_infile_name := '~scoring_project::in::riskview_v3_batch_experian_attributes_20140710' ; //renamed & matched to frank I/p sample 9/10/14
Experian_RVA_30_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_Experian_attributes_v3' + '_' + ut.GetDate  + filetag ;

CapitalOne_RVAttributes_V3_infile_name := '~scoring_project::in::riskview_v3_batch_capitalone_attributes_20140709'; //renamed & matched to frank I/p sample 9/10/14
CapitalOne_RVAttributes_V3_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v3' + '_' + ut.GetDate  + filetag ;

CapitalOne_RVAttributes_V2_infile_name     := '~Scoring_Project::in::RiskView_v2_Batch_CapitalOne_Attributes_20140716'; 
CapitalOne_RVAttributes_V2_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_V2' + '_' + ut.GetDate  + filetag ;

CreditAcceptanceCorp_RV2_BATCH_infile_name := '~scoring_project::in::riskview_v2_xml_creditacceptance_attributes_20140711'; //renamed & matched to frank I/p sample 9/10/14
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
*/

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
RV_Attributes_V2_BATCH := Scoring_Project_Macros.RV_Attributes_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V2_BATCH_infile_name,RV_Attributes_V2_BATCH_outfile_name,no_of_recs_to_run);
RV_V3_ENOVA_XML_Scores := Scoring_Project_Macros.RV_Scores_V3_ENOVA_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_ENOVA_XML_Scores_infile_name,RV_V3_ENOVA_XML_Scores_outfile_name,no_of_recs_to_run);
CapitalOne_RVAttributes_V2 := Scoring_Project_Macros.CapitalOne_RVAttributes_V2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CapitalOne_RVAttributes_V2_infile_name,CapitalOne_RVAttributes_V2_outfile_name,no_of_recs_to_run);
CapitalOne_RVAttributes_V3 := Scoring_Project_Macros.CapitalOne_RVAttributes_V3_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CapitalOne_RVAttributes_V3_infile_name,CapitalOne_RVAttributes_V3_outfile_name,no_of_recs_to_run);
CreditAcceptanceCorp_RV2_BATCH := Scoring_Project_Macros.CreditAcceptanceCorp_RV_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CreditAcceptanceCorp_RV2_BATCH_infile_name,CreditAcceptanceCorp_RV2_BATCH_outfile_name,no_of_recs_to_run);
T_Mobile_RVT1212 := Scoring_Project_Macros.T_Mobile_RVT1212_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,T_Mobile_RVT1212_infile_name,T_Mobile_RVT1212_outfile_name,no_of_recs_to_run);
T_Mobile_RVT1210 := Scoring_Project_Macros.T_Mobile_RVT1210_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,T_Mobile_RVT1210_infile_name,T_Mobile_RVT1210_outfile_name,no_of_recs_to_run);
Santander_RVA1304_1 := Scoring_Project_Macros.Santander_RVA1304_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1304_1_infile_name,Santander_RVA1304_1_outfile_name,no_of_recs_to_run);
Santander_RVA1304_2 := Scoring_Project_Macros.Santander_RVA1304_2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1304_2_infile_name,Santander_RVA1304_2_outfile_name,no_of_recs_to_run);

// ***************************************************************************************************************************
RETURN sequential(	
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
										RV_Attributes_V2_BATCH,
										RV_Attributes_V4_XML,
										RV_Attributes_V3_XML,
										RV_Scores_V4_XML,
										RV_Scores_V3_XML
										);
END;
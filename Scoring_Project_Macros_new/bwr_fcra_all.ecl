
EXPORT bwr_fcra_all := FUNCTION

import RiskWise;
import sghatti;
import ut,Scoring_Project_Macros ;

//Here are the URLs to run data collections for testing non-FCRA OSS roxie

// fcra_roxieIP := riskwise.shortcuts.staging_fcra_roxieip ;//staging
// fcra_roxieIP := RiskWise.Shortcuts.prod_batch_fcra; //prod batch
fcra_roxieIP := RiskWise.Shortcuts.Dev196; //prod batch
// fcra_roxieIP := '10.176.68.187:9876'; //prod batch

// neutralroxieIP := RiskWise.shortcuts.QA_neutral_roxieIP;
// neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral;//prod neutral
neutralroxieIP := RiskWise.shortcuts.Dev196;//prod neutral
// neutralroxieIP := '10.176.68.187:9876';//prod neutral

no_of_threads := 3;
Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 25000;

filetag := 'nuestar_baseline'; 
// filetag := 'nuestar_second'; 
// filetag := 'test'; 



CapitalOne_RVAttributes_V3_infile_name := '~nkoubsky::in::capone_rvattributes3_20131122';//file desprayed by nathan
CapitalOne_RVAttributes_V3_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_v3_' + filetag + '_' + ut.GetDate  ;

CapitalOne_RVAttributes_V2_infile_name     := '~nkoubsky::in::capone_rvattributes3_20131122'; 
CapitalOne_RVAttributes_V2_outfile_name := '~ScoringQA::out::FCRA::RiskView_Batch_Capitalone_attributes_V2_' + filetag + '_' + ut.GetDate  ;

CreditAcceptanceCorp_RV2_BATCH_infile_name := '~nkoubsky::in::new_riskview_v2_credacceptcorp_xml_input_20140108_csv'; 
CreditAcceptanceCorp_RV2_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_creditacceptancecorp_attributes_v2_' + filetag + '_' + ut.GetDate  ;



T_Mobile_RVT1212_infile_name:= '~scoring_project::in::riskview_xml_tmobile_rvt1212_1_20140408';
T_Mobile_RVT1212_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1212_1_v4_' + filetag + '_' + ut.GetDate  ;

T_Mobile_RVT1210_infile_name:= '~scoring_project::in::riskview_xml_tmobile_rvt1210_1_20140408';
T_Mobile_RVT1210_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1210_1_v4_' + filetag + '_' + ut.GetDate  ;



Santander_RVA1304_1_infile_name := '~Scoring_Project::in::RiskView_XML_Santander_1304_1_20140414';
Santander_RVA1304_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_1_v3_' + filetag + '_' + ut.GetDate  ;

Santander_RVA1304_2_infile_name := '~Scoring_Project::in::RiskView_XML_Santander_1304_2_20140414';
Santander_RVA1304_2_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Santander_RVA1304_2_v3_' + filetag + '_' + ut.GetDate  ;


RV_V3_ENOVA_XML_Scores_infile_name := '~nkoubsky::in::new_riskview_v2_enovafinancial_xml_input_20140108_csv' ;
RV_V3_ENOVA_XML_Scores_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_enova_rvg1103_0_v4_' + filetag + '_' + ut.GetDate  ;

 
RV_Attributes_V3_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version3_20140528';
RV_Attributes_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v3_' + filetag + '_' +  ut.GetDate  ;


RV_Attributes_V4_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140528';
RV_Attributes_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v4_' + filetag + '_' +  ut.GetDate  ;

RV_Attributes_V2_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140528';
RV_Attributes_V2_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v2_' + filetag + '_' +  ut.GetDate  ;


 RV_Scores_V4_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140528';
   RV_Scores_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v4_' + filetag + '_' +  ut.GetDate  ;
   
   
   RV_Scores_V3_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version3_20140528';
   RV_Scores_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v3_' + filetag + '_' +  ut.GetDate  ;
   
   



Regional_Acceptance_RVA1008_1_infile_name := '~scoring_project::in::riskview_xml_regionalacceptance_rva1008_1_20140301' ;
Regional_Acceptance_RVA1008_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_RegionalAcceptance_RVA1008_1_v4_' + filetag + '_' +  ut.GetDate  ;

Experian_RVA_30_XML_infile_name := '~sghatti::in::Experian_RVA_batch_data' ;
Experian_RVA_30_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Experian_attributes_v3_' + filetag + '_' +  ut.GetDate  ;

Experian_RVA_30_BATCH_infile_name := '~sghatti::in::Experian_RVA_batch_data' ;
Experian_RVA_30_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_Experian_attributes_v3_' + filetag + '_' +  ut.GetDate  ;


RV_Scores_V4_XML_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140528';
RV_Scores_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_generic_allflagships_v4' + filetag + '_' + ut.GetDate  ;

  RV_Scores_V3_XML_infile_name :=  '~scoring_project::in::riskview_xml_generic_version3_20140528';
RV_Scores_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_generic_allflagships_v3' + filetag + '_' +  ut.GetDate  ;

RV_Attributes_V4_XML_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140528';
RV_Attributes_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v4' + filetag + '_' +  ut.GetDate  ;

RV_Attributes_V3_XML_infile_name :=  '~scoring_project::in::riskview_xml_generic_version3_20140528';
RV_Attributes_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v3' + filetag + '_' +  ut.GetDate  ;


RV_Attributes_V4_XML := Scoring_Project_Macros_new.RV_Attributes_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V4_XML_infile_name,RV_Attributes_V4_XML_outfile_name,no_of_recs_to_run);

RV_Attributes_V3_XML := Scoring_Project_Macros_new.RV_Attributes_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_XML_infile_name,RV_Attributes_V3_XML_outfile_name,no_of_recs_to_run);

		 
RV_Scores_V4_XML := Scoring_Project_Macros_new.RV_Scores_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V4_XML_infile_name,RV_Scores_V4_XML_outfile_name,no_of_recs_to_run);

RV_Scores_V3_XML := Scoring_Project_Macros_new.RV_Scores_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V3_XML_infile_name,RV_Scores_V3_XML_outfile_name,no_of_recs_to_run);


Experian_RVA_30_XML := Scoring_Project_Macros_new.Experian_RVA_30_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Experian_RVA_30_XML_infile_name,Experian_RVA_30_XML_outfile_name,no_of_recs_to_run);

Experian_RVA_30_BATCH := Scoring_Project_Macros_new.Experian_RVA_30_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Experian_RVA_30_BATCH_infile_name,Experian_RVA_30_BATCH_outfile_name,no_of_recs_to_run);

Regional_Acceptance_RVA1008_1 := Scoring_Project_Macros_new.Regional_Acceptance_RVA1008_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Regional_Acceptance_RVA1008_1_infile_name,Regional_Acceptance_RVA1008_1_outfile_name,no_of_recs_to_run);


RV_Scores_V4_BATCH := Scoring_Project_Macros_new.RV_Scores_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V4_BATCH_infile_name,RV_Scores_V4_BATCH_outfile_name,no_of_recs_to_run);

RV_Scores_V3_BATCH := Scoring_Project_Macros_new.RV_Scores_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V3_BATCH_infile_name,RV_Scores_V3_BATCH_outfile_name,no_of_recs_to_run);

 
RV_Attributes_V3_BATCH := Scoring_Project_Macros_new.RV_Attributes_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_BATCH_infile_name,RV_Attributes_V3_BATCH_outfile_name,no_of_recs_to_run);

RV_Attributes_V4_BATCH := Scoring_Project_Macros_new.RV_Attributes_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V4_BATCH_infile_name,RV_Attributes_V4_BATCH_outfile_name,no_of_recs_to_run);

RV_Attributes_V2_BATCH := Scoring_Project_Macros_new.RV_Attributes_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V2_BATCH_infile_name,RV_Attributes_V2_BATCH_outfile_name,no_of_recs_to_run);


RV_V3_ENOVA_XML_Scores := Scoring_Project_Macros_new.RV_Scores_V3_ENOVA_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_ENOVA_XML_Scores_infile_name,RV_V3_ENOVA_XML_Scores_outfile_name,no_of_recs_to_run);

CapitalOne_RVAttributes_V2 := Scoring_Project_Macros_new.CapitalOne_RVAttributes_V2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CapitalOne_RVAttributes_V2_infile_name,CapitalOne_RVAttributes_V2_outfile_name,no_of_recs_to_run);

CapitalOne_RVAttributes_V3 := Scoring_Project_Macros_new.CapitalOne_RVAttributes_V3_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CapitalOne_RVAttributes_V3_infile_name,CapitalOne_RVAttributes_V3_outfile_name,no_of_recs_to_run);

CreditAcceptanceCorp_RV2_BATCH := Scoring_Project_Macros_new.CreditAcceptanceCorp_RV_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CreditAcceptanceCorp_RV2_BATCH_infile_name,CreditAcceptanceCorp_RV2_BATCH_outfile_name,no_of_recs_to_run);


T_Mobile_RVT1212 := Scoring_Project_Macros_new.T_Mobile_RVT1212_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,T_Mobile_RVT1212_infile_name,T_Mobile_RVT1212_outfile_name,no_of_recs_to_run);

T_Mobile_RVT1210 := Scoring_Project_Macros_new.T_Mobile_RVT1210_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,T_Mobile_RVT1210_infile_name,T_Mobile_RVT1210_outfile_name,no_of_recs_to_run);


Santander_RVA1304_1 := Scoring_Project_Macros_new.Santander_RVA1304_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1304_1_infile_name,Santander_RVA1304_1_outfile_name,no_of_recs_to_run);

Santander_RVA1304_2 := Scoring_Project_Macros_new.Santander_RVA1304_2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1304_2_infile_name,Santander_RVA1304_2_outfile_name,no_of_recs_to_run);

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
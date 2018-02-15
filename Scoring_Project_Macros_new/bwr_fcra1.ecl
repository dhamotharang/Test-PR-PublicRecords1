
import RiskWise;
import sghatti;
import ut ;

//Here are the URLs to run data collections for testing non-FCRA OSS roxie
// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
// cert128 702 - roxiestaging.sc.seisint.com:9876

// staging_roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// QA_roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 


// cert130_OSS_roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';

// fcra_roxieIP := riskwise.shortcuts.staging_fcra_roxieip ;//staging
// fcra_roxieIP := RiskWise.Shortcuts.prod_batch_fcra; //prod batch
fcra_roxieIP := RiskWise.Shortcuts.Dev196; //prod batch
// neutralroxieIP := RiskWise.shortcuts.QA_neutral_roxieIP;
// neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral;//prod neutral
neutralroxieIP := RiskWise.shortcuts.Dev196;//prod neutral

no_of_threads := 20;

Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 5;

filetag := 'test'; 



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

 

RV_V3_ENOVA_XML_Scores := Scoring_Project_Macros_new.RV_Scores_V3_ENOVA_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_ENOVA_XML_Scores_infile_name,RV_V3_ENOVA_XML_Scores_outfile_name,no_of_recs_to_run);

CapitalOne_RVAttributes_V2 := Scoring_Project_Macros_new.CapitalOne_RVAttributes_V2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CapitalOne_RVAttributes_V2_infile_name,CapitalOne_RVAttributes_V2_outfile_name,no_of_recs_to_run);

CapitalOne_RVAttributes_V3 := Scoring_Project_Macros_new.CapitalOne_RVAttributes_V3_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CapitalOne_RVAttributes_V3_infile_name,CapitalOne_RVAttributes_V3_outfile_name,no_of_recs_to_run);

CreditAcceptanceCorp_RV2_BATCH := Scoring_Project_Macros_new.CreditAcceptanceCorp_RV_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CreditAcceptanceCorp_RV2_BATCH_infile_name,CreditAcceptanceCorp_RV2_BATCH_outfile_name,no_of_recs_to_run);


T_Mobile_RVT1212 := Scoring_Project_Macros_new.T_Mobile_RVT1212_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,T_Mobile_RVT1212_infile_name,T_Mobile_RVT1212_outfile_name,no_of_recs_to_run);

T_Mobile_RVT1210 := Scoring_Project_Macros_new.T_Mobile_RVT1210_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,T_Mobile_RVT1210_infile_name,T_Mobile_RVT1210_outfile_name,no_of_recs_to_run);


Santander_RVA1304_1 := Scoring_Project_Macros_new.Santander_RVA1304_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1304_1_infile_name,Santander_RVA1304_1_outfile_name,no_of_recs_to_run);

Santander_RVA1304_2 := Scoring_Project_Macros_new.Santander_RVA1304_2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1304_2_infile_name,Santander_RVA1304_2_outfile_name,no_of_recs_to_run);


//old format
/* export Santander_3     := sghatti.Santander_RVA1304_1_Cust_Rec;
   export Santander_4     := sghatti.Santander_RVA1304_2_Cust_Rec;
   
   export tmobile_cust_rec_1 := sghatti.T_mobile_Custom_RVS_RVT1210_1_Cust_Rec ;
   export tmobile_cust_rec_2 := sghatti.T_mobile_Custom_RVS_RVT1212_1_Cust_Rec ; 
   
   export rv_x3_new := sghatti.RV_v3_XML_scores_new_input;
   
   export capone_new_v3:= sghatti.CapitalOne_RVAttributes_v3;
   export capone_new_v2:= sghatti.CapitalOne_RVAttributes_v2;
   export creditacceptancecorp:= sghatti.creditacceptancecorp_RV_batch_v2;
   
*/




a:=sequential(RV_V3_ENOVA_XML_Scores,CapitalOne_RVAttributes_V2,CapitalOne_RVAttributes_V3,CreditAcceptanceCorp_RV2_BATCH,T_Mobile_RVT1212,T_Mobile_RVT1210,Santander_RVA1304_1,Santander_RVA1304_2);

a;
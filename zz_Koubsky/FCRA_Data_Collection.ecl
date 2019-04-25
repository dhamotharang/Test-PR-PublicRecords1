EXPORT FCRA_Data_Collection := 'todo';

#workunit('name','FCRA DataCollect AC 4.2');

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
// neutralroxieIP := RiskWise.shortcuts.QA_neutral_roxieIP;
// neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral;//prod neutral

// When Dev196 make the fcraroxieip and neutralroxieip point to 196 roxie
fcra_roxieIP := RiskWise.shortcuts.Dev196 ;//dev196
neutralroxieIP := RiskWise.shortcuts.Dev196 ;//dev196


//**** RUNTIME SETTINGS ******
no_of_threads := 1;
Timeout := 120;
Retry_time := 1;
no_of_recs_to_run := 25000;


//version parameter for bocashell Macro
bs_version := 50;

//***** UNIQUE OUPUT FILE TAG *********
filetag := '196_cleaner_42';  // i.e. vehicles_cert_130


bocashell_50_cert_fcra_infile_name :=  MAP(bs_version = 50 => '~bweiner::in::aetna_4630_50k_sample_in', 
																					 bs_version = 41 => '~scoringqa::in::ge_cap_100302_pii' , '');
bocashell_50_cert_fcra_outfile_name := MAP(bs_version = 50 =>'~scoringqa::out::tracking::bocashell50::cert_bs_50_FCRA_' + filetag + '_'  + ut.GetDate ,
																						bs_version = 41 => '~scoringqa::out::bs_41_tracking_edina_fcra_' + filetag + '_'  + ut.GetDate, '');


CapitalOne_RVAttributes_V3_infile_name := '~nkoubsky::in::capone_rvattributes3_20131122';//file desprayed by nathan
CapitalOne_RVAttributes_V3_outfile_name := '~scoringqa::out::batch_fcra_capone_v3_' + filetag + '_'  + ut.GetDate  ;

CapitalOne_RVAttributes_V2_infile_name     := '~nkoubsky::in::capone_rvattributes3_20131122'; 
CapitalOne_RVAttributes_V2_outfile_name := '~scoringqa::out::batch_fcra_capone_v2_'  + filetag + '_'  + ut.GetDate  ;

CreditAcceptanceCorp_RV2_BATCH_infile_name := '~nkoubsky::in::new_riskview_v2_credacceptcorp_xml_input_20140108_csv'; 
CreditAcceptanceCorp_RV2_BATCH_outfile_name := '~scoringqa::out::creditacceptancecorp_RV_batch_v2_'  + filetag + '_'  + ut.GetDate  ;

RV_Scores_V4_XML_infile_name :=  '~nmontpetit::in::ge_cap_100302_pii';
RV_Scores_V4_XML_outfile_name := '~scoringqa::out::fcra_rvscores_v0_'  + filetag + '_'  + ut.GetDate  ;

RV_Scores_V4_BATCH_infile_name :=  '~nmontpetit::in::ge_cap_100302_pii';
RV_Scores_V4_BATCH_outfile_name := '~scoringqa::out::batch_fcra_rvscores_v4_' + filetag + '_'  + ut.GetDate  ;


RV_Scores_V3_XML_infile_name :=  '~nmontpetit::in::ge_cap_100302_pii';
RV_Scores_V3_XML_outfile_name := '~scoringqa::out::fcra_rvscores_v30_' + filetag + '_'  + ut.GetDate  ;


RV_Scores_V3_BATCH_infile_name :=  '~nmontpetit::in::ge_cap_100302_pii';
RV_Scores_V3_BATCH_outfile_name := '~scoringqa::out::batch_fcra_rvscores_v3_' + filetag + '_'  + ut.GetDate  ;


RV_Attributes_V4_XML_infile_name :=  '~nmontpetit::in::ge_cap_100302_pii';
RV_Attributes_V4_XML_outfile_name := '~scoringqa::out::fcra_rvattributes_v4_' + filetag + '_'  + ut.GetDate  ;

RV_Attributes_V3_XML_infile_name :=  '~nmontpetit::in::ge_cap_100302_pii';
RV_Attributes_V3_XML_outfile_name := '~scoringqa::out::fcra_rvattributes_v30_' + filetag + '_'  + ut.GetDate  ;


RV_Attributes_V3_BATCH_infile_name :=  '~nmontpetit::in::ge_cap_100302_pii';
RV_Attributes_V3_BATCH_outfile_name := '~scoringqa::out::batch_fcra_rvattributes_v3_' + filetag + '_'  + ut.GetDate  ;


RV_Attributes_V4_BATCH_infile_name :=  '~nmontpetit::in::ge_cap_100302_pii';
RV_Attributes_V4_BATCH_outfile_name := '~scoringqa::out::batch_fcra_rvattributes_v4_' + filetag + '_'  + ut.GetDate  ;

RV_Attributes_V2_BATCH_infile_name :=  '~nmontpetit::in::ge_cap_100302_pii';
RV_Attributes_V2_BATCH_outfile_name := '~scoringqa::out::batch_fcra_rvattributes_v2_' + filetag + '_'  + ut.GetDate  ;

T_Mobile_RVT1212_infile_name:= '~sghatti::in::T_mobile_RVT1212_1_Cust_Rec_data';
T_Mobile_RVT1212_outfile_name := '~scoringqa::out::T_mobile_RVT1212_1_Cust_Rec_'+ filetag + '_'  + ut.GetDate  ;

T_Mobile_RVT1210_infile_name:= '~sghatti::in::t_mobile_rvt1210_1_cust_rec_data';
T_Mobile_RVT1210_outfile_name := '~scoringqa::out::T_mobile_RVT1210_1_Cust_Rec_'+ filetag + '_'  + ut.GetDate  ;

Santander_RVA1007_1_infile_name := '~sghatti::in::Santander_RVA1007_1_Cust_Rec_data';
Santander_RVA1007_1_outfile_name := '~scoringqa::out::Santander_RVA1007_1_' + filetag + '_'  + ut.GetDate  ;

Santander_RVA1007_2_infile_name := '~sghatti::in::Santander_RVA1007_1_Cust_Rec_data';
Santander_RVA1007_2_outfile_name := '~scoringqa::out::Santander_RVA1007_2_Cust_Rec_' + filetag + '_'  + ut.GetDate  ;

Santander_RVA1304_1_infile_name := '~sghatti::in::Santander_RVA1007_1_Cust_Rec_data';
Santander_RVA1304_1_outfile_name := '~scoringqa::out::Santander_RVA1304_1_' + filetag + '_'  + ut.GetDate  ;

Santander_RVA1304_2_infile_name := '~sghatti::in::Santander_RVA1007_1_Cust_Rec_data';
Santander_RVA1304_2_outfile_name := '~scoringqa::out::Santander_RVA1304_2_Cust_Rec_' + filetag + '_'  + ut.GetDate  ;

Regional_Acceptance_RVA1008_1_infile_name := 'sghatti::in::Regional_Acceptance_RVA1008_1' ;
Regional_Acceptance_RVA1008_1_outfile_name := '~scoringqa::out::Regional_Acceptance_RVA1008_1_'  + filetag + '_'  + ut.GetDate  ;

Experian_RVA_30_XML_infile_name := '~sghatti::in::Experian_RVA_batch_data' ;
Experian_RVA_30_XML_outfile_name := '~scoringqa::out::fcra_Experian_RVA_30_Cust_Rec_'  + filetag + '_'  + ut.GetDate  ;

Experian_RVA_30_BATCH_infile_name := '~sghatti::in::Experian_RVA_batch_data' ;
Experian_RVA_30_BATCH_outfile_name := '~scoringqa::out::fcra_Experian_RVA_30_batch_Cust_Rec_'  + filetag + '_'  + ut.GetDate  ;

RV_V3_ENOVA_XML_Scores_infile_name := '~nkoubsky::in::new_riskview_v2_enovafinancial_xml_input_20140108_csv' ;
RV_V3_ENOVA_XML_Scores_outfile_name := '~scoringqa::out::fcra_rvscores_v4_newinput_' + filetag + '_' + ut.GetDate  ;


bocashell_cert_fcra := Scoring_Project_Macros.BocaShell_50_FCRA_cert_MACRO( bs_version, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_50_cert_fcra_infile_name,bocashell_50_cert_fcra_outfile_name,no_of_recs_to_run);
// bocashell_cert_fcra;

RV_V3_ENOVA_XML_Scores := Scoring_Project_Macros.RV_Scores_V3_ENOVA_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_ENOVA_XML_Scores_infile_name,RV_V3_ENOVA_XML_Scores_outfile_name,no_of_recs_to_run);

Experian_RVA_30_XML := Scoring_Project_Macros.Experian_RVA_30_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Experian_RVA_30_XML_infile_name,Experian_RVA_30_XML_outfile_name,no_of_recs_to_run);

Experian_RVA_30_BATCH := Scoring_Project_Macros.Experian_RVA_30_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Experian_RVA_30_BATCH_infile_name,Experian_RVA_30_BATCH_outfile_name,no_of_recs_to_run);

Regional_Acceptance_RVA1008_1 := Scoring_Project_Macros.Regional_Acceptance_RVA1008_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Regional_Acceptance_RVA1008_1_infile_name,Regional_Acceptance_RVA1008_1_outfile_name,no_of_recs_to_run);

CapitalOne_RVAttributes_V2 := Scoring_Project_Macros.CapitalOne_RVAttributes_V2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CapitalOne_RVAttributes_V2_infile_name,CapitalOne_RVAttributes_V2_outfile_name,no_of_recs_to_run);

CapitalOne_RVAttributes_V3 := Scoring_Project_Macros.CapitalOne_RVAttributes_V3_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CapitalOne_RVAttributes_V3_infile_name,CapitalOne_RVAttributes_V3_outfile_name,no_of_recs_to_run);

CreditAcceptanceCorp_RV2_BATCH := Scoring_Project_Macros.CreditAcceptanceCorp_RV_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,CreditAcceptanceCorp_RV2_BATCH_infile_name,CreditAcceptanceCorp_RV2_BATCH_outfile_name,no_of_recs_to_run);

RV_Scores_V4_XML := Scoring_Project_Macros.RV_Scores_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V4_XML_infile_name,RV_Scores_V4_XML_outfile_name,no_of_recs_to_run);

RV_Scores_V3_XML := Scoring_Project_Macros.RV_Scores_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V3_XML_infile_name,RV_Scores_V3_XML_outfile_name,no_of_recs_to_run);

RV_Scores_V4_BATCH := Scoring_Project_Macros.RV_Scores_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V4_BATCH_infile_name,RV_Scores_V4_BATCH_outfile_name,no_of_recs_to_run);

RV_Scores_V3_BATCH := Scoring_Project_Macros.RV_Scores_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V3_BATCH_infile_name,RV_Scores_V3_BATCH_outfile_name,no_of_recs_to_run);

RV_Attributes_V4_XML := Scoring_Project_Macros.RV_Attributes_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V4_XML_infile_name,RV_Attributes_V4_XML_outfile_name,no_of_recs_to_run);

RV_Attributes_V3_XML := Scoring_Project_Macros.RV_Attributes_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_XML_infile_name,RV_Attributes_V3_XML_outfile_name,no_of_recs_to_run);

RV_Attributes_V3_BATCH := Scoring_Project_Macros.RV_Attributes_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_BATCH_infile_name,RV_Attributes_V3_BATCH_outfile_name,no_of_recs_to_run);

RV_Attributes_V4_BATCH := Scoring_Project_Macros.RV_Attributes_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V4_BATCH_infile_name,RV_Attributes_V4_BATCH_outfile_name,no_of_recs_to_run);

RV_Attributes_V2_BATCH := Scoring_Project_Macros.RV_Attributes_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V2_BATCH_infile_name,RV_Attributes_V2_BATCH_outfile_name,no_of_recs_to_run);

T_Mobile_RVT1212 := Scoring_Project_Macros.T_Mobile_RVT1212_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,T_Mobile_RVT1212_infile_name,T_Mobile_RVT1212_outfile_name,no_of_recs_to_run);

T_Mobile_RVT1210 := Scoring_Project_Macros.T_Mobile_RVT1210_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,T_Mobile_RVT1210_infile_name,T_Mobile_RVT1210_outfile_name,no_of_recs_to_run);

Santander_RVA1007_1 := Scoring_Project_Macros.Santander_RVA1007_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1007_1_infile_name,Santander_RVA1007_1_outfile_name,no_of_recs_to_run);

Santander_RVA1007_2 := Scoring_Project_Macros.Santander_RVA1007_2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1007_2_infile_name,Santander_RVA1007_2_outfile_name,no_of_recs_to_run);

Santander_RVA1304_1 := Scoring_Project_Macros.Santander_RVA1304_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1304_1_infile_name,Santander_RVA1304_1_outfile_name,no_of_recs_to_run);

Santander_RVA1304_2 := Scoring_Project_Macros.Santander_RVA1304_2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Santander_RVA1304_2_infile_name,Santander_RVA1304_2_outfile_name,no_of_recs_to_run);




// EXPORT BWR_to_run_FCRA_Macros :=
 Sequential(bocashell_cert_fcra, Santander_RVA1304_2, Santander_RVA1304_1, Santander_RVA1007_2, Santander_RVA1007_1, T_Mobile_RVT1210, T_Mobile_RVT1212,
RV_Attributes_V2_BATCH, RV_Attributes_V4_BATCH, RV_Attributes_V3_BATCH, RV_Attributes_V3_XML, RV_Attributes_V4_XML,
RV_Scores_V3_BATCH, RV_Scores_V4_BATCH, RV_Scores_V3_XML, RV_Scores_V4_XML,
CapitalOne_RVAttributes_V2, CapitalOne_RVAttributes_V3, CreditAcceptanceCorp_RV2_BATCH, Regional_Acceptance_RVA1008_1, RV_V3_ENOVA_XML_Scores,
Experian_RVA_30_XML, Experian_RVA_30_BATCH): 
 FAILURE(FileServices.SendEmail( 'nathan.koubsky@lexisnexis.com','FCRA DataCollection Macros failed','The failed workunit is:' + workunit + FailMessage));
// : WHEN(CRON('30 3 * * *')), 
 // FAILURE(FileServices.SendEmail( 'suman.burjukindi@lexisnexis.com','FCRA DataCollection Macros failed','The failed workunit is:' + workunit + FailMessage));

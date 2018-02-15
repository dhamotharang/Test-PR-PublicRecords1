
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
no_of_threads := 30;
Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 10000;


//version parameter for bocashell Macro
bs_version := 50;

//***** UNIQUE OUPUT FILE TAG *********
filetag := 'test';  // i.e. vehicles_cert_130


bocashell_50_cert_fcra_infile_name :=  MAP(bs_version = 50 => '~bweiner::in::aetna_4630_50k_sample_in', 
																					 bs_version = 41 => '~scoringqa::in::ge_cap_100302_pii' , '');
bocashell_50_cert_fcra_outfile_name := MAP(bs_version = 50 =>'~scoringqa::out::tracking::bocashell50::cert_bs_50_FCRA_NO_EDINA_' + filetag + '_'  + ut.GetDate ,
																						bs_version = 41 => '~scoringqa::out::bs_41_tracking_edina_fcra_NO_EDINA_' + filetag + '_'  + ut.GetDate, '');


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


T_Mobile_RVT1212_infile_name:= '~scoring_project::in::riskview_xml_tmobile_rvt1212_1_20140408';
T_Mobile_RVT1212_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_T_mobile_RVT1212_1_v4'+ '_' + ut.GetDate  + filetag ;

T_Mobile_RVT1210_infile_name:= '~Scoring_Project::in::RiskView_XML_TMobile_rvt121020140725';
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
   
   
Regional_Acceptance_RVA1008_1_infile_name := '~scoring_project::in::riskview_xml_regionalacceptance_rva1008_1_20140301' ;
Regional_Acceptance_RVA1008_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_RegionalAcceptance_RVA1008_1_v4' + '_' + ut.GetDate  + filetag ;



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
 Sequential(Santander_RVA1304_2, Santander_RVA1304_1, Santander_RVA1007_2, Santander_RVA1007_1, T_Mobile_RVT1210, T_Mobile_RVT1212,
RV_Attributes_V2_BATCH, RV_Attributes_V4_BATCH, RV_Attributes_V3_BATCH, RV_Attributes_V3_XML, RV_Attributes_V4_XML,
RV_Scores_V3_BATCH, RV_Scores_V4_BATCH, RV_Scores_V3_XML, RV_Scores_V4_XML,
CapitalOne_RVAttributes_V2, CapitalOne_RVAttributes_V3, CreditAcceptanceCorp_RV2_BATCH, Regional_Acceptance_RVA1008_1, RV_V3_ENOVA_XML_Scores,
Experian_RVA_30_XML, Experian_RVA_30_BATCH) ;
// : WHEN(CRON('30 3 * * *')), 
 // FAILURE(FileServices.SendEmail( 'suman.burjukindi@lexisnexis.com','FCRA DataCollection Macros failed','The failed workunit is:' + workunit + FailMessage));

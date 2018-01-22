//Riskview Attributes v3, v4, v5 and experian;
// no longer monitoring 7/12 oked by product
// tmobile
// regional acceptance
// santander
// credit acceptance 
// enova
//run on 50way

import RiskWise,Scoring_Project_Macros;
import sghatti;
import ut, scoring_project_pip ;

//Here are the URLs to run data collections for testing non-FCRA OSS roxie
// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
// cert128 702 - roxiestaging.sc.seisint.com:9876

// staging_roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// QA_roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 


// cert130_OSS_roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';

fcra_roxieIP := riskwise.shortcuts.staging_fcra_roxieip ;//staging
// fcra_roxieIP := RiskWise.Shortcuts.prod_batch_fcra; //prod batch
neutralroxieIP := RiskWise.shortcuts.QA_neutral_roxieIP;
// neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral;//prod neutral

no_of_threads := 1;

Timeout := 15;
Retry_time := 3;
no_of_recs_to_run := 0;
no_of_recs_to_run_IV := 500;

filetag := ut.GetDate  +'_1'; 

message:=output('Daily_Data_Collection_FCRA_Macro_1_jobs_failed');

RV_V4_Generic_infile :=  scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;


RV_Attributes_V4_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_BATCH_Generic_outfile + filetag ;
RV_Attributes_V4_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_XML_Generic_outfile + filetag ;

//********************************

RV_V3_Generic_infile:=  scoring_project_pip.Input_Sample_Names.RV_V3_Generic_infile;

RV_Attributes_V3_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_XML_Generic_outfile + filetag ;
RV_Attributes_V3_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_Generic_outfile + filetag ;
     
//********************************
// no longer monitoring 7/12 oked by product		 
// RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile := zz_bbraaten2.test_input_samples.RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile;
// RV_Scores_XML_RegionalAcceptance_RVA1008_1_outfile :=scoring_project_pip.Output_Sample_Names.RV_Scores_XML_RegionalAcceptance_RVA1008_1_outfile + filetag ;

//********************************

RV_Scores_Attributes_V5_XMl_Generic_infile :=    scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;
RV_Scores_Attributes_V5_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile + filetag ;
// RV_Scores_Attributes_V5_XML_Generic_prescreen_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_prescreen_outfile + filetag ;  //has been replaced with RV v5 capone batch prescreen sample in Macro #2

RV_Attributes_V3_XML_Experian_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_XML_Experian_infile;
RV_Attributes_V3_XML_Experian_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_XML_Experian_outfile + filetag ;

RV_Attributes_V3_BATCH_Experian_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_XML_Experian_infile;
RV_Attributes_V3_BATCH_Experian_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_Experian_outfile + filetag ;

IV_Attributes_infile := scoring_project_pip.Input_Sample_Names.IV_Attributes_infile;
IV_Attributes_outfile := scoring_project_pip.Output_Sample_Names.IV_Attributes_outfile + filetag ;

//********************************
Experian_RVA_30_XML := scoring_project_pip.Experian_RVA_30_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_XML_Experian_infile,RV_Attributes_V3_XML_Experian_outfile,no_of_recs_to_run):RECOVERY(message,10);
Experian_RVA_30_BATCH := scoring_project_pip.Experian_RVA_30_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_BATCH_Experian_infile,RV_Attributes_V3_BATCH_Experian_outfile,no_of_recs_to_run):RECOVERY(message,10);

 
RV_Attributes_V4_XML := scoring_project_pip.RV_Attributes_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V4_Generic_infile,RV_Attributes_V4_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
RV_Attributes_V4_BATCH := scoring_project_pip.RV_Attributes_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V4_Generic_infile,RV_Attributes_V4_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);

RV_Attributes_V3_XML := scoring_project_pip.RV_Attributes_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_Generic_infile,RV_Attributes_V3_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
RV_Attributes_V3_BATCH := scoring_project_pip.RV_Attributes_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_Generic_infile,RV_Attributes_V3_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);

IV_Attributes := scoring_project_pip.insurview_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,IV_Attributes_infile,IV_Attributes_outfile,no_of_recs_to_run_IV):RECOVERY(message,10);

// no longer monitoring 7/12 oked by product
// Regional_Acceptance_RVA1008_1 := scoring_project_pip.Regional_Acceptance_RVA1008_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile,RV_Scores_XML_RegionalAcceptance_RVA1008_1_outfile,no_of_recs_to_run):RECOVERY(message,10);

// no longer monitoring 7/12 oked by product
// RV_Attributes_V2_BATCH := scoring_project_pip.RV_Attributes_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V4_Generic_infile,RV_Attributes_V2_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);

RV_Scores_Attributes_V5_XML := Scoring_Project_PIP.RV_Scores_Attributes_V5_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_Attributes_V5_XMl_Generic_infile,RV_Scores_Attributes_V5_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
// RV_Scores_Attributes_V5_XML_Prescreen := Scoring_Project_PIP.RV_Scores_Attributes_V5_XML_Prescreen_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_Attributes_V5_XMl_Generic_infile,RV_Scores_Attributes_V5_XML_Generic_prescreen_outfile,no_of_recs_to_run):RECOVERY(message,10);  //has been replaced with RV v5 capone batch prescreen sample in Macro #2

sequential(Experian_RVA_30_XML,Experian_RVA_30_BATCH,RV_Attributes_V4_XML,RV_Attributes_V4_BATCH,RV_Attributes_V3_XML,
RV_Attributes_V3_BATCH,RV_Scores_Attributes_V5_XML,IV_Attributes);

/*  old macro call, updated on 7/17/2016
import RiskWise,Scoring_Project_Macros;
import sghatti;
import ut ;

//Here are the URLs to run data collections for testing non-FCRA OSS roxie
// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
// cert128 702 - roxiestaging.sc.seisint.com:9876

// staging_roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// QA_roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 


// cert130_OSS_roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';

fcra_roxieIP := riskwise.shortcuts.staging_fcra_roxieip ;//staging
// fcra_roxieIP := RiskWise.Shortcuts.prod_batch_fcra; //prod batch
neutralroxieIP := RiskWise.shortcuts.QA_neutral_roxieIP;
// neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral;//prod neutral

no_of_threads := 15;

Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 0;

filetag := ut.GetDate  +'_1'; 

message:=output('Daily_Data_Collection_FCRA_Macro_1_jobs_failed');

RV_Attributes_V3_XML_Experian_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_XML_Experian_infile;
RV_Attributes_V3_XML_Experian_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_XML_Experian_outfile + filetag ;

RV_Attributes_V3_BATCH_Experian_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_BATCH_Experian_infile;
RV_Attributes_V3_BATCH_Experian_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_Experian_outfile + filetag ;

RV_Attributes_V3_BATCH_CapOne_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_BATCH_CapOne_infile;
RV_Attributes_V3_BATCH_CapOne_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_CapOne_outfile + filetag ;

RV_Attributes_V2_BATCH_CapOne_infile     := scoring_project_pip.Input_Sample_Names.RV_Attributes_V2_BATCH_CapOne_infile;
RV_Attributes_V2_BATCH_CapOne_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V2_BATCH_CapOne_outfile + filetag ;


RV_Attributes_V2_BATCH_CreditAcceptance_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V2_BATCH_CreditAcceptance_infile;
RV_Attributes_V2_BATCH_CreditAcceptance_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V2_BATCH_CreditAcceptance_outfile + filetag ;

RV_Scores_XML_Tmobile_rvt1212_1_infile:= scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Tmobile_rvt1212_1_infile;
RV_Scores_XML_Tmobile_rvt1212_1_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_XML_Tmobile_rvt1212_1_outfile + filetag ;

RV_Scores_XML_Tmobile_rvt1210_1_infile:= scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Tmobile_rvt1210_1_infile;
RV_Scores_XML_Tmobile_rvt1210_1_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_XML_Tmobile_rvt1210_1_outfile + filetag ;

RV_Scores_XML_Santander_1304_1_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Santander_1304_1_infile;
RV_Scores_XML_Santander_1304_1_outfile :=scoring_project_pip.Output_Sample_Names.RV_Scores_XML_Santander_1304_1_outfile + filetag ;

RV_Scores_XML_Santander_1304_2_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_Santander_1304_2_infile;
RV_Scores_XML_Santander_1304_2_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_XML_Santander_1304_2_outfile + filetag ;

RV_Scores_V4_XML_ENOVA_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_V4_XML_ENOVA_infile;
RV_Scores_V4_XML_ENOVA_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V4_XML_ENOVA_outfile + filetag ;

//********************************

Experian_RVA_30_XML := scoring_project_pip.Experian_RVA_30_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_XML_Experian_infile,RV_Attributes_V3_XML_Experian_outfile,no_of_recs_to_run):RECOVERY(message,10);

Experian_RVA_30_BATCH := scoring_project_pip.Experian_RVA_30_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_BATCH_Experian_infile,RV_Attributes_V3_BATCH_Experian_outfile,no_of_recs_to_run):RECOVERY(message,10);

RV_V3_ENOVA_XML_Scores := scoring_project_pip.RV_Scores_V3_ENOVA_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V4_XML_ENOVA_infile,RV_Scores_V4_XML_ENOVA_outfile,no_of_recs_to_run):RECOVERY(message,10);

CapitalOne_RVAttributes_V2 := scoring_project_pip.CapitalOne_RVAttributes_V2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V2_BATCH_CapOne_infile,RV_Attributes_V2_BATCH_CapOne_outfile,no_of_recs_to_run):RECOVERY(message,10);

CapitalOne_RVAttributes_V3 := scoring_project_pip.CapitalOne_RVAttributes_V3_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_BATCH_CapOne_infile,RV_Attributes_V3_BATCH_CapOne_outfile,no_of_recs_to_run):RECOVERY(message,10);

CreditAcceptanceCorp_RV2_BATCH := scoring_project_pip.CreditAcceptanceCorp_RV_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V2_BATCH_CreditAcceptance_infile,RV_Attributes_V2_BATCH_CreditAcceptance_outfile,no_of_recs_to_run):RECOVERY(message,10);

T_Mobile_RVT1212 := scoring_project_pip.T_Mobile_RVT1212_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_XML_Tmobile_rvt1212_1_infile,RV_Scores_XML_Tmobile_rvt1212_1_outfile,no_of_recs_to_run):RECOVERY(message,10);

T_Mobile_RVT1210 := scoring_project_pip.T_Mobile_RVT1210_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_XML_Tmobile_rvt1210_1_infile,RV_Scores_XML_Tmobile_rvt1210_1_outfile,no_of_recs_to_run):RECOVERY(message,10);

Santander_RVA1304_1 := scoring_project_pip.Santander_RVA1304_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_XML_Santander_1304_1_infile,RV_Scores_XML_Santander_1304_1_outfile,no_of_recs_to_run):RECOVERY(message,10);

Santander_RVA1304_2 := scoring_project_pip.Santander_RVA1304_2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_XML_Santander_1304_2_infile,RV_Scores_XML_Santander_1304_2_outfile,no_of_recs_to_run):RECOVERY(message,10);


sequential(RV_V3_ENOVA_XML_Scores,T_Mobile_RVT1212,T_Mobile_RVT1210,Santander_RVA1304_1,Santander_RVA1304_2,
              CapitalOne_RVAttributes_V2,CapitalOne_RVAttributes_V3,CreditAcceptanceCorp_RV2_BATCH,Experian_RVA_30_XML,Experian_RVA_30_BATCH
							);
*/
EXPORT FCRA_macro1_call := 'todo';
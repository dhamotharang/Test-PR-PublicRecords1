
//Rv scores v3, v4 and capone (v5 scores in macro 1);
// no longer monitoring 7/12 oked by product
// tmobile
// regional acceptance
// santander
// credit acceptance 
// enova

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

filetag := ut.GetDate  +'_1'; 

message:=output('Daily_Data_Collection_FCRA_Macro_2_jobs_failed');

RV_V4_Generic_infile :=  scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;


RV_Scores_V4_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V4_XML_Generic_outfile + filetag ;
RV_Scores_V4_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V4_BATCH_Generic_outfile + filetag ;   
// RV_Attributes_V2_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V2_BATCH_Generic_outfile + filetag ;  // no longer monitoring 7/12 oked by product
 
//********************************

RV_V3_Generic_infile:=  scoring_project_pip.Input_Sample_Names.RV_V3_Generic_infile;

RV_Scores_V3_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V3_XML_Generic_outfile + filetag ;
RV_Scores_V3_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V3_BATCH_Generic_outfile + filetag ;
     
//********************************
		 
//********************************

RV_Attributes_V2_BATCH_CapOne_infile     := scoring_project_pip.Input_Sample_Names.RV_Attributes_V2_BATCH_CapOne_infile;
RV_Attributes_V2_BATCH_CapOne_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V2_BATCH_CapOne_outfile + filetag ;

RV_Attributes_V3_BATCH_CapOne_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V3_BATCH_CapOne_infile;
RV_Attributes_V3_BATCH_CapOne_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_CapOne_outfile + filetag ;

RV_Attributes_V5_BATCH_CapOne_infile := scoring_project_pip.Input_Sample_Names.RV_Attributes_V2_BATCH_CapOne_infile;
RV_Attributes_V5_BATCH_CapOne_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V5_BATCH_CapOne_outfile + filetag ;

//********************************

RV_Scores_V4_XML := scoring_project_pip.RV_Scores_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V4_Generic_infile,RV_Scores_V4_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
RV_Scores_V4_BATCH := scoring_project_pip.RV_Scores_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V4_Generic_infile,RV_Scores_V4_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);

RV_Scores_V3_XML := scoring_project_pip.RV_Scores_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_Generic_infile,RV_Scores_V3_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
RV_Scores_V3_BATCH := scoring_project_pip.RV_Scores_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_Generic_infile,RV_Scores_V3_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);

CapitalOne_RVAttributes_V2 := scoring_project_pip.CapitalOne_RVAttributes_V2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V2_BATCH_CapOne_infile,RV_Attributes_V2_BATCH_CapOne_outfile,no_of_recs_to_run):RECOVERY(message,10);
CapitalOne_RVAttributes_V3 := scoring_project_pip.CapitalOne_RVAttributes_V3_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_BATCH_CapOne_infile,RV_Attributes_V3_BATCH_CapOne_outfile,no_of_recs_to_run):RECOVERY(message,10);
CapitalOne_RVAttributes_V5 := scoring_project_pip.CapitalOne_RVAttributes_V5_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V5_BATCH_CapOne_infile,RV_Attributes_V5_BATCH_CapOne_outfile,no_of_recs_to_run):RECOVERY(message,10);


// no longer monitoring 7/12 oked by product
// Regional_Acceptance_RVA1008_1 := scoring_project_pip.Regional_Acceptance_RVA1008_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile,RV_Scores_XML_RegionalAcceptance_RVA1008_1_outfile,no_of_recs_to_run):RECOVERY(message,10);

// no longer monitoring 7/12 oked by product
// RV_Attributes_V2_BATCH := scoring_project_pip.RV_Attributes_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V4_Generic_infile,RV_Attributes_V2_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);

sequential(RV_Scores_V4_XML,RV_Scores_V4_BATCH,RV_Scores_V3_XML,RV_Scores_V3_BATCH,CapitalOne_RVAttributes_V3,CapitalOne_RVAttributes_V2,CapitalOne_RVAttributes_V5);


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

no_of_threads := 20;

Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 0;

filetag := ut.GetDate  +'_1'; 

message:=output('Daily_Data_Collection_FCRA_Macro_2_jobs_failed');

RV_V4_Generic_infile :=  scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;


RV_Scores_V4_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V4_XML_Generic_outfile + filetag ;
RV_Attributes_V4_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_BATCH_Generic_outfile + filetag ;
RV_Scores_V4_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V4_BATCH_Generic_outfile + filetag ;   
RV_Attributes_V4_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_XML_Generic_outfile + filetag ;
RV_Attributes_V2_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V2_BATCH_Generic_outfile + filetag ;

//********************************

RV_V3_Generic_infile:=  scoring_project_pip.Input_Sample_Names.RV_V3_Generic_infile;

RV_Scores_V3_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V3_XML_Generic_outfile + filetag ;
RV_Attributes_V3_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_XML_Generic_outfile + filetag ;
RV_Attributes_V3_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_BATCH_Generic_outfile + filetag ;
RV_Scores_V3_BATCH_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_V3_BATCH_Generic_outfile + filetag ;
     
//********************************
		 
RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile := scoring_project_pip.Input_Sample_Names.RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile;
RV_Scores_XML_RegionalAcceptance_RVA1008_1_outfile :=scoring_project_pip.Output_Sample_Names.RV_Scores_XML_RegionalAcceptance_RVA1008_1_outfile + filetag ;

//********************************

RV_Scores_Attributes_V5_XMl_Generic_infile :=  scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;
RV_Scores_Attributes_V5_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile + filetag ;
RV_Scores_Attributes_V5_XML_Generic_prescreen_outfile := scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_prescreen_outfile + filetag ;

//********************************

RV_Scores_V4_XML := scoring_project_pip.RV_Scores_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V4_Generic_infile,RV_Scores_V4_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
RV_Scores_V4_BATCH := scoring_project_pip.RV_Scores_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V4_Generic_infile,RV_Scores_V4_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);

RV_Scores_V3_XML := scoring_project_pip.RV_Scores_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_Generic_infile,RV_Scores_V3_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
RV_Scores_V3_BATCH := scoring_project_pip.RV_Scores_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_Generic_infile,RV_Scores_V3_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);

RV_Attributes_V4_XML := scoring_project_pip.RV_Attributes_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V4_Generic_infile,RV_Attributes_V4_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
RV_Attributes_V4_BATCH := scoring_project_pip.RV_Attributes_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V4_Generic_infile,RV_Attributes_V4_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);

RV_Attributes_V3_XML := scoring_project_pip.RV_Attributes_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_Generic_infile,RV_Attributes_V3_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
RV_Attributes_V3_BATCH := scoring_project_pip.RV_Attributes_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V3_Generic_infile,RV_Attributes_V3_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);

Regional_Acceptance_RVA1008_1 := scoring_project_pip.Regional_Acceptance_RVA1008_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_XML_RegionalAcceptance_RVA1008_1_infile,RV_Scores_XML_RegionalAcceptance_RVA1008_1_outfile,no_of_recs_to_run):RECOVERY(message,10);

RV_Attributes_V2_BATCH := scoring_project_pip.RV_Attributes_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_V4_Generic_infile,RV_Attributes_V2_BATCH_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);

RV_Scores_Attributes_V5_XML := Scoring_Project_PIP.RV_Scores_Attributes_V5_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_Attributes_V5_XMl_Generic_infile,RV_Scores_Attributes_V5_XML_Generic_outfile,no_of_recs_to_run):RECOVERY(message,10);
RV_Scores_Attributes_V5_XML_Prescreen := Scoring_Project_PIP.RV_Scores_Attributes_V5_XML_Prescreen_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_Attributes_V5_XMl_Generic_infile,RV_Scores_Attributes_V5_XML_Generic_prescreen_outfile,no_of_recs_to_run):RECOVERY(message,10);

sequential(RV_Scores_V4_XML,RV_Scores_V4_BATCH,RV_Scores_V3_XML,RV_Scores_V3_BATCH,Regional_Acceptance_RVA1008_1,
		           RV_Attributes_V4_XML,RV_Attributes_V4_BATCH,RV_Attributes_V3_XML,RV_Attributes_V3_BATCH,RV_Attributes_V2_BATCH,
							 RV_Scores_Attributes_V5_XML,RV_Scores_Attributes_V5_XML_Prescreen);
		 
		 
*/
EXPORT FCRA_macro2_call := 'todo';
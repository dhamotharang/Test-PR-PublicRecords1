// EXPORT bwr_CapOne_ITA_30_DataCollection := 'todo';

#workunit('name','nonFCRA_2 DataCollect AC 4.2');

import sghatti ;

//Here are the URLs to run data collections for testing non-FCRA OSS roxie
// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
// cert128 702 - roxiestaging.sc.seisint.com:9876

//******** Uncomment roxie to run ************
roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 
// roxieIP := RiskWise.shortcuts.Dev196 ;//dev196
// roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';  // OSS VIP


//**** RUNTIME SETTINGS ******
gateway_ip := '';
no_of_threads := 1;
Timeout := 120;
Retry_time := 1;
no_of_recs_to_run := 100;
//***** UNIQUE OUPUT FILE TAG *********
filetag := 'CapOne_ITA_test';  // i.e. vehicles_cert_130

// Input / Output file names
CapitalOne_batch_infile_name :=  '~Scoring_Project::in::ITA_v3_Batch_CapitalOne_Attributes_20140625';
CapitalOne_batch_outfile_name := '~scoringqa::out::nonfcra_ita_capitalone_batch_v30_' +  filetag + '_'  + ut.GetDate  ;


//*********************************************************************************************
//  Commands to call the Macro.  Should not need modification
// (ROXIE_IP,Gateway, Threads, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun)
//*********************************************************************************************

CapitalOne_batch := zz_Koubsky.macro_CapOne_ITA_30_Batch(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,CapitalOne_batch_infile_name,CapitalOne_batch_outfile_name,no_of_recs_to_run);
CapitalOne_batch;

EXPORT bwr_itabatch_old_Nuestar := FUNCTION

IMPORT sghatti, RiskWise, ut, Scoring_Project_Macros; 


//******** Uncomment roxie to run ************
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876';
roxieIP := RiskWise.shortcuts.Dev196;  
// roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';  // OSS VIP

//**** RUNTIME SETTINGS ******
gateway_ip := '';
no_of_threads := 3;
Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 25000;
//***** UNIQUE OUPUT FILE TAG *********
filetag := 'nuestar_baseline';  // i.e. vehicles_cert_130
// filetag := 'nuestar_second';  // i.e. vehicles_cert_130
// filetag := 'test';  // i.e. vehicles_cert_130

CapitalOne_batch_infile_name :=  '~nkoubsky::in::capone_ita3batch_20131126';
CapitalOne_batch_outfile_name := '~ScoringQA::out::NONFCRA::ITA_batch_CapitalOne_attributes_v3_' + filetag + '_' + ut.GetDate  ;

CapitalOne_batch_ITA:= Scoring_Project_Macros_new.CapitalOne_ITA_V3_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,CapitalOne_batch_infile_name,CapitalOne_batch_outfile_name,no_of_recs_to_run);

RETURN CapitalOne_batch_ITA;

END;
﻿#workunit('name','Bocashell_Collections');
IMPORT  Scoring_Project_Macros, RiskWise, UT, Scoring_Project_DailyTracking;

//Here are the URLs to run data collections for testing non-FCRA OSS roxie
// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
// cert128 702 - roxiestaging.sc.seisint.com:9876

//******** Uncomment roxie to run ************
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 
// roxieIP := RiskWise.shortcuts.prod_batch_neutral;
neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral;
fcra_roxieIP := RiskWise.shortcuts.prod_batch_fcra;


//**** RUNTIME SETTINGS ******
gateway_ip := '';
no_of_threads := 30; //set to 1 if on a 50 way, 30 if on a 1 way
Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 0;
archive_date := 201207;
bs_version_41 := 41;
bs_version_50 := 50;
//***** UNIQUE OUPUT FILE TAG *********
filetag := '_1';  

//***FILE IN***///
bocashell_file_in := '~scoring_project::in::bocashell_v3_v4_v5_input_20140528';


//**********OUTPUT FILE NAMES**************//
bocashell_41_nonfcra_file_out := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_prod_' + ut.getdate + filetag;
bocashell_41_nonfcra_file_out_HD := '~scoringqa::out::nonfcra::bocashell_41_historydate_201207_prod_' + ut.getdate + filetag;

bocashell_41_fcra_file_out := '~scoringqa::out::fcra::bocashell_41_historydate_999999_prod_' + ut.getdate + filetag;
bocashell_41_fcra_file_out_HD := '~scoringqa::out::fcra::bocashell_41_historydate_201207_prod_' + ut.getdate + filetag;

bocashell_50_nonfcra_file_out := '~scoringqa::out::nonfcra::bocashell_50_historydate_999999_prod_' + ut.getdate + filetag;
bocashell_50_nonfcra_file_out_HD := '~scoringqa::out::nonfcra::bocashell_50_historydate_201207_prod_' + ut.getdate + filetag;

bocashell_50_fcra_file_out := '~scoringqa::out::fcra::bocashell_50_historydate_999999_prod_' + ut.getdate + filetag;
bocashell_50_fcra_file_out_HD := '~scoringqa::out::fcra::bocashell_50_historydate_201207_prod_' + ut.getdate + filetag;


//**********CALLING MACROS FOR 41*************//
Bocashell_41_nonfcra_999999 := Scoring_Project_Macros.BocaShell_41_nonFCRA_cert_MACRO( bs_version_41, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_file_in,bocashell_41_nonfcra_file_out,no_of_recs_to_run);
Bocashell_41_nonfcra_201207 := Scoring_Project_Macros.BocaShell_41_nonFCRA_cert_MACRO( bs_version_41, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_file_in,bocashell_41_nonfcra_file_out_HD,no_of_recs_to_run, archive_date);

Bocashell_41_fcra_999999 := Scoring_Project_Macros.BocaShell_41_FCRA_cert_MACRO( bs_version_41, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_file_in,bocashell_41_fcra_file_out,no_of_recs_to_run);
Bocashell_41_fcra_201207 := Scoring_Project_Macros.BocaShell_41_FCRA_cert_MACRO( bs_version_41, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_file_in,bocashell_41_fcra_file_out_HD,no_of_recs_to_run, archive_date);


//**********CALLING MACROS FOR 50*************//
Bocashell_50_nonfcra_999999 := Scoring_Project_Macros.BocaShell_50_nonFCRA_cert_MACRO( bs_version_50, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_file_in,bocashell_50_nonfcra_file_out,no_of_recs_to_run);
Bocashell_50_nonfcra_201207 := Scoring_Project_Macros.BocaShell_50_nonFCRA_cert_MACRO( bs_version_50, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_file_in,bocashell_50_nonfcra_file_out_HD,no_of_recs_to_run, archive_date);

Bocashell_50_fcra_999999 := Scoring_Project_Macros.BocaShell_50_FCRA_cert_MACRO( bs_version_50, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_file_in,bocashell_50_fcra_file_out,no_of_recs_to_run);
Bocashell_50_fcra_201207 := Scoring_Project_Macros.BocaShell_50_FCRA_cert_MACRO( bs_version_50, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_file_in,bocashell_50_fcra_file_out_HD,no_of_recs_to_run, archive_date);


Nonfcra_41 := sequential(Bocashell_41_nonfcra_999999, Bocashell_41_nonfcra_201207);
Fcra_41 := sequential(Bocashell_41_fcra_999999, Bocashell_41_fcra_201207);
Nonfcra_50 := sequential(Bocashell_50_nonfcra_999999, Bocashell_50_nonfcra_201207);
Fcra_50 := sequential(Bocashell_50_fcra_999999, Bocashell_50_fcra_201207);

//Run nonfcra sequentially and fcra sequentially in parallel
parallel(Nonfcra_41, Nonfcra_50, Fcra_41, Fcra_50)
			: WHEN(CRON('30 9 * * *')), //4:30 am
			FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list,'Prod Bocashell collections job failed.','The failed workunit is: ' + workunit + FailMessage))
			;
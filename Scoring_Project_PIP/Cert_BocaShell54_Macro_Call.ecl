//BocaShell54 Daily Tracking Report Data Collection - scheduled for daily run

#workunit('name','Cert_Bocashell54_Collections');
IMPORT  Scoring_Project_Macros, RiskWise, std, UT, Scoring_Project_DailyTracking, scoring_project_pip, zz_bbraaten2;

//Here are the URLs to run data collections for testing non-FCRA OSS roxie
// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
// cert128 702 - roxiestaging.sc.seisint.com:9876

//******** Uncomment roxie to run ************
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 
// roxieIP := RiskWise.shortcuts.prod_batch_neutral;
neutralroxieIP := RiskWise.shortcuts.staging_neutral_roxieIP;
fcra_roxieIP := RiskWise.shortcuts.staging_fcra_roxieIP;


//**** RUNTIME SETTINGS ******
gateway_ip := '';
no_of_threads := 2; //set to 1 if on a 50 way, 30 if on a 1 way
Timeout := 25;
Retry_time := 3;
no_of_recs_to_run := 0;
archive_date := 201207;
bs_version_54 := 54;

//***** UNIQUE OUPUT FILE TAG *********
filetag := '_1'; 

//***FILE IN***///
bocashell_file_in := '~scoring_project::in::riskview_xml_generic_v3_v4_v5_20161110';  //need to change macros from csv to flat before kick off.

// bocashell_file_in := '~scoring_project::in::bocashell_v3_v4_v5_input_20160419';  
// bocashell_file_in := '~scoring_project::in::bocashell_v3_v4_v5_input_20160517';


//**********OUTPUT FILE NAMES**************//
//bocashell_54_nonfcra
//2/14/2020
//replaced (STRING8)Std.Date.Today() with ut.getdate

bocashell_54_nonfcra_file_out := '~scoringqa::out::nonfcra::bocashell_54_historydate_999999_cert_' + ut.getdate + filetag;
bocashell_54_nonfcra_file_out_HD := '~scoringqa::out::nonfcra::bocashell_54_historydate_201207_cert_' + ut.getdate + filetag;

//bocashell_54_fcra
bocashell_54_fcra_file_out := '~scoringqa::out::fcra::bocashell_54_historydate_999999_cert_' + ut.getdate + filetag;
bocashell_54_fcra_file_out_HD := '~scoringqa::out::fcra::bocashell_54_historydate_201207_cert_' + ut.getdate + filetag;

//macros for 54
Bocashell_54_nonfcra_999999 := Scoring_Project_PIP.BocaShell_54_nonFCRA_cert_MACRO( bs_version_54, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_file_in,bocashell_54_nonfcra_file_out,no_of_recs_to_run);
Bocashell_54_nonfcra_201207 := Scoring_Project_PIP.BocaShell_54_nonFCRA_cert_MACRO( bs_version_54, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_file_in,bocashell_54_nonfcra_file_out_HD,no_of_recs_to_run, archive_date);

Bocashell_54_fcra_999999 := Scoring_Project_PIP.BocaShell_54_FCRA_cert_MACRO( bs_version_54, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_file_in,bocashell_54_fcra_file_out,no_of_recs_to_run);
Bocashell_54_fcra_201207 := Scoring_Project_PIP.BocaShell_54_FCRA_cert_MACRO( bs_version_54, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_file_in,bocashell_54_fcra_file_out_HD,no_of_recs_to_run, archive_date);


//nonfcra_54 and fcra_54
Nonfcra_54 := sequential(Bocashell_54_nonfcra_999999, Bocashell_54_nonfcra_201207);
Fcra_54 := sequential(Bocashell_54_fcra_999999,Bocashell_54_fcra_201207);

data_collection := parallel(Nonfcra_54, Fcra_54);

//Run Collections in parallel
sequential(data_collection)

			 : WHEN(CRON('00 8 * * *')), //3:00 am Eastern
			FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list,'Test Cert Bocashell collections job failed.','The failed workunit is: ' + workunit + FailMessage));
		

EXPORT Cert_BocaShell54_Macro_Call := 'todo';
import Scoring_Project_Macros;

STRING nonFCRA_roxieIP := RiskWise.shortcuts.Dev196;
// STRING nonFCRA_roxieIP := RiskWise.shortcuts.core_roxieIP;
// STRING nonFCRA_roxieIP := RiskWise.shortcuts.prod_batch_neutral;
STRING FCRA_roxieIP := RiskWise.shortcuts.Dev196;
// STRING FCRA_roxieIP := RiskWise.shortcuts.core_roxieIP;
INTEGER no_of_threads := 40;
INTEGER no_of_recs_to_run := 25000;

STRING filetag := 'Nuestar_baseline';
// STRING filetag := 'Nuestar_baseline_test';
// STRING filetag := 'BIP_baseline_test';
// STRING filetag := 'core_smoke_test';

#workunit('name', 'HIGH PRIORITY - ' + filetag);

nonfcra_datacollection := Scoring_Project_Macros.bwr_nonfcra_w_params(nonFCRA_roxieIP, '', no_of_threads, no_of_recs_to_run, filetag);
fcra_datacollection := Scoring_Project_Macros.bwr_fcra_w_params(nonFCRA_roxieIP, FCRA_roxieIP, no_of_threads, no_of_recs_to_run, filetag);
bocashell_datacollection := Scoring_Project_Macros.BWR_BocaShell_w_params(nonFCRA_roxieIP, FCRA_roxieIP, no_of_threads, no_of_recs_to_run, filetag);
// phoneshell := zz_Koubsky.bwr_phone_shell;

// nonfcra_datacollection
// fcra_datacollection
// bocashell_datacollection

Sequential(nonfcra_datacollection, fcra_datacollection, bocashell_datacollection): 
// Sequential(nonfcra_datacollection, fcra_datacollection, bocashell_datacollection, phoneshell): 
								// WHEN(CRON('15 4 * * *')), //run at 12:15 AM EST
								FAILURE(FileServices.SendEmail('nathan.koubsky@lexisnexis.com','Nuestar Data collection job failed','The failed workunit is: ' + WORKUNIT + '; ' + FAILMESSAGE));
// #workunit('name', 'HIGH PRIORITY - Nuestar Baseline');
#workunit('name', 'HIGH PRIORITY - Nuestar Testrun');

import Scoring_Project_Macros, RiskWise;

(roxieIP, gateway_ip, no_of_recs_to_run, filetag)
fcra_roxieIP := RiskWise.Shortcuts.Dev196;
roxieIP := RiskWise.Shortcuts.Dev196;
no_of_recs_to_run := 20000;
filetag := 'nuestar_baseline'; 
// filetag := 'nuestar_second';

nonfcra_datacollection := Scoring_Macros_Dev196.bwr_nonfcra_all(roxieIP, gateway_ip, no_of_recs_to_run, filetag);
fcra_datacollection := Scoring_Macros_Dev196.bwr_fcra_all(fcra_roxieIP, roxieIP, no_of_recs_to_run, filetag);
bocashell_datacollection := Scoring_Macros_Dev196.BWR_to_run_BocaShell_Macros(fcra_roxieIP, roxieIP, no_of_recs_to_run, filetag);
phoneshell := Scoring_Macros_Dev196.bwr_phone_shell(roxieIP, gateway_ip, no_of_recs_to_run, filetag);

Sequential(bocashell_datacollection, fcra_datacollection, nonfcra_datacollection, phoneshell): 
// bocashell_datacollection: 
// nonfcra_datacollection: 
// Sequential(nonfcra_datacollection, fcra_datacollection, phoneshell): 
// parallel(bocashell_datacollection, nonfcra_datacollection, fcra_datacollection): 
								// WHEN(CRON('15 4 * * *')), //run at 12:15 AM EST
								FAILURE(FileServices.SendEmail('nathan.koubsky@lexisnexis.com','Nuestar Data collection job failed','The failed workunit is: ' + WORKUNIT + '; ' + FAILMESSAGE));
// bocashell_datacollection;
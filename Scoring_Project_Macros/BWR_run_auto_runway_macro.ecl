#workunit('name','Runway Macro');
import Risk_Indicators, ut, Scoring_Project_Macros, Riskwise;

// Test settings
unsigned8 records_ToRun := 0;
integer Retry := 3;
integer Timeout := 120;
integer Thread := 30; //set to 1 if on a 50way, 30 if on a 1way
integer bs_version := 41;
filetag := '_1'; 

String neutralroxie_IP := RiskWise.shortcuts.staging_neutral_roxieIP; 
String roxieIP := Riskwise.shortcuts.staging_fcra_roxieIP ;

auto_runway := Scoring_Project_Macros.Runway_Main_Macro_Auto( bs_version, roxieIP, neutralroxie_IP, Thread, Timeout, Retry, records_ToRun);

auto_runway
	:  WHEN(CRON('30 13 * * *')), //8:30 am
	FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list,'Runway stats job failed.','The failed workunit is:' + workunit + FailMessage))
	;
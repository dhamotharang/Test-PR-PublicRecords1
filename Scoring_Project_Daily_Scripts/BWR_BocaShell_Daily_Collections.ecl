#workunit('name', 'BocaShell_Daily_Collections');
#WORKUNIT('priority','high');  

IMPORT  Scoring_Project_Macros, RiskWise, UT, Scoring_Project_DailyTracking, scoring_project_pip;
Scoring_Project_PIP.Cert_BocaShell_Macro_Call: WHEN(CRON('05 5 * * *')), //4:30 am
			FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list,'Test Cert Bocashell collections job failed.','The failed workunit is: ' + workunit + FailMessage));
		


// EXPORT BWR_BocaShell_Daily_Collections := 'todo';
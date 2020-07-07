#WORKUNIT('name', 'BocaShell_54_Daily_Collections');
#WORKUNIT('priority','high');  

IMPORT  Scoring_Project_Macros, RiskWise, std, UT, Scoring_Project_DailyTracking, scoring_project_pip;
Scoring_Project_PIP.Cert_BocaShell54_Macro_Call: WHEN(CRON('30 5 * * *')), //12:30 am Eastern
			FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list,'Test Cert Bocashell collections job failed.','The failed workunit is: ' + workunit + FailMessage));
		

// EXPORT BWR_BocaShell_54_Daily_Collections := 'todo';
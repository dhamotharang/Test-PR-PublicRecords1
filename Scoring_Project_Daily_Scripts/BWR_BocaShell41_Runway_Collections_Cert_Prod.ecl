#workunit('name','Bocashell_Runway Collections');
IMPORT  Scoring_Project_Macros, RiskWise, UT, Scoring_Project_DailyTracking, scoring_project_pip, zz_bbraaten2;
Prod_runway := Scoring_Project_Macros.Runway_Macro_Report_Generation;
Cert_runway := Scoring_Project_Macros.Cert_Runway_Macro;

sequential(Prod_runway, Cert_runway): WHEN(CRON('00 16 * * *')), //4:30 am
			FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list,'Runway Macros Failed','The failed workunit is: ' + workunit + FailMessage));
		


// EXPORT BWR_BocaShell41_Runway_Collections_Cert_Prod := 'todo';
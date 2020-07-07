#WORKUNIT('name','Prod_BocaShell_54_Tracking_Reports');
import std,ut, Scoring_Project_DailyTracking;

// Prod_Report_41 := Scoring_Project_DailyTracking.BocaShell_41_Prod_Tracking_DailyReport;
// Prod_Report_50 := Scoring_Project_DailyTracking.BocaShell_50_Prod_Tracking_DailyReport;
Prod_Report_54 := Scoring_Project_DailyTracking.BocaShell_54_Prod_Tracking_DailyReport;


//Run nonfcra sequentially and fcra sequentially in parallel
//sequential(Prod_Report_41,Prod_Report_50)
Prod_Report_54 //;
			: WHEN(CRON('00 30 * * *')), //7:30 pm Eastern
			FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list,'Prod Bocashell collections job failed.','The failed workunit is: ' + workunit + FailMessage))
			;


// EXPORT BWR_Prod_BocaShell_54_Tracking_Reports := 'todo';
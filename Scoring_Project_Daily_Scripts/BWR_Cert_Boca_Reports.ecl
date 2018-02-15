// EXPORT BWR_Cert_Boca_Reports := 'todo';

cert_report_41:=Scoring_Project_DailyTracking.BocaShell_41_Cert_Tracking_DailyReport;

cert_report_50:=Scoring_Project_DailyTracking.BocaShell_50_Cert_Tracking_DailyReport;
Boca41FCRA_Macro := Scoring_Project_Macros.Run_Boca41FCRA_Macro;
Boca41NonFCRA_Macro:= Scoring_Project_Macros.Run_Boca41NonFCRA_Macro;

sequential(cert_report_41, cert_report_50, Boca41FCRA_Macro, Boca41NonFCRA_Macro) : WHEN(CRON('00 14 * * *')), //4:30 am
			FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list,'Test Cert Bocashell collections job failed.','The failed workunit is: ' + workunit + FailMessage));
		

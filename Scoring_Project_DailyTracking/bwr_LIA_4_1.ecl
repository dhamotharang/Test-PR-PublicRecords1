#workunit('name','LIA 4.1 Daily Tracking Report');

Scoring_Project_DailyTracking.LeadIntegrity_v41_DailyReport 
									// :WHEN(CRON('0 11 * * *')) //run at 6:00 AM CST  
									// FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list,'LIA4 CRON job failed','The failed workunit is:' + WORKUNIT + FAILMESSAGE));
									;
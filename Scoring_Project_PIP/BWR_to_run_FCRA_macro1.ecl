
#workunit('name', 'Daily Data Collection FCRA Macro#1');


Scoring_Project_PIP.FCRA_macro1_call :  WHEN(CRON('05 4 * * *')), 
FAILURE(FileServices.SendEmail( Scoring_Project_DailyTracking.email_distribution.Daily_Data_collections_fail_list,'Daily Data Collection FCRA Macro#1 jobs failed','The failed workunit is:' + workunit + FailMessage));

#workunit('name', 'Daily Data Collection NONFCRA Macro#3');

Scoring_Project_PIP.NONFCRA_macro3_call :  WHEN(CRON('05 4 * * *')), 
FAILURE(FileServices.SendEmail( Scoring_Project_DailyTracking.email_distribution.Daily_Data_collections_fail_list,'Daily Data Collection NONFCRA Macro#3 jobs failed','The failed workunit is:' + workunit + FailMessage));




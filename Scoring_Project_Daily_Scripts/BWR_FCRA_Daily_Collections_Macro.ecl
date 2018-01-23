#workunit('name', 'Daily Data Collection FCRA Macro');
#WORKUNIT('priority','high');  

Scoring_Project_PIP.New_FCRA_Macro_Call :  WHEN(CRON('05 5 * * *')), 
FAILURE(FileServices.SendEmail( Scoring_Project_DailyTracking.email_distribution.Daily_Data_collections_fail_list,'Daily Data Collection FCRA Macro failed','The failed workunit is:' + workunit + FailMessage));



// EXPORT BWR_FCRA_Daily_Collections_Macro := 'todo';

#workunit('name', 'Daily Data Collection Capone Prod');
#WORKUNIT('priority','high');  

Scoring_Project_PIP.Prod_Capone_Macro_Call: WHEN(CRON('05 8 * * *')), 
FAILURE(FileServices.SendEmail( Scoring_Project_DailyTracking.email_distribution.Daily_Data_collections_fail_list,'Daily Data Collection Prod Failed','The failed workunit is:' + workunit + FailMessage));


// EXPORT BWR_Prod_Capone_Daily_Collections := 'todo';
#workunit('name', 'Daily Data Collection NONFCRA Macro#4');
#WORKUNIT('priority','high');  

Scoring_Project_PIP.NONFCRA_macro4_call :  WHEN(CRON('35 8 * * *')), 
FAILURE(FileServices.SendEmail( Scoring_Project_DailyTracking.email_distribution.Daily_Data_collections_fail_list,'Daily Data Collection NONFCRA Macro#4 jobs failed','The failed workunit is:' + workunit + FailMessage));



// EXPORT BWR_NonFCRA_Daily_Collections_Macro4 := 'todo';
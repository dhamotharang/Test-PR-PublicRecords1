#workunit('name','Address Shell Business Shell Collections');
IMPORT  Scoring_Project_Macros, RiskWise, UT, Scoring_Project_DailyTracking, scoring_project_pip, zz_bbraaten2;

Scoring_Project_PIP.BusinessShell_AddressShell_Collections_Macro_Call:   WHEN(CRON('00 6 * * *')), 
FAILURE(FileServices.SendEmail( Scoring_Project_DailyTracking.email_distribution.DDT_fail_list,'Daily Data Collection Addressshell & BusinessShell job failed','The failed workunit is:' + workunit + FailMessage));



// EXPORT BWR_Address_Business_Collections := 'todo';
#workunit('name', 'Daily Data Tracking Report');

// date deployed = <blank> if previous day, 'all' for all data, else a date can be input.  Note that a dataset will not return if it has been redeployed on a subsequent date

// Scoring_Project_DailyTracking.DDT_DailyReport('all');
// Scoring_Project_DailyTracking.DDT_DailyReport('');

Scoring_Project_DailyTracking.DDT_DailyReport('', Scoring_Project_DailyTracking.email_distribution.DDT_general_list): WHEN(CRON('15 4 * * *')); //run at 12:15 AM EST ;
// Scoring_Project_DailyTracking.DDT_DailyReport('', 'nathan.koubsky@lexisnexis.com');
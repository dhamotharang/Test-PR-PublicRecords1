Import STD, lib_stringlib, History_Analysis, wk_ut, dops,ut;

pVersion := stringlib.getDateYYYYMMDD();
output(pVersion, named('workunit_version'));

#workunit('name', 'Prod History Report ');

todays_date := (string)Std.Date.today():global;

tomorrows_date := (string)Std.Date.AdjustDate((integer)todays_date,0,0,1):global;

yesterdays_date := (string)Std.Date.AdjustDate((integer)todays_date,0,0,-1):global;

//This call will build all of the required files including spraying, delta calculations and statistics 
//////////////////////////////////////// processing dops daily input to a file in memory ////////////////////////////////////////////////
//////////////////////////////////programmer must specify what range for desired data (up to 10 days at a time) /////////////////////////
////// Attention! Before running this report please make sure you are specifying the desired range for the Dops service ///////
// datasetname = dataset name from dops
// location = 'B' for boca or 'A' for alpharetta or '' or '*'
// cluster = 'N' for nonfcra or 'F' for fcra or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
// fromdate - format 'YYYYMMDD' (start date)
// todate - format 'YYYYMMDD' (end date)
// dopsenv = 'dev' or 'prod'; dev - points to dev or prod DOPS DB

History_Analysis.Proc_Build_All(pVersion, '*', 'B', 'set for nonfcra and fcra (process_dops.ecl)', yesterdays_date, tomorrows_date, 'prod');

//History_Analysis.CreateStandaloneReports.StandaloneProdReport(pVersion,'*', 'B','set for nonfcra and fcra (process_dops.ecl)', 'enteradate', 'enteradate', 'prod');

//History_Analysis.CreateStandaloneReports.StandaloneQAReport(pVersion,'*', 'B','set for nonfcra and fcra (process_dops.ecl)', 'enteradate', 'enteradate', 'prod');
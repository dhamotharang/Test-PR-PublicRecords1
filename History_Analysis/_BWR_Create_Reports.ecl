Import STD, lib_stringlib, History_Analysis;

pVersion := stringlib.getDateYYYYMMDD();
output(pVersion, Named('workunit_version'));

#workunit('name', 'Dops History Report ');

//This call will build all of the required files including spraying, delta calculations and statistics 
//////////////////////////////////////// processing dops daily input to a file in memory ////////////////////////////////////////////////
//////////////////////////////////programmer must specify what range for desired data (up to 10 days at a time) /////////////////////////
////// Attention! Before running this report please make sure you are specifying the desired range for the Dops service ///////
// datasetname = dataset name from dops
// location = 'B' for boca or 'A' for alpharetta or '' or '*'
// cluster = 'N' for nonfcra or 'F' for fcra or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
// environment = 'Q' for qa or 'P' for prod; this variable represents data in prod or qa roxie
// start date of ten day range
// end date of ten day range
// dopsenv = 'dev' or 'prod'; dev - points to dev or prod DOPS DB
History_Analysis.Proc_Build_All(pVersion, '*', 'B','N','P', '20201101', '20201102', 'prod');

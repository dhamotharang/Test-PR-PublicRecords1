// --------------------------------------------------------------------------------
// BWR_Spray_Scrambled_Foreclosures
// This is for initial scrambled data or for regular data from Nancy's Spreadsheet
// --------------------------------------------------------------------------------
/* ********************************************************************************************
spray Foreclosure data file after it has been scrambled into HPCC files for further processing.
*********************************************************************************************** */

IMPORT ut, PRTE2_Foreclosure, PRTE2_Common;
#workunit('name', 'Spray PRCT Foreclosure File Scrambled');
#OPTION('multiplePersistInstances',FALSE);

STRING fileVersion := ut.GetDate;
CSVName := 'Foreclosures_Alpha_Prod_20150213.csv';

BuildFile := PRTE2_Foreclosure.Fn_Spray_ALPHA_Spreadsheet( CSVName, fileVersion );

SEQUENTIAL (BuildFile);

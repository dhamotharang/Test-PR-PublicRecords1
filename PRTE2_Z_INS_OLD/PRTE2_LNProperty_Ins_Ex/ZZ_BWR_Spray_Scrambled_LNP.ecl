// --------------------------------------------------------------------------------
//  BWR_Spray_Gateway_LNP 
// This is for initial scrambled data or for regular data from Nancy's Spreadsheet
// --------------------------------------------------------------------------------
/* **********************************************************************************
Simply spray the Gateway generated data file into HPCC files for further processing.
********************************************************************************** */

IMPORT ut, PRTE2_LNProperty, PRTE2_Common;
#workunit('name', 'Spray PRCT LNProperty Scrambled');

STRING fileVersion := ut.GetDate+'';
CSVName := 'LNProperty_Scrambled_20140725.csv';

BuildFile := PRTE2_LNProperty.Fn_Spray_Scrambled_Spreadsheet( CSVName, fileVersion );

SEQUENTIAL (BuildFile);

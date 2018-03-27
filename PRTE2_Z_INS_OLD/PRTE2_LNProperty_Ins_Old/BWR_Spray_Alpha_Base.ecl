// --------------------------------------------------------------------------------
//  BWR_Spray_Gateway_LNP 
// This is for initial scrambled data or for regular data from Nancy's Spreadsheet
// --------------------------------------------------------------------------------
/* **********************************************************************************
Simply spray the Gateway generated data file into HPCC files for further processing.
Jan 2016 - moved away from old gateway layout to new layout similar to pre-key build base layout
********************************************************************************** */

IMPORT ut, PRTE2_LNProperty, PRTE2_Common;
#workunit('name', 'Spray PRCT LNProperty Scrambled');

STRING fileVersion := ut.GetDate+'';
CSVName := 'LN_Property_AV3_Base_DEV_20160115.csv';

BuildFile := PRTE2_LNProperty.Fn_Spray_Alpha_Spreadsheet( CSVName, fileVersion );
SEQUENTIAL (BuildFile);

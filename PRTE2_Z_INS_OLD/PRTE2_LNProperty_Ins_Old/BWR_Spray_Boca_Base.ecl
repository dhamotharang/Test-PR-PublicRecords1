// --------------------------------------------------------------------------------
//  BWR_Spray_Boca_Base 
// This is for spraying the BOCA base data file
// Just use the Boca base file in Production, not bothering to copy this to new dataland
// --------------------------------------------------------------------------------
/* **********************************************************************************
Simply spray the Scrambled data file into HPCC files ready now for the build.
********************************************************************************** */

IMPORT ut, PRTE2_LNProperty, PRTE2_Common;
#workunit('name', 'Boca PRCT LNProperty Boca Data Spray');

// Assumes today's date, alter this if that isn't true.
STRING fileVersion := ut.GetDate+'';
CSVName := 'LNProperty_Boca_Base_20140507_or_whatever.csv';

BuildFile := PRTE2_LNProperty.Fn_Spray_Boca_Spreadsheet( CSVName, fileVersion );

SEQUENTIAL (BuildFile);

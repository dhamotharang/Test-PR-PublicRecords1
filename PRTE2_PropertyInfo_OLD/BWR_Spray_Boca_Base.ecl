// --------------------------------------------------------------------------------
//  BWR_Spray_Boca_Base 
// This is for spraying the BOCA base data file
// --------------------------------------------------------------------------------
/* **********************************************************************************
Simply spray the Scrambled data file into HPCC files ready now for the build.
********************************************************************************** */

IMPORT ut, PRTE2_PropertyInfo, PRTE2_Common;
#workunit('name', 'Boca PRCT Property Info Boca Data Spray');

// Assumes today's date, alter this if that isn't true.
STRING fileVersion := ut.GetDate+'b';
CSVName := 'PropertyInfo_Export_Boca_Base_20140507.csv';

BuildFile := PRTE2_PropertyInfo.Fn_Spray_Boca_Spreadsheet( CSVName, fileVersion );

SEQUENTIAL (BuildFile);

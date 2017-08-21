// --------------------------------------------------------------------------------
//  BWR_Spray_Boca_Base 
// This is for spraying the BOCA base data file
// --------------------------------------------------------------------------------
/* **********************************************************************************
Simply spray the Scrambled data file into HPCC files ready now for the build.
********************************************************************************** */

IMPORT ut, PRTE2_Foreclosure, PRTE2_Common;
#workunit('name', 'Boca PRCT Foreclosure Boca Data Spray');
#OPTION('multiplePersistInstances',FALSE);

// Assumes today's date, alter this if that isn't true.
STRING fileVersion := ut.GetDate+'';
CSVName := 'Foreclosures_Boca_Base_20150213.csv';

BuildFile := PRTE2_Foreclosure.Fn_Spray_Boca_Spreadsheet( CSVName, fileVersion );

SEQUENTIAL (BuildFile);

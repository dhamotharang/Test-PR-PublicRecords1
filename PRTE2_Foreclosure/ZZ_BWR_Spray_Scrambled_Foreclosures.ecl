// --------------------------------------------------------------------------------
// BWR_Spray_Scrambled_Foreclosures
// This is for initial scrambled data or for regular data from Nancy's Spreadsheet
// --------------------------------------------------------------------------------
/* ********************************************************************************************
spray Foreclosure data file after it has been scrambled into HPCC files for further processing.
*********************************************************************************************** */

IMPORT ut, PRTE2_Foreclosure, PRTE2_Common;
#workunit('name', 'Spray PRCT Foreclosure File Scrambled');

STRING fileVersion := ut.GetDate;

CSVName := 'Foreclosures_Scrambled_Data_20131217.csv';

// If CSV path is not '/load01/prct2/bpetro/batchGateway/', add a 3rd param below to override
BuildFile := PRTE2_Foreclosure.Fn_Spray_Scrambled_Spreadsheet( CSVName, fileVersion );

SEQUENTIAL (BuildFile);

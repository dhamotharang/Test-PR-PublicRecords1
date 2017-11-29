// --------------------------------------------------------------------------------
//  BWR_Spray_Scrambled_PII 
// This is for initial scrambled data or for regular data from Nancy's Spreadsheet
// --------------------------------------------------------------------------------
/* **********************************************************************************
Simply spray the Scrambled data file into HPCC files ready now for the build.
********************************************************************************** */

IMPORT ut, PRTE2_PropertyInfo, PRTE2_Common;

#workunit('name', 'Boca PRCT Property Info Scrambled File Spray');

STRING fileVersion := ut.GetDate+'';

// Assumes today's date, alter this if that isn't true.
xdate	:= ut.GetDate;
// xdate := '20131112';

// This name for newly scrambled data
// CSVName := 'PropertyInfo_Scrambled_Data_'+xdate+'.csv';
// This name for regulary extracts that we pull back in
CSVName := 'PropertyInfo_Export_'+xdate+'.csv';
// If CSV path is not '/load01/prct2/bpetro/batchGateway/', we can add a 3rd param below to override

BuildFile := PRTE2_PropertyInfo.Fn_Spray_Scrambled_Spreadsheet( CSVName, fileVersion );

SEQUENTIAL (BuildFile);

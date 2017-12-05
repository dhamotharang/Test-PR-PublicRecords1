// --------------------------------------------------------------------------------
//  BWR_Spray_Alpharetta_Base 
// This to spray the regular data from Nancy's Alpharetta Spreadsheet
// --------------------------------------------------------------------------------
/* **********************************************************************************
Simply spray the Scrambled data file into HPCC files ready now for the build.
********************************************************************************** */

IMPORT ut, PRTE2_PropertyInfo, PRTE2_Common;
#workunit('name', 'Boca PRCT Property Info Scrambled File Spray');

STRING fileVersion := ut.GetDate+'';
CSVName := 'PropertyInfo_New_Expanded_20150217.csv';

// pii_path := '/load01/prct2/PropertyInfo/';
BuildFile := PRTE2_PropertyInfo.Fn_Spray_Alpharetta_Spreadsheet( CSVName, fileVersion ); //, pii_path 

SEQUENTIAL (BuildFile);

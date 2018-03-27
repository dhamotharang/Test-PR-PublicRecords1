// --------------------------------------------------------------------------------
//  BWR_Spray_Alpharetta_Adds 
// This to spray New data from Nancy's Alpharetta Spreadsheet
// --------------------------------------------------------------------------------
/* **********************************************************************************
Simply spray the Scrambled data file into HPCC files ready now for the build.
********************************************************************************** */

IMPORT ut, PRTE2_PropertyInfo, PRTE2_Common;
#workunit('name', 'Boca PRCT Property Info Spray & Add');

STRING fileVersion := ut.GetDate+'';
CSVName := 'Property_data_Adds_alfa_20160622.csv';
isProdBase := TRUE; // TRUE = read PROD base file, append new cases then save as new Dev base.  FALSE = append new cases to the Local Dev Base.

// pii_path := '/load01/prct2/PropertyInfo/';
BuildFile := PRTE2_PropertyInfo.Fn_Spray_Alpharetta_Add_Records( CSVName, fileVersion, isProdBase); //, pii_path 

SEQUENTIAL (BuildFile);

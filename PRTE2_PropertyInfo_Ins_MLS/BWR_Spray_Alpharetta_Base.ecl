/* ************************************************************************************************************************
**********************************************************************************************
***** MLS CONVERSION NOTES:
**********************************************************************************************
Simple spray of CSV layout into HPCC Alpha CSV Base file which includes extra fields not used in key builds.
Uses PromoteSuper so does not need a file version in the base files
************************************************************************************************************************ */

IMPORT ut, PRTE2_PropertyInfo_Ins_MLS, PRTE2_Common;
#workunit('name', 'ALPHA PRCT Property Info File Spray');

CSVName := 'PropertyInfo_MLS_Dev_20200225.csv';

BuildFile := PRTE2_PropertyInfo_Ins_MLS.Fn_Spray_Alpharetta_Spreadsheet( CSVName); 

SEQUENTIAL (BuildFile);

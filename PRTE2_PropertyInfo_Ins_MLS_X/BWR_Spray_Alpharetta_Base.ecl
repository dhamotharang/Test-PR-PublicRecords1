/* ************************************************************************************************************************
**********************************************************************************************
***** MLS CONVERSION NOTES:
**********************************************************************************************

---------------------------------------------------------------------------------------------------------------
Simple spray of CSV layout into HPCC Alpha CSV Base file which includes extra fields not used in key builds.
---------------------------------------------------------------------------------------------------------------

************************************************************************************************************************ */

IMPORT ut, PRTE2_PropertyInfo_Ins_MLS_X, PRTE2_Common;
#workunit('name', 'ALPHA PRCT Property Info File Spray');

STRING fileVersion := PRTE2_Common.Constants.TodayString+'';
CSVName := 'PropertyInfo_MLS_Dev_20200225.csv';

BuildFile := PRTE2_PropertyInfo_Ins_MLS_X.Fn_Spray_Alpharetta_Spreadsheet( CSVName, fileVersion ); 

SEQUENTIAL (BuildFile);

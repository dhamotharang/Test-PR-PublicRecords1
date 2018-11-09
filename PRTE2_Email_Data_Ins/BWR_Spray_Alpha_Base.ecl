/* *******************************************************************************************************
PRTE2_Email_Data_Ins.BWR_Spray_Alpha_Base

Nov 2017 - re-write to new LZ and base layouts

******************************************************************************************************* */

IMPORT PRTE2_Common, PRTE2_Email_Data_Ins;
#workunit('name', 'Boca CT Email Spreadsheet File Spray');

fileVersion := PRTE2_Common.Constants.TodayString+'';
CSVName := 'Email_V2_Base_Prod_20171030_ct541_upd.csv';

lzFilePath := PRTE2_Email_Data_Ins.Constants.SourcePathForCSV + CSVName;

BuildFile := PRTE2_Email_Data_Ins.Fn_Spray_And_Build_BaseMain(lzFilePath, fileVersion);
SEQUENTIAL (BuildFile);
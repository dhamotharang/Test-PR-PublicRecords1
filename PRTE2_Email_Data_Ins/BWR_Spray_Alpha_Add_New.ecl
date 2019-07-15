/* *******************************************************************************************************
PRTE2_Email_Data_Ins.BWR_Spray_Alpha_Add_New

Feb 2018 - Write this for the first time to add new Farmers rush data.
******************************************************************************************************* */

IMPORT PRTE2_Common, PRTE2_Email_Data_Ins;
#workunit('name', 'Boca CT Email Spreadsheet File Spray');

fileVersion := PRTE2_Common.Constants.TodayString+'f';
CSVName := 'Email_V2_ADD_NEW_20180209.csv';

lzFilePath := PRTE2_Email_Data_Ins.Constants.SourcePathForCSV + CSVName;
isProdBase 	:= TRUE; 	// Used for Adds only. TRUE: Load the Prod Base to this DEV build.  FALSE: Load Local Base.

BuildFile := PRTE2_Email_Data_Ins.Fn_Spray_And_Add_New(lzFilePath, fileVersion, isProdBase);
SEQUENTIAL (BuildFile);
/* **********************************************************************************
		PRTE2_Gong_Ins.BWR_Spray_Add_New
This is for spraying regular Alpha data from Nancy's Spreadsheet - new rows to append
Simply spray the fake CT data file into HPCC files ready now for the build.
********************************************************************************** */

IMPORT ut, PRTE2_Gong_Ins, PRTE2_Common;
#workunit('name', 'Boca PRCT Gong Spray New');

STRING fileVersion := PRTE2_Common.Constants.TodayString+'c';
CSVName := 'Gong_Add_New_20180209.csv';
isProdBase 	:= TRUE; 	// Used for Adds only. TRUE: Load the Prod Base to this DEV build.  FALSE: Load Local Base.

BuildFile := PRTE2_Gong_Ins.Fn_Spray_And_Add_New( CSVName, fileVersion, isProdBase ); 

SEQUENTIAL (BuildFile);


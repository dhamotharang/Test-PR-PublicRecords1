/* **********************************************************************************
		PRTE2_Gong_Ins.BWR_Spray_Add_New
This is for spraying regular Alpha data from Nancy's Spreadsheet - new rows to append
Simply spray the fake CT data file into HPCC files ready now for the build.

********** WARNING ********* WARNING ************* WARNING *********** WARNING *********
I put an add_new in here but we have no idea what field initialization may be needed.
We created this initial data by working with Linda to gather production records and replace PII
SO -- maybe??  in the future we won't do add_new, but instead will do gather prod and replace PII???
Please consider these to be initial but not ready for use until we determine how to proceed:
PRTE2_Gong_Ins.BWR_Spray_Add_New	AND 	PRTE2_Gong_Ins.Fn_Spray_And_Add_New
********** WARNING ********* WARNING ************* WARNING *********** WARNING *********

********************************************************************************** */

IMPORT ut, PRTE2_Gong_Ins, PRTE2_Common;
#workunit('name', 'Alpha PRCT Gong Spray New');

STRING fileVersion := PRTE2_Common.Constants.TodayString+'c';
CSVName := 'Gong_Add_New_20180209.csv';
isProdBase 	:= TRUE; 	// Used for Adds only. TRUE: Load the Prod Base to this DEV build.  FALSE: Load Local Base.

BuildFile := PRTE2_Gong_Ins.Fn_Spray_And_Add_New( CSVName, fileVersion, isProdBase ); 

SEQUENTIAL (BuildFile);


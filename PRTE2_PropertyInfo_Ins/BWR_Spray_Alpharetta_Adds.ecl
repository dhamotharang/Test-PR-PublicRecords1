/* **********************************************************************************
	PRTE2_PropertyInfo_Ins.BWR_Spray_Alpharetta_Adds
Simply spray new data file into HPCC files, run initializations, and append to base file.
********************************************************************************** */

IMPORT ut, PRTE2_PropertyInfo_Ins, PRTE2_Common;
#workunit('name', 'Boca PRCT Property Info Spray & Add');

STRING fileVersion := PRTE2_Common.Constants.TodayString+'';
CSVName := 'PROPERTY_DATA_NJ_only_new_cases_NEWLAYOUT.csv';
// isProdBase := TRUE; // TRUE = read PROD base file, append new cases then save as new Dev base.  FALSE = append new cases to the Local Dev Base.
isProdBase := FALSE; // TRUE = read PROD base file, append new cases then save as new Dev base.  FALSE = append new cases to the Local Dev Base.

BuildFile := PRTE2_PropertyInfo_Ins.Fn_Spray_Alpharetta_Add_Records( CSVName, fileVersion, isProdBase);

SEQUENTIAL (BuildFile);

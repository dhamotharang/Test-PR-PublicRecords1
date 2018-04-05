/* **********************************************************************************
	PRTE2_PropertyInfo_Ins.BWR_Spray_Alpharetta_Adds
Simply spray new data file into HPCC files, run initializations, and append to base file.

Run this in DEV/Dataland ... 
1. It reads Production Property base, adds new records and save to Dev/Dataland base...
2. Despray from Dev/Dataland base
3. Spray the new file into PROD, build keys because Boca has no data in here.
********************************************************************************** */

IMPORT ut, PRTE2_PropertyInfo_Ins, PRTE2_Common;
#workunit('name', 'Boca PRCT Property Info Spray & Add');

STRING fileVersion := PRTE2_Common.Constants.TodayString+'';
CSVName := 'PropertyInfo_adds_travelets_20170818_upd.csv';
isProdBase := TRUE; // TRUE = read PROD base file, append new cases then save as new Dev base.  FALSE = append new cases to the Local Dev Base.

BuildFile := PRTE2_PropertyInfo_Ins.Fn_Spray_Alpharetta_Add_Records( CSVName, fileVersion, isProdBase);

SEQUENTIAL (BuildFile);

/* ***********************************************************************************************
Builder window code to do a full watercraft Insurance Customer Test base build
ADDING NEW DATA (delta) to the existing main ("alldata") base
*********************************************************************************************** */

IMPORT PRTE2_Common;
IMPORT * FROM PRTE2_WaterCraft_Ins;
#WORKUNIT ('NAME', 'InsCT Watercraft Add Build');

fileVersion	:= PRTE2_Common.Constants.TodayString + 'a';
FileName := 'WatercraftV3_adds_farmers_20180209.csv';
LZPath := PRTE2_WaterCraft_Ins.Constants.SourcePathForCSV;
LZFullPath := LZPath + FileName;
Constants := PRTE2_WaterCraft_Ins.Constants;
isProdBase 	:= TRUE; 	// Used for Adds only. TRUE: Load the Prod Base to this DEV build.  FALSE: Load Local Base.

BaseBuild := Build_MASTER(Constants.ADD_NEW_ONLY_INDICATOR, fileVersion, LZFullPath, isProdBase);

SEQUENTIAL(BaseBuild);
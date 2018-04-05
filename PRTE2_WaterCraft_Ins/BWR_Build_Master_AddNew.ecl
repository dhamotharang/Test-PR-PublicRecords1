/* ***********************************************************************************************
Builder window code to do a full watercraft Insurance Customer Test base build
ADDING NEW DATA (delta) to the existing main ("alldata") base
*********************************************************************************************** */

IMPORT PRTE2_Common;
IMPORT * FROM PRTE2_WaterCraft_Ins;
#WORKUNIT ('NAME', 'InsCT Watercraft Add Build');

fileVersion	:= PRTE2_Common.Constants.TodayString + '';
FileName := 'Farm_WATERCRAFT_V3_ADD_xxxxxxx.csv';
LZPath := PRTE2_WaterCraft_Ins.Constants.SourcePathForCSV;
LZFullPath := LZPath + FileName;
Constants := PRTE2_WaterCraft_Ins.Constants;

BaseBuild := Build_MASTER(Constants.ADD_NEW_ONLY_INDICATOR, fileVersion, LZFullPath);

SEQUENTIAL(BaseBuild);
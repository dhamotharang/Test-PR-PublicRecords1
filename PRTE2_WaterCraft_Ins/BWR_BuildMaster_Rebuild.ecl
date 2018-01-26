/* ***********************************************************************************************
Builder window code to do a full watercraft Insurance Customer Test base build
REPLACING THE EXISTING main ("alldata") base with a new file
*********************************************************************************************** */

IMPORT PRTE2_Common;
IMPORT * FROM PRTE2_WaterCraft_Ins;
#WORKUNIT ('NAME', 'InsCT Watercraft Full Build');

fileVersion	:= PRTE2_Common.Constants.TodayString + 'd';

FileName := 'WatercraftV3_base_Prod_20180119.csv';
LZPath := PRTE2_WaterCraft_Ins.Constants.SourcePathForCSV;
LZFullPath := LZPath + FileName;
Constants := PRTE2_WaterCraft_Ins.Constants;

BaseBuild := Build_MASTER(Constants.FULL_REBUILD_INDICATOR, fileVersion, LZFullPath);

SEQUENTIAL(BaseBuild);
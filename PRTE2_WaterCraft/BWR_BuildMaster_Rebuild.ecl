// Builder window code to do a full watercraft Customer Test build
// starting with REPLACING THE EXISTING main ("alldata") base with a new file

IMPORT ut;
IMPORT * FROM PRTE2_watercraft;

fileVersion := ut.GetDate+'';
// Version on 4/23 that is a despray after adding new craft
FileName := 'Watercraft_base_despray_Check_20140423.csv';
LZPath := _LandingZoneConfig.AllData.Dir;
LZFullPath := LZPath + FileName;

boolean is_test_run := true;	// IF you are in PROD, true stops the DOPS UpdateVersion from happening.
PostBuild_Steps_To_Do := after_build_actions.post_processing_actions(is_test_run,fileVersion);

MainBuild := Build_MASTER(_constants.FULL_REBUILD_INDICATOR, fileVersion, LZFullPath);

SEQUENTIAL(MainBuild, PostBuild_Steps_To_Do);
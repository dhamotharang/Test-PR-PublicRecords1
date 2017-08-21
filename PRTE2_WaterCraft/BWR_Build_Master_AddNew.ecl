// Builder window code to do a full watercraft Customer Test build
// starting with ADDING NEW DATA (delta) to the existing main ("alldata") base

IMPORT ut;
IMPORT * FROM PRTE2_watercraft;

fileVersion := ut.GetDate+'';
FileName := 'MET_WATERCRAFT_ADD_042214.csv';
LZPath := _LandingZoneConfig.NewData.Dir;
LZFullPath := LZPath + FileName;

boolean is_test_run := true;	// IF you are in PROD, true stops the DOPS UpdateVersion from happening.
PostBuild_Steps_To_Do := after_build_actions.post_processing_actions(is_test_run,fileVersion);

MainBuild := Build_MASTER(_constants.ADD_NEW_ONLY_INDICATOR, fileVersion, LZFullPath);

SEQUENTIAL(MainBuild, PostBuild_Steps_To_Do);
//This is the code to execute in a builder window
#workunit('name','BIPV2_POWID_DOWN_Platform.BWR_Iterate - Internal Linking - SALT V2.7 Gold');
IMPORT BIPV2_POWID_DOWN_Platform,SALT27;
//BIPV2_POWID_DOWN_Platform.Specificities(BIPV2_POWID_DOWN_Platform.In_POWID_Down).Build; // Used to create callibration keys
//Proc_Iterate also supports a dataset parameter to allow an arbitrary file as starting point.
//Proc_Iterate also supports a threshold parameter to override the default threshold.
// If the debugging parameter is set to off the build will go a little quicker but the debug services (such as the compare service) will not be available.
BIPV2_POWID_DOWN_Platform.Proc_Iterate('1').DoAll; // Change '1' for subsequent iterations
//BIPV2_POWID_DOWN_Platform.Proc_Iterate('1').DoAllAgain; // Use this version to re-run an iteration

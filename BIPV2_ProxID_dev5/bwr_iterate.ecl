//This is the code to execute in a builder window
#workunit('name','BIPV2_ProxID_dev5.BWR_Iterate - Internal Linking - SALT V2.5 Gold');
IMPORT BIPV2_ProxID_dev5,SALT25;
//BIPV2_ProxID_dev5.Specificities(BIPV2_ProxID_dev5.In_DOT_Base).Build; // Used to create callibration keys
BIPV2_ProxID_dev5.Proc_Iterate('1').DoAll; // Change '1' for subsequent iterations
//BIPV2_ProxID_dev5.Proc_Iterate('1').DoAllAgain; // Use this version to re-run an iteration

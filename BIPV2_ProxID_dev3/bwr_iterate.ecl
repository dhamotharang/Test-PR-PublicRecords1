//This is the code to execute in a builder window
#workunit('name','BIPV2_ProxID_dev3.BWR_Iterate - Internal Linking - SALT V2.6 Beta 2');
IMPORT BIPV2_ProxID_dev3,SALT26;
//BIPV2_ProxID_dev3.Specificities(BIPV2_ProxID_dev3.In_DOT_Base).Build; // Used to create callibration keys
BIPV2_ProxID_dev3.Proc_Iterate('1').DoAll; // Change '1' for subsequent iterations
//BIPV2_ProxID_dev3.Proc_Iterate('1').DoAllAgain; // Use this version to re-run an iteration

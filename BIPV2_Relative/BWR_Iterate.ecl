//This is the code to execute in a builder window
#workunit('name','BIPV2_Relative.BWR_Iterate - Internal Linking - SALT V2.5 Gold');
IMPORT BIPV2_Relative,SALT25;
BIPV2_Relative.Proc_Iterate('1').DoAll; // Change '1' for subsequent iterations
//BIPV2_Relative.Proc_Iterate('1').DoAllAgain; // Use this version to re-run an iteration

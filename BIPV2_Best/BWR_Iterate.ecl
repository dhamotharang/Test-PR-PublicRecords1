//This is the code to execute in a builder window
#workunit('name','BIPV2_Best.BWR_Iterate - Internal Linking - SALT V2.4 Gold');
IMPORT BIPV2_Best,SALT24;
BIPV2_Best.Proc_Iterate('1').DoAll; // Change '1' for subsequent iterations
//BIPV2_Best.Proc_Iterate('1').DoAllAgain; // Use this version to re-run an iteration

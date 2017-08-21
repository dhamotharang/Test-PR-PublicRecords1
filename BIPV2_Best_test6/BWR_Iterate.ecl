//This is the code to execute in a builder window
#workunit('name','BIPV2_Best_test6.BWR_Iterate - Internal Linking - SALT V2.7 Beta 1');
IMPORT BIPV2_Best_test6,SALT27;
BIPV2_Best_test6.Proc_Iterate('1').DoAll; // Change '1' for subsequent iterations
//BIPV2_Best_test6.Proc_Iterate('1').DoAllAgain; // Use this version to re-run an iteration

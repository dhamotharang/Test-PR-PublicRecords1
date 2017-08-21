//This is the code to execute in a builder window
#workunit('name','NGCDL2.CDL - IT1 - Internal Linking')
NGCDL2.Proc_Iterate('1').DoAll; // Change '1' and superfile contents for subsequent iterations
//NGCDL2.Proc_Iterate('1').DoAllAgain; // Use this version to re-run an iteration


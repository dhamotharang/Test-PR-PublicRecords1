//This is the code to execute in a builder window
#workunit('name','Business_Header_Bdid_lift.BDID - Internal Linking - SALT V1.4 Beta 2')
iteration := '1';

Business_Header_Bdid_lift.Proc_Iterate(
	 iteration
	,Business_Header.BH_Basic_Match_FEIN()
).DoAll2; // Change '1' for subsequent iterations

//Business_Header_Bdid_lift.Proc_Iterate('1').DoAll; // Change '1' for subsequent iterations
//Business_Header_Bdid_lift.Proc_Iterate('1').DoAllAgain; // Use this version to re-run an iteration


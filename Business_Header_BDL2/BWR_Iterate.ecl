//This is the code to execute in a builder window
import business_header;

#workunit('name','Business_Header_BDL2 - BDL Linking - SALT V1.4 Beta 2')
iteration := '1';
pversion  := '20090629';

Business_Header_BDL2.Proc_Iterate(
	 iteration
	,Business_Header.BH_BDL2()
	,pversion
).DoAll2; // Change '1' for subsequent iterations

//Business_Header_BDL2.Proc_Iterate('1').DoAll; // Change '1' for subsequent iterations
//Business_Header_BDL2.Proc_Iterate('1').DoAllAgain; // Use this version to re-run an iteration


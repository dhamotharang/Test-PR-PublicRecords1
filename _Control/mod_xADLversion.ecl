/*2012-02-23T21:30:16Z (Chad Morton)
bug 97353 again - removing ref to package file variable
*/
export mod_xADLversion := 
MODULE

//This controls Thor activity absolutely.  It also controls Roxie calls from Thor xadl macros absolutely.
//This controls Roxie activitity, but only when package file variable is empty and soap parameter is empty and Roxie is not being called from a Thor xadl macro.
// export constant_usexADL2 := false;//only if rollback is required
export constant_usexADL2 := true;
export string_constant_version := if(constant_usexADL2, '2', '1');

export useNonLABFiles := true;

// 2/16/2012 - removing reference to package file variable and soap option on roxie and deleting xADL1 keys.  keeping plumbing in place for future versioning.
export roxie_version(unsigned soap_setting = 0) := 2;

export QA_version := true; 	
	
END;//module
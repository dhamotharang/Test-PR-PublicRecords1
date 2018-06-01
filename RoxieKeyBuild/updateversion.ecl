// Function to update data operations database with a new build version for a specific
// dataset

// Parameters

// Dataset name - Name in the package (ex. BankruptcyV2Keys)
// uversion - Version to update (build version).
// email_t - list of emailids to notify the status of the update
// auto_pkg (optional) - must be used only when there is a business requirement to send
													// production packages automatically
													// For example, we send Bankruptcy packages early in the morning
													// at 5.00 AM and this is done automatically and is based 
													// on this flag. ****** VERY IMPORTANT NOT TO USE THIS FLAG *****
// inenvment - 'N' - nonfcra, 'F' - FCRA, 'BN' - BIP NonFCRA if updating the same dataset
//								 in multiple environment then use "|" for example 'N|F'
// isboolready (optional) - some datasets have boolean keys associated with it.
													// use this option only when auto_pkg = 'Y' and there are a boolean
													// keys associated with this dataset.
// inprod - 'Y' if the dataset version should be included in automated package.
// isprodready - 'Y' if the dataset version should be included in automated package.
// inloc - location to run
// updateflag - 'F' - Full replace; 'D' - Delta Update; 'DR' - Delta Replace
//							Note: Use Delta Replace when you are replacing a delta version with another delta.

import STD,_Control,dops;
export updateversion(string datasetname,string uversion,string email_t,
string auto_pkg = 'N',string inenvment = '',string isboolready = 'Y',
string isprodready = 'N',string inloc = 'B',string indaliip = '',string includeboolean = 'Y', 
string updateflag = 'F',
string tagdelta = '',
string dopsenv = dops.constants.dopsenvironment,
boolean overrideupdateflag = false) := dops.updateversion(
												datasetname
												,uversion
												,email_t
												,auto_pkg
												,inenvment
												,isboolready
												,isprodready
												,inloc
												,indaliip
												,includeboolean
												,updateflag
												,tagdelta
												,dopsenv
												,overrideupdateflag) : DEPRECATED('Use dops.updateversion() Instead');

	
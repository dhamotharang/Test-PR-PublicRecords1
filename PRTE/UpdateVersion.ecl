// Function to update data operations database with a new build version for a specific
// dataset

// Parameters

// Dataset name - Name in the package (ex. BankruptcyV2Keys)
// uversion - Version to update (build version).
// email_t - list of emailids to notify the status of the update
// inloc - 'B' - Boca, 'A' - Alpharetta
// inenvment - 'N' - nonfcra, 'F' - FCRA
// isboolready (optional) - some datasets have boolean keys associated with it.
													// use this option only when auto_pkg = 'Y' and there are a boolean
													// keys associated with this dataset.


import ut,_Control,dops,std;
export updateversion(string l_datasetname,string l_uversion,string l_email_t,
string l_auto_pkg = 'N',string l_inenvment = '',string l_isboolready = 'Y',
string l_isprodready = 'N',string l_inloc = dops.constants.location,string l_indaliip = '',string l_includeboolean = 'Y', 
string l_updateflag = 'F',
string l_tagdelta = '',
string l_dopsenv = dops.constants.dopsenvironment,
boolean l_overrideupdateflag = false,
string l_esp = dops.constants.esp(dops.constants.dopsenvironment),
string l_espport = '8010') := dops.updateversion(
												l_datasetname
												,l_uversion
												,l_email_t
												,l_auto_pkg
												,l_inenvment
												,l_isboolready
												,l_isprodready
												,l_inloc
												,l_indaliip
												,l_includeboolean
												,l_updateflag
												,l_tagdelta
												,l_dopsenv
												,l_overrideupdateflag
												,l_testenv := 'PRTE');
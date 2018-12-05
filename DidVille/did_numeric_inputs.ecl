import AutoStandardI,ut,doxie;

gmod := AutoStandardI.GlobalModule();

export did_numeric_inputs := 
MODULE

// Read and format some of the inputs
export maxresults_val := AutoStandardI.InterfaceTranslator.maxresults_val.val(project(gmod,AutoStandardI.InterfaceTranslator.maxresults_val.params));	

EXPORT mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (gmod);

export string4   ssn4_value := '' : STORED('SSN4');
export unsigned2 yob_value := 0  : STORED('Yob');
export unsigned1 fi_value := 0   : STORED('FirstInitial');
export unsigned1 li_value := 0   : STORED('LastInitial');

string3 thresh_val := ''     : stored('AppendThreshold');
export unsigned thresh_value := (unsigned)thresh_val;

export ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(gmod,AutoStandardI.InterfaceTranslator.ssn_value.params)); 
export unsigned2 input_ssn4 :=if((unsigned2) ssn4_value <> 0,(unsigned2) ssn4_value,(unsigned2) ssn_value[6..9]);

export zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(gmod,AutoStandardI.InterfaceTranslator.zip_value.params)); 
export string5 input_zip := INTFORMAT(zip_value[1],5,1);

export prange_value := AutoStandardI.InterfaceTranslator.prange_value.val(project(gmod,AutoStandardI.InterfaceTranslator.prange_value.params)); 
export unsigned5 input_prange :=(unsigned5) prange_value;

export unsigned3 ssn5_value := (unsigned3) ssn_value[1..5];

/*
(This is the rule from Tom Monser and Bonnie Isaacs (BTM Investment requirements.doc 11/11/2008) 
 that I going to use to calculate CompleteDataField and then AllowMultipleResults_value.)
a complete data field set would be the following:
-Zip
-YOB
-Last 4 SSN
-First initial
-Last initial
-house number

If these data fields are completely filled in and there are multiple matches, return the matches .
If these data fields are not completely filled in, please return the 203.
*/
boolean CompleteDataField := 
	(integer)input_zip > 0 and 
	yob_value > 0 and 
	(integer)ssn4_value > 0 and 
	fi_value > 0 and 
	li_value > 0 and 
	input_prange > 0;
boolean AllowMultipleResults := false : stored('AllowMultipleResults');
export boolean AllowMultipleResults_value := AllowMultipleResults and CompleteDataField;

END;
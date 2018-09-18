import AutoStandardI,ut,doxie;

gmod := AutoStandardI.GlobalModule();

export inputs := 
MODULE

// Read and format some of the inputs
// doxie.MAC_Header_Field_Declare()
// export GLB_Purpose := AutoStandardI.InterfaceTranslator.GLB_Purpose.val(project(gmod,AutoStandardI.InterfaceTranslator.GLB_Purpose.params));		
// export DPPA_Purpose := AutoStandardI.InterfaceTranslator.DPPA_Purpose.val(project(gmod,AutoStandardI.InterfaceTranslator.DPPA_Purpose.params));	
export maxresults_val := AutoStandardI.InterfaceTranslator.maxresults_val.val(project(gmod,AutoStandardI.InterfaceTranslator.maxresults_val.params));	
// export ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_value.val(project(gmod,AutoStandardI.InterfaceTranslator.ssn_mask_value.params));	
// export industry_class_value := AutoStandardI.InterfaceTranslator.industry_class_value.val(project(gmod,AutoStandardI.InterfaceTranslator.industry_class_value.params));	
// export probation_override_value := AutoStandardI.InterfaceTranslator.probation_override_value.val(project(gmod,AutoStandardI.InterfaceTranslator.probation_override_value.params));	
// export no_scrub := AutoStandardI.InterfaceTranslator.no_scrub.val(project(gmod,AutoStandardI.InterfaceTranslator.no_scrub.params));	

EXPORT mod_access := doxie.functions.GetGlobalDataAccessModuleTranslated (gmod);

// export glb_ok := ut.glb_ok(GLB_Purpose);
// export dppa_ok := ut.dppa_ok(DPPA_Purpose);

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
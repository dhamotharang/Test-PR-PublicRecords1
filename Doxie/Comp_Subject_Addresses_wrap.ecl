// wrap up one of the common ways of calling doxie.Comp_Subject_Addresses
// so the compiler can call it once and hang onto the results for later

doxie.MAC_Selection_Declare();
doxie.MAC_Header_Field_Declare();

export Comp_Subject_Addresses_wrap := 
MODULE
	shared csa := doxie.Comp_Subject_Addresses(doxie.Get_Dids(),dateVal,dppa_purpose,glb_purpose,ln_branded_value,,probation_override_value,industry_class_value,
                                             no_scrub,dial_contactprecision_value, Addresses_PerSubject);

	export addresses := csa.addresses;
	export names := csa.names;
	export raw := csa.raw;

END;
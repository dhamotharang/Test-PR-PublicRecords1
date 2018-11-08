// wrap up one of the common ways of calling doxie.Comp_Subject_Addresses
// so the compiler can call it once and hang onto the results for later
IMPORT $;

$.MAC_Selection_Declare();
$.MAC_Header_Field_Declare();

mod_access := $.compliance.GetGlobalDataAccessModule ();
 
export Comp_Subject_Addresses_wrap :=
MODULE
	shared csa := doxie.Comp_Subject_Addresses ($.Get_Dids(), , dial_contactprecision_value, Addresses_PerSubject,
                                              mod_access);

	export addresses := csa.addresses;
	export names := csa.names;
	export raw := csa.raw;

END;
import LN_PropertyV2_Services;

addr_rec := doxie.layout_propertySearch;
name_rec := doxie.layout_NameDID;

export Fn_comp_prop_count(
	unsigned6 DID_value,
	unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
	boolean ln_branded_value = false,
	boolean probation_override_value = false,
	dataset(addr_rec) addrs_in = dataset([], addr_rec),
	dataset(name_rec) names_in = dataset([], name_rec)
	) := 
FUNCTION

	dids := dataset([{did_value}],doxie.layout_references);
		
	get_csa0 := doxie.Comp_Subject_Addresses(dids, 0,
	1, 1,
	true, , 
	true, '');

	csa_names := if(exists(names_in), names_in, get_csa0.names);
	
	csa_addresses := if(exists(addrs_in), 
			project(addrs_in, transform(doxie.Layout_Comp_Addresses, self := left, self := [])), 
			project(get_csa0.addresses, transform(doxie.Layout_Comp_Addresses, self := left, self := []))
			);

	c_owned := 
		LN_PropertyV2_Services.Ownership.count_currently_owned(
			dids, 
			csa_addresses, 
			csa_names);

	return c_owned;

END;
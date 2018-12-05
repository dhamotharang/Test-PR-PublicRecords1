import LN_PropertyV2_Services, doxie;

addr_rec := doxie.layout_propertySearch;
name_rec := doxie.layout_NameDID;

export Fn_comp_prop_count(
	unsigned6 DID_value,
	// not used; delete, when refactoring:
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

  mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
    EXPORT unsigned1 glb := 1;
    EXPORT unsigned1 dppa := 1;
    EXPORT boolean ln_branded := TRUE;
    EXPORT boolean probation_override := TRUE;
    EXPORT unsigned3 date_threshold := 0;
    EXPORT string5 industry_class := '';
  END;

	get_csa0 := doxie.Comp_Subject_Addresses(dids, , , , mod_access);

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
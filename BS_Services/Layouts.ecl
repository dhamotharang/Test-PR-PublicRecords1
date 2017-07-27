import doxie,risk_indicators,doxie_crs;

export Layouts := 
MODULE

	export addresses := doxie.Layout_Comp_Addresses;
	export best_info := doxie_crs.layout_best_information;
	// export names := doxie_crs.layout_comp_names;

	export out := record(risk_indicators.Layout_InstandID_NuGen)
		dataset(addresses) addresses_children {maxcount(bs_services.constants.max_addresses)};
		dataset(best_info) best_information_children {maxcount(bs_services.constants.max_best)};
		// dataset(names) names_children {maxcount(bs_services.constants.max_names)};
	end;
	
END;
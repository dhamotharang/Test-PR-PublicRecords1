export File_Hedonic_Comps(string1 fc) := function

	// if fc='', building the base file for the keys, otherwise using as comp candidates in get_hedonic_comps
	hedonic_base := if(fc='', avm.File_AVM_Hedonic_Base, avm.File_AVM_Hedonic_Base(fips_code[1]=fc));

	comparable_candidates := hedonic_base((integer)sales_price > avm.filters.minimum_sale_price and
										   recording_date != '' and
										   recording_date > avm.filters.recent_sale_for_hedonic_model );

	return comparable_candidates;

end;

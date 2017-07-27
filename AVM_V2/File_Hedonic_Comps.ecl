
export File_Hedonic_Comps(string1 fc, string8 history_date) := function

	// if fc='', building the base file for the keys, otherwise using as comp candidates in get_hedonic_comps
	hedonic_base := if(fc='', avm_v2.File_AVM_Hedonic_Base(history_date), avm_v2.File_AVM_Hedonic_Base(history_date)(fips_code[1]=fc));

	comparable_candidates := hedonic_base((integer)sales_price > avm_v2.filters(history_date).minimum_sale_price and
										   recording_date != '' and
										   recording_date > avm_v2.filters(history_date).recent_sale_for_hedonic_model );

	return comparable_candidates;

end;

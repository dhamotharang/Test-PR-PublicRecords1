import AutoStandardI;
export LIBIN := module
	export FetchI_Hdr_Indv := module
		export base := interface(
			AutoStandardI.InterfaceTranslator.fname_value.params,
			AutoStandardI.InterfaceTranslator.fname_set_value.params,		
			AutoStandardI.InterfaceTranslator.lname_value.params,
			AutoStandardI.InterfaceTranslator.lname_set_value.params,
			AutoStandardI.InterfaceTranslator.lnamephoneticset.params,
			AutoStandardI.InterfaceTranslator.nicknames.params,
			AutoStandardI.InterfaceTranslator.phonetics.params,
			AutoStandardI.InterfaceTranslator.usephoneticdistance.params,
			AutoStandardI.InterfaceTranslator.prange_value.params,
			AutoStandardI.InterfaceTranslator.prange_beg_value.params,
			AutoStandardI.InterfaceTranslator.prange_end_value.params,
			AutoStandardI.InterfaceTranslator.prange_wild_value.params,
			AutoStandardI.InterfaceTranslator.pname_value.params,
			AutoStandardI.InterfaceTranslator.sec_range_value.params,
			AutoStandardI.InterfaceTranslator.addr_range.params,
			AutoStandardI.InterfaceTranslator.addr_loose.params,
			AutoStandardI.InterfaceTranslator.addr_wild.params,
			AutoStandardI.InterfaceTranslator.city_value.params,
			AutoStandardI.InterfaceTranslator.state_value.params,
			AutoStandardI.InterfaceTranslator.zip_val.params,
			AutoStandardI.InterfaceTranslator.zip_value.params,
			AutoStandardI.InterfaceTranslator.prev_state_val1.params,
			AutoStandardI.InterfaceTranslator.prev_state_val2.params,
			AutoStandardI.InterfaceTranslator.other_lname_value1.params,
			AutoStandardI.InterfaceTranslator.date_first_seen_value.params,
			AutoStandardI.InterfaceTranslator.date_last_seen_value.params,
			AutoStandardI.InterfaceTranslator.allow_date_seen_value.params,
			AutoStandardI.InterfaceTranslator.searchignoresaddressonly_value.params,
			AutoStandardI.InterfaceTranslator.err_stat.params,
			AutoStandardI.InterfaceTranslator.prim_range_set_value.params,
			AutoStandardI.InterfaceTranslator.FuzzySecRange_value.params,
			AutoStandardI.InterfaceTranslator.currentresidentsonly.params,
			AutoStandardI.InterfaceTranslator.fname3_value.params,
			AutoStandardI.InterfaceTranslator.lname4_value.params,
			AutoStandardI.InterfaceTranslator.find_year_high.params,
			AutoStandardI.InterfaceTranslator.find_year_low.params,
			AutoStandardI.InterfaceTranslator.other_city_value.params,
			AutoStandardI.InterfaceTranslator.rel_fname_value1.params,
			AutoStandardI.InterfaceTranslator.rel_fname_value2.params,
			AutoStandardI.InterfaceTranslator.agelow_val.params,
			AutoStandardI.InterfaceTranslator.agehigh_val.params,
			AutoStandardI.InterfaceTranslator.dob_val.params,
			AutoStandardI.InterfaceTranslator.find_month.params,
			AutoStandardI.InterfaceTranslator.find_day.params,
			AutoStandardI.InterfaceTranslator.lookup_value.params,
			AutoStandardI.InterfaceTranslator.isCRS.params,
			AutoStandardI.InterfaceTranslator.fname_wild.params,
			AutoStandardI.InterfaceTranslator.fname_wild_val.params,
			AutoStandardI.InterfaceTranslator.mname_value.params,
			AutoStandardI.InterfaceTranslator.lname_wild.params,
			AutoStandardI.InterfaceTranslator.lname_wild_val.params,
			AutoStandardI.InterfaceTranslator.phone_value.params,
			AutoStandardI.InterfaceTranslator.ssn_value.params,
			AutoStandardI.InterfaceTranslator.did_value.params,
			AutoStandardI.InterfaceTranslator.non_exclusion_value.params,
			AutoStandardI.InterfaceTranslator.ln_branded_value.params,
			AutoStandardI.InterfaceTranslator.score_threshold_value.params,
			AutoStandardI.InterfaceTranslator.BpsLeadingNameMatch_value.params,
			AutoStandardI.InterfaceTranslator.lname_trailing_value.params,
			AutoStandardI.InterfaceTranslator.fname_trailing_value.params,
			AutoStandardI.InterfaceTranslator.fuzzy_ssn.params,
			AutoStandardI.InterfaceTranslator.searchgoodssnonly_value.params,
			AutoStandardI.InterfaceTranslator.ssnfallback_value.params,
			AutoStandardI.InterfaceTranslator.lname_val.params,
			AutoStandardI.InterfaceTranslator.city_zip_value.params,
			AutoStandardI.InterfaceTranslator.zipradius_value.params,
			AutoStandardI.InterfaceTranslator.county_value.params,
			AutoStandardI.InterfaceTranslator.pname_wild.params,
			AutoStandardI.InterfaceTranslator.pname_wild_val.params,
			AutoStandardI.InterfaceTranslator.is_inv_wildcard.params,
			AutoStandardI.InterfaceTranslator.addr_error_value.params,
			AutoStandardI.InterfaceTranslator.any_addr_error_value.params,
			AutoStandardI.InterfaceTranslator.rid_value.params,
			AutoStandardI.InterfaceTranslator.allow_wildcard_val.params,
			AutoStandardI.InterfaceTranslator.use_onlybestdid.params,
			AutoStandardI.InterfaceTranslator.adl_service_ip.params,
			AutoStandardI.InterfaceTranslator.whole_house.params,
			AutoStandardI.InterfaceTranslator.DPPA_Purpose.params,
			AutoStandardI.InterfaceTranslator.keep_old_ssns_val.params,
			AutoStandardI.InterfaceTranslator.AllowLeadingLname_value.params,
			AutoStandardI.InterfaceTranslator.AllowFuzzyDOBMatch.params,
			AutoStandardI.DataPermissionI.params,
			AutoStandardI.InterfaceTranslator.demo_customer_name_value.params,
			AutoStandardI.InterfaceTranslator.application_type_val.params)
  		export boolean noFail := false;
		end;
		export full := interface(base)
			export boolean useGlobalScope := true;
			export boolean noFail := false;
			export boolean forceLocal := true;
		end;
	end;
	export FetchI_Hdr_Biz := module
		export base := interface(
			AutoStandardI.InterfaceTranslator.fname_value.params,
			AutoStandardI.InterfaceTranslator.nicknames.params,
			AutoStandardI.InterfaceTranslator.mname_value.params,
			AutoStandardI.InterfaceTranslator.lname_value.params,
			AutoStandardI.InterfaceTranslator.SearchIgnoresAddressOnly_value.params,
			AutoStandardI.InterfaceTranslator.phonetics.params,
			AutoStandardI.InterfaceTranslator.company_name_value.params,
			AutoStandardI.InterfaceTranslator.prange_value.params,
			AutoStandardI.InterfaceTranslator.predir_value.params,
			AutoStandardI.InterfaceTranslator.pname_value.params,
			AutoStandardI.InterfaceTranslator.addr_suffix_value.params,
			AutoStandardI.InterfaceTranslator.postdir_value.params,
			AutoStandardI.InterfaceTranslator.sec_range_value.params,
			AutoStandardI.InterfaceTranslator.addr_loose.params,
			AutoStandardI.InterfaceTranslator.city_value.params,
			AutoStandardI.InterfaceTranslator.state_value.params,
			AutoStandardI.InterfaceTranslator.zip_value.params,
			AutoStandardI.InterfaceTranslator.addr_error_value.params,
			AutoStandardI.InterfaceTranslator.any_addr_error_value.params,
			AutoStandardI.InterfaceTranslator.bh_zip_value.params,
			AutoStandardI.InterfaceTranslator.mile_radius_value.params,
			AutoStandardI.InterfaceTranslator.phone_value.params,
			AutoStandardI.InterfaceTranslator.fein_value.params,
			AutoStandardI.InterfaceTranslator.bdid_value.params,
			AutoStandardI.InterfaceTranslator.non_exclusion_value.params,
			AutoStandardI.InterfaceTranslator.ssn_value.params
			)
		end;
		export full := interface(base)
			export boolean noFail := false;
			export boolean use_exec_search := true;
			export boolean use_word_search := true;
			export boolean score_results := true;
			export unsigned6 bdid_limit := 2500;
			export boolean match_ssn_as_fein := false;
			export boolean phone_mandatory_match := false;
			export boolean fein_mandatory_match := false;
			export unsigned1 fuzziness_dial := 3;
		end;
	end;
end;

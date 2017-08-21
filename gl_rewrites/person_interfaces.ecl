export person_interfaces :=
	module
		export i__fetch_header_did :=
			interface(
				gl_rewrites.basic_interfaces.i__did_value)
			end;
		export i__fetch_header_rid :=
			interface(
				gl_rewrites.basic_interfaces.i__rid_value)
			end;
		export i__fetch_header_ssn :=
			interface(
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__fuzzy_ssn,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__score_threshold_value,
				gl_rewrites.basic_interfaces.i__SearchGoodSSNOnly_value)
			end;
		export i__fetch_header_stnamesmall :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__nicknames,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__mname_value,
				gl_rewrites.basic_interfaces.i__score_threshold_value,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__phonetics,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2)
			end;
		export i__fetch_header_phone :=
			interface(
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__fname_value)
			end;
		export i__fetch_header_street :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__pname_value,
				gl_rewrites.basic_interfaces.i__zip_val,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__city_zip_value,
				gl_rewrites.basic_interfaces.i__prange_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__did_value,
				gl_rewrites.basic_interfaces.i__addr_loose,
				gl_rewrites.basic_interfaces.i__phonetics,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__prange_end_value,
				gl_rewrites.basic_interfaces.i__prange_beg_value,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__nicknames)
				export boolean nofail := false;
			end;
		export i__fetch_address :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__phonetics,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__pname_value,
				gl_rewrites.basic_interfaces.i__prange_value,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__addr_loose,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__prange_end_value,
				gl_rewrites.basic_interfaces.i__prange_beg_value,
				gl_rewrites.basic_interfaces.i__addr_wild,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__sec_range_value,
				gl_rewrites.basic_interfaces.i__SearchIgnoresAddressOnly_value)
				export boolean nofail := false;
			end;
		export i__fetch_header_zip :=
			interface(
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__did_value,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__phonetics,
				gl_rewrites.basic_interfaces.i__nicknames,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__mname_value,
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__lname_value)
				export boolean nofail := false;
			end;
		export i__fetch_header_da :=
			interface(
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__lname4_value,
				gl_rewrites.basic_interfaces.i__fname3_value,
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__nicknames,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__lookup_value)
			end;
		export i__fetch_header_fnamesmall :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__pname_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__date_first_seen_value,
				gl_rewrites.basic_interfaces.i__date_last_seen_value,
				gl_rewrites.basic_interfaces.i__allow_date_seen_value,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__lookup_value)
				export boolean nofail := false;
			end;
		export i__fetch_header_name :=
			interface(
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__did_value,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__mname_value,
				gl_rewrites.basic_interfaces.i__nicknames,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__score_threshold_value,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__Phonetics,
				gl_rewrites.penalty_interfaces.i__input_name)
				export boolean nofail := false;
			end;
		export i__fetch_header_stflname :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__mname_value,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__did_value,
				gl_rewrites.basic_interfaces.i__phonetics,
				gl_rewrites.basic_interfaces.i__nicknames,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__non_exclusion_value)
				export boolean nofail := false;
			end;
		export i__fetch_header_stcityflname :=
			interface(
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__did_value,
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__nicknames,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__phonetics)
			end;
		export i__fetch_header_wild_ssn :=
			interface(
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__lname_wild_val,
				gl_rewrites.basic_interfaces.i__fname_wild_val,
				gl_rewrites.basic_interfaces.i__fuzzy_ssn,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__score_threshold_value)
			end;
		export i__fetch_header_wild_stnamesmall :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_wild_val,
				gl_rewrites.basic_interfaces.i__fname_wild_val,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__mname_value,
				gl_rewrites.basic_interfaces.i__score_threshold_value,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2)
			end;
		export i__fetch_header_wild_phone :=
			interface(
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__lname_wild_val,
				gl_rewrites.basic_interfaces.i__fname_wild_val)
			end;
		export i__fetch_header_wild_street :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__pname_value,
				gl_rewrites.basic_interfaces.i__lname_wild_val,
				gl_rewrites.basic_interfaces.i__fname_wild_val,
				gl_rewrites.basic_interfaces.i__pname_wild_val,
				gl_rewrites.basic_interfaces.i__zip_val,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__city_zip_value,
				gl_rewrites.basic_interfaces.i__prange_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__did_value,
				gl_rewrites.basic_interfaces.i__addr_range,
				gl_rewrites.basic_interfaces.i__addr_loose,
				gl_rewrites.basic_interfaces.i__addr_wild,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__prange_end_value,
				gl_rewrites.basic_interfaces.i__prange_beg_value,
				gl_rewrites.basic_interfaces.i__prange_wild_value,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__zipradius_value)
				export boolean nofail := false;
			end;
		export i__fetch_header_wild_address :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_wild_val,
				gl_rewrites.basic_interfaces.i__fname_wild_val,
				gl_rewrites.basic_interfaces.i__pname_value,
				gl_rewrites.basic_interfaces.i__pname_wild_val,
				gl_rewrites.basic_interfaces.i__prange_value,
				gl_rewrites.basic_interfaces.i__prange_end_value,
				gl_rewrites.basic_interfaces.i__prange_beg_value,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__addr_loose,
				gl_rewrites.basic_interfaces.i__addr_range,
				gl_rewrites.basic_interfaces.i__addr_wild,
				gl_rewrites.basic_interfaces.i__pname_wild,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__sec_range_value)
			end;
		export i__fetch_header_wild_zip :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_wild_val,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__did_value,
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__zip_val,
				gl_rewrites.basic_interfaces.i__city_zip_value,
				gl_rewrites.basic_interfaces.i__zipradius_value,
				gl_rewrites.basic_interfaces.i__fname_wild_val,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__mname_value)
				export boolean nofail := false;
			end;
		export i__fetch_header_wild_ssn_partial :=
			interface(
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__lname_wild_val,
				gl_rewrites.basic_interfaces.i__fname_wild_val,
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__fname_value)
			end;
		export i__fetch_header_wild_fnamesmall :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_wild_val,
				gl_rewrites.basic_interfaces.i__fname_wild_val,
				gl_rewrites.basic_interfaces.i__pname_wild_val,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__lookup_value)
				export boolean nofail := false;
			end;
		export i__fetch_header_wild_name :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_wild_val,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__did_value,
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__mname_value,
				gl_rewrites.basic_interfaces.i__fname_wild_val,
				gl_rewrites.basic_interfaces.i__lookup_value)
				export boolean nofail := false;
			end;
		export i__fetch_header_wild_stflname :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_wild_val,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__did_value,
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__mname_value,
				gl_rewrites.basic_interfaces.i__fname_wild_val,
				gl_rewrites.basic_interfaces.i__lookup_value)
				export boolean nofail := false;
			end;
		export i__fetch_header_wild_stcityflname :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__lname_wild_val,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__did_value,
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__fname_wild_val,
				gl_rewrites.basic_interfaces.i__lookup_value)
				export boolean nofail := false;
			end;
		export i__header_wild_references :=
			interface(
				i__fetch_header_did,
				i__fetch_header_rid,
				i__fetch_header_wild_ssn,
				i__fetch_header_wild_stnamesmall,
				i__fetch_header_wild_phone,
				i__fetch_header_wild_street,
				i__fetch_header_wild_address,
				i__fetch_header_wild_zip,
				i__fetch_header_wild_ssn_partial,
				i__fetch_header_wild_fnamesmall,
				i__fetch_header_wild_name,
				i__fetch_header_wild_stflname,
				i__fetch_header_wild_stcityflname,
				gl_rewrites.basic_interfaces.i__addr_error_value,
				gl_rewrites.basic_interfaces.i__any_addr_error_value,
				gl_rewrites.basic_interfaces.i__is_inv_wildcard)
				export boolean nofail := false;
			end;
		export i__get_onlybestdid :=
			interface(
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__lname_value,
				gl_rewrites.basic_interfaces.i__fname_value)
			end;
		export i__header_references :=
			interface(
				i__fetch_header_did,
				i__fetch_header_rid,
				i__fetch_header_ssn,
				i__fetch_header_stnamesmall,
				i__fetch_header_phone,
				i__fetch_header_street,
				i__fetch_address,
				i__fetch_header_zip,
				i__fetch_header_da,
				i__fetch_header_fnamesmall,
				i__fetch_header_name,
				i__fetch_header_stflname,
				i__fetch_header_stcityflname,
				i__header_wild_references,
				i__get_onlybestdid,
				gl_rewrites.basic_interfaces.i__is_wildcard_search,
				gl_rewrites.basic_interfaces.i__allow_wildcard_val,
				gl_rewrites.basic_interfaces.i__use_onlybestdid)
			end;
		export i__get_dids_hhid :=
			interface(
				i__header_references,
				gl_rewrites.basic_interfaces.i__dppa_purpose,
				gl_rewrites.basic_interfaces.i__glb_purpose,
				gl_rewrites.basic_interfaces.i__adl_service_ip,
				gl_rewrites.basic_interfaces.i__ssn_set,
				gl_rewrites.basic_interfaces.i__keep_old_ssns_val,
				gl_rewrites.basic_interfaces.i__whole_house)
				export boolean forceLocal := true;
				export boolean noFail := false;
				export boolean allow_wildcard := false;
			end;
		export i__get_dids :=
			interface(
				i__get_dids_hhid)
				export boolean forceLocal := true;
				export boolean noFail := false;
				export boolean allow_wildcard := false;
			end;
	end;
	
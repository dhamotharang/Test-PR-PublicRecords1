import gl_rewrites;
export penalty_interfaces :=
	module
		export i__input_name :=
			interface(
				gl_rewrites.basic_interfaces.i__lname_wild,
				gl_rewrites.basic_interfaces.i__lname_wild_val,
				gl_rewrites.basic_interfaces.i__lnameIn,
				gl_rewrites.basic_interfaces.i__lnameIn_clean,
				gl_rewrites.basic_interfaces.i__fname_wild,
				gl_rewrites.basic_interfaces.i__fname_wild_val,
				gl_rewrites.basic_interfaces.i__fnameIn,
				gl_rewrites.basic_interfaces.i__fnameIn_clean,
				gl_rewrites.basic_interfaces.i__mname_value,
				gl_rewrites.basic_interfaces.i__non_exclusion_value)
				export boolean allow_wildcard := false;
			end;
		export i__found_name :=
			interface
				export string fname_field := '';
				export string mname_field := '';
				export string lname_field := '';
			end;
		export i__input_cname :=
			interface(
				gl_rewrites.basic_interfaces.i__comp_name_value)
			end;
		export i__found_cname :=
			interface
				export string cname_field := '';
			end;
		export i__input_addr :=
			interface(
				gl_rewrites.basic_interfaces.i__zip_val,
				gl_rewrites.basic_interfaces.i__addr_range,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__prange_beg_value,
				gl_rewrites.basic_interfaces.i__prange_end_value,
				gl_rewrites.basic_interfaces.i__pname_wild,
				gl_rewrites.basic_interfaces.i__pname_wild_val,
				gl_rewrites.basic_interfaces.i__pname_value,
				gl_rewrites.basic_interfaces.i__addr_wild,
				gl_rewrites.basic_interfaces.i__prange_value,
				gl_rewrites.basic_interfaces.i__prange_wild_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__addr_suffix_value,
				gl_rewrites.basic_interfaces.i__postdir_value,
				gl_rewrites.basic_interfaces.i__zipradius_value,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__city_zip_value,
				gl_rewrites.basic_interfaces.i__input_city_value,
				gl_rewrites.basic_interfaces.i__predir_value)
				export boolean allow_wildcard := false;
			end;
		export i__found_addr :=
			interface
				export string predir_field := '';
				export string prange_field := '';
				export string pname_field := '';
				export string suffix_field := '';
				export string postdir_field := '';
				export string sec_range_field := '';
				export string city_field := '';
				export string state_field := '';
				export string zip_field := '';
			end;
		export i__input_ssn :=
			interface(
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__score_threshold_value)
			end;
		export i__found_ssn :=
			interface
				export string ssn_field := '';
			end;
		export i__input_fein :=
			interface(
				gl_rewrites.basic_interfaces.i__score_threshold_value,
				gl_rewrites.basic_interfaces.i__fein_val)
			end;
		export i__found_fein :=
			interface
				export string fein_field := '';
			end;
		export i__input_did :=
			interface(
				gl_rewrites.basic_interfaces.i__did_value)
			end;
		export i__found_did :=
			interface
				export string did_field := '';
			end;
		export i__input_bdid :=
			interface(
				gl_rewrites.basic_interfaces.i__bdid_value)
			end;
		export i__found_bdid :=
			interface
				export string bdid_field := '';
			end;
		export i__input_county :=
			interface(
				gl_rewrites.basic_interfaces.i__county_value)
			end;
		export i__found_county :=
			interface
				export string county_field := '';
			end;
		export i__input_phone :=
			interface(
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__score_threshold_value)
			end;
		export i__found_phone :=
			interface
				export string phone_field := '';
			end;
		export i__input_dob :=
			interface(
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__agehigh_val,
				gl_rewrites.basic_interfaces.i__agelow_val)
			end;
		export i__found_dob :=
			interface
				export string dob_field := '';
			end;
		export i__input :=
			interface(
				i__input_name,
				i__input_cname,
				i__input_addr,
				i__input_ssn,
				i__input_fein,
				i__input_did,
				i__input_bdid,
				i__input_county,
				i__input_phone,
				i__input_dob)
			end;
		export i__found :=
			interface(
				i__found_name,
				i__found_cname,
				i__found_addr,
				i__found_ssn,
				i__found_fein,
				i__found_did,
				i__found_bdid,
				i__found_county,
				i__found_phone,
				i__found_dob)
			end;
	end;
	
import gl_rewrites;
export autokey_interfaces :=
	module
		export ssn2 :=
			interface(
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__fuzzy_ssn)
				export boolean nofail := true;
				export boolean workhard;
			end;
		export ssn :=
			interface(
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__fuzzy_ssn)
				export boolean nofail := true;
				export boolean workhard;
			end;
		export phone2 :=
			interface(
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__lname_value)
				export boolean nofail := true;
			end;
		export phone :=
			interface(
				gl_rewrites.basic_interfaces.i__phone_value,
				gl_rewrites.basic_interfaces.i__lname_value)
				export boolean nofail := true;
			end;
		export address :=
			interface(
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__zip_val,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__pname_value,
				gl_rewrites.basic_interfaces.i__prange_value,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__addr_loose,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__sec_range_value,
				gl_rewrites.basic_interfaces.i__lname_value)
				export boolean nofail := true;
				export boolean workhard;
			end;
		export zip :=
			interface(
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__phonetics,
				gl_rewrites.basic_interfaces.i__nicknames,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__pname_value,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__addr_error_value,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__lname_value)
				export boolean nofail := true;
				export boolean workhard;
			end;
		export name :=
			interface(
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__phonetics,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__mname_value,
				gl_rewrites.basic_interfaces.i__nicknames,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__did_value,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__lname_value)
				export boolean nofail := true;
				export boolean workhard;
			end;
		export stflname :=
			interface(
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__phonetics,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__mname_value,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__nicknames,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__lname_value)
				export boolean nofail := true;
				export boolean workhard;
			end;
		export stcityflname :=
			interface(
				gl_rewrites.basic_interfaces.i__find_year_low,
				gl_rewrites.basic_interfaces.i__find_year_high,
				gl_rewrites.basic_interfaces.i__find_month,
				gl_rewrites.basic_interfaces.i__find_day,
				gl_rewrites.basic_interfaces.i__prev_state_val1,
				gl_rewrites.basic_interfaces.i__prev_state_val2,
				gl_rewrites.basic_interfaces.i__rel_fname_value1,
				gl_rewrites.basic_interfaces.i__rel_fname_value2,
				gl_rewrites.basic_interfaces.i__fname_value,
				gl_rewrites.basic_interfaces.i__mname_value,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__phonetics,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__pname_value,
				gl_rewrites.basic_interfaces.i__nicknames,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__ssn_value,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__other_lname_value1,
				gl_rewrites.basic_interfaces.i__other_city_value,
				gl_rewrites.basic_interfaces.i__addr_error_value,
				gl_rewrites.basic_interfaces.i__lname_value)
				export boolean nofail := true;
				export boolean workhard;
			end;
		export dids :=
			interface(
				ssn2,
				ssn,
				phone2,
				phone,
				address,
				zip,
				name,
				stflname,
				stcityflname)
				export boolean workhard := true;
				export boolean nofail := true;
			end;
		export biz_fein :=
			interface(
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__isCRS,
				gl_rewrites.basic_interfaces.i__fein_val,
				gl_rewrites.basic_interfaces.i__fein_value)
				export boolean nofail := true;
				export boolean workhard;
			end;
		export biz_phone :=
			interface(
				gl_rewrites.basic_interfaces.i__comp_name_value,
				gl_rewrites.basic_interfaces.i__comp_name_indic_value,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__comp_name_sec_value,
				gl_rewrites.basic_interfaces.i__phone_value)
				export boolean nofail := true;
			end;
		export biz_address :=
			interface(
				gl_rewrites.basic_interfaces.i__comp_name_indic_value,
				gl_rewrites.basic_interfaces.i__comp_name_sec_value,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__prange_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__addr_loose,
				gl_rewrites.basic_interfaces.i__pname_value,
				gl_rewrites.basic_interfaces.i__sec_range_value,
				gl_rewrites.basic_interfaces.i__comp_name_value)
				export boolean nofail := true;
				export boolean workhard;
			end;
		export biz_stcityflname :=
			interface(
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__comp_name_indic_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__comp_name_sec_value,
				gl_rewrites.basic_interfaces.i__pname_value,
				gl_rewrites.basic_interfaces.i__addr_error_value,
				gl_rewrites.basic_interfaces.i__comp_name_value)
				export boolean nofail := true;
				export boolean workhard;
			end;
		export biz_zip :=
			interface(
				gl_rewrites.basic_interfaces.i__comp_name_indic_value,
				gl_rewrites.basic_interfaces.i__pname_value,
				gl_rewrites.basic_interfaces.i__addr_error_value,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__comp_name_sec_value,
				gl_rewrites.basic_interfaces.i__comp_name_value)
				export boolean nofail := true;
				export boolean workhard;
			end;
		export biz_stname :=
			interface(
				gl_rewrites.basic_interfaces.i__comp_name_indic_value,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__comp_name_sec_value,
				gl_rewrites.basic_interfaces.i__comp_name_value)
				export boolean nofail := true;
			end;
		export biz_name :=
			interface(
				gl_rewrites.basic_interfaces.i__comp_name_indic_value,
				gl_rewrites.basic_interfaces.i__city_value,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__bdid_value,
				gl_rewrites.basic_interfaces.i__comp_name_sec_value)			
				export boolean nofail := true;
			end;
		export biz_name_words :=
			interface(
				gl_rewrites.basic_interfaces.i__state_value,
				gl_rewrites.basic_interfaces.i__lookup_value,
				gl_rewrites.basic_interfaces.i__company_name_val_filt,
				gl_rewrites.basic_interfaces.i__company_name_val_filt2,
				gl_rewrites.basic_interfaces.i__zip_value,
				gl_rewrites.basic_interfaces.i__bdid_value,
				gl_rewrites.basic_interfaces.i__city_value)
				export boolean nofail := true;
			end;
		export bdids :=
			interface(
				biz_fein,
				biz_phone,
				biz_address,
				biz_stcityflname,
				biz_zip,
				biz_stname,
				biz_name,
				biz_name_words,
				gl_rewrites.basic_interfaces.i__pname_value,
				gl_rewrites.basic_interfaces.i__comp_name_value)
				export boolean workhard := true;
				export boolean nofail := true;
			end;
		export ids :=
			interface(
				dids,
				bdids)
				export boolean workhard := true;
				export boolean nofail := true;
			end;
		export retrieve_ids :=
			interface(
				ids,
				gl_rewrites.basic_interfaces.i__nodeepdive)
				export boolean workhard := true;
				export boolean nofail := false;
				export boolean parm_nodeepdive := false;
			end;
	end;

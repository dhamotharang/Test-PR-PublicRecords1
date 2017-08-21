import doxie,ut;
export FN_Tra_Penalty_Addr(
	gl_rewrites.penalty_interfaces.i__input_addr in_input_parms,
	gl_rewrites.penalty_interfaces.i__found_addr in_found_parms) :=
		function
			return
				map(
					in_input_parms.city_value = '' or
					in_found_parms.city_field = in_input_parms.city_value or
					in_found_parms.city_field = in_input_parms.input_city_value =>
						0,
					in_found_parms.city_field = '' =>
						3,
					in_input_parms.zipradius_value > 0 or
					ut.stringsimilar(in_found_parms.city_field,in_input_parms.city_value) < 3 or
					ut.stringsimilar(in_found_parms.city_field,in_input_parms.input_city_value) < 3 =>
						1,
					5) +
				if(
					in_input_parms.state_value = '' or
					in_found_parms.state_field = in_input_parms.state_value,
					0,
					10) +
				map(
					in_input_parms.zip_value = [] or
					in_input_parms.zip_val = in_found_parms.zip_field or
					in_input_parms.city_zip_value = in_found_parms.zip_field =>
						0,
					(unsigned4)in_found_parms.zip_field = 0 =>
						2,
					(unsigned4)(4 * ut.zip_dist(
						if(
							in_input_parms.zip_val <> '',
							in_input_parms.zip_val,
							in_input_parms.city_zip_value),
						in_found_parms.zip_field) / ut.max2(in_input_parms.zipradius_value,1)) + 1) +
				map(
					in_input_parms.predir_value = '' or
					in_found_parms.predir_field = in_input_parms.predir_value =>
						0,
					1) +
				map(
					in_input_parms.postdir_value = '' or
					in_found_parms.postdir_field = in_input_parms.postdir_value =>
						0,
					1) +
				map(
					in_input_parms.addr_suffix_value = '' or
					in_found_parms.suffix_field = in_input_parms.addr_suffix_value =>
						0,
					1) +
				map(
					in_input_parms.pname_wild and
					in_input_parms.allow_wildcard and
					stringlib.stringwildmatch(
						doxie.StripOrdinal(in_found_parms.pname_field),
						in_input_parms.pname_wild_val,
						true) =>
						0,
					in_input_parms.pname_wild and
					in_input_parms.allow_wildcard =>
						10,
					in_input_parms.pname_value = '' or
					ut.StripOrdinal(in_found_parms.pname_field) = in_input_parms.pname_value =>
						0,
					in_found_parms.pname_field = '' =>
						8,
					ut.stringsimilar(in_input_parms.pname_value,in_found_parms.pname_field)) +
				map(
					(unsigned8)in_input_parms.prange_value = 0 or
					(unsigned8)in_found_parms.prange_field = (unsigned8)in_input_parms.prange_value =>
						0,
					in_input_parms.addr_range and
					(unsigned)in_found_parms.prange_field >= in_input_parms.prange_beg_value and
					(unsigned)in_found_parms.prange_field <= in_input_parms.prange_end_value =>
						0,
					in_input_parms.addr_wild and
					in_input_parms.allow_wildcard and
					in_input_parms.prange_wild_value <> '' and
					stringlib.stringwildmatch(in_found_parms.prange_field,in_input_parms.prange_wild_value,true) =>
						0,
					in_input_parms.addr_wild and
					in_input_parms.allow_wildcard and
					in_input_parms.prange_wild_value <> '' =>
						10,
					(unsigned8)in_found_parms.prange_field = 0 =>
						2,
					ut.StringSimilar(in_input_parms.prange_value,in_found_parms.prange_field));
		end;
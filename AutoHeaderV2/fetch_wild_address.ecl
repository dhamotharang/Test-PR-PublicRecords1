import ut,doxie,dx_header,AutoStandardI,AutoHeaderV2,lib_stringlib;

export fetch_wild_address (dataset (AutoHeaderV2.layouts.search) ds_search):= function
	
	_row := ds_search[1];
	
	temp_fname_wild_val := _row.tname.fname;
	temp_lname_wild_val := _row.tname.lname;
	temp_prange_value := _row.taddress.prim_range;
	temp_prange_beg_value := _row.taddress.prange_beg;
	temp_prange_end_value := _row.taddress.prange_end;
	temp_prange_wild_value := _row.taddress.prange_wild;
	temp_pname_value := _row.taddress.prim_name;
	temp_pname_wild := Stringlib.StringFind(temp_pname_value, '*', 1) <> 0 or Stringlib.StringFind(temp_pname_value, '?', 1) <> 0;
	temp_pname_wild_val := _row.taddress.prim_name;
	temp_sec_range_value := _row.taddress.sec_range;
	temp_addr_range := _row.taddress._range;
	temp_addr_wild := _row.taddress._wild;
	temp_city_value := _row.taddress.city;
	temp_state_value := _row.taddress.state;
	temp_zip_value := _row.taddress.zip_set;
	temp_prev_state_val1 := _row.taddress.state_prev_1;
	temp_prev_state_val2 := _row.taddress.state_prev_2;
	temp_other_city_value := _row.taddress.city_other;
	temp_other_lname_value1 := _row.tname.lname_other;
	temp_rel_fname_value1 := _row.tname.fname_rel_1;
	temp_rel_fname_value2 := _row.tname.fname_rel_2;
	temp_FuzzySecRange_value := _row.taddress.sec_range_fuzziness;

	// FuzzySecRange, if any: regex pattern for type 2 fuzzy secrange search
	string sec_range_pattern := AutoheaderV2.Functions.GetSecrangeAtomPattern (temp_sec_range_value);

	srange := AutoStandardI.Constants.SECRANGE;

	i_rg_only := dx_header.key_wild_address() (temp_pname_wild_val != '',
					keyed((temp_pname_wild and prim_name[1..3]=temp_pname_wild_val[1..3]) OR (~temp_pname_wild AND  prim_name=temp_pname_wild_val)),
					(~temp_pname_wild OR stringlib.StringWildMatch(prim_name, temp_pname_wild_val, true)), 
			 keyed(temp_prange_value = '' OR 
					temp_prange_value=prim_range OR
					temp_addr_range OR
					temp_addr_wild),
			 keyed(city_code in doxie.Make_CityCodes(temp_city_value).rox OR temp_city_value=''), 
			 keyed(temp_state_value=st OR temp_state_value=''), 
			 wild(zip),
			 temp_zip_value=[] or (integer4)zip IN temp_zip_value,
			 keyed(temp_sec_range_value='' or temp_sec_range_value=sec_range or 
						(temp_FuzzySecRange_value=srange.EXACT_OR_BLANK and sec_range = '') or (temp_FuzzySecRange_value=srange.INCLUDES_ATOM)),
				((temp_FuzzySecRange_value != srange.INCLUDES_ATOM) or regexfind (sec_range_pattern, sec_range)),
			 (~temp_addr_range OR (INTEGER)prim_range >= temp_prange_beg_value AND (INTEGER)prim_range <= temp_prange_end_value),
				temp_prev_state_val1='' or ut.bit_test(states,ut.St2Code(temp_prev_state_val1)),
				temp_prev_state_val2='' or ut.bit_test(states,ut.St2Code(temp_prev_state_val2)),
				temp_lname_wild_val='' OR stringlib.StringWildMatch(lname,temp_lname_wild_val,true),
				temp_fname_wild_val='' OR stringlib.StringWildMatch(fname,temp_fname_wild_val,true),
				temp_other_lname_value1[1]='' or ut.bit_test(lname1,ut.Chr2Code(temp_other_lname_value1[1])),
				temp_other_lname_value1[2]='' or ut.bit_test(lname2,ut.Chr2Code(temp_other_lname_value1[2])),
				temp_other_lname_value1[3]='' or ut.bit_test(lname3,ut.Chr2Code(temp_other_lname_value1[3])),
				not temp_addr_wild OR Stringlib.StringWildMatch(prim_range, temp_prange_wild_value, TRUE));		  
								
	i_ready := PROJECT(i_rg_only, transform (AutoHeaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoHeaderV2.Constants.FetchHit.W_ADDRESS));

  // set up limits and error code depending on whether the search was just by address
	boolean just_addr := temp_lname_wild_val = '' and temp_fname_wild_val = '';
	maxres := if(just_addr, ut.limits.FETCH_JUST_ADDR, ut.limits.FETCH_UNKEYED);
	ec := 	if(just_addr, 11, 203);

	Fetch_Lev := AutoHeaderV2.functions.FetchConstraints(i_ready, ut.limits.FETCH_KEYED, maxres, true, ec, , AutoHeaderV2.Constants.FetchHit.W_ADDRESS);

	RETURN map (trim (temp_pname_wild_val) = '' => AutoHeaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.W_ADDRESS, AutoHeaderV2.Constants.STATUS._DATA),
              exists(Fetch_Lev) => Fetch_Lev,
              AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.W_ADDRESS, AutoHeaderV2.Constants.STATUS._NOT_FOUND));
end;

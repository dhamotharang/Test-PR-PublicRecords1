import ut,doxie;
export fetch_address(
	gl_rewrites.person_interfaces.i__fetch_address in_parms) :=
		function
			i := doxie.Key_Address;

			boolean doSkipFname := LENGTH(TRIM(in_parms.fname_value))<2;
			boolean just_addr := in_parms.lname_value = '' and doSkipFname;

			maxres := if(just_addr, 1000, doxie.Limit_FetchUnkeyed);
			ec := 	if(just_addr, 11, 203);

			index_lev1 := project(
							 i(in_parms.pname_value != '',
						 not (in_parms.SearchIgnoresAddressOnly_value and just_addr),
					 keyed(prim_name=in_parms.pname_value), 
					 keyed(in_parms.prange_value = '' OR 
							in_parms.prange_value=prim_range OR
							in_parms.addr_loose OR
							in_parms.addr_wild),
					 keyed(hash((qstring25)in_parms.city_value)=city_code OR in_parms.city_value=''), 
					 keyed(in_parms.state_value=st OR in_parms.state_value=''), 
					 wild(zip),
					 in_parms.zip_value=[] or (integer4)zip IN in_parms.zip_value,
					 keyed(in_parms.sec_range_value='' or in_parms.sec_range_value=sec_range),
					 (~in_parms.addr_range OR (INTEGER)prim_range >= in_parms.prange_beg_value AND (INTEGER)prim_range <= in_parms.prange_end_value),
						in_parms.prev_state_val1='' or ut.bit_test(states,ut.St2Code(in_parms.prev_state_val1)),
						in_parms.prev_state_val2='' or ut.bit_test(states,ut.St2Code(in_parms.prev_state_val2)),
						keyed(in_parms.lname_value='' OR lname=in_parms.lname_value OR in_parms.phonetics),
						keyed(in_parms.lname_value='' or dph_lname=metaphonelib.DMetaPhone1(in_parms.lname_value)[1..6]),
						doSkipFname or pfname=datalib.preferredfirst(in_parms.fname_value),
						in_parms.other_lname_value1[1]='' or ut.bit_test(lname1,ut.Chr2Code(in_parms.other_lname_value1[1])),
						in_parms.other_lname_value1[2]='' or ut.bit_test(lname2,ut.Chr2Code(in_parms.other_lname_value1[2])),
						in_parms.other_lname_value1[3]='' or ut.bit_test(lname3,ut.Chr2Code(in_parms.other_lname_value1[3])),
						ut.bit_test(lookups, in_parms.lookup_value),
						not in_parms.addr_wild OR Stringlib.StringWildMatch(prim_range, in_parms.prange_wild_value, TRUE)),
									doxie.layout_references);
				

			fetch_lev1_fail := LIMIT(LIMIT(index_lev1,
																		 100000, FAIL(ec, doxie.ErrorCodes(ec)), keyed),
												 maxres, FAIL(ec, doxie.ErrorCodes(ec)));
												
			fetch_lev1_nofail := LIMIT(LIMIT(index_lev1,
										 100000, SKIP, keyed),
									maxres, SKIP);

			fetch_lev1 := IF(in_parms.noFail, fetch_lev1_nofail, fetch_lev1_fail);	
					 
			return fetch_lev1;	   
				
		end;	   
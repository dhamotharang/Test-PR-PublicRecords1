import doxie,ut;
export fetch_header_wild_address(
	gl_rewrites.person_interfaces.i__fetch_header_wild_address in_parms) :=
		function
			i := doxie.Key_Header_Wild_Address;

			boolean just_addr := in_parms.lname_wild_val = '' and in_parms.fname_wild_val = '';

			maxres := if(just_addr, 1000, doxie.Limit_FetchUnkeyed);
			ec := 	if(just_addr, 11, 203);

			i_rg_only := i(in_parms.pname_wild_val != '',
							keyed((in_parms.pname_wild and prim_name[1..3]=in_parms.pname_wild_val[1..3]) OR (~in_parms.pname_wild AND  prim_name=in_parms.pname_wild_val)),
							(~in_parms.pname_wild OR stringlib.StringWildMatch(prim_name, in_parms.pname_wild_val, true)), 
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
						in_parms.lname_wild_val='' OR stringlib.StringWildMatch(lname,in_parms.lname_wild_val,true),
						in_parms.fname_wild_val='' OR stringlib.StringWildMatch(fname,in_parms.fname_wild_val,true),
						in_parms.other_lname_value1[1]='' or ut.bit_test(lname1,ut.Chr2Code(in_parms.other_lname_value1[1])),
						in_parms.other_lname_value1[2]='' or ut.bit_test(lname2,ut.Chr2Code(in_parms.other_lname_value1[2])),
						in_parms.other_lname_value1[3]='' or ut.bit_test(lname3,ut.Chr2Code(in_parms.other_lname_value1[3])),
						ut.bit_test(lookups, in_parms.lookup_value),
						not in_parms.addr_wild OR Stringlib.StringWildMatch(prim_range, in_parms.prange_wild_value, TRUE));		  
						
			i_ready := i_rg_only;	  

			return
				 project(LIMIT(LIMIT(i_ready, 100000, FAIL(ec, doxie.ErrorCodes(ec)), keyed)
					 ,maxres  , FAIL(ec, doxie.ErrorCodes(ec)))
					 
							, doxie.layout_references);
		end;
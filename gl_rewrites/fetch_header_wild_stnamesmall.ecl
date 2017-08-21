import doxie,ut;
export fetch_header_wild_stnamesmall(
	gl_rewrites.person_interfaces.i__fetch_header_wild_stnamesmall in_parms) :=
		function
			i := doxie.Key_Header_Wild_StFnameLname;

			return
				project(  LIMIT (LIMIT(
						 i(in_parms.lname_wild_val != '' AND in_parms.fname_wild_val != '',
						keyed(i.lname[1..3]=in_parms.lname_wild_val[1..3]) and 
										 stringlib.StringWildMatch(i.lname, in_parms.lname_wild_val, true),
						keyed(i.fname[1..3]=in_parms.fname_wild_val[1..3]) and 
										 stringlib.StringWildMatch(i.fname, in_parms.fname_wild_val, true),
						keyed((st=in_parms.state_value or in_parms.state_value='')),
						keyed(in_parms.mname_value='' or in_parms.mname_value[1]=minit OR in_parms.score_threshold_value>10), // TODO: make wild
						keyed(yob>=(unsigned2)in_parms.find_year_low AND 
								yob<=IF((unsigned2)in_parms.find_year_high != 0, (unsigned2)in_parms.find_year_high, (unsigned2)0xFFFF)),
						keyed(LENGTH(TRIM(in_parms.ssn_value))<>4 or (unsigned2)in_parms.ssn_value=s4),
						in_parms.find_month=0 or (dob div 100) % 100=in_parms.find_month,
						in_parms.find_day=0 or dob % 100=in_parms.find_day,
						in_parms.zip_value=[] or zip IN in_parms.zip_value,
						mac_header_indexing.gen_filt(i),
						ut.bit_test(lookups, in_parms.lookup_value)
						 ) , ut.limits.DID_PER_PERSON * 2, SKIP, keyed), 1000, SKIP) 
					, doxie.layout_references);
		end;
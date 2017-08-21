import doxie,ut;
export fetch_header_da(
	gl_rewrites.person_interfaces.i__fetch_header_da in_parms) :=
		function
			i := doxie.Key_Header_DA;

			max_persons := ut.limits .DID_PER_PERSON * 5; //there are less than 1500 'JOH' 'SMIT' in Big Apple

			return
				 project(LIMIT (
						i(keyed(st=in_parms.state_value),
							keyed(city_code=hash((qstring25)in_parms.city_value)),
							keyed(l4=in_parms.lname4_value),
							keyed (f3[1..length(trim(in_parms.fname3_value))]=in_parms.fname3_value),
							in_parms.lname_value='' or lname = in_parms.lname_value,
							in_parms.fname_value='' or (
								datalib.preferredfirst(fname)[1..length(trim(datalib.preferredfirst(in_parms.fname_value)))]=
																														 datalib.preferredfirst(in_parms.fname_value) and
								(in_parms.nicknames or fname[1..length(trim(in_parms.fname_value))]=in_parms.fname_value)),
							mac_header_indexing.gen_filt(i),
							in_parms.find_year_low=0 or yob>=in_parms.find_year_low, in_parms.find_year_high=0 or yob<=in_parms.find_year_high,
							ut.bit_test(lookups, in_parms.lookup_value)), max_persons, SKIP)
								, doxie.layout_references);
		end;
		
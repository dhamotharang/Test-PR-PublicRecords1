import doxie,ut;
export fetch_header_stnamesmall(
	gl_rewrites.person_interfaces.i__fetch_header_stnamesmall in_parms) :=
		function
			i := doxie.Key_Header_StFnameLname;

			pfe(string20 l, string20 r) := l[1..length(trim(datalib.preferredfirst(r)))]=(STRING20)datalib.preferredfirst(r);

			return
				project(  LIMIT (LIMIT(
						 i(in_parms.lname_value != '' AND in_parms.fname_value != '',
						keyed(dph_lname=metaphonelib.DMetaPhone1(in_parms.lname_value)[1..6]),
						keyed((lname=in_parms.lname_value OR in_parms.phonetics)),
						keyed(pfe(pfname,in_parms.fname_value) OR pfname=(STRING1)in_parms.fname_value OR pfname[1..length(trim(in_parms.fname_value))]=(STRING20)in_parms.fname_value OR LENGTH(TRIM(in_parms.fname_value))<2),
						keyed(fname[1..length(trim(in_parms.fname_value))]=in_parms.fname_value OR fname=(STRING1)in_parms.fname_value OR in_parms.nicknames), 
						keyed((st=in_parms.state_value or in_parms.state_value='')),
						keyed(in_parms.mname_value='' or in_parms.mname_value[1]=minit OR in_parms.score_threshold_value>10), // TODO: make wild
						keyed(yob>=(unsigned2)in_parms.find_year_low AND 
								yob<=IF((unsigned2)in_parms.find_year_high != 0, (unsigned2)in_parms.find_year_high, (unsigned2)0xFFFF)),
						keyed(LENGTH(TRIM(in_parms.ssn_value))<>4 or (unsigned2)in_parms.ssn_value=s4),
						in_parms.find_month=0 or (dob div 100) % 100=in_parms.find_month,
						in_parms.find_day=0 or dob % 100=in_parms.find_day,
						in_parms.zip_value=[] or zip IN in_parms.zip_value,
						gl_rewrites.mac_header_indexing.gen_filt(i),
						ut.bit_test(lookups, in_parms.lookup_value)
						 ) , ut.limits.DID_PER_PERSON * 2, SKIP, keyed), 1000, SKIP)
					, doxie.layout_references);
		end;
		
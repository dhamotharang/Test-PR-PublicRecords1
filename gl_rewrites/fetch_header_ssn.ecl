import doxie,ut;
export fetch_header_ssn(
	gl_rewrites.person_interfaces.i__fetch_header_ssn in_parms) :=
		function
			i := doxie.Key_Header_SSN;
			pfe(string20 l, string20 r) := l[1..length(trim(datalib.preferredfirst(r)))]=datalib.preferredfirst(r);
			unsigned1 mplname_len_raw := length(metaphonelib.DMetaPhone1(in_parms.lname_value));
			unsigned1 mplname_len :=
				map(in_parms.lname_value = '' => 1,  //rather than zero to keep the string indexing happy below
						mplname_len_raw < 6 => mplname_len_raw,
						6);
			ds_header_non_fuzzy := 
				LIMIT (i(keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])), ut.limits.DID_PER_PERSON, SKIP);

			//arbitrary restriction for fuzzy
			fuzzy_lim := ut.limits.DID_PER_PERSON * 2;
			ds_header_fuzzy := 
				LIMIT (i(wild(s1),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])), fuzzy_lim, SKIP) +
				LIMIT (i(keyed(s1=in_parms.ssn_value[1]),wild(s2),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])), fuzzy_lim, SKIP) +
				LIMIT (i(keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),wild(s3),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])), fuzzy_lim, SKIP) +
				LIMIT (i(keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),wild(s4),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])), fuzzy_lim, SKIP) +
				LIMIT (i(keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),wild(s5),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])), fuzzy_lim, SKIP) +
				LIMIT (i(keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),wild(s6),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])), fuzzy_lim, SKIP) +
				LIMIT (i(keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),wild(s7),keyed(s8=in_parms.ssn_value[8]),keyed(s9=in_parms.ssn_value[9])), fuzzy_lim, SKIP) +
				LIMIT (i(keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),wild(s8),keyed(s9=in_parms.ssn_value[9])), fuzzy_lim, SKIP) +
				LIMIT (i(keyed(s1=in_parms.ssn_value[1]),keyed(s2=in_parms.ssn_value[2]),keyed(s3=in_parms.ssn_value[3]),keyed(s4=in_parms.ssn_value[4]),keyed(s5=in_parms.ssn_value[5]),keyed(s6=in_parms.ssn_value[6]),keyed(s7=in_parms.ssn_value[7]),keyed(s8=in_parms.ssn_value[8])), fuzzy_lim, SKIP);

			p := project(
			map( ~in_parms.fuzzy_ssn OR in_parms.isCRS =>
				ds_header_non_fuzzy,
				ds_header_fuzzy)
								(in_parms.score_threshold_value > 10 OR in_parms.isCRS OR
								((in_parms.lname_value='' or dph_lname[1..mplname_len]=metaphonelib.DMetaPhone1(in_parms.lname_value)[1..mplname_len]) AND 
								 (LENGTH(TRIM(in_parms.fname_value))<2 or pfe(pfname,in_parms.fname_value))))
							, doxie.layout_references);
							
			GoodSSNOnly := join(p, doxie.Key_Header,
								keyed(left.did > 0 and left.did = right.s_did) and
								right.valid_ssn = 'G' and
								right.ssn = in_parms.ssn_value,
								transform(doxie.layout_references, self := left),
								keep(1),
								limit(ut.limits.DID_PER_PERSON * 2, skip));
							
			return if(in_parms.SearchGoodSSNOnly_value, GoodSSNOnly, p);
		end;

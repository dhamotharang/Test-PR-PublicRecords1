import doxie,ut;
export fetch_header_wild_ssn(
	gl_rewrites.person_interfaces.i__fetch_header_wild_ssn in_parms) :=
		function
			i := doxie.Key_Header_Wild_SSN;

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

			// limit for non-fuzzy is 500, for fuzzy 500*(number of chars in ssn) -- arbitrary restriction;
			// it's worth considering setting individual limit for each fuzzy character
			return project(
			map( ~in_parms.fuzzy_ssn OR in_parms.isCRS => ds_header_non_fuzzy, ds_header_fuzzy)
								(in_parms.score_threshold_value > 10 OR in_parms.isCRS OR 
								 (in_parms.lname_wild_val='' OR stringlib.StringWildMatch(lname, in_parms.lname_wild_val, true)) and 
							(in_parms.fname_wild_val='' OR stringlib.StringWildMatch(fname, in_parms.fname_wild_val, true))), doxie.layout_references);
		end;
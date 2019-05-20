import ut,doxie,dx_header,AutoHeaderV2, lib_stringlib;

export fetch_wild_SSN (dataset (AutoHeaderV2.layouts.search) ds_search) := function
		
	_row := ds_search[1];
	_options := ds_search[1].options;

	temp_isCRS := _options.isCRS;
	temp_fname_wild_val := _row.tname.fname;
	temp_lname_wild_val := _row.tname.lname;
	temp_ssn_value := _row.tssn.ssn;
	temp_fuzzy_ssn := _row.tssn.fuzzy_ssn;
	temp_score_threshold_value := _options.score_threshold;

	i := dx_header.key_wild_SSN();

	ds_header_non_fuzzy := 
		LIMIT (i(keyed(s1=temp_ssn_value[1]),keyed(s2=temp_ssn_value[2]),keyed(s3=temp_ssn_value[3]),keyed(s4=temp_ssn_value[4]),keyed(s5=temp_ssn_value[5]),keyed(s6=temp_ssn_value[6]),keyed(s7=temp_ssn_value[7]),keyed(s8=temp_ssn_value[8]),keyed(s9=temp_ssn_value[9])), ut.limits.DID_PER_PERSON, SKIP);

	//arbitrary restriction for fuzzy
	fuzzy_lim := ut.limits.DID_PER_PERSON * 2;
	ds_header_fuzzy := 
		LIMIT (i(wild(s1),keyed(s2=temp_ssn_value[2]),keyed(s3=temp_ssn_value[3]),keyed(s4=temp_ssn_value[4]),keyed(s5=temp_ssn_value[5]),keyed(s6=temp_ssn_value[6]),keyed(s7=temp_ssn_value[7]),keyed(s8=temp_ssn_value[8]),keyed(s9=temp_ssn_value[9])), fuzzy_lim, SKIP) +
		LIMIT (i(keyed(s1=temp_ssn_value[1]),wild(s2),keyed(s3=temp_ssn_value[3]),keyed(s4=temp_ssn_value[4]),keyed(s5=temp_ssn_value[5]),keyed(s6=temp_ssn_value[6]),keyed(s7=temp_ssn_value[7]),keyed(s8=temp_ssn_value[8]),keyed(s9=temp_ssn_value[9])), fuzzy_lim, SKIP) +
		LIMIT (i(keyed(s1=temp_ssn_value[1]),keyed(s2=temp_ssn_value[2]),wild(s3),keyed(s4=temp_ssn_value[4]),keyed(s5=temp_ssn_value[5]),keyed(s6=temp_ssn_value[6]),keyed(s7=temp_ssn_value[7]),keyed(s8=temp_ssn_value[8]),keyed(s9=temp_ssn_value[9])), fuzzy_lim, SKIP) +
		LIMIT (i(keyed(s1=temp_ssn_value[1]),keyed(s2=temp_ssn_value[2]),keyed(s3=temp_ssn_value[3]),wild(s4),keyed(s5=temp_ssn_value[5]),keyed(s6=temp_ssn_value[6]),keyed(s7=temp_ssn_value[7]),keyed(s8=temp_ssn_value[8]),keyed(s9=temp_ssn_value[9])), fuzzy_lim, SKIP) +
		LIMIT (i(keyed(s1=temp_ssn_value[1]),keyed(s2=temp_ssn_value[2]),keyed(s3=temp_ssn_value[3]),keyed(s4=temp_ssn_value[4]),wild(s5),keyed(s6=temp_ssn_value[6]),keyed(s7=temp_ssn_value[7]),keyed(s8=temp_ssn_value[8]),keyed(s9=temp_ssn_value[9])), fuzzy_lim, SKIP) +
		LIMIT (i(keyed(s1=temp_ssn_value[1]),keyed(s2=temp_ssn_value[2]),keyed(s3=temp_ssn_value[3]),keyed(s4=temp_ssn_value[4]),keyed(s5=temp_ssn_value[5]),wild(s6),keyed(s7=temp_ssn_value[7]),keyed(s8=temp_ssn_value[8]),keyed(s9=temp_ssn_value[9])), fuzzy_lim, SKIP) +
		LIMIT (i(keyed(s1=temp_ssn_value[1]),keyed(s2=temp_ssn_value[2]),keyed(s3=temp_ssn_value[3]),keyed(s4=temp_ssn_value[4]),keyed(s5=temp_ssn_value[5]),keyed(s6=temp_ssn_value[6]),wild(s7),keyed(s8=temp_ssn_value[8]),keyed(s9=temp_ssn_value[9])), fuzzy_lim, SKIP) +
		LIMIT (i(keyed(s1=temp_ssn_value[1]),keyed(s2=temp_ssn_value[2]),keyed(s3=temp_ssn_value[3]),keyed(s4=temp_ssn_value[4]),keyed(s5=temp_ssn_value[5]),keyed(s6=temp_ssn_value[6]),keyed(s7=temp_ssn_value[7]),wild(s8),keyed(s9=temp_ssn_value[9])), fuzzy_lim, SKIP) +
		LIMIT (i(keyed(s1=temp_ssn_value[1]),keyed(s2=temp_ssn_value[2]),keyed(s3=temp_ssn_value[3]),keyed(s4=temp_ssn_value[4]),keyed(s5=temp_ssn_value[5]),keyed(s6=temp_ssn_value[6]),keyed(s7=temp_ssn_value[7]),keyed(s8=temp_ssn_value[8])), fuzzy_lim, SKIP);

	// limit for non-fuzzy is 500, for fuzzy 500*(number of chars in ssn) -- arbitrary restriction;
	// it's worth considering setting individual limit for each fuzzy character
	res_final := project(
							map( ~temp_fuzzy_ssn OR temp_isCRS => ds_header_non_fuzzy, ds_header_fuzzy)
												(temp_score_threshold_value > 10 OR temp_isCRS OR 
												 (temp_lname_wild_val='' OR stringlib.StringWildMatch(lname, temp_lname_wild_val, true)) and 
											(temp_fname_wild_val='' OR stringlib.StringWildMatch(fname, temp_fname_wild_val, true))), 
											transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.W_SSN));
	
	return if(exists(res_final), res_final, AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.W_SSN, AutoHeaderV2.Constants.STATUS._NOT_FOUND));
end;

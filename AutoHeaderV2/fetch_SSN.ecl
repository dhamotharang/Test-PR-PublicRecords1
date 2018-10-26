import ut,doxie,NID,watchdog,autokey,header_quick,AutoHeaderV2,lib_metaphone,dx_BestRecords;

export fetch_SSN (dataset (AutoheaderV2.layouts.search) ds_search) := function

  _row := ds_search[1];
  _options := ds_search[1].options;

	temp_isCRS := _options.isCRS;
	temp_fname_value := _row.tname.fname;
	temp_lname_value := _row.tname.lname;
	temp_ssn_value := _row.tssn.ssn;
	temp_fuzzy_ssn := _row.tssn.fuzzy_ssn;
	temp_searchgoodssnonly_value := _row.tssn.only_good_ssn;
	temp_score_threshold_value := _options.score_threshold;
	useSSnPartialFetch :=  _row.tssn.partial_ssn;
	i := doxie.Key_Header_SSN;

	pfe(string20 l, string20 r) := NID.mod_PFirstTools.SubLinPFR(l, r);
	unsigned1 mplname_len_raw := length(metaphonelib.DMetaPhone1(temp_lname_value));
	unsigned1 mplname_len :=
		map(temp_lname_value = '' => 1,  //rather than zero to keep the string indexing happy below
				mplname_len_raw < 6 => mplname_len_raw,
				6);

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

	p0 := project(
	map( ~temp_fuzzy_ssn OR temp_isCRS => ds_header_non_fuzzy, ds_header_fuzzy)
						(temp_score_threshold_value > 10 OR temp_isCRS OR
						((temp_lname_value='' or dph_lname[1..mplname_len]=metaphonelib.DMetaPhone1(temp_lname_value)[1..mplname_len]) AND 
						 (LENGTH(TRIM(temp_fname_value))<2 or pfe(pfname,temp_fname_value)))),
				transform (AutoheaderV2.layouts.search_out, self.did := left.did, 
                                                    self.fetch_hit := AutoheaderV2.Constants.FetchHit.SSN,
                                                    self.index_hit := AutoheaderV2.Constants.IndexHit.SSN));
					
					// Needs to SSNFAllBack only if it is requested and only if Strict SSN Match doesn't fetch any results.
	// here input SSN is always 9 digits, so both partial searches are legit
	SSNPartial_Fetch1 := AutoheaderV2.fetch_SSNPartial (project (ds_search, transform (AutoheaderV2.layouts.search, Self.tssn.ssn := temp_ssn_value[1..5], self := left)));
	SSNPartial_Fetch2 := AutoheaderV2.fetch_SSNPartial (project (ds_search, transform (AutoheaderV2.layouts.search, Self.tssn.ssn := temp_ssn_value[6..9], self := left)));
	SSNPartial_Fetch := SSNPartial_Fetch1 + SSNPartial_Fetch2;

	p := p0+ IF((~temp_fuzzy_ssn OR temp_isCRS )	AND NOT EXISTS(p0) AND useSSnPartialFetch
					,SSNPartial_Fetch);
					
	best_recs := dx_BestRecords.append(p, did, dx_BestRecords.Constants.perm_type.glb, left_outer := false);
	GoodSSNOnly := project(best_recs(_best.valid_ssn = 'G' and _best.ssn = temp_ssn_value), 
		transform(recordof(p), self := left));

	ssn_res := if(temp_SearchGoodSSNOnly_value, GoodSSNOnly, p);

	// output ((~temp_fuzzy_ssn OR temp_isCRS )	AND NOT EXISTS(p0) AND useSSnPartialFetch, named ('is_ssn_partial'));
	// output (SSNPartial_Fetch, named ('SSNPartial_Fetch'));

  // If the searched and found a new SSN in the QH, we better account for it
  qhdids := autokey.Key_SSN(header_quick.str_AutokeyName) (
              keyed(s1=temp_ssn_value[1]), keyed(s2=temp_ssn_value[2]), keyed(s3=temp_ssn_value[3]),
              keyed(s4=temp_ssn_value[4]), keyed(s5=temp_ssn_value[5]), keyed(s6=temp_ssn_value[6]),
              keyed(s7=temp_ssn_value[7]),keyed(s8=temp_ssn_value[8]),keyed(s9=temp_ssn_value[9]));

  ssn_quick := project (limit (qhdids, 100, skip), transform (AutoheaderV2.layouts.search_out, 
                                                              Self.did       := Left.did, 
                                                              self.fetch_hit := AutoheaderV2.Constants.FetchHit.SSN,
                                                              self.index_hit := AutoheaderV2.Constants.FetchHit.QUICK_SSN));

  //NB: exact, fuzzy and partial fetches are mutually exclusive; ssn quick search may bring duplicate DIDs
  res_final := dedup (ssn_res + ssn_quick, did, index_hit, all);
	return if(exists(res_final), res_final, AutoHeaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.SSN, AutoheaderV2.Constants.STATUS._NOT_FOUND));
end;

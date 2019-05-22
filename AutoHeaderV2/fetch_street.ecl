IMPORT ut,doxie,dx_header,NID,AutoHeaderV2, lib_stringlib, lib_ziplib;

// used only in search library
export dataset (AutoheaderV2.layouts.search_out) fetch_street (dataset (AutoheaderV2.layouts.search) ds_search, integer search_code=0) := function

  _row := ds_search[1];
  _options := ds_search[1].options;
  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;

		temp_isCRS := _options.isCRS;
		temp_fname_value := _row.tname.fname;
		temp_fname_set_value := _row.tname.fname_set;
		temp_nicknames := _row.tname.nicknames;
		temp_lname_value := _row.tname.lname;
		temp_lname_set_value := _row.tname.lname_set;
		temp_lnamephoneticset := _row.tname.lname_set_phonetic;
		temp_phonetics :=  _row.tname.phonetic;
		temp_usephoneticdistance := _row.tname.phonetic_distance;
		temp_prange_value := _row.taddress.prim_range;
		temp_prange_wild_value := _row.taddress.prange_wild;
		temp_pname_value := _row.taddress.prim_name;
		temp_addr_range := _row.taddress._range;
		temp_addr_wild := _row.taddress._wild;
		temp_zip_val := _row.taddress.zip5;
		temp_zip_value := _row.taddress.zip_set;
		temp_zipradius_value :=  _row.taddress.zip_radius;
		temp_city_zip_value := ziplib.CityToZip5(_row.taddress.state, _row.taddress.city);
		temp_phone_value := _row.tphone.phone10;
		temp_did_value := _row.did;
		temp_ssn_value :=  _row.tssn.ssn;
		temp_prev_state_val1 := _row.taddress.state_prev_1;
		temp_prev_state_val2 := _row.taddress.state_prev_2;
		temp_other_lname_value1 := _row.tname.lname_other;
		temp_other_city_value := _row.taddress.city_other;
		temp_rel_fname_value1 := _row.tname.fname_rel_1;
		temp_rel_fname_value2 :=  _row.tname.fname_rel_2;
		temp_lookup_value := _options._lookup;
		temp_date_first_seen_value := _row.taddress.date_firstseen;
		temp_date_last_seen_value := _row.taddress.date_lastseen;
		temp_allow_date_seen_value := _row.taddress.allow_dateseen;
		temp_BpsLeadingNameMatch_value := _row.tname.leading_name_match;
		// temp_lname_trailing_value := AutoStandardI.InterfaceTranslator.lname_trailing_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_trailing_value.params));
		// temp_fname_trailing_value := AutoStandardI.InterfaceTranslator.fname_trailing_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.fname_trailing_value.params));
    temp_lname_trailing_value := _row.tname.lname != '' and _row.tname.fname = '' and _row.tname.mname = '';
		temp_fname_trailing_value := _row.tname.lname != '' and _row.tname.fname != '' and _row.tname.mname = '';
    temp_prim_range_set := _row.taddress.prim_range_set;
		
		i := dx_header.key_StreetZipName();
		wi := dx_header.key_wild_StreetZipName();
		dti := dx_header.key_DTS_StreetZipName();
		
		boolean just_addr := temp_lname_value = '' and temp_fname_value = '';

		ec := 	if(just_addr, 11, 203);


    //? by usage DID cannot be zero here
		first_fil := (temp_pname_value<>'' AND temp_zip_value<>[]) AND
									// To Prevent extra work
									(length(trim(temp_ssn_value))<>9 AND temp_did_value=0 AND temp_phone_value='');
		
		gen_fil := AutoheaderV2.MAC_indexing.gen_filt(wi) AND (temp_lookup_value=0 OR ut.bit_test(wi.lookups, temp_lookup_value));
		AutoheaderV2.MAC_indexing.zip1(wi,zip1_fil)
		AutoheaderV2.MAC_indexing.pname(wi,pname_fil)
		AutoheaderV2.MAC_indexing.lname_fname(wi,lname_fil,fname_fil)
		prange_fil := temp_prange_value='' OR (temp_addr_wild AND ~temp_addr_range) OR wi.prim_range=temp_prange_value OR
		              (temp_addr_range and (wi.prim_range IN temp_prim_range_set));
		prange_postfil := ~temp_addr_wild OR Stringlib.StringWildMatch(wi.prim_range, temp_prange_wild_value, TRUE);


		index_Lev1 := PROJECT(wi(
													keyed(pname_fil),
													keyed(zip1_fil),
													keyed(lname_fil OR temp_lname_value=''),
													keyed(fname_fil), 
													keyed(prange_fil),
													prange_postfil,
													gen_fil), 
      transform (AutoheaderV2.layouts.search_out, self.did := left.did, self.fetch_hit := AutoheaderV2.Constants.FetchHit.STREET));

		maxres := if(just_addr, ut.limits.FETCH_JUST_ADDR, ut.limits.FETCH_UNKEYED);

		Fetch_Lev1 := AutoheaderV2.functions.FetchConstraints(index_Lev1,ut.limits.FETCH_KEYED,maxres,no_fail,203,,AutoheaderV2.Constants.FetchHit.STREET);

		gen_fil2 := AutoheaderV2.MAC_indexing.gen_filt(i) AND (temp_lookup_value=0 OR ut.bit_test(i.lookups, temp_lookup_value));
		AutoheaderV2.MAC_indexing.pref(i,pref_fil2)
		AutoheaderV2.MAC_indexing.zip(i,zip_fil2)
		AutoheaderV2.MAC_indexing.pname(i,pname_fil2)
		AutoheaderV2.MAC_indexing.phon_dist(i,phon_fil2)
		AutoheaderV2.MAC_indexing.lname_fname(i,lname_fil2,fname_fil2)
		prange_fil2 := temp_prange_value='' OR (temp_addr_wild AND ~temp_addr_range) OR i.prim_range=temp_prange_value OR
		               (temp_addr_range AND (i.prim_range IN temp_prim_range_set));
		prange_postfil2 := ~temp_addr_wild OR Stringlib.StringWildMatch(i.prim_range, temp_prange_wild_value, TRUE);
							 
		index_Lev2 := PROJECT(i(
													keyed(pname_fil2),
													keyed(zip_fil2 AND zip NOT IN [(integer4)temp_zip_val,(integer4)temp_city_zip_value]),
													keyed(phon_fil2 OR temp_lname_value=''),
													keyed(lname_fil2 OR temp_lname_value=''),
													keyed(pref_fil2 OR LENGTH(TRIM(temp_fname_value))<2),
													keyed(fname_fil2 OR temp_nicknames), 
													keyed(prange_fil2),
													prange_postfil2,
													gen_fil2),
      transform (AutoheaderV2.layouts.search_out, self.did := left.did, self.fetch_hit := AutoheaderV2.Constants.FetchHit.STREET));

		maxres2 := if(just_addr, ut.limits.FETCH_JUST_ADDR, ut.limits.FETCH_LEV2_UNKEYED);

		Fetch_Lev2 := AutoheaderV2.functions.FetchConstraints(index_Lev2,ut.limits.FETCH_KEYED,maxres2,exists(Fetch_Lev1) or no_fail,ec,,AutoheaderV2.Constants.FetchHit.STREET);
			//here we are going to fail (rather than skip) when lev1 = 0 and lev2 exceeds

		index_Lev3 := project(i(
													keyed(pname_fil2),
													keyed(zip_fil2),
													keyed(phon_fil2 OR temp_lname_value=''),
													keyed(lname<>temp_lname_value),
													keyed(pref_fil2 OR LENGTH(TRIM(temp_fname_value))<2),
													keyed(fname_fil2 OR temp_nicknames), 
													keyed(prange_fil2),
													prange_postfil2,
													gen_fil2),
                          transform (AutoheaderV2.layouts.search_out, self.did := left.did, self.fetch_hit := AutoheaderV2.Constants.FetchHit.STREET));
													
		Fetch_Lev3 := AutoheaderV2.functions.FetchConstraints(index_Lev3,ut.limits.FETCH_KEYED,maxres2,true,ec,,AutoheaderV2.Constants.FetchHit.STREET);


		zips := dataset(temp_zip_value,{unsigned3 z});
		boolean tooloose := count(zips) > 250 and temp_lname_value = '' and temp_prange_value = '';//RR in big zip radius with no lname gave problems
		loosefail := Fail(Fetch_Lev2, 11, doxie.ErrorCodes(11));

		//adding fetch by dt_seen
		gen_fil_dt := AutoheaderV2.MAC_indexing.gen_filt(dti) AND (temp_lookup_value=0 OR ut.bit_test(dti.lookups, temp_lookup_value));
		AutoheaderV2.MAC_indexing.zip1(dti,zip1_fil_dt)
		AutoheaderV2.MAC_indexing.pname(dti,pname_fil_dt)
		AutoheaderV2.MAC_indexing.lname_fname(dti,lname_fil_dt,fname_fil_dt)
		AutoheaderV2.MAC_indexing.phon(dti,phon_fil_dt)
		AutoheaderV2.MAC_indexing.pref(dti,pref_fil_dt)
		prange_fil_dt := temp_prange_value='' OR (temp_addr_wild AND ~temp_addr_range) OR dti.prim_range=temp_prange_value OR
		                 (temp_addr_range AND (dti.prim_range IN temp_prim_range_set));
		prange_postfil_dt := ~temp_addr_wild OR Stringlib.StringWildMatch(dti.prim_range, temp_prange_wild_value, TRUE);

		index_LevDt := PROJECT(dti(
													 keyed(pname_fil_dt),
													 keyed(zip1_fil_dt),
													 keyed(temp_date_first_seen_value=0 and dt_last_seen >= temp_date_last_seen_value or 
																 temp_date_first_seen_value<>0 and dt_last_seen >= temp_date_first_seen_value),
													 keyed(phon_fil_dt),
													 keyed(pref_fil_dt),
													 keyed(prange_fil_dt),
													 keyed(lname_fil_dt OR temp_lname_value=''),
													 keyed(fname_fil_dt), 
																														dt_first_seen <= temp_date_last_seen_value,	
													 prange_postfil_dt,
													 gen_fil_dt),
                           transform (AutoheaderV2.layouts.search_out, self.did := left.did, self.fetch_hit := AutoheaderV2.Constants.FetchHit.STREET));

		Fetch_LevDt := AutoheaderV2.functions.FetchConstraints(index_LevDt,ut.limits.FETCH_KEYED,ut.limits.FETCH_UNKEYED,no_fail,203,,AutoheaderV2.Constants.FetchHit.STREET);

		Fetch_LevOt :=	choosen(Fetch_Lev1 &
							IF(~temp_isCRS AND temp_zipradius_value<>0,
								 if(tooloose, if(not EXISTS(Fetch_Lev1), loosefail), Fetch_Lev2)) &
							IF(~temp_isCRS AND (temp_phonetics or temp_nicknames),
								 Fetch_Lev3),
							ut.limits.FETCH_UNKEYED);
		
    //change: by usage always temp_pname_value != ''
    search_res := if(temp_allow_date_seen_value and temp_date_last_seen_value<>0,// and temp_pname_value<>'',
                     Fetch_LevDt, Fetch_LevOt);
										 
    //change: first_fil moved here
    //change: dedup here
		final_res := if (first_fil, 
										 if(exists(search_res), 
												dedup (search_res, did, all),
												AutoheaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.STREET, AutoheaderV2.Constants.STATUS._NOT_FOUND)),
										 AutoheaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.STREET, AutoheaderV2.Constants.Status._DATA));
									
		return final_res;
end;

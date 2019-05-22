import ut,doxie,dx_header,NID,AutoHeaderV2;

export fetch_StName (dataset (AutoHeaderV2.layouts.search) ds_search, integer search_code=0) := function
	_row := ds_search[1];
  _options := ds_search[1].options;
  boolean no_fail := search_code & AutoHeaderV2.Constants.SearchCode.NOFAIL > 0;

	temp_isCRS := _options.isCRS;
	temp_fname_value :=_row.tname.fname;
	temp_fname_set_value := _row.tname.fname_set;
	temp_nicknames := _row.tname.nicknames;
	temp_mname_value := _row.tname.mname;
	temp_lname_value := _row.tname.lname;
	temp_lname_set_value := _row.tname.lname_set;
	temp_lnamephoneticset := _row.tname.lname_set_phonetic;
	temp_phonetics := _row.tname.phonetic; 
	temp_usephoneticdistance := _row.tname.phonetic_distance;
	temp_city_value := _row.taddress.city;
	temp_state_value := _row.taddress.state;
	temp_zip_value := _row.taddress.zip_set;
	temp_phone_value := _row.tphone.phone10;

  // DOB-related values
	dob_mod := doxie.DOBTools (_row.tdob.dob);
	temp_find_year_high := dob_mod.find_year_high (_row.tdob.agelow);
	temp_find_year_low  := dob_mod.find_year_low (_row.tdob.agehigh);
	temp_find_month     := dob_mod.find_month;
	temp_find_day       := dob_mod.find_day;

	temp_did_value := _row.did;
	temp_ssn_value := _row.tssn.ssn;
	temp_prev_state_val1 := _row.taddress.state_prev_1;
	temp_prev_state_val2 := _row.taddress.state_prev_2;
	temp_other_lname_value1 := _row.tname.lname_other;
	temp_other_city_value := _row.taddress.city_other;
	temp_rel_fname_value1 := _row.tname.fname_rel_1;
	temp_rel_fname_value2 := _row.tname.fname_rel_2;
	temp_non_exclusion_value := _options.nonexclusion or _options.ln_branded and ~_options.strict_match;
	temp_BpsLeadingNameMatch_value := _row.tname.leading_name_match;
	temp_lname_trailing_value := _row.tname.lname != '' and _row.tname.fname = '' and _row.tname.mname = '';
	temp_fname_trailing_value := _row.tname.lname != '' and _row.tname.fname != '' and _row.tname.mname = '';

	i := dx_header.key_StFnameLname();
	// use wild key for level 1 fetch 
	wi := dx_header.key_wild_StFnameLname();

	first_fil := (temp_lname_value != '') AND
								// To Prevent extra work
								(temp_zip_value=[] AND length(trim(temp_ssn_value))<>9 AND temp_did_value=0 AND
								temp_phone_value='' AND temp_city_value='');
	
	AutoheaderV2.MAC_indexing.gen_withdobfilt(wi, gen_fil,TRUE)
	AutoheaderV2.MAC_indexing.state(wi, state_fil)
	AutoheaderV2.MAC_indexing.lname_fname(wi, lname_fil, fname_fil)
	AutoheaderV2.MAC_indexing.mname_yob_ssn4(wi, mname_fil, yob_fil, ssn4_fil)

	index_lev1 := PROJECT(wi(keyed(state_fil),   
													 keyed(lname_fil),
													 keyed(fname_fil),
													 keyed(mname_fil or temp_non_exclusion_value),
													 keyed(yob_fil),
													 keyed(ssn4_fil or LENGTH(TRIM(temp_ssn_value))<>4),
													 gen_fil),
													 transform (AutoHeaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoHeaderV2.Constants.FetchHit.STNAME));

	Fetch_Lev1 := AutoHeaderV2.functions.FetchConstraints(index_Lev1,ut.limits.FETCH_KEYED,ut.limits.FETCH_UNKEYED,no_fail,203,,AutoHeaderV2.Constants.FetchHit.STNAME);
	index_lev1_noMN := PROJECT(wi(keyed(state_fil),   
																keyed(lname_fil),
																keyed(fname_fil),
																WILD(minit),
																keyed(yob_fil),
																keyed(ssn4_fil or LENGTH(TRIM(temp_ssn_value))<>4),
																gen_fil),
																transform (AutoHeaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoHeaderV2.Constants.FetchHit.STNAME));

	// called with skip=TRUE so that it never fails
	Fetch_Lev1_noMN := AutoHeaderV2.functions.FetchConstraints(index_Lev1_noMN,ut.limits.FETCH_KEYED,ut.limits.FETCH_UNKEYED,true,203,,AutoHeaderV2.Constants.FetchHit.STNAME);

	// only do the contingent fetch if necessary						
	Fetch_Lev1_cont := IF(~exists(Fetch_Lev1) and ~temp_non_exclusion_value, Fetch_Lev1_noMN);
	// output a message indicating that removal of MN would produce header results
	// messages := IF(exists(Fetch_Lev1_cont), ut.MessageCode(ut.constants_MessageCodes.REMOVE_MNAME,''));

	AutoheaderV2.MAC_indexing.gen_withdobfilt(i,gen_fil2,TRUE)
	AutoheaderV2.MAC_indexing.pref(i,pref_fil2)
	AutoheaderV2.MAC_indexing.state(i,state_fil2)
	AutoheaderV2.MAC_indexing.phon_dist(i,phon_fil2)
	AutoheaderV2.MAC_indexing.lname_fname(i,lname_fil2,fname_fil2)
	AutoheaderV2.MAC_indexing.mname_yob_ssn4(i,mname_fil2,yob_fil2,ssn4_fil2)
		 
	index_Lev2 := project(
						i(keyed(state_fil2),   
							keyed(phon_fil2),
							keyed(lname_fil2 OR temp_phonetics),
							keyed(pref_fil2 OR LENGTH(TRIM(temp_fname_value))<2),
							keyed(fname_fil2 OR temp_nicknames),
							keyed(mname_fil2 OR temp_non_exclusion_value),
							(lname<>temp_lname_value OR temp_nicknames),
							nofold(yob_fil2),
							nofold(ssn4_fil2 or LENGTH(TRIM(temp_ssn_value))<>4),
							nofold(gen_fil2)), 
							transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.STNAME));

	// only fail the Fetch_Lev2 if neither Fetch_Lev1 nor the contingent Fetch produce results
	Fetch_Lev2 := AutoHeaderV2.functions.FetchConstraints(index_Lev2,ut.limits.FETCH_KEYED,ut.limits.FETCH_LEV2_UNKEYED,exists(Fetch_Lev1) or exists(Fetch_Lev1_cont) or no_fail,203,,AutoHeaderV2.Constants.FetchHit.STNAME);

	search_res := choosen(Fetch_Lev1 & IF(~temp_isCRS AND (temp_Phonetics OR temp_Nicknames), Fetch_Lev2), ut.limits.FETCH_UNKEYED);
	
	final_res := if (first_fil, 
									 if(exists(search_res),
											search_res,
											AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.STNAME, AutoHeaderV2.Constants.Status._NOT_FOUND)
											) 
										+ if(exists(Fetch_Lev1_cont), AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.STNAME, AutoHeaderV2.Constants.Status._MNAME)),
										AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.STNAME, AutoHeaderV2.Constants.Status._DATA));
	
	return final_res;
end;

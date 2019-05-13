import ut,doxie,dx_header,NID, AutoStandardI,AutoHeaderV2;

export fetch_name (dataset (AutoheaderV2.layouts.search) ds_search, integer search_code=0) := function
	_row := ds_search[1];
  _options := ds_search[1].options;
  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;
	
	temp_isCRS := _options.isCRS;
	temp_fname_value := _row.tname.fname;
	temp_fname_set_value := _row.tname.fname_set;
	temp_fname3_value := _row.tname.fname3;
	temp_nicknames := _row.tname.nicknames;
	temp_mname_value := _row.tname.mname;
	temp_lname_value := _row.tname.lname;
	temp_lname4_value := _row.tname.lname4;
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
	temp_strict_match_value := _options.strict_match;
	temp_non_exclusion_value := (_options.nonexclusion or _options.ln_branded) and ~temp_strict_match_value;
	temp_ln_branded_value := _options.ln_branded;
	temp_score_threshold_value := _options.score_threshold;
	temp_BpsLeadingNameMatch_value := _row.tname.leading_name_match;
	temp_lname_trailing_value := _row.tname.lname != '' and _row.tname.fname = '' and _row.tname.mname = '';
	temp_fname_trailing_value := _row.tname.lname != '' and _row.tname.fname != '' and _row.tname.mname = '';

	i := dx_header.key_name();
	wi := dx_header.key_wild_name();
	i2:=dx_header.key_name_alt();

	first_fil := (temp_lname_value<>'') AND 
								// To Prevent extra work
								(temp_zip_value=[] AND length(trim(temp_ssn_value))<>9 AND temp_did_value=0 AND
								temp_phone_value='' AND temp_city_value='' AND temp_state_value='');

	boolean just_name := temp_other_lname_value1 = '' and 
					 temp_rel_fname_value1 = '' and
					 temp_find_year_low = 0 and 
					 temp_find_year_high = 0  and 
					 temp_ssn_value = '';

	maxres := if(just_name, ut.limits.FETCH_JUST_NAME, ut.limits.FETCH_UNKEYED);
	
	AutoheaderV2.MAC_indexing.gen_withdobfilt(wi,gen_fil_w,TRUE)
	AutoheaderV2.MAC_indexing.lname_fname(wi,lname_fil_w,fname_fil_w)
	AutoheaderV2.MAC_indexing.mname_yob_ssn4(wi,mname_fil_w,yob_fil_w,ssn4_fil_w)

	index_Lev1 := project(wi(
											 keyed(lname_fil_w),
											 keyed(fname_fil_w), 
											 nofold(mname_fil_w),
											 nofold(yob_fil_w),
											 nofold(ssn4_fil_w or temp_ssn_value=''),
											 nofold(gen_fil_w)), 
											 transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.NAME));
													 
	Fetch_Lev1 := AutoheaderV2.functions.FetchConstraints (index_Lev1, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED,
                                            no_fail, 203, false, AutoheaderV2.Constants.FetchHit.NAME);
	
	// bug 112733 -- do a contingent fetch with Mname wilded for ln_branded apps.
	// this is to prevent the confusing case where the user enters a first/middle/last
	// and gets the exact matches only, the runs the same search and adds a state, 
	// and then gets non-exclusionary behavior (i.e., mname not used as a search criterion), 
	// and receives more results even though they provided more specific criteria.
	//
	// Note: This is using the 'choosen' form of FetchLimitLimitSkipFail.

	index_Lev1_noMN := project(wi(
														 keyed(lname_fil_w),
														 keyed(fname_fil_w), 
														 WILD(minit),
														 nofold(yob_fil_w),
														 nofold(ssn4_fil_w or temp_ssn_value=''),
														 nofold(gen_fil_w)), 
														 transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.NAME));

	Fetch_Lev1_noMN := AutoHeaderV2.functions.FetchConstraints (index_Lev1_noMN, ut.limits.FETCH_KEYED, ut.limits.FETCH_LEV2_UNKEYED,
                                                 exists(Fetch_Lev1 (did != 0)) or no_fail,203,temp_ln_branded_value, AutoheaderV2.Constants.FetchHit.NAME);

	AutoheaderV2.MAC_indexing.gen_withdobfilt(i,gen_fil)
	AutoheaderV2.MAC_indexing.pref(i,pref_fil)
	AutoheaderV2.MAC_indexing.phon(i,phon_fil)
	AutoheaderV2.MAC_indexing.lname_fname(i,lname_fil,fname_fil)
	AutoheaderV2.MAC_indexing.mname_yob_ssn4(i,mname_fil,yob_fil,ssn4_fil)
	
	makepmod(string fname_in,string minit_in,string lname_in) := module(AutoStandardI.LIBIN.PenaltyI_Indv_Name.full)
		export boolean allow_wildcard := false;
		export string fname_field := fname_in;
		export string mname_field := minit_in;
		export string lname_field := lname_in;
		
		export string50 lname := temp_lname_value;
		export string30 lastname := temp_lname_value;
		export string30 firstname := temp_fname_value;
		export string4 lname4 := temp_lname4_value;
		export string3 fname3 := temp_fname3_value;
		export boolean phoneticmatch := temp_phonetics;
		export boolean phoneticdistancematch := temp_usephoneticdistance;
		export string30 middlename := temp_mname_value;
		export boolean nonexclusion := temp_non_exclusion_value;
		export boolean lnbranded := temp_ln_branded_value;
		export boolean StrictMatch := temp_strict_match_value;
		export boolean BpsLeadingNameMatch := temp_BpsLeadingNameMatch_value;
		
		export string120 asisname := '';
		export string120 nameasis := '';
		export boolean checkNameVariants := false;
		export boolean cleanfmlname := false;
		export boolean isFCRAVal := false;
		export string50 lfmname := '';
		export string120 unparsedfullname := '';	
	end;
	
	no_phonetics_index_Lev2 := project(i(
																		keyed(phon_fil),
																		keyed(lname_fil),
																		keyed(pref_fil OR LENGTH(TRIM(temp_fname_value))<2),
																		WILD(fname),
																		WILD(minit),
																		// need to weed out records in advance that won't meet the score threshold on name parameters only									
																		(temp_Nicknames OR fname_fil), 
																		nofold(mname_fil),
																		AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(makepmod(fname,minit,lname)) < temp_score_threshold_value,
																		nofold(yob_fil),
																		nofold(ssn4_fil or  temp_ssn_value=''),
																		nofold(gen_fil)), 
																		transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.NAME));
										

	AutoheaderV2.MAC_indexing.gen_withdobfilt(i2,gen_fil2)
	AutoheaderV2.MAC_indexing.pref(i2,pref_fil2)
	AutoheaderV2.MAC_indexing.phon_dist (i2,phon_fil2)
	AutoheaderV2.MAC_indexing.lname_fname(i2,lname_fil2,fname_fil2)
	AutoheaderV2.MAC_indexing.mname_yob_ssn4(i2,mname_fil2,yob_fil2,ssn4_fil2)

	phonetics_index_Lev2 := project(i2(
																	keyed(phon_fil2),
																	keyed(pref_fil2 OR LENGTH(TRIM(temp_fname_value))<2),
																	WILD(fname),
																	WILD(lname),
																	WILD(minit),
																	// need to weed out records in advance that won't meet the score threshold on name parameters only									
																	(temp_Nicknames OR fname_fil2), 
																	nofold(mname_fil2),
																	AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(makepmod(fname,minit,lname)) < temp_score_threshold_value,
																	nofold(yob_fil2),
																	nofold(ssn4_fil2 or  temp_ssn_value=''),
																	nofold(gen_fil2)),
																	transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.NAME));
										
	no_phonetics_Fetch_Lev2 := AutoheaderV2.functions.FetchConstraints(no_phonetics_index_Lev2,ut.limits.FETCH_KEYED,ut.limits.FETCH_LEV2_UNKEYED,
																												exists(Fetch_Lev1(did !=0)) or no_fail,203,temp_ln_branded_value, AutoheaderV2.Constants.FetchHit.NAME);

	phonetics_Fetch_Lev2 := AutoheaderV2.functions.FetchConstraints (phonetics_index_Lev2,ut.limits.FETCH_KEYED,ut.limits.FETCH_LEV2_UNKEYED,
																											exists(Fetch_Lev1(did !=0)) or no_fail,203,temp_ln_branded_value, AutoheaderV2.Constants.FetchHit.NAME);

	
  fetched_exp := Fetch_Lev1 &
								 if(temp_ln_branded_value and temp_mname_value <> '',Fetch_Lev1_noMN) &
								 if(temp_Phonetics and LENGTH(TRIM(temp_fname_value))>1,
                    phonetics_fetch_lev2,
                    if(temp_Nicknames and temp_fname_value!='',no_phonetics_fetch_lev2));
	res := choosen (if (temp_isCRS, Fetch_Lev1, fetched_exp), ut.limits.FETCH_UNKEYED);
									
	final_res := if(first_fil,
								 res,
									AutoheaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.NAME, AutoheaderV2.Constants.STATUS._DATA));
	
	return final_res;
		

end;


import dx_header, ut, doxie, AutoheaderV2, NID, lib_ziplib;

export fetch_zip (dataset (AutoheaderV2.layouts.search) ds_search, integer search_code=0) := function

  _row := ds_search[1];
  _options := ds_search[1].options;
  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;

	// shared do_back(params in_mod) := module
		temp_isCRS := _options.isCRS;
		temp_fname_value := _row.tname.fname;
		temp_fname_set_value := _row.tname.fname_set;
		temp_nicknames := _row.tname.nicknames;
		temp_lname_value := _row.tname.lname;
		temp_lname_set_value := _row.tname.lname_set;
		temp_lnamephoneticset := _row.tname.lname_set_phonetic;
		temp_phonetics :=  _row.tname.phonetic;
		temp_usephoneticdistance := _row.tname.phonetic_distance;
		temp_zip_val := _row.taddress.zip5;
		temp_zip_value := _row.taddress.zip_set;
		temp_zipradius_value :=  _row.taddress.zip_radius;
		temp_city_zip_value := ziplib.CityToZip5(_row.taddress.state, _row.taddress.city);
		temp_ssn_value :=  _row.tssn.ssn;
		temp_prev_state_val1 := _row.taddress.state_prev_1;
		temp_prev_state_val2 := _row.taddress.state_prev_2;
		temp_other_lname_value1 := _row.tname.lname_other;
		temp_other_city_value := _row.taddress.city_other;
		temp_rel_fname_value1 := _row.tname.fname_rel_1;
		temp_rel_fname_value2 :=  _row.tname.fname_rel_2;
		temp_BpsLeadingNameMatch_value := _row.tname.leading_name_match;
    temp_lname_trailing_value := _row.tname.lname != '' and _row.tname.fname = '' and _row.tname.mname = '';
		temp_fname_trailing_value := _row.tname.lname != '' and _row.tname.fname != '' and _row.tname.mname = '';

		temp_mname_value := _row.tname.mname;
		// temp_phone_value := _row.cphone.phone10;
		// temp_did_value := _row.did;
		// shared temp_lname_val := AutoStandardI.InterfaceTranslator.lname_val.val(project(in_mod,AutoStandardI.InterfaceTranslator.lname_val.params));
		temp_county_value := _row.taddress.county;

    // DOB-related values
    dob_mod := doxie.DOBTools (_row.tdob.dob);
      temp_find_year_high := dob_mod.find_year_high (_row.tdob.agelow);
      temp_find_year_low  := dob_mod.find_year_low (_row.tdob.agehigh);
      temp_find_month     := dob_mod.find_month;
      temp_find_day       := dob_mod.find_day;

		temp_non_exclusion_value := _options.nonexclusion or _options.ln_branded and ~_options.strict_match;


		i := dx_header.key_piz();
		wi := dx_header.key_wild_zip();

    //change: moved to the very end
    //change: by usage, this function is not called if DID, full SSN or phone are provided
		first_fil := (temp_lname_value<>'' AND temp_zip_value<>[]);// AND
									// To Prevent extra work
									// (length(trim(temp_ssn_value))<>9 AND temp_did_value='' AND temp_phone_value='');
		
		piz_value := ut.PizTools.reverseZipset(temp_zip_value);

		AutoheaderV2.MAC_indexing.gen_withdobfilt(wi,gen_fil,TRUE)
		AutoheaderV2.MAC_indexing.Zip1(wi,zip1_fil)
		AutoheaderV2.MAC_indexing.lname_fname(wi,lname_fil,fname_fil)
		AutoheaderV2.MAC_indexing.mname_yob_ssn4(wi,mname_fil,yob_fil,ssn4_fil)

		index_Lev1 := PROJECT(wi(
													keyed(zip1_fil),
													keyed(lname_fil),
													keyed(fname_fil), 
													keyed(mname_fil OR temp_non_exclusion_value),
													keyed(yob_fil),
													keyed(ssn4_fil or temp_ssn_value=''),
													gen_fil),
                          transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.ZIP));

		Fetch_Lev1 := AutoheaderV2.functions.FetchConstraints(index_Lev1,ut.limits.FETCH_KEYED,ut.limits.FETCH_UNKEYED,no_fail,203,,AutoheaderV2.Constants.FetchHit.ZIP);

		index_lev1_noMN := PROJECT(wi(
																	keyed(zip1_fil),
																	keyed(lname_fil),
																	keyed(fname_fil),
																	WILD(minit),
																	keyed(yob_fil),
																	keyed(ssn4_fil or temp_ssn_value=''),
																	gen_fil),
                          transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.ZIP));

		Fetch_Lev1_noMN := AutoheaderV2.functions.FetchConstraints(index_Lev1_noMN,ut.limits.FETCH_KEYED,ut.limits.FETCH_UNKEYED,true,203,,AutoheaderV2.Constants.FetchHit.ZIP);

		// Need a variation to support bpssearch that does the leading name match logic
		// and allows for zip radius
		AutoheaderV2.MAC_indexing.Zip(wi,zip1radius_fil)
		
		index_Lev1_leading := PROJECT(wi(
													keyed(zip1radius_fil AND zip not in [(integer4)temp_zip_val,(integer4)temp_city_zip_value]),
													keyed(lname_fil),
													keyed(fname_fil), 
													keyed(mname_fil OR temp_non_exclusion_value),
													keyed(yob_fil),
													keyed(ssn4_fil or temp_ssn_value=''),
													gen_fil),
                          transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.ZIP));

		Fetch_Lev1_leading := AutoheaderV2.functions.FetchConstraints(index_Lev1_leading,ut.limits.FETCH_KEYED,ut.limits.FETCH_UNKEYED,exists(Fetch_Lev1) or no_fail,203,,AutoheaderV2.Constants.FetchHit.ZIP);

		AutoheaderV2.MAC_indexing.gen_withdobfilt(i,gen_fil2,TRUE)
		AutoheaderV2.MAC_indexing.pref(i,pref_fil2)
		AutoheaderV2.MAC_indexing.Piz(i,piz_fil2)
		AutoheaderV2.MAC_indexing.phon_dist(i,phon_fil2)
		AutoheaderV2.MAC_indexing.lname_fname(i,lname_fil2,fname_fil2)
		AutoheaderV2.MAC_indexing.mname_yob_ssn4(i,mname_fil2,yob_fil2,ssn4_fil2)
		temp_piz_val := ut.PizTools.reverseZip(temp_zip_val);
		
		index_Lev2 := PROJECT(i(
													keyed(piz_fil2 AND piz <> (integer4)temp_piz_val),
													keyed(phon_fil2),
													keyed(lname_fil2),
													keyed(pref_fil2 OR LENGTH(TRIM(temp_fname_value))<2),
													keyed(fname_fil2 OR temp_nicknames), 
													keyed(mname_fil2 OR temp_non_exclusion_value),
													keyed(yob_fil2),
													keyed(ssn4_fil2 or temp_ssn_value=''),
													gen_fil2), 
                          transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.ZIP));

		// only do the contingent fetch if necessary						
		Fetch_Lev1_cont := IF(~exists(Fetch_Lev1) and ~temp_non_exclusion_value, Fetch_Lev1_noMN);
		// output a message indicating that removal of MN would produce header results
		// messages := IF(exists(Fetch_Lev1_cont), ut.MessageCode(ut.constants_MessageCodes.REMOVE_MNAME,''));

		// only fail the Fetch_Lev2 if neither Fetch_Lev1 nor the contingent Fetch produce results									
		Fetch_Lev2 := AutoheaderV2.functions.FetchConstraints(index_Lev2,ut.limits.FETCH_KEYED,ut.limits.FETCH_LEV2_UNKEYED,exists(Fetch_Lev1) or exists(Fetch_Lev1_cont) or no_fail,203,,AutoheaderV2.Constants.FetchHit.ZIP);

		index_Lev3 := project(i(
									keyed(piz_fil2),
									keyed(phon_fil2),
									WILD(lname),
									WILD(pfname),
									WILD(fname),
									WILD(minit),
    //change: temp_lname_val -> temp_lname_value (the latter is uppercased and trimmed, so it shouldn't make a difference)
									(lname<>temp_lname_value),
									(pref_fil2 OR LENGTH(TRIM(temp_fname_value))<2),
									(fname_fil2 OR temp_nicknames), 
									(mname_fil2 OR temp_non_exclusion_value),
									nofold(yob_fil2),
									nofold(ssn4_fil2 or temp_ssn_value=''),
									nofold(gen_fil2)), 
                  transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.ZIP));
									
		Fetch_Lev3 := AutoheaderV2.functions.FetchConstraints(index_Lev3,ut.limits.FETCH_KEYED,ut.limits.FETCH_LEV2_UNKEYED,true,203,,AutoheaderV2.Constants.FetchHit.ZIP);

     
		search_res := 
			choosen(Fetch_Lev1 &
//? what's with the County?
							IF(temp_BpsLeadingNameMatch_value AND (temp_zipradius_value<>0 or temp_county_value <> ''),
								Fetch_Lev1_leading) &
							IF(~temp_isCRS AND (temp_zipradius_value<>0 or temp_county_value <> ''),
								 Fetch_Lev2) &
							IF(~temp_isCRS AND temp_phonetics,
								 Fetch_Lev3),
							ut.limits.FETCH_UNKEYED);

  final_res := if (first_fil, 
									 if(exists(search_res),
											search_res,
											AutoheaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.ZIP, AutoheaderV2.Constants.STATUS._NOT_FOUND))
									 + if(exists(Fetch_Lev1_cont), AutoheaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.ZIP, AutoheaderV2.Constants.Status._MNAME)),
									 AutoheaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.ZIP, AutoheaderV2.Constants.Status._DATA));

	return final_res;
end;

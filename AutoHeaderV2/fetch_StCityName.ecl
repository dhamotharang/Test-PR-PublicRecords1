import ut,doxie,dx_header,NID,AutoHeaderV2;

export fetch_StCityName (dataset (AutoheaderV2.layouts.search) ds_search, integer search_code=0) := function
	_row := ds_search[1];
  _options := ds_search[1].options;
  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;

	temp_isCRS := _options.isCRS;
	temp_fname_value := _row.tname.fname;
	temp_fname_set_value := _row.tname.fname_set;
	temp_nicknames :=_row.tname.nicknames;
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
	temp_BpsLeadingNameMatch_value := _row.tname.leading_name_match;
	temp_lname_trailing_value := _row.tname.lname != '' and _row.tname.fname = '' and _row.tname.mname = '';
	temp_fname_trailing_value := _row.tname.lname != '' and _row.tname.fname != '' and _row.tname.mname = '';

	i := dx_header.key_StCityLFName();
	wi := dx_header.key_wild_StCityLFName();


	first_fil := (temp_city_value != '' AND temp_lname_value != '') AND
								// To Prevent extra work
								(temp_zip_value=[] AND length(trim(temp_ssn_value))<>9 AND temp_did_value=0 AND
								temp_phone_value='');
	
	AutoheaderV2.MAC_indexing.Gen_withdobfilt(wi,gen_fil,FALSE)
	AutoheaderV2.MAC_indexing.lname_fname(wi,lname_fil,fname_fil)
	AutoheaderV2.MAC_indexing.state(wi,state_fil)
	city_fil := wi.city_code in doxie.Make_CityCodes(temp_city_value).rox;

	index_lev1 := PROJECT(wi(keyed(city_fil),
													 keyed(state_fil),   
													 keyed(lname_fil),
													 keyed(fname_fil),   
													 gen_fil),
													 transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.STCITYNAME));

	Fetch_Lev1 := AutoHeaderV2.functions.FetchConstraints (index_Lev1,ut.limits.FETCH_KEYED,ut.limits.FETCH_UNKEYED,no_fail,203,,AutoheaderV2.Constants.FetchHit.STCITYNAME);

	AutoheaderV2.MAC_indexing.Gen_withdobfilt(i,gen_fil2,FALSE)
	AutoheaderV2.MAC_indexing.phon_dist(i,phon_fil2)
	AutoheaderV2.MAC_indexing.lname_fname(i,lname_fil2,fname_fil2)
	AutoheaderV2.MAC_indexing.pref(i,pref_fil2)
	AutoheaderV2.MAC_indexing.state(i,state_fil2)
	city_fil2 := i.city_code in doxie.Make_CityCodes(temp_city_value).rox;
			 
	index_Lev2 := project(
						i(keyed(city_fil2),
							keyed(state_fil2),   
							keyed(phon_fil2),
							keyed(lname_fil2 OR temp_phonetics),
							keyed(pref_fil2 OR LENGTH(TRIM(temp_fname_value))<2),
							keyed(fname_fil2 OR temp_nicknames),
							(lname<>temp_lname_value OR temp_nicknames),
							// Why no yob or ssn4 filter like StCityFLName?
							nofold(gen_fil2)),
							transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.STCITYNAME));
		
	Fetch_Lev2 := AutoheaderV2.functions.FetchConstraints(index_Lev2,ut.limits.FETCH_KEYED,ut.limits.FETCH_LEV2_UNKEYED,exists(Fetch_Lev1) or no_fail,203,,AutoheaderV2.Constants.FetchHit.STCITYNAME);

  res_chosen := choosen(Fetch_Lev1 & IF(~temp_isCRS AND (temp_phonetics OR temp_nicknames), Fetch_Lev2),
						           ut.limits.FETCH_UNKEYED);
											 
  final_res	 := if (first_fil, 
									 if(exists(res_chosen),
											res_chosen,
											AutoHeaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.STCITYNAME, AutoheaderV2.Constants.Status._NOT_FOUND)
											),
										AutoHeaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.STCITYNAME, AutoheaderV2.Constants.Status._DATA));
										
	return final_res; 
end;

import ut, dx_header, NID, AutoHeaderV2, lib_stringlib;

export dataset (AutoheaderV2.layouts.search_out) fetch_DOBName (dataset (AutoheaderV2.layouts.search) ds_search, integer search_code=0) := function

  _row := ds_search[1];
  _options := ds_search[1].options;
  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;

	temp_lname_value := _row.tname.lname;
	temp_lname_set_value := _row.tname.lname_set;
	temp_BpsLeadingNameMatch_value := _row.tname.leading_name_match;
	temp_lname_trailing_value := _row.tname.lname != '' and _row.tname.fname = '' and _row.tname.mname = '';
	temp_fname_value := _row.tname.fname;
	temp_fname_set_value := _row.tname.fname_set;
	temp_fname_trailing_value := _row.tname.lname != '' and _row.tname.fname != '' and _row.tname.mname = '';
	temp_phonetics := _row.tname.phonetic;
	temp_nicknames := _row.tname.nicknames;
	temp_zip_value := _row.taddress.zip_set;
	temp_city_value := _row.taddress.city;
	temp_dob_val := _row.tdob.dob;
	temp_allowFuzzyDOBMatch := _row.tdob.fuzzy_dob;
	temp_state_value := _row.taddress.state;

	i := dx_header.key_DOBName();

  // more precise boundaries -- based on today's date (year stays the same)
	unsigned8 todays_date := (unsigned8)Stringlib.getDateYYYYMMDD();
	temp_yob_val_low  := _row.tdob.dob_low div 10000;
	temp_yob_val_high := _row.tdob.dob_high div 10000;
	temp_dob_val_low_true := temp_yob_val_low * 10000 + (todays_date % 10000);
	temp_dob_val_high_true := temp_yob_val_high * 10000 + (todays_date % 10000);
	unsigned8 temp_mob_val := IF(temp_dob_val != 0, (temp_dob_val div 100) % 100,0);
	unsigned8 temp_day_val := IF(temp_dob_val != 0, temp_dob_val % 100,0);

	AutoheaderV2.MAC_indexing.state(i, state_fil);
	AutoheaderV2.MAC_indexing.pref(i, pref_fil);
	AutoheaderV2.MAC_indexing.phon(i, phon_fil);
	AutoheaderV2.MAC_indexing.lname_fname(i,lname_fil,fname_fil)

	// trying to fetch set of zips, if wasn't done already.
	// Generally, this better be done in doxie.MAC_Header_Field_Declare, but might affect some other search code.
	boolean FindZips := (temp_zip_value=[]) AND (temp_state_value != '') AND (temp_city_value != '');
	zips_by_city_state := ut.ZipsWithinCity (temp_state_value, temp_city_value);
	zips_use := IF (FindZips, zips_by_city_state, temp_zip_value);
	
	// need to make sure that all zips are intformatted to 5 digits with leading zeroes
	zips_ds := dataset(zips_use, {integer4 zip});
	zips := if(exists(zips_ds), set(project(zips_ds, transform({string5 zip5}, self.zip5 := INTFORMAT(LEFT.zip, 5, 1))),zip5), 
															ALL);


	index_Lev_exact := project (i( keyed(yob between temp_yob_val_low and temp_yob_val_high) AND
													 keyed(phon_fil) AND
													 keyed(lname_fil) AND
													 keyed(pref_fil) AND
													 keyed(fname_fil) AND
													 keyed(temp_mob_val = 0 or mob = temp_mob_val or (temp_allowFuzzyDOBMatch and mob = 0)) AND
													 keyed(temp_day_val = 0 or day = temp_day_val or (temp_allowFuzzyDOBMatch and day = 0)) AND
													 keyed (state_fil) AND
													 keyed (zip IN zips) AND
													 // for age range filtering only (bypass this for a dob search)
													 (temp_dob_val <> 0 or 
														(temp_dob_val_low_true <= map(
															dob % 10000 = 0 => dob + 9999,
															dob % 100   = 0 => dob + 99,
															dob) and
														temp_dob_val_high_true >= dob))
													 ), 
				transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.DOBNAME));

	Fetch_Lev_exact := AutoheaderV2.functions.FetchConstraints (index_Lev_exact, ut.limits.FETCH_KEYED,ut.limits.FETCH_UNKEYED, no_fail, 203, , AutoheaderV2.Constants.FetchHit.DOBNAME);


	index_Lev_fuzzy := project (i( keyed(yob between temp_yob_val_low and temp_yob_val_high) AND
													 keyed(phon_fil) AND
													 keyed(temp_phonetics or lname_fil) AND
													 keyed(pref_fil) AND
													 keyed(temp_nicknames OR fname_fil) AND
													 keyed(temp_mob_val = 0 or mob = temp_mob_val or (temp_allowFuzzyDOBMatch and mob = 0)) AND
													 keyed(temp_day_val = 0 or day = temp_day_val or (temp_allowFuzzyDOBMatch and day = 0)) AND
													 keyed (state_fil) AND
													 keyed (zip IN zips) AND
													 // for age range filtering only (bypass this for a dob search)
													 (temp_dob_val <> 0 or 
														(temp_dob_val_low_true <= map(
															dob % 10000 = 0 => dob + 9999,
															dob % 100   = 0 => dob + 99,
															dob) and
														temp_dob_val_high_true >= dob))
													 ), 
				transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.DOBNAME));

	Fetch_Lev_fuzzy := AutoHeaderV2.functions.FetchConstraints (index_Lev_fuzzy, ut.limits.FETCH_KEYED,ut.limits.FETCH_UNKEYED, 
																								 exists(Fetch_Lev_exact) or no_fail, 203, , AutoheaderV2.Constants.FetchHit.DOBNAME);

	// always return the exact matches, and the fuzzy ones if they aren't too many
	res := Fetch_Lev_exact & IF(temp_nicknames or temp_phonetics, Fetch_Lev_fuzzy);
	// change: dedup here
	res_final := dedup (sort (res, did), did);
	return if(exists(res_final), res_final, AutoHeaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.DOBNAME, AutoheaderV2.Constants.STATUS._NOT_FOUND));
end;

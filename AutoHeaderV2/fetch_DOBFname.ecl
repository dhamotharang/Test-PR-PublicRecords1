import ut, doxie, dx_header, NID,AutoHeaderV2,lib_stringlib;

export fetch_DOBFname (dataset (AutoheaderV2.layouts.search) ds_search, integer search_code=0) := function
	_row := ds_search[1];
  _options := ds_search[1].options;
  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;
	
	temp_fname_value := _row.tname.fname;
	temp_nicknames := _row.tname.nicknames;
	temp_zip_value := _row.taddress.zip_set;
	temp_city_value := _row.taddress.city;
	temp_state_value := _row.taddress.state;
	
	i1 := dx_header.key_DOB_fname();
	i2 := dx_header.key_DOB_pfname();

	unsigned1 fname_in_len := length(trim(temp_fname_value));
	// absolutely required for this search
	unsigned8 todays_date := (unsigned8)Stringlib.getDateYYYYMMDD();

  temp_dob_val_low := _row.tdob.dob_low;
  temp_dob_val_high := _row.tdob.dob_high;
  // these are more precise boundaries -- based on today's date (year stays the same)
	unsigned8 temp_dob_val_low_true := (temp_dob_val_low div 10000) * 10000 + (todays_date % 10000);
	unsigned8 temp_dob_val_high_true := (temp_dob_val_high div 10000) * 10000 + (todays_date % 10000);

	boolean first_fil := doxie.DOBTools(temp_dob_val_low).IsValidDOB AND doxie.DOBTools(temp_dob_val_high).IsValidDOB AND (fname_in_len > 1); // short names are omitted in this key
	
	AutoheaderV2.MAC_indexing.state (i1, state_fil1);
	AutoheaderV2.MAC_indexing.state (i2, state_fil2);
	AutoheaderV2.MAC_indexing.pref  (i2, pref_fil);

	// trying to fetch set of zips, if wasn't done already.
	// Generally, this better be done in doxie.MAC_Header_Field_Declare, but might affect some other search code.
	boolean FindZips := (temp_zip_value=[]) AND (temp_state_value != '') AND (temp_city_value != '');
	zips_by_city_state := ut.ZipsWithinCity (temp_state_value, temp_city_value);
	zips_use := IF (FindZips, zips_by_city_state, temp_zip_value);
	
	// need to make sure that all zips are intformatted to 5 digits with leading zeroes
	zips_ds := dataset(zips_use, {integer4 zip});
	zips := if(exists(zips_ds), set(project(zips_ds, transform({string5 zip5}, self.zip5 := INTFORMAT(LEFT.zip, 5, 1))),zip5), 
															ALL);

	index_Lev1 := project (i1 (
												keyed (f2=temp_fname_value[1..2]) AND
												keyed (dob between temp_dob_val_low and temp_dob_val_high) AND
												keyed (fname [1..fname_in_len] = temp_fname_value) AND
												keyed (state_fil1) AND
												keyed (zip IN zips) AND
													 (_row.tdob.dob <> 0 or 
														 (temp_dob_val_low_true <= map(
																 dob % 10000 = 0 => dob + 9999,
															dob % 100   = 0 => dob + 99,
															dob) and
												temp_dob_val_high_true >= dob))), 
												transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.DOBFNAME));
													 
	index_Lev2 := project (i2 (
												keyed (NID.mod_PFirstTools.R2inPFL_FirstTwo(temp_fname_value, pf2)) AND
												keyed (dob between temp_dob_val_low and temp_dob_val_high) AND
												keyed (pref_fil) AND
												keyed (state_fil2) AND
												keyed (zip IN zips) AND
													 (_row.tdob.dob <> 0 or 
														 (temp_dob_val_low_true <= map(
																 dob % 10000 = 0 => dob + 9999,
															dob % 100   = 0 => dob + 99,
															dob) and
												temp_dob_val_high_true >= dob))), 
												transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.DOBFNAME));												 

	index_Lev := if(temp_nicknames, index_Lev2, index_Lev1);   

	Fetch_Lev := AutoHeaderV2.functions.FetchConstraints (index_Lev, ut.limits.FETCH_KEYED,ut.limits.FETCH_UNKEYED, no_fail, 203, , AutoheaderV2.Constants.FetchHit.DOBFNAME);
	
	final_res := if(first_fil,
									if(exists(Fetch_Lev), 
										 dedup (Fetch_Lev, did, all), 
										 AutoHeaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.DOBFNAME, AutoheaderV2.Constants.STATUS._NOT_FOUND)),
									AutoHeaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.DOBFNAME, AutoheaderV2.Constants.Status._DATA));

	return final_res;
end;

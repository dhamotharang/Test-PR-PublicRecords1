import ut, doxie, dx_header, AutoheaderV2, lib_stringlib;

export fetch_wild_StCityName (dataset (AutoheaderV2.layouts.search) ds_search, integer search_code=0) := function
	_row := ds_search[1];
	_options := ds_search[1].options;
  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;

	temp_fname_wild_val := _row.tname.fname;
	temp_lname_value := _row.tname.lname;
	temp_lname_wild_val := _row.tname.lname; //same as temp_lname_value
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

	i := dx_header.key_wild_StCityLFName();

	first_fil := (temp_city_value != '' AND temp_lname_value != '') AND
								// To Prevent extra work
								(temp_zip_value=[] AND length(trim(temp_ssn_value))<>9 AND temp_did_value=0 AND
								temp_phone_value='');
	
	AutoheaderV2.MAC_indexing.Gen_withdobfilt(i,gen_fil,FALSE)

	city_fil := i.city_code in doxie.Make_CityCodes(temp_city_value).rox;
	state_fil := i.st=temp_state_value OR temp_state_value='';
	lname_fil := keyed(i.lname[1..3]=temp_lname_value[1..3]) and 
							 stringlib.StringWildMatch(i.lname, temp_lname_wild_val, true);
	fname_fil := temp_fname_wild_val = '' OR
							 stringlib.StringWildMatch(i.fname, temp_fname_wild_val, true); 

	index_lev1 := PROJECT(i(
												keyed(city_fil),
												keyed(state_fil),  
												lname_fil,
												fname_fil,   
												gen_fil),
												transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.W_STCITYNAME));


	Fetch_Lev1 := AutoheaderV2.functions.FetchConstraints(index_Lev1,ut.limits.FETCH_KEYED,ut.limits.FETCH_UNKEYED,no_fail,203,,AutoheaderV2.Constants.FetchHit.W_STCITYNAME);
	res := choosen(Fetch_Lev1, ut.limits.FETCH_UNKEYED);
	
	final_res := if(first_fil,
									if(exists(res),
										 res,
										 AutoheaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.W_STCITYNAME, AutoheaderV2.Constants.STATUS._NOT_FOUND)),
									AutoheaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.W_STCITYNAME, AutoheaderV2.Constants.Status._DATA));
									
	return final_res;

end;

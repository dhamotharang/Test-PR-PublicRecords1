IMPORT ut,doxie,dx_header,NID,AutoHeaderV2;

export fetch_DA (dataset (AutoheaderV2.layouts.search) ds_search) := function
	_row := ds_search[1];
	
	temp_fname_value := _row.tname.fname;
	temp_fname3_value := _row.tname.fname3;
	temp_nicknames := _row.tname.nicknames;
	temp_lname_value := _row.tname.lname;
	temp_lname4_value := _row.tname.lname4;
	temp_lname_set_value := _row.tname.lname_set;
	temp_city_value := _row.taddress.city;
	temp_state_value := _row.taddress.state;
  // DOB-related values
  dob_mod := doxie.DOBTools (_row.tdob.dob);
    temp_find_year_high := dob_mod.find_year_high (_row.tdob.agelow);
    temp_find_year_low  := dob_mod.find_year_low (_row.tdob.agehigh);
	temp_prev_state_val1 := _row.taddress.state_prev_1;
	temp_prev_state_val2 := _row.taddress.state_prev_2;
	temp_other_lname_value1 := _row.tname.lname_other;
	temp_other_city_value := _row.taddress.city_other;
	temp_rel_fname_value1 := _row.tname.fname_rel_1;
	temp_rel_fname_value2 := _row.tname.fname_rel_2;

	i := dx_header.key_DA();

	max_persons := ut.limits.DID_PER_PERSON * 5; //there are less than 1500 'JOH' 'SMIT' in Big Apple
	
	// enable 'starts with' matching on the input fname *and* safeguard against invalid subrange exception
	castFname := trim(ut.cast2keyfield(i.fname,temp_fname_value));

	res_final := project(LIMIT (
				i(keyed(st=temp_state_value),
					keyed(city_code in doxie.Make_CityCodes(temp_city_value).rox), 
					keyed(l4=temp_lname4_value),
					keyed (f3[1..length(trim(temp_fname3_value))]=temp_fname3_value),
					temp_lname_value='' or (lname IN temp_lname_set_value),
					temp_fname_value='' or (
						NID.mod_PFirstTools.SUBPFLeqPFR(fname, temp_fname_value) and
						(temp_nicknames or fname[1..length(castFname)]=castFname)),
					AutoheaderV2.MAC_indexing.gen_filt(i),
					temp_find_year_low=0 or yob>=temp_find_year_low, temp_find_year_high=0 or yob<=temp_find_year_high),
					max_persons, SKIP),
					transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoHeaderV2.Constants.FetchHit.DA));
	
	return if(exists(res_final), res_final, AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.DA, AutoHeaderV2.Constants.STATUS._NOT_FOUND));
end;

import ut,doxie,dx_header,AutoheaderV2,lib_stringlib;

export fetch_wild_StNameSmall (dataset (AutoheaderV2.layouts.search) ds_search) := function
	_row := ds_search[1];
	_options := ds_search[1].options;

	temp_fname_wild_val := _row.tname.fname;
	temp_mname_value := _row.tname.mname;
	temp_lname_wild_val := _row.tname.lname;
	temp_state_value := _row.taddress.state;
	temp_zip_value := _row.taddress.zip_set;
  // DOB-related values
	dob_mod := doxie.DOBTools (_row.tdob.dob);
    temp_find_year_high := dob_mod.find_year_high (_row.tdob.agelow);
    temp_find_year_low  := dob_mod.find_year_low (_row.tdob.agehigh);
    temp_find_month     := dob_mod.find_month;
    temp_find_day       := dob_mod.find_day;
	temp_ssn_value := _row.tssn.ssn;
	temp_prev_state_val1 := _row.taddress.state_prev_1;
	temp_prev_state_val2 := _row.taddress.state_prev_2;
	temp_other_lname_value1 := _row.tname.lname_other;
	temp_other_city_value := _row.taddress.city_other;
	temp_rel_fname_value1 := _row.tname.fname_rel_1;
	temp_rel_fname_value2 := _row.tname.fname_rel_2;
	temp_score_threshold_value := _options.score_threshold;

	i := dx_header.key_wild_StFnameLname();

	res_final :=
		project(  LIMIT (LIMIT(
				 i(temp_lname_wild_val != '' AND temp_fname_wild_val != '',
				keyed(i.lname[1..3]=temp_lname_wild_val[1..3]) and 
								 stringlib.StringWildMatch(i.lname, temp_lname_wild_val, true),
				keyed(i.fname[1..3]=temp_fname_wild_val[1..3]) and 
								 stringlib.StringWildMatch(i.fname, temp_fname_wild_val, true),
				keyed((st=temp_state_value or temp_state_value='')),
				keyed(temp_mname_value='' or temp_mname_value[1]=minit OR temp_score_threshold_value>10), // TODO: make wild
				keyed(yob>=(unsigned2)temp_find_year_low AND 
						yob<=IF((unsigned2)temp_find_year_high != 0, (unsigned2)temp_find_year_high, (unsigned2)0xFFFF)),
				keyed(LENGTH(TRIM(temp_ssn_value))<>4 or (unsigned2)temp_ssn_value=s4),
				temp_find_month=0 or (dob div 100) % 100=temp_find_month,
				temp_find_day=0 or dob % 100=temp_find_day,
				temp_zip_value=[] or zip IN temp_zip_value,
				AutoheaderV2.MAC_indexing.gen_filt(i)
				 ) , ut.limits.DID_PER_PERSON * 2, SKIP, keyed), 1000, SKIP),
				transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.W_STNAMESMALL));

	return if(exists(res_final), res_final, AutoheaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.W_STNAMESMALL, AutoheaderV2.Constants.STATUS._NOT_FOUND));
end;

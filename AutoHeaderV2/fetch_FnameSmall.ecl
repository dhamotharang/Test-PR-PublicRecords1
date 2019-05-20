import ut,doxie,dx_header,NID,AutoHeaderV2;

export fetch_FnameSmall (dataset (AutoheaderV2.layouts.search) ds_search, integer search_code=0) := function
	_row := ds_search[1];
  _options := ds_search[1].options;
  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;

	temp_fname_value := _row.tname.fname;
	temp_lname_value := _row.tname.lname;
	temp_pname_value := _row.taddress.prim_name;
	temp_state_value := _row.taddress.state;
	temp_zip_value := _row.taddress.zip_set;
  // DOB-related values
	dob_mod := doxie.DOBTools (_row.tdob.dob);
    temp_find_year_high := dob_mod.find_year_high (_row.tdob.agelow);
    temp_find_year_low  := dob_mod.find_year_low (_row.tdob.agehigh);
    temp_find_month     := dob_mod.find_month;
    temp_find_day       := dob_mod.find_day;
	temp_prev_state_val1 := _row.taddress.state_prev_1;
	temp_prev_state_val2 := _row.taddress.state_prev_2;
	temp_other_lname_value1 := _row.tname.lname_other;
	temp_other_city_value := _row.taddress.city_other;
	temp_rel_fname_value1 := _row.tname.fname_rel_1;
	temp_rel_fname_value2 := _row.tname.fname_rel_2;
	temp_date_first_seen_value := _row.taddress.date_firstseen;
	temp_date_last_seen_value := _row.taddress.date_lastseen;
	temp_allow_date_seen_value := _row.taddress.allow_dateseen;

	i := dx_header.key_FnameSmall();
	dti := dx_header.key_DTS_FnameSmall();

	first_fil := temp_lname_value='' AND temp_fname_value<>'';

	AutoheaderV2.MAC_indexing.gen_nodobfilt(i,gen_fil)
	AutoheaderV2.MAC_indexing.pref(i,pref_fil)
	AutoheaderV2.MAC_indexing.state(i,state_fil)
	AutoheaderV2.MAC_indexing.Zip(i,zip_fil)
	AutoheaderV2.MAC_indexing.pname(i,pname_fil)
	AutoheaderV2.MAC_indexing.dob(i,dob_fil,TRUE)

	refcount :=
	RECORD
		doxie.layout_references;
		i.fname_count;
	END;

	index_Lev1 := project(i(
											keyed(pref_fil) AND
											keyed(state_fil OR  i.st='') AND
											keyed(zip_fil OR i.zip=0 OR temp_zip_value=[]) AND
											nofold(pname_fil OR i.prim_name='' OR temp_pname_value='') AND
											(dob_fil OR i.dob=0) AND
											(gen_fil OR i.fname_count>20000)), refcount);

	//allowing dt_seen filter
	AutoheaderV2.MAC_indexing.gen_nodobfilt(dti,gen_fil_dt)
	AutoheaderV2.MAC_indexing.pref(dti,pref_fil_dt)
	AutoheaderV2.MAC_indexing.state(dti,state_fil_dt)
	AutoheaderV2.MAC_indexing.Zip(dti,zip_fil_dt)
	AutoheaderV2.MAC_indexing.pname(dti,pname_fil_dt)
	AutoheaderV2.MAC_indexing.dob(dti,dob_fil_dt,TRUE)

	index_LevDt := project(dti(
												keyed(pref_fil_dt) AND
														 keyed(state_fil_dt OR  dti.st='') AND
													keyed(zip_fil_dt OR dti.zip=0 OR temp_zip_value=[]) AND
												keyed(temp_date_first_seen_value=0 and dt_last_seen >= temp_date_last_seen_value or 
																											temp_date_first_seen_value<>0 and dt_last_seen >= temp_date_first_seen_value) AND
												(pname_fil_dt OR dti.prim_name='' OR temp_pname_value='') AND
												(dt_first_seen <= temp_date_last_seen_value) AND
												(dob_fil_dt OR dti.dob=0) AND
												(gen_fil_dt OR dti.fname_count>20000)), refcount);

	index_Lev := if(temp_allow_date_seen_value and temp_date_last_seen_value<>0 and temp_pname_value<>'', index_LevDt, index_Lev1);


	doxie.mac_FetchLimitLimitSkipFail (index_lev, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED, no_fail, 203, 
																									false, false, Fetch_Lev1); //should use functions.FetchConstraints?

	AutoheaderV2.layouts.search_out check_count(refcount le) :=
	TRANSFORM
		SELF.did := IF(le.fname_count>20000,if(no_fail,SKIP,ERROR(11,doxie.ErrorCodes(11))),le.did);
		self.fetch_hit := AutoHeaderV2.Constants.FetchHit.FNAMESMALL;
	END;

	res := PROJECT(Fetch_Lev1, check_count(LEFT));
	
	p_final := map(~first_fil => AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.FNAMESMALL, AutoHeaderV2.Constants.STATUS._DATA),
								 no_fail and count(Fetch_Lev1)>count(res) => AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.FNAMESMALL, AutoHeaderV2.Constants.STATUS._NOT_FOUND), 
								 res);
						
	return p_final;
		
end;

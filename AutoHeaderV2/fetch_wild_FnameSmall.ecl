import ut,doxie,dx_header,AutoHeaderV2,lib_stringlib;

export fetch_wild_FnameSmall (dataset (AutoheaderV2.layouts.search) ds_search, integer search_code=0) := function

	_row := ds_search[1];
  _options := ds_search[1].options;
  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;

	temp_fname_wild_val := _row.tname.fname;
	temp_lname_wild_val := _row.tname.lname;
	temp_pname_wild_val := _row.taddress.prim_name;
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

	i := dx_header.key_wild_FnameSmall();

	first_fil := temp_lname_wild_val='' AND temp_fname_wild_val<>'' AND temp_ssn_value='';

	AutoheaderV2.MAC_indexing.gen_withdobfilt(i,gen_fil,TRUE)

	state_fil := i.st='' OR i.st=temp_state_value OR temp_state_value='';
	zip_fil := i.zip=0 OR temp_zip_value=[] OR i.zip IN temp_zip_value;
	pname_fil := i.prim_name='' OR temp_pname_wild_val='' OR stringlib.StringWildMatch(i.prim_name, temp_pname_wild_val, true);

	refcount :=
	RECORD
		doxie.layout_references;
		i.fname_count;
	END;

	index_Lev1 := project(i(
											keyed(fname[1..3]=temp_fname_wild_val[1..3]) AND
											stringlib.StringWildMatch(fname, temp_fname_wild_val, true),
											keyed(state_fil) AND
											keyed(zip_fil) AND
											nofold(pname_fil) AND
											gen_fil), refcount);

	doxie.mac_FetchLimitLimitSkipFail (index_lev1, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED, no_fail, 203, 
																			false, false, Fetch_Lev1);
																			
	AutoheaderV2.layouts.search_out check_count(refcount le) :=
	TRANSFORM
		SELF.did := IF(le.fname_count>20000,ERROR(11,doxie.ErrorCodes(11)),le.did);
		Self.fetch_hit := AutoHeaderV2.Constants.FetchHit.W_FNAMESMALL;
	END;

	p_final := PROJECT(Fetch_Lev1, check_count(LEFT));
	
	final_res := if(first_fil,
									if(exists(p_final),
										 p_final,
										 AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.W_FNAMESMALL, AutoHeaderV2.Constants.STATUS._NOT_FOUND)),
									AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.W_FNAMESMALL, AutoHeaderV2.Constants.Status._DATA));
									
	return final_res;
	
end;

import ut,doxie, dx_header, NID,AutoHeaderV2, lib_metaphone;

export fetch_StNameSmall  (dataset (AutoHeaderV2.layouts.search) ds_search) := function

  _row := ds_search[1];
  _options := ds_search[1].options;

	temp_fname_value := _row.tname.fname;
	temp_nicknames := _row.tname.nicknames;
	temp_mname_value := _row.tname.mname;
	temp_lname_value := _row.tname.lname;
	temp_lname_set_value := _row.tname.lname_set;
	temp_lnamephoneticset := _row.tname.lname_set_phonetic;
	temp_phonetics := _row.tname.phonetic;
	temp_usephoneticdistance := _row.tname.phonetic_distance;
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
	temp_score_threshold_value :=  _options.score_threshold;

	i := dx_header.key_StFnameLname();
	
	first_fil := temp_lname_value != '' AND temp_fname_value != '';

	pfe(string20 l, string20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);

	// enable 'starts with' matching on the input fname *and* safeguard against invalid subrange exception
	castFname := trim(ut.cast2keyfield(i.fname,temp_fname_value));

	//? this function is always called with temp_score_threshold_value>10
	//? move [temp_lname_value != '' AND temp_fname_value != ''] outside
	res :=project(  LIMIT (LIMIT(
				 i(keyed(dph_lname=metaphonelib.DMetaPhone1(temp_lname_value)[1..6]),
				keyed(((lname IN temp_lname_set_value) OR (temp_phonetics AND (~temp_UsePhoneticDistance OR (lname IN temp_LNamePhoneticSet)))  )), //
				keyed(pfe(pfname,temp_fname_value) OR pfname=(STRING1)temp_fname_value OR pfname[1..length(trim(temp_fname_value))]=(STRING20)temp_fname_value OR LENGTH(TRIM(temp_fname_value))<2),
				keyed(fname[1..length(castFname)]=castFname OR fname=(STRING1)temp_fname_value OR temp_nicknames), 
				keyed((st=temp_state_value or temp_state_value='')),
				keyed(temp_mname_value='' or temp_mname_value[1]=minit OR temp_score_threshold_value>10), // TODO: make wild
				keyed(yob>=(unsigned2)temp_find_year_low AND 
						yob<=IF((unsigned2)temp_find_year_high != 0, (unsigned2)temp_find_year_high, (unsigned2)0xFFFF)),
				keyed(LENGTH(TRIM(temp_ssn_value))<>4 or (unsigned2)temp_ssn_value=s4),
				temp_find_month=0 or (dob div 100) % 100=temp_find_month,
				temp_find_day=0 or dob % 100=temp_find_day,
				temp_zip_value=[] or zip IN temp_zip_value,
				AutoheaderV2.MAC_indexing.gen_filt(i)
				 ) , ut.limits.DID_PER_PERSON * 2, SKIP, keyed), 1000, SKIP)
				, transform (AutoHeaderV2.layouts.search_out, self.did := left.did, self.fetch_hit := AutoHeaderV2.Constants.FetchHit.STNAMESMALL));

	//change: dedup here;
	res_dup:= dedup (res, did, all);
	
	final_res := if (first_fil, 
									 if(exists(res_dup),
											res_dup,
											AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.STNAMESMALL, AutoHeaderV2.Constants.Status._NOT_FOUND)
											),
										AutoHeaderV2.functions.MakeDiagnosticDataset(AutoHeaderV2.Constants.FetchHit.STNAMESMALL, AutoHeaderV2.Constants.Status._DATA));
	
	return final_res;
end;

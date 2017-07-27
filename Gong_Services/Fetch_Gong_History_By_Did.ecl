/*
	Given a did input to this function, search the header file by the did
	and get the addresses, use the addresses as search criteria in 
	the gong history and return gong history records rolled up.
*/

import gong, doxie, census_data, doxie_raw;

export Fetch_Gong_History_By_Did (Dataset(doxie.layout_references) indids,
	unsigned3 dateVal = 0,unsigned1 DPPA_Purpose = 0, unsigned1 GLBA_Purpose = 0, 
	string6 ssn_mask_value = 'NONE', boolean ln_branded_value = false,
	boolean probation_override_value = false)
:= FUNCTION
	//Get the records from the header file by the dids?
	HeaderRecs := Doxie_Raw.Header_Raw(
												indids,
												dateVal,
												dppa_purpose,
												glba_purpose,
												ssn_mask_value,
												ln_branded_value,
												probation_override_value);
	joinedRecord := Gong_Services.Layout_GongHistorySearchService;
	joinedRecord doGongHeaderProject(gong.Key_History_Address l) := TRANSFORM
		SELF := l;
	END;
	GongHistoryRecs := JOIN(HeaderRecs,gong.Key_History_Address,
													LEFT.prim_range = RIGHT.prim_range
													and LEFT.prim_name = RIGHT.prim_name
													and (LEFT.sec_range = RIGHT.sec_range
														or RIGHT.sec_range = '')
													and LEFT.zip = RIGHT.z5
													and ziplib.ZipToState2(LEFT.zip) = RIGHT.st
													, doGongHeaderProject(RIGHT), limit(100, SKIP, COUNT)
);

	DedupedMatchingRecs := DEDUP(SORT(GongHistoryRecs,RECORD),RECORD);;
	
	joinedRecord doMatchingRecsRollup (joinedRecord l, joinedRecord r) := TRANSFORM
		SELF.dt_first_seen := if ( l.dt_first_seen='' 
																or r.dt_first_seen<>''
																and r.dt_first_seen < l.dt_first_seen,
																r.dt_first_seen,
																l.dt_first_seen);
		SELF.dt_last_seen := if ( l.dt_last_seen='' 
																or r.dt_last_seen<>''
																and r.dt_last_seen > l.dt_last_seen,
																r.dt_last_seen,
																l.dt_last_seen);
		SELF.current_record_flag := if(l.current_record_flag <> '',
																l.current_record_flag,
																r.current_record_flag); 
		SELF.v_city_name := if(l.p_city_name = l.v_city_name and l.v_city_name <> r.v_city_name,
															r.v_city_name,
															l.v_city_name
													);
		boolean substitute_vname := if(l.prim_name = l.v_prim_name and l.v_prim_name <> r.v_prim_name,
															true,
															false
													);
		SELF.v_predir := if(substitute_vname,
														r.v_predir,
														l.v_predir
												);
		SELF.v_prim_name := if(substitute_vname,
														r.v_prim_name,
														l.v_prim_name
												);
		SELF.v_suffix := if(substitute_vname,
														r.v_suffix,
														l.v_suffix
												);
		SELF.v_postdir := if(substitute_vname,
														r.v_postdir,
														l.v_postdir
												);

		SELF := r;
	END;

	RolledMatchingRecs := ROLLUP(DedupedMatchingRecs
																				,doMatchingRecsRollup(LEFT,RIGHT)
																				,publish_code
																				,phone10
																				,prim_range
																				,predir
																				,prim_name
																				,suffix
																				,postdir
																				,unit_desig
																				,sec_range
																				,p_city_name
//																				,v_predir
//																				,v_prim_name
//																				,v_suffix
//																				,v_postdir
//																				,v_city_name
																				,st
																				,z5
																				,z4
																				,listed_name
																				,omit_address
																				,omit_phone
																				,omit_locality
//																				,did
//																				,hhid
																				);
	
	RolledWithCountyNameRecord := RECORD
		RolledMatchingRecs;
		string18 county_name;
	END;
	RolledWithCountyNameRecord doCountyName(RolledMatchingRecs l, Census_Data.Key_Fips2County r) := TRANSFORM
		SELF.county_name := if (l.county_code <> '', r.county_name, '');
		SELF := l;
	END;
	RolledWithCountyNameRecords := JOIN(RolledMatchingRecs,Census_Data.Key_Fips2County,
																			KEYED(LEFT.st = RIGHT.state_code and
																						LEFT.county_code[3..5] = RIGHT.county_fips),
																						doCountyName(LEFT,RIGHT), LEFT OUTER, KEEP (1));
	return RolledWithCountyNameRecords;
END;

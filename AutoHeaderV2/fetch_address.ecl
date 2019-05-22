import ut, doxie, dx_header, AutoStandardI, NID, AutoHeaderV2, lib_metaphone, lib_stringlib;

export fetch_address (dataset (AutoheaderV2.layouts.search) ds_search, integer search_code=0) := function

  _row := ds_search[1];
  _options := ds_search[1].options;
  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;
	boolean currentResidentsOnly := search_code & AutoheaderV2.Constants.SearchCode.CURRENT_RESIDENTS > 0;

	temp_fname_value := _row.tname.fname;
	temp_fname_set_value := _row.tname.fname_set;
	temp_lname_value := _row.tname.lname;
	temp_lname_set_value := _row.tname.lname_set;
	temp_lnamephoneticset := _row.tname.lname_set_phonetic;
	temp_nicknames := _row.tname.nicknames;
	temp_phonetics := _row.tname.phonetic;
	temp_usephoneticdistance := _row.tname.phonetic_distance;
	temp_prange_value := _row.taddress.prim_range;
	temp_prange_wild_value := _row.taddress.prange_wild;
	temp_pname_value := _row.taddress.prim_name;
	temp_sec_range_value := _row.taddress.sec_range;
	temp_addr_range := _row.taddress._range;
	temp_addr_wild := _row.taddress._wild;
	temp_city_value := _row.taddress.city;
	temp_state_value := _row.taddress.state;
	temp_zip_value := _row.taddress.zip_set;
	temp_prev_state_val1 := _row.taddress.state_prev_1;
	temp_prev_state_val2 := _row.taddress.state_prev_2;
	temp_other_lname_value1 := _row.tname.lname_other;
	temp_date_first_seen_value := _row.taddress.date_firstseen;
	temp_date_last_seen_value := _row.taddress.date_lastseen;
	temp_allow_date_seen_value := _row.taddress.allow_dateseen;;
	temp_searchignoresaddressonly_value := _options.searchignoresaddressonly;
	temp_AllowLeadingLname := _row.tname.allow_leading_name_match;
	temp_do_primname_word_match :=  _row.taddress.err IN AutostandardI.Constants.suffix_error_set;
	//instead of AutoStandardI.InterfaceTranslator.do_primname_word_match.val(project(args,AutoStandardI.InterfaceTranslator.do_primname_word_match.params));

	temp_prim_range_set := _row.taddress.prim_range_set;
	temp_FuzzySecRange_value := _row.taddress.sec_range_fuzziness;
			
	i := dx_header.key_address();
	wi := dx_header.key_wild_address();
	dti := dx_header.key_DTS_address();
 
	boolean doSkipFname := LENGTH(TRIM(temp_fname_value))<2;
	boolean just_addr := temp_lname_value = '' and doSkipFname;
	length_temp_lname_value := length(trim(temp_lname_value));

	zips :=set(project(dataset(temp_zip_value,{Integer4 zip}),transform({string5 zip},self.zip:=intformat(left.zip,5,1))),zip);

	extended_zips := zips + 
		IF(temp_state_value<>'' AND temp_city_value<>'',set(project(dataset(ut.ZipsWithinCity(temp_state_value,temp_city_value),{Integer4 zip}),transform({string5 zip},self.zip:=intformat(left.zip,5,1))),zip),[]);

	maxres := if(just_addr, ut.limits.FETCH_JUST_ADDR, ut.limits.FETCH_UNKEYED);
	temp_pname_value_word:=trim(temp_pname_value)+' ';
	index_Lev1 := project(
					 wi(temp_pname_value != '',
				 not (temp_SearchIgnoresAddressOnly_value and just_addr),
			 keyed(if(temp_do_primname_word_match,(prim_name[1..length(temp_pname_value_word)]=temp_pname_value_word),prim_name=temp_pname_value)), 
			 keyed(temp_prange_value = '' OR 
					temp_prange_value=prim_range OR
				//TODO: redundant:						(temp_addr_loose and  ~temp_addr_range) OR
					(temp_addr_range AND (prim_range IN temp_prim_range_set)) OR
					temp_addr_wild),					
			 keyed(temp_state_value=st OR temp_state_value=''), 
			 keyed(city_code in doxie.Make_CityCodes(temp_city_value).rox OR temp_city_value=''), 
			 keyed(extended_zips=[] or zip IN extended_zips),
			 keyed(temp_sec_range_value='' or temp_sec_range_value=sec_range),				 
				temp_prev_state_val1='' or ut.bit_test(states,ut.St2Code(temp_prev_state_val1)),
				temp_prev_state_val2='' or ut.bit_test(states,ut.St2Code(temp_prev_state_val2)),				
				keyed(temp_lname_value='' OR (lname IN temp_lname_set_value) OR (temp_AllowLeadingLname and length_temp_lname_value >= 3 and lname[1..length_temp_lname_value] = temp_lname_value)), //
				keyed(doSkipFname OR fname IN temp_fname_set_value),
				temp_other_lname_value1[1]='' or ut.bit_test(lname1,ut.Chr2Code(temp_other_lname_value1[1])),
				temp_other_lname_value1[2]='' or ut.bit_test(lname2,ut.Chr2Code(temp_other_lname_value1[2])),
				temp_other_lname_value1[3]='' or ut.bit_test(lname3,ut.Chr2Code(temp_other_lname_value1[3])),
				not temp_addr_wild OR Stringlib.StringWildMatch(prim_range, temp_prange_wild_value, TRUE),
				not currentResidentsOnly or ut.bit_test(lookups,31)),
				transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.ADDRESS));


	// FUZZY SEC RANGE SEARCH
	// so far: type 1 -- NNEQ; type 2 -- contains exact "atom" (a separate, stand-alone symbol(s) or number)

	// regex pattern for type 2 fuzzy secrange search
	string sec_range_pattern := AutoheaderV2.Functions.GetSecrangeAtomPattern (temp_sec_range_value);

	srange := AutoStandardI.Constants.SECRANGE;

	index_fuzzy := project(
					 i(temp_pname_value != '',
				 not (temp_SearchIgnoresAddressOnly_value and just_addr),
			 keyed(if(temp_do_primname_word_match,(prim_name[1..length(temp_pname_value_word)]=temp_pname_value_word),prim_name=temp_pname_value)), 
			 keyed(temp_prange_value = '' OR 
					temp_prange_value=prim_range OR
		//TODO: redundant:						(temp_addr_loose and  ~temp_addr_range) OR
					(temp_addr_range AND (prim_range IN temp_prim_range_set)) OR
					temp_addr_wild),					
			 keyed(temp_state_value=st OR temp_state_value=''), 
			 keyed(city_code in doxie.Make_CityCodes(temp_city_value).rox OR temp_city_value=''), 
			 keyed(extended_zips=[] or zip IN extended_zips),

			 // fuzzy seach: flexible secrange.
			 keyed( (temp_sec_range_value='') or
							(temp_FuzzySecRange_value=srange.EXACT and temp_sec_range_value = sec_range) or 
							(temp_FuzzySecRange_value=srange.EXACT_OR_BLANK and ut.NNEQ(temp_sec_range_value,sec_range)) or 
							(temp_FuzzySecRange_value=srange.INCLUDES_ATOM)),
			 // this is a post-filter (vs. keyed condition above)
				(temp_FuzzySecRange_value != srange.INCLUDES_ATOM or regexfind (sec_range_pattern, sec_range)),

				temp_prev_state_val1='' or ut.bit_test(states,ut.St2Code(temp_prev_state_val1)),
				temp_prev_state_val2='' or ut.bit_test(states,ut.St2Code(temp_prev_state_val2)),				
				// fuzzy seach: phonetics 
				keyed(temp_lname_value='' or temp_AllowLeadingLname or dph_lname=metaphonelib.DMetaPhone1(temp_lname_value)[1..6]),		
				keyed(temp_lname_value='' OR (lname IN temp_lname_set_value) OR (temp_AllowLeadingLname and length_temp_lname_value >= 3 and lname[1..length_temp_lname_value] = temp_lname_value) OR (temp_phonetics AND (~temp_UsePhoneticDistance OR (lname IN temp_LNamePhoneticSet)))), //
				// require fname match if nicknames not enabled
				keyed(doSkipFname or (NID.mod_PFirstTools.RinPFL(temp_fname_value,pfname))),
				keyed(doSkipFname OR temp_nicknames OR fname IN temp_fname_set_value),
				temp_other_lname_value1[1]='' or ut.bit_test(lname1,ut.Chr2Code(temp_other_lname_value1[1])),
				temp_other_lname_value1[2]='' or ut.bit_test(lname2,ut.Chr2Code(temp_other_lname_value1[2])),
				temp_other_lname_value1[3]='' or ut.bit_test(lname3,ut.Chr2Code(temp_other_lname_value1[3])),
				not temp_addr_wild OR Stringlib.StringWildMatch(prim_range, temp_prange_wild_value, TRUE),
				not currentResidentsOnly or ut.bit_test(lookups,31)),
				transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.ADDRESS));

	// need to only include these matches if there aren't too many
	doSkip := true;
	Fetch_Lev_fuzzy := AutoheaderV2.functions.FetchConstraints (index_fuzzy,ut.limits.FETCH_KEYED,maxres,doSkip,203,,AutoheaderV2.Constants.FetchHit.ADDRESS); 
		
	//adding fetch by dt_seen
	index_LevDt := 
		 PROJECT(dti(not (temp_SearchIgnoresAddressOnly_value and just_addr),
							keyed(if(temp_do_primname_word_match,(prim_name[1..length(temp_pname_value_word)]=temp_pname_value_word),prim_name=temp_pname_value)), 
						 keyed(temp_prange_value = '' OR 
							temp_prange_value=prim_range OR
		//TODO: redundant:								(temp_addr_loose and  ~temp_addr_range) OR 
							(temp_addr_range AND (prim_range IN temp_prim_range_set)) OR
							temp_addr_wild),
					 keyed(temp_state_value=st OR temp_state_value=''), 
					 keyed(city_code in doxie.Make_CityCodes(temp_city_value).rox OR temp_city_value=''), 
				keyed(extended_zips=[] or zip IN extended_zips),
				keyed(temp_date_first_seen_value=0 and dt_last_seen >= temp_date_last_seen_value or 
											 temp_date_first_seen_value<>0 and dt_last_seen >= temp_date_first_seen_value),
					 keyed(temp_sec_range_value='' or temp_sec_range_value=sec_range),
					 temp_prev_state_val1='' or ut.bit_test(states,ut.St2Code(temp_prev_state_val1)),
				temp_prev_state_val2='' or ut.bit_test(states,ut.St2Code(temp_prev_state_val2)),
				keyed(temp_lname_value='' or dph_lname=metaphonelib.DMetaPhone1(temp_lname_value)[1..6]),
				keyed(temp_lname_value='' OR (lname IN temp_lname_set_value) OR (temp_phonetics AND (~temp_UsePhoneticDistance OR (lname IN temp_LNamePhoneticSet)))), //
				// require fname match if nicknames not enabled
				keyed(doSkipFname or (NID.mod_PFirstTools.RinPFL(temp_fname_value, pfname))),
				keyed(doSkipFname OR temp_nicknames OR (fname IN temp_fname_set_value)),
							dt_first_seen <= temp_date_last_seen_value,	
				temp_other_lname_value1[1]='' or ut.bit_test(lname1,ut.Chr2Code(temp_other_lname_value1[1])),
				temp_other_lname_value1[2]='' or ut.bit_test(lname2,ut.Chr2Code(temp_other_lname_value1[2])),
				temp_other_lname_value1[3]='' or ut.bit_test(lname3,ut.Chr2Code(temp_other_lname_value1[3])),
				not temp_addr_wild OR Stringlib.StringWildMatch(prim_range, temp_prange_wild_value, TRUE),
				not currentResidentsOnly or ut.bit_test(lookups,31)), 
				transform (AutoheaderV2.layouts.search_out, self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.ADDRESS));

	index_Lev := if(temp_allow_date_seen_value and temp_date_last_seen_value<>0 and temp_pname_value<>'', index_LevDt, index_Lev1);	   

	Fetch_Lev := AutoHeaderV2.functions.FetchConstraints(index_Lev,ut.limits.FETCH_KEYED,ut.limits.FETCH_UNKEYED,no_fail,203,,AutoheaderV2.Constants.FetchHit.ADDRESS); 
	// fuzzy search makes sense only if input sec range isn't blank OR phonetics search takes place;
	boolean is_fuzzy := ~just_addr or ((temp_FuzzySecRange_value != srange.EXACT) and (temp_sec_range_value !='')); 
	res_final := Fetch_Lev + if (is_fuzzy, Fetch_Lev_fuzzy);
	
	return if(exists(res_final), res_final, AutoHeaderV2.functions.MakeDiagnosticDataset(AutoheaderV2.Constants.FetchHit.ADDRESS, AutoheaderV2.Constants.STATUS._NOT_FOUND));
end;

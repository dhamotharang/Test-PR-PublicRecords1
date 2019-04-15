import doxie, AutoStandardI, ut, NID, dx_header;

export mod_PartialMatch(mod_Params.PersonSearch search_mod) := MODULE

	shared ResponseLayout := RECORD
		doxie.key_header.did;
		UNSIGNED4 score;
	END;

	// once all of the DIDs are rolled up and scored, any DIDs scoring less than
	// respScoreCutoff * maxDIDScore will be dropped immediately.
	shared respScoreCutoff := 0.33;

	shared IT := AutoStandardI.InterfaceTranslator;
	shared inFirstName := IT.fname_value.val(project(search_mod, IT.fname_val.params));
	shared inMiddleName := IT.mname_value.val(project(search_mod, IT.mname_val.params));
	shared inLastName := IT.lname_value.val(project(search_mod, IT.lname_val.params));

	// build a few sets of first names.  These will be empty if there is no 
	// first name given in the inputs.
	shared fnameLayout := RECORD
		STRING30 fname;
	END;

	// nine closest variations of the input first name
	shared inFirstNameVariants := if(inFirstName <> '', DATASET(ut.namevariants(inFirstName, 9, FALSE).fnames, fnameLayout));
	shared inFirstNameVariantsSet := SET(inFirstNameVariants, fname);

	// the preferred name for each of the nine above.
	fnameLayout toPreferredOld(fnameLayout L) := TRANSFORM
		SELF.fname := NID.PreferredFirstNew(l.fname, false);
	END;

	fnameLayout toPreferredNew(fnameLayout L) := TRANSFORM
		SELF.fname := NID.PreferredFirstNew(l.fname, true);
	END;

	shared inPreferredFirstNameVariants := DEDUP(SORT(PROJECT(inFirstNameVariants, toPreferredOld(LEFT)) + 
	                                                  PROJECT(inFirstNameVariants, toPreferredNew(LEFT)), RECORD), RECORD);
	shared inPreferredFirstNameVariantsSet := SET(inPreferredFirstNameVariants, fname);

	// if we got a preferred first name which wasn't already a variant, include
	// it in the list of the original nine.
	shared inAllFirstNameVariants := DEDUP(SORT(inPreferredFirstNameVariants + inFirstNameVariants, RECORD), RECORD);
	shared inAllFirstNameVariantsSet := SET(inAllFirstNameVariants, fname);

	shared inPhoneticLastName := if(inLastName <> '', metaphonelib.DMetaphone1(inLastName)[1..6], '');  //most or all of these keys have dph_lname limited to string6

	shared inStreet := IT.addr_value.val(project(search_mod, IT.addr_value.params));  // FIXME - ignored for now

	shared inPrimRange := IT.prange_value.val(project(search_mod, IT.prange_value.params));
	shared inPrimName := IT.pname_value.val(project(search_mod, IT.pname_value.params));
	shared inSecRange := IT.sec_range_value.val(project(search_mod, IT.sec_range_value.params));
	shared inCity := IT.city_value.val(project(search_mod, IT.city_value.params));
	shared inState := IT.state_value.val(project(search_mod, IT.state_value.params));
	shared inZip5 := (INTEGER) IT.zip_val.val(project(search_mod, IT.zip_val.params));
	shared inCityZip := (INTEGER)IT.city_zip_value.val(project(search_mod, IT.city_zip_value.params));

	shared inZip5Set := IT.zip_value.val(project(search_mod, IT.zip_value.params)) + if(inCityZip > 0, [inCityZip], []);

	shared inPhone := IT.phone_value.val(project(search_mod, IT.phone_value.params));
	
	maxResults := IT.maxresults_val.val(project(search_mod, IT.maxresults_val.params));
	shared inMaxResults := if (maxResults = 0, 100, maxResults);
	shared MaxKeyResults := (UNSIGNED) ut.limits.FETCH_UNKEYED;

	// some "shortcut" boolean expressions to be used below.
	shared BOOLEAN hasName := inLastName <> '';
	shared BOOLEAN hasFName := LENGTH(TRIM(inFirstName)) > 1;
	shared BOOLEAN hasFInit := LENGTH(TRIM(inFirstName)) = 1;
	shared BOOLEAN hasLName := inLastName <> '';
	shared BOOLEAN hasPrimRange := inPrimRange <> '';
	shared BOOLEAN hasPrimName := inPrimName <> '';
//	shared BOOLEAN hasStreet := hasPrimRange OR hasPrimName;	
	shared BOOLEAN hasCity := inCity <> '';
	shared BOOLEAN hasState := inState <> '';
	shared BOOLEAN hasCityState := hasCity AND hasState;
	shared BOOLEAN hasZip := inZip5 <> 0;
	shared BOOLEAN hasValidPhone := inPhone <> '' AND (length(TRIM(inPhone)) = 10 OR length(TRIM(inPhone)) = 7);
	
	// this is the city_code value needed for city name lookups in doxie keys.
	shared set of UNSIGNED inCityCode := doxie.Make_CityCodes(inCity).rox;

	shared ResponseLayout emptyResponse := DATASET([], ResponseLayout);
	
	// These values are loosely based on the values found in mod_Score, and
	// represent the contribution of each individual field to the overall entity
	// score.  As an example, the street address accounts for 20% of the entity
	// score, and the primary range accounts for 25/70 of that score:
  //
	//   prim_range (25) + prim_name (25) + sec_range (20) = 70
	//   (prim_range (25)/ total possible (70)) * contrib of street address (20) = 7.14
	//
	// These results were then multiplied by 10 to give a greater possible 
	// variation in scores, eg. 0..71 vs 0..7 in this case.
	//
	// This is not a hard rule, but was used as a guideline for establishing
	// base values.  Two notable deviations are in the name (where middle name
	// is not considered), and that name + state combination is weighted equally
	// with the zip code.
	shared did_wt_lname := 120;
	shared did_wt_fname := 80;

	shared did_wt_prim_range := 71;
	shared did_wt_prim_name := 71;
	shared did_wt_sec_range := 58;

	shared did_wt_city := 50;
	shared did_wt_state := 50;
	shared did_wt_zip := 100;

	shared did_wt_phone := 200;

  // minimum "percentages" (scaled 0-1) for various fields.  If the normalized
	// edit distance between input and response values falls below these 
	// thresholds, the entire response will be rejected as being too weak.
	shared min_pct_lname      := 30;
	shared min_pct_fname      := 30;

	shared min_pct_prim_range := 20;
	shared min_pct_prim_name  := 40;
	shared min_pct_sec_range  := 50;

	shared min_pct_city       := 40;
	shared min_pct_state      := 100;
	shared min_pct_zip        := 60;

	shared min_pct_phone      := 100;

	// convert a set of INTEGER4 zip codes (presumably generated by 
	// ut.ZipsWithinCity) to a set of QSTRING5-formatted zips required to
	// access certain key files (such as doxie.key_header_address).
	shared fn_ZipSetToQString(SET OF INTEGER4 zips) := FUNCTION
		zips_ds := DATASET( zips, { INTEGER4 zip });

		qstringZip := RECORD
			QSTRING5 zip;
		END;

		qstringZip toQstringZip(zips_ds L) := TRANSFORM
			SELF.zip := (QSTRING5) L.zip;
		END;

		QStringZipSet := PROJECT(zips_ds, toQstringZip(LEFT));
		zipSet := SET(QStringZipSet, zip);
		return zipSet;
	END;

	shared BOOLEAN fn_RejectField(STRING input, STRING response, UNSIGNED pct) := FUNCTION
		ed := fn_NormalizedEditDistance(input, response, 100);
		mylength(string s) := length(trim(s));
		isleadingoneway(string a, string b) := a = b[1..mylength(a)];
		isleadingmatch(string a, string b) := isleadingoneway(a,b) or isleadingoneway(b,a);
		return MAP( input = '' 											=> FALSE,
								input = response								=> FALSE,
								isleadingmatch(input, response)	=> FALSE,
								ed < pct 												=> TRUE, 
								FALSE);
	END;

	// a name + city/state search
	export NameCityState := MODULE
	  // key begins with city, state, (string6)dph_lname, lname, pfname, fname
		idx := doxie.key_header_stcitylfname;

		qryWithFirst := idx(KEYED(city_code in inCityCode) AND
												KEYED(st = inState) AND
												KEYED(dph_lname = inPhoneticLastName) AND
												pfname IN inPreferredFirstNameVariantsSet);

		qryWithFInit := idx(KEYED(city_code in inCityCode) AND
												KEYED(st = inState) AND
												KEYED(dph_lname = inPhoneticLastName) AND
												fname[1] = inFirstName[1]);

		qryWithoutFirst := idx(KEYED(city_code in inCityCode) AND
													KEYED(st = inState) AND
													KEYED(dph_lname = inPhoneticLastName) AND
													KEYED(lname = inLastName));
										
		raw_WithFirst := IF(hasFName, qryWithFirst);
		raw_WithFInit := IF(hasFName or hasFInit, qryWithFInit);
										
		raw_recs := map(exists(raw_WithFirst) => raw_WithFirst,
										exists(raw_WithFInit) => raw_WithFInit,
										qryWithoutFirst);

		responseLayout ScoreRaw(raw_recs L) := TRANSFORM, SKIP (fn_RejectField(inLastName, L.lname, min_pct_lname) OR
																														(LENGTH(inFirstName) > 1 AND fn_RejectField(inFirstName, L.fname, min_pct_fname)))
			SELF.did := L.did;

			lname_score := fn_NormalizedEditDistance(inLastName, L.lname, did_wt_lname);
			fname_score := MAP(hasFName => fn_NormalizedEditDistance(inFirstName, L.fname, did_wt_fname),
												 hasFInit AND inFirstName[1] = L.fname[1] => did_wt_fname,
												 0);

			SELF.score := did_wt_city + did_wt_state +	// city + state given
										lname_score + 								// lname is given, but score will vary
										if(inFirstName <> '', fname_score, 0);
		END;

		doxie.mac_FetchLimitLimitSkipFail(raw_recs, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED,   
																			true, 203, false, false, limit_dids);																			
		scored_dids := PROJECT(DISTRIBUTE(limit_dids, did), ScoreRaw(LEFT));
		sorted_dids := SORT(scored_dids, did, -score, LOCAL);
		dids := DEDUP(sorted_dids, LEFT.did = RIGHT.did, LOCAL);  // keeps highest score!

		doQuery := hasName AND hasCityState;
		rval := if(doQuery, dids, emptyResponse);

		#IF(Debug.debug_flag)
		output(doQuery, NAMED('doNameCityState'));
		output(raw_recs, NAMED('indNameCityStateRecs'));
		output(scored_dids, NAMED('indNameCityStateScored'));
		output(rval, NAMED('indNameCityStateDIDs'));
		#END

		export ResponseLayout records := rval;
	END;

	// a name + zip search
	export NameZip := MODULE
		// key has: zip, (string6)dph_lname, lname, pfname, fname
		idx := doxie.key_header_piz;
    inpiz5 := ut.PizTools.reverseZip((string5)inzip5);
		qryWithFirst := idx(KEYED(piz = inpiz5) AND
												KEYED(dph_lname = inPhoneticLastName) AND
												pfname IN inPreferredFirstNameVariantsSet);

		qryWithFInit := idx(KEYED(piz = inpiz5) AND
												KEYED(dph_lname = inPhoneticLastName) AND
												fname[1] = inFirstName[1]);

		qryWithoutFirst := idx(KEYED(piz = inpiz5) AND
													 KEYED(dph_lname = inPhoneticLastName) AND
													 KEYED(lname = inLastName));
		
		raw_WithFirst := IF(hasFName, qryWithFirst);
		raw_WithFInit := IF(hasFName or hasFInit, qryWithFInit);
										
		raw_recs := map(exists(raw_WithFirst) => raw_WithFirst,
										exists(raw_WithFInit) => raw_WithFInit,
										qryWithoutFirst);

		responseLayout ScoreRaw(raw_recs L) := TRANSFORM, SKIP (fn_RejectField(inLastName, L.lname, min_pct_lname) OR
																														(LENGTH(inFirstName) > 1 AND fn_RejectField(inFirstName, L.fname, min_pct_fname)))
			SELF.did := L.did;

			lname_score := fn_NormalizedEditDistance(inLastName, L.lname, did_wt_lname);
			fname_score := MAP(hasFName => fn_NormalizedEditDistance(inFirstName, L.fname, did_wt_fname),
												 hasFInit AND inFirstName[1] = L.fname[1] => did_wt_fname,
												 0);

			SELF.score := did_wt_zip + lname_score + // zip + last name are given, but last score will vary
										if(inFirstName <> '', fname_score, 0);
		END;

		doxie.mac_FetchLimitLimitSkipFail(raw_recs, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED, 
																			true, 203, false, false, limit_dids);
		scored_dids := PROJECT(DISTRIBUTE(limit_dids, did), ScoreRaw(LEFT));
		sorted_dids := SORT(scored_dids, did, -score, LOCAL);
		dids := DEDUP(sorted_dids, LEFT.did = RIGHT.did, LOCAL);  // keeps highest score!

		doQuery := hasName AND hasZip;
		rval := if(doQuery, dids, emptyResponse);

		#IF(Debug.debug_flag)
		output(doQuery, NAMED('doNameZip'));
		output(raw_recs, NAMED('indNameZipRecs'));
		output(scored_dids, NAMED('indNameZipScored'));
		output(rval, NAMED('indNameZipDIDs'));
		#END

		export ResponseLayout records := rval;
	END;

	// a name + st search
	export NameState := MODULE
		// BZ 42358 - name/state search should use exact last + preferred first name.
		idx := doxie.Key_Header_StFnameLname;

		raw_recs := idx(KEYED(st = inState) AND
										KEYED(dph_lname = inPhoneticLastName) AND
										KEYED(lname = inLastname) AND
										KEYED(pfname IN inPreferredFirstNameVariantsSet)
										);  //the double use of ut.limits.FETCH_UNKEYED below is depending on all filters being keyed

		// guaranteed a match on state and lname, variable score on first name.
		responseLayout ScoreRaw(raw_recs L) := TRANSFORM, SKIP(fn_RejectField(inFirstName, L.fname, min_pct_fname))
			SELF.did := L.did;
			fname_score := fn_NormalizedEditDistance(inFirstName, L.fname, did_wt_fname);
			SELF.score := did_wt_state + did_wt_lname + fname_score;
		END;

		doxie.mac_FetchLimitLimitSkipFail(raw_recs, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED, 
																			true, 203, false, false, limit_dids);
		scored_dids := PROJECT(DISTRIBUTE(limit_dids, did), ScoreRaw(LEFT));
		sorted_dids := SORT(scored_dids, did, -score, LOCAL);
		dids := DEDUP(sorted_dids, LEFT.did = RIGHT.did, LOCAL);  // keeps highest score!

		doQuery := hasName AND hasFName AND hasState;
		rval := if(doQuery, dids, emptyResponse);

		#IF(Debug.debug_flag)
		output(doQuery, NAMED('doNameState'));
		output(raw_recs, NAMED('indNameStateRecs'));
		output(scored_dids, NAMED('indNameStateScored'));
		output(rval, NAMED('indNameStateDIDs'));
		#END

		export ResponseLayout records := rval;
	END;
	
	export StreetState := MODULE
		// key has:  prim_name, prim_range, state, city_code, zip, dph_lname, lname, pfname, and fname
		idx := doxie.key_header_dts_address;

		raw_recs := idx(KEYED(prim_name = inPrimName) AND
										KEYED(prim_range = inPrimRange) AND
										KEYED(st = inState) AND
											(
												sec_range = inSecRange OR 
												dph_lname = inPhoneticLastName
											)
										);

		ResponseLayout ScoreRaw(raw_recs L) := TRANSFORM, SKIP(fn_RejectField(inSecRange, L.sec_range, min_pct_sec_range) OR
																													 (inZip5 <> 0 AND fn_RejectField((STRING5) inZip5, L.zip, min_pct_zip)) OR
																													 fn_RejectField(inLastName, L.lname, min_pct_lname) OR
																													 (LENGTH(inFirstName) > 1 AND fn_RejectField(inFirstName, L.fname, min_pct_fname)))
			SELF.did := L.did;

			sec_range_score := fn_NormalizedEditDistance((STRING5) inSecRange, L.sec_range, did_wt_sec_range);
			city_score := if(L.city_code in inCityCode, did_wt_city, 0);
			zip_score := fn_NormalizedEditDistance((STRING5) inZip5, L.zip, did_wt_zip);
			lname_score := fn_NormalizedEditDistance(inLastName, L.lname, did_wt_lname);
			fname_score := MAP(hasFName => fn_NormalizedEditDistance(inFirstName, L.fname, did_wt_fname),
												 hasFInit AND inFirstName[1] = L.fname[1] => did_wt_fname,
												 0);

			SELF.score := did_wt_prim_name + did_wt_prim_range + did_wt_state +
										if(inSecRange <> '', sec_range_score, 0) +
										// if(inCity <> '', city_score, 0) +
										if(inZip5 > 0, zip_score, 0) +
										if(inLastName <> '', lname_score, 0) +
										if(inFirstName <> '', fname_score, 0);
		END;

		doxie.mac_FetchLimitLimitSkipFail(raw_recs, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED, 
																			true, 203, false, false, limit_dids);
		scored_dids := PROJECT(DISTRIBUTE(limit_dids, did), ScoreRaw(LEFT));
		sorted_dids := SORT(scored_dids, did, -score, LOCAL);
		dids := DEDUP(sorted_dids, LEFT.did = RIGHT.did, LOCAL);  // keeps highest score!

		doQuery := hasPrimRange AND hasPrimName AND hasState;
		rval := if(doQuery, dids, emptyResponse);

		#IF(Debug.debug_flag)
		output(doQuery, NAMED('doStreetState'));
		output(raw_recs, NAMED('indStreetStateRecs'));
		output(scored_dids, NAMED('indStreetStateScored'));
		output(rval, NAMED('indStreetStateDIDs'));
		#END

		export ResponseLayout records := rval;
	END;

	export NameStreet := MODULE
		// key has:  prim_name, prim_range, state, city_code, zip, dph_lname, lname, pfname, and fname
		idx := doxie.key_header_dts_address;

		raw_recs := idx(KEYED(prim_name = inPrimName) AND
										KEYED(prim_range = inPrimRange) AND
										lname = inLastName);

		ResponseLayout ScoreRaw(raw_recs L) := TRANSFORM, SKIP (fn_RejectField(inSecRange, L.sec_range, min_pct_sec_range) OR
																														fn_RejectField(inState, L.st, min_pct_state) OR
																														(inZip5 <> 0 AND fn_RejectField((STRING5) inZip5, L.zip, min_pct_zip)) OR
																														(LENGTH(inFirstName) > 1 AND fn_RejectField(inFirstName, L.fname, min_pct_fname)))
			SELF.did := L.did;

			sec_range_score := fn_NormalizedEditDistance((STRING5) inSecRange, L.sec_range, did_wt_sec_range);
			state_score := if(inState = L.st, did_wt_state, 0);
			city_score := if(L.city_code in inCityCode, did_wt_city, 0);
			zip_score := fn_NormalizedEditDistance(if(inZip5 <> 0, (STRING5) inZip5, ''), L.zip, did_wt_zip);
			fname_score := MAP(hasFName => fn_NormalizedEditDistance(inFirstName, L.fname, did_wt_fname),
												 hasFInit AND inFirstName[1] = L.fname[1] => did_wt_fname,
												 0);

			SELF.score := did_wt_prim_name + did_wt_prim_range + did_wt_lname +
										if(inState <> '', state_score, 0) +
										if(inSecRange <> '', sec_range_score, 0) +
										if(inCity <> '', city_score, 0) +
										if(inZip5 > 0, zip_score, 0) +
										if(inFirstName <> '', fname_score, 0);
		END;

		doxie.mac_FetchLimitLimitSkipFail(raw_recs, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED, 
																			true, 203, false, false, limit_dids);
		scored_dids := PROJECT(DISTRIBUTE(limit_dids, did), ScoreRaw(LEFT));
		sorted_dids := SORT(scored_dids, did, -score, LOCAL);
		dids := DEDUP(sorted_dids, LEFT.did = RIGHT.did, LOCAL);  // keeps highest score!

		doQuery := (not hasState) and (not hasZip) and hasPrimRange AND hasPrimName AND hasLName;
		rval := if(doQuery, dids, emptyResponse);

		#IF(Debug.debug_flag)
		output(doQuery, NAMED('doNameStreet'));
		output(raw_recs, NAMED('indNameStreetRecs'));
		output(scored_dids, NAMED('indNameStreetScored'));
		output(rval, NAMED('inNameStreetDIDs'));
		#END

		export ResponseLayout records := rval;
	END;

	export StreetZip := MODULE
	// key has: prim_name, zip, prim_range, sec_range....lname
		idx := dx_header.key_header_address();
		raw_recs := idx(KEYED(prim_name = inPrimName) AND
										KEYED(zip = (QSTRING) inZip5) AND
										KEYED(prim_range = inPrimRange) AND
											(
												sec_range = inSecRange OR 
												lname = inLastName
											)
										);

		ResponseLayout ScoreRaw(raw_recs L) := TRANSFORM, SKIP(fn_RejectField(inSecRange, L.sec_range, min_pct_sec_range) OR
																													 fn_RejectField(inCity, L.city_name, min_pct_city) OR
																													 (LENGTH(inFirstName) > 1 AND fn_RejectField(inFirstName, L.fname, min_pct_fname)) OR
																													 fn_RejectField(inLastName, L.lname, min_pct_lname) OR
																													 fn_RejectField(inState, L.st, min_pct_state))
			SELF.did := L.did;

			sec_range_score := fn_NormalizedEditDistance(inSecRange, L.sec_range, did_wt_sec_range);
			city_score := fn_NormalizedEditDistance(inCity, L.city_name, did_wt_city);
			fname_score := MAP(hasFName => fn_NormalizedEditDistance(inFirstName, L.fname, did_wt_fname),
												 hasFInit AND inFirstName[1] = L.fname[1] => did_wt_fname,
												 0);
			lname_score := fn_NormalizedEditDistance(inLastName, L.lname, did_wt_lname);
			state_score := if(inState = L.st, did_wt_state, 0);

			SELF.score := did_wt_prim_name + did_wt_zip + did_wt_prim_range +
										IF(inSecRange <> '', sec_range_score, 0) +
										IF(inCity <> '', city_score, 0) +
										IF(inFirstName <> '', fname_score, 0) +
										IF(inLastName <> '', lname_score, 0) +
										IF(inState <> '', state_score, 0);
		END;

		doxie.mac_FetchLimitLimitSkipFail(raw_recs, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED, 
																			true, 203, false, false, limit_dids);
		scored_dids := PROJECT(DISTRIBUTE(limit_dids, did), ScoreRaw(LEFT));
		sorted_dids := SORT(scored_dids, did, -score, LOCAL);
		dids := DEDUP(sorted_dids, LEFT.did = RIGHT.did, LOCAL);  // keeps highest score!

		doQuery := hasPrimName AND hasPrimRange AND hasZip;
		rval := if(doQuery, dids, emptyResponse);

		#IF(Debug.debug_flag)
		output(doQuery, NAMED('doStreetZip'));
		output(raw_recs, NAMED('indStreetZipRecs'));
		output(scored_dids, NAMED('indStreetZipScored'));
		output(rval, NAMED('indStreetZipDIDs'));
		#END
		
		export ResponseLayout records := rval;
	END;
	
	export StreetZipName := MODULE
		idx_name := doxie.Key_Header_StreetZipName;
		idx_noname := dx_header.key_header_address();

		// if we have city and state inputs, we can build a set of zip codes for
		// that city/state.  This set should be a superset of what is already in
		// the inZip5Set.  If we have city + state and are able to resolve it into
		// a set of zip codes, we'll use the larger zip set in the lookups here.
		derrivedZipFromCity := IF(inState <> '' and inCity <> '', 
															ut.ZipsWithinCity(inState, inCity), [] );

		useZipSet := if(EXISTS(derrivedZipFromCity), derrivedZipFromCity, inZip5Set);

		// this search may hit one of two keys depending on whether a last name is 
		// given.  Unfortunately, these keys have a slightly different layout.
		// This layout is intended to provide a common layout with the fields
		// needed to score below.
		StreetZipNameLayout := RECORD
			idx_name.prim_name;
			idx_name.zip;
			idx_name.prim_range;
			idx_name.fname;
			idx_name.lname;
			idx_name.did;
		END;

		StreetZipNameLayout idxNameTransform(idx_name L) := TRANSFORM
			SELF := L;
		END;

		StreetZipNameLayout idxNoNameTransform(idx_noname L) := TRANSFORM
			SELF.zip := (INTEGER4) L.zip;
			SELF := L;
		END;

		// given a last name, the search is pretty simple...
		raw_recs_name := PROJECT(idx_name(KEYED(prim_name = inPrimName) AND
																			KEYED(zip in useZipSet) AND
																			KEYED(dph_lname = inPhoneticLastName)), idxNameTransform(LEFT));

		// without a last name, we run into a whole bunch of trouble with an 
		// overly-broad query.  We need to filter the number of response records.
		// The best option we have is to take key entries last reported less than
		// five years ago reported only by a few select data sources.
		today := (UNSIGNED4) (((UNSIGNED4) stringlib.GetDateYYYYMMDD()) / 100); // drop the day (YYYYMMDD => YYYYMM)
		yesterday := if(today > 500, today - 500, 0);                           // subtract 500 = -5 yrs, 00 months
		raw_recs_noname := PROJECT(idx_noname(KEYED(prim_name = inPrimName) AND
																					KEYED(zip in fn_ZipSetToQString(useZipSet)) AND
																					dt_last_seen >= yesterday AND
																					src in Constants.TOP_VENDORS), idxNoNameTransform(LEFT));

		// which key do we use!?
		raw_recs := if(inPhoneticLastName <> '', raw_recs_name, raw_recs_noname);

		ResponseLayout ScoreRaw(raw_recs L) := TRANSFORM, SKIP((inZip5 <> 0 AND fn_RejectField((STRING5) inZip5, (STRING5) L.zip, min_pct_zip)) OR
																													 fn_RejectField(inLastName, L.lname, min_pct_lname) OR
																													 fn_RejectField(inFirstName, L.fname, min_pct_fname) OR
																													 fn_RejectField(inPrimRange, L.prim_range, min_pct_prim_range))
			SELF.did := L.did;
			
			zip_score := fn_NormalizedEditDistance(if(inZip5 <> 0, (STRING) inZip5, ''), (STRING) L.zip, did_wt_zip);
			lname_score := fn_NormalizedEditDistance(inLastName, L.lname, did_wt_lname);
			fname_score := MAP(hasFName => fn_NormalizedEditDistance(inFirstName, L.fname, did_wt_fname),
												 hasFInit AND inFirstName[1] = L.fname[1] => did_wt_fname,
												 0);
			prange_score := fn_NormalizedEditDistance(inPrimRange, L.prim_range, did_wt_prim_range);

			// for scoring, we either have a zip or city + state (guaranteed by the
			// condition guarding the execution of this condition).  If we have a
			// zip, we use a fuzzy score against the input.  Otherwise, we know we
			// have an exact match on city and state since it was used to generate
			// the set of zip codes.
			SELF.score := did_wt_prim_name + 
										IF(inZip5 > 0, zip_score, did_wt_city + did_wt_state) + 
										IF(inLastName <> '', lname_score, 0) +
										IF(inFirstName <> '', fname_score, 0) +
										IF(inPrimRange <> '', prange_score, 0);
		END;

		doxie.mac_FetchLimitLimitSkipFail(raw_recs, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED, 
																			true, 203, false, false, limit_dids);
		scored_dids := PROJECT(DISTRIBUTE(limit_dids, did), ScoreRaw(LEFT));
		sorted_dids := SORT(scored_dids, did, -score, LOCAL);
		dids := DEDUP(sorted_dids, LEFT.did = RIGHT.did, LOCAL);  // keeps highest score!

		doQuery := hasPrimName AND (hasZip OR hasCityState);
		rval := if(doQuery, dids, emptyResponse);

		#IF(Debug.debug_flag)
		output(doQuery, NAMED('doStreetZipName'));
		output(useZipSet, NAMED('indStreetZipNameZipSet'));
		output(raw_recs, NAMED('indStreetZipNameRecs'));
		output(scored_dids, NAMED('indStreetZipNameScored'));
		output(rval, NAMED('indStreetZipNameDIDs'));
		#END
		
		export ResponseLayout records := rval;
	END;	

	export Phone := MODULE
		idx := doxie.key_header_wild_phone;

		inP7 := MAP(length(inPhone) = 10 => inPhone[4..10],
								length(inPhone) = 7 => inPhone[1..7],
								'');

		inP3 := IF(length(inPhone) = 10, inPhone[1..3], '');

		raw_recs := idx(KEYED(p7 = inP7) AND
										(p3 = inP3 OR inP3 = ''));  //CEM - might want to remove the "OR inP3 = ''" or at least make it "OR (inP3 = '' and instate <> '' and instate = st)" or something

		// don't skip anything given a phone match!
		responseLayout ScoreRaw(raw_recs L) := TRANSFORM
			SELF.did := L.did;

			key_phone := TRIM(L.p3) + TRIM(L.p7);
			phone_score := fn_NormalizedEditDistance(inPhone, key_phone, did_wt_phone);
			lname_score := fn_NormalizedEditDistance(inLastName, L.lname, did_wt_lname);
			fname_score := MAP(hasFName => fn_NormalizedEditDistance(inFirstName, L.fname, did_wt_fname),
												 hasFInit AND inFirstName[1] = L.fname[1] => did_wt_fname,
												 0);

			SELF.score := phone_score + 
										IF(inLastName <> '', lname_score, 0) + 
										IF(inFirstName <> '', fname_score, 0);
		END;

		doxie.mac_FetchLimitLimitSkipFail(raw_recs, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED, 
																			true, 203, false, false, limit_dids);
		scored_dids := PROJECT(DISTRIBUTE(limit_dids, did), ScoreRaw(LEFT));
		sorted_dids := SORT(scored_dids, did, -score, LOCAL);
		dids := DEDUP(sorted_dids, LEFT.did = RIGHT.did, LOCAL);  // keeps highest score!

		doQuery := hasValidPhone;
		rval := if(doQuery, dids, emptyResponse);

		#IF(Debug.debug_flag)
		output(doQuery, NAMED('doPhone'));
		output(raw_recs, NAMED('indPhoneRecs'));
		output(scored_dids, NAMED('indPhoneScored'));
		output(rval, NAMED('indPhoneDIDs'));
		#END

		export ResponseLayout records := rval;
	END;

	ncs_recs 	:= NameCityState.records;
	nz_recs 	:= NameZip.records;
	nstr_recs := NameStreet.records;
	ss_recs 	:= StreetState.records;
	sz_recs 	:= StreetZip.records;
	p_recs 		:= phone.records;
	szn_recs 	:= StreetZipName.records;
	ns_recs   := NameState.records;

	combined_recs := ncs_recs + nz_recs + nstr_recs + ss_recs + sz_recs + p_recs + szn_recs + ns_recs;

	// TODO - would it be more efficient to do a group/sum in a crosstab rather
	//        than the SORT/ROLLUP/PROJECT/SORT that we're doing here?

	ResponseLayout RollupScoredDIDs(ResponseLayout L, ResponseLayout R) := TRANSFORM
		SELF.did := L.did;
		SELF.score := L.score + R.score;
	END;

	did_sorted_recs := SORT(combined_recs, did);
	rolled_recs := ROLLUP(did_sorted_recs, LEFT.did = RIGHT.did, RollupScoredDIDs(LEFT, RIGHT));

	maxScore := MAX(rolled_recs, rolled_recs.score);
	cutoffScore := (UNSIGNED) (respScoreCutoff * maxScore);
	usable_scored_recs := SORT(rolled_recs(score >= cutoffScore), -score, did);
	
	// now we decide which records to return:
	target_record := MIN(COUNT(usable_scored_recs), inMaxResults);
	target_score := usable_scored_recs[target_record].score;
	target_recs := usable_scored_recs(score > target_score);

	selected_dids := MAP(COUNT(usable_scored_recs) < inMaxResults => usable_scored_recs,	// everything usable
											 EXISTS(target_recs) => target_recs,															// best matches
											 CHOOSEN(usable_scored_recs, inmaxResults));											// top 'n'

	#IF(Debug.debug_flag)
	inRow := 
		DATASET( [{ inFirstName, inMiddleName, inLastName, inPreferredFirstNameVariantsSet,
								inPhoneticLastName, inStreet, inPrimRange, inPrimName,
								inSecRange, inCity, inState, inZip5, inZip5Set, inPhone }],
								{ STRING20 inFirstName, STRING20 inMiddleName, STRING20 inLastName,
								  SET OF STRING30 inPreferredFirstNames {MAXCOUNT(100)}, STRING6 inPhoneticLastName,
									STRING120 inStreet, STRING10 inPrimRange, STRING30 inPrimName,
									STRING10 inSecRange, STRING60 inCity, STRING2 inState, 
									STRING5 inZip5, SET OF STRING5 inZip5Set {MAXCOUNT(100)},
									STRING10 inPhone } );
	output(inRow, NAMED('searchInputs'), EXTEND);
	output(combined_recs, NAMED('indCombinedDIDs'));
	output(rolled_recs, NAMED('indRolledDIDs'));
	output(cutoffScore, NAMED('indCutoffScore'));
	output(selected_dids, NAMED('indSelectedDIDs'));
	#END

	export dids := PROJECT(selected_dids, Doxie.layout_references_hh);
END;
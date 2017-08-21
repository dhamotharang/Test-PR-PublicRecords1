IMPORT AutoStandardI, UPS_Services, NID;

export mod_TestScore(UPS_Services.IF_PartialMatchSearchParams search_mod) := MODULE
	
	shared commonLayout := UPS_Services.layout_Common;
	shared IT := AutoStandardI.InterfaceTranslator;
	
	shared inFirstName := IT.fname_value.val(project(search_mod, IT.fname_value.params));
	shared inMiddleName := IT.mname_value.val(project(search_mod, IT.mname_value.params));
	shared inLastName := IT.lname_value.val(project(search_mod, IT.lname_value.params));
	shared inCompanyName := IT.comp_name_value.val(project(search_mod, IT.comp_name_value.params));

	shared inPreferredFirstName := NID.PreferredFirstNew(inFirstName);
	shared inPhoneticLastName := if(inLastName <> '', metaphonelib.DMetaphone1(inLastName)[1..6], '');

	shared inStreet := IT.addr_value.val(project(search_mod, IT.addr_value.params));  // FIXME - ignored for now

	shared inPrimRange := IT.prange_value.val(project(search_mod, IT.prange_value.params));
	shared inPrimName := IT.pname_value.val(project(search_mod, IT.pname_value.params));
	shared inSecRange := IT.sec_range_value.val(project(search_mod, IT.sec_range_value.params));
	shared inCity := IT.city_value.val(project(search_mod, IT.city_value.params));
	shared inState := IT.state_value.val(project(search_mod, IT.state_value.params));
	shared inZip5 := (INTEGER) IT.zip_val.val(project(search_mod, IT.zip_value.params));
	shared inPredir := search_mod.predir;
	shared inPostdir := search_mod.postdir;
	shared inSuffix := search_mod.suffix;
	
	shared inPhone := IT.phone_value.val(project(search_mod, IT.phone_value.params));

	maxResults := IT.maxresults_val.val(project(search_mod, IT.maxresults_val.params));
	shared inMaxResults := if (maxResults = 0, 100, maxResults);
	shared MaxKeyResults := (UNSIGNED) (1.5 * inMaxResults);

	shared hasFirstName := inFirstName <> '';
	shared hasMiddleName := inMiddleName <> '';
	shared hasLastName := inLastName <> '';
	shared hasIndName := hasFirstName OR hasLastName;
	shared hasBizName := inCompanyName <> '';
	shared hasName := hasIndName OR hasBizName;
	
	shared hasStreet := inPrimRange <> '' AND inPrimName <> '';
	shared hasCity := inCity <> '';
	shared hasState := inState <> '';
	shared hasCityState := hasCity AND hasState;
	shared hasZip := inZip5 <> 0;
	
	shared hasPhone := inPhone <> '' AND (LENGTH(inPhone) = 7 OR LENGTH(inPhone) = 10);
	
	// default range (ie, 0..defRange) across which scores are generated
	shared UNSIGNED2 defRange := 100;
		
	// Scoring is done at three levels:
	//
	// 1.  At the individual field level.  This is returned as an edit distance
	//     normalized for the length of the string.
	// 2.  Fields within a "group".  For instance, first, middle and last name
	//     each contribute to the name score.  The contribution of each 
	//     individual field within a group of fields is given in the
	//     weightsStreet, weightsCityStateZip, weightsIndName, weightsBizName,
	//     and weightsPhone interfaces.
	// 3.  At the record level.  Name score, address score, and phone score
	//     are each combined to come up with an aggregate record score.  The
	//     relative weights of components is given in the weightsRecord
	//     interface.
	//
	// The weights of all fields within a group (at level 1) should should sum
	// to 100.  This is a CONVENTION and not an absolute REQIREMENT.

	export input_vals := INTERFACE(AutoStandardI.GlobalModule())
	END;

	export weightsStreet := INTERFACE
		export UNSIGNED2 wt_prim_range := 25;
		export UNSIGNED2 wt_predir := 10;
		export UNSIGNED2 wt_prim_name := 25;
		export UNSIGNED2 wt_postdir := 10;
		export UNSIGNED2 wt_suffix := 10;
		export UNSIGNED2 wt_sec_range := 20;		
	END;
	
	export defWeightsStreet := MODULE(weightsStreet)
	END;
	
	export weightsCityStateZip := INTERFACE
		export UNSIGNED2 wt_city := 33;
		export UNSIGNED2 wt_state := 33;
		export UNSIGNED2 wt_zip := 34;		
	END;

	export defWeightsCityStateZip := MODULE(weightsCityStateZip)
	END;
	
	export weightsIndName := INTERFACE
		export UNSIGNED2 wt_fname := 40;
		export UNSIGNED2 wt_mname := 10;
		export UNSIGNED2 wt_lname := 50;
		export UNSIGNED2 wt_cname := 100;
	END;

	export defWeightsIndName := MODULE(weightsIndName)
	END;

	export weightsBizName := INTERFACE
		export UNSIGNED2 wt_cname := 100;
	END;

	export defWeightsBizName := MODULE(weightsBizName)
	END;

	export weightsName := INTERFACE(weightsIndName, weightsBizName)
	END;

	export defWeightsName := MODULE(weightsName)
	END;

	export weightsPhone := INTERFACE
		export UNSIGNED2 wt_phone := 100;
	END;

	export defWeightsPhone := MODULE(weightsPhone)
	END;
	
	export weightsAddress := INTERFACE(weightsStreet, weightsCityStateZip)
		export UNSIGNED2 wt_street := 50;
		export UNSIGNED2 wt_citystatezip := 50;
	END;
	
	export defWeightsAddress := MODULE(weightsAddress)
	END;
	
	export weightsRecord := INTERFACE(weightsAddress, weightsIndName, weightsBizName, weightsPhone)
		export UNSIGNED2 wt_grp_name := 40;
		export UNSIGNED2 wt_grp_addrStreet := 20;
		export UNSIGNED2 wt_grp_addrCityStateZip := 20;
		export UNSIGNED2 wt_grp_phone := 20;
	END;
	
	export defWeightsRecord := MODULE(weightsRecord)
	END;

	// Compute a normalized score (0..range, 0..100 by default) for two strings,
	// s1 and s2.  The score is based on the edit distance relative to the 
	// length of the two strings, as described below.  A score of 0 is a poor
	// match and a score of 'range' (100) is a perfect match.
	//
	// Edit distance returns a value between 0 (exact match) and k, where k is
	// the length of the longer of the two strings being compared.  Normalize
	// this value so that it's on a scale of 0..1 (by dividing by the length
	// of the longer string), and invert it so that higher values represent
	// stronger matches (ie, 1 - n, where n is the normalized edit distance).
	// Finally, multiply by 100 to convert the REAL value (0..1) to an integer
	// score (0..100), truncating any fractional part left over from the 
	// division.

	export UNSIGNED2 fn_NormalizedEditDistance(STRING s1, STRING s2, UNSIGNED2 rng = defRange) := FUNCTION
		REAL edist := StringLib.EditDistance(s1, s2);           // edit distance
		REAL maxlen := max(LENGTH(TRIM(s1)), LENGTH(TRIM(s2))); // max length
		REAL nedist := edist / maxlen;                          // norm edit dist (0..1)
		REAL score := (1.0 - nedist) * rng;  // invert score so that 0 = bad and 1 = good

		return (UNSIGNED2) score;
	END;
	
	// a few shortcuts used EVERYWHERE :)
	shared ned(STRING s1, STRING s2) := fn_NormalizedEditDistance(s1, s2);	
	shared points(UNSIGNED score, UNSIGNED weight) := score * weight;
	
	// determine what to return from the scoring routines.
	shared reduce_points(UNSIGNED tot_points, UNSIGNED max_points) := 
			MAP(tot_points = 0 AND max_points > 0 => 0,  // we have inputs, but scored a 0
				  max_points = 0 => defRange,              // we have no inputs, a perfect match
					tot_points / max_points);                // otherwise, normalize

	export UNSIGNED2 fn_ScoreIndName(commonLayout rec, 
																	 weightsIndName weights = defWeightsIndName) := FUNCTION
		fname_points := points(if(inFirstName <> '', ned(inFirstName, rec.fname), 0), weights.wt_fname);
		mname_points := points(if(inMiddleName <> '', ned(inMiddleName, rec.mname), 0), weights.wt_mname);
		lname_points := points(if(inLastName <> '', ned(inLastName, rec.lname), 0), weights.wt_lname);

		tot_points := fname_points + mname_points + lname_points;

		max_points := if(inFirstName <> '', weights.wt_fname, 0) +
									if(inMiddleName <> '', weights.wt_mname, 0) +
									if(inLastName <> '', weights.wt_lname, 0);

		// debug_rec := DATASET( [{ fname_points, mname_points, lname_points, tot_points, max_points }], 
		                  // { UNSIGNED2 fname, UNSIGNED2 mname, UNSIGNED2 lname, UNSIGNED2 tot_points, UNSIGNED2 max_points } ); 
		// output(debug_rec, NAMED('debug'), EXTEND);
		// output(inFirstName, NAMED('inFirstName'));
		// output(inLastName, NAMED('inLastName'));
		return reduce_points(tot_points, max_points);
	END;
	
	export UNSIGNED2 fn_ScoreBizName(commonLayout rec, 
																	 weightsBizName weights = defWeightsBizName) := FUNCTION
		return IF(inCompanyName <> '', ned(inCompanyName, rec.company_name), defRange);
	END;

	export UNSIGNED2 fn_ScoreName(commonLayout rec, 
																weightsName weights = defWeightsName) := FUNCTION
		ind_score := fn_ScoreIndName(rec, weights);
		biz_score := fn_ScoreBizName(rec, weights);

		return MAP(hasIndName AND hasBizName => MAX(ind_score, biz_score),
		           hasIndName => ind_score,
							 hasBizName => biz_score,
							 defRange);  // a match of nothing to nothing is perfect
	END;

	export UNSIGNED2 fn_ScoreStreet(commonLayout rec, 
																	weightsStreet weights = defWeightsStreet) := FUNCTION
		prim_range_points := points(if(inPrimRange <> '', ned(inPrimRange, rec.prim_range), 0), weights.wt_prim_range);
		predir_points := points(if(inPredir <> '', ned(inPredir, rec.predir), 0), weights.wt_predir);
		prim_name_points := points(if(inPrimName <> '', ned(inPrimName, rec.prim_name), 0), weights.wt_prim_name);
		postdir_points := points(if(inPostdir <> '', ned(inPostdir, rec.postdir), 0), weights.wt_postdir);
		suffix_points := points(if(inSuffix <> '' AND inSuffix = rec.suffix, defRange, 0), weights.wt_suffix);
		sec_range_points := points(if(inSecRange <> '', ned(inSecRange, rec.sec_range), 0), weights.wt_sec_range);

		tot_points := prim_range_points + predir_points + prim_name_points + 
									postdir_points + suffix_points + sec_range_points;

		max_points := if(inPrimRange <> '', weights.wt_prim_range, 0) +
									if(inPredir <> '', weights.wt_predir, 0) +
									if(inPrimName <> '', weights.wt_prim_name, 0) +
									if(inSuffix <> '', weights.wt_suffix, 0) +
									if(inPostdir <> '', weights.wt_postdir, 0) +
									if(inSecRange <> '', weights.wt_sec_range, 0);

		return reduce_points(tot_points, max_points);
	END;
	
	export UNSIGNED2 fn_ScoreCityStateZip(commonLayout rec, 
																				weightsCityStateZip weights = defWeightsCityStateZip) := FUNCTION
		city_points := points(if(inCity <> '', ned(inCity, rec.city_name), 0), weights.wt_city);
		state_points := points(if(inState <> '' AND inState = rec.state, defRange, 0), weights.wt_state);
		zip_points := points(if(inZip5 <> 0, ned((STRING) inZip5, rec.zip), 0), weights.wt_zip);

		tot_points := city_points + state_points + zip_points;

		max_points := if(inCity <> '', weights.wt_city, 0) +
									if(inState <> '', weights.wt_state, 0) +
									if(inZip5 <> 0, weights.wt_zip, 0);

		return reduce_points(tot_points, max_points);
	END;

	export UNSIGNED2 fn_ScoreAddress(commonLayout rec, 
																	 weightsAddress weights = defWeightsAddress) := FUNCTION
		street_points := points(fn_ScoreStreet(rec, weights), weights.wt_street);
		citystatezip_points := points(fn_ScoreCityStateZip(rec, weights), weights.wt_citystatezip);

		tot_points := street_points + citystatezip_points;
		max_points := weights.wt_street + weights.wt_citystatezip;

		// here, max_points cannot be zero, and tot_points will only be zero if
		// the street and the city/state/zip both returned inexact matches.
		return tot_points / max_points;
	END;
	
	export UNSIGNED2 fn_ScorePhone(commonLayout rec, 
																 weightsPhone weights = defWeightsPhone) := FUNCTION
		return IF(inPhone <> '', ned(inPhone, rec.phone), defRange);
	END;
	
	export UNSIGNED2 fn_Score(commonLayout rec, 
														weightsRecord weights = defWeightsRecord) := FUNCTION

		doCityStateZip := hasCity OR hasState OR hasZip;
		
		name_score := if(hasName, fn_ScoreName(rec), 0);
		addr_street_score := if(hasStreet, fn_ScoreStreet(rec, weights), 0);
		addr_citystatezip_score := if(doCityStateZip, fn_ScoreCityStateZip(rec, weights), 0);
		phone_score := if(hasPhone, fn_ScorePhone(rec, weights), 0);

		tot_points := points(name_score, weights.wt_grp_name) + 
								  points(addr_street_score, weights.wt_grp_name) + 
								  points(addr_citystatezip_score, weights.wt_grp_name) +
								  points(phone_score, weights.wt_grp_name);
								 
		max_points := if(hasName, weights.wt_grp_name, 0) +
									if(hasStreet, weights.wt_grp_addrstreet, 0) +
									if(doCityStateZip, weights.wt_grp_addrcitystatezip, 0) +
									if(hasPhone, weights.wt_grp_phone, 0);

		return IF(max_points = 0, defRange,   // is this even possible?  No inputs?
															tot_points / max_points);
	END;

	export UNSIGNED2 fn_AggregateScore(UNSIGNED2 score_name, 
																		 UNSIGNED2 score_addr_street, 
																		 UNSIGNED2 score_addr_citystatezip, 
																		 UNSIGNED2 score_phone, 
																		 weightsRecord weights = defWeightsRecord) := FUNCTION
		// export UNSIGNED2 wt_grp_name := 40;
		// export UNSIGNED2 wt_grp_addrStreet := 20;
		// export UNSIGNED2 wt_grp_addrCityStateZip := 20;
		// export UNSIGNED2 wt_grp_phone := 20;
		name_points := if(hasName, points(score_name, weights.wt_grp_name), 0);
		street_points := if(hasStreet, points(score_addr_street, weights.wt_grp_addrStreet), 0);
		csz_points := if(hasCity OR hasState OR hasZip, points(score_addr_citystatezip, weights.wt_grp_addrCityStateZip), 0);
		phone_points := if(hasPhone, points(score_phone, weights.wt_grp_phone), 0);
		
		tot_points := name_points + street_points + csz_points + phone_points;

		max_points := if(hasName, weights.wt_grp_name, 0) +
									if(hasStreet, weights.wt_grp_addrStreet, 0) +
									if(hasCity OR hasState OR hasZip, weights.wt_grp_addrCityStateZip, 0) +
									if(hasPhone, weights.wt_grp_phone, 0);

		return IF(max_points = 0, defRange, tot_points / max_points);

	END;

	export DATASET(commonLayout) score(DATASET(commonLayout) in_recs, 
																		 weightsRecord weights = defWeightsRecord) := FUNCTION	
		
		in_recs ScoreRecords(in_recs L) := TRANSFORM
			SELF.score_name := fn_ScoreName(L);
			SELF.score_addr := fn_ScoreAddress(L);
			SELF.score_phone := fn_ScorePhone(L);
			SELF := L;
		END;
		
		out_recs := PROJECT(in_recs, ScoreRecords(LEFT));
		return out_recs;
	END;
END;
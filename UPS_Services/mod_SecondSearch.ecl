import doxie, ut, AutoStandardI, Business_Header_SS, Business_Header;

export mod_SecondSearch := MODULE

	shared IT := AutoStandardI.InterfaceTranslator;
	shared maxRecs := 10;  // was originally coded as 100, but we really just want SOMETHING to return and 10 provides less impact to latency
	shared message_code 		:= 999;//temp.  i dont know what we should use for internal messages.
	shared message_prefix 	:= 'UPS_Services.mod_SecondSearch: ';

	// Make a last-ditch effort to find /something/.  Very broad queries!

	// NOTE: any query which does not use zip codes should filter on state 
	// unless the state input is not set since non-matching state records will
	// be filtered in the rollup.
	export Individual(mod_Params.PersonSearch search_mod) := MODULE
		layout := doxie.layout_references_hh;

		inLastName := IT.lname_value.val(project(search_mod, IT.lname_val.params));
		inPhoneticLastName := if(inLastName <> '', metaphonelib.DMetaphone1(inLastName)[1..6], '');  //most or all of these keys have dph_lname limited to string6
		inPrimRange := IT.prange_value.val(project(search_mod, IT.prange_value.params));
		inPrimName := IT.pname_value.val(project(search_mod, IT.pname_value.params));
		inCity := IT.city_value.val(project(search_mod, IT.city_value.params));
		inCityCode := doxie.Make_CityCodes(inCity).rox;
		inState := IT.state_value.val(project(search_mod, IT.state_value.params));
		inStateSet := if(inState <> '', [ inState ],
																	  if(inCity <> '', fn_BestStates(inCity, 5), []));
		inZip5 := (INTEGER) IT.zip_val.val(project(search_mod, IT.zip_val.params));
		derrivedZipFromCity := IF(inState <> '' and inCity <> '', ut.ZipsWithinCity(inState, inCity), [] );
		inZip5Set := [inZip5] + derrivedZipFromCity;
		
		inPhone := IT.phone_value.val(project(search_mod, IT.phone_value.params));
		phoneLen := LENGTH(TRIM(inPhone));

		StreetQuery := PROJECT(CHOOSEN(doxie.key_header_dts_address(
															KEYED(prim_name in [inPrimName,ut.Word(inPrimName, 1, ' ')]) AND
															KEYED(prim_range = inPrimRange) AND
															KEYED(st IN inStateSet OR NOT EXISTS(inStateSet))), maxRecs), 
													 TRANSFORM(layout, SELF := LEFT));

		RangeZipQuery := PROJECT(CHOOSEN(doxie.key_header_zipprlname(
															KEYED(zip IN inZip5Set) AND
															KEYED(prim_range = inPrimRange)), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));

		StreetZipQuery := PROJECT(CHOOSEN(doxie.key_header_dts_streetzipname(
															KEYED(prim_name in [inPrimName,ut.Word(inPrimName, 1, ' ')]) AND
															KEYED(zip IN inZip5Set) AND
															(dph_lname = inPhoneticLastName OR dph_lname = '')), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));

		inPiz5Set := ut.PizTools.reverseZipset(inZip5Set);
	
		LastZipQuery := PROJECT(CHOOSEN(doxie.key_header_piz(
															KEYED(piz IN inPiz5Set) AND
															KEYED(dph_lname = inPhoneticLastName)), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));
		
		LastCityStateQuery := PROJECT(CHOOSEN(doxie.key_header_stcitylfname(
															KEYED(city_code in inCityCode) AND
															KEYED(st = inState) AND
															KEYED(dph_lname = inPhoneticLastName)), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));

		LastStateQuery :=	PROJECT(CHOOSEN(doxie.key_header_stfnamelname(
															KEYED(st = inState) AND
															KEYED(dph_lname = inPhoneticLastName) AND
															KEYED(lname = inLastName)), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));
		
		//EVEN LOOSER
		StreetQuery2 := PROJECT(CHOOSEN(doxie.key_header_dts_address(
															KEYED(prim_name in [inPrimName,ut.Word(inPrimName, 1, ' ')]) AND
															KEYED(prim_range = inPrimRange)), maxRecs), 
													 TRANSFORM(layout, SELF := LEFT));

		StreetZipQuery2 := PROJECT(CHOOSEN(doxie.key_header_dts_streetzipname(
															KEYED(prim_name in [inPrimName,ut.Word(inPrimName, 1, ' ')]) AND
															KEYED(zip IN inZip5Set)), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));

		LastStateQuery2 :=	PROJECT(CHOOSEN(doxie.key_header_stfnamelname(
															KEYED(st = inState) AND
															KEYED(dph_lname = inPhoneticLastName)), maxRecs),
													 TRANSFORM(layout, SELF := LEFT));													 
													 

		errantPhones_7 :=
			UPS_Services.mod_GenerateTransposedPhones(inPhone).set_phone7 +
			UPS_Services.mod_GenerateFatfingeredPhones(inPhone).set_phone7;
		
		errantPhones_3 :=
			UPS_Services.mod_GenerateTransposedPhones(inPhone).set_phone3 +
			UPS_Services.mod_GenerateFatfingeredPhones(inPhone).set_phone3;

		errantPhones :=
			UPS_Services.mod_GenerateTransposedPhones(inPhone).set_phone10 +
			UPS_Services.mod_GenerateFatfingeredPhones(inPhone).set_phone10;
			
		PhoneQuery :=	
		PROJECT(
			CHOOSEN(
				LIMIT(
					doxie.key_header_wild_phone( //ups right address service is already using this key (as opposed to non-wild version)
						KEYED(p7 in errantPhones_7) AND
						KEYED(p3 in errantPhones_3) AND
						p3+p7 in errantPhones
					), 
					ut.limits.PHONE_PER_PERSON, keyed, skip
				),
				maxRecs
			),
			TRANSFORM(
				layout, 
				SELF := LEFT
			)
		);
													 
		doStreetQuery := inPrimName <> '' AND inPrimRange <> '';
		doRangeZipQuery := inPrimRange <> '' AND EXISTS(inZip5Set);
		doStreetZipQuery := inPrimName <> '' AND EXISTS(inZip5Set);
		doLastZipQuery := inPhoneticLastName <> '' AND EXISTS(inZip5Set);
		doLastCityStateQuery := inPhoneticLastName <> '' AND inCity <> '' AND inState <> '';
		doLastStateQuery := inLastName <> '' AND inState <> '';
		doPhone := inPhone <> '' AND (phoneLen = 10);
		
		raw_recs := 
		choosen(
			StreetQuery(doStreetQuery) 
			& RangeZipQuery(doRangeZipQuery) 
			& StreetZipQuery(doStreetZipQuery) 
			& LastZipQuery(doLastZipQuery) 
			& LastCityStateQuery(doLastCityStateQuery) 
			& LastStateQuery(doLastStateQuery) 
			& PhoneQuery(doPhone)
			& StreetQuery2(doStreetQuery)
			& StreetZipQuery2(doStreetZipQuery)
			& LastStateQuery2(doLastStateQuery)
			,maxRecs
		);

		doxie.mac_FetchLimitLimitSkipFail(raw_recs, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED, 
																			true, 203, false, false, limit_dids);

		#IF(Debug.debug_flag)
		// inputs_ds := DATASET( [ { inLastName, inPhoneticLastName, inPrimRange,  inPrimName,
															// inCity, inStateSet, inZip5Set } ], 
															// { STRING lname, STRING plname, STRING prim_range, STRING prim_name,
																// STRING city, SET OF STRING2 states, SET OF STRING5 zipset} );
		// output(inputs_ds, NAMED('indInputs'), EXTEND);
		output(if(doStreetQuery, StreetQuery), NAMED('indStreetQuery'));
		output(if(doRangeZipQuery), NAMED('indRangeZipQuery'));
		output(if(doStreetZipQuery), NAMED('indStreeZipQuery'));
		output(if(doLastZipQuery), NAMED('indLastZipQuery'));
		output(if(doLastCityStateQuery), NAMED('indLastCityStateQuery'));
		output(if(doLastStateQuery), NAMED('indLastStateQuery'));
		output(limit_dids, NAMED('indKamikazeDIDs'));
		#END

		// ut.outputMessage(message_code, message_prefix + 'individual fired returning ' + COUNT(limit_dids) + ' DIDs');
		export records := limit_dids;
	END;

	export Business(mod_Params.BusinessSearch search_mod) := MODULE
		layout := doxie.layout_ref_bdid;

		inCompanyName := '';
		inPrimRange := IT.prange_value.val(project(search_mod, IT.prange_value.params));
		inPrimName := IT.pname_value.val(project(search_mod, IT.pname_value.params));
		inCity := IT.city_value.val(project(search_mod, IT.city_value.params));
		inState := IT.state_value.val(project(search_mod, IT.state_value.params));
		inStateSet := if(inState <> '', [ inState ],
																	  if(inCity <> '', fn_BestStates(inCity, 5), []));
		inZip5 := (INTEGER) IT.zip_val.val(project(search_mod, IT.zip_val.params));
		derrivedZipFromCity := IF(inState <> '' and inCity <> '', ut.ZipsWithinCity(inState, inCity), [] );
		inZip5Set := [inZip5] + derrivedZipFromCity;
		
		inPhone := IT.phone_value.val(project(search_mod, IT.phone_value.params));
		phoneLen := LENGTH(TRIM(inPhone));
		
		StateStreetQuery := PROJECT(CHOOSEN(Business_Header_SS.Key_BH_Addr_pr_pn_sr_st(
																					KEYED(state IN inStateSet) AND
																					KEYED(prim_name in [inPrimName,ut.Word(inPrimName, 1, ' ')])), maxRecs),
																TRANSFORM(layout, SELF := LEFT));

		ZipStreetQuery := PROJECT(CHOOSEN(Business_Header_SS.Key_BH_Addr_pr_pn_zip(
																					KEYED(zip in inZip5Set) AND
																					KEYED(prim_name in [inPrimName,ut.Word(inPrimName, 1, ' ')])), maxRecs),
																TRANSFORM(layout, SELF := LEFT));

		//EVEN LOOSER																
		PRPNQuery := PROJECT(CHOOSEN(Business_Header.RoxieKeys().NewFetch.key_address_qa(
																					KEYED(prim_name in [inPrimName,ut.Word(inPrimName, 1, ' ')]) AND
																					KEYED(prim_range = inPrimRange)
																					), maxRecs),
																TRANSFORM(layout, SELF := LEFT));
																
		errantPhones_7 :=
			UPS_Services.mod_GenerateTransposedPhones(inPhone).set_phone7 +
			UPS_Services.mod_GenerateFatfingeredPhones(inPhone).set_phone7;
		
		errantPhones_3 :=
			UPS_Services.mod_GenerateTransposedPhones(inPhone).set_phone3 +
			UPS_Services.mod_GenerateFatfingeredPhones(inPhone).set_phone3;
			
		errantPhones :=
			UPS_Services.mod_GenerateTransposedPhones(inPhone).set_phone10 +
			UPS_Services.mod_GenerateFatfingeredPhones(inPhone).set_phone10;	
			
		PhoneQuery :=	
		PROJECT(
			CHOOSEN(
				LIMIT(
					Business_Header.RoxieKeys().NewFetch.Key_Phone_QA(
						KEYED(p7 in errantPhones_7) AND
						KEYED(p3 in errantPhones_3) AND
						p3+p7 in errantPhones
					), 
					ut.limits.PHONE_PER_PERSON, keyed, skip
				),
				maxRecs
			),
			TRANSFORM(
				layout, 
				SELF := LEFT
			)
		);

		doStateStreetQuery := EXISTS(inStateSet) AND inPrimName <> '';
		doZipStreetQuery := EXISTS(inZip5Set) AND inPrimName <> '';
		doPhone := inPhone <> '' AND (phoneLen = 10);
		doPRPNQuery := inPrimName <> '' AND inPrimRange <> '';

		raw_recs := 
		choosen(
			StateStreetQuery(doStateStreetQuery) 
			& ZipStreetQuery(doZipStreetQuery) 
			& PhoneQuery(doPhone)
			& PRPNQuery(doPRPNQuery)
			,maxRecs
		);

		doxie.mac_FetchLimitLimitSkipFail(raw_recs, ut.limits.FETCH_KEYED, ut.limits.FETCH_UNKEYED, 
																			true, 203, false, false, limit_bdids);
		#IF(Debug.debug_flag)
		output(limit_bdids, NAMED('bizKamikazeBDIDs'));
		#END

		// ut.outputMessage(message_code, message_prefix + 'business fired returning ' + COUNT(limit_bdids) + ' BDIDs');
		export records := limit_bdids;
	END;
END;
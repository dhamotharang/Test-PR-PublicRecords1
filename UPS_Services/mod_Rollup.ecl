IMPORT ut, iesp, NID;

// Given a set of records in the common RightAddress layout, rolls up the
// records by DID.  More specifically, all unique names and addresses are 
// extracted from the input records and are nested within an "entity" based
// on the DID of the input record.

export mod_Rollup(SearchParams inputs) := MODULE
	export inLayout := UPS_Services.layout_Common;
	export outLayout := iesp.rightaddress.t_RightAddressSearchRecord;

	// We need to access the weights in mod_Score.  Really, mod_Score should be
	// rewritten so that the search inputs aren't a required parameter to 
	// simply reference the module, but for now...
	shared scoreMod := mod_Score(inputs);
	
	shared entityLayout := RECORD
		inLayout.rollup_key;
		inLayout.rollup_key_type;
		inLayout.listing_type;
	END;

	export addrLayout := iesp.rightaddress.t_RAAddressWithPhones;
	export nameLayout	:= iesp.rightaddress.t_HighlightedNameAndCompany;
	export phoneLayout := iesp.rightaddress.t_HighlightedPhoneInfo;

	shared rollNamesResponse := RECORD(entityLayout)
		UNSIGNED best_score_name;
		DATASET(nameLayout) names {MAXCOUNT(iesp.Constants.RA.MAX_CHILD_RECORDS)};
	END;

	shared rollAddressesResponse := RECORD(entityLayout)
		UNSIGNED2 best_address;
		UNSIGNED2 best_score_addr;
		UNSIGNED2 best_score_phone;
		DATASET(addrLayout) addresses {MAXCOUNT(iesp.Constants.RA.MAX_CHILD_RECORDS)};
	END;

	// a clean output address PLUS entity information and original score 
	// information.
	shared scoredAddrLayout := RECORD(entityLayout)
		inLayout.score_addr;
		TYPEOF(inLayout.score_phone) best_score_phone;
		addrLayout;
	END;		

	// after addresses are rolled up, decide which ones are passed to output
	shared DATASET(scoredAddrLayout) fn_RestrictOutputAddresses(DATASET(scoredAddrLayout) addrs,
																															UNSIGNED maxRecs = Constants.MAX_RETURNED_ADDRS) := FUNCTION
		// removes records without a first seen/last seen date.  If there is only
		// one address in the input, pass it back REGARDLESS of whether it has a
		// date or not.  (Bugzilla 42359).
		filteredAddrs := addrs(
															(DateLastSeen.year > 0 OR DateFirstSeen.year > 0 ) AND 
															 ut.Age(iesp.ECL2ESP.DateToInteger(DateLastSeen)) <= 10 
														 ); // Keep records newer than or equal to 10 years. 
		return IF(COUNT(filteredAddrs) > 0 , 
							 CHOOSEN(filteredAddrs, maxRecs),
							 CHOOSEN(addrs, maxRecs));//i am not sure whether this is deterministic
	END;

	// after names are rolled up, decide which ones are passed to output
	shared DATASET(nameLayout) fn_RestrictOutputNames(DATASET(nameLayout) names,
																										UNSIGNED maxRecs = Constants.MAX_RETURNED_NAMES) := FUNCTION
		return CHOOSEN(names, maxRecs);//these have a reasonable sort coming in so i suspect this is deterministic
	END;

	// return the index of the "best" address within a set of address records.
	// The record set is scanned, and the index of the record with the highest
	// score is returned.  In the event that there are several records with
	// the same score value (tied for highest), the index of the first record
	// is returned.  If date is to be considered in addition to lowest penalty
	// in selecting the "best" match, records should be sorted appropriately by
	// date prior to entering this function.
	//
	// If no addresses are input or no address search criteria was provided,
	// this fn may return 0.
	shared INTEGER fn_BestAddress(DATASET(scoredAddrLayout) addrs) := FUNCTION

		addrInputs := inputs.addrQueryInputs;
		inputsHadAddress := addrInputs.StreetAddress1 <> '' OR
												addrInputs.City <> ''   OR
												addrInputs.State <> ''  OR
												addrInputs.Zip5 <> ''   OR addrInputs.PostalCode <> '' ;
		inputsHadPhone := inputs.phoneQueryInput <> '';

		enumeratedAddrLayout := RECORD
			UNSIGNED2 idx;
			INTEGER4  best_score;  // phone or address
		END;
		
		enumeratedAddrLayout enumerationTransform(scoredAddrLayout L, INTEGER c) := TRANSFORM
			SELF.idx := c;
			SELF.best_score := MAX(if(inputsHadAddress, L.score_addr, 0),
														 if(inputsHadPhone, L.best_score_phone, 0));
		END;

		enumeratedAddrs := PROJECT(addrs, enumerationTransform(LEFT, COUNTER));
		rankedAddrs := SORT(enumeratedAddrs, -best_score, idx);

		return rankedAddrs[1].idx;
	END;

	// accepts a dataset in the common layout, and returns a set of merged and
	// sorted NameAndCompany records for each unique rollup key/type in the 
	// input.  For each rollup key, a max of maxRecs names will be returned.
	export DATASET(rollNamesResponse) rollNames(DATASET(inLayout) recs,
																							DATASET(entityLayout) entities,
																							UNSIGNED4 maxRecs = Constants.MAX_RETURNED_NAMES) := FUNCTION

		scoredNameLayout := RECORD(nameLayout)
			inLayout.rollup_key;
			inLayout.rollup_key_type;
			STRING20 preferred_first;
			STRING6  phonetic_last;
			inLayout.score_name;
		END;

		scoredNameResponse := RECORD
			inLayout.rollup_key;
			inLayout.rollup_key_type;
			TYPEOF(inLayout.score_name) best_name_score;
			DATASET(scoredNameLayout) names {MAXCOUNT(250 * iesp.Constants.RA.MAX_CHILD_RECORDS)};
		END;

		scoredNameLayout InputToNamesTransform(inLayout L) := TRANSFORM, SKIP(L.fname = '' AND 
																																					L.lname = '' AND 
																																					L.company_name = '')
			SELF.rollup_key := L.rollup_key;
			SELF.rollup_key_type := L.rollup_key_type;

			SELF.First := L.fname;
			SELF.Middle := L.mname[1];  // truncate to an initial, if anything
			SELF.Last := L.lname;
			SELF.Suffix := L.name_suffix;
			SELF.CompanyName := L.company_name;

			SELF.score_name := L.score_name;
			SELF.preferred_first := NID.PreferredFirstNew(L.fname);
			SELF.phonetic_last := metaphonelib.DMetaPhone1(L.lname)[1..6];

			SELF := [];
		END;  // InputToNamesTransform

		names := PROJECT(recs, InputToNamesTransform(LEFT));
		srtNames := SORT(names, rollup_key, rollup_key_type, phonetic_last, preferred_first, Last, First, Middle, CompanyName);
		uniqueNames := DEDUP(srtNames, RECORD);

		// in rolling up names, we want to keep the names which most closely
		// match the inputs unless there is a clear advantage to doing otherwise
		// (ie, keeping a full name over an initial).
		scoredNameLayout mergeNames(scoredNameLayout L, scoredNameLayout R) := TRANSFORM
			SELF.rollup_key := L.rollup_key;
			SELF.rollup_key_type := L.rollup_key_type;

			bestFname := MAP( // if one side is an initial matching a full name, keep the full name
												LENGTH(TRIM(R.First)) = 1 AND L.First[1] = R.First[1] => L,
												LENGTH(TRIM(L.First)) = 1 AND R.First[1] = L.First[1] => R,

												// otherwise, keep the name which matches the input most closely 
												L.First <> '' AND L.score_name >= R.score_name => L,
												R.First <> '' AND R.score_name >  L.score_name => R,
												L.First <> '' => L,
												R);

			SELF.first := bestFname.First;
			SELF.preferred_first := bestFname.preferred_first;

			mname := MAP(L.Middle <> '' AND L.score_name >= R.score_name => L.Middle,
									 R.Middle <> '' AND R.score_name >  L.score_name => R.Middle,
									 L.Middle <> '' => L.Middle,
									 R.Middle);

			SELF.middle := mname;

			bestLname := MAP(L.Last <> '' AND L.score_name >= R.score_name => L,
											 R.Last <> '' AND R.score_name >  L.score_name => R,
											 L.Last <> '' => L,
											 R);

			SELF.last := bestLname.last;
			SELF.phonetic_last := bestLname.phonetic_last;

			SELF.suffix := IF(L.Suffix <> '', L.Suffix, R.Suffix);

			SELF.score_name := IF(L.score_name > R.score_name, L.score_name, R.score_name);
			
			bestCname := MAP(L.companyname <> '' AND L.score_name >= R.score_name => L,
											 R.companyname <> '' AND R.score_name >  L.score_name => R,
											 L.companyname <> '' => L,
											 R);
			SELF.companyName := bestCname.companyname;
			
			SELF.full := '';    // we don't carry these through...
			SELF.prefix := '';
		END;  // NameRollup

		// mergedNames becomes a set of UNIQUE (as defined below) names for each
		// rollup_key/rollup_key_type.

		mergedNames := ROLLUP(uniqueNames,
													LEFT.rollup_key = RIGHT.rollup_key AND
													LEFT.rollup_key_type = RIGHT.rollup_key_type AND
													fn_LastNamesMatch(LEFT.Last, RIGHT.Last, LEFT.phonetic_last, RIGHT.phonetic_last) AND
													fn_FirstNamesMatch(LEFT.First, RIGHT.First, LEFT.preferred_first, RIGHT.preferred_first) AND
													// ut.nneq(LEFT.Middle, RIGHT.Middle) AND
													LEFT.companyname = RIGHT.companyname,
													mergeNames(LEFT, RIGHT));

		// create an "entity container" to hold all of the names.  Each container
		// is tagged with key and key type and holds a dataset of all related names.
		
		scoredNameResponse toNameResponse(entityLayout L) := TRANSFORM
			SELF.rollup_key := L.rollup_key;
			SELF.rollup_key_type := L.rollup_key_type;
			SELF.best_name_score := 0;  // not just yet... need to attach names 
																	//   and apply filtering logic first.
			SELF.names := [];
		END;

		emptyResponse := PROJECT(entities, toNameResponse(LEFT));

		// associate all scored name records with respective appropriate entity
		// container

		scoredNameResponse populateNamesTransform(scoredNameResponse L, scoredNameLayout R) := TRANSFORM
			SELF.rollup_key := L.rollup_key;
			SELF.rollup_key_type := L.rollup_key_type;
			SELF.best_name_score := L.best_name_score;
			SELF.names := L.names + R;
		END;

		scoredResp := DENORMALIZE(emptyResponse, mergedNames,
															LEFT.rollup_key = RIGHT.rollup_key AND
															LEFT.rollup_key_type = RIGHT.rollup_key_type,
															populateNamesTransform(LEFT, RIGHT));

		// convert the scored name records in each entity container to unscored.
		// Apply any last minute filtering/transforms/selection logic.  The output
		// of this transform is what the end user will receive as name data!

		rollNamesResponse toResponseLayout(scoredNameResponse L) := TRANSFORM
			srtScoredNames := SORT(L.names, -score_name, last, first, middle, companyname, suffix); //this sort is necessary for the subsequent call to fn_RestrictOutputNames
			keepNames := fn_RestrictOutputNames(srtScoredNames);	//depends on the sort immediately above
			SELF.best_score_name := MAX(srtScoredNames, score_name);  // now we can set it!
			SELF.names := PROJECT(keepNames, nameLayout);
			SELF.listing_type := '';
			SELF := L;
		END;

		resp := PROJECT(scoredResp, toResponseLayout(LEFT));
	 
	 #IF(debug.debug_flag)
		output(names, named('inputNames'));
		output(srtNames, named('srtNames'));
		output(uniqueNames, named('uniqueNames'));
		output(mergedNames, named('mergedNames'));
		output(entities, named('entities'));
		output(entities, named('nameEntities'));
		output(emptyResponse, named('emptyNameResponse'));
		output(scoredResp, named('scoredNameResp'));
		output(resp, named('resp'));
		#END

		RETURN resp;
	END;  // rollNames() function

	export DATASET(rollAddressesResponse) rollAddresses(DATASET(inLayout) recs, 
																											DATASET(entityLayout) entities,
																											UNSIGNED4 maxRecs = Constants.DEF_RETURNED_ADDRS) := FUNCTION

		scoredAddrResponse := RECORD
			inLayout.rollup_key;
			inLayout.rollup_key_type;

			DATASET(scoredAddrLayout) addrs {MAXCOUNT(500 * iesp.Constants.RA.MAX_CHILD_RECORDS)};
		END;

		scoredAddrLayout InputToAddrTransform(recs L) := TRANSFORM, SKIP (L.prim_range = '' AND 
																																				L.prim_name = '')
			SELF.rollup_key := L.rollup_key;
			SELF.rollup_key_type := L.rollup_key_type;
				
			// sometimes we get a 0 first seen or last seen date.  If that's the
			// case, use the non-zero date in both positions.  In either case, we
			// discard the day portion of the date.
			year(dtstr) := (INTEGER)((STRING) dtstr)[1..4];
			month(dtstr) := (INTEGER)((STRING) dtstr)[5..6];

			SELF.DateFirstSeen.year := if (L.dt_first_seen <> 0, year(L.dt_first_seen), year(L.dt_last_seen));
			SELF.DateFirstSeen.month := if (L.dt_first_seen <> 0, month(L.dt_first_seen), month(L.dt_last_seen));
			SELF.DateFirstSeen.day := 0;

			SELF.DateLastSeen.year := if (L.dt_last_seen <> 0, year(L.dt_last_seen), year(L.dt_first_seen));
			SELF.DateLastSeen.month := if (L.dt_last_seen <> 0, month(L.dt_last_seen), month(L.dt_first_seen));
			SELF.DateLastSeen.day := 0;

			// if there is a phone number attached to this record, we convert it
			// to a dataset of a single record.  When we roll up later, the
			// datasets will be concatenated and deduped.

			phone_recs := if (L.phone <> '', DATASET( [{ L.phone }], { STRING10 Phone10 }),
																			 DATASET( [],            { STRING10 Phone10 }) );

			phoneLayout InputToPhoneTransform(phone_recs L) := TRANSFORM, SKIP (L.Phone10 = '')
				SELF.phone10 := L.Phone10;
				SELF := [];
			END;

			phones := PROJECT(phone_recs, InputToPhoneTransform(LEFT));
			SELF.phones := CHOOSEN(phones, iesp.Constants.RA.MAX_CHILD_RECORDS);

			// simple field mappings due to dissimilar layouts
			SELF.StreetName := L.prim_name;
			SELF.StreetNumber := L.prim_range;
			SELF.StreetPreDirection := L.predir;
			SELF.StreetPostDirection := L.postdir;
			SELF.StreetSuffix := L.suffix;
			SELF.UnitDesignation := L.unit_desig;
			SELF.UnitNumber := L.sec_range;
			SELF.StreetAddress1 := '';
			SELF.StreetAddress2 := '';
			SELF.City := L.city_name;
			SELF.State := L.state;
			SELF.Zip5 := L.zip;
			SELF.Zip4 := L.zip4;
			SELF.PostalCode := L.PostalCode;
			SELF.County := '';
			SELF.StateCityZip := '';
			SELF.score_addr := L.score_addr;
			//SELF.HistoryFlag := L.history_flag;
		
			// in a sense, best_score_phone is a bit misleading here... we're
			// simply converting record formats, so the "best" phone score is
			// the only one we have.  This field makes more sense in the rollup
			// context later.
			SELF.best_score_phone := L.score_phone;
			SELF.listing_type := L.listing_type; 
			SELF.Current := L.Current;
			SELF.AddressType := L.AddressType;
		END;	// AddrTransform

		addrs := PROJECT(recs, InputToAddrTransform(LEFT));
		sortedAddrs := SORT(addrs, rollup_key,
															 rollup_key_type,
															 State,
															 StreetNumber,
															 StreetName,
															 City,
															 UnitNumber, 
															 StreetPreDirection, 
															 StreetPostDirection, 
															 Zip5,PostalCode);
		uniqueAddrs := DEDUP(sortedAddrs, RECORD);

		scoredAddrLayout AddressRollup(scoredAddrLayout L, scoredAddrLayout R) := TRANSFORM
			SELF.rollup_key := L.rollup_key;
			SELF.rollup_key_type := L.rollup_key_type;

			pa := if(l.score_addr >= r.score_addr, L, R);  // preferred address
			oa := if(l.score_addr >= r.score_addr, R, L);  // "other" address

			// these are hard requirements in the rollup below
			SELF.State := L.State;
			SELF.StreetNumber := L.StreetNumber;
			
			SELF.StreetName := if(pa.StreetName <> '', pa.StreetName, oa.StreetName);
			SELF.StreetPreDirection := if(pa.StreetPreDirection <> '', pa.StreetPreDirection, oa.StreetPreDirection);
			SELF.StreetPostDirection := if(pa.StreetPostDirection <> '', pa.StreetPostDirection, oa.StreetPostDirection);
			SELF.StreetSuffix := if(pa.StreetSuffix <> '', pa.StreetSuffix, oa.StreetSuffix);
			SELF.UnitDesignation := if(pa.UnitDesignation <> '', pa.UnitDesignation, oa.UnitDesignation);
			SELF.UnitNumber :=if(pa.UnitNumber <> '', pa.UnitNumber, oa.UnitNumber);
			SELF.City := if(pa.City <> '', pa.City, oa.City);
			SELF.Zip5 := if(pa.Zip5 <> '', pa.Zip5, oa.Zip5);
			SELF.PostalCode := if(pa.PostalCode <> '', pa.PostalCode, oa.PostalCode);
			SELF.Zip4 := '';
			SELF.DateFirstSeen := mod_Dates.fn_MinDate(L.DateFirstSeen, R.DateFirstSeen);
			SELF.DateLastSeen := mod_Dates.fn_MaxDate(L.DateLastSeen, R.DateLastSeen);
			//SELF.HistoryFlag := L.history_flag;
			
			SELF.score_addr := pa.score_addr;
			SELF.best_score_phone := max(L.best_score_phone, R.best_score_phone);

			SELF.Phones := CHOOSEN(DEDUP(SORT(L.Phones + R.Phones, Phone10), Phone10), iesp.Constants.RA.MAX_CHILD_RECORDS);

			// these fields should never be set.
			SELF.StreetAddress1 := '';
			SELF.StreetAddress2 := '';
			SELF.County := '';
			SELF.StateCityZip := '';
			SELF.listing_type := '';
			//SELF.HistoryFlag := '';
			SELF.Current := if(pa.Current <> '', pa.Current, oa.Current);
			SELF.AddressType := if(pa.AddressType <> '', pa.AddressType, oa.AddressType);
		END;  // AddressRollup

		BOOLEAN fuzzyMatch(STRING s1, STRING s2) := (s1 = s2 OR fn_NormalizedEditDistance(s1, s2) > 80);
			
		mergedAddrs := ROLLUP(uniqueAddrs, 
													LEFT.rollup_key = RIGHT.rollup_key AND
													LEFT.rollup_key_type = RIGHT.rollup_key_type AND
													LEFT.State = RIGHT.State AND
													LEFT.StreetNumber = RIGHT.StreetNumber AND
													fuzzyMatch(LEFT.StreetName, RIGHT.StreetName) AND
													fuzzyMatch(LEFT.City, RIGHT.City) AND
													ut.nneq(LEFT.UnitNumber, RIGHT.UnitNumber) AND
													ut.nneq(LEFT.StreetPreDirection, RIGHT.StreetPreDirection) AND
													ut.nneq(LEFT.StreetPostDirection, RIGHT.StreetPostDirection),
													AddressRollup(LEFT, RIGHT));

		scoredAddrResponse toAddrResponse(entityLayout L) := TRANSFORM
			SELF.rollup_key := L.rollup_key;
			SELF.rollup_key_type := L.rollup_key_type;

			SELF.addrs := [];
		END;
		
		emptyResponse := PROJECT(entities, toAddrResponse(LEFT));

		// associate all scored address records with respective appropriate entity
		// container

		scoredAddrResponse populateAddrsTransform(scoredAddrResponse L, scoredAddrLayout R) := TRANSFORM
			SELF.rollup_key := L.rollup_key;
			SELF.rollup_key_type := L.rollup_key_type;

			SELF.addrs := L.addrs + R;
		END;

		scoredResp := DENORMALIZE(emptyResponse, mergedAddrs,
															LEFT.rollup_key = RIGHT.rollup_key AND
															LEFT.rollup_key_type = RIGHT.rollup_key_type,
															populateAddrsTransform(LEFT, RIGHT));

		rollAddressesResponse toResponseLayout(scoredAddrResponse L) := TRANSFORM
			myAddrs := L.addrs;
			UPS_Services.mac_SortAddresses(myAddrs,mySrtAddrs);

			bestAddrIdx := fn_BestAddress(mySrtAddrs);
			topAddrs := fn_RestrictOutputAddresses(mySrtAddrs, maxRecs);
			allAddrs := if(bestAddrIdx > maxRecs, topAddrs + mySrtAddrs[bestAddrIdx], topAddrs);
			bestAddr := if(bestAddrIdx > maxRecs, maxRecs + 1, bestAddrIdx);
			
			SELF.rollup_key := L.rollup_key;
			SELF.rollup_key_type := L.rollup_key_type;
			SELF.best_score_addr := MAX(allAddrs, score_addr);
			SELF.best_score_phone := MAX(allAddrs, best_score_phone);
			SELF.best_address := bestAddr;
			SELF.addresses := PROJECT(allAddrs, addrLayout);
			SELF.listing_type := '';
		END;

		resp := PROJECT(scoredResp, toResponseLayout(LEFT));

		#if(Debug.debug_flag)
		output(addrs, named('addrs'));
		output(sortedAddrs, named('sortedAddrs'));
		output(uniqueAddrs, named('uniqueAddrs'));
		output(mergedAddrs, named('mergedAddrs'));
		output(entities, named('addrEntities'));
		output(emptyResponse, named('emptyAddrResponse'));
		output(scoredResp, named('scoredAddrResponse'));
		output(resp, named('addrResponse'));
		#end

		return resp;
	END;

	export DATASET(inLayout) fn_FilterInputRecords(DATASET(inLayout) recs) := FUNCTION
		
		inState := inputs.addrQueryInputs.state;
		inPhone := inputs.phoneQueryInput;
		hasState := inState <> ''  ;
		hasPhone := inPhone <> '';

		keyLayout := RECORD
			recs.rollup_key;
			recs.rollup_key_type;
		END;

		allKeys := SORT(PROJECT(recs, keyLayout), record);

		// if a state was included in the search criteria and there were no 
		// matching records returned in that state for an entity, remove the 
		// entire entity.
		
		stateKeys := if(hasState, PROJECT(recs(state = inState), keyLayout),
															allKeys);
		
		// if only a phone number was provided for search criteria and no records
		// matching that phone number were returned (perhaps due to GLB or DPPA
		// filtering), remove the entire entity.
		// BZ 42158 - it's possible to get a hit on a phone number which is not
		//            associated with an address.  Since we can't tie the phone to
		//            an address for display, and records with empty addresses are
		//            filtered from the display, it's necessary to filter (remove)
		//            phone + empty address records  :(
		
		errantPhones :=
			UPS_Services.mod_GenerateTransposedPhones(inPhone).set_phone10 +
			UPS_Services.mod_GenerateFatfingeredPhones(inPhone).set_phone10;
		
		phoneKeys := if(hasPhone, PROJECT(recs((phone = inPhone or phone in errantPhones) AND (prim_range <> '' OR prim_name <> '')), keyLayout),
															allKeys);

		useKeys := MAP(NOT hasState AND NOT hasPhone => allKeys,
									 NOT hasState AND hasPhone => phoneKeys,
									 hasState AND NOT hasPhone => stateKeys,
									 hasState AND hasPhone => phoneKeys + stateKeys,
									 allKeys);

		inLayout outTransform(keyLayout L, inLayout R) := TRANSFORM
			SELF := R;
		END;

		keys := DEDUP(SORT(useKeys, RECORD), RECORD);

		#IF(Debug.debug_flag)
		output(hasState, named('filterHasState'));
		output(hasPhone, named('filterHasPhone'));
		output(allKeys, named('filterAllKeys'));
		output(stateKeys, named('filterStateKeys'));
		output(phoneKeys, named('filterPhoneKeys'));
		output(keys, named('filteredKeys'));
		#END

		srtRecs := SORT(recs, rollup_key, rollup_key_type);

		return JOIN(keys, srtRecs, 
								LEFT.rollup_key = RIGHT.rollup_key AND 
								LEFT.rollup_key_type = RIGHT.rollup_key_type,
								outTransform(LEFT, RIGHT));
	END;

	// master rollup routine.  Rolls up names, addresses, and phones by rollup_key
	// and rollup_key_type.
	//
	//    searchVals - values used in original searches, required for selecting
	//								 "best" address, "best" phone, various filters, etc.
	//    in_recs    - the records to be rolled up.
	//    maxResults - (optional) the maximum number of entities rolled up
	//                 entities to return.  If 0, all will be returned.
	export DATASET(outLayout) roll(DATASET(inLayout) in_recs, UNSIGNED4 maxResults = 0) := FUNCTION	

		rollupLayout := RECORD(outLayout)
			inLayout.rollup_key;
			inLayout.rollup_key_type;
			INTEGER4 BestAddressDate;
			inLayout.Listing_Type;
		END;

		srtRecs := SORT(in_recs, rollup_key, rollup_key_type);
		filteredRecs := fn_FilterInputRecords(srtRecs);

		// some housekeeping for later
		nameInputs := inputs.nameQueryInputs;
		hasIndNameInput := nameInputs.first <> '' OR nameInputs.middle <> '' OR nameInputs.last <> '';
		hasBizNameInput := nameInputs.companyname <> '';
		hasNameInput := hasIndNameInput OR hasBizNameInput;

		addrInputs := inputs.addrQueryInputs;
		hasAddrStreetInput := addrInputs.StreetNumber <> '' OR addrInputs.StreetName <> '';
		hasAddrCityStZipInput := addrInputs.City <> '' OR addrInputs.State <> '' OR addrInputs.Zip5 <> '' OR addrInputs.PostalCode <> '' ;
		hasAddrInput := hasAddrStreetInput OR hasAddrCityStZipInput;

		hasPhoneInput := inputs.phoneQueryInput <> '';


		// build the basic entity record structure for each entity in the input
		entities := PROJECT(filteredRecs, entityLayout);
		uniqueEntities := DEDUP(SORT(entities, RECORD), RECORD);

		rolledNames := rollNames(filteredRecs, uniqueEntities);

		rolledAddrs := rollAddresses(filteredRecs, uniqueEntities);

		rollupLayout InputToEntityTransform(uniqueEntities L) := TRANSFORM
			SELF.rollup_key := L.rollup_key;
			SELF.rollup_key_type := L.rollup_key_type;
			SELF.listing_type := L.listing_type;
			SELF := [];
		END;

		emptyRecs := PROJECT(uniqueEntities, InputToEntityTransform(LEFT));

		rollupLayout PopulateEntities(rollupLayout L) := TRANSFORM
			SELF.rollup_key := L.rollup_key;
			SELF.rollup_key_type := L.rollup_key_type;
			
			SELF.UniqueID := (STRING) L.rollup_key;
			SELF.EntityType := map( 
			                      L.rollup_key_type = Constants.TAG_ROLLUP_KEY_LINKID => UPS_Services.Constants.TAG_ENTITY_BIZ,
														  L.rollup_key_type = Constants.TAG_ROLLUP_KEY_DID =>  Constants.TAG_ENTITY_IND,								
															L.rollup_key_type = Constants.TAG_ROLLUP_KEY_FDID  and L.Listing_Type ='B'=> UPS_Services.Constants.TAG_ENTITY_BIZ,
															L.rollup_key_type = Constants.TAG_ROLLUP_KEY_FDID  and L.Listing_Type ='R'=> UPS_Services.Constants.TAG_ENTITY_IND,
															L.rollup_key_type = Constants.TAG_ROLLUP_KEY_FAKEID  and L.Listing_Type ='B'=> UPS_Services.Constants.TAG_ENTITY_BIZ,
															Constants.TAG_ENTITY_UNK
														 );

			nameEntities := rolledNames(rollup_key = L.rollup_key AND rollup_key_type = L.rollup_key_type);
			myNames := if (EXISTS(nameEntities), nameEntities[1].names, DATASET([], nameLayout));
			SELF.Names := myNames;

			addrEntities := rolledAddrs(rollup_key = L.rollup_key AND rollup_key_type = L.rollup_key_type);
			myAddrs := if (EXISTS(addrEntities), addrEntities[1].addresses, DATASET([], addrLayout));
			SELF.Addresses := myAddrs;

			// todo - fix me!
			bestAddress := addrEntities[1].best_address;
			SELF.BestAddress := bestAddress;

			best_addr_year := myAddrs[bestAddress].DateLastSeen.year;
			best_addr_month := myAddrs[bestAddress].DateLastSeen.month;

			SELF.BestAddressDate := (best_addr_year * 100) + best_addr_month;

			defWeights := scoreMod.defWeightsRecord;
			wt_name := defWeights.wt_grp_name;
			wt_addr := defWeights.wt_grp_addr;
			wt_phone := defWeights.wt_grp_phone;

			wt_total := if(hasNameInput, wt_name, 0) +
									if(hasAddrInput, wt_addr, 0) + 
									if(hasPhoneInput, wt_phone, 0);

			// compute an aggreate score for this record.

			pointsBestName := if(hasNameInput, nameEntities[1].best_score_name * wt_name, 0);
			pointsBestAddr := if(hasAddrInput, addrEntities[1].best_score_addr * wt_addr, 0);
			pointsBestPhone := if(hasPhoneInput, addrEntities[1].best_score_phone * wt_phone, 0);

			SELF.Score := if(wt_total = 0, Constants.DEFAULT_RANGE,
																		 (pointsBestName + pointsBestAddr + pointsBestPhone) / wt_total);
			SELF.listing_type := L.listing_type;	
		END;

		filledRecs := PROJECT(emptyRecs, PopulateEntities(LEFT));
	
		usableRecs := filledRecs(EXISTS(names) AND 
														 EXISTS(addresses) AND
														 Score >= Constants.RESPONSE_THRESHOLD);


		presentationRecs := PROJECT(usableRecs, outLayout);
		sortedRecs := SORT(usableRecs, -score, 
																	 -BestAddressDate, 
																	 if(names[1].Last <> '', names[1].Last, names[1].companyname), 
																	 names[1].First, 
																	 UniqueID);

		outRecs := PROJECT(sortedRecs, outLayout);  // drops internally used fields

	#IF (Debug.debug_flag)
		output(in_recs, NAMED('inRecs'));
		output(count(in_recs), named('inRecsCount'));
		output(filteredRecs, NAMED('filteredRecs'));
		output(count(filteredRecs), named('filteredRecsCount'));
		output(uniqueEntities, named('uniqueEntities'));
		output(count(uniqueEntities), named('uniqueEntitiesCount'));
		output(filledRecs, NAMED('filledRecs'));
		output(presentationRecs, NAMED('presentationRecs'));
		output(sortedRecs, NAMED('sortedRecs'));
		output(outRecs, NAMED('outputRecs'));
		output(maxResults, NAMED('maxResults'));
	#END

		return if (maxResults > 0, CHOOSEN(outRecs, maxResults),
															 outRecs);
	END;  // roll() function

END;  // mod_Rollup module

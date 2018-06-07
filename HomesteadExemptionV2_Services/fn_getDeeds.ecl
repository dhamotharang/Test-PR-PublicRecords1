IMPORT LN_PropertyV2, LN_PropertyV2_Services, Std, ut;

EXPORT fn_getDeeds(DATASET(HomesteadExemptionV2_Services.Layouts.fidSrchRec) fids) := FUNCTION

	workRec:=RECORD
		HomesteadExemptionV2_Services.Layouts.propParentRec;
		HomesteadExemptionV2_Services.Layouts.deedSlim;
	END;

	addrWorkRec:=RECORD
		workRec;
		HomesteadExemptionV2_Services.Layouts.addrMin bestAddr;
		HomesteadExemptionV2_Services.Layouts.addrMin inputAddr;
	END;

	workDeedPartyRec := RECORD
		HomesteadExemptionV2_Services.Layouts.propParentRec;
		HomesteadExemptionV2_Services.Layouts.deedsPartiesRec;
	END;

	HomesteadExemptionV2_Services.Layouts.propDeedRec rollParents(HomesteadExemptionV2_Services.Layouts.propDeedRec L,HomesteadExemptionV2_Services.Layouts.propDeedRec R) := TRANSFORM
		SELF.firstSeen:=(STRING)ut.Min2((INTEGER)L.firstSeen,(INTEGER)R.firstSeen);
		SELF.lastSeen:=MAX(L.lastSeen,R.lastSeen);
		SELF:=L;
	END;

	HomesteadExemptionV2_Services.Layouts.propDeedRec addDeedChildren(HomesteadExemptionV2_Services.Layouts.propDeedRec L,DATASET(workDeedPartyRec) R) := TRANSFORM
		SELF.deed_records:=PROJECT(R,TRANSFORM(HomesteadExemptionV2_Services.Layouts.deedsPartiesRec,SELF:=LEFT));
		SELF:=L;
	END;

	workRec deedRecords(addrWorkRec L) := TRANSFORM
		// FILTER RECORDS BY PROPERTY ID
		propAddr:=ROW({L.prim_range,L.prim_name,L.sec_range,L.p_city_name,L.st,L.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
		propertyID:=HomesteadExemptionV2_Services.Functions.getPropertyID(propAddr,L.fares_unformatted_apn);
		SELF.property_ID:=IF(propertyID!='',propertyID,SKIP);
		SELF.sortby_date:=LN_PropertyV2_Services.Raw.deed_recency(L);

		// COMPARE ADDRESSES AND SET BOOLEANS
		inputAddr:=ROW({L.inputAddr.prim_range,L.inputAddr.prim_name,L.inputAddr.sec_range,L.inputAddr.p_city_name,L.inputAddr.st,L.inputAddr.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
		SELF.isInputAddress:=HomesteadExemptionV2_Services.Functions.compare2Addresses(propAddr,inputAddr);
		bestAddr:=ROW({L.bestAddr.prim_range,L.bestAddr.prim_name,L.bestAddr.sec_range,L.bestAddr.p_city_name,L.bestAddr.st,L.bestAddr.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
		SELF.isBestAddress:=HomesteadExemptionV2_Services.Functions.compare2Addresses(propAddr,bestAddr);

		// SET DESCRIPTIONS
		fid_type:=LN_PropertyV2.fn_fid_type(L.ln_fares_id);
		SELF.fid_type:=fid_type;
		SELF.fid_type_desc:=LN_PropertyV2_Services.fn_fid_type_desc(fid_type);
		SELF.vendor_source_flag:=LN_PropertyV2_Services.fn_vendor_source_obscure(L.vendor_source_flag);
		SELF.vendor_source_desc:=LN_PropertyV2_Services.fn_vendor_source(L.vendor_source_flag);
		SELF:=L;
	END;

	// GET RAW RECS
	rawDeeds:=JOIN(fids,LN_PropertyV2.key_deed_fid(),
		KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id),
		TRANSFORM(addrWorkRec,
			SELF.did:=LEFT.search_did,
			SELF:=LEFT,
			SELF:=RIGHT,
			SELF:=[]),
		LIMIT(LN_PropertyV2_Services.consts.MAX_RAW,SKIP));

	// PICKUP FARES MORTGAGE DATE -> LN_PropertyV2_Services.Raw.deed_recency()
	addlDeeds:=JOIN(rawDeeds,LN_PropertyV2.key_addl_fares_deed_fid,
		KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id),
		TRANSFORM(addrWorkRec,
			SELF.fares_mortgage_date:=RIGHT.fares_mortgage_date,
			SELF:=LEFT,
			SELF:=[]),
		LEFT OUTER,LIMIT(0),KEEP(1));

	// PICKUP OWNERSHIP AND SEEN DATES
	ownerDeeds:=JOIN(addlDeeds,LN_PropertyV2.key_ownership.did(),
		KEYED(LEFT.did=RIGHT.did) AND Std.Str.Find(LEFT.fares_unformatted_apn,TRIM(RIGHT.unformatted_apn))>0,
		TRANSFORM(addrWorkRec,
			taxYearDids:=NORMALIZE(RIGHT.hist(((STRING)dt_seen)[1..4]=LEFT.inputTaxYear),LEFT.owners,TRANSFORM({UNSIGNED6 did},SELF:=RIGHT));
			currentDids:=DEDUP(NORMALIZE(RIGHT.hist(dt_seen=RIGHT.dt_last_seen),LEFT.owners,TRANSFORM(HomesteadExemptionV2_Services.Layouts.didRec,SELF:=RIGHT)),ALL);
			SELF.dids:=currentDids,
			SELF.firstSeen:=(STRING)Std.Date.Year(RIGHT.dt_first_seen),
			SELF.lastSeen:=(STRING)Std.Date.Year(RIGHT.dt_last_seen),
			SELF.isCurrentOwner:=RIGHT.current,
			SELF.isTaxYearOwner:=EXISTS(taxYearDids(did=LEFT.did)),
			SELF.isBusinessOwned:=EXISTS(currentDids(isbdid)),
			SELF:=LEFT,
			SELF:=[]),
		LEFT OUTER,LIMIT(0),KEEP(1));

	// PICKUP CLEAN ADDRESS
	addrDeeds:=JOIN(ownerDeeds,LN_PropertyV2.key_search_fid(),
		KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id) AND
		LEFT.did=RIGHT.did AND RIGHT.source_code_2='P',
		TRANSFORM(addrWorkRec,
			SELF.prim_range :=RIGHT.prim_range,
			SELF.predir     :=RIGHT.predir,
			SELF.prim_name  :=RIGHT.prim_name,
			SELF.addr_suffix:=RIGHT.suffix,
			SELF.postdir    :=RIGHT.postdir,
			SELF.unit_desig :=RIGHT.unit_desig,
			SELF.sec_range  :=RIGHT.sec_range,
			SELF.p_city_name:=RIGHT.p_city_name,
			SELF.st         :=RIGHT.st,
			SELF.z5         :=RIGHT.zip,
			SELF.zip4       :=RIGHT.zip4,
			SELF:=LEFT,
			SELF:=[]),
		LEFT OUTER,LIMIT(0),KEEP(1));

	deedRecs:=PROJECT(addrDeeds,deedRecords(LEFT));
	partyRecs:=HomesteadExemptionV2_Services.fn_getParties(fids);

	// JOIN PARTY RECORDS
	deedPartyRecs:=JOIN(deedRecs,partyRecs,
		LEFT.acctno=RIGHT.acctno AND
		LEFT.ln_fares_id=RIGHT.ln_fares_id AND
		LEFT.fid_type=RIGHT.fid_type,
		TRANSFORM(workDeedPartyRec,
			isBuyerBorrower:=LEFT.did IN SET(RIGHT.parties(party_type IN ['O','B']).entity,(UNSIGNED)did);
			SELF.deeds:=PROJECT(LEFT,TRANSFORM(HomesteadExemptionV2_Services.Layouts.deedSlim,
				SELF.isBuyerBorrower:=isBuyerBorrower,SELF:=LEFT)),
			SELF.parties:=PROJECT(RIGHT.parties,TRANSFORM(HomesteadExemptionV2_Services.Layouts.partySlim,SELF:=LEFT)),
			SELF:=LEFT),
		LIMIT(0),KEEP(1));

	parentRecs:=PROJECT(deedRecs,TRANSFORM(HomesteadExemptionV2_Services.Layouts.propDeedRec,SELF:=LEFT;SELF:=[]));
	sortParents:=SORT(parentRecs,acctno,did,property_id,firstSeen,lastSeen);
	rolledParents:=ROLLUP(sortParents,LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did AND LEFT.property_id=RIGHT.property_id,rollParents(LEFT,RIGHT));

	// OUTPUT(rawDeeds,NAMED('rawDeeds'));
	// OUTPUT(ownerDeeds,NAMED('ownerDeeds'));
	// OUTPUT(addrDeeds,NAMED('addrDeeds'));
	// OUTPUT(deedRecs,NAMED('deedRecs'));
	// OUTPUT(partyRecs,NAMED('dPartyRecs'));
	// OUTPUT(SORT(deedPartyRecs,acctno,did,property_id),NAMED('deedPartyRecs'));
	// OUTPUT(parentRecs,NAMED('deedParentRecs'));
	// OUTPUT(sortParents,NAMED('deedSortParents'));
	// OUTPUT(rolledParents,NAMED('deedRolledParents'));

	RETURN DENORMALIZE(rolledParents,deedPartyRecs,
		LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did AND LEFT.property_id=RIGHT.property_id,
		GROUP,addDeedChildren(LEFT,ROWS(RIGHT)));
END;

IMPORT Codes, LN_PropertyV2, LN_PropertyV2_Services, Std, ut;

EXPORT fn_getAssessments(DATASET(HomesteadExemptionV2_Services.Layouts.fidSrchRec) fids) := FUNCTION

	ASSESS_FILE:=LN_PropertyV2_Services.consts.assess_codefile;

	workRec:=RECORD
		HomesteadExemptionV2_Services.Layouts.propParentRec;
		HomesteadExemptionV2_Services.Layouts.assessmentSlim;
		LN_PropertyV2_Services.layouts.parties.tmp1.addr_type;
		LN_PropertyV2_Services.layouts.parties.pparty.party_type;
		LN_PropertyV2_Services.layouts.parties.pparty.party_type_name;
	END;

	addrWorkRec:=RECORD
		workRec;
		HomesteadExemptionV2_Services.Layouts.addrMin bestAddr;
		HomesteadExemptionV2_Services.Layouts.addrMin inputAddr;
	END;

	workAssessmentPartyRec := RECORD
		HomesteadExemptionV2_Services.Layouts.propParentRec;
		HomesteadExemptionV2_Services.Layouts.assessmentsPartiesRec;
	END;

	HomesteadExemptionV2_Services.Layouts.propAssessmentRec rollParents(HomesteadExemptionV2_Services.Layouts.propAssessmentRec L,HomesteadExemptionV2_Services.Layouts.propAssessmentRec R) := TRANSFORM
		SELF.firstSeen:=(STRING)ut.Min2((INTEGER)L.firstSeen,(INTEGER)R.firstSeen);
		SELF.lastSeen:=MAX(L.lastSeen,R.lastSeen);
		SELF:=L;
	END;

	HomesteadExemptionV2_Services.Layouts.propAssessmentRec addAssessmentChildren(HomesteadExemptionV2_Services.Layouts.propAssessmentRec L,DATASET(workAssessmentPartyRec) R) := TRANSFORM
		SELF.assessment_records:=PROJECT(R,TRANSFORM(HomesteadExemptionV2_Services.Layouts.assessmentsPartiesRec,SELF:=LEFT));
		SELF:=L;
	END;

	workRec assessmentRecords(addrWorkRec L) := TRANSFORM
		// FILTER RECORDS BY PROPERTY ID
		propAddr:=ROW({L.prim_range,L.prim_name,L.sec_range,L.p_city_name,L.st,L.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
		propertyID:=HomesteadExemptionV2_Services.Functions.getPropertyID(propAddr,L.fares_unformatted_apn);
		SELF.property_ID:=IF(propertyID!='',propertyID,SKIP);

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
		vsource:=LN_PropertyV2_Services.fn_vendor_source(L.vendor_source_flag);
		SELF.vendor_source_desc:=vsource;
		SELF.tax_exemption1_desc:=Codes.KeyCodes(ASSESS_FILE,'TAX_EXEMPTION1_CODE',vsource,L.tax_exemption1_code,TRUE);
		SELF.tax_exemption2_desc:=Codes.KeyCodes(ASSESS_FILE,'TAX_EXEMPTION2_CODE',vsource,L.tax_exemption2_code,TRUE);
		SELF.tax_exemption3_desc:=Codes.KeyCodes(ASSESS_FILE,'TAX_EXEMPTION3_CODE',vsource,L.tax_exemption3_code,TRUE);
		SELF.tax_exemption4_desc:=Codes.KeyCodes(ASSESS_FILE,'TAX_EXEMPTION4_CODE',vsource,L.tax_exemption4_code,TRUE);
		SELF.standardized_land_use_desc:=Codes.KeyCodes(ASSESS_FILE,'LAND_USE',vsource,L.standardized_land_use_code,TRUE);
		SELF:=L;
	END;

	// GET RAW RECS
	rawAssessments:=JOIN(fids,LN_PropertyV2.key_assessor_fid(),
		KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id),
		TRANSFORM(addrWorkRec,
			SELF.did:=LEFT.search_did,
			SELF.sortby_date:=LN_PropertyV2_Services.Raw.assess_recency(RIGHT),
			SELF:=LEFT,
			SELF:=RIGHT,
			SELF:=[]),
		LIMIT(LN_PropertyV2_Services.consts.MAX_RAW,SKIP));

	// PICKUP OWNERSHIP SEEN DATES
	ownerAssessments:=JOIN(rawAssessments,LN_PropertyV2.key_ownership.did(),
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
	addrAssessments:=JOIN(ownerAssessments,LN_PropertyV2.key_search_fid(),
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

	assessmentRecs:=PROJECT(addrAssessments,assessmentRecords(LEFT));
	partyRecs:=HomesteadExemptionV2_Services.fn_getParties(fids);

	// JOIN PARTY RECORDS
	assessmentPartyRecs:=JOIN(assessmentRecs,partyRecs,
		LEFT.acctno=RIGHT.acctno AND
		LEFT.ln_fares_id=RIGHT.ln_fares_id AND
		LEFT.fid_type=RIGHT.fid_type,
		TRANSFORM(workAssessmentPartyRec,
			isAssessee:=LEFT.did IN SET(RIGHT.parties(party_type='O').entity,(UNSIGNED)did);
			SELF.assessments:=PROJECT(LEFT,TRANSFORM(HomesteadExemptionV2_Services.Layouts.assessmentSlim,
				SELF.isAssessee:=isAssessee,SELF:=LEFT)),
			SELF.parties:=PROJECT(RIGHT.parties,TRANSFORM(HomesteadExemptionV2_Services.Layouts.partySlim,SELF:=LEFT)),
			SELF:=LEFT),
		LIMIT(0),KEEP(1));

	parentRecs:=PROJECT(assessmentRecs,TRANSFORM(HomesteadExemptionV2_Services.Layouts.propAssessmentRec,SELF:=LEFT,SELF:=[]));
	sortParents:=SORT(parentRecs,acctno,did,property_id,firstSeen,lastSeen);
	rolledParents:=ROLLUP(sortParents,LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did AND LEFT.property_id=RIGHT.property_id,rollParents(LEFT,RIGHT));

	// OUTPUT(rawAssessments,NAMED('rawAssessments'));
	// OUTPUT(ownerAssessments,NAMED('ownerAssessments'));
	// OUTPUT(addrAssessments,NAMED('addrAssessments'));
	// OUTPUT(assessmentRecs,NAMED('assessmentRecs'));
	// OUTPUT(partyRecs,NAMED('aPartyRecs'));
	// OUTPUT(SORT(assessmentPartyRecs,acctno,did,property_id),NAMED('assessmentPartyRecs'));
	// OUTPUT(parentRecs,NAMED('assessmentParentRecs'));
	// OUTPUT(sortParents,NAMED('assessmentSortParents'));
	// OUTPUT(rolledParents,NAMED('assessmentRolledParents'));

	RETURN DENORMALIZE(rolledParents,assessmentPartyRecs,
		LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did AND LEFT.property_id=RIGHT.property_id,
		GROUP,addAssessmentChildren(LEFT,ROWS(RIGHT)));
END;

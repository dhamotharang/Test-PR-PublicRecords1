IMPORT LN_PropertyV2, LN_PropertyV2_Services, Suppress;

EXPORT fn_getProperties(DATASET(HomesteadExemptionV2_Services.Layouts.workRec) ds_work_in,
				HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

	raw_fid_recs:=JOIN(ds_work_in,LN_PropertyV2.key_Property_did(),
		KEYED(LEFT.did=RIGHT.s_did) AND	RIGHT.source_code_2='P',
		TRANSFORM(HomesteadExemptionV2_Services.Layouts.fidSrchRec,
			SELF.acctno       :=LEFT.acctno,
			SELF.link_clientid :=LEFT.link_clientid,
			SELF.ln_fares_id  :=RIGHT.ln_fares_id,
			SELF.search_did   :=LEFT.did,
			SELF.inputTaxYear :=LEFT.tax_year,
			SELF.inputTaxState:=LEFT.tax_state,
			// BEST NAME
			SELF.name_first   :=LEFT.Best_Records[1].name_first,
			SELF.name_middle  :=LEFT.Best_Records[1].name_middle,
			SELF.name_last    :=LEFT.Best_Records[1].name_last,
			SELF.name_suffix  :=LEFT.Best_Records[1].name_suffix,
			// BEST ADDRESS
			SELF.bestAddr.prim_range   :=LEFT.Best_Records[1].prim_range,
			SELF.bestAddr.prim_name    :=LEFT.Best_Records[1].prim_name,
			SELF.bestAddr.sec_range    :=LEFT.Best_Records[1].sec_range,
			SELF.bestAddr.p_city_name  :=LEFT.Best_Records[1].p_city_name,
			SELF.bestAddr.st           :=LEFT.Best_Records[1].st,
			SELF.bestAddr.z5           :=LEFT.Best_Records[1].z5,
			// INPUT ADDRESS
			SELF.inputAddr.prim_range  :=LEFT.prim_range,
			SELF.inputAddr.prim_name   :=LEFT.prim_name,
			SELF.inputAddr.sec_range   :=LEFT.sec_range,
			SELF.inputAddr.p_city_name :=LEFT.p_city_name,
			SELF.inputAddr.st          :=LEFT.st,
			SELF.inputAddr.z5          :=LEFT.z5,
			SELF:=[]),
		LIMIT(LN_PropertyV2_Services.consts.MAX_RAW,SKIP));

	dup_fid_recs:=DEDUP(SORT(raw_fid_recs,acctno,ln_fares_id),acctno,ln_fares_id);
	Suppress.MAC_Suppress(dup_fid_recs,fid_recs,in_mod.ApplicationType,,,Suppress.Constants.DocTypes.FaresID,ln_fares_id);

	// APPLY DATA_RESTRICTION_MASK USING FIRST CHARACTER OF LN_FARES_ID
	// 'R' = FARES = VENDOR_SOURCE_DESC IS 'FAR_F' AND 'FAR_S'
	// 'O' = FIDELITY = VENDOR_SOURCE_DESC IS 'OKCTY'
	// 'D' = LNBRANDED = VENDOR_SOURCE_DESC IS 'DAYTN'
	// DRM = '00000' ALLOW['O','R'] RESTRICT['D']
	// DRM = '10000' ALLOW['O'] RESTRICT['R','D']
	// DRM = '00001' ALLOW['R'] RESTRICT['O','D']
	// TO ALLOW['D'] FIDELITY MUST BE INCLUDED AND LNBRANDED=TRUE

	srch_fid_recs:=fid_recs(ln_fares_id[1] NOT IN LN_PropertyV2_Services.input.srcRestrict);

	deed_recs:=HomesteadExemptionV2_Services.fn_getDeeds(srch_fid_recs);
	assessment_recs:=HomesteadExemptionV2_Services.fn_getAssessments(srch_fid_recs);

	/************************************************/

	// JOIN DEEDS AND ASSESSMENTS

	HomesteadExemptionV2_Services.Layouts.hmstdYearRec gatherHmstdExmptns(HomesteadExemptionV2_Services.Layouts.assessmentSlim L) := TRANSFORM
		hasExmptn:=L.homestead_homeowner_exemption='Y' OR	L.tax_exemption1_code='D' OR
			L.tax_exemption2_code='D' OR L.tax_exemption3_code='D' OR L.tax_exemption4_code='D';
		tax_year:=IF(L.tax_year!='',L.tax_year,L.assessed_value_year);
		SELF.tax_year:=IF(hasExmptn AND tax_year!='',tax_year,SKIP);
		SELF.hmstdExmptn:=L.homestead_homeowner_exemption;
		SELF.exmptn1:=L.tax_exemption1_desc;
		SELF.exmptn2:=L.tax_exemption2_desc;
		SELF.exmptn3:=L.tax_exemption3_desc;
		SELF.exmptn4:=L.tax_exemption4_desc;
	END;

	HomesteadExemptionV2_Services.Layouts.taxYearRec gatherSeenDates(HomesteadExemptionV2_Services.Layouts.assessmentSlim L) := TRANSFORM
		tax_year:=IF(L.tax_year!='',L.tax_year,L.assessed_value_year);
		SELF.tax_year:=IF(tax_year!='',tax_year,SKIP);
	END;

	HomesteadExemptionV2_Services.Layouts.propertyRec setDeedsAssessments(HomesteadExemptionV2_Services.Layouts.propDeedRec L,HomesteadExemptionV2_Services.Layouts.propAssessmentRec R) := TRANSFORM
		hasDeedRecords:=EXISTS(L.deed_records);
		hasAssessments:=EXISTS(R.assessment_records.assessments(isAssessee));
		isInputAddress:=IF(hasDeedRecords,L.isInputAddress,R.isInputAddress);

		hmstdExmptns:=DEDUP(SORT(PROJECT(R.assessment_records.assessments(isAssessee),gatherHmstdExmptns(LEFT)),tax_year,-hmstdExmptn,-exmptn1),tax_year);
		cntHmstdExmptns:=COUNT(hmstdExmptns);
		firstHmstdExmptn:=MIN(hmstdExmptns,tax_year);
		lastHmstdExmptn:=MAX(hmstdExmptns,tax_year);

		inputTaxYear:=IF(hasDeedRecords,L.inputTaxYear,R.inputTaxYear);
		previousYears:=HomesteadExemptionV2_Services.Functions.previousYears(inputTaxYear,HomesteadExemptionV2_Services.Constants.HOMESTEAD_YEARS);
		hasHmstdExmptn:=EXISTS(JOIN(hmstdExmptns,previousYears,LEFT.tax_year=RIGHT.year,LOOKUP));

		inputTaxState:=IF(hasDeedRecords,L.inputTaxState,R.inputTaxState);
		propState:=IF(hasDeedRecords,L.st,R.st);
		inState:=propState=inputTaxState;

		SELF.acctno      :=IF(hasDeedRecords,L.acctno,R.acctno);
		SELF.did         :=IF(hasDeedRecords,L.did,R.did);
		SELF.property_id :=IF(hasDeedRecords,L.property_id,R.property_id);

		SELF.property_rank:=MAP(isInputAddress => HomesteadExemptionV2_Services.Constants.INPUT_ADDR,
			hasAssessments AND hasDeedRecords AND	hasHmstdExmptn AND inState => HomesteadExemptionV2_Services.Constants.IN_STATE,
			hasAssessments AND hasDeedRecords AND	hasHmstdExmptn AND NOT inState => HomesteadExemptionV2_Services.Constants.OUT_OF_STATE,
			hasAssessments AND NOT hasDeedRecords AND hasHmstdExmptn => HomesteadExemptionV2_Services.Constants.HAS_EXMPTNS,
			hasAssessments AND hasDeedRecords AND NOT hasHmstdExmptn => HomesteadExemptionV2_Services.Constants.NO_EXMPTNS,
			NOT hasAssessments AND hasDeedRecords => HomesteadExemptionV2_Services.Constants.DEED_ONLY,
			hasAssessments AND NOT hasDeedRecords => HomesteadExemptionV2_Services.Constants.ASSESS_ONLY,
			255);

		deed_sortby_date   :=MAX(L.deed_records.deeds,sortby_date);
		assess_sortby_date :=MAX(R.assessment_records.assessments(isAssessee),sortby_date);
		SELF.sortby_date   :=MAX(deed_sortby_date,assess_sortby_date);

		SELF.link_clientid :=IF(hasDeedRecords,L.link_clientid,R.link_clientid);
		SELF.dids          :=IF(hasDeedRecords,L.dids,R.dids);
		SELF.inputTaxYear  :=IF(hasDeedRecords,L.inputTaxYear,R.inputTaxYear);
		SELF.inputTaxState :=IF(hasDeedRecords,L.inputTaxState,R.inputTaxState);

		// BEST NAME - FOR VEHICLE GATEWAY hasNameMatch
		SELF.name_first  :=IF(hasDeedRecords,L.name_first,R.name_first);
		SELF.name_middle :=IF(hasDeedRecords,L.name_middle,R.name_middle);
		SELF.name_last   :=IF(hasDeedRecords,L.name_last,R.name_last);
		SELF.name_suffix :=IF(hasDeedRecords,L.name_suffix,R.name_suffix);

		// PROPERTY ADDRESS
		SELF.prim_range  :=IF(hasDeedRecords,L.prim_range,R.prim_range);
		SELF.predir      :=IF(hasDeedRecords,L.predir,R.predir);
		SELF.prim_name   :=IF(hasDeedRecords,L.prim_name,R.prim_name);
		SELF.addr_suffix :=IF(hasDeedRecords,L.addr_suffix,R.addr_suffix);
		SELF.postdir     :=IF(hasDeedRecords,L.postdir,R.postdir);
		SELF.unit_desig  :=IF(hasDeedRecords,L.unit_desig,R.unit_desig);
		SELF.sec_range   :=IF(hasDeedRecords,L.sec_range,R.sec_range);
		SELF.p_city_name :=IF(hasDeedRecords,L.p_city_name,R.p_city_name);
		SELF.st          :=IF(hasDeedRecords,L.st,R.st);
		SELF.z5          :=IF(hasDeedRecords,L.z5,R.z5);
		SELF.zip4        :=IF(hasDeedRecords,L.zip4,R.zip4);

		SELF.isCurrentOwner  :=IF(hasDeedRecords,L.isCurrentOwner,R.isCurrentOwner);
		SELF.isTaxYearOwner  :=IF(hasDeedRecords,L.isTaxYearOwner,R.isTaxYearOwner);
		SELF.isBusinessOwned :=IF(hasDeedRecords,L.isBusinessOwned,R.isBusinessOwned);
		SELF.isBestAddress   :=IF(hasDeedRecords,L.isBestAddress,R.isBestAddress);

		SELF.isInputAddress  :=isInputAddress;
		SELF.hasDeedRecords  :=hasDeedRecords;
		SELF.hasAssessments  :=hasAssessments;

		SELF.hmstdExmptns     :=hmstdExmptns;
		SELF.hasHmstdExmptn   :=hasHmstdExmptn;
		SELF.cntHmstdExmptns  :=cntHmstdExmptns;
		SELF.firstHmstdExmptn :=firstHmstdExmptn;
		SELF.lastHmstdExmptn  :=lastHmstdExmptn;

		firstSeen:=IF(hasDeedRecords,L.firstSeen,R.firstSeen);
		ds_firstSeen:=DATASET([{firstSeen}],HomesteadExemptionV2_Services.Layouts.taxYearRec);
		lastSeen :=IF(hasDeedRecords,L.lastSeen,R.lastSeen);
		ds_lastSeen:=DATASET([{lastSeen}],HomesteadExemptionV2_Services.Layouts.taxYearRec);
		ds_tmpDates:=PROJECT(R.assessment_records.assessments(isAssessee),gatherSeenDates(LEFT));
		seenDates:=DEDUP(SORT(ds_firstSeen+ds_tmpDates+ds_lastSeen,tax_year),tax_year);
		SELF.seenDates :=seenDates;
		SELF.firstSeen :=IF(EXISTS(seenDates),MIN(firstSeen,MIN(seenDates,tax_year)),firstSeen);
		SELF.lastSeen  :=IF(EXISTS(seenDates),MAX(lastSeen ,MAX(seenDates,tax_year)),lastSeen);

		SELF:=L; // L.deed_records
		SELF:=R; // R.assessment_records
		SELF:=[];
	END;

	ds_prop_join_recs:=JOIN(deed_recs,assessment_recs,
		LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did AND LEFT.property_id=RIGHT.property_id,
		setDeedsAssessments(LEFT,RIGHT),FULL OUTER,LIMIT(0));

	/************************************************/

	// DEDUP PROPERTIES BY CO-OWNER

	propLinkAcctRec:=RECORD
		HomesteadExemptionV2_Services.Layouts.workRecSlim.link_clientid;
		DATASET(HomesteadExemptionV2_Services.Layouts.propertyRec) property_records;
	END;

	propLinkAcctRec removeJointOwnedProperties (propLinkAcctRec L,DATASET(HomesteadExemptionV2_Services.Layouts.propertyRec) R) := TRANSFORM
		isOwnerPropDids:=PROJECT(R(iscurrentowner),TRANSFORM({STRING property_id,UNSIGNED6 did},SELF:=LEFT));
		dedupProperties:=DEDUP(SORT(R,property_ID,acctno),property_ID);
		SELF.property_records:=PROJECT(dedupProperties,
			TRANSFORM(HomesteadExemptionV2_Services.Layouts.propertyRec,
				ownerDids:=PROJECT(isOwnerPropDids(property_id=LEFT.property_id),TRANSFORM(HomesteadExemptionV2_Services.Layouts.didRec,SELF:=LEFT));
				SELF.dids:=DEDUP(SORT(LEFT.dids+ownerDids,did,-isbdid),did),
				SELF:=LEFT));
		SELF:=L;
	END;

	prop_link_parent_recs:=DEDUP(PROJECT(ds_prop_join_recs,TRANSFORM(propLinkAcctRec,SELF:=LEFT,SELF:=[])),ALL);

	prop_link_acct_recs:=DENORMALIZE(prop_link_parent_recs,ds_prop_join_recs,
		LEFT.link_clientid=RIGHT.link_clientid,GROUP,removeJointOwnedProperties(LEFT,ROWS(RIGHT)));

	ds_prop_recs:=NORMALIZE(prop_link_acct_recs,LEFT.property_records,
		TRANSFORM(HomesteadExemptionV2_Services.Layouts.propertyRec,SELF:=RIGHT));

	/************************************************/

	// SEARCH OTHER DATASETS WHERE PROPERTY RANK IS <= 30

	ds_propSrchRecs:=PROJECT(ds_prop_recs(property_rank<=HomesteadExemptionV2_Services.Constants.HAS_EXMPTNS),TRANSFORM(HomesteadExemptionV2_Services.Layouts.propIdRec,SELF:=LEFT));

	/************************************************/

	// APPEND FORECLOSURES

	HomesteadExemptionV2_Services.Layouts.propertyRec appendForeclosures
		(HomesteadExemptionV2_Services.Layouts.propertyRec L,DATASET(HomesteadExemptionV2_Services.Layouts.propForeclosureRec) R) := TRANSFORM
			SELF.foreclosure_records:=PROJECT(R.foreclosures,TRANSFORM(HomesteadExemptionV2_Services.Layouts.foreclosureRec,SELF:=LEFT));
			SELF:=L;
	END;

	foreclosure_recs:=HomesteadExemptionV2_Services.fn_getForeclosures(ds_propSrchRecs);

	ds_with_foreclosures:=DENORMALIZE(ds_prop_recs,foreclosure_recs,
		LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did AND LEFT.property_id=RIGHT.property_id,
		GROUP,appendForeclosures(LEFT,ROWS(RIGHT)));

	/************************************************/

	// APPEND ADDITIONAL PERSONS

	HomesteadExemptionV2_Services.Layouts.propertyRec appendAdditionalPersons
		(HomesteadExemptionV2_Services.Layouts.propertyRec L,DATASET(HomesteadExemptionV2_Services.Layouts.propAddlPerRec) R) := TRANSFORM
			SELF.additional_person_records:=PROJECT(R.additional_persons,TRANSFORM(HomesteadExemptionV2_Services.Layouts.addlPerRec,SELF:=LEFT));
			SELF:=L;
	END;

	additional_person_recs:=HomesteadExemptionV2_Services.fn_getAdditionalPersons(ds_propSrchRecs,in_mod);

	ds_with_additional_persons:=DENORMALIZE(ds_with_foreclosures,additional_person_recs,
		LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did AND LEFT.property_id=RIGHT.property_id,
		GROUP,appendAdditionalPersons(LEFT,ROWS(RIGHT)));

	/************************************************/

	// APPEND RELATIVES

	HomesteadExemptionV2_Services.Layouts.propertyRec appendRelatives
		(HomesteadExemptionV2_Services.Layouts.propertyRec L,DATASET(HomesteadExemptionV2_Services.Layouts.propRelativeRec) R) := TRANSFORM
			SELF.relative_records:=PROJECT(R.relatives,TRANSFORM(HomesteadExemptionV2_Services.Layouts.relativeRec,SELF:=LEFT));
			SELF:=L;
	END;

	relative_recs:=HomesteadExemptionV2_Services.fn_getRelatives(ds_propSrchRecs,in_mod);

	ds_with_relatives:=DENORMALIZE(ds_with_additional_persons,relative_recs,
		LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did AND LEFT.property_id=RIGHT.property_id,
		GROUP,appendRelatives(LEFT,ROWS(RIGHT)));

	/************************************************/

	// APPEND VEHICLES

	HomesteadExemptionV2_Services.Layouts.propertyRec appendVehicles
		(HomesteadExemptionV2_Services.Layouts.propertyRec L,DATASET(HomesteadExemptionV2_Services.Layouts.propVehicleRec) R) := TRANSFORM
			SELF.vehicle_records:=PROJECT(R.vehicles,TRANSFORM(HomesteadExemptionV2_Services.Layouts.vehicleRec,SELF:=LEFT));
			SELF:=L;
	END;

	vehicle_recs:=HomesteadExemptionV2_Services.fn_getVehicles(ds_propSrchRecs,in_mod);

	ds_with_vehicles:=DENORMALIZE(ds_with_relatives,vehicle_recs,
		LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did AND LEFT.property_id=RIGHT.property_id,
		GROUP,appendVehicles(LEFT,ROWS(RIGHT)));

	/************************************************/

	// APPEND DRIVERS

	HomesteadExemptionV2_Services.Layouts.propertyRec appendDrivers
		(HomesteadExemptionV2_Services.Layouts.propertyRec L,DATASET(HomesteadExemptionV2_Services.Layouts.propDriverRec) R) := TRANSFORM
			SELF.driver_records:=PROJECT(R.drivers,TRANSFORM(HomesteadExemptionV2_Services.Layouts.driverRec,SELF:=LEFT));
			SELF:=L;
	END;

	driver_recs:=HomesteadExemptionV2_Services.fn_getDrivers(ds_propSrchRecs);

	ds_with_drivers:=DENORMALIZE(ds_with_vehicles,driver_recs,
		LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did AND LEFT.property_id=RIGHT.property_id,
		GROUP,appendDrivers(LEFT,ROWS(RIGHT)));

	/************************************************/

	// APPEND VOTERS

	HomesteadExemptionV2_Services.Layouts.propertyRec appendVoters
		(HomesteadExemptionV2_Services.Layouts.propertyRec L,DATASET(HomesteadExemptionV2_Services.Layouts.propVoterRec) R) := TRANSFORM
			SELF.voter_records:=PROJECT(R.voters,TRANSFORM(HomesteadExemptionV2_Services.Layouts.voterRec,SELF:=LEFT));
			SELF:=L;
	END;

	voter_recs:=HomesteadExemptionV2_Services.fn_getVoters(ds_propSrchRecs);

	ds_with_voters:=DENORMALIZE(ds_with_drivers,voter_recs,
		LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did AND LEFT.property_id=RIGHT.property_id,
		GROUP,appendVoters(LEFT,ROWS(RIGHT)));

	/************************************************/

	// APPEND OWNERSHIP TO WORK RECORD

	ds_not_owner:=PROJECT(ds_with_voters(NOT isCurrentOwner AND isInputAddress),HomesteadExemptionV2_Services.Layouts.inputNotOwnerRec);
	ds_ownership:=HomesteadExemptionV2_Services.fn_getOwnership(ds_not_owner,in_mod);

	ds_work_ownership:=JOIN(ds_work_in,ds_ownership,
		LEFT.acctno=RIGHT.acctno AND LEFT.did=RIGHT.did,
		TRANSFORM(HomesteadExemptionV2_Services.Layouts.workRec,
			SELF.Ownership_Record.acctno        :=RIGHT.acctno,
			SELF.Ownership_Record.did           :=RIGHT.did,
			SELF.Ownership_Record.ln_fares_id   :=RIGHT.ln_fares_id,
			SELF.Ownership_Record.owner_did     :=RIGHT.owner_did,
			SELF.Ownership_Record.owner_bdid    :=RIGHT.owner_bdid,
			SELF.Ownership_Record.name_first    :=RIGHT.name_first,
			SELF.Ownership_Record.name_middle   :=RIGHT.name_middle,
			SELF.Ownership_Record.name_last     :=RIGHT.name_last,
			SELF.Ownership_Record.name_suffix   :=RIGHT.name_suffix,
			SELF.Ownership_Record.company_name  :=RIGHT.company_name,
			SELF.Ownership_Record.sale_date     :=RIGHT.sale_date,
			SELF.Ownership_Record.contract_date :=RIGHT.contract_date,
			SELF.Ownership_Record.isCurrentOwner:=RIGHT.isCurrentOwner,
			SELF:=LEFT),
		LEFT OUTER,LIMIT(0),KEEP(1));

	/************************************************/

	// APPEND PROPERTIES TO WORK RECORD

	HomesteadExemptionV2_Services.Layouts.workRec denormPropRecs(ds_work_in L,DATASET(HomesteadExemptionV2_Services.Layouts.propertyRec) R) := TRANSFORM
		// RESERVE _1 BATCH OUTPUT FIELDS FOR INPUT ADDRESS ONLY
		HomesteadExemptionV2_Services.Layouts.propertyRec inputAddrProp() := TRANSFORM
			SELF.acctno:=L.acctno;
			SELF.did:=L.did;
			SELF.property_id:='INPUT ADDR PLACE HOLDER RECORD';
			SELF.property_rank:=HomesteadExemptionV2_Services.Constants.INPUT_ADDR;
			SELF.sortby_date:=L.tax_year+'0000';
			SELF:=[];
		END;
		hasInputAddrProp:=EXISTS(R(property_rank=HomesteadExemptionV2_Services.Constants.INPUT_ADDR));
		InputPropertyIfExists:=IF(hasInputAddrProp,DATASET([],HomesteadExemptionV2_Services.Layouts.propertyRec),DATASET([inputAddrProp()]));
		SELF.property_records:=PROJECT(InputPropertyIfExists+R,TRANSFORM(HomesteadExemptionV2_Services.Layouts.propertyRec,SELF:=LEFT));
		SELF:=L;
	END;

	ds_work_with_prop:=DENORMALIZE(ds_work_ownership,ds_with_voters,
		LEFT.acctno=RIGHT.acctno,GROUP,denormPropRecs(LEFT,ROWS(RIGHT)));

	// OUTPUT(ds_work_in,NAMED('ds_work_in'));

	// OUTPUT(COUNT(raw_fid_recs),NAMED('cnt_raw_fid_recs'));
	// OUTPUT(COUNT(dup_fid_recs),NAMED('cnt_dup_fid_recs'));
	// OUTPUT(COUNT(srch_fid_recs),NAMED('cnt_srch_fid_recs'));
	// OUTPUT(COUNT(prty_fid_recs),NAMED('cnt_prty_fid_recs'));
	// OUTPUT(srch_fid_recs,NAMED('srch_fid_recs'));

	// OUTPUT(SORT(deed_recs,acctno,did,property_id),NAMED('deed_recs'));
	// OUTPUT(SORT(assessment_recs,acctno,did,property_id),NAMED('assessment_recs'));

	// OUTPUT(ds_prop_join_recs,NAMED('ds_prop_join_recs'));

	// OUTPUT(prop_link_parent_recs,NAMED('prop_link_parent_recs'));
	// OUTPUT(prop_link_acct_recs,NAMED('prop_link_acct_recs'));

	// OUTPUT(ds_prop_recs,NAMED('ds_prop_recs'));

	// OUTPUT(ds_not_owner,NAMED('ds_not_owner'));
	// OUTPUT(ds_ownership,NAMED('ds_ownership'));

	// OUTPUT(ds_propSrchRecs,NAMED('ds_propSrchRecs'));

	// OUTPUT(foreclosure_recs,NAMED('foreclosure_recs'));
	// OUTPUT(ds_with_foreclosures,NAMED('ds_with_foreclosures'));

	// OUTPUT(additional_person_recs,NAMED('additional_person_recs'));
	// OUTPUT(ds_with_additional_persons,NAMED('ds_with_additional_persons'));

	// OUTPUT(relative_recs,NAMED('relative_recs'));
	// OUTPUT(ds_with_relatives,NAMED('ds_with_relatives'));

	// OUTPUT(vehicle_recs,NAMED('vehicle_recs'));
	// OUTPUT(ds_with_vehicles,NAMED('ds_with_vehicles'));

	// OUTPUT(driver_recs,NAMED('driver_recs'));
	// OUTPUT(ds_with_drivers,NAMED('ds_with_drivers'));

	// OUTPUT(voter_recs,NAMED('voter_recs'));
	// OUTPUT(ds_with_voters,NAMED('ds_with_voters'));

	// OUTPUT(ds_work_with_prop,NAMED('ds_work_with_prop'));

	RETURN ds_work_with_prop;
END;

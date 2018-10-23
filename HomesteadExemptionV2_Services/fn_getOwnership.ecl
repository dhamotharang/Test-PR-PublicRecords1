IMPORT LN_PropertyV2;

EXPORT fn_getOwnership(DATASET(HomesteadExemptionV2_Services.Layouts.inputNotOwnerRec) ds_not_owner_recs,
				HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

	// CURRENT OWNER 1 DID/BDID AND FID BY PROPERTY ADDRESS
	ownershipAddrRecs:=JOIN(ds_not_owner_recs,LN_PropertyV2.key_ownership.addr(),
		KEYED(LEFT.prim_range=RIGHT.prim_range) AND
		KEYED(LEFT.predir=RIGHT.predir) AND
		KEYED(LEFT.prim_name=RIGHT.prim_name) AND
		KEYED(LEFT.addr_suffix=RIGHT.addr_suffix) AND
		KEYED(LEFT.postdir=RIGHT.postdir) AND
		KEYED(LEFT.sec_range=RIGHT.sec_range) AND
		KEYED(LEFT.z5=RIGHT.zip5),
		TRANSFORM(HomesteadExemptionV2_Services.Layouts.ownershipRec,
			latestFID:=SORT(RIGHT.hist,-dt_seen)[1].ln_fares_id;
			dids:=DEDUP(NORMALIZE(RIGHT.hist(ln_fares_id=latestFID),LEFT.owners,TRANSFORM({UNSIGNED6 did,BOOLEAN isbdid},SELF:=RIGHT)),ALL);
			SELF.ln_fares_id:=latestFID,
			SELF.owner_did:=dids(NOT isbdid)[1].did,
			SELF.owner_bdid:=dids(isbdid)[1].did,
			SELF.isCurrentOwner:=EXISTS(dids(did=LEFT.did)),
			SELF:=LEFT,SELF:=[]),
		LEFT OUTER,LIMIT(0),KEEP(1));

	// BUSINESS NAMES
	ownershipBusinessRecs:=JOIN(ownershipAddrRecs,LN_PropertyV2.key_search_fid(),
		KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id) AND
		LEFT.owner_bdid=RIGHT.bdid AND RIGHT.source_code_2='P',
		TRANSFORM(HomesteadExemptionV2_Services.Layouts.ownershipRec,
			SELF.company_name:=RIGHT.cname,
			SELF:=LEFT),
		LEFT OUTER,LIMIT(0),KEEP(1));

	// OWNER NAMES
	ownershipNameRecs:=JOIN(ownershipBusinessRecs,LN_PropertyV2.key_search_fid(),
		KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id) AND
		LEFT.owner_did=RIGHT.did AND RIGHT.source_code_2='P',
		TRANSFORM(HomesteadExemptionV2_Services.Layouts.ownershipRec,
			SELF.name_first :=RIGHT.fname,
			SELF.name_middle:=RIGHT.mname,
			SELF.name_last  :=RIGHT.lname,
			SELF.name_suffix:=RIGHT.name_suffix,
			SELF:=LEFT),
		LEFT OUTER,LIMIT(0),KEEP(1));

	// SALE DATE
	ownershipSaleDateRecs:=JOIN(ownershipNameRecs,LN_PropertyV2.key_assessor_fid(),
		KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id),
		TRANSFORM(HomesteadExemptionV2_Services.Layouts.ownershipRec,
			SELF.sale_date:=RIGHT.sale_date,
			SELF:=LEFT),
		LEFT OUTER,LIMIT(0),KEEP(1));

	// CONTRACT DATE
	ownershipContractDateRecs:=JOIN(ownershipSaleDateRecs,LN_PropertyV2.key_deed_fid(),
		KEYED(LEFT.ln_fares_id=RIGHT.ln_fares_id),
		TRANSFORM(HomesteadExemptionV2_Services.Layouts.ownershipRec,
			SELF.contract_date:=RIGHT.contract_date,
			SELF:=LEFT),
		LEFT OUTER,LIMIT(0),KEEP(1));

	// OUTPUT(ownershipAddrRecs,NAMED('ownershipAddrRecs'));
	// OUTPUT(ownershipBusinessRecs,NAMED('ownershipBusinessRecs'));
	// OUTPUT(ownershipNameRecs,NAMED('ownershipNameRecs'));
	// OUTPUT(ownershipSaleDateRecs,NAMED('ownershipSaleDateRecs'));
	// OUTPUT(ownershipContractDateRecs,NAMED('ownershipContractDateRecs'));

	RETURN ownershipContractDateRecs;
END;

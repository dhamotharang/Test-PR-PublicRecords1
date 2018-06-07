IMPORT DidVille, LN_PropertyV2, ut;

EXPORT fn_getOwnership(DATASET(HomesteadExemptionV2_Services.Layouts.inputNotOwnerRec) ds_not_owner_recs,
				HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

	// CURRENT OWNER 1 DID AND FID BY PROPERTY ADDRESS
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
			dids:=DEDUP(NORMALIZE(RIGHT.hist(ln_fares_id=latestFID),LEFT.owners,TRANSFORM({UNSIGNED6 did},SELF:=RIGHT)),ALL);
			SELF.ln_fares_id:=latestFID,
			SELF.owner_did:=dids[1].did,
			SELF.isCurrentOwner:=EXISTS(dids(did=LEFT.did)),
			SELF:=LEFT,SELF:=[]),
		LEFT OUTER,LIMIT(0),KEEP(1));

	// OWNER NAMES
	ds_in:=PROJECT(ownershipAddrRecs,TRANSFORM(DidVille.Layout_Did_OutBatch,SELF.did:=LEFT.owner_did,SELF:=[]));
	didville.MAC_BestAppend(ds_in,'BEST_NAME','BEST_NAME',0,ut.PermissionTools.glb.restrictRNA(in_mod.GLBPurpose),
		ds_best_names,FALSE,in_mod.DataRestrictionMask,,,,,'',IndustryClass_val:=in_mod.industryclass);
	ownershipNameRecs:=JOIN(ownershipAddrRecs,ds_best_names,
		LEFT.owner_did=RIGHT.did,
		TRANSFORM(HomesteadExemptionV2_Services.Layouts.ownershipRec,
			SELF.name_first :=RIGHT.best_fname,
			SELF.name_middle:=RIGHT.best_mname,
			SELF.name_last  :=RIGHT.best_lname,
			SELF.name_suffix:=RIGHT.best_name_suffix,
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
	// OUTPUT(ownershipNameRecs,NAMED('ownershipNameRecs'));
	// OUTPUT(ownershipSaleDateRecs,NAMED('ownershipSaleDateRecs'));
	// OUTPUT(ownershipContractDateRecs,NAMED('ownershipContractDateRecs'));

	RETURN ownershipContractDateRecs;
END;

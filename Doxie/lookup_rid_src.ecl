import header, dx_header, ut, Suppress, STD;

export lookup_rid_src(DATASET(doxie.Layout_Rollup.RidRecDid) inrecs, doxie.IDataAccess mod_access, boolean skipListings=false) := FUNCTION

	// fake rids have the 2 char src code embedded
	boolean isFake(string rid) := (STD.str.FilterOut(rid,'0123456789') != '');

	// Source Doc info
	key_rid_src := dx_header.key_rid_SrcID( , false, false);
	key_qhri_src := dx_header.key_rid_SrcID( , true, false);

	RidRec_layout_Sids:= RECORD
		doxie.Layout_Rollup.RidRecDid;
		UNSIGNED4 global_sid;
		UNSIGNED8 record_sid;
	END;

	RidRec_layout_Sids getSrcInfo(inrecs l, key_rid_src r) := TRANSFORM
		fakeRid := isFake(l.r.rid);
		SELF.r.src := if(r.uid = 0 and ~fakeRid, 'FI', l.r.src);
		SELF.r.rid := l.r.rid;
		SELF.global_sid := R.global_sid;
		SELF.record_sid := R.record_sid;
		SELF := l;
	END;

	srcHdrRids := join(inrecs((unsigned6)r.rid < Header.constants.QH_start_rid),
                      key_rid_src,
                      keyed((unsigned6)LEFT.r.rid = RIGHT.rid),
                      getSrcInfo(LEFT,RIGHT), LEFT OUTER, KEEP(ut.limits.HEADER_PER_DID));
  
  srcQHRids := join(inrecs((unsigned6)r.rid >= Header.constants.QH_start_rid),
                    key_qhri_src,
                    keyed((unsigned6)LEFT.r.rid = RIGHT.rid),
                    getSrcInfo(LEFT,RIGHT), LEFT OUTER, KEEP(ut.limits.HEADER_PER_DID));
  
  srcRids_all := srcHdrRids + srcQHRids;
  
  srcRids_flagged := Suppress.MAC_FlagSuppressedSource(srcRids_all, mod_access, did);

  srcRids := PROJECT(srcRids_flagged, TRANSFORM(doxie.Layout_Rollup.RidRecDid,
                                                fakeRid := isFake(LEFT.r.rid);
                                                SELF.r.src := if(LEFT.is_suppressed AND ~fakeRid, 'FI', LEFT.r.src);
                                                SELF:= LEFT));
  
	doxie.Layout_Rollup.RidRecDid getDocCnts(doxie.Layout_Rollup.RidRecDid L,doxie.Layout_Rollup.RidRecDid R) := TRANSFORM
		// don't accumulate counts for fakeRids
		SELF.r.docCnt := IF(isFake(R.r.rid), L.r.docCnt, L.r.docCnt + 1);
		SELF := L;
	END;

  doxie.Layout_Rollup.RidRecDid makeListingRids(inrecs L) := TRANSFORM
		SELF.r.rid := L.did + 'PH' + L.listed_phone;
		SELF.r.src := 'PH';
		SELF := L;
	END;
	
  // and make fake rids for listings, if applicable
	listingRids := PROJECT(inrecs(listed_phone <> ''), makeListingRids(LEFT));
	
  allRids := if(skipListings, srcrids, srcRids + listingRids);
	
	allRidsSorted := group(sort(allRids, did, r.rid), did);
	srcRidsRolled := rollup(allRidsSorted,getDocCnts(LEFT,RIGHT),r.rid);
	// ensure these are within the limit for the RID dataset
	srcRidsFinal := dedup(srcRidsRolled, true, KEEP(ut.limits.HEADER_PER_DID));
	RETURN ungroup(srcRidsFinal);
END;

IMPORT doxie, DayBatchEDA, didville, AddrBest;

EXPORT AddressCorrection_BatchService_Records(dataset($.Layouts_Batch.InAddrRecord) inputData,
																							doxie.IDataAccess mod_access) := FUNCTION

	preferred := PROJECT(inputData,Transforms.assignPreferred(LEFT));
	inputNorm := NORMALIZE(preferred,3,Transforms.normalizeInput(LEFT,COUNTER));

	gongRecs  := DayBatchEDA.Fetch_Batch_Gong_Full(PROJECT(inputNorm,Transforms.assignDayBatchEDA(LEFT)));
	gongJoin  := JOIN(inputNorm,gongRecs,LEFT.AcctNo=RIGHT.AcctNo,Transforms.gongMatch(LEFT,RIGHT),LEFT OUTER);
	gongMatch := gongJoin(MatchType!='N');
	gongNoHit := gongJoin(AcctNo NOT IN SET(gongMatch,AcctNo));

	didRecs   := didville.did_service_common_function(PROJECT(gongNoHit,Transforms.assignDidVille(LEFT)), '', '', '', TRUE,,,,,,,,,,,,mod_access.application_type,IndustryClass_val := mod_access.industry_class);

	bestRecs  := AddrBest.BestAddr_common(PROJECT(UNGROUP(didRecs),Transforms.assignBestAddr(LEFT)),
    mod_access,
    Constants.DEFAULT_YYMM_VALUE,
    TRUE,
    90);

	// need to get this back into the same layout as it was before minus the matchcode fields
	tmpBestRecs := PROJECT(bestRecs, TRANSFORM(AddrBest.Layout_BestAddr.Service_out, SELF := LEFT));

	bestFilt  := tmpBestRecs(Exists(srcs(src IN Constants.HdrSrcs)));

	bestJoin  := SORT(JOIN(gongNoHit,bestFilt,LEFT.AcctNo=RIGHT.AcctNo,Transforms.assignBooleans(LEFT,RIGHT)),AcctNo,did,-addr_dt_last_seen);

	bestRoll  := ROLLUP(bestJoin,LEFT.AcctNo=RIGHT.AcctNo and LEFT.did=Right.did,Transforms.rollupRecs(LEFT,RIGHT));
	bestFill  := JOIN(bestFilt,bestRoll,LEFT.AcctNo=RIGHT.AcctNo and LEFT.did=Right.did,Transforms.backFillRecs(LEFT,RIGHT));

	bestMatch := JOIN(gongNoHit,bestFill,LEFT.AcctNo=RIGHT.AcctNo,Transforms.bestAddrMatch(LEFT,RIGHT));
	matchRecs := DEDUP(SORT(gongMatch+bestMatch,AcctNo,-DateLastSeen,MatchType,seq),AcctNo);
	results   := JOIN(matchRecs,inputData,LEFT.AcctNo=RIGHT.AcctNo,Transforms.noAddrHits(LEFT,RIGHT),RIGHT OUTER);

	RETURN results;

END;

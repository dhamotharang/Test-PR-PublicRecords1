import $,BairRx_Common;

EXPORT SlimReportRecords(BairRx_Common.IParam.SearchParam inMod, integer max_records, boolean is_raids) := function
	
	MC := inMod.ModeContext[1];
	SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
	CA := inMod.platitude;
	CO := inMod.plongitude;		
	
	dIDSIn 	:= PROJECT(inMod.EIDs, TRANSFORM(BairRx_Common.Layouts.SearchRec,
		_eid := BairRx_Common.EID.Clean(LEFT.value);
		_stamp := BairRx_Common.EID.GetStamp(LEFT.value);
		SELF.etype := IF(BairRx_Common.EID.IsEvent(_eid),BairRx_Common.EID.Type.EVE, SKIP),	
		SELF.eid := _eid,
		SELF.stamp := _stamp,
		SELF := []));
											
	dIDS := CHOOSEN(DEDUP(SORT(dIDSIn, eid), eid), max_records);
	dDeltaRecs := $.GetPayload.SlimSearchView(dIDS, SC.fid, TRUE);		
	dIDSMain := JOIN(dIDS,dDeltaRecs,LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_Common.Layouts.SearchRec,SELF := LEFT),LEFT ONLY);
	dMainRecs := $.GetPayload.SlimSearchView(dIDSMain, SC.fid, FALSE);		
	dRecs := dDeltaRecs + dMainRecs;	
	
	dGACCleanRecs := BairRx_Common.GroupAccessControl.Clean(dRecs, inMod.AgencyORI, data_provider_ori);		
	dCleanRecs := IF(is_raids, dRecs(raids_ok), dGACCleanRecs);
	dRecsOut := PROJECT(dCleanRecs, $.ESPOut.SlimSearchView(LEFT, CA, CO));	
	
	$.Layouts.SlimSearchResults xtResults() := TRANSFORM
		SELF.match_count := COUNT(dRecsOut),
		SELF.records := dRecsOut;
	END;
	dResults := DATASET([xtResults()]);				
	
	RETURN dResults;
	
END;	
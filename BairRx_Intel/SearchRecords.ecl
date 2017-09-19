import $,BairRx_Common,BairRx_Intel,iesp;

EXPORT SearchRecords(BairRx_Common.IParam.SearchParam inMod, integer max_records) := function
	
	MC := inMod.ModeContext[1];
	SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
	MaxSlimSort := MAX(max_records, BairRx_Common.Constants.MAX_SLIM_SORT);
	
	// Get all matching IDs
	dSearchIDs := $.GetIDs(inMod);	
	
	// Apply group access restrictions
	dCleanIDs := BairRx_Common.GroupAccessControl.Clean(dSearchIDs, inMod.AgencyORI);
	
	// No search needed, if EIDs are being provided	
	dIDSIn 	:= CHOOSEN(DEDUP(SORT(PROJECT(inMod.EIDs, TRANSFORM(BairRx_Common.Layouts.SearchRec,
									_eid := BairRx_Common.EID.Clean(LEFT.value);		
									_stamp := BairRx_Common.EID.GetStamp(LEFT.value);
									SELF.etype	:= IF(BairRx_Common.EID.IsIntel(_eid),BairRx_Common.EID.Type.INT, skip),	
									SELF.eid 		:= _eid,
									SELF.stamp 	:= _stamp,																				
									SELF := [])), eid), eid), MaxSlimSort);
	
	IsSearchByEID := EXISTS(dIDsIn) and ~MC.filter_search; // do we really need to check filter search (?)
			
	// Slim sort based on input sorting criteria to select top records to return 
	// Note: If EIDs have been provided, we don't know which ones are deltas so we will try to pull deltas for all.
	dDeltaPickIDs := IF(IsSearchByEID, dIDSIn, BairRx_Common.SortingClause.SlimTOPN(dCleanIDs(delta), SC, MaxSlimSort)); // 	
	dDeltaPickRecs := $.GetPayload.SearchView(dDeltaPickIDs, SC.fid, TRUE);	
	
	dMainIDsIn := JOIN(dIDSIn, dDeltaPickRecs, LEFT.eid = RIGHT.eid, TRANSFORM(LEFT), LEFT ONLY);
	dMainPickIDs := IF(IsSearchByEID, dMainIDsIn, BairRx_Common.SortingClause.SlimTOPN(dCleanIDs(~delta), SC, MaxSlimSort));
	dMainPickRecs := $.GetPayload.SearchView(dMainPickIDs, SC.fid, FALSE);	
	
	dPickRecs := dMainPickRecs + dDeltaPickRecs;
	dCleanPickRecs := BairRx_Common.GroupAccessControl.Clean(dPickRecs, inMod.AgencyORI, data_provider_ori); 
	dRecs := IF(IsSearchByEID, dCleanPickRecs, dPickRecs); // must clean after fetching payload if search by eid

	// And sort based on the actual value of the sorting field
	dPickRecsSorted := BairRx_Common.SortingClause.CustomSort(dRecs, SC);
		
	dRecsOut := PROJECT(CHOOSEN(dPickRecsSorted, max_records), $.ESPOut.SearchView(LEFT));
	
	$.Layouts.SearchResults xtResults() := transform
		SELF.match_count := COUNT(IF(IsSearchByEID, dIDSIn,  dCleanIDs)),
		SELF.records := dRecsOut;
	END;
	dResults := DATASET([xtResults()]);			

	BairRx_Common.GetGeoHash(inMod).Debug();
	return dResults;		
	
end;
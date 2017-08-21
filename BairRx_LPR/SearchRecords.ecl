import BairRx_Common, BairRx_LPR, iesp;

EXPORT SearchRecords(BairRx_Common.IParam.SearchParam inMod, integer max_records) := function
	
	MC := inMod.ModeContext[1];
	DR := MC.data_relation;
	SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
	CA := inMod.platitude;
	CO := inMod.plongitude;	
	MaxSlimSort := MAX(max_records, BairRx_Common.Constants.MAX_SLIM_SORT); 
	
	// Get all matching IDs
	dSearchIDs := BairRx_LPR.GetIDs(inMod);		

	// Apply group access restrictions
	dCleanIDs := BairRx_Common.GroupAccessControl.Clean(dSearchIDs, inMod.AgencyORI);
	
	dMainIDs := dCleanIDs(~delta);
	dDeltaIDs := dCleanIDs(delta);
		
	// Slim sort based on input sorting criteria to select top records to return 
	dPickIDs := BairRx_Common.SortingClause.SlimTOPN(dMainIDs, SC, MaxSlimSort);
	dDeltaPickIDs := BairRx_Common.SortingClause.SlimTOPN(dDeltaIDs, SC, MaxSlimSort);	

	// Now go get full payload for each EID
	dPickRecs := BairRx_LPR.GetPayload.SearchView(dPickIDs, SC.fid, FALSE);	
	dDeltaPickRecs := IF(EXISTS(dDeltaIDs), BairRx_LPR.GetPayload.SearchView(dDeltaPickIDs, SC.fid, TRUE), 
		DATASET([], BairRx_LPR.Layouts.SearchPayload));	
	dPicks := dPickRecs + IF(EXISTS(dDeltaIDs), dDeltaPickRecs);
	
	// And sort based on the actual value of the sorting field
	dPickRecsSorted := BairRx_Common.SortingClause.CustomSort(dPicks, SC);
	
	dRecsOut := PROJECT(CHOOSEN(dPickRecsSorted, max_records), BairRx_LPR.ESPOut(LEFT, TRUE, CA, CO));
	
	BairRx_LPR.Layouts.SearchResults xtResults() := transform
		self.match_count := count(dCleanIDs),
		self.records := dRecsOut;
	end;
	dResults := dataset([xtResults()]);			
	
	BairRx_Common.GetGeoHash(inMod).Debug();
	return dResults;	
	
end;
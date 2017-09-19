import BairRx_Common, BairRx_Spotter, iesp;

EXPORT SearchRecords(BairRx_Common.IParam.SearchParam inMod, integer max_records) := function

	MC := inMod.ModeContext[1];
	DR := MC.data_relation;
	SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
	CA := inMod.platitude;
	CO := inMod.plongitude;	
	MaxSlimSort := MAX(max_records, BairRx_Common.Constants.MAX_SLIM_SORT);
	
	// Get all matching IDs.
	dSearchIDs := BairRx_Spotter.GetIDs(inMod);	
	
	// Apply group access restrictions. Note: only applicable if we're running a search. 
	dCleanIDs := BairRx_Common.GroupAccessControl.Clean(dSearchIDs, inMod.AgencyORI);
	dMainIDs 	:= dCleanIDs(~delta);
	dDeltaIDs := dCleanIDs(delta);
	
	// Slim sort based on input sorting criteria to select top records to return
	dPickIDs := BairRx_Common.SortingClause.SlimTOPN(dMainIDs, SC, MaxSlimSort);
	dDeltaPickIDs := BairRx_Common.SortingClause.SlimTOPN(dDeltaIDs, SC, MaxSlimSort);	
	
	// Get payload for both main and delta IDs.
	dPickRecs := BairRx_Spotter.GetPayload.SearchView(dPickIDs+dDeltaPickIDs, SC.fid);	
	
	// Custom sort based on the actual value of the sorting field.
	dPickRecsSorted := BairRx_Common.SortingClause.CustomSort(dPickRecs, SC);
	
	dRecsOut := PROJECT(CHOOSEN(dPickRecsSorted, max_records), BairRx_Spotter.ESPOut(LEFT));
	
	BairRx_Spotter.Layouts.SearchResults xtResults() := transform
		self.match_count := count(dCleanIDs),
		self.records := dRecsOut;
	end;
	dResults := dataset([xtResults()]);			

	BairRx_Common.GetGeoHash(inMod).Debug();
	return dResults;		
	
end;
import BairRx_Common, iesp;

EXPORT SearchRecords(BairRx_Common.IParam.SearchParam inMod, integer max_records, boolean isRaids = false, boolean skipOffenderDates = true) := function
	
	MC := inMod.ModeContext[1];
	DR := MC.data_relation;
	SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
	CA := inMod.platitude;
	CO := inMod.plongitude;	
	MaxSlimSort := MAX(max_records, BairRx_Common.Constants.MAX_SLIM_SORT);
		
	dSearchIDs := BairRx_Offender.GetIDs(inMod,isRaids, skipOffenderDates);	
	
	// Apply group access restrictions - not needed if running a 'raids' search
	dCleanIDs := IF(isRaids, dSearchIDs, BairRx_Common.GroupAccessControl.Clean(dSearchIDs, inMod.AgencyORI));	
	dMainIDs 	:= dCleanIDs(~delta);
	dDeltaIDs := dCleanIDs(delta);
			
	// Slim sort based on input sorting criteria to select top records to return 
	dPickIDs := BairRx_Common.SortingClause.SlimTOPN(dMainIDs, SC, MaxSlimSort);
	dDeltaPickIDs := BairRx_Common.SortingClause.SlimTOPN(dDeltaIDs, SC, MaxSlimSort);	

	// Now go get full payload for each EID
	dPickRecs := BairRx_Offender.GetPayload.SearchView(dPickIDs+IF(EXISTS(dDeltaIDs), dDeltaPickIDs), SC.fid);	
	
	// And sort based on the actual value of the sorting field
	dPickRecsSorted := BairRx_Common.SortingClause.CustomSort(dPickRecs, SC);
		
	dRecsOut := PROJECT(CHOOSEN(dPickRecsSorted, max_records), BairRx_Offender.ESPOut(LEFT, TRUE, CA, CO));	
	
	BairRx_Offender.Layouts.SearchResults xtResults() := transform
		self.match_count := count(dCleanIDs),
		self.records := dRecsOut;
	end;
	
	dResults := dataset([xtResults()]);			
	
	BairRx_Common.GetGeoHash(inMod).Debug();
	return dResults;			
	
end;
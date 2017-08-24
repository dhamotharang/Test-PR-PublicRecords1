import $, BairRx_Common, iesp;

EXPORT SearchRecords(BairRx_Common.IParam.SearchParam inMod, integer max_records) := function
	
	MC := inMod.ModeContext[1];
	DR := MC.data_relation;
	SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
	CA := inMod.platitude;
	CO := inMod.plongitude;	
	MaxSlimSort := MAX(max_records, BairRx_Common.Constants.MAX_SLIM_SORT); 
	
	// Get all matching IDs
	dSearchIDs := $.GetIDs(inMod);		
	
	// Apply group access restrictions
	dCleanIDs := BairRx_Common.GroupAccessControl.Clean(dSearchIDs, inMod.AgencyORI);
	
	// Delta and main IDs are mutually exclusive, as guaranteed by geo search.
	dMainIDs := dCleanIDs(etype=BairRx_Common.EID.Type.CRA, ~delta);						
	dDeltaIDs := dCleanIDs(etype=BairRx_Common.EID.Type.CRA, delta);	
	
	// Slim sort based on input sorting criteria to select top records to return 
	dMainPickIDs := BairRx_Common.SortingClause.SlimTOPN(dMainIDs, SC, MaxSlimSort);
	dDeltaPickIDs := BairRx_Common.SortingClause.SlimTOPN(dDeltaIDs, SC, MaxSlimSort);	
	
	// Now go get full payload for each EID
	dMainPickRecs := $.GetPayload.SearchView(dMainPickIDs, DR, SC.fid, false);	
	dDeltaPickRecs := IF(EXISTS(dDeltaIDs), $.GetPayload.SearchView(dDeltaPickIDs, DR, SC.fid, TRUE), 
		DATASET([], $.Layouts.SearchPayload));	
	
	// No search needed, if EIDs are being provided	
	dIDsIn 	:= PROJECT(inMod.EIDs, TRANSFORM(BairRx_Common.Layouts.SearchRec,
							_eid := BairRx_Common.EID.Clean(LEFT.value);		
							_stamp := BairRx_Common.EID.GetStamp(LEFT.value);
							SELF.etype	:= IF(BairRx_Common.EID.IsCrash(_eid),BairRx_Common.EID.Type.CRA, skip),	
							SELF.eid 		:= _eid,
							SELF.stamp 	:= _stamp,																				
							SELF := []));
	
	// If EIDs have been provided, need to hit both delta and main key.	
	dInDeltaPickRecs := $.GetPayload.SearchView(dIDsIn, DR, SC.fid, TRUE);	
	dMainIDsIn := JOIN(dIDsIn, dInDeltaPickRecs, LEFT.eid = RIGHT.eid, TRANSFORM(LEFT), LEFT ONLY);
	dInMainPickRecs := $.GetPayload.SearchView(dMainIDsIn, DR, SC.fid, FALSE);	
	dPickRecsIn := dInMainPickRecs+dInDeltaPickRecs; 		
	
	// Make sure GAC is applied in case of search by EID	
	dCleanPickRecsIn := BairRx_Common.GroupAccessControl.Clean(dPickRecsIn, inMod.AgencyORI, data_provider_ori);					
	
	// Pick the correct set of records depending on the type of search
	searchByID := exists(dIDsIn);		
	dPickRecs := IF(searchByID, dCleanPickRecsIn, dMainPickRecs+dDeltaPickRecs);		

	// ...and sort based on the actual value of the sorting field
	dPickRecsSorted := BairRx_Common.SortingClause.CustomSort(dPickRecs, SC);	
	
	dRecsOut := PROJECT(CHOOSEN(dPickRecsSorted, max_records), $.ESPOut.SearchView(LEFT));
	
	$.Layouts.SearchResults xtResults() := transform
		self.match_count := COUNT(DEDUP(SORT(IF(searchByID, dIDsIn, dCleanIDs), eid),eid)),
		self.records := dRecsOut;
	end;
	dResults := dataset([xtResults()]);		
	
	BairRx_Common.GetGeoHash(inMod).Debug();
	return dResults;		
		
end;
import $,BairRx_Common,iesp;

EXPORT SlimSearchRecords(BairRx_Common.IParam.SearchParam inMod, integer max_records, boolean is_raids) := FUNCTION

	MC := inMod.ModeContext[1];
	SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
	CA := inMod.platitude;
	CO := inMod.plongitude;	
	MaxSlimSort := MAX(max_records, BairRx_Common.Constants.MAX_SLIM_SORT); 
	AGF := BairRx_Common.AgencyFilter(MC.filters, inMod.AgencyDataOnly, inMod.AgencyORI);
	filterByAgency := AGF.IsActive();
	allowedORIs := AGF.GetAllowedSrcORI();
	
	GH := BairRx_Common.GetGeoHash(inMod, MC, filterByAgency, allowedORIs);	
	dSrchIDs := GH.GeoIDs(FALSE,is_raids);		
	
	// Apply group access restrictions, only if not raids
	dIDs := IF(is_raids, dSrchIDs, BairRx_Common.GroupAccessControl.Clean(dSrchIDs, inMod.AgencyORI));	
	dDeltaIDs := dIDs(delta); 
	
	// Slim sort based on input sorting criteria to select top records to return 
	dPickIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs(~delta), SC, MaxSlimSort);
	dDeltaPickIDs := BairRx_Common.SortingClause.SlimTOPN(dDeltaIDs, SC, MaxSlimSort);	
	
	// Now go get full payload for each EID
	dPickRecs := $.GetPayload.SlimSearchView(dPickIDs, SC.fid, FALSE);	
	dDeltaPickRecs := IF(EXISTS(dDeltaIDs), $.GetPayload.SlimSearchView(dDeltaPickIDs, SC.fid, TRUE), 
		DATASET([], $.Layouts.SlimSearchPayload));	
	
	// And sort based on the actual value of the sorting field
	dRecsToSort := dPickRecs+dDeltaPickRecs;
	dPickRecsSorted := BairRx_Common.SortingClause.CustomSort(dRecsToSort, SC);	
	dRecsOut := PROJECT(CHOOSEN(dPickRecsSorted, max_records), $.ESPOut.SlimSearchView(LEFT, CA, CO));
	
	$.Layouts.SlimSearchResults xtResults() := TRANSFORM
		SELF.match_count := COUNT(DEDUP(SORT(dIDs, eid),eid)),
		SELF.records := dRecsOut;
	END;
	dResults := DATASET([xtResults()]);			
		
	BairRx_Common.GetGeoHash(inMod).Debug();	
	RETURN dResults;	
	
END;
import BairRx_Common,iesp;

EXPORT IDSearchRecords(BairRx_Common.IParam.SearchParam inMod, boolean is_raids, integer max_records, boolean skipOffenderDates = true) := FUNCTION
	
	eid_download := TRUE;	
	dIDs := BairRx_MapIncident.GetIDs(inMod, is_raids, eid_download, skipOffenderDates); 	
	
	// Apply group access restrictions - not needed if running a raids search.
	dCleanIDs := IF(is_raids, dIDs, BairRx_Common.GroupAccessControl.Clean(dIDs, inMod.AgencyORI));	
	
	dRecsEVE := BairRx_MapIncident.IDModeSearch(dCleanIDs, inMod, BairRx_Common.Constants.Mode.EVE, max_records);	
	dRecsCFS := BairRx_MapIncident.IDModeSearch(dCleanIDs, inMod, BairRx_Common.Constants.Mode.CFS, max_records);	
	dRecsCRA := BairRx_MapIncident.IDModeSearch(dCleanIDs, inMod, BairRx_Common.Constants.Mode.CRA, max_records);	
	dRecsLPR := BairRx_MapIncident.IDModeSearch(dCleanIDs, inMod, BairRx_Common.Constants.Mode.LPR, max_records);	
	dRecsOFF := BairRx_MapIncident.IDModeSearch(dCleanIDs, inMod, BairRx_Common.Constants.Mode.OFF, max_records);	
	dRecsSPO := BairRx_MapIncident.IDModeSearch(dCleanIDs, inMod, BairRx_Common.Constants.Mode.SHO, max_records);	
	dRecsINT := BairRx_MapIncident.IDModeSearch(dCleanIDs, inMod, BairRx_Common.Constants.Mode.INT, max_records);	
	
	dTopRecs := BairRx_MapIncident.PickTopRecords(dRecsEVE, dRecsCFS, dRecsCRA, dRecsLPR, dRecsOFF, dRecsSPO, dRecsINT, max_records);	
	dRecsOut := PROJECT(dTopRecs, TRANSFORM(iesp.bair_incident.t_BAIRIncidentIDSearchRecord, SELF.EntityID := LEFT.eid));
		
	BairRx_MapIncident.Layouts.IDSearchResults xtResults() := transform
		self.match_count := COUNT(dCleanIDs),
		self.records := dRecsOut;
	end;
	dResults := dataset([xtResults()]);			
	
	BairRx_Common.GetGeoHash(inMod).Debug();
	return dResults;
	
end;
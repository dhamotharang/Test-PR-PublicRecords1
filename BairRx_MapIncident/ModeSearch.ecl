#warning('Deprecated. Replaced by BairRx_MapIncident.GetModeRecs')
import BairRx_Common, BairRx_Event, BairRx_CFS, BairRx_Crash, BairRx_Offender, BairRx_LPR, BairRx_Intel, BairRx_Spotter;

EXPORT ModeSearch(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, BairRx_Common.IParam.SearchParam inMod, string mode, integer max_records, boolean eid_download, boolean isRaids=FALSE, boolean inc_details=FALSE) := FUNCTION

	MC := inMod.ModeContext(mId=mode)[1]; 
	DR := MC.data_relation;
	SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
	CA := inMod.platitude;
	CO := inMod.plongitude;	
	DPID := inMod.DataProviderID;
	MaxSlimSort := MAX(max_records, BairRx_Common.Constants.MAX_SLIM_SORT); 
	boolean sort_by_distance := SC.sort_by_distance; 	
	dModeIDs := dIDs(eid[1..3]=mode);
	dDeltaIDs := dModeIDs(delta);	
	
	// Slim sort based on input sorting criteria to select top records to return 
	dPickIDs := BairRx_Common.SortingClause.SlimTOPN(dModeIDs(~delta), SC, MaxSlimSort);
	dDeltaPickIDs := BairRx_Common.SortingClause.SlimTOPN(dDeltaIDs, SC, MaxSlimSort);	
	dPickEIDs := BairRx_Common.SortingClause.SlimTOPN(dModeIDs, SC, MaxSlimSort);
	
	//	Only Events, CFS and LPR have delta payload keys. 
	dDeltaPickRecs := MAP(
		mode = BairRx_Common.Constants.Mode.EVE => BairRx_Event.GetPayload.MapView(dDeltaPickIDs, DR, SC.FID, DPID, TRUE, isRaids, inc_details),  
		mode = BairRx_Common.Constants.Mode.CFS => BairRx_CFS.GetPayload.MapView(dDeltaPickIDs, DR, SC.FID, TRUE, inc_details),  
		mode = BairRx_Common.Constants.Mode.CRA => BairRx_Crash.GetPayload.MapView(dDeltaPickIDs, DR, SC.FID, TRUE, inc_details), 
		mode = BairRx_Common.Constants.Mode.LPR => BairRx_LPR.GetPayload.MapView(dDeltaPickIDs, DR, SC.FID, TRUE, inc_details), 
		mode = BairRx_Common.Constants.Mode.SHO => BairRx_Spotter.GetPayload.MapView(dPickIDs, SC.FID, TRUE, inc_details),  
		mode = BairRx_Common.Constants.Mode.OFF => BairRx_Offender.GetPayload.MapView(dDeltaPickIDs, SC.FID, TRUE, inc_details), 
		DATASET([], BairRx_Common.Layouts.MapPayload)
		);		
	
	// For all others, we just need to hit the payload keys with both main and delta ids.	
	dPickRecs := MAP(
		mode = BairRx_Common.Constants.Mode.EVE => BairRx_Event.GetPayload.MapView(dPickIDs, DR, SC.FID, DPID, FALSE, isRaids, inc_details),  
		mode = BairRx_Common.Constants.Mode.CFS => BairRx_CFS.GetPayload.MapView(dPickIDs, DR, SC.FID, FALSE, inc_details),  
		mode = BairRx_Common.Constants.Mode.CRA => BairRx_Crash.GetPayload.MapView(dPickIDs, DR, SC.FID, FALSE, inc_details),  
		mode = BairRx_Common.Constants.Mode.LPR => BairRx_LPR.GetPayload.MapView(dPickIDs, DR, SC.FID, FALSE, inc_details),  
		mode = BairRx_Common.Constants.Mode.SHO => BairRx_Spotter.GetPayload.MapView(dPickIDs, SC.FID, FALSE, inc_details),  
		mode = BairRx_Common.Constants.Mode.OFF => BairRx_Offender.GetPayload.MapView(dPickIDs, SC.FID, FALSE, inc_details),  
		mode = BairRx_Common.Constants.Mode.INT => BairRx_Intel.GetPayload.MapView(dPickIDs+dDeltaPickIDs, DR, SC.FID, inc_details),  
		DATASET([], BairRx_Common.Layouts.MapPayload)
		);
		
	dPicks := dPickRecs+IF(EXISTS(dDeltaIDs), dDeltaPickRecs);
	dPickRecsSorted := BairRx_Common.SortingClause.CustomSort(dPicks, SC);
		
	dMapSearchRecs := PROJECT(dPickRecsSorted, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.seq := COUNTER, SELF := LEFT));
	dMapIDRecs := PROJECT(dPickEIDs, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.EID := BairRx_Common.EID.Clean(LEFT.eid), SELF := []));	
	dMapRecs := IF(eid_download, dMapIDRecs, CHOOSEN(dMapSearchRecs, max_records));
	
	RETURN dMapRecs;
END;
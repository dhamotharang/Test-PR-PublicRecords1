IMPORT BairRx_Common, BairRx_Event, BairRx_CFS, BairRx_Crash, BairRx_Offender, BairRx_LPR, BairRx_Intel, BairRx_Spotter;

EXPORT GetModeRecs(	
	DATASET(BairRx_Common.Layouts.ModeContext) mode_context,
	integer data_provider_id,
	integer max_records, 
	boolean eid_download, 
	boolean isRaids=FALSE, 
	boolean inc_details=FALSE
) := MODULE

	SHARED MaxSlimSort := MAX(max_records, BairRx_Common.Constants.MAX_SLIM_SORT); 
	
	EXPORT GetEvents(DATASET(BairRx_Common.Layouts.SearchRec) dIDs) := FUNCTION
	
		MC := mode_context(mId=BairRx_Common.Constants.Mode.EVE)[1]; 
		SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
		DR := MC.data_relation;
		dDeltaIDs := dIDs(delta);	
		
		// Slim sort based on input sorting criteria to select top records to return 
		dPickIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs(~delta), SC, MaxSlimSort);		
		dDeltaPickIDs := BairRx_Common.SortingClause.SlimTOPN(dDeltaIDs, SC, MaxSlimSort);			
		
		// get payload for top recs
		dDeltaPickRecs := BairRx_Event.GetPayload.MapView(dDeltaPickIDs, DR, SC.FID, data_provider_id, TRUE, isRaids, inc_details);
		dPickRecs := BairRx_Event.GetPayload.MapView(dPickIDs, DR, SC.FID, data_provider_id, FALSE, isRaids, inc_details);		
		dPicks := dPickRecs+IF(EXISTS(dDeltaIDs), dDeltaPickRecs);
		
		// sort them all and project to common layout
		dPickRecsSorted := CHOOSEN(BairRx_Common.SortingClause.CustomSort(dPicks, SC), max_records);
		dMapSearchRecs 	:= PROJECT(dPickRecsSorted, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.seq := COUNTER, SELF := LEFT, SELF := []));
		
		// eid download only
		dPickEIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs, SC, MaxSlimSort);
		dMapIDRecs := PROJECT(dPickEIDs, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.EID := BairRx_Common.EID.Clean(LEFT.eid), SELF := []));
		
		dMapRecs := IF(eid_download, dMapIDRecs, CHOOSEN(dMapSearchRecs, max_records));

		RETURN dMapRecs;
	END;
	
	EXPORT GetCFS(DATASET(BairRx_Common.Layouts.SearchRec) dIDs) := FUNCTION
	
		MC := mode_context(mId=BairRx_Common.Constants.Mode.CFS)[1]; 
		SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
		DR := MC.data_relation;		
		dDeltaIDs := dIDs(delta);	
	
		// Slim sort based on input sorting criteria to select top records to return 
		dPickIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs(~delta), SC, MaxSlimSort);
		dDeltaPickIDs := BairRx_Common.SortingClause.SlimTOPN(dDeltaIDs, SC, MaxSlimSort);			
		
		// get payload for top recs
		dDeltaPickRecs := BairRx_CFS.GetPayload.MapView(dDeltaPickIDs, DR, SC.FID, TRUE, inc_details);
		dPickRecs := BairRx_CFS.GetPayload.MapView(dPickIDs, DR, SC.FID, FALSE, inc_details);		
		dPicks := dPickRecs+IF(EXISTS(dDeltaIDs), dDeltaPickRecs);
		
		// sort them all and project to common layout
		dPickRecsSorted := CHOOSEN(BairRx_Common.SortingClause.CustomSort(dPicks, SC), max_records);
		dMapSearchRecs 	:= PROJECT(dPickRecsSorted, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.seq := COUNTER, SELF := LEFT, SELF := []));
		
		// eid download only
		dPickEIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs, SC, MaxSlimSort);
		dMapIDRecs := PROJECT(dPickEIDs, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.EID := BairRx_Common.EID.Clean(LEFT.eid), SELF := []));
		
		dMapRecs := IF(eid_download, dMapIDRecs, CHOOSEN(dMapSearchRecs, max_records));

		RETURN dMapRecs;
	END;

	EXPORT GetCrash(DATASET(BairRx_Common.Layouts.SearchRec) dIDs) := FUNCTION
	
		MC := mode_context(mId=BairRx_Common.Constants.Mode.CRA)[1]; 
		SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
		DR := MC.data_relation;		
		dDeltaIDs := dIDs(delta);	
	
		// Slim sort based on input sorting criteria to select top records to return 
		dPickIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs(~delta), SC, MaxSlimSort);
		dDeltaPickIDs := BairRx_Common.SortingClause.SlimTOPN(dDeltaIDs, SC, MaxSlimSort);			
		
		// get payload for top recs
		dDeltaPickRecs := BairRx_Crash.GetPayload.MapView(dDeltaPickIDs, DR, SC.FID, TRUE, inc_details);
		dPickRecs := BairRx_Crash.GetPayload.MapView(dPickIDs, DR, SC.FID, FALSE, inc_details);		
		dPicks := dPickRecs+IF(EXISTS(dDeltaIDs), dDeltaPickRecs);
		
		// sort them all and project to common layout
		dPickRecsSorted := CHOOSEN(BairRx_Common.SortingClause.CustomSort(dPicks, SC), max_records);
		dMapSearchRecs 	:= PROJECT(dPickRecsSorted, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.seq := COUNTER, SELF := LEFT, SELF := []));
		
		// eid download only
		dPickEIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs, SC, MaxSlimSort);
		dMapIDRecs := PROJECT(dPickEIDs, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.EID := BairRx_Common.EID.Clean(LEFT.eid), SELF := []));
		
		dMapRecs := IF(eid_download, dMapIDRecs, CHOOSEN(dMapSearchRecs, max_records));

		RETURN dMapRecs;
	END;

	EXPORT GetLPR(DATASET(BairRx_Common.Layouts.SearchRec) dIDs) := FUNCTION
	
		MC := mode_context(mId=BairRx_Common.Constants.Mode.LPR)[1]; 
		SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
		DR := MC.data_relation;		
		dDeltaIDs := dIDs(delta);	
	
		// Slim sort based on input sorting criteria to select top records to return 
		dPickIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs(~delta), SC, MaxSlimSort);
		dDeltaPickIDs := BairRx_Common.SortingClause.SlimTOPN(dDeltaIDs, SC, MaxSlimSort);			
		
		// get payload for top recs
		dDeltaPickRecs := BairRx_LPR.GetPayload.MapView(dDeltaPickIDs, DR, SC.FID, TRUE, inc_details);
		dPickRecs := BairRx_LPR.GetPayload.MapView(dPickIDs, DR, SC.FID, FALSE, inc_details);		
		dPicks := dPickRecs+IF(EXISTS(dDeltaIDs), dDeltaPickRecs);
		
		// sort them all and project to common layout
		dPickRecsSorted := CHOOSEN(BairRx_Common.SortingClause.CustomSort(dPicks, SC), max_records);
		dMapSearchRecs 	:= PROJECT(dPickRecsSorted, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.seq := COUNTER, SELF := LEFT, SELF := []));
		
		// eid download only
		dPickEIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs, SC, MaxSlimSort);
		dMapIDRecs := PROJECT(dPickEIDs, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.EID := BairRx_Common.EID.Clean(LEFT.eid), SELF := []));
		
		dMapRecs := IF(eid_download, dMapIDRecs, CHOOSEN(dMapSearchRecs, max_records));

		RETURN dMapRecs;
	END;
	
	EXPORT GetShotspotter(DATASET(BairRx_Common.Layouts.SearchRec) dIDs) := FUNCTION
	
		MC := mode_context(mId=BairRx_Common.Constants.Mode.SHO)[1]; 
		SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
		DR := MC.data_relation;		
		dDeltaIDs := dIDs(delta);	
	
		// Slim sort based on input sorting criteria to select top records to return 
		dPickIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs(~delta), SC, MaxSlimSort);
		dDeltaPickIDs := BairRx_Common.SortingClause.SlimTOPN(dDeltaIDs, SC, MaxSlimSort);			
		
		// get payload for top recs
		dDeltaPickRecs := BairRx_Spotter.GetPayload.MapView(dDeltaPickIDs, SC.FID, TRUE, inc_details);
		dPickRecs := BairRx_Spotter.GetPayload.MapView(dPickIDs, SC.FID, FALSE, inc_details);		
		dPicks := dPickRecs+IF(EXISTS(dDeltaIDs), dDeltaPickRecs);
		
		// sort them all and project to common layout
		dPickRecsSorted := CHOOSEN(BairRx_Common.SortingClause.CustomSort(dPicks, SC), max_records);
		dMapSearchRecs 	:= PROJECT(dPickRecsSorted, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.seq := COUNTER, SELF := LEFT, SELF := []));
		
		// eid download only
		dPickEIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs, SC, MaxSlimSort);
		dMapIDRecs := PROJECT(dPickEIDs, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.EID := BairRx_Common.EID.Clean(LEFT.eid), SELF := []));
		
		dMapRecs := IF(eid_download, dMapIDRecs, CHOOSEN(dMapSearchRecs, max_records));

		RETURN dMapRecs;
	END;
	
	EXPORT GetOffenders(DATASET(BairRx_Common.Layouts.SearchRec) dIDs) := FUNCTION
	
		MC := mode_context(mId=BairRx_Common.Constants.Mode.OFF)[1]; 
		SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
		DR := MC.data_relation;		
		dDeltaIDs := dIDs(delta);	
	
		// Slim sort based on input sorting criteria to select top records to return 
		dPickIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs(~delta), SC, MaxSlimSort);
		dDeltaPickIDs := BairRx_Common.SortingClause.SlimTOPN(dDeltaIDs, SC, MaxSlimSort);			
		
		// get payload for top recs
		dDeltaPickRecs := BairRx_Offender.GetPayload.MapView(dDeltaPickIDs, SC.FID, TRUE, inc_details);
		dPickRecs := BairRx_Offender.GetPayload.MapView(dPickIDs, SC.FID, FALSE, inc_details);		
		dPicks := dPickRecs+IF(EXISTS(dDeltaIDs), dDeltaPickRecs);
		
		// sort them all and project to common layout
		dPickRecsSorted := CHOOSEN(BairRx_Common.SortingClause.CustomSort(dPicks, SC), max_records);
		dMapSearchRecs 	:= PROJECT(dPickRecsSorted, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.seq := COUNTER, SELF := LEFT, SELF := []));
		
		// eid download only
		dPickEIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs, SC, MaxSlimSort);
		dMapIDRecs := PROJECT(dPickEIDs, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.EID := BairRx_Common.EID.Clean(LEFT.eid), SELF := []));
		
		dMapRecs := IF(eid_download, dMapIDRecs, CHOOSEN(dMapSearchRecs, max_records));

		RETURN dMapRecs;
	END;
	
	EXPORT GetIntel(DATASET(BairRx_Common.Layouts.SearchRec) dIDs) := FUNCTION
	
		MC := mode_context(mId=BairRx_Common.Constants.Mode.INT)[1]; 
		SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
		DR := MC.data_relation;		
		dDeltaIDs := dIDs(delta);	
	
		// Slim sort based on input sorting criteria to select top records to return 
		dPickIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs(~delta), SC, MaxSlimSort);
		dDeltaPickIDs := BairRx_Common.SortingClause.SlimTOPN(dDeltaIDs, SC, MaxSlimSort);			
		
		// get payload for top recs
		dPickRecs := BairRx_Intel.GetPayload.MapView(dPickIDs+dDeltaPickIDs, DR, SC.FID, inc_details);				
		
		// sort them all and project to common layout
		dPickRecsSorted := CHOOSEN(BairRx_Common.SortingClause.CustomSort(dPickRecs, SC), max_records);
		dMapSearchRecs 	:= PROJECT(dPickRecsSorted, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.seq := COUNTER, SELF := LEFT, SELF := []));
		
		// eid download only
		dPickEIDs := BairRx_Common.SortingClause.SlimTOPN(dIDs, SC, MaxSlimSort);
		dMapIDRecs := PROJECT(dPickEIDs, TRANSFORM(BairRx_Common.Layouts.MapPayload, SELF.EID := BairRx_Common.EID.Clean(LEFT.eid), SELF := []));
		
		dMapRecs := IF(eid_download, dMapIDRecs, CHOOSEN(dMapSearchRecs, max_records));

		RETURN dMapRecs;
	END;
	
	
END;
import BairRx_Common;

EXPORT IDModeSearch(DATASET(BairRx_Common.Layouts.SearchRec) dIDs, BairRx_Common.IParam.SearchParam inMod, string mode, integer max_records) := FUNCTION

	MC := inMod.ModeContext(mID=mode)[1];
	SC := BairRx_Common.SortingClause.GetClause(MC.mID, MC.sorting_clause);
	MaxSlimSort := MAX(max_records, BairRx_Common.Constants.MAX_SLIM_SORT); 
	dModeIDs := dIDs(eid[1..3]=mode);
	
	// Slim sort based on input sorting criteria to select top records to return 
	dPickEIDs := BairRx_Common.SortingClause.SlimTOPN(dModeIDs, SC, MaxSlimSort);
	dEIDRecs := PROJECT(dPickEIDs, TRANSFORM(BairRx_Common.Layouts.EIDDownload, SELF.EID := BairRx_Common.EID.Clean(LEFT.eid),SELF.seq := COUNTER));	
		
	RETURN dEIDRecs;
END;
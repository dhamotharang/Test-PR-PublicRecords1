import $,BairRx_Common,iesp;

EXPORT ReportRecords(BairRx_Common.IParam.ReportParam inMod, integer max_records, boolean include_notes = FALSE,  boolean is_raids = FALSE) := FUNCTION
	
	dIDsIn := PROJECT(inMod.EIDs, TRANSFORM(BairRx_Common.Layouts.SearchRec,
      SELF.etype := IF(BairRx_Common.EID.IsOffender(LEFT.value),BairRx_Common.EID.Type.OFF, skip),	
      SELF.eid := LEFT.value, 
      SELF := []));
											
	dIDs := CHOOSEN(DEDUP(SORT(dIDsIn, eid), eid), max_records);
	dRecs := $.GetPayload.SearchView(dIDs, 0, is_raids);
	
	dCleanRecs := IF(~is_raids, BairRx_Common.GroupAccessControl.Clean(dRecs, inMod.AgencyORI, data_provider_ori), dRecs);
	dOutRecs := PROJECT(dCleanRecs(raids_ok or ~is_raids), $.ESPOut(LEFT, FALSE));	
	
	$.Layouts.SearchResults xtResults() := transform
		SELF.match_count := COUNT(dOutRecs),
		SELF.records := IF(include_notes, $.Functions.AppendNotes(dOutRecs), dOutRecs);
	END;

	RETURN DATASET([xtResults()]);	
	
END;	
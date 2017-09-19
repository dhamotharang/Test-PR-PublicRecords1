import $,BairRx_Common;

EXPORT ReportRecords(BairRx_Common.IParam.SearchParam inMod, integer max_records) := FUNCTION
	
	dIDsIn 	:= PROJECT(inMod.EIDs,
    TRANSFORM(BairRx_Common.Layouts.SearchRec,
      SELF.etype := IF(BairRx_Common.EID.IsShotSpotter(LEFT.value),BairRx_Common.EID.Type.SHO, skip),
      SELF.eid := LEFT.value,
      SELF := []));
											
	dIDs := CHOOSEN(DEDUP(SORT(dIDsIn, eid), eid), max_records);
	dRecs	:= $.GetPayload.SearchView(dIDs, 0);
	dRecsClean := BairRx_Common.GroupAccessControl.Clean(dRecs, inMod.AgencyORI, data_provider_ori);	
	dOutRecs := PROJECT(dRecsClean, $.ESPOut(LEFT));	
	
	$.Layouts.SearchResults xtResults() := TRANSFORM
		SELF.match_count := COUNT(dOutRecs),
		SELF.records := dOutRecs;
	END;
	dResults := DATASET([xtResults()]);			

	RETURN dResults;	
	
END;	
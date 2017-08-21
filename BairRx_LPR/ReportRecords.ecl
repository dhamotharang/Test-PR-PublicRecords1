import $,BairRx_Common;

EXPORT ReportRecords(BairRx_Common.IParam.SearchParam inMod, integer max_records) := function
	
	dIDsIn 	:= PROJECT(inMod.EIDs, TRANSFORM(BairRx_Common.Layouts.SearchRec,
											SELF.etype := IF(BairRx_Common.EID.IsLPR(LEFT.value),BairRx_Common.EID.Type.LPR, skip),	
											SELF.eid := LEFT.value,
											SELF := []));											
	dIDs := CHOOSEN(DEDUP(SORT(dIDsIn, eid), eid), max_records);
	
	dDeltaRecs := $.GetPayload.SearchView(dIDs, 0, TRUE);
	dIDsMain := JOIN(dIDs,dDeltaRecs,LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_Common.Layouts.SearchRec,SELF := LEFT),LEFT ONLY);
	dMainRecs := $.GetPayload.SearchView(dIDsMain, 0, FALSE);		
	
	dRecsClean := BairRx_Common.GroupAccessControl.Clean(dDeltaRecs + dMainRecs, inMod.AgencyORI, data_provider_ori);	
	dRecs := PROJECT(dRecsClean, $.ESPOut(LEFT, FALSE));	
	
	$.Layouts.SearchResults xtResults() := TRANSFORM
		SELF.match_count := COUNT(dRecs),
		SELF.records := dRecs;
	end;
	dResults := DATASET([xtResults()]);			

	RETURN dResults;	
	
END;	
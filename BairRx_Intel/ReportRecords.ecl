import $,BairRx_Common;

EXPORT ReportRecords(BairRx_Common.IParam.ReportParam inMod, integer max_records, boolean include_notes) := function
	
	dIDSIn := PROJECT(inMod.EIDs, TRANSFORM(BairRx_Common.Layouts.SearchRec,
			SELF.etype := IF(BairRx_Common.EID.IsIntel(LEFT.value),BairRx_Common.EID.Type.INT, skip),	
			SELF.eid := LEFT.value,
			SELF := []));
			
	dIDS := CHOOSEN(DEDUP(SORT(dIDSIn, eid), eid), max_records);
	dDeltaRecs := $.GetPayload.ReportView(dIDs, include_notes,TRUE);			
	
	dIDSmain := JOIN(dIDS, dDeltaRecs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_Common.Layouts.SearchRec,SELF := LEFT),LEFT ONLY);				
	dMainRecs	:= $.GetPayload.ReportView(dIDSmain, include_notes,FALSE);			

	dRecs := BairRx_Common.GroupAccessControl.Clean(dDeltaRecs + dMainRecs, inMod.AgencyORI, data_provider_ori);			
	dResults := PROJECT(dRecs, $.ESPOut.ReportView(LEFT));	
	
	return dResults;
	
END;	
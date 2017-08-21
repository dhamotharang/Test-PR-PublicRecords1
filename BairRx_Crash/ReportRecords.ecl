import $,BairRx_Common;

EXPORT ReportRecords(BairRx_Common.IParam.ReportParam inMod, integer max_records, boolean include_notes) := function
		
	dIDSIn 	:= PROJECT(inMod.EIDs, TRANSFORM(BairRx_Common.Layouts.SearchRec,
											SELF.etype	:= IF(BairRx_Common.EID.IsCrash(LEFT.value),BairRx_Common.EID.Type.CRA, SKIP),	
											SELF.eid 		:= LEFT.value,											
											SELF := []));
											
	dIDS 				:= CHOOSEN(DEDUP(SORT(dIDSIn, eid), eid), max_records);
	dDeltaRecs 	:= $.GetPayload.ReportView(dIDS, include_notes, TRUE);		
	dIDSmain 		:= JOIN(dIDS, dDeltaRecs, LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_Common.Layouts.SearchRec,SELF := LEFT),LEFT ONLY);
	dMainRecs 	:= $.GetPayload.ReportView(dIDSmain, include_notes, FALSE);
	dRecs 			:= dDeltaRecs + dMainRecs;
	dCleanRecs 	:= BairRx_Common.GroupAccessControl.Clean(dRecs, inMod.AgencyORI, data_provider_ori);			
	dResults 		:= PROJECT(dCleanRecs, $.ESPOut.ReportView(LEFT));	

	return dResults;
	
	
END;	
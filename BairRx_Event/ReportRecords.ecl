import $,BairRx_Common;

EXPORT ReportRecords(BairRx_Common.IParam.ReportParam inMod, integer max_records, boolean include_notes) := function

	dIDSIn := PROJECT(inMod.EIDs,
	  TRANSFORM(BairRx_Common.Layouts.SearchRec,
      _eid := BairRx_Common.EID.Clean(LEFT.value);
      _stamp := BairRx_Common.EID.GetStamp(LEFT.value);
      SELF.etype := IF(BairRx_Common.EID.IsEvent(_eid),BairRx_Common.EID.Type.EVE, skip),
      SELF.eid := _eid,
      SELF.stamp := _stamp,
      SELF := [])
    );
											
	dIDS := CHOOSEN(DEDUP(SORT(dIDSIn, eid), eid), max_records);
	dDeltaRecs := $.GetPayload.ReportView(dIDs, include_notes, inMod.DataProviderID, TRUE);
	dIDSMain := JOIN(dIDS,dDeltaRecs,LEFT.eid = RIGHT.eid, TRANSFORM(BairRx_Common.Layouts.SearchRec,SELF := LEFT),LEFT ONLY);
	dMainRecs := $.GetPayload.ReportView(dIDSMain, include_notes, inMod.DataProviderID, FALSE);		
	dCleanRecs := BairRx_Common.GroupAccessControl.Clean(dDeltaRecs + dMainRecs, inMod.AgencyORI, data_provider_ori);			
	dResults := PROJECT(dCleanRecs, $.ESPOut.ReportView(LEFT));	// should we be sorting by EID?
	
	RETURN dResults;
	
END;

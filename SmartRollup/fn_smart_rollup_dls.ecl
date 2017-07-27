IMPORT iesp;
export fn_smart_rollup_dls(DATASET(iesp.driverlicense2.t_DLEmbeddedReport2Record) inRecs) := function
  sRecs := sort(inRecs, OriginState, DriverLicense, -iesp.ECL2ESP.DateToInteger(expirationDate));
	sRecs loadit(sRecs L, sRecs R) := transform
	   self := L;
	end;
	rRecs := rollup(sRecs, LEFT.OriginState = RIGHT.OriginState and LEFT.DriverLicense=RIGHT.DriverLicense, loadit(LEFT,RIGHT));
  outRecs := sort(rRecs,-iesp.ECL2ESP.DateToInteger(expirationDate));
	RETURN outRecs;
end;
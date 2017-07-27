import iesp;
export fn_smart_rollup_paw(dataset(iesp.peopleatwork.t_PeopleAtWorkRecord) inPAW) := FUNCTION
  // Call function to dedup on linkids and name/address
  recs := SmartRollup.Functions.dedup_businesses(inPAW,DateLastSeen);
	outrecs := sort(recs,-iesp.ECL2ESP.DateToInteger(DateFirstSeen));
  RETURN outRecs;
END;
IMPORT PersonContext;

EXPORT GetPersonContext(PersonContext.Layouts.Layout_PCRequest rowPCReq) := FUNCTION
	VSK 	 					:= PersonContext.Functions.ValidateSearchKeys(rowPCReq);
	dsPCDB 					:= PersonContext.Functions.PerformDeltabaseCall(VSK.dsPCValidSearchRecs, VSK.isEmptySearchDs, rowPCReq.DeltabaseURL);

  dsPCR_results   := PersonContext.Functions.PerformGetPCR(VSK.dsPCValidSearchRecs);
  // the UID in the PCR key maps to recID1 in the PersonContext layout
  // put the PCR keys data and PersonContext deltabase results together and dedup.  keep the latest one
  dsPCDB_plus_dsPCR := dedup(sort(dsPCDB + dsPCR_results, LexId, DataGroup, RecordType, EventType, RecId1, RecId2, RecId3, RecId4, -DateAdded), LexId, DataGroup, RecordType, EventType, RecId1, RecId2, RecId3, RecId4);  
  
  dsRoxieKeyFinal := PersonContext.Functions.PerformGetRoxieKeyData(VSK.dsPCValidSearchRecs);
  CD 							:= PersonContext.Functions.PerformCombineDatasets(VSK.dsPCReqValidated, dsPCDB_plus_dsPCR, dsRoxieKeyFinal);
  dsFinalResponse := PersonContext.Functions.PerformCreateFinalOutput(CD.dsResults,VSK.isEmptySearchds,VSK.isNoValidSearchKeys,CD.isWeFoundResults);
  
  // output(VSK.dsPCValidSearchRecs, named('dsPCValidSearchRecs'));
  // output(dsPCDB, named('dsPCDB'));
  // output(dsPCR_results, named('dsPCR_results'));
  // output(dsPCDB_plus_dsPCR, named('dsPCDB_plus_dsPCR'));
  
	RETURN(dsFinalResponse);
END;

IMPORT PersonContext;

EXPORT GetPersonContext(PersonContext.Layouts.Layout_PCRequest rowPCReq) := FUNCTION
	VSK 	 					:= PersonContext.Functions.ValidateSearchKeys(rowPCReq);
	dsPCDB 					:= PersonContext.Functions.PerformDeltabaseCall(VSK.dsPCValidSearchRecs, VSK.isEmptySearchDs, rowPCReq.DeltabaseURL);
  dsRoxieKeyFinal := PersonContext.Functions.PerformGetRoxieKeyData(VSK.dsPCValidSearchRecs);
  CD 							:= PersonContext.Functions.PerformCombineDatasets(VSK.dsPCReqValidated, dsPCDB, dsRoxieKeyFinal);
  dsFinalResponse := PersonContext.Functions.PerformCreateFinalOutput(CD.dsResults,VSK.isEmptySearchds,VSK.isNoValidSearchKeys,CD.isWeFoundResults);
	RETURN(dsFinalResponse);
END;

IMPORT PersonContext;

EXPORT GetPersonContext(PersonContext.Layouts.Layout_PCRequest rowPCReq, BOOLEAN failOnSoapError = FALSE) := FUNCTION

  VSK              := PersonContext.Functions.ValidateSearchKeys(rowPCReq);
  dsPCDB           := PersonContext.Functions.PerformDeltabaseCall(VSK.dsPCValidSearchRecs, VSK.isEmptySearchDs, rowPCReq.DeltabaseURL);

  dsPCR_results   := PersonContext.Functions.PerformGetPCR(VSK.dsPCValidSearchRecs);

  // put the PCR keys data and PersonContext deltabase results together
  dsPCDB_plus_dsPCR := dsPCDB.response.Records + dsPCR_results;  

  dsRoxieKeyFinal := PersonContext.Functions.PerformGetRoxieKeyData(VSK.dsPCValidSearchRecs);
  CD               := PersonContext.Functions.PerformCombineDatasets(VSK.dsPCReqValidated, dsPCDB_plus_dsPCR, dsRoxieKeyFinal);

  dsFinalResponse := PersonContext.Functions.PerformCreateFinalOutput(CD.dsResults,VSK.isEmptySearchds,VSK.isNoValidSearchKeys,CD.isWeFoundResults);
  
  PersonContext.Layouts.Layout_PCResponse onFailResponse() := TRANSFORM
      SELF._Header := dsPCDB.response._Header;
      SELF := [];    
  END;
  dsSoapFailResp := DATASET([onFailResponse()]);
   
  // output(VSK.dsPCValidSearchRecs, named('dsPCValidSearchRecs'));
  // output(dsPCDB, named('dsPCDB'));
  // output(dsPCR_results, named('dsPCR_results'));
  // output(dsPCDB_plus_dsPCR, named('dsPCDB_plus_dsPCR'));
  
  RETURN IF(failOnSoapError AND dsPCDB.response._Header.Status <> 0, dsSoapFailResp, dsFinalResponse);
END;

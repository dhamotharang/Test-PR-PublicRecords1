EXPORT GetPersonContext_thor(DATASET(PersonContext.Layouts.Layout_PCSearchKey) PCKeys = DATASET([], PersonContext.Layouts.Layout_PCSearchKey)) := FUNCTION
	VSK_thor 						 := PersonContext.Functions.ValidateSearchKeys_thor(PCKeys);
	//won't do the deltabase call when running on thor  
  dsPCR_results   		 := PersonContext.Functions.PerformGetPCR(VSK_thor.dsPCValidSearchRecs);
	dsRoxieKeyFinal_thor := PersonContext.Functions.PerformGetRoxieKeyData(VSK_thor.dsPCValidSearchRecs); 
  CD_thor 						 := PersonContext.Functions.PerformCombineDatasets(VSK_thor.dsPCReqValidated, dsPCR_results, dsRoxieKeyFinal_thor);
	ConvertSTCodes			 := PersonContext.Functions.PerformStateConversion(CD_thor.dsResults);
  dsFinalResponse_thor := PersonContext.Functions.PerformCreateFinalOutput_thor(ConvertSTCodes.dsResults);	
	RETURN(dsFinalResponse_thor);
END;
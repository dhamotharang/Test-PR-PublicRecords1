EXPORT GetPersonContext_thor(DATASET(PersonContext.Layouts.Layout_PCSearchKey) PCKeys = DATASET([], PersonContext.Layouts.Layout_PCSearchKey)) := FUNCTION
	VSK_thor 						 := PersonContext.Functions.ValidateSearchKeys_thor(PCKeys);
	dsPCDB_thor 				 := DATASET([],PersonContext.Layouts.Layout_PCResponseRec); //won't do the deltabase call when running on thor
	dsRoxieKeyFinal_thor := PersonContext.Functions.PerformGetRoxieKeyData(VSK_thor.dsPCValidSearchRecs); 
  CD_thor 						 := PersonContext.Functions.PerformCombineDatasets(VSK_thor.dsPCReqValidated, dsPCDB_thor, dsRoxieKeyFinal_thor);
  dsFinalResponse_thor := PersonContext.Functions.PerformCreateFinalOutput_thor(CD_thor.dsResults);	
	RETURN(dsFinalResponse_thor);
END;
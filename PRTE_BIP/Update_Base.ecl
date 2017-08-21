export Update_Base(
										dataset(Layouts.input_slim_sprayed)		pUpdateFile,
										dataset(Layouts.Base)									pBaseFile,
										string pversion
									) := function

	dStandardizedInputFile  := 	StandardizeInputFile.fAll(pUpdateFile, pversion): persist(persistnames('standardized').standardized);
  
	dUpdateCombined					:=	if(prte_bip._Flags('slim').Update
																,dStandardizedInputFile + pBaseFile																	
																,dStandardizedInputFile
																)
																: persist(persistnames('combined').combined);

	dRollupBase							:= 	Rollup_Base(dStandardizedInputFile, dUpdateCombined);
	
	return dRollupBase;
end;
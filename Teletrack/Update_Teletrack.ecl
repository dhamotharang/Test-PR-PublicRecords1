//Rolls up existing base file records together with the records from incoming update
export Update_Teletrack(

	 string						    						pversion
	,dataset(Layouts.Input.Sprayed	)	pSprayedFile		= Files().input.Using
	,dataset(Layouts.Base						)	pBaseFile       = Files().base.qa										

) :=
function

	dStandardizedInputFile := Standardize_Input.fAll(pSprayedFile, pversion);

	base_file := project(pBaseFile, transform(Layouts.Base, self.record_type := 'H'; self := left));

	update_combined	 	  := map(_Flags.Update.Teletrack =>	dStandardizedInputFile + base_file,
															dStandardizedInputFile 
														);
								 
	dAppendIds					:= Append_Ids.fAll (update_combined);
	dRollup							:= Rollup_Teletrack(dAppendIds);

	return dRollup;

end;
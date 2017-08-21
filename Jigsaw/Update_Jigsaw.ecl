//Rolls up existing base file records together with the records from incoming update
export Update_Jigsaw(

	 string						    						pversion
	,dataset(Layouts.Input.Sprayed	)	pLiveSprayedFile		= Files().input.live.using
	,dataset(Layouts.Input.Sprayed	)	pDeadSprayedFile    = Files().input.dead.using
	,dataset(Layouts.Input.Sprayed	)	pLockedSprayedFile  = Files().input.deletedremove.using
	,dataset(Layouts.Base						)	pBaseFile           = Files().base.qa										

) :=
function

	dStandardizedInputFile := Standardize_Jigsaw.fAll(pLiveSprayedFile,pDeadSprayedFile, pversion);

	base_file := project(pBaseFile, transform(Layouts.Base, self.record_type := 'H'; self := left));

	update_combined	 	  := map(_Flags.ExistJigsawBaseFile =>	dStandardizedInputFile + base_file,
															dStandardizedInputFile 
														);
								 
	dRemoveIds          := Truncate_Ids(pLockedSprayedFile,update_combined);
	
	dStandardisedAIDs 	:= Jigsaw.Standardize_Addr_Jigsaw(dRemoveIds);

	dAppendIds					:= Append_Ids.fAll (dStandardisedAIDs);
	dRollup							:= Rollup_Jigsaw   (dAppendIds);

	return dRollup;

end;
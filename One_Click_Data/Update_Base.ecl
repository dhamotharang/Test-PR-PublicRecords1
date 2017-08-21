//Rolls up existing base file records together with the records from incoming update
export Update_Base(

	 string						    						pversion
	,dataset(Layouts.Input.Sprayed	)	pSprayedFile		= Files().input.using
	,dataset(Layouts.Base   				)	pBaseFile       = Files().base.qa										

) :=
function

	dStandardizedInputFile	:= Standardize_Input.fAll(pSprayedFile, pversion);
	base_file								:= project(pBaseFile, transform(Layouts.Base, self.record_type := 'H'; self := left));
	update_combined	 	  		:= map(_Flags.Update =>	dStandardizedInputFile + base_file,
																									dStandardizedInputFile 
														 );
	dStandardize_NameAddr		:= Standardize_NameAddr.fAll(update_combined,	pversion	);													 
	dAppendIds							:= Append_Ids.fAll 	(dStandardize_NameAddr);
	dRollup									:= Rollup_Base   		(dAppendIds			);

	return dRollup;
	
end;
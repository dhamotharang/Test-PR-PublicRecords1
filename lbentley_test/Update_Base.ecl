//Rolls up existing base file records together with the records from incoming update
export Update_Base(

	 string						    						pversion
	,dataset(Layouts.Input.Sprayed	)	pSprayedFile		= Files().input.using

) :=
function

	dStandardizedInputFile	:= Standardize_Input.fAll(pSprayedFile, pversion);
	dAppendIds							:= Append_Ids.fAll 	(dStandardizedInputFile);

	return dAppendIds;

end;
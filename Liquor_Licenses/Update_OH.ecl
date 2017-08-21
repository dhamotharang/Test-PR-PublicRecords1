export Update_OH(

	 dataset(Layouts.Input.OH	)	pUpdateFile
	,dataset(Layouts.Base.OH	)	pBaseFile
	,string											pversion

) :=
function

	dStandardizedInputFile	:= Standardize_OH.fAll(pUpdateFile, pversion);

	update_combined					:= map(_Flags.Update.OH =>	dStandardizedInputFile + pBaseFile,
																											dStandardizedInputFile
															);

	return update_combined;

end;
export Update_PA(

	 dataset(Layouts.Input.PA	)	pUpdateFile
	,dataset(Layouts.Base.PA	)	pBaseFile
	,string											pversion

) :=
function

	dStandardizedInputFile	:= Standardize_PA.fAll(pUpdateFile, pversion);

	update_combined					:= map(_Flags.Update.PA =>	dStandardizedInputFile + pBaseFile,
																											dStandardizedInputFile
															);

	return update_combined;

end;
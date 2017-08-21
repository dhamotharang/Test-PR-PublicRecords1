export Update_IN(

	 dataset(Layouts.Input.IN	)	pUpdateFile
	,dataset(Layouts.Base.IN	)	pBaseFile
	,string											pversion

) :=
function

	dStandardizedInputFile	:= Standardize_IN.fAll(pUpdateFile, pversion);

	update_combined					:= map(_Flags.Update.IN =>	dStandardizedInputFile + pBaseFile,
																											dStandardizedInputFile
															);

	return update_combined;

end;
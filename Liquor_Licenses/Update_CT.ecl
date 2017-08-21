export Update_CT(

	 dataset(Layouts.Input.CT	)	pUpdateFile
	,dataset(Layouts.Base.CT	)	pBaseFile
	,string											pversion

) :=
function

	dStandardizedInputFile	:= Standardize_CT.fAll(pUpdateFile, pversion);

	update_combined					:= map(_Flags.Update.CT =>	dStandardizedInputFile + pBaseFile,
																											dStandardizedInputFile
															);

	return update_combined;

end;
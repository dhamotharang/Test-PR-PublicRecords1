export Update_TX(

	 dataset(Layouts.Input.TX)	pUpdateFile
	,dataset(Layouts.Base.TX)		pBaseFile
	,string											pversion

) :=
function

	dStandardizedInputFile	:= Standardize_TX.fAll(pUpdateFile, pversion);

	update_combined					:= map(_Flags.Update.TX =>	dStandardizedInputFile + pBaseFile,
																											dStandardizedInputFile
													);

	return update_combined;

end;
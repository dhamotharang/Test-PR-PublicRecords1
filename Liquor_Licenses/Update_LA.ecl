export Update_LA(

	 dataset(Layouts.Input.LA	)	pUpdateFile
	,dataset(Layouts.Base.LA	)	pBaseFile
	,string											pversion

) :=
function

	dStandardizedInputFile	:= Standardize_LA.fAll(pUpdateFile, pversion);

	update_combined					:= map(_Flags.Update.LA =>	dStandardizedInputFile + pBaseFile,
																											dStandardizedInputFile
															);

	return update_combined;

end;
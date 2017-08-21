export Update_CA(

	 dataset(Layouts.Input.CA_sprayed	)	pUpdateFile	= files().input.ca.using
	,dataset(Layouts.Base.CA					)	pBaseFile		= files().base.ca.qa
	,string															pversion

) :=
function

	dStandardizedInputFile	:= Standardize_CA.fAll(pUpdateFile, pversion);

	update_combined					:= map(_Flags.Update.CA =>	dStandardizedInputFile + pBaseFile,
																											dStandardizedInputFile
													);

	return dedup(update_combined,all);

end;
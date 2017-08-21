import business_header;

export Update_Base(

	 string																			pversion
	,dataset(Layouts.Input.Sprayed						)	pUpdateFile			= Files().Input.using
	,dataset(Layouts.Base											)	pBaseFile				= Files().base.qa
	,boolean																		pShouldUpdate		= _Flags.Update	

) :=
function

	dStandardizedInputFile	:= StandardizeInputFile.fAll	(pUpdateFile, pversion);
	
	update_combined					:= if(pShouldUpdate
																,dStandardizedInputFile + pBaseFile
																,dStandardizedInputFile
															);

	dStandardize_NameAddr		:= Standardize_NameAddr.fAll(update_combined,	pversion	);
	dAppendIds							:= Append_Ids.fAll					(dStandardize_NameAddr			);
	dRollup									:= Rollup_Base							(dAppendIds									);

	return dRollup;

end;
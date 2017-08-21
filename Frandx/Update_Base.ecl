import business_header;

export Update_Base(

	 string																			pversion
	,dataset(Layouts.Input.Sprayed						)	pSprayedFile		= Files().Input.using
	,dataset(Layouts.Base											)	pBaseFile				= Files().base.qa
	,boolean																		pShouldUpdate		= _Flags.Update	

) :=
function

	dStandardizedInputFile	:= Standardize_Input.fAll	(pSprayedFile, pversion);
	
	base_file								:= project(pBaseFile, transform(Layouts.Base, self.record_type := 'H'; self := left));
	
	update_combined					:= if(pShouldUpdate
																,dStandardizedInputFile + base_file
																,dStandardizedInputFile
															);

	dStandardize_NameAddr		:= Standardize_NameAddr.fAll(update_combined,	pversion	);
	dAppendIds							:= Append_Ids.fAll					(dStandardize_NameAddr			);
	dRollup									:= Rollup_Base							(dAppendIds									);

	return dRollup;

end;
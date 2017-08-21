export Update_Base(
	 string																			pversion
	,dataset(Layouts.Input.Sprayed						)	pSprayedFile	= Files().Input.using
	,dataset(Layouts.Base											)	pBaseFile			= Files().base.qa
	,boolean																		pShouldUpdate	= _Flags.Update
) :=
function

	dStandardizedInputFile	:= Standardize_Input.fAll	(pSprayedFile						, pversion);
	
	base_file								:= project(pBaseFile, transform(Layouts.Base, self.record_type := 'H'; self := left));
	
	update_combined					:= if(pShouldUpdate
																,dStandardizedInputFile + base_file
																,dStandardizedInputFile
															);
	dAppendIds							:= Append_Ids.fAll		(update_combined		);
	dImproveIds							:= Improve_Ids				(dAppendIds					);
	dback2base							:= project(dImproveIds,layouts.base);
	dImproveBdids						:= Improve_Bdids			(dback2base					);
	
	return dImproveBdids;

end;

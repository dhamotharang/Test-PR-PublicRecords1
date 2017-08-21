 export Update_Base(

	 string																			pversion
	,dataset(Layouts.Input.Sprayed						)	pSprayedFile		= Files().Input.using
	,dataset(Layouts.Base											)	pBaseFile				= Files().base.qa
	,boolean																		pShouldUpdate		= _Flags.Update
	//,dataset(Layouts.Input.SprayedOLD					)	pSprayedOldFile	= Files().InputOLD.using

) :=
function

	//dPrepFile								:= Prep_File(,,pSprayedFile,pSprayedOldFile);
	dStandardizedInputFile	:= Standardize_Input.fAll	(pSprayedFile						, pversion);
	
	base_file								:= project(pBaseFile, transform(Layouts.Base, self.recordtype := 'H'; self := left));
	
	update_combined					:= if(pShouldUpdate
																,dStandardizedInputFile + base_file
																,dStandardizedInputFile
															);
	dAppendAID							:= Append_AID.fall(update_combined			);	
	dAppendIds							:= Append_Ids.fAll				(dAppendAID		);
	dRollup									:= Rollup_Base						(dAppendIds						);

	return dRollup; 

end;
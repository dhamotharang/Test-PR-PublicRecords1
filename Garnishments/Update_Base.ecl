import liensv2;

export Update_Base(

	 string																			pversion
	,dataset(Layouts.Input.Layout_Liens_Hogan	)	pSprayedFile	= Files().Input.using
	,dataset(Layouts.Base											)	pBaseFile			= Files().base.qa

) :=
function

	dMap_it 								:= Map_Input(pSprayedFile);
	dStandardizedInputFile	:= Standardize_Input.fAll	(dMap_it						, pversion);
	dRemove_Deletes					:= Remove_Deletes(dStandardizedInputFile,pBaseFile);

	dAppendIds							:= Append_Ids.fAll				(dRemove_Deletes						);

	dRollup									:= Rollup_Base						(dAppendIds						);
	dappendBdid							:= Append_Company_Info		(dRollup);
	return dappendBdid;

end;
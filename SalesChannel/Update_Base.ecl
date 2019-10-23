export Update_Base(

	 string										pversion
	,dataset(Layouts.Input	)	pSprayedFile	= files().input.using
	,dataset(Layouts.Base_new)	pBaseFile			= Files().base.built			

) :=
function

	dPrep_Input		:= Prep_Input					(pversion			,pSprayedFile	);
	dIngest				:= Ingest							(dPrep_Input	,pBaseFile		).AllRecords_NoTag;
	dAppendAid		:= Append_Aid.fall		(dIngest										);
	dAppendDid		:= Append_Did					(dAppendAid									);
	dAppendBdid		:= Append_Bdid				(dAppendDid									);
	
	return dAppendBdid;

end;
export Update_File(
	 string														pversion
	,dataset(Layouts.Input.Sprayed	)	pSprayedFile
	,dataset(Layouts.Base						)	pBaseFile			= files().base.prod_thor.qa							
	
) :=
function

	dPrep_File		:= Prep_File				(pversion		,pSprayedFile		);
	dIngest				:= Ingest						(dPrep_File	,pBaseFile			).AllRecords_NoTag;
	dAppend_AID		:= Append_AID.fall	(dIngest				);
	dAppendBdids	:= Append_Bdid			(dAppend_AID		);
	
	return dAppendBdids;
end;

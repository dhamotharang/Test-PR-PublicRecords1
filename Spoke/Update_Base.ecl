export Update_Base(

	 dataset(layouts.Input.Sprayed	)	pUpdateFile
	,dataset(Layouts.Base						)	pBaseFile
	,string														pversion

) :=
function

	dStandardizedInputFile	:= Standardize_Input.fAll	(pUpdateFile						, pversion);
	update_combined					:= if(_Flags.Update
																,dStandardizedInputFile + pBaseFile
																,dStandardizedInputFile
															);

	dStandardize_Addr				:= Standardize_Addr				(update_combined			);
	dAppendIds							:= Append_Ids.fAll				(dStandardize_Addr		);
	dRollup									:= Rollup_Base						(dAppendIds						);

	return dRollup;

end;
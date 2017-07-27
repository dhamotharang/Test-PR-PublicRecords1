export Update_Unaffiliated_Individuals(

	 string																						pversion
	,dataset(layouts.Input.Sprayed									)	pUpdateFile	= Files().input.using
	,dataset(Layouts.Base.Unaffiliated_Individuals	)	pBaseFile		= Files().base.Unaffiliated_Individuals.qa

) :=
function

	dpreprocess							:= Parse_Input.PreProcess										(pUpdateFile		);
	dIndividuals						:= Parse_Input.Unaffiliated_Individuals			(dpreprocess			);
	dStandardizedInputFile	:= Standardize_Unaffiliated_Individuals.fAll(pversion,dIndividuals	);

	dupdate_combined					:= map(_Flags.Update.Unaffiliated_Individuals =>
																												dStandardizedInputFile + pBaseFile
																												,dStandardizedInputFile
																	);
															
	dStandardize_Addr				:= Standardize_Unaffiliated_Individuals_AID	(dupdate_combined);																
	drollup									:= Rollup_Unaffiliated_Individuals					(dStandardize_Addr);
	dAppend_Ids							:= Append_Ids.fAppendUnaffDid								(drollup				);

	return dAppend_Ids;

end;
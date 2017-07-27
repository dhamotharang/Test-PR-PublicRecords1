export Update_Affiliated_Individuals(

	 string																					pversion
	,dataset(layouts.Input.Sprayed								)	pUpdateFile		= Files().input.using
	,dataset(Layouts.Base.Affiliated_Individuals	)	pAffBaseFile	= files().base.Affiliated_Individuals.qa
	,dataset(Layouts.Base.Organizations						)	pOrgBaseFile	= files().base.Organizations.built					

) :=
function

	dpreprocess							:= Parse_Input.PreProcess									(pUpdateFile						);
	dpreprocessOrgs					:= Parse_Input.Organizations							(dpreprocess							);
	daffindiv								:= Parse_Input.Affiliated_Individuals			(dpreprocessOrgs					);
	dStandardizedInputFile	:= Standardize_Affiliated_Individuals.fAll(pversion,daffindiv	, pOrgBaseFile);
	dupdate_combined				:= map(_Flags.Update.Affiliated_Individuals =>	 dStandardizedInputFile + pAffBaseFile
																																					,dStandardizedInputFile
															);
															
	dStandardize_Addr				:= Standardize_Affiliated_Individuals_AID (dupdate_combined			);																
	drollup									:= Rollup_Affiliated_Individuals					(dStandardize_Addr);
	dAppend_Ids							:= Append_Ids.fAppendAffDid								(drollup	);

	return dAppend_Ids;

end;
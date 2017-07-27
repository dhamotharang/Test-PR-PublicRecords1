import tools;
export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
	,string		pDatasetName					= 'DNB'

) :=
module

	shared lkeyTemplate							:= _Constants(pUseOtherEnvironment,pDatasetName).keyTemplate			;
	shared lautokeytemplate			 		:= _Constants(pUseOtherEnvironment,pDatasetName).altautokeytemplate	;
	shared lautokeytemplatelogical	:= _Constants(pUseOtherEnvironment,pDatasetName).autokeytemplate		;

	export Bdid						:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'bdid'				,pversion);
	export Duns						:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'dunsnum'			,pversion);
	export autokeyroot		:= tools.mod_FilenamesBuild(lautokeytemplate									,pversion,lautokeytemplatelogical									);
	export addressb2			:= tools.mod_FilenamesBuild(lautokeytemplate + 'addressb2'		,pversion,lautokeytemplatelogical + 'addressb2'		);
	export citystnameb2		:= tools.mod_FilenamesBuild(lautokeytemplate + 'citystnameb2'	,pversion,lautokeytemplatelogical + 'citystnameb2');
	export nameb2					:= tools.mod_FilenamesBuild(lautokeytemplate + 'nameb2'				,pversion,lautokeytemplatelogical + 'nameb2'			);
	export namewords2			:= tools.mod_FilenamesBuild(lautokeytemplate + 'namewords2'		,pversion,lautokeytemplatelogical + 'namewords2'	);
	export payload				:= tools.mod_FilenamesBuild(lautokeytemplate + 'payload'			,pversion,lautokeytemplatelogical + 'payload'			);
	export phoneb2				:= tools.mod_FilenamesBuild(lautokeytemplate + 'phoneb2'			,pversion,lautokeytemplatelogical + 'phoneb2'			);
	export stnameb2				:= tools.mod_FilenamesBuild(lautokeytemplate + 'stnameb2'			,pversion,lautokeytemplatelogical + 'stnameb2'		);
	export zipb2	 				:= tools.mod_FilenamesBuild(lautokeytemplate + 'zipb2' 				,pversion,lautokeytemplatelogical + 'zipb2' 			);
	export LinkIds				:= tools.mod_FilenamesBuild(lkeyTemplate		 + 'linkIds'			,pversion);

	export dAll_filenames := 
		  Bdid.dAll_filenames
		+ Duns.dAll_filenames
		+ addressb2.dAll_filenames
		+ citystnameb2.dAll_filenames
		+ nameb2.dAll_filenames
		+ namewords2.dAll_filenames
		+ payload.dAll_filenames
		+ phoneb2.dAll_filenames
		+ stnameb2.dAll_filenames
		+ zipb2.dAll_filenames
		+ LinkIds.dAll_filenames
		;

end;

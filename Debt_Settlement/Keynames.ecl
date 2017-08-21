import tools;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lkeyTemplate		:= _Constants(pUseOtherEnvironment).keyTemplate			;
	shared lautokeytemplate := _Constants(pUseOtherEnvironment).autokeytemplate	;
	
	export Bdid						:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'bdid'				,pversion);
  export LinkIds				:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'linkids'			,pversion);	
	export autokeyroot		:= tools.mod_FilenamesBuild(lautokeytemplate									,pversion);
	export addressb2			:= tools.mod_FilenamesBuild(lautokeytemplate + 'addressb2'		,pversion);
	export citystnameb2		:= tools.mod_FilenamesBuild(lautokeytemplate + 'citystnameb2',pversion);
	export nameb2					:= tools.mod_FilenamesBuild(lautokeytemplate + 'nameb2'			,pversion);
	export namewords2			:= tools.mod_FilenamesBuild(lautokeytemplate + 'namewords2'	,pversion);
	export payload				:= tools.mod_FilenamesBuild(lautokeytemplate + 'payload'			,pversion);
	export phoneb2				:= tools.mod_FilenamesBuild(lautokeytemplate + 'phoneb2'			,pversion);
	export stnameb2				:= tools.mod_FilenamesBuild(lautokeytemplate + 'stnameb2'		,pversion);
	export zipb2	 				:= tools.mod_FilenamesBuild(lautokeytemplate + 'zipb2' 			,pversion);

	export dAll_filenames := 
		  Bdid.dAll_filenames
		+ LinkIds.dAll_filenames
		+ addressb2.dAll_filenames
		+ citystnameb2.dAll_filenames
		+ nameb2.dAll_filenames
		+ namewords2.dAll_filenames
		+ payload.dAll_filenames
		+ phoneb2.dAll_filenames
		+ stnameb2.dAll_filenames
		+ zipb2.dAll_filenames
		;

end;
import tools;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lkeyTemplate						:= Constants(pUseOtherEnvironment).keyTemplate						;
	shared loldkeytemplate				:= Constants(pUseOtherEnvironment).oldkeytemplate					;
	shared lautokeytemplate 			:= Constants(pUseOtherEnvironment).autokeytemplate				;
	shared loldautokeytemplate 		:= Constants(pUseOtherEnvironment).oldautokeytemplate			;

	export Bdid							:= tools.mod_FilenamesBuild(loldkeytemplate					+ '_bdid'				,pversion,lkeyTemplate				+ 'bdid'							);
	export addr							:= tools.mod_FilenamesBuild(loldkeytemplate					+ '_addr'				,pversion,lkeyTemplate				+ 'addr'							);
	export phone						:= tools.mod_FilenamesBuild(loldkeytemplate					+ '_phone'			,pversion,lkeyTemplate				+ 'phone'							);
	export linkids					:= tools.mod_FilenamesBuild(loldkeytemplate					+ '_linkids'		,pversion,lkeyTemplate				+ 'linkids'						);
	export autokeyroot			:= tools.mod_FilenamesBuild(loldautokeytemplate											,pversion,lautokeytemplate													);
	export address					:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'address'			,pversion,lautokeytemplate		+ 'address'						);
	export addressb2				:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'addressb2'		,pversion,lautokeytemplate		+ 'addressb2'					);
	export citystname				:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'citystname'	,pversion,lautokeytemplate		+ 'citystname'				);
	export citystnameb2			:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'citystnameb2',pversion,lautokeytemplate		+ 'citystnameb2'			);
	export name							:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'name'				,pversion,lautokeytemplate		+ 'name'							);
	export nameb2						:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'nameb2'			,pversion,lautokeytemplate		+ 'nameb2'						);
	export namewords2				:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'namewords2'	,pversion,lautokeytemplate		+ 'namewords2'				);
	export payload					:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'payload'			,pversion,lautokeytemplate		+ 'payload'						);
	export phone2						:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'phone2'			,pversion,lautokeytemplate		+ 'phone2'						);
	export phoneb2					:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'phoneb2'			,pversion,lautokeytemplate		+ 'phoneb2'						);
	export stname						:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'stname'			,pversion,lautokeytemplate		+ 'stname'						);
	export stnameb2					:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'stnameb2'		,pversion,lautokeytemplate		+ 'stnameb2'					);
	export zip							:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'zip'					,pversion,lautokeytemplate		+ 'zip'								);
	export zipb2	 					:= tools.mod_FilenamesBuild(loldautokeytemplate			+ 'zipb2' 			,pversion,lautokeytemplate		+ 'zipb2' 						);
                                                                                       			
	export dAll_filenames :=                                                   
		  Bdid.dAll_filenames
		+ addr.dAll_filenames
		+ phone.dAll_filenames
		+ linkids.dAll_filenames
		+ address.dAll_filenames
		+ addressb2.dAll_filenames
		+ citystname.dAll_filenames
		+ citystnameb2.dAll_filenames
		+ name.dAll_filenames
		+ nameb2.dAll_filenames
		+ namewords2.dAll_filenames
		+ payload.dAll_filenames
		+ phone2.dAll_filenames
		+ phoneb2.dAll_filenames
		+ stname.dAll_filenames
		+ stnameb2.dAll_filenames
		+ zip.dAll_filenames
		+ zipb2.dAll_filenames
		;

end;
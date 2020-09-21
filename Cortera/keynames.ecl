import tools;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lkeyTemplate		:= _Constants(pUseOtherEnvironment).keyTemplate;

	//export Bdid								:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'bdid'						,pversion);
	//export Did								:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'did'							,pversion);
	export LinkIds						:= tools.mod_FilenamesBuild(lkeyTemplate		+ 'linkIds'						,pversion);
	export Hdr_Link_Id				:= tools.mod_FilenamesBuild(lkeyTemplate		+ 'hdr_linkid'				,pversion);			
	export Attr_Link_Id				:= tools.mod_FilenamesBuild(lkeyTemplate		+ 'attr_linkid'				,pversion);			
	export Executive_Link_Id 	:= tools.mod_FilenamesBuild(lkeyTemplate		+ 'executive_linkid'	,pversion);

	export dAll_filenames := LinkIds.dAll_filenames
													+ Hdr_Link_Id.dAll_filenames
													+ Attr_Link_Id.dAll_filenames
													+ Executive_Link_Id.dAll_filenames
													;

end;
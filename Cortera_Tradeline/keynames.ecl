import tools;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lkeyTemplate		:= $._Constants(pUseOtherEnvironment).keyTemplate			;

	export LinkIds					:= tools.mod_FilenamesBuild(lkeyTemplate		+ 'linkIds'			,pversion);
	export Tradeline_Link_Id		:= tools.mod_FilenamesBuild(lkeyTemplate		+ 'tradeline_linkid',pversion);			
	
	export dAll_filenames := LinkIds.dAll_filenames
								+ Tradeline_Link_Id.dAll_filenames
								;

end;
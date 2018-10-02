import tools;

export Keynames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	shared lkeyTemplate	  := _Constants(pUseOtherEnvironment).keyTemplate;

	export LinkIds	      := tools.mod_FilenamesBuild(lkeyTemplate	+ 'linkIds'	,pversion);
	
	export dAll_filenames := LinkIds.dAll_filenames;

end;
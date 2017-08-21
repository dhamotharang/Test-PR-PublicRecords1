import tools;
export Keynames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module
	shared lkeyTemplate		:= _Constants(pUseOtherEnvironment).keyTemplate			;
	export Bdid						:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'bdid'				,pversion);
	export Bid						:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'bid'					,pversion);
	export Did						:= tools.mod_FilenamesBuild(lkeyTemplate			+ 'did'					,pversion);
	export dAll_filenames := 
		  Bdid.dAll_filenames
		+ Bid.dAll_filenames
		+ Did.dAll_filenames
		;
end;

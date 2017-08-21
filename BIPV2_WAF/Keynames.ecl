import tools;
export Keynames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	export lLogicalTmplt	 := _Constants(pUseOtherEnvironment).keyTemplate + 'proxid::'			;

	//new keys
  export WAFKey				 	 := tools.mod_FilenamesBuild(lLogicalTmplt	 + 'efr'	 ,pversion );


	export dAll_filenames := 
		  WAFKey.dAll_filenames
		;

end;

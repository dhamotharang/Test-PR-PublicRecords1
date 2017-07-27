import tools;
export Keynames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	export lLogicalTmplt	 := _Constants(pUseOtherEnvironment).keyTemplate + 'proxid::'			;
	//export lLogicalTmplt	 := '~thor_data400::key::BIPV2_WAF::proxid' + '::@version@::';

	//new keys
  export WAFKey				 	 := tools.mod_FilenamesBuild(lLogicalTmplt	 + 'efr'	 ,pversion );


	export dAll_filenames := 
		  WAFKey.dAll_filenames
		;

end;

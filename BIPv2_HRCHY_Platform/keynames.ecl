import tools;
export Keynames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	shared lfileprefix		:= _Constants(pUseOtherEnvironment).prefix	;

	export HrchyProxid      := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::BIPv2_HRCHY_Platform::key::@version@::proxid' ,pversion );
	export HrchyLgid 	      := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::BIPv2_HRCHY_Platform::key::@version@::LGID'   ,pversion );

	export dall_filenames := 
      HrchyProxid .dall_filenames
    + HrchyLgid 	.dall_filenames
    ;
    
end;
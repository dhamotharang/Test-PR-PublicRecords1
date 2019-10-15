import tools;
export Filenames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	shared lfileprefix		:= _Constants(pUseOtherEnvironment).prefix	;

	export base             := tools.mod_FilenamesBuild(lfileprefix + 'thor_data400::BIPv2_HRCHY_Platform::base::@version@::data'	 ,pversion);
	export wkhistory        := tools.mod_FilenamesBuild(lfileprefix + 'BIPv2_HRCHY_Platform::wkhistory::@version@::data'            ,pversion);

	export dall_filenames := 
      base.dall_filenames
    + wkhistory.dall_filenames
    ;
    
end;
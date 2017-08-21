import versioncontrol;

export Filenames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module
  
	export lInputFileTemplate	:= _Dataset(pUseOtherEnvironment).thor_cluster_files		+ 'in::'		+ _Dataset().name + '::@version@::data'	;
	export lFileTemplate	    := _Dataset(pUseOtherEnvironment).thor_cluster_files		+ 'base::'	+ _Dataset().name + '::@version@::data'	;

	export Input := versioncontrol.mInputFilenameVersions(lInputFileTemplate,'bctlpedata11.risk.regn.net'	);
	export Base  := versioncontrol.mBuildFilenameVersions(lFileTemplate			,pversion	);
                                                                        
	export dAll_filenames :=
		   Base.dAll_filenames 
	; 

end;
import versioncontrol;

export Keynames(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	export lFileTemplate	    := _Dataset(pUseOtherEnvironment).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::@version@::'	;

	export AddrZip  	:= versioncontrol.mBuildFilenameVersions(lFileTemplate + 'addr_search_zip'	,pversion	);
	export AddrState  := versioncontrol.mBuildFilenameVersions(lFileTemplate + 'addr_search_state',pversion	);
                                                                        
	export dAll_filenames :=
		  AddrZip.dAll_filenames
		+	AddrState.dAll_filenames
	; 

end;
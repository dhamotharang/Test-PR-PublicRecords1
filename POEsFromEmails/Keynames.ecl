import versioncontrol;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	export lFileTemplate	    := _Dataset(pUseOtherEnvironment).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::@version@::'	;
	
	shared lBdid		:= lFileTemplate + 'bdid'	;
	shared lDid			:= lFileTemplate + 'did'		;

	export Bdid		:= versioncontrol.mBuildFilenameVersions(lBdid	,pversion);
	export Did		:= versioncontrol.mBuildFilenameVersions(ldid		,pversion);

	export dAll_filenames := 
		  Bdid.dAll_filenames
		+ Did.dAll_filenames
		;

end;
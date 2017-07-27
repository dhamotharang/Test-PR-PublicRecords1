import tools;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	export lFileTemplate	    := _Dataset(pUseOtherEnvironment).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::@version@::'	;
	
	shared lBdid		:= lFileTemplate + 'bdid'	;
	shared lDid			:= lFileTemplate + 'did'	;
	shared lLinkIDs	:= lFileTemplate + 'linkids'	;

	export Bdid		:= tools.mod_FilenamesBuild(lBdid	    ,pversion);
	export Did		:= tools.mod_FilenamesBuild(ldid		  ,pversion);
	export LinkIDs:= tools.mod_FilenamesBuild(lLinkIDs	,pversion);


	export dAll_filenames := 
		  Bdid.dAll_filenames
		+ Did.dAll_filenames
		+ LinkIDs.dAll_filenames
		;

end;
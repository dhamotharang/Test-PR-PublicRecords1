import tools;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	export lFileTemplate	    := _Dataset(pUseOtherEnvironment).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::@version@::'	;
	
	shared lBdid		:= lFileTemplate + 'bdid'	;
	shared lLinkids	:= lFileTemplate + 'linkids'	;
	shared lDid			:= lFileTemplate + 'did'	;

	export Bdid		  := tools.mod_FilenamesBuild(lBdid	,pversion);
	export Linkids  := tools.mod_FilenamesBuild(lLinkids	,pversion);
	export Did		  := tools.mod_FilenamesBuild(ldid		,pversion);

	export dAll_filenames := 
		  Bdid.dAll_filenames
		+ Linkids.dAll_filenames
		+ Did.dAll_filenames
		;

end;
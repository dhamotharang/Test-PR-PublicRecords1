import tools;

export Keynames(

	 string		pversion							= '',
   boolean pUseProd = false

) :=
module

	export lFileTemplate	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::@version@::'	;
	export lFileTemplate_fcra	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::fcra::@version@::'	;
	
	shared lBdid		:= lFileTemplate + 'bdid'	;
	shared lDid			:= lFileTemplate + 'did'		;
	shared lDid_fcra:= lFileTemplate_fcra + 'did'		;
	shared llinkIDs	:= lFileTemplate + 'linkIds';
	
	export Bdid			:= tools.mod_FilenamesBuild(lBdid	,pversion);
	export Did			:= tools.mod_FilenamesBuild(ldid	,pversion);
	export Did_fcra	:= tools.mod_FilenamesBuild(ldid_fcra	,pversion);
	
	export LinkIds	:= tools.mod_FilenamesBuild(llinkIDs ,pversion);	
	
	export dAll_filenames := 
		  Bdid.dAll_filenames
		+ Did.dAll_filenames
		+ Did_fcra.dAll_filenames
		+ LinkIds.dAll_filenames
		;

end;
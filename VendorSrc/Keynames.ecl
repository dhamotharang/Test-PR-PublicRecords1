import tools;

export Keynames(

	 string		pversion							= '',
   boolean pUseProd = false

) :=
module

	export lFileTemplate	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::@version@::'	;
	
	shared lDid			:= lFileTemplate + 'did'		;

	export Did		:= tools.mod_FilenamesBuild(ldid	,pversion);

	export dAll_filenames := 

		Did.dAll_filenames
		;

end;
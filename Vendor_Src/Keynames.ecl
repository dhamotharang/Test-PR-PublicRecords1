﻿import tools;

export Keynames(string pversion	= '', boolean pUseProd = false) := module
   
	//export lFileTemplate        := '~thor_data400::key::vendor_src::@version@::';   
	
	export lFileTemplate	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ 'vendor_src_info' + '::@version@::'	;
	
	shared lDid			:= lFileTemplate + 'vendor_source'		;

	export source_code		:= tools.mod_FilenamesBuild(ldid	,pversion);

	export dAll_filenames := source_code.dAll_filenames;

end;
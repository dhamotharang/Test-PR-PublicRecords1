IMPORT tools;

EXPORT Keynames(

	 string		pversion							= '',
   boolean pUseProd = false

) :=
MODULE

	EXPORT koptrgtharv_lFileTemplate				:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::trgt_harv_results::@version@::'	;
	

	// state license keys - lnk_key, ....
	
	SHARED koptrgtharv_llnpid_key						:= koptrgtharv_lFileTemplate + 'lnpid';
	EXPORT koptrgtharv_lnpid_key						:= tools.mod_FilenamesBuild(koptrgtharv_llnpid_key	,pversion);
	EXPORT koptrgtharv_lnpid_dAll_filenames := koptrgtharv_lnpid_key.dAll_filenames;
	

	EXPORT koptrgtharv	:= koptrgtharv_lnpid_dAll_filenames;

	
END;
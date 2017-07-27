IMPORT tools;

EXPORT Keynames(

	 string		pversion							= '',
   boolean pUseProd = false

) := MODULE

	EXPORT Provider_lFileTemplate	:= _Dataset(pUseProd).thor_cluster_files+ 'key::'+ _Dataset().name + '::hms_Provider::@version@::'	;
	SHARED Provider_lPIID_key			:= Provider_lFileTemplate + 'Provider_PIID';
	EXPORT Provider_PIID_key			:= tools.mod_FilenamesBuild(Provider_lPIID_key	,pversion);
	EXPORT Provider_PIID_dAll_filenames:= Provider_PIID_key.dAll_filenames;
	//EXPORT PIID_Key	:= Provider_PIID_key.dAll_filenames;
	
	//EXPORT HMS_Provider_PIID_Key	:= Provider_lFileTemplate + 'Provider_PIID';
	

	
END;
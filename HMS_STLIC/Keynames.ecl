IMPORT tools;

EXPORT Keynames(

	 string		pversion							= '',
   boolean pUseProd = false

) :=
MODULE

	EXPORT statelicense_lFileTemplate				:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::hms_statelicense::@version@::'	;
	EXPORT stlicrollup_lFileTemplate				:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::hms_stlicrollup::@version@::'	;
	

	// state license keys - lnk_key, ....
	SHARED statelicense_llnk_key					:= statelicense_lFileTemplate + 'ln_key';
	EXPORT statelicense_lnk_key						:= tools.mod_FilenamesBuild(statelicense_llnk_key	,pversion);
	EXPORT statelicense_lnk_dAll_filenames:= statelicense_lnk_key.dAll_filenames;

	SHARED statelicense_llic_key						:= statelicense_lFileTemplate + 'license_number';
	EXPORT statelicense_lic_key							:= tools.mod_FilenamesBuild(statelicense_llic_key	,pversion);
	EXPORT statelicense_lic_dAll_filenames	:= statelicense_lic_key.dAll_filenames;
	
	SHARED statelicense_ldea_key						:= statelicense_lFileTemplate + 'dea_number';
	EXPORT statelicense_dea_key							:= tools.mod_FilenamesBuild(statelicense_ldea_key	,pversion);
	EXPORT statelicense_dea_dAll_filenames	:= statelicense_dea_key.dAll_filenames;
	
	SHARED statelicense_lnpi_key						:= statelicense_lFileTemplate + 'npi_number';
	EXPORT statelicense_npi_key							:= tools.mod_FilenamesBuild(statelicense_lnpi_key	,pversion);
	EXPORT statelicense_npi_dAll_filenames	:= statelicense_npi_key.dAll_filenames;
		
	SHARED statelicense_lzip_key						:= statelicense_lFileTemplate + 'zip';
	EXPORT statelicense_zip_key							:= tools.mod_FilenamesBuild(statelicense_lzip_key	,pversion);
	EXPORT statelicense_zip_dAll_filenames	:= statelicense_zip_key.dAll_filenames;
	
	SHARED statelicense_llnpid_key					:= statelicense_lFileTemplate + 'lnpid';
	EXPORT statelicense_lnpid_key						:= tools.mod_FilenamesBuild(statelicense_llnpid_key	,pversion);
	EXPORT statelicense_lnpid_dAll_filenames:= statelicense_lnpid_key.dAll_filenames;
	
	SHARED stlicrollup_lsourcerid_key					:= stlicrollup_lFileTemplate + 'source_rid';
	EXPORT stlicrollup_sourcerid_key						:= tools.mod_FilenamesBuild(stlicrollup_lsourcerid_key	,pversion);
	EXPORT stlicrollup_sourcerid_dAll_filenames:= stlicrollup_sourcerid_key.dAll_filenames;
	
	SHARED statelicense_lsourcerid_key						:= statelicense_lFileTemplate + 'source_rid';
	EXPORT statelicense_sourcerid_key							:= tools.mod_FilenamesBuild(statelicense_lsourcerid_key	,pversion);
	EXPORT statelicense_sourcerid_dAll_filenames	:= statelicense_sourcerid_key.dAll_filenames;
	
	
	EXPORT statelicense	:= statelicense_lnk_key.dAll_filenames
										+  statelicense_lic_key.dAll_filenames
										+  statelicense_dea_key.dAll_filenames
										+  statelicense_npi_key.dAll_filenames
										+	 statelicense_zip_dAll_filenames
										+  statelicense_lnpid_dAll_filenames
										+  statelicense_sourcerid_dAll_filenames
										+  stlicrollup_sourcerid_dAll_filenames;

	
END;
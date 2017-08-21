IMPORT tools;

EXPORT Keynames(

	 string		pversion							= '',
   boolean pUseProd = false

) :=
MODULE

	EXPORT csrcredential_lFileTemplate				:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::hms_csrcredential::@version@::'	;
	

	// state license keys - lnk_key, ....
	SHARED csrcredential_llnk_key					:= csrcredential_lFileTemplate + 'ln_key';
	EXPORT csrcredential_lnk_key						:= tools.mod_FilenamesBuild(csrcredential_llnk_key	,pversion);
	EXPORT csrcredential_lnk_dAll_filenames:= csrcredential_lnk_key.dAll_filenames;

	SHARED csrcredential_llic_key						:= csrcredential_lFileTemplate + 'license_number';
	EXPORT csrcredential_lic_key							:= tools.mod_FilenamesBuild(csrcredential_llic_key	,pversion);
	EXPORT csrcredential_lic_dAll_filenames	:= csrcredential_lic_key.dAll_filenames;
	
	SHARED csrcredential_ldea_key						:= csrcredential_lFileTemplate + 'dea_number';
	EXPORT csrcredential_dea_key							:= tools.mod_FilenamesBuild(csrcredential_ldea_key	,pversion);
	EXPORT csrcredential_dea_dAll_filenames	:= csrcredential_dea_key.dAll_filenames;
	
	SHARED csrcredential_lnpi_key						:= csrcredential_lFileTemplate + 'npi_number';
	EXPORT csrcredential_npi_key							:= tools.mod_FilenamesBuild(csrcredential_lnpi_key	,pversion);
	EXPORT csrcredential_npi_dAll_filenames	:= csrcredential_npi_key.dAll_filenames;
		
	SHARED csrcredential_lzip_key						:= csrcredential_lFileTemplate + 'zip';
	EXPORT csrcredential_zip_key							:= tools.mod_FilenamesBuild(csrcredential_lzip_key	,pversion);
	EXPORT csrcredential_zip_dAll_filenames	:= csrcredential_zip_key.dAll_filenames;
	
	SHARED csrcredential_llnpid_key					:= csrcredential_lFileTemplate + 'lnpid';
	EXPORT csrcredential_lnpid_key						:= tools.mod_FilenamesBuild(csrcredential_llnpid_key	,pversion);
	EXPORT csrcredential_lnpid_dAll_filenames:= csrcredential_lnpid_key.dAll_filenames;
	
	EXPORT csrcredential	:= csrcredential_lnk_key.dAll_filenames
										+  csrcredential_lic_key.dAll_filenames
										+  csrcredential_dea_key.dAll_filenames
										+  csrcredential_npi_key.dAll_filenames
										+	 csrcredential_zip_dAll_filenames
										+  csrcredential_lnpid_dAll_filenames;

	
END;
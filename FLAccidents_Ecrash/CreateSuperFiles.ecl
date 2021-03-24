	
	 CreateSFBase := SEQUENTIAL(	 
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_ECRASH_SF),	
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_ECRASH_FATHER),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::GRANDFATHER::' + Files_eCrash.SUFFIX_BASE_ECRASH),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::DELETE::' + Files_eCrash.SUFFIX_BASE_ECRASH),
	 
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_ClaimsClarity_SF),	
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_ClaimsClarity_FATHER),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::GRANDFATHER::' + Files_eCrash.SUFFIX_BASE_ClaimsClarity),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::DELETE::' + Files_eCrash.SUFFIX_BASE_ClaimsClarity),
	 
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_SUPPLEMENTAL_SF),	
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_SUPPLEMENTAL_FATHER),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::GRANDFATHER::' + Files_eCrash.SUFFIX_BASE_SUPPLEMENTAL),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::DELETE::' + Files_eCrash.SUFFIX_BASE_SUPPLEMENTAL),
	 
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_DOCUMENT_SF),	
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_DOCUMENT_FATHER),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::GRANDFATHER::' + Files_eCrash.SUFFIX_BASE_DOCUMENT),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::DELETE::' + Files_eCrash.SUFFIX_BASE_DOCUMENT),
	 
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_CRUVehicleIncidents_SF),	
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_CRUVehicleIncidents_FATHER),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::GRANDFATHER::' + Files_eCrash.SUFFIX_BASE_CRUVehicleIncidents),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::DELETE::' + Files_eCrash.SUFFIX_BASE_CRUVehicleIncidents),
	 
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_CONSOLIDATION_ECRASH_SF),	
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_CONSOLIDATION_ECRASH_FATHER),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::GRANDFATHER::' + Files_eCrash.SUFFIX_CONSOLIDATION_ECRASH),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::DELETE::' + Files_eCrash.SUFFIX_CONSOLIDATION_ECRASH),
	 
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_CONSOLIDATION_PR_SF),	
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_CONSOLIDATION_PR_FATHER),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::GRANDFATHER::' + Files_eCrash.SUFFIX_CONSOLIDATION_PR),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::DELETE::' + Files_eCrash.SUFFIX_CONSOLIDATION_PR),
	 
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_CONSOLIDATION_CRU_SF),	
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_CONSOLIDATION_CRU_FATHER),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::GRANDFATHER::' + Files_eCrash.SUFFIX_CONSOLIDATION_CRU),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::DELETE::' + Files_eCrash.SUFFIX_CONSOLIDATION_CRU),
	 
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_CONSOLIDATION_MBSAgency_SF),	
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.FILE_BASE_CONSOLIDATION_MBSAgency_FATHER),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::GRANDFATHER::' + Files_eCrash.SUFFIX_CONSOLIDATION_MBSAgency),
	 mod_Utilities.fn_CreateSuperFile(Files_eCrash.BASE_ECRASH_PREFIX + '::DELETE::' + Files_eCrash.SUFFIX_CONSOLIDATION_MBSAgency));
	 
  CreateSFKeys := SEQUENTIAL(			
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_dlnnbrdlstate_qa'),											 
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_dlnnbrdlstate_built'),											 
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_dlnnbrdlstate_father'),						
	                     mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_dlnnbrdlstate_grandfather'),											 
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_dlnnbrdlstate_delete'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_licenseplatenbr_qa'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_licenseplatenbr_built'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_licenseplatenbr_father'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_licenseplatenbr_grandfather'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_licenseplatenbr_delete'),
											 mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_officerbadgenbr_qa'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_officerbadgenbr_built'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_officerbadgenbr_father'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_officerbadgenbr_grandfather'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_officerbadgenbr_delete'),
											 mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_vinnbr_qa'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_vinnbr_built'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_vinnbr_father'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_vinnbr_grandfather'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_vinnbr_delete'),
											 mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_Unrestricted_accnbrv1_qa'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_Unrestricted_accnbrv1_built'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_Unrestricted_accnbrv1_father'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_Unrestricted_accnbrv1_grandfather'),
                       mod_Utilities.fn_CreateSuperFile('~thor_data400::key::ecrashv2_Unrestricted_accnbrv1_delete')
                       );

  CreateSF := SEQUENTIAL(CreateSFBase, CreateSFKeys);
	
	EXPORT CreateSuperFiles := CreateSF;
	
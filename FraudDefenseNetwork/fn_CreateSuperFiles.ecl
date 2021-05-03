IMPORT tools, STD, dx_FraudDefenseNetwork;

EXPORT fn_CreateSuperFiles() := FUNCTION	

  CreateSpray_SF := tools.mod_Utilities.createinputsupers(filenames().Input.dAll_filenames);																													
  CreateKeys_SF := SEQUENTIAL(			
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.ID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.ID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.ID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.ID_SUFFIX),											 
                       
											 
											 mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.DID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.DID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.DID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.DID_SUFFIX),
											 
											 mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.IP_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.IP_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.IP_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.IP_SUFFIX),
											 
											 mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.EMAIL_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.EMAIL_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.EMAIL_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.EMAIL_SUFFIX),
											 
											 mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.PROFESSIONALID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.PROFESSIONALID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.PROFESSIONALID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.PROFESSIONALID_SUFFIX),
											 
											 mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.DEVICEID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.DEVICEID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.DEVICEID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.DEVICEID_SUFFIX),
											 
											 mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.TIN_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.TIN_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.TIN_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.TIN_SUFFIX),
											 
											 mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.NPI_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.NPI_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.NPI_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.NPI_SUFFIX),
											 
											 mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.APPPROVIDERID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.APPPROVIDERID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.APPPROVIDERID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.APPPROVIDERID_SUFFIX),
											 
											 mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.LNPID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.LNPID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.LNPID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.LNPID_SUFFIX),
											 
											 mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.MBS_INDTYPE_EXCLUSION_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.MBS_INDTYPE_EXCLUSION_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.MBS_INDTYPE_EXCLUSION_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.MBS_INDTYPE_EXCLUSION_SUFFIX),
											 
		                   mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.MBS_PRODUCT_INCLUDE_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.MBS_PRODUCT_INCLUDE_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.MBS_PRODUCT_INCLUDE_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.MBS_PRODUCT_INCLUDE_SUFFIX),
											 
											 mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_SUFFIX),
											 
											 mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_EXCL_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_EXCL_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_EXCL_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_EXCL_SUFFIX),
											 
											 mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::built::' + dx_FraudDefenseNetwork.Names.LINKIDS_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::qa::' + dx_FraudDefenseNetwork.Names.LINKIDS_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::father::' + dx_FraudDefenseNetwork.Names.LINKIDS_SUFFIX),											 
                       mod_Utilities.fn_CreateSuperFile(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::grandfather::' + dx_FraudDefenseNetwork.Names.LINKIDS_SUFFIX)
                       );
											 
  CreateSF := SEQUENTIAL(createSpray_SF, CreateKeys_SF);

	RETURN CreateSF	;

END;
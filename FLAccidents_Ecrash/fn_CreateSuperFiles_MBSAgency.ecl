EXPORT fn_CreateSuperFiles_MBSAgency() := FUNCTION	

  CreateSprayAgency_SF := SEQUENTIAL(mod_Utilities.fn_CreateSuperFile(Files_MBSAgency.FILE_SPRAY_AGENCY_SF));

	CreateBaseAgencySF := SEQUENTIAL(
																	mod_Utilities.fn_CreateSuperFile(Files_MBSAgency.FILE_BASE_AGENCY_SF),	
																	mod_Utilities.fn_CreateSuperFile(Files_MBSAgency.FILE_BASE_AGENCY_FATHER_SF),	
																	mod_Utilities.fn_CreateSuperFile(Files_MBSAgency.FILE_BASE_AGENCY_GRANDFATHER_SF));			 											 
	
	CreateSF := SEQUENTIAL(createSprayAgency_SF, CreateBaseAgencySF);
	
	
	RETURN CreateSF	;


END;
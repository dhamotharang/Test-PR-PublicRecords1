//fn_CreateSuperFiles

IMPORT STD;
fileservices := STD.File;

CreateSuperFile(STRING File) := IF (~FileServices.FileExists(TRIM(File, LEFT, RIGHT)), FileServices.CreateSuperFile(TRIM(File, LEFT, RIGHT)));
																																	
CreateSuperBaseFile(STRING Prefix, STRING Ver,  STRING Suffix) := IF (~FileServices.FileExists(TRIM(Prefix, LEFT, RIGHT) + '::' + TRIM(Ver, LEFT, RIGHT) + '::' + TRIM(Suffix, LEFT, RIGHT)), 
                                                                      FileServices.CreateSuperFile(TRIM(Prefix, LEFT, RIGHT) + '::' + TRIM(Ver, LEFT, RIGHT) + '::' + TRIM(Suffix, LEFT, RIGHT)));

EXPORT fn_CreateSuperFiles() := FUNCTION


  createSpraySF := SEQUENTIAL(
	                     CreateSuperFile(Files_NAccidentsInquiry.SPRAY_CLIENT_BASE_FILE),	
											 CreateSuperFile(Files_NAccidentsInquiry.SPRAY_INT_ORDER_BASE_FILE),											 
                       CreateSuperFile(Files_NAccidentsInquiry.SPRAY_ORDER_VERSION_BASE_FILE),											 
                       CreateSuperFile(Files_NAccidentsInquiry.SPRAY_VEHICLE_PARTY_BASE_FILE),											 
                       CreateSuperFile(Files_NAccidentsInquiry.SPRAY_VEHICLE_INCIDENT_BASE_FILE),
                       CreateSuperFile(Files_NAccidentsInquiry.SPRAY_VEHICLE_BASE_FILE),
											 CreateSuperFile(Files_NAccidentsInquiry.SPRAY_RESULT_BASE_FILE),
											 CreateSuperFile(Files_NAccidentsInquiry.SPRAY_VEHICLE_INSCR_BASE_FILE)
                       );

  createBaseSF := SEQUENTIAL(
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'QA', Files_NAccidentsInquiry.SUFFIX_NAME_CLIENT),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'FATHER', Files_NAccidentsInquiry.SUFFIX_NAME_CLIENT),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'GRANDFATHER', Files_NAccidentsInquiry.SUFFIX_NAME_CLIENT),
											 
											 CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'QA', Files_NAccidentsInquiry.SUFFIX_NAME_INT_ORDER),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'FATHER', Files_NAccidentsInquiry.SUFFIX_NAME_INT_ORDER),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'GRANDFATHER', Files_NAccidentsInquiry.SUFFIX_NAME_INT_ORDER),
											 
											 CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'QA', Files_NAccidentsInquiry.SUFFIX_NAME_ORDER_VERSION),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'FATHER', Files_NAccidentsInquiry.SUFFIX_NAME_ORDER_VERSION),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'GRANDFATHER', Files_NAccidentsInquiry.SUFFIX_NAME_ORDER_VERSION),
											 
											 CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'QA', Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE_PARTY),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'FATHER', Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE_PARTY),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'GRANDFATHER', Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE_PARTY),
											 
											 CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'QA', Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE_INCIDENT),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'FATHER', Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE_INCIDENT),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'GRANDFATHER', Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE_INCIDENT),
											 
											 CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'QA', Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'FATHER', Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'GRANDFATHER', Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE),
											 
											 CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'QA', Files_NAccidentsInquiry.SUFFIX_NAME_RESULT),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'FATHER', Files_NAccidentsInquiry.SUFFIX_NAME_RESULT),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'GRANDFATHER', Files_NAccidentsInquiry.SUFFIX_NAME_RESULT),
											 
											 CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'QA', Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE_INSCR),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'FATHER', Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE_INSCR),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'GRANDFATHER', Files_NAccidentsInquiry.SUFFIX_NAME_VEHICLE_INSCR),
											 
											 CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'QA', Files_NAccidentsInquiry.SUFFIX_NAME_ACCIDENTS_BASE),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'FATHER', Files_NAccidentsInquiry.SUFFIX_NAME_ACCIDENTS_BASE),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'GRANDFATHER', Files_NAccidentsInquiry.SUFFIX_NAME_ACCIDENTS_BASE),
											 
											 CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'QA', Files_NAccidentsInquiry.SUFFIX_NAME_INQUIRY_BASE),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'FATHER', Files_NAccidentsInquiry.SUFFIX_NAME_INQUIRY_BASE),	
	                     CreateSuperBaseFile(Files_NAccidentsInquiry.BASE_PREFIX, 'GRANDFATHER', Files_NAccidentsInquiry.SUFFIX_NAME_INQUIRY_BASE));
											 
	
	createSF := SEQUENTIAL(createSpraySF, createBaseSF);
	
	RETURN createSF;


END;
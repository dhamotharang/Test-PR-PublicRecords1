IMPORT doxie, ut, Data_Services, STD;

EXPORT Keys := MODULE

  EXPORT did_key := index(Files.file_did(did<>0), {l_did},{Files.file_did}, Constants.KEY_PREFIX + doxie.Version_SuperKey + '::did');                                                
  																	
	EXPORT Phone_key := index(Files.file_Phone,{Phone}, {Files.file_Phone},	Constants.KEY_PREFIX + doxie.Version_SuperKey + '::Phone');
																		
																		
END;
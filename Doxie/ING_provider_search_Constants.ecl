IMPORT ut;

EXPORT ING_provider_search_Constants := 
   MODULE

	   EXPORT AUTOKEY_NAME            := doxie.ING_provider_search_Cluster + 'key::ingenix_providers_';
	   EXPORT AUTOKEY_SKIP_SET	       := ['B','F','P','Q','S'];  // B: Skip Biz Data
		                                                          // C: Skip Person Contact Data
																					 // F: Skip FEIN
																					 // P: Skip Personal Phones
																					 // Q: Skip Biz Phones
																					 // S: Skip SSN
	   EXPORT TYPE_STR	             := 'AK';
	   EXPORT BOOLEAN WORK_HARD       := TRUE; 
	   EXPORT BOOLEAN NO_FAIL         := TRUE;
	   EXPORT BOOLEAN USE_ALL_LOOKUPS := FALSE;
		EXPORT STRING10  LOOKUP_TYPE   := 'PROV';
       		
END;
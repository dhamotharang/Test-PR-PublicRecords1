
IMPORT ut;

EXPORT ING_sanctions_search_Constants := 
   MODULE

	   EXPORT AUTOKEY_NAME            := doxie.ING_sanctions_search_Cluster + 'key::ingenix_sanctions_';
	   EXPORT AUTOKEY_SKIP_SET	       := ['B','F','Q', 'P','S']; // B: Skip Biz Data
		                                                          // C: Skip Person Contact Data
																					 // F: Skip FEIN 
																					 // P: Skip Personal Phones
																					 // Q: Skip Biz Phones
																					 // S: Skip SSN
	   EXPORT TYPE_STR	             := 'AK';
	   EXPORT BOOLEAN WORK_HARD       := TRUE; 
	   EXPORT BOOLEAN NO_FAIL         := TRUE;
	   EXPORT BOOLEAN USE_ALL_LOOKUPS := FALSE;
		EXPORT STRING10 LOOKUP_TYPE    := 'SANC';

END;
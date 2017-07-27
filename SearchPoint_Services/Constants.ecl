IMPORT Data_Services,doxie,ut,CNLD_Facilities, Ingenix_NatlProf, NCPDP;

EXPORT Constants := 
   MODULE
      
      EXPORT RecordLimit := 400; /* when a fein key search or zip code autokey search is done, the fids can exponentially increase the 
                                    number of pids returned.  Limiting the number of records returned at the first level 
                                    reduces (hopefully eliminates) the possibility of a "memory limit exceeded" error. */
      
      // Creating a hierachy for the data sources used for sorting purposes.
      // Sources: 1 = Ingenix (preferred source)
      //          2 = NCPDP (National Council for Prescription Drug Programs)
      //          3 = CNLD (ChoicePoint National License Database)
      EXPORT ingenixSourceRank    := 1;
      EXPORT ncpdpSourceRank      := 2;
      EXPORT cnldSourceRank       := 3;
      EXPORT ncpdpDefaultAddrRank := 1;
      
      EXPORT CnldAutoKey :=
         MODULE
           EXPORT AUTOKEY_NAME                    := CNLD_Facilities.constants.ak_qa_keyname;
	         EXPORT AUTOKEY_SKIP_SET	              := CNLD_Facilities.constants.set_skip;          // B:  Skip Biz Data -- If 'B' is not used in the skip set
                                                                                                  //     then one of the following two can be used to
                                                                                                  //     further restrict the Business autokey skip set. 
                                                                                                  //     If 'B' is included in the skip set, then no business
                                                                                                  //     data is searchedand the following two are not necessary
                                                                                                  //     in the skip set.
		                                                                                              // F: Skip FEIN
																															                                    // Q: Skip Biz Phones
																															                                    // C: Skip Person Contact Data -- If 'C' is not used in the skip set
                                                                                                  //     then one of the following two can be used to
                                                                                                  //     further restrict the Person contact autokey skip set. 
                                                                                                  //     If 'C' is included in the skip set, then no Personal
                                                                                                  //     data is searched and the following two are not necessary
                                                                                                  //     in the skip set.
																															                                    // P: Skip Personal Phones
																															                                    // S: Skip SSN
	         EXPORT TYPE_STR	                     	:= 'AK'; 	// Auto Key
	         EXPORT BOOLEAN WORK_HARD               := TRUE; 	// deep dive 
	         EXPORT BOOLEAN NO_FAIL                 := TRUE; 	// 
	         EXPORT BOOLEAN USE_ALL_LOOKUPS         := TRUE; 	// takes into account the "lookup bit" (? Not sure what this means)		      
      END; // CNLD Autokey module 		


      EXPORT IngenixAutoKey :=
         MODULE
           EXPORT AUTOKEY_NAME       	            := Ingenix_NatlProf.Constants.autokey_qa_name_prov;
	         EXPORT AUTOKEY_SKIP_SET	              := Ingenix_NatlProf.Constants.autokey_skip_set_prov;          
	         EXPORT TYPE_STR	                      := Ingenix_NatlProf.Constants.autokey_typeStr_prov; // Auto Key
	         EXPORT BOOLEAN WORK_HARD               := TRUE;            // deep dive 
	         EXPORT BOOLEAN NO_FAIL                 := TRUE;            // 
	         EXPORT BOOLEAN USE_ALL_LOOKUPS         := TRUE;            // takes into account the "lookup bit" (????)
      END; // Ingenix Autokey module 
			

      EXPORT NCPDP_AutoKey :=
         MODULE
           EXPORT ContLegalMail_AutoKey           := NCPDP.Constants().ak_qa_keyname_ContLegalPhys;
	         EXPORT ContLegalMail_AUTOKEY_SKIP_SET	:= ['B', 'S'];
	         EXPORT ContLegalMail_TYPE_STR	        := 'AK'; 		// Auto Key
																																
           EXPORT ContLegalPhys_AutoKey           := NCPDP.Constants().ak_qa_keyname_ContLegalPhys;
	         EXPORT ContLegalPhys_AUTOKEY_SKIP_SET	:= ['B', 'S'];
	         EXPORT ContLegalPhys_TYPE_STR	        := 'AK'; 		// Auto Key
            
           EXPORT DBA_Mail_AUTOKEY_NAME    	      := NCPDP.Constants().ak_qa_keyname_DBAMail;
	         EXPORT DBA_Mail_AUTOKEY_SKIP_SET       := NCPDP.Constants().ak_skipSet_DBAMail;  
	         EXPORT DBA_Mail_TYPE_STR	              := 'AK';    // Auto Key
		      					
					 EXPORT DBA_Phys_AUTOKEY_NAME           := NCPDP.Constants().ak_qa_keyname_DBAPhys;
	         EXPORT DBA_Phys_AUTOKEY_SKIP_SET	      := NCPDP.Constants().ak_skipSet_DBAPhys; 
	         EXPORT DBA_Phys_TYPE_STR	              := 'AK';    	// Auto Key
            
					 EXPORT BOOLEAN WORK_HARD       	      := TRUE;    // deep dive 
	         EXPORT BOOLEAN NO_FAIL         	      := TRUE;    // 
	         EXPORT BOOLEAN USE_ALL_LOOKUPS 	      := TRUE;    // takes into account the "lookup bit" (????)
            
      END; // End of NCPDP Autokey module 

END;
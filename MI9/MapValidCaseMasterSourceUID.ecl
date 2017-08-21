

																															
export MapValidCaseMasterSourceUID :=                         										 
																MapSourceUIDValidation (REGEXFIND('Error',SOURCE_UID_C,NOCASE)=false)
																                    : persist ('~thor_data400::persist::out::crim::cross_soff::MapValidCaseMasterSourceUID');									 
																										             

																															
export MapValidCaseMasterSourceUID :=                         										 
																MapSourceUIDValidation (REGEXFIND('Error',SOURCE_UID_C,NOCASE)=false)
																                    : persist ('~thor_data400::persist::out::crim::cross_aoc_and_county::MapValidCaseMasterSourceUID');									 
																										             

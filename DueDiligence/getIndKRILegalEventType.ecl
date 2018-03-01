IMPORT DueDiligence, STD, ut;

EXPORT getIndKRILegalEventType(DueDiligence.Layouts.Indv_Internal indv) := FUNCTION

		/* PERSON LEGAL EVENT TYPE */ 
		legalEventTypeFlag9 := IF(indv.atleastOneCategory9, 'T', 'F');                                                            		 
		legalEventTypeFlag8 := IF(indv.atleastOneCategory8, 'T', 'F');                                		 
		legalEventTypeFlag7 := IF(indv.atleastOneCategory7, 'T', 'F');  
		legalEventTypeFlag6 := IF(indv.atleastOneCategory6, 'T', 'F');   
		legalEventTypeFlag5 := IF(indv.atleastOneCategory5, 'T', 'F');   
		legalEventTypeFlag4 := IF(indv.atleastOneCategory4, 'T', 'F'); 
		legalEventTypeFlag3 := IF(indv.atleastOneCategory3, 'T', 'F');   
		legalEventTypeFlag2 := IF(indv.atleastOneCategory2, 'T', 'F');  
		legalEventTypeFlag1 := IF(indv.atleastOneCategory9 = FALSE AND indv.atleastOneCategory8 = FALSE AND
																													indv.atleastOneCategory7 = FALSE AND indv.atleastOneCategory6 = FALSE AND
																													indv.atleastOneCategory5 = FALSE AND indv.atleastOneCategory4 = FALSE AND
																													indv.atleastOneCategory3 = FALSE AND indv.atleastOneCategory2 = FALSE, 'T', 'F');                               	 
		
		legalEventTypeConcat := legalEventTypeFlag9 + legalEventTypeFlag8 + legalEventTypeFlag7 + legalEventTypeFlag6 + legalEventTypeFlag5 + legalEventTypeFlag4 + legalEventTypeFlag3 + legalEventTypeFlag2 + legalEventTypeFlag1;
		legalEventTypeFlag0 := IF(STD.Str.Find(legalEventTypeConcat, 'T', 1) = 0, 'T', 'F');  //Insufficient information reported on person and cannot calculate
		
		legalEventTypeConcat_Final := legalEventTypeConcat + legalEventTypeFlag0;

		perLegalEventType_Flag := legalEventTypeConcat_Final;
		perLegalEventType  := (STRING)(10-STD.Str.Find(legalEventTypeConcat_Final, 'T', 1)); 
		
		
		RETURN DueDiligence.Common.createNVPair(perLegalEventType, perLegalEventType_Flag);

END;
IMPORT DueDiligence, STD;

EXPORT getIndKRILegalEventType(DueDiligence.Layouts.Indv_Internal indv) := FUNCTION

		/* PERSON LEGAL EVENT TYPE */ 
		legalEventTypeFlag9 := IF(indv.atleastOneCategory9, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                                            		 
		legalEventTypeFlag8 := IF(indv.atleastOneCategory8, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                		 
		legalEventTypeFlag7 := IF(indv.atleastOneCategory7, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);  
		legalEventTypeFlag6 := IF(indv.atleastOneCategory6, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);   
		legalEventTypeFlag5 := IF(indv.atleastOneCategory5, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);   
		legalEventTypeFlag4 := IF(indv.atleastOneCategory4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
		legalEventTypeFlag3 := IF(indv.atleastOneCategory3, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);   
		legalEventTypeFlag2 := IF(indv.atleastOneCategory2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);  
		legalEventTypeFlag1 := IF(indv.atleastOneCategory9 = FALSE AND indv.atleastOneCategory8 = FALSE AND
                                indv.atleastOneCategory7 = FALSE AND indv.atleastOneCategory6 = FALSE AND
                                indv.atleastOneCategory5 = FALSE AND indv.atleastOneCategory4 = FALSE AND
                                indv.atleastOneCategory3 = FALSE AND indv.atleastOneCategory2 = FALSE AND
                                indv.atleastOneCategory0 = FALSE, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                               	 
		
		legalEventTypeConcat := legalEventTypeFlag9 + legalEventTypeFlag8 + legalEventTypeFlag7 + legalEventTypeFlag6 + legalEventTypeFlag5 + legalEventTypeFlag4 + legalEventTypeFlag3 + legalEventTypeFlag2 + legalEventTypeFlag1;
		legalEventTypeFlag0 := IF(indv.atleastOneCategory0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);  //Uncategorized offenses
		
		legalEventTypeConcat_Final := legalEventTypeConcat + legalEventTypeFlag0;

		perLegalEventType_Flag := legalEventTypeConcat_Final;
		perLegalEventType  := (STRING)(10-STD.Str.Find(legalEventTypeConcat_Final, DueDiligence.Constants.T_INDICATOR, 1)); 
		
		
		RETURN DueDiligence.Common.createNVPair(perLegalEventType, perLegalEventType_Flag);

END;
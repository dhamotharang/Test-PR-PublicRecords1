IMPORT DueDiligence, STD;

EXPORT getIndKRILegalStateCriminal(DueDiligence.Layouts.Indv_Internal indv) := FUNCTION

		/* PERSON STATE LEGAL EVENT */ 
		legalStateCriminalFlag9 := IF(indv.currentIncarcerationOrParole, 'T', 'F');                                                            		 
		legalStateCriminalFlag8 := IF(indv.felonyPast3Yrs, 'T', 'F');                                		 
		legalStateCriminalFlag7 := IF(indv.felonyOver3Yrs, 'T', 'F');  
		legalStateCriminalFlag6 := IF(indv.previousIncarceration, 'T', 'F');   
		legalStateCriminalFlag5 := IF(indv.uncategorizedConvictionPast3Yrs, 'T', 'F');   
		legalStateCriminalFlag4 := IF(indv.misdemeanorConvictionPast3Yrs, 'T', 'F'); 
		legalStateCriminalFlag3 := IF(indv.uncategorizedConvictionOver3Yrs, 'T', 'F');   
		legalStateCriminalFlag2 := IF(indv.misdemeanorConvictionOver3Years, 'T', 'F');  
		legalStateCriminalFlag1 := IF(indv.currentIncarcerationOrParole = FALSE AND indv.felonyPast3Yrs = FALSE AND
                                  indv.felonyOver3Yrs = FALSE AND indv.previousIncarceration = FALSE AND
                                  indv.uncategorizedConvictionPast3Yrs = FALSE AND indv.misdemeanorConvictionPast3Yrs = FALSE AND
                                  indv.uncategorizedConvictionOver3Yrs = FALSE AND indv.misdemeanorConvictionOver3Years = FALSE, 'T', 'F');                               	 
		
		legalStateCriminalConcat := legalStateCriminalFlag9 + legalStateCriminalFlag8 + legalStateCriminalFlag7 + legalStateCriminalFlag6 + legalStateCriminalFlag5 + legalStateCriminalFlag4 + legalStateCriminalFlag3 + legalStateCriminalFlag2 + legalStateCriminalFlag1;
		legalStateCriminalFlag0 := IF(STD.Str.Find(legalStateCriminalConcat, 'T', 1) = 0, 'T', 'F');  //Insufficient information reported on person and cannot calculate
		
		legalStateCriminalConcat_Final := legalStateCriminalConcat + legalStateCriminalFlag0;

		perStateLegalEvent_Flag := legalStateCriminalConcat_Final;
		perStateLegalEvent  := (STRING)(10-STD.Str.Find(legalStateCriminalConcat_Final, 'T', 1)); 
		
		
		RETURN DueDiligence.Common.createNVPair(perStateLegalEvent, perStateLegalEvent_Flag);
END;
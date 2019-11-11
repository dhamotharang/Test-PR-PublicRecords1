IMPORT DueDiligence, STD;

EXPORT getIndKRILegalStateCriminal(DueDiligence.Layouts.Indv_Internal indv) := FUNCTION

    /* PERSON STATE LEGAL EVENT */ 
    legalStateCriminalFlag9 := IF(indv.currentIncarceration, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);                                                            		 
    legalStateCriminalFlag8 := IF(indv.felonyConvictionPast3Yrs, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);                                		 
    legalStateCriminalFlag7 := IF(indv.felonyConvictionOver3YrsOrNoDate, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);  
    legalStateCriminalFlag6 := IF(indv.previousIncarcerationOrParoleOrProbation, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);   
    legalStateCriminalFlag5 := IF(indv.nonFelonyConvictionPast3Yrs, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);   
    legalStateCriminalFlag4 := IF(indv.nonFelonyConvictionOver3YrsOrNoDate, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR); 
    legalStateCriminalFlag3 := IF(indv.felonyNotConvicted, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);   
    legalStateCriminalFlag2 := IF(indv.nonFelonyNotConvicted, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);  

    legalStateCriminalFlag1 := IF(indv.currentIncarceration = FALSE AND indv.felonyConvictionPast3Yrs = FALSE AND
                                  indv.felonyConvictionOver3YrsOrNoDate = FALSE AND indv.previousIncarcerationOrParoleOrProbation = FALSE AND
                                  indv.nonFelonyConvictionPast3Yrs = FALSE AND indv.nonFelonyConvictionOver3YrsOrNoDate = FALSE AND
                                  indv.felonyNotConvicted = FALSE AND indv.nonFelonyNotConvicted = FALSE, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);                               	 
                                  
                                  
     legalStateCriminal_final := DueDiligence.Common.calcFinalFlagField(legalStateCriminalFlag9,
                                                                        legalStateCriminalFlag8,
                                                                        legalStateCriminalFlag7,
                                                                        legalStateCriminalFlag6,
                                                                        legalStateCriminalFlag5,
                                                                        legalStateCriminalFlag4,
                                                                        legalStateCriminalFlag3,
                                                                        legalStateCriminalFlag2,
                                                                        legalStateCriminalFlag1);                              

    perStateLegalEvent_Flag := legalStateCriminal_final;
    perStateLegalEvent  := (STRING)(10-STD.Str.Find(legalStateCriminal_final, DueDiligence.Constants.T_INDICATOR, 1));


    RETURN DueDiligence.Common.createNVPair(perStateLegalEvent, perStateLegalEvent_Flag);
END;
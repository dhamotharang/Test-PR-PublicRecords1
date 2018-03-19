IMPORT DueDiligence, STD, ut;

EXPORT getIndKRILegalTrafficInfraction(DueDiligence.Layouts.Indv_Internal indv) := FUNCTION

		/* PERSON LEGAL TRAFFIC & INFRACTIONS */ 
		legalTrafficInfractionFlag9 := IF(indv.threePlusTrafConvictPast3Yrs, 'T', 'F');                                                            		 
		legalTrafficInfractionFlag8 := IF(indv.twoOrLessTrafConvictPast3Yrs, 'T', 'F');                                		 
		legalTrafficInfractionFlag7 := IF(indv.threePlusInfractConvictPast3Yrs, 'T', 'F');  
		legalTrafficInfractionFlag6 := IF(indv.twoOrLessInfractConvictPast3Yrs, 'T', 'F');   
		legalTrafficInfractionFlag5 := IF(indv.threePlusTrafConvictOver3Yrs, 'T', 'F');   
		legalTrafficInfractionFlag4 := IF(indv.twoOrLessTrafConvictOver3Yrs, 'T', 'F'); 
		legalTrafficInfractionFlag3 := IF(indv.threePlusInfractConvictOver3Yrs, 'T', 'F');   
		legalTrafficInfractionFlag2 := IF(indv.twoOrLessInfractConvictOver3Yrs, 'T', 'F');  
		legalTrafficInfractionFlag1 := IF(indv.threePlusTrafConvictPast3Yrs = FALSE AND indv.twoOrLessTrafConvictPast3Yrs = FALSE AND
                                      indv.threePlusInfractConvictPast3Yrs = FALSE AND indv.twoOrLessInfractConvictPast3Yrs = FALSE AND
                                      indv.threePlusTrafConvictOver3Yrs = FALSE AND indv.twoOrLessTrafConvictOver3Yrs = FALSE AND
                                      indv.threePlusInfractConvictOver3Yrs = FALSE AND indv.twoOrLessInfractConvictOver3Yrs = FALSE, 'T', 'F');                               	 
		
		legalTrafficInfractionConcat := legalTrafficInfractionFlag9 + legalTrafficInfractionFlag8 + legalTrafficInfractionFlag7 + legalTrafficInfractionFlag6 + legalTrafficInfractionFlag5 + legalTrafficInfractionFlag4 + legalTrafficInfractionFlag3 + legalTrafficInfractionFlag2 + legalTrafficInfractionFlag1;
		legalTrafficInfractionFlag0 := IF(STD.Str.Find(legalTrafficInfractionConcat, 'T', 1) = 0, 'T', 'F');  //Insufficient information reported on person and cannot calculate
		
		legalTrafficInfractionConcat_Final := legalTrafficInfractionConcat + legalTrafficInfractionFlag0;

		perLegalTrafficInfraction_Flag := legalTrafficInfractionConcat_Final;
		perLegalTrafficInfractionType  := (STRING)(10-STD.Str.Find(legalTrafficInfractionConcat_Final, 'T', 1)); 
		
		
		RETURN DueDiligence.Common.createNVPair(perLegalTrafficInfractionType, perLegalTrafficInfraction_Flag);

END;
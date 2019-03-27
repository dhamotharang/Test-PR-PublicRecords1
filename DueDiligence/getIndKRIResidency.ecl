IMPORT DueDiligence, STD, ut;

EXPORT getIndKRIResidency(DueDiligence.Layouts.Indv_Internal indv) := FUNCTION

		/* PERSON US RESIDENCY */ 
		reportedAge := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)indv.firstReportedDate, (STRING)indv.historyDate);       
		indDOB := indv.individual.dob;
		usResidencyFlag9 := IF(indv.validSSN = FALSE OR (indv.hasSSN = FALSE AND indv.hasITIN = FALSE), 'T', 'F');                                                            		 
		usResidencyFlag8 := IF(indv.hasITIN OR indv.hasImmigrantSSN, 'T', 'F');                                		 
		usResidencyFlag7 := IF(indDOB > 0 AND  indDOB < indv.mostRecentParentSSNIssuanceDate, 'T', 'F');  
		usResidencyFlag6 := IF(indv.atleastOneParentHasITIN OR indv.atleastOneParentHasImmigrantSSN, 'T', 'F');   
		usResidencyFlag5 := IF(indv.hasParent = FALSE OR (indv.hasParent AND (indv.atleastOneParentHasSSN = FALSE AND indv.atleastOneParentHasITIN = FALSE)), 'T', 'F');   
		usResidencyFlag4 := IF(reportedAge < ut.DaysInNYears(3) AND ((indv.registeredVoter = FALSE OR indv.stateVotingSourceAvailable = FALSE) AND indv.atleastOneParentIsRegisteredVoter = FALSE), 'T', 'F'); 
		usResidencyFlag3 := IF(reportedAge BETWEEN ut.DaysInNYears(3) AND ut.DaysInNYears(10) AND ((indv.registeredVoter = FALSE OR indv.stateVotingSourceAvailable = FALSE) AND indv.atleastOneParentIsRegisteredVoter = FALSE), 'T', 'F');   
		usResidencyFlag2 := IF(reportedAge > ut.DaysInNYears(10) AND ((indv.registeredVoter = FALSE OR indv.stateVotingSourceAvailable = FALSE) AND indv.atleastOneParentIsRegisteredVoter = FALSE), 'T', 'F');  
		usResidencyFlag1 := IF(indv.registeredVoter OR indv.atleastOneParentIsRegisteredVoter, 'T', 'F');                               	 
		
		usResidencyConcat := usResidencyFlag9 + usResidencyFlag8 + usResidencyFlag7 + usResidencyFlag6 + usResidencyFlag5 + usResidencyFlag4 + usResidencyFlag3 + usResidencyFlag2 + usResidencyFlag1;
		usResidencyFlag0 := IF(STD.Str.Find(usResidencyConcat, 'T', 1) = 0, 'T', 'F');  //Insufficient information reported on person and cannot calculate
		
		usResidencyConcat_Final := usResidencyConcat + usResidencyFlag0;

		perUSResidency_Flag := usResidencyConcat_Final;
		perUSResidency  := (STRING)(10-STD.Str.Find(usResidencyConcat_Final, 'T', 1)); 
		
		
		RETURN DueDiligence.Common.createNVPair(perUSResidency, perUSResidency_Flag);

END;
IMPORT DueDiligence, risk_indicators, Doxie;

EXPORT getIndSSNData(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                      STRING dataRestrictionMask,
                      UNSIGNED1 dppa,
                      UNSIGNED1 glba,
                      INTEGER bsVersion,
                      UNSIGNED8 bsOptions,
                      doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
																							
		
	
		
		parents := DueDiligence.CommonIndividual.getRelationship(inData, parents, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);																																																		
		allInd := parents + inData;

		withSSNFlags := DueDiligence.CommonIndividual.GetIIDSSNFlags(allInd, dataRestrictionMask, dppa, glba, bsVersion, bsOptions, mod_access);
		
		validateSSN := JOIN(allInd, withSSNFlags,
																						LEFT.seq = (UNSIGNED)RIGHT.account AND
																						LEFT.individual.did = RIGHT.did,
																						TRANSFORM({RECORDOF(LEFT), BOOLEAN indValidSSN, BOOLEAN indITIN, BOOLEAN indNonUSSSN, BOOLEAN indSSNExists, BOOLEAN parentValidSSN, BOOLEAN parentITIN, 
																																																	BOOLEAN parentNonUSSSN, BOOLEAN parentSSNExists, UNSIGNED4 parentSSNIssuedDt},
																																
																																	valid := RIGHT.socsvalflag in ['3', '0'] OR (RIGHT.socsvalflag = '2' AND LENGTH(TRIM(RIGHT.ssn)) = 4);
																																	itin := Risk_Indicators.rcSet.isCodeIT(RIGHT.ssn);
																																	nonUSSSN := Risk_Indicators.rcSet.isCode85(RIGHT.ssn, RIGHT.socllowissue);
																																	ssnExists := TRIM(RIGHT.ssn) <> DueDiligence.Constants.EMPTY;
																																	
																																	inquired := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL;
																																	parent := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT;
																																	
																																	SELF.indValidSSN := inquired AND valid;
																																	SELF.indITIN := inquired AND itin;
																																	SELF.indNonUSSSN := inquired AND nonUSSSN;
																																	SELF.indSSNExists := inquired AND ssnExists;
																																	
																																	SELF.parentValidSSN := parent AND valid;
																																	SELF.parentITIN := parent AND itin;
																																	SELF.parentNonUSSSN := parent AND nonUSSSN;
																																	SELF.parentSSNExists := parent AND ssnExists;
																																	SELF.parentSSNIssuedDt := IF(parent, (UNSIGNED)RIGHT.socllowissue, 0);
																																	SELF := LEFT;),
																						LEFT OUTER);
		
		rollValidatedSSN := ROLLUP(SORT(validateSSN, seq, inquiredDID, indvType, -parentSSNIssuedDt),
																														LEFT.seq = RIGHT.seq AND
																														LEFT.inquiredDID = RIGHT.inquiredDID,
																														TRANSFORM(RECORDOF(LEFT),
																																									SELF.indValidSSN := LEFT.indValidSSN OR RIGHT.indValidSSN;
																																									SELF.indITIN := LEFT.indITIN OR RIGHT.indITIN;
																																									SELF.indNonUSSSN := LEFT.indNonUSSSN OR RIGHT.indNonUSSSN;
																																									SELF.indSSNExists := LEFT.indSSNExists OR RIGHT.indSSNExists;
																																									
																																									SELF.parentValidSSN := LEFT.parentValidSSN OR RIGHT.parentValidSSN;
																																									SELF.parentITIN := LEFT.parentITIN OR RIGHT.parentITIN;
																																									SELF.parentNonUSSSN := LEFT.parentNonUSSSN OR RIGHT.parentNonUSSSN;
																																									SELF.parentSSNExists := LEFT.parentSSNExists OR RIGHT.parentSSNExists;
																																									SELF.parentSSNIssuedDt := MAX(LEFT.parentSSNIssuedDt, RIGHT.parentSSNIssuedDt);
																																									SELF := LEFT;));

			addSSNData := JOIN(inData, rollValidatedSSN,
																							LEFT.seq = RIGHT.seq AND
																							LEFT.inquiredDID = RIGHT.inquiredDID,
																							TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																																		SELF.hasSSN := RIGHT.indSSNExists;
																																		SELF.hasITIN := RIGHT.indITIN;
																																		SELF.hasImmigrantSSN := RIGHT.indNonUSSSN;
																																		SELF.validSSN := RIGHT.indValidSSN;
																																		SELF.atleastOneParentHasSSN := RIGHT.parentSSNExists;
																																		SELF.atleastOneParentHasITIN := RIGHT.parentITIN;
																																		SELF.mostRecentParentSSNIssuanceDate := RIGHT.parentSSNIssuedDt;
																																		SELF.atleastOneParentHasImmigrantSSN := RIGHT.parentNonUSSSN;
																																		SELF := LEFT;),
																							LEFT OUTER);

			
			
		// OUTPUT(parents, NAMED('parents'));			
		// OUTPUT(allInd, NAMED('allInd_ssnData'));			
		// OUTPUT(ssnFlagsPrepSeq, NAMED('ssnFlagsPrepSeq'));			
		// OUTPUT(withSSNFlags, NAMED('withSSNFlags'));			
		// OUTPUT(validateSSN, NAMED('validateSSN'));					
		// OUTPUT(rollValidatedSSN, NAMED('rollValidatedSSN'));					
		// OUTPUT(addSSNData, NAMED('addSSNData'));					
					
					
					
		RETURN addSSNData;
																							
END;
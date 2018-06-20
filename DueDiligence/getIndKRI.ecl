﻿IMPORT DueDiligence, STD, ut;


EXPORT getIndKRI (DATASET(DueDiligence.Layouts.Indv_Internal) indivs) := FUNCTION
	//individual not found
	STRING10 INVALID_INDIVIDUAL_FLAGS := 'FFFFFFFFFF';
	STRING2 INVALID_INDIVIDUAL_SCORE := '-1';

	//We have individuals with and without LEXID/DIDs
	withDIDs := indivs(individual.did <> DueDiligence.Constants.NUMERIC_ZERO);
	noDIDs := indivs(individual.did = DueDiligence.Constants.NUMERIC_ZERO);
	
	DueDiligence.Layouts.Indv_Internal IndvKRIs(DueDiligence.Layouts.Indv_Internal le) := TRANSFORM
  
    /* PERSON LEXID/DID  */
    // this is already populated by the DueDiligence.getIndDID  
    SELF.PerLexID := le.PerLexID;
		
		/* PERSON US RESIDENCY */ 
		usResidency := DueDiligence.getIndKRIResidency(le);
		
		SELF.PerUSResidency_Flag := usResidency.value;
		SELF.PerUSResidency  := usResidency.name;
    
    
    /* PERSON MATCH LEVEL (based on ADL Score) */  																																																	 
		 PerMatchLevel_Flag9 := IF (le.individual.score < 21, 'T','F');                            /* Index value of 9 was set */
		 PerMatchLevel_Flag8 := IF (le.individual.score BETWEEN 21 AND 30, 'T','F');               /* Index value of 8 was set */
		 PerMatchLevel_Flag7 := IF (le.individual.score BETWEEN 31 AND 40, 'T','F');               /* Index value of 7 was set */
		 PerMatchLevel_Flag6 := IF (le.individual.score BETWEEN 41 AND 50, 'T','F');               /* Index value of 6 was set */
		 PerMatchLevel_Flag5 := IF (le.individual.score BETWEEN 51 AND 60, 'T','F');                /* Index value of 5 was set */
		 PerMatchLevel_Flag4 := IF (le.individual.score BETWEEN 61 AND 70, 'T','F');                /* Index value of 4 was set */
		 PerMatchLevel_Flag3 := IF (le.individual.score BETWEEN 71 AND 80, 'T','F');                /* Index value of 3 was set */
		 PerMatchLevel_Flag2 := IF (le.individual.score BETWEEN 81 AND 90, 'T','F');                /* Index value of 2 was set */
		 PerMatchLevel_Flag1 := IF (le.individual.score > 90, 'T','F');                             /* Index value of 1 was set */
    
     PerMatchLevel_Flag_Concat := PerMatchLevel_Flag9 +
																			PerMatchLevel_Flag8 +
																			PerMatchLevel_Flag7 +
																			PerMatchLevel_Flag6 +
																			PerMatchLevel_Flag5 +
																			PerMatchLevel_Flag4 +
																			PerMatchLevel_Flag3 +
																			PerMatchLevel_Flag2 +
																			PerMatchLevel_Flag1;
                                      
    PerMatchLevel_Flag0        := IF(STD.Str.Find(PerMatchLevel_Flag_Concat, 'T', 1) = 0, 'T', 'F');     /* Insufficient information reported on this person */
		PerMatchLevel_Flag_final  := PerMatchLevel_Flag_Concat + PerMatchLevel_Flag0; 
    
    self.PerMatchLevel_Flag   :=  PerMatchLevel_Flag_final;                                            /* This a string of T or F based on how the data used to calculate the KRI  */
		self.PerMatchLevel         := (STRING)(10 - STD.Str.Find(PerMatchLevel_Flag_final, 'T', 1));       /* Set the level to the position of the first 'T' which is essentially the highest level. 
    
    /* PERSON ASSET OWNED PROPERTY */
    perAssetOwnProperty_Flag9 := IF(le.ownedPropCount >= 15, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag8 := IF(le.ownedPropCount BETWEEN 10 AND 14, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag7 := IF(le.ownedPropCount BETWEEN 6 AND 9, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag6 := IF(le.ownedPropCount = 5, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag5 := IF(le.ownedPropCount = 4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag4 := IF(le.ownedPropCount = 3, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag3 := IF(le.ownedPropCount = 2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag2 := IF(le.ownedPropCount = 1, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag1 := IF(le.ownedPropCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    
    perAssetOwnProperty_Flag_Concat := perAssetOwnProperty_Flag9 +
                                        perAssetOwnProperty_Flag8 +
                                        perAssetOwnProperty_Flag7 +
                                        perAssetOwnProperty_Flag6 +
                                        perAssetOwnProperty_Flag5 +
                                        perAssetOwnProperty_Flag4 +
                                        perAssetOwnProperty_Flag3 +
                                        perAssetOwnProperty_Flag2 +
                                        perAssetOwnProperty_Flag1;
                                      
    perAssetOwnProperty_Flag0 := IF(STD.Str.Find(perAssetOwnProperty_Flag_Concat, DueDiligence.Constants.T_INDICATOR, 1) = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);     
		perAssetOwnProperty_Flag_final := perAssetOwnProperty_Flag_Concat + perAssetOwnProperty_Flag0; 
    
    self.PerAssetOwnProperty_Flag :=  perAssetOwnProperty_Flag_final;                                           
		self.PerAssetOwnProperty := (STRING)(10 - STD.Str.Find(perAssetOwnProperty_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));    

    /* INDIVIDUAL GEOGRAPHIC RISK  */  
		perGeoRisk_Flag9 := IF (le.CountyHasHighCrimeIndex   
		                    AND le.CountyBordersForgeinJur
											  AND (le.HIDTA OR le.HIFCA),      'T','F');                            /* Set the Index value to 9 */	
												
		perGeoRisk_Flag8 := IF (le.CityBorderStation 
		                    OR  le.CityFerryCrossing  
											  OR  le.CityRailStation ,         'T','F');                            /* Set the Index value to 8 */
												
		perGeoRisk_Flag7 := IF (le.CountyBordersForgeinJur,  'T','F');                            /* Set the Index value to 7 */
		
		perGeoRisk_Flag6 := IF (~le.CountyBordersForgeinJur 
		                    AND  le.CountyBorderOceanForgJur, 'T','F');                           /* Set the Index value to 6 */
												
		perGeoRisk_Flag5 := IF (le.CountyHasHighCrimeIndex
		                    AND (le.HIDTA OR le.HIFCA),       'T','F');                           /* Set the Index value to 5 */
												
		perGeoRisk_Flag4 := IF (le.CountyHasHighCrimeIndex,   'T','F');                           /* Set the Index value to 4 */
		                                                                 
		perGeoRisk_Flag3 := IF (le.HIFCA, 'T','F');                                               /* Set the Index value to 3 */
		
		perGeoRisk_Flag2 := IF (le.HIDTA, 'T','F');                                               /* Set the Index value to 2  */
		
		perGeoRisk_Flag1 := IF (~le.CountyHasHighCrimeIndex,'T','F');                             /* Set the Index value to 1 */
	

		perGeoRisk_Flag_Concat := perGeoRisk_Flag9 +
																			perGeoRisk_Flag8 +
																			perGeoRisk_Flag7 +
																			perGeoRisk_Flag6 +
																			perGeoRisk_Flag5 +
																			perGeoRisk_Flag4 +
																			perGeoRisk_Flag3 +
																			perGeoRisk_Flag2 +
																			perGeoRisk_Flag1;
	


		perGeoRisk_Flag0        := IF(STD.Str.Find(perGeoRisk_Flag_Concat, 'T', 1) = 0, 'T', 'F');     /* Insufficient information reported on the business */
		perGeoRisk_Flag_final   := perGeoRisk_Flag_Concat + perGeoRisk_Flag0; 
		
		self.perGeographic_Flag   :=  perGeoRisk_Flag_final;                                             /* This a string of T or F based on how the data used to calculate the KRI  */
		self.perGeographic         := (STRING)(10-STD.Str.Find(perGeoRisk_Flag_final, 'T', 1));          /* Set the index to the position of the first 'T'.  */
			

    
		/*INDIVIDUAL PROFESSIONAL LICENSE */
		highRiskFound := le.atleastOneActiveLawAcct OR le.atleastOneActiveFinRealEstate OR le.atleastOneActiveMedical OR 
																			le.atleastOneActiveBlastPilot OR le.atleastOneInactiveLawAcct OR le.atleastOneInactiveFinRealEstate OR 
																			le.atleastOneInactiveMedical OR le.atleastOneInactiveBlastPilot;
		professionalLicRisk9 := IF(le.atleastOneActiveLawAcct, 'T', 'F');
		professionalLicRisk8 := IF(le.atleastOneActiveFinRealEstate, 'T', 'F');
		professionalLicRisk7 := IF(le.atleastOneActiveMedical, 'T', 'F');
		professionalLicRisk6 := IF(le.atleastOneActiveBlastPilot, 'T', 'F');
		professionalLicRisk5 := IF(le.atleastOneInactiveLawAcct, 'T', 'F');
		professionalLicRisk4 := IF(le.atleastOneInactiveFinRealEstate, 'T', 'F');
		professionalLicRisk3 := IF(le.atleastOneInactiveMedical, 'T', 'F');
		professionalLicRisk2 := IF(le.atleastOneInactiveBlastPilot, 'T', 'F');
		professionalLicRisk1 := IF(highRiskFound = FALSE, 'T', 'F');
												
		professionalLicRiskConcat := professionalLicRisk9 + professionalLicRisk8 + professionalLicRisk7 + professionalLicRisk6 + 
                                 professionalLicRisk5 + professionalLicRisk4 + professionalLicRisk3 + professionalLicRisk2 + professionalLicRisk1;
		professionalLicRiskFlag0 := IF(STD.Str.Find(professionalLicRiskConcat, 'T', 1) = 0, 'T', 'F');  //Insufficient information reported on business and cannot calculate
		
		professionalLicRiskConcat_Final := professionalLicRiskConcat + professionalLicRiskFlag0;
		
		SELF.PerProfLicense_Flag := professionalLicRiskConcat_Final;
		SELF.PerProfLicense := (STRING)(10-STD.Str.Find(professionalLicRiskConcat_Final, 'T', 1));
		


    //BELOW ATTRIBUTES HAVE ALREADY BEEN CALC'D IN CODE (DUE TO REUSABILITY BETWEEN BUSINESS AND PERSON)
    
    /* PERSON STATE CRIMINAL */
    //is populated in DueDiligence.getIndKRILegalStateCriminal, which is ultimately called in DueDiligence.getIndCriminal
		SELF.PerLegalStateCriminal := le.individual.stateCriminalLegalEventsScore;
    SELF.PerLegalStateCriminal_Flag := le.individual.stateCriminalLegalEventsFlags;
    
    /* LEGAL EVENT TYPES  */
    //is populated in DueDiligence.getIndKRILegalEventType,  
		SELF.PerLegalTypes := le.individual.legalEventTypeScore;
    SELF.PerLegalTypes_Flag := le.individual.legalEventTypeFlags;
	
		
		SELF := le;
	END;


	kriIndv := PROJECT(SORT(withDIDs, seq), IndvKRIs(LEFT));
  //all of the person with no information(DID) will get the value of -1
	kriUnknownIndv := PROJECT(noDIDs, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																							SELF.PerAssetOwnProperty := INVALID_INDIVIDUAL_SCORE;
																							SELF.PerAssetOwnProperty_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAssetOwnAircraft := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAssetOwnAircraft_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAssetOwnWatercraft := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAssetOwnWatercraft_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAssetOwnVehicle := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAssetOwnVehicle_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAccessToFundsProperty := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAccessToFundsProperty_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAccessToFundsIncome := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAccessToFundsIncome_Flag := INVALID_INDIVIDUAL_FLAGS;
																							SELF.PerGeographic := INVALID_INDIVIDUAL_SCORE;
																							SELF.PerGeographic_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerMobility := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerMobility_Flag := INVALID_INDIVIDUAL_FLAGS;
																							SELF.PerLegalStateCriminal := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerLegalStateCriminal_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              // SELF.PerLegalFedCriminal := INVALID_INDIVIDUAL_SCORE;
                                              // SELF.PerLegalFedCriminal_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerLegalCivil := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerLegalCivil_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerLegalTraffInfr := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerLegalTraffInfr_Flag := INVALID_INDIVIDUAL_FLAGS;
																							SELF.PerLegalTypes := INVALID_INDIVIDUAL_SCORE;
																							SELF.PerLegalTypes_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerHighRiskNewsProfiles := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerHighRiskNewsProfiles_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAgeRange := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAgeRange_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerIdentityRisk := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerIdentityRisk_Flag := INVALID_INDIVIDUAL_FLAGS;
																							SELF.PerUSResidency := INVALID_INDIVIDUAL_SCORE;
																							SELF.PerUSResidency_Flag := INVALID_INDIVIDUAL_FLAGS;
																							SELF.PerMatchLevel := INVALID_INDIVIDUAL_SCORE;
																							SELF.PerMatchLevel_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAssociatesIndex := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAssociatesIndex_Flag := INVALID_INDIVIDUAL_FLAGS;
																							SELF.PerProfLicense := INVALID_INDIVIDUAL_SCORE;
																							SELF.PerProfLicense_Flag := INVALID_INDIVIDUAL_FLAGS;
																							SELF := LEFT;));



	RETURN kriIndv + kriUnknownIndv;
				 
END;
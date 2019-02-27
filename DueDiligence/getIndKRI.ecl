IMPORT DueDiligence, STD, ut;


EXPORT getIndKRI(DATASET(DueDiligence.Layouts.Indv_Internal) indivs) := FUNCTION
	//individual not found
	STRING10 INVALID_INDIVIDUAL_FLAGS := 'FFFFFFFFFF';
	STRING2 INVALID_INDIVIDUAL_SCORE := '-1';

	//we have individuals with and without LEXID/DIDs
	withDIDs := indivs(individual.did <> DueDiligence.Constants.NUMERIC_ZERO);
	noDIDs := indivs(individual.did = DueDiligence.Constants.NUMERIC_ZERO);
  

 
	DueDiligence.Layouts.Indv_Internal IndvKRIs(DueDiligence.Layouts.Indv_Internal le) := TRANSFORM
		
		//PERSON US RESIDENCY 
		usResidency := DueDiligence.getIndKRIResidency(le);
		
		SELF.PerUSResidency_Flag := usResidency.value;
		SELF.PerUSResidency  := usResidency.name;
    
    
    //PERSON MATCH LEVEL (based on ADL Score)																																																	 
		PerMatchLevel_Flag9 := IF (le.individual.score < 21, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);                            
		PerMatchLevel_Flag8 := IF (le.individual.score BETWEEN 21 AND 30, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);               
		PerMatchLevel_Flag7 := IF (le.individual.score BETWEEN 31 AND 40, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);               
		PerMatchLevel_Flag6 := IF (le.individual.score BETWEEN 41 AND 50, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);               
		PerMatchLevel_Flag5 := IF (le.individual.score BETWEEN 51 AND 60, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);               
		PerMatchLevel_Flag4 := IF (le.individual.score BETWEEN 61 AND 70, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);               
		PerMatchLevel_Flag3 := IF (le.individual.score BETWEEN 71 AND 80, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);               
		PerMatchLevel_Flag2 := IF (le.individual.score BETWEEN 81 AND 90, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);               
		PerMatchLevel_Flag1 := IF (le.individual.score > 90, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);                            
    
    PerMatchLevel_Flag_final := DueDiligence.Common.calcFinalFlagField(PerMatchLevel_Flag9,
                                                                        PerMatchLevel_Flag8,
                                                                        PerMatchLevel_Flag7,
                                                                        PerMatchLevel_Flag6,
                                                                        PerMatchLevel_Flag5,
                                                                        PerMatchLevel_Flag4,
                                                                        PerMatchLevel_Flag3,
                                                                        PerMatchLevel_Flag2,
                                                                        PerMatchLevel_Flag1);
                                      
    SELF.PerMatchLevel_Flag := PerMatchLevel_Flag_final;                                            
		SELF.PerMatchLevel := (STRING)(10 - STD.Str.Find(PerMatchLevel_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));       
    
    //PERSON ASSET OWNED PROPERTY
    perAssetOwnProperty_Flag9 := IF(le.ownedPropCount >= 15, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag8 := IF(le.ownedPropCount BETWEEN 10 AND 14, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag7 := IF(le.ownedPropCount BETWEEN 6 AND 9, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag6 := IF(le.ownedPropCount = 5, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag5 := IF(le.ownedPropCount = 4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag4 := IF(le.ownedPropCount = 3, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag3 := IF(le.ownedPropCount = 2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag2 := IF(le.ownedPropCount = 1, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnProperty_Flag1 := IF(le.ownedPropCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    
    perAssetOwnProperty_Flag_final := DueDiligence.Common.calcFinalFlagField(perAssetOwnProperty_Flag9,
                                                                              perAssetOwnProperty_Flag8,
                                                                              perAssetOwnProperty_Flag7,
                                                                              perAssetOwnProperty_Flag6,
                                                                              perAssetOwnProperty_Flag5,
                                                                              perAssetOwnProperty_Flag4,
                                                                              perAssetOwnProperty_Flag3,
                                                                              perAssetOwnProperty_Flag2,
                                                                              perAssetOwnProperty_Flag1); 
    
    SELF.PerAssetOwnProperty_Flag := perAssetOwnProperty_Flag_final;                                           
		SELF.PerAssetOwnProperty := (STRING)(10 - STD.Str.Find(perAssetOwnProperty_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));
    
    
    //PERSON ASSET OWNED WATERCRAFT
    perAssetOwnWatercraft_Flag9 := IF(le.watercraftCount > 0 AND le.watercraftlength >= 200, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnWatercraft_Flag8 := IF(le.watercraftCount > 0 AND le.watercraftlength BETWEEN 100 AND 199, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnWatercraft_Flag7 := IF(le.watercraftCount > 0 AND le.watercraftlength BETWEEN 50  AND 99, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
    perAssetOwnWatercraft_Flag6 := IF(le.watercraftCount >= 6, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                            
    perAssetOwnWatercraft_Flag5 := IF(le.watercraftCount BETWEEN 4 AND 5, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                  
    perAssetOwnWatercraft_Flag4 := IF(le.watercraftCount = 3, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                             
    perAssetOwnWatercraft_Flag3 := IF(le.watercraftCount = 2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                             
    perAssetOwnWatercraft_Flag2 := IF(le.watercraftCount = 1, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                             
    perAssetOwnWatercraft_Flag1 := IF(le.watercraftCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                             
    
    perAssetOwnWatercraft_Flag_final := DueDiligence.Common.calcFinalFlagField(perAssetOwnWatercraft_Flag9,
                                                                                perAssetOwnWatercraft_Flag8,
                                                                                perAssetOwnWatercraft_Flag7,
                                                                                perAssetOwnWatercraft_Flag6,
                                                                                perAssetOwnWatercraft_Flag5,
                                                                                perAssetOwnWatercraft_Flag4,
                                                                                perAssetOwnWatercraft_Flag3,
                                                                                perAssetOwnWatercraft_Flag2,
                                                                                perAssetOwnWatercraft_Flag1); 
    
    SELF.PerAssetOwnWatercraft_Flag := perAssetOwnWatercraft_Flag_final;                                           
		SELF.PerAssetOwnWatercraft := (STRING)(10 - STD.Str.Find(perAssetOwnWatercraft_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));
    
    
    //PERSON ASSET OWNED AIRCRAFT
    perAssetOwnAircraft_Flag9 := IF(le.aircraftCount >= 8, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnAircraft_Flag8 := IF(le.aircraftCount = 7, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnAircraft_Flag7 := IF(le.aircraftCount = 6, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnAircraft_Flag6 := IF(le.aircraftCount = 5, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnAircraft_Flag5 := IF(le.aircraftCount = 4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnAircraft_Flag4 := IF(le.aircraftCount = 3, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnAircraft_Flag3 := IF(le.aircraftCount = 2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnAircraft_Flag2 := IF(le.aircraftCount = 1, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAssetOwnAircraft_Flag1 := IF(le.aircraftCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    
    perAssetOwnAircraft_Flag_final := DueDiligence.Common.calcFinalFlagField(perAssetOwnAircraft_Flag9,
                                                                              perAssetOwnAircraft_Flag8,
                                                                              perAssetOwnAircraft_Flag7,
                                                                              perAssetOwnAircraft_Flag6,
                                                                              perAssetOwnAircraft_Flag5,
                                                                              perAssetOwnAircraft_Flag4,
                                                                              perAssetOwnAircraft_Flag3,
                                                                              perAssetOwnAircraft_Flag2,
                                                                              perAssetOwnAircraft_Flag1); 
                                                          
    SELF.PerAssetOwnAircraft_Flag := perAssetOwnAircraft_Flag_final;
    SELF.PerAssetOwnAircraft := (STRING)(10 - STD.Str.Find(perAssetOwnAircraft_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));
    
    
    //PERSON ACCESS TO FUNDS PROPERTY
    perAccessToFundsProperty_Flag9 := IF(le.ownedPropCount > 0 AND le.totalAssesedValue >= 15000000, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsProperty_Flag8 := IF(le.ownedPropCount > 0 AND le.totalAssesedValue BETWEEN 5000000 AND 14999999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsProperty_Flag7 := IF(le.ownedPropCount > 0 AND le.totalAssesedValue BETWEEN 1000000 AND 4999999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsProperty_Flag6 := IF(le.ownedPropCount > 0 AND le.totalAssesedValue BETWEEN 500000 AND 999999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsProperty_Flag5 := IF(le.ownedPropCount > 0 AND le.totalAssesedValue BETWEEN 200000 AND 499999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsProperty_Flag4 := IF(le.ownedPropCount > 0 AND le.totalAssesedValue BETWEEN 50000 AND 199999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsProperty_Flag3 := IF(le.ownedPropCount > 0 AND le.totalAssesedValue < 50000, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsProperty_Flag2 := IF(le.previouslyOwnedPropCount > 0 AND le.ownedPropCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsProperty_Flag1 := IF(le.ownedPropCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    
    perAccessToFundsProperty_Flag_final := DueDiligence.Common.calcFinalFlagField(perAccessToFundsProperty_Flag9,
                                                                                  perAccessToFundsProperty_Flag8,
                                                                                  perAccessToFundsProperty_Flag7,
                                                                                  perAccessToFundsProperty_Flag6,
                                                                                  perAccessToFundsProperty_Flag5,
                                                                                  perAccessToFundsProperty_Flag4,
                                                                                  perAccessToFundsProperty_Flag3,
                                                                                  perAccessToFundsProperty_Flag2,
                                                                                  perAccessToFundsProperty_Flag1);
    
    SELF.PerAccessToFundsProperty_Flag := perAccessToFundsProperty_Flag_final;
		SELF.PerAccessToFundsProperty := (STRING)(10 - STD.Str.Find(perAccessToFundsProperty_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));
    
    
    
    //PERSON ACCESS TO FUNDS INCOME
    perAccessToFundsIncome_Flag9 := IF(le.estimatedIncome > 250000, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsIncome_Flag8 := IF(le.estimatedIncome BETWEEN 200000 AND 250000, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsIncome_Flag7 := IF(le.estimatedIncome BETWEEN 150000 AND 199999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsIncome_Flag6 := IF(le.estimatedIncome BETWEEN 100000 AND 149999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsIncome_Flag5 := IF(le.estimatedIncome BETWEEN 80000 AND 99999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsIncome_Flag4 := IF(le.estimatedIncome BETWEEN 60000 AND 79999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsIncome_Flag3 := IF(le.estimatedIncome BETWEEN 40000 AND 59999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsIncome_Flag2 := IF(le.estimatedIncome BETWEEN 20000 AND 39999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAccessToFundsIncome_Flag1 := IF(le.estimatedIncome BETWEEN 0 AND 19999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    
    perAccessToFundsIncome_Flag_final := DueDiligence.Common.calcFinalFlagField(perAccessToFundsIncome_Flag9,
                                                                                perAccessToFundsIncome_Flag8,
                                                                                perAccessToFundsIncome_Flag7,
                                                                                perAccessToFundsIncome_Flag6,
                                                                                perAccessToFundsIncome_Flag5,
                                                                                perAccessToFundsIncome_Flag4,
                                                                                perAccessToFundsIncome_Flag3,
                                                                                perAccessToFundsIncome_Flag2,
                                                                                perAccessToFundsIncome_Flag1);
    
    SELF.PerAccessToFundsIncome_Flag := perAccessToFundsIncome_Flag_final;
		SELF.PerAccessToFundsIncome := (STRING)(10 - STD.Str.Find(perAccessToFundsIncome_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));
    
    
    //PERSON AGE RANGE
    perAgeRange_Flag9 := IF(le.estimatedAge BETWEEN 1 AND 18, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAgeRange_Flag8 := IF(le.estimatedAge BETWEEN 19 AND 21, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAgeRange_Flag7 := IF(le.estimatedAge BETWEEN 22 AND 25, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAgeRange_Flag6 := IF(le.estimatedAge BETWEEN 26 AND 35, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAgeRange_Flag5 := IF(le.estimatedAge BETWEEN 36 AND 50, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAgeRange_Flag4 := IF(le.estimatedAge BETWEEN 51 AND 63, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAgeRange_Flag3 := IF(le.estimatedAge BETWEEN 64 AND 75, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAgeRange_Flag2 := IF(le.estimatedAge BETWEEN 76 AND 85, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    perAgeRange_Flag1 := IF(le.estimatedAge > 85, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
    
    perAgeRange_Flag_final := DueDiligence.Common.calcFinalFlagField(perAgeRange_Flag9,
                                                                      perAgeRange_Flag8,
                                                                      perAgeRange_Flag7,
                                                                      perAgeRange_Flag6,
                                                                      perAgeRange_Flag5,
                                                                      perAgeRange_Flag4,
                                                                      perAgeRange_Flag3,
                                                                      perAgeRange_Flag2,
                                                                      perAgeRange_Flag1);
    
    SELF.PerAgeRange_Flag := perAgeRange_Flag_final;
		SELF.PerAgeRange := (STRING)(10 - STD.Str.Find(perAgeRange_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));
    
    

    //INDIVIDUAL GEOGRAPHIC RISK
		perGeoRisk_Flag9 := IF(le.CountyHasHighCrimeIndex AND le.CountyBordersForgeinJur AND (le.HIDTA OR le.HIFCA), DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);                            	
		perGeoRisk_Flag8 := IF(le.CityBorderStation OR le.CityFerryCrossing OR le.CityRailStation, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);                           											
		perGeoRisk_Flag7 := IF(le.CountyBordersForgeinJur, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);  
		perGeoRisk_Flag6 := IF(~le.CountyBordersForgeinJur AND le.CountyBorderOceanForgJur, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);                           			
		perGeoRisk_Flag5 := IF(le.CountyHasHighCrimeIndex AND (le.HIDTA OR le.HIFCA), DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);                           											
		perGeoRisk_Flag4 := IF(le.CountyHasHighCrimeIndex, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);                                                                                   
		perGeoRisk_Flag3 := IF(le.HIFCA, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);                                               
		perGeoRisk_Flag2 := IF(le.HIDTA, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);                                               
		perGeoRisk_Flag1 := IF(~le.CountyHasHighCrimeIndex, DueDiligence.Constants.T_INDICATOR,DueDiligence.Constants.F_INDICATOR);                             
	

		perGeoRisk_Flag_final := DueDiligence.Common.calcFinalFlagField(perGeoRisk_Flag9,
                                                                    perGeoRisk_Flag8, 
                                                                    perGeoRisk_Flag7, 
                                                                    perGeoRisk_Flag6, 
                                                                    perGeoRisk_Flag5, 
                                                                    perGeoRisk_Flag4, 
                                                                    perGeoRisk_Flag3, 
                                                                    perGeoRisk_Flag2, 
                                                                    perGeoRisk_Flag1); 
		
		SELF.perGeographic_Flag := perGeoRisk_Flag_final;                                             
		SELF.perGeographic := (STRING)(10-STD.Str.Find(perGeoRisk_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));          
			

    
		//INDIVIDUAL PROFESSIONAL LICENSE
		highRiskFound := le.atleastOneActiveLawAcct OR le.atleastOneActiveFinRealEstate OR le.atleastOneActiveMedical OR 
                     le.atleastOneActiveBlastPilot OR le.atleastOneInactiveLawAcct OR le.atleastOneInactiveFinRealEstate OR 
                     le.atleastOneInactiveMedical OR le.atleastOneInactiveBlastPilot;
                                      
		professionalLicRisk9 := IF(le.atleastOneActiveLawAcct, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		professionalLicRisk8 := IF(le.atleastOneActiveFinRealEstate, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		professionalLicRisk7 := IF(le.atleastOneActiveMedical, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		professionalLicRisk6 := IF(le.atleastOneActiveBlastPilot, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		professionalLicRisk5 := IF(le.atleastOneInactiveLawAcct, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		professionalLicRisk4 := IF(le.atleastOneInactiveFinRealEstate, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		professionalLicRisk3 := IF(le.atleastOneInactiveMedical, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		professionalLicRisk2 := IF(le.atleastOneInactiveBlastPilot, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		professionalLicRisk1 := IF(highRiskFound = FALSE, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
												
		professionalLicRiskConcat_Final := DueDiligence.Common.calcFinalFlagField(professionalLicRisk9, 
                                                                              professionalLicRisk8, 
                                                                              professionalLicRisk7, 
                                                                              professionalLicRisk6, 
                                                                              professionalLicRisk5, 
                                                                              professionalLicRisk4, 
                                                                              professionalLicRisk3, 
                                                                              professionalLicRisk2, 
                                                                              professionalLicRisk1);
		
		SELF.PerProfLicense_Flag := professionalLicRiskConcat_Final;
		SELF.PerProfLicense := (STRING)(10-STD.Str.Find(professionalLicRiskConcat_Final, DueDiligence.Constants.T_INDICATOR, 1));
		

    //ASSETS OWNED VEHICLE
		PerAssetOwnVehicle_Flag9 := IF(le.VehicleCount > 0 AND le.VehicleBaseValue >= 200000, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
		PerAssetOwnVehicle_Flag8 := IF(le.VehicleCount > 0 AND le.VehicleBaseValue BETWEEN 150000 AND 199999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
		PerAssetOwnVehicle_Flag7 := IF(le.VehicleCount > 0 AND le.VehicleBaseValue BETWEEN 100000 AND 149999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);  
		PerAssetOwnVehicle_Flag6 := IF(le.VehicleCount >= 15, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                                  
		PerAssetOwnVehicle_Flag5 := IF(le.VehicleCount BETWEEN 8 AND 14, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                    
		PerAssetOwnVehicle_Flag4 := IF(le.VehicleCount BETWEEN 5 AND 7, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                     
		PerAssetOwnVehicle_Flag3 := IF(le.VehicleCount BETWEEN 3 AND 4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                        
		PerAssetOwnVehicle_Flag2 := IF(le.VehicleCount BETWEEN 1 AND 2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                        
		PerAssetOwnVehicle_Flag1 := IF(le.VehicleCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                                  
	
		PerAssetOwnVehicle_Flag_Final := DueDiligence.Common.calcFinalFlagField(PerAssetOwnVehicle_Flag9,
                                                                            PerAssetOwnVehicle_Flag8,
                                                                            PerAssetOwnVehicle_Flag7,
                                                                            PerAssetOwnVehicle_Flag6,
                                                                            PerAssetOwnVehicle_Flag5,
                                                                            PerAssetOwnVehicle_Flag4,
                                                                            PerAssetOwnVehicle_Flag3,
                                                                            PerAssetOwnVehicle_Flag2,
                                                                            PerAssetOwnVehicle_Flag1);

    SELF.PerAssetOwnVehicle_Flag := PerAssetOwnVehicle_Flag_Final;                                             
		SELF.PerAssetOwnVehicle := (STRING)(10-STD.Str.Find(PerAssetOwnVehicle_Flag_Final, DueDiligence.Constants.T_INDICATOR, 1));           

    
    
    //BELOW ATTRIBUTES HAVE ALREADY BEEN CALC'D IN CODE (DUE TO REUSABILITY BETWEEN BUSINESS AND PERSON)
    
    //PERSON LEXID/DID
    //is already populated in DueDiligence.getIndDID  
    SELF.PerLexID := (STRING)le.inquiredDID;
    
    SELF.PerLexIDMatch := (STRING)le.individual.score;
    
    //PERSON STATE CRIMINAL
    //is populated in DueDiligence.getIndKRILegalStateCriminal, which is ultimately called in DueDiligence.getIndCriminal
		SELF.PerStateLegalEvent := le.individual.stateCriminalLegalEventsScore;
    SELF.PerStateLegalEvent_Flag := le.individual.stateCriminalLegalEventsFlags;
    
    //PERSON LEGAL EVENT TYPES
    //is populated in DueDiligence.getIndKRILegalEventType,  
		SELF.PerOffenseType := le.individual.legalEventTypeScore;
    SELF.PerOffenseType_Flag := le.individual.legalEventTypeFlags;
    
    //PERSON BUSINESS ASSOCIATIONS
    //is populated in DueDiligence.getIndKRIBusAssoc
    SELF.PerBusAssociations := le.individual.busAssociationScore;
    SELF.PerBusAssociations_Flag := le.individual.busAssociationFlags;

	
		
		SELF := le;
	END;


	kriIndv := PROJECT(SORT(withDIDs, seq), IndvKRIs(LEFT));
  //all of the person with no information(DID) will get the value of -1
	kriUnknownIndv := PROJECT(noDIDs, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                              SELF.PerAssetOwnProperty := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerAssetOwnProperty_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              SELF.PerAssetOwnAircraft := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerAssetOwnAircraft_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              SELF.PerAssetOwnWatercraft := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerAssetOwnWatercraft_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              SELF.PerAssetOwnVehicle := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerAssetOwnVehicle_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              SELF.PerAccessToFundsProperty := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerAccessToFundsProperty_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              SELF.PerAccessToFundsIncome := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerAccessToFundsIncome_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              SELF.PerGeographic := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerGeographic_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              // SELF.PerMobility := INVALID_INDIVIDUAL_SCORE;
                                              // SELF.PerMobility_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              SELF.PerStateLegalEvent := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerStateLegalEvent_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              // SELF.PerFederalLegalEvent := INVALID_INDIVIDUAL_SCORE;
                                              // SELF.PerFederalLegalEvent_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              // SELF.PerFederalLegalMatchLevel := INVALID_INDIVIDUAL_SCORE;
                                              // SELF.PerFederalLegalMatchLevel_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              // SELF.PerCivilLegalEvent := INVALID_INDIVIDUAL_SCORE;
                                              // SELF.PerCivilLegalEvent_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              SELF.PerOffenseType := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerOffenseType_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              SELF.PerAgeRange := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerAgeRange_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              // SELF.PerIdentityRisk := INVALID_INDIVIDUAL_SCORE;
                                              // SELF.PerIdentityRisk_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              SELF.PerUSResidency := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerUSResidency_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              SELF.PerMatchLevel := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerMatchLevel_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              // SELF.PerAssociates := INVALID_INDIVIDUAL_SCORE;
                                              // SELF.PerAssociates_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              SELF.PerProfLicense := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerProfLicense_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              SELF.PerBusAssociations := INVALID_INDIVIDUAL_SCORE;
                                              SELF.PerBusAssociations_Flag := INVALID_INDIVIDUAL_FLAGS;
                                              // SELF.PerEmploymentIndustry := INVALID_INDIVIDUAL_SCORE;
                                              // SELF.PerEmploymentIndustry_Flags := INVALID_INDIVIDUAL_FLAGS
                                              SELF := LEFT;));



	RETURN kriIndv + kriUnknownIndv;
				 
END;
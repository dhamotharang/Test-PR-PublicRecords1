/*
 * Searches the AddrFraud key by GeoLink.  Eventually this key should be updated
 * to use Address ID (AID). 
 */

IMPORT ut, AddrFraud, EASI;

EXPORT Address_Shell.layoutPropertyCharacteristics searchAddressFraud (DATASET(Address_Shell.layoutPropertyCharacteristics) working, UNSIGNED1 attributesVersion = 1) := FUNCTION
/* ************************************************************
	 * Gather EASI Census data.  The Indexes calculated require *
   * FAMOTF18_P, so add this to the working layout.           *
	 ************************************************************ */
	workingLayout := RECORD
		Address_Shell.layoutPropertyCharacteristics;
		STRING10 FAMOTF18_P := '';
	END;
	
	workingLayout getEASIV1(Address_Shell.layoutPropertyCharacteristics le, EASI.Key_Easi_Census ri) := TRANSFORM
		SELF.PropertyAttributes.Version1.Low_Income := ri.LowInc;
		SELF.FAMOTF18_P := ri.FAMOTF18_P;
		
		// Keep everything already calculated
		SELF := le;
		SELF := [];
	END;
	
	easiV1 := JOIN(working, EASI.Key_Easi_Census, TRIM(LEFT.Input.GeoLink) <> '' AND KEYED(LEFT.Input.GeoLink = RIGHT.GeoLink), 
													getEASIV1(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));

/* ************************************************************
	 * Calculate all of the index values.  This REQUIRES that   *
   * EASI census data has already been included.              *
	 ************************************************************ */
	padZeros (REAL input) := TRIM((STRING)REALFORMAT(input, 6, 2));
	
	Address_Shell.layoutPropertyCharacteristics getAddressFraudV1(workingLayout le, AddrFraud.Key_AddrFraud_GeoLink ri) := TRANSFORM
		// We simply don't have information for this GeoBlock, return defaults
		unableToCalculate := (ri.occupants = 0 AND ri.occupants_1yr = 0 AND ri.occupants_2yr = 0 AND
													ri.occupants_3yr = 0 AND ri.occupants_4yr = 0 AND ri.occupants_5yr = 0 AND 
													ri.turnover_1yr_in = 0 AND ri.turnover_1yr_out = 0 AND ri.turnover_2yr_in = 0 AND
													ri.turnover_2yr_out = 0 AND ri.turnover_3yr_in = 0 AND ri.turnover_3yr_out = 0 AND 
													ri.turnover_4yr_in = 0 AND ri.turnover_4yr_out = 0 AND ri.turnover_5yr_in = 0 AND
													ri.turnover_5yr_out = 0 AND ri.crimes = 0 AND ri.crimes_1yr = 0 AND ri.crimes_2yr = 0 AND 
													ri.crimes_3yr = 0 AND ri.crimes_4yr = 0 AND ri.crimes_5yr = 0 AND ri.foreclosures = 0 AND
													ri.foreclosures_1yr = 0 AND ri.foreclosures_2yr = 0 AND ri.foreclosures_3yr = 0 AND
													ri.foreclosures_4yr = 0 AND ri.foreclosures_5yr = 0);
	
		averagePeoplePerHouse := 2;
		
		crimesTemp := ((ri.crimes * 100000) / ri.occupants);
		crimeIndexRaw := IF(crimesTemp > 1000, 999, crimesTemp);
		crimeIndex := (0.5 * (IF(crimeIndexRaw <= 0, 0, crimeIndexRaw)));

		povertyIndexTemp := IF((REAL)le.PropertyAttributes.Version1.Low_Income <= 0, 0, (REAL)le.PropertyAttributes.Version1.Low_Income);
		povertyIndex := IF(povertyIndexTemp >= 100, 100, IF(povertyIndexTemp <= 0, 0, povertyIndexTemp));

		foreclosureIndexRaw := ((ri.foreclosures * 100000) / (ri.occupants / averagePeoplePerHouse));
		foreclosureIndex := (0.0233 * (IF(foreclosureIndexRaw <= 0, 0, foreclosureIndexRaw)));

		disruptionIndex := IF((REAL)le.FAMOTF18_P <= 0, 0, (REAL)le.FAMOTF18_P);

		mobilityIndexRaw := ((ri.turnover_1yr_in + ri.turnover_1yr_out) / ri.occupants_1yr);
		mobilityIndexTemp := (100 * ABS(mobilityIndexRaw));
		mobilityIndex := IF(mobilityIndexTemp >= 100, 100, IF(mobilityIndexTemp <= 0, 0, mobilityIndexTemp));

		riskIndexTemp := (crimeIndex + povertyIndex + foreclosureIndex + disruptionIndex + mobilityIndex);
		riskIndex := IF(riskIndexTemp >= 999.00, 999.00, IF(riskIndexTemp <= 0.00, 0.00, riskIndexTemp));

		// During testing found that these can return *****, need to add TRIM to remove the garbage data...
		SELF.PropertyAttributes.Version1.Mobility_Index := IF(unableToCalculate, '', padZeros(mobilityIndex));
		SELF.PropertyAttributes.Version1.Poverty_Index :=  IF(unableToCalculate, '', padZeros(povertyIndex));
		SELF.PropertyAttributes.Version1.Risk_Index :=  IF(unableToCalculate, '', padZeros(riskIndex));
		
		// Keep everything already calculated
		SELF := le;
		SELF := [];
	END;
		
	version1 := JOIN(easiV1, AddrFraud.Key_AddrFraud_GeoLink,	TRIM(LEFT.Input.GeoLink) <> '' AND KEYED(LEFT.Input.GeoLink = RIGHT.GeoLink),
																getAddressFraudV1(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));

	// Don't calculate these attributes unless the correct version is requested.
	final := CASE(attributesVersion,
								1 => version1,
										 working
								);
	
	RETURN(final);
END;
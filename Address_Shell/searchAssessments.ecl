/*
 * Searches the AVM key and LN_PropertyV2 key.  Eventually these keys should be
 * updated to use Address ID (AID).
 */

IMPORT ut, AVM_V2, LN_PropertyV2;

EXPORT Address_Shell.layoutPropertyCharacteristics searchAssessments (DATASET(Address_Shell.layoutPropertyCharacteristics) working, UNSIGNED1 attributesVersion = 1) := FUNCTION
/* ************************************************************
	 * Get AVM_V2 information - Since we can get multiple       *
   * results per input address we need to keep the assessment *
   * date for the rollup to ensure we return the most recent  *
   * AVM information.                                         *
	 ************************************************************ */
	workingLayout := RECORD
		Address_Shell.layoutPropertyCharacteristics;
		STRING4 assessmentYear := '';
		STRING8 recordingDate := '';
	END;
	
	workingLayout getAVMV1(Address_Shell.layoutPropertyCharacteristics le, AVM_V2.Key_AVM_Address ri) := TRANSFORM
		SELF.PropertyAttributes.Version1.Property_Automated_Valuation := (STRING)ri.automated_valuation;
		SELF.PropertyAttributes.Version1.Property_Tax_Assessment_Valuation := (STRING)ri.tax_assessment_valuation;
		
		SELF.assessmentYear := IF(TRIM(ri.assessed_value_year) IN ['', '\n'], '0', TRIM(ri.assessed_value_year));
		SELF.recordingDate := IF(TRIM(ri.recording_date) IN ['', '\n'], '0', TRIM(ri.recording_date));
		
		// Keep everything already calculated
		SELF := le;
		SELF := [];
	END;
		
	version1AVMTemp := JOIN(working, AVM_V2.Key_AVM_Address, (TRIM(LEFT.Input.StreetName) <> '' AND TRIM(LEFT.Input.State) <> '' AND TRIM(LEFT.Input.Zip5) <> ''
																												AND TRIM(LEFT.Input.StreetNumber) <> '')
																												AND KEYED(LEFT.Input.StreetName = RIGHT.prim_name AND LEFT.Input.State = RIGHT.St
																												AND LEFT.Input.Zip5 = RIGHT.Zip AND LEFT.Input.StreetNumber = RIGHT.prim_range 
																												AND LEFT.Input.UnitNumber = RIGHT.sec_range),
																getAVMV1(LEFT, RIGHT), LEFT OUTER, KEEP(200), ATMOST(1000));

/* ************************************************************
	 *          Get the most recent AVM information:            *
	 ************************************************************ */
	workingLayout bestAVMV1(workingLayout le, workingLayout ri) := TRANSFORM
		// Keep the most recent AVM information.  If the assessment year is not known, try going with the recording date
		dateLeft := IF(le.assessmentYear = '0', le.recordingDate[1..4], le.assessmentYear);
		dateRight := IF(ri.assessmentYear = '0', ri.recordingDate[1..4], ri.assessmentYear);
		rightNewer := (UNSIGNED)dateRight > (UNSIGNED)dateLeft;
		
		SELF.PropertyAttributes.Version1.Property_Automated_Valuation := IF(rightNewer, ri.PropertyAttributes.Version1.Property_Automated_Valuation, le.PropertyAttributes.Version1.Property_Automated_Valuation);
		SELF.PropertyAttributes.Version1.Property_Tax_Assessment_Valuation := IF(rightNewer, ri.PropertyAttributes.Version1.Property_Tax_Assessment_Valuation, le.PropertyAttributes.Version1.Property_Tax_Assessment_Valuation);

		// Keep the most recent date (Year only)
		SELF.assessmentYear := IF(rightNewer, dateRight, dateLeft);
		SELF.recordingDate := IF(rightNewer, dateRight, dateLeft);
		
		SELF := le;
		SELF := [];
	END;
	
	version1AVMRolled := ROLLUP(version1AVMTemp, (LEFT.Input.StreetName = RIGHT.Input.StreetName AND LEFT.Input.State = RIGHT.Input.State
																								AND LEFT.Input.Zip5 = RIGHT.Input.Zip5 AND LEFT.Input.StreetNumber = RIGHT.Input.StreetNumber 
																								AND LEFT.Input.UnitNumber = RIGHT.Input.UnitNumber), bestAVMV1(LEFT, RIGHT));
	
	version1AVM := PROJECT(version1AVMRolled, TRANSFORM(Address_Shell.layoutPropertyCharacteristics, SELF := LEFT));
	
/* ************************************************************
	 *              Get Property V2 information:                *
	 ************************************************************ */
	Address_Shell.layoutPropertyCharacteristics getPropertyV1(Address_Shell.layoutPropertyCharacteristics le, LN_PropertyV2.Key_Prop_Address_V4 ri) := TRANSFORM
		SELF.PropertyAttributes.Version1.Property_Owned_Assessed_Total := (STRING)ri.Property_Owned_Assessed_Total;
		SELF.PropertyAttributes.Version1.Property_Owned_Purchase_Total := (STRING)ri.Property_Owned_Purchase_Total;
		SELF.PropertyAttributes.Version1.Property_Purchase_Amount := (STRING)ri.Purchase_Amount;
		
		// Keep everything already calculated
		SELF := le;
		SELF := [];
	END;

	version1Property := JOIN(working, LN_PropertyV2.Key_Prop_Address_V4, (TRIM(LEFT.Input.StreetNumber) <> '' AND TRIM(LEFT.Input.StreetName) <> ''
																																				AND TRIM(LEFT.Input.Zip5) <> '')
																																				AND KEYED(LEFT.Input.StreetNumber = RIGHT.prim_range AND LEFT.Input.StreetName = RIGHT.prim_name
																																				AND LEFT.Input.Zip5 = RIGHT.Zip AND LEFT.Input.StreetSuffix = RIGHT.suffix
																																				AND LEFT.Input.StreetPreDirection = RIGHT.predir AND LEFT.Input.StreetPostDirection = RIGHT.postdir
																																				AND LEFT.Input.UnitNumber = RIGHT.sec_range),
																		getPropertyV1(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(1000));

/* ************************************************************
	 *                    Combine Version 1:                    *
	 ************************************************************ */
	Address_Shell.layoutPropertyCharacteristics combineV1(Address_Shell.layoutPropertyCharacteristics le, Address_Shell.layoutPropertyCharacteristics ri) := TRANSFORM
		// AVM Fields
		SELF.PropertyAttributes.Version1.Property_Automated_Valuation := le.PropertyAttributes.Version1.Property_Automated_Valuation;
		SELF.PropertyAttributes.Version1.Property_Tax_Assessment_Valuation := le.PropertyAttributes.Version1.Property_Tax_Assessment_Valuation;
		// Property Fields
		SELF.PropertyAttributes.Version1.Property_Owned_Assessed_Total := ri.PropertyAttributes.Version1.Property_Owned_Assessed_Total;
		SELF.PropertyAttributes.Version1.Property_Owned_Purchase_Total := ri.PropertyAttributes.Version1.Property_Owned_Purchase_Total;
		SELF.PropertyAttributes.Version1.Property_Purchase_Amount := ri.PropertyAttributes.Version1.Property_Purchase_Amount;
		
		SELF := le;
		SELF := [];
	END;
	
	version1 := JOIN(version1AVM, version1Property, LEFT.Input.GeoLink = RIGHT.Input.GeoLink, combineV1(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(100));
	
	// Don't calculate these attributes unless the correct version is requested.
	final := CASE(attributesVersion,
								1 => version1,
										 working
								);
	
	RETURN(final);
END;
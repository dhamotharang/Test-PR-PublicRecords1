/*
 * Searches the foreclosure key by Zip, Street Number, Street Name, Street Suffix
 * and Street Pre Direction.  Eventually this key should be updated to use Address
 * ID (AID).
 */

IMPORT ut, Property;

EXPORT Address_Shell.layoutPropertyCharacteristics searchForeclosures (DATASET(Address_Shell.layoutPropertyCharacteristics) working, UNSIGNED1 attributesVersion = 1) := FUNCTION
/* ************************************************************
	 * Get all foreclosures at the input address - This can     *
   * result in multiple records per input address.            *
	 ************************************************************ */
	Address_Shell.layoutPropertyCharacteristics getForeclosuresV1(Address_Shell.layoutPropertyCharacteristics le, Property.Key_Foreclosures_Addr ri) := TRANSFORM
		SELF.PropertyAttributes.Version1.Foreclosure_Recording_Date := ri.recording_date;
		SELF.PropertyAttributes.Version1.Foreclosure_Count := IF(TRIM(ri.recording_date) <> '', '1', '0'); // Every record found with a non-blank date should be a foreclosure.
		
		// Keep everything already calculated
		SELF := le;
		SELF := [];
	END;
		
	version1Temp := JOIN(working, Property.Key_Foreclosures_Addr, (TRIM(LEFT.Input.Zip5) <> '' AND TRIM(LEFT.Input.StreetNumber) <> '' AND TRIM(LEFT.Input.StreetName) <> '' 
																																AND TRIM(LEFT.Input.StreetSuffix) <> '' AND TRIM(LEFT.Input.StreetPreDirection) <> '')
																																AND KEYED(LEFT.Input.Zip5 = RIGHT.situs1_zip AND LEFT.Input.StreetNumber = RIGHT.situs1_prim_range
																																AND LEFT.Input.StreetName = RIGHT.situs1_prim_name AND LEFT.Input.StreetSuffix = RIGHT.situs1_addr_suffix
																																AND LEFT.Input.StreetPreDirection = RIGHT.situs1_predir), 
																getForeclosuresV1(LEFT, RIGHT), LEFT OUTER, KEEP(200), ATMOST(1000));

	version1Dedup := DEDUP(SORT(version1Temp, Input.seq, PropertyAttributes.Version1.Foreclosure_Recording_Date), Input.seq, PropertyAttributes.Version1.Foreclosure_Recording_Date);
/* ************************************************************
	 * Count all foreclosures at the input address and keep     *
   * the most recent foreclosure date:                        *
	 ************************************************************ */
	Address_Shell.layoutPropertyCharacteristics countForeclosuresV1(Address_Shell.layoutPropertyCharacteristics le, Address_Shell.layoutPropertyCharacteristics ri) := TRANSFORM
		// Keep the most recent foreclosure date
		SELF.PropertyAttributes.Version1.Foreclosure_Recording_Date := (STRING)MAX((UNSIGNED)le.PropertyAttributes.Version1.Foreclosure_Recording_Date, (UNSIGNED)ri.PropertyATtributes.Version1.Foreclosure_Recording_Date);
		SELF.PropertyAttributes.Version1.Foreclosure_Count := (STRING)((UNSIGNED1)le.PropertyAttributes.Version1.Foreclosure_Count + (UNSIGNED1)ri.PropertyAttributes.Version1.Foreclosure_Count);
		
		SELF := le;
		SELF := [];
	END;
	
	version1 := ROLLUP(version1Dedup, (LEFT.Input.Zip5 = RIGHT.Input.Zip5 AND LEFT.Input.StreetNumber = RIGHT.Input.StreetNumber
																		AND LEFT.Input.StreetName = RIGHT.Input.StreetName AND LEFT.Input.StreetSuffix = RIGHT.Input.StreetSuffix
																		AND LEFT.Input.StreetPreDirection = RIGHT.Input.StreetPreDirection), countForeclosuresV1(LEFT, RIGHT));
	
	// Don't calculate these attributes unless the correct version is requested.
	final := CASE(attributesVersion,
								1 => version1,
										 working
								);
	
	RETURN(final);
END;
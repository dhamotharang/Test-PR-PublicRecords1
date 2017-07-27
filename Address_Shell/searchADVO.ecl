/*
 * Searches the ADVO Addr1 key by Zip, Prim Range, Prim Name, Suffix, Predir,
 * Postdir and Sec Range.  Eventually this key should be updated to use
 * Address ID (AID). 
 */

IMPORT ut, ADVO, Risk_Indicators;

EXPORT Address_Shell.layoutPropertyCharacteristics searchADVO (DATASET(Address_Shell.layoutPropertyCharacteristics) working, UNSIGNED1 attributesVersion = 1) := FUNCTION
/* ************************************************************
	 *            Get ADVO Addr1 Vacancy Data:                  *
	 ************************************************************ */
	Address_Shell.layoutPropertyCharacteristics getAdvoV1(Address_Shell.layoutPropertyCharacteristics le, ADVO.Key_Addr1 ri) := TRANSFORM
		SELF.PropertyAttributes.Version1.Address_Vacancy_Indicator := ri.Address_Vacancy_Indicator;
		
		// Keep everything already calculated
		SELF := le;
		SELF := [];
	END;

	// The Input section of working contains the DataRestrictionMask
	version1 := JOIN(working, ADVO.Key_Addr1, (TRIM(LEFT.Input.Zip5) <> '' AND TRIM(LEFT.Input.StreetNumber) <> '' AND TRIM(LEFT.Input.StreetName) <> '')
																					AND (LEFT.Input.DataRestrictionMask[Risk_Indicators.iid_constants.posADVORestriction] <> '1')
																					AND KEYED(LEFT.Input.Zip5 = RIGHT.Zip AND LEFT.Input.StreetNumber = RIGHT.prim_range AND LEFT.Input.StreetName = RIGHT.prim_name
																					AND LEFT.Input.StreetSuffix = RIGHT.addr_suffix AND LEFT.Input.StreetPreDirection = RIGHT.predir AND LEFT.Input.StreetPostDirection = RIGHT.postdir
																					AND LEFT.Input.UnitNumber = RIGHT.sec_range),
														getAdvoV1(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(1000));

	// Don't calculate these attributes unless the correct version is requested.
	final := CASE(attributesVersion,
								1 => version1,
										 working
								);
	
	RETURN(final);
END;
/*
 * Searches the safety key by GeoLink.  Currently this key
 * only contains firedepartment information, but it is possible
 * that this could be expanded to contain police department and
 * other safety information in the future.
 */

IMPORT ut, Address_Attributes;

EXPORT Address_Shell.layoutPropertyCharacteristics searchSafety (DATASET(Address_Shell.layoutPropertyCharacteristics) working, UNSIGNED1 attributesVersion = 1) := FUNCTION
	Address_Shell.layoutPropertyCharacteristics getSafetyV1(Address_Shell.layoutPropertyCharacteristics le, Address_Attributes.key_FireDepartment_geolink ri) := TRANSFORM
		SELF.PropertyAttributes.Version1.Career_Firefighter := IF(TRIM(le.PropertyAttributes.Version1.Career_Firefighter) = '', ri.Active_Firefighters_Career, le.PropertyAttributes.Version1.Career_Firefighter);
		SELF.PropertyAttributes.Version1.Volunteer_Firefighter := IF(TRIM(le.PropertyAttributes.Version1.Volunteer_Firefighter) = '', ri.Active_Firefighters_Volunteer, le.PropertyAttributes.Version1.Volunteer_Firefighter);
		dist := IF(TRIM(ri.Geo_Lat) <> '' AND TRIM(ri.Geo_Long) <> '', (STRING)Address_Shell.calculateGeoDistance((REAL)le.Input.GeoLat, (REAL)le.Input.GeoLong, (REAL)ri.Geo_Lat, (REAL)ri.Geo_Long), '');
		SELF.PropertyAttributes.Version1.Distance_To_Fire_Department := IF(TRIM(le.PropertyAttributes.Version1.Distance_To_Fire_Department) = '', dist, le.PropertyAttributes.Version1.Distance_To_Fire_Department);
		
		// Keep everything already calculated
		SELF := le;
		SELF := [];
	END;
	
	version1exactGeoLink := JOIN(working, Address_Attributes.key_FireDepartment_geolink, TRIM(LEFT.Input.GeoLink) <> '' AND KEYED(LEFT.Input.GeoLink = RIGHT.GeoLink), getSafetyV1(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(500));
	version1 := JOIN(version1exactGeoLink, Address_Attributes.key_FireDepartment_geolink, TRIM(LEFT.Input.GeoLink) <> '' AND KEYED(LEFT.Input.GeoLink[1..5] = RIGHT.GeoLink[1..5]), getSafetyV1(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(500));
	
	// Don't calculate these attributes unless the correct version is requested.
	final := CASE(attributesVersion,
								1 => version1,
										 working
								);

	/* ************************************************************
	 * Debugging section.  This is only turned on when          *
   * Address_Shell.Constants.debugging is set to TRUE and     *
   * then the service is redeployed.  Allows the dev to look  *
   * at each step of the process.  ECL Developers use only.   *
   ************************************************************ */
	#if(Address_Shell.Constants.debugging)
		#STORED('PRSafetyExact', version1exactGeoLink);
		#STORED('PRSafetyClose', version1);
	#end	
	
	RETURN(final);
END;
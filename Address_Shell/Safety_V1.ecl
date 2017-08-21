/*
 * The cleaned fire department file is set to be updated on a yearly basis.  However 
 * due to GeoLink changes this key should be rebuilt on a monthly basis.  Once Address
 * ID (AID) is rolled out, this can be updated to use that and only be built on a
 * yearly basis.
 */

IMPORT ut, Address, Address_Attributes, Risk_Indicators;

EXPORT Address_Shell.Layout_Safety_V1 Safety_V1() := FUNCTION
	/* *****************************************
   * Read in the raw firedepartment file and *
   * then clean the GeoLink information      *
   *******************************************/
	fireDepartments := Address_Shell.File_Fire_Departments;
	
	Address_Shell.Layout_Fire_Departments cleanAddress(Address_Shell.Layout_Fire_Departments le) := TRANSFORM
		tempStreetAddr := Address.Addr1FromComponents(le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
		cleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(tempStreetAddr, le.p_city_name, le.st, le.zip);
		
		SELF.st := cleanAddr[115..116];
		SELF.geo_lat := cleanAddr[146..155];
		SELF.geo_long := cleanAddr[156..166];
		SELF.geo_blk := cleanAddr[171..177];
		SELF.county := cleanAddr[143..145];
		SELF.geolink := cleanAddr[115..116] + cleanAddr[143..145] + cleanAddr[171..177]; // State + County + GeoBlock = GeoLink
		
		SELF := le;
	END;
	cleanedFireDepartments := PROJECT(fireDepartments, cleanAddress(LEFT));
	
	// Make sure that we only index the stuff that is actually populated...  For some reason some of the fields had newline characters in them.
	filteredFireDepartments := cleanedFireDepartments (TRIM(GeoLink) NOT IN ['', '\n'] AND TRIM(Geo_Lat) NOT IN ['', '\n'] AND TRIM(Geo_Long) NOT IN ['', '\n']);
	
  /* *****************************************
   * Everything is clean, index grab the     *
   * information that we care about.         *
   *******************************************/
	Address_Shell.Layout_Safety_V1 intoSafetyV1(Address_Shell.Layout_Fire_Departments le) := TRANSFORM
		// Need to save the Latitude and Longitude to calculate the distance to the firedepartment
		SELF.GeoLat := le.geo_lat;
		SELF.GeoLong := le.geo_long;
		
		SELF.GeoLink := le.geolink;
		SELF.Active_Career_Firefighter := le.Active_Firefighters_Career;
		SELF.Active_Volunteer_Firefighter := le.Active_Firefighters_Volunteer;
	END;
	final := PROJECT(filteredFireDepartments, intoSafetyV1(LEFT));
	
	RETURN(final);
END;
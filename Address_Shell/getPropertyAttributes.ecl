/* 
 * getPropertyAttributes: This function takes in the input and returns the
 * public records attributes relating to the input property and surrounding
 * neighborhoods.  It then places this information into a flat layout for return.
 * This function should be batch friendly.
 */

IMPORT iesp, InsuranceContext_iesp,doxie, ut;

EXPORT Address_Shell.layoutPropertyCharacteristics getPropertyAttributes (DATASET(Address_Shell.layoutInput) input, UNSIGNED1 attributesVersion = 1,doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
/* ************************************************************
	 * All searching will be done by GeoLink or ZIP/PrimRange/  *
   * PrimName/Suffix/PreDir for the time being, but           *
   * eventually this could and should be replaced by Address  *
   * ID (AID) when it finally gets rolled out.                *
   ************************************************************
   * Start by placing the input into the working layout. This *
   * will be passed around to each function:                  *
	 ************************************************************ */
	Address_Shell.layoutPropertyCharacteristics intoWorking(Address_Shell.layoutInput le) := TRANSFORM
		SELF.Input.StreetNumber := le.StreetNumber;
		SELF.Input.StreetPreDirection := le.StreetPreDirection;
		SELF.Input.StreetName := le.StreetName;
		SELF.Input.StreetSuffix := le.StreetSuffix;
		SELF.Input.StreetPostDirection := le.StreetPostDirection;
		SELF.Input.UnitDesignation := le.UnitDesignation;
		SELF.Input.UnitNumber := le.UnitNumber;
		SELF.Input.StreetAddress1 := le.StreetAddress1;
		SELF.Input.StreetAddress2 := le.StreetAddress2;
		SELF.Input.City := le.City;
		SELF.Input.State := le.State;
		SELF.Input.Zip5 := le.Zip5;
		SELF.Input.Zip4 := le.Zip4;
		SELF.Input.County := le.County;
		SELF.Input.PostalCode := le.PostalCode;
		SELF.Input.StateCityZip := le.StateCityZip;
		SELF.Input.GeoLat := le.GeoLat;
		SELF.Input.GeoLong := le.GeoLong;
		SELF.Input.GeoLink := le.GeoLink;
		
		// Version 1 attributes contain simply the cleaned input state...  Not sure why they want this info - but they do.
		SELF.PropertyAttributes.Version1.State := IF(attributesVersion IN [1], le.State, '');
		
		SELF.Input := le;
		SELF := [];
	END;
	working := PROJECT(input, intoWorking(LEFT));
	
/* ************************************************************
	 *      Get firefighter and other safety information:       *
	 ************************************************************ */
	firefighters := Address_Shell.searchSafety(working, attributesVersion);
	
/* ************************************************************
	 *              Get foreclosure information:                *
	 ************************************************************ */
	foreclosures := Address_Shell.searchForeclosures(firefighters, attributesVersion,mod_access);
	
/* ************************************************************
	 *               Get assessment information:                *
	 ************************************************************ */
	assessment := Address_Shell.searchAssessments(foreclosures, attributesVersion);
	
/* ************************************************************
	 *             Get index attribute information:             *
	 ************************************************************ */
	indexes := Address_Shell.searchAddressFraud(assessment, attributesVersion);
	
/* ************************************************************
	 *             Get vacancy attribute information:           *
	 ************************************************************ */
	advo := Address_Shell.searchADVO(indexes, attributesVersion);

/* ************************************************************
	 * Debugging section.  This is only turned on when          *
   * Address_Shell.Constants.debugging is set to TRUE and     *
   * then the service is redeployed.  Allows the dev to look  *
   * at each step of the process.  ECL Developers use only.   *
   ************************************************************ */
	#if(Address_Shell.Constants.debugging)
		#STORED('PAFirefighters', firefighters);
		#STORED('PAForeclosures', foreclosures);
		#STORED('PAAssessment', assessment);
		#STORED('PAIndexes', indexes);
		#STORED('PAAdvo', advo);
	#end
	
	RETURN(advo);
END;
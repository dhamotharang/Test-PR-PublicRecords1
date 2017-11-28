IMPORT BIPV2, Business_Risk, Business_Risk_BIP, DueDiligence, ADDRESS_ATTRIBUTES, Risk_Indicators, STD, Easi, Codes;

EXPORT getBusGeographicRisk(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											     Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
													 boolean DebugMode = FALSE
											     ) := FUNCTION
	
  // ------                                                                                -----
  // ------   THIS FUNCTION IS EXPECTING THE 3 DIGIT FIPS CODE TO BE POPULATED             -----
	// ------   IT NEEDS BOTH THE 3 DIGIT FIPS AND THE 5 DIGIT FIPS CODE                     -----
	// ------   The FIPS county code is a five-digit Federal Information Processing          -----
	// ------   Standards (FIPS) code (FIPS 6-4) which uniquely identifies counties and      -----
	// ------   county equivalents in the United States,                                     -----

  // ------                                                                                     ------
	// ------ Pick up the EasiTotCrime this state and county and geo blk                          ------  
	// ------ from the Census Keys.  The address cleaner picked up the county put into the        ------
	// ------ Busn_info.address of the Busn_Internal layout.                                      ------
	// ------   Use 3 digits FIPS code to build the geolink                                       ------
	// ------   Build the 5 digit FIPS code using the state code                                  ------
	// ------   Use the 5 digit FIPS code to determine if the county area matches the lists       ------
	// ------   created in the duediligence.constants                                             ------
	// ------                                                                                     ------
	// ------ Note:  The Easi - if we cannot find any Census data for this geographic location    ------
	// ------        per our requirements the "not found" condition will produce the same result  ------
	// ------        a low to average crime index                                                 ------
	
 withEasiCensus := join(BusnData, Easi.Key_Easi_Census,
		keyed(right.geolink = left.Busn_info.address.state + left.Busn_info.address.county + left.Busn_info.address.geo_blk),
		transform(DueDiligence.layouts.Busn_Internal, 
		        /*  Set all of the County/State area risk indicators   */
		        self.EasiTotCrime             := right.totcrime;
						self.buildgeolink             := left.Busn_info.address.state + left.Busn_info.address.county + left.Busn_info.address.geo_blk;
						integer tempCrimeValue        := (integer)right.totcrime;   
						self.CountyHasHighCrimeIndex  := tempCrimeValue >= DueDiligence.Constants.HighCrimeValue;
						/* populate the remaining business internal record with data from the left  */ 
						self                          := left;), left outer,
		ATMOST
		    (keyed(right.geolink = left.Busn_info.address.state + left.Busn_info.address.county + left.Busn_info.address.geo_blk), 
				 DueDiligence.Constants.MAX_ATMOST), KEEP(1));
  
	

  // ------                                                                                     ------
	// ------ Start setting the HIFCA                                                             ------  
	// ------    Busn_info address is the cleaned input                                           ------
	// ------    Note: make sure we are using the best or the cleaned                             ------
	// ------                                                                                     ------
 withGeographicRisk  :=  PROJECT(withEasiCensus,  
			TRANSFORM(DueDiligence.layouts.Busn_Internal,
			 /* populate the remaining business internal record with data from the left  */ 
						SELF.FIPSCode                  := codes.st2FipsCode(StringLib.StringToUpperCase(left.Busn_info.address.state)) + left.Busn_info.address.county;
				    STRING5 tempFIPS               := codes.st2FipsCode(StringLib.StringToUpperCase(left.Busn_info.address.state)) + left.Busn_info.address.county; 
			      SELF.HIFCA                     := IF(tempFIPS IN DueDiligence.Constants.setHIFCA,1,0);
			      SELF.HIDTA                     := IF(tempFIPS IN DueDiligence.Constants.setHIDTA,1,0);
				    SELF.CountyBordersForgeinJur   := IF(tempFIPS IN DueDiligence.Constants.CountyForeignJurisdic,1,0);   
				    SELF.CountyBorderOceanForgJur  := IF(tempFIPS IN DueDiligence.Constants.CountyBordersOceanForgJur,1,0);
				    /*  Set all of the City/State area risk indicators   */  
				    SELF.CityState                 := TRIM(left.Busn_info.address.city, LEFT, RIGHT) + ','+ left.Busn_info.address.state; 
				    tempCityState                  := TRIM(left.Busn_info.address.city, LEFT, RIGHT) + ','+ left.Busn_info.address.state;
				    self.CityBorderStation         := tempCityState in DueDiligence.Constants.CityBorderStation;
				    self.CityFerryCrossing         := tempCityState in DueDiligence.Constants.CityFerryCrossing; 
				    self.CityRailStation           := tempCityState in DueDiligence.Constants.CityRailStation; 
				    SELF                 := LEFT)); 






  // ********************
	//   DEBUGGING OUTPUTS
	// *********************

	 //IF(DebugMode,      OUTPUT(CHOOSEN(buildgeolink, 100),                          NAMED('buildgeolink')));
	 IF(DebugMode,      OUTPUT(CHOOSEN(withGeographicRisk, 100),                       NAMED('withGeographicRisk')));
	 //IF(DebugMode,      OUTPUT(CHOOSEN(setSomeFields, 100),                          NAMED('setSomeFields')));
	
	 

	
	RETURN withGeographicRisk;
END;


 // ***********************
 //   JUST FOR UNIT TESTING
 // ***********************
 // JustforTesting := DueDiligence.ForTesting_populate_Busn_Internal.CreateSomeTestCase(withEasiCensus,DueDiligence.ForTesting_populate_Busn_Internal.HIFCA_TEST_CASE);   
 // JustforTesting := DueDiligence.ForTesting_populate_Busn_Internal.CreateSomeTestCase(withEasiCensus,DueDiligence.ForTesting_populate_Busn_Internal.HIDTA_TEST_CASE);   
 // JustforTesting := DueDiligence.ForTesting_populate_Busn_Internal.CreateSomeTestCase(withEasiCensus,DueDiligence.ForTesting_populate_Busn_Internal.COUNTY_FOREIGN_JURISDIC);   
 // JustforTesting := DueDiligence.ForTesting_populate_Busn_Internal.CreateSomeTestCase(withEasiCensus,DueDiligence.ForTesting_populate_Busn_Internal.COUNTY_BORDERS_OCEAN);   
 // JustforTesting := DueDiligence.ForTesting_populate_Busn_Internal.CreateSomeTestCase(withEasiCensus,DueDiligence.ForTesting_populate_Busn_Internal.CITY_RAIL_CITY_BORDER);   
 // JustforTesting := DueDiligence.ForTesting_populate_Busn_Internal.CreateSomeTestCase(withEasiCensus,DueDiligence.ForTesting_populate_Busn_Internal.CITY_FERRY_CROSSING); 
 // setSomeFields  :=  PROJECT(JustforTesting,                   //***CAUTION FOR TESTING ONLY ***//
	
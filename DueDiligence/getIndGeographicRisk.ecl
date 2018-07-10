IMPORT DueDiligence; 

EXPORT getIndGeographicRisk(DATASET(DueDiligence.Layouts.Indv_Internal) inData, 
											     UNSIGNED1 dppa,
												   UNSIGNED1 glba,
												   BOOLEAN includeReport = FALSE) := FUNCTION
	
 
  // ------                                                                                    ------
	// ------ Start by calling the Geographic Risk Function                                      ------  
	// ------    The individual address IS the cleaned input  and geo blk came from the          ------
  // ------    address cleaner.  we also rely on getIndBestData to populate the address        ------
	// ------                                                                                    ------
 ListOfAddresses  :=  PROJECT(inData,  
			TRANSFORM(DueDiligence.layoutsInternal.GeographicLayout,
			 /* populate the Geographic internal record with address data from the left  */ 
						   SELF.seq    := LEFT.seq; 
							 SELF.did    := LEFT.inquiredDID;              
							 SELF.streetaddress1  := LEFT.indvCleanInput.address.streetaddress1;
							 SELF.streetaddress2  := LEFT.indvCleanInput.address.streetaddress2;
							 SELF.prim_range      := LEFT.indvCleanInput.address.prim_range;
							 SELF.predir          := LEFT.indvCleanInput.address.predir;
							 SELF.prim_name       := LEFT.indvCleanInput.address.prim_name;
							 SELF.addr_suffix     := LEFT.indvCleanInput.address.addr_suffix;
							 SELF.postdir         := LEFT.indvCleanInput.address.postdir;
							 SELF.unit_desig      := LEFT.indvCleanInput.address.unit_desig;
							 SELF.sec_range       := LEFT.indvCleanInput.address.sec_range;
							 SELF.city            := LEFT.indvCleanInput.address.city;
							 SELF.zip5            := LEFT.indvCleanInput.address.zip5;
							 SELF.zip4            := LEFT.indvCleanInput.address.zip4;
							 SELF.cart            := LEFT.indvCleanInput.address.cart;
							 SELF.state           := LEFT.indvCleanInput.address.state;
							 SELF.county          := LEFT.indvCleanInput.address.county;
							 SELF.geo_blk         := LEFT.indvCleanInput.address.geo_blk;
				       SELF                 := LEFT;
						   SELF                 := []));  //***all other fields can be empty

  // ------                                                                                   ------
  // ------ Determine the Geographic Risk for the Inquired Individual                         ------
	// ------                                                                                  ------
	AddressPersonGeoRisk   := DueDiligence.Common.getGeographicRisk(ListOfAddresses);  

  // ------                                                                                    ------
  // ------ add the Geographic Risk to Indv_Internal layout.                                   ------
	// ------                                                                                    ------
	WithPersonGeoRisk := JOIN(InData, AddressPersonGeoRisk,
												LEFT.seq          = RIGHT.seq AND
												LEFT.inquiredDID  = RIGHT.did,												
												TRANSFORM(DueDiligence.Layouts.Indv_Internal, 
												     /*  Populate the Business Internal will the Geographic risk from the RIGHT */  
																	SELF.buildgeolink              := RIGHT.buildgeolink,	
																	SELF.EasiTotCrime              := RIGHT.EasiTotCrime;
																	SELF.CityState                 := RIGHT.CityState;
																	SELF.CountyHasHighCrimeIndex   := RIGHT.CountyHasHighCrimeIndex;
																	SELF.CountyBordersForgeinJur   := Right.CountyBordersForgeinJur;
																	SELF.CountyBorderOceanForgJur  := RIGHT.CountyBorderOceanForgJur;
																	SELF.CityBorderStation         := RIGHT.CityBorderStation;
																	SELF.CityFerryCrossing         := RIGHT.CityFerryCrossing;
																	SELF.CityRailStation           := RIGHT.CityRailStation;
																	SELF.HIDTA                     := RIGHT.HIDTA;
																	SELF.HIFCA                     := RIGHT.HIFCA;
                                  SELF.FipsCode                  := RIGHT.FipsCode;
                                  SELF.CountyName                := RIGHT.CountyName;  
																	/*  Populate the rest of the Business Internal from the LEFT             */
																	SELF := LEFT),
																	LEFT OUTER);
																	



  // ********************
	//   DEBUGGING OUTPUTS
	// *********************

	 //OUTPUT(CHOOSEN(ListOfAddresses, 100),    NAMED('ListOfAddresses'));
	 //OUTPUT(CHOOSEN(AddressPersonGeoRisk, 100), NAMED('AddressPersonGeoRisk'));
	 //OUTPUT(CHOOSEN(WithPersonGeoRisk, 100),    NAMED('WithPersonGeoRisk'));
	 
	RETURN WithPersonGeoRisk;
END;

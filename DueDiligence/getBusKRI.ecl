IMPORT UT, DueDiligence, STD;

EXPORT getBusKRI(DATASET(DueDiligence.Layouts.Busn_Internal) BusnBIPIDs) := FUNCTION
	
	//business not found
	STRING10 INVALID_BUSINESS_FLAGS := 'FFFFFFFFFF';
	STRING2 INVALID_BUSINESS_SCORE := '-1';

	//We have both companies with and without BIP IDs
	withBIPs := BusnBIPIDs(Busn_Info.BIP_IDs.PowID.LinkID <> 0 OR Busn_Info.BIP_IDs.ProxID.LinkID <> 0 OR Busn_Info.BIP_IDs.SeleID.LinkID <> 0 OR Busn_Info.BIP_IDs.OrgID.LinkID <> 0 OR Busn_Info.BIP_IDs.UltID.LinkID <> 0);
	noBIPs := BusnBIPIDs(Busn_Info.BIP_IDs.PowID.LinkID = 0 AND Busn_Info.BIP_IDs.ProxID.LinkID = 0 AND Busn_Info.BIP_IDs.SeleID.LinkID = 0 AND Busn_Info.BIP_IDs.OrgID.LinkID = 0 AND Busn_Info.BIP_IDs.UltID.LinkID = 0);
	

	DueDiligence.Layouts.Busn_Internal  BusnKRIs(BusnBIPIDs le)  := TRANSFORM
		
		SELF.BusLexID := le.Busn_info.BIP_IDS.SeleID.LinkID;
		
		/* Customer facing attribute  */  																																																	 
		 BusAssetOwnProperty_Flag9 := If (le.CurrPropOwnedCount >= 15,'T','F');                                     /* Index value of 9 was set */
		 BusAssetOwnProperty_Flag8 := IF (le.CurrPropOwnedCount between 10 and 14,'T','F');                         /* Index value of 8 was set */
		 BusAssetOwnProperty_Flag7 := IF (le.CurrPropOwnedCount between  6 and 9 ,'T','F');                         /* Index value of 7 was set */
		 BusAssetOwnProperty_Flag6 := IF (le.CurrPropOwnedCount = 5,'T','F');                                       /* Index value of 6 was set */
		 BusAssetOwnProperty_Flag5 := IF (le.CurrPropOwnedCount = 4,'T','F');                                       /* Index value of 5 was set */
		 BusAssetOwnProperty_Flag4 := IF (le.CurrPropOwnedCount = 3,'T','F');                                       /* Index value of 4 was set */
		 BusAssetOwnProperty_Flag3 := IF (le.CurrPropOwnedCount = 2,'T','F');                                       /* Index value of 3 was set */
		 BusAssetOwnProperty_Flag2 := IF (le.CurrPropOwnedCount = 1,'T','F');                                       /* Index value of 2 was set */
		 BusAssetOwnProperty_Flag1 := IF (le.CurrPropOwnedCount = 0,'T','F');                                       /* Index value of 1 was set */
		 
		 BusAssetOwnProperty_Flag_Concat := BusAssetOwnProperty_Flag9 +
																			BusAssetOwnProperty_Flag8 +
																			BusAssetOwnProperty_Flag7 +
																			BusAssetOwnProperty_Flag6 +
																			BusAssetOwnProperty_Flag5 +
																			BusAssetOwnProperty_Flag4 +
																			BusAssetOwnProperty_Flag3 +
																			BusAssetOwnProperty_Flag2 +
																			BusAssetOwnProperty_Flag1;
		 
		 BusAssetOwnProperty_Flag0        := IF(STD.Str.Find(BusAssetOwnProperty_Flag_Concat, 'T', 1) = 0, 'T', 'F');     /* Insufficient information reported on the business */
		 BusAssetOwn_property_Flag_final  := BusAssetOwnProperty_Flag_Concat + BusAssetOwnProperty_Flag0; 
		
		 self.BusAssetOwnProperty_Flags   :=  BusAssetOwn_property_Flag_final;                                            /* This a string of T or F based on how the data used to calculate the KRI  */
		 self.BusAssetOwnProperty         := (STRING)(10 - STD.Str.Find(BusAssetOwn_property_Flag_final, 'T', 1));        /* Set the index to the position of the first 'T'.  
	 
		
		
		/* Customer facing attribute  */  																																													 
		BusAssetOwnAircraft_Flag9 := If (le.AircraftCount >= 8,'T','F');                                           /* Index value of 9 was set */
		BusAssetOwnAircraft_Flag8 := IF (le.AircraftCount  = 7,'T','F');                                           /* Index value of 8 was set */	
		BusAssetOwnAircraft_Flag7 := IF (le.AircraftCount  = 6,'T','F');                                           /* Index value of 7 was set */
		BusAssetOwnAircraft_Flag6 := IF (le.AircraftCount  = 5,'T','F');                                           /* Index value of 6 was set */
		BusAssetOwnAircraft_Flag5 := IF (le.AircraftCount  = 4,'T','F');                                           /* Index value of 5 was set */
		BusAssetOwnAircraft_Flag4 := IF (le.AircraftCount  = 3,'T','F');                                           /* Index value of 4 was set */
		BusAssetOwnAircraft_Flag3 := IF (le.AircraftCount  = 2,'T','F');                                           /* Index value of 3 was set */
		BusAssetOwnAircraft_Flag2 := IF (le.AircraftCount  = 1,'T','F');                                           /* Index value of 2 was set */
		BusAssetOwnAircraft_Flag1 := IF (le.AircraftCount  = 0,'T','F');                                           /* Index value of 1 was set */
		
		BusAssetOwnAircraft_Flag_Concat := BusAssetOwnAircraft_Flag9 +
																			BusAssetOwnAircraft_Flag8 +
																			BusAssetOwnAircraft_Flag7 +
																			BusAssetOwnAircraft_Flag6 +
																			BusAssetOwnAircraft_Flag5 +
																			BusAssetOwnAircraft_Flag4 +
																			BusAssetOwnAircraft_Flag3 +
																			BusAssetOwnAircraft_Flag2 +
																			BusAssetOwnAircraft_Flag1;
		 
	 BusAssetOwnAircraft_Flag0        := IF(STD.Str.Find(BusAssetOwnAircraft_Flag_Concat, 'T', 1) = 0, 'T', 'F');     /* Insufficient information reported on the business */
	 BusAssetOwnAircraft_Flag_final   := BusAssetOwnAircraft_Flag_Concat + BusAssetOwnAircraft_Flag0; 
	
	 self.BusAssetOwnAircraft_Flags   :=  BusAssetOwnAircraft_Flag_final;                                             /* This a string of T or F based on how the data used to calculate the KRI  */
	 self.BusAssetOwnAircraft         := (STRING)(10-STD.Str.Find(BusAssetOwnAircraft_Flag_final, 'T', 1));           /* Set the index to the position of the first 'T'. */ 
																						 
																																																					 
		/* Customer facing attribute  */  
		BusAssetOwnWatercraft_Flag9 := If (le.WatercraftCount  >  0 AND le.Watercraftlength >= 200,'T','F');               /* Set the Index value to 9 */
		BusAssetOwnWatercraft_Flag8 := IF (le.WatercraftCount  >  0 AND le.Watercraftlength BETWEEN 100 AND 199,'T','F');  /* Set the Index value to 8 */	
		BusAssetOwnWatercraft_Flag7 := IF (le.WatercraftCount  >  0 AND le.Watercraftlength BETWEEN 50  AND 99,'T','F');  /* Set the Index value to 7 */
		BusAssetOwnWatercraft_Flag6 := IF (le.WatercraftCount  >= 6,'T','F');                                           /* Set the Index value to 6 */
		BusAssetOwnWatercraft_Flag5 := IF (le.WatercraftCount BETWEEN 4 AND 5,'T','F');                                 /* Set the Index value to 5 */
		BusAssetOwnWatercraft_Flag4 := IF (le.WatercraftCount  = 3,'T','F');                                            /* Set the Index value to 4 */
		BusAssetOwnWatercraft_Flag3 := IF (le.WatercraftCount  = 2,'T','F');                                            /* Set the Index value to 3 */
		BusAssetOwnWatercraft_Flag2 := IF (le.WatercraftCount  = 1,'T','F');                                            /* Set the Index value to 2  */
		BusAssetOwnWatercraft_Flag1 := IF (le.WatercraftCount  = 0,'T','F');                                            /* Set the Index value to 1 */
	
		BusAssetOwnWatercraft_Flag_Concat := BusAssetOwnWatercraft_Flag9 +
																			BusAssetOwnWatercraft_Flag8 +
																			BusAssetOwnWatercraft_Flag7 +
																			BusAssetOwnWatercraft_Flag6 +
																			BusAssetOwnWatercraft_Flag5 +
																			BusAssetOwnWatercraft_Flag4 +
																			BusAssetOwnWatercraft_Flag3 +
																			BusAssetOwnWatercraft_Flag2 +
																			BusAssetOwnWatercraft_Flag1;
	
		BusAssetOwnWatercraft_Flag0        := IF(STD.Str.Find(BusAssetOwnWatercraft_Flag_Concat, 'T', 1) = 0, 'T', 'F');     /* Insufficient information reported on the business */
		BusAssetOwnWatercraft_Flag_final   := BusAssetOwnWatercraft_Flag_Concat + BusAssetOwnWatercraft_Flag0; 
		
		self.BusAssetOwnWatercraft_Flags   :=  BusAssetOwnWatercraft_Flag_final;                                             /* This a string of T or F based on how the data used to calculate the KRI  */
		self.BusAssetOwnWatercraft         := (STRING)(10-STD.Str.Find(BusAssetOwnWatercraft_Flag_final, 'T', 1));                /* Set the index to the position of the first 'T'.  */
			
			
			
	  	/* Customer facing attribute  */  
		BusAssetOwnVehicle_Flag9 := If (le.VehicleCount  >  0 AND le.VehicleBaseValue >= 200000,'T','F');                  /* Set the Index value to 9 */
		BusAssetOwnVehicle_Flag8 := IF (le.VehicleCount  >  0 AND le.VehicleBaseValue BETWEEN 150000 AND 199999,'T','F');  /* Set the Index value to 8 */	
		BusAssetOwnVehicle_Flag7 := IF (le.VehicleCount  >  0 AND le.VehicleBaseValue BETWEEN 100000 AND 149999,'T','F');  /* Set the Index value to 7 */
		BusAssetOwnVehicle_Flag6 := IF (le.VehicleCount  >= 15,'T','F');                                                    /* Set the Index value to 6 */
		BusAssetOwnVehicle_Flag5 := IF (le.VehicleCount BETWEEN 11 AND 14,'T','F');                                          /* Set the Index value to 5 */
		BusAssetOwnVehicle_Flag4 := IF (le.VehicleCount BETWEEN  6 AND 10,'T','F');                               /* Set the Index value to 4 */
		BusAssetOwnVehicle_Flag3 := IF (le.VehicleCount BETWEEN  3 AND  5,'T','F');                               /* Set the Index value to 3 */
		BusAssetOwnVehicle_Flag2 := IF (le.VehicleCount BETWEEN  1 AND  2,'T','F');                               /* Set the Index value to 2  */
		BusAssetOwnVehicle_Flag1 := IF (le.VehicleCount  = 0,'T','F');                                            /* Set the Index value to 1 */
	
		BusAssetOwnVehicle_Flag_Concat := BusAssetOwnVehicle_Flag9 +
																			BusAssetOwnVehicle_Flag8 +
																			BusAssetOwnVehicle_Flag7 +
																			BusAssetOwnVehicle_Flag6 +
																			BusAssetOwnVehicle_Flag5 +
																			BusAssetOwnVehicle_Flag4 +
																			BusAssetOwnVehicle_Flag3 +
																			BusAssetOwnVehicle_Flag2 +
																			BusAssetOwnVehicle_Flag1;
	
		BusAssetOwnVehicle_Flag0        := IF(STD.Str.Find(BusAssetOwnVehicle_Flag_Concat, 'T', 1) = 0, 'T', 'F');     /* Insufficient information reported on the business */
		BusAssetOwnVehicle_Flag_final   := BusAssetOwnVehicle_Flag_Concat + BusAssetOwnVehicle_Flag0; 
		
		self.BusAssetOwnVehicle_Flags   :=  BusAssetOwnVehicle_Flag_final;                                             /* This a string of T or F based on how the data used to calculate the KRI  */
		self.BusAssetOwnVehicle         := (STRING)(10-STD.Str.Find(BusAssetOwnVehicle_Flag_final, 'T', 1));                /* Set the index to the position of the first 'T'.  */
																						
																						
		
																					
		
		
		/* Customer facing attribute  for BusValidityRisk*/  
		bvrZeroOperatingLocation := MAX(le.SOSAddrLocationCount, le.HDAddrCount) = 0;
		bvrOneOperatingLocation := MAX(le.SOSAddrLocationCount, le.HDAddrCount) = 1;
		bvrMultipleOperatingLocations := MAX(le.SOSAddrLocationCount, le.HDAddrCount) > 1;
		bvrZeroOptions := le.NoFein = TRUE AND le.busRegHit = FALSE AND le.creditSrcCnt = 0;	//no fein, not a registered bus, and no credit sources
		bvrOneOption := (le.NoFein = FALSE AND le.busRegHit = FALSE AND le.creditSrcCnt = 0) OR 	//fein, not a registered bus, and no credit sources
										(le.NoFein = TRUE AND le.busRegHit = TRUE AND le.creditSrcCnt = 0) OR 		//no fein, a registered bus, and no credit sources
										(le.NoFein = TRUE AND le.busRegHit = FALSE AND le.creditSrcCnt > 0);			//no fein, not a registered bus, and at least 1 credit source
		bvrTwoPlusOptions := (le.NoFein = FALSE AND le.busRegHit = TRUE) OR 			//fein and registered bus
												 (le.NoFein = FALSE AND le.creditSrcCnt > 0) OR				//fein and at least 1 credit source
												 (le.busRegHit = TRUE AND le.creditSrcCnt > 0);				//registered bus and at least 1 credit source
		
		bvrFlag9 := IF(bvrZeroOperatingLocation AND bvrZeroOptions, 'T', 'F');
		bvrFlag8 := IF(bvrZeroOperatingLocation AND bvrOneOption, 'T', 'F');
		bvrFlag7 := IF(bvrZeroOperatingLocation AND bvrTwoPlusOptions, 'T', 'F');
		bvrFlag6 := IF(bvrOneOperatingLocation AND bvrZeroOptions, 'T', 'F');
		bvrFlag5 := IF(bvrOneOperatingLocation AND bvrOneOption, 'T', 'F');
		bvrFlag4 := IF(bvrOneOperatingLocation AND bvrTwoPlusOptions, 'T', 'F');
		bvrFlag3 := IF(bvrMultipleOperatingLocations AND bvrZeroOptions, 'T', 'F');
		bvrFlag2 := IF(bvrMultipleOperatingLocations AND bvrOneOption, 'T', 'F');
		bvrFlag1 := IF(bvrMultipleOperatingLocations AND bvrTwoPlusOptions, 'T', 'F');
		
		bvrConcat := bvrFlag9 + bvrFlag8 + bvrFlag7 + bvrFlag6 + bvrFlag5 + bvrFlag4 + bvrFlag3 + bvrFlag2 + bvrFlag1;
		bvrFlag0 := IF(STD.Str.Find(bvrConcat, 'T', 1) = 0, 'T', 'F');                                           //Insufficient information reported on business and cannot calculate
		
		bvrConcat_final := bvrConcat + bvrFlag0;

		SELF.BusValidityRisk_Flags := bvrConcat_final;
		SELF.BusValidityRisk  := (STRING)(10-STD.Str.Find(bvrConcat_final, 'T', 1));
		
																		
		/* Determine the Customer facing attribute for BusSOSAgeRange  */ 
		SOSAge := DueDiligence.Common.DaysApartWithZeroEmptyDate((string)le.SOSIncorporationDate); //return 0 day to hit the 8 level if no date  (less than 1 year)       
		sosFlag9 := IF(le.NoSOSFilingEver AND (UNSIGNED)le.SOSIncorporationDate = 0, 'T', 'F');                                                            		 //business has no SOS filing reported
		sosFlag8 := IF(sosFlag9 = 'F' AND SOSAge < ut.DaysInNYears(1), 'T', 'F');                                		 //business SOS incropration date reported as less than 1 year ago
		sosFlag7 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(1) AND SOSAge < ut.DaysInNYears(2), 'T', 'F');   //business SOS incropration date reported between 1 and 2 years ago
		sosFlag6 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(2) AND SOSAge < ut.DaysInNYears(3), 'T', 'F');   //business SOS incropration date reported between 2 and 3 years ago
		sosFlag5 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(3) AND SOSAge < ut.DaysInNYears(4), 'T', 'F');   //business SOS incropration date reported between 3 and 4 years ago
		sosFlag4 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(4) AND SOSAge < ut.DaysInNYears(6), 'T', 'F');   //business SOS incropration date reported between 4 and 6 years ago
		sosFlag3 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(6) AND SOSAge < ut.DaysInNYears(8), 'T', 'F');   //business SOS incropration date reported between 6 and 8 years ago
		sosFlag2 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(8) AND SOSAge < ut.DaysInNYears(10), 'T', 'F');  //business SOS incropration date reported between 8 and 10 years ago
		sosFlag1 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(10), 'T', 'F');                               	 //business SOS incropration date reported 10 or more years ago
		
		sosConcat := sosFlag9 + sosFlag8 + sosFlag7 + sosFlag6 + sosFlag5 + sosFlag4 + sosFlag3 + sosFlag2 + sosFlag1;
		sosFlag0 := IF(STD.Str.Find(sosConcat, 'T', 1) = 0, 'T', 'F');                                           		//Insufficient information reported on business and cannot calculate
		
		sosConcat_Final := sosConcat + sosFlag0;

		SELF.BusSOSAgeRange_Flags := sosConcat_Final;
		SELF.BusSOSAgeRange  := (STRING)(10-STD.Str.Find(sosConcat_Final, 'T', 1)); 


		/* Determine the Customer facing attribute for BusPublicRecordAgeRange */ 
		HDRAge := DueDiligence.Common.DaysApartWithZeroEmptyDate((string)le.BusnHdrDtFirstSeen); //return 0 day to hit the 8 level if no date  (less than 1 year)
		hdrAgeFlag9 := IF(le.srcCount = 0, 'T', 'F');                                                                	 			//business not reported in public records
		hdrAgeFlag8 := IF(hdrAgeFlag9 = 'F' AND HDRAge < ut.DaysInNYears(1), 'T', 'F');                                			//business first reported in public records less than 1 year ago
		hdrAgeFlag7 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(1) AND HDRAge < ut.DaysInNYears(2), 'T', 'F');   	//business first reported in public records between 1 and 2 years ago
		hdrAgeFlag6 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(2) AND HDRAge < ut.DaysInNYears(3), 'T', 'F');   	//business first reported in public records between 2 and 3 years ago
		hdrAgeFlag5 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(3) AND HDRAge < ut.DaysInNYears(4), 'T', 'F');   	//business first reported in public records between 3 and 4 years ago
		hdrAgeFlag4 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(4) AND HDRAge < ut.DaysInNYears(6), 'T', 'F');   	//business first reported in public records between 4 and 6 years ago
		hdrAgeFlag3 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(6) AND HDRAge < ut.DaysInNYears(8), 'T', 'F');   	//business first reported in public records between 6 and 8 years ago
		hdrAgeFlag2 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(8) AND HDRAge < ut.DaysInNYears(10), 'T', 'F');  	//business first reported in public records between 8 and 10 years ago
		hdrAgeFlag1 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(10), 'T', 'F');                               		//business first reported in public records 10 or more years ago
		
		hdrAgeConcat := hdrAgeFlag9 + hdrAgeFlag8 + hdrAgeFlag7 + hdrAgeFlag6 + hdrAgeFlag5 + hdrAgeFlag4 + hdrAgeFlag3 + hdrAgeFlag2 + hdrAgeFlag1;
		hdrAgeFlag0 := IF(STD.Str.Find(hdrAgeConcat, 'T', 1) = 0, 'T', 'F');                                           			//Insufficient information reported on business and cannot calculate
		
		hdrAgeConcat_Final := hdrAgeConcat + hdrAgeFlag0;
		
		SELF.BusPublicRecordAgeRange_Flags := hdrAgeConcat_Final;
		SELF.BusPublicRecordAgeRange := (STRING)(10-STD.Str.Find(hdrAgeConcat_Final, 'T', 1)); 
		
		
		/* Determine the Customer facing attribute for BusStructureType */ 
		// structFlag9 := IF(le.busnType = DueDiligence.Constants.CMPTYP_PROPRIETORSHIP OR le.busnType = DueDiligence.Constants.CMPTYP_ASSUMED_NAME_DBA, 'T', 'F');
		// structFlag8 := IF(le.busnType = DueDiligence.Constants.CMPTYP_TRUST, 'T', 'F');
		// structFlag7 := IF(le.busnType = DueDiligence.Constants.CMPTYP_LIMITED_LIABILITY_CORP, 'T', 'F');
		// structFlag6 := IF(le.busnType = DueDiligence.Constants.CMPTYP_FOREIGN_LLC, 'T', 'F');
		// structFlag5 := IF(le.busnType = DueDiligence.Constants.CMPTYP_CORP_NON_PROFIT OR le.busnType = DueDiligence.Constants.CMPTYP_FOREIGN_CORP_NON_PROFIT, 'T', 'F');
		// structFlag4 := IF(le.busnType = DueDiligence.Constants.CMPTYP_CORP_BUSINESS OR le.busnType = DueDiligence.Constants.CMPTYP_FOREIGN_CORP, 'T', 'F');
		// structFlag3 := IF(le.busnType = DueDiligence.Constants.CMPTYP_PROFESSIONAL_CORP OR le.busnType = DueDiligence.Constants.CMPTYP_PROFESSIONAL_ASSOC, 'T', 'F');
		// structFlag2 := IF(le.busnType = DueDiligence.Constants.CMPTYP_LIMITED_PARTNERSHIP OR le.busnType = DueDiligence.Constants.CMPTYP_LIMITED_LIABILITY_PARTNERSHIP, 'T', 'F');
		// structFlag1 := IF(le.busnType = '', 'T', 'F');
		
		// structConcat := structFlag9 + structFlag8 + structFlag7 + structFlag6 + structFlag5 + structFlag4 + structFlag3 + structFlag2 + structFlag1;
		// structFlag0 := IF(STD.Str.Find(structConcat, 'T', 1) = 0, 'T', 'F');  	//Insufficient information reported on business and cannot calculate
		
		// structConcat_Final := structConcat + structFlag0;
		
		// SELF.BusStructureType_Flags := structConcat_Final;
		// SELF.BusStructureType := (STRING)(10-STD.Str.Find(structConcat_Final, 'T', 1)); 
		
		
		
		/* Determine the Customer facing attribute for BusIndustryRisk */
		industFlag9 := IF(le.sicNaicRisk.cibExists, 'T', 'F');
		industFlag8 := IF(le.sicNaicRisk.msbExists, 'T', 'F');
		industFlag7 := IF(le.sicNaicRisk.nbfiExists, 'T', 'F');
		industFlag6 := IF(le.sicNaicRisk.cagExists, 'T', 'F');
		industFlag5 := IF(le.sicNaicRisk.legAcctTeleFlightTravExists, 'T', 'F');
		industFlag4 := IF(le.sicNaicRisk.autoExists, 'T', 'F');
		industFlag3 := IF(le.sicNaicRisk.otherHighRiskIndustExists, 'T', 'F');
		industFlag2 := IF(le.sicNaicRisk.moderateRiskIndustExists, 'T', 'F');
		industFlag1 := IF(le.sicNaicRisk.lowRiskIndustExists, 'T', 'F');
		
		industConcat := industFlag9 + industFlag8 + industFlag7 + industFlag6 + industFlag5 + industFlag4 + industFlag3 + industFlag2 + industFlag1;
		industFlag0 := IF(STD.Str.Find(industConcat, 'T', 1) = 0, 'T', 'F');                                           			//Insufficient information reported on business and cannot calculate
		
		industConcat_Final := industConcat + industFlag0;
		
		SELF.BusIndustryRisk_Flags := industConcat_Final;
		SELF.BusIndustryRisk := (STRING)(10-STD.Str.Find(industConcat_Final, 'T', 1)); 
			
			
		SELF := le;
	END;


	KRIndexesBusn := project(sort(withBIPs, seq), BusnKRIs(left));
	kriIndexesUnknownBus := PROJECT(noBIPs, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																										SELF.BusAssetOwnProperty := INVALID_BUSINESS_SCORE;
																										SELF.BusAssetOwnProperty_Flags := INVALID_BUSINESS_FLAGS;
																										SELF.BusAssetOwnAircraft := INVALID_BUSINESS_SCORE;
																										SELF.BusAssetOwnAircraft_Flags := INVALID_BUSINESS_FLAGS;
																										SELF.BusAssetOwnWatercraft := INVALID_BUSINESS_SCORE;
																										SELF.BusAssetOwnWatercraft_Flags := INVALID_BUSINESS_FLAGS;
																										SELF.BusAssetOwnVehicle := INVALID_BUSINESS_SCORE;
																										SELF.BusAssetOwnVehicle_Flags := INVALID_BUSINESS_FLAGS;
																										// SELF.BusAccessToFundsProperty := INVALID_BUSINESS_SCORE;
																										// SELF.BusAccessToFundsProperty_Flags := INVALID_BUSINESS_FLAGS;
																										// SELF.BusGeographicRisk := INVALID_BUSINESS_SCORE;
																										// SELF.BusGeographicRisk_Flags := INVALID_BUSINESS_FLAGS;
																										SELF.BusValidityRisk := INVALID_BUSINESS_SCORE;
																										SELF.BusValidityRisk_Flags := INVALID_BUSINESS_FLAGS;
																										// SELF.BusStabilityRisk := INVALID_BUSINESS_SCORE;
																										// SELF.BusStabilityRisk_Flags := INVALID_BUSINESS_FLAGS;
																										SELF.BusIndustryRisk := INVALID_BUSINESS_SCORE;
																										SELF.BusIndustryRisk_Flags := INVALID_BUSINESS_FLAGS;
																										// SELF.BusStructureType := INVALID_BUSINESS_SCORE;
																										// SELF.BusStructureType_Flags := INVALID_BUSINESS_FLAGS;
																										SELF.BusSOSAgeRange := INVALID_BUSINESS_SCORE;
																										SELF.BusSOSAgeRange_Flags := INVALID_BUSINESS_FLAGS;
																										SELF.BusPublicRecordAgeRange := INVALID_BUSINESS_SCORE;
																										SELF.BusPublicRecordAgeRange_Flags := INVALID_BUSINESS_FLAGS;
																										// SELF.BusShellShelfRisk := INVALID_BUSINESS_SCORE;
																										// SELF.BusShellShelfRisk_Flags := INVALID_BUSINESS_FLAGS;
																										// SELF.BusMatchLevel := INVALID_BUSINESS_SCORE;
																										// SELF.BusMatchLevel_Flags := INVALID_BUSINESS_FLAGS;
																										// SELF.BusLegalEvents := INVALID_BUSINESS_SCORE;
																										// SELF.BusLegalEvents_Flags := INVALID_BUSINESS_FLAGS;
																										// SELF.BusLegalEventsFelonyType := INVALID_BUSINESS_SCORE;
																										// SELF.BusLegalEventsFelonyType_Flags := INVALID_BUSINESS_FLAGS;
																										// SELF.BusHighRiskNewsProfiles := INVALID_BUSINESS_SCORE;
																										// SELF.BusHighRiskNewsProfiles_Flags := INVALID_BUSINESS_FLAGS;
																										// SELF.BusLinkedBusRisk := INVALID_BUSINESS_SCORE;
																										// SELF.BusLinkedBusRisk_Flags := INVALID_BUSINESS_FLAGS;
																										// SELF.BusExecOfficersRisk := INVALID_BUSINESS_SCORE;
																										// SELF.BusExecOfficersRisk_Flags := INVALID_BUSINESS_FLAGS;
																										// SELF.BusExecOfficersResidencyRisk := INVALID_BUSINESS_SCORE;
																										// SELF.BusExecOfficersResidencyRisk_Flags := INVALID_BUSINESS_FLAGS;
																										SELF := LEFT;));



	RETURN KRIndexesBusn + kriIndexesUnknownBus;

END;

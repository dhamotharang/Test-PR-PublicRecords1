IMPORT UT, DueDiligence, STD;

EXPORT getBusKRI(DATASET(DueDiligence.Layouts.Busn_Internal) BusnBIPIDs) := FUNCTION
	
	//business not found
	STRING10 INVALID_BUSINESS_FLAGS := 'FFFFFFFFFF';
	STRING2 INVALID_BUSINESS_SCORE := '-1';

	//We have both companies with and without BIP IDs
	withBIPs := BusnBIPIDs(Busn_Info.BIP_IDs.PowID.LinkID <> DueDiligence.Constants.NUMERIC_ZERO OR Busn_Info.BIP_IDs.ProxID.LinkID <> DueDiligence.Constants.NUMERIC_ZERO OR Busn_Info.BIP_IDs.SeleID.LinkID <> DueDiligence.Constants.NUMERIC_ZERO OR Busn_Info.BIP_IDs.OrgID.LinkID <> DueDiligence.Constants.NUMERIC_ZERO OR Busn_Info.BIP_IDs.UltID.LinkID <> DueDiligence.Constants.NUMERIC_ZERO);
	noBIPs := BusnBIPIDs(Busn_Info.BIP_IDs.PowID.LinkID = DueDiligence.Constants.NUMERIC_ZERO AND Busn_Info.BIP_IDs.ProxID.LinkID = DueDiligence.Constants.NUMERIC_ZERO AND Busn_Info.BIP_IDs.SeleID.LinkID = DueDiligence.Constants.NUMERIC_ZERO AND Busn_Info.BIP_IDs.OrgID.LinkID = DueDiligence.Constants.NUMERIC_ZERO AND Busn_Info.BIP_IDs.UltID.LinkID = DueDiligence.Constants.NUMERIC_ZERO);
	

	DueDiligence.Layouts.Busn_Internal  BusnKRIs(BusnBIPIDs le)  := TRANSFORM
		
		SELF.BusLexID := (STRING)le.Busn_info.BIP_IDS.SeleID.LinkID;
		
		/* BUSINESS ASSETS OWNED PROPERTY  */  																																																	 
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
		
		 self.BusAssetOwnProperty_Flag   :=  BusAssetOwn_property_Flag_final;                                            /* This a string of T or F based on how the data used to calculate the KRI  */
		 self.BusAssetOwnProperty         := (STRING)(10 - STD.Str.Find(BusAssetOwn_property_Flag_final, 'T', 1));        /* Set the index to the position of the first 'T'.  
	 
		
		
		/* BUSINESS ASSET OWNED AIRCRAFT */  																																													 
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
	
	 self.BusAssetOwnAircraft_Flag   :=  BusAssetOwnAircraft_Flag_final;                                             /* This a string of T or F based on how the data used to calculate the KRI  */
	 self.BusAssetOwnAircraft         := (STRING)(10-STD.Str.Find(BusAssetOwnAircraft_Flag_final, 'T', 1));           /* Set the index to the position of the first 'T'. */ 
																						 
																																																					 
		/* BUSINESS ASSET OWNED WATERCRAFT  */  
		BusAssetOwnWatercraft_Flag9 := If (le.WatercraftCount  >  0 AND le.Watercraftlength >= 200,'T','F');               /* Set the Index value to 9 */
		BusAssetOwnWatercraft_Flag8 := IF (le.WatercraftCount  >  0 AND le.Watercraftlength BETWEEN 100 AND 199,'T','F');  /* Set the Index value to 8 */	
		BusAssetOwnWatercraft_Flag7 := IF (le.WatercraftCount  >  0 AND le.Watercraftlength BETWEEN 50  AND 99,'T','F');   /* Set the Index value to 7 */
		BusAssetOwnWatercraft_Flag6 := IF (le.WatercraftCount  >= 6,'T','F');                                              /* Set the Index value to 6 */
		BusAssetOwnWatercraft_Flag5 := IF (le.WatercraftCount BETWEEN 4 AND 5,'T','F');                                    /* Set the Index value to 5 */
		BusAssetOwnWatercraft_Flag4 := IF (le.WatercraftCount  = 3,'T','F');                                               /* Set the Index value to 4 */
		BusAssetOwnWatercraft_Flag3 := IF (le.WatercraftCount  = 2,'T','F');                                               /* Set the Index value to 3 */
		BusAssetOwnWatercraft_Flag2 := IF (le.WatercraftCount  = 1,'T','F');                                               /* Set the Index value to 2  */
		BusAssetOwnWatercraft_Flag1 := IF (le.WatercraftCount  = 0,'T','F');                                               /* Set the Index value to 1 */
	
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
		
		self.BusAssetOwnWatercraft_Flag   :=  BusAssetOwnWatercraft_Flag_final;                                             /* This a string of T or F based on how the data used to calculate the KRI  */
		self.BusAssetOwnWatercraft         := (STRING)(10-STD.Str.Find(BusAssetOwnWatercraft_Flag_final, 'T', 1));           /* Set the index to the position of the first 'T'.  */
			
			
			
	  	/* ASSETS OWNED VEHICLE  */  
		BusAssetOwnVehicle_Flag9 := If (le.VehicleCount  >  0 AND le.VehicleBaseValue >= 200000,'T','F');                  /* Set the Index value to 9 */
		BusAssetOwnVehicle_Flag8 := IF (le.VehicleCount  >  0 AND le.VehicleBaseValue BETWEEN 150000 AND 199999,'T','F');  /* Set the Index value to 8 */	
		BusAssetOwnVehicle_Flag7 := IF (le.VehicleCount  >  0 AND le.VehicleBaseValue BETWEEN 100000 AND 149999,'T','F');  /* Set the Index value to 7 */
		BusAssetOwnVehicle_Flag6 := IF (le.VehicleCount  >= 150,'T','F');                                                  /* Set the Index value to 6 */
		BusAssetOwnVehicle_Flag5 := IF (le.VehicleCount BETWEEN 50 AND 149,'T','F');                                       /* Set the Index value to 5 */
		BusAssetOwnVehicle_Flag4 := IF (le.VehicleCount BETWEEN 25 AND 49,'T','F');                                        /* Set the Index value to 4 */
		BusAssetOwnVehicle_Flag3 := IF (le.VehicleCount BETWEEN 10 AND 24,'T','F');                                        /* Set the Index value to 3 */
		BusAssetOwnVehicle_Flag2 := IF (le.VehicleCount BETWEEN  1 AND  9,'T','F');                                        /* Set the Index value to 2  */
		BusAssetOwnVehicle_Flag1 := IF (le.VehicleCount  = 0,'T','F');                                                     /* Set the Index value to 1 */
	
		BusAssetOwnVehicle_Flag_Concat := BusAssetOwnVehicle_Flag9 +
																			BusAssetOwnVehicle_Flag8 +
																			BusAssetOwnVehicle_Flag7 +
																			BusAssetOwnVehicle_Flag6 +
																			BusAssetOwnVehicle_Flag5 +
																			BusAssetOwnVehicle_Flag4 +
																			BusAssetOwnVehicle_Flag3 +
																			BusAssetOwnVehicle_Flag2 +
																			BusAssetOwnVehicle_Flag1;
	
		BusAssetOwnVehicle_Flag0        := IF(STD.Str.Find(BusAssetOwnVehicle_Flag_Concat, 'T', 1) = 0, 'T', 'F');      /* Insufficient information reported on the business */
		BusAssetOwnVehicle_Flag_final   := BusAssetOwnVehicle_Flag_Concat + BusAssetOwnVehicle_Flag0; 
		
		self.BusAssetOwnVehicle_Flag   :=  BusAssetOwnVehicle_Flag_final;                                              /* This a string of T or F based on how the data used to calculate the KRI  */
		self.BusAssetOwnVehicle         := (STRING)(10-STD.Str.Find(BusAssetOwnVehicle_Flag_final, 'T', 1));            /* Set the index to the position of the first 'T'.  */
																						
																						
		/* ACCESS TO FUNDS PROPERTY  */  																																																	 
		 BusAccessToFundsProperty_Flag9 := If (le.CurrPropOwnedCount > 0  AND le.PropTaxValue >=                    15000000,'T','F');               /* Index value of 9 was set */
		 BusAccessToFundsProperty_Flag8 := IF (le.CurrPropOwnedCount > 0  AND le.PropTaxValue between   5000000 and 14999999,'T','F');               /* Index value of 8 was set */
		 BusAccessToFundsProperty_Flag7 := IF (le.CurrPropOwnedCount > 0  AND le.PropTaxValue between   1000000 and  4999999,'T','F');               /* Index value of 7 was set */
		 BusAccessToFundsProperty_Flag6 := IF (le.CurrPropOwnedCount > 0  AND le.PropTaxValue between    500000 and  999999,'T','F');                /* Index value of 6 was set */
		 BusAccessToFundsProperty_Flag5 := IF (le.CurrPropOwnedCount > 0  AND le.PropTaxValue between    200000 and  499999,'T','F');                /* Index value of 5 was set */
		 BusAccessToFundsProperty_Flag4 := IF (le.CurrPropOwnedCount > 0  AND le.PropTaxValue between     50000 and  199999,'T','F');                /* Index value of 4 was set */
		 BusAccessToFundsProperty_Flag3 := IF (le.CurrPropOwnedCount > 0  AND le.PropTaxValue <=                      49999,'T','F');                /* Index value of 3 was set */
		 BusAccessToFundsProperty_Flag2 := IF (le.CurrPropOwnedCount = 0  AND le.CountSoldProp > 0,'T','F');                                         /* Index value of 2 was set */
		 BusAccessToFundsProperty_Flag1 := IF (le.PropTaxValue = 0        AND le.CurrPropOwnedCount = 0 AND le.CountSoldProp = 0,'T','F');           /* Index value of 1 was set */
		 
		 BusAccessToFundsProperty_Flag_Concat := BusAccessToFundsProperty_Flag9 +
																			BusAccessToFundsProperty_Flag8 +
																			BusAccessToFundsProperty_Flag7 +
																			BusAccessToFundsProperty_Flag6 +
																			BusAccessToFundsProperty_Flag5 +
																			BusAccessToFundsProperty_Flag4 +
																			BusAccessToFundsProperty_Flag3 +
																			BusAccessToFundsProperty_Flag2 +
																			BusAccessToFundsProperty_Flag1;
		 
		 BusAccessToFundsProperty_Flag0       := IF(STD.Str.Find(BusAccessToFundsProperty_Flag_Concat, 'T', 1) = 0, 'T', 'F');     /* Insufficient information reported on the business */
		 BusAccessToFundsProperty_Flag_final  := BusAccessToFundsProperty_Flag_Concat + BusAccessToFundsProperty_Flag0; 
		
		 self.BusAccessToFundsProperty_Flag  :=  BusAccessToFundsProperty_Flag_final;                                            /* This a string of T or F based on how the data used to calculate the KRI  */
		 self.BusAccessToFundsProperty        := (STRING)(10 - STD.Str.Find(BusAccessToFundsProperty_Flag_final, 'T', 1));        /* Set the index to the position of the first 'T'.  
	 

		/*BUSINESS VALIDITY RISK*/  
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
		bvrFlag8 := IF(bvrOneOperatingLocation AND bvrZeroOptions, 'T', 'F');
		bvrFlag7 := IF(bvrMultipleOperatingLocations AND bvrZeroOptions, 'T', 'F');
		bvrFlag6 := IF(bvrZeroOperatingLocation AND bvrOneOption, 'T', 'F');
		bvrFlag5 := IF(bvrOneOperatingLocation AND bvrOneOption, 'T', 'F');
		bvrFlag4 := IF(bvrMultipleOperatingLocations AND bvrOneOption, 'T', 'F');
		bvrFlag3 := IF(bvrZeroOperatingLocation AND bvrTwoPlusOptions, 'T', 'F');
		bvrFlag2 := IF(bvrOneOperatingLocation AND bvrTwoPlusOptions, 'T', 'F');
		bvrFlag1 := IF(bvrMultipleOperatingLocations AND bvrTwoPlusOptions, 'T', 'F');

		bvrConcat := bvrFlag9 + bvrFlag8 + bvrFlag7 + bvrFlag6 + bvrFlag5 + bvrFlag4 + bvrFlag3 + bvrFlag2 + bvrFlag1;
		bvrFlag0 := IF(STD.Str.Find(bvrConcat, 'T', 1) = 0, 'T', 'F');    //Insufficient information reported on business and cannot calculate
		
		bvrConcat_final := bvrConcat + bvrFlag0;

		SELF.BusValidity_Flag := bvrConcat_final;
		SELF.BusValidity  := (STRING)(10-STD.Str.Find(bvrConcat_final, 'T', 1));
		
																		
		/*BUSINESS SOS AGE RANGE*/ 
		SOSAge := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)le.SOSIncorporationDate, (STRING)le.historyDate);       
		sosFlag9 := IF(le.NoSOSFilingEver AND (UNSIGNED)le.SOSIncorporationDate = 0, 'T', 'F');                                                            		 
		sosFlag8 := IF(sosFlag9 = 'F' AND SOSAge < ut.DaysInNYears(1), 'T', 'F');                                		 
		sosFlag7 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(1) AND SOSAge < ut.DaysInNYears(2), 'T', 'F');  
		sosFlag6 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(2) AND SOSAge < ut.DaysInNYears(3), 'T', 'F');   
		sosFlag5 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(3) AND SOSAge < ut.DaysInNYears(4), 'T', 'F');   
		sosFlag4 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(4) AND SOSAge < ut.DaysInNYears(6), 'T', 'F'); 
		sosFlag3 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(6) AND SOSAge < ut.DaysInNYears(8), 'T', 'F');   
		sosFlag2 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(8) AND SOSAge < ut.DaysInNYears(10), 'T', 'F');  
		sosFlag1 := IF(sosFlag9 = 'F' AND SOSAge >= ut.DaysInNYears(10), 'T', 'F');                               	 
		
		sosConcat := sosFlag9 + sosFlag8 + sosFlag7 + sosFlag6 + sosFlag5 + sosFlag4 + sosFlag3 + sosFlag2 + sosFlag1;
		sosFlag0 := IF(STD.Str.Find(sosConcat, 'T', 1) = 0, 'T', 'F');  //Insufficient information reported on business and cannot calculate
		
		sosConcat_Final := sosConcat + sosFlag0;

		SELF.BusSOSAgeRange_Flag := sosConcat_Final;
		SELF.BusSOSAgeRange  := (STRING)(10-STD.Str.Find(sosConcat_Final, 'T', 1)); 


		/*BUSINESS PUBLIC RECORD AGE RANGE*/ 
		HDRAge := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)le.BusnHdrDtFirstSeen, (STRING)le.historyDate); 
		hdrAgeFlag9 := IF(le.srcCount = 0, 'T', 'F');                                                                	 			
		hdrAgeFlag8 := IF(hdrAgeFlag9 = 'F' AND HDRAge < ut.DaysInNYears(1), 'T', 'F');                                			
		hdrAgeFlag7 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(1) AND HDRAge < ut.DaysInNYears(2), 'T', 'F');
		hdrAgeFlag6 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(2) AND HDRAge < ut.DaysInNYears(3), 'T', 'F');
		hdrAgeFlag5 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(3) AND HDRAge < ut.DaysInNYears(4), 'T', 'F');
		hdrAgeFlag4 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(4) AND HDRAge < ut.DaysInNYears(6), 'T', 'F');
		hdrAgeFlag3 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(6) AND HDRAge < ut.DaysInNYears(8), 'T', 'F');
		hdrAgeFlag2 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(8) AND HDRAge < ut.DaysInNYears(10), 'T', 'F');
		hdrAgeFlag1 := IF(hdrAgeFlag9 = 'F' AND HDRAge >= ut.DaysInNYears(10), 'T', 'F');
		
		hdrAgeConcat := hdrAgeFlag9 + hdrAgeFlag8 + hdrAgeFlag7 + hdrAgeFlag6 + hdrAgeFlag5 + hdrAgeFlag4 + hdrAgeFlag3 + hdrAgeFlag2 + hdrAgeFlag1;
		hdrAgeFlag0 := IF(STD.Str.Find(hdrAgeConcat, 'T', 1) = 0, 'T', 'F');   //Insufficient information reported on business and cannot calculate
		
		hdrAgeConcat_Final := hdrAgeConcat + hdrAgeFlag0;
		
		SELF.BusPublicRecordAgeRange_Flag := hdrAgeConcat_Final;
		SELF.BusPublicRecordAgeRange := (STRING)(10-STD.Str.Find(hdrAgeConcat_Final, 'T', 1)); 
		
		
		/*BUSINESS STRUCTURE TYPE*/ 
		structure := IF(le.hdBusnType = DueDiligence.Constants.EMPTY, le.adrBusnType, le.hdBusnType);
		structFlag9 := IF(structure = DueDiligence.Constants.CMPTYP_PROPRIETORSHIP OR structure = DueDiligence.Constants.CMPTYP_ASSUMED_NAME_DBA, 'T', 'F');
		structFlag8 := IF(structure = DueDiligence.Constants.CMPTYP_TRUST, 'T', 'F');
		structFlag7 := IF(structure = DueDiligence.Constants.CMPTYP_LIMITED_LIABILITY_CORP, 'T', 'F');
		structFlag6 := IF(structure = DueDiligence.Constants.CMPTYP_FOREIGN_LLC, 'T', 'F');
		structFlag5 := IF(structure = DueDiligence.Constants.CMPTYP_CORP_NON_PROFIT OR structure = DueDiligence.Constants.CMPTYP_FOREIGN_CORP_NON_PROFIT, 'T', 'F');
		structFlag4 := IF(structure = DueDiligence.Constants.CMPTYP_CORP_BUSINESS OR structure = DueDiligence.Constants.CMPTYP_FOREIGN_CORP, 'T', 'F');
		structFlag3 := IF(structure = DueDiligence.Constants.CMPTYP_PROFESSIONAL_CORP OR structure = DueDiligence.Constants.CMPTYP_PROFESSIONAL_ASSOC, 'T', 'F');
		structFlag2 := IF(structure = DueDiligence.Constants.CMPTYP_LIMITED_PARTNERSHIP OR structure = DueDiligence.Constants.CMPTYP_LIMITED_LIABILITY_PARTNERSHIP, 'T', 'F');
		structFlag1 := IF(structure = DueDiligence.Constants.EMPTY, 'T', 'F');
		
		structConcat := structFlag9 + structFlag8 + structFlag7 + structFlag6 + structFlag5 + structFlag4 + structFlag3 + structFlag2 + structFlag1;
		structFlag0 := IF(STD.Str.Find(structConcat, 'T', 1) = 0, 'T', 'F');  	//Insufficient information reported on business and cannot calculate
		
		structConcat_Final := structConcat + structFlag0;
		
		SELF.BusStructureType_Flag := structConcat_Final;
		SELF.BusStructureType := (STRING)(10-STD.Str.Find(structConcat_Final, 'T', 1)); 
		
				
		/*BUSINESS INDUSTRY RISK*/
		industFlag9 := IF(le.sicNaicRisk.cibNonRetailExists, 'T', 'F');
		industFlag8 := IF(le.sicNaicRisk.cibRetailExists, 'T', 'F');
		industFlag7 := IF(le.sicNaicRisk.msbExists, 'T', 'F');
		industFlag6 := IF(le.sicNaicRisk.nbfiExists, 'T', 'F');
		industFlag5 := IF(le.sicNaicRisk.cagExists, 'T', 'F');
		industFlag4 := IF(le.sicNaicRisk.legAcctTeleFlightTravExists, 'T', 'F');
		industFlag3 := IF(le.sicNaicRisk.autoExists, 'T', 'F');
		industFlag2 := IF(le.sicNaicRisk.otherHighRiskIndustExists, 'T', 'F');
		industFlag1 := IF(le.sicNaicRisk.moderateRiskIndustExists OR le.sicNaicRisk.lowRiskIndustExists, 'T', 'F');
		
		industConcat := industFlag9 + industFlag8 + industFlag7 + industFlag6 + industFlag5 + industFlag4 + industFlag3 + industFlag2 + industFlag1;
		industFlag0 := IF(STD.Str.Find(industConcat, 'T', 1) = 0, 'T', 'F');  //Insufficient information reported on business and cannot calculate
		
		industConcat_Final := industConcat + industFlag0;
		
		SELF.BusIndustry_Flag := industConcat_Final;
		SELF.BusIndustry := (STRING)(10-STD.Str.Find(industConcat_Final, 'T', 1)); 
		

		/*BUSINESS STABILITY RISK*/
		stabFirstSeenDays := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)le.firstReportedAtInputAddress, (STRING)le.historyDate);
		stabFlag9 := IF(le.sosAllDissolveInactiveSuspend, 'T', 'F');
		stabFlag8 := IF(le.sosHasAtleastOneOtherStatusFiling AND le.sosHasAtleastOneDissolvedFiling = FALSE AND 
												le.sosHasAtleastOneInactiveFiling = FALSE AND le.sosHasAtleastOneSuspendedFiling = FALSE AND 
												le.sosHasAtleastOneActiveFiling = FALSE AND le.sosLastReinstateDate = 0, 'T', 'F');
		stabFlag7 := IF(le.notFoundInHeader, 'T', 'F');
		stabFlag6 := IF(le.inputAddressVerified = FALSE OR le.inputAddressProvided = FALSE, 'T', 'F');
		stabFlag5 := IF(le.vacant OR le.cmra, 'T', 'F');
		stabFlag4 := IF(le.feinIsSSN OR le.busIsSOHO, 'T', 'F');
		stabFlag3 := IF(le.firstReportedAtInputAddress > 0 AND stabFirstSeenDays <= 90, 'T', 'F');
		stabFlag2 := IF(le.firstReportedAtInputAddress > 0 AND stabFirstSeenDays BETWEEN 91 AND ut.DaysInNYears(1), 'T', 'F');
		stabFlag1 := IF(le.firstReportedAtInputAddress > 0 AND stabFirstSeenDays > ut.DaysInNYears(1), 'T', 'F');
												
		stabConcat := stabFlag9 + stabFlag8 + stabFlag7 + stabFlag6 + stabFlag5 + stabFlag4 + stabFlag3 + stabFlag2 + stabFlag1;
		stabFlag0 := IF(STD.Str.Find(stabConcat, 'T', 1) = 0, 'T', 'F');  //Insufficient information reported on business and cannot calculate
		
		stabConcat_Final := stabConcat + stabFlag0;
		
		SELF.BusStability_Flag := stabConcat_Final;
		SELF.BusStability := (STRING)(10-STD.Str.Find(stabConcat_Final, 'T', 1)); 
		
		
		/*BUSINESS SHELL SHELF RISK*/
		nonCreditFirstSeen := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)le.busnHdrDtFirstSeenNonCredit, (STRING)le.historyDate);
		differSOSAndNoCredit := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)le.busnHdrDtFirstSeenNonCredit, (STRING)le.SOSIncorporationDate);
		shellShelfFlag9 := IF(le.numOfBusFoundAtAddr > 50 AND ((le.numOfBusIncInStateLooseLaws/le.numOfBusFoundAtAddr) * 100) > 25, 'T', 'F');
		shellShelfFlag8 := IF(le.numOfBusFoundAtAddr > 50 AND ((le.numOfBusNoReportedFein/le.numOfBusFoundAtAddr) * 100) > 75, 'T', 'F');
		shellShelfFlag7 := IF(le.registeredAgentExists AND (le.agentShelfBusn OR le.agentPotentialNIS), 'T', 'F');
		shellShelfFlag6 := IF((le.SOSIncorporationDate > 0 AND SOSAge >= ut.DaysInNYears(2)) AND
														((le.busnHdrDtFirstSeenNonCredit > 0 AND nonCreditFirstSeen < ut.DaysInNYears(2) AND
														le.busnHdrDtFirstSeenNonCredit > 0 AND le.SOSIncorporationDate > 0 AND differSOSAndNoCredit >= ut.DaysInNYears(2)) OR
														le.srcCount = 0), 'T', 'F');
		shellShelfFlag5 := IF(le.registeredAgentExists AND le.atleastOneAgentSameAddrAsBus, 'T', 'F');												
		shellShelfFlag4 := IF(le.privatePostExists OR le.mailDropExists OR le.remailerExists OR le.storageFacilityExists OR le.undeliverableSecRangeExists, 'T', 'F');
		shellShelfFlag3 := IF(le.shellHdrSrcCnt = 0 AND le.creditSrcCnt = 0, 'T', 'F');
		shellShelfFlag2 := IF(le.incorpWithLooseLaws, 'T', 'F');
				
		shellShelfConcat := shellShelfFlag9 + shellShelfFlag8 + shellShelfFlag7 + shellShelfFlag6 + shellShelfFlag5 + shellShelfFlag4 + shellShelfFlag3 + shellShelfFlag2;
		shellShelfFlag1 := IF(STD.Str.Find(shellShelfConcat, 'T', 1) = 0, 'T', 'F');
		shellShelfFlag0 := 'F';  //Insufficient information reported on business and cannot calculate
		
		shellShelfConcat_Final := shellShelfConcat + shellShelfFlag1 + shellShelfFlag0;
		
		SELF.BusShellShelf_Flag := shellShelfConcat_Final;
		SELF.BusShellShelf := (STRING)(10-STD.Str.Find(shellShelfConcat_Final, 'T', 1)); 
		
		
		/*BUSINESS EXECUTIVE OFFICERS RISK*/
		highRiskFound := le.atleastOneActiveLawAcctExec OR le.atleastOneActiveFinRealEstateExec OR le.atleastOneActiveMedicalExec OR 
																			le.atleastOneActiveBlastPilotExec OR le.atleastOneInactiveLawAcctExec OR le.atleastOneInactiveFinRealEstateExec OR 
																			le.atleastOneInactiveMedicalExec OR le.atleastOneInactiveBlastPilotExec;
		execOfficerRisk9 := IF(le.atleastOneActiveLawAcctExec, 'T', 'F');
		execOfficerRisk8 := IF(le.atleastOneActiveFinRealEstateExec, 'T', 'F');
		execOfficerRisk7 := IF(le.atleastOneActiveMedicalExec, 'T', 'F');
		execOfficerRisk6 := IF(le.atleastOneActiveBlastPilotExec, 'T', 'F');
		execOfficerRisk5 := IF(le.atleastOneInactiveLawAcctExec, 'T', 'F');
		execOfficerRisk4 := IF(le.atleastOneInactiveFinRealEstateExec, 'T', 'F');
		execOfficerRisk3 := IF(le.atleastOneInactiveMedicalExec, 'T', 'F');
		execOfficerRisk2 := IF(le.atleastOneInactiveBlastPilotExec, 'T', 'F');
		execOfficerRisk1 := IF(le.numOfBusExecs = 0 OR highRiskFound = FALSE, 'T', 'F');
												
		execOfficerRiskConcat := execOfficerRisk9 + execOfficerRisk8 + execOfficerRisk7 + execOfficerRisk6 + execOfficerRisk5 + execOfficerRisk4 + execOfficerRisk3 + execOfficerRisk2 + execOfficerRisk1;
		execOfficerRiskFlag0 := IF(STD.Str.Find(execOfficerRiskConcat, 'T', 1) = 0, 'T', 'F');  //Insufficient information reported on business and cannot calculate
		
		execOfficerRiskConcat_Final := execOfficerRiskConcat + execOfficerRiskFlag0;
		
		SELF.BusBEOProfLicense_Flag := execOfficerRiskConcat_Final;
		SELF.BusBEOProfLicense := (STRING)(10-STD.Str.Find(execOfficerRiskConcat_Final, 'T', 1));
		
		
		
    /* BUSINESS GEOGRAPHIC RISK  */  
		BusGeoRisk_Flag9 := IF (le.CountyHasHighCrimeIndex   
		                    AND le.CountyBordersForgeinJur
											          	AND (le.HIDTA OR le.HIFCA),      'T','F');                                      /* Set the Index value to 9 */	
												
		BusGeoRisk_Flag8 := IF (le.CityBorderStation 
		                    OR  le.CityFerryCrossing  
											          	OR  le.CityRailStation ,         'T','F');                                      /* Set the Index value to 8 */
												
		BusGeoRisk_Flag7 := IF (le.CountyBordersForgeinJur,  'T','F');                                      /* Set the Index value to 7 */
		
		BusGeoRisk_Flag6 := IF (~le.CountyBordersForgeinJur 
		                    AND  le.CountyBorderOceanForgJur, 'T','F');                                    /* Set the Index value to 6 */
												
		BusGeoRisk_Flag5 := IF (le.CountyHasHighCrimeIndex
		                    AND (le.HIDTA OR le.HIFCA),       'T','F');                                    /* Set the Index value to 5 */
												
		BusGeoRisk_Flag4 := IF (le.CountyHasHighCrimeIndex, 'T','F');                                       /* Set the Index value to 4 */
		                                                                 
		BusGeoRisk_Flag3 := IF (le.HIFCA, 'T','F');                                                         /* Set the Index value to 3 */
		
		BusGeoRisk_Flag2 := IF (le.HIDTA, 'T','F');                                                         /* Set the Index value to 2  */
		
		BusGeoRisk_Flag1 := IF (~le.CountyHasHighCrimeIndex,'T','F');                                       /* Set the Index value to 1 */
	

		BusGeoRisk_Flag_Concat := BusGeoRisk_Flag9 +
																			BusGeoRisk_Flag8 +
																			BusGeoRisk_Flag7 +
																			BusGeoRisk_Flag6 +
																			BusGeoRisk_Flag5 +
																			BusGeoRisk_Flag4 +
																			BusGeoRisk_Flag3 +
																			BusGeoRisk_Flag2 +
																			BusGeoRisk_Flag1;
	


		BusGeoRisk_Flag0        := IF(STD.Str.Find(BusGeoRisk_Flag_Concat, 'T', 1) = 0, 'T', 'F');     /* Insufficient information reported on the business */
		BusGeoRisk_Flag_final   := BusGeoRisk_Flag_Concat + BusGeoRisk_Flag0; 
		
		self.BusGeographic_Flag   :=  BusGeoRisk_Flag_final;                                             /* This a string of T or F based on how the data used to calculate the KRI  */
		self.BusGeographic         := (STRING)(10-STD.Str.Find(BusGeoRisk_Flag_final, 'T', 1));           /* Set the index to the position of the first 'T'.  */
			
			
		
		
		 /* BUSINESS MATCH LEVEL  */  																																																	 
		 BusMatchLevel_Flag9 := If (le.weight < 80, 'T','F');                            /* Index value of 9 was set */
		 BusMatchLevel_Flag8 := IF (le.weight BETWEEN 80 AND 84, 'T','F');               /* Index value of 8 was set */
		 BusMatchLevel_Flag7 := IF (le.weight BETWEEN 85 AND 89, 'T','F');               /* Index value of 7 was set */
		 BusMatchLevel_Flag6 := IF (le.weight BETWEEN 90 AND 91, 'T','F');                /* Index value of 6 was set */
		 BusMatchLevel_Flag5 := IF (le.weight BETWEEN 92 AND 93, 'T','F');                /* Index value of 5 was set */
		 BusMatchLevel_Flag4 := IF (le.weight BETWEEN 94 AND 95, 'T','F');                /* Index value of 4 was set */
		 BusMatchLevel_Flag3 := IF (le.weight BETWEEN 96 AND 97, 'T','F');                /* Index value of 3 was set */
		 BusMatchLevel_Flag2 := IF (le.weight BETWEEN 98 AND 99, 'T','F');                /* Index value of 2 was set */
		 BusMatchLevel_Flag1 := IF (le.weight > 99, 'T','F');                             /* Index value of 1 was set */
		 
		 BusMatchLevel_Flag_Concat := BusMatchLevel_Flag9 +
																			BusMatchLevel_Flag8 +
																			BusMatchLevel_Flag7 +
																			BusMatchLevel_Flag6 +
																			BusMatchLevel_Flag5 +
																			BusMatchLevel_Flag4 +
																			BusMatchLevel_Flag3 +
																			BusMatchLevel_Flag2 +
																			BusMatchLevel_Flag1;
		 
		 BusMatchLevel_Flag0       := IF(STD.Str.Find(BusMatchLevel_Flag_Concat, 'T', 1) = 0, 'T', 'F');     /* Insufficient information reported on the business */
		 BusMatchLevel_Flag_final  := BusMatchLevel_Flag_Concat + BusMatchLevel_Flag0; 
		
		 // self.BusMatchLevel_Flag  :=  BusMatchLevel_Flag_final;                                            /* This a string of T or F based on how the data used to calculate the KRI  */
		 // self.BusMatchLevel       := (STRING)(10 - STD.Str.Find(BusMatchLevel_Flag_final, 'T', 1));        /* Set the index to the position of the first 'T'.  */  
		
		
		
		 /* BUSINESS LEGAL EVENTS - CRIMINAL STATE */  																																																	 
		 BusStateLegalEvent_Flag9 := If (le.BEOevidenceOfCurrentIncarcerationOrParole, 'T','F');           /* Index value of 9 was set */
		 BusStateLegalEvent_Flag8 := IF (le.BEOevidenceOfFelonyConvictionInLastNYR, 'T','F');           /* Index value of 8 was set */
		 BusStateLegalEvent_Flag7 := IF (le.BEOevidenceOfFelonyConvictionOlderNYR,  'T','F');           /* Index value of 7 was set */
		 BusStateLegalEvent_Flag6 := IF (le.BEOevidenceOfPreviousIncarceration,     'T','F');           /* Index value of 6 was set */
		 BusStateLegalEvent_Flag5 := IF (le.BEOevidenceOfUncatagorizedConvictionInLastNYR, 'T','F');    /* Index value of 5 was set */
		 BusStateLegalEvent_Flag4 := IF (le.BEOevidenceOfMisdeameanorConvictionInLastNYR,  'T','F');    /* Index value of 4 was set */
		 BusStateLegalEvent_Flag3 := IF (le.BEOevidenceOfUncatagorizedConvictionOlderNYR,  'T','F');    /* Index value of 3 was set */
		 BusStateLegalEvent_Flag2 := IF (le.BEOevidenceOfMisdeameanorConvictionOlderNYR,   'T','F');    /* Index value of 2 was set */
		 BusStateLegalEvent_Flag1 := IF (le.BEONoEvidenceOfStateCriminal OR le.execCount = 0,  'T','F');    /* Index value of 1 was set */
		 
		 BusStateLegalEvent_Flag_Concat :=  BusStateLegalEvent_Flag9 +
																			BusStateLegalEvent_Flag8 +
																			BusStateLegalEvent_Flag7 +
																			BusStateLegalEvent_Flag6 +
																			BusStateLegalEvent_Flag5 +
																			BusStateLegalEvent_Flag4 +
																			BusStateLegalEvent_Flag3 +
																			BusStateLegalEvent_Flag2 +
																			BusStateLegalEvent_Flag1;
		 
		 BusStateLegalEvent_Flag0    := IF(STD.Str.Find(BusStateLegalEvent_Flag_Concat, 'T', 1) = 0, 'T', 'F');     /* Insufficient information reported on the business */
		 BusStateLegalEvent_Flag_final  := BusStateLegalEvent_Flag_Concat + BusStateLegalEvent_Flag0; 
		
		 self.BusStateLegalEvent_Flag  :=  BusStateLegalEvent_Flag_final;                                            /* This a string of T or F based on how the data used to calculate the KRI  */
		 self.BusStateLegalEvent        := (STRING)(10 - STD.Str.Find(BusStateLegalEvent_Flag_final, 'T', 1));        /* Set the index to the position of the first 'T'.  */  
		
	
		 /* BUSINESS LEGAL EVENTS - CIVIL (LIENS, JUDGEMENTS and EVICTIONS) */ 
		 totalBusCivilCount := le.Business.liensUnreleasedCntInThePastNYR + le.Business.evictionsCntInThePastNYR;
		 BusCivilLegalEvent_Flag9 := IF(totalBusCivilCount >= 10, 'T','F');    
		 BusCivilLegalEvent_Flag8 := IF(totalBusCivilCount BETWEEN 5 AND 9, 'T','F');   											
		 BusCivilLegalEvent_Flag7 := IF(totalBusCivilCount BETWEEN 3 AND 4, 'T','F');    										
		 BusCivilLegalEvent_Flag6 := IF(totalBusCivilCount BETWEEN 1 AND 2, 'T','F'); 
			
		 totalBusCivilCountOlder := le.Business.liensUnreleasedCntOVNYR + le.Business.evictionsCntOVNYR;  													
		 BusCivilLegalEvent_Flag5 := IF(totalBusCivilCountOlder >= 10, 'T','F');
		 BusCivilLegalEvent_Flag4 := IF(totalBusCivilCountOlder BETWEEN 5 AND 9, 'T','F'); 						
		 BusCivilLegalEvent_Flag3 := IF(totalBusCivilCountOlder BETWEEN 3 AND 4, 'T','F'); 										
		 BusCivilLegalEvent_Flag2 := IF(totalBusCivilCountOlder BETWEEN 1 AND 2, 'T','F'); 
		 
		 BusCivilLegalEvent_Flag1 := IF(BusCivilLegalEvent_Flag9 = 'F' 
																AND BusCivilLegalEvent_Flag8 = 'F' 
																AND BusCivilLegalEvent_Flag7 = 'F' 
																AND BusCivilLegalEvent_Flag6 = 'F'
																AND BusCivilLegalEvent_Flag5 = 'F' 
																AND BusCivilLegalEvent_Flag4 = 'F' 
																AND BusCivilLegalEvent_Flag3 = 'F'
																AND BusCivilLegalEvent_Flag2 = 'F', 'T','F');   /* Index value of 1 was set */
		 
		 BusCivilLegalEvent_Flag_Concat := BusCivilLegalEvent_Flag9 +
																	BusCivilLegalEvent_Flag8 +
																	BusCivilLegalEvent_Flag7 +
																	BusCivilLegalEvent_Flag6 +
																	BusCivilLegalEvent_Flag5 +
																	BusCivilLegalEvent_Flag4 +
																	BusCivilLegalEvent_Flag3 +
																	BusCivilLegalEvent_Flag2 +
																	BusCivilLegalEvent_Flag1;

		 BusCivilLegalEvent_Flag0 := IF(STD.Str.Find(BusCivilLegalEvent_Flag_Concat, 'T', 1) = 0, 'T', 'F');       /* Insufficient information reported on the business */
		 BusCivilLegalEvent_Flag_final := BusCivilLegalEvent_Flag_Concat + BusCivilLegalEvent_Flag0; 
		
		 self.BusCivilLegalEvent_Flag :=  BusCivilLegalEvent_Flag_final;                                            /* This a string of T or F based on how the data used to calculate the KRI  */
		 self.BusCivilLegalEvent := (STRING)(10 - STD.Str.Find(BusCivilLegalEvent_Flag_final, 'T', 1));        /* Set the index to the position of the first 'T'.  */  																																																	 
		 
		 
		/*BUSINESS LEGAL EVENT TYPE*/
		legalEventTypeFlag9 := IF(le.atleastOneBEOInCategory9, 'T', 'F');
		legalEventTypeFlag8 := IF(le.atleastOneBEOInCategory8, 'T', 'F');
		legalEventTypeFlag7 := IF(le.atleastOneBEOInCategory7, 'T', 'F');
		legalEventTypeFlag6 := IF(le.atleastOneBEOInCategory6, 'T', 'F');
		legalEventTypeFlag5 := IF(le.atleastOneBEOInCategory5, 'T', 'F');
		legalEventTypeFlag4 := IF(le.atleastOneBEOInCategory4, 'T', 'F');
		legalEventTypeFlag3 := IF(le.atleastOneBEOInCategory3, 'T', 'F');
		legalEventTypeFlag2 := IF(le.atleastOneBEOInCategory2, 'T', 'F');
		legalEventTypeFlag1 := IF(le.BEOsHaveNoConvictionsOrCategoryHits OR le.execCount = 0, 'T', 'F');
												
		legalEventTypeConcat := legalEventTypeFlag9 + legalEventTypeFlag8 + legalEventTypeFlag7 + legalEventTypeFlag6 + legalEventTypeFlag5 + legalEventTypeFlag4 + legalEventTypeFlag3 + legalEventTypeFlag2 + legalEventTypeFlag1;
		legalEventTypeFlag0 := IF(STD.Str.Find(legalEventTypeConcat, 'T', 1) = 0, 'T', 'F');  //Insufficient information reported on business and cannot calculate
		
		legalEventTypeConcat_Final := legalEventTypeConcat + legalEventTypeFlag0;
		
		SELF.BusOffenseType_Flag := legalEventTypeConcat_Final;
		SELF.BusOffenseType := (STRING)(10-STD.Str.Find(legalEventTypeConcat_Final, 'T', 1)); 
		
		
		/*BUSINESS EXECUTIVE OFFICER US RESIDENCY*/
		beoResidencyFlag9 := IF(le.atleastOneBEOInvalidSSN , 'T', 'F');
		beoResidencyFlag8 := IF(le.atleastOneBEOAssocITINOrImmigrantSSN , 'T', 'F');
		beoResidencyFlag7 := IF(le.atleastOneBEODOBPriorToParentSSN , 'T', 'F');
		beoResidencyFlag6 := IF(le.atleastOneBEOParentWithITINOrImmigrantSSN , 'T', 'F');
		beoResidencyFlag5 := IF(le.atleastOneBEONoParentsOrNeitherHaveSSNITIN , 'T', 'F');
		beoResidencyFlag4 := IF(le.atleastOneBEOPublicRecordsLess3YrsWithNoVote , 'T', 'F');
		beoResidencyFlag3 := IF(le.atleastOneBEOPublicRecordsBetween3And10YrsWithNoVote , 'T', 'F');
		beoResidencyFlag2 := IF(le.atleastOneBEOPublicRecordsMoreThan10YrsWithNoVote , 'T', 'F');
		beoResidencyFlag1 := IF(le.execCount = 0 OR le.atleastOneBEOOrParentRegisteredVoter , 'T', 'F');
												
		beoResidencyConcat := beoResidencyFlag9 + beoResidencyFlag8 + beoResidencyFlag7 + beoResidencyFlag6 + beoResidencyFlag5 + beoResidencyFlag4 + beoResidencyFlag3 + beoResidencyFlag2 + beoResidencyFlag1;
		beoResidencyFlag0 := IF(STD.Str.Find(beoResidencyConcat, 'T', 1) = 0, 'T', 'F');  //Insufficient information reported on business and cannot calculate
		
		beoResidencyConcat_Final := beoResidencyConcat + beoResidencyFlag0;
		
		SELF.BusBEOUSResidency_Flag := beoResidencyConcat_Final;
		SELF.BusBEOUSResidency := (STRING)(10-STD.Str.Find(beoResidencyConcat_Final, 'T', 1));

			
		SELF := le;
	END;


	KRIndexesBusn := project(sort(withBIPs, seq), BusnKRIs(left));
	kriIndexesUnknownBus := PROJECT(noBIPs, TRANSFORM(DueDiligence.Layouts.Busn_Internal,				
																										SELF.BusAssetOwnProperty := INVALID_BUSINESS_SCORE;
																										SELF.BusAssetOwnProperty_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusAssetOwnAircraft := INVALID_BUSINESS_SCORE;
																										SELF.BusAssetOwnAircraft_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusAssetOwnWatercraft := INVALID_BUSINESS_SCORE;
																										SELF.BusAssetOwnWatercraft_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusAssetOwnVehicle := INVALID_BUSINESS_SCORE;
																										SELF.BusAssetOwnVehicle_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusAccessToFundsProperty := INVALID_BUSINESS_SCORE;
																										SELF.BusAccessToFundsProperty_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusGeographic := INVALID_BUSINESS_SCORE;
																										SELF.BusGeographic_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusValidity := INVALID_BUSINESS_SCORE;
																										SELF.BusValidity_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusStability := INVALID_BUSINESS_SCORE;
																										SELF.BusStability_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusIndustry := INVALID_BUSINESS_SCORE;
																										SELF.BusIndustry_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusStructureType := INVALID_BUSINESS_SCORE;
																										SELF.BusStructureType_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusSOSAgeRange := INVALID_BUSINESS_SCORE;
																										SELF.BusSOSAgeRange_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusPublicRecordAgeRange := INVALID_BUSINESS_SCORE;
																										SELF.BusPublicRecordAgeRange_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusShellShelf := INVALID_BUSINESS_SCORE;
																										SELF.BusShellShelf_Flag := INVALID_BUSINESS_FLAGS;
																										// SELF.BusMatchLevel := INVALID_BUSINESS_SCORE;
																										// SELF.BusMatchLevel_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusStateLegalEvent := INVALID_BUSINESS_SCORE;
																										SELF.BusStateLegalEvent_Flag := INVALID_BUSINESS_FLAGS;
																										// SELF.BusFederalLegalEvent := INVALID_BUSINESS_FLAGS;
																										// SELF.BusFederalLegalEvent_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusCivilLegalEvent := INVALID_BUSINESS_SCORE;
																										SELF.BusCivilLegalEvent_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusOffenseType := INVALID_BUSINESS_SCORE;
																										SELF.BusOffenseType_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusBEOProfLicense := INVALID_BUSINESS_SCORE;
																										SELF.BusBEOProfLicense_Flag := INVALID_BUSINESS_FLAGS;
																										SELF.BusBEOUSResidency := INVALID_BUSINESS_SCORE;
																										SELF.BusBEOUSResidency_Flag := INVALID_BUSINESS_FLAGS;
																										SELF := LEFT;));



	RETURN KRIndexesBusn + kriIndexesUnknownBus;

END;

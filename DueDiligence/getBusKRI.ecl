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
		
		//BUSINESS ASSETS OWNED PROPERTY  																																																	 
		BusAssetOwnProperty_Flag9 := IF(le.CurrPropOwnedCount >= 15, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);            
		BusAssetOwnProperty_Flag8 := IF(le.CurrPropOwnedCount BETWEEN 10 AND 14, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusAssetOwnProperty_Flag7 := IF(le.CurrPropOwnedCount BETWEEN 6 AND 9, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusAssetOwnProperty_Flag6 := IF(le.CurrPropOwnedCount = 5, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);              
		BusAssetOwnProperty_Flag5 := IF(le.CurrPropOwnedCount = 4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);              
		BusAssetOwnProperty_Flag4 := IF(le.CurrPropOwnedCount = 3, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);              
		BusAssetOwnProperty_Flag3 := IF(le.CurrPropOwnedCount = 2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);              
		BusAssetOwnProperty_Flag2 := IF(le.CurrPropOwnedCount = 1, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);              
		BusAssetOwnProperty_Flag1 := IF(le.CurrPropOwnedCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);              
		
		BusAssetOwn_property_Flag_final := DueDiligence.Common.calcFinalFlagField(BusAssetOwnProperty_Flag9,
                                                                              BusAssetOwnProperty_Flag8,
                                                                              BusAssetOwnProperty_Flag7,
                                                                              BusAssetOwnProperty_Flag6,
                                                                              BusAssetOwnProperty_Flag5,
                                                                              BusAssetOwnProperty_Flag4,
                                                                              BusAssetOwnProperty_Flag3,
                                                                              BusAssetOwnProperty_Flag2,
                                                                              BusAssetOwnProperty_Flag1); 
		
		SELF.BusAssetOwnProperty_Flag := BusAssetOwn_property_Flag_final;
		SELF.BusAssetOwnProperty := (STRING)(10 - STD.Str.Find(BusAssetOwn_property_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));
	 
		
		
		//BUSINESS ASSET OWNED AIRCRAFT																																											 
		BusAssetOwnAircraft_Flag9 := IF(le.AircraftCount >= 8, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusAssetOwnAircraft_Flag8 := IF(le.AircraftCount = 7, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);	
		BusAssetOwnAircraft_Flag7 := IF(le.AircraftCount = 6, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusAssetOwnAircraft_Flag6 := IF(le.AircraftCount = 5, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusAssetOwnAircraft_Flag5 := IF(le.AircraftCount = 4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusAssetOwnAircraft_Flag4 := IF(le.AircraftCount = 3, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusAssetOwnAircraft_Flag3 := IF(le.AircraftCount = 2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusAssetOwnAircraft_Flag2 := IF(le.AircraftCount = 1, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusAssetOwnAircraft_Flag1 := IF(le.AircraftCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		
		BusAssetOwnAircraft_Flag_final := DueDiligence.Common.calcFinalFlagField(BusAssetOwnAircraft_Flag9,
                                                                              BusAssetOwnAircraft_Flag8,
                                                                              BusAssetOwnAircraft_Flag7,
                                                                              BusAssetOwnAircraft_Flag6,
                                                                              BusAssetOwnAircraft_Flag5,
                                                                              BusAssetOwnAircraft_Flag4,
                                                                              BusAssetOwnAircraft_Flag3,
                                                                              BusAssetOwnAircraft_Flag2,
                                                                              BusAssetOwnAircraft_Flag1); 
	
	  SELF.BusAssetOwnAircraft_Flag := BusAssetOwnAircraft_Flag_final;
	  SELF.BusAssetOwnAircraft := (STRING)(10-STD.Str.Find(BusAssetOwnAircraft_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));
																						 
																																																					 
		//BUSINESS ASSET OWNED WATERCRAFT 
		BusAssetOwnWatercraft_Flag9 := IF(le.WatercraftCount > 0 AND le.Watercraftlength >= 200, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);             
		BusAssetOwnWatercraft_Flag8 := IF(le.WatercraftCount > 0 AND le.Watercraftlength BETWEEN 100 AND 199, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusAssetOwnWatercraft_Flag7 := IF(le.WatercraftCount > 0 AND le.Watercraftlength BETWEEN 50 AND 99, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
		BusAssetOwnWatercraft_Flag6 := IF(le.WatercraftCount >= 6, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                            
		BusAssetOwnWatercraft_Flag5 := IF(le.WatercraftCount BETWEEN 4 AND 5, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                  
		BusAssetOwnWatercraft_Flag4 := IF(le.WatercraftCount = 3, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                             
		BusAssetOwnWatercraft_Flag3 := IF(le.WatercraftCount = 2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                             
		BusAssetOwnWatercraft_Flag2 := IF(le.WatercraftCount = 1, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                             
		BusAssetOwnWatercraft_Flag1 := IF(le.WatercraftCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                             
	
		BusAssetOwnWatercraft_Flag_final := DueDiligence.Common.calcFinalFlagField(BusAssetOwnWatercraft_Flag9,
                                                                                BusAssetOwnWatercraft_Flag8,
                                                                                BusAssetOwnWatercraft_Flag7,
                                                                                BusAssetOwnWatercraft_Flag6,
                                                                                BusAssetOwnWatercraft_Flag5,
                                                                                BusAssetOwnWatercraft_Flag4,
                                                                                BusAssetOwnWatercraft_Flag3,
                                                                                BusAssetOwnWatercraft_Flag2,
                                                                                BusAssetOwnWatercraft_Flag1); 
		
		SELF.BusAssetOwnWatercraft_Flag := BusAssetOwnWatercraft_Flag_final;
		SELF.BusAssetOwnWatercraft := (STRING)(10-STD.Str.Find(BusAssetOwnWatercraft_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));
			
			
			
	  //ASSETS OWNED VEHICLE
		BusAssetOwnVehicle_Flag9 := IF(le.VehicleCount > 0 AND le.VehicleBaseValue >= 200000, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                
		BusAssetOwnVehicle_Flag8 := IF(le.VehicleCount > 0 AND le.VehicleBaseValue BETWEEN 150000 AND 199999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusAssetOwnVehicle_Flag7 := IF(le.VehicleCount > 0 AND le.VehicleBaseValue BETWEEN 100000 AND 149999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusAssetOwnVehicle_Flag6 := IF(le.VehicleCount >= 150, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                               
		BusAssetOwnVehicle_Flag5 := IF(le.VehicleCount BETWEEN 50 AND 149, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                   
		BusAssetOwnVehicle_Flag4 := IF(le.VehicleCount BETWEEN 25 AND 49, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                    
		BusAssetOwnVehicle_Flag3 := IF(le.VehicleCount BETWEEN 10 AND 24, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                    
		BusAssetOwnVehicle_Flag2 := IF(le.VehicleCount BETWEEN 1 AND 9, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                    
		BusAssetOwnVehicle_Flag1 := IF(le.VehicleCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                                 
	
		BusAssetOwnVehicle_Flag_final := DueDiligence.Common.calcFinalFlagField(BusAssetOwnVehicle_Flag9,
                                                                            BusAssetOwnVehicle_Flag8,
                                                                            BusAssetOwnVehicle_Flag7,
                                                                            BusAssetOwnVehicle_Flag6,
                                                                            BusAssetOwnVehicle_Flag5,
                                                                            BusAssetOwnVehicle_Flag4,
                                                                            BusAssetOwnVehicle_Flag3,
                                                                            BusAssetOwnVehicle_Flag2,
                                                                            BusAssetOwnVehicle_Flag1); 
		
		SELF.BusAssetOwnVehicle_Flag := BusAssetOwnVehicle_Flag_final;
		SELF.BusAssetOwnVehicle := (STRING)(10-STD.Str.Find(BusAssetOwnVehicle_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));
																						
																						
		//ACCESS TO FUNDS PROPERTY 																																																	 
		BusAccessToFundsProperty_Flag9 := IF(le.CurrPropOwnedCount > 0 AND le.PropTaxValue >= 15000000, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);               
		BusAccessToFundsProperty_Flag8 := IF(le.CurrPropOwnedCount > 0 AND le.PropTaxValue BETWEEN 5000000 AND 14999999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusAccessToFundsProperty_Flag7 := IF(le.CurrPropOwnedCount > 0 AND le.PropTaxValue BETWEEN 1000000 AND 4999999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
		BusAccessToFundsProperty_Flag6 := IF(le.CurrPropOwnedCount > 0 AND le.PropTaxValue BETWEEN 500000 AND 999999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);   
		BusAccessToFundsProperty_Flag5 := IF(le.CurrPropOwnedCount > 0 AND le.PropTaxValue BETWEEN 200000 AND 499999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);   
		BusAccessToFundsProperty_Flag4 := IF(le.CurrPropOwnedCount > 0 AND le.PropTaxValue BETWEEN 50000 AND 199999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);    
		BusAccessToFundsProperty_Flag3 := IF(le.CurrPropOwnedCount > 0 AND le.PropTaxValue <= 49999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);    
		BusAccessToFundsProperty_Flag2 := IF(le.CurrPropOwnedCount = 0 AND le.CountSoldProp > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                        
		BusAccessToFundsProperty_Flag1 := IF(le.PropTaxValue = 0 AND le.CurrPropOwnedCount = 0 AND le.CountSoldProp = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		
		BusAccessToFundsProperty_Flag_final := DueDiligence.Common.calcFinalFlagField(BusAccessToFundsProperty_Flag9,
                                                                                  BusAccessToFundsProperty_Flag8,
                                                                                  BusAccessToFundsProperty_Flag7,
                                                                                  BusAccessToFundsProperty_Flag6,
                                                                                  BusAccessToFundsProperty_Flag5,
                                                                                  BusAccessToFundsProperty_Flag4,
                                                                                  BusAccessToFundsProperty_Flag3,
                                                                                  BusAccessToFundsProperty_Flag2,
                                                                                  BusAccessToFundsProperty_Flag1); 
		
    SELF.BusAccessToFundsProperty_Flag := BusAccessToFundsProperty_Flag_final;
		SELF.BusAccessToFundsProperty := (STRING)(10 - STD.Str.Find(BusAccessToFundsProperty_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));
	 

		//BUSINESS VALIDITY RISK
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
		
		bvrFlag9 := IF(bvrZeroOperatingLocation AND bvrZeroOptions, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		bvrFlag8 := IF(bvrOneOperatingLocation AND bvrZeroOptions, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		bvrFlag7 := IF(bvrMultipleOperatingLocations AND bvrZeroOptions, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		bvrFlag6 := IF(bvrZeroOperatingLocation AND bvrOneOption, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		bvrFlag5 := IF(bvrOneOperatingLocation AND bvrOneOption, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		bvrFlag4 := IF(bvrMultipleOperatingLocations AND bvrOneOption, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		bvrFlag3 := IF(bvrZeroOperatingLocation AND bvrTwoPlusOptions, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		bvrFlag2 := IF(bvrOneOperatingLocation AND bvrTwoPlusOptions, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		bvrFlag1 := IF(bvrMultipleOperatingLocations AND bvrTwoPlusOptions, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);

		bvrConcat_final := DueDiligence.Common.calcFinalFlagField(bvrFlag9,
                                                              bvrFlag8,
                                                              bvrFlag7,
                                                              bvrFlag6,
                                                              bvrFlag5,
                                                              bvrFlag4,
                                                              bvrFlag3,
                                                              bvrFlag2,
                                                              bvrFlag1);

		SELF.BusValidity_Flag := bvrConcat_final;
		SELF.BusValidity  := (STRING)(10-STD.Str.Find(bvrConcat_final, DueDiligence.Constants.T_INDICATOR, 1));
		
																		
		//BUSINESS SOS AGE RANGE
		SOSAge := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)le.SOSIncorporationDate, (STRING)le.historyDate);   
    
		sosFlag9 := IF(le.NoSOSFilingEver AND (UNSIGNED)le.SOSIncorporationDate = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                                            		 
		sosFlag8 := IF(sosFlag9 = DueDiligence.Constants.F_INDICATOR AND SOSAge < ut.DaysInNYears(1), 'T', 'F');                                		 
		sosFlag7 := IF(sosFlag9 = DueDiligence.Constants.F_INDICATOR AND SOSAge >= ut.DaysInNYears(1) AND SOSAge < ut.DaysInNYears(2), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);  
		sosFlag6 := IF(sosFlag9 = DueDiligence.Constants.F_INDICATOR AND SOSAge >= ut.DaysInNYears(2) AND SOSAge < ut.DaysInNYears(3), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);   
		sosFlag5 := IF(sosFlag9 = DueDiligence.Constants.F_INDICATOR AND SOSAge >= ut.DaysInNYears(3) AND SOSAge < ut.DaysInNYears(4), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);   
		sosFlag4 := IF(sosFlag9 = DueDiligence.Constants.F_INDICATOR AND SOSAge >= ut.DaysInNYears(4) AND SOSAge < ut.DaysInNYears(6), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
		sosFlag3 := IF(sosFlag9 = DueDiligence.Constants.F_INDICATOR AND SOSAge >= ut.DaysInNYears(6) AND SOSAge < ut.DaysInNYears(8), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);   
		sosFlag2 := IF(sosFlag9 = DueDiligence.Constants.F_INDICATOR AND SOSAge >= ut.DaysInNYears(8) AND SOSAge < ut.DaysInNYears(10), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);  
		sosFlag1 := IF(sosFlag9 = DueDiligence.Constants.F_INDICATOR AND SOSAge >= ut.DaysInNYears(10), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                               	 
		
		sosConcat_Final := DueDiligence.Common.calcFinalFlagField(sosFlag9,
                                                              sosFlag8,
                                                              sosFlag7,
                                                              sosFlag6,
                                                              sosFlag5,
                                                              sosFlag4,
                                                              sosFlag3,
                                                              sosFlag2,
                                                              sosFlag1);

		SELF.BusSOSAgeRange_Flag := sosConcat_Final;
		SELF.BusSOSAgeRange  := (STRING)(10-STD.Str.Find(sosConcat_Final, DueDiligence.Constants.T_INDICATOR, 1)); 


		//BUSINESS PUBLIC RECORD AGE RANGE
		HDRAge := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)le.BusnHdrDtFirstSeen, (STRING)le.historyDate); 
    
		hdrAgeFlag9 := IF(le.srcCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                                                	 			
		hdrAgeFlag8 := IF(hdrAgeFlag9 = DueDiligence.Constants.F_INDICATOR AND HDRAge < ut.DaysInNYears(1), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                			
		hdrAgeFlag7 := IF(hdrAgeFlag9 = DueDiligence.Constants.F_INDICATOR AND HDRAge >= ut.DaysInNYears(1) AND HDRAge < ut.DaysInNYears(2), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		hdrAgeFlag6 := IF(hdrAgeFlag9 = DueDiligence.Constants.F_INDICATOR AND HDRAge >= ut.DaysInNYears(2) AND HDRAge < ut.DaysInNYears(3), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		hdrAgeFlag5 := IF(hdrAgeFlag9 = DueDiligence.Constants.F_INDICATOR AND HDRAge >= ut.DaysInNYears(3) AND HDRAge < ut.DaysInNYears(4), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		hdrAgeFlag4 := IF(hdrAgeFlag9 = DueDiligence.Constants.F_INDICATOR AND HDRAge >= ut.DaysInNYears(4) AND HDRAge < ut.DaysInNYears(6), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		hdrAgeFlag3 := IF(hdrAgeFlag9 = DueDiligence.Constants.F_INDICATOR AND HDRAge >= ut.DaysInNYears(6) AND HDRAge < ut.DaysInNYears(8), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		hdrAgeFlag2 := IF(hdrAgeFlag9 = DueDiligence.Constants.F_INDICATOR AND HDRAge >= ut.DaysInNYears(8) AND HDRAge < ut.DaysInNYears(10), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		hdrAgeFlag1 := IF(hdrAgeFlag9 = DueDiligence.Constants.F_INDICATOR AND HDRAge >= ut.DaysInNYears(10), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		
		hdrAgeConcat_Final := DueDiligence.Common.calcFinalFlagField(hdrAgeFlag9,
                                                                  hdrAgeFlag8,
                                                                  hdrAgeFlag7,
                                                                  hdrAgeFlag6,
                                                                  hdrAgeFlag5,
                                                                  hdrAgeFlag4,
                                                                  hdrAgeFlag3,
                                                                  hdrAgeFlag2,
                                                                  hdrAgeFlag1);
		
		SELF.BusPublicRecordAgeRange_Flag := hdrAgeConcat_Final;
		SELF.BusPublicRecordAgeRange := (STRING)(10-STD.Str.Find(hdrAgeConcat_Final, DueDiligence.Constants.T_INDICATOR, 1)); 
		
		
		//BUSINESS STRUCTURE TYPE
		structure := IF(le.hdBusnType = DueDiligence.Constants.EMPTY, le.adrBusnType, le.hdBusnType);
    
		structFlag9 := IF(structure = DueDiligence.Constants.CMPTYP_PROPRIETORSHIP OR structure = DueDiligence.Constants.CMPTYP_ASSUMED_NAME_DBA, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		structFlag8 := IF(structure = DueDiligence.Constants.CMPTYP_TRUST, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		structFlag7 := IF(structure = DueDiligence.Constants.CMPTYP_LIMITED_LIABILITY_CORP, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		structFlag6 := IF(structure = DueDiligence.Constants.CMPTYP_FOREIGN_LLC, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		structFlag5 := IF(structure = DueDiligence.Constants.CMPTYP_CORP_NON_PROFIT OR structure = DueDiligence.Constants.CMPTYP_FOREIGN_CORP_NON_PROFIT, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		structFlag4 := IF(structure = DueDiligence.Constants.CMPTYP_CORP_BUSINESS OR structure = DueDiligence.Constants.CMPTYP_FOREIGN_CORP, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		structFlag3 := IF(structure = DueDiligence.Constants.CMPTYP_PROFESSIONAL_CORP OR structure = DueDiligence.Constants.CMPTYP_PROFESSIONAL_ASSOC, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		structFlag2 := IF(structure = DueDiligence.Constants.CMPTYP_LIMITED_PARTNERSHIP OR structure = DueDiligence.Constants.CMPTYP_LIMITED_LIABILITY_PARTNERSHIP, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		structFlag1 := IF(structure = DueDiligence.Constants.EMPTY, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		
		structConcat_Final := DueDiligence.Common.calcFinalFlagField(structFlag9,
                                                                  structFlag8,
                                                                  structFlag7,
                                                                  structFlag6,
                                                                  structFlag5,
                                                                  structFlag4,
                                                                  structFlag3,
                                                                  structFlag2,
                                                                  structFlag1);
		
		SELF.BusStructureType_Flag := structConcat_Final;
		SELF.BusStructureType := (STRING)(10-STD.Str.Find(structConcat_Final, DueDiligence.Constants.T_INDICATOR, 1)); 
		
				
		//BUSINESS INDUSTRY RISK
		industFlag9 := IF(le.sicNaicRisk.cibNonRetailExists, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		industFlag8 := IF(le.sicNaicRisk.cibRetailExists, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		industFlag7 := IF(le.sicNaicRisk.msbExists, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		industFlag6 := IF(le.sicNaicRisk.nbfiExists, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		industFlag5 := IF(le.sicNaicRisk.cagExists, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		industFlag4 := IF(le.sicNaicRisk.legAcctTeleFlightTravExists, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		industFlag3 := IF(le.sicNaicRisk.autoExists, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		industFlag2 := IF(le.sicNaicRisk.otherHighRiskIndustExists, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		industFlag1 := IF(le.sicNaicRisk.moderateRiskIndustExists OR le.sicNaicRisk.lowRiskIndustExists, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		
		industConcat_Final := DueDiligence.Common.calcFinalFlagField(industFlag9,
                                                                  industFlag8,
                                                                  industFlag7,
                                                                  industFlag6,
                                                                  industFlag5,
                                                                  industFlag4,
                                                                  industFlag3,
                                                                  industFlag2,
                                                                  industFlag1);
		
		SELF.BusIndustry_Flag := industConcat_Final;
		SELF.BusIndustry := (STRING)(10-STD.Str.Find(industConcat_Final, DueDiligence.Constants.T_INDICATOR, 1)); 
		

		//BUSINESS STABILITY RISK
		stabFirstSeenDays := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)le.firstReportedAtInputAddress, (STRING)le.historyDate);
    
		stabFlag9 := IF(le.sosAllDissolveInactiveSuspend, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		stabFlag8 := IF(le.sosHasAtleastOneOtherStatusFiling AND le.sosHasAtleastOneDissolvedFiling = FALSE AND 
												le.sosHasAtleastOneInactiveFiling = FALSE AND le.sosHasAtleastOneSuspendedFiling = FALSE AND 
												le.sosHasAtleastOneActiveFiling = FALSE AND le.sosLastReinstateDate = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		stabFlag7 := IF(le.notFoundInHeader, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		stabFlag6 := IF(le.inputAddressVerified = FALSE OR le.inputAddressProvided = FALSE, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		stabFlag5 := IF(le.vacant OR le.cmra, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		stabFlag4 := IF(le.feinIsSSN OR le.busIsSOHO, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		stabFlag3 := IF(le.firstReportedAtInputAddress > 0 AND stabFirstSeenDays <= 90, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		stabFlag2 := IF(le.firstReportedAtInputAddress > 0 AND stabFirstSeenDays BETWEEN 91 AND ut.DaysInNYears(1), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		stabFlag1 := IF(le.firstReportedAtInputAddress > 0 AND stabFirstSeenDays > ut.DaysInNYears(1), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
												
		stabConcat_Final := DueDiligence.Common.calcFinalFlagField(stabFlag9,
                                                               stabFlag8,
                                                               stabFlag7,
                                                               stabFlag6,
                                                               stabFlag5,
                                                               stabFlag4,
                                                               stabFlag3,
                                                               stabFlag2,
                                                               stabFlag1);
		
		SELF.BusStability_Flag := stabConcat_Final;
		SELF.BusStability := (STRING)(10-STD.Str.Find(stabConcat_Final, DueDiligence.Constants.T_INDICATOR, 1)); 
		
		
		//BUSINESS SHELL SHELF RISK
		nonCreditFirstSeen := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)le.busnHdrDtFirstSeenNonCredit, (STRING)le.historyDate);
		differSOSAndNoCredit := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)le.busnHdrDtFirstSeenNonCredit, (STRING)le.SOSIncorporationDate);
    
		shellShelfFlag9 := IF(le.numOfBusFoundAtAddr > 50 AND ((le.numOfBusIncInStateLooseLaws/le.numOfBusFoundAtAddr) * 100) > 25, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		shellShelfFlag8 := IF(le.numOfBusFoundAtAddr > 50 AND ((le.numOfBusNoReportedFein/le.numOfBusFoundAtAddr) * 100) > 75, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		shellShelfFlag7 := IF(le.registeredAgentExists AND (le.agentShelfBusn OR le.agentPotentialNIS), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		shellShelfFlag6 := IF((le.SOSIncorporationDate > 0 AND SOSAge >= ut.DaysInNYears(2)) AND
														((le.busnHdrDtFirstSeenNonCredit > 0 AND nonCreditFirstSeen < ut.DaysInNYears(2) AND
														le.busnHdrDtFirstSeenNonCredit > 0 AND le.SOSIncorporationDate > 0 AND differSOSAndNoCredit >= ut.DaysInNYears(2)) OR
														le.srcCount = 0), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		shellShelfFlag5 := IF(le.registeredAgentExists AND le.atleastOneAgentSameAddrAsBus, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);												
		shellShelfFlag4 := IF(le.privatePostExists OR le.mailDropExists OR le.remailerExists OR le.storageFacilityExists OR le.undeliverableSecRangeExists, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		shellShelfFlag3 := IF(le.shellHdrSrcCnt = 0 AND le.creditSrcCnt = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		shellShelfFlag2 := IF(le.incorpWithLooseLaws, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
				
		shellShelfConcat := shellShelfFlag9 + shellShelfFlag8 + shellShelfFlag7 + shellShelfFlag6 + shellShelfFlag5 + shellShelfFlag4 + shellShelfFlag3 + shellShelfFlag2;
		shellShelfFlag1 := IF(STD.Str.Find(shellShelfConcat, DueDiligence.Constants.T_INDICATOR, 1) = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		shellShelfFlag0 := DueDiligence.Constants.F_INDICATOR;
		
		shellShelfConcat_Final := shellShelfConcat + shellShelfFlag1 + shellShelfFlag0;
		
		SELF.BusShellShelf_Flag := shellShelfConcat_Final;
		SELF.BusShellShelf := (STRING)(10-STD.Str.Find(shellShelfConcat_Final, DueDiligence.Constants.T_INDICATOR, 1)); 
		
		
		//BUSINESS EXECUTIVE OFFICERS RISK
		highRiskFound := le.atleastOneActiveLawAcctExec OR le.atleastOneActiveFinRealEstateExec OR le.atleastOneActiveMedicalExec OR 
                     le.atleastOneActiveBlastPilotExec OR le.atleastOneInactiveLawAcctExec OR le.atleastOneInactiveFinRealEstateExec OR 
                     le.atleastOneInactiveMedicalExec OR le.atleastOneInactiveBlastPilotExec;
                                      
		execOfficerRisk9 := IF(le.atleastOneActiveLawAcctExec, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		execOfficerRisk8 := IF(le.atleastOneActiveFinRealEstateExec, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		execOfficerRisk7 := IF(le.atleastOneActiveMedicalExec, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		execOfficerRisk6 := IF(le.atleastOneActiveBlastPilotExec, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		execOfficerRisk5 := IF(le.atleastOneInactiveLawAcctExec, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		execOfficerRisk4 := IF(le.atleastOneInactiveFinRealEstateExec, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		execOfficerRisk3 := IF(le.atleastOneInactiveMedicalExec, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		execOfficerRisk2 := IF(le.atleastOneInactiveBlastPilotExec, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		execOfficerRisk1 := IF(le.numOfBusExecs = 0 OR highRiskFound = FALSE, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
												
		execOfficerRiskConcat_Final := DueDiligence.Common.calcFinalFlagField(execOfficerRisk9,
                                                                          execOfficerRisk8,
                                                                          execOfficerRisk7,
                                                                          execOfficerRisk6,
                                                                          execOfficerRisk5,
                                                                          execOfficerRisk4,
                                                                          execOfficerRisk3,
                                                                          execOfficerRisk2,
                                                                          execOfficerRisk1);
		
		SELF.BusBEOProfLicense_Flag := execOfficerRiskConcat_Final;
		SELF.BusBEOProfLicense := (STRING)(10-STD.Str.Find(execOfficerRiskConcat_Final, DueDiligence.Constants.T_INDICATOR, 1));
		
		
		
    //BUSINESS GEOGRAPHIC RISK
		BusGeoRisk_Flag9 := IF(le.CountyHasHighCrimeIndex AND le.CountyBordersForgeinJur AND (le.HIDTA OR le.HIFCA), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);										
		BusGeoRisk_Flag8 := IF(le.CityBorderStation OR le.CityFerryCrossing OR le.CityRailStation, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                     												
		BusGeoRisk_Flag7 := IF(le.CountyBordersForgeinJur, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);       		
		BusGeoRisk_Flag6 := IF(~le.CountyBordersForgeinJur AND le.CountyBorderOceanForgJur, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);												
		BusGeoRisk_Flag5 := IF(le.CountyHasHighCrimeIndex AND (le.HIDTA OR le.HIFCA), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                             												
		BusGeoRisk_Flag4 := IF(le.CountyHasHighCrimeIndex, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                    		                                                                 
		BusGeoRisk_Flag3 := IF(le.HIFCA, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                                  		
		BusGeoRisk_Flag2 := IF(le.HIDTA, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                           
		BusGeoRisk_Flag1 := IF(~le.CountyHasHighCrimeIndex, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
	
		BusGeoRisk_Flag_final := DueDiligence.Common.calcFinalFlagField(BusGeoRisk_Flag9,
                                                                    BusGeoRisk_Flag8,
                                                                    BusGeoRisk_Flag7,
                                                                    BusGeoRisk_Flag6,
                                                                    BusGeoRisk_Flag5,
                                                                    BusGeoRisk_Flag4,
                                                                    BusGeoRisk_Flag3,
                                                                    BusGeoRisk_Flag2,
                                                                    BusGeoRisk_Flag1); 
		
		SELF.BusGeographic_Flag := BusGeoRisk_Flag_final;                                             
		SELF.BusGeographic := (STRING)(10-STD.Str.Find(BusGeoRisk_Flag_final, DueDiligence.Constants.T_INDICATOR, 1)); 
  

		//BUSINESS LEGAL EVENTS - CRIMINAL STATE 																																																	 
		BusStateLegalEvent_Flag9 := IF(le.BEOevidenceOfCurrentIncarcerationOrParole, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);           
		BusStateLegalEvent_Flag8 := IF(le.BEOevidenceOfFelonyConvictionInLastNYR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);           
		BusStateLegalEvent_Flag7 := IF(le.BEOevidenceOfFelonyConvictionOlderNYR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);           
		BusStateLegalEvent_Flag6 := IF(le.BEOevidenceOfPreviousIncarceration, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);           
		BusStateLegalEvent_Flag5 := IF(le.BEOevidenceOfUncatagorizedConvictionInLastNYR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);    
		BusStateLegalEvent_Flag4 := IF(le.BEOevidenceOfMisdeameanorConvictionInLastNYR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);    
		BusStateLegalEvent_Flag3 := IF(le.BEOevidenceOfUncatagorizedConvictionOlderNYR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);    
		BusStateLegalEvent_Flag2 := IF(le.BEOevidenceOfMisdeameanorConvictionOlderNYR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);    
		BusStateLegalEvent_Flag1 := IF(le.BEONoEvidenceOfStateCriminal OR le.execCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		 
		BusStateLegalEvent_Flag_final  := DueDiligence.Common.calcFinalFlagField(BusStateLegalEvent_Flag9,
                                                                             BusStateLegalEvent_Flag8,
                                                                             BusStateLegalEvent_Flag7,
                                                                             BusStateLegalEvent_Flag6,
                                                                             BusStateLegalEvent_Flag5,
                                                                             BusStateLegalEvent_Flag4,
                                                                             BusStateLegalEvent_Flag3,
                                                                             BusStateLegalEvent_Flag2,
                                                                             BusStateLegalEvent_Flag1); 
		
    SELF.BusStateLegalEvent_Flag := BusStateLegalEvent_Flag_final;   
 	  SELF.BusStateLegalEvent := (STRING)(10 - STD.Str.Find(BusStateLegalEvent_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));
		
	
		//BUSINESS LEGAL EVENTS - CIVIL (LIENS, JUDGEMENTS and EVICTIONS)
		totalBusCivilCount := le.Business.liensUnreleasedCntInThePastNYR + le.Business.evictionsCntInThePastNYR;
    totalBusCivilCountOlder := le.Business.liensUnreleasedCntOVNYR + le.Business.evictionsCntOVNYR; 
     
		BusCivilLegalEvent_Flag9 := IF(totalBusCivilCount >= 10, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);    
		BusCivilLegalEvent_Flag8 := IF(totalBusCivilCount BETWEEN 5 AND 9, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);   											
		BusCivilLegalEvent_Flag7 := IF(totalBusCivilCount BETWEEN 3 AND 4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);    										
		BusCivilLegalEvent_Flag6 := IF(totalBusCivilCount BETWEEN 1 AND 2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
		BusCivilLegalEvent_Flag5 := IF(totalBusCivilCountOlder >= 10, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		BusCivilLegalEvent_Flag4 := IF(totalBusCivilCountOlder BETWEEN 5 AND 9, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 						
		BusCivilLegalEvent_Flag3 := IF(totalBusCivilCountOlder BETWEEN 3 AND 4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 										
		BusCivilLegalEvent_Flag2 := IF(totalBusCivilCountOlder BETWEEN 1 AND 2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
		BusCivilLegalEvent_Flag1 := IF(BusCivilLegalEvent_Flag9 = DueDiligence.Constants.F_INDICATOR 
                                    AND BusCivilLegalEvent_Flag8 = DueDiligence.Constants.F_INDICATOR
                                    AND BusCivilLegalEvent_Flag7 = DueDiligence.Constants.F_INDICATOR 
                                    AND BusCivilLegalEvent_Flag6 = DueDiligence.Constants.F_INDICATOR
                                    AND BusCivilLegalEvent_Flag5 = DueDiligence.Constants.F_INDICATOR 
                                    AND BusCivilLegalEvent_Flag4 = DueDiligence.Constants.F_INDICATOR
                                    AND BusCivilLegalEvent_Flag3 = DueDiligence.Constants.F_INDICATOR
                                    AND BusCivilLegalEvent_Flag2 = DueDiligence.Constants.F_INDICATOR, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR); 
		 
		BusCivilLegalEvent_Flag_final := DueDiligence.Common.calcFinalFlagField(BusCivilLegalEvent_Flag9,
                                                                            BusCivilLegalEvent_Flag8,
                                                                            BusCivilLegalEvent_Flag7,
                                                                            BusCivilLegalEvent_Flag6,
                                                                            BusCivilLegalEvent_Flag5,
                                                                            BusCivilLegalEvent_Flag4,
                                                                            BusCivilLegalEvent_Flag3,
                                                                            BusCivilLegalEvent_Flag2,
                                                                            BusCivilLegalEvent_Flag1); 
		
		 SELF.BusCivilLegalEvent_Flag :=  BusCivilLegalEvent_Flag_final;                                            /* This a string of T or F based on how the data used to calculate the KRI  */
		 SELF.BusCivilLegalEvent := (STRING)(10 - STD.Str.Find(BusCivilLegalEvent_Flag_final, DueDiligence.Constants.T_INDICATOR, 1));        /* Set the index to the position of the first 'T'.  */  																																																	 
		 
		 
		//BUSINESS LEGAL EVENT TYPE
		legalEventTypeFlag9 := IF(le.atleastOneBEOInCategory9, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		legalEventTypeFlag8 := IF(le.atleastOneBEOInCategory8, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		legalEventTypeFlag7 := IF(le.atleastOneBEOInCategory7, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		legalEventTypeFlag6 := IF(le.atleastOneBEOInCategory6, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		legalEventTypeFlag5 := IF(le.atleastOneBEOInCategory5, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		legalEventTypeFlag4 := IF(le.atleastOneBEOInCategory4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		legalEventTypeFlag3 := IF(le.atleastOneBEOInCategory3, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		legalEventTypeFlag2 := IF(le.atleastOneBEOInCategory2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		legalEventTypeFlag1 := IF(le.BEOsHaveNoConvictionsOrCategoryHits OR le.execCount = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
												
		legalEventTypeConcat_Final := DueDiligence.Common.calcFinalFlagField(legalEventTypeFlag9,
                                                                          legalEventTypeFlag8,
                                                                          legalEventTypeFlag7,
                                                                          legalEventTypeFlag6,
                                                                          legalEventTypeFlag5,
                                                                          legalEventTypeFlag4,
                                                                          legalEventTypeFlag3,
                                                                          legalEventTypeFlag2,
                                                                          legalEventTypeFlag1);
		
		SELF.BusOffenseType_Flag := legalEventTypeConcat_Final;
		SELF.BusOffenseType := (STRING)(10-STD.Str.Find(legalEventTypeConcat_Final, DueDiligence.Constants.T_INDICATOR, 1)); 
		
		
		//BUSINESS EXECUTIVE OFFICER US RESIDENCY
		beoResidencyFlag9 := IF(le.atleastOneBEOInvalidSSN , DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		beoResidencyFlag8 := IF(le.atleastOneBEOAssocITINOrImmigrantSSN , DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		beoResidencyFlag7 := IF(le.atleastOneBEODOBPriorToParentSSN , DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		beoResidencyFlag6 := IF(le.atleastOneBEOParentWithITINOrImmigrantSSN , DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		beoResidencyFlag5 := IF(le.atleastOneBEONoParentsOrNeitherHaveSSNITIN , DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		beoResidencyFlag4 := IF(le.atleastOneBEOPublicRecordsLess3YrsWithNoVote , DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		beoResidencyFlag3 := IF(le.atleastOneBEOPublicRecordsBetween3And10YrsWithNoVote , DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		beoResidencyFlag2 := IF(le.atleastOneBEOPublicRecordsMoreThan10YrsWithNoVote , DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
		beoResidencyFlag1 := IF(le.execCount = 0 OR le.atleastOneBEOOrParentRegisteredVoter , DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
												
		beoResidencyConcat_Final := DueDiligence.Common.calcFinalFlagField(beoResidencyFlag9,
                                                                        beoResidencyFlag8,
                                                                        beoResidencyFlag7,
                                                                        beoResidencyFlag6,
                                                                        beoResidencyFlag5,
                                                                        beoResidencyFlag4,
                                                                        beoResidencyFlag3,
                                                                        beoResidencyFlag2,
                                                                        beoResidencyFlag1);
		
		SELF.BusBEOUSResidency_Flag := beoResidencyConcat_Final;
		SELF.BusBEOUSResidency := (STRING)(10-STD.Str.Find(beoResidencyConcat_Final, DueDiligence.Constants.T_INDICATOR, 1));

			
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
																										// SELF.BusFederalLegalEvent := INVALID_BUSINESS_SCORE;
																										// SELF.BusFederalLegalEvent_Flag := INVALID_BUSINESS_FLAGS;
																										// SELF.BusFederalLegalMatchLevel := INVALID_BUSINESS_SCORE;
																										// SELF.BusFederalLegalMatchLevel_Flag := INVALID_BUSINESS_FLAGS;
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

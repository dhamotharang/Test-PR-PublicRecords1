IMPORT iesp, DueDiligence;

EXPORT getBusReport(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
											   //Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
													 //BOOLEAN includeReportData,
													 boolean DebugMode = FALSE
											     ) := FUNCTION
													 
													 
		
		
		// ***OperatingLocations is a nested DATASET within the Business Internal layout                   ***//
		// ***Need to convert this into a flat/simple dataset before calling the Geographic Risk FUNCTION  ***//
	 ListOfOperatingLocations := NORMALIZE(BusnData, LEFT.operatingLocations, TRANSFORM(DueDiligence.LayoutsInternal.GeographicLayout,
                             /*  start by getting all of the operating locations from the Parent  */  																														
																												 SELF.seq                       := LEFT.seq;
																													SELF.ultID                     := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
																													SELF.orgID                     := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
																													SELF.seleID                    := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
																													/*  now get the rest of the data from child dataset */   
																													SELF                           := RIGHT;
																													SELF                           := [];)); 
																													
	
 	
	
 
 // ------                                                                                     ------
	// ------ Convert the listOfOperatingLocations into the layout                                ------  
	// ------    expected by the Common.getGeographicRisk                                         ------
	// ------    Note: make sure we are using the best or the cleaned                             ------
	// ------                                                                                     ------
 ListOfOperAddresses  :=  PROJECT(ListOfOperatingLocations,  
			TRANSFORM(DueDiligence.layoutsInternal.GeographicLayout,
			 /* populate the Geographic internal record with address data from the List of Operating Locations  */ 
						  SELF.seq             := LEFT.seq;
					//***BEGIN FOR TESTING ONLY ****    *** FORCE IN SOME HIFCA 
					//   SELF.state           := 'FL';  
					//	  SELF.county          := '111';   
					//***END   FOR TESTING ONLY ****
				    SELF                 := LEFT;
						  SELF                 := []));  //***all other fields can be empty
	
	
	// ------                                                                                   ------
 // ------ Determine the Geographic Risk for the Inquired Business                           ------
	// ------                                                                                   ------
	AddressOperLocGeoRisk   := DueDiligence.Common.getGeographicRisk(ListOfOperAddresses, true);  
	
	
	
	
	// ------                                                                       ------
 // ------ define the ChildDataset                                               ------
	// ------                                                                       ------
	BusOperLocChildDatasetLayout    := RECORD
	 unsigned2                      seq;                                           //*  This is the seqence number of the parent   
	 DATASET(iesp.duediligencereport.t_DDRBusinessAddressRisk) BusOperLocRiskChild;
	END;																											
																													
 // ------                                                                        ------
 // ------ populate the ChildDataset  with the list of operating locations       ------
 // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
 // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
	// ------                                                                       ------
	iesp.duediligencereport.t_DDRBusinessAddressRisk  FormatTheListOfOperLoc(AddressOperLocGeoRisk le, Integer OperLocSeq) := TRANSFORM
	                                                            
																															                              SELF.Sequence                         := OperLocSeq;                      
																																														               SELF.Address.StreetNumber             := le.prim_range;
																																																					        SELF.Address.StreetPreDirection       := le.predir;
																																																									    SELF.Address.StreetName               := le.prim_name;     
																							                                      SELF.Address.StreetSuffix             := le.addr_suffix;
																																										                   SELF.Address.StreetPostDirection      := le.postdir;
																																																	            SELF.Address.UnitDesignation          := le.unit_desig;
																																																							      SELF.Address.UnitNumber               := le.sec_range; 
																																																										   SELF.Address.StreetAddress1           := le.streetAddress1;
																																																										   SELF.Address.StreetAddress2           := le.streetAddress2;
																																																											  SELF.Address.City                     := le.city;
																																																												 SELF.Address.State                    := le.state;
																																																												 SELF.Address.Zip5                     := le.zip5;
																																																												 SELF.Address.Zip4                     := le.zip4;
																																																												 SELF.Address.County                   := le.county;
																																																												 SELF.Address.PostalCode               := le.zip5 + le.zip4;
																																																												 SELF.Address.StateCityZip             := le.state + le.city + le.state;
																																																												 /*  County Risk  */  
																																																												 SELF.CountyCityRisk.CountyName        := 'ZZCOUNTYNAME';
																																																												 SELF.CountyCityRisk.BoardersForeignJurisdiction                :=  le.CountyBordersForgeinJur;
																																																												 SELF.CountyCityRisk.BoardersOceanWithin150ForeignJurisdiction  :=  le.CountyBorderOceanForgJur;
																																																												 /*  City Risk    */  
																																																												 SELF.CountyCityRisk.AccessThroughBoarderStation                :=  le.CityBorderStation; 
																																																												 SELF.CountyCityRisk.AccessThroughRailCrossing                  :=  le.CityRailStation;
																																																												 SELF.CountyCityRisk.AccessThroughFerryCrossing                 :=  le.CityFerryCrossing;
																																																												 /*  Area Risk    */
																																																												 SELF.AreaRisk.Hifca                                            :=  le.HIFCA;
																																																												 SELF.AreaRisk.Hidta                                            :=  le.HIDTA; 
																																																												 SELF.AreaRisk.CrimeIndex                                       :=  IF(le.CountyHasHighCrimeIndex, 'HIGH', 'LOW');   
																																																							      /*  Other Address Information  */   
																																																										   SELF.AddressType                     := 'ZZADDRESS TYPE';         //*** where do I get this from?
																																																											  SELF.InputAddressVerified            := true;                     //*** verified is true because it was found on the business header ***//
																																																												 SELF.IsVacant                        := IF(le.AddressVacancyInd = 'T', true, false);     //*** this has not been validated yet ***//
																																																												 SELF.Cmra                            := false;                    //*** this has not been code yet
																																																												 SELF                                 := le;
			                                                          SELF                                 := [];
																							                                   END;  
	 

	BusOperLocChildDataset  :=   
	PROJECT(AddressOperLocGeoRisk,                                  //*** Using this input dataset - these addresses have the geo risk populated  
			TRANSFORM(BusOperLocChildDatasetLayout,                       //*** format the data according to this layout.
				SELF.seq                    := LEFT.seq,                     //*** This is the sequence number of the Inquired Business (or the Parent)
				SELF.BusOperLocRiskChild   := PROJECT(LEFT, FormatTheListOfOperLoc(LEFT, COUNTER)))); 
				       

 // ------                                                                        ------
 // ------ define the TRANSFORM used by the DENORMALIZE FUNCTION                  ------
 // ------ that is bringing the parent (BusnData) on the LEFT and the newly       ------
 // ------ created child dataset on the RIGHT.                                    ------
	// ------                                                                        ------
	  DueDiligence.Layouts.Busn_Internal CreateNestedData(BusnData le, BusOperLocChildDataset ri, Integer BOLCount) := TRANSFORM
												     SELF.BusinessReport.BusinessAttributeDetails.OperatingAttributeDataDetails.BusinessLocations.OperatingLocationCount       := le.hdAddrCount;
									
														   //***                                                                                        OperatingLocations is the NESTED CHILD DATASET  
																 SELF.BusinessReport.BusinessAttributeDetails.OperatingAttributeDataDetails.BusinessLocations.OperatingLocations     := le.BusinessReport.BusinessAttributeDetails.OperatingAttributeDataDetails.BusinessLocations.OperatingLocations  + ri.BusOperLocRiskChild;
																	SELF := le;
				  											END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	UpdateBusnOperLocWithReport := DENORMALIZE(BusnData, BusOperLocChildDataset,
	                                            LEFT.seq = RIGHT.seq, 
											                                 CreateNestedData(Left, Right, Counter));  
		
		
		  																													
																													
													 
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************

	    IF(DebugMode,      OUTPUT(ListOfOperatingLocations,                NAMED('ListOfOperatingLocations')));
   	 IF(DebugMode,      OUTPUT(CHOOSEN(ListOfOperAddresses, 100),       NAMED('ListOfOperAddresses')));												 
   	 IF(DebugMode,      OUTPUT(CHOOSEN(AddressOperLocGeoRisk, 100),     NAMED('AddressOperLocGeoRisk')));												 
   	 IF(DebugMode,      OUTPUT(CHOOSEN(BusOperLocChildDataset, 100),     NAMED('BusOperLocChildDataset')));												 
   	 IF(DebugMode,      OUTPUT(CHOOSEN(UpdateBusnOperLocWithReport, 100),     NAMED('UpdateBusnOperLocWithReport')));												 
   	// IF(DebugMode,      OUTPUT(CHOOSEN(BusnDataWithOperLocGeoRisk, 100),     NAMED('BusnDataWithOperLocGeoRisk')));												 

	RETURN UpdateBusnOperLocWithReport;
END;
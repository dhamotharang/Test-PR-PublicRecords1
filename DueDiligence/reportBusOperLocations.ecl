﻿IMPORT Advo, BIPv2, DueDiligence, iesp;

EXPORT reportBusOperLocations(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
                              boolean DebugMode = FALSE
                              ) := FUNCTION
													 
													 
		
		
	 // ***OperatingLocations is a nested DATASET within the Business Internal layout                   ***//
	 // ***Need to convert this into a flat/simple dataset before calling the Geographic Risk FUNCTION  ***//
	 ListOfOperatingLocations := NORMALIZE(BusnData, LEFT.operatingLocations, TRANSFORM(DueDiligence.LayoutsInternal.GeographicLayout,																													
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
                                              SELF                 := LEFT;
                                              SELF                 := []));
	
	
   // ------                                                                                   ------
   // ------ Determine the Geographic Risk for the Inquired Business and operating locations   ------
   // ------                                                                                   ------
   GeographicRiskResults   := DueDiligence.Common.getGeographicRisk(ListOfOperAddresses);  

	 // ------                                                                                   ------
	 // ------ group the geographic dataset by seq and linkIDs so counter can count per grouping ------
	 // ------                                                                                   ------
	 groupAddressOperLocGeoRisk := GROUP(GeographicRiskResults, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
																											
																													
   // ------                                                                        ------
   // ------ populate the ChildDataset  with the list of operating locations       ------
   // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
   // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
	 // ------                                                                       ------
	 iesp.duediligencebusinessreport.t_DDRBusinessAddressRisk  FormatTheListOfOperLoc(groupAddressOperLocGeoRisk le, Integer OperLocSeq) := TRANSFORM,
                                                            SKIP(OperLocSeq > iesp.constants.DDRAttributesConst.MaxOperatingLocations)
                    
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
               SELF.Address.StateCityZip             := le.state + TRIM(le.city) + le.zip5;
               /*  County Risk  */  
               SELF.CountyCityRisk.CountyName                                :=  le.CountyName;
               SELF.CountyCityRisk.BordersForeignJurisdiction                :=  le.CountyBordersForgeinJur;
               SELF.CountyCityRisk.BordersOceanWithin150ForeignJurisdiction  :=  le.CountyBorderOceanForgJur;
               /*  City Risk    */  
               SELF.CountyCityRisk.AccessThroughBorderStation                 :=  le.CityBorderStation; 
               SELF.CountyCityRisk.AccessThroughRailCrossing                  :=  le.CityRailStation;
               SELF.CountyCityRisk.AccessThroughFerryCrossing                 :=  le.CityFerryCrossing;
               /*  Area Risk    */
               SELF.AreaRisk.Hifca                                            :=  le.HIFCA;
               SELF.AreaRisk.Hidta                                            :=  le.HIDTA; 
               SELF.AreaRisk.CrimeIndex                                       :=  IF(le.CountyHasHighCrimeIndex, 'HIGH', 'LOW');   
               /*  Other Address Information  */   
               SELF.AddressType                     := Advo.Lookup_Descriptions.fn_resbus(le.addressType);         
               SELF.InputAddressVerified            := true;                    //To be removed at later date - replaced by AddressVerified
               SELF.AddressVerified                 := true;   //*** verified is true because it was found on the business header ***//
               SELF.IsVacant                        := le.vacant;     
               SELF.Cmra                            := le.cmra;                   
               SELF                                 := le;
               SELF                                 := [];
	 END;  
	 

	 BusOperLocChildDataset  := PROJECT(groupAddressOperLocGeoRisk,  //Using this input dataset - these addresses have the geo risk populated  
                                      TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, DATASET(iesp.duediligencebusinessreport.t_DDRBusinessAddressRisk) BusOperLocRiskChild}, //format the data according to this layout.
                                                SELF.BusOperLocRiskChild   := PROJECT(LEFT, FormatTheListOfOperLoc(LEFT, COUNTER));
                                                SELF := LEFT;)); 
				       

															
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
   UpdateBusnOperLocWithReport := DENORMALIZE(BusnData, BusOperLocChildDataset,
	                                           #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
											                       TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                                        SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessLocations.OperatingLocationCount := COUNT(LEFT.operatingLocations);
                                                        //OperatingLocations is the NESTED CHILD DATASET  
                                                        SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessLocations.OperatingLocations := LEFT.BusinessReport.BusinessAttributeDetails.Operating.BusinessLocations.OperatingLocations  + RIGHT.BusOperLocRiskChild;
                                                        SELF := LEFT;));  
		
		
		  																													
																													
													 
	 // ********************
	 //   DEBUGGING OUTPUTS
	 // *********************
   IF(DebugMode,      OUTPUT(BusnData,                                NAMED('BusnDatainto')));
   IF(DebugMode,      OUTPUT(ListOfOperatingLocations,                NAMED('ListOfOperatingLocations')));
   IF(DebugMode,      OUTPUT(CHOOSEN(ListOfOperAddresses, 100),       NAMED('ListOfOperAddresses')));												 
   IF(DebugMode,      OUTPUT(CHOOSEN(GeographicRiskResults, 100),     NAMED('GeographicRiskResults')));																		 
   IF(DebugMode,      OUTPUT(CHOOSEN(BusOperLocChildDataset, 100),     NAMED('BusOperLocChildDataset')));												 
   IF(DebugMode,      OUTPUT(CHOOSEN(UpdateBusnOperLocWithReport, 100),     NAMED('UpdateBusnOperLocWithReport')));	
   
   // OUTPUT(BusOperLocChildDataset, NAMED('BusOperLocChildDataset'));
     

	RETURN UpdateBusnOperLocWithReport;
END;
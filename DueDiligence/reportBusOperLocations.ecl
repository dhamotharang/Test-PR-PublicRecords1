﻿IMPORT iesp, DueDiligence, BIPv2, Census_Data, iesp;

EXPORT reportBusOperLocations(DATASET(DueDiligence.layouts.Busn_Internal) BusnData, 
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
				      SELF                 := LEFT;
						  SELF                 := []));  //***all other fields can be empty
	
	
	// ------                                                                                   ------
  // ------ Determine the Geographic Risk for the Inquired Business                           ------
	// ------                                                                                   ------
	GeographicRiskResults   := DueDiligence.Common.getGeographicRisk(ListOfOperAddresses);  
  
  // ------                                                                                                              ------
  // ------ Use the Census Macro to fill in the county_name - pass the result set as input,                              ------
  // ------ the field name that contains the state,                                                                      ------ 
  // ------ the field name that contains the 3 digit fips(county) and the field name of the county name.                 ------
  // ------ the name of the output result set                                                                            ------
  // ------                                                                                                              ------
	//Census_Data.MAC_Fips2County_Keyed(GeographicRiskResults, state, Fipscode, countyName, AddressOperLocGeoRiskCounty);
	
	// ------                                                                                   ------
	// ------ group the geographic dataset by seq and linkIDs so counter can count per grouping ------
	// ------                                                                                   ------
	groupAddressOperLocGeoRisk := GROUP(GeographicRiskResults, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
	
	// ------                                                                       ------
  // ------ define the ChildDataset                                               ------
	// ------                                                                       ------
	BusOperLocChildDatasetLayout    := RECORD
	 unsigned2                      seq;                                           //*  This is the seqence number of the parent   
	 DATASET(iesp.duediligencebusinessreport.t_DDRBusinessAddressRisk) BusOperLocRiskChild;
	END;																											
																													
  // ------                                                                        ------
  // ------ populate the ChildDataset  with the list of operating locations       ------
  // ------ by building a DATASET we can INSERT the entire ChiledDATASET          ------
  // ------ as a 'WHOLE' into the DATASET defined within the PARENT               ------
	// ------                                                                       ------
	iesp.duediligencebusinessreport.t_DDRBusinessAddressRisk  FormatTheListOfOperLoc(groupAddressOperLocGeoRisk le, Integer OperLocSeq) := TRANSFORM,
                                                            SKIP(OperLocSeq > iesp.constants.DDRAttributesConst.MaxOperatingLocations)
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
               SELF.AddressType                     := 'ZZADDRESS TYPE';         //*** where do I get this from?
               SELF.InputAddressVerified            := true;                     //*** verified is true because it was found on the business header ***//
               SELF.IsVacant                        := IF(le.AddressVacancyInd = 'T', true, false);     //*** this has not been validated yet ***//
               SELF.Cmra                            := false;                    //*** this has not been code yet
               SELF                                 := le;
               SELF                                 := [];
	END;  
	 

	BusOperLocChildDataset  :=   
	PROJECT(groupAddressOperLocGeoRisk,                                //*** Using this input dataset - these addresses have the geo risk populated  
			TRANSFORM(BusOperLocChildDatasetLayout,                       //*** format the data according to this layout.
				SELF.seq                    := LEFT.seq,                    //*** This is the sequence number of the Inquired Business (or the Parent)
				SELF.BusOperLocRiskChild   := PROJECT(LEFT, FormatTheListOfOperLoc(LEFT, COUNTER)))); 
				       

 // ------                                                                        ------
 // ------ define the TRANSFORM used by the DENORMALIZE FUNCTION                  ------
 // ------ that is bringing the parent (BusnData) on the LEFT and the newly       ------
 // ------ created child dataset on the RIGHT.                                    ------
	// ------                                                                        ------
	  DueDiligence.Layouts.Busn_Internal CreateNestedData(BusnData le, BusOperLocChildDataset ri, Integer BOLCount) := TRANSFORM
												    SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessLocations.OperatingLocationCount := le.hdAddrCount;
														   //***                                                                                        OperatingLocations is the NESTED CHILD DATASET  
														SELF.BusinessReport.BusinessAttributeDetails.Operating.BusinessLocations.OperatingLocations     := le.BusinessReport.BusinessAttributeDetails.Operating.BusinessLocations.OperatingLocations  + ri.BusOperLocRiskChild;
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
   	 IF(DebugMode,      OUTPUT(CHOOSEN(GeographicRiskResults, 100),     NAMED('GeographicRiskResults')));												 
   	 //IF(DebugMode,      OUTPUT(CHOOSEN(AddressOperLocGeoRiskCounty, 100),     NAMED('AddressOperLocGeoRiskCounty')));												 
   	 IF(DebugMode,      OUTPUT(CHOOSEN(BusOperLocChildDataset, 100),     NAMED('BusOperLocChildDataset')));												 
   	 IF(DebugMode,      OUTPUT(CHOOSEN(UpdateBusnOperLocWithReport, 100),     NAMED('UpdateBusnOperLocWithReport')));												 
   	// IF(DebugMode,      OUTPUT(CHOOSEN(BusnDataWithOperLocGeoRisk, 100),     NAMED('BusnDataWithOperLocGeoRisk')));												 

	RETURN UpdateBusnOperLocWithReport;
END;
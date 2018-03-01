IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, UT, iesp, Census_Data;

EXPORT reportBusProperty(DATASET(DueDiligence.layouts.Busn_Internal) UpdateBusnPropertyForAttributeLogic, 
											   DATASET(DueDiligence.LayoutsInternal.PropertySlimLayout) BusPropertyOwnedWithDetails,
											   boolean DebugMode = FALSE
											   ) := FUNCTION

  // ------                                                                                     ------
  // ------ Limit the number properties according the max for the report                        ------  
  // ------                                                                                     ------ 
  PropertyCurrentlyOwnedButLimited   := dedup(sort(BusPropertyOwnedWithDetails,  PropertyReportData.seleid, -TaxAssdValue), PropertyReportData.seleid,  KEEP(iesp.constants.DDRAttributesConst.MaxProperties));  
 
  // ------                                                                                     ------
  // ------ add a sequence number to uniquely identify each property                            ------  
  // ------                                                                                     ------ 
  PropertyCurrentlyOwnedSequenced    := PROJECT(PropertyCurrentlyOwnedButLimited , TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout, 
                                                                                         SELF.propertySeq := COUNTER, 
																																												                                             SELF := left));	

  // ------                                                                                     ------
	// ------ Convert the PropertyCurrentlyOwnedButLimited into the layout                        ------  
	// ------    expected by the Common.getGeographicRisk                                         ------
	// ------                                                                                     ------
  ListOfPropertyAddresses  :=  PROJECT(PropertyCurrentlyOwnedSequenced,  
			TRANSFORM(DueDiligence.layoutsInternal.GeographicLayout,
			 /* populate the Geographic internal record with address data from the List of Operating Locations  */ 
						  SELF.seq             := LEFT.PropertyReportData.seq;
							 SELF.ultID           := LEFT.PropertyReportData.ultID;
							 SELF.orgID           := LEFT.PropertyReportData.orgID;
							 SELF.seleID          := LEFT.PropertyReportData.seleID;
							 SELF.proxID          := LEFT.PropertyReportData.proxID;
							 SELF.powID           := LEFT.PropertyReportData.powID;
							 SELF.GeoSequence     := LEFT.propertySeq;
							 /*  County Risk  */
							 SELF.county          := LEFT.county[3..5];  //***the county on the property slim is the 5 digit county
							 /*  City Risk    */
							 SELF.state           := LEFT.st;
               SELF                 := LEFT;
               SELF                 := []));  //***all other fields can be empty
						   
	 
	
	// ------                                                                                   ------
  // ------ Determine the Geographic Risk for the Inquired Business                           ------
	// ------     The results are in DueDiligence.layoutsInternal.GeographicLayout              ------
	// ------                                                                                   ------
	AddressPropertyOwnedRisk   := DueDiligence.Common.getGeographicRisk(ListOfPropertyAddresses);  
	
	// ------                                                                                    ------	
	// ----- Add the Geographic Risk to Property Slim Record                                     ------
	// ------                                                                                    ------
	SlimBusnOwnedProperty := JOIN(PropertyCurrentlyOwnedSequenced, AddressPropertyOwnedRisk,
												LEFT.PropertyReportData.seq          = RIGHT.seq AND
												LEFT.PropertyReportData.UltID        = RIGHT.ultID AND
												LEFT.PropertyReportData.OrgID        = RIGHT.orgID AND
												LEFT.PropertyReportData.SeleID       = RIGHT.seleID AND
												LEFT.propertySeq                     = RIGHT.GeoSequence,
												TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout, 
												     /*  populate the geographic risk from the RIGHT  */
																	SELF.buildgeolink                 := RIGHT.buildgeolink,
																	SELF.EasiTotCrime                 := RIGHT.EasiTotCrime,
																	SELF.CityState                    := RIGHT.CityState,
																	SELF.AddressVacancyInd            := RIGHT.AddressVacancyInd,
																	SELF.CountyHasHighCrimeIndex      := RIGHT.CountyHasHighCrimeIndex,
																	SELF.CountyBordersForgeinJur      := RIGHT.CountyBordersForgeinJur,
																	SELF.CountyBorderOceanForgJur     := RIGHT.CountyBorderOceanForgJur,
																	SELF.CityBorderStation            := RIGHT.CityBorderStation,
																	SELF.CityFerryCrossing            := RIGHT.CityFerryCrossing,
																	SELF.CityRailStation              := RIGHT.CityRailStation,
																	SELF.HIDTA                        := RIGHT.HIDTA,
																	SELF.HIFCA                        := RIGHT.HIFCA,
																	SELF.HighFelonNeighborhood        := RIGHT.HighFelonNeighborhood,
																	SELF.HRBusPct                     := RIGHT.HRBusPct,
                                  SELF.CountyName                   := RIGHT.CountyName,
																	/*  pass everything else from the LEFT    */  
																	SELF := LEFT),
																	LEFT OUTER);
												
	//group slimmed dataset by seq and linkIDs so counter can count per grouping
	groupSlimBusnOwnedProperty := GROUP(SlimBusnOwnedProperty, PropertyReportData.seq, PropertyReportData.UltID, PropertyReportData.OrgID, PropertyReportData.SeleID );
	
	// ------                                                                                    ------
  // ------ define the ChildDataset of Property                                                ------
	// ------                                                                                    ------
	PropertyChildDatasetLayout    := RECORD
	  unsigned2 seq;                                                        //*  This is the seqence number of the parent  
	  DATASET(iesp.duediligencebusinessreport.t_DDRBusinessProperty) PropChild;
	END;
	 
  // ------                                                                                    ------
  // ------ format the Slim Property into the ChildDataset layout of Property                  ------
	// ------                                                                                    ------	 
	iesp.duediligencebusinessreport.t_DDRBusinessProperty    FormatTheListOfProperty(RECORDOF(groupSlimBusnOwnedProperty) le, Integer PropertySeq) := TRANSFORM 
 	                       SELF.OwnerOccupied                 := MAP(
                                                                    le.OwnerOccupied = 'Y'   => 'Y',
                                                                    le.OwnerOccupied = 'N'   => 'N',
                                                                                                'U'); 
                         SELF.BusinessAddressType                := le.BusinessType; 
                         SELF.Ownership.PurchasePrice      := le.PurchasePrice;
                                                                    /* position 1 through 4 = yyyy */
                         SELF.Ownership.PurchaseDate.Year  := (unsigned4)le.SaleDate[1..4];
                                                                    /* position 5 through 6 = MM */  
                         SELF.Ownership.PurchaseDate.Month := (unsigned2)le.SaleDate[5..6];
                                                                    /* position 6 through 8 = DD  */  
                         SELF.Ownership.PurchaseDate.Day   := (unsigned2)le.SaleDate[7..8];
                         SELF.Ownership.LengthofOwnership  := le.lengthOfOwnership;
                         SELF.Assessment.TaxPrice        := le.TaxAssdValue;          //* check this field?  
                         SELF.Assessment.TaxYear.Year    := (integer)le.TaxYear;
                         SELF.Address.StreetNumber          := le.prim_range;
                         SELF.Address.StreetPreDirection    := le.predir; 
                         SELF.Address.StreetName            := le.prim_name;
                         SELF.Address.StreetSuffix          := le.suffix;
                         SELF.Address.StreetPostDirection   := le.postdir;
                         SELF.Address.UnitDesignation       := le.unit_desig;
                         SELF.Address.UnitNumber            := le.sec_range;
                         SELF.Address.City                  := le.p_city_name;
                         SELF.Address.State                 := le.st;
                         SELF.Address.Zip5                  := le.zip; 
                         SELF.Address.Zip4                  := le.zip4;
                         SELF.Address.County                := le.countyName; 
                         SELF.OwnerName.Full                := le.assesseeName;
                         /*  County Risk  */  
                         SELF.CountyCityRisk.CountyName         := le.countyName;
                         SELF.CountyCityRisk.BordersForeignJurisdiction                :=  le.CountyBordersForgeinJur;
                         SELF.CountyCityRisk.BordersOceanWithin150ForeignJurisdiction  :=  le.CountyBorderOceanForgJur;
                         /*  City Risk    */  
                         SELF.CountyCityRisk.AccessThroughBorderStation                :=  le.CityBorderStation; 
                         SELF.CountyCityRisk.AccessThroughRailCrossing                  :=  le.CityRailStation;
                         SELF.CountyCityRisk.AccessThroughFerryCrossing                 :=  le.CityFerryCrossing;
                         /*  Area Risk    */
                         SELF.AreaRisk.Hifca                                        :=  le.HIFCA;
                         SELF.AreaRisk.Hidta                                        :=  le.HIDTA; 
                         SELF.AreaRisk.CrimeIndex                                   :=  IF(le.CountyHasHighCrimeIndex, 'HIGH', 'LOW'); 
                         /*  The rest of the fields in the report will be blank for now  */  
                         SELF                                                           :=  [];
	END;  
	 
	  
	PropertyChildDataset  :=   
		PROJECT(groupSlimBusnOwnedProperty,
			TRANSFORM(PropertyChildDatasetLayout,
				SELF.seq             := LEFT.PropertyReportData.seq,
				SELF.PropChild       := PROJECT(LEFT, FormatTheListOfProperty(LEFT, COUNTER)))); 
				       
				                                         
	
	 /*  define the TRANSFORM used by the DENORMALIZE FUNCTION                        */  
	 DueDiligence.Layouts.Busn_Internal CreateNestedData(UpdateBusnPropertyForAttributeLogic le, PropertyChildDataset ri, Integer PropCount) := TRANSFORM
												     SELF.BusinessReport.BusinessAttributeDetails.Economic.Property.PropertyCurrentCount  := le.CurrPropOwnedCount,
																	SELF.BusinessReport.BusinessAttributeDetails.Economic.Property.TaxAssessedValue      := le.PropTaxValue,
																	SELF.BusinessReport.BusinessAttributeDetails.Economic.Property.Properties := le.BusinessReport.BusinessAttributeDetails.Economic.Property.Properties + ri.PropChild;
																	SELF := le;
																	END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	 UpdateBusnPropertyWithReport := DENORMALIZE(UpdateBusnPropertyForAttributeLogic, PropertyChildDataset,
	                                             LEFT.seq = RIGHT.seq, 
												                       CreateNestedData(Left, Right, Counter));  
		
	
    // ********************
    //   DEBUGGING OUTPUTS
    // *********************
	  IF(DebugMode,     OUTPUT(COUNT  (PropertyCurrentlyOwnedButLimited),         NAMED('HowManyPropertyCurrentlyOwnedButLimited')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(AddressPropertyOwnedRisk, 30),            NAMED('AddressPropertyOwnedRisk')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(ListOfPropertyAddresses, 30),             NAMED('ListOfPropertyAddresses')));
	  IF(DebugMode,     OUTPUT(CHOOSEN(PropertyChildDataset, 30),                NAMED('PropertyChildDataset')));
	 
		
		Return UpdateBusnPropertyWithReport;
		
	END;   
	
	
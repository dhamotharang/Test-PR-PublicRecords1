
IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, UT, iesp, Census_Data;

EXPORT reportBusProperty(DATASET(DueDiligence.layouts.Busn_Internal) UpdateBusnPropertyForAttributeLogic, 
											   DATASET(DueDiligence.LayoutsInternal.PropertySlimLayout) PropertyCurrentlyOwnedButLimited,
											   boolean DebugMode = FALSE
											   ) := FUNCTION

	 // ------                                                                                    ------   
	 // ------ Convert the fips code to a County Name for reporting                               ------ 
	 // ------  DON'T NEED - DELETE next release                                                                                  ------
	  PropertyCurentlyOwnedForReporting := PropertyCurrentlyOwnedButLimited;  //for debugging
	 // PropertyCurentlyOwnedForReporting := join(PropertyCurrentlyOwnedButLimited, Census_Data.file_Fips2County,
													 // left.st = right.state_fips and
													 // /* take the last 3 digits of the 5 digit value */  
													 // left.countyFIPS[3..5] = right.county_fips,
											  // TRANSFORM(RECORDOF(LEFT),
															// self.countyName:= right.county_name;
															// self := left),
															// lookup, 
															// left outer);
															



	 
	// ------                                                                                    ------
  // ------ create the ChildDataset of Property                                                ------
	// ------                                                                                    ------
	PropertyChildDatasetLayout    := RECORD
	  unsigned2                      seq;                                                        //*  This is the seqence number of the parent  
	  DATASET(iesp.duediligencereport.t_DDRProperty) PropChild;
	END;
	 
	 
	iesp.duediligencereport.t_DDRProperty    FormatTheListOfProperty(RECORDOF(PropertyCurentlyOwnedForReporting) le, Integer PropertySeq) := TRANSFORM 
                                                 SELF.Sequence                      := PropertySeq;
 	                                               SELF.OwnerOccupied                 := MAP(
																								                                            le.OwnerOccupied = 'Y'   => 'Y',
																																														le.OwnerOccupied = 'N'   => 'N',
																																														                            'U'); 
																								 SELF.BusinessAddressType           := le.BusinessType; 
																								 SELF.PurchaseDetails.PurchasePrice := le.PurchasePrice;
																								 SELF.PurchaseDetails.PurchaseDate.Year  := (integer)le.SaleDate[1..4];
																								 SELF.PurchaseDetails.PurchaseDate.Month := (integer)le.SaleDate[4..2];
																								 SELF.PurchaseDetails.PurchaseDate.Day   := (integer)le.SaleDate[6..2];
																								 SELF.PurchaseDetails.LengthofOwnership  := le.lengthOfOwnership;
																								 SELF.MostRecentTax.TaxPrice        := le.TaxAssdValue;    //* I think i have the wrong field?  
																								 SELF.MostRecentTax.TaxYear.Year    := (integer)le.TaxYear;
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
				                                         SELF                               := [];
																								 END;  
	 
	 
	PropertyChildDataset  :=   
		PROJECT(PropertyCurentlyOwnedForReporting,
			TRANSFORM(PropertyChildDatasetLayout,
				SELF.seq             := LEFT.PropertyReportData.seq,
				SELF.PropChild       := PROJECT(LEFT, FormatTheListOfProperty(LEFT, COUNTER)))); 
				       
				                                         
	
	 /*  define the TRANSFORM used by the DENORMALIZE FUNCTION                        */  
	  DueDiligence.Layouts.Busn_Internal CreateNestedData(UpdateBusnPropertyForAttributeLogic le, PropertyChildDataset ri, Integer PropCount) := TRANSFORM
												          SELF.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.PropertyOwnerShip.PropertyCurrentCount  := le.CurrPropOwnedCount,
																	SELF.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.PropertyOwnerShip.TaxAssessedValue      := le.PropTaxValue,
																	SELF.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.PropertyOwnerShip.Properties := le.BusinessReport.BusinessAttributeDetails.EconomicAttributeDataDetails.PropertyOwnerShip.Properties + ri.PropChild;
																	SELF := le;
																	END; 
																	
	 /* perform the DENORMALIZE (join) by Seq #                                        */   															 															
	 UpdateBusnPropertyWithReport := DENORMALIZE(UpdateBusnPropertyForAttributeLogic, PropertyChildDataset,
	                                             LEFT.seq = RIGHT.seq, 
												                       CreateNestedData(Left, Right, Counter));  
		
	
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
	 
	  IF(DebugMode,     OUTPUT(CHOOSEN(PropertyCurentlyOwnedForReporting, 50),     NAMED('Sample_PropertyCurentlyOwnedForReporting_Step8')));
	  IF(DebugMode,     OUTPUT(COUNT  (PropertyCurentlyOwnedForReporting),         NAMED('HowManyPropertyCurentlyOwnedForReportingStep8')));
	 
	 
	  IF(DebugMode,     OUTPUT(CHOOSEN(PropertyChildDataset, 100),  NAMED('PropertyChildDataset')));
	 
	  PropertyReportDataAdded  := UpdateBusnPropertyWithReport;
	  // PropertyReportDataAdded    := UpdateBusnPropertyForAttributeLogic;   //***for debugging
		
		Return PropertyReportDataAdded;
		
	END;   
	
	
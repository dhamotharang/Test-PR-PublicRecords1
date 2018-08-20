IMPORT BIPv2, DueDiligence, iesp;

EXPORT reportBusProperty(DATASET(DueDiligence.layouts.Busn_Internal) inData) := FUNCTION


    //pull property data from the inquired
    listOfProperties := NORMALIZE(inData, LEFT.busProperties, TRANSFORM(DueDiligence.LayoutsInternalReport.SharedPropertyLayout,																												
                                                                    SELF.seq := LEFT.seq; 
                                                                    SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                                    SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
                                                                    SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
                                                                    
                                                                    SELF.prim_range := RIGHT.prim_range;
                                                                    SELF.predir := RIGHT.predir;
                                                                    SELF.prim_name := RIGHT.prim_name;
                                                                    SELF.addr_suffix := RIGHT.addr_suffix;
                                                                    SELF.postdir := RIGHT.postdir;
                                                                    SELF.unit_desig := RIGHT.unit_desig;
                                                                    SELF.sec_range := RIGHT.sec_range;
                                                                    SELF.city := RIGHT.city;
                                                                    SELF.state := RIGHT.state;
                                                                    SELF.zip5 := RIGHT.zip5;
                                                                    SELF.zip4 := RIGHT.zip4;
                                                                    SELF.county := RIGHT.county;
                                                                    SELF.geo_blk := RIGHT.geo_blk;
                                                                    SELF.addressType := RIGHT.addressType;
                                                                    SELF.purchaseDate := RIGHT.purchaseDate;
                                                                    SELF.purchasePrice := RIGHT.purchasePrice;
                                                                    SELF.lengthOfOwnership := RIGHT.lengthOfOwnership;
                                                                    SELF.assessedYear := RIGHT.assessedYear;
                                                                    SELF.assessedTotalValue := RIGHT.assessedValue;
                                                                    SELF.ownerName := RIGHT.ownerName;
                                                                    
                                                                    SELF := [];)); 
  
  
    ownedPropertyDetails := DueDiligence.reportSharedProperty(listOfProperties);
                                
    //transform data to the report layout
    propertyReport := PROJECT(ownedPropertyDetails, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(iesp.duediligencebusinessreport.t_DDRBusinessProperty) busProperties},
                                                              SELF.seq := LEFT.seq;
                                                              SELF.ultID := LEFT.ultID;
                                                              SELF.orgID := LEFT.orgID;
                                                              SELF.seleID := LEFT.seleID;
                                                              
                                                              SELF.busProperties := DATASET([TRANSFORM(iesp.duediligencebusinessreport.t_DDRBusinessProperty,
                                                                                                        SELF.OwnerOccupied:= IF(LEFT.ownerOccupied NOT IN [DueDiligence.Constants.YES, DueDiligence.Constants.NO], 'U', LEFT.ownerOccupied);
                                                                                                        SELF.AddressType := LEFT.addressType; 
                                                                                                        
                                                                                                        SELF.Ownership.PurchasePrice := LEFT.PurchasePrice;       
                                                                                                        SELF.Ownership.PurchaseDate := iesp.ECL2ESP.toDatestring8(LEFT.purchaseDate);
                                                                                                        SELF.Ownership.LengthofOwnership := LEFT.lengthOfOwnership;
                                                                                                        
                                                                                                        SELF.Assessment.TaxPrice := LEFT.assessedTotalValue;  
                                                                                                        SELF.Assessment.TaxYear.Year := (INTEGER)LEFT.assessedYear;
                                                                                                        
                                                                                                        SELF.Address.StreetNumber := LEFT.prim_range;
                                                                                                        SELF.Address.StreetPreDirection := LEFT.predir; 
                                                                                                        SELF.Address.StreetName := LEFT.prim_name;
                                                                                                        SELF.Address.StreetSuffix := LEFT.addr_suffix;
                                                                                                        SELF.Address.StreetPostDirection := LEFT.postdir;
                                                                                                        SELF.Address.UnitDesignation := LEFT.unit_desig;
                                                                                                        SELF.Address.UnitNumber := LEFT.sec_range;
                                                                                                        SELF.Address.City := LEFT.city;
                                                                                                        SELF.Address.State := LEFT.state;
                                                                                                        SELF.Address.Zip5 := LEFT.zip5; 
                                                                                                        SELF.Address.Zip4 := LEFT.zip4;
                                                                                                        SELF.Address.County := LEFT.countyName; 
                                                                                                        
                                                                                                        SELF.OwnerName.Full := LEFT.ownerName;
                                                                                                        
                                                                                                        SELF.CountyCityRisk.CountyName := LEFT.countyName;
                                                                                                        SELF.CountyCityRisk.BordersForeignJurisdiction := LEFT.CountyBordersForgeinJur;
                                                                                                        SELF.CountyCityRisk.BordersOceanWithin150ForeignJurisdiction := LEFT.CountyBorderOceanForgJur; 
                                                                                                        SELF.CountyCityRisk.AccessThroughBorderStation := LEFT.CityBorderStation; 
                                                                                                        SELF.CountyCityRisk.AccessThroughRailCrossing := LEFT.CityRailStation;
                                                                                                        SELF.CountyCityRisk.AccessThroughFerryCrossing := LEFT.CityFerryCrossing;
                                                                                                        
                                                                                                        SELF.AreaRisk.Hifca := LEFT.HIFCA;
                                                                                                        SELF.AreaRisk.Hidta := LEFT.HIDTA; 
                                                                                                        SELF.AreaRisk.CrimeIndex := IF(LEFT.CountyHasHighCrimeIndex, 'HIGH', 'LOW'); 
                                                                                                        
                                                                                                        SELF := [];)]);
                                                                
                                                              SELF :=  [];));
    
    
    rollProperties := ROLLUP(SORT(propertyReport, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())),
                              #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.busProperties := LEFT.busProperties + RIGHT.busProperties;
                                        SELF := LEFT;));
    
    
    
    //add formatted report data to the report
    addPropertyToReport := JOIN(inData, rollProperties,
                                #EXPAND(DueDiligence.Constants.mac_JOINLinkids_BusInternal()),
                                TRANSFORM(DueDiligence.layouts.Busn_Internal,
                                          SELF.BusinessReport.BusinessAttributeDetails.Economic.Property.PropertyCurrentCount := LEFT.CurrPropOwnedCount;
                                          SELF.BusinessReport.BusinessAttributeDetails.Economic.Property.TaxAssessedValue := LEFT.PropTaxValue;
                                          SELF.BusinessReport.BusinessAttributeDetails.Economic.Property.Properties := RIGHT.busProperties;
                                          SELF := LEFT;),
                                LEFT OUTER,
                                ATMOST(1));
    
    
    
    
    
    // OUTPUT(listOfProperties, NAMED('listOfProperties'));
    // OUTPUT(ownedPropertyDetails, NAMED('ownedPropertyDetails'));
    // OUTPUT(propertyReport, NAMED('propertyReport'));
    // OUTPUT(rollProperties, NAMED('rollProperties'));
    // OUTPUT(addPropertyToReport, NAMED('addPropertyToReport'));
		
		RETURN addPropertyToReport;
		
END;   
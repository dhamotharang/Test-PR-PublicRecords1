IMPORT BIPv2, DueDiligence, iesp;

EXPORT reportBusProperty(DATASET(DueDiligence.layouts.Busn_Internal) inData) := FUNCTION


  //pull property data from the inquired
  listOfProperties := NORMALIZE(inData, LEFT.properties, TRANSFORM(DueDiligence.LayoutsInternalReport.SharedPropertyLayout,																												
                                                                    SELF.seq := LEFT.seq; 
                                                                    SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                                    SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
                                                                    SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
                                                                    
                                                                    SELF.prim_range := RIGHT.prim_range;
                                                                    SELF.predir := RIGHT.predir;
                                                                    SELF.prim_name := RIGHT.prim_name;
                                                                    SELF.suffix := RIGHT.addr_suffix;
                                                                    SELF.postdir := RIGHT.postdir;
                                                                    SELF.unit_desig := RIGHT.unit_desig;
                                                                    SELF.sec_range := RIGHT.sec_range;
                                                                    SELF.p_city_name := RIGHT.city;
                                                                    SELF.st := RIGHT.state;
                                                                    SELF.zip := RIGHT.zip5;
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
  

    //limit the number of properties according to the max for the report
    limitedProperties := DEDUP(SORT(listOfProperties, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -assessedYear), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), KEEP(iesp.constants.DDRAttributesConst.MaxProperties));
   
    
    //transform data to calc the geographic risk per address
    geoPropertyAddress := PROJECT(limitedProperties, TRANSFORM(DueDiligence.layoutsInternal.GeographicLayout,
                                                               SELF.seq := LEFT.seq;
                                                               SELF.ultID := LEFT.ultID;
                                                               SELF.orgID := LEFT.orgID;
                                                               SELF.seleID := LEFT.seleID;
                                                               SELF.prim_range := LEFT.prim_range;
                                                               SELF.predir := LEFT.predir;
                                                               SELF.prim_name := LEFT.prim_name;
                                                               SELF.addr_suffix := LEFT.suffix;
                                                               SELF.postdir := LEFT.postdir;
                                                               SELF.unit_desig := LEFT.unit_desig;
                                                               SELF.sec_range := LEFT.sec_range;
                                                               SELF.city := LEFT.p_city_name;
                                                               SELF.state := LEFT.st;
                                                               SELF.zip5 := LEFT.zip;
                                                               SELF.zip4 := LEFT.zip4;
                                                               SELF.county := LEFT.county;
                                                               SELF.geo_blk := LEFT.geo_blk;
                                                               SELF := LEFT;
                                                               SELF := [];));
   
   propertyOwnedRisk := DueDiligence.Common.getGeographicRisk(geoPropertyAddress);
   
   
   //add the risk back to the property details
   ownedPropertyDetails := JOIN(limitedProperties, propertyOwnedRisk,
                                #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                                LEFT.prim_range = RIGHT.prim_range AND
                                LEFT.prim_name[1..8] = RIGHT.prim_name[1..8] AND
                                LEFT.zip = RIGHT.zip5,
                                TRANSFORM(DueDiligence.LayoutsInternalReport.SharedPropertyLayout,
                                          SELF.buildgeolink := RIGHT.buildgeolink;
                                          SELF.EasiTotCrime := RIGHT.EasiTotCrime;
                                          SELF.CityState := RIGHT.CityState;
                                          SELF.FipsCode := RIGHT.FipsCode;  
                                          SELF.CountyName := RIGHT.CountyName;                     
                                          SELF.CountyHasHighCrimeIndex := RIGHT.CountyHasHighCrimeIndex;   
                                          SELF.CountyBordersForgeinJur := RIGHT.CountyBordersForgeinJur;   
                                          SELF.CountyBorderOceanForgJur := RIGHT.CountyBorderOceanForgJur;  
                                          SELF.CityBorderStation := RIGHT.CityBorderStation;  
                                          SELF.CityFerryCrossing := RIGHT.CityFerryCrossing;  
                                          SELF.CityRailStation := RIGHT.CityRailStation; 
                                          SELF.HIDTA := RIGHT.HIDTA;  
                                          SELF.HIFCA := RIGHT.HIFCA;                                  
                                          SELF.HighFelonNeighborhood := RIGHT.HighFelonNeighborhood;     
                                          SELF := LEFT;),
                                LEFT OUTER,
                                ATMOST(1));
                                
                                
                                
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
                                                                                                        SELF.Address.StreetSuffix := LEFT.suffix;
                                                                                                        SELF.Address.StreetPostDirection := LEFT.postdir;
                                                                                                        SELF.Address.UnitDesignation := LEFT.unit_desig;
                                                                                                        SELF.Address.UnitNumber := LEFT.sec_range;
                                                                                                        SELF.Address.City := LEFT.p_city_name;
                                                                                                        SELF.Address.State := LEFT.st;
                                                                                                        SELF.Address.Zip5 := LEFT.zip; 
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
    // OUTPUT(limitedProperties, NAMED('limitedProperties'));
    // OUTPUT(geoPropertyAddress, NAMED('geoPropertyAddress'));
    // OUTPUT(propertyOwnedRisk, NAMED('propertyOwnedRisk'));
    // OUTPUT(ownedPropertyDetails, NAMED('ownedPropertyDetails'));
    // OUTPUT(propertyReport, NAMED('propertyReport'));
    // OUTPUT(rollProperties, NAMED('rollProperties'));
    // OUTPUT(addPropertyToReport, NAMED('addPropertyToReport'));
		
		RETURN addPropertyToReport;
		
END;   
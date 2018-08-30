IMPORT ADVO, DueDiligence, iesp, STD;


EXPORT reportIndProperty(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION  

    //pull property data from the inquired  
    listOfProperties := NORMALIZE(inData, LEFT.perProperties, TRANSFORM(DueDiligence.LayoutsInternalReport.SharedPropertyLayout,																												
                                                                      SELF.seq := LEFT.seq; 
                                                                      SELF.did := LEFT.inquiredDID;
                                                                      
                                                                      SELF.historyDate := LEFT.historyDate;
                                                                      
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
                                                                      SELF.ownerNames := RIGHT.propertyOwners;
                                                                      SELF.inquiredOwned := RIGHT.inquiredOwned;
                                                                      SELF.spouseOwned := RIGHT.spouseOwned;
                                                                      SELF.ownerOccupied := RIGHT.ownerOccupied;
                                                                      
                                                                      SELF := [];)); 


    ownedPropDetails := DueDiligence.reportSharedProperty(listOfProperties);

    
    //check to see if the property is vacant
    checkVacancy := JOIN(ownedPropDetails, Advo.Key_Addr1_history,  
                          LEFT.zip5 != '' AND 
                          LEFT.prim_range != '' AND
                          KEYED(LEFT.zip5 = RIGHT.zip) AND
                          KEYED(LEFT.prim_range = RIGHT.prim_range) AND
                          KEYED(LEFT.prim_name = RIGHT.prim_name) AND
                          KEYED(LEFT.addr_suffix = RIGHT.addr_suffix) AND
                          KEYED(LEFT.predir = RIGHT.predir) AND
                          KEYED(LEFT.postdir = RIGHT.postdir) AND
                          KEYED(LEFT.sec_range = RIGHT.sec_range), 
                          TRANSFORM({DueDiligence.LayoutsInternalReport.SharedPropertyLayout, STRING1 vacantIndicator, UNSIGNED advoDateFirstSeen},
                                      SELF.vacantIndicator := RIGHT.Address_Vacancy_Indicator,
                                      SELF.advoDateFirstSeen := (UNSIGNED)IF(RIGHT.date_first_seen = DueDiligence.Constants.EMPTY, RIGHT.date_vendor_first_reported, RIGHT.date_first_seen);
                                      SELF := LEFT,
                                      SELF := []), LEFT outer,
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));
                          
                          
       
    //Clean dates used in logic so all comparisions flow through consistently
    vacancyCleanDate := DueDiligence.Common.CleanDatasetDateFields(checkVacancy, 'advoDateFirstSeen');
    
    // Filter out records after our history date.
    vacancyFilt := DueDiligence.Common.FilterRecordsSingleDate(vacancyCleanDate, advoDateFirstSeen);
    
    //Rollup the data was we want the most recent row (if there is more than 1 row per address)
    recentUniqueVacancy := DEDUP(SORT(vacancyFilt, seq, did, prim_range, prim_name[1..8], zip5, -advoDateFirstSeen), seq, did, prim_range, prim_name[1..8], zip5);
    
    
    //add vacancy indicator to property details
    addVacancy := JOIN(ownedPropDetails, recentUniqueVacancy,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.did = RIGHT.did AND
                        LEFT.prim_range = RIGHT.prim_range AND
                        LEFT.prim_name[1..8] = RIGHT.prim_name[1..8] AND
                        LEFT.zip5 = RIGHT.zip5,
                        TRANSFORM(DueDiligence.LayoutsInternalReport.SharedPropertyLayout,
                                  SELF.vacancyIndicator := IF(RIGHT.vacantIndicator != DueDiligence.Constants.EMPTY, RIGHT.vacantIndicator, DueDiligence.Constants.UNKNOWN);
                                  SELF := LEFT;),
                        LEFT OUTER,
                        ATMOST(1));
    
    
    
    
    //transform data to the report layout
    propertyReport := PROJECT(addVacancy, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DATASET(iesp.duediligencepersonreport.t_DDRPersonProperty) indProperties},
                                                          SELF.seq := LEFT.seq;
                                                          SELF.did := LEFT.did;
                                                          
                                                          SELF.indProperties := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonProperty,
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
                                                                                                    
                                                                                                    SELF.Owners := PROJECT(LEFT.ownerNames, TRANSFORM(iesp.duediligenceshared.t_DDRPersonNameWithLexID,
                                                                                                                                                      SELF.LexID := (STRING)LEFT.DID;
                                                                                                                                                      SELF.Name := iesp.ECL2ESP.SetName(LEFT.firstName, LEFT.middleName, LEFT.lastName, LEFT.suffix, DueDiligence.Constants.EMPTY)));
                                                                                                                                        

                                                                                                    SELF.Vacant := LEFT.vacancyIndicator = DueDiligence.Constants.YES;
                                                                                                    SELF.SubjectOwned := LEFT.inquiredOwned;
                                                                                                    SELF.SpouseOwned := LEFT.spouseOwned;
                                                                                                    
                                                                                                    SELF.CountyCityRisk.CountyName := LEFT.countyName;
                                                                                                    SELF.CountyCityRisk.BordersForeignJurisdiction := LEFT.CountyBordersForgeinJur;
                                                                                                    SELF.CountyCityRisk.BordersOceanWithin150ForeignJurisdiction := LEFT.CountyBorderOceanForgJur; 
                                                                                                    SELF.CountyCityRisk.AccessThroughBorderStation := LEFT.CityBorderStation; 
                                                                                                    SELF.CountyCityRisk.AccessThroughRailCrossing := LEFT.CityRailStation;
                                                                                                    SELF.CountyCityRisk.AccessThroughFerryCrossing := LEFT.CityFerryCrossing;
                                                                                                    
                                                                                                    SELF.AreaRisk.Hifca := LEFT.HIFCA;
                                                                                                    SELF.AreaRisk.Hidta := LEFT.HIDTA; 
                                                                                                    SELF.AreaRisk.CrimeIndex := IF(LEFT.CountyHasHighCrimeIndex, 'HIGH', 'LOW'); 
                                                                                                    
                                                                                                    SELF.OwnershipType.SubjectOwned := LEFT.inquiredOwned;
                                                                                                    SELF.OwnershipType.SpouseOwned := LEFT.spouseOwned;
                                                                                                    SELF.OwnershipType.Owners := PROJECT(LEFT.ownerNames, TRANSFORM(iesp.duediligenceshared.t_DDRPersonNameWithLexID,
                                                                                                                                                                    SELF.LexID := (STRING)LEFT.DID;
                                                                                                                                                                    SELF.Name := iesp.ECL2ESP.SetName(LEFT.firstName, LEFT.middleName, LEFT.lastName, LEFT.suffix, DueDiligence.Constants.EMPTY)));
                                                                                                    
                                                                                                    SELF := [];)]);
                                                            
                                                          SELF :=  [];));
    
    
    rollProperties := ROLLUP(SORT(propertyReport, seq, did),
                              LEFT.seq = RIGHT.seq AND
                              LEFT.did = RIGHT.did,
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.indProperties := LEFT.indProperties + RIGHT.indProperties;
                                        SELF := LEFT;));
    
    
    
    // add formatted report data to the report
    addPropertyToReport := JOIN(inData, rollProperties,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.inquiredDID = RIGHT.did,
                                TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                          SELF.PersonReport.PersonAttributeDetails.Economic.Property.PropertyCurrentCount := LEFT.ownedPropCount;
                                          SELF.PersonReport.PersonAttributeDetails.Economic.Property.TaxAssessedValue := LEFT.totalassesedvalue;
                                          SELF.PersonReport.PersonAttributeDetails.Economic.Property.Properties := RIGHT.indProperties;
                                          SELF := LEFT;),
                                LEFT OUTER,
                                ATMOST(1));




    // OUTPUT(inData, NAMED('inData'));
    // OUTPUT(listOfProperties, NAMED('listOfProperties'));
    // OUTPUT(ownedPropDetails, NAMED('ownedPropDetails'));
    // OUTPUT(checkVacancy, NAMED('checkVacancy'));
    // OUTPUT(vacancyCleanDate, NAMED('vacancyCleanDate'));
    // OUTPUT(vacancyFilt, NAMED('vacancyFilt'));
    // OUTPUT(recentUniqueVacancy, NAMED('recentUniqueVacancy'));
    // OUTPUT(addVacancy, NAMED('addVacancy'));
    // OUTPUT(propertyReport, NAMED('propertyReport'));
    // OUTPUT(rollProperties, NAMED('rollProperties'));
    // OUTPUT(addPropertyToReport, NAMED('addPropertyToReport'));


    RETURN addPropertyToReport;
END;
IMPORT DueDiligence, iesp, Risk_Indicators, Seed_Files, STD;


//Since these test seeds are for XML queries - making assumptions 
//regarding the additionalInfo parm that can only ever have 1 record come in
//from the inData dataset
EXPORT TestSeedFunction(DATASET(DueDiligence.Layouts.Input) inData, STRING testDataTableName, iesp.duediligenceshared.t_DDRAttributesAdditionalInfo additionalInfo) := MODULE

    //determine which product is calling the test seeds
    //to determine which layout needs to be returned
    SHARED businessResponseLayout := iesp.duediligencebusinessreport.t_DueDiligenceBusinessReportResponse;
    SHARED personResponseLayout := iesp.duediligencepersonreport.t_DueDiligencePersonReportResponse;
    SHARED attributeResponseLayout := iesp.duediligenceattributes.t_DueDiligenceAttributesResponse;
    
    
    SHARED getHash(STRING firstName, STRING lastName, STRING ssn, STRING companyName, STRING fein, STRING zip, STRING phone) := FUNCTION
        RETURN Seed_Files.Hash_InstantID(STD.Str.ToUpperCase(TRIM(firstName)),    //first name - not used for business products
                                         STD.Str.ToUpperCase(TRIM(lastName)),     //last name - not used for business products
                                         STD.Str.ToUpperCase(TRIM(ssn)),  //ssn - not used for business products
                                         STD.Str.ToUpperCase(TRIM(fein)),  //fein - not used for person products
                                         STD.Str.ToUpperCase(TRIM(zip)),   // zip
                                         STD.Str.ToUpperCase(TRIM(phone)),     // phone
                                         STD.Str.ToUpperCase(TRIM(companyName))); //company_name - not used for person products
    END;
    

    SHARED getKeys(layout, indvOrBus) := FUNCTIONMACRO
        
        workingLayout := RECORD
          STRING20 datasetName;
          DATA16 hashkey;
          UNSIGNED4 historyDate;
          layout;
        END;  
        
        RETURN PROJECT(inData, TRANSFORM(workingLayout,
                                          SELF.datasetName := testDataTableName;
                                          
                                          #EXPAND(IF(indvOrBus = DueDiligence.Constants.INDIVIDUAL,
                                                      'SELF.hashKey := getHash(LEFT.rawPerson.name.firstName, LEFT.rawPerson.name.lastName, LEFT.rawPerson.taxID,' +
                                                                                'Risk_Indicators.nullstring, Risk_Indicators.nullstring,' +
                                                                                'LEFT.rawPerson.address.zip, LEFT.rawPerson.phone);',
                                                      DueDiligence.Constants.EMPTY))
                                                     
                                                     
                                                     
                                          #EXPAND(IF(indvOrBus = DueDiligence.Constants.BUSINESS,
                                                      'SELF.hashKey := getHash(Risk_Indicators.nullstring, Risk_Indicators.nullstring, Risk_Indicators.nullstring,' +
                                                                                'LEFT.rawBusiness.companyName, LEFT.rawBusiness.taxID,' +
                                                                                'LEFT.rawBusiness.address.zip, LEFT.rawBusiness.phone);',
                                                      DueDiligence.Constants.EMPTY))
                                              
                                                      
                                                      
                                          SELF.historyDate := LEFT.historyDateYYYYMMDD;
                                          SELF.result.AdditionalInput := additionalInfo;
                                          
                                                                                              
                                          
                                          //populate input echo for a person
                                          #EXPAND(IF(indvOrBus = DueDiligence.Constants.INDIVIDUAL,
                                                      'SELF.result.inputEcho.person.lexID := (STRING)LEFT.rawPerson.lexID;' + 
                                                      'SELF.result.inputEcho.person.phone := LEFT.rawPerson.phone;' +
                                                      'SELF.result.inputEcho.person.ssn := LEFT.rawPerson.taxID;' +
                                                      'SELF.result.inputEcho.person.dob := iesp.ECL2ESP.toDatestring8(LEFT.rawPerson.dob);' +
                                             
                                                      'SELF.result.inputEcho.person.address := iesp.ECL2ESP.SetAddress(LEFT.rawPerson.address.prim_name,' +
                                                                                                                       'LEFT.rawPerson.address.prim_range,' + 
                                                                                                                       'LEFT.rawPerson.address.predir,' + 
                                                                                                                       'LEFT.rawPerson.address.postdir,' + 
                                                                                                                       'LEFT.rawPerson.address.addr_suffix,' + 
                                                                                                                       'LEFT.rawPerson.address.unit_desig,' + 
                                                                                                                       'LEFT.rawPerson.address.sec_range,' + 
                                                                                                                       'LEFT.rawPerson.address.city,' + 
                                                                                                                       'LEFT.rawPerson.address.state,' + 
                                                                                                                       'LEFT.rawPerson.address.zip,' + 
                                                                                                                       'LEFT.rawPerson.address.zip4,' + 
                                                                                                                       'DueDiligence.Constants.EMPTY,' + 
                                                                                                                       'DueDiligence.Constants.EMPTY,' + 
                                                                                                                       'LEFT.rawPerson.address.streetAddress1,' + 
                                                                                                                       'LEFT.rawPerson.address.streetAddress2);' +
                                                      
                                                      'SELF.result.inputEcho.person.name := iesp.ECL2ESP.SetName(LEFT.rawPerson.name.firstName,' +
                                                                                                                 'LEFT.rawPerson.name.middleName,' + 
                                                                                                                 'LEFT.rawPerson.name.lastName,' + 
                                                                                                                 'LEFT.rawPerson.name.suffix,' + 
                                                                                                                 'DueDiligence.Constants.EMPTY,' + 
                                                                                                                 'LEFT.rawPerson.name.fullName);',
                                                                                                                 
                                                      DueDiligence.Constants.EMPTY))
                                                      
                                                      
                                          //populate input echo for a business
                                          #EXPAND(IF(indvOrBus = DueDiligence.Constants.BUSINESS,
                                                      'SELF.result.inputEcho.business.lexID := (STRING)LEFT.rawBusiness.lexID;' + 
                                                      'SELF.result.inputEcho.business.phone := LEFT.rawBusiness.phone;' +
                                                      'SELF.result.inputEcho.business.fein := LEFT.rawBusiness.taxID;' +
                                                      'SELF.result.inputEcho.business.companyName := LEFT.rawBusiness.companyName;' +
                                                      'SELF.result.inputEcho.business.alternateCompanyName := LEFT.rawBusiness.altCompanyName;' +
                                                      
                                                      'SELF.result.inputEcho.business.address := iesp.ECL2ESP.SetAddress(LEFT.rawBusiness.address.prim_name,' +
                                                                                                                       'LEFT.rawBusiness.address.prim_range,' + 
                                                                                                                       'LEFT.rawBusiness.address.predir,' + 
                                                                                                                       'LEFT.rawBusiness.address.postdir,' + 
                                                                                                                       'LEFT.rawBusiness.address.addr_suffix,' + 
                                                                                                                       'LEFT.rawBusiness.address.unit_desig,' + 
                                                                                                                       'LEFT.rawBusiness.address.sec_range,' + 
                                                                                                                       'LEFT.rawBusiness.address.city,' + 
                                                                                                                       'LEFT.rawBusiness.address.state,' + 
                                                                                                                       'LEFT.rawBusiness.address.zip,' + 
                                                                                                                       'LEFT.rawBusiness.address.zip4,' + 
                                                                                                                       'DueDiligence.Constants.EMPTY,' + 
                                                                                                                       'DueDiligence.Constants.EMPTY,' + 
                                                                                                                       'LEFT.rawBusiness.address.streetAddress1,' + 
                                                                                                                       'LEFT.rawBusiness.address.streetAddress2);',
                                                                                                                 
                                                      DueDiligence.Constants.EMPTY))
                                                      
                                                      
                                                      
                                          SELF := []));
    ENDMACRO;
    
    
    


    EXPORT GetPersonReportSeeds := FUNCTION
        
        inRecs := getKeys(personResponseLayout, DueDiligence.Constants.INDIVIDUAL);

        
        //================================
        // Person Information Section
        //================================
        bestInfo := JOIN(inRecs, Seed_Files.keys_DueDiligencePersonReport.BestSection,
                          KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                          KEYED(RIGHT.hashValue = LEFT.hashkey),
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.result.personReport.personInformation.bestName := iesp.ECL2ESP.SetName(RIGHT.firstName, RIGHT.middleName, 
                                                                                                                RIGHT.lastName, RIGHT.suffix, 
                                                                                                                RIGHT.prefix, RIGHT.fullName);
                                                                                                                
                                    SELF.result.personReport.personInformation.bestAddress := iesp.ECL2ESP.SetAddress(RIGHT.streetName, RIGHT.streetNumber,
                                                                                                                      RIGHT.streetPreDirection, RIGHT.streetPostDirection,
                                                                                                                      RIGHT.streetSuffix, RIGHT.unitDesignation,
                                                                                                                      RIGHT.unitNumber, RIGHT.city,
                                                                                                                      RIGHT.state,  RIGHT.zip5, RIGHT.zip4,
                                                                                                                      RIGHT.county, RIGHT.postalCode,
                                                                                                                      RIGHT.streetAddress1, RIGHT.streetAddress2,
                                                                                                                      RIGHT.stateCityZip);
                                    SELF.result.personReport.personInformation.bestAddressType := RIGHT.addressType;
                                    SELF.result.personReport.personInformation.bestSSN := RIGHT.ssn;
                                    SELF.result.personReport.personInformation.bestDOB := iesp.ECL2ESP.toDate(RIGHT.dob);
                                    SELF.result.personReport.personInformation.bestAge := RIGHT.age;
                                    SELF.result.personReport.personInformation.bestPhone := RIGHT.phone;
                                    
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                          

        inputInfo := JOIN(bestInfo, Seed_Files.keys_DueDiligencePersonReport.PersonInformationSection,
                          KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                          KEYED(RIGHT.hashValue = LEFT.hashkey),
                          TRANSFORM(RECORDOF(LEFT),
                                    
                                    seedExists := LEFT.hashKey = RIGHT.hashValue;
                                    
                                    name := iesp.ECL2ESP.SetName(RIGHT.firstName,
                                                                  RIGHT.middleName,
                                                                  RIGHT.lastName,
                                                                  RIGHT.suffix,
                                                                  DueDiligence.Constants.EMPTY,
                                                                  RIGHT.fullName);
                                                                  
                                    address := iesp.ECL2ESP.SetAddress(RIGHT.streetName,
                                                                       RIGHT.streetNumber, 
                                                                       RIGHT.streetPreDirection,
                                                                       RIGHT.streetPostDirection,
                                                                       RIGHT.streetSuffix,
                                                                       RIGHT.unitDesignation,
                                                                       RIGHT.unitNumber,
                                                                       RIGHT.city,
                                                                       RIGHT.state,
                                                                       RIGHT.zip5,
                                                                       RIGHT.zip4,
                                                                       DueDiligence.Constants.EMPTY,
                                                                       DueDiligence.Constants.EMPTY,
                                                                       RIGHT.streetAddress1,
                                                                       RIGHT.streetAddress2);
                                    
                                    SELF.result.inputEcho.person.lexID := IF(seedExists, (STRING)RIGHT.lexID, LEFT.result.inputEcho.person.lexID);
                                    SELF.result.inputEcho.person.phone := IF(seedExists, RIGHT.phone, LEFT.result.inputEcho.person.phone);
                                    SELF.result.inputEcho.person.ssn := IF(seedExists, RIGHT.ssn, LEFT.result.inputEcho.person.ssn);
                                    SELF.result.inputEcho.person.dob := IF(seedExists, iesp.ECL2ESP.toDate(RIGHT.dob), LEFT.result.inputEcho.person.dob);
                                    SELF.result.inputEcho.person.address := IF(seedExists, address, LEFT.result.inputEcho.person.address);                                             
                                    SELF.result.inputEcho.person.name := IF(seedExists, name, LEFT.result.inputEcho.person.name);
                          
                          
                          
                                    SELF.result.personReport.personInformation.lexID := (STRING)RIGHT.lexID; 
                                    SELF.result.personReport.personInformation.inputName := name;
                                    SELF.result.personReport.personInformation.inputAddress := address;
                                    SELF.result.personReport.personInformation.inputAddressType := RIGHT.addressType;
                                    SELF.result.personReport.personInformation.inputSSN := RIGHT.ssn;
                                    SELF.result.personReport.personInformation.inputPhone := RIGHT.phone;
                                    
                                    SELF.result.personReport.personInformation.inputDOB := iesp.ECL2ESP.toDate(RIGHT.dob);
                                    SELF.result.personReport.personInformation.inputAge := RIGHT.age;
                                    
                                    SELF := LEFT;),
                          LEFT OUTER, 
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                            
        //================================
        // Legal Section
        //================================
        legalInfo := JOIN(inputInfo, Seed_Files.keys_DueDiligencePersonReport.LegalSection,
                          KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                          KEYED(RIGHT.hashValue = LEFT.hashkey),
                          TRANSFORM(RECORDOF(LEFT),
                          
                                    peeps := PROJECT(RIGHT, TRANSFORM(iesp.duediligenceshared.t_DDRLegalEventIndividual,
                                                                      SELF.name := iesp.ECL2ESP.SetName(LEFT.firstName, LEFT.middleName, 
                                                                                                        LEFT.lastName, LEFT.suffix, 
                                                                                                        LEFT.prefix, LEFT.fullName);
                                                                                                        
                                                                      SELF.address := iesp.ECL2ESP.SetAddress(LEFT.streetName, LEFT.streetNumber,
                                                                                                              LEFT.streetPreDirection, LEFT.streetPostDirection,
                                                                                                              LEFT.streetSuffix, LEFT.unitDesignation,
                                                                                                              LEFT.unitNumber, LEFT.city,
                                                                                                              LEFT.state,  LEFT.zip5, LEFT.zip4,
                                                                                                              LEFT.county, LEFT.postalCode,
                                                                                                              LEFT.streetAddress1, LEFT.streetAddress2,
                                                                                                              LEFT.stateCityZip);
                                                                      SELF.ssn := LEFT.ssn;
                                                                      SELF.dob := iesp.ECL2ESP.toDate(LEFT.dob);
                                                                      SELF.lexID := (STRING)LEFT.lexID;
                                                                      SELF := [];));
                                                                      
                                    badBoys := DueDiligence.TestSeeds.TestSeedFunctionHelperPerson.GetCriminalDS(RIGHT);
                                    
                                    SELF.result.personReport.personAttributeDetails.legal.possibleLegalEvents := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonCriminalEvents,
                                                                                                                                    SELF.personInfo := peeps;
                                                                                                                                    SELF.criminals := badBoys;)]);
                                    SELF := LEFT;),
                          LEFT OUTER, 
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                          
        //================================
        // Economic Section - Income
        //================================
        estimatedIncome := JOIN(legalInfo, Seed_Files.keys_DueDiligencePersonReport.EconomicIncomeSection,
                                KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                                KEYED(RIGHT.hashValue = LEFT.hashkey),
                                TRANSFORM(RECORDOF(LEFT),
                                          SELF.result.personReport.personAttributeDetails.economic.estimatedIncome := RIGHT.estimatedIncome;
                                          SELF := LEFT;),
                                LEFT OUTER, 
                                ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                          
        //================================
        // Economic Section - property
        //================================
        property := JOIN(estimatedIncome, Seed_Files.keys_DueDiligencePersonReport.EconomicPropertySection,
                          KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                          KEYED(RIGHT.hashValue = LEFT.hashkey),
                          TRANSFORM(RECORDOF(LEFT),
                          
                                    propertyAddrs := DueDiligence.TestSeeds.TestSeedFunctionHelperPerson.GetPropertiesDS(RIGHT);
                                    
                                    props := PROJECT(RIGHT, TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonPropertyOwnership,
                                                                      SELF.propertyCurrentcount := COUNT(propertyAddrs);
                                                                      SELF.taxAssessedValue := LEFT.taxAssessedValue;
                                                                      SELF.properties := propertyAddrs;
                                                                      SELF := [];));
                                    
                                    SELF.result.personReport.personAttributeDetails.economic.property := props;
                                    SELF := LEFT;),
                          LEFT OUTER, 
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                          
        //================================
        // Economic Section - vehicle
        //================================
        vehicle := JOIN(property, Seed_Files.keys_DueDiligencePersonReport.EconomicVehicleSection,
                        KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                        KEYED(RIGHT.hashValue = LEFT.hashkey),
                        TRANSFORM(RECORDOF(LEFT),
                                  SELF.result.personReport.personAttributeDetails.economic.vehicle.motorVehicles := DueDiligence.TestSeeds.TestSeedFunctionHelperPerson.GetVehiclesDS(RIGHT);
                                  SELF := LEFT;),
                        LEFT OUTER, 
                        ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                          
        //================================
        // Economic Section - watercraft
        //================================
        watercraft := JOIN(vehicle, Seed_Files.keys_DueDiligencePersonReport.EconomicWatercraftSection,
                            KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                            KEYED(RIGHT.hashValue = LEFT.hashkey),
                            TRANSFORM(RECORDOF(LEFT),
                                      SELF.result.personReport.personAttributeDetails.economic.watercraft.watercrafts := DueDiligence.TestSeeds.TestSeedFunctionHelperPerson.GetWatercraftDS(RIGHT);
                                      SELF := LEFT;),
                            LEFT OUTER, 
                            ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                          
        //================================
        // Economic Section - aircraft
        //================================
        aircraft := JOIN(watercraft, Seed_Files.keys_DueDiligencePersonReport.EconomicAircraftSection,
                          KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                          KEYED(RIGHT.hashValue = LEFT.hashkey),
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.result.personReport.personAttributeDetails.economic.aircraft.aircrafts := DueDiligence.TestSeeds.TestSeedFunctionHelperPerson.GetAircraftDS(RIGHT);
                                    SELF := LEFT;),
                          LEFT OUTER, 
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                          
        //================================
        // Professional Network Section
        //================================
        license := JOIN(aircraft, Seed_Files.keys_DueDiligencePersonReport.ProfessionalNetworkSection,
                          KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                          KEYED(RIGHT.hashValue = LEFT.hashkey),
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.result.personReport.personAttributeDetails.professionalNetwork.professionalLicenses := DueDiligence.TestSeeds.TestSeedFunctionHelperPerson.GetProfLicensesDS(RIGHT);
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                          
        //================================
        // Business Associations Section
        //================================
        busAssoc := JOIN(license, Seed_Files.keys_DueDiligencePersonReport.BusinessAssociationSection,
                          KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                          KEYED(RIGHT.hashValue = LEFT.hashkey),
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.result.personReport.personAttributeDetails.businessAssocation.associations := DueDiligence.TestSeeds.TestSeedFunctionHelperPerson.GetBusAssociationsDS(RIGHT);
                                    SELF := LEFT;),
                          LEFT OUTER, 
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                          
        //================================
        // Identity Section - Age
        //================================
        estimatedAge := JOIN(busAssoc, Seed_Files.keys_DueDiligencePersonReport.IdentityAgeSection,
                              KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                              KEYED(RIGHT.hashValue = LEFT.hashkey),
                              TRANSFORM(RECORDOF(LEFT),
                                        // SELF.result.personReport.personAttributeDetails.identity.estimatedAge := RIGHT.estimatedAge;
                                        SELF.result.personReport.personAttributeDetails.identitiy.estimatedAge := RIGHT.estimatedAge;
                                        SELF := LEFT;),
                              LEFT OUTER, 
                              ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                          
        //================================
        // Attributes Section
        //================================
        attributes := JOIN(estimatedAge, Seed_Files.keys_DueDiligencePersonReport.AttributesSection,
                              KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                              KEYED(RIGHT.hashValue = LEFT.hashkey),
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.result.AttributeGroup := IF(RIGHT.perLexID > 0, 
                                                                            DueDiligence.TestSeeds.TestSeedFunctionHelperPerson.GetPersonAttributes(RIGHT),
                                                                            DueDiligence.TestSeeds.TestSeedFunctionHelperPerson.GetPersonAttributesNotFound);
                                        SELF.result.PersonLexIDMatch := (UNSIGNED)RIGHT.perLexIDMatch;
                                        SELF.result.UniqueID := (STRING)RIGHT.perLexID;
                                        SELF := LEFT;),
                              LEFT OUTER, 
                              ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                        
        RETURN PROJECT(attributes, TRANSFORM(personResponseLayout, SELF := LEFT;));
    END;
    
    
    EXPORT GetPersonAttributeSeeds := FUNCTION
    
        inRecs := getKeys(attributeResponseLayout, DueDiligence.Constants.INDIVIDUAL);
        
        inputInfo := JOIN(inRecs, Seed_Files.keys_DueDiligencePersonReport.PersonInformationSection,
                          KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                          KEYED(RIGHT.hashValue = LEFT.hashkey),
                          TRANSFORM(RECORDOF(LEFT),
                                    
                                    seedExists := LEFT.hashKey = RIGHT.hashValue;
                                    
                                    name := iesp.ECL2ESP.SetName(RIGHT.firstName,
                                                                  RIGHT.middleName,
                                                                  RIGHT.lastName,
                                                                  RIGHT.suffix,
                                                                  DueDiligence.Constants.EMPTY,
                                                                  RIGHT.fullName);
                                                                  
                                    address := iesp.ECL2ESP.SetAddress(RIGHT.streetName,
                                                                       RIGHT.streetNumber, 
                                                                       RIGHT.streetPreDirection,
                                                                       RIGHT.streetPostDirection,
                                                                       RIGHT.streetSuffix,
                                                                       RIGHT.unitDesignation,
                                                                       RIGHT.unitNumber,
                                                                       RIGHT.city,
                                                                       RIGHT.state,
                                                                       RIGHT.zip5,
                                                                       RIGHT.zip4,
                                                                       DueDiligence.Constants.EMPTY,
                                                                       DueDiligence.Constants.EMPTY,
                                                                       RIGHT.streetAddress1,
                                                                       RIGHT.streetAddress2);
                                    
                                    SELF.result.inputEcho.person.lexID := IF(seedExists, (STRING)RIGHT.lexID, LEFT.result.inputEcho.person.lexID);
                                    SELF.result.inputEcho.person.phone := IF(seedExists, RIGHT.phone, LEFT.result.inputEcho.person.phone);
                                    SELF.result.inputEcho.person.ssn := IF(seedExists, RIGHT.ssn, LEFT.result.inputEcho.person.ssn);
                                    SELF.result.inputEcho.person.dob := IF(seedExists, iesp.ECL2ESP.toDate(RIGHT.dob), LEFT.result.inputEcho.person.dob);
                                    SELF.result.inputEcho.person.address := IF(seedExists, address, LEFT.result.inputEcho.person.address);                                             
                                    SELF.result.inputEcho.person.name := IF(seedExists, name, LEFT.result.inputEcho.person.name);
                                    
                                    SELF := LEFT;),
                          LEFT OUTER, 
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
        
        //================================
        // Attributes Section
        //================================
        attributes := JOIN(inputInfo, Seed_Files.keys_DueDiligencePersonReport.AttributesSection,
                              KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                              KEYED(RIGHT.hashValue = LEFT.hashkey),
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.result.AttributeGroup := IF(RIGHT.perLexID > 0, 
                                                                            DueDiligence.TestSeeds.TestSeedFunctionHelperPerson.GetPersonAttributes(RIGHT),
                                                                            DueDiligence.TestSeeds.TestSeedFunctionHelperPerson.GetPersonAttributesNotFound);
                                        SELF.result.PersonLexIDMatch := (UNSIGNED)RIGHT.perLexIDMatch;
                                        SELF.result.UniqueID := (STRING)RIGHT.perLexID;
                                        SELF := LEFT;),
                              LEFT OUTER, 
                              ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                        
        RETURN PROJECT(attributes, TRANSFORM(attributeResponseLayout, SELF := LEFT;));
    END;
    
    
    EXPORT GetBusinessAttributeSeeds := FUNCTION
        inRecs := getKeys(attributeResponseLayout, DueDiligence.Constants.BUSINESS);
                
        //================================
        // Input Echo Section
        //================================
        inputEcho := JOIN(inRecs, Seed_Files.keys_DueDiligenceBusinessReport.InputEchoSection,
                            KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                            KEYED(RIGHT.hashValue = LEFT.hashkey),
                            TRANSFORM(RECORDOF(LEFT),
                                      
                                      seedFound := RIGHT.hashValue = LEFT.hashkey;
                                      
                                      SELF.result.inputEcho.business.lexID := IF(seedFound, RIGHT.lexID, LEFT.result.inputEcho.business.lexID);
                                      SELF.result.inputEcho.business.phone := IF(seedFound, RIGHT.phone, LEFT.result.inputEcho.business.phone);
                                      SELF.result.inputEcho.business.address := IF(seedFound, iesp.ECL2ESP.SetAddress(RIGHT.streetName,
                                                                                                                       RIGHT.streetNumber, 
                                                                                                                       RIGHT.streetPreDirection,
                                                                                                                       RIGHT.streetPostDirection,
                                                                                                                       RIGHT.streetSuffix,
                                                                                                                       RIGHT.unitDesignation,
                                                                                                                       RIGHT.unitNumber,
                                                                                                                       RIGHT.city,
                                                                                                                       RIGHT.state,
                                                                                                                       RIGHT.zip5,
                                                                                                                       RIGHT.zip4,
                                                                                                                       DueDiligence.Constants.EMPTY,
                                                                                                                       DueDiligence.Constants.EMPTY,
                                                                                                                       RIGHT.streetAddress1,
                                                                                                                       RIGHT.streetAddress2),
                                                                                              LEFT.result.inputEcho.business.address);
                                      SELF.result.inputEcho.business.companyName := IF(seedFound, RIGHT.companyName, LEFT.result.inputEcho.business.companyName);
                                      SELF.result.inputEcho.business.alternateCompanyName := IF(seedFound, RIGHT.altCompanyName, LEFT.result.inputEcho.business.alternateCompanyName);
                                      SELF.result.inputEcho.business.fein := IF(seedFound, RIGHT.fein, LEFT.result.inputEcho.business.fein);
                                      SELF := LEFT;),
                            LEFT OUTER, 
                            ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
        
        //================================
        // Attributes Section
        //================================
        attributes := JOIN(inputEcho, Seed_Files.keys_DueDiligenceBusinessReport.AttributesSection,
                              KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                              KEYED(RIGHT.hashValue = LEFT.hashkey),
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.result.AttributeGroup := IF(RIGHT.busLexID <> DueDiligence.Constants.EMPTY, 
                                                                            DueDiligence.TestSeeds.TestSeedFunctionHelperBusiness.GetBusinessAttributes(RIGHT),
                                                                            DueDiligence.TestSeeds.TestSeedFunctionHelperBusiness.GetBusinessAttributesNotFound);
                                        SELF.result.BusinessLexIDMatch := (UNSIGNED)RIGHT.busLexIDMatch;
                                        SELF.result.BusinessID := RIGHT.busLexID;
                                        SELF := LEFT;),
                              LEFT OUTER, 
                              ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                        
        RETURN PROJECT(attributes, TRANSFORM(attributeResponseLayout, SELF := LEFT;));
    END;
    
    
    EXPORT GetCitizenshipSeeds := FUNCTION
        
        inRecs := getKeys(attributeResponseLayout, DueDiligence.Constants.INDIVIDUAL);
        
        inputInfo := JOIN(inRecs, Seed_Files.keys_Citizenship.InputEchoSection,
                          KEYED(LEFT.datasetName = RIGHT.inDatasetName) AND
                          KEYED(LEFT.hashkey = RIGHT.hashValue),
                          TRANSFORM(RECORDOF(LEFT),
                                    
                                    seedExists := RIGHT.hashValue = LEFT.hashkey;
                                    
                                    name := iesp.ECL2ESP.SetName(RIGHT.firstName,
                                                                  RIGHT.middleName,
                                                                  RIGHT.lastName,
                                                                  RIGHT.suffix,
                                                                  DueDiligence.Constants.EMPTY,
                                                                  RIGHT.fullName);
                                                                  
                                    address := iesp.ECL2ESP.SetAddress(RIGHT.streetName,
                                                                       RIGHT.streetNumber, 
                                                                       RIGHT.streetPreDirection,
                                                                       RIGHT.streetPostDirection,
                                                                       RIGHT.streetSuffix,
                                                                       RIGHT.unitDesignation,
                                                                       RIGHT.unitNumber,
                                                                       RIGHT.city,
                                                                       RIGHT.state,
                                                                       RIGHT.zip5,
                                                                       RIGHT.zip4,
                                                                       DueDiligence.Constants.EMPTY,
                                                                       DueDiligence.Constants.EMPTY,
                                                                       RIGHT.streetAddress1,
                                                                       RIGHT.streetAddress2);
                                                                       
                                    
                                    SELF.result.inputEcho.person.lexID := IF(seedExists, (STRING)RIGHT.lexID, LEFT.result.inputEcho.person.lexID);
                                    SELF.result.inputEcho.person.phone := IF(seedExists, RIGHT.phone, LEFT.result.inputEcho.person.phone);
                                    SELF.result.inputEcho.person.ssn := IF(seedExists, RIGHT.ssn, LEFT.result.inputEcho.person.ssn);
                                    SELF.result.inputEcho.person.dob := IF(seedExists, iesp.ECL2ESP.toDate(RIGHT.dob), LEFT.result.inputEcho.person.dob);
                                    SELF.result.inputEcho.person.address := IF(seedExists, address, LEFT.result.inputEcho.person.address);                                             
                                    SELF.result.inputEcho.person.name := IF(seedExists, name, LEFT.result.inputEcho.person.name);
                                    SELF.result.inputEcho.person.citizenship.citizenshipModelName := IF(seedExists, RIGHT.modelName, inData[1].modelName);
                                    SELF.result.inputEcho.person.citizenship.phone2 := IF(seedExists, RIGHT.phone2, inData[1].phone2);
                                    SELF.result.inputEcho.person.citizenship.dlNumber := IF(seedExists, RIGHT.dlNumber, inData[1].dlNumber);
                                    SELF.result.inputEcho.person.citizenship.dlState := IF(seedExists, RIGHT.dlState, inData[1].dlState);
                                    SELF.result.inputEcho.person.citizenship.email := IF(seedExists, RIGHT.emailAddress, inData[1].email);
                                    
                                    SELF.result.inputEcho.productRequestType := inData[1].productRequested;
                                    
                                    SELF := LEFT;),
                          LEFT OUTER, 
                          ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                          
                          
        // ================================
        // Risk Indicators Section
        // ================================
        indicators := JOIN(inputInfo, Seed_Files.keys_Citizenship.RiskIndicatorsSection,
                              KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                              KEYED(RIGHT.hashValue = LEFT.hashkey),
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.result.CitizenshipResults := IF((INTEGER)RIGHT.citizenshipScore > 0, 
                                                                              DueDiligence.TestSeeds.TestSeedFunctionHelperCitizenship.GetRiskIndicators(RIGHT));
                                        SELF.result.UniqueID := RIGHT.lexID;
                                        SELF := LEFT;),
                              LEFT OUTER, 
                              ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
        

        RETURN PROJECT(indicators, TRANSFORM(attributeResponseLayout, SELF := LEFT;));
    END;

END;
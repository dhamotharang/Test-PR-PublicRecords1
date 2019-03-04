IMPORT DueDiligence, iesp, risk_indicators, Seed_Files, STD;

EXPORT TestSeedFunction(DATASET(DueDiligence.Layouts.Input) inData, STRING testDataTableName) := MODULE

    //determine which product is calling the test seeds
    //to determine which layou needs to be returned
    SHARED businessResponseLayout := iesp.duediligencebusinessreport.t_DueDiligenceBusinessReportResponse;
    SHARED personResponseLayout := iesp.duediligencepersonreport.t_DueDiligencePersonReportResponse;
    SHARED attributeResponseLayout := iesp.duediligenceattributes.t_DueDiligenceAttributesResponse;
    

    SHARED getKeys(layout, indvOrBus) := FUNCTIONMACRO
        
        workingLayout := RECORD
          STRING20 datasetName;
          DATA16 hashkey;
          UNSIGNED4 historyDate;
          layout;
        END;  
        
        RETURN PROJECT(inData, TRANSFORM(workingLayout,
                                          SELF.datasetName := testDataTableName;
                                          SELF.hashKey := Seed_Files.Hash_InstantID(StringLib.StringToUpperCase(TRIM(LEFT.individual.name.firstName)),   //first name
                                                                                    StringLib.StringToUpperCase(TRIM(LEFT.individual.name.lastName)),    //last name
                                                                                    StringLib.StringToUpperCase(TRIM(LEFT.individual.ssn)),              //ssn
                                                                                    risk_indicators.nullstring,    //fein - not used for person products
                                                                                    StringLib.StringToUpperCase(TRIM(LEFT.individual.address.zip5)),     // zip
                                                                                    StringLib.StringToUpperCase(TRIM(LEFT.individual.phone)),            // phone
                                                                                    risk_indicators.nullstring);   //company_name - not used for person products
                                                                                    
                                          SELF.historyDate := LEFT.historyDateYYYYMMDD;
                                           
                                          //populate input echo for a person
                                          #EXPAND(IF(indvOrBus = DueDiligence.Constants.INDIVIDUAL,
                                                      'SELF.result.inputEcho.person.lexID := LEFT.individual.lexID;' + 
                                                      'SELF.result.inputEcho.person.phone := LEFT.individual.phone;' +
                                                      'SELF.result.inputEcho.person.ssn := LEFT.individual.ssn;' +
                                                      'SELF.result.inputEcho.person.dob := iesp.ECL2ESP.toDatestring8(LEFT.individual.dob);' +
                                                      
                                                      'SELF.result.inputEcho.person.address := iesp.ECL2ESP.SetAddress(LEFT.individual.address.prim_name,' +
                                                                                                                       'LEFT.individual.address.prim_range,' + 
                                                                                                                       'LEFT.individual.address.predir,' + 
                                                                                                                       'LEFT.individual.address.postdir,' + 
                                                                                                                       'LEFT.individual.address.addr_suffix,' + 
                                                                                                                       'LEFT.individual.address.unit_desig,' + 
                                                                                                                       'LEFT.individual.address.sec_range,' + 
                                                                                                                       'LEFT.individual.address.city,' + 
                                                                                                                       'LEFT.individual.address.state,' + 
                                                                                                                       'LEFT.individual.address.zip5,' + 
                                                                                                                       'LEFT.individual.address.zip4,' + 
                                                                                                                       'DueDiligence.Constants.EMPTY,' + 
                                                                                                                       'DueDiligence.Constants.EMPTY,' + 
                                                                                                                       'LEFT.individual.address.streetAddress1,' + 
                                                                                                                       'LEFT.individual.address.streetAddress2);' +
                                                      
                                                      'SELF.result.inputEcho.person.name := iesp.ECL2ESP.SetName(LEFT.individual.name.firstName,' +
                                                                                                                 'LEFT.individual.name.middleName,' + 
                                                                                                                 'LEFT.individual.name.lastName,' + 
                                                                                                                 'LEFT.individual.name.suffix,' + 
                                                                                                                 'DueDiligence.Constants.EMPTY,' + 
                                                                                                                 'LEFT.individual.name.fullName);',
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
                          KEEP(2), 
                          ATMOST(1));
                          

        inputInfo := JOIN(bestInfo, Seed_Files.keys_DueDiligencePersonReport.PersonInformationSection,
                          KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                          KEYED(RIGHT.hashValue = LEFT.hashkey),
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.result.personReport.personInformation.lexID := (STRING)RIGHT.lexID; 
                                    SELF.result.personReport.personInformation.inputName := LEFT.result.inputEcho.person.name;
                                    SELF.result.personReport.personInformation.inputAddress := LEFT.result.inputEcho.person.address;
                                    SELF.result.personReport.personInformation.inputAddressType := RIGHT.addressType;
                                    SELF.result.personReport.personInformation.inputSSN := LEFT.result.inputEcho.person.ssn;
                                    SELF.result.personReport.personInformation.inputPhone := LEFT.result.inputEcho.person.phone;
                                    
                                    inputDOB := LEFT.result.inputEcho.person.dob;
                                    dobForCalc := iesp.ECL2ESP.DateToInteger(inputDOB);
                                                    
                                    validInputDOB := STD.Date.IsValidDate(dobForCalc);
                                    validHistDate := STD.Date.IsValidDate(LEFT.historyDate);
                                    
                                    SELF.result.personReport.personInformation.inputDOB := inputDOB;
                                    SELF.result.personReport.personInformation.inputAge := IF(validInputDOB AND validHistDate, STD.Date.YearsBetween(dobForCalc, LEFT.historyDate), 0);
                                    
                                    SELF := LEFT;),
                          LEFT OUTER, 
                          KEEP(2), 
                          ATMOST(1));
                            
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
                                                                      // SELF.ssn := LEFT.ssn;
                                                                      // SELF.dob := iesp.ECL2ESP.toDate(LEFT.dob);
                                                                      SELF.lexID := (STRING)LEFT.lexID;
                                                                      SELF := [];));
                                                                      
                                    badBoys := DueDiligence.TestSeeds.TestSeedFunctionHelperPerson.GetCriminalDS(RIGHT);
                                    
                                    SELF.result.personReport.personAttributeDetails.legal.possibleLegalEvents := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonCriminalEvents,
                                                                                                                                    SELF.personInfo := peeps;
                                                                                                                                    SELF.criminals := badBoys;)]);
                                    SELF := LEFT;),
                          LEFT OUTER, 
                          KEEP(2), 
                          ATMOST(1));
                          
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
                                KEEP(2), 
                                ATMOST(1));
                          
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
                          KEEP(2), 
                          ATMOST(1));
                          
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
                        KEEP(2), 
                        ATMOST(1));
                          
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
                            KEEP(2), 
                            ATMOST(1));
                          
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
                          KEEP(2), 
                          ATMOST(1));
                          
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
                          KEEP(2), 
                          ATMOST(1));
                          
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
                          KEEP(2), 
                          ATMOST(1));
                          
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
                              KEEP(2), 
                              ATMOST(1));
                          
        //================================
        // Attributes Section
        //================================
        attributes := JOIN(busAssoc, Seed_Files.keys_DueDiligencePersonReport.AttributesSection,
                              KEYED(RIGHT.inDatasetName = LEFT.datasetName) AND
                              KEYED(RIGHT.hashValue = LEFT.hashkey),
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.result.AttributeGroup := DueDiligence.TestSeeds.TestSeedFunctionHelperPerson.GetPersonAttributes(RIGHT);
                                        SELF := LEFT;),
                              LEFT OUTER, 
                              KEEP(2), 
                              ATMOST(1));
                        
        RETURN PROJECT(attributes, TRANSFORM(personResponseLayout, SELF := LEFT;));
    END;

END;
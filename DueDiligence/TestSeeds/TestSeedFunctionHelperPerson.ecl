IMPORT DueDiligence, iesp, Seed_Files;

EXPORT TestSeedFunctionHelperPerson := MODULE
    
    //================================
    // Shared Section
    //================================
    SHARED mac_EmptyDS(structure) := FUNCTIONMACRO
        RETURN DATASET([], structure);
    ENDMACRO;
    
    SHARED mac_AddressPopulated(inData) := FUNCTIONMACRO
        RETURN inData.streetName <> DueDiligence.Constants.EMPTY OR 
                inData.streetNumber <> DueDiligence.Constants.EMPTY OR
                inData.streetPreDirection <> DueDiligence.Constants.EMPTY OR 
                inData.streetPostDirection <> DueDiligence.Constants.EMPTY OR
                inData.streetSuffix <> DueDiligence.Constants.EMPTY OR 
                inData.unitDesignation <> DueDiligence.Constants.EMPTY OR
                inData.unitNumber <> DueDiligence.Constants.EMPTY OR 
                inData.city <> DueDiligence.Constants.EMPTY OR
                inData.state <> DueDiligence.Constants.EMPTY OR 
                inData.zip5 <> DueDiligence.Constants.EMPTY OR 
                inData.zip4 <> DueDiligence.Constants.EMPTY OR
                inData.county <> DueDiligence.Constants.EMPTY OR 
                inData.postalCode <> DueDiligence.Constants.EMPTY OR
                inData.streetAddress1 <> DueDiligence.Constants.EMPTY OR 
                inData.streetAddress2 <> DueDiligence.Constants.EMPTY OR
                inData.stateCityZip <> DueDiligence.Constants.EMPTY;
    ENDMACRO;
    
    SHARED mac_ESPAddress(inData) := FUNCTIONMACRO
        RETURN iesp.ECL2ESP.SetAddress(inData.streetName, inData.streetNumber,
                                        inData.streetPreDirection, inData.streetPostDirection,
                                        inData.streetSuffix, inData.unitDesignation,
                                        inData.unitNumber, inData.city,
                                        inData.state, inData.zip5, inData.zip4,
                                        inData.county, inData.postalCode,
                                        inData.streetAddress1, inData.streetAddress2,
                                        inData.stateCityZip);
    ENDMACRO;
    
    SHARED mac_GetYearMakeModel(inData) := FUNCTIONMACRO
        RETURN PROJECT(inData, TRANSFORM(iesp.duediligenceshared.t_DDRYearMakeModel,
                                          SELF.year := LEFT.year;
                                          SELF.make := LEFT.make;
                                          SELF.model := LEFT.model;));
    ENDMACRO;
    
    SHARED mac_GetStateAndDate(inData, structure) := FUNCTIONMACRO
        RETURN PROJECT(inData, TRANSFORM(structure,
                                          SELF.state := LEFT.state;
                                          SELF.date := iesp.ECL2ESP.toDate(LEFT.date);));
    ENDMACRO;
    
    SHARED mac_ESPPersonWithLexID(inData) := FUNCTIONMACRO
        
         personExists := inData.lexID > 0 OR
                          inData.firstName <> DueDiligence.Constants.EMPTY OR
                          inData.middleName <> DueDiligence.Constants.EMPTY OR
                          inData.lastName <> DueDiligence.Constants.EMPTY OR
                          inData.suffix <> DueDiligence.Constants.EMPTY OR
                          inData.prefix <> DueDiligence.Constants.EMPTY OR
                          inData.fullName <> DueDiligence.Constants.EMPTY;
        
        person := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRPersonNameWithLexID,
                                          SELF.lexID := (STRING)inData.lexID;
                                          SELF.name := iesp.ECL2ESP.SetName(inData.firstName, inData.middleName, 
                                                                            inData.lastName, inData.suffix, 
                                                                            inData.prefix, inData.fullName);)]);
        
        RETURN IF(personExists, person, mac_EmptyDS(iesp.duediligenceshared.t_DDRPersonNameWithLexID));
    ENDMACRO;
    
    SHARED mac_GetOwnershipType(inData) := FUNCTIONMACRO
        RETURN PROJECT(inData, TRANSFORM(iesp.duediligencepersonreport.t_DDRInquiredOrSpouseOwnership,
                                          SELF.subjectOwned := LEFT.subjectOwned;
                                          SELF.spouseOwned := LEFT.spouseOwned;
                                          
                                          owner1 := mac_ESPPersonWithLexID(LEFT.owner1);
                                          owner2 := mac_ESPPersonWithLexID(LEFT.owner2);
                                          
                                          SELF.owners := owner1 + owner2;));
    ENDMACRO;











    //================================
    // Legal Section
    //================================
    SHARED GetCriminalSourceDetails(DueDiligence.TestSeeds.SharedLayouts.CriminalSourceDetail sourceDetail) := FUNCTION
        withSourceDetails := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRLegalSourceInfo,
                                                SELF.offenseCharge := sourceDetail.offenseCharge;
                                                SELF.offenseConviction :=  sourceDetail.offenseConviction;
                                                SELF.offenseChargeLevelReported := sourceDetail.offenseChargeLevelReported;
                                                SELF.source := sourceDetail.source;
                                                SELF.courtDisposition1 := sourceDetail.courtDisposition1;
                                                SELF.courtDisposition2 := sourceDetail.courtDisposition2;
                                                SELF.offenseReportedDate := iesp.ECL2ESP.toDate(sourceDetail.offenseReportedDate);
                                                SELF.offenseArrestDate := iesp.ECL2ESP.toDate(sourceDetail.offenseArrestDate);
                                                SELF.offenseCourtDispDate := iesp.ECL2ESP.toDate(sourceDetail.offenseCourtDispDate);
                                                SELF.offenseAppealDate := iesp.ECL2ESP.toDate(sourceDetail.offenseAppealDate);
                                                SELF.offenseSentenceDate := iesp.ECL2ESP.toDate(sourceDetail.offenseSentenceDate);
                                                SELF.offenseSentenceStartDate := iesp.ECL2ESP.toDate(sourceDetail.offenseSentenceStartDate);
                                                SELF.docConvictionOverrideDate := iesp.ECL2ESP.toDate(sourceDetail.docConvictionOverrideDate);
                                                SELF.docScheduledReleaseDate := iesp.ECL2ESP.toDate(sourceDetail.docScheduledReleaseDate);
                                                SELF.docActualReleaseDate := iesp.ECL2ESP.toDate(sourceDetail.docActualReleaseDate);
                                                SELF.docInmateStatus := sourceDetail.docInmateStatus;
                                                SELF.docParoleStatus := sourceDetail.docParoleStatus;
                                                SELF.offenseMaxTerm := sourceDetail.offenseMaxTerm;
                                                SELF.docParoleActualReleaseDate := iesp.ECL2ESP.toDate(sourceDetail.docParoleActualReleaseDate);
                                                SELF.docParolePresumptiveReleaseDate := iesp.ECL2ESP.toDate(sourceDetail.docParolePresumptiveReleaseDate);
                                                SELF.docParoleScheduledReleaseDate := iesp.ECL2ESP.toDate(sourceDetail.docParoleScheduledReleaseDate);
                                                SELF.docCurrentLocationSecurity := sourceDetail.docCurrentLocationSecurity;
                                                SELF.docParoleCurrentStatus := sourceDetail.docParoleCurrentStatus;
                                                SELF.docCurrentKnownInmateStatus := sourceDetail.docCurrentKnownInmateStatus;
                                                SELF.currentIncarcerationFlag := sourceDetail.currentIncarcerationFlag;
                                                SELF.currentParoleFlag := sourceDetail.currentParoleFlag;
                                                SELF.currentProbationFlag :=  sourceDetail.currentProbationFlag;
                                                
                                                party1 := IF(sourceDetail.partyname1 = DueDiligence.Constants.EMPTY, 
                                                                mac_EmptyDS(iesp.share.t_StringArrayItem),
                                                                DATASET([TRANSFORM(iesp.share.t_StringArrayItem,
                                                                                    SELF.value := sourceDetail.partyname1;)]));
                                                party2 := IF(sourceDetail.partyname2 = DueDiligence.Constants.EMPTY, 
                                                                mac_EmptyDS(iesp.share.t_StringArrayItem),
                                                                DATASET([TRANSFORM(iesp.share.t_StringArrayItem,
                                                                                    SELF.value := sourceDetail.partyname2;)]));
                                                                              
                                                SELF.partyNames := party1 + party2;)]);
                                                
        RETURN IF(sourceDetail.source = DueDiligence.Constants.EMPTY, mac_EmptyDS(iesp.duediligenceshared.t_DDRLegalSourceInfo), withSourceDetails);
    END;
    
    SHARED GetTopLevelCriminal(DueDiligence.TestSeeds.SharedLayouts.TopLevelCriminal topLevel) := FUNCTION
        withTopLevel := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRLegalStateCriminal, 
                                            SELF.state := topLevel.state;
                                            SELF.source := topLevel.source;
                                            SELF.caseNumber := topLevel.caseNumber;
                                            SELF.offenseStatute := topLevel.offenseStatute;
                                            SELF.offenseDDFirstReported := iesp.ECL2ESP.toDate(topLevel.offenseDDFirstReported);
                                            SELF.offenseDDLastReportedActivity := iesp.ECL2ESP.toDate(topLevel.offenseDDLastReportedActivity);
                                            SELF.offenseDDMostRecentCourtDispDate := iesp.ECL2ESP.toDate(topLevel.offenseDDMostRecentCourtDispDate);
                                            SELF.offenseDDLegalEventTypeMapped := topLevel.offenseDDLegalEventTypeMapped;
                                            SELF.offenseCharge := topLevel.offenseCharge;
                                            SELF.offenseDDChargeLevelCalculated := topLevel.offenseDDChargeLevelCalculated;
                                            SELF.offenseChargeLevelReported := topLevel.offenseChargeLevelReported;
                                            SELF.offenseConviction := topLevel.offenseConviction;
                                            SELF.offenseIncarcerationProbationParole := topLevel.offenseIncarcerationProbationParole;
                                            SELF.offenseTrafficRelated := topLevel.offenseTrafficRelated;
                                            SELF.county := topLevel.county;
                                            SELF.countyCourt := topLevel.countyCourt;
                                            SELF.city := topLevel.city;
                                            SELF.agency := topLevel.agency;
                                            SELF.race := topLevel.race;
                                            SELF.sex := topLevel.sex;
                                            SELF.hairColor := topLevel.hairColor;
                                            SELF.eyeColor := topLevel.eyeColor;
                                            SELF.height :=  topLevel.height;
                                            SELF.weight := topLevel.weight;
                                            
                                            source1 := GetCriminalSourceDetails(topLevel.sourceDetail1);
                                            source2 := GetCriminalSourceDetails(topLevel.sourceDetail2);
                                            
                                            SELF.sources := source1 + source2;)]);
                                            
        RETURN IF(topLevel.source = DueDiligence.Constants.EMPTY, mac_EmptyDS(iesp.duediligenceshared.t_DDRLegalStateCriminal), withTopLevel);
    END;

    EXPORT GetCriminalDS(RECORDOF(Seed_Files.keys_DueDiligencePersonReport.LegalSection) criminalData) := FUNCTION
        criminal1 := GetTopLevelCriminal(criminalData.topLevelCriminal1);
        criminal2 := GetTopLevelCriminal(criminalData.topLevelCriminal2);
        
        RETURN criminal1 + criminal2;
    END;
    
    
    
    

    //================================
    // Economic Section - Property
    //================================
    SHARED GetPropertyAddresses(DueDiligence.TestSeeds.PersonLayouts.Property addrDetails) := FUNCTION
       
       hasProp := mac_AddressPopulated(addrDetails);
       
       
       
       withProp :=  DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonProperty,
                                  SELF.vacant := addrDetails.vacant;
                                  SELF.ownershipType := mac_GetOwnershipType(addrDetails);                                                                                
                                  SELF.address := mac_ESPAddress(addrDetails);
                                  SELF.addressType := addrDetails.addressType;
                                  SELF.ownerOccupied := addrDetails.ownerOccupied;
                                  SELF.ownership.purchaseDate := iesp.ECL2ESP.toDate(addrDetails.purchasedate);
                                  SELF.ownership.lengthOfOwnership := addrDetails.lengthOfOwnership;
                                  SELF.ownership.purchasePrice := addrDetails.purchasePrice;
                                  SELF.assessment.taxYear := iesp.ECL2ESP.toDatestring8((STRING)addrDetails.taxYear + '0000');
                                  SELF.assessment.taxPrice := addrDetails.taxPrice;
                                  SELF.areaRisk.hifca := addrDetails.hifca;
                                  SELF.areaRisk.hidta := addrDetails.hidta;
                                  SELF.areaRisk.crimeIndex := addrDetails.crimeIndex;
                                  SELF.countyCityRisk.countyName := addrDetails.countyName;
                                  SELF.countyCityRisk.bordersForeignJurisdiction := addrDetails.bordersForeignJurisdiction;
                                  SELF.countyCityRisk.bordersOceanWithin150ForeignJurisdiction := addrDetails.bordersOceanWithin150ForeignJurisdiction;
                                  SELF.countyCityRisk.accessThroughBorderStation := addrDetails.accessThroughBorderStation;
                                  SELF.countyCityRisk.accessThroughRailCrossing := addrDetails.accessThroughRailCrossing;
                                  SELF.countyCityRisk.accessThroughFerryCrossing := addrDetails.accessThroughFerryCrossing;
                                  SELF := [];)]);
                                  
        RETURN IF(hasProp, withProp, mac_EmptyDS(iesp.duediligencepersonreport.t_DDRPersonProperty));
    END;

    EXPORT GetPropertiesDS(RECORDOF(Seed_Files.keys_DueDiligencePersonReport.EconomicPropertySection) propertyData) := FUNCTION
        
        prop1 := GetPropertyAddresses(propertyData.property1);
        prop2 := GetPropertyAddresses(propertyData.property2);
        prop3 := GetPropertyAddresses(propertyData.property3);
        prop4 := GetPropertyAddresses(propertyData.property4);
        prop5 := GetPropertyAddresses(propertyData.property5);
        prop6 := GetPropertyAddresses(propertyData.property6);
        prop7 := GetPropertyAddresses(propertyData.property7);
        prop8 := GetPropertyAddresses(propertyData.property8);
        prop9 := GetPropertyAddresses(propertyData.property9);
        prop10 := GetPropertyAddresses(propertyData.property10);
        prop11 := GetPropertyAddresses(propertyData.property11);
        prop12 := GetPropertyAddresses(propertyData.property12);
        prop13 := GetPropertyAddresses(propertyData.property13);
        prop14 := GetPropertyAddresses(propertyData.property14);
        prop15 := GetPropertyAddresses(propertyData.property15);
        
        RETURN prop1 + prop2 + prop3 + prop4 + prop5 + prop6 + prop7 + prop8 + prop9 + prop10 + prop11 + prop12 + prop13 + prop14 + prop15;
    END;
    
    
    
    

    //================================
    // Economic Section - Vehicle
    //================================
    SHARED GetVehicleData(DueDiligence.TestSeeds.PersonLayouts.MotorVehicle vehicle) := FUNCTION
        
        hasBeepBeep := vehicle.year <> DueDiligence.Constants.EMPTY OR
                       vehicle.make <> DueDiligence.Constants.EMPTY OR
                       vehicle.model <> DueDiligence.Constants.EMPTY OR
                       vehicle.vin <> DueDiligence.Constants.EMPTY OR
                       vehicle.licensePlateType <> DueDiligence.Constants.EMPTY OR
                       vehicle.classType <> DueDiligence.Constants.EMPTY OR
                       vehicle.basePrice > 0 OR
                       vehicle.title.state <> DueDiligence.Constants.EMPTY OR
                       vehicle.title.date > 0 OR
                       vehicle.registration.state <> DueDiligence.Constants.EMPTY OR
                       vehicle.registration.date > 0;
                       
        beepBeep := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonVehicle,
                                        SELF.ownershipType := mac_GetOwnershipType(vehicle);
                                        SELF.vehicle := mac_GetYearMakeModel(vehicle);
                                        SELF.motorVehicle.vin := vehicle.vin;
                                        SELF.licensePlateType.detailType := vehicle.licensePlateType;
                                        SELF.classType.detailType := vehicle.classType;
                                        SELF.basePrice := vehicle.basePrice;
                                        SELF.title := mac_GetStateAndDate(vehicle.title, iesp.duediligenceshared.t_DDRTitleInfo);
                                        SELF.registration := mac_GetStateAndDate(vehicle.registration, iesp.duediligenceshared.t_DDRRegistration);)]);
                                        
        RETURN IF(hasBeepBeep, beepBeep, mac_EmptyDs(iesp.duediligencepersonreport.t_DDRPersonVehicle));
    END;

    EXPORT GetVehiclesDS(RECORDOF(Seed_Files.keys_DueDiligencePersonReport.EconomicVehicleSection) vehicleData) := FUNCTION
        
        vroom1 := GetVehicleData(vehicleData.vehicle1);
        vroom2 := GetVehicleData(vehicleData.vehicle2);
        vroom3 := GetVehicleData(vehicleData.vehicle3);
        vroom4 := GetVehicleData(vehicleData.vehicle4);
        vroom5 := GetVehicleData(vehicleData.vehicle5);
        vroom6 := GetVehicleData(vehicleData.vehicle6);
        vroom7 := GetVehicleData(vehicleData.vehicle7);
        vroom8 := GetVehicleData(vehicleData.vehicle8);
        vroom9 := GetVehicleData(vehicleData.vehicle9);
        vroom10 := GetVehicleData(vehicleData.vehicle10);
        vroom11 := GetVehicleData(vehicleData.vehicle11);
        vroom12 := GetVehicleData(vehicleData.vehicle12);
        vroom13 := GetVehicleData(vehicleData.vehicle13);
        vroom14 := GetVehicleData(vehicleData.vehicle14);
        vroom15 := GetVehicleData(vehicleData.vehicle15);

        
        RETURN vroom1 + vroom2 + vroom3 + vroom4 + vroom5 + vroom6 + vroom7 + vroom8 + vroom9 + vroom10 + vroom11 + vroom12 + vroom13 + vroom14 + vroom15;
    END;
    
    
    
    

    //================================
    // Economic Section - Watercraft
    //================================
    SHARED GetWatercraftData(DueDiligence.TestSeeds.PersonLayouts.Watercraft boat) := FUNCTION
        
        hasBoat := boat.year <> DueDiligence.Constants.EMPTY OR
                   boat.make <> DueDiligence.Constants.EMPTY OR
                   boat.model <> DueDiligence.Constants.EMPTY OR
                   boat.vin <> DueDiligence.Constants.EMPTY OR
                   boat.vesselType <> DueDiligence.Constants.EMPTY OR
                   boat.title.state <> DueDiligence.Constants.EMPTY OR
                   boat.title.date > 0 OR
                   boat.registration.state <> DueDiligence.Constants.EMPTY OR
                   boat.registration.date > 0 OR
                   boat.lengthInches > 0 OR
                   boat.lengthFeet > 0 OR
                   boat.propulsion <> DueDiligence.Constants.EMPTY;
                   
        waterToy := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonWatercraft,
                                        SELF.yearMakeModel := mac_GetYearMakeModel(boat);
                                        SELF.vesselType.detailType := boat.vesselType;
                                        SELF.title := mac_GetStateAndDate(boat.title, iesp.duediligenceshared.t_DDRTitleInfo);
                                        SELF.registration := mac_GetStateAndDate(boat.registration, iesp.duediligenceshared.t_DDRRegistration);
                                        SELF.lengthInches := boat.lengthInches;
                                        SELF.lengthFeet := boat.lengthFeet;
                                        SELF.vinNumber.vin := boat.vin;
                                        SELF.propulsion := boat.propulsion;
                                        SELF.ownershipType := mac_GetOwnershipType(boat);)]);
                                    
        RETURN IF(hasBoat, waterToy, mac_EmptyDS(iesp.duediligencepersonreport.t_DDRPersonWatercraft));
    END;

    EXPORT GetWatercraftDS(RECORDOF(Seed_Files.keys_DueDiligencePersonReport.EconomicWatercraftSection) watercraftData) := FUNCTION
        
        swoosh1 := GetWatercraftData(watercraftData.watercraft1);
        swoosh2 := GetWatercraftData(watercraftData.watercraft2);
        swoosh3 := GetWatercraftData(watercraftData.watercraft3);
        swoosh4 := GetWatercraftData(watercraftData.watercraft4);
        swoosh5 := GetWatercraftData(watercraftData.watercraft5);
        swoosh6 := GetWatercraftData(watercraftData.watercraft6);
        
        RETURN swoosh1 + swoosh2 + swoosh3 + swoosh4 + swoosh5 + swoosh6;
    END;
    
    
    
    

    //================================
    // Economic Section - Aircraft
    //================================
    SHARED GetAircraftData(DueDiligence.TestSeeds.PersonLayouts.Aircraft plane) := FUNCTION
        
        hasPlane := plane.year <> DueDiligence.Constants.EMPTY OR
                     plane.make <> DueDiligence.Constants.EMPTY OR
                     plane.model <> DueDiligence.Constants.EMPTY OR
                     plane.vin <> DueDiligence.Constants.EMPTY OR
                     plane.additionalDetails <> DueDiligence.Constants.EMPTY OR
                     (UNSIGNED)plane.numberOfEngines > 0 OR
                     plane.tailNumber <> DueDiligence.Constants.EMPTY OR
                     plane.registrationDate > 0;
                   
        flyingContraption := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonAircraft,
                                                SELF.yearMakeModel := mac_GetYearMakeModel(plane);
                                                SELF.additionalDetails.detailType := plane.additionalDetails;
                                                SELF.numberOfEngines := (UNSIGNED)plane.numberOfEngines;
                                                SELF.tailNumber := plane.tailNumber;
                                                SELF.aircraft.vin := plane.vin;
                                                SELF.registrationDate := iesp.ECL2ESP.toDate(plane.registrationDate);
                                                SELF.ownershipType := mac_GetOwnershipType(plane);)]);
                                    
        RETURN IF(hasPlane, flyingContraption, mac_EmptyDS(iesp.duediligencepersonreport.t_DDRPersonAircraft));
    END;
    
    EXPORT GetAircraftDS(RECORDOF(Seed_Files.keys_DueDiligencePersonReport.EconomicAircraftSection) aircraftData) := FUNCTION
        
        air1 := GetAircraftData(aircraftData.aircraft1);
        air2 := GetAircraftData(aircraftData.aircraft2);
        air3 := GetAircraftData(aircraftData.aircraft3);
        air4 := GetAircraftData(aircraftData.aircraft4);
        air5 := GetAircraftData(aircraftData.aircraft5);
        air6 := GetAircraftData(aircraftData.aircraft6);
        air7 := GetAircraftData(aircraftData.aircraft7);
        air8 := GetAircraftData(aircraftData.aircraft8);
        
        RETURN air1 + air2 + air3 + air4 + air5 + air6 + air7 + air8;
    END;
    
    
    
    

    //================================
    // Professional Network Section
    //================================
    SHARED GetProfessionalLicensesData(DueDiligence.TestSeeds.SharedLayouts.ProfessionalLicense profLic) := FUNCTION
        
        hasProfLic := profLic.license <> DueDiligence.Constants.EMPTY OR
                      profLic.status <> DueDiligence.Constants.EMPTY OR
                      profLic.issuingAgency <> DueDiligence.Constants.EMPTY OR
                      profLic.issueDate > 0 OR
                      profLic.expirationDate > 0 OR
                      profLic.lawAccounting OR profLic.financeRealEstate OR
                      profLic.medicalDoctor OR profLic.pilotMarinePilotHarborPilotExplosives;
                      
        lic := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRProfessionalLicenses,
                                  SELF.license := profLic.license;
                                  SELF.status := profLic.status;
                                  SELF.issuingAgency := profLic.issuingAgency;
                                  SELF.issueDate := iesp.ECL2ESP.toDate(profLic.issueDate);
                                  SELF.expirationDate := iesp.ECL2ESP.toDate(profLic.expirationDate);
                                  SELF.lawAccounting := profLic.lawAccounting;
                                  SELF.financeRealEstate := profLic.financeRealEstate;
                                  SELF.medicalDoctor := profLic.medicalDoctor;
                                  SELF.pilotMarinePilotHarborPilotExplosives := profLic.pilotMarinePilotHarborPilotExplosives;)]);
        
        RETURN IF(hasProfLic, lic, mac_EmptyDS(iesp.duediligenceshared.t_DDRProfessionalLicenses));
    END;
    
    EXPORT GetProfLicensesDS(RECORDOF(Seed_Files.keys_DueDiligencePersonReport.ProfessionalNetworkSection) licenses) := FUNCTION
        
        lic1 := GetProfessionalLicensesData(licenses.license1);
        lic2 := GetProfessionalLicensesData(licenses.license2);
        
        RETURN lic1 + lic2;
    END;
    
    
    
    

    //================================
    // Business Associations Section
    //================================
    SHARED GetIndustryRiskData(DueDiligence.TestSeeds.PersonLayouts.IndustryRisk risk) := FUNCTION
        RETURN PROJECT(risk, TRANSFORM(iesp.duediligencepersonreport.t_DDRIndustryRisk,
                                        SELF.code := LEFT.code;
                                        SELF.description := LEFT.description;
                                        SELF.industryRisk := LEFT.industryRisk;));
    END;
    
    SHARED GetExecData(DueDiligence.TestSeeds.SharedLayouts.Executives exec) := FUNCTION
        
        execNameLexID := mac_ESPPersonWithLexID(exec);
        execExists := EXISTS(execNameLexID);
        
        execData := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRExecutives,
                                        SELF.execTitle := exec.execTitle;
                                        SELF.firstReported := iesp.ECL2ESP.toDate(exec.firstReported);
                                        SELF.lastReported := iesp.ECL2ESP.toDate(exec.lastReported);
                                        SELF.name := execNameLexID[1].name;
                                        SELF.lexID := execNameLexID[1].lexID;)]);
        
        
        RETURN IF(execExists, execData, mac_EmptyDS(iesp.duediligencepersonreport.t_DDRExecutives));
        
    END;
    
    SHARED GetBusAssociationData(DueDiligence.TestSeeds.PersonLayouts.Business bus) := FUNCTION
        
        hasBus := bus.businessName <> DueDiligence.Constants.EMPTY OR
                  bus.lexID > 0 OR
                  mac_AddressPopulated(bus) OR
                  bus.addressType <> DueDiligence.Constants.EMPTY OR
                  bus.structureType <> DueDiligence.Constants.EMPTY;
                  
        corp := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRBusinessAssocationDetails,
                                    SELF.businessName := bus.businessName;
                                    SELF.businessAddress := mac_ESPAddress(bus);
                                    SELF.businessAddressType := bus.addressType;
                                    SELF.lexID := (STRING)bus.lexID;
                                    SELF.bestNAICS := GetIndustryRiskData(bus.bestNAICS);
                                    SELF.bestSIC := GetIndustryRiskData(bus.bestSIC);
                                    SELF.highestRisk := GetIndustryRiskData(bus.highestRisk);
                                    SELF.structureType := bus.structureType;
                                    
                                    agent1 := mac_ESPPersonWithLexID(bus.registeredAgent1);
                                    agent2 := mac_ESPPersonWithLexID(bus.registeredAgent2);
                                    
                                    SELF.registeredAgents := agent1 + agent2;
                                    
                                    exec1 := GetExecData(bus.exec1);
                                    exec2 := GetExecData(bus.exec2);
                                    
                                    SELF.executiveOfficers := exec1 + exec2;)]);
        
        RETURN IF(hasBus, corp, mac_EmptyDS(iesp.duediligencepersonreport.t_DDRBusinessAssocationDetails));
    END;
    
    EXPORT GetBusAssociationsDS(RECORDOF(Seed_Files.keys_DueDiligencePersonReport.BusinessAssociationSection) associations) := FUNCTION
        
        bus1 := GetBusAssociationData(associations.business1);
        bus2 := GetBusAssociationData(associations.business2);
        
        RETURN bus1 + bus2;
    END;
    
    
    
    

    //================================
    // Attributes Section
    //================================
    EXPORT GetPersonAttributes(RECORDOF(Seed_Files.keys_DueDiligencePersonReport.AttributesSection) attrs) := FUNCTION
        
        RETURN PROJECT(attrs, TRANSFORM(iesp.duediligenceshared.t_DDRAttributeGroup,
                                        SELF.name := LEFT.attributeName;
                                        SELF.attributes := DueDiligence.Common.createNVPair('PerAssetOwnProperty', LEFT.PerAssetOwnProperty) +
                                                            DueDiligence.Common.createNVPair('PerAssetOwnAircraft', LEFT.PerAssetOwnAircraft) +
                                                            DueDiligence.Common.createNVPair('PerAssetOwnWatercraft', LEFT.PerAssetOwnWatercraft) +
                                                            DueDiligence.Common.createNVPair('PerAssetOwnVehicle', LEFT.PerAssetOwnVehicle) +
                                                            DueDiligence.Common.createNVPair('PerAccessToFundsIncome', LEFT.PerAccessToFundsIncome) +
                                                            DueDiligence.Common.createNVPair('PerAccessToFundsProperty', LEFT.PerAccessToFundsProperty) +
                                                            DueDiligence.Common.createNVPair('PerGeographic', LEFT.PerGeographic) +
                                                            DueDiligence.Common.createNVPair('PerMobility', LEFT.PerMobility) +
                                                            DueDiligence.Common.createNVPair('PerStateLegalEvent', LEFT.PerStateLegalEvent) +
                                                            DueDiligence.Common.createNVPair('PerFederalLegalEvent', LEFT.PerFederalLegalEvent) +
                                                            DueDiligence.Common.createNVPair('PerFederalLegalMatchLevel', LEFT.PerFederalLegalMatchLevel) +
                                                            DueDiligence.Common.createNVPair('PerCivilLegalEvent', LEFT.PerCivilLegalEvent) +
                                                            DueDiligence.Common.createNVPair('PerOffenseType', LEFT.PerOffenseType) +
                                                            DueDiligence.Common.createNVPair('PerAgeRange', LEFT.PerAgeRange) +
                                                            DueDiligence.Common.createNVPair('PerIdentityRisk', LEFT.PerIdentityRisk) +
                                                            DueDiligence.Common.createNVPair('PerUSResidency', LEFT.PerUSResidency) +
                                                            DueDiligence.Common.createNVPair('PerMatchLevel', LEFT.PerMatchLevel) +
                                                            DueDiligence.Common.createNVPair('PerAssociates', LEFT.PerAssociates) +
                                                            DueDiligence.Common.createNVPair('PerEmploymentIndustry', LEFT.PerEmploymentIndustry) +
                                                            DueDiligence.Common.createNVPair('PerProfLicense', LEFT.PerProfLicense) +
                                                            DueDiligence.Common.createNVPair('PerBusAssociations', LEFT.PerBusAssociations);
                                                            
                                        SELF.attributeLevelHits := DueDiligence.Common.createNVPair('PerAssetOwnProperty_Flag', LEFT.PerAssetOwnProperty_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerAssetOwnAircraft_Flag', LEFT.PerAssetOwnAircraft_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerAssetOwnWatercraft_Flag', LEFT.PerAssetOwnWatercraft_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerAssetOwnVehicle_Flag', LEFT.PerAssetOwnVehicle_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerAccessToFundsIncome_Flag', LEFT.PerAccessToFundsIncome_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerAccessToFundsProperty_Flag', LEFT.PerAccessToFundsProperty_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerGeographic_Flag', LEFT.PerGeographic_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerMobility_Flag', LEFT.PerMobility_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerStateLegalEvent_Flag', LEFT.PerStateLegalEvent_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerFederalLegalEvent_Flag', LEFT.PerFederalLegalEvent_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerFederalLegalMatchLevel_Flag', LEFT.PerFederalLegalMatchLevel_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerCivilLegalEvent_Flag', LEFT.PerCivilLegalEvent_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerOffenseType_Flag', LEFT.PerOffenseType_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerAgeRange_Flag', LEFT.PerAgeRange_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerIdentityRisk_Flag', LEFT.PerIdentityRisk_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerUSResidency_Flag', LEFT.PerUSResidency_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerMatchLevel_Flag', LEFT.PerMatchLevel_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerAssociates_Flag', LEFT.PerAssociates_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerEmploymentIndustry_Flag', LEFT.PerEmploymentIndustry_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerProfLicense_Flag', LEFT.PerProfLicense_Flag) +
                                                                    DueDiligence.Common.createNVPair('PerBusAssociations_Flag', LEFT.PerBusAssociations_Flag);));

    END;

END;

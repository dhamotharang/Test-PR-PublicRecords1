IMPORT BIPV2, Business_Risk_BIP, DueDiligence, STD, ut;


EXPORT getIndAttributes(DATASET(DueDiligence.LayoutsInternal.SharedInput) inData,
                        STRING6 ssnMask,
                        BOOLEAN includeReport,
                        Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                        BIPV2.mod_sources.iParams linkingOptions,
                        BOOLEAN debugMode = FALSE) := FUNCTION

																						 

    INTEGER bsVersion := DueDiligence.CitDDShared.DEFAULT_BS_VERSION;
    UNSIGNED8 bsOptions := DueDiligence.CitDDShared.DEFAULT_BS_OPTIONS;
    BOOLEAN isFCRA := DueDiligence.Constants.DEFAULT_IS_FCRA;
    
    UNSIGNED1 dppa := options.DPPA_Purpose;
    UNSIGNED1 glba := options.GLBA_Purpose;
    STRING dataRestrictionMask := options.DataRestrictionMask;




    //convert the incoming data to the DueDiligence.Layouts.Indv_Internal used
    //for processing an individual
    inquiredInd := PROJECT(inData, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
    
                                              historyDate := IF(LEFT.cleanedinput.historyDateYYYYMMDD = DueDiligence.Constants.date8Nines, STD.Date.Today(), LEFT.cleanedinput.historyDateYYYYMMDD);
                                              
                                              SELF.seq := LEFT.cleanedInput.seq;
                                              SELF.indvRawInput.lexID := LEFT.inputEcho.individual.lexID;
                                              SELF.indvRawInput.accountNumber := LEFT.inputEcho.individual.accountNumber;
                                              SELF.indvRawInput.address := LEFT.inputEcho.individual.address;
                                              SELF.indvRawInput.phone := LEFT.inputEcho.individual.phone;
                                              SELF.indvRawInput.inputSeq := LEFT.inputEcho.individual.inputSeq;
                                              SELF.indvRawInput.nameInputOrder := LEFT.inputEcho.individual.nameInputOrder;
                                              SELF.indvRawInput.name := LEFT.inputEcho.individual.name;
                                              SELF.indvRawInput.ssn := LEFT.inputEcho.individual.ssn;
                                              SELF.indvRawInput.dob := LEFT.inputEcho.individual.dob;
                                              SELF.indvRawInput.cleanAddress := LEFT.cleanedInput.individual.address;
                                              
                                              SELF.historyDateRaw := LEFT.cleanedinput.historyDateYYYYMMDD;
                                              SELF.historyDate := historyDate;
                                              SELF.indvType := DueDiligence.Constants.INQUIRED_INDIVIDUAL;
                                              
                                              SELF.inquiredDID := LEFT.dataToUse.did;
                                              SELF.individual.did := LEFT.dataToUse.did;
                                              SELF.individual.score := LEFT.dataToUse.lexIDScore;
                                              SELF.individual.ssn := LEFT.dataToUse.ssn;
                                              SELF.individual.dob := (UNSIGNED4)LEFT.dataToUse.dob;
                                              SELF.individual.phone := LEFT.dataToUse.phone;
                                              
                                              SELF.individual := LEFT.dataToUse.name;
                                              SELF.individual := LEFT.dataToUse.address;
                                              
                                              SELF.inputaddressprovided := LEFT.cleanedInput.addressProvided;
                                              SELF.fullinputaddressprovided := LEFT.cleanedInput.fullCleanAddressExists;
                                              
                                              SELF.bestSSN := LEFT.dataToUse.ssn;
                                              SELF.bestPhone := LEFT.dataToUse.phone;
                                              SELF.bestDOB := (UNSIGNED4)LEFT.dataToUse.dob;
                                              
                                              SELF.bestName := LEFT.dataToUse.name;
                                              SELF.bestAddress := LEFT.dataToUse.bestAddress;
                                              
                                              
                                              validDOB := DueDiligence.Common.IsValidDOB((UNSIGNED4)LEFT.dataToUse.dob);
                                              validHistDate := STD.Date.IsValidDate(historyDate);
                                              
                                              SELF.estimatedAge := IF(validDOB AND validHistDate, ut.Age((UNSIGNED4)LEFT.dataToUse.dob, historyDate), 0);

                                              SELF := [];));



    didFound := inquiredInd(inquiredDID <> 0);
    noDIDFound := inquiredInd(inquiredDID = 0);


    //get estimated income
    indEstIncome := DueDiligence.getIndEstimatedIncome(didFound);

    //get geographic risk of the inquired individual's address  
    indGeoRisk := DueDiligence.getIndGeographicRisk(indEstIncome);

    //get proffessional license
    indProfLic := DueDiligence.getIndProfessionalData(indGeoRisk);

    //get relatives of the inquired individual  
    indRelatives := DueDiligence.getIndRelatives(indProfLic, options);

    //get header information
    indHeader := DueDiligence.getIndHeader(indRelatives, dataRestrictionMask, dppa, glba, isFCRA, includeReport);

    //get information pertaining to SSN
    indSSNData := DueDiligence.getIndSSNData(indHeader, dataRestrictionMask, dppa, glba, bsVersion, bsOptions, isFCRA, includeReport);

    //get property information
    indProperty := DueDiligence.getIndProperty(indSSNData, dataRestrictionMask);

    //get watercraft information
    indWatercraft := DueDiligence.getIndWatercraft(indProperty);

    //get vehicle information
    indVehicle := DueDiligence.getIndVehicle(indWatercraft, dppa);

    //get aircraft information
    indAircraft := DueDiligence.getIndAircraft(indVehicle);

    //get legal information
    indCriminalData := DueDiligence.getIndLegalEvents(indAircraft);

    //get business associations
    indBusAssoc := DueDiligence.getIndBusAssoc(indCriminalData, options, linkingOptions);

    //if a person report is being requested, populate the report
    indReportData :=  IF(includeReport, DueDiligence.getIndReport(indBusAssoc, options, linkingOptions, ssnMask), indBusAssoc);


    //populate the attributes and flags
    indKRI := DueDiligence.getIndKRI(indReportData + noDIDFound);
    
    

    //debugging section
    IF(debugMode, OUTPUT(inquiredInd, NAMED('inquiredInd')));
    IF(debugMode, OUTPUT(didFound, NAMED('didFound')));
    IF(debugMode, OUTPUT(noDIDFound, NAMED('noDIDFound')));
    IF(debugMode, OUTPUT(indEstIncome, NAMED('indEstIncome')));
    IF(debugMode, OUTPUT(indGeoRisk, NAMED('indGeoRisk')));
    IF(debugMode, OUTPUT(indProfLic, NAMED('indProfLic')));
    IF(debugMode, OUTPUT(indRelatives, NAMED('indRelatives')));
    IF(debugMode, OUTPUT(indHeader, NAMED('indHeader')));
    IF(debugMode, OUTPUT(indSSNData, NAMED('indSSNData')));
    IF(debugMode, OUTPUT(indProperty, NAMED('indProperty')));
    IF(debugMode, OUTPUT(indWatercraft, NAMED('indWatercraft')));
    IF(debugMode, OUTPUT(indVehicle, NAMED('indVehicle')));
    IF(debugMode, OUTPUT(indAircraft, NAMED('indAircraft')));
    IF(debugMode, OUTPUT(indCriminalData, NAMED('indCriminalData')));
    IF(debugMode, OUTPUT(indBusAssoc, NAMED('indBusAssoc')));
    IF(debugMode, OUTPUT(indReportData, NAMED('indReportData')));
    IF(debugMode, OUTPUT(indKRI, NAMED('indKRI')));



    RETURN indKRI;
END;
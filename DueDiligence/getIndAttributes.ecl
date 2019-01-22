IMPORT BIPV2, Business_Risk_BIP, DueDiligence;


EXPORT getIndAttributes(DATASET(DueDiligence.Layouts.CleanedData) cleanedInput,
                        UNSIGNED1 dppa,
                        UNSIGNED1 glba,
                        STRING dataRestrictionMask,
                        STRING6 ssnMask,
                        BOOLEAN includeReport,
                        BOOLEAN displayAttributeText,
                        BOOLEAN debugMode,
                        Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                        BIPV2.mod_sources.iParams linkingOptions) := FUNCTION

																						 

    INTEGER bsVersion := DueDiligence.CitDDShared.DEFAULT_BS_VERSION;
    UNSIGNED8 bsOptions := DueDiligence.CitDDShared.DEFAULT_BS_OPTIONS;
    BOOLEAN isFCRA := DueDiligence.Constants.DEFAULT_IS_FCRA;



    //get the DID of the inquired individual
    inquiredInd := DueDiligence.getIndDID(cleanedInput, dataRestrictionMask, dppa, glba, bsVersion, bsOptions, includeReport);

    didFound := inquiredInd(inquiredDID <> 0);
    noDIDFound := inquiredInd(inquiredDID = 0);

    //get the best data for the individual if do not have it
    indBest := DueDiligence.getIndBestData(didFound, dppa, glba, includeReport);

    //get estimated income
    indEstIncome := DueDiligence.getIndEstimatedIncome(indBest);

    //get geographic risk of the inquired individual's address  
    indGeoRisk := DueDiligence.getIndGeographicRisk(indEstIncome, dppa, glba, includeReport);

    //get proffessional license
    indProfLic := DueDiligence.getIndProfessionalData(indGeoRisk);

    //get relatives of the inquired individual  
    indRelatives := DueDiligence.getIndRelatives(indProfLic, dppa, glba, includeReport);

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
    IF(debugMode, OUTPUT(cleanedInput, NAMED('cleanedInput')));
    IF(debugMode, OUTPUT(inquiredInd, NAMED('inquiredInd')));
    IF(debugMode, OUTPUT(didFound, NAMED('didFound')));
    IF(debugMode, OUTPUT(noDIDFound, NAMED('noDIDFound')));
    IF(debugMode, OUTPUT(indBest, NAMED('indBest')));
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
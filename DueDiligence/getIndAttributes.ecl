﻿IMPORT BIPV2, Business_Risk_BIP, Doxie, DueDiligence;


EXPORT getIndAttributes(DATASET(DueDiligence.LayoutsInternal.SharedInput) inData,
                        STRING6 ssnMask,
                        BOOLEAN includeReport,
                        Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                        BIPV2.mod_sources.iParams linkingOptions,
                        BOOLEAN debugMode = FALSE,
                        unsigned1 LexIdSourceOptout = 1,
                        string TransactionID = '',
                        string BatchUID = '',
                        unsigned6 GlobalCompanyId = 0) := FUNCTION

																					 
																						 
    INTEGER bsVersion := DueDiligence.CitDDShared.DEFAULT_BS_VERSION;
    UNSIGNED8 bsOptions := DueDiligence.CitDDShared.DEFAULT_BS_OPTIONS;
    BOOLEAN isFCRA := DueDiligence.Constants.DEFAULT_IS_FCRA;
    
    UNSIGNED1 dppa := options.DPPA_Purpose;
    UNSIGNED1 glba := options.GLBA_Purpose;
    STRING dataRestrictionMask := options.DataRestrictionMask;
    
    mod_access := MODULE(Doxie.IDataAccess)
      EXPORT glb := options.GLBA_Purpose;
      EXPORT dppa := options.DPPA_Purpose;
      EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
      EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
      EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
    END;




    //convert the incoming data to the DueDiligence.Layouts.Indv_Internal used
    //for processing an individual
    inquiredInd := DueDiligence.getInd(inData);


    didFound := inquiredInd(inquiredDID <> 0);
    noDIDFound := inquiredInd(inquiredDID = 0);


    //get estimated income
    indEstIncome := DueDiligence.getIndEstimatedIncome(didFound);

    //get geographic risk of the inquired individual's address  
    indGeoRisk := DueDiligence.getIndGeographicRisk(indEstIncome);

    //get proffessional license
    indProfLic := DueDiligence.getIndProfessionalData(indGeoRisk, mod_access);

    //get relatives of the inquired individual  
    indRelationships := DueDiligence.getIndRelationships(indProfLic, options, mod_access);
    
    //get business associations
    indBusAssoc := DueDiligence.getIndBusAssoc(indRelationships, options, linkingOptions, mod_access);

    //get header information
    indHeader := DueDiligence.getIndHeader(indBusAssoc, dataRestrictionMask, dppa, glba, isFCRA, bsVersion, includeReport, mod_access);

    //get information pertaining to SSN
    indSSNData := DueDiligence.getIndSSNData(indHeader, dataRestrictionMask, dppa, glba, isFCRA, bsVersion, bsOptions, mod_access);

    //get property information
    indProperty := DueDiligence.getIndProperty(indSSNData, dataRestrictionMask);

    //get watercraft information
    indWatercraft := DueDiligence.getIndWatercraft(indProperty, mod_access);

    //get vehicle information
    indVehicle := DueDiligence.getIndVehicle(indWatercraft, dppa, mod_access);

    //get aircraft information
    indAircraft := DueDiligence.getIndAircraft(indVehicle);

    //get legal information
    indCriminalData := DueDiligence.getIndLegalEvents(indAircraft);

    //get person associations
    indPerAssoc := DueDiligence.getIndPerAssoc(indCriminalData);
    
    //get identity risk
    indIDRisk := DueDiligence.getIndIdentityRisk(indPerAssoc, dataRestrictionMask, dppa, glba, isFCRA, bsVersion, bsOptions, mod_access);

    //populate the attributes and flags
    indKRI := DueDiligence.getIndKRI(indIDRisk);

    //if a person report is being requested, populate the report
    indReportData :=  IF(includeReport, DueDiligence.getIndReport(indKRI, options, linkingOptions, ssnMask, mod_access), indKRI);

    //populate the attributes and flags for those without a DID
    indNoDIDKRI := DueDiligence.getIndKRINoDID(noDIDFound);

    //add both did and didless individuals
    finalInd := SORT(indReportData + indNoDIDKRI, seq);
    
    

    

    //debugging section
    IF(debugMode, OUTPUT(inquiredInd, NAMED('inquiredInd')));
    IF(debugMode, OUTPUT(didFound, NAMED('didFound')));
    IF(debugMode, OUTPUT(noDIDFound, NAMED('noDIDFound')));
    IF(debugMode, OUTPUT(indEstIncome, NAMED('indEstIncome')));
    IF(debugMode, OUTPUT(indGeoRisk, NAMED('indGeoRisk')));
    IF(debugMode, OUTPUT(indProfLic, NAMED('indProfLic')));
    IF(debugMode, OUTPUT(indRelationships, NAMED('indRelationships')));
    IF(debugMode, OUTPUT(indBusAssoc, NAMED('indBusAssoc')));
    IF(debugMode, OUTPUT(indHeader, NAMED('indHeader')));
    IF(debugMode, OUTPUT(indSSNData, NAMED('indSSNData')));
    IF(debugMode, OUTPUT(indProperty, NAMED('indProperty')));
    IF(debugMode, OUTPUT(indWatercraft, NAMED('indWatercraft')));
    IF(debugMode, OUTPUT(indVehicle, NAMED('indVehicle')));
    IF(debugMode, OUTPUT(indAircraft, NAMED('indAircraft')));
    IF(debugMode, OUTPUT(indCriminalData, NAMED('indCriminalData')));
    IF(debugMode, OUTPUT(indPerAssoc, NAMED('indPerAssoc')));
    IF(debugMode, OUTPUT(indIDRisk, NAMED('indIDRisk')));
    IF(debugMode, OUTPUT(indKRI, NAMED('indKRI')));
    IF(debugMode, OUTPUT(indReportData, NAMED('indReportData')));
    IF(debugMode, OUTPUT(indNoDIDKRI, NAMED('indNoDIDKRI')));
    IF(debugMode, OUTPUT(finalInd, NAMED('finalInd')));



    RETURN finalInd;
END;
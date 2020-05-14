IMPORT BIPV2, Business_Risk_BIP, DueDiligence, Doxie;

	
EXPORT getBusAttributes(DATASET(DueDiligence.LayoutsInternal.SharedInput) inData,
                        STRING6 ssnMask,
                        BOOLEAN includeReport,
                        Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                        BIPV2.mod_sources.iParams linkingOptions,
                        BOOLEAN debugMode = FALSE,
                        unsigned1 LexIdSourceOptout = 1,
                        string TransactionID = '',
                        string BatchUID = '',
                        unsigned6 GlobalCompanyId = 0) := FUNCTION

     mod_access := MODULE(Doxie.IDataAccess)
      EXPORT glb := options.GLBA_Purpose;
      EXPORT dppa := options.DPPA_Purpose;
      EXPORT DataPermissionMask := options.DataPermissionMask;
      EXPORT DataRestrictionMask := options.DataRestrictionMask;
      EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
      EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
      EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
    END;
	
    BOOLEAN includeAllBusinessData := TRUE;


    //convert the incoming data to the DueDiligence.Layouts.Busn_Internal used
    //for processing a business
    inquiredBus := PROJECT(inData, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                              SELF.seq := LEFT.cleanedInput.seq;

                                              SELF.busn_info.BIP_IDs.UltID.LinkID := LEFT.dataToUse.UltID;
                                              SELF.busn_info.BIP_IDs.OrgID.LinkID := LEFT.dataToUse.OrgID;
                                              SELF.busn_info.BIP_IDs.SeleID.LinkID := LEFT.dataToUse.SeleID;
                                              SELF.busn_info.BIP_IDs.ProxID.LinkID := LEFT.dataToUse.ProxID;
                                              SELF.busn_info.BIP_IDs.PowID.LinkID := LEFT.dataToUse.PowID;

                                              SELF.busn_info.lexID := (STRING)LEFT.dataToUse.SeleID;
                                              SELF.busn_info.companyName := LEFT.dataToUse.companyName; 
                                              SELF.busn_info.altCompanyName := LEFT.dataToUse.altCompanyName;
                                              SELF.busn_info.fein := LEFT.dataToUse.fein;
                                              SELF.busn_info.phone := LEFT.dataToUse.phone;
                                              SELF.busn_info.address := LEFT.dataToUse.address;
                                              SELF.busn_info.accountNumber := LEFT.cleanedInput.business.accountNumber;

                                              SELF.score := LEFT.dataToUse.lexIDScore;

                                              SELF.historyDate := LEFT.cleanedInput.historyDateYYYYMMDD;

                                              addressProvided := LEFT.cleanedInput.addressProvided;
                                              fullAddressProvided := LEFT.cleanedInput.fullCleanAddressExists;
                                              cleanBusInput := LEFT.cleanedInput.business;

                                              SELF.inputaddressprovided := addressProvided;
                                              SELF.fullinputaddressprovided := fullAddressProvided;
                                              SELF.relatedDegree := DueDiligence.Constants.INQUIRED_BUSINESS_DEGREE;                                           

                                              SELF.bestBusInfo.companyName := LEFT.dataToUse.companyName;
                                              SELF.bestBusInfo.address := LEFT.dataToUse.bestAddress;
                                              SELF.bestBusInfo.phone := LEFT.dataToUse.phone;
                                              SELF.bestBusInfo.fein := LEFT.dataToUse.fein;

                                              SELF.busn_input := LEFT.inputEcho.business;
                                              SELF := [];));



    //seperate those with LexIDs and those without/not found
    inquiredBusWithBIP := inquiredBus(Busn_Info.BIP_IDs.SeleID.LinkID <> DueDiligence.Constants.NUMERIC_ZERO);
    inquiredBusNoBIP := inquiredBus(Busn_Info.BIP_IDs.SeleID.LinkID = DueDiligence.Constants.NUMERIC_ZERO);

    //get linked business to the business passed in
    linkedBus := DueDiligence.getBusLinkedBus(inquiredBusWithBIP, options, linkingOptions, ssnMask);

    //get executives from inquired businesses
    busExecs := DueDiligence.getBusExec(linkedBus, options, linkingOptions, mod_access);


    //get attribute data for individuals related to the inquired business
    busProfLicense := DueDiligence.getBusProfLic(busExecs, includeReport, mod_access);

    busLegalEvents := DueDiligence.getBusLegalEvents(busProfLicense, mod_access); 
    


    //get attribute data for the inquired business
    busProperty    := DueDiligence.getBusProperty(busLegalEvents, options, linkingOptions);

    busWatercraft  := DueDiligence.getBusWatercraft(busProperty, options, linkingOptions, mod_access);

    busAircraft := DueDiligence.getBusAircraft(busWatercraft, options);

    busVehicle := DueDiligence.getBusVehicle(busAircraft, options, linkingOptions, mod_access);

    busReg := DueDiligence.getBusRegistration(busVehicle, options, includeAllBusinessData);

    busGeoRisk := DueDiligence.getBusGeographicRisk(busReg);   

    busSales := DueDiligence.getBusSales(busGeoRisk, options, linkingOptions, mod_access);
    
    busCivilEvents := DueDiligence.getBusCivilEvent(busSales, options, mod_access);
    
    

    //attributes taking in inquired and linked businesses
    busHeader := DueDiligence.getBusHeader(busCivilEvents, options, linkingOptions, includeAllBusinessData, includeReport, mod_access);

    busSOS := DueDiligence.getBusSOSDetail(busHeader, options, includeAllBusinessData, includeReport);


    //attributes that must be called after other attributes
    addrRisk := DueDiligence.getBusAddrData(busSOS, options, includeReport);  //must be called after getBusSOSDetail & getBusRegistration

    busAsInd := DueDiligence.getBusAsInd(addrRisk, options, mod_access);  //must be called after getBusSOSDetail & getBusHeader

    busSicNaic := DueDiligence.getBusSicNaic(busAsInd, options, linkingOptions, includeReport, mod_access);  //must be called after getBusRegistration & getBusHeader & getBusSOSDetail


    addCounts := PROJECT(busSicNaic, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                                SELF.numOfRegAgents := COUNT(LEFT.registeredAgents);
                                                SELF.numOfSicNaic := COUNT(LEFT.sicNaicSources);
                                                SELF.execCount := COUNT(LEFT.execs);
                                                SELF := LEFT;));


    //if a report is requested, populate the data needed for report	
    addBusinessDataForReport := IF(includeReport, DueDiligence.getBusReport(addCounts, options, linkingOptions, ssnMask, mod_access), addCounts);

    //populate the index for the customer
    busKRI := DueDiligence.getBusKRI(addBusinessDataForReport + inquiredBusNoBIP);






    //debugging section  
    IF(debugMode, OUTPUT(inquiredBus, NAMED('inquiredBus')));
    IF(debugMode, OUTPUT(inquiredBusWithBIP, NAMED('inquiredBusWithBIP')));
    IF(debugMode, OUTPUT(inquiredBusNoBIP, NAMED('inquiredBusNoBIP')));

    IF(debugMode, OUTPUT(linkedBus, NAMED('linkedBus')));	
    IF(debugMode, OUTPUT(busExecs, NAMED('busExecs')));
    IF(debugMode, OUTPUT(busProfLicense, NAMED('busProfLicense')));
    IF(debugMode, OUTPUT(busLegalEvents, NAMED('busLegalEvents')));
    IF(debugMode, OUTPUT(busProperty, NAMED('busProperty')));
    IF(debugMode, OUTPUT(busWatercraft, NAMED('busWatercraft')));
    IF(debugMode, OUTPUT(busAircraft, NAMED('busAircraft')));	
    IF(debugMode, OUTPUT(busVehicle, NAMED('busVehicle')));	
    IF(debugMode, OUTPUT(busReg, NAMED('busReg')));	
    IF(debugMode, OUTPUT(busGeoRisk, NAMED('busGeoRisk')));	
    IF(debugMode, OUTPUT(busSales, NAMED('busSales')));
    IF(debugMode, OUTPUT(busCivilEvents, NAMED('busCivilEvents')));

    IF(debugMode, OUTPUT(busHeader, NAMED('busHeader')));
    IF(debugMode, OUTPUT(busSOS, NAMED('busSOS')));

    IF(debugMode, OUTPUT(addrRisk, NAMED('addrRisk')));
    IF(debugMode, OUTPUT(busAsInd, NAMED('busAsInd')));
    IF(debugMode, OUTPUT(busSicNaic, NAMED('busSicNaic')));
    IF(debugMode, OUTPUT(addBusinessDataForReport, NAMED('addBusinessDataForReport')));

    IF(debugMode, OUTPUT(busKRI, NAMED('busKRI')));


    RETURN busKRI;

END;

IMPORT BIPV2, Business_Risk_BIP, DueDiligence, Doxie;

/*

NOTE: Logic is currently being moved to DueDiligence.v3.getBusiness
      where code can be executed modularly. While moving code, clean-up
      is underway and will be marking 'old' code as deprecated. Once each 
      attribute is converted over the deprecations will go away. This new
      function will be used by both DD and Internal customers to retrieve
      DD specific attributes/reports. So please excuse the mess while we
      transition. Eventually this function will also be removed.
      Think of this function as under construction :) 

*/
	//DueDiligence.Layouts.Busn_Internal
EXPORT getBusAttributes(DATASET(DueDiligence.Layouts.Busn_Internal) inData,
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
    
    
     
    
    
 



    //seperate those with LexIDs and those without/not found
    inquiredBusWithBIP := inData(Busn_Info.BIP_IDs.SeleID.LinkID <> DueDiligence.Constants.NUMERIC_ZERO);
    inquiredBusNoBIP := inData(Busn_Info.BIP_IDs.SeleID.LinkID = DueDiligence.Constants.NUMERIC_ZERO);

    //get linked business to the business passed in
    linkedBus := DueDiligence.getBusLinkedBus(inquiredBusWithBIP, options, linkingOptions, ssnMask);

    //get executives from inquired businesses
    busExecs := DueDiligence.getBusExec(linkedBus, options, mod_access);


    //get attribute data for individuals related to the inquired business
    busProfLicense := DueDiligence.getBusProfLic(busExecs, includeReport, mod_access);



    //get attribute data for the inquired business
    busProperty    := DueDiligence.getBusProperty(busProfLicense, options, linkingOptions);

    busWatercraft  := DueDiligence.getBusWatercraft(busProperty, options, linkingOptions, mod_access);

    busAircraft := DueDiligence.getBusAircraft(busWatercraft, options);

    busVehicle := DueDiligence.getBusVehicle(busAircraft, options, linkingOptions, mod_access);

    busReg := DueDiligence.getBusRegistration(busVehicle, options, TRUE);

    busGeoRisk := DueDiligence.getBusGeographicRisk(busReg);   

    busSales := DueDiligence.getBusSales(busGeoRisk, options, linkingOptions, mod_access);
    
    

    //attributes taking in inquired and linked businesses
    busHeader := DueDiligence.getBusHeader(busSales, options, linkingOptions, TRUE, includeReport, mod_access);

    busSOS := DueDiligence.getBusSOSDetail(busHeader, options, TRUE, includeReport);


    //attributes that must be called after other attributes
    addrRisk := DueDiligence.getBusAddrData(busSOS, options, includeReport);  //must be called after getBusSOSDetail & getBusRegistration

    busAsInd := DueDiligence.getBusAsInd(addrRisk, options, mod_access);  //must be called after getBusSOSDetail & getBusHeader



    addCounts := PROJECT(busAsInd, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
                                                SELF.numOfRegAgents := COUNT(LEFT.registeredAgents);
                                                SELF.execCount := COUNT(LEFT.execs);
                                                SELF := LEFT;));


    //if a report is requested, populate the data needed for report	
    addBusinessDataForReport := IF(includeReport, DueDiligence.getBusReport(addCounts, options, linkingOptions, ssnMask, mod_access), addCounts);

    //populate the index for the customer
    busKRI := DueDiligence.getBusKRI(addBusinessDataForReport + inquiredBusNoBIP);






    //debugging section  
    IF(debugMode, OUTPUT(inquiredBusWithBIP, NAMED('inquiredBusWithBIP')));
    IF(debugMode, OUTPUT(inquiredBusNoBIP, NAMED('inquiredBusNoBIP')));

    IF(debugMode, OUTPUT(linkedBus, NAMED('linkedBus')));	
    IF(debugMode, OUTPUT(busExecs, NAMED('busExecs')));
    IF(debugMode, OUTPUT(busProfLicense, NAMED('busProfLicense')));
    IF(debugMode, OUTPUT(busProperty, NAMED('busProperty')));
    IF(debugMode, OUTPUT(busWatercraft, NAMED('busWatercraft')));
    IF(debugMode, OUTPUT(busAircraft, NAMED('busAircraft')));	
    IF(debugMode, OUTPUT(busVehicle, NAMED('busVehicle')));	
    IF(debugMode, OUTPUT(busReg, NAMED('busReg')));	
    IF(debugMode, OUTPUT(busGeoRisk, NAMED('busGeoRisk')));	
    IF(debugMode, OUTPUT(busSales, NAMED('busSales')));

    IF(debugMode, OUTPUT(busHeader, NAMED('busHeader')));
    IF(debugMode, OUTPUT(busSOS, NAMED('busSOS')));

    IF(debugMode, OUTPUT(addrRisk, NAMED('addrRisk')));
    IF(debugMode, OUTPUT(busAsInd, NAMED('busAsInd')));
    IF(debugMode, OUTPUT(addBusinessDataForReport, NAMED('addBusinessDataForReport')));

    IF(debugMode, OUTPUT(busKRI, NAMED('busKRI')));


    RETURN busKRI;

END : DEPRECATED('Use DueDiligence.v3.getBusiness');

IMPORT BIPV2, Business_Risk_BIP, DueDiligence, Doxie;

EXPORT getIndReport(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                    Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                    BIPV2.mod_sources.iParams linkingOptions,
                    STRING6 ssnMask,
                    doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION



  
    getInputBestInfo := DueDiligence.reportIndBestInfo(inData, ssnMask);

    getPropertyReportData := DueDiligence.reportIndProperty(getInputBestInfo);

    getWatercraftReportData := DueDiligence.reportIndWatercraft(getPropertyReportData);

    getCriminalReportData := DueDiligence.reportIndCriminal(getWatercraftReportData, ssnMask);

    getProfessionalLicenseData := DueDiligence.reportIndProfLicense(getCriminalReportData);  

    getVehicleData := DueDiligence.reportIndVehicle(getProfessionalLicenseData);  

    getAircraftData := DueDiligence.reportIndAircraft(getVehicleData);

    getBusinessAssociationReportData := DueDiligence.reportIndBusAssoc(getAircraftData, options, linkingOptions, mod_access);
    
    getIdentityReportData := DueDiligence.reportIndIdentity(getBusinessAssociationReportData, options, ssnMask, mod_access);
    
    getMobilityReportData := DueDiligence.reportIndMobility(getIdentityReportData, options, mod_access);
    
    getPersonAssociateReportData := DueDiligence.reportIndAssociates(getMobilityReportData, ssnMask);
    
    getCivilEventReportData := DueDiligence.reportIndCivilEvent(getPersonAssociateReportData);




    // OUTPUT(getInputBestInfo, NAMED('getInputBestInfo'));
    // OUTPUT(getPropertyReportData, NAMED('getPropertyReportData'));
    // OUTPUT(getWatercraftReportData, NAMED('getWatercraftReportData'));
    // OUTPUT(getCriminalReportData, NAMED('getCriminalReportData'));
    // OUTPUT(getProfessionalLicenseData, NAMED('getProfessionalLicenseData'));
    // OUTPUT(getVehicleData, NAMED('getVehicleData'));
    // OUTPUT(getBusinessAssociationReportData, NAMED('getBusinessAssociationReportData'));
    // OUTPUT(getIdentityReportData, NAMED('getIdentityReportData'));
    // OUTPUT(getMobilityReportData, NAMED('getMobilityReportData'));
    // OUTPUT(getPersonAssociateReportData, NAMED('getPersonAssociateReportData'));
    // OUTPUT(getCivilEventReportData, NAMED('getCivilEventReportData'));


    RETURN getCivilEventReportData;     
END;
IMPORT BIPV2, Business_Risk_BIP, DueDiligence;

EXPORT getIndReport(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                    Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                    BIPV2.mod_sources.iParams linkingOptions) := FUNCTION


    getInputBestInfo := DueDiligence.reportIndBestInfo(inData, options.ssn_mask);

    getPropertyReportData := DueDiligence.reportIndProperty(getInputBestInfo);

    getWatercraftReportData := DueDiligence.reportIndWatercraft(getPropertyReportData);

    getProfessionalLicenseData := DueDiligence.reportIndProfLicense(getWatercraftReportData);

    getVehicleData := DueDiligence.reportIndVehicle(getProfessionalLicenseData);

    getAircraftData := DueDiligence.reportIndAircraft(getVehicleData);

    getBusinessAssociationReportData := DueDiligence.reportIndBusAssoc(getAircraftData, options, linkingOptions);

    getIdentityReportData := DueDiligence.reportIndIdentity(getBusinessAssociationReportData, options);

    getMobilityReportData := DueDiligence.reportIndMobility(getIdentityReportData, options);

    getPersonAssociateReportData := DueDiligence.reportIndAssociates(getMobilityReportData, options.ssn_mask);





    // OUTPUT(getInputBestInfo, NAMED('getInputBestInfo'));
    // OUTPUT(getPropertyReportData, NAMED('getPropertyReportData'));
    // OUTPUT(getWatercraftReportData, NAMED('getWatercraftReportData'));
    // OUTPUT(getProfessionalLicenseData, NAMED('getProfessionalLicenseData'));
    // OUTPUT(getVehicleData, NAMED('getVehicleData'));
    // OUTPUT(getBusinessAssociationReportData, NAMED('getBusinessAssociationReportData'));
    // OUTPUT(getIdentityReportData, NAMED('getIdentityReportData'));
    // OUTPUT(getMobilityReportData, NAMED('getMobilityReportData'));
    // OUTPUT(getPersonAssociateReportData, NAMED('getPersonAssociateReportData'));


    RETURN getPersonAssociateReportData;
END;

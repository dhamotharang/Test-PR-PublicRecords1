IMPORT BIPV2, Business_Risk_BIP, DueDiligence;

EXPORT getBusReport(DATASET(DueDiligence.layouts.Busn_Internal) busnData,
                    Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
                    BIPV2.mod_sources.iParams linkingOptions) := FUNCTION



    //This section is for masking FEIN and E5 sources - this data is only needed IF a report is requested
    addFeinSource := DueDiligence.getBusFeinSources(busnData, options, linkingOptions);


    //This section is for Operating Locations
    addOperatingLocToReport := DueDiligence.reportBusOperLocations(addFeinSource);

    //This section is for Operating Information
    addOperatingInfoToReport := DueDiligence.reportBusOperatingInformation(addOperatingLocToReport);

    //This section is for Registered Agents
    addRegisteredAgents := DueDiligence.reportBusRegisteredAgents(addOperatingInfoToReport, options, linkingOptions);

    //This section is for Best Business Information
    addBestData := DueDiligence.reportBusBestInfo(addRegisteredAgents);

    //This section is for Business Executives
    addExecutives := DueDiligence.reportBusExecs(addBestData, options, linkingOptions);

    //This section is for Shell Shelf Information
    addShellShelf := DueDiligence.reportBusShellShelf(addExecutives);

    //This section is for Property
    addProperty := DueDiligence.reportBusProperty(addShellShelf);

    //This section is for Watercraft
    addWatercraft := DueDiligence.reportBusWatercraft(addProperty);

    //This section is for Aircraft
    addAircraft := DueDiligence.reportBusAircraft(addWatercraft);

    //This section is for Vehicle
    addVehicle := DueDiligence.reportBusVehicle(addAircraft);



    //DEBUGGING OUTPUTS

    // OUTPUT(addFeinSource, NAMED('addFeinSource'));
    // OUTPUT(addOperatingLocToReport, NAMED('addOperatingLocToReport'));
    // OUTPUT(addOperatingInfoToReport, NAMED('addOperatingInfoToReport'));
    // OUTPUT(addRegisteredAgents, NAMED('addRegisteredAgents'));
    // OUTPUT(addBestData, NAMED('addBestData'));
    // OUTPUT(addExecutives, NAMED('addExecutives'));
    // OUTPUT(addShellShelf, NAMED('addShellShelf'));
    // OUTPUT(addProperty, NAMED('addProperty'));
    // OUTPUT(addWatercraft, NAMED('addWatercraft'));
    // OUTPUT(addAircraft, NAMED('addAircraft'));
    // OUTPUT(addVehicle, NAMED('addVehicle'));


    RETURN addVehicle;
END;

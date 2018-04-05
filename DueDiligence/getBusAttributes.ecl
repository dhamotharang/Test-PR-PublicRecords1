IMPORT BIPV2, Business_Risk_BIP, DueDiligence;

EXPORT getBusAttributes(DATASET(DueDiligence.Layouts.CleanedData) cleanedInput,
												Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
												BIPV2.mod_sources.iParams linkingOptions,
												BOOLEAN includeReport = FALSE,
												BOOLEAN debugMode = FALSE) := FUNCTION


	// ------                                                                                     ------
	// ------ Get the BIP IDs of the business passed in                                           ------  
	// ------ Notice the input address has already been cleaned prior to looking up the BIPID     ------
	// ------ Essentially this routine will either search by LEXID if it was input                ------
	// ------   OR                                                                                ------
	// ------ this routine will call the BIP Linking Process using the input address              ------
	// ------ and return the results back in the Busn_Internal layout for further processing      ------
	 
	inquiredBus := DueDiligence.getBusBIPId(cleanedInput, options, linkingOptions, includeReport);
	
	//seperate those with BIP IDs and those without/not found
	inquiredBusWithBIP := inquiredBus(Busn_Info.BIP_IDs.PowID.LinkID <> 0 OR Busn_Info.BIP_IDs.ProxID.LinkID <> 0 OR Busn_Info.BIP_IDs.SeleID.LinkID <> 0 OR Busn_Info.BIP_IDs.OrgID.LinkID <> 0 OR Busn_Info.BIP_IDs.UltID.LinkID <> 0);
	inquiredBusNoBIP := inquiredBus(Busn_Info.BIP_IDs.PowID.LinkID = 0 AND Busn_Info.BIP_IDs.ProxID.LinkID = 0 AND Busn_Info.BIP_IDs.SeleID.LinkID = 0 AND Busn_Info.BIP_IDs.OrgID.LinkID = 0 AND Busn_Info.BIP_IDs.UltID.LinkID = 0);
	
	//Get best data - best address for this LINKID (not everything was populated on the input).  This is our attempt to fill in what was not INPUT.
	//  Bus_Info is populated here.   
	busBestData := DueDiligence.getBusBestData(cleanedInput, inquiredBusWithBIP, options, linkingOptions, includeReport);
	
	//Get linked business to the business passed in
	linkedBus := DueDiligence.getBusLinkedBus(busBestData, options, linkingOptions);
	
	//Get executives from inquired businesses
	busExecs := DueDiligence.getBusExec(linkedBus, options, linkingOptions);
	
	//Get related businesses
	relatedBus := DATASET([], DueDiligence.Layouts.Busn_Internal);
	
	
	
	//get attribute data for individuals related to the inquired business
	busProfLicense := DueDiligence.getBusProfLic(busExecs, includeReport);
	

	//get attribute data for the inquired business
	busProperty := DueDiligence.getBusProperty(busProfLicense, options, linkingOptions);

	busWatercraft := DueDiligence.getBusWatercraft(busProperty, options, linkingOptions, includeReport);

	busAircraft := DueDiligence.getBusAircraft(busWatercraft, options);
	
	busVehicle := DueDiligence.getBusVehicle(busAircraft, options, linkingOptions);

	busReg := DueDiligence.getBusRegistration(busVehicle, options, linkingOptions);
	
	busGeoRisk := DueDiligence.getBusGeographicRisk(busReg, options, debugMode);   



	/*attributes taking in inquired and linked businesses*/
	busHeader := DueDiligence.getBusHeader(busGeoRisk, options, linkingOptions, includeReport);
	
	busSOS := DueDiligence.getBusSOSDetail(busHeader, options, linkingOptions, includeReport);

	
	
	/*attributes that must be called after other attributes*/
	addrRisk  := DueDiligence.getBusAddrData(busSOS, options);  //must be called after getBusSOSDetail & getBusRegistration
	
	busAsInd := DueDiligence.getBusAsInd(addrRisk, options);  //must be called after getBusSOSDetail
	
	busSicNaic := DueDiligence.getBusSicNaic(busAsInd, options, linkingOptions);  //must be called after getBusRegistration & getBusHeader & getBusSOSDetail




	//temp code to remove after dataset size selected
	addCounts := PROJECT(busSicNaic, TRANSFORM(RECORDOF(LEFT),
																										SELF.numOfRegAgents := COUNT(LEFT.registeredAgents);
																										SELF.numOfSicNaic := COUNT(LEFT.sicNaicSources);
																										SELF := LEFT;));



	//Populate the index for the customer
	busKRI := DueDiligence.getBusKRI(addCounts + inquiredBusNoBIP);

	
	
	
	/*debugging section */   
	IF(debugMode, OUTPUT(inquiredBus, NAMED('inquiredBus')));
	IF(debugMode, OUTPUT(inquiredBusWithBIP, NAMED('inquiredBusWithBIP')));
	IF(debugMode, OUTPUT(inquiredBusNoBIP, NAMED('inquiredBusNoBIP')));
	
	IF(debugMode, OUTPUT(busBestData, NAMED('busBestData')));	
	IF(debugMode, OUTPUT(linkedBus, NAMED('linkedBus')));	
	IF(debugMode, OUTPUT(busExecs, NAMED('busExecs')));
	IF(debugMode, OUTPUT(relatedBus, NAMED('relatedBus')));

	IF(debugMode, OUTPUT(busProfLicense, NAMED('busProfLicense')));
	
	IF(debugMode, OUTPUT(busProperty, NAMED('busProperty')));
	IF(debugMode, OUTPUT(busWatercraft, NAMED('busWatercraft')));
	IF(debugMode, OUTPUT(busAircraft, NAMED('busAircraft')));	
	IF(debugMode, OUTPUT(busVehicle, NAMED('busVehicle')));	
	IF(debugMode, OUTPUT(busReg, NAMED('busReg')));	
	IF(debugMode, OUTPUT(busGeoRisk, NAMED('busGeoRisk')));	
	
	IF(debugMode, OUTPUT(busHeader, NAMED('busHeader')));
	IF(debugMode, OUTPUT(busSOS, NAMED('busSOS')));
	
	IF(debugMode, OUTPUT(addrRisk, NAMED('addrRisk')));
	IF(debugMode, OUTPUT(busAsInd, NAMED('busAsInd')));
	IF(debugMode, OUTPUT(busSicNaic, NAMED('busSicNaic')));
	
	IF(debugMode, OUTPUT(busKRI, NAMED('busKRI')));


	RETURN busKRI;

END;
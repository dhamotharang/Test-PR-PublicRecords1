IMPORT BIPV2, Business_Risk_BIP, DueDiligence;

EXPORT getBusAttributes(DATASET(DueDiligence.Layouts.CleanedData) cleanedInput,
												Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
												BIPV2.mod_sources.iParams linkingOptions,
												BOOLEAN includeReport = FALSE,
												BOOLEAN debugMode = FALSE) := FUNCTION


	//Get the BIP IDs of the business passed in
	inquiredBus := DueDiligence.getBusBIPId(cleanedInput, options, linkingOptions, includeReport);
	
	//seperate those with BIP IDs and those without/not found
	inquiredBusWithBIP := inquiredBus(Busn_Info.BIP_IDs.PowID.LinkID <> 0 OR Busn_Info.BIP_IDs.ProxID.LinkID <> 0 OR Busn_Info.BIP_IDs.SeleID.LinkID <> 0 OR Busn_Info.BIP_IDs.OrgID.LinkID <> 0 OR Busn_Info.BIP_IDs.UltID.LinkID <> 0);
	inquiredBusNoBIP := inquiredBus(Busn_Info.BIP_IDs.PowID.LinkID = 0 AND Busn_Info.BIP_IDs.ProxID.LinkID = 0 AND Busn_Info.BIP_IDs.SeleID.LinkID = 0 AND Busn_Info.BIP_IDs.OrgID.LinkID = 0 AND Busn_Info.BIP_IDs.UltID.LinkID = 0);
	
	//Get best data
	busBestData := DueDiligence.getBusBestData(cleanedInput, inquiredBusWithBIP, options, linkingOptions, includeReport);
	
	//Get linked business to the business passed in
	linkedBus := DueDiligence.getBusLinkedBus(busBestData, options, linkingOptions);
	
	//count and add the number of linked businesses
	countLnkBus := TABLE(UNGROUP(linkedBus), {seq, unsigned3 linkdBusCount := count(group)}, seq);	
	addLnkBus := JOIN(busBestData, countLnkBus,
										LEFT.seq = RIGHT.seq,
										TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																SELF.LinkedBusncount := RIGHT.linkdBusCount;
																SELF := LEFT),
										LEFT OUTER);
	
	//Get executives from inquired and linked businesses
	busExecs := DATASET([], DueDiligence.Layouts.Busn_Internal); //DueDiligence.getBusExec(inquiredBusWithBIP + linkedBus, options, linkingOptions);
	
	//Get related businesses
	relatedBus := DATASET([], DueDiligence.Layouts.Busn_Internal);



	//Get business address risk data - currently only inquired business
	addrRisk  := DueDiligence.getBusAddrData(addLnkBus, options);
	
		
	
	
	/*attributes only taking in inquired businesses*/
	busProperty := DueDiligence.getBusProperty(addrRisk, options, linkingOptions, debugMode);

	busWatercraft := DueDiligence.getBusWatercraft(busProperty, options, linkingOptions, debugMode);

	busAircraft := DueDiligence.getBusAircraft(busWatercraft, options, debugMode);
	
	busVehicle := DueDiligence.getBusVehicle(busAircraft, options, linkingOptions);

	busReg := DueDiligence.getBusRegistration(busVehicle, options, linkingOptions);


	/*attributes taking in inquired and linked businesses*/
	busHeader := DueDiligence.getBusHeader(busReg + linkedBus, options, linkingOptions);
	
	busSOS := DueDiligence.getBusSOSDetail(busHeader + linkedBus, options, linkingOptions);

	
	
	/*attributes that must be called after all other attributes*/
	busSicNaic := DueDiligence.getBusSicNaic(busSOS, options, linkingOptions);



	//Populate the index for the customer
	busKRI := DueDiligence.getBusKRI(busSicNaic + inquiredBusNoBIP);

	
	
	
	/*debugging section */   
	IF(debugMode, OUTPUT(inquiredBus, NAMED('inquiredBus')));
	IF(debugMode, OUTPUT(inquiredBusWithBIP, NAMED('inquiredBusWithBIP')));
	IF(debugMode, OUTPUT(inquiredBusNoBIP, NAMED('inquiredBusNoBIP')));
	
	IF(debugMode, OUTPUT(busBestData, NAMED('busBestData')));	
	IF(debugMode, OUTPUT(linkedBus, NAMED('linkedBus')));	
	IF(debugMode, OUTPUT(busExecs, NAMED('busExecs')));
	IF(debugMode, OUTPUT(relatedBus, NAMED('relatedBus')));
	
	IF(debugMode, OUTPUT(addrRisk, NAMED('addrRisk')));
	
	IF(debugMode, OUTPUT(busProperty, NAMED('busProperty')));
	IF(debugMode, OUTPUT(busWatercraft, NAMED('busWatercraft')));
	IF(debugMode, OUTPUT(busAircraft, NAMED('busAircraft')));	
	IF(debugMode, OUTPUT(busVehicle, NAMED('busVehicle')));	
	IF(debugMode, OUTPUT(busReg, NAMED('busReg')));	
	IF(debugMode, OUTPUT(busHeader, NAMED('busHeader')));
	IF(debugMode, OUTPUT(busSOS, NAMED('busSOS')));
	
	IF(debugMode, OUTPUT(busSicNaic, NAMED('busSicNaic')));
	
	IF(debugMode, OUTPUT(busKRI, NAMED('busKRI')));


	RETURN busKRI;

END;
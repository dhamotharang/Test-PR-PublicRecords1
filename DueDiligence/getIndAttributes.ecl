IMPORT Risk_Indicators, Business_Risk, Models, iesp, doxie, Gateway, ut, Address, AutoStandardI;

EXPORT getIndAttributes(DATASET(DueDiligence.Layouts.CleanedData) cleanedInput,
												UNSIGNED1 dppa,
												UNSIGNED1 glba,
												STRING dataRestrictionMask,
												DATASET(Gateway.Layouts.Config) gateways,
												BOOLEAN includeReport = FALSE,
												BOOLEAN displayAttributeText = FALSE,
												BOOLEAN debugMode = FALSE) := FUNCTION
																						 

	INTEGER bsVersion := 50;
	UNSIGNED8 bsOptions :=  0;
	BOOLEAN isFCRA := FALSE;
	
	
	//get the DID of the inquired individual
	inquiredInd := DueDiligence.getIndDID(cleanedInput, dataRestrictionMask, dppa, glba, bsVersion, bsOptions, gateways, includeReport);
	
	didFound := inquiredInd(individual.did <> 0);
	noDIDFound := inquiredInd(individual.did = 0);
	
	//get the best data for the individual if do not have it
	inquiredBest := DueDiligence.getIndBestData(didFound, dppa, glba, includeReport);
	
	//get relatives of the inquired individual
	inquiredRelatives := DueDiligence.getIndRelatives(inquiredBest, dppa, glba, includeReport);
	
	//get header information
	// indHeader := DueDiligence.getIndHeader(inquiredRelatives, dppa, glba, isFCRA, includeReport);
	
	//get information pertaining to SSN
	//indSSNData := DueDiligence.getIndSSNData(indHeader, dataRestrictionMask, dppa, glba, bsVersion, bsOptions, isFCRA, includeReportData);
	
	
	//populate the attributes and flags
	indKRI := DueDiligence.getIndKRI(inquiredRelatives + noDIDFound);
	
	
	


	/*debugging section */   
	IF(debugMode, OUTPUT(inquiredInd, NAMED('inquiredInd')));
	IF(debugMode, OUTPUT(didFound, NAMED('didFound')));
	IF(debugMode, OUTPUT(noDIDFound, NAMED('noDIDFound')));
	IF(debugMode, OUTPUT(inquiredBest, NAMED('inquiredBest')));
	
	
	IF(debugMode, OUTPUT(inquiredRelatives, NAMED('inquiredRelatives')));
	// IF(debugMode, OUTPUT(indHeader, NAMED('indHeader')));
	// IF(debugMode, OUTPUT(indSSNData, NAMED('indSSNData')));
	
	IF(debugMode, OUTPUT(indKRI, NAMED('indKRI')));



	RETURN indKRI;

END;

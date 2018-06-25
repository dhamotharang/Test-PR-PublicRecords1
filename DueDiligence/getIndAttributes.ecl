IMPORT DueDiligence, Risk_Indicators, Business_Risk, Models, iesp, doxie, ut, Address, AutoStandardI;

EXPORT getIndAttributes(DATASET(DueDiligence.Layouts.CleanedData) cleanedInput,
                        UNSIGNED1 dppa,
                        UNSIGNED1 glba,
                        STRING dataRestrictionMask,
                        STRING6 ssnMask,
                        BOOLEAN includeReport = FALSE,
                        BOOLEAN displayAttributeText = FALSE,
                        BOOLEAN debugMode = FALSE) := FUNCTION
																						 

	INTEGER bsVersion := DueDiligence.Constants.DEFAULT_BS_VERSION;   //Use the default Boca Shell Version of 50 to get the default handling for getting our DID's
	UNSIGNED8 bsOptions := DueDiligence.Constants.DEFAULT_BS_OPTIONS;
	BOOLEAN isFCRA := DueDiligence.Constants.DEFAULT_IS_FCRA;

	
	
	//get the DID of the inquired individual
	inquiredInd := DueDiligence.getIndDID(cleanedInput, dataRestrictionMask, dppa, glba, bsVersion, bsOptions, includeReport);
	
	didFound := inquiredInd(inquiredDID <> 0);
	noDIDFound := inquiredInd(inquiredDID = 0);
	
	//get the best data for the individual if do not have it
	indBest := DueDiligence.getIndBestData(didFound, dppa, glba, includeReport);
  
  //get geographic risk of the inquired individual's address  
  indGeoRisk := DueDiligence.getIndGeographicRisk(indBest, dppa, glba, includeReport);
  
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
  
  //get legal information
  indCriminalData := DueDiligence.getIndLegalEvents(indProperty, includeReport);
  
  //if a person report is being requested, populate the report
  indReportData :=  IF(includeReport, DueDiligence.getIndReport(indCriminalData, ssnMask),
                                      indCriminalData);
	
	
	//populate the attributes and flags
	indKRI := DueDiligence.getIndKRI(indReportData + noDIDFound);
	
	

	/*debugging section */   
	IF(debugMode, OUTPUT(cleanedInput, NAMED('cleanedInput')));
	IF(debugMode, OUTPUT(inquiredInd, NAMED('inquiredInd')));
	IF(debugMode, OUTPUT(didFound, NAMED('didFound')));
	IF(debugMode, OUTPUT(noDIDFound, NAMED('noDIDFound')));
	IF(debugMode, OUTPUT(indBest, NAMED('indBest')));
	IF(debugMode, OUTPUT(indGeoRisk, NAMED('indGeoRisk')));
	IF(debugMode, OUTPUT(indProfLic, NAMED('indProfLic')));
	IF(debugMode, OUTPUT(indRelatives, NAMED('indRelatives')));
	IF(debugMode, OUTPUT(indHeader, NAMED('indHeader')));
	IF(debugMode, OUTPUT(indSSNData, NAMED('indSSNData')));
	IF(debugMode, OUTPUT(indProperty, NAMED('indProperty')));
	IF(debugMode, OUTPUT(indCriminalData, NAMED('indCriminalData')));
	IF(debugMode, OUTPUT(indKRI, NAMED('indKRI')));



	RETURN indKRI;

END;
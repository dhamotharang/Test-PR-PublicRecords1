EXPORT DueDiligenceBatchMain(input, inGLBA, inDPPA) := FUNCTIONMACRO

  //FBOP (Federal Bureau Of Prison) specific field
  //FBOP Date Tolerance
  UNSIGNED1 FBOP_DateTolerance := DueDiligence.Constants.NUMERIC_ZERO : STORED('FBOP_DateTolerance');
  UNSIGNED1 FBOP_DateToleranceYearsPrior := DueDiligence.Constants.NUMERIC_ZERO : STORED('FBOP_DateToleranceYearsPrior');
  
  //FBOP Name Tolerance
  BOOLEAN FBOP_includeRequiredExactInputLastName := FALSE : STORED('FBOP_IncludeExactInputLastName');
  BOOLEAN FBOP_includeNicknames := FALSE : STORED('FBOP_IncludeNicknames');
  UNSIGNED1 FBOP_nameOrderSearched := DueDiligence.Constants.NUMERIC_ZERO : STORED('FBOP_NameOrderSearched');
  
  //FBOP Age Tolerance
  BOOLEAN FBOP_includeLexIDPrimaryDOBYear := FALSE : STORED('FBOP_IncludeLexIDPrimaryDOBYear');
  BOOLEAN FBOP_includeDOBYearRadius := FALSE : STORED('FBOP_IncludeDOBYearRadius');
  UNSIGNED1 FBOP_DOBNumberOfYearsRadius := DueDiligence.Constants.NUMERIC_ZERO : STORED('FBOP_DOBNumberOfYearsRadius');
  
  //validate the requests
	validatedRequests := DueDiligence.CommonQuery.ValidateRequest(input, inGLBA, inDPPA, DueDiligence.Constants.ATTRIBUTES);
  
  //clean data
  cleanData := DueDiligence.CommonQuery.GetCleanData(validatedRequests(validRequest));


	//Keep track of individual vs business requests
	indRecs :=  cleanData(inputEcho.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS);
  busRecs :=  cleanData(inputEcho.requestedVersion IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS);
  
  DueDiligence.CommonQuery.mac_GetBusinessOptionSettings(inDPPA, inGLBA, dataRestriction, dataPermission, Business_Risk_BIP.Constants.Default_IndustryClass);


	//********************************************************PERSON ATTRIBUTES STARTS HERE**********************************************************
	consumerResults := DueDiligence.getIndAttributes(indRecs, inDPPA, inGLBA, dataRestriction, DueDiligence.Constants.EMPTY, FALSE, FALSE, FALSE, busOptions, busLinkingOptions);
																				 
  indIndex := JOIN(indRecs, consumerResults, 
										LEFT.inputEcho.seq = RIGHT.seq, 
										TRANSFORM(DueDiligence.Layouts.BatchOut,
                              SELF.seq := IF(LEFT.inputEcho.inputSeq = DueDiligence.Constants.NUMERIC_ZERO, LEFT.inputEcho.seq, LEFT.inputEcho.inputSeq);
                              SELF.acctNo := LEFT.inputEcho.individual.accountNumber;
                              
                              SELF.PerLexID := RIGHT.PerLexID;
                              SELF.PerAssetOwnProperty := RIGHT.PerAssetOwnProperty;
                              SELF.PerAssetOwnProperty_Flag := RIGHT.PerAssetOwnProperty_Flag;
                              SELF.PerAssetOwnAircraft := RIGHT.PerAssetOwnAircraft;
                              SELF.PerAssetOwnAircraft_Flag := RIGHT.PerAssetOwnAircraft_Flag;
                              SELF.PerAssetOwnWatercraft := RIGHT.PerAssetOwnWatercraft;
                              SELF.PerAssetOwnWatercraft_Flag := RIGHT.PerAssetOwnWatercraft_Flag;
                              SELF.PerAssetOwnVehicle := RIGHT.PerAssetOwnVehicle;
                              SELF.PerAssetOwnVehicle_Flag := RIGHT.PerAssetOwnVehicle_Flag;
                              SELF.PerAccessToFundsIncome := RIGHT.PerAccessToFundsIncome;
                              SELF.PerAccessToFundsIncome_Flag := RIGHT.PerAccessToFundsIncome_Flag;
                              SELF.PerAccessToFundsProperty := RIGHT.PerAccessToFundsProperty;
                              SELF.PerAccessToFundsProperty_Flag := RIGHT.PerAccessToFundsProperty_Flag;		
                              SELF.PerGeographic := RIGHT.PerGeographic;
                              SELF.PerGeographic_Flag := RIGHT.PerGeographic_Flag;
                              SELF.PerMobility := RIGHT.PerMobility;
                              SELF.PerMobility_Flag := RIGHT.PerMobility_Flag;
                              SELF.PerStateLegalEvent := RIGHT.PerStateLegalEvent;
                              SELF.PerStateLegalEvent_Flag := RIGHT.PerStateLegalEvent_Flag;
                              SELF.PerFederalLegalEvent := RIGHT.PerFederalLegalEvent;
                              SELF.PerFederalLegalEvent_Flag := RIGHT.PerFederalLegalEvent_Flag;
                              SELF.PerFederalLegalMatchLevel := RIGHT.PerFederalLegalMatchLevel;
                              SELF.PerFederalLegalMatchLevel_Flag := RIGHT.PerFederalLegalMatchLevel_Flag;                              
                              SELF.PerCivilLegalEvent := RIGHT.PerCivilLegalEvent;
                              SELF.PerCivilLegalEvent_Flag := RIGHT.PerCivilLegalEvent_Flag;
                              SELF.PerOffenseType := RIGHT.PerOffenseType;
                              SELF.PerOffenseType_Flag := RIGHT.PerOffenseType_Flag;
                              SELF.PerAgeRange := RIGHT.PerAgeRange;
                              SELF.PerAgeRange_Flag := RIGHT.PerAgeRange_Flag;
                              SELF.PerIdentityRisk := RIGHT.PerIdentityRisk;
                              SELF.PerIdentityRisk_Flag := RIGHT.PerIdentityRisk_Flag;
                              SELF.PerUSResidency := RIGHT.PerUSResidency;
                              SELF.PerUSResidency_Flag := RIGHT.PerUSResidency_Flag;
                              SELF.PerMatchLevel := RIGHT.PerMatchLevel;
                              SELF.PerMatchLevel_Flag := RIGHT.PerMatchLevel_Flag;
                              SELF.PerAssociates := RIGHT.PerAssociates;
                              SELF.PerAssociates_Flag := RIGHT.PerAssociates_Flag;
                              SELF.PerProfLicense := RIGHT.PerProfLicense;
                              SELF.PerProfLicense_Flag := RIGHT.PerProfLicense_Flag;
                              SELF.PerBusAssociations := RIGHT.PerBusAssociations;
                              SELF.PerBusAssociations_Flag := RIGHT.PerBusAssociations_Flag;
                              
                              SELF := [];), 
                    LEFT OUTER);  	  



//********************************************************BUSINESS ATTRIBUTES STARTS HERE********************************************************
 
	businessResults := DueDiligence.getBusAttributes(busRecs, busOptions, busLinkingOptions);
														 
  busIndex := JOIN(busRecs, businessResults,
										LEFT.inputEcho.seq = RIGHT.seq, 
										TRANSFORM(DueDiligence.Layouts.BatchOut,
                              SELF.seq := IF(RIGHT.busn_input.inputSeq = DueDiligence.Constants.NUMERIC_ZERO, RIGHT.seq, RIGHT.busn_input.inputSeq);
                              SELF.acctNo := RIGHT.busn_input.accountNumber;
                              
                              SELF.BusLexID := RIGHT.BusLexID;
                              SELF.BusAssetOwnProperty := RIGHT.BusAssetOwnProperty;
                              SELF.BusAssetOwnProperty_Flag := RIGHT.BusAssetOwnProperty_Flag;
                              SELF.BusAssetOwnAircraft := RIGHT.BusAssetOwnAircraft;
                              SELF.BusAssetOwnAircraft_Flag := RIGHT.BusAssetOwnAircraft_Flag;
                              SELF.BusAssetOwnWatercraft := RIGHT.BusAssetOwnWatercraft;
                              SELF.BusAssetOwnWatercraft_Flag := RIGHT.BusAssetOwnWatercraft_Flag;
                              SELF.BusAssetOwnVehicle := RIGHT.BusAssetOwnVehicle;
                              SELF.BusAssetOwnVehicle_Flag := RIGHT.BusAssetOwnVehicle_Flag;
                              SELF.BusAccessToFundsProperty := RIGHT.BusAccessToFundsProperty;
                              SELF.BusAccessToFundsProperty_Flag := RIGHT.BusAccessToFundsProperty_Flag;
                              SELF.BusGeographic := RIGHT.BusGeographic;
                              SELF.BusGeographic_Flag := RIGHT.BusGeographic_Flag;
                              SELF.BusValidity := RIGHT.BusValidity;
                              SELF.BusValidity_Flag := RIGHT.BusValidity_Flag;
                              SELF.BusStability := RIGHT.BusStability;
                              SELF.BusStability_Flag := RIGHT.BusStability_Flag;
                              SELF.BusIndustry := RIGHT.BusIndustry;
                              SELF.BusIndustry_Flag := RIGHT.BusIndustry_Flag;
                              SELF.BusStructureType := RIGHT.BusStructureType;
                              SELF.BusStructureType_Flag := RIGHT.BusStructureType_Flag;
                              SELF.BusSOSAgeRange := RIGHT.BusSOSAgeRange;
                              SELF.BusSOSAgeRange_Flag := RIGHT.BusSOSAgeRange_Flag;
                              SELF.BusPublicRecordAgeRange := RIGHT.BusPublicRecordAgeRange;
                              SELF.BusPublicRecordAgeRange_Flag := RIGHT.BusPublicRecordAgeRange_Flag;
                              SELF.BusShellShelf := RIGHT.BusShellShelf;
                              SELF.BusShellShelf_Flag := RIGHT.BusShellShelf_Flag;
                              SELF.BusMatchLevel := RIGHT.BusMatchLevel;
                              SELF.BusMatchLevel_Flag := RIGHT.BusMatchLevel_Flag;
                              SELF.BusStateLegalEvent := RIGHT.BusStateLegalEvent;
                              SELF.BusStateLegalEvent_Flag := RIGHT.BusStateLegalEvent_Flag;
                              SELF.BusFederalLegalEvent := RIGHT.BusFederalLegalEvent;
                              SELF.BusFederalLegalEvent_Flag := RIGHT.BusFederalLegalEvent_Flag;
                              SELF.BusFederalLegalMatchLevel := RIGHT.BusFederalLegalMatchLevel;
                              SELF.BusFederalLegalMatchLevel_Flag := RIGHT.BusFederalLegalMatchLevel_Flag;
                              SELF.BusCivilLegalEvent := RIGHT.BusCivilLegalEvent;
                              SELF.BusCivilLegalEvent_Flag := RIGHT.BusCivilLegalEvent_Flag;
                              SELF.BusOffenseType := RIGHT.BusOffenseType;
                              SELF.BusOffenseType_Flag := RIGHT.BusOffenseType_Flag;
                              SELF.BusBEOProfLicense := RIGHT.BusBEOProfLicense;
                              SELF.BusBEOProfLicense_Flag := RIGHT.BusBEOProfLicense_Flag;
                              SELF.BusBEOUSResidency := RIGHT.BusBEOUSResidency;
                              SELF.BusBEOUSResidency_Flag := RIGHT.BusBEOUSResidency_Flag;
                              
                              SELF := [];), 
                    LEFT OUTER); 
							

	final :=  UNGROUP(indIndex) + UNGROUP(busIndex);
  

  RETURN final;
  
ENDMACRO;
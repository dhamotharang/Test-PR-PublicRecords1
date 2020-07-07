IMPORT BIPV2, Business_Risk_BIP, DueDiligence;

EXPORT DueDiligenceBatchMain(DATASET(DueDiligence.LayoutsInternal.SharedInput) inData,
                             Business_Risk_BIP.LIB_Business_Shell_LIBIN busOptions, 
                             BIPV2.mod_sources.iParams busLinkingOptions,
                             unsigned1 LexIdSourceOptout = 1,
                             string TransactionID = '',
                             string BatchUID = '',
                             unsigned6 GlobalCompanyId = 0) := FUNCTION

  
  //Keep track of individual vs business requests
  indRecs :=  inData(cleanedInput.containsPersonReq);
  busRecs :=  inData(cleanedInput.containsPersonReq = FALSE);
  

  //********************************************************PERSON ATTRIBUTES STARTS HERE**********************************************************
  consumerResults := DueDiligence.getIndAttributes(indRecs, DueDiligence.Constants.EMPTY, FALSE, busOptions, busLinkingOptions,
                                                                                          LexIdSourceOptout := LexIdSourceOptout, 
                                                                                          TransactionID := TransactionID, 
                                                                                          BatchUID := BatchUID, 
                                                                                          GlobalCompanyID := GlobalCompanyID);
                                         
  indIndex := JOIN(indRecs, consumerResults, 
                    LEFT.cleanedInput.seq = RIGHT.seq, 
                    TRANSFORM(DueDiligence.Layouts.BatchOut,
                              SELF.seq := LEFT.cleanedInput.seq;
                              SELF.acctNo := LEFT.inputEcho.individual.accountNumber;

                              SELF.PerLexID := RIGHT.PerLexID;
                              SELF.PerLexIDMatch := RIGHT.PerLexIDMatch;
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
                              SELF.PerEmploymentIndustry := RIGHT.PerEmploymentIndustry;
                              SELF.PerEmploymentIndustry_Flag := RIGHT.PerEmploymentIndustry_Flag;

                              SELF := [];), 
                    LEFT OUTER);  	  



  //********************************************************BUSINESS ATTRIBUTES STARTS HERE********************************************************
  businessResults := DueDiligence.getBusAttributes(busRecs, DueDiligence.Constants.EMPTY, FALSE, busOptions, busLinkingOptions,
                                                                                          LexIdSourceOptout := LexIdSourceOptout, 
                                                                                          TransactionID := TransactionID, 
                                                                                          BatchUID := BatchUID, 
                                                                                          GlobalCompanyID := GlobalCompanyID);
                             
  busIndex := JOIN(busRecs, businessResults,
                    LEFT.cleanedInput.seq = RIGHT.seq, 
                    TRANSFORM(DueDiligence.Layouts.BatchOut,
                              SELF.seq := LEFT.cleanedInput.seq;
                              SELF.acctNo := LEFT.inputEcho.business.accountNumber;

                              SELF.BusLexID := RIGHT.BusLexID;
                              SELF.BusLexIDMatch := RIGHT.BusLexIDMatch;
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
                              SELF.BusAccessToFundSales := RIGHT.BusAccessToFundSales;
                              SELF.BusAccessToFundsSales_Flag := RIGHT.BusAccessToFundsSales_Flag;
                              SELF.BusBEOAccessToFundsProperty := RIGHT.BusBEOAccessToFundsProperty;
                              SELF.BusBEOAccessToFundsProperty_Flag := RIGHT.BusBEOAccessToFundsProperty_Flag;
                              SELF.BusLinkedBusinesses := RIGHT.BusLinkedBusinesses;
                              SELF.BusLinkedBusinesses_Flag := RIGHT.BusLinkedBusinesses_Flag;

                              SELF := [];), 
                    LEFT OUTER); 
							

  final :=  UNGROUP(indIndex) + UNGROUP(busIndex);
  

  RETURN final;
END;
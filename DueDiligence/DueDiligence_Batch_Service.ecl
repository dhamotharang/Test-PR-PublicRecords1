IMPORT Risk_Indicators, Business_Risk_BIP, BIPV2, DueDiligence, STD, WSInput;

EXPORT DueDiligence_Batch_Service() := FUNCTION
	
	//The following macro defines the field sequence on WsECL page of query. 
  WSInput.MAC_DueDiligence_Batch_Service();
  
  // Can't have duplicate definitions of Stored with different default values, 
  // so add the default to #stored to eliminate the assignment of a default value.
  #STORED('glbPurpose',  DueDiligence.Constants.DEFAULT_GLBA);
  #STORED('dppaPurpose', DueDiligence.Constants.DEFAULT_DPPA);
  #STORED('dataRestrictionMask', Risk_indicators.iid_constants.default_DataRestriction);
  #STORED('dataPermissionMask',  Risk_Indicators.iid_constants.default_DataPermission);
  
								

  batch_in  := DATASET([], DueDiligence.Layouts.BatchInLayout ) : STORED('batch_in');
  
  UNSIGNED1 glba := DueDiligence.Constants.DEFAULT_GLBA : STORED('glbPurpose');
	UNSIGNED1 dppa := DueDiligence.Constants.DEFAULT_DPPA : STORED('dppaPurpose');
	
  UNSIGNED1 attributesVersion := DueDiligence.Constants.VERSION_3 : STORED('attributesVersion'); 

	STRING	dataRestriction := Risk_indicators.iid_constants.default_DataRestriction : STORED('dataRestrictionMask');
  STRING 	dataPermission := Risk_Indicators.iid_constants.default_DataPermission : STORED('dataPermissionMask');




	wseq := PROJECT(batch_in, TRANSFORM(DueDiligence.Layouts.Input,
                                      customerType := STD.Str.ToUpperCase(LEFT.custType);
	
                                      version := MAP(attributesVersion = DueDiligence.Constants.VERSION_3 AND customerType = DueDiligence.Constants.INDIVIDUAL => DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3,
                                                      attributesVersion = DueDiligence.Constants.VERSION_3 AND customerType = DueDiligence.Constants.BUSINESS => DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3,
                                                      DueDiligence.Constants.INVALID);
                                    
                                    
                                      address_in := DATASET([TRANSFORM(DueDiligence.Layouts.Address,
                                                                        SELF.streetAddress1 := TRIM(LEFT.streetAddress1);
                                                                        SELF.streetAddress2 := TRIM(LEFT.streetAddress2);
                                                                        SELF.prim_range := TRIM(LEFT.prim_range);
                                                                        SELF.predir := TRIM(LEFT.predir);
                                                                        SELF.prim_name := TRIM(LEFT.prim_name);
                                                                        SELF.addr_suffix := TRIM(LEFT.addr_suffix);
                                                                        SELF.postdir := TRIM(LEFT.postdir);
                                                                        SELF.unit_desig := TRIM(LEFT.unit_desig);
                                                                        SELF.sec_range := TRIM(LEFT.sec_range);
                                                                        SELF.city := TRIM(LEFT.city);
                                                                        SELF.state := TRIM(LEFT.state);
                                                                        SELF.zip5 := TRIM(LEFT.zip5);
                                                                        SELF := [];)]);
                                                                          
                                      ind_in := IF(version IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, 
                                                          DATASET([TRANSFORM(DueDiligence.Layouts.Indv_Input,
                                                                              SELF.lexID := TRIM(LEFT.lexID);
                                                                              SELF.nameInputOrder := TRIM(LEFT.nameInputOrder);
                                                                              SELF.name := DATASET([TRANSFORM(DueDiligence.Layouts.Name,
                                                                                                              SELF.fullName := TRIM(LEFT.fullName);
                                                                                                              SELF.firstName := TRIM(LEFT.firstName);
                                                                                                              SELF.middleName := TRIM(LEFT.middleName);
                                                                                                              SELF.lastName := TRIM(LEFT.lastName);
                                                                                                              SELF.suffix := TRIM(LEFT.suffix);
                                                                                                              SELF := [];)])[1];
                                                                              SELF.address := address_in[1];
                                                                              SELF.phone := TRIM(LEFT.phone);
                                                                              SELF.ssn := TRIM(LEFT.taxID);
                                                                              SELF.accountNumber := TRIM(LEFT.acctNo);
                                                                              SELF.inputSeq := LEFT.seq;
                                                                              SELF := [];)]),
                                                          DATASET([], DueDiligence.Layouts.Indv_Input));
                                                                    
                                      bus_in := IF(version IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS, 
                                                          DATASET([TRANSFORM(DueDiligence.Layouts.Busn_Input,
                                                                              SELF.lexID := TRIM(LEFT.lexID);
                                                                              SELF.accountNumber := TRIM(LEFT.acctNo);
                                                                              SELF.companyName := TRIM(LEFT.companyName);
                                                                              SELF.altCompanyName := TRIM(LEFT.altCompanyName);
                                                                              SELF.address := address_in[1];
                                                                              SELF.fein := TRIM(LEFT.taxID);
                                                                              SELF.inputSeq := LEFT.seq;
                                                                              SELF := [];,)]),
                                                          DATASET([], DueDiligence.Layouts.Busn_Input));
                                                                    
                                                                      
                                      SELF.seq := COUNTER;
                                      SELF.individual := ind_in[1];
                                      SELF.business := bus_in[1];
                                      SELF.historyDateYYYYMMDD := IF((UNSIGNED4)LEFT.HistoryDateYYYYMMDD = DueDiligence.Constants.NUMERIC_ZERO, DueDiligence.Constants.date8Nines, (UNSIGNED4)LEFT.HistoryDateYYYYMMDD);
                                      SELF.requestedVersion := version;
                                      SELF := [];));
	
	validatedRequests := DueDiligence.CommonQuery.ValidateRequest(wseq, glba, dppa);
  
  //clean data
  cleanData := DueDiligence.CommonQuery.GetCleanData(validatedRequests(validRequest));

	//Keep track of individual vs business requests
	indRecs :=  cleanData(inputEcho.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS);
  busRecs :=  cleanData(inputEcho.requestedVersion IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS);


	//********************************************************PERSON ATTRIBUTES STARTS HERE**********************************************************
	consumerResults := DueDiligence.getIndAttributes(indRecs, dppa, glba, dataRestriction, DueDiligence.Constants.EMPTY);
																				 
  indIndex := JOIN(indRecs, consumerResults, 
										LEFT.inputEcho.seq = RIGHT.seq, 
										TRANSFORM(DueDiligence.Layouts.BatchOut,
                              SELF.seq := RIGHT.indvRawInput.inputSeq;
                              SELF.acctNo := RIGHT.indvRawInput.accountNumber;
                              
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
                              
                              SELF := [];), 
                    LEFT OUTER);  	  



//********************************************************BUSINESS ATTRIBUTES STARTS HERE********************************************************
  DueDiligence.CommonQuery.mac_GetBusinessOptionSettings(dppa, glba, dataRestriction, dataPermission, Business_Risk_BIP.Constants.Default_IndustryClass);


	businessResults := DueDiligence.getBusAttributes(busRecs, busOptions, busLinkingOptions);
														 
  busIndex := JOIN(busRecs, businessResults,
										LEFT.inputEcho.seq = RIGHT.seq, 
										TRANSFORM(DueDiligence.Layouts.BatchOut,
                              SELF.seq := RIGHT.busn_input.inputSeq;
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

		
	RETURN OUTPUT(final, NAMED('Results'));
															 
END;


/*--SOAP-- 
<message name="duediligence.duediligence_batch_service">
	<part name="batch_in" sequence="1" type="tns:XmlDataset"/>
	<part name="attributesversion" sequence="2" type="xsd:integer"/>
	<part name="glbapurpose" sequence="5" type="xsd:integer"/>
	<part name="dppapurpose" sequence="6" type="xsd:integer"/>
	<part name="datarestriction" sequence="7" type="xsd:string"/>
	<part name="datapermissionmask" sequence="8" type="xsd:string"/>
</message>
*/


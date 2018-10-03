IMPORT BIPV2, Business_Risk_BIP, Citizenship, DueDiligence, Risk_Indicators, STD, WSInput;

EXPORT DueDiligence_Batch_Service() := FUNCTION
	
	//The following macro defines the field sequence on WsECL page of query. 
  WSInput.MAC_DueDiligence_Batch_Service();
  
  // Can't have duplicate definitions of Stored with different default values, 
  // so add the default to #stored to eliminate the assignment of a default value.
  #STORED('glbPurpose',  DueDiligence.Constants.DEFAULT_GLBA);
  #STORED('dppaPurpose', DueDiligence.Constants.DEFAULT_DPPA);
  #STORED('dataRestrictionMask', Risk_indicators.iid_constants.default_DataRestriction);
  #STORED('dataPermissionMask',  Risk_Indicators.iid_constants.default_DataPermission);
  
								
  //Shared input - used in both citizenship and due diligence
  batch_in  := DATASET([], DueDiligence.Layouts.BatchInLayout ) : STORED('batch_in');
  
  UNSIGNED1 glba := DueDiligence.Constants.DEFAULT_GLBA : STORED('glbPurpose');
	UNSIGNED1 dppa := DueDiligence.Constants.DEFAULT_DPPA : STORED('dppaPurpose');

	STRING	dataRestriction := Risk_indicators.iid_constants.default_DataRestriction : STORED('dataRestrictionMask');
  STRING 	dataPermission := Risk_Indicators.iid_constants.default_DataPermission : STORED('dataPermissionMask');
  
  BOOLEAN debugIndicator := FALSE : STORED('debugMode');
  
  //Due Diligence specific field	
  UNSIGNED1 attributesVersion := DueDiligence.Constants.VERSION_0 : STORED('attributesVersion'); 
  
  //Citizenship specific field
  STRING modelName := DueDiligence.Constants.EMPTY : STORED('modelName');
	BOOLEAN validateModel := FALSE : STORED('modelValidation');

  
  
  //Determine which product(s) need to be called - Citizenship and/or Due Diligence
  BOOLEAN callCitizenship := modelName != DueDiligence.Constants.EMPTY;
  BOOLEAN callDueDiligence := attributesVersion > DueDiligence.Constants.VERSION_0;
  
  requestedProducts := MAP(callCitizenship AND callDueDiligence => DueDiligence.CitDDShared.PRODUCT_REQUESTED_ENUM.BOTH,
                            callCitizenship => DueDiligence.CitDDShared.PRODUCT_REQUESTED_ENUM.CITIZENSHIP_ONLY,
                            DueDiligence.CitDDShared.PRODUCT_REQUESTED_ENUM.ATTRIBUTES_ONLY);
  
  
  //Transform data into a shared common input layout
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
                                                                          
                                      ind_in := IF(version IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS OR modelName != DueDiligence.Constants.EMPTY, 
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
                                                                              SELF.ssn := TRIM(LEFT.ssn);
                                                                              SELF.dob := TRIM(LEFT.dob);  
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
                                      SELF.inputSeq := LEFT.seq;
                                      SELF.individual := ind_in[1];
                                      SELF.business := bus_in[1];
                                      SELF.historyDateYYYYMMDD := IF((UNSIGNED4)LEFT.HistoryDateYYYYMMDD = DueDiligence.Constants.NUMERIC_ZERO, DueDiligence.Constants.date8Nines, (UNSIGNED4)LEFT.HistoryDateYYYYMMDD);
                                      SELF.requestedVersion := version;
                                      
                                      //citizenship specific additions
                                      SELF.phone2 := LEFT.phone2;
                                      SELF.dlNumber := LEFT.dlNumber;
                                      SELF.dlState := LEFT.dlState;
                                      
                                      SELF := [];));
	
 
  //Call the respective product(s)
  //each product is responsible for validating and cleaning data - those shared between
  //Citizenship and Due Diligence can be found in DueDiligence.CitDDShared
  citResults := IF(requestedProducts IN DueDiligence.CitDDShared.CITIZENSHIP_PRODUCTS, Citizenship.CitizenshipBatchMain(wseq, glba, dppa, dataRestriction, dataPermission, TRIM(modelName), validateModel, debugIndicator), DATASET([], DueDiligence.Layouts.BatchOut)); 
  ddResults := IF(requestedProducts IN DueDiligence.CitDDShared.DUEDILIGENCE_PRODUCTS, DueDiligence.DueDiligenceBatchMain(wseq, glba, dppa), DATASET([], DueDiligence.Layouts.BatchOut));
  
  allProducts := citResults + ddResults;
  sortProducts := SORT(allProducts, seq, acctNo);
  
  final := ROLLUP(sortProducts,
                  LEFT.seq = RIGHT.seq AND
                  LEFT.acctNo = RIGHT.acctNo,
                  TRANSFORM(DueDiligence.Layouts.BatchOut,
                            SELF.lexIDChanged := LEFT.lexIDChanged OR RIGHT.lexIDChanged;
                            SELF.PerLexID := DueDiligence.Common.firstPopulatedString(PerLexID);
                            SELF.PerAssetOwnProperty := DueDiligence.Common.firstPopulatedString(PerAssetOwnProperty);
                            SELF.PerAssetOwnProperty_Flag := DueDiligence.Common.firstPopulatedString(PerAssetOwnProperty_Flag);
                            SELF.PerAssetOwnAircraft := DueDiligence.Common.firstPopulatedString(PerAssetOwnAircraft);
                            SELF.PerAssetOwnAircraft_Flag := DueDiligence.Common.firstPopulatedString(PerAssetOwnAircraft_Flag);
                            SELF.PerAssetOwnWatercraft := DueDiligence.Common.firstPopulatedString(PerAssetOwnWatercraft);
                            SELF.PerAssetOwnWatercraft_Flag := DueDiligence.Common.firstPopulatedString(PerAssetOwnWatercraft_Flag);
                            SELF.PerAssetOwnVehicle := DueDiligence.Common.firstPopulatedString(PerAssetOwnVehicle);
                            SELF.PerAssetOwnVehicle_Flag := DueDiligence.Common.firstPopulatedString(PerAssetOwnVehicle_Flag);
                            SELF.PerAccessToFundsIncome := DueDiligence.Common.firstPopulatedString(PerAccessToFundsIncome);
                            SELF.PerAccessToFundsIncome_Flag := DueDiligence.Common.firstPopulatedString(PerAccessToFundsIncome_Flag);
                            SELF.PerAccessToFundsProperty := DueDiligence.Common.firstPopulatedString(PerAccessToFundsProperty);
                            SELF.PerAccessToFundsProperty_Flag := DueDiligence.Common.firstPopulatedString(PerAccessToFundsProperty_Flag);		
                            SELF.PerGeographic := DueDiligence.Common.firstPopulatedString(PerGeographic);
                            SELF.PerGeographic_Flag := DueDiligence.Common.firstPopulatedString(PerGeographic_Flag);
                            SELF.PerMobility := DueDiligence.Common.firstPopulatedString(PerMobility);
                            SELF.PerMobility_Flag := DueDiligence.Common.firstPopulatedString(PerMobility_Flag);
                            SELF.PerStateLegalEvent := DueDiligence.Common.firstPopulatedString(PerStateLegalEvent);
                            SELF.PerStateLegalEvent_Flag := DueDiligence.Common.firstPopulatedString(PerStateLegalEvent_Flag);
                            SELF.PerFederalLegalEvent := DueDiligence.Common.firstPopulatedString(PerFederalLegalEvent);
                            SELF.PerFederalLegalEvent_Flag := DueDiligence.Common.firstPopulatedString(PerFederalLegalEvent_Flag);
                            SELF.PerFederalLegalMatchLevel := DueDiligence.Common.firstPopulatedString(PerFederalLegalMatchLevel);
                            SELF.PerFederalLegalMatchLevel_Flag := DueDiligence.Common.firstPopulatedString(PerFederalLegalMatchLevel_Flag);
                            SELF.PerCivilLegalEvent := DueDiligence.Common.firstPopulatedString(PerCivilLegalEvent);
                            SELF.PerCivilLegalEvent_Flag := DueDiligence.Common.firstPopulatedString(PerCivilLegalEvent_Flag);
                            SELF.PerOffenseType := DueDiligence.Common.firstPopulatedString(PerOffenseType);
                            SELF.PerOffenseType_Flag := DueDiligence.Common.firstPopulatedString(PerOffenseType_Flag);
                            SELF.PerAgeRange := DueDiligence.Common.firstPopulatedString(PerAgeRange);
                            SELF.PerAgeRange_Flag := DueDiligence.Common.firstPopulatedString(PerAgeRange_Flag);
                            SELF.PerIdentityRisk := DueDiligence.Common.firstPopulatedString(PerIdentityRisk);
                            SELF.PerIdentityRisk_Flag := DueDiligence.Common.firstPopulatedString(PerIdentityRisk_Flag);
                            SELF.PerUSResidency := DueDiligence.Common.firstPopulatedString(PerUSResidency);
                            SELF.PerUSResidency_Flag := DueDiligence.Common.firstPopulatedString(PerUSResidency_Flag);
                            SELF.PerMatchLevel := DueDiligence.Common.firstPopulatedString(PerMatchLevel);
                            SELF.PerMatchLevel_Flag := DueDiligence.Common.firstPopulatedString(PerMatchLevel_Flag);
                            SELF.PerAssociates := DueDiligence.Common.firstPopulatedString(PerAssociates);
                            SELF.PerAssociates_Flag := DueDiligence.Common.firstPopulatedString(PerAssociates_Flag);
                            SELF.PerProfLicense := DueDiligence.Common.firstPopulatedString(PerProfLicense);
                            SELF.PerProfLicense_Flag := DueDiligence.Common.firstPopulatedString(PerProfLicense_Flag);
                            SELF.PerBusAssociations := DueDiligence.Common.firstPopulatedString(PerBusAssociations);
                            SELF.PerBusAssociations_Flag := DueDiligence.Common.firstPopulatedString(PerBusAssociations_Flag);
                            
                            SELF.BusLexID := DueDiligence.Common.firstPopulatedString(BusLexID);
                            SELF.BusAssetOwnProperty := DueDiligence.Common.firstPopulatedString(BusAssetOwnProperty);
                            SELF.BusAssetOwnProperty_Flag := DueDiligence.Common.firstPopulatedString(BusAssetOwnProperty_Flag);
                            SELF.BusAssetOwnAircraft := DueDiligence.Common.firstPopulatedString(BusAssetOwnAircraft);
                            SELF.BusAssetOwnAircraft_Flag := DueDiligence.Common.firstPopulatedString(BusAssetOwnAircraft_Flag);
                            SELF.BusAssetOwnWatercraft := DueDiligence.Common.firstPopulatedString(BusAssetOwnWatercraft);
                            SELF.BusAssetOwnWatercraft_Flag := DueDiligence.Common.firstPopulatedString(BusAssetOwnWatercraft_Flag);
                            SELF.BusAssetOwnVehicle := DueDiligence.Common.firstPopulatedString(BusAssetOwnVehicle);
                            SELF.BusAssetOwnVehicle_Flag := DueDiligence.Common.firstPopulatedString(BusAssetOwnVehicle_Flag);
                            SELF.BusAccessToFundsProperty := DueDiligence.Common.firstPopulatedString(BusAccessToFundsProperty);
                            SELF.BusAccessToFundsProperty_Flag := DueDiligence.Common.firstPopulatedString(BusAccessToFundsProperty_Flag);
                            SELF.BusGeographic := DueDiligence.Common.firstPopulatedString(BusGeographic);
                            SELF.BusGeographic_Flag := DueDiligence.Common.firstPopulatedString(BusGeographic_Flag);
                            SELF.BusValidity := DueDiligence.Common.firstPopulatedString(BusValidity);
                            SELF.BusValidity_Flag := DueDiligence.Common.firstPopulatedString(BusValidity_Flag);
                            SELF.BusStability := DueDiligence.Common.firstPopulatedString(BusStability);
                            SELF.BusStability_Flag := DueDiligence.Common.firstPopulatedString(BusStability_Flag);
                            SELF.BusIndustry := DueDiligence.Common.firstPopulatedString(BusIndustry);
                            SELF.BusIndustry_Flag := DueDiligence.Common.firstPopulatedString(BusIndustry_Flag);
                            SELF.BusStructureType := DueDiligence.Common.firstPopulatedString(BusStructureType);
                            SELF.BusStructureType_Flag := DueDiligence.Common.firstPopulatedString(BusStructureType_Flag);
                            SELF.BusSOSAgeRange := DueDiligence.Common.firstPopulatedString(BusSOSAgeRange);
                            SELF.BusSOSAgeRange_Flag := DueDiligence.Common.firstPopulatedString(BusSOSAgeRange_Flag);
                            SELF.BusPublicRecordAgeRange := DueDiligence.Common.firstPopulatedString(BusPublicRecordAgeRange);
                            SELF.BusPublicRecordAgeRange_Flag := DueDiligence.Common.firstPopulatedString(BusPublicRecordAgeRange_Flag);
                            SELF.BusShellShelf := DueDiligence.Common.firstPopulatedString(BusShellShelf);
                            SELF.BusShellShelf_Flag := DueDiligence.Common.firstPopulatedString(BusShellShelf_Flag);
                            SELF.BusMatchLevel := DueDiligence.Common.firstPopulatedString(BusMatchLevel);
                            SELF.BusMatchLevel_Flag := DueDiligence.Common.firstPopulatedString(BusMatchLevel_Flag);
                            SELF.BusStateLegalEvent := DueDiligence.Common.firstPopulatedString(BusStateLegalEvent);
                            SELF.BusStateLegalEvent_Flag := DueDiligence.Common.firstPopulatedString(BusStateLegalEvent_Flag);
                            SELF.BusFederalLegalEvent := DueDiligence.Common.firstPopulatedString(BusFederalLegalEvent);
                            SELF.BusFederalLegalEvent_Flag := DueDiligence.Common.firstPopulatedString(BusFederalLegalEvent_Flag);
                            SELF.BusFederalLegalMatchLevel := DueDiligence.Common.firstPopulatedString(BusFederalLegalMatchLevel);
                            SELF.BusFederalLegalMatchLevel_Flag := DueDiligence.Common.firstPopulatedString(BusFederalLegalMatchLevel_Flag);
                            SELF.BusCivilLegalEvent := DueDiligence.Common.firstPopulatedString(BusCivilLegalEvent);
                            SELF.BusCivilLegalEvent_Flag := DueDiligence.Common.firstPopulatedString(BusCivilLegalEvent_Flag);
                            SELF.BusOffenseType := DueDiligence.Common.firstPopulatedString(BusOffenseType);
                            SELF.BusOffenseType_Flag := DueDiligence.Common.firstPopulatedString(BusOffenseType_Flag);
                            SELF.BusBEOProfLicense := DueDiligence.Common.firstPopulatedString(BusBEOProfLicense);
                            SELF.BusBEOProfLicense_Flag := DueDiligence.Common.firstPopulatedString(BusBEOProfLicense_Flag);
                            SELF.BusBEOUSResidency := DueDiligence.Common.firstPopulatedString(BusBEOUSResidency);
                            SELF.BusBEOUSResidency_Flag := DueDiligence.Common.firstPopulatedString(BusBEOUSResidency_Flag);
                            
                            SELF.citizenshipScore := DueDiligence.Common.firstPopulatedString(citizenshipScore);
                            SELF.lexID := DueDiligence.Common.firstNonZeroNumber(lexID);
                            SELF.identityAge := DueDiligence.Common.firstNonZeroNumber(identityAge);
                            SELF.emergenceAgeHeader := DueDiligence.Common.firstNonZeroNumber(emergenceAgeHeader);
                            SELF.emergenceAgeBureau := DueDiligence.Common.firstNonZeroNumber(emergenceAgeBureau);
                            SELF.ssnIssuanceAge := DueDiligence.Common.firstNonZeroNumber(ssnIssuanceAge);
                            SELF.ssnIssuanceYears := DueDiligence.Common.firstNonZeroNumber(ssnIssuanceYears);
                            SELF.relativeCount := DueDiligence.Common.firstNonZeroNumber(relativeCount);
                            SELF.ver_voterRecords := DueDiligence.Common.firstNonZeroNumber(ver_voterRecords);
                            SELF.ver_insuranceRecords := DueDiligence.Common.firstNonZeroNumber(ver_insuranceRecords);
                            SELF.ver_studentFile := DueDiligence.Common.firstNonZeroNumber(ver_studentFile);
                            SELF.firstSeenAddr10 := DueDiligence.Common.firstNonZeroNumber(firstSeenAddr10);
                            SELF.reportedCurAddressYears := DueDiligence.Common.firstNonZeroNumber(reportedCurAddressYears);
                            SELF.addressFirstReportedAge := DueDiligence.Common.firstNonZeroNumber(addressFirstReportedAge);
                            SELF.timeSinceLastReportedNonBureau := DueDiligence.Common.firstNonZeroNumber(timeSinceLastReportedNonBureau);
                            SELF.inputSSNRandomlyIssued := DueDiligence.Common.firstNonZeroNumber(inputSSNRandomlyIssued);
                            SELF.inputSSNRandomIssuedInvalid := DueDiligence.Common.firstNonZeroNumber(inputSSNRandomIssuedInvalid);
                            SELF.inputSSNIssuedToNonUS := DueDiligence.Common.firstNonZeroNumber(inputSSNIssuedToNonUS);
                            SELF.inputSSNITIN := DueDiligence.Common.firstNonZeroNumber(inputSSNITIN);
                            SELF.inputSSNInvalid := DueDiligence.Common.firstNonZeroNumber(inputSSNInvalid);
                            SELF.inputSSNIssuedPriorDOB := DueDiligence.Common.firstNonZeroNumber(inputSSNIssuedPriorDOB);
                            SELF.inputSSNAssociatedMultLexIDs := DueDiligence.Common.firstNonZeroNumber(inputSSNAssociatedMultLexIDs);
                            SELF.inputSSNReportedDeceased := DueDiligence.Common.firstNonZeroNumber(inputSSNReportedDeceased);
                            SELF.inputSSNNotPrimaryLexID := DueDiligence.Common.firstNonZeroNumber(inputSSNNotPrimaryLexID);
                            SELF.lexIDBestSSNInvalid := DueDiligence.Common.firstNonZeroNumber(lexIDBestSSNInvalid);
                            SELF.lexIDReportedDeceased := DueDiligence.Common.firstNonZeroNumber(lexIDReportedDeceased);
                            SELF.lexIDMultipleSSNs := DueDiligence.Common.firstNonZeroNumber(lexIDMultipleSSNs);
                            SELF.inputComponentDivRisk := DueDiligence.Common.firstNonZeroNumber(inputComponentDivRisk);
                            
                            SELF := LEFT;));
                            
                            

  
  IF(debugIndicator, output(citResults, NAMED('citizenshipResults')));
  IF(debugIndicator, output(ddResults, NAMED('ddResults')));
  IF(debugIndicator, output(sortProducts, NAMED('sortProducts')));


  RETURN OUTPUT(final, NAMED('Results'));
END;


/*--SOAP-- 
<message name="duediligence.duediligence_batch_service">
	<part name="batch_in" sequence="1" type="tns:XmlDataset"/>
	<part name="attributesversion" sequence="2" type="xsd:integer"/>
	<part name="FBOP_DateTolerance" sequence="3" type="xsd:integer"/>
	<part name="FBOP_DateToleranceYearsPrior" sequence="4" type="xsd:integer"/>
	<part name="FBOP_IncludeExactInputLastName" sequence="5" type="xsd:boolean"/>
	<part name="FBOP_IncludeNicknames" sequence="6" type="xsd:boolean"/>
	<part name="FBOP_NameOrderSearched" sequence="7" type="xsd:integer"/>
	<part name="FBOP_IncludeLexIDPrimaryDOBYear" sequence="8" type="xsd:boolean"/>
	<part name="FBOP_IncludeDOBYearRadius" sequence="9" type="xsd:boolean"/>
	<part name="FBOP_DOBNumberOfYearsRadius" sequence="10" type="xsd:integer"/>
	<part name="modelName" sequence="15" type="xsd:string"/>
	<part name="glbapurpose" sequence="16" type="xsd:integer"/>
	<part name="dppapurpose" sequence="17" type="xsd:integer"/>
	<part name="datarestriction" sequence="18" type="xsd:string"/>
	<part name="datapermissionmask" sequence="19" type="xsd:string"/>
</message>
*/          


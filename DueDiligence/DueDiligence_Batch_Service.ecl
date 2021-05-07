IMPORT DueDiligence, Risk_Indicators, STD, WSInput;

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

  //CCPA fields
  UNSIGNED1 lexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
  STRING transactionID := '' : STORED('_TransactionId');
  STRING batchUID := '' : STORED('_BatchUID');
  UNSIGNED6 globalCompanyId := 0 : STORED('_GCID');






  //Determine which product(s) need to be called - Citizenship and/or Due Diligence
  BOOLEAN callCitizenship := modelName != DueDiligence.Constants.EMPTY;
  BOOLEAN callDueDiligence := attributesVersion > DueDiligence.Constants.VERSION_0;

  requestedProducts := MAP(callCitizenship AND callDueDiligence => DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.BOTH,
                            callCitizenship => DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.CITIZENSHIP_ONLY,
                            callDueDiligence => DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY,
                            DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.EMPTY);



  rawWithSeq := PROJECT(batch_in, TRANSFORM({UNSIGNED6 uniqueID, RECORDOF(LEFT)},
                                            SELF.uniqueID := COUNTER;
                                            SELF := LEFT;));


  //Transform data into a shared common input layout
	wseq := PROJECT(rawWithSeq, TRANSFORM(DueDiligence.Layouts.Input,
                                      customerType := STD.Str.ToUpperCase(LEFT.custType);

                                      version := MAP(attributesVersion = DueDiligence.Constants.VERSION_3 AND customerType = DueDiligence.Constants.INDIVIDUAL => DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3,
                                                      attributesVersion = DueDiligence.Constants.VERSION_3 AND customerType = DueDiligence.Constants.BUSINESS => DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3,
                                                      DueDiligence.Constants.INVALID);

                                      productsRequested := MAP(requestedProducts = DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.BOTH => DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP,
                                                               requestedProducts = DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.CITIZENSHIP_ONLY => DueDiligence.ConstantsQuery.VALID_PRODUCT_CITIZENSHIP_ONLY,
                                                               requestedProducts = DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY => DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_ONLY,
                                                               DueDiligence.Constants.INVALID);


                                      address_in := DATASET([TRANSFORM(DueDiligence.v3Layouts.Internal.Address,
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
                                                                        SELF.zip := TRIM(LEFT.zip5);
                                                                        SELF.zip4 := TRIM(LEFT.zip4);
                                                                        SELF := [];)]);

                                      ind_in := IF(version IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS OR modelName != DueDiligence.Constants.EMPTY,
                                                          DATASET([TRANSFORM(DueDiligence.Layouts.IndInput,
                                                                              SELF.lexID := (UNSIGNED)TRIM(LEFT.lexID);
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
                                                                              SELF.taxID := TRIM(LEFT.ssn);
                                                                              SELF.dob := TRIM(LEFT.dob);

                                                                              SELF := [];)]),
                                                          DATASET([], DueDiligence.Layouts.IndInput));

                                      bus_in := IF(version IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS,
                                                          DATASET([TRANSFORM(DueDiligence.Layouts.BusInput,
                                                                              SELF.lexID := (UNSIGNED)TRIM(LEFT.lexID);
                                                                              SELF.companyName := TRIM(LEFT.companyName);
                                                                              SELF.altCompanyName := TRIM(LEFT.altCompanyName);
                                                                              SELF.address := address_in[1];
                                                                              SELF.taxID := TRIM(LEFT.taxID);
                                                                              SELF := [];)]),
                                                          DATASET([], DueDiligence.Layouts.BusInput));


                                      SELF.seq := LEFT.uniqueID;
                                      SELF.inputSeq := LEFT.seq;
                                      SELF.accountNumber := TRIM(LEFT.acctNo);

                                      SELF.rawPerson := ind_in[1];
                                      SELF.rawBusiness := bus_in[1];
                                      SELF.historyDateYYYYMMDD := IF((UNSIGNED4)LEFT.HistoryDateYYYYMMDD = DueDiligence.Constants.NUMERIC_ZERO, DueDiligence.Constants.date8Nines, (UNSIGNED4)LEFT.HistoryDateYYYYMMDD);
                                      SELF.requestedVersion := version;
                                      SELF.productRequested := productsRequested;

                                      //citizenship specific additions
                                      SELF.phone2 := LEFT.phone2;
                                      SELF.dlNumber := LEFT.dlNumber;
                                      SELF.dlState := LEFT.dlState;

                                      SELF := [];));


  //validate the requests
  validatedRequests := DueDiligence.CommonQuery.ValidateRequest(wseq, glba, dppa, DueDiligence.Constants.ATTRIBUTES, FALSE, modelName);

  //clean data
  cleanedData := DueDiligence.CommonQuery.GetCleanData(validatedRequests(validRequest));



  //Call the respective product(s) based on person/business requests
  busRecs :=  cleanedData(containsPersonReq = FALSE);
  perRecs :=  cleanedData(containsPersonReq);


  //retrieve compliance information
  regulatoryCompliance := DueDiligence.CommonQuery.GetCompliance(dppa, glba, dataRestriction, dataPermission, DueDiligence.Constants.EMPTY, lexIdSourceOptout, transactionID, batchUID, globalCompanyID, DueDiligence.Constants.EMPTY);


  busProductResults := DueDiligence.CommonQuery.v3BusinessResults(busRecs, regulatoryCompliance, FALSE, debugIndicator);
  transBusToBatch := PROJECT(busProductResults, TRANSFORM(DueDiligence.Layouts.BatchOut, SELF := LEFT; SELF := [];));


  perProductResults := DueDiligence.CommonQuery.v3PersonResults(perRecs, regulatoryCompliance, FALSE, debugIndicator, validateModel);
  transPerToBatch := PROJECT(perProductResults, TRANSFORM(DueDiligence.Layouts.BatchOut, SELF := LEFT; SELF := [];));


  allRequests := transBusToBatch + transPerToBatch;

  //add FI pass through fields to output
  withFIFields := JOIN(rawWithSeq, allRequests,
                        LEFT.uniqueID = RIGHT.seq,
                        TRANSFORM(DueDiligence.Layouts.BatchOut,
                                   SELF.seq := LEFT.seq;
                                   SELF.acctNo := LEFT.acctNo;
                                   SELF.FIAcctOpenDate := LEFT.FIAcctOpenDate;
                                   SELF.FICRR := LEFT.FICRR;
                                   SELF.FIAdditionalCodes1 := LEFT.FIAdditionalCodes1;
                                   SELF.FIAdditionalCodes2 := LEFT.FIAdditionalCodes2;
                                   SELF.FIAdditionalCodes3 := LEFT.FIAdditionalCodes3;
                                   SELF.FIAdditionalCodes4 := LEFT.FIAdditionalCodes4;
                                   SELF.FIAdditionalCodes5 := LEFT.FIAdditionalCodes5;

                                   lexIDToUse := TRIM(IF(RIGHT.perLexID = DueDiligence.Constants.EMPTY, RIGHT.busLexID, RIGHT.perLexID));

                                   SELF.lexIDChanged := TRIM(LEFT.lexID) <> DueDiligence.Constants.EMPTY AND
                                                        lexIDToUse <> DueDiligence.Constants.EMPTY AND
                                                        TRIM(LEFT.lexID) <> lexIDToUse;
                                   SELF := RIGHT;));

  final := SORT(withFIFields, seq, acctNo);




  IF(debugIndicator, output(validatedRequests, NAMED('validatedRequests')));
  IF(debugIndicator, output(cleanedData, NAMED('cleanedData')));
  IF(debugIndicator, output(perRecs, NAMED('perRecs')));
  IF(debugIndicator, output(busRecs, NAMED('busRecs')));
  IF(debugIndicator, output(busProductResults, NAMED('busProductResults')));
  IF(debugIndicator, output(perProductResults, NAMED('perProductResults')));
  IF(debugIndicator, output(allRequests, NAMED('allRequests')));
  IF(debugIndicator, output(withFIFields, NAMED('withFIFields')));


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

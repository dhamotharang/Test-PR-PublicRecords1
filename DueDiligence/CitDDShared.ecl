IMPORT Address, Business_Risk_BIP, DueDiligence, Risk_Indicators, STD, ut;

EXPORT CitDDShared := MODULE

  //constants shared between Citizenship and Due Diligence
  EXPORT VALIDATION_INVALID_GLB := 'Not an allowable GLB permissible purpose';
  EXPORT VALIDATION_INVALID_DPPA := 'Not an allowable DPPA permissible purpose';
  EXPORT VALIDATION_INVALID_DD_ATTRIBUTE_REQUEST_WITH_CITIZENSHIP := 'Business attributes are not valid with a citizenship request';
  EXPORT VALIDATION_INVALID_PRODUCT_REQUEST_TYPE := 'Product Request Type is required or invalid. Product Request Type = AttributesOnly, CitizenshipOnly or AttributesAndCitizenship';
  EXPORT VALIDATION_INVALID_DD_VERSION := 'Please enter a valid attributes version';
  EXPORT VALIDATION_INVALID_MODEL_NAME := 'Model is currently not supported.';
  EXPORT VALIDATION_INVALID_DD_CITIZENSHIP_COMBO := 'Attributes version is invalid and model is not supported.';
  EXPORT VALIDATION_INVALID_REQUEST := 'Invalid request. Could not determine which products were requested';

  EXPORT VALID_PRODUCT_DUE_DILIGENCE_ONLY := 'attributesonly';
  EXPORT VALID_PRODUCT_CITIZENSHIP_ONLY := 'citizenshiponly';
  EXPORT VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP := 'attributesandcitizenship';


  
  //we want to use the standard BS Options used in the Boca Shell.  
  EXPORT INTEGER DEFAULT_BS_VERSION := 52;
	EXPORT UNSIGNED8 DEFAULT_BS_OPTIONS :=(Risk_Indicators.iid_constants.BSOptions.IncludeFraudVelocity +
                                         Risk_Indicators.iid_constants.BSOptions.IncludeHHIDSummary +
                                         Risk_Indicators.iid_constants.BSOptions.TurnOffTumblings +
                                         Risk_Indicators.iid_constants.BSOptions.TurnOffRelativeProperty
																				 );
			
  EXPORT PRODUCT_REQUESTED_ENUM := ENUM(UNSIGNED1, EMPTY=0, DUEDILIGENCE_ONLY=1, CITIZENSHIP_ONLY=2, BOTH=3);
  
  EXPORT DUEDILIGENCE_PRODUCTS := [PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY, PRODUCT_REQUESTED_ENUM.BOTH];
  EXPORT CITIZENSHIP_PRODUCTS := [PRODUCT_REQUESTED_ENUM.CITIZENSHIP_ONLY, PRODUCT_REQUESTED_ENUM.BOTH];
  
  EXPORT VALID_REQUESTED_PRODUCTS := [VALID_PRODUCT_DUE_DILIGENCE_ONLY, VALID_PRODUCT_CITIZENSHIP_ONLY, VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP];
  



  
  
  EXPORT getProductEnum(STRING selectedProduct) := FUNCTION
    RETURN MAP(selectedProduct = 'attributesandcitizenship' => PRODUCT_REQUESTED_ENUM.BOTH,
                selectedProduct = 'citizenshiponly' => PRODUCT_REQUESTED_ENUM.CITIZENSHIP_ONLY,
                PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY);
  END;
  
  EXPORT isValidGLBA(UNSIGNED1 glbPurpose) := FUNCTION
    RETURN (glbPurpose BETWEEN 0 AND 7) OR glbPurpose = 11 OR glbPurpose = 12;
  END;
  
  EXPORT isValidDPPA(UNSIGNED1 dppaPurpose) := FUNCTION
    RETURN dppaPurpose BETWEEN 0 AND 7;
  END;
  
  
  EXPORT stripNonNumericValues(STRING stringToStrip) := FUNCTION
    strippedString := STD.Str.Filter(stringToStrip, DueDiligence.Constants.NUMERIC_VALUES);
    
    RETURN TRIM(strippedString);
  END;
  
  EXPORT mapFullName := MACRO
    unparsedName := STD.Str.ToUpperCase(LEFT.individual.name.fullName);
    fName := STD.Str.ToUpperCase(LEFT.individual.name.firstName);
    mName := STD.Str.ToUpperCase(LEFT.individual.name.middleName);
    lName := STD.Str.ToUpperCase(LEFT.individual.name.lastName);
    sName := STD.Str.ToUpperCase(LEFT.individual.name.suffix);
    
    
    cleanedName := MAP(STD.Str.ToUpperCase(LEFT.individual.nameInputOrder) = 'FML' => Address.CleanPersonFML73(unparsedName),
                       STD.Str.ToUpperCase(LEFT.individual.nameInputOrder) = 'LFM' => Address.CleanPersonLFM73(unparsedName),
                       Address.CleanPerson73(unparsedName));	

    cleanedFirst := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[6..25]), DueDiligence.Constants.EMPTY);
    cleanedMiddle := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[26..45]), DueDiligence.Constants.EMPTY);
    cleanedLast := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[46..65]), DueDiligence.Constants.EMPTY);
    cleanedSuffix := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[66..70]), DueDiligence.Constants.EMPTY);

    SELF.fullName := unparsedName;
    SELF.firstName := IF(fName = DueDiligence.Constants.EMPTY, cleanedFirst, fName);
    SELF.middleName := IF(mName = DueDiligence.Constants.EMPTY, cleanedMiddle, mName);
    SELF.lastName := IF(lName = DueDiligence.Constants.EMPTY, cleanedLast, lName);
    SELF.suffix := IF(sName = DueDiligence.Constants.EMPTY, cleanedSuffix, sName);                                                                                                    
  ENDMACRO;
  
  
  EXPORT GetCleanData(DATASET(DueDiligence.Layouts.Input) input) := FUNCTION
    RETURN PROJECT(input, TRANSFORM(DueDiligence.Layouts.CleanedData,
                                          
                                          citizenshipRequested := getProductEnum(LEFT.productRequested) IN CITIZENSHIP_PRODUCTS;
                                          
                                          personRequest := MAP(TRIM(STD.Str.ToLowerCase(LEFT.productRequested)) = VALID_PRODUCT_DUE_DILIGENCE_ONLY AND TRIM(STD.Str.ToUpperCase(LEFT.requestedVersion)) IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS => TRUE,
                                                               TRIM(STD.Str.ToLowerCase(LEFT.productRequested)) = VALID_PRODUCT_CITIZENSHIP_ONLY => TRUE,
                                                               TRIM(STD.Str.ToLowerCase(LEFT.productRequested)) = VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP AND TRIM(STD.Str.ToUpperCase(LEFT.requestedVersion)) IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS => TRUE,
                                                               FALSE);
                                          
                                          
                                          
                                          //=======Fields pertaining to both Citizenship and Due Diligence=======
                                          //Clean Address
                                          addressToClean := IF(personRequest, LEFT.individual.address, LEFT.business.address);
                                          
                                          addressClean := DueDiligence.CommonAddress.GetCleanAddress(addressToClean);

                                          addrProvided := addressToClean.streetAddress1 <> DueDiligence.Constants.EMPTY OR addressToClean.streetAddress2 <> DueDiligence.Constants.EMPTY OR addressToClean.prim_range <> DueDiligence.Constants.EMPTY OR addressToClean.predir <> DueDiligence.Constants.EMPTY OR 
                                                          addressToClean.prim_name <> DueDiligence.Constants.EMPTY OR addressToClean.addr_suffix <> DueDiligence.Constants.EMPTY OR addressToClean.postdir <> DueDiligence.Constants.EMPTY OR addressToClean.unit_desig <> DueDiligence.Constants.EMPTY OR 
                                                          addressToClean.sec_range <> DueDiligence.Constants.EMPTY OR addressToClean.city <> DueDiligence.Constants.EMPTY OR addressToClean.state <> DueDiligence.Constants.EMPTY OR addressToClean.zip5 <> DueDiligence.Constants.EMPTY;	
                                                          
                                          fullAddrProvided := (addressClean.streetAddress1 <> DueDiligence.Constants.EMPTY OR addressClean.prim_name <> DueDiligence.Constants.EMPTY) AND addressClean.city <> DueDiligence.Constants.EMPTY AND addressClean.state <> DueDiligence.Constants.EMPTY AND addressClean.zip5 <> DueDiligence.Constants.EMPTY;

                                          //Clean Phone Number
                                          phoneNumber := IF(personRequest, LEFT.individual.phone, LEFT.business.phone);
                                          phoneToClean := stripNonNumericValues(phoneNumber);
                                          
                                          //Remove any non-numeric fiends from taxID and lexID fields
                                          taxID := IF(personRequest, LEFT.individual.ssn, LEFT.business.fein);
                                          taxIDToClean := stripNonNumericValues(taxID);
                                          
                                          lexID := IF(personRequest, LEFT.individual.lexID, LEFT.business.lexID);
                                          validLexID := stripNonNumericValues(lexID);
                                          
                                          //Valid history date passed - if invalid should return 99999999 for current mode
                                          validDate := DueDiligence.Common.checkInvalidDate((STRING)LEFT.historyDateYYYYMMDD, (STRING)DueDiligence.Constants.date8Nines);




                                          //=======Fields pertaining to Citizenship Only=======
                                          phone2ToClean := stripNonNumericValues(LEFT.phone2);
                                          
                                          
                                          
                                          
                                          //=======Fields pertaining to Due Diligence Only=======
                                          //Clean Company Name
                                          busName := LEFT.business.companyName;
                                          altBusName := LEFT.business.altCompanyName;

                                          companyName := IF(busName = DueDiligence.Constants.EMPTY, ut.CleanCompany(altBusName), ut.CleanCompany(busName)); // If the customer didn't pass in a company but passed in an alt company name use the alt as the company name
                                          altCompanyName := IF(busName = DueDiligence.Constants.EMPTY, DueDiligence.Constants.EMPTY, ut.CleanCompany(altBusName)); // Blank out the cleaned AltCompanyName if CompanyName wasn't populated, as we copied Alt into the Main CompanyName field on the previous line

                                          //Populate appropriate cleaned data	
                                          busClean := IF(personRequest = FALSE, 
                                                          DATASET([TRANSFORM(DueDiligence.Layouts.Busn_Input,
                                                                              SELF.lexID := validLexID;
                                                                              SELF.companyName := companyName;
                                                                              SELF.altCompanyName := altCompanyName;
                                                                              SELF.address := addressClean;
                                                                              SELF.phone := IF(Business_Risk_BIP.Common.validPhone(phoneToClean), phoneToClean, DueDiligence.Constants.EMPTY);
                                                                              SELF.fein := taxIDToClean;
                                                                              SELF.BIP_IDs.SeleID.LinkID := (UNSIGNED6)validLexID;
                                                                              SELF := LEFT.business;
                                                                              SELF := [];)]),
                                                          DATASET([], DueDiligence.Layouts.Busn_Input));
                                                                          
                                                                          
                                                                          
                                                                          

                                          indClean := IF(personRequest,
                                                          DATASET([TRANSFORM(DueDiligence.Layouts.Indv_Input,
                                                                              SELF.lexID := validLexID;
                                                                              SELF.name := DATASET([TRANSFORM(DueDiligence.Layouts.Name,
                                                                                                              unparsedName := STD.Str.ToUpperCase(LEFT.individual.name.fullName);
                                                                                                              fName := STD.Str.ToUpperCase(LEFT.individual.name.firstName);
                                                                                                              mName := STD.Str.ToUpperCase(LEFT.individual.name.middleName);
                                                                                                              lName := STD.Str.ToUpperCase(LEFT.individual.name.lastName);
                                                                                                              sName := STD.Str.ToUpperCase(LEFT.individual.name.suffix);
                                                                                                              
                                                                                                              
                                                                                                              cleanedName := MAP(STD.Str.ToUpperCase(LEFT.individual.nameInputOrder) = 'FML' => Address.CleanPersonFML73(unparsedName),
                                                                                                                                 STD.Str.ToUpperCase(LEFT.individual.nameInputOrder) = 'LFM' => Address.CleanPersonLFM73(unparsedName),
                                                                                                                                 Address.CleanPerson73(unparsedName));	
                                        
                                                                                                              cleanedFirst := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[6..25]), DueDiligence.Constants.EMPTY);
                                                                                                              cleanedMiddle := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[26..45]), DueDiligence.Constants.EMPTY);
                                                                                                              cleanedLast := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[46..65]), DueDiligence.Constants.EMPTY);
                                                                                                              cleanedSuffix := IF(unparsedName <> DueDiligence.Constants.EMPTY, STD.Str.ToUpperCase(cleanedName[66..70]), DueDiligence.Constants.EMPTY);
                                                                                              
                                                                                                              SELF.fullName := unparsedName;
                                                                                                              SELF.firstName := IF(fName = DueDiligence.Constants.EMPTY, cleanedFirst, fName);
                                                                                                              SELF.middleName := IF(mName = DueDiligence.Constants.EMPTY, cleanedMiddle, mName);
                                                                                                              SELF.lastName := IF(lName = DueDiligence.Constants.EMPTY, cleanedLast, lName);
                                                                                                              SELF.suffix := IF(sName = DueDiligence.Constants.EMPTY, cleanedSuffix, sName);																															
                                                                                                              SELF := [];)])[1];
                                                                              SELF.address := addressClean;
                                                                              SELF.phone := phoneToClean;
                                                                              SELF.ssn := taxIDToClean;
                                                                              SELF := LEFT.individual;
                                                                              SELF := [];)]),
                                                          DATASET([], DueDiligence.Layouts.Indv_Input));

                                          inputClean := DATASET([TRANSFORM(DueDiligence.Layouts.Input,
                                                                            SELF.seq := LEFT.seq;
                                                                            SELF.business := busClean[1];
                                                                            SELF.individual := indClean[1];
                                                                            SELF.historyDateYYYYMMDD := (UNSIGNED)validDate;
                                                                            
                                                                            SELF.addressProvided := addrProvided;
                                                                            SELF.fullCleanAddressExists := fullAddrProvided;
                                                                            SELF.lexIDPopulated := validLexID <> DueDiligence.Constants.EMPTY;
                                                                            SELF.piiPopulated := addrProvided OR
                                                                                                 taxIDToClean <> DueDiligence.Constants.EMPTY OR
                                                                                                 phoneToClean <> DueDiligence.Constants.EMPTY OR
                                                                                                 indClean[1].name.fullName <> DueDiligence.Constants.EMPTY OR
                                                                                                 indClean[1].name.firstName <> DueDiligence.Constants.EMPTY OR
                                                                                                 indClean[1].name.middleName <> DueDiligence.Constants.EMPTY OR
                                                                                                 indClean[1].name.lastName <> DueDiligence.Constants.EMPTY OR
                                                                                                 indClean[1].name.suffix <> DueDiligence.Constants.EMPTY OR
                                                                                                 companyName <> DueDiligence.Constants.EMPTY OR
                                                                                                 altCompanyName <> DueDiligence.Constants.EMPTY;
                                                                                                 
                                                                                                 
                                                                                                 
    
                                                                            SELF.containsCitizenshipReq := citizenshipRequested;
                                                                            SELF.containsPersonReq := personRequest;
                                                                            
                                                                            //only populated for Citizenship
                                                                            SELF.modelName := IF(citizenshipRequested, LEFT.modelName, DueDiligence.Constants.EMPTY);
                                                                            SELF.phone2 := IF(citizenshipRequested, phone2ToClean, DueDiligence.Constants.EMPTY);
                                                                            SELF.dlNumber := IF(citizenshipRequested, LEFT.dlNumber, DueDiligence.Constants.EMPTY);
                                                                            SELF.dlState := IF(citizenshipRequested, LEFT.dlState, DueDiligence.Constants.EMPTY);
                                                                            SELF.email := IF(citizenshipRequested, LEFT.email, DueDiligence.Constants.EMPTY);
                                                                                              
                                                                            SELF := LEFT;
                                                                            SELF := [];)])[1];


                                          SELF.cleanedInput := inputClean;
                                          SELF.inputEcho := LEFT;
                                          SELF := []));
  END;


END;
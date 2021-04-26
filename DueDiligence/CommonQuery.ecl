IMPORT Address, Business_Risk_BIP, DueDiligence, Risk_Indicators, STD, ut;


EXPORT CommonQuery := MODULE



    SHARED isValidGLBA(UNSIGNED1 glbPurpose) := FUNCTION
        RETURN (glbPurpose BETWEEN 0 AND 7) OR glbPurpose = 11 OR glbPurpose = 12;
    END;

    SHARED isValidDPPA(UNSIGNED1 dppaPurpose) := FUNCTION
        RETURN dppaPurpose BETWEEN 0 AND 7;
    END;

    EXPORT ValidateRequest(DATASET(DueDiligence.Layouts.Input) input, UNSIGNED1 glbPurpose, UNSIGNED1 dppaPurpose, STRING11 requestedService, BOOLEAN reportRequested = FALSE, STRING15 modelName = DueDiligence.Constants.EMPTY):= FUNCTION

        BOOLEAN validGLB := isValidGLBA(glbPurpose);
        BOOLEAN validDPPA := isValidDPPA(dppaPurpose);
        BOOLEAN validModel := STD.Str.ToUpperCase(modelName) IN DueDiligence.Citizenship.Constants.VALID_MODEL_NAMES;

        validatedRequests := PROJECT(input, TRANSFORM(DueDiligence.Layouts.Input,
                                                      //Validate the request
                                                      BOOLEAN validIndVersion := LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS;
                                                      BOOLEAN validBusVersion := LEFT.requestedVersion IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS;

                                                      requestedProducts := STD.Str.ToLowerCase(TRIM(LEFT.productRequested));

                                                      STRING OhNoMessage := MAP(requestedProducts = DueDiligence.Constants.EMPTY => DueDiligence.ConstantsQuery.VALIDATION_INVALID_REQUEST,
                                                                                requestedProducts NOT IN DueDiligence.ConstantsQuery.VALID_REQUESTED_PRODUCTS => DueDiligence.ConstantsQuery.VALIDATION_INVALID_PRODUCT_REQUEST_TYPE,
                                                                                requestedProducts = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_REPORT_DEFAULT AND reportRequested = FALSE => DueDiligence.ConstantsQuery.VALIDATION_INVALID_PRODUCT_REQUEST_TYPE,
                                                                                (requestedProducts = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP OR requestedProducts = DueDiligence.ConstantsQuery.VALID_PRODUCT_CITIZENSHIP_ONLY) AND validBusVersion = TRUE => DueDiligence.ConstantsQuery.VALIDATION_INVALID_DD_ATTRIBUTE_REQUEST_WITH_CITIZENSHIP,
                                                                                requestedProducts = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP AND validIndVersion = FALSE AND validModel = FALSE => DueDiligence.ConstantsQuery.VALIDATION_INVALID_DD_CITIZENSHIP_COMBO,
                                                                                requestedProducts = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP AND validIndVersion = FALSE => DueDiligence.ConstantsQuery.VALIDATION_INVALID_DD_VERSION,
                                                                                requestedProducts = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP AND validModel = FALSE => DueDiligence.ConstantsQuery.VALIDATION_INVALID_MODEL_NAME,
                                                                                requestedProducts = DueDiligence.ConstantsQuery.VALID_PRODUCT_CITIZENSHIP_ONLY AND validModel = FALSE => DueDiligence.ConstantsQuery.VALIDATION_INVALID_MODEL_NAME,
                                                                                requestedProducts = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_ONLY AND validIndVersion = FALSE AND validBusVersion = FALSE => DueDiligence.ConstantsQuery.VALIDATION_INVALID_DD_VERSION,
                                                                                (requestedProducts = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_MODULES OR (requestedProducts = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_REPORT_DEFAULT AND reportRequested)) AND COUNT(input[1].requestedModules) = 0 => DueDiligence.ConstantsQuery.VALIDATION_NO_MODULES_REQUESTED,
                                                                                validGLB = FALSE => DueDiligence.ConstantsQuery.VALIDATION_INVALID_GLB,
                                                                                validDPPA = FALSE => DueDiligence.ConstantsQuery.VALIDATION_INVALID_DPPA,
                                                                                DueDiligence.Constants.EMPTY);

                                                      validDDVersions := MAP(TRIM(requestedService) = DueDiligence.Constants.BUSINESS => DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3,
                                                                             TRIM(requestedService) = DueDiligence.Constants.INDIVIDUAL => DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3,
                                                                             DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3 + ' OR ' + DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3);

                                                      validModules := MAP(TRIM(requestedService) = DueDiligence.Constants.BUSINESS => DueDiligence.ConstantsQuery.MODULE_ECONOMIC + ', ' + DueDiligence.ConstantsQuery.MODULE_OPERATING + ', ' +
                                                                                                                                      DueDiligence.ConstantsQuery.MODULE_LEGAL + ', ' + DueDiligence.ConstantsQuery.MODULE_NETWORK,
                                                                          TRIM(requestedService) = DueDiligence.Constants.INDIVIDUAL => DueDiligence.ConstantsQuery.MODULE_ECONOMIC + ', ' + DueDiligence.ConstantsQuery.MODULE_GEOGRAPHIC + ', ' + DueDiligence.ConstantsQuery.MODULE_IDENTITY + ', ' +
                                                                                                                                        DueDiligence.ConstantsQuery.MODULE_LEGAL + ', ' + DueDiligence.ConstantsQuery.MODULE_NETWORK,
                                                                          DueDiligence.ConstantsQuery.MODULE_ECONOMIC + ', ' + DueDiligence.ConstantsQuery.MODULE_GEOGRAPHIC + ', ' + DueDiligence.ConstantsQuery.MODULE_IDENTITY + ', ' +
                                                                          DueDiligence.ConstantsQuery.MODULE_LEGAL + ', ' + DueDiligence.ConstantsQuery.MODULE_NETWORK + ', ' + DueDiligence.ConstantsQuery.MODULE_OPERATING);

                                                      updatedOhNoMessage := MAP(OhNoMessage = DueDiligence.ConstantsQuery.VALIDATION_INVALID_DD_VERSION => TRIM(OhNoMessage) + ': ' + validDDVersions,
                                                                                OhNoMessage = DueDiligence.ConstantsQuery.VALIDATION_INVALID_MODEL_NAME => TRIM(OhNoMessage) + ' Supported models include: CIT1808_0_0',
                                                                                OhNoMessage = DueDiligence.ConstantsQuery.VALIDATION_NO_MODULES_REQUESTED => TRIM(OhNoMessage) + ' Supported modules are: ' + validModules,
                                                                                OhNoMessage = DueDiligence.ConstantsQuery.VALIDATION_INVALID_PRODUCT_REQUEST_TYPE => TRIM(OhNoMessage) + IF(reportRequested, ' Modules or Standard (default to all attributes)', 'AttributesAndCitizenship, AttributesOnly, CitizenshipOnly, or Modules'),
                                                                                OhNoMessage);

                                                      trimOhNo := TRIM(updatedOhNoMessage);


                                                      SELF.validRequest := trimOhNo = DueDiligence.Constants.EMPTY;
                                                      SELF.errorMessage := trimOhNo;
                                                      SELF := LEFT;));

        RETURN validatedRequests;
    END;


		EXPORT mac_FailOnError(invalidRequests) := MACRO
				IF(COUNT(invalidRequests) > 0 AND invalidRequests[1].validRequest = FALSE, FAIL(invalidRequests[1].errorMessage));
		ENDMACRO;


    SHARED stripNonNumericValues(STRING stringToStrip) := FUNCTION
        strippedString := STD.Str.Filter(stringToStrip, DueDiligence.Constants.NUMERIC_VALUES);

        RETURN TRIM(strippedString);
    END;

    EXPORT getProductEnum(STRING selectedProduct) := FUNCTION
        littleProduct := STD.Str.ToLowerCase(TRIM(selectedProduct));

        RETURN MAP(littleProduct = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP => DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.BOTH,
                    littleProduct = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_ONLY => DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY,
                    littleProduct = DueDiligence.ConstantsQuery.VALID_PRODUCT_CITIZENSHIP_ONLY => DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.CITIZENSHIP_ONLY,
                    littleProduct = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_MODULES => DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.CUSTOM_ATTRIBUTES,
                    littleProduct = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_REPORT_DEFAULT => DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY,
                    DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.EMPTY);
    END;


    EXPORT GetCleanData(DATASET(DueDiligence.Layouts.Input) input) := FUNCTION
        RETURN PROJECT(input, TRANSFORM(DueDiligence.Layouts.Input,

                                          citizenshipRequested := getProductEnum(LEFT.productRequested) IN DueDiligence.ConstantsQuery.CITIZENSHIP_PRODUCTS;

                                          personRequest := MAP(TRIM(STD.Str.ToLowerCase(LEFT.productRequested)) = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_ONLY AND TRIM(STD.Str.ToUpperCase(LEFT.requestedVersion)) IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS => TRUE,
                                                               TRIM(STD.Str.ToLowerCase(LEFT.productRequested)) = DueDiligence.ConstantsQuery.VALID_PRODUCT_CITIZENSHIP_ONLY => TRUE,
                                                               TRIM(STD.Str.ToLowerCase(LEFT.productRequested)) = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP AND TRIM(STD.Str.ToUpperCase(LEFT.requestedVersion)) IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS => TRUE,
                                                               TRIM(STD.Str.ToLowerCase(LEFT.productRequested)) = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_MODULES AND TRIM(STD.Str.ToUpperCase(LEFT.requestedVersion)) IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS => TRUE,
                                                               FALSE);



                                          //=======Fields pertaining to both Citizenship and Due Diligence=======
                                          //Clean Address
                                          addressToClean := IF(personRequest, LEFT.rawPerson.address, LEFT.rawBusiness.address);

                                          addressClean := DueDiligence.v3Common.Address.GetCleanAddress(addressToClean);

                                          addrProvided := addressToClean.streetAddress1 <> DueDiligence.Constants.EMPTY OR addressToClean.streetAddress2 <> DueDiligence.Constants.EMPTY OR addressToClean.prim_range <> DueDiligence.Constants.EMPTY OR addressToClean.predir <> DueDiligence.Constants.EMPTY OR
                                                          addressToClean.prim_name <> DueDiligence.Constants.EMPTY OR addressToClean.addr_suffix <> DueDiligence.Constants.EMPTY OR addressToClean.postdir <> DueDiligence.Constants.EMPTY OR addressToClean.unit_desig <> DueDiligence.Constants.EMPTY OR
                                                          addressToClean.sec_range <> DueDiligence.Constants.EMPTY OR addressToClean.city <> DueDiligence.Constants.EMPTY OR addressToClean.state <> DueDiligence.Constants.EMPTY OR addressToClean.zip <> DueDiligence.Constants.EMPTY;

                                          fullAddrProvided := (addressClean.streetAddress1 <> DueDiligence.Constants.EMPTY OR addressClean.prim_name <> DueDiligence.Constants.EMPTY) AND addressClean.city <> DueDiligence.Constants.EMPTY AND addressClean.state <> DueDiligence.Constants.EMPTY AND addressClean.zip <> DueDiligence.Constants.EMPTY;

                                          //Clean Phone Number
                                          phoneNumber := IF(personRequest, LEFT.rawPerson.phone, LEFT.rawBusiness.phone);
                                          phoneToClean := stripNonNumericValues(phoneNumber);

                                          //Remove any non-numeric fiends from taxID and lexID fields
                                          taxID := IF(personRequest, LEFT.rawPerson.taxID, LEFT.rawBusiness.taxID);
                                          taxIDToClean := stripNonNumericValues(taxID);

                                          lexID := IF(personRequest, LEFT.rawPerson.lexID, LEFT.rawBusiness.lexID);
                                          validLexID := (UNSIGNED6)stripNonNumericValues((STRING)lexID);

                                          //Valid history date passed - if invalid should return 99999999 for current mode
                                          validDate := DueDiligence.Common.checkInvalidDate((STRING)LEFT.historyDateYYYYMMDD, (STRING)DueDiligence.Constants.date8Nines);




                                          //=======Fields pertaining to Citizenship Only=======
                                          phone2ToClean := stripNonNumericValues(LEFT.phone2);

                                          //only populated for Citizenship
                                          SELF.modelName := IF(citizenshipRequested, LEFT.modelName, DueDiligence.Constants.EMPTY);
                                          SELF.phone2 := IF(citizenshipRequested, phone2ToClean, DueDiligence.Constants.EMPTY);
                                          SELF.dlNumber := IF(citizenshipRequested, LEFT.dlNumber, DueDiligence.Constants.EMPTY);
                                          SELF.dlState := IF(citizenshipRequested, LEFT.dlState, DueDiligence.Constants.EMPTY);
                                          SELF.email := IF(citizenshipRequested, LEFT.email, DueDiligence.Constants.EMPTY);




                                          //=======Fields pertaining to Due Diligence Only=======
                                          //Clean Company Name
                                          busName := LEFT.rawBusiness.companyName;
                                          altBusName := LEFT.rawBusiness.altCompanyName;

                                          companyName := IF(busName = DueDiligence.Constants.EMPTY, ut.CleanCompany(altBusName), ut.CleanCompany(busName)); // If the customer didn't pass in a company but passed in an alt company name use the alt as the company name
                                          altCompanyName := IF(busName = DueDiligence.Constants.EMPTY, DueDiligence.Constants.EMPTY, ut.CleanCompany(altBusName)); // Blank out the cleaned AltCompanyName if CompanyName wasn't populated, as we copied Alt into the Main CompanyName field on the previous line

                                          //Populate appropriate cleaned data
                                          SELF.cleanedBusiness := IF(personRequest = FALSE,
                                                                      DATASET([TRANSFORM(DueDiligence.Layouts.BusInput,
                                                                                          SELF.lexID := validLexID;
                                                                                          SELF.companyName := companyName;
                                                                                          SELF.altCompanyName := altCompanyName;
                                                                                          SELF.address := addressClean;
                                                                                          SELF.phone := IF(Business_Risk_BIP.Common.validPhone(phoneToClean), phoneToClean, DueDiligence.Constants.EMPTY);
                                                                                          SELF.taxID := taxIDToClean;
                                                                                          SELF := [];)]),
                                                                      DATASET([], DueDiligence.Layouts.BusInput))[1];





                                          SELF.cleanedPerson := IF(personRequest,
                                                                    DATASET([TRANSFORM(DueDiligence.Layouts.IndInput,
                                                                                        SELF.lexID := validLexID;
                                                                                        SELF.name := DATASET([TRANSFORM(DueDiligence.Layouts.Name,
                                                                                                                        unparsedName := STD.Str.ToUpperCase(LEFT.rawPerson.name.fullName);
                                                                                                                        fName := STD.Str.ToUpperCase(LEFT.rawPerson.name.firstName);
                                                                                                                        mName := STD.Str.ToUpperCase(LEFT.rawPerson.name.middleName);
                                                                                                                        lName := STD.Str.ToUpperCase(LEFT.rawPerson.name.lastName);
                                                                                                                        sName := STD.Str.ToUpperCase(LEFT.rawPerson.name.suffix);


                                                                                                                        cleanedName := MAP(STD.Str.ToUpperCase(LEFT.rawPerson.nameInputOrder) = 'FML' => Address.CleanPersonFML73(unparsedName),
                                                                                                                                           STD.Str.ToUpperCase(LEFT.rawPerson.nameInputOrder) = 'LFM' => Address.CleanPersonLFM73(unparsedName),
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
                                                                                        SELF.taxID := taxIDToClean;
                                                                                        SELF.nameInputOrder := LEFT.rawPerson.nameInputOrder;
                                                                                        SELF.dob := LEFT.rawPerson.dob;
                                                                                        SELF := [];)]),
                                                                    DATASET([], DueDiligence.Layouts.IndInput))[1];


                                          SELF.historyDateYYYYMMDD := (UNSIGNED)validDate;

                                          SELF.addressProvided := addrProvided;
                                          SELF.fullCleanAddressExists := fullAddrProvided;
                                          SELF.lexIDPopulated := validLexID > 0;
                                          SELF.piiPopulated := addrProvided OR
                                                               taxIDToClean <> DueDiligence.Constants.EMPTY OR
                                                               phoneToClean <> DueDiligence.Constants.EMPTY OR
                                                               SELF.cleanedPerson.name.fullName <> DueDiligence.Constants.EMPTY OR
                                                               SELF.cleanedPerson.name.firstName <> DueDiligence.Constants.EMPTY OR
                                                               SELF.cleanedPerson.name.middleName <> DueDiligence.Constants.EMPTY OR
                                                               SELF.cleanedPerson.name.lastName <> DueDiligence.Constants.EMPTY OR
                                                               SELF.cleanedPerson.name.suffix <> DueDiligence.Constants.EMPTY OR
                                                               companyName <> DueDiligence.Constants.EMPTY OR
                                                               altCompanyName <> DueDiligence.Constants.EMPTY;




                                          SELF.containsCitizenshipReq := citizenshipRequested;
                                          SELF.containsPersonReq := personRequest;

                                          SELF := LEFT;));
    END;


    EXPORT GetCompliance(UNSIGNED3 dppaIn, UNSIGNED3 glbaIn, STRING drmIn, STRING dpmIn, STRING10 industryIn,
                             UNSIGNED1 lexIDSrcOptOutIn, STRING transIDIn, STRING batchUIDIn, UNSIGNED6 globalCoIDIn,
                             STRING ssnMask) := FUNCTION

        compliance := MODULE(DueDiligence.DDInterface.iDDRegulatoryCompliance)
            EXPORT UNSIGNED3 glba := glbaIn;
            EXPORT UNSIGNED3 dppa := dppaIn;
            EXPORT STRING drm := drmIn;
            EXPORT STRING dpm := dpmIn;
            EXPORT STRING10 industryClass := industryIn;
            EXPORT STRING ssn_mask := ssnMask;

            //CCPA Regulatory fields
            EXPORT UNSIGNED1 lexIDSourceOptOut := lexIDSrcOptOutIn;
            EXPORT STRING transactionID := transIDIn;
            EXPORT STRING batchUID := batchUIDIn;
            EXPORT UNSIGNED6 globalCompanyID := globalCoIDIn;
        END;

        RETURN compliance;
    END;

    EXPORT GetPersonOptions(STRING10 ssnMaskIn,
                            UNSIGNED1 inputUsageIn = DueDiligence.Constants.USE_INPUT_DATA_ENUM.DD_RULES,
                            BOOLEAN includeReport = FALSE,
                            BOOLEAN includeCit = FALSE,
                            DATASET(Risk_Indicators.Layout_Boca_Shell) shell = DATASET([], Risk_Indicators.Layout_Boca_Shell)) := FUNCTION

        options := MODULE(DueDiligence.DDInterface.iDDPersonOptions)
            EXPORT BOOLEAN includeCitizenship := includeCit;
            EXPORT BOOLEAN includeReportData := includeReport;
            EXPORT STRING10 ssnMask := ssnMaskIn;
            EXPORT UNSIGNED1 inputUsage := inputUsageIn; //see DueDiligence.Constants.USE_INPUT_DATA_ENUM for values/explainations
            EXPORT DATASET(Risk_Indicators.Layout_Boca_Shell) bs := shell;
        END;

        RETURN options;
    END;

    EXPORT GetBusinessOptions(STRING10 ssnMaskIn,
                              UNSIGNED1 inputUsageIn = DueDiligence.Constants.USE_INPUT_DATA_ENUM.DD_RULES,
                              BOOLEAN includeReport = FALSE) := FUNCTION

        options := MODULE(DueDiligence.DDInterface.iDDBusinessOptions)
            EXPORT BOOLEAN includeReportData := includeReport;
            EXPORT STRING10 ssnMask := ssnMaskIn;
            EXPORT UNSIGNED1 inputUsage := inputUsageIn; //see DueDiligence.Constants.USE_INPUT_DATA_ENUM for values/explainations
        END;

        RETURN options;
    END;

    EXPORT GetPersonAttributes(DueDiligence.Layouts.Input input) := FUNCTION

        setMods := SET(input.requestedModules, STD.Str.ToUpperCase(TRIM(attributeModules)));
        useMods := STD.Str.ToLowerCase(TRIM(input.productRequested)) = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_MODULES AND COUNT(setMods) > 0;

        allAttributes := STD.Str.ToLowerCase(TRIM(input.productRequested)) IN [DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_ONLY, DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP];


        attrs := MODULE(DueDiligence.DDInterface.iDDv3PersonAttributes)
            EXPORT BOOLEAN includeAssetOwnProperty := useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN setMods;
            EXPORT BOOLEAN includeAssetOwnAircraft := useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN setMods;
            EXPORT BOOLEAN includeAssetOwnWatercraft := useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN setMods;
            EXPORT BOOLEAN includeAssetOwnVehicle := useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN setMods;
            EXPORT BOOLEAN includeAccessToFundsIncome := useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN setMods;
            EXPORT BOOLEAN includeAccessToFundsProperty := useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN setMods;
            EXPORT BOOLEAN includeGeographic := useMods AND DueDiligence.ConstantsQuery.MODULE_GEOGRAPHIC IN setMods;
            EXPORT BOOLEAN includeMobility := useMods AND DueDiligence.ConstantsQuery.MODULE_GEOGRAPHIC IN setMods;
            EXPORT BOOLEAN includeStateLegalEvent := useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN setMods;
            // EXPORT BOOLEAN includeFederalLegalEvent := useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN setMods; //not yet implemented
            // EXPORT BOOLEAN includeFederalLegalMatchLevel := useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN setMods;  //not yet implemented
            EXPORT BOOLEAN includeCivilLegalEvent := useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN setMods;
            EXPORT BOOLEAN includeCivilLegalEventFilingAmount := useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN setMods;
            EXPORT BOOLEAN includeOffenseType := useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN setMods;
            EXPORT BOOLEAN includeAgeRange := useMods AND DueDiligence.ConstantsQuery.MODULE_IDENTITY IN setMods;
            EXPORT BOOLEAN includeIdentityRisk := useMods AND DueDiligence.ConstantsQuery.MODULE_IDENTITY IN setMods;
            EXPORT BOOLEAN includeUSResidency := useMods AND DueDiligence.ConstantsQuery.MODULE_IDENTITY IN setMods;
            EXPORT BOOLEAN includeMatchLevel := allAttributes OR useMods;
            EXPORT BOOLEAN includeAssociates := useMods AND DueDiligence.ConstantsQuery.MODULE_NETWORK IN setMods;
            // EXPORT BOOLEAN includeEmploymentIndustry := useMods AND DueDiligence.ConstantsQuery.MODULE_NETWORK IN setMods; //not yet implemented
            EXPORT BOOLEAN includeProfLicense := useMods AND DueDiligence.ConstantsQuery.MODULE_NETWORK IN setMods;
            EXPORT BOOLEAN includeBusAssociations := useMods AND DueDiligence.ConstantsQuery.MODULE_NETWORK IN setMods;
            EXPORT BOOLEAN includeAll := allAttributes;
        END;

        RETURN attrs;
    END;

    EXPORT GetBusinessAttributes(DueDiligence.Layouts.Input input) := FUNCTION

        setMods := SET(input.requestedModules, STD.Str.ToUpperCase(TRIM(attributeModules)));
        useMods := STD.Str.ToLowerCase(TRIM(input.productRequested)) = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_MODULES AND COUNT(setMods) > 0;

        allAttributes := STD.Str.ToLowerCase(TRIM(input.productRequested)) = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_ONLY;


        attrs := MODULE(DueDiligence.DDInterface.iDDv3BusinessAttributes)
            EXPORT BOOLEAN includeAssetOwnProperty := useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN setMods;
            EXPORT BOOLEAN includeAssetOwnAircraft := useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN setMods;
            EXPORT BOOLEAN includeAssetOwnWatercraft := useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN setMods;
            EXPORT BOOLEAN includeAssetOwnVehicle := useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN setMods;
            EXPORT BOOLEAN includeAccessToFundSales := useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN setMods;
            EXPORT BOOLEAN includeAccessToFundsProperty := useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN setMods;
            EXPORT BOOLEAN includeGeographic := useMods AND DueDiligence.ConstantsQuery.MODULE_OPERATING IN setMods;
            EXPORT BOOLEAN includeValidity := useMods AND DueDiligence.ConstantsQuery.MODULE_OPERATING IN setMods;
            EXPORT BOOLEAN includeStability := useMods AND DueDiligence.ConstantsQuery.MODULE_OPERATING IN setMods;
            EXPORT BOOLEAN includeIndustry := useMods AND DueDiligence.ConstantsQuery.MODULE_OPERATING IN setMods;
            EXPORT BOOLEAN includeStructureType := useMods AND DueDiligence.ConstantsQuery.MODULE_OPERATING IN setMods;
            EXPORT BOOLEAN includeSOSAgeRange := useMods AND DueDiligence.ConstantsQuery.MODULE_OPERATING IN setMods;
            EXPORT BOOLEAN includePublicRecordAgeRange := useMods AND DueDiligence.ConstantsQuery.MODULE_OPERATING IN setMods;
            EXPORT BOOLEAN includeShellShelf := useMods AND DueDiligence.ConstantsQuery.MODULE_OPERATING IN setMods;
            EXPORT BOOLEAN includeMatchLevel := allAttributes OR useMods;
            EXPORT BOOLEAN includeStateLegalEvent := useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN setMods;
            // EXPORT BOOLEAN includeFederalLegalEvent := useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN setMods;
            // EXPORT BOOLEAN includeFederalLegalMatchLevel := useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN setMods;
            EXPORT BOOLEAN includeCivilLegalEvent := useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN setMods;
            EXPORT BOOLEAN includeCivilLegalEventFilingAmount := useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN setMods;
            EXPORT BOOLEAN includeOffenseType := useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN setMods;
            EXPORT BOOLEAN includeBEOProfLicense := useMods AND DueDiligence.ConstantsQuery.MODULE_NETWORK IN setMods;
            EXPORT BOOLEAN includeBEOUSResidency := useMods AND DueDiligence.ConstantsQuery.MODULE_NETWORK IN setMods;
            EXPORT BOOLEAN includeBEOAccessToFundsProperty := useMods AND DueDiligence.ConstantsQuery.MODULE_NETWORK IN setMods;
            // EXPORT BOOLEAN includeLinkedBusinesses := useMods AND DueDiligence.ConstantsQuery.MODULE_NETWORK IN setMods;
            EXPORT BOOLEAN includeAll := allAttributes;
        END;

        RETURN attrs;
    END;



    EXPORT v3PersonResults(DATASET(DueDiligence.Layouts.Input) cleanData, DueDiligence.DDInterface.iDDRegulatoryCompliance compliance,
                        BOOLEAN rptBoolean, BOOLEAN debugIndicator, BOOLEAN modelIntermediates) := FUNCTION


        personOptions := GetPersonOptions(ssnMaskIn := compliance.ssn_mask, includeCit := cleanData[1].containsCitizenshipReq, includeReport := rptBoolean);
        personAttributes := GetPersonAttributes(cleanData[1]);

        //convert data to version 3 input
        v3PersonInput := PROJECT(cleanData, TRANSFORM(DueDiligence.v3Layouts.DDInput.PersonSearch,
                                                      SELF.seq := LEFT.seq;
                                                      SELF.accountNumber := LEFT.accountNumber;
                                                      SELF.historyDateRaw := LEFT.historyDateYYYYMMDD;
                                                      SELF.modelName := LEFT.modelName;
                                                      SELF.rawData := DATASET([TRANSFORM(DueDiligence.v3Layouts.DDInput.Person,
                                                                                          SELF.lexID := LEFT.rawPerson.lexID;
                                                                                          SELF.fullName := LEFT.rawPerson.name.fullName;
                                                                                          SELF.firstName := LEFT.rawPerson.name.firstName;
                                                                                          SELF.middleName := LEFT.rawPerson.name.middleName;
                                                                                          SELF.lastName := LEFT.rawPerson.name.lastName;
                                                                                          SELF.suffix := LEFT.rawPerson.name.suffix;
                                                                                          SELF.dob := (UNSIGNED4)LEFT.rawPerson.dob;
                                                                                          SELF.phone := LEFT.rawPerson.phone;
                                                                                          SELF.ssn := LEFT.rawPerson.taxID;
                                                                                          SELF := LEFT.rawPerson.address;
                                                                                          SELF := [];)])[1];

                                                      SELF.searchBy := DATASET([TRANSFORM(DueDiligence.v3Layouts.DDInput.Person,
                                                                                          SELF.lexID := LEFT.cleanedPerson.lexID;
                                                                                          SELF.fullName := LEFT.cleanedPerson.name.fullName;
                                                                                          SELF.firstName := LEFT.cleanedPerson.name.firstName;
                                                                                          SELF.middleName := LEFT.cleanedPerson.name.middleName;
                                                                                          SELF.lastName := LEFT.cleanedPerson.name.lastName;
                                                                                          SELF.suffix := LEFT.cleanedPerson.name.suffix;
                                                                                          SELF.dob := (UNSIGNED4)LEFT.cleanedPerson.dob;
                                                                                          SELF.phone := LEFT.cleanedPerson.phone;
                                                                                          SELF.ssn := LEFT.cleanedPerson.taxID;
                                                                                          SELF.phone2 := LEFT.phone2;
                                                                                          SELF.dlNumber := LEFT.dlNumber;
                                                                                          SELF.dlState := LEFT.dlState;
                                                                                          SELF.email := LEFT.email;
                                                                                          SELF := LEFT.cleanedPerson.address;
                                                                                          SELF := [];)])[1];

                                                      SELF := [];));

        //getData
        perResults := DueDiligence.v3.getPerson(v3PersonInput, personAttributes, compliance, personOptions, debugIndicator, modelIntermediates);



        IF(debugIndicator, OUTPUT(cleanData, NAMED('v3PersonResults_input')));
        IF(debugIndicator, OUTPUT(v3PersonInput, NAMED('v3PersonInput')));
        IF(debugIndicator, OUTPUT(perResults, NAMED('v3PerResults')));

        RETURN perResults;
    END;

    EXPORT v3BusinessResults(DATASET(DueDiligence.Layouts.Input) inCleanData, DueDiligence.DDInterface.iDDRegulatoryCompliance compliance,
                              BOOLEAN rptBoolean = FALSE, BOOLEAN debugIndicator = FALSE) := FUNCTION


        businessOptions := GetBusinessOptions(ssnMaskIn := compliance.ssn_mask, includeReport := rptBoolean);
        businessAttributes := GetBusinessAttributes(inCleanData[1]);

        v3BusinessInput := PROJECT(inCleanData, TRANSFORM(DueDiligence.v3Layouts.DDInput.BusinessSearch,
                                                           SELF.seq := LEFT.seq;
                                                           SELF.accountNumber := LEFT.accountNumber;
                                                           SELF.historyDateRaw := LEFT.historyDateYYYYMMDD;
                                                           SELF.rawData := DATASET([TRANSFORM(DueDiligence.v3Layouts.DDInput.Business,
                                                                                                SELF.seleID := LEFT.rawBusiness.lexID;
                                                                                                SELF.companyName := LEFT.rawBusiness.companyName;
                                                                                                SELF.phone := LEFT.rawBusiness.phone;
                                                                                                SELF.fein := LEFT.rawBusiness.taxID;
                                                                                                SELF := LEFT.rawBusiness.address;
                                                                                                SELF := [];)])[1];

                                                           SELF.searchBy := DATASET([TRANSFORM(DueDiligence.v3Layouts.DDInput.Business,
                                                                                                SELF.seleID := LEFT.cleanedBusiness.lexID;
                                                                                                SELF.companyName := LEFT.cleanedBusiness.companyName;
                                                                                                SELF.phone := LEFT.cleanedBusiness.phone;
                                                                                                SELF.fein := LEFT.cleanedBusiness.taxID;
                                                                                                SELF := LEFT.cleanedBusiness.address;
                                                                                                SELF := [];)])[1];

                                                           SELF := [];));

        //getData
        busResults := DueDiligence.v3.getBusiness(v3BusinessInput, businessAttributes, compliance, businessOptions, debugIndicator);

        RETURN busResults;
    END;



END;

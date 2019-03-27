IMPORT Address, Business_Header, Business_Risk_BIP, Citizenship, DueDiligence, iesp, Risk_Indicators, STD, ut;


EXPORT CommonQuery := MODULE
		
    EXPORT mac_AddressFromRequest(reportedBy) := MACRO
        
        indBusAddr := reportedBy.address;
        address_in := DATASET([TRANSFORM(DueDiligence.Layouts.Address,
                                          SELF.prim_range := TRIM(indBusAddr.streetnumber);
                                          SELF.predir := TRIM(indBusAddr.streetPreDirection);
                                          SELF.prim_name := TRIM(indBusAddr.streetName);
                                          SELF.addr_suffix := TRIM(indBusAddr.streetSuffix);
                                          SELF.postdir := TRIM(indBusAddr.streetPostDirection);
                                          SELF.unit_desig := TRIM(indBusAddr.unitDesignation);
                                          SELF.sec_range := TRIM(indBusAddr.unitNumber);
                                          SELF.streetAddress1 := TRIM(indBusAddr.streetAddress1);
                                          SELF.streetAddress2 := TRIM(indBusAddr.streetAddress2);
                                          SELF.city := TRIM(indBusAddr.city);
                                          SELF.state := TRIM(indBusAddr.state);
                                          SELF.zip5 := TRIM(indBusAddr.zip5);
                                          SELF.zip4 := TRIM(indBusAddr.zip4);
                                          SELF.county := TRIM(indBusAddr.county);
                                          SELF := [];)]);
    ENDMACRO;
		
    EXPORT PopulateIndividualFromRequest(reportedBy, acctNo, indvIndicator) := FUNCTIONMACRO
        
        #if(indvIndicator <> DueDiligence.Constants.BUSINESS)
            
            personInfo := reportedBy.person;
            DueDiligence.CommonQuery.mac_AddressFromRequest(personInfo);
            
            ind_in := DATASET([TRANSFORM(DueDiligence.Layouts.Indv_Input,
                                          SELF.lexID := TRIM(personInfo.lexID);
                                          SELF.name := DATASET([TRANSFORM(DueDiligence.Layouts.Name,
                                                                          SELF.fullName := TRIM(personInfo.name.full);
                                                                          SELF.firstName := TRIM(personInfo.name.first);
                                                                          SELF.middleName := TRIM(personInfo.name.middle);
                                                                          SELF.lastName := TRIM(personInfo.name.last);
                                                                          SELF.suffix := TRIM(personInfo.name.suffix);
                                                                          SELF := [];)])[1];
                                          SELF.address := address_in[1];
                                          SELF.phone := TRIM(personInfo.phone);
                                          SELF.ssn := TRIM(personInfo.ssn);
                                          SELF.accountNumber := TRIM(acctNo);
                                          SELF.dob := (INTFORMAT(personInfo.dob.Year, 4, 1) + INTFORMAT(personInfo.dob.Month, 2, 1) + INTFORMAT(personInfo.dob.Day, 2, 1));
                                          SELF := [];)]);
        #else
            ind_in := DATASET([], DueDiligence.Layouts.Indv_Input);
        #end

        RETURN ind_in;
    ENDMACRO;
		
    EXPORT PopulateBusinessFromRequest(reportedBy, acctNo, busIndicator) := FUNCTIONMACRO
        
        #if(busIndicator <> DueDiligence.Constants.INDIVIDUAL)
            
            businessInfo := reportedBy.business;
            DueDiligence.CommonQuery.mac_AddressFromRequest(businessInfo);
            
            bus_in := DATASET([TRANSFORM(DueDiligence.Layouts.Busn_Input,
                                          SELF.lexID := TRIM(businessInfo.lexID);
                                          SELF.accountNumber := TRIM(acctNo);
                                          SELF.companyName := TRIM(businessInfo.companyName);
                                          SELF.altCompanyName := TRIM(businessInfo.alternateCompanyName);
                                          SELF.address := address_in[1];
                                          SELF.fein := TRIM(businessInfo.fein);
                                          SELF := [];)]);
        #else
            bus_in := DATASET([], DueDiligence.Layouts.Busn_Input);
        #end

        RETURN bus_in;
    ENDMACRO;
		
    EXPORT mac_CreateInputFromXML(requestType, requestStoredName, requestedReport, serviceRequested) := MACRO
				
        // Can't have duplicate definitions of Stored with different default values, 
        // so add the default to #stored to eliminate the assignment of a default value.
        #STORED('DPPAPurpose', Business_Risk_BIP.Constants.Default_DPPA);
        #STORED('GLBPurpose',  Business_Risk_BIP.Constants.Default_GLBA);


        //Get debugging indicator
        debugIndicator := FALSE : STORED('debugMode');
        intermediates := FALSE : STORED('intermediateVariables');

        // Get XML input 
        requestIn := DATASET([], requestType) : STORED(requestStoredName, FEW);

        firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime AND not batch, should only have one row on input.

        optionsIn := GLOBAL(firstRow.options);
        userIn := GLOBAL(firstRow.user);  
        search := GLOBAL(firstRow.reportBy);

        //Fields for test seeds
        BOOLEAN executeTestSeeds := userIn.testDataEnabled;
        STRING testSeedTableName := userIn.testDataTableName;

        //get outer band data - to use if customer data is not populated
        UNSIGNED1 outerBandDPPAPurpose := Business_Risk_BIP.Constants.Default_DPPA : STORED('DPPAPurpose');
        UNSIGNED1 outerBandGLBPurpose  := Business_Risk_BIP.Constants.Default_GLBA : STORED('GLBPurpose');
        outerBandHistoryDate           := DueDiligence.Constants.NUMERIC_ZERO      : STORED('HistoryDateYYYYMMDD');
        STRING6 outerBandSSNMASK       := Business_Risk_BIP.Constants.Default_SSNMask : STORED('SSNMask');  


        //The general rule for picking these options is to look in the inner band (ie the User section) first
        //If the inner band fields are not populated look in the outer band or the Default from the Global Module 
        drm	    := IF(TRIM(userIn.DataRestrictionMask) <> DueDiligence.Constants.EMPTY, userIn.DataRestrictionMask, AutoStandardI.GlobalModule().DataRestrictionMask);
        dpm	    := IF(TRIM(userIn.DataPermissionMask) <> DueDiligence.Constants.EMPTY, userIn.DataPermissionMask, AutoStandardI.GlobalModule().DataPermissionMask);
        dppa    := IF((UNSIGNED1)userIn.DLPurpose > DueDiligence.Constants.NUMERIC_ZERO, (UNSIGNED1)userIn.DLPurpose, outerBandDPPAPurpose);
        glba    := IF((UNSIGNED1)userIn.GLBPurpose > DueDiligence.Constants.NUMERIC_ZERO, (UNSIGNED1)userIn.GLBPurpose, outerBandGLBPurpose);
        STRING6 DD_SSNMask := IF(userIn.SSNMask != DueDiligence.Constants.EMPTY, TRIM(userIn.SSNMask), TRIM(outerBandSSNMASK));    //*** EXPECTING ALL/LAST4/FIRST5 from MBS   

        //since the initial version can be defaulted, default options for person and business reports only; attributes need to be requested
        defaultVersion := MAP(TRIM(STD.Str.ToUpperCase(optionsIn.DDAttributesVersionRequest)) <> DueDiligence.Constants.EMPTY => TRIM(STD.Str.ToUpperCase(optionsIn.DDAttributesVersionRequest)),
                              serviceRequested = DueDiligence.Constants.BUSINESS => DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3,
                              serviceRequested = DueDiligence.Constants.INDIVIDUAL => DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3,
                              DueDiligence.Constants.EMPTY);
                              
        requestedVersion := defaultVersion;
        includeReport := requestedReport;
        displayAttributeText := optionsIn.displayText;       

        requestedSource := MAP(STD.Str.ToUpperCase(TRIM(optionsIn.IncludeSpecialAttributes)) = 'NONE' => DueDiligence.Constants.REQUESTED_SOURCE_ENUM.NONE,
                                STD.Str.ToUpperCase(TRIM(optionsIn.IncludeSpecialAttributes)) = 'ONLINE' => DueDiligence.Constants.REQUESTED_SOURCE_ENUM.ONLINE,
                                STD.Str.ToUpperCase(TRIM(optionsIn.IncludeSpecialAttributes)) = 'BATCH' => DueDiligence.Constants.REQUESTED_SOURCE_ENUM.BATCH,
                                DueDiligence.Constants.REQUESTED_SOURCE_ENUM.EMPTY);




        wseq := PROJECT(requestIn, TRANSFORM({INTEGER4 seq, RECORDOF(requestIn)}, SELF.seq := COUNTER, SELF := LEFT));

        input := PROJECT(wseq, TRANSFORM(DueDiligence.Layouts.Input,

                                          version := requestedVersion;
                                          reportBy := LEFT.reportBy;
                                          
                                          populatedInd := DueDiligence.CommonQuery.PopulateIndividualFromRequest(reportBy, LEFT.user.accountNumber, serviceRequested);
                                          populatedBus := DueDiligence.CommonQuery.PopulateBusinessFromRequest(reportBy, LEFT.user.accountNumber, serviceRequested);
                                          
                                          
                                          useHistDate := (UNSIGNED4)(INTFORMAT(LEFT.options.HistoryDate.Year, 4, 1) + INTFORMAT(LEFT.options.HistoryDate.Month, 2, 1) + INTFORMAT(LEFT.options.HistoryDate.Day, 2, 1));
                                          histDate := IF(useHistDate > 0, useHistDate, (UNSIGNED4)outerBandHistoryDate);
                                                                          
                                          SELF.seq := LEFT.seq;
                                          SELF.individual := populatedInd[1];
                                          SELF.business := populatedBus[1];
                                          SELF.historyDateYYYYMMDD := histDate;
                                          SELF.requestedVersion := version;
                                          
                                          //Citizenship fields
                                          #IF(serviceRequested = DueDiligence.Constants.ATTRIBUTES)
                                            SELF.modelName := reportBy.person.citizenship.citizenshipModelName;
                                            SELF.phone2 := reportBy.person.citizenship.phone2;
                                            SELF.dlNumber := reportBy.person.citizenship.dlNumber;
                                            SELF.dlState := reportBy.person.citizenship.dlState;
                                            SELF.email := reportBy.person.citizenship.email;
                                            
                                            SELF.productRequested := search.ProductRequestType;
                                          #END
                                          
                                          SELF := [];));
    ENDMACRO;
		
		
    EXPORT ValidateRequest(DATASET(DueDiligence.Layouts.Input) input, UNSIGNED1 glbPurpose, UNSIGNED1 dppaPurpose, STRING11 requestedService):= FUNCTION
        
        BOOLEAN ValidGLB := DueDiligence.CitDDShared.isValidGLBA(glbPurpose);
        BOOLEAN ValidDPPA := DueDiligence.CitDDShared.isValidDPPA(dppaPurpose);
                                                      
        validatedRequests := PROJECT(input, TRANSFORM(DueDiligence.Layouts.Input,
                                                      //Validate the request
                                                      BOOLEAN ValidIndVersion := LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS;
                                                      BOOLEAN ValidBusVersion := LEFT.requestedVersion IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS;

                                                      STRING OhNoMessage := MAP(ValidIndVersion = FALSE AND ValidBusVersion = FALSE => DueDiligence.Constants.VALIDATION_INVALID_VERSION,
                                                                                ValidGLB = FALSE => DueDiligence.CitDDShared.VALIDATION_INVALID_GLB,
                                                                                ValidDPPA = FALSE => DueDiligence.CitDDShared.VALIDATION_INVALID_DPPA,
                                                                                DueDiligence.Constants.EMPTY);
                                                                                
                                                      validVersions := MAP(TRIM(requestedService) = DueDiligence.Constants.BUSINESS => DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3,
                                                                           TRIM(requestedService) = DueDiligence.Constants.INDIVIDUAL => DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3,
                                                                           DueDiligence.Constants.IND_REQ_ATTRIBUTE_V3 + ' OR ' + DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3);
                                                            
                                                      versionReq := ': ' + validVersions;
                                                      updatedOhNoMessage := IF(OhNoMessage = DueDiligence.Constants.VALIDATION_INVALID_VERSION, TRIM(OhNoMessage) + versionReq, OhNoMessage);

                                                      trimOhNo := TRIM(updatedOhNoMessage);


                                                      SELF.validRequest := trimOhNo = DueDiligence.Constants.EMPTY;
                                                      SELF.errorMessage := trimOhNo;
                                                      SELF := LEFT;));

        RETURN validatedRequests;
    END;
		
		
		EXPORT mac_FailOnError(invalidRequests) := MACRO
				IF(COUNT(invalidRequests) > 0 AND invalidRequests[1].validRequest = FALSE, FAIL(invalidRequests[1].errorMessage));
		ENDMACRO;
			
			
    EXPORT GetCleanData(DATASET(DueDiligence.Layouts.Input) input) := FUNCTION
			
        cleanData := PROJECT(input, TRANSFORM(DueDiligence.Layouts.CleanedData,
                                              //Clean Address
                                              addressToClean := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, LEFT.individual.address, LEFT.business.address);
                                              addressClean := DueDiligence.CitDDShared.cleanAddress(addressToClean);

                                              addrProvided := addressToClean.streetAddress1 <> DueDiligence.Constants.EMPTY OR addressToClean.streetAddress2 <> DueDiligence.Constants.EMPTY OR addressToClean.prim_range <> DueDiligence.Constants.EMPTY OR addressToClean.predir <> DueDiligence.Constants.EMPTY OR 
                                                              addressToClean.prim_name <> DueDiligence.Constants.EMPTY OR addressToClean.addr_suffix <> DueDiligence.Constants.EMPTY OR addressToClean.postdir <> DueDiligence.Constants.EMPTY OR addressToClean.unit_desig <> DueDiligence.Constants.EMPTY OR 
                                                              addressToClean.sec_range <> DueDiligence.Constants.EMPTY OR addressToClean.city <> DueDiligence.Constants.EMPTY OR addressToClean.state <> DueDiligence.Constants.EMPTY OR addressToClean.zip5 <> DueDiligence.Constants.EMPTY;	
                                                              
                                              fullAddrProvided := (addressClean.streetAddress1 <> DueDiligence.Constants.EMPTY OR addressClean.prim_name <> DueDiligence.Constants.EMPTY) AND addressClean.city <> DueDiligence.Constants.EMPTY AND addressClean.state <> DueDiligence.Constants.EMPTY AND addressClean.zip5 <> DueDiligence.Constants.EMPTY;

                                              //Clean Company Name
                                              busName := LEFT.business.companyName;
                                              altBusName := LEFT.business.altCompanyName;


                                              companyName := IF(busName = DueDiligence.Constants.EMPTY, ut.CleanCompany(altBusName), ut.CleanCompany(busName)); // If the customer didn't pass in a company but passed in an alt company name use the alt as the company name
                                              altCompanyName := IF(busName = DueDiligence.Constants.EMPTY, DueDiligence.Constants.EMPTY, ut.CleanCompany(altBusName)); // Blank out the cleaned AltCompanyName if CompanyName wasn't populated, as we copied Alt into the Main CompanyName field on the previous line

                                              //Clean Phone Number
                                              phoneNumber := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, LEFT.individual.phone, LEFT.business.phone);
                                              phoneToClean := DueDiligence.CitDDShared.stripNonNumericValues(phoneNumber);

                                              //Remove any non-numeric fiends from taxID and lexID fields
                                              taxID := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, LEFT.individual.ssn, LEFT.business.fein);
                                              taxIDToClean := DueDiligence.CitDDShared.stripNonNumericValues(taxID);
                                              validTaxID := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, 
                                                                IF(Business_Header.IsValidSsn((UNSIGNED)taxIDToClean), taxIDToClean, DueDiligence.Constants.EMPTY), 
                                                                IF(Business_Header.ValidFEIN((UNSIGNED)taxIDToClean), taxIDToClean, DueDiligence.Constants.EMPTY ));

                                              lexID := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, LEFT.individual.lexID, LEFT.business.lexID);
                                              validLexID := DueDiligence.CitDDShared.stripNonNumericValues(lexID);

                                              //Valid history date passed - if invalid should return 99999999 for current mode
                                              validDate := DueDiligence.Common.checkInvalidDate((STRING)LEFT.historyDateYYYYMMDD, (STRING)DueDiligence.Constants.date8Nines);

                                              //Populate appropriate cleaned data	
                                              busClean := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS, 
                                                                              DATASET([TRANSFORM(DueDiligence.Layouts.Busn_Input,
                                                                                                  SELF.lexID := validLexID;
                                                                                                  SELF.companyName := companyName;
                                                                                                  SELF.altCompanyName := altCompanyName;
                                                                                                  SELF.address := addressClean;
                                                                                                  SELF.phone := IF(Business_Risk_BIP.Common.validPhone(phoneToClean), phoneToClean, DueDiligence.Constants.EMPTY);
                                                                                                  SELF.fein := validTaxID;
                                                                                                  SELF.BIP_IDs.SeleID.LinkID := (UNSIGNED6)validLexID;
                                                                                                  SELF := LEFT.business;
                                                                                                  SELF := [];)]),
                                                                              DATASET([], DueDiligence.Layouts.Busn_Input));

                                              indClean := IF(LEFT.requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS,
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
                                                                                                  SELF.ssn := validTaxID;
                                                                                                  SELF := LEFT.individual;
                                                                                                  SELF := [];)]),
                                                                              DATASET([], DueDiligence.Layouts.Indv_Input));

                                              inputClean := DATASET([TRANSFORM(DueDiligence.Layouts.Input,
                                                                                SELF.business := busClean[1];
                                                                                SELF.individual := indClean[1];
                                                                                SELF.historyDateYYYYMMDD := (UNSIGNED)validDate;
                                                                                SELF.addressProvided := addrProvided;
                                                                                SELF.fullAddressProvided := fullAddrProvided;
                                                                                SELF := LEFT;
                                                                                SELF := [];)])[1];


                                              SELF.cleanedInput := inputClean;
                                              SELF.inputEcho := LEFT;
                                              SELF := []));
			
				
        RETURN cleanData;
    END;
		
		
    EXPORT mac_GetBusinessOptionSettings(dppaIn, glbaIn, drmIn, dpmIn, industryIn) := MACRO
    
        industry := IF(TRIM(industryIn) = DueDiligence.Constants.EMPTY, Business_Risk_BIP.Constants.Default_IndustryClass, industryIn);

        busOptions := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
              // Clean up the Options and make sure that defaults are enforced
              EXPORT UNSIGNED1 DPPA_Purpose := dppaIn;
              EXPORT UNSIGNED1 GLBA_Purpose := glbaIn;
              EXPORT STRING50 DataRestrictionMask	:= TRIM(drmIn);
              EXPORT STRING50 DataPermissionMask	:= TRIM(dpmIn);
              EXPORT STRING10 IndustryClass := STD.Str.ToUpperCase(industry);
              EXPORT UNSIGNED1 LinkSearchLevel := Business_Risk_BIP.Constants.LinkSearch.SeleID;
              EXPORT UNSIGNED1 BusShellVersion := Business_Risk_BIP.Constants.Default_BusShellVersion;
              EXPORT UNSIGNED1 MarketingMode := Business_Risk_BIP.Constants.Default_MarketingMode;
              EXPORT STRING50 AllowedSources := Business_Risk_BIP.Constants.Default_AllowedSources;
              EXPORT UNSIGNED1 BIPBestAppend := Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest;
        END;

        busLinkingOptions := MODULE(BIPV2.mod_sources.iParams)
              EXPORT STRING DataRestrictionMask := busOptions.DataRestrictionMask; 
              EXPORT BOOLEAN ignoreFares := FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore FARES data - default it to FALSE to always utilize whatever the DataRestrictionMask allows
              EXPORT BOOLEAN ignoreFidelity := FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore Fidelity data - default it to FALSE to always utilize whatever the DataRestrictionMask allows
              EXPORT BOOLEAN AllowAll := FALSE;
              EXPORT BOOLEAN AllowGLB := Risk_Indicators.iid_constants.GLB_OK(busOptions.GLBA_Purpose, FALSE);
              EXPORT BOOLEAN AllowDPPA := Risk_Indicators.iid_constants.DPPA_OK(busOptions.DPPA_Purpose, FALSE);
              EXPORT UNSIGNED1 DPPAPurpose := busOptions.DPPA_Purpose;
              EXPORT UNSIGNED1 GLBPurpose := busOptions.GLBA_Purpose;
              EXPORT BOOLEAN IncludeMinors := TRUE; // Shouldn't really have an impact on business searches, set to TRUE for now
              EXPORT BOOLEAN LNBranded := TRUE; // Not entirely certain what effect this has
        END;		
    ENDMACRO;
		
		
    EXPORT GetIndividualAttributes(DATASET(DueDiligence.Layouts.Indv_Internal) results) := FUNCTION
				
        personAttributes := NORMALIZE(UNGROUP(results), DueDiligence.Constants.NUMBER_OF_INDIVIDUAL_ATTRIBUTES, TRANSFORM(iesp.share.t_NameValuePair,
                                                                  SELF := CASE(COUNTER,
                                                                                1  => DueDiligence.Common.createNVPair('PerAssetOwnProperty', LEFT.PerAssetOwnProperty),
                                                                                2  => DueDiligence.Common.createNVPair('PerAssetOwnAircraft', LEFT.PerAssetOwnAircraft),
                                                                                3  => DueDiligence.Common.createNVPair('PerAssetOwnWatercraft', LEFT.PerAssetOwnWatercraft),
                                                                                4  => DueDiligence.Common.createNVPair('PerAssetOwnVehicle', LEFT.PerAssetOwnVehicle),
                                                                                5  => DueDiligence.Common.createNVPair('PerAccessToFundsIncome', LEFT.PerAccessToFundsIncome),
                                                                                6  => DueDiligence.Common.createNVPair('PerAccessToFundsProperty', LEFT.PerAccessToFundsProperty),
                                                                                7  => DueDiligence.Common.createNVPair('PerGeographic', LEFT.PerGeographic),
                                                                                8  => DueDiligence.Common.createNVPair('PerMobility', LEFT.PerMobility),
                                                                                9  => DueDiligence.Common.createNVPair('PerStateLegalEvent', LEFT.PerStateLegalEvent),
                                                                                10 => DueDiligence.Common.createNVPair('PerFederalLegalEvent', LEFT.PerFederalLegalEvent),
                                                                                11 => DueDiligence.Common.createNVPair('PerFederalLegalMatchLevel', LEFT.PerFederalLegalMatchLevel),
                                                                                12 => DueDiligence.Common.createNVPair('PerCivilLegalEvent', LEFT.PerCivilLegalEvent),
                                                                                13 => DueDiligence.Common.createNVPair('PerOffenseType', LEFT.PerOffenseType),
                                                                                14 => DueDiligence.Common.createNVPair('PerAgeRange', LEFT.PerAgeRange),
                                                                                15 => DueDiligence.Common.createNVPair('PerIdentityRisk', LEFT.PerIdentityRisk),
                                                                                16 => DueDiligence.Common.createNVPair('PerUSResidency', LEFT.PerUSResidency),
                                                                                17 => DueDiligence.Common.createNVPair('PerMatchLevel', LEFT.PerMatchLevel),
                                                                                18 => DueDiligence.Common.createNVPair('PerAssociates', LEFT.PerAssociates),
                                                                                19 => DueDiligence.Common.createNVPair('PerEmploymentIndustry', LEFT.PerEmploymentIndustry),
                                                                                20 => DueDiligence.Common.createNVPair('PerProfLicense', LEFT.PerProfLicense),
                                                                                21 => DueDiligence.Common.createNVPair('PerBusAssociations', LEFT.PerBusAssociations),
                                                                                      DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));

	
	
        RETURN personAttributes;
    END;
		
		
    EXPORT GetIndividualAttributeFlags(DATASET(DueDiligence.Layouts.Indv_Internal) results) := FUNCTION
		
        personFlags := NORMALIZE(UNGROUP(results), DueDiligence.Constants.NUMBER_OF_INDIVIDUAL_ATTRIBUTES, TRANSFORM(iesp.share.t_NameValuePair,
                                                                  SELF := CASE(COUNTER,
                                                                                1  => DueDiligence.Common.createNVPair('PerAssetOwnProperty_Flag', LEFT.PerAssetOwnProperty_Flag),
                                                                                2  => DueDiligence.Common.createNVPair('PerAssetOwnAircraft_Flag', LEFT.PerAssetOwnAircraft_Flag),
                                                                                3  => DueDiligence.Common.createNVPair('PerAssetOwnWatercraft_Flag', LEFT.PerAssetOwnWatercraft_Flag),
                                                                                4  => DueDiligence.Common.createNVPair('PerAssetOwnVehicle_Flag', LEFT.PerAssetOwnVehicle_Flag),
                                                                                5  => DueDiligence.Common.createNVPair('PerAccessToFundsIncome_Flag', LEFT.PerAccessToFundsIncome_Flag),
                                                                                6  => DueDiligence.Common.createNVPair('PerAccessToFundsProperty_Flag', LEFT.PerAccessToFundsProperty_Flag),
                                                                                7  => DueDiligence.Common.createNVPair('PerGeographic_Flag', LEFT.PerGeographic_Flag),
                                                                                8  => DueDiligence.Common.createNVPair('PerMobility_Flag', LEFT.PerMobility_Flag),
                                                                                9  => DueDiligence.Common.createNVPair('PerStateLegalEvent_Flag', LEFT.PerStateLegalEvent_Flag),
                                                                                10 => DueDiligence.Common.createNVPair('PerFederalLegalEvent_Flag', LEFT.PerFederalLegalEvent_Flag),
                                                                                11 => DueDiligence.Common.createNVPair('PerFederalLegalMatchLevel_Flag', LEFT.PerFederalLegalMatchLevel_Flag),
                                                                                12 => DueDiligence.Common.createNVPair('PerCivilLegalEvent_Flag', LEFT.PerCivilLegalEvent_Flag),
                                                                                13 => DueDiligence.Common.createNVPair('PerOffenseType_Flag', LEFT.PerOffenseType_Flag),
                                                                                14 => DueDiligence.Common.createNVPair('PerAgeRange_Flag', LEFT.PerAgeRange_Flag),
                                                                                15 => DueDiligence.Common.createNVPair('PerIdentityRisk_Flag', LEFT.PerIdentityRisk_Flag),
                                                                                16 => DueDiligence.Common.createNVPair('PerUSResidency_Flag', LEFT.PerUSResidency_Flag),
                                                                                17 => DueDiligence.Common.createNVPair('PerMatchLevel_Flag', LEFT.PerMatchLevel_Flag),
                                                                                18 => DueDiligence.Common.createNVPair('PerAssociates_Flag', LEFT.PerAssociates_Flag),
                                                                                19 => DueDiligence.Common.createNVPair('PerEmploymentIndustry_Flag', LEFT.PerEmploymentIndustry_Flag),
                                                                                20 => DueDiligence.Common.createNVPair('PerProfLicense_Flag', LEFT.PerProfLicense_Flag),
                                                                                21 => DueDiligence.Common.createNVPair('PerBusAssociations_Flag', LEFT.PerBusAssociations_Flag),
                                                                                      DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));
		
        RETURN personFlags;
    END;
		
		
    EXPORT GetBusinessAttributes(DATASET(DueDiligence.Layouts.Busn_Internal) results) := FUNCTION
        
      businessAttributes := NORMALIZE(UNGROUP(results), DueDiligence.Constants.NUMBER_OF_BUSINESS_ATTRIBUTES, TRANSFORM(iesp.share.t_NameValuePair,
                                                                  SELF := CASE(COUNTER,
                                                                                1  => DueDiligence.Common.createNVPair('BusAssetOwnProperty', LEFT.BusAssetOwnProperty),
                                                                                2  => DueDiligence.Common.createNVPair('BusAssetOwnAircraft', LEFT.BusAssetOwnAircraft),
                                                                                3  => DueDiligence.Common.createNVPair('BusAssetOwnWatercraft', LEFT.BusAssetOwnWatercraft),
                                                                                4  => DueDiligence.Common.createNVPair('BusAssetOwnVehicle', LEFT.BusAssetOwnVehicle),
                                                                                5  => DueDiligence.Common.createNVPair('BusAccessToFundSales', LEFT.BusAccessToFundSales),
                                                                                6  => DueDiligence.Common.createNVPair('BusAccessToFundsProperty', LEFT.BusAccessToFundsProperty),
                                                                                7  => DueDiligence.Common.createNVPair('BusGeographic', LEFT.BusGeographic),
                                                                                8  => DueDiligence.Common.createNVPair('BusValidity', LEFT.BusValidity),
                                                                                9  => DueDiligence.Common.createNVPair('BusStability', LEFT.BusStability),
                                                                                10 => DueDiligence.Common.createNVPair('BusIndustry', LEFT.BusIndustry),
                                                                                11 => DueDiligence.Common.createNVPair('BusStructureType', LEFT.BusStructureType),
                                                                                12 => DueDiligence.Common.createNVPair('BusSOSAgeRange', LEFT.BusSOSAgeRange),
                                                                                13 => DueDiligence.Common.createNVPair('BusPublicRecordAgeRange', LEFT.BusPublicRecordAgeRange),
                                                                                14 => DueDiligence.Common.createNVPair('BusShellShelf', LEFT.BusShellShelf),
                                                                                15 => DueDiligence.Common.createNVPair('BusMatchLevel', LEFT.BusMatchLevel),
                                                                                16 => DueDiligence.Common.createNVPair('BusStateLegalEvent', LEFT.BusStateLegalEvent),
                                                                                17 => DueDiligence.Common.createNVPair('BusFederalLegalEvent', LEFT.BusFederalLegalEvent),
                                                                                18 => DueDiligence.Common.createNVPair('BusFederalLegalMatchLevel', LEFT.BusFederalLegalMatchLevel),
                                                                                19 => DueDiligence.Common.createNVPair('BusCivilLegalEvent', LEFT.BusCivilLegalEvent),
                                                                                20 => DueDiligence.Common.createNVPair('BusOffenseType', LEFT.BusOffenseType),
                                                                                21 => DueDiligence.Common.createNVPair('BusBEOProfLicense', LEFT.BusBEOProfLicense),
                                                                                22 => DueDiligence.Common.createNVPair('BusBEOUSResidency', LEFT.BusBEOUSResidency),
                                                                                23 => DueDiligence.Common.createNVPair('BusBEOAccessToFundsProperty', LEFT.BusBEOAccessToFundsProperty),
                                                                                24 => DueDiligence.Common.createNVPair('BusLinkedBusinesses', LEFT.BusLinkedBusinesses),
                                                                                      DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));
																																																							
				
        RETURN businessAttributes;
    END;
		
		
    EXPORT GetBusinessAttributeFlags(DATASET(DueDiligence.Layouts.Busn_Internal) results) := FUNCTION
			
        businessFlags := NORMALIZE(UNGROUP(results), DueDiligence.Constants.NUMBER_OF_BUSINESS_ATTRIBUTES, TRANSFORM(iesp.share.t_NameValuePair,
                                                                  SELF := CASE(COUNTER,
                                                                                1  => DueDiligence.Common.createNVPair('BusAssetOwnProperty_Flag', LEFT.BusAssetOwnProperty_Flag),
                                                                                2  => DueDiligence.Common.createNVPair('BusAssetOwnAircraft_Flag', LEFT.BusAssetOwnAircraft_Flag),
                                                                                3  => DueDiligence.Common.createNVPair('BusAssetOwnWatercraft_Flag', LEFT.BusAssetOwnWatercraft_Flag),
                                                                                4  => DueDiligence.Common.createNVPair('BusAssetOwnVehicle_Flag', LEFT.BusAssetOwnVehicle_Flag),
                                                                                5  => DueDiligence.Common.createNVPair('BusAccessToFundsSales_Flag', LEFT.BusAccessToFundsSales_Flag),
                                                                                6  => DueDiligence.Common.createNVPair('BusAccessToFundsProperty_Flag', LEFT.BusAccessToFundsProperty_Flag),
                                                                                7  => DueDiligence.Common.createNVPair('BusGeographic_Flag', LEFT.BusGeographic_Flag),
                                                                                8  => DueDiligence.Common.createNVPair('BusValidity_Flag', LEFT.BusValidity_Flag),
                                                                                9  => DueDiligence.Common.createNVPair('BusStability_Flag', LEFT.BusStability_Flag),
                                                                                10 => DueDiligence.Common.createNVPair('BusIndustry_Flag', LEFT.BusIndustry_Flag),
                                                                                11 => DueDiligence.Common.createNVPair('BusStructureType_Flag', LEFT.BusStructureType_Flag),
                                                                                12 => DueDiligence.Common.createNVPair('BusSOSAgeRange_Flag', LEFT.BusSOSAgeRange_Flag),
                                                                                13 => DueDiligence.Common.createNVPair('BusPublicRecordAgeRange_Flag', LEFT.BusPublicRecordAgeRange_Flag),
                                                                                14 => DueDiligence.Common.createNVPair('BusShellShelf_Flag', LEFT.BusShellShelf_Flag),
                                                                                15 => DueDiligence.Common.createNVPair('BusMatchLevel_Flag', LEFT.BusMatchLevel_Flag),
                                                                                16 => DueDiligence.Common.createNVPair('BusStateLegalEvent_Flag', LEFT.BusStateLegalEvent_Flag),
                                                                                17 => DueDiligence.Common.createNVPair('BusFederalLegalEvent_Flag', LEFT.BusFederalLegalEvent_Flag),
                                                                                18 => DueDiligence.Common.createNVPair('BusFederalLegalMatchLevel_Flag', LEFT.BusFederalLegalMatchLevel_Flag),
                                                                                19 => DueDiligence.Common.createNVPair('BusCivilLegalEvent_Flag', LEFT.BusCivilLegalEvent_Flag),
                                                                                20 => DueDiligence.Common.createNVPair('BusOffenseType_Flag', LEFT.BusOffenseType_Flag),
                                                                                21 => DueDiligence.Common.createNVPair('BusBEOProfLicense_Flag', LEFT.BusBEOProfLicense_Flag),
                                                                                22 => DueDiligence.Common.createNVPair('BusBEOUSResidency_Flag', LEFT.BusBEOUSResidency_Flag),
                                                                                23 => DueDiligence.Common.createNVPair('BusBEOAccessToFundsProperty_Flag', LEFT.BusBEOAccessToFundsProperty_Flag),
                                                                                24 => DueDiligence.Common.createNVPair('BusLinkedBusinesses_Flag', LEFT.BusLinkedBusinesses_Flag),
                                                                                      DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));
												
        RETURN businessFlags;
    END;


    EXPORT mac_GetESPReturnData(inputWithSeq, results, iespLayout, indvOrBus, includeReport, attrs, attrsFlags, reqVersion, customerPassThruInput) := FUNCTIONMACRO
			
        returnData := JOIN(inputWithSeq, results, 
                            LEFT.seq = RIGHT.seq,
                            TRANSFORM(iespLayout,
                                      SELF.result.inputecho := LEFT.reportBy;	
                                      SELF.result.AttributeGroup.attributes :=  attrs;
                                      SELF.result.AttributeGroup.AttributeLevelHits := attrsFlags;
                                      SELF.result.AttributeGroup.Name := reqVersion;
                                      SELF.result.AdditionalInput := customerPassThruInput;

                                      #EXPAND(IF(indvOrBus = DueDiligence.Constants.BUSINESS,
                                                              'SELF.result.businessID := (STRING)RIGHT.busn_info.BIP_IDs.SeleID.LinkID;',
                                                              DueDiligence.Constants.EMPTY))
                                      #EXPAND(IF(indvOrBus = DueDiligence.Constants.BUSINESS,
                                                              'SELF.result.BusinessLexIDMatch := RIGHT.score;',
                                                              DueDiligence.Constants.EMPTY))
                                      #EXPAND(IF(indvOrBus = DueDiligence.Constants.BUSINESS AND includeReport = DueDiligence.Constants.STRING_TRUE,
                                                              'SELF.result.BusinessReport := RIGHT.BusinessReport;',
                                                              DueDiligence.Constants.EMPTY))

                                      #EXPAND(IF(indvOrBus = DueDiligence.Constants.INDIVIDUAL,
                                                              'SELF.result.uniqueID := (STRING)RIGHT.individual.did;',
                                                              DueDiligence.Constants.EMPTY))	
                                      #EXPAND(IF(indvOrBus = DueDiligence.Constants.INDIVIDUAL,
                                                              'SELF.result.PersonLexIDMatch := RIGHT.individual.score;',
                                                              DueDiligence.Constants.EMPTY))	
                                      #EXPAND(IF(indvOrBus = DueDiligence.Constants.INDIVIDUAL AND includeReport = DueDiligence.Constants.STRING_TRUE,
                                                              'SELF.result.PersonReport := RIGHT.personReport;',
                                                              DueDiligence.Constants.EMPTY))
                                                                 
                                      SELF := LEFT;
                                      SELF := [];));																																		
				
        RETURN returnData;
    ENDMACRO;
END;
IMPORT DueDiligence, iesp, STD;


EXPORT CommonQueryXML := MODULE

    EXPORT mac_AddressFromRequest(reportedBy) := FUNCTIONMACRO
        
        LOCAL indBusAddr := reportedBy.address;
        RETURN DATASET([TRANSFORM(DueDiligence.v3Layouts.Internal.Address,
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
                                  SELF.zip := TRIM(indBusAddr.zip5);
                                  SELF.zip4 := TRIM(indBusAddr.zip4);
                                  SELF.county := TRIM(indBusAddr.county);
                                  SELF := [];)]);
    ENDMACRO;
		
    EXPORT mac_PopulateIndividualFromRequest(reportedBy, indvIndicator) := FUNCTIONMACRO
        
        #if(indvIndicator <> DueDiligence.Constants.BUSINESS)
            
            LOCAL personInfo := reportedBy.person;
            LOCAL addressFromReq := DueDiligence.CommonQueryXML.mac_AddressFromRequest(personInfo);
            
            LOCAL ind_in := DATASET([TRANSFORM(DueDiligence.Layouts.IndInput,
                                                SELF.lexID := (UNSIGNED6)TRIM(personInfo.lexID);
                                                SELF.name := DATASET([TRANSFORM(DueDiligence.Layouts.Name,
                                                                                SELF.fullName := TRIM(personInfo.name.full);
                                                                                SELF.firstName := TRIM(personInfo.name.first);
                                                                                SELF.middleName := TRIM(personInfo.name.middle);
                                                                                SELF.lastName := TRIM(personInfo.name.last);
                                                                                SELF.suffix := TRIM(personInfo.name.suffix);
                                                                                SELF := [];)])[1];
                                                SELF.address := addressFromReq[1];
                                                SELF.phone := TRIM(personInfo.phone);
                                                SELF.taxID := TRIM(personInfo.ssn);
                                                SELF.dob := (INTFORMAT(personInfo.dob.Year, 4, 1) + INTFORMAT(personInfo.dob.Month, 2, 1) + INTFORMAT(personInfo.dob.Day, 2, 1));
                                                SELF := [];)]);
        #else
            LOCAL ind_in := DATASET([], DueDiligence.Layouts.IndInput);
        #end

        RETURN ind_in;
    ENDMACRO;
		
    EXPORT mac_PopulateBusinessFromRequest(reportedBy, busIndicator) := FUNCTIONMACRO
        
        #if(busIndicator <> DueDiligence.Constants.INDIVIDUAL)
            
            LOCAL businessInfo := reportedBy.business;
            LOCAL addressFromReq := DueDiligence.CommonQueryXML.mac_AddressFromRequest(businessInfo);
            
            LOCAL bus_in := DATASET([TRANSFORM(DueDiligence.Layouts.BusInput,
                                                SELF.lexID := (UNSIGNED6)TRIM(businessInfo.lexID);
                                                SELF.companyName := TRIM(businessInfo.companyName);
                                                SELF.altCompanyName := TRIM(businessInfo.alternateCompanyName);
                                                SELF.address := addressFromReq[1];
                                                SELF.taxID := TRIM(businessInfo.fein);
                                                // SELF.phone := TRIM(businessInfo.phone);
                                                SELF := [];)]);
        #else
            LOCAL bus_in := DATASET([], DueDiligence.Layouts.BusInput);
        #end

        RETURN bus_in;
    ENDMACRO;
    
    EXPORT innerOuterBandResults(STRING innerValue, STRING outerValue, STRING defaultValue) := FUNCTION
        RETURN MAP(TRIM(innerValue) <> DueDiligence.Constants.EMPTY => innerValue,
                   TRIM(outerValue) <> DueDiligence.Constants.EMPTY => outerValue,
                   defaultValue);
    END;
    
    EXPORT innerOuterBandUnsignedResults(UNSIGNED innerValue, UNSIGNED outerValue, UNSIGNED defaultValue) := FUNCTION
        RETURN MAP(innerValue > DueDiligence.Constants.NUMERIC_ZERO => innerValue,
                   outerValue > DueDiligence.Constants.NUMERIC_ZERO => outerValue,
                   defaultValue);
    END;
		
    EXPORT mac_CreateInputFromXML(requestType, requestStoredName, requestedReport, serviceRequested) := MACRO
				
        //Can't have duplicate definitions of Stored with different default values, 
        //so add the default to #stored to eliminate the assignment of a default value.
        #STORED('DPPAPurpose', Business_Risk_BIP.Constants.Default_DPPA);
        #STORED('GLBPurpose',  Business_Risk_BIP.Constants.Default_GLBA);


        //Get debugging indicator
        debugIndicator := FALSE : STORED('debugMode');
        intermediates := FALSE : STORED('intermediateVariables');

        //Get XML input 
        requestIn := DATASET([], requestType) : STORED(requestStoredName, FEW);

        firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime AND not batch, should only have one row on input.

        optionsIn := GLOBAL(firstRow.options);
        userIn := GLOBAL(firstRow.user);  
        reportByIn := GLOBAL(firstRow.reportBy);

        //Fields for test seeds
        BOOLEAN executeTestSeeds := userIn.testDataEnabled;
        STRING testSeedTableName := userIn.testDataTableName;
        
        //CCPA fields
        UNSIGNED1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
        STRING TransactionID := '' : STORED('_TransactionId');
        STRING BatchUID := '' : STORED('_BatchUID');
        UNSIGNED6 GlobalCompanyId := 0 : STORED('_GCID');

        //get outer band data - to use if customer data is not populated
        UNSIGNED1 outerBandDPPAPurpose := Business_Risk_BIP.Constants.Default_DPPA : STORED('DPPAPurpose');
        UNSIGNED1 outerBandGLBPurpose := Business_Risk_BIP.Constants.Default_GLBA : STORED('GLBPurpose');
        outerBandHistoryDate := DueDiligence.Constants.NUMERIC_ZERO : STORED('HistoryDateYYYYMMDD');
        STRING6 outerBandSSNMASK := Business_Risk_BIP.Constants.Default_SSNMask : STORED('SSNMask');  
        STRING outerBandDRM := AutoStandardI.GlobalModule().DataRestrictionMask;
        STRING outerBandDPM := AutoStandardI.GlobalModule().DataPermissionMask;

        
        //The general rule for picking these options is to look in the inner band (ie the User section) first
        //If the inner band fields are not populated look in the outer band or the Default from the Global Module         
        dppa := DueDiligence.CommonQueryXML.innerOuterBandUnsignedResults((UNSIGNED1)userIn.DLPurpose, outerBandDPPAPurpose, Business_Risk_BIP.Constants.Default_DPPA);
        glba := DueDiligence.CommonQueryXML.innerOuterBandUnsignedResults((UNSIGNED1)userIn.GLBPurpose, outerBandGLBPurpose, Business_Risk_BIP.Constants.Default_GLBA);
        drm	:= DueDiligence.CommonQueryXML.innerOuterBandResults(userIn.DataRestrictionMask, outerBandDRM, AutoStandardI.Constants.DataRestrictionMask_default); 
        dpm := DueDiligence.CommonQueryXML.innerOuterBandResults(userIn.DataPermissionMask, outerBandDPM, AutoStandardI.Constants.DataPermissionMask_default);
        STRING6 DDssnMask := DueDiligence.CommonQueryXML.innerOuterBandResults(userIn.SSNMask, outerBandSSNMASK, DueDiligence.Constants.EMPTY); //*** EXPECTING ALL/LAST4/FIRST5 from MBS   

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


        requestedAttributes := PROJECT(reportByIn.attributeModules, TRANSFORM({STRING15 attributeModules},
                                                                              SELF.attributeModules := LEFT.name;
                                                                              SELF := [];));

        
        wseq := PROJECT(requestIn, TRANSFORM({INTEGER4 seq, RECORDOF(requestIn)}, SELF.seq := COUNTER, SELF := LEFT));

        input := PROJECT(wseq, TRANSFORM(DueDiligence.Layouts.Input,

                                          version := requestedVersion;
                                          reportBy := LEFT.reportBy;
                                          
                                          populatedInd := DueDiligence.CommonQueryXML.mac_PopulateIndividualFromRequest(reportBy, serviceRequested);
                                          populatedBus := DueDiligence.CommonQueryXML.mac_PopulateBusinessFromRequest(reportBy, serviceRequested);
                                          
                                          
                                          useHistDate := (UNSIGNED4)(INTFORMAT(LEFT.options.HistoryDate.Year, 4, 1) + INTFORMAT(LEFT.options.HistoryDate.Month, 2, 1) + INTFORMAT(LEFT.options.HistoryDate.Day, 2, 1));
                                          histDate := IF(useHistDate > 0, useHistDate, (UNSIGNED4)outerBandHistoryDate);
                                                                          
                                          SELF.seq := LEFT.seq;
                                          SELF.accountNumber := userIn.accountNumber;
                                          SELF.requestedVersion := version;
                                          SELF.requestedModules := requestedAttributes;
                                          
                                          
                                          SELF.rawBusiness := populatedBus[1];
                                          SELF.rawPerson := populatedInd[1];
                                          SELF.historyDateYYYYMMDD := histDate;
                                          
                                          //only default if we are in the context of a report request and ProductRequestType is empty
                                          SELF.productRequested := MAP(reportByIn.ProductRequestType = '' AND serviceRequested != DueDiligence.Constants.ATTRIBUTES => DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_ONLY, 
                                                                       STD.Str.ToLowerCase(reportByIn.ProductRequestType) = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_REPORT_DEFAULT AND serviceRequested != DueDiligence.Constants.ATTRIBUTES => DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_ONLY, 
                                                                       STD.Str.ToLowerCase(reportByIn.ProductRequestType));
                                          
                                          
                                          //Citizenship fields
                                          #IF(serviceRequested = DueDiligence.Constants.ATTRIBUTES)
                                            SELF.modelName := reportBy.person.citizenship.citizenshipModelName;
                                            SELF.phone2 := reportBy.person.citizenship.phone2;
                                            SELF.dlNumber := reportBy.person.citizenship.dlNumber;
                                            SELF.dlState := reportBy.person.citizenship.dlState;
                                            SELF.email := reportBy.person.citizenship.email;
                                          #END
                                          
                                          SELF := [];));                                                                           
    ENDMACRO;
    
    SHARED mac_GetAttrModsWithResults(results, cleanData) := FUNCTIONMACRO
        
        LOCAL attrsWithMods := JOIN(results, cleanData,
                                    LEFT.seq = RIGHT.seq,
                                    TRANSFORM({RECORDOF(results), BOOLEAN includeAll, BOOLEAN useMods, SET OF STRING15 requestedMods},
                                              SELF.requestedMods := SET(RIGHT.requestedModules, STD.Str.ToUpperCase(TRIM(attributeModules)));
                                              SELF.includeAll := STD.Str.ToLowerCase(TRIM(RIGHT.productRequested)) IN [DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_ONLY, DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_AND_CITIZENSHIP];
                                              SELF.useMods := STD.Str.ToLowerCase(TRIM(RIGHT.productRequested)) = DueDiligence.ConstantsQuery.VALID_PRODUCT_DUE_DILIGENCE_MODULES AND COUNT(RIGHT.requestedModules) > 0;
                                              SELF := LEFT;),
                                    LEFT OUTER,
                                    ATMOST(1));
                                
        RETURN UNGROUP(attrsWithMods);
    ENDMACRO;
    
    EXPORT GetIndividualV3Attributes(DATASET(DueDiligence.v3Layouts.DDOutput.PersonResults) results, DATASET(DueDiligence.Layouts.Input) cleanData) := FUNCTION
    
        checkWhichAttrs := mac_GetAttrModsWithResults(results, cleanData);
				
        personAttributes := NORMALIZE(checkWhichAttrs, DueDiligence.Constants.NUMBER_OF_INDIVIDUAL_ATTRIBUTES, TRANSFORM(iesp.share.t_NameValuePair,
                                                                  
                                                                  useEconomic := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN LEFT.requestedMods);
                                                                  useGeo := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_GEOGRAPHIC IN LEFT.requestedMods);
                                                                  useLegal := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN LEFT.requestedMods);
                                                                  useIdentity := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_IDENTITY IN LEFT.requestedMods);
                                                                  useNetwork := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_NETWORK IN LEFT.requestedMods);
                                                                  
                                                                  SELF := CASE(COUNTER,
                                                                                1  => IF(useEconomic, DueDiligence.Common.createNVPair('PerAssetOwnProperty', LEFT.PerAssetOwnProperty)),
                                                                                2  => IF(useEconomic, DueDiligence.Common.createNVPair('PerAssetOwnAircraft', LEFT.PerAssetOwnAircraft)),
                                                                                3  => IF(useEconomic, DueDiligence.Common.createNVPair('PerAssetOwnWatercraft', LEFT.PerAssetOwnWatercraft)),
                                                                                4  => IF(useEconomic, DueDiligence.Common.createNVPair('PerAssetOwnVehicle', LEFT.PerAssetOwnVehicle)),
                                                                                5  => IF(useEconomic, DueDiligence.Common.createNVPair('PerAccessToFundsIncome', LEFT.PerAccessToFundsIncome)),
                                                                                6  => IF(useEconomic, DueDiligence.Common.createNVPair('PerAccessToFundsProperty', LEFT.PerAccessToFundsProperty)),
                                                                                7  => IF(useGeo, DueDiligence.Common.createNVPair('PerGeographic', LEFT.PerGeographic)),
                                                                                8  => IF(useGeo, DueDiligence.Common.createNVPair('PerMobility', LEFT.PerMobility)),
                                                                                9  => IF(useLegal, DueDiligence.Common.createNVPair('PerStateLegalEvent', LEFT.PerStateLegalEvent)),
                                                                                10 => IF(useLegal, DueDiligence.Common.createNVPair('PerFederalLegalEvent', LEFT.PerFederalLegalEvent)),
                                                                                11 => IF(useLegal, DueDiligence.Common.createNVPair('PerFederalLegalMatchLevel', LEFT.PerFederalLegalMatchLevel)),
                                                                                12 => IF(useLegal, DueDiligence.Common.createNVPair('PerCivilLegalEvent', LEFT.PerCivilLegalEvent)),
                                                                                13 => IF(useLegal, DueDiligence.Common.createNVPair('PerCivilLegalEventFilingAmt', LEFT.PerCivilLegalEventFilingAmt)),
                                                                                14 => IF(useLegal, DueDiligence.Common.createNVPair('PerOffenseType', LEFT.PerOffenseType)),
                                                                                15 => IF(useIdentity, DueDiligence.Common.createNVPair('PerAgeRange', LEFT.PerAgeRange)),
                                                                                16 => IF(useIdentity, DueDiligence.Common.createNVPair('PerIdentityRisk', LEFT.PerIdentityRisk)),
                                                                                17 => IF(useIdentity, DueDiligence.Common.createNVPair('PerUSResidency', LEFT.PerUSResidency)),
                                                                                18 => DueDiligence.Common.createNVPair('PerMatchLevel', LEFT.PerMatchLevel),
                                                                                19 => IF(useNetwork, DueDiligence.Common.createNVPair('PerAssociates', LEFT.PerAssociates)),
                                                                                20 => IF(useNetwork, DueDiligence.Common.createNVPair('PerEmploymentIndustry', LEFT.PerEmploymentIndustry)),
                                                                                21 => IF(useNetwork, DueDiligence.Common.createNVPair('PerProfLicense', LEFT.PerProfLicense)),
                                                                                22 => IF(useNetwork, DueDiligence.Common.createNVPair('PerBusAssociations', LEFT.PerBusAssociations)),
                                                                                      DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));

	
	
        RETURN personAttributes(value <> DueDiligence.Constants.EMPTY);
    END;
		
		
    EXPORT GetIndividualV3AttributeFlags(DATASET(DueDiligence.v3Layouts.DDOutput.PersonResults) results, DATASET(DueDiligence.Layouts.Input) cleanData) := FUNCTION
		
        checkWhichAttrs := mac_GetAttrModsWithResults(results, cleanData);
        
        personFlags := NORMALIZE(checkWhichAttrs, DueDiligence.Constants.NUMBER_OF_INDIVIDUAL_ATTRIBUTES, TRANSFORM(iesp.share.t_NameValuePair,
                                                                  
                                                                  useEconomic := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN LEFT.requestedMods);
                                                                  useGeo := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_GEOGRAPHIC IN LEFT.requestedMods);
                                                                  useLegal := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN LEFT.requestedMods);
                                                                  useIdentity := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_IDENTITY IN LEFT.requestedMods);
                                                                  useNetwork := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_NETWORK IN LEFT.requestedMods);
                                                                  
                                                                  SELF := CASE(COUNTER,
                                                                                1  => IF(useEconomic, DueDiligence.Common.createNVPair('PerAssetOwnProperty_Flag', LEFT.PerAssetOwnProperty_Flag)),
                                                                                2  => IF(useEconomic, DueDiligence.Common.createNVPair('PerAssetOwnAircraft_Flag', LEFT.PerAssetOwnAircraft_Flag)),
                                                                                3  => IF(useEconomic, DueDiligence.Common.createNVPair('PerAssetOwnWatercraft_Flag', LEFT.PerAssetOwnWatercraft_Flag)),
                                                                                4  => IF(useEconomic, DueDiligence.Common.createNVPair('PerAssetOwnVehicle_Flag', LEFT.PerAssetOwnVehicle_Flag)),
                                                                                5  => IF(useEconomic, DueDiligence.Common.createNVPair('PerAccessToFundsIncome_Flag', LEFT.PerAccessToFundsIncome_Flag)),
                                                                                6  => IF(useEconomic, DueDiligence.Common.createNVPair('PerAccessToFundsProperty_Flag', LEFT.PerAccessToFundsProperty_Flag)),
                                                                                7  => IF(useGeo, DueDiligence.Common.createNVPair('PerGeographic_Flag', LEFT.PerGeographic_Flag)),
                                                                                8  => IF(useGeo, DueDiligence.Common.createNVPair('PerMobility_Flag', LEFT.PerMobility_Flag)),
                                                                                9  => IF(useLegal, DueDiligence.Common.createNVPair('PerStateLegalEvent_Flag', LEFT.PerStateLegalEvent_Flag)),
                                                                                10 => IF(useLegal, DueDiligence.Common.createNVPair('PerFederalLegalEvent_Flag', LEFT.PerFederalLegalEvent_Flag)),
                                                                                11 => IF(useLegal, DueDiligence.Common.createNVPair('PerFederalLegalMatchLevel_Flag', LEFT.PerFederalLegalMatchLevel_Flag)),
                                                                                12 => IF(useLegal, DueDiligence.Common.createNVPair('PerCivilLegalEvent_Flag', LEFT.PerCivilLegalEvent_Flag)),
                                                                                13 => IF(useLegal, DueDiligence.Common.createNVPair('PerCivilLegalEventFilingAmt_Flag', LEFT.PerCivilLegalEventFilingAmt_Flag)),
                                                                                14 => IF(useLegal, DueDiligence.Common.createNVPair('PerOffenseType_Flag', LEFT.PerOffenseType_Flag)),
                                                                                15 => IF(useIdentity, DueDiligence.Common.createNVPair('PerAgeRange_Flag', LEFT.PerAgeRange_Flag)),
                                                                                16 => IF(useIdentity, DueDiligence.Common.createNVPair('PerIdentityRisk_Flag', LEFT.PerIdentityRisk_Flag)),
                                                                                17 => IF(useIdentity, DueDiligence.Common.createNVPair('PerUSResidency_Flag', LEFT.PerUSResidency_Flag)),
                                                                                18 => DueDiligence.Common.createNVPair('PerMatchLevel_Flag', LEFT.PerMatchLevel_Flag),
                                                                                19 => IF(useNetwork, DueDiligence.Common.createNVPair('PerAssociates_Flag', LEFT.PerAssociates_Flag)),
                                                                                20 => IF(useNetwork, DueDiligence.Common.createNVPair('PerEmploymentIndustry_Flag', LEFT.PerEmploymentIndustry_Flag)),
                                                                                21 => IF(useNetwork, DueDiligence.Common.createNVPair('PerProfLicense_Flag', LEFT.PerProfLicense_Flag)),
                                                                                22 => IF(useNetwork, DueDiligence.Common.createNVPair('PerBusAssociations_Flag', LEFT.PerBusAssociations_Flag)),
                                                                                      DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));
		
        RETURN personFlags(value <> DueDiligence.Constants.EMPTY);
    END;
		
		
    EXPORT GetBusinessV3Attributes(DATASET(DueDiligence.v3Layouts.DDOutput.BusinessResults) results, DATASET(DueDiligence.Layouts.Input) cleanData) := FUNCTION
        
      checkWhichAttrs := mac_GetAttrModsWithResults(results, cleanData);
      
      businessAttributes := NORMALIZE(checkWhichAttrs, DueDiligence.Constants.NUMBER_OF_BUSINESS_ATTRIBUTES, TRANSFORM(iesp.share.t_NameValuePair,
                                                                  
                                                                  useEconomic := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN LEFT.requestedMods);
                                                                  useOperating := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_OPERATING IN LEFT.requestedMods);
                                                                  useLegal := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN LEFT.requestedMods);
                                                                  useNetwork := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_NETWORK IN LEFT.requestedMods);
                                                                  
                                                                  SELF := CASE(COUNTER,
                                                                                1  => IF(useEconomic, DueDiligence.Common.createNVPair('BusAssetOwnProperty', LEFT.BusAssetOwnProperty)),
                                                                                2  => IF(useEconomic, DueDiligence.Common.createNVPair('BusAssetOwnAircraft', LEFT.BusAssetOwnAircraft)),
                                                                                3  => IF(useEconomic, DueDiligence.Common.createNVPair('BusAssetOwnWatercraft', LEFT.BusAssetOwnWatercraft)),
                                                                                4  => IF(useEconomic, DueDiligence.Common.createNVPair('BusAssetOwnVehicle', LEFT.BusAssetOwnVehicle)),
                                                                                5  => IF(useEconomic, DueDiligence.Common.createNVPair('BusAccessToFundSales', LEFT.BusAccessToFundSales)),
                                                                                6  => IF(useEconomic, DueDiligence.Common.createNVPair('BusAccessToFundsProperty', LEFT.BusAccessToFundsProperty)),
                                                                                7  => IF(useOperating, DueDiligence.Common.createNVPair('BusGeographic', LEFT.BusGeographic)),
                                                                                8  => IF(useOperating, DueDiligence.Common.createNVPair('BusValidity', LEFT.BusValidity)),
                                                                                9  => IF(useOperating, DueDiligence.Common.createNVPair('BusStability', LEFT.BusStability)),
                                                                                10 => IF(useOperating, DueDiligence.Common.createNVPair('BusIndustry', LEFT.BusIndustry)),
                                                                                11 => IF(useOperating, DueDiligence.Common.createNVPair('BusStructureType', LEFT.BusStructureType)),
                                                                                12 => IF(useOperating, DueDiligence.Common.createNVPair('BusSOSAgeRange', LEFT.BusSOSAgeRange)),
                                                                                13 => IF(useOperating, DueDiligence.Common.createNVPair('BusPublicRecordAgeRange', LEFT.BusPublicRecordAgeRange)),
                                                                                14 => IF(useOperating, DueDiligence.Common.createNVPair('BusShellShelf', LEFT.BusShellShelf)),
                                                                                15 => DueDiligence.Common.createNVPair('BusMatchLevel', LEFT.BusMatchLevel),
                                                                                16 => IF(useLegal, DueDiligence.Common.createNVPair('BusStateLegalEvent', LEFT.BusStateLegalEvent)),
                                                                                17 => IF(useLegal, DueDiligence.Common.createNVPair('BusFederalLegalEvent', LEFT.BusFederalLegalEvent)),
                                                                                18 => IF(useLegal, DueDiligence.Common.createNVPair('BusFederalLegalMatchLevel', LEFT.BusFederalLegalMatchLevel)),
                                                                                19 => IF(useLegal, DueDiligence.Common.createNVPair('BusCivilLegalEvent', LEFT.BusCivilLegalEvent)),
                                                                                20 => IF(useLegal, DueDiligence.Common.createNVPair('BusCivilLegalEventFilingAmt', LEFT.BusCivilLegalEventFilingAmt)),
                                                                                21 => IF(useLegal, DueDiligence.Common.createNVPair('BusOffenseType', LEFT.BusOffenseType)),
                                                                                22 => IF(useNetwork, DueDiligence.Common.createNVPair('BusBEOProfLicense', LEFT.BusBEOProfLicense)),
                                                                                23 => IF(useNetwork, DueDiligence.Common.createNVPair('BusBEOUSResidency', LEFT.BusBEOUSResidency)),
                                                                                24 => IF(useNetwork, DueDiligence.Common.createNVPair('BusBEOAccessToFundsProperty', LEFT.BusBEOAccessToFundsProperty)),
                                                                                25 => IF(useNetwork, DueDiligence.Common.createNVPair('BusLinkedBusinesses', LEFT.BusLinkedBusinesses)),
                                                                                      DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));
																																																							
				
        RETURN businessAttributes(value <> DueDiligence.Constants.EMPTY);
    END;
		
		
    EXPORT GetBusinessV3AttributeFlags(DATASET(DueDiligence.v3Layouts.DDOutput.BusinessResults) results, DATASET(DueDiligence.Layouts.Input) cleanData) := FUNCTION
			
        checkWhichAttrs := mac_GetAttrModsWithResults(results, cleanData);
        
        businessFlags := NORMALIZE(checkWhichAttrs, DueDiligence.Constants.NUMBER_OF_BUSINESS_ATTRIBUTES, TRANSFORM(iesp.share.t_NameValuePair,
                                                                  
                                                                  useEconomic := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_ECONOMIC IN LEFT.requestedMods);
                                                                  useOperating := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_OPERATING IN LEFT.requestedMods);
                                                                  useLegal := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_LEGAL IN LEFT.requestedMods);
                                                                  useNetwork := LEFT.includeAll OR (LEFT.useMods AND DueDiligence.ConstantsQuery.MODULE_NETWORK IN LEFT.requestedMods);
                                                                  
                                                                  SELF := CASE(COUNTER,
                                                                                1  => IF(useEconomic, DueDiligence.Common.createNVPair('BusAssetOwnProperty_Flag', LEFT.BusAssetOwnProperty_Flag)),
                                                                                2  => IF(useEconomic, DueDiligence.Common.createNVPair('BusAssetOwnAircraft_Flag', LEFT.BusAssetOwnAircraft_Flag)),
                                                                                3  => IF(useEconomic, DueDiligence.Common.createNVPair('BusAssetOwnWatercraft_Flag', LEFT.BusAssetOwnWatercraft_Flag)),
                                                                                4  => IF(useEconomic, DueDiligence.Common.createNVPair('BusAssetOwnVehicle_Flag', LEFT.BusAssetOwnVehicle_Flag)),
                                                                                5  => IF(useEconomic, DueDiligence.Common.createNVPair('BusAccessToFundsSales_Flag', LEFT.BusAccessToFundsSales_Flag)),
                                                                                6  => IF(useEconomic, DueDiligence.Common.createNVPair('BusAccessToFundsProperty_Flag', LEFT.BusAccessToFundsProperty_Flag)),
                                                                                7  => IF(useOperating, DueDiligence.Common.createNVPair('BusGeographic_Flag', LEFT.BusGeographic_Flag)),
                                                                                8  => IF(useOperating, DueDiligence.Common.createNVPair('BusValidity_Flag', LEFT.BusValidity_Flag)),
                                                                                9  => IF(useOperating, DueDiligence.Common.createNVPair('BusStability_Flag', LEFT.BusStability_Flag)),
                                                                                10 => IF(useOperating, DueDiligence.Common.createNVPair('BusIndustry_Flag', LEFT.BusIndustry_Flag)),
                                                                                11 => IF(useOperating, DueDiligence.Common.createNVPair('BusStructureType_Flag', LEFT.BusStructureType_Flag)),
                                                                                12 => IF(useOperating, DueDiligence.Common.createNVPair('BusSOSAgeRange_Flag', LEFT.BusSOSAgeRange_Flag)),
                                                                                13 => IF(useOperating, DueDiligence.Common.createNVPair('BusPublicRecordAgeRange_Flag', LEFT.BusPublicRecordAgeRange_Flag)),
                                                                                14 => IF(useOperating, DueDiligence.Common.createNVPair('BusShellShelf_Flag', LEFT.BusShellShelf_Flag)),
                                                                                15 => DueDiligence.Common.createNVPair('BusMatchLevel_Flag', LEFT.BusMatchLevel_Flag),
                                                                                16 => IF(useLegal, DueDiligence.Common.createNVPair('BusStateLegalEvent_Flag', LEFT.BusStateLegalEvent_Flag)),
                                                                                17 => IF(useLegal, DueDiligence.Common.createNVPair('BusFederalLegalEvent_Flag', LEFT.BusFederalLegalEvent_Flag)),
                                                                                18 => IF(useLegal, DueDiligence.Common.createNVPair('BusFederalLegalMatchLevel_Flag', LEFT.BusFederalLegalMatchLevel_Flag)),
                                                                                19 => IF(useLegal, DueDiligence.Common.createNVPair('BusCivilLegalEvent_Flag', LEFT.BusCivilLegalEvent_Flag)),
                                                                                20 => IF(useLegal, DueDiligence.Common.createNVPair('BusCivilLegalEventFilingAmt_Flag', LEFT.BusCivilLegalEventFilingAmt_Flag)),
                                                                                21 => IF(useLegal, DueDiligence.Common.createNVPair('BusOffenseType_Flag', LEFT.BusOffenseType_Flag)),
                                                                                22 => IF(useNetwork, DueDiligence.Common.createNVPair('BusBEOProfLicense_Flag', LEFT.BusBEOProfLicense_Flag)),
                                                                                23 => IF(useNetwork, DueDiligence.Common.createNVPair('BusBEOUSResidency_Flag', LEFT.BusBEOUSResidency_Flag)),
                                                                                24 => IF(useNetwork, DueDiligence.Common.createNVPair('BusBEOAccessToFundsProperty_Flag', LEFT.BusBEOAccessToFundsProperty_Flag)),
                                                                                25 => IF(useNetwork, DueDiligence.Common.createNVPair('BusLinkedBusinesses_Flag', LEFT.BusLinkedBusinesses_Flag)),
                                                                                      DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));
												
        RETURN businessFlags(value <> DueDiligence.Constants.EMPTY);
    END;
    
    EXPORT GetCitizenshipScoreIndicators(DATASET(DueDiligence.v3Layouts.DDOutput.PersonResults) results) := FUNCTION
    
        citizenshipIndicators := NORMALIZE(UNGROUP(results), DueDiligence.Citizenship.Constants.NUMBER_OF_INDICATORS, TRANSFORM(iesp.share.t_NameValuePair,
                                                                  SELF := CASE(COUNTER,
                                                                                1  => DueDiligence.Common.createNVPairIntegerValue('LexID', LEFT.lexID),
                                                                                2  => DueDiligence.Common.createNVPairIntegerValue('LexIDScore', LEFT.lexIDScore),
                                                                                3  => DueDiligence.Common.createNVPairIntegerValue('IdentityAge', LEFT.identityAge),
                                                                                4  => DueDiligence.Common.createNVPairIntegerValue('EmergenceAgeHeader', LEFT.emergenceAgeHeader),
                                                                                5  => DueDiligence.Common.createNVPairIntegerValue('EmergenceAgeBureau', LEFT.emergenceAgeBureau),
                                                                                6  => DueDiligence.Common.createNVPairIntegerValue('SSNIssuanceAge', LEFT.ssnIssuanceAge),
                                                                                7  => DueDiligence.Common.createNVPairIntegerValue('SSNIssuanceYears', LEFT.ssnIssuanceYears),
                                                                                8  => DueDiligence.Common.createNVPairIntegerValue('RelativeCount', LEFT.relativeCount),
                                                                                9  => DueDiligence.Common.createNVPairIntegerValue('Ver_voterRecords', LEFT.ver_voterRecords),
                                                                                10 => DueDiligence.Common.createNVPairIntegerValue('Ver_insuranceRecords', LEFT.ver_insuranceRecords),
                                                                                11 => DueDiligence.Common.createNVPairIntegerValue('Ver_studentFile', LEFT.ver_studentFile),
                                                                                12 => DueDiligence.Common.createNVPairIntegerValue('FirstSeenAddr10', LEFT.firstSeenAddr10),
                                                                                13 => DueDiligence.Common.createNVPairIntegerValue('ReportedCurAddressYears', LEFT.reportedCurAddressYears),
                                                                                14 => DueDiligence.Common.createNVPairIntegerValue('AddressFirstReportedAge', LEFT.addressFirstReportedAge),
                                                                                15 => DueDiligence.Common.createNVPairIntegerValue('TimeSinceLastReportedNonBureau', LEFT.timeSinceLastReportedNonBureau),
                                                                                16 => DueDiligence.Common.createNVPairIntegerValue('InputSSNRandomlyIssued', LEFT.inputSSNRandomlyIssued),
                                                                                17 => DueDiligence.Common.createNVPairIntegerValue('InputSSNRandomIssuedInvalid', LEFT.inputSSNRandomIssuedInvalid),
                                                                                18 => DueDiligence.Common.createNVPairIntegerValue('InputSSNIssuedToNonUS', LEFT.inputSSNIssuedToNonUS),
                                                                                19 => DueDiligence.Common.createNVPairIntegerValue('InputSSNITIN', LEFT.inputSSNITIN),
                                                                                20 => DueDiligence.Common.createNVPairIntegerValue('InputSSNInvalid', LEFT.inputSSNInvalid),
                                                                                21 => DueDiligence.Common.createNVPairIntegerValue('InputSSNIssuedPriorDOB', LEFT.inputSSNIssuedPriorDOB),
                                                                                22 => DueDiligence.Common.createNVPairIntegerValue('InputSSNAssociatedMultLexIDs', LEFT.inputSSNAssociatedMultLexIDs),
                                                                                23 => DueDiligence.Common.createNVPairIntegerValue('InputSSNReportedDeceased', LEFT.inputSSNReportedDeceased),
                                                                                24 => DueDiligence.Common.createNVPairIntegerValue('InputSSNNotPrimaryLexID', LEFT.inputSSNNotPrimaryLexID),
                                                                                25 => DueDiligence.Common.createNVPairIntegerValue('LexIDBestSSNInvalid', LEFT.lexIDBestSSNInvalid),
                                                                                26 => DueDiligence.Common.createNVPairIntegerValue('LexIDReportedDeceased', LEFT.lexIDReportedDeceased),
                                                                                27 => DueDiligence.Common.createNVPairIntegerValue('LexIDMultipleSSNs', LEFT.lexIDMultipleSSNs),
                                                                                28 => DueDiligence.Common.createNVPairIntegerValue('InputComponentDivRisk', LEFT.inputComponentDivRisk),
                                                                                      DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));
        RETURN citizenshipIndicators;
    END;
    
    EXPORT mac_GetESPReturnData(inputWithSeq, cleanInputData, results, iespLayout, indvOrBus, includeReport, attrs, attrsFlags, reqVersion, customerPassThruInput) := FUNCTIONMACRO
        
        LOCAL products := STD.Str.ToLowerCase(cleanInputData[1].productRequested);
        LOCAL reqProduct := DueDiligence.CommonQuery.getProductEnum(products);
      
        LOCAL returnData := JOIN(inputWithSeq, results, 
                                  LEFT.seq = RIGHT.seq,
                                  TRANSFORM(iespLayout,
                                            SELF.result.inputecho := LEFT.reportBy;	
                                            SELF.result.AttributeGroup.attributes := attrs;                                      
                                            SELF.result.AttributeGroup.AttributeLevelHits := attrsFlags;
                                            SELF.result.AttributeGroup.Name := IF(reqProduct IN DueDiligence.ConstantsQuery.DUEDILIGENCE_PRODUCTS, reqVersion, DueDiligence.Constants.EMPTY);
                                            SELF.result.AdditionalInput := customerPassThruInput;

                                            #EXPAND(IF(indvOrBus = DueDiligence.Constants.BUSINESS,
                                                                    'SELF.result.businessID := (STRING)RIGHT.busLexID;' +
                                                                    'SELF.result.BusinessLexIDMatch := (UNSIGNED1)RIGHT.busLexIDMatch;',
                                                                    DueDiligence.Constants.EMPTY))
                                                                    
                                            #EXPAND(IF(indvOrBus = DueDiligence.Constants.BUSINESS AND includeReport = DueDiligence.Constants.STRING_TRUE,
                                                                    'SELF.result := RIGHT.report;',
                                                                    DueDiligence.Constants.EMPTY))
                                                                    

                                            #EXPAND(IF(indvOrBus = DueDiligence.Constants.INDIVIDUAL,
                                                                    'SELF.result.uniqueID := (STRING)RIGHT.perLexID;' +
                                                                    'SELF.result.PersonLexIDMatch := (UNSIGNED1)RIGHT.perLexIDMatch;',
                                                                    DueDiligence.Constants.EMPTY))
                                                                    
                                            #EXPAND(IF(indvOrBus = DueDiligence.Constants.INDIVIDUAL AND includeReport = DueDiligence.Constants.STRING_TRUE,
                                                                    'SELF.result.personReport := RIGHT.personReport;',
                                                                    DueDiligence.Constants.EMPTY))
                                                                    
                                            #EXPAND(IF(indvOrBus = DueDiligence.Constants.INDIVIDUAL AND includeReport = DueDiligence.Constants.STRING_FALSE,
                                                                    'SELF.result.CitizenshipResults.CitizenshipAttributes := IF(RIGHT.citizenshipScore <> DueDiligence.Constants.EMPTY, DueDiligence.CommonQueryXML.GetCitizenshipScoreIndicators(results), DATASET([], iesp.share.t_NameValuePair));' +
                                                                    'SELF.result.CitizenshipResults.CitizenshipScore := IF(RIGHT.citizenshipScore <> DueDiligence.Constants.EMPTY, RIGHT.citizenshipScore, DueDiligence.Constants.EMPTY);',
                                                                    DueDiligence.Constants.EMPTY))                        
                                                                       
                                            SELF := LEFT;
                                            SELF := [];));																																		
				
        RETURN returnData;
    ENDMACRO;
    
    EXPORT mac_v3PersonXML(rawReqWithSeq, cleanData, compliance, ssnMaskVal, additionalInfo, 
                            responseLayout, includeReport, debugIn, intermediatesIn) := FUNCTIONMACRO
        
        LOCAL boolReport := IF(includeReport = DueDiligence.Constants.STRING_TRUE, TRUE, FALSE);
        LOCAL results := DueDiligence.CommonQuery.v3PersonResults(cleanData, compliance, ssnMaskVal, boolReport, debugIn, intermediatesIn);
        
        LOCAL indIndex := DueDiligence.CommonQueryXML.GetIndividualV3Attributes(results, cleanData);
        LOCAL indIndexHits := DueDiligence.CommonQueryXML.GetIndividualV3AttributeFlags(results, cleanData);
        
        LOCAL finalPerson := DueDiligence.CommonQueryXML.mac_GetESPReturnData(rawReqWithSeq, cleanData, results, responseLayout, DueDiligence.Constants.INDIVIDUAL,
                                                                              includeReport, indIndex, indIndexHits, cleanData[1].requestedVersion, additionalInfo);
        
        RETURN finalPerson;
    ENDMACRO;
    
    EXPORT mac_v3BusinessXML(rawReqWithSeq, cleanData, compliance, ssnMaskVal, additionalInfo, responseLayout, includeReport, debugIn) := FUNCTIONMACRO
        
        LOCAL boolReport := IF(includeReport = DueDiligence.Constants.STRING_TRUE, TRUE, FALSE);
        LOCAL results := DueDiligence.CommonQuery.v3BusinessResults(cleanData, compliance, ssnMaskVal, boolReport, debugIn);
        
        LOCAL busIndex := DueDiligence.CommonQueryXML.GetBusinessV3Attributes(results, cleanData);
        LOCAL busIndexHits := DueDiligence.CommonQueryXML.GetBusinessV3AttributeFlags(results, cleanData);
        
        LOCAL finalBusiness := DueDiligence.CommonQueryXML.mac_GetESPReturnData(rawReqWithSeq, cleanData, results, responseLayout, DueDiligence.Constants.BUSINESS,
                                                                                includeReport, busIndex, busIndexHits, cleanData[1].requestedVersion, additionalInfo);
        
        RETURN finalBusiness;
    ENDMACRO;
    
    
    
    EXPORT mac_processV3XMLRequest(rawReqWithSeq, cleanData, compliance, ssnMaskVal, 
                                additionalInfo, responseLayout, includeReport, debugIn, intermediatesIn) := FUNCTIONMACRO
  
        busDebug := IF(cleanData[1].containsPersonReq = FALSE AND cleanData[1].containsCitizenshipReq = FALSE, debugIn, FALSE);
        perDebug := IF(cleanData[1].containsPersonReq OR cleanData[1].containsCitizenshipReq, debugIn, FALSE);
  
        ddFinal := IF(cleanData[1].containsPersonReq OR cleanData[1].containsCitizenshipReq,
                      DueDiligence.CommonQueryXML.mac_v3PersonXML(rawReqWithSeq, cleanData, compliance, ssnMaskVal, additionalInfo, responseLayout, includeReport, perDebug, intermediatesIn),
                      DueDiligence.CommonQueryXML.mac_v3BusinessXML(rawReqWithSeq, cleanData, compliance, ssnMaskVal, additionalInfo, responseLayout, includeReport, busDebug));
        
        RETURN ddFinal;
    ENDMACRO;




END;
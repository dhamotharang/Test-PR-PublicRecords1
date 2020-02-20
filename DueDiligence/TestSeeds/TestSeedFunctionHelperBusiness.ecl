IMPORT DueDiligence, iesp, Seed_Files;

EXPORT TestSeedFunctionHelperBusiness := MODULE

    //================================
    // Attributes Section
    //================================
    EXPORT GetBusinessAttributes(RECORDOF(Seed_Files.keys_DueDiligenceBusinessReport.AttributesSection) attrs) := FUNCTION
        
        RETURN PROJECT(attrs, TRANSFORM(iesp.duediligenceshared.t_DDRAttributeGroup,
                                        SELF.name := LEFT.attributeName;
                                        SELF.attributes := DueDiligence.Common.createNVPair('BusAssetOwnProperty', LEFT.BusAssetOwnProperty) +
                                                            DueDiligence.Common.createNVPair('BusAssetOwnAircraft', LEFT.BusAssetOwnAircraft) +
                                                            DueDiligence.Common.createNVPair('BusAssetOwnWatercraft', LEFT.BusAssetOwnWatercraft) +
                                                            DueDiligence.Common.createNVPair('BusAssetOwnVehicle', LEFT.BusAssetOwnVehicle) +
                                                            DueDiligence.Common.createNVPair('BusAccessToFundSales', LEFT.BusAccessToFundSales) +
                                                            DueDiligence.Common.createNVPair('BusAccessToFundsProperty', LEFT.BusAccessToFundsProperty) +
                                                            DueDiligence.Common.createNVPair('BusGeographic', LEFT.BusGeographic) +
                                                            DueDiligence.Common.createNVPair('BusValidity', LEFT.BusValidity) +
                                                            DueDiligence.Common.createNVPair('BusStability', LEFT.BusStability) +
                                                            DueDiligence.Common.createNVPair('BusIndustry', LEFT.BusIndustry) +
                                                            DueDiligence.Common.createNVPair('BusStructureType', LEFT.BusStructureType) +
                                                            DueDiligence.Common.createNVPair('BusSOSAgeRange', LEFT.BusSOSAgeRange) +
                                                            DueDiligence.Common.createNVPair('BusPublicRecordAgeRange', LEFT.BusPublicRecordAgeRange) +
                                                            DueDiligence.Common.createNVPair('BusShellShelf', LEFT.BusShellShelf) +
                                                            DueDiligence.Common.createNVPair('BusMatchLevel', LEFT.BusMatchLevel) +
                                                            DueDiligence.Common.createNVPair('BusStateLegalEvent', LEFT.BusStateLegalEvent) +
                                                            DueDiligence.Common.createNVPair('BusFederalLegalEvent', LEFT.BusFederalLegalEvent) +
                                                            DueDiligence.Common.createNVPair('BusFederalLegalMatchLevel', LEFT.BusFederalLegalMatchLevel) +
                                                            DueDiligence.Common.createNVPair('BusCivilLegalEvent', LEFT.BusCivilLegalEvent) +
                                                            DueDiligence.Common.createNVPair('BusOffenseType', LEFT.BusOffenseType) +
                                                            DueDiligence.Common.createNVPair('BusBEOProfLicense', LEFT.BusBEOProfLicense) +
                                                            DueDiligence.Common.createNVPair('BusBEOUSResidency', LEFT.BusBEOUSResidency) +
                                                            DueDiligence.Common.createNVPair('BusBEOAccessToFundsProperty', LEFT.BusBEOAccessToFundsProperty) +
                                                            DueDiligence.Common.createNVPair('BusLinkedBusinesses', LEFT.BusLinkedBusinesses);
                                                            
                                        SELF.attributeLevelHits := DueDiligence.Common.createNVPair('BusAssetOwnProperty_Flag', LEFT.BusAssetOwnProperty_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusAssetOwnAircraft_Flag', LEFT.BusAssetOwnAircraft_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusAssetOwnWatercraft_Flag', LEFT.BusAssetOwnWatercraft_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusAssetOwnVehicle_Flag', LEFT.BusAssetOwnVehicle_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusAccessToFundsSales_Flag', LEFT.BusAccessToFundsSales_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusAccessToFundsProperty_Flag', LEFT.BusAccessToFundsProperty_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusGeographic_Flag', LEFT.BusGeographic_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusValidity_Flag', LEFT.BusValidity_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusStability_Flag', LEFT.BusStability_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusIndustry_Flag', LEFT.BusIndustry_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusStructureType_Flag', LEFT.BusStructureType_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusSOSAgeRange_Flag', LEFT.BusSOSAgeRange_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusPublicRecordAgeRange_Flag', LEFT.BusPublicRecordAgeRange_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusShellShelf_Flag', LEFT.BusShellShelf_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusMatchLevel_Flag', LEFT.BusMatchLevel_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusStateLegalEvent_Flag', LEFT.BusStateLegalEvent_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusFederalLegalEvent_Flag', LEFT.BusFederalLegalEvent_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusFederalLegalMatchLevel_Flag', LEFT.BusFederalLegalMatchLevel_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusCivilLegalEvent_Flag', LEFT.BusCivilLegalEvent_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusOffenseType_Flag', LEFT.BusOffenseType_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusBEOProfLicense_Flag', LEFT.BusBEOProfLicense_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusBEOUSResidency_Flag', LEFT.BusBEOUSResidency_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusBEOAccessToFundsProperty_Flag', LEFT.BusBEOAccessToFundsProperty_Flag) +
                                                                    DueDiligence.Common.createNVPair('BusLinkedBusinesses_Flag', LEFT.BusLinkedBusinesses_Flag);));

    END;
    
    EXPORT GetBusinessAttributesNotFound := FUNCTION
    
        STRING10 INVALID_BUSINESS_FLAGS := 'FFFFFFFFFF';
        STRING2 INVALID_BUSINESS_SCORE := '-1';
        STRING2 NOT_CURRENTLY_IMPLEMENTED := DueDiligence.Constants.EMPTY;
    
        RETURN DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRAttributeGroup,
                                        SELF.name := DueDiligence.Constants.BUS_REQ_ATTRIBUTE_V3;
                                        SELF.attributes := DueDiligence.Common.createNVPair('BusAssetOwnProperty', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusAssetOwnAircraft', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusAssetOwnWatercraft', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusAssetOwnVehicle', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusAccessToFundSales', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusAccessToFundsProperty', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusGeographic', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusValidity', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusStability', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusIndustry', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusStructureType', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusSOSAgeRange', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusPublicRecordAgeRange', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusShellShelf', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusMatchLevel', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusStateLegalEvent', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusFederalLegalEvent', NOT_CURRENTLY_IMPLEMENTED) +
                                                            DueDiligence.Common.createNVPair('BusFederalLegalMatchLevel', NOT_CURRENTLY_IMPLEMENTED) +
                                                            DueDiligence.Common.createNVPair('BusCivilLegalEvent', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusOffenseType', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusBEOProfLicense', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusBEOUSResidency', INVALID_BUSINESS_SCORE) +
                                                            DueDiligence.Common.createNVPair('BusBEOAccessToFundsProperty', NOT_CURRENTLY_IMPLEMENTED) +
                                                            DueDiligence.Common.createNVPair('BusLinkedBusinesses', NOT_CURRENTLY_IMPLEMENTED);
                                                            
                                        SELF.attributeLevelHits := DueDiligence.Common.createNVPair('BusAssetOwnProperty_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusAssetOwnAircraft_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusAssetOwnWatercraft_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusAssetOwnVehicle_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusAccessToFundsSales_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusAccessToFundsProperty_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusGeographic_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusValidity_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusStability_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusIndustry_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusStructureType_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusSOSAgeRange_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusPublicRecordAgeRange_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusShellShelf_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusMatchLevel_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusStateLegalEvent_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusFederalLegalEvent_Flag', NOT_CURRENTLY_IMPLEMENTED) +
                                                                    DueDiligence.Common.createNVPair('BusFederalLegalMatchLevel_Flag', NOT_CURRENTLY_IMPLEMENTED) +
                                                                    DueDiligence.Common.createNVPair('BusCivilLegalEvent_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusOffenseType_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusBEOProfLicense_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusBEOUSResidency_Flag', INVALID_BUSINESS_FLAGS) +
                                                                    DueDiligence.Common.createNVPair('BusBEOAccessToFundsProperty_Flag', NOT_CURRENTLY_IMPLEMENTED) +
                                                                    DueDiligence.Common.createNVPair('BusLinkedBusinesses_Flag', NOT_CURRENTLY_IMPLEMENTED);)])[1];
        
    END;

END;
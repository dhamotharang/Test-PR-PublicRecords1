IMPORT DueDiligence, iesp, Seed_Files;

EXPORT TestSeedFunctionHelperCitizenship := MODULE

    //================================
    // Risk Indicator Section
    //================================
    EXPORT GetRiskIndicators(RECORDOF(Seed_Files.keys_Citizenship.RiskIndicatorsSection) risk) := FUNCTION
        
        RETURN PROJECT(risk, TRANSFORM(iesp.citizenshipscore.t_CITResponse,
                                        SELF.CitizenshipScore := LEFT.citizenshipScore;
                                        SELF.CitizenshipAttributes := DueDiligence.Common.createNVPair('LexID', LEFT.lexID) +
                                                                      DueDiligence.Common.createNVPair('LexIDScore', LEFT.lexIDScore) +
                                                                      DueDiligence.Common.createNVPair('IdentityAge', LEFT.identityAge) +
                                                                      DueDiligence.Common.createNVPair('EmergenceAgeHeader', LEFT.emergenceAgeHeader) +
                                                                      DueDiligence.Common.createNVPair('EmergenceAgeBureau', LEFT.emergenceAgeBureau) +
                                                                      DueDiligence.Common.createNVPair('SSNIssuanceAge', LEFT.ssnIssuanceAge) +
                                                                      DueDiligence.Common.createNVPair('SSNIssuanceYears', LEFT.ssnIssuanceYears) +
                                                                      DueDiligence.Common.createNVPair('RelativeCount', LEFT.relativeCount) +
                                                                      DueDiligence.Common.createNVPair('Ver_voterRecords', LEFT.ver_voterRecords) +
                                                                      DueDiligence.Common.createNVPair('Ver_insuranceRecords', LEFT.ver_insuranceRecords) +
                                                                      DueDiligence.Common.createNVPair('Ver_studentFile', LEFT.ver_studentFile) +
                                                                      DueDiligence.Common.createNVPair('FirstSeenAddr10', LEFT.firstSeenAddr10) +
                                                                      DueDiligence.Common.createNVPair('ReportedCurAddressYears', LEFT.reportedCurAddressYears) +
                                                                      DueDiligence.Common.createNVPair('AddressFirstReportedAge', LEFT.addressFirstReportedAge) +
                                                                      DueDiligence.Common.createNVPair('TimeSinceLastReportedNonBureau', LEFT.timeSinceLastReportedNonBureau) +
                                                                      DueDiligence.Common.createNVPair('InputSSNRandomlyIssued', LEFT.inputSSNRandomlyIssued) +
                                                                      DueDiligence.Common.createNVPair('InputSSNRandomIssuedInvalid', LEFT.inputSSNRandomIssuedInvalid) +
                                                                      DueDiligence.Common.createNVPair('InputSSNIssuedToNonUS', LEFT.inputSSNIssuedToNonUS) +
                                                                      DueDiligence.Common.createNVPair('InputSSNITIN', LEFT.inputSSNITIN) +
                                                                      DueDiligence.Common.createNVPair('InputSSNInvalid', LEFT.inputSSNInvalid) +
                                                                      DueDiligence.Common.createNVPair('InputSSNIssuedPriorDOB', LEFT.inputSSNIssuedPriorDOB) +
                                                                      DueDiligence.Common.createNVPair('InputSSNAssociatedMultLexIDs', LEFT.inputSSNAssociatedMultLexIDs) +
                                                                      DueDiligence.Common.createNVPair('InputSSNReportedDeceased', LEFT.inputSSNReportedDeceased) +
                                                                      DueDiligence.Common.createNVPair('InputSSNNotPrimaryLexID', LEFT.inputSSNNotPrimaryLexID) +
                                                                      DueDiligence.Common.createNVPair('LexIDBestSSNInvalid', LEFT.lexIDBestSSNInvalid) +
                                                                      DueDiligence.Common.createNVPair('LexIDReportedDeceased', LEFT.lexIDReportedDeceased) +
                                                                      DueDiligence.Common.createNVPair('LexIDMultipleSSNs', LEFT.lexIDMultipleSSNs) +
                                                                      DueDiligence.Common.createNVPair('InputComponentDivRisk', LEFT.inputComponentDivRisk);));

    END;
    
    EXPORT GetRiskIndicatorsNotFound := FUNCTION
    
        STRING3 DEFAULT_SCORE := '510';
        STRING2 VALUE_NEG_1 := '-1';
        STRING2 VALUE_ZERO := '0';
    
        RETURN DATASET([TRANSFORM(iesp.citizenshipscore.t_CITResponse,
                                        SELF.CitizenshipScore := DEFAULT_SCORE;
                                        SELF.CitizenshipAttributes := DueDiligence.Common.createNVPair('LexID', VALUE_ZERO) +
                                                                      DueDiligence.Common.createNVPair('LexIDScore', VALUE_ZERO) +
                                                                      DueDiligence.Common.createNVPair('IdentityAge', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('EmergenceAgeHeader', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('EmergenceAgeBureau', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('SSNIssuanceAge', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('SSNIssuanceYears', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('RelativeCount', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('Ver_voterRecords', VALUE_ZERO) +
                                                                      DueDiligence.Common.createNVPair('Ver_insuranceRecords', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('Ver_studentFile', VALUE_ZERO) +
                                                                      DueDiligence.Common.createNVPair('FirstSeenAddr10', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('ReportedCurAddressYears', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('AddressFirstReportedAge', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('TimeSinceLastReportedNonBureau', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('InputSSNRandomlyIssued', VALUE_ZERO) +
                                                                      DueDiligence.Common.createNVPair('InputSSNRandomIssuedInvalid', VALUE_ZERO) +
                                                                      DueDiligence.Common.createNVPair('InputSSNIssuedToNonUS', VALUE_ZERO) +
                                                                      DueDiligence.Common.createNVPair('InputSSNITIN', VALUE_ZERO) +
                                                                      DueDiligence.Common.createNVPair('InputSSNInvalid', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('InputSSNIssuedPriorDOB', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('InputSSNAssociatedMultLexIDs', VALUE_ZERO) +
                                                                      DueDiligence.Common.createNVPair('InputSSNReportedDeceased', VALUE_ZERO) +
                                                                      DueDiligence.Common.createNVPair('InputSSNNotPrimaryLexID', VALUE_ZERO) +
                                                                      DueDiligence.Common.createNVPair('LexIDBestSSNInvalid', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('LexIDReportedDeceased', VALUE_ZERO) +
                                                                      DueDiligence.Common.createNVPair('LexIDMultipleSSNs', VALUE_NEG_1) +
                                                                      DueDiligence.Common.createNVPair('InputComponentDivRisk', VALUE_NEG_1);)])[1];
        
    END;

END;
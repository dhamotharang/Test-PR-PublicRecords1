IMPORT Citizenship, DueDiligence, iesp;

EXPORT CitizenshipServiceMain(DATASET({INTEGER4 seq, iesp.duediligenceattributes.t_DueDiligenceAttributesRequest}) rawInput,
                              DATASET(DueDiligence.Layouts.Input) validRequest, 
                              UNSIGNED6 inGLBA, 
                              UNSIGNED6 inDPPA, 
                              STRING50 inDataRestriction,
                              STRING50 inDataPermission,
                              STRING15 inModelName,
                              BOOLEAN modelValidation,
                              BOOLEAN debug) := FUNCTION
                            
                            
                            
    citizenshipInfo := Citizenship.getCitizenship(validRequest, inGLBA, inDPPA, inDataRestriction, inDataPermission, inModelName, modelValidation, debug);
    
    
    citizenshipIndicators := NORMALIZE(UNGROUP(citizenshipInfo), Citizenship.Constants.NUMBER_OF_INDICATORS, TRANSFORM(iesp.share.t_NameValuePair,
																													SELF := CASE(COUNTER,
																																				1  => Citizenship.Common.createNVPair('LexID', LEFT.lexID),
																																				2  => Citizenship.Common.createNVPair('LexIDScore', LEFT.lexIDScore),
																																				3  => Citizenship.Common.createNVPair('IdentityAge', LEFT.identityAge),
																																				4  => Citizenship.Common.createNVPair('EmergenceAgeHeader', LEFT.emergenceAgeHeader),
																																				5  => Citizenship.Common.createNVPair('EmergenceAgeBureau', LEFT.emergenceAgeBureau),
																																				6  => Citizenship.Common.createNVPair('SSNIssuanceAge', LEFT.ssnIssuanceAge),
																																				7  => Citizenship.Common.createNVPair('SSNIssuanceYears', LEFT.ssnIssuanceYears),
																																				8  => Citizenship.Common.createNVPair('RelativeCount', LEFT.relativeCount),
																																				9  => Citizenship.Common.createNVPair('Ver_voterRecords', LEFT.ver_voterRecords),
																																				10 => Citizenship.Common.createNVPair('Ver_insuranceRecords', LEFT.ver_insuranceRecords),
																																				11 => Citizenship.Common.createNVPair('Ver_studentFile', LEFT.ver_studentFile),
																																				12 => Citizenship.Common.createNVPair('FirstSeenAddr10', LEFT.firstSeenAddr10),
																																				13 => Citizenship.Common.createNVPair('ReportedCurAddressYears', LEFT.reportedCurAddressYears),
																																				14 => Citizenship.Common.createNVPair('AddressFirstReportedAge', LEFT.addressFirstReportedAge),
																																				15 => Citizenship.Common.createNVPair('TimeSinceLastReportedNonBureau', LEFT.timeSinceLastReportedNonBureau),
																																				16 => Citizenship.Common.createNVPair('InputSSNRandomlyIssued', LEFT.inputSSNRandomlyIssued),
																																				17 => Citizenship.Common.createNVPair('InputSSNRandomIssuedInvalid', LEFT.inputSSNRandomIssuedInvalid),
																																				18 => Citizenship.Common.createNVPair('InputSSNIssuedToNonUS', LEFT.inputSSNIssuedToNonUS),
																																				19 => Citizenship.Common.createNVPair('InputSSNITIN', LEFT.inputSSNITIN),
																																				20 => Citizenship.Common.createNVPair('InputSSNInvalid', LEFT.inputSSNInvalid),
																																				21 => Citizenship.Common.createNVPair('InputSSNIssuedPriorDOB', LEFT.inputSSNIssuedPriorDOB),
																																				22 => Citizenship.Common.createNVPair('InputSSNAssociatedMultLexIDs', LEFT.inputSSNAssociatedMultLexIDs),
																																				23 => Citizenship.Common.createNVPair('InputSSNReportedDeceased', LEFT.inputSSNReportedDeceased),
																																				24 => Citizenship.Common.createNVPair('InputSSNNotPrimaryLexID', LEFT.inputSSNNotPrimaryLexID),
																																				25 => Citizenship.Common.createNVPair('LexIDBestSSNInvalid', LEFT.lexIDBestSSNInvalid),
																																				26 => Citizenship.Common.createNVPair('LexIDReportedDeceased', LEFT.lexIDReportedDeceased),
																																				27 => Citizenship.Common.createNVPair('LexIDMultipleSSNs', LEFT.lexIDMultipleSSNs),
																																				28 => Citizenship.Common.createNVPair('InputComponentDivRisk', LEFT.inputComponentDivRisk),
																																							DueDiligence.Common.createNVPair(DueDiligence.Constants.INVALID, DueDiligence.Constants.INVALID));));
    
    
    // return the esp output
    citizenshipResults := JOIN(rawInput, citizenshipInfo,
                                LEFT.seq = RIGHT.seq,
                                TRANSFORM(iesp.duediligenceattributes.t_DueDiligenceAttributesResponse,
                                          SELF.Result.UniqueId := IF((STRING)RIGHT.lexID = '0', DueDiligence.Constants.EMPTY, (STRING)RIGHT.lexID);
                                          SELF.Result.inputecho := LEFT.reportBy;	
                                          SELF.Result.CitizenshipResults.CitizenshipScore := RIGHT.citizenshipScore;
                                          SELF.Result.CitizenshipResults.CitizenshipAttributes := citizenshipIndicators;
                                          SELF := [];));
    

    
   
    
    // OUTPUT(citizenshipInfo, NAMED('citizenshipInfo'));
    // OUTPUT(citizenshipIndicators, NAMED('citizenshipIndicators'));
    // OUTPUT(citizenshipResults, NAMED('citizenshipResults'));
    
    RETURN citizenshipResults;
END;
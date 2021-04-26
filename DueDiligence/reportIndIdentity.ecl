IMPORT Business_Risk_BIP, DueDiligence, iesp;

EXPORT reportIndIdentity(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                         Business_Risk_BIP.LIB_Business_Shell_LIBIN options
                         ) := FUNCTION


    IDENTITY_TYPE_INACTIVE := 'Inactive';
    IDENTITY_TYPE_UNSTABLE := 'Unstable';
    IDENTITY_TYPE_EMERGING := 'Emerging';
    IDENTITY_TYPE_ESTABLISHED := 'Established';

    START_DESCRIPTION := 'Individual\'s identity (LexID) has emerged';

    IdentityDSLayout := RECORD
      STRING2 identityAttributeLevel;
      STRING identityType;
      STRING identityDescription;
    END;


    indentityDS := DATASET([
                          {'9',    IDENTITY_TYPE_INACTIVE,         START_DESCRIPTION + ', but has not been seen by any reporting source within the last 3 years'},
                          {'8',    IDENTITY_TYPE_UNSTABLE,         START_DESCRIPTION + ', but the LexID and/or the SSN is being reported as deceased'},
                          {'7',    IDENTITY_TYPE_UNSTABLE,         START_DESCRIPTION + ', but the SSN has red flags associated with it such as being invalid, associated to multiple LexIDs, or being issued prior to the date of birth'},
                          {'6',    IDENTITY_TYPE_UNSTABLE,         START_DESCRIPTION + ', but is missing key personally identifiable information (PII) such as address or date of birth'},
                          {'5',    IDENTITY_TYPE_EMERGING,         START_DESCRIPTION + ' and been reported at Lexis Nexis for 0-2 years'},
                          {'4',    IDENTITY_TYPE_ESTABLISHED,      START_DESCRIPTION + ' and been reported at Lexis Nexis for 2-5 years'},
                          {'3',    IDENTITY_TYPE_ESTABLISHED,      START_DESCRIPTION + ' and been reported at Lexis Nexis for 5-10 years'},
                          {'2',    IDENTITY_TYPE_ESTABLISHED,      START_DESCRIPTION + ' and been reported at Lexis Nexis for 10-20 years'},
                          {'1',    IDENTITY_TYPE_ESTABLISHED,      START_DESCRIPTION + ' and been reported at Lexis Nexis for 20+ years'}], IdentityDSLayout);

    dctByLevel := DICTIONARY(indentityDS, {identityAttributeLevel => indentityDS});








    initialInfo := PROJECT(inData, TRANSFORM(DueDiligence.LayoutsInternalReport.ReportIdentity,
                                              SELF.seq := LEFT.seq;
                                              SELF.inquiredDID := LEFT.inquiredDID;

                                              SELF.estimatedAge := LEFT.estimatedAge;


                                              SELF.inputSSNDetails.SSNFirstAssociated := iesp.ECL2ESP.toDate(LEFT.inputSSNDetails.firstSeen);
                                              SELF.inputSSNDetails.SSNLastAssociated := iesp.ECL2ESP.toDate(LEFT.inputSSNDetails.lastSeen);
                                              SELF.inputSSNDetails.SSNIssuanceRangeLow := iesp.ECL2ESP.toDate(LEFT.inputSSNDetails.issuedLowDate);
                                              SELF.inputSSNDetails.SSNIssuanceRangeHigh := iesp.ECL2ESP.toDate(LEFT.inputSSNDetails.issuedHighDate);
                                              SELF.inputSSNDetails.SSNIssuanceState := LEFT.inputSSNDetails.issuedState;
                                              SELF.inputSSNDetails.SSNRandomized := LEFT.inputSSNDetails.randomized;
                                              SELF.inputSSNDetails.SSNEnumerationAtEntry := LEFT.inputSSNDetails.enumerationAtEntry;
                                              SELF.inputSSNDetails.SSNIsITIN := LEFT.inputSSNDetails.isITIN;
                                              SELF.inputSSNDetails.SSNInvalid := LEFT.inputSSNDetails.invalid;
                                              SELF.inputSSNDetails.SSNIssuedPriorToDOB := LEFT.inputSSNDetails.issuedPriorToDOB;
                                              SELF.inputSSNDetails.SSNRandomlyIssuedInvalid := LEFT.inputSSNDetails.randomlyIssuedInvalid;
                                              SELF.inputSSNDetails.SSNReportedAsDeceased := LEFT.inputSSNDetails.reportedDeceased;

                                              SELF.bestSSNDetails.SSNFirstAssociated := iesp.ECL2ESP.toDate(LEFT.bestSSNDetails.firstSeen);
                                              SELF.bestSSNDetails.SSNLastAssociated := iesp.ECL2ESP.toDate(LEFT.bestSSNDetails.lastSeen);
                                              SELF.bestSSNDetails.SSNIssuanceRangeLow := iesp.ECL2ESP.toDate(LEFT.bestSSNDetails.issuedLowDate);
                                              SELF.bestSSNDetails.SSNIssuanceRangeHigh := iesp.ECL2ESP.toDate(LEFT.bestSSNDetails.issuedHighDate);
                                              SELF.bestSSNDetails.SSNIssuanceState := LEFT.bestSSNDetails.issuedState;
                                              SELF.bestSSNDetails.SSNRandomized := LEFT.bestSSNDetails.randomized;
                                              SELF.bestSSNDetails.SSNEnumerationAtEntry := LEFT.bestSSNDetails.enumerationAtEntry;
                                              SELF.bestSSNDetails.SSNIsITIN := LEFT.bestSSNDetails.isITIN;
                                              SELF.bestSSNDetails.SSNInvalid := LEFT.bestSSNDetails.invalid;
                                              SELF.bestSSNDetails.SSNIssuedPriorToDOB := LEFT.bestSSNDetails.issuedPriorToDOB;
                                              SELF.bestSSNDetails.SSNRandomlyIssuedInvalid := LEFT.bestSSNDetails.randomlyIssuedInvalid;
                                              SELF.bestSSNDetails.SSNReportedAsDeceased := LEFT.bestSSNDetails.reportedDeceased;

                                              SELF.identityDetails.LexIDReportedDeceased := LEFT.lexIDReportedDeceased;
                                              SELF.identityDetails.LexIDBestSSNInvalid := LEFT.dd_bestSSNInvalid;
                                              SELF.identityDetails.LexIDMultipleSSNs := LEFT.redFlagLexIDContainsMultiSSNs;

                                              SELF.identityDetails.IdentityDateAppeared := iesp.ECL2ESP.toDate(LEFT.firstReportedDate);
                                              SELF.identityDetails.IdentityDateLastReported := iesp.ECL2ESP.toDate(LEFT.dateLastReported);

                                              timeBetweenDateAppeared := DueDiligence.CommonDate.NumberOfYearsMonthsDaysBetweenDates((STRING)LEFT.firstReportedDate, (STRING)LEFT.historyDate);
                                              SELF.identityDetails.IdentityDateAppearedYears := timeBetweenDateAppeared.Years;
                                              SELF.identityDetails.IdentityDateAppearedMonths := timeBetweenDateAppeared.Months;

                                              timeBetweenDateLastReported := DueDiligence.CommonDate.NumberOfYearsMonthsDaysBetweenDates((STRING)LEFT.dateLastReported, (STRING)LEFT.historyDate);
                                              SELF.identityDetails.IdentityDateLastReportedYears := timeBetweenDateLastReported.Years;
                                              SELF.identityDetails.IdentityDateLastReportedMonths := timeBetweenDateLastReported.Months;


                                              identityData := dctByLevel[TRIM(LEFT.PerIdentityRisk)];

                                              SELF.identityDetails.IdentityType := identityData.identityType;
                                              SELF.identityDetails.IdentityTypeDescription := identityData.identityDescription;


                                              SELF := [];));



    ssnVariationDetails := DueDiligence.reportIndIdentitySSNVariation(inData, options);

    addSSNVariations := JOIN(initialInfo, ssnVariationDetails,
                             LEFT.seq = RIGHT.seq AND
                             LEFT.inquiredDID = RIGHT.inquiredDID,
                             TRANSFORM(DueDiligence.LayoutsInternalReport.ReportIdentity,
                                        SELF.inputSSNDetails.SSN := RIGHT.maskedInputSSN;
                                        SELF.inputSSNDetails.SSNDeviations := RIGHT.inputPersonDeviations;

                                        SELF.bestSSNDetails.SSN := RIGHT.maskedBestSSN;
                                        SELF.bestSSNDetails.SSNDeviations := RIGHT.bestPersonDeviations;

                                        SELF.identityDetails.IdentityReportedSSNs := SORT(RIGHT.reportedSSNs, ssn, lexID);
                                        SELF := LEFT;),
                             LEFT OUTER,
                             ATMOST(1));


    sourceDetails := DueDiligence.reportIndIdentitySources(inData);

    addSources := JOIN(addSSNVariations, sourceDetails,
                       LEFT.seq = RIGHT.seq AND
                       LEFT.inquiredDID = RIGHT.inquiredDID,
                       TRANSFORM(DueDiligence.LayoutsInternalReport.ReportIdentity,
                                  SELF.inputSSNDetails.SourcesReporting := RIGHT.espInputSourceDetails;
                                  SELF.bestSSNDetails.SourcesReporting := RIGHT.espBestSourceDetails;
                                  SELF.allSourcesReporting := RIGHT.espSourceDetailsWithDates;
                                  SELF.allSourcesCounts := RIGHT.sourceCategoryCount;
                                  SELF := LEFT;),
                       LEFT OUTER,
                       ATMOST(1));


    nestedDS := DueDiligence.reportIndIdentityNestedData(inData);

    addNestedData := JOIN(addSources, nestedDS,
                           LEFT.seq = RIGHT.seq AND
                           LEFT.inquiredDID = RIGHT.inquiredDID,
                           TRANSFORM(DueDiligence.LayoutsInternalReport.ReportIdentity,
                                      SELF.identityDetails.IdentityAKAs := RIGHT.espAKAs;
                                      SELF.identityDetails.IdentityReportedDOBs := RIGHT.espDOBAge;
                                      SELF := LEFT;),
                           LEFT OUTER,
                           ATMOST(1));


    addIdentity := JOIN(inData, addnestedData,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.inquiredDID = RIGHT.inquiredDID,
                        TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                  SELF.personReport.PersonAttributeDetails.Identitiy.EstimatedAge := RIGHT.estimatedAge;
                                  SELF.personReport.PersonAttributeDetails.Identitiy.SSNInformation.InputSSNDetails := RIGHT.inputSSNDetails;
                                  SELF.personReport.PersonAttributeDetails.Identitiy.SSNInformation.BestSSNDetails := RIGHT.bestSSNDetails;
                                  SELF.personReport.PersonAttributeDetails.Identitiy.LexIDInformation := RIGHT.identityDetails;
                                  SELF.personReport.PersonAttributeDetails.Identitiy.SourcesReporting := RIGHT.allSourcesReporting;
                                  SELF.personReport.PersonAttributeDetails.Identitiy.NumberOfSourcesReporting := RIGHT.allSourcesCounts;

                                  SELF := LEFT;),
                        LEFT OUTER,
                        ATMOST(1));





    // OUTPUT(inData, NAMED('inData'));
    // OUTPUT(initialInfo, NAMED('initialInfo'));
    // OUTPUT(ssnVariationDetails, NAMED('ssnVariationDetails'));
    // OUTPUT(addSSNVariations, NAMED('addSSNVariations'));
    // OUTPUT(sourceDetails, NAMED('sourceDetails'));
    // OUTPUT(addSources, NAMED('addSources'));
    // OUTPUT(nestedDS, NAMED('nestedDS'));
    // OUTPUT(addNestedData, NAMED('addNestedData'));
    // OUTPUT(addIdentity, NAMED('addIdentity'));



    RETURN addIdentity;


END;

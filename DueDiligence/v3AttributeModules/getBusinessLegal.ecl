IMPORT Business_Risk_BIP, Doxie, DueDiligence;


EXPORT getBusinessLegal(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                        DueDiligence.DDInterface.iDDv3BusinessAttributes attributesRequested,
                        DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
                        DueDiligence.DDInterface.iDDBusinessOptions ddOptions) := FUNCTION


    //get legal data for all unique businesses
    uniqueBusinesses := DEDUP(SORT(inData, inquiredBusiness.ultID, inquiredBusiness.orgID, inquiredBusiness.seleID), inquiredBusiness.ultID, inquiredBusiness.orgID, inquiredBusiness.seleID);
    rawCivilResults := DueDiligence.v3BusinessData.getLienJundgementEviction(uniqueBusinesses, regulatoryAccess);
    rawBankruptcyResults := DueDiligence.v3BusinessData.getBankruptcy(uniqueBusinesses, regulatoryAccess);


    //based on the legal data - populate requested attributes
    noAttributeResults := DATASET([], DueDiligence.v3Layouts.InternalBusiness.BusinessAttributes);

    offenseTypeAttributeResults := DueDiligence.v3BusinessAttributes.getOffenseType(inData);
    stateLegalEventAttributeResults := DueDiligence.v3BusinessAttributes.getStateLegalEvent(inData);
    civilLegalEventAttributeResults := DueDiligence.v3BusinessAttributes.getCivilLegalEvent(inData, rawCivilResults, rawBankruptcyResults);
    civilLegalEventFilingAmountAttributeResults := DueDiligence.v3BusinessAttributes.getCivilLegalEventFilingAmt(inData, rawCivilResults);


    offenseType := IF(attributesRequested.includeAll OR attributesRequested.includeOffenseType, offenseTypeAttributeResults, noAttributeResults);
    stateLegalEvent := IF(attributesRequested.includeAll OR attributesRequested.includeStateLegalEvent, stateLegalEventAttributeResults, noAttributeResults);
    civilLegalEvent := IF(attributesRequested.includeAll OR attributesRequested.includeCivilLegalEvent, civilLegalEventAttributeResults, noAttributeResults);
    civilLegalEventFilingAmt := IF(attributesRequested.includeAll OR attributesRequested.includeCivilLegalEventFilingAmount, civilLegalEventFilingAmountAttributeResults, noAttributeResults);


    //add all the attributes together to get all necessary legal attributes
    legalAttributes := ROLLUP(SORT(offenseType + stateLegalEvent + civilLegalEvent + civilLegalEventFilingAmt, seq, ultID, orgID, seleID),
                              LEFT.seq = RIGHT.seq AND
                              LEFT.ultID = RIGHT.ultID AND
                              LEFT.orgID = RIGHT.orgID AND
                              LEFT.seleID = RIGHT.seleID,
                              TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessAttributes,
                                        SELF.seq := LEFT.seq;
                                        SELF.ultID := LEFT.ultID;
                                        SELF.orgID := LEFT.orgID;
                                        SELF.seleID := LEFT.seleID;

                                        SELF.busCivilLegalEvent := DueDiligence.v3Common.General.FirstPopulatedString(busCivilLegalEvent);
                                        SELF.busCivilLegalEvent_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busCivilLegalEvent_Flag);

                                        SELF.busCivilLegalEventFilingAmt := DueDiligence.v3Common.General.FirstPopulatedString(busCivilLegalEventFilingAmt);
                                        SELF.busCivilLegalEventFilingAmt_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busCivilLegalEventFilingAmt_Flag);

                                        SELF.busOffenseType := DueDiligence.v3Common.General.FirstPopulatedString(busOffenseType);
                                        SELF.busOffenseType_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busOffenseType_Flag);

                                        SELF.busStateLegalEvent := DueDiligence.v3Common.General.FirstPopulatedString(busStateLegalEvent);
                                        SELF.busStateLegalEvent_Flag := DueDiligence.v3Common.General.FirstPopulatedString(busStateLegalEvent_Flag);

                                        SELF := LEFT;));



    //based on request - populate the reports of the legal section
    noLegalReportData := DATASET([], DueDiligence.v3Layouts.InternalBusiness.BusinessReport);
    legalReportData := DueDiligence.v3BusinessReport.getLegal(inData, rawCivilResults);

    includeReportData := ddOptions.includeReportData AND
                        (attributesRequested.includeAll OR
                        (attributesRequested.includeOffenseType AND
                        attributesRequested.includeStateLegalEvent AND
                        attributesRequested.includeCivilLegalEvent AND
                        attributesRequested.includeCivilLegalEventFilingAmount));

    legalReport := IF(includeReportData, legalReportData, noLegalReportData);


    //join the attributes and report data together
    finalLegal := JOIN(legalAttributes, legalReport,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.ultID = RIGHT.ultID AND
                        LEFT.orgID = RIGHT.orgID AND
                        LEFT.seleID = RIGHT.seleID,
                        TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessResults,
                                  SELF.seq := LEFT.seq;
                                  SELF.ultID := LEFT.ultID;
                                  SELF.orgID := LEFT.orgID;
                                  SELF.seleID := LEFT.seleID;

                                  SELF.busCivilLegalEvent := LEFT.busCivilLegalEvent;
                                  SELF.busCivilLegalEvent_Flag := LEFT.busCivilLegalEvent_Flag;
                                  SELF.busCivilLegalEventFilingAmt := LEFT.busCivilLegalEventFilingAmt;
                                  SELF.busCivilLegalEventFilingAmt_Flag := LEFT.busCivilLegalEventFilingAmt_Flag;
                                  SELF.busOffenseType := LEFT.busOffenseType;
                                  SELF.busOffenseType_Flag := LEFT.busOffenseType_Flag;
                                  SELF.busStateLegalEvent := LEFT.busStateLegalEvent;
                                  SELF.busStateLegalEvent_Flag := LEFT.busStateLegalEvent_Flag;

                                  SELF.legalReportIncluded := includeReportData; //only included if the flag is set and module attributes selected
                                  SELF.report.businessReport := RIGHT.businessReport;

                                  SELF := [];),
                        LEFT OUTER,
                        ATMOST(1));



    // OUTPUT(uniqueBEOs, NAMED('uniqueBEOs'));
    // OUTPUT(rawLegalResults, NAMED('rawLegalResults'));

    // OUTPUT(uniqueBusinesses, NAMED('uniqueBusinesses'));
    // OUTPUT(rawCivilResults, NAMED('rawCivilResults'));

    // OUTPUT(offenseType, NAMED('offenseType'));
    // OUTPUT(stateLegalEvent, NAMED('stateLegalEvent'));
    // OUTPUT(civilLegalEvent, NAMED('civilLegalEvent'));
    // OUTPUT(legalAttributes, NAMED('legalAttributes'));

    // OUTPUT(legalReport, NAMED('legalReport'));
    // OUTPUT(finalLegal, NAMED('finalLegal'));


    RETURN finalLegal;
END;

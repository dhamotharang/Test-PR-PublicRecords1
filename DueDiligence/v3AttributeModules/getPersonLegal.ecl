IMPORT DueDiligence;


EXPORT getPersonLegal(DATASET(DueDiligence.v3Layouts.Internal.PersonTemp) inData, 
                      DueDiligence.DDInterface.iDDv3PersonAttributes attributesRequested,
                      DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess,
                      DueDiligence.DDInterface.iDDPersonOptions ddOptions) := FUNCTION


    //get all unique people for all relationships that are populated
    unqiuePeople := DueDiligence.v3Common.DDPerson.GetRelationships(inData, TRUE, 'ALL');
    uniqueInquired := DueDiligence.v3Common.DDPerson.GetRelationships(inData, TRUE, DueDiligence.Constants.INQUIRED_INDIVIDUAL);
    
    //get legal data for all unique individuals
    rawLegalResults := DueDiligence.v3SharedData.getCriminalData(unqiuePeople);
    rawCivilResults := DueDiligence.v3PersonData.getLienJundgementEviction(uniqueInquired, regulatoryAccess, ddOptions.ssnMask);
    rawBankruptcyResults := DueDiligence.v3PersonData.getBankruptcy(uniqueInquired);
    
    //based on the legal data - populate requested attributes
    noAttributeResults := DATASET([], DueDiligence.v3Layouts.InternalPerson.PersonAttributes);
    
    offenseTypeAttributeResults := DueDiligence.v3PersonAttributes.getOffenseType(unqiuePeople, rawLegalResults);
    stateLegalEventAttributeResults := DueDiligence.v3PersonAttributes.getStateLegalEvent(unqiuePeople, rawLegalResults);
    civilLegalEventAttributeResults := DueDiligence.v3PersonAttributes.getCivilLegalEvent(inData, rawCivilResults, rawBankruptcyResults);
    civilLegalEventFilingAmtAttributeResults := DueDiligence.v3PersonAttributes.getCivilLegalEventFilingAmt(inData, rawCivilResults);
    
    
    offenseType := IF(attributesRequested.includeAll OR attributesRequested.includeOffenseType, offenseTypeAttributeResults, noAttributeResults);
    stateLegalEvent := IF(attributesRequested.includeAll OR attributesRequested.includeStateLegalEvent, stateLegalEventAttributeResults, noAttributeResults);
    civilLegalEvent := IF(attributesRequested.includeAll OR attributesRequested.includeCivilLegalEvent, civilLegalEventAttributeResults, noAttributeResults);
    civilLegalEventFilingAmt := IF(attributesRequested.includeAll OR attributesRequested.includeCivilLegalEventFilingAmount, civilLegalEventFilingAmtAttributeResults, noAttributeResults);

   
    //add all the attributes together to get all necessary legal attributes
    legalAttributes := ROLLUP(SORT(offenseType + stateLegalEvent + civilLegalEvent + civilLegalEventFilingAmt, lexID),
                              LEFT.lexID = RIGHT.lexID,
                              TRANSFORM(DueDiligence.v3Layouts.InternalPerson.PersonAttributes,
                                        SELF.lexID := LEFT.lexID;
                                        
                                        SELF.perCivilLegalEvent := DueDiligence.v3Common.General.FirstPopulatedString(perCivilLegalEvent);
                                        SELF.perCivilLegalEvent_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perCivilLegalEvent_Flag);
                                        
                                        SELF.perCivilLegalEventFilingAmt := DueDiligence.v3Common.General.FirstPopulatedString(perCivilLegalEventFilingAmt);
                                        SELF.perCivilLegalEventFilingAmt_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perCivilLegalEventFilingAmt_Flag);
                                        
                                        SELF.perOffenseType := DueDiligence.v3Common.General.FirstPopulatedString(perOffenseType);
                                        SELF.perOffenseType_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perOffenseType_Flag);
                                        
                                        SELF.perStateLegalEvent := DueDiligence.v3Common.General.FirstPopulatedString(perStateLegalEvent);
                                        SELF.perStateLegalEvent_Flag := DueDiligence.v3Common.General.FirstPopulatedString(perStateLegalEvent_Flag);
                                        
                                        SELF := LEFT;));
                                        

    //get the inquired's attributes
    inquiredAttributes := JOIN(inData, legalAttributes,
                                LEFT.inquiredDID = RIGHT.lexID,
                                TRANSFORM(DueDiligence.v3Layouts.InternalPerson.PersonAttributes,
                                          SELF.seq := LEFT.seq;
                                          SELF.lexID := LEFT.inquiredDID;
                                          SELF := RIGHT;),
                                LEFT OUTER,
                                ATMOST(1));
                                            
                                            
                                            
       
    //based on request - populate the reports of the legal section
    noLegalReportData := DATASET([], DueDiligence.v3Layouts.InternalPerson.PersonReport);
    legalReportData := DueDiligence.v3PersonReport.getLegal(inData, ddOptions.ssnMask, rawLegalResults, rawCivilResults);
                                            
    legalReport := IF(ddOptions.includeReportData AND
                      (attributesRequested.includeAll OR 
                      (attributesRequested.includeOffenseType AND
                      attributesRequested.includeStateLegalEvent AND
                      attributesRequested.includeCivilLegalEvent AND
                      attributesRequested.includeCivilLegalEventFilingAmount)), legalReportData, noLegalReportData);
    
    
    //join the attributes and report data together
    finalLegal := JOIN(inquiredAttributes, legalReport,
                       LEFT.lexID = RIGHT.lexID,
                       TRANSFORM(DueDiligence.v3Layouts.InternalPerson.PersonResults,
                                  SELF.seq := LEFT.seq;
                                  SELF.lexID := LEFT.lexID;
                                  
                                  SELF.perCivilLegalEvent := LEFT.perCivilLegalEvent;
                                  SELF.perCivilLegalEvent_Flag := LEFT.perCivilLegalEvent_Flag;
                                  SELF.perCivilLegalEventFilingAmt := LEFT.perCivilLegalEventFilingAmt;
                                  SELF.perCivilLegalEventFilingAmt_Flag := LEFT.perCivilLegalEventFilingAmt_Flag;
                                  SELF.perOffenseType := LEFT.perOffenseType;
                                  SELF.perOffenseType_Flag := LEFT.perOffenseType_Flag;
                                  SELF.perStateLegalEvent := LEFT.perStateLegalEvent;
                                  SELF.perStateLegalEvent_Flag := LEFT.perStateLegalEvent_Flag;
                                  
                                  SELF.legalReportIncluded := ddOptions.includeReportData; //only included if the flag is set
                                  SELF.personReport := RIGHT.personReport;
                                  SELF := [];),
                       LEFT OUTER,
                       ATMOST(1));
                                            
                                            
                                            
    
    
    // OUTPUT(inData, NAMED('inData'));
    // OUTPUT(unqiuePeople, NAMED('unqiuePeople'));
    // OUTPUT(rawLegalResults, NAMED('rawLegalResults'));
    // OUTPUT(offenseType, NAMED('legaloffenseType'));
    // OUTPUT(stateLegalEvent, NAMED('stateLegalEvent'));
    // OUTPUT(civilLegalEvent, NAMED('civilLegalEvent'));
    // OUTPUT(legalAttributes, NAMED('legalAttributes'));
    // OUTPUT(inquiredAttributes, NAMED('inquiredAttributes'));
    
    // OUTPUT(legalReportData, NAMED('legalReportData'));
    // OUTPUT(legalReport, NAMED('legalReport'));
    // OUTPUT(finalLegal, NAMED('finalLegal'));


    RETURN finalLegal;
END;
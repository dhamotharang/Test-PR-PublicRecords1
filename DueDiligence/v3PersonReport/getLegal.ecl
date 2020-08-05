IMPORT DueDiligence, iesp, Suppress;


EXPORT getLegal(DATASET(DueDiligence.v3Layouts.Internal.PersonTemp) inData, 
                STRING10 ssnMask,
                DATASET(DueDiligence.v3Layouts.InternalPersonLegal.FinalCrimData) rawCrimData,
                DATASET(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions) rawLJE):= FUNCTION


    //convert person input to shared layout - just need all inquired's seq and lexIDs
    sharedLegalReportInput := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalShared.ReportSharedLegal,
                                                        SELF.seq := LEFT.seq;
                                                        SELF.did := LEFT.inquiredDID;
                                                        SELF := [];));


    //get shared report data
    sharedLegalReport := DueDiligence.v3SharedReport.getSharedLegal(sharedLegalReportInput, rawCrimData, rawLJE);


    //mask ssn for the report    
    Suppress.MAC_Mask(inData, maskedInquired, inquired.ssn, '', TRUE, FALSE,,,, ssnMask);

    legalReportSections := JOIN(maskedInquired, sharedLegalReport,
                                LEFT.inquiredDID = RIGHT.did,
                                TRANSFORM(DueDiligence.v3Layouts.InternalPerson.PersonReport,
                                          SELF.lexID := LEFT.inquiredDID;
                                          SELF.personReport.personAttributeDetails.legal.possibleLiensJudgmentsEvictions := RIGHT.liensJudgementsEvictions;
                                          
                                          personInfo := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRLegalEventIndividual,
                                                                            SELF.lexID := (STRING)LEFT.inquiredDID;
                                                                            SELF.ssn := LEFT.inquired.ssn;
                                                                            SELF.dob := iesp.ECL2ESP.toDate(LEFT.inquired.dob);
                                                                            SELF.name := iesp.ECL2ESP.SetName(LEFT.inquired.firstName, LEFT.inquired.middleName, 
                                                                                                              LEFT.inquired.lastName, LEFT.inquired.suffix, 
                                                                                                              DueDiligence.Constants.EMPTY, LEFT.inquired.fullName);
                                                                                                              
                                                                            SELF.address := iesp.ECL2ESP.SetAddress(LEFT.inquired.prim_name, LEFT.inquired.prim_range, LEFT.inquired.predir,
                                                                                                                    LEFT.inquired.postdir, LEFT.inquired.addr_suffix, LEFT.inquired.unit_desig,
                                                                                                                    LEFT.inquired.sec_range, LEFT.inquired.city, LEFT.inquired.state, LEFT.inquired.zip,
                                                                                                                    LEFT.inquired.zip4, LEFT.inquired.county, DueDiligence.Constants.EMPTY, LEFT.inquired.streetAddress1);
                                                                            SELF := [];)])[1];
                                                                            
                                          crimEvents := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonCriminalEvents,
                                                                           SELF.personInfo := IF(COUNT(RIGHT.criminals) > 0, personInfo);
                                                                           SELF.criminals := RIGHT.criminals;
                                                                           SELF := [];)]);
                                          
                                          SELF.personReport.personAttributeDetails.legal.possibleLegalEvents := crimEvents;
                                          SELF := [];),
                                LEFT OUTER,
                                ATMOST(1));








    // OUTPUT(sharedLegalReportInput, NAMED('sharedLegalReportInput'));
    // OUTPUT(sharedLegalReport, NAMED('sharedLegalReport'));
    // OUTPUT(maskedInquired, NAMED('maskedInquired'));
    // OUTPUT(legalReportSections, NAMED('legalReportSections'));


    RETURN legalReportSections;
END;
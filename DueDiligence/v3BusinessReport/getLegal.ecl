IMPORT DueDiligence, iesp, Suppress;


EXPORT getLegal(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                DATASET(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions) rawLJE):= FUNCTION


        
    //grab business data that way we can pick up the civil info (as criminal is by person and civil is by business)
    justBus := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalShared.ReportSharedLegal,
                                          SELF.seq := LEFT.seq;
                                          SELF.ultID := LEFT.inquiredBusiness.ultID;
                                          SELF.orgID := LEFT.inquiredBusiness.orgID;
                                          SELF.seleID := LEFT.inquiredBusiness.seleID;
                                          SELF := [];));
                                                            
                                                            


    //get shared report data
    sharedLegalReport := DueDiligence.v3SharedReport.getSharedLegal(justBus, DATASET([], DueDiligence.v3Layouts.InternalPersonLegal.FinalCrimData), rawLJE);
    
    
    legalReportSection := JOIN(inData, sharedLegalReport(did = 0),
                                LEFT.seq = RIGHT.seq AND
                                LEFT.inquiredBusiness.ultID = RIGHT.ultID AND
                                LEFT.inquiredBusiness.orgID = RIGHT.orgID AND
                                LEFT.inquiredBusiness.seleID = RIGHT.seleID,
                                TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessReport,
                                          SELF.seq := LEFT.seq;
                                          SELF.ultID := LEFT.inquiredBusiness.ultID;
                                          SELF.orgID := LEFT.inquiredBusiness.orgID;
                                          SELF.seleID := LEFT.inquiredBusiness.seleID;
                                          
                                          SELF.businessReport.businessAttributeDetails.legal.possibleLiensJudgmentsEvictions := RIGHT.liensJudgementsEvictions;
                                          SELF.businessReport.businessAttributeDetails.legal.possibleLegalEvents := LEFT.beoCrimReport;
                                          
                                          SELF := [];),
                                LEFT OUTER,
                                ATMOST(1));

    
    // OUTPUT(beoData, NAMED('beoData'));
    // OUTPUT(busWithBEOs, NAMED('busWithBEOs'));
    // OUTPUT(justBus, NAMED('justBus'));
    
    // OUTPUT(sharedLegalReport, NAMED('sharedLegalReport'));
    // OUTPUT(legalReportSection, NAMED('legalReportSection'));
 

    RETURN legalReportSection;
END;
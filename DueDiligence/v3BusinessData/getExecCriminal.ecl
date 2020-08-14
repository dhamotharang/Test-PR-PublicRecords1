IMPORT DueDiligence, iesp, Suppress;


EXPORT getExecCriminal(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                       DueDiligence.DDInterface.iDDv3BusinessAttributes attributesRequested,
                       DueDiligence.DDInterface.iDDBusinessOptions ddOptions) := FUNCTION
    
    //get all unique people for all the BEOs with LexIDs
    uniqueBEOs := DueDiligence.v3Common.DDBusiness.GetBEOAsSlimPerson(inData, TRUE);
    
    //get legal data for all unique individuals
    rawLegalResults := DueDiligence.v3SharedData.getCriminalData(uniqueBEOs);
    
    //get all lexID BEOs tied to their respective businesses
    allLexIDBEOs := DueDiligence.v3Common.DDBusiness.GetBEOBusiness(inData);
    
    
    allBEOs := NORMALIZE(inData, LEFT.beos, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails,
                                                      SELF.seq := LEFT.seq;
                                                      SELF.ultID := LEFT.inquiredBusiness.ultID;
                                                      SELF.orgID := LEFT.inquiredBusiness.orgID;
                                                      SELF.seleID := LEFT.inquiredBusiness.seleID;
                                                      SELF := RIGHT;
                                                      SELF := [];));
                                                      
                                                      
    //determine which attribute(s) need to be called
    networkReport := ddOptions.includeReportData AND
                     (attributesRequested.includeAll OR
                     (attributesRequested.includeBEOProfLicense AND attributesRequested.includeBEOUSResidency));// AND 
                     // attributesRequested.includeBEOAccessToFundsProperty AND attributesRequested.includeLinkedBusinesses)); //UNCOMMENT ONCE CODED
    
    offenseTypeAttr := attributesRequested.includeAll OR attributesRequested.includeOffenseType;
    stateLegalEventAttr := attributesRequested.includeAll OR attributesRequested.includeStateLegalEvent;

    
    
    
    
    //offense type
    beoOffenseTypeResults := IF(networkReport OR offenseTypeAttr, 
                                DueDiligence.v3PersonAttributes.getOffenseType(uniqueBEOs, rawLegalResults),
                                DATASET([], DueDiligence.v3Layouts.InternalPerson.PersonAttributes));
    
    
    beoOffenseType := JOIN(allBEOs, beoOffenseTypeResults,
                            LEFT.lexID = RIGHT.lexID,
                            TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails,
                                      SELF.offenseType := RIGHT.perOffenseType;
                                      SELF.offenseTypeFlag := RIGHT.perOffenseType_Flag;
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(DueDiligence.Constants.MAX_1000));
    
    
    //state legal events
    beoSLEResults := IF(networkReport OR stateLegalEventAttr, 
                        DueDiligence.v3PersonAttributes.getStateLegalEvent(uniqueBEOs, rawLegalResults),
                        DATASET([], DueDiligence.v3Layouts.InternalPerson.PersonAttributes));
    
    beoSLEType := JOIN(beoOffenseType, beoSLEResults,
                        LEFT.lexID = RIGHT.lexID,
                        TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                  SELF.seq := LEFT.seq;
                                  SELF.inquiredBusiness.ultID := LEFT.ultID;
                                  SELF.inquiredBusiness.orgID := LEFT.orgID;
                                  SELF.inquiredBusiness.seleID := LEFT.seleID;
                                  
                                  SELF.beos := DATASET([TRANSFORM(DueDiligence.v3Layouts.Internal.SlimExec,
                                                        SELF.stateLegalEvents := RIGHT.perStateLegalEvent;
                                                        SELF.stateLegalEventsFlag := RIGHT.perStateLegalEvent_Flag;
                                                        SELF := LEFT;
                                                        SELF := [];)]);
                                  
                                  SELF := LEFT;
                                  SELF := [];),
                        LEFT OUTER);
                        
    //rollup the BEOs to the business to be re-added
    rollBEOs := ROLLUP(SORT(beoSLEType, seq, inquiredBusiness.ultID, inquiredBusiness.orgID, inquiredBusiness.seleID),
                        LEFT.seq = RIGHT.seq AND
                        LEFT.inquiredBusiness.ultID = RIGHT.inquiredBusiness.ultID AND
                        LEFT.inquiredBusiness.orgID = RIGHT.inquiredBusiness.orgID AND
                        LEFT.inquiredBusiness.seleID = RIGHT.inquiredBusiness.seleID,
                        TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                  SELF.beos := LEFT.beos + RIGHT.beos;
                                  SELF := LEFT;));
                                  
    
    //replace the BEOs
    updateBEOs := JOIN(inData, rollBEOs,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.inquiredBusiness.ultID = RIGHT.inquiredBusiness.ultID AND
                        LEFT.inquiredBusiness.orgID = RIGHT.inquiredBusiness.orgID AND
                        LEFT.inquiredBusiness.seleID = RIGHT.inquiredBusiness.seleID,
                        TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                  SELF.beos := RIGHT.beos;
                                  SELF := LEFT;),
                        LEFT OUTER,
                        ATMOST(1));
                                  
                                  
                                  
    //only populating report sections when all attribute modules are requested
    populateCrimReport := ddOptions.includeReportData AND
                          (attributesRequested.includeAll OR 
                          (attributesRequested.includeStateLegalEvent AND attributesRequested.includeOffenseType AND attributesRequested.includeCivilLegalEvent));
    
    beoExecWithLexID := allBEOs(lexID > 0);
    
    
    //convert beo input to shared layout - just need all beo's seq and lexIDs and business associated with
    busWithBEOs := PROJECT(beoExecWithLexID, TRANSFORM(DueDiligence.v3Layouts.InternalShared.ReportSharedLegal,
                                                        SELF.seq := LEFT.seq;
                                                        SELF.ultID := LEFT.ultID;
                                                        SELF.orgID := LEFT.orgID;
                                                        SELF.seleID := LEFT.seleID;
                                                        SELF.did := LEFT.lexID;
                                                        SELF := [];));
    
                                                           


    //get shared report data
    sharedLegalReport := IF(populateCrimReport,
                            DueDiligence.v3SharedReport.getSharedLegal(busWithBEOs, rawLegalResults, DATASET([],DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions)),
                            DATASET([], DueDiligence.v3Layouts.InternalShared.ReportSharedLegal));
    
    //mask ssn for the report 
    Suppress.MAC_Mask(beoExecWithLexID, maskedBEOs, ssn, '', TRUE, FALSE,,,, ddOptions.ssnMask);
   
    
    crimReportSection := JOIN(maskedBEOs, sharedLegalReport,
                              LEFT.lexID = RIGHT.did,
                              TRANSFORM({DueDiligence.v3Layouts.InternalShared.InternalIDs, DATASET(iesp.duediligencebusinessreport.t_DDRBusinessExecutiveCriminalEvents) beoCrimData},
                                        SELF.seq := LEFT.seq;
                                        SELF.ultID := LEFT.ultID;
                                        SELF.orgID := LEFT.orgID;
                                        SELF.seleID := LEFT.seleID;
                                        SELF.did := LEFT.lexID;
                                        
                                        beoInfo := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRLegalEventIndividual,
                                                                      SELF.lexID := (STRING)LEFT.lexID;
                                                                      SELF.ssn := LEFT.ssn;
                                                                      SELF.dob := iesp.ECL2ESP.toDate(LEFT.dob);
                                                                      SELF.name := iesp.ECL2ESP.SetName(LEFT.firstName, LEFT.middleName, 
                                                                                                        LEFT.lastName, LEFT.suffix, 
                                                                                                        DueDiligence.Constants.EMPTY, LEFT.fullName);
                                                                                                        
                                                                      SELF.address := iesp.ECL2ESP.SetAddress(LEFT.prim_name, LEFT.prim_range, LEFT.predir,
                                                                                                              LEFT.postdir, LEFT.addr_suffix, LEFT.unit_desig,
                                                                                                              LEFT.sec_range, LEFT.city, LEFT.state, LEFT.zip,
                                                                                                              LEFT.zip4, LEFT.county, DueDiligence.Constants.EMPTY, LEFT.streetAddress1);
                                                                      SELF := [];)])[1];
                                                                          
                                        SELF.beoCrimData := DATASET([TRANSFORM(iesp.duediligencebusinessreport.t_DDRBusinessExecutiveCriminalEvents,
                                                                               SELF.executiveOfficer := IF(COUNT(RIGHT.criminals) > 0, beoInfo);
                                                                               SELF.criminals := RIGHT.criminals;
                                                                               SELF.execTitle := LEFT.titles[1].title;
                                                                               SELF := [];)]);
                                        
                                        SELF := [];));

    rollCrimSection := ROLLUP(SORT(crimReportSection, seq, ultID, orgID, seleID),
                              LEFT.seq = RIGHT.seq AND
                              LEFT.ultID = RIGHT.ultID AND
                              LEFT.orgID = RIGHT.orgID AND
                              LEFT.seleID = RIGHT.seleID,
                              TRANSFORM({DueDiligence.v3Layouts.InternalShared.InternalIDs, DATASET(iesp.duediligencebusinessreport.t_DDRBusinessExecutiveCriminalEvents) beoCrimData},
                                        SELF.beoCrimData := LEFT.beoCrimData + RIGHT.beoCrimData;
                                        SELF := LEFT;));



    addAllLegal := JOIN(updateBEOs, rollCrimSection,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.inquiredBusiness.ultID = RIGHT.ultID AND
                        LEFT.inquiredBusiness.orgID = RIGHT.orgID AND
                        LEFT.inquiredBusiness.seleID = RIGHT.seleID,
                        TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                  
                                  SELF.beoCrimReport := RIGHT.beoCrimData;
                                  
                                  SELF := LEFT;),
                        LEFT OUTER,
                        ATMOST(1));
    
    
    
    // OUTPUT(inData, NAMED('execCrim_busTemp'));
    // OUTPUT(uniqueBEOs, NAMED('uniqueBEOs'));
    // OUTPUT(rawLegalResults, NAMED('rawLegalResults'));
    // OUTPUT(allLexIDBEOs, NAMED('allLexIDBEOs'));
    // OUTPUT(allBEOs, NAMED('allBEOs'));
    
    // OUTPUT(beoOffenseTypeResults, NAMED('beoOffenseTypeResults'));
    // OUTPUT(beoOffenseType, NAMED('beoOffenseType'));
    // OUTPUT(beoSLEResults, NAMED('beoSLEResults'));
    // OUTPUT(beoSLEType, NAMED('beoSLEType'));
    
    // OUTPUT(rollBEOs, NAMED('rollBEOs'));
    // OUTPUT(updateBEOs, NAMED('updateBEOs'));
    
    // OUTPUT(busWithBEOs, NAMED('busWithBEOs'));
    // OUTPUT(sharedLegalReport, NAMED('sharedLegalReport'));
    // OUTPUT(maskedBEOs, NAMED('maskedBEOs'));
    // OUTPUT(crimReportSection, NAMED('crimReportSection'));
    // OUTPUT(rollCrimSection, NAMED('rollCrimSection'));
    // OUTPUT(addAllLegal, NAMED('addAllLegal'));
    
    
    RETURN addAllLegal;
END;
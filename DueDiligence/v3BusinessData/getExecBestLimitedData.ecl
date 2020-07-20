IMPORT DueDiligence, iesp;


EXPORT getExecBestLimitedData(DATASET(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails) inData,
                              DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION
    
    //limit the number of execs to max allowed per business
    didlessExecs := DEDUP(SORT(inData(lexID = 0), seq, ultID, orgID, seleID, lastName, firstName, suffix), seq, ultID, seleID, lastName, firstName, suffix);
    execs := DEDUP(SORT(inData(lexID > 0), seq, ultID, orgID, seleID, lexID), seq, ultID, seleID, lexID);
    
    //all unique BEOs
    allUniqueBEOs := GROUP(SORT(didlessExecs + execs, seq, ultID, orgID, seleID, -lexID, -lastSeen, lastName, firstName, suffix), seq, ultID, orgID, seleID);
    
    maxBEOs := DueDiligence.v3Common.General.GetMaxNumberOfRecords(allUniqueBEOs, iesp.Constants.DDRAttributesConst.MaxBusinessExecs);

   
    //grab the best data for those that have lexIDs
    bestBEOData := DueDiligence.v3PersonData.getBestData(regulatoryAccess);
    
    transBEOLexID := PROJECT(maxBEOs(lexID > 0), TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimBestSearch,
                                                            SELF.lexID := LEFT.lexID;
                                                            SELF.historyDate := LEFT.historyDate;
                                                            SELF := [];));
                                                            
    uniqueBestBEOs := DEDUP(SORT(transBEOLexID, lexID), lexID);
    
    beoBest := bestBEOData.GetIndividualBestDataWithLexID(uniqueBestBEOs);
    
    mostRecentBEODataByLexID := DEDUP(SORT(inData(lexID > 0), lexID, -lastSeen, lastName, -firstName, -middleName, -suffix), lexID);
    
    //only get the data from the limited BEOs and replace name of the lexID to be best so they are the same
    beoWithBestData := JOIN(inData(lexID > 0), beoBest,
                            LEFT.lexID = RIGHT.lexID,
                            TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails,
                                       SELF.seq := LEFT.seq;
                                       SELF.ultID := LEFT.ultID;
                                       SELF.orgID := LEFT.orgID;
                                       SELF.seleID := LEFT.seleID;
                                       SELF.lexID := LEFT.lexID;
                                       
                                       useBestInfo := RIGHT.lexID > 0;
                                       recentBEOInfo := mostRecentBEODataByLexID(lexID = LEFT.lexID);
                                       
                                       SELF.firstName := IF(useBestInfo, RIGHT.firstName, recentBEOInfo[1].firstName);
                                       SELF.middleName := IF(useBestInfo, RIGHT.middleName, recentBEOInfo[1].middleName);
                                       SELF.lastName := IF(useBestInfo, RIGHT.lastName, recentBEOInfo[1].lastName);
                                       SELF.suffix := IF(useBestInfo, RIGHT.suffix, recentBEOInfo[1].suffix);
                                       SELF.fullName := IF(useBestInfo, RIGHT.fullName, recentBEOInfo[1].fullName);
                                       
                                       SELF.dob := RIGHT.dob;
                                       SELF.ssn := RIGHT.ssn;
                                       
                                       SELF.streetAddress1 := RIGHT.streetAddress1;
                                       SELF.streetAddress2 := RIGHT.streetAddress2;
                                       SELF.prim_range := RIGHT.prim_range;
                                       SELF.predir := RIGHT.predir;
                                       SELF.prim_name := RIGHT.prim_name;
                                       SELF.addr_suffix := RIGHT.addr_suffix;
                                       SELF.postdir := RIGHT.postdir;
                                       SELF.unit_desig := RIGHT.unit_desig;
                                       SELF.sec_range := RIGHT.sec_range;
                                       
                                       SELF.city := RIGHT.city;
                                       SELF.state := RIGHT.state;
                                       SELF.zip := RIGHT.zip;
                                       SELF.zip4 := RIGHT.zip4;
                                       SELF.geo_blk := RIGHT.geo_blk;
                                       SELF.county := RIGHT.county;
                                       
                                       SELF := LEFT;
                                       SELF := [];),
                            LEFT OUTER,
                            ATMOST(1));
                                       
    beoWithName := JOIN(inData(lexID = 0), maxBEOs(lexID = 0),
                        LEFT.seq = RIGHT.seq AND
                        LEFT.ultID = RIGHT.ultID AND
                        LEFT.orgID = RIGHT.orgID AND
                        LEFT.seleID = RIGHT.seleID AND
                        LEFT.lastName = RIGHT.lastName AND
                        LEFT.firstName = RIGHT.firstName AND
                        LEFT.suffix = RIGHT.suffix,
                        TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails,
                                  SELF := LEFT;));
    
    
    allBEOsData := beoWithBestData + beoWithName;
    
    
    
    // OUTPUT(didlessExecs, NAMED('didlessExecs'));
    // OUTPUT(execs, NAMED('execs'));
    // OUTPUT(allUniqueBEOs, NAMED('allUniqueBEOs'));
    // OUTPUT(maxBEOs, NAMED('maxBEOs'));
    
    // OUTPUT(beoBest, NAMED('beoBest'));
    // OUTPUT(mostRecentBEODataByLexID, NAMED('mostRecentBEODataByLexID'));
    // OUTPUT(beoWithBestData, NAMED('beoWithBestData'));
    // OUTPUT(beoWithName, NAMED('beoWithName'));
    // OUTPUT(allBEOsData, NAMED('allBEOsData'));
    

    RETURN allBEOsData;
END;
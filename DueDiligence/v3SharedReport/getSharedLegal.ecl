IMPORT DueDiligence, iesp;


EXPORT getSharedLegal(DATASET(DueDiligence.v3Layouts.InternalShared.ReportSharedLegal) inData,
                      DATASET(DueDiligence.v3Layouts.InternalPersonLegal.FinalCrimData) rawCrimData,
                      DATASET(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions) rawLJE) := FUNCTION
    
    

    transformCrimData := PROJECT(rawCrimData, TRANSFORM(DueDiligence.v3Layouts.InternalShared.ReportSharedLegal,
                                                        SELF.did := LEFT.did;
                                                        SELF.criminals := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRLegalStateCriminal, SELF := LEFT;)]);
                                                        SELF := [];));
    
    //this is on a per person basis
    rollCrimByPerson := ROLLUP(SORT(transformCrimData, did),
                               LEFT.did = RIGHT.did,
                               TRANSFORM(DueDiligence.v3Layouts.InternalShared.ReportSharedLegal,
                                         SELF.criminals := LEFT.criminals + RIGHT.criminals;
                                         SELF := LEFT;));
    
    //inner join because we only care about those individuals who have criminal records
    addCrim := JOIN(inData, rollCrimByPerson,
                    LEFT.did = RIGHT.did,
                    TRANSFORM(DueDiligence.v3Layouts.InternalShared.ReportSharedLegal,
                              SELF.seq := LEFT.seq;
                              SELF.ultID := LEFT.ultID;
                              SELF.orgID := LEFT.orgID;
                              SELF.seleID := LEFT.seleID;
                              SELF.did := LEFT.did;
                              SELF.criminals := RIGHT.criminals;
                              SELF := [];));
                                         
                                         
    transformLJEData := PROJECT(rawLJE, TRANSFORM(DueDiligence.v3Layouts.InternalShared.ReportSharedLegal,
                                                  SELF.ultID := LEFT.ultID;
                                                  SELF.orgID := LEFT.orgID;
                                                  SELF.seleID := LEFT.seleID;
                                                  SELF.did := LEFT.did;
                                                  SELF.liensJudgementsEvictions := DATASET([TRANSFORM(iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions, SELF := LEFT.espDetails;)]);
                                                  SELF := [];));
                                                  
    rollLJEByEntity := ROLLUP(SORT(transformLJEData, seq, ultID, orgID, seleID, did),
                              LEFT.ultID = RIGHT.ultID AND
                              LEFT.orgID = RIGHT.orgID AND
                              LEFT.seleID = RIGHT.seleID AND
                              LEFT.did = RIGHT.did,
                              TRANSFORM(DueDiligence.v3Layouts.InternalShared.ReportSharedLegal,
                                        SELF.liensJudgementsEvictions := LEFT.liensJudgementsEvictions + RIGHT.liensJudgementsEvictions;
                                        SELF := LEFT;));
      
    //process as an inner join as we only care about entities that have civil events  
    addLJE := JOIN(inData, rollLJEByEntity,
                    LEFT.ultID = RIGHT.ultID AND
                    LEFT.orgID = RIGHT.orgID AND
                    LEFT.seleID = RIGHT.seleID AND
                    LEFT.did = RIGHT.did,
                    TRANSFORM(DueDiligence.v3Layouts.InternalShared.ReportSharedLegal,
                              SELF.seq := LEFT.seq;
                              SELF.ultID := LEFT.ultID;
                              SELF.orgID := LEFT.orgID;
                              SELF.seleID := LEFT.seleID;
                              SELF.did := LEFT.did;
                              SELF.liensJudgementsEvictions := RIGHT.liensJudgementsEvictions;
                              SELF := [];));
    
   
   
    //get the requested sections of the report
    allSharedLegalReport := ROLLUP(SORT(addCrim + addLJE, seq, ultID, orgID, seleID, did),
                                    LEFT.seq = RIGHT.seq AND
                                    LEFT.ultID = RIGHT.ultID AND
                                    LEFT.orgID = RIGHT.orgID AND
                                    LEFT.seleID = RIGHT.seleID AND
                                    LEFT.did = RIGHT.did,
                                    TRANSFORM(DueDiligence.v3Layouts.InternalShared.ReportSharedLegal,
                                              SELF.criminals := LEFT.criminals + RIGHT.criminals;
                                              SELF.liensJudgementsEvictions := LEFT.liensJudgementsEvictions + RIGHT.liensJudgementsEvictions;
                                              SELF := LEFT;));
    






    // OUTPUT(rawCrimData, NAMED('rawCrimData'));
    // OUTPUT(transformCrimData, NAMED('transformCrimData'));
    // OUTPUT(rollCrimByPerson, NAMED('rollCrimByPerson'));
    // OUTPUT(addCrim, NAMED('addCrim'));
    
    // OUTPUT(transformLJEData, NAMED('transformLJEData'));
    // OUTPUT(rollLJEByEntity, NAMED('rollLJEByEntity'));
    // OUTPUT(addLJE, NAMED('addLJE'));
    
    // OUTPUT(allSharedLegalReport, NAMED('allSharedLegalReport'));
    
    
    
    RETURN allSharedLegalReport;
END;
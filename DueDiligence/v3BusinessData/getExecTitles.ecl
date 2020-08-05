IMPORT DueDiligence, iesp;


EXPORT getExecTitles(DATASET(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails) inData) := FUNCTION

    //sort all beos most recent and title
    sortExecs := SORT(inData, seq, ultID, orgID, seleID, lexID, lastName, firstName, suffix, title, firstSeen, lastSeen, -isOwnershipProng);
    
    uniqueExecTitles := ROLLUP(sortExecs,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.ultID = RIGHT.ultID AND
                                LEFT.orgID = RIGHT.orgID AND
                                LEFT.seleID = RIGHT.seleID AND
                                LEFT.lexID = RIGHT.lexID AND
                                LEFT.lastName = RIGHT.lastName AND
                                LEFT.firstName = RIGHT.firstName AND
                                LEFT.suffix = RIGHT.suffix AND
                                LEFT.title = RIGHT.title,
                                TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails,
                                          SELF.lastSeen := MAX(LEFT.lastSeen, RIGHT.lastSeen);
                                          SELF.firstSeen := IF(LEFT.firstSeen = 0, MAX(LEFT.firstSeen, RIGHT.firstSeen), MIN(LEFT.firstSeen, RIGHT.firstSeen));
                                          SELF.isOwnershipProng := LEFT.isOwnershipProng OR RIGHT.isOwnershipProng;
                                          SELF.isControlProng := LEFT.isControlProng OR RIGHT.isControlProng;
                                          SELF := LEFT;));


    
    grpTitles := GROUP(SORT(uniqueExecTitles, seq, ultID, orgID, seleID, lexID, lastName, firstName, suffix, -lastSeen, firstSeen), seq, ultID, orgID, seleID, lexID, lastName, firstName, suffix);
    maxTitles := DueDiligence.v3Common.General.GetMaxNumberOfRecords(grpTitles, iesp.Constants.DDRAttributesConst.MaxTitles);

    
    addAllTitles := PROJECT(maxTitles, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails,
                                                  SELF.titles := DATASET([TRANSFORM(DueDiligence.v3Layouts.Internal.beoTitles,
                                                                            SELF.title := LEFT.title;
                                                                            SELF.firstSeen := LEFT.firstSeen;
                                                                            SELF.lastSeen := LEFT.lastSeen;
                                                                            SELF := [];)]);
                                                  
                                                  SELF := LEFT;));
                                                  
    rollTitles := ROLLUP(SORT(addAllTitles, seq, ultID, orgID, seleID, lexID, lastName, firstName, suffix, -lastSeen -firstSeen, title),
                          LEFT.seq = RIGHT.seq AND
                          LEFT.ultID = RIGHT.ultID AND
                          LEFT.orgID = RIGHT.orgID AND
                          LEFT.seleID = RIGHT.seleID AND
                          LEFT.lexID = RIGHT.lexID AND
                          LEFT.lastName = RIGHT.lastName AND
                          LEFT.firstName = RIGHT.firstName AND
                          LEFT.suffix = RIGHT.suffix,
                          TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails,
                                    
                                    SELF.titles := LEFT.titles + RIGHT.titles;
                                    
                                    SELF.isOwnershipProng := LEFT.isOwnershipProng OR RIGHT.isOwnershipProng;
                                    SELF.isControlProng := LEFT.isControlProng OR RIGHT.isControlProng;
                                    SELF := LEFT;));

                      


    // OUTPUT(sortExecs, NAMED('sortExecs'));
    // OUTPUT(uniqueExecTitles, NAMED('uniqueExecTitles'));
    // OUTPUT(maxTitles, NAMED('maxTitles'));
    // OUTPUT(addAllTitles, NAMED('addAllTitles'));
    // OUTPUT(rollTitles, NAMED('rollTitles'));
    
    RETURN rollTitles;
END;
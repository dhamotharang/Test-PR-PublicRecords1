IMPORT DueDiligence, iesp;


EXPORT getExecTitles(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inBusData,
                     DATASET(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails) inData) := FUNCTION



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
                                    
                                    
    //transform and then rollup to the business level
    transBEOs := PROJECT(rollTitles, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetsSlim,
                                               SELF.seq := LEFT.seq;
                                               SELF.ultID := LEFT.ultID;
                                               SELF.orgID := LEFT.orgID;
                                               SELF.seleID := LEFT.seleID;
                                               
                                               SELF.execs := DATASET([TRANSFORM(DueDiligence.v3Layouts.Internal.SlimExec,
                                                                                SELF.lexID := LEFT.lexID;
                                                                                SELF.firstName := LEFT.firstName;
                                                                                SELF.middleName := LEFT.middleName;
                                                                                SELF.lastName := LEFT.lastName;
                                                                                SELF.suffix := LEFT.suffix;
                                                                                SELF.fullName := LEFT.fullName;
                                                                                
                                                                                SELF.titles := LEFT.titles;
                                                                                
                                                                                SELF.dob := LEFT.dob;
                                                                                SELF.ssn := LEFT.ssn;
                                                                               
                                                                                SELF.streetAddress1 := LEFT.streetAddress1;
                                                                                SELF.streetAddress2 := LEFT.streetAddress2;
                                                                                SELF.prim_range := LEFT.prim_range;
                                                                                SELF.predir := LEFT.predir;
                                                                                SELF.prim_name := LEFT.prim_name;
                                                                                SELF.addr_suffix := LEFT.addr_suffix;
                                                                                SELF.postdir := LEFT.postdir;
                                                                                SELF.unit_desig := LEFT.unit_desig;
                                                                                SELF.sec_range := LEFT.sec_range;
                                                                                
                                                                                SELF.city := LEFT.city;
                                                                                SELF.state := LEFT.state;
                                                                                SELF.zip := LEFT.zip;
                                                                                SELF.zip4 := LEFT.zip4;
                                                                                SELF.geo_blk := LEFT.geo_blk;
                                                                                SELF.county := LEFT.county;

                                                                                SELF.isOwnershipProng := LEFT.isOwnershipProng;
                                                                                SELF.isControlProng := LEFT.isControlProng;
                                                                                
                                                                                SELF := [];)]);
                                               
                                               SELF := [];));
                                             
    rollBEOs := ROLLUP(SORT(transBEOs, seq, ultID, orgID, seleID),
                       LEFT.seq = RIGHT.seq AND
                       LEFT.ultID = RIGHT.ultID AND
                       LEFT.orgID = RIGHT.orgID AND
                       LEFT.seleID = RIGHT.seleID,
                       TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetsSlim,
                                  SELF.execs := LEFT.execs + RIGHT.execs;
                                  SELF := LEFT;));
                                  
    addBEOsToInput := JOIN(inBusData, rollBEOs,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.inquiredBusiness.ultID = RIGHT.ultID AND
                            LEFT.inquiredBusiness.orgID = RIGHT.orgID AND
                            LEFT.inquiredBusiness.seleID = RIGHT.seleID,
                            TRANSFORM(DueDiligence.v3Layouts.Internal.BusinessTemp,
                                      SELF.beos := RIGHT.execs;
                                      SELF := LEFT;),
                            LEFT OUTER,
                            ATMOST(1));

                      


    // OUTPUT(sortExecs, NAMED('sortExecs'));
    // OUTPUT(uniqueExecTitles, NAMED('uniqueExecTitles'));
    // OUTPUT(maxTitles, NAMED('maxTitles'));
    // OUTPUT(addAllTitles, NAMED('addAllTitles'));
    // OUTPUT(rollTitles, NAMED('rollTitles'));
    
    // OUTPUT(transBEOs, NAMED('transBEOs'));
    // OUTPUT(rollBEOs, NAMED('rollBEOs'));
    // OUTPUT(addBEOsToInput, NAMED('addBEOsToInput'));
    
    RETURN addBEOsToInput;
END;
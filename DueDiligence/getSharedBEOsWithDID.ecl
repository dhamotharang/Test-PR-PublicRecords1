IMPORT BIPV2, DueDiligence;

EXPORT getSharedBEOsWithDID(DATASET(DueDiligence.LayoutsInternal.BEOLayout) inBEOs) := FUNCTION

    //send the executives that have DID's listed in the Contacts Key through the attribute logic. The attribute logic relies on having a DID to do all the look ups against the keys 
    sortExecs := SORT(inBEOs, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), relatedParty.did, title, partyLastSeen, partyFirstSeen, -isOwnershipProng);
    dedupExecs := DEDUP(sortExecs, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), relatedParty.did, title, partyLastSeen, partyFirstSeen);
    
    uniqueExecTitles := ROLLUP(dedupExecs,
                        #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                        LEFT.relatedParty.did = RIGHT.relatedParty.did AND
                        LEFT.title = RIGHT.title,
                        TRANSFORM(DueDiligence.LayoutsInternal.BEOLayout,
                                  SELF.partyLastSeen := MAX(LEFT.partyLastSeen, RIGHT.partyLastSeen);
                                  SELF.partyFirstSeen := IF(LEFT.partyFirstSeen = DueDiligence.Constants.NUMERIC_ZERO, MAX(LEFT.partyFirstSeen, RIGHT.partyFirstSeen), MIN(LEFT.partyFirstSeen, RIGHT.partyFirstSeen));
                                  SELF.isOwnershipProng := LEFT.isOwnershipProng OR RIGHT.isOwnershipProng;
                                  SELF.isControlProng := LEFT.isControlProng OR RIGHT.isControlProng;
                                  SELF := LEFT;));

    //add all positions to the related party                                           
    addExecPositions := PROJECT(uniqueExecTitles, TRANSFORM(DueDiligence.LayoutsInternal.BEOLayout,
                                                            SELF.relatedParty.positions := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.Positions,
                                                                                                                    SELF.firstSeen := LEFT.partyFirstSeen;
                                                                                                                    SELF.lastSeen := LEFT.partyLastSeen;
                                                                                                                    SELF.title := LEFT.title;
                                                                                                                    SELF := [];));
                                                            SELF := LEFT;
                                                            SELF := [];));

    sortExecsByLastSeen := SORT(addExecPositions, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), relatedParty.did, -partyLastSeen, -isOwnershipProng);
    
    //rollup all positions per given DID
    rollUniqueExecPositions := ROLLUP(sortExecsByLastSeen,
                                      #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                                      LEFT.relatedParty.did = RIGHT.relatedParty.did,
                                      TRANSFORM(DueDiligence.LayoutsInternal.BEOLayout,
                                                SELF.relatedParty.positions := LEFT.relatedParty.positions + RIGHT.relatedParty.positions;
                                                SELF.isOwnershipProng := LEFT.isOwnershipProng OR RIGHT.isOwnershipProng;
                                                SELF.isControlProng := LEFT.isControlProng OR RIGHT.isControlProng;
                                                SELF := LEFT;));


    sortRecentExecs := SORT(rollUniqueExecPositions, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), -partylastseen);
    groupExecs := GROUP(sortRecentExecs, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()));
    
    //grab the max number of execs
    getMaxExecutives := DueDiligence.Common.GetMaxRecords(groupExecs, DueDiligence.Constants.MAX_EXECS);
    
    //add count of positions and prongs to the related party dataset
    relatedPartyDS := PROJECT(getMaxExecutives, TRANSFORM(DueDiligence.LayoutsInternal.RelatedPartyLayout,
                                                                  
                                                          ownershipProng := LEFT.isOwnershipProng;
                                                          controlProng := LEFT.isControlProng;
                                                          
                                                          partyInfo := PROJECT(LEFT.relatedParty, TRANSFORM(RECORDOF(LEFT),
                                                                                                            SELF.isOwnershipProng := ownershipProng;
                                                                                                            SELF.isControlProng := controlProng;
                                                                                                            SELF.numOfPositions := COUNT(LEFT.positions);
                                                                                                            SELF := LEFT;));
                                                          
                                                          SELF.executives := partyInfo;
                                                          SELF := LEFT;));
                                                                  
                                                                  
    sortAllExecs := SORT(relatedPartyDS, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()));
     
     
    //rollup all execs by inquired business (seq, ultID, orgID, seleID)
    rollAllExecs := ROLLUP(sortAllExecs,
                            #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()),	
                            TRANSFORM(DueDiligence.LayoutsInternal.RelatedPartyLayout,
                                      SELF.executives := LEFT.executives + RIGHT.executives;
                                      SELF := LEFT;));	





    // OUTPUT(dedupExecs, NAMED('dedupExecs'));
    // OUTPUT(uniqueExecTitles, NAMED('uniqueExecTitles'));
    // OUTPUT(addExecPositions, NAMED('addExecPositions'));
    // OUTPUT(sortExecsByLastSeen, NAMED('sortExecsByLastSeen'));
    // OUTPUT(rollUniqueExecPositions, NAMED('rollUniqueExecPositions'));
    // OUTPUT(sortRecentExecs, NAMED('sortRecentExecs'));
    // OUTPUT(getMaxExecutives, NAMED('getMaxExecutives'));
    // OUTPUT(relatedPartyDS, NAMED('relatedPartyDS'));
    // OUTPUT(rollAllExecs, NAMED('rollAllExecs'));
    
    
    RETURN rollAllExecs;
END;
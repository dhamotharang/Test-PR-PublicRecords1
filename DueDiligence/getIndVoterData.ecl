/*
	Following Keys being used:
			VotersV2.Key_Voters_States
*/
EXPORT getIndVoterData(inquiredInternal, inquiredAndParentHeaderData) := FUNCTIONMACRO

    IMPORT DueDiligence, MDR, VotersV2;

    LOCAL inquiredOnlyHeaderData := inquiredAndParentHeaderData(indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL);

    //determine if there was a voter source for the individual or inquired's parent
    voterSources := inquiredAndParentHeaderData(src = MDR.sourceTools.src_Voters_v2);

    sortVoterSources := SORT(voterSources, seq, did);
    dedupVoterSources := DEDUP(sortVoterSources, seq, did);

    projectVoterSources := PROJECT(dedupVoterSources, TRANSFORM({RECORDOF(LEFT), BOOLEAN inquiredVoterSource, BOOLEAN parentVoterSource},
                                                                SELF.inquiredVoterSource := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL;
                                                                SELF.parentVoterSource := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT;
                                                                SELF := LEFT;));

                                                        
    rollVoterSources := ROLLUP(SORT(projectVoterSources, seq, inquiredDID, indvType),
                                LEFT.seq = RIGHT.seq AND
                                LEFT.inquiredDID = RIGHT.inquiredDID,
                                TRANSFORM(RECORDOF(LEFT),
                                          SELF.inquiredVoterSource := LEFT.inquiredVoterSource OR RIGHT.inquiredVoterSource;
                                          SELF.parentVoterSource := LEFT.parentVoterSource OR RIGHT.parentVoterSource;
                                          SELF := LEFT;));			                                                                
                                                

    addRegVoter := JOIN(inquiredInternal, rollVoterSources,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.individual.did = RIGHT.inquiredDID,
                        TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                  SELF.registeredVoter := RIGHT.inquiredVoterSource;
                                  SELF.atleastOneParentIsRegisteredVoter := RIGHT.parentVoterSource;
                                  SELF := LEFT;),
                        LEFT OUTER,
                        ATMOST(DueDiligence.Constants.MAX_ATMOST_1));


    //determine if the voter info has state coverage for the inquired individual 
    //using best address vs header data to potentially grab a state they may have lived that
    //does have voter info availble but now in a state that does not
    addIndStateVoter := JOIN(addRegVoter, VotersV2.Key_Voters_States(isFCRA),
                              KEYED(LEFT.bestAddress.State = RIGHT.State) AND
                              (STRING)LEFT.historyDate > RIGHT.date_first_seen,
                              TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                        SELF.stateVotingSourceAvailable := (UNSIGNED)RIGHT.date_first_seen > 0;
                                        SELF := LEFT;),
                              LEFT OUTER,
                              ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
		
                              


                        


    // output(voterSources, named('voterSources'));
    // output(dedupVoterSources, named('dedupVoterSources'));

    // output(projectVoterSources, named('projectVoterSources'));
    // output(rollVoterSources, named('rollVoterSources'));
    // output(addRegVoter, named('addRegVoter'));

    // output(parentRegVoters, named('parentRegVoters'));
    // output(addParentRegVoter, named('addParentRegVoter'));

    // output(addIndStateVoter, named('addIndStateVoter'));
                              
                              
    RETURN addIndStateVoter;
ENDMACRO;
EXPORT getIndHeaderReportData(inquiredInternal, inquiredHeaderData) := FUNCTIONMACRO

    IMPORT did_add, DueDiligence;
    
    
    
    GetSSNCounts(DATASET(DueDiligence.Layouts.Indv_Internal) indvInternal, BOOLEAN searchBest) := FUNCTION
        groupedHeader := GROUP(SORT(inquiredHeaderData, seq, did), seq, did);
        
        //determine if we count the SSN record
        ssnCounts := PROJECT(groupedHeader, TRANSFORM({DueDiligence.LayoutsInternal.IndSlimHeader, UNSIGNED socscount, UNSIGNED socScore},
                                                        ssnBestScore := did_add.ssn_match_score(LEFT.bestSSN, LEFT.ssn, LENGTH(TRIM(LEFT.ssn))=4);
                                                        ssnInputScore := did_add.ssn_match_score(LEFT.inputSSN, LEFT.ssn, LENGTH(TRIM(LEFT.ssn))=4);
                                                        
                                                        ssnScore := IF(searchBest, ssnBestScore, ssnInputScore);
                                                        SELF.socScore := ssnScore;
                                                        
                                                        ssnMatchesBest := LEFT.ssn = LEFT.bestSSN;
                                                        ssnMatchesInput := LEFT.ssn = LEFT.inputSSN;
                                                        ssnScoreInRange := risk_indicators.iid_constants.gn(ssnScore); 
                                                        ssnMatch := ssnScoreInRange AND IF(searchBest, ssnMatchesBest, ssnMatchesInput);
                                                        SELF.socscount := IF(ssnMatch, 1, 0);
                                                        SELF := LEFT;
                                                        SELF := [];));
                                                        
        //determine sources and dates
        sourceStats := TABLE(ssnCounts, {seq, did, src,
                                          records_per_source := COUNT(GROUP),
                                          ssn_matched_records := COUNT(GROUP, socscount > 0),
                                          ssn_first_seen  := MIN(GROUP, IF(dateFirstSeen <> 0 AND socscount > 0, dateFirstSeen, 99999999)),
                                          ssn_last_seen  := MAX(GROUP, IF(socscount > 0, dateLastSeen, 0))}, seq, did, src);
                                          
        grpSourceStats := GROUP(SORT(sourceStats, seq, did, ssn_first_seen, src), seq, did);
        
        transformStats := PROJECT(grpSourceStats, TRANSFORM({UNSIGNED4 seq, UNSIGNED6 did, STRING ssnSources, STRING ssnFirstSeen, STRING ssnLastSeen, STRING ssnSourceCount},
                                                              SELF.seq := LEFT.seq;
                                                              SELF.did := LEFT.did;
                                                              
                                                              sblank := LEFT.ssn_matched_records = 0;                                                          
                                                                                                                        
                                                              SELF.ssnSources := IF(sblank, '', TRIM(LEFT.src) + ',');
                                                              SELF.ssnFirstSeen := IF(sblank,'', IF(LEFT.ssn_first_seen=99999999, '0', (STRING)LEFT.ssn_first_seen) + ',');
                                                              SELF.ssnLastSeen := IF(sblank,'', IF(LEFT.ssn_last_seen=99999999, '0', (STRING)LEFT.ssn_last_seen) + ',');
                                                              SELF.ssnSourceCount := IF(sblank,'', (STRING)LEFT.ssn_matched_records + ',');));					
                  
        
        rolledSourceStats := ROLLUP(transformStats,
                                    LEFT.seq = RIGHT.seq AND
                                    LEFT.did = RIGHT.did,
                                    TRANSFORM(RECORDOF(LEFT),
                                              SELF.ssnSources := TRIM(LEFT.ssnSources) + RIGHT.ssnSources + ',';
                                              SELF.ssnFirstSeen := TRIM(LEFT.ssnFirstSeen) + IF(RIGHT.ssnSources = '', '', RIGHT.ssnFirstSeen + ',');
                                              SELF.ssnLastSeen := TRIM(LEFT.ssnLastSeen) + IF(RIGHT.ssnSources = '', '', RIGHT.ssnLastSeen + ',');
                                              SELF.ssnSourceCount := TRIM(LEFT.ssnSourceCount) + IF(RIGHT.ssnSources = '', '', RIGHT.ssnSourceCount + ',');		
                                              SELF := LEFT;));
        
        
        addSourceDetails := JOIN(indvInternal, rolledSourceStats,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.individual.did = RIGHT.did,
                                  TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                            sourceDets := DueDiligence.Common.GetSourceDetailsAsDataset(RIGHT.ssnSources, RIGHT.ssnSourceCount, RIGHT.ssnFirstSeen, RIGHT.ssnLastSeen);
                                            sourceDetails := sourceDets(source <> DueDiligence.Constants.EMPTY); 
                                            
                                            minFirstSeen := MIN(sourceDetails(sourceFirstSeen <> 0), sourceDetails.sourceFirstSeen);
                                            maxLastSeen := MAX(sourceDetails, sourceDetails.sourceLastSeen);
                                            
                                            SELF.bestSSNDetails.sourceInfo := IF(searchBest, sourceDetails, LEFT.bestSSNDetails.sourceInfo);
                                            SELF.bestSSNDetails.firstSeen := IF(searchBest, minFirstSeen, LEFT.bestSSNDetails.firstSeen); 
                                            SELF.bestSSNDetails.lastSeen := IF(searchBest, maxLastSeen, LEFT.bestSSNDetails.lastSeen);
                                                                                        
                                            SELF.inputSSNDetails.sourceInfo := IF(searchBest = FALSE, sourceDetails, LEFT.inputSSNDetails.sourceInfo);
                                            SELF.inputSSNDetails.firstSeen := IF(searchBest = FALSE, minFirstSeen, LEFT.inputSSNDetails.firstSeen); 
                                            SELF.inputSSNDetails.lastSeen := IF(searchBest = FALSE, maxLastSeen, LEFT.inputSSNDetails.lastSeen);
                                            
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
                                  
        
        RETURN addSourceDetails;
    END;


							

    bestSSNStats := GetSSNCounts(inquiredInternal, TRUE);
    inputSSNStats := GetSSNCounts(bestSSNStats, FALSE);
    
    //get unique names for the inquired
    sortHeader := SORT(inquiredHeaderData, seq, inquiredDID, firstName, middleName, lastName, suffix);
    uniqueNames := DEDUP(sortHeader, seq, inquiredDID, firstName, middleName, lastName, suffix);
    
    uniqueNameDS := PROJECT(uniqueNames, TRANSFORM({UNSIGNED6 seq, UNSIGNED6 inquiredDID, DATASET(DueDiligence.Layouts.Name) names},  
                                                    SELF.seq := LEFT.seq;
                                                    SELF.inquiredDID := LEFT.inquiredDID;
                                                    SELF.names := DATASET([TRANSFORM(DueDiligence.Layouts.Name,
                                                                                      SELF.firstName := LEFT.firstName;
                                                                                      SELF.middleName := LEFT.middleName;
                                                                                      SELF.lastName := LEFT.lastName;
                                                                                      SELF.suffix := LEFT.suffix;
                                                                                      SELF := [];)]);));
                                                                                      
    rollUniqueNames := ROLLUP(SORT(uniqueNameDS, seq, inquiredDID),
                              LEFT.seq = RIGHT.seq AND
                              LEFT.inquiredDID = RIGHT.inquiredDID,
                              TRANSFORM(RECORDOF(LEFT),
                                        SELF.names := LEFT.names + RIGHT.names;
                                        SELF := LEFT;));
    


    addAKAs := JOIN(inputSSNStats, rollUniqueNames,
                    LEFT.seq = RIGHT.seq AND
                    LEFT.inquiredDID = RIGHT.inquiredDID,
                    TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                              SELF.akas := RIGHT.names;
                              SELF := LEFT;),
                    LEFT OUTER,
                    ATMOST(1));
                    
                    
    
    sortMostRecentDate := SORT(inquiredHeaderData, seq, inquiredDID, -dateLastSeen);
    mostRecentData := DEDUP(sortMostRecentDate, seq, inquiredDID);
    
    addDateLastReported := JOIN(addAKAs, mostRecentData,
                                LEFT.seq = RIGHT.seq AND
                                LEFT.inquiredDID = RIGHT.inquiredDID,
                                TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                          SELF.dateLastReported := RIGHT.dateLastSeen;
                                          SELF := LEFT;),
                                LEFT OUTER,
                                ATMOST(1));
        
        
        
        

    // OUTPUT(bestSSNStats, NAMED('bestSSNStats'));
    // OUTPUT(inputSSNStats, NAMED('inputSSNStats'));
    // OUTPUT(sortHeader, NAMED('sortHeader'));
    // OUTPUT(uniqueNames, NAMED('uniqueNames'));
    // OUTPUT(uniqueNameDS, NAMED('uniqueNameDS'));
    // OUTPUT(rollUniqueNames, NAMED('rollUniqueNames'));
    // OUTPUT(addAKAs, NAMED('addAKAs'));

    
    
    
    RETURN addDateLastReported;
ENDMACRO;    
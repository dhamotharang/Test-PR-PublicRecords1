IMPORT DueDiligence, STD, ut;


EXPORT getCivilLegalEvent(DATASET(DueDiligence.v3Layouts.Internal.PersonTemp) inData,
                          DATASET(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions) rawLJE) := FUNCTION
                          
                          
                          
    //for each lexID determine which levels were hit
    civilEvent := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalPerson.PersonAttributes,
                                                        
                                            SELF.lexID := LEFT.inquiredDID;
                                            
                                            personCivilEvents := rawLJE(did = LEFT.inquiredDID);
                                            
                                            //evictions
                                            evictionsOver3Yrs := personCivilEvents(espDetails.eviction AND
                                                                                   releaseDate = 0 AND
                                                                                   DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) > ut.DaysInNYears(3));
                                            
                                            evictionsPast3Yrs := personCivilEvents(espDetails.eviction AND
                                                                                   releaseDate = 0 AND
                                                                                   DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) <= ut.DaysInNYears(3));
                                                                                   
                                                                                   
                                            //unreleased liens
                                            unreleasedLiensOver3Yrs := personCivilEvents(espDetails.eviction = FALSE AND
                                                                                         releaseDate = 0 AND
                                                                                         DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) > ut.DaysInNYears(3));
                                                                                         
                                            unreleasedLiensPast3Yrs := personCivilEvents(espDetails.eviction = FALSE AND
                                                                                         releaseDate = 0 AND
                                                                                         DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) <= ut.DaysInNYears(3));
                                          
                                            
                                                          
                                            civilEvent9 := IF(COUNT(unreleasedLiensPast3Yrs + evictionsPast3Yrs) >= 10, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent8 := IF(COUNT(unreleasedLiensPast3Yrs + evictionsPast3Yrs) BETWEEN 5 AND 9, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent7 := IF(COUNT(unreleasedLiensPast3Yrs + evictionsPast3Yrs) BETWEEN 3 AND 4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent6 := IF(COUNT(unreleasedLiensPast3Yrs + evictionsPast3Yrs) BETWEEN 1 AND 2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent5 := IF(COUNT(unreleasedLiensOver3Yrs + evictionsOver3Yrs) >= 10, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent4 := IF(COUNT(unreleasedLiensOver3Yrs + evictionsOver3Yrs) BETWEEN 5 AND 9, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent3 := IF(COUNT(unreleasedLiensOver3Yrs + evictionsOver3Yrs) BETWEEN 3 AND 4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent2 := IF(COUNT(unreleasedLiensOver3Yrs + evictionsOver3Yrs) BETWEEN 1 AND 2, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent1 := IF(COUNT(personCivilEvents) = 0 OR
                                                              (civilEvent9 = DueDiligence.Constants.F_INDICATOR AND
                                                              civilEvent8 = DueDiligence.Constants.F_INDICATOR AND
                                                              civilEvent7 = DueDiligence.Constants.F_INDICATOR AND
                                                              civilEvent6 = DueDiligence.Constants.F_INDICATOR AND
                                                              civilEvent5 = DueDiligence.Constants.F_INDICATOR AND
                                                              civilEvent4 = DueDiligence.Constants.F_INDICATOR AND
                                                              civilEvent3 = DueDiligence.Constants.F_INDICATOR AND
                                                              civilEvent2 = DueDiligence.Constants.F_INDICATOR), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                              
                                            civilEvent0 := DueDiligence.Constants.EMPTY;
                                            
                                            civilFlags := DueDiligence.v3Common.General.GetAttributeFlagDetails(civilEvent9, civilEvent8, civilEvent7,
                                                                                                                  civilEvent6, civilEvent5, civilEvent4,
                                                                                                                  civilEvent3, civilEvent2, civilEvent1, civilEvent0);
                                            
                                            civilScore := (STRING2)(10-STD.Str.Find(civilFlags, DueDiligence.Constants.T_INDICATOR, 1)); 
                                            
                                            SELF.perCivilLegalEvent := civilScore;
                                            SELF.perCivilLegalEvent_Flag := civilFlags;
                                            
                                            SELF := [];));


    // OUTPUT(civilEvent, NAMED('civilEvent'));

    RETURN civilEvent;
END;
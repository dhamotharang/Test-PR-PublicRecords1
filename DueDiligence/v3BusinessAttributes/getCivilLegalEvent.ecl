IMPORT DueDiligence, STD, ut;



EXPORT getCivilLegalEvent(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                          DATASET(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions) rawLJE,
                          DATASET(DueDiligence.v3Layouts.InternalShared.Bankruptcies) rawBank) := FUNCTION


    //for each lexID determine which levels were hit
    civilEvent := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessAttributes,
                                            SELF.seq := LEFT.seq;
                                            SELF.ultID := LEFT.inquiredBusiness.ultID;
                                            SELF.orgID := LEFT.inquiredBusiness.orgID;
                                            SELF.seleID := LEFT.inquiredBusiness.seleID;
                                            
                                            
                                            busBankEvents := rawBank(ultID = LEFT.inquiredBusiness.ultID AND 
                                                                     orgID = LEFT.inquiredBusiness.orgID AND 
                                                                     seleID = LEFT.inquiredBusiness.seleID);
                                                                     

                                            bankOver7 := busBankEvents(dismissed = FALSE AND
                                                                       IF(dateFirstSeen = 0,
                                                                            DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)filingDate, (STRING)historyDate) > ut.DaysInNYears(7),
                                                                            DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) > ut.DaysInNYears(7)));

                                            bankPast7 := busBankEvents(dismissed = FALSE AND
                                                                       IF(dateFirstSeen = 0,
                                                                            DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)filingDate, (STRING)historyDate) <= ut.DaysInNYears(7),
                                                                            DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) <= ut.DaysInNYears(7)));
                                                                            
                                            
                                            bankUnknownTime := busBankEvents(dismissed = FALSE AND
                                                                             DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)filingDate, (STRING)historyDate) = ut.DaysInNYears(0) AND
                                                                             DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) = ut.DaysInNYears(0));
                                            
                                            
                                            
                                            busCivilEvents := rawLJE(ultID = LEFT.inquiredBusiness.ultID AND 
                                                                     orgID = LEFT.inquiredBusiness.orgID AND 
                                                                     seleID = LEFT.inquiredBusiness.seleID);
                                                                                                               
                                            
                                            //evictions
                                            evictionsOver5Yrs := busCivilEvents(espDetails.eviction AND
                                                                                 releaseDate = 0 AND
                                                                                 IF(dateFirstSeen = 0,
                                                                                      DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)filingDate, (STRING)historyDate) > ut.DaysInNYears(5),
                                                                                      DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) > ut.DaysInNYears(5)));
                                            
                                            evictionsPast5Yrs := busCivilEvents(espDetails.eviction AND
                                                                                 releaseDate = 0 AND
                                                                                 IF(dateFirstSeen = 0,
                                                                                      DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)filingDate, (STRING)historyDate) <= ut.DaysInNYears(5),
                                                                                      DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) <= ut.DaysInNYears(5)));
                                                                                   
                                                                                   
                                            //unreleased liens
                                            unreleasedLiensOver5Yrs := busCivilEvents(espDetails.eviction = FALSE AND
                                                                                       releaseDate = 0 AND
                                                                                       IF(dateFirstSeen = 0,
                                                                                            DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)filingDate, (STRING)historyDate) > ut.DaysInNYears(5),
                                                                                            DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) > ut.DaysInNYears(5)));
                                                                                         
                                            unreleasedLiensPast5Yrs := busCivilEvents(espDetails.eviction = FALSE AND
                                                                                       releaseDate = 0 AND
                                                                                       IF(dateFirstSeen = 0,
                                                                                            DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)filingDate, (STRING)historyDate) <= ut.DaysInNYears(5),
                                                                                            DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) <= ut.DaysInNYears(5)));
                                          
                                            
                                                          
                                            civilEvent9 := IF(COUNT(bankPast7) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent8 := IF(COUNT(unreleasedLiensPast5Yrs + evictionsPast5Yrs) >= 10, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent7 := IF(COUNT(unreleasedLiensPast5Yrs + evictionsPast5Yrs) BETWEEN 5 AND 9, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent6 := IF(COUNT(unreleasedLiensPast5Yrs + evictionsPast5Yrs) BETWEEN 1 AND 4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent5 := IF(COUNT(bankOver7) > 0 OR COUNT(bankUnknownTime) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent4 := IF(COUNT(unreleasedLiensOver5Yrs + evictionsOver5Yrs) >= 10, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent3 := IF(COUNT(unreleasedLiensOver5Yrs + evictionsOver5Yrs) BETWEEN 5 AND 9, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent2 := IF(COUNT(unreleasedLiensOver5Yrs + evictionsOver5Yrs) BETWEEN 1 AND 4, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            civilEvent1 := IF((COUNT(busCivilEvents) = 0 AND COUNT(busBankEvents) = 0) OR
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
                                            
                                            SELF.busCivilLegalEvent := civilScore;
                                            SELF.busCivilLegalEvent_Flag := civilFlags;
                                            
                                            SELF := [];));


    // OUTPUT(rawLJE, NAMED('rawLJE'));
    // OUTPUT(civilEvent, NAMED('civilEvent'));
                                            
                          
    RETURN civilEvent;
END;;
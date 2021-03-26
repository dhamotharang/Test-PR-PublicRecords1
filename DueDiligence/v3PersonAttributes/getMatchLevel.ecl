IMPORT DueDiligence, STD;


EXPORT getMatchLevel(DATASET(DueDiligence.v3Layouts.Internal.PersonTemp) inData,
                     DATASET(DueDiligence.v3Layouts.DDInput.PersonSearch) rawData) := FUNCTION

    //for each lexID determine which levels were hit
    matchLevel := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalPerson.PersonResults,
                                            
                                            SELF.seq := LEFT.seq;
                                            SELF.lexID := LEFT.inquiredDID;
                                            SELF.lexIDScore := LEFT.lexIDScore;
                                            
                                            SELF.perLexID := (STRING15)LEFT.inquiredDID;
                                            SELF.perLexIDMatch := (STRING3)LEFT.lexIDScore;
                                            
                                            //searchBy is cleaned input data (could have more completed address)
                                            inputData := rawData(seq = LEFT.seq)[1].searchBy;
                                            
                                            //have input lexID the score will be 0 (nothing else to compare to give score)
                                            //if searching by lexID, regardless of PII entered (lexID search is priority)
                                            lexIDSearchOnly := inputData.lexID <> 0 AND LEFT.lexIDScore = 0;
                                            
                                            matchLevel9 := IF(LEFT.lexIDScore < 21  AND lexIDSearchOnly = FALSE, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel8 := IF(LEFT.lexIDScore BETWEEN 21 AND 30, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel7 := IF(LEFT.lexIDScore BETWEEN 31 AND 40, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel6 := IF(LEFT.lexIDScore BETWEEN 41 AND 50, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel5 := IF(LEFT.lexIDScore BETWEEN 51 AND 60, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel4 := IF(LEFT.lexIDScore BETWEEN 61 AND 70, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel3 := IF(LEFT.lexIDScore BETWEEN 71 AND 80, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel2 := IF(LEFT.lexIDScore BETWEEN 81 AND 90, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel1 := IF(LEFT.lexIDScore > 90 OR lexIDSearchOnly, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel0 := DueDiligence.Constants.EMPTY;
                                            
                                            matchFlags := DueDiligence.v3Common.General.GetAttributeFlagDetails(matchLevel9, matchLevel8, matchLevel7,
                                                                                                                  matchLevel6, matchLevel5, matchLevel4,
                                                                                                                  matchLevel3, matchLevel2, matchLevel1, matchLevel0);
                                            
                                            matchScore := (STRING2)(10-STD.Str.Find(matchFlags, DueDiligence.Constants.T_INDICATOR, 1)); 
                                            
                                            SELF.perMatchLevel := matchScore;
                                            SELF.perMatchLevel_Flag := matchFlags;
                                            
                                            SELF := [];));


    // OUTPUT(matchLevel, NAMED('matchLevel'));

    RETURN matchLevel;
END;
IMPORT DueDiligence, STD;


EXPORT getMatchLevel(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                     DATASET(DueDiligence.v3Layouts.DDInput.BusinessSearch) rawData) := FUNCTION

    //for each lexID determine which levels were hit
    matchLevel := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessResults,
                                            
                                            SELF.seq := LEFT.seq;
                                            SELF.ultID := LEFT.inquiredBusiness.ultID;
                                            SELF.orgID := LEFT.inquiredBusiness.orgID;
                                            SELF.seleID := LEFT.inquiredBusiness.seleID;
                                            SELF.proxID := LEFT.inquiredBusiness.proxID;
                                            SELF.powID := LEFT.inquiredBusiness.powID;
                                            
                                            SELF.busLexID := (STRING15)LEFT.inquiredBusiness.seleID;
                                            SELF.busLexIDMatch := (STRING3)LEFT.lexIDScore;
                                            
                                            //searchBy is cleaned input data (could have more completed address)
                                            inputData := rawData(seq = LEFT.seq)[1].searchBy;
                                            
                                            
                                            //have input lexID the score will be 0 (nothing else to compare to give score)
                                            //if searching by lexID, regardless of BII entered (lexID search is priority)
                                            lexIDSearchOnly := inputData.seleID <> 0 AND LEFT.lexIDScore = 0;
                                            
                                            matchLevel9 := IF(LEFT.lexIDScore < 50 AND lexIDSearchOnly = FALSE, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel8 := IF(LEFT.lexIDScore BETWEEN 50 AND 74, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel7 := IF(LEFT.lexIDScore BETWEEN 75 AND 84, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel6 := IF(LEFT.lexIDScore BETWEEN 85 AND 95, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel5 := IF(LEFT.lexIDScore = 96, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel4 := IF(LEFT.lexIDScore = 97, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel3 := IF(LEFT.lexIDScore = 98, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel2 := IF(LEFT.lexIDScore = 99, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel1 := IF(LEFT.lexIDScore = 100 OR lexIDSearchOnly, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                            matchLevel0 := DueDiligence.Constants.EMPTY;
                                            
                                            matchFlags := DueDiligence.v3Common.General.GetAttributeFlagDetails(matchLevel9, matchLevel8, matchLevel7,
                                                                                                                  matchLevel6, matchLevel5, matchLevel4,
                                                                                                                  matchLevel3, matchLevel2, matchLevel1, matchLevel0);
                                            
                                            matchScore := (STRING2)(10-STD.Str.Find(matchFlags, DueDiligence.Constants.T_INDICATOR, 1)); 
                                            
                                            SELF.busMatchLevel := matchScore;
                                            SELF.busMatchLevel_Flag := matchFlags;
                                            
                                            SELF := [];));


    // OUTPUT(matchLevel, NAMED('matchLevel'));

    RETURN matchLevel;
END;
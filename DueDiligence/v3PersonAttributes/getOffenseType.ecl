IMPORT DueDiligence, STD;


EXPORT getOffenseType(DATASET(DueDiligence.v3Layouts.InternalPerson.SlimPersonDetails) allUniquePeople,
                      DATASET(DueDiligence.v3Layouts.InternalPersonLegal.FinalCrimData) rawCrimData) := FUNCTION



    //for each lexID determine which levels were hit
    offenseType := PROJECT(allUniquePeople, TRANSFORM(DueDiligence.v3Layouts.InternalPerson.PersonAttributes,
                                                        
                                                        SELF.lexID := LEFT.lexID;
                                                        
                                                        personCrimData := rawCrimData(did = LEFT.lexID);
                                                        
                                                        offenseTypeLevel9 := IF(COUNT(personCrimData(offenseLevel = DueDiligence.translateExpression.LEVEL_9)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        offenseTypeLevel8 := IF(COUNT(personCrimData(offenseLevel = DueDiligence.translateExpression.LEVEL_8)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        offenseTypeLevel7 := IF(COUNT(personCrimData(offenseLevel = DueDiligence.translateExpression.LEVEL_7)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        offenseTypeLevel6 := IF(COUNT(personCrimData(offenseLevel = DueDiligence.translateExpression.LEVEL_6)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        offenseTypeLevel5 := IF(COUNT(personCrimData(offenseLevel = DueDiligence.translateExpression.LEVEL_5)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        offenseTypeLevel4 := IF(COUNT(personCrimData(offenseLevel = DueDiligence.translateExpression.LEVEL_4)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        offenseTypeLevel3 := IF(COUNT(personCrimData(offenseLevel = DueDiligence.translateExpression.LEVEL_3)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        offenseTypeLevel2 := IF(COUNT(personCrimData(offenseLevel = DueDiligence.translateExpression.LEVEL_2)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        offenseTypeLevel1 := IF(COUNT(personCrimData) = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        offenseTypeLevel0 := IF(COUNT(personCrimData(offenseLevel = DueDiligence.translateExpression.LEVEL_0)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        
                                                        offenseFlags := DueDiligence.v3Common.General.GetAttributeFlagDetails(offenseTypeLevel9, offenseTypeLevel8, offenseTypeLevel7,
                                                                                                                              offenseTypeLevel6, offenseTypeLevel5, offenseTypeLevel4,
                                                                                                                              offenseTypeLevel3, offenseTypeLevel2, offenseTypeLevel1, offenseTypeLevel0);
                                                        
                                                        offenseScore := (STRING2)(10-STD.Str.Find(offenseFlags, DueDiligence.Constants.T_INDICATOR, 1)); 
                                                        
                                                        SELF.perOffenseType := offenseScore;
                                                        SELF.perOffenseType_Flag := offenseFlags;
                                                        
                                                        SELF := [];));
    

    RETURN offenseType;
END;
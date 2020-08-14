IMPORT DueDiligence, STD, ut;


EXPORT getStateLegalEvent(DATASET(DueDiligence.v3Layouts.InternalPerson.SlimPersonDetails) allUniquePeople,
                          DATASET(DueDiligence.v3Layouts.InternalPersonLegal.FinalCrimData) rawCrimData) := FUNCTION


    
    FELONY_TEXT := 'FELONY';
    YES_TEXT := 'YES';



    //for each lexID determine which levels were hit
    sle := PROJECT(allUniquePeople, TRANSFORM(DueDiligence.v3Layouts.InternalPerson.PersonAttributes,
                                                        
                                              SELF.lexID := LEFT.lexID;
                                              
                                              personCrimData := rawCrimData(did = LEFT.lexID);
                                              
                                              //Felony
                                              convictedFelony := personCrimData(STD.Str.ToUpperCase(TRIM(offenseDDChargeLevelCalculated)) = FELONY_TEXT AND
                                                                                STD.Str.ToUpperCase(TRIM(offenseConviction)) = YES_TEXT);
                                                                                                                              
                                              
                                              convictedFelLast3Yrs := convictedFelony(ddFirstReportedActivity <> 0 AND
                                                                                      DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING8)ddFirstReportedActivity, (STRING8)historyDate) <= ut.DaysInNYears(3));
                                                                                      
                                              
                                              convictedFelOver3Yrs := convictedFelony(ddFirstReportedActivity = 0 OR
                                                                                      (ddFirstReportedActivity <> 0 AND
                                                                                      DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING8)ddFirstReportedActivity, (STRING8)historyDate) > ut.DaysInNYears(3)));
                                              
                                              
                                              //Non-Felony
                                              convictedNonFelony := personCrimData(STD.Str.ToUpperCase(TRIM(offenseDDChargeLevelCalculated)) <> FELONY_TEXT AND
                                                                                   STD.Str.ToUpperCase(TRIM(offenseConviction)) = YES_TEXT);
                                                                                   
                                              convictedNonFelLast3Yrs := convictedNonFelony(ddFirstReportedActivity <> 0 AND
                                                                                            DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING8)ddFirstReportedActivity, (STRING8)historyDate) <= ut.DaysInNYears(3));
                                                                                      
                                              
                                              convictedNonFelOver3Yrs := convictedNonFelony(ddFirstReportedActivity = 0 OR
                                                                                            (ddFirstReportedActivity <> 0 AND
                                                                                            DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING8)ddFirstReportedActivity, (STRING8)historyDate) > ut.DaysInNYears(3)));
                                              
                                 
                                              
                                              sleLevel9 := IF(COUNT(personCrimData(currentlyIncarcerated)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                              sleLevel8 := IF(COUNT(convictedFelLast3Yrs) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                              sleLevel7 := IF(COUNT(convictedFelOver3Yrs) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                              sleLevel6 := IF(COUNT(personCrimData(prevIncarcerated OR currentlyParoled OR currentlyProbation)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                              sleLevel5 := IF(COUNT(convictedNonFelLast3Yrs) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                              sleLevel4 := IF(COUNT(convictedNonFelOver3Yrs) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                              sleLevel3 := IF(COUNT(personCrimData(STD.Str.ToUpperCase(TRIM(offenseDDChargeLevelCalculated)) = FELONY_TEXT AND 
                                                                                   STD.Str.ToUpperCase(TRIM(offenseConviction)) <> YES_TEXT)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                                                   
                                              sleLevel2 := IF(COUNT(personCrimData(STD.Str.ToUpperCase(TRIM(offenseDDChargeLevelCalculated)) <> FELONY_TEXT AND 
                                                                                   STD.Str.ToUpperCase(TRIM(offenseConviction)) <> YES_TEXT)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                                                   
                                              sleLevel1 := IF(COUNT(personCrimData) = 0 OR
                                                              (sleLevel9 = DueDiligence.Constants.F_INDICATOR AND
                                                              sleLevel8 = DueDiligence.Constants.F_INDICATOR AND
                                                              sleLevel7 = DueDiligence.Constants.F_INDICATOR AND
                                                              sleLevel6 = DueDiligence.Constants.F_INDICATOR AND
                                                              sleLevel5 = DueDiligence.Constants.F_INDICATOR AND
                                                              sleLevel4 = DueDiligence.Constants.F_INDICATOR AND
                                                              sleLevel3 = DueDiligence.Constants.F_INDICATOR AND
                                                              sleLevel2 = DueDiligence.Constants.F_INDICATOR), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                              
                                              sleLevel0 := DueDiligence.Constants.EMPTY;
                                              
                                              stateLegalFlags := DueDiligence.v3Common.General.GetAttributeFlagDetails(sleLevel9, sleLevel8, sleLevel7,
                                                                                                                        sleLevel6, sleLevel5, sleLevel4,
                                                                                                                        sleLevel3, sleLevel2, sleLevel1, sleLevel0);
                                              
                                              stateLegalScore := (STRING2)(10-STD.Str.Find(stateLegalFlags, DueDiligence.Constants.T_INDICATOR, 1)); 
                                              
                                              SELF.perStateLegalEvent := stateLegalScore;
                                              SELF.perStateLegalEvent_Flag := stateLegalFlags;
                                              
                                              SELF := [];));



    RETURN sle;
END;
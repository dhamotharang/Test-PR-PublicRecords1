IMPORT DueDiligence, STD;


EXPORT getOffenseType(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData) := FUNCTION

    
    //get all lexID BEOs tied
    allBEOs := NORMALIZE(inData, LEFT.beos(lexID > 0), TRANSFORM({DueDiligence.v3Layouts.InternalBusiness.BusinessBEO, STRING2 score, STRING10 flag},
                                                                  SELF.seq := LEFT.seq;
                                                                  SELF.ultID := LEFT.inquiredBusiness.ultID;
                                                                  SELF.orgID := LEFT.inquiredBusiness.orgID;
                                                                  SELF.seleID := LEFT.inquiredBusiness.seleID;
                                                                  SELF.beoLexID := RIGHT.lexID;
                                                                  SELF.score := RIGHT.offenseType;
                                                                  SELF.flag := RIGHT.offenseTypeFlag;
                                                                  SELF := [];));

                   
    getBusinessOffenseType := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessAttributes,
                                                         SELF.seq := LEFT.seq;
                                                         SELF.ultID := LEFT.inquiredBusiness.ultID;
                                                         SELF.orgID := LEFT.inquiredBusiness.orgID;
                                                         SELF.seleID := LEFT.inquiredBusiness.seleID;
                                                          
                                                         beoCrimData := allBEOs(seq = LEFT.seq AND ultID = LEFT.inquiredBusiness.ultID AND
                                                                                orgID = LEFT.inquiredBusiness.orgID AND seleID = LEFT.inquiredBusiness.seleID);
                                                          
                                                         
                                                         offenseTypeLevel9 := IF(COUNT(beoCrimData(flag[1] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                         offenseTypeLevel8 := IF(COUNT(beoCrimData(flag[2] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                         offenseTypeLevel7 := IF(COUNT(beoCrimData(flag[3] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                         offenseTypeLevel6 := IF(COUNT(beoCrimData(flag[4] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                         offenseTypeLevel5 := IF(COUNT(beoCrimData(flag[5] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                         offenseTypeLevel4 := IF(COUNT(beoCrimData(flag[6] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                         offenseTypeLevel3 := IF(COUNT(beoCrimData(flag[7] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                         offenseTypeLevel2 := IF(COUNT(beoCrimData(flag[8] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                         offenseTypeLevel1 := IF(COUNT(beoCrimData(flag[9] = DueDiligence.Constants.T_INDICATOR)) > 0 OR COUNT(beoCrimData) = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                         offenseTypeLevel0 := DueDiligence.Constants.EMPTY;
                                                         
                                                         offenseFlags := DueDiligence.v3Common.General.GetAttributeFlagDetails(offenseTypeLevel9, offenseTypeLevel8, offenseTypeLevel7,
                                                                                                                               offenseTypeLevel6, offenseTypeLevel5, offenseTypeLevel4,
                                                                                                                               offenseTypeLevel3, offenseTypeLevel2, offenseTypeLevel1, offenseTypeLevel0);
                                                         
                                                         offenseScore := (STRING2)(10-STD.Str.Find(offenseFlags, DueDiligence.Constants.T_INDICATOR, 1)); 
                                                         
                                                         SELF.busOffenseType := offenseScore;
                                                         SELF.busOffenseType_Flag := offenseFlags;
                                                          
                                                         SELF := [];));




    // OUTPUT(allBEOs, NAMED('allBEOs'));
    // OUTPUT(getBusinessOffenseType, NAMED('getBusinessOffenseType'));

    RETURN getBusinessOffenseType;
END;
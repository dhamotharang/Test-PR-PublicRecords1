IMPORT DueDiligence, STD;


EXPORT getStateLegalEvent(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData) := FUNCTION

    
    //get all lexID BEOs tied
    allBEOs := NORMALIZE(inData, LEFT.beos(lexID > 0), TRANSFORM({DueDiligence.v3Layouts.InternalBusiness.BusinessBEO, STRING2 score, STRING10 flag},
                                                                  SELF.seq := LEFT.seq;
                                                                  SELF.ultID := LEFT.inquiredBusiness.ultID;
                                                                  SELF.orgID := LEFT.inquiredBusiness.orgID;
                                                                  SELF.seleID := LEFT.inquiredBusiness.seleID;
                                                                  SELF.beoLexID := RIGHT.lexID;
                                                                  SELF.score := RIGHT.stateLegalEvents;
                                                                  SELF.flag := RIGHT.stateLegalEventsFlag;
                                                                  SELF := [];));

    getBusinessSLE := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessAttributes,
                                                SELF.seq := LEFT.seq;
                                                SELF.ultID := LEFT.inquiredBusiness.ultID;
                                                SELF.orgID := LEFT.inquiredBusiness.orgID;
                                                SELF.seleID := LEFT.inquiredBusiness.seleID;
                                                
                                                beoCrimData := allBEOs(seq = LEFT.seq AND ultID = LEFT.inquiredBusiness.ultID AND
                                                                       orgID = LEFT.inquiredBusiness.orgID AND seleID = LEFT.inquiredBusiness.seleID);
                                                                          
                                                                          
                                                sleLevel9 := IF(COUNT(beoCrimData(flag[1] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                sleLevel8 := IF(COUNT(beoCrimData(flag[2] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                sleLevel7 := IF(COUNT(beoCrimData(flag[3] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                sleLevel6 := IF(COUNT(beoCrimData(flag[4] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                sleLevel5 := IF(COUNT(beoCrimData(flag[5] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                sleLevel4 := IF(COUNT(beoCrimData(flag[6] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                sleLevel3 := IF(COUNT(beoCrimData(flag[7] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);                                
                                                sleLevel2 := IF(COUNT(beoCrimData(flag[8] = DueDiligence.Constants.T_INDICATOR)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                sleLevel1 := IF(COUNT(beoCrimData(flag[9] = DueDiligence.Constants.T_INDICATOR)) > 0 OR COUNT(beoCrimData) = 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                sleLevel0 := DueDiligence.Constants.EMPTY;
                                                
                                                stateLegalFlags := DueDiligence.v3Common.General.GetAttributeFlagDetails(sleLevel9, sleLevel8, sleLevel7,
                                                                                                                          sleLevel6, sleLevel5, sleLevel4,
                                                                                                                          sleLevel3, sleLevel2, sleLevel1, sleLevel0);
                                                
                                                stateLegalScore := (STRING2)(10-STD.Str.Find(stateLegalFlags, DueDiligence.Constants.T_INDICATOR, 1)); 
                                                
                                                SELF.busStateLegalEvent := stateLegalScore;
                                                SELF.busStateLegalEvent_Flag := stateLegalFlags; 
                                                
                                                SELF := [];));
    
    
    
    
    // OUTPUT(allBEOs, NAMED('allBEOs'));
    // OUTPUT(getBusinessSLE, NAMED('getBusinessSLE'));
    
    
    RETURN getBusinessSLE;
END;
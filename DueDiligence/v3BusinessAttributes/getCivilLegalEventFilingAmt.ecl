IMPORT DueDiligence, STD, ut;


EXPORT getCivilLegalEventFilingAmt(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                                   DATASET(DueDiligence.v3Layouts.InternalShared.LiensJudgementsEvictions) rawLJE) := FUNCTION


    //for each lexID determine which levels were hit
    civilEventFilingAmt := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessAttributes,
                                                      SELF.seq := LEFT.seq;
                                                      SELF.ultID := LEFT.inquiredBusiness.ultID;
                                                      SELF.orgID := LEFT.inquiredBusiness.orgID;
                                                      SELF.seleID := LEFT.inquiredBusiness.seleID;
                                                      
                                                      busCivilEvents := rawLJE(ultID = LEFT.inquiredBusiness.ultID AND 
                                                                               orgID = LEFT.inquiredBusiness.orgID AND 
                                                                               seleID = LEFT.inquiredBusiness.seleID);
                                                      
                                                      
                                                      
                                                     
                                                      cityCountyStateFedPast5Yrs := busCivilEvents(releaseDate = 0 AND
                                                                                                    STD.Str.ToUpperCase(TRIM(espDetails.filingType)) IN DueDiligence.ConstantsLegal.CITY_COUNTY_STATE_FEDERAL AND
                                                                                                    IF(dateFirstSeen = 0,
                                                                                                        DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)filingDate, (STRING)historyDate) <= ut.DaysInNYears(5),
                                                                                                        DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) <= ut.DaysInNYears(5)));
                                                                                                      
                                                      cityCountyStateFedOver5Yrs := busCivilEvents(releaseDate = 0 AND
                                                                                                    STD.Str.ToUpperCase(TRIM(espDetails.filingType)) IN DueDiligence.ConstantsLegal.CITY_COUNTY_STATE_FEDERAL AND
                                                                                                    IF(dateFirstSeen = 0,
                                                                                                        DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)filingDate, (STRING)historyDate) > ut.DaysInNYears(5),
                                                                                                        DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) > ut.DaysInNYears(5)));
                                                      
                                                      
                                                      
                                                      
                                                      otherFilingTypesPast5Yrs := busCivilEvents(releaseDate = 0 AND
                                                                                                  STD.Str.ToUpperCase(TRIM(espDetails.filingType)) NOT IN DueDiligence.ConstantsLegal.CITY_COUNTY_STATE_FEDERAL AND
                                                                                                  IF(dateFirstSeen = 0,
                                                                                                      DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)filingDate, (STRING)historyDate) <= ut.DaysInNYears(5),
                                                                                                      DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) <= ut.DaysInNYears(5)));
                                                      
                                                      otherFilingTypesOver5Yrs := busCivilEvents(releaseDate = 0 AND
                                                                                                  STD.Str.ToUpperCase(TRIM(espDetails.filingType)) NOT IN DueDiligence.ConstantsLegal.CITY_COUNTY_STATE_FEDERAL AND
                                                                                                  IF(dateFirstSeen = 0,
                                                                                                      DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)filingDate, (STRING)historyDate) > ut.DaysInNYears(5),
                                                                                                      DueDiligence.v3Common.Date.DaysApartAccountingForZero((STRING)dateFirstSeen, (STRING)historyDate) > ut.DaysInNYears(5)));
                                                              
                                     
                                     
                                                      
                                                                    
                                                      civilEventFilingAmt9 := IF(SUM(cityCountyStateFedPast5Yrs, espDetails.filingAmount) > 500000, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                      civilEventFilingAmt8 := IF(SUM(cityCountyStateFedPast5Yrs, espDetails.filingAmount) BETWEEN 100000 AND 500000, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                      civilEventFilingAmt7 := IF(SUM(cityCountyStateFedPast5Yrs, espDetails.filingAmount) BETWEEN 50000 AND 99999, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                      civilEventFilingAmt6 := IF(COUNT(cityCountyStateFedPast5Yrs) > 0 AND SUM(cityCountyStateFedPast5Yrs, espDetails.filingAmount) < 50000, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                      civilEventFilingAmt5 := IF(SUM(otherFilingTypesPast5Yrs, espDetails.filingAmount) > 100000, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                      civilEventFilingAmt4 := IF(COUNT(otherFilingTypesPast5Yrs) > 0 AND SUM(otherFilingTypesPast5Yrs, espDetails.filingAmount) <= 100000, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                      civilEventFilingAmt3 := IF(COUNT(cityCountyStateFedOver5Yrs) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                      civilEventFilingAmt2 := IF(COUNT(otherFilingTypesOver5Yrs) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                      civilEventFilingAmt1 := IF(COUNT(busCivilEvents) = 0 OR
                                                                                (civilEventFilingAmt9 = DueDiligence.Constants.F_INDICATOR AND
                                                                                civilEventFilingAmt8 = DueDiligence.Constants.F_INDICATOR AND
                                                                                civilEventFilingAmt7 = DueDiligence.Constants.F_INDICATOR AND
                                                                                civilEventFilingAmt6 = DueDiligence.Constants.F_INDICATOR AND
                                                                                civilEventFilingAmt5 = DueDiligence.Constants.F_INDICATOR AND
                                                                                civilEventFilingAmt4 = DueDiligence.Constants.F_INDICATOR AND
                                                                                civilEventFilingAmt3 = DueDiligence.Constants.F_INDICATOR AND
                                                                                civilEventFilingAmt2 = DueDiligence.Constants.F_INDICATOR), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                                        
                                                      civilEventFilingAmt0 := DueDiligence.Constants.EMPTY;
                                                      
                                                      civilFilingAmtFlags := DueDiligence.v3Common.General.GetAttributeFlagDetails(civilEventFilingAmt9, civilEventFilingAmt8, civilEventFilingAmt7,
                                                                                                                                    civilEventFilingAmt6, civilEventFilingAmt5, civilEventFilingAmt4,
                                                                                                                                    civilEventFilingAmt3, civilEventFilingAmt2, civilEventFilingAmt1, civilEventFilingAmt0);
                                                      
                                                      civilFilingAmtScore := (STRING2)(10-STD.Str.Find(civilFilingAmtFlags, DueDiligence.Constants.T_INDICATOR, 1)); 
                                                      
                                                      SELF.busCivilLegalEventFilingAmt := civilFilingAmtScore;
                                                      SELF.busCivilLegalEventFilingAmt_Flag := civilFilingAmtFlags;
                                                      
                                                      SELF := [];));


    // OUTPUT(civilEventFilingAmt, NAMED('civilEventFilingAmt'));
    // OUTPUT(rawLJE, NAMED('rawLJE'));
                                            
                          
    RETURN civilEventFilingAmt;
END;
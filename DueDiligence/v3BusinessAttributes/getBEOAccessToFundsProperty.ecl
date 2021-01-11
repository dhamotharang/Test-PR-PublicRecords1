IMPORT DueDiligence, STD;


EXPORT getBEOAccessToFundsProperty(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData) := FUNCTION


    beoAccessFundsProperty := PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessAttributes,
                                                        SELF.seq := LEFT.seq;
                                                        SELF.ultID := LEFT.inquiredBusiness.ultID;
                                                        SELF.orgID := LEFT.inquiredBusiness.orgID;
                                                        SELF.seleID := LEFT.inquiredBusiness.seleID;
                                            
                                                        allBEOs := LEFT.beos;
                                                        
                                                        beoWithLexIDs := allBEOs(lexID > 0);
                                                        didlessBEOs := allBEOs(lexID = 0);
                                                        
                                                        //grab only the data that is populated
                                                        maxWatercraftLength := SORT(beoWithLexIDs, -maxWatercraftLengthRaw)[1].maxWatercraftLengthRaw;
                                                        
                                                        //should only have information with those that have lexIDs
                                                        //and grab the largest values
                                                        numProps := SORT(beoWithLexIDs, -numProperties)[1].numProperties;
                                                        numVehs := SORT(beoWithLexIDs, -numVehicles)[1].numVehicles;
                                                        numAir := SORT(beoWithLexIDs, -numAircraft)[1].numAircraft;
                                                        numWater := SORT(beoWithLexIDs, -numWatercraft)[1].numWatercraft;
                                                        
                                                        
                                                        accessFundsProp9 := IF(COUNT(beoWithLexIDs(totalTaxAssessedVal >= 15000000)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        accessFundsProp8 := IF(COUNT(beoWithLexIDs(totalTaxAssessedVal BETWEEN 5000000 AND 14999999)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        accessFundsProp7 := IF(maxWatercraftLength >= 50, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        accessFundsProp6 := IF(COUNT(beoWithLexIDs(maxBaseVehicleVal >= 200000)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        accessFundsProp5 := IF(COUNT(beoWithLexIDs(totalTaxAssessedVal BETWEEN 1000000 AND 4999999)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        accessFundsProp4 := IF(COUNT(beoWithLexIDs(maxBaseVehicleVal BETWEEN 75000 AND 199999)) > 0, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        accessFundsProp3 := IF(numProps >= 4 OR 
                                                                               numAir >= 1 OR
                                                                               numVehs >= 5 OR
                                                                               numWater >= 3, DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        
                                                        accessFundsProp2 := IF(COUNT(allBEOs) = 0 OR
                                                                                (COUNT(beoWithLexIDs) = 0 AND COUNT(didlessBEOs) > 0), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                        
                                                        accessFundsProp1 := IF(COUNT(beoWithLexIDs) > 0 AND
                                                                               (accessFundsProp9 = DueDiligence.Constants.F_INDICATOR AND
                                                                                accessFundsProp8 = DueDiligence.Constants.F_INDICATOR AND
                                                                                accessFundsProp7 = DueDiligence.Constants.F_INDICATOR AND
                                                                                accessFundsProp6 = DueDiligence.Constants.F_INDICATOR AND
                                                                                accessFundsProp5 = DueDiligence.Constants.F_INDICATOR AND
                                                                                accessFundsProp4 = DueDiligence.Constants.F_INDICATOR AND
                                                                                accessFundsProp3 = DueDiligence.Constants.F_INDICATOR), DueDiligence.Constants.T_INDICATOR, DueDiligence.Constants.F_INDICATOR);
                                                                          
                                                        accessFundsProp0 := DueDiligence.Constants.EMPTY;
                                                        
                                                        beoAccessFundsAndPropFlags := DueDiligence.v3Common.General.GetAttributeFlagDetails(accessFundsProp9, accessFundsProp8, accessFundsProp7,
                                                                                                                                            accessFundsProp6, accessFundsProp5, accessFundsProp4,
                                                                                                                                            accessFundsProp3, accessFundsProp2, accessFundsProp1, 
                                                                                                                                            accessFundsProp0);
                                                        
                                                        beoAccessFundsAndPropScore := (STRING2)(10-STD.Str.Find(beoAccessFundsAndPropFlags, DueDiligence.Constants.T_INDICATOR, 1)); 
                                                        
                                                        SELF.busBEOAccessToFundsProperty := beoAccessFundsAndPropScore;
                                                        SELF.busBEOAccessToFundsProperty_Flag := beoAccessFundsAndPropFlags;
                                                        
                                                        SELF := [];));



    RETURN beoAccessFundsProperty;
END;
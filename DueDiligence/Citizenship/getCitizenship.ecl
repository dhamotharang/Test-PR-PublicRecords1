IMPORT DueDiligence, Models, Risk_Indicators;

EXPORT getCitizenship(DATASET(Risk_Indicators.Layout_Boca_Shell) inData,
                      DATASET(DueDiligence.Citizenship.Layouts.IndicatorLayout) riskIndicators,
                      BOOLEAN modelValidation) := FUNCTION
                      
                      
    
    //call model
    modelResults := Models.cit1808_0_0(inData);    //expecting to return everything (basically running as debug TRUE, only care about seq and score
    
    
    citizenshipScore := JOIN(inData, modelResults, 
                            LEFT.seq = RIGHT.seq, 
                            TRANSFORM(DueDiligence.Citizenship.Layouts.ScoreAndIndicators,  
                                      SELF.seq := LEFT.seq;
                                      SELF.citizenshipScore := RIGHT.citizenshipScore;
                                      SELF := [];));
                                      
    citizenshipResults := JOIN(citizenshipScore, riskIndicators,
                                  LEFT.seq = RIGHT.seq,
                                  TRANSFORM(DueDiligence.Citizenship.Layouts.ScoreAndIndicators,
                                            SELF.seq := LEFT.seq;
                                            SELF.citizenshipScore := LEFT.citizenshipScore;
                                            SELF := RIGHT;));
            
            
            
            

    IF(modelValidation, OUTPUT(DueDiligence.Citizenship.getModelValidationFile(riskIndicators, modelResults), NAMED('modelValidationResults')));
    
    
            


    // OUTPUT(modelResults, NAMED('modelResults'));        
    // OUTPUT(citizenshipScore, NAMED('citizenshipScore'));        
    // OUTPUT(citizenshipResults, NAMED('citizenshipResults'));        
                                          
    RETURN citizenshipResults;
END;
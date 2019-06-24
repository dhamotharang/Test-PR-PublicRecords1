IMPORT DueDiligence, Models, Risk_Indicators;

EXPORT getCitizenship(DATASET(DueDiligence.LayoutsInternal.SharedInput) inData,
                      BOOLEAN modelValidation) := FUNCTION
                      
                      

    
    //pull out the BS from each request                                                  
    bsOnly := PROJECT(inData, TRANSFORM({DATASET(Risk_Indicators.Layout_Boca_Shell) clam},
                                         SELF.clam := DATASET([TRANSFORM(Risk_Indicators.Layout_Boca_Shell,
                                                                    SELF := LEFT.bs;)]);));
                                                      
                                                      
    //call model
    modelResults := Models.cit1808_0_0(bsOnly.clam);    //expecting to return everything (basically running as debug TRUE, only care about seq and score
    
    
    citizenshipResults := JOIN(inData, modelResults, 
                                LEFT.bs.seq = RIGHT.seq, 
                                TRANSFORM({UNSIGNED4 seq, STRING30 acctNo, Citizenship.Layouts.LayoutScoreAndIndicators},  
                                          SELF.seq := LEFT.bs.seq;
                                          SELF.acctNo := LEFT.inputEcho.individual.accountNumber;
                                          SELF.citizenshipScore := RIGHT.citizenshipScore;
                                          SELF := LEFT.riskIndicators;));
            
            
            
            

    IF(modelValidation, output(DueDiligence.Citizenship.Common.GetModelValidationFile(inData, modelResults), NAMED('modelValidationResults')));
    
    
            

    // OUTPUT(bsOnly, NAMED('bsOnly'));
    // OUTPUT(modelResults, NAMED('modelResults'));        
                                          
    RETURN citizenshipResults;
END;
IMPORT DueDiligence;

EXPORT CitizenshipBatchMain(DATASET(DueDiligence.LayoutsInternal.SharedInput) inData, 
                            BOOLEAN modelValidation) := FUNCTION

 
  
  
    
    citizenship := DueDiligence.Citizenship.getCitizenship(inData, modelValidation);
    
    
    //return the batch output
    citizenshipResults := PROJECT(citizenship, TRANSFORM(DueDiligence.Layouts.BatchOut,
                                                          SELF := LEFT;
                                                          SELF := [];));
    

    
   
    
   
    // OUTPUT(citizenship, NAMED('citizenship'));
    // OUTPUT(citizenshipResults, NAMED('citizenshipResults'));
    

    RETURN citizenshipResults;
END;
IMPORT Citizenship, DueDiligence, Gateway, Models, Risk_Indicators;

EXPORT CitizenshipBatchMain(DATASET(DueDiligence.Layouts.Input) input, 
                            UNSIGNED6 inGLBA, 
                            UNSIGNED6 inDPPA, 
                            STRING50 inDataRestriction,
                            STRING50 inDataPermission,
                            STRING15 inModelName,
                            BOOLEAN modelValidation,
                            BOOLEAN debug) := FUNCTION

 
  
  
    //validate the request
    validatedCitizenshipRequests := Citizenship.Common.ValidateInput(input, inGLBA, inDPPA, inModelName);
    
    
    citizenship := Citizenship.getCitizenship(validatedCitizenshipRequests(validRequest), inGLBA, inDPPA, inDataRestriction, inDataPermission, inModelName, modelValidation, debug);
    
    
    //return the batch output
    citizenshipResults := PROJECT(citizenship, TRANSFORM(DueDiligence.Layouts.BatchOut,
                                                          SELF := LEFT;
                                                          SELF := [];));
    

    
   
    
   
    // OUTPUT(validatedCitizenshipRequests, NAMED('cit_validatedRequests'));
    

    RETURN citizenshipResults;
END;
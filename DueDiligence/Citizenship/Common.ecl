IMPORT Address, Business_Header, DueDiligence, iesp, STD;

EXPORT Common := MODULE

  EXPORT ValidateInput(DATASET(DueDiligence.Layouts.Input) input, UNSIGNED1 glbPurpose, UNSIGNED1 dppaPurpose, STRING15 modelName):= FUNCTION

      BOOLEAN ValidGLB := DueDiligence.CitDDShared.isValidGLBA(glbPurpose);
      BOOLEAN ValidDPPA := DueDiligence.CitDDShared.isValidDPPA(dppaPurpose);

      BOOLEAN validModel := STD.Str.ToUpperCase(modelName) IN Citizenship.Constants.VALID_MODEL_NAMES;

      validatedRequests := PROJECT(input, TRANSFORM(DueDiligence.Layouts.Input,
                                                    //Validate the request
                                                    STRING OhNoMessage := MAP(validModel = FALSE => Citizenship.Constants.VALIDATION_INVALID_MODEL_NAME,
                                                                              ValidGLB = FALSE => DueDiligence.CitDDShared.VALIDATION_INVALID_GLB,
                                                                              ValidDPPA = FALSE => DueDiligence.CitDDShared.VALIDATION_INVALID_DPPA,
                                                                              DueDiligence.Constants.EMPTY);




                                                    SELF.validRequest := OhNoMessage = DueDiligence.Constants.EMPTY;
                                                    SELF.errorMessage := OhNoMessage;

                                                    SELF := LEFT;));
                                                    
      RETURN validatedRequests;
  END;
  

  EXPORT createNVPair(STRING name, INTEGER val) := FUNCTION
      
      iesp.share.t_NameValuePair createPair(STRING n, INTEGER v) := TRANSFORM
        SELF.Name := n;
        SELF.Value := (STRING)v;
      END;

      RETURN ROW(createPair(name, val));			
  END;
  
  
  EXPORT GetModelValidationFile(inData, model) := FUNCTIONMACRO
  
      //should be able to handle any model as long as the model
      //has a seq field in the layout
      fullModelValidation := JOIN(inData, model,
                                  LEFT.bs.seq = RIGHT.seq,
                                  TRANSFORM({DueDiligence.Citizenship.Layouts.IndicatorLayout, RECORDOF(RIGHT) -seq},
                                              SELF := LEFT.riskIndicators;
                                              SELF := RIGHT;));

      RETURN fullModelValidation;
  ENDMACRO;

END;
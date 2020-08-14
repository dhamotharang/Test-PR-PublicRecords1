EXPORT getModelValidationFile(riskIndicators, model) := FUNCTIONMACRO
     
     IMPORT DueDiligence;
     
      //should be able to handle any model as long as the model
      //has a seq field in the layout
      fullModelValidation := JOIN(riskIndicators, model,
                                  LEFT.seq = RIGHT.seq,
                                  TRANSFORM({DueDiligence.Citizenship.Layouts.IndicatorLayout, RECORDOF(RIGHT) -seq},
                                              SELF := LEFT;
                                              SELF := RIGHT;));

      RETURN fullModelValidation;
ENDMACRO;
IMPORT Address, Business_Header, DueDiligence, iesp, STD;

EXPORT Common := MODULE

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
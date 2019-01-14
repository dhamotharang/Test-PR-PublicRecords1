EXPORT macAppendDataset(dIn1, dIn2, fieldString = '') := FUNCTIONMACRO
  
  LOCAL rIn2 := RECORDOF(dIn2);
  LOCAL recString := '{rIn2.'+REGEXREPLACE(',', fieldString, ', rIn2.')+'}';
  
  LOCAL rOut  := RECORD
    RECORDOF(dIn1)
    #IF(fieldString != '')
      OR #EXPAND(recString)
    #END;
  END;
  
	LOCAL dOut1 := PROJECT(dIn1, TRANSFORM(rOut, SELF := LEFT, SELF := []));
	LOCAL dOut2 := PROJECT(dIn2, TRANSFORM(rOut, SELF := LEFT, SELF := []));
  
  LOCAL dOut  := dOut1 + dOut2;
		
	RETURN DISTRIBUTE(dOut);
ENDMACRO;
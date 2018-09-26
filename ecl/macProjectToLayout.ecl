EXPORT macProjectToLayout(dIn, inOutputFields) := FUNCTIONMACRO
IMPORT  ecl;

  LOCAL newRecordLayout := ecl.macComputeAppendFieldsRecord(inOutputFields, '');
  LOCAL dOut := PROJECT(dIn, TRANSFORM({
    #EXPAND(newRecordLayout)}, SELF := LEFT));
    
  RETURN #IF(inOutputFields != '') dOut #ELSE dIn #END;
ENDMACRO;
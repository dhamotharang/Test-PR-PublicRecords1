EXPORT macProjectToLayout(dIn, inOutputFields) := FUNCTIONMACRO
IMPORT  hipie_ecl;

  LOCAL newRecordLayout := hipie_ecl.macComputeAppendFieldsRecord(inOutputFields, '');
  LOCAL dOut := PROJECT(dIn, TRANSFORM({
    #EXPAND(newRecordLayout)}, SELF := LEFT));
    
  RETURN #IF(inOutputFields != '') dOut #ELSE dIn #END;
ENDMACRO;
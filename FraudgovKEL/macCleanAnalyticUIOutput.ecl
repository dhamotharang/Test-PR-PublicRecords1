EXPORT macCleanAnalyticUIOutput(dIn, rIn, strCodesToIgnore = '-99999\', \'-99998\', \'-99997') := FUNCTIONMACRO
  LOADXML('<xml/>');
  #DECLARE(FieldsCleaning) #SET(FieldsCleaning, '')
  #EXPORTXML(Fields, RECORDOF(rIn))
  #FOR(Fields)
    #FOR(Field)
      #APPEND(FieldsCleaning, 'SELF.' + %'{@label}'% + ':= IF((STRING)LEFT.'+ %'{@label}'% + ' IN [\'')
      #APPEND(FieldsCleaning, codesToIgnore)
      #APPEND(FieldsCleaning, '\'], (TYPEOF(LEFT.' + %'{@label}'% + '))\'\', LEFT.'+ %'{@label}'% +'),')
    #END
  #END
   
  LOCAL dCleanOut := PROJECT(dIn, TRANSFORM(rIn,
    #EXPAND(%'FieldsCleaning'%)
    SELF := LEFT
    ));
    
  RETURN dCleanOut;
ENDMACRO;
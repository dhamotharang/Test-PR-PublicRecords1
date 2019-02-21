EXPORT macComputeFieldMap(inNormalizeField, inRawFields, rawFieldsSeparator = '\',\'') := FUNCTIONMACRO 
  LOCAL fieldMap := (STRING)inNormalizeField + '=' + REGEXREPLACE((STRING)rawFieldsSeparator, (STRING)inRawFields, '|');
  RETURN fieldMap;
ENDMACRO;
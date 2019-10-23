EXPORT macComputeConcatenatedColumn(l, space=' '):=FUNCTIONMACRO
  RETURN #EXPAND(REGEXREPLACE(',',REGEXREPLACE('([^,]+)',l,'TRIM((string)LEFT.$1)'),' + \'' + space + '\' + '));
ENDMACRO;
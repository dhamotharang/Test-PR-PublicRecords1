EXPORT SlimDataSet(d, keycols, fieldcols) := FUNCTIONMACRO
  IMPORT Std;
  STRING Layout := 'LEFT.' + Std.Str.FindReplace(keycols + ',' + fieldcols, ',', ', LEFT.');
  RETURN PROJECT(d, #EXPAND('TRANSFORM({' + Layout + '}, SELF := LEFT)'));
ENDMACRO;

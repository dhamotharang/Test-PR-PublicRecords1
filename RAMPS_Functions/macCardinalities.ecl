EXPORT macCardinalities(d,f,t=100):=FUNCTIONMACRO
  RETURN #EXPAND(REGEXREPLACE('([^{}+]+)',REGEXREPLACE(',',REGEXREPLACE(' ',f,''),'+'),'TOPN(TABLE('+#TEXT(d)+',{STRING100 field_name:=\'$1\';STRING field_value:=(STRING)$1;UNSIGNED value_count:=COUNT(GROUP);},$1,MERGE),'+#TEXT(t)+',-value_count)'));
ENDMACRO;

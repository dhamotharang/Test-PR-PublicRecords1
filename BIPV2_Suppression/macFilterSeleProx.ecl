EXPORT macFilterSeleProx(d):=FUNCTIONMACRO
  RETURN JOIN(d,BIPV2_Suppression.modSuppression.kSeleProx(),KEYED(LEFT.seleid=RIGHT.seleid AND LEFT.proxid=RIGHT.proxid),TRANSFORM(LEFT),LEFT ONLY);
ENDMACRO;
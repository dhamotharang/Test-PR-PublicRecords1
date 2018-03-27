EXPORT MAC_Field_By_UID(infile,ufield,infield) := FUNCTIONMACRO
  RETURN TABLE(infile,{infield,ufield,Cnt := COUNT(GROUP)},ufield,infield,local);
ENDMACRO;

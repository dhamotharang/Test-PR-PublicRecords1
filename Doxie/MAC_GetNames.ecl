export MAC_GetNames (outfile, infile, key, layout) := MACRO 
  #uniquename (tra);
  layout %tra%(infile le, recordof (key) ri) := TRANSFORM
    SELF.names := PROJECT(ri,TRANSFORM(standard.name, SELF := ri, SELF := []));
    SELF := le;
  END;

  outfile := JOIN (infile, key, keyed(LEFT.person2=RIGHT.did), %tra%(LEFT,RIGHT), KEEP(1));
 
ENDMACRO;

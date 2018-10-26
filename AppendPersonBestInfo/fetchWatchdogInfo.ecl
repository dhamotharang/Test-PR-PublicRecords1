EXPORT fetchWatchdogInfo := MODULE
  EXPORT macSmall(dIn, inLexid, key) := FUNCTIONMACRO
    RETURN JOIN(dIn, key, 
    KEYED((UNSIGNED)LEFT.inLexid=RIGHT.did),
    TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)}, 
      SELF := RIGHT,
      SELF := LEFT), 
    KEEP (1), LIMIT (0));
  ENDMACRO;
  
  EXPORT macLarge(dIn, inLexid, key) := FUNCTIONMACRO
    RETURN JOIN(PULL(key), dIn, 
    LEFT.did = (UNSIGNED)RIGHT.inLexid,
    TRANSFORM({RECORDOF(RIGHT), RECORDOF(LEFT)}, 
      SELF := LEFT,
      SELF := RIGHT), 
    SMART, MANY, KEEP (1), LIMIT (0));
  ENDMACRO;
END;
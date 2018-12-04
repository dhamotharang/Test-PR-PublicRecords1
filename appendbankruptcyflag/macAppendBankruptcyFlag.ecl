EXPORT macAppendBankruptcyFlag(dIn, inLexID, appendPrefix = '\'\'', UseIndexThreshold=10000000) := FUNCTIONMACRO
  IMPORT AppendBankruptcyFlag;
  
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    INTEGER1 #EXPAND(appendPrefix + 'hasBankruptcy');
  END;
  
  LOCAL dOutSmall := JOIN (dIn,AppendBankruptcyFlag.Keys.BocashellBankruptcyKey,
    KEYED(LEFT.inLexID = RIGHT.DID AND LEFT.inLexID > 0),
    TRANSFORM(rOut, 
      SELF.#EXPAND(appendPrefix + 'hasBankruptcy') := (INTEGER1)(RIGHT.bk_count30 > 0 OR 
        RIGHT.bk_count90 > 0 OR 
        RIGHT.bk_count180 > 0 OR 
        RIGHT.bk_count12 > 0  OR 
        RIGHT.bk_count24 > 0 OR 
        RIGHT.bk_count36 > 0 OR 
        RIGHT.bk_count60 > 0),
			SELF := LEFT), 
      LEFT OUTER, HASH);
      
	LOCAL dOutLarge := JOIN(AppendBankruptcyFlag.Keys.BocashellBankruptcyKey, dIn, 
    RIGHT.inLexID = LEFT.DID AND RIGHT.inLexID > 0,
    TRANSFORM(rOut,
      SELF.#EXPAND(appendPrefix + 'hasBankruptcy') := (INTEGER1)(LEFT.bk_count30 > 0 OR 
        LEFT.bk_count90 > 0 OR 
        LEFT.bk_count180 > 0 OR 
        LEFT.bk_count12 > 0  OR 
        LEFT.bk_count24 > 0 OR 
        LEFT.bk_count36 > 0 OR 
        LEFT.bk_count60 > 0),
      SELF := RIGHT),
    SMART);
	
	LOCAL dOut := MAP(COUNT(dIn) > UseIndexThreshold => dOutLarge, dOutSmall);
  RETURN dOut;
ENDMACRO;
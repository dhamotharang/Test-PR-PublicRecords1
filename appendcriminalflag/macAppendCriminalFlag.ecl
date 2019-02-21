EXPORT macAppendCriminalFlag(dIn, inLexID, appendPrefix = '\'\'', UseIndexThreshold=10000000) := FUNCTIONMACRO
  IMPORT AppendCriminalFlag;
  
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    INTEGER1 #EXPAND(appendPrefix + 'hasCriminal');
  END;
  
  LOCAL dOutSmall := JOIN (dIn,AppendCriminalFlag.Keys.BocashellCriminalKey,
    KEYED(LEFT.inLexID = RIGHT.DID AND LEFT.inLexID > 0),
    TRANSFORM(rOut, 
      SELF.#EXPAND(appendPrefix + 'hasCriminal') := (INTEGER1)(RIGHT.arrests_count30 > 0 OR 
        RIGHT.arrests_count90 > 0 OR 
        RIGHT.arrests_count180 > 0 OR 
        RIGHT.arrests_count12 > 0  OR 
        RIGHT.arrests_count24 > 0 OR 
        RIGHT.arrests_count36 > 0 OR 
        RIGHT.arrests_count60 > 0),
			SELF := LEFT), 
      LEFT OUTER, HASH);
      
	LOCAL dOutLarge := JOIN(AppendCriminalFlag.Keys.BocashellCriminalKey, dIn, 
    RIGHT.inLexID = LEFT.DID AND RIGHT.inLexID > 0,
    TRANSFORM(rOut,
      SELF.#EXPAND(appendPrefix + 'hasCriminal') := (INTEGER1)(LEFT.arrests_count30 > 0 OR 
        LEFT.arrests_count90 > 0 OR 
        LEFT.arrests_count180 > 0 OR 
        LEFT.arrests_count12 > 0  OR 
        LEFT.arrests_count24 > 0 OR 
        LEFT.arrests_count36 > 0 OR 
        LEFT.arrests_count60 > 0),
      SELF := RIGHT),
    SMART);
	
	LOCAL dOut := MAP(COUNT(dIn) > UseIndexThreshold => dOutLarge, dOutSmall);
  RETURN dOut;
ENDMACRO;
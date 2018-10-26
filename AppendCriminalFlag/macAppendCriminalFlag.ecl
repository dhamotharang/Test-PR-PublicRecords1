EXPORT macAppendCriminalFlag(dIn, inLexID, appendPrefix = '\'\'', UseIndexThreshold=10000000) := FUNCTIONMACRO
  IMPORT doxie_files, hipie_ecl;
  
	LOCAL dDistributed    := DISTRIBUTE(dIn((UNSIGNED)inLexID <> 0), HASH32(inLexID));
  LOCAL dDeduped        := DEDUP(SORT(dDistributed, inLexID, LOCAL), inLexID, LOCAL);
  
  LOCAL dCriminal := hipie_ecl.macJoinKey(dDeduped, doxie_files.Key_BocaShell_Crim2,
		'KEYED(LEFT.' + #TEXT(inLexID) + ' = RIGHT.DID)', 
    'RIGHT.' + #TEXT(inLexID) + ' = LEFT.DID', 
    UseIndexThreshold,,,,,,HashOption:=true); 
		
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    INTEGER1 #EXPAND(appendPrefix + 'hasCriminal');
  END;
	
  LOCAL dOut := JOIN(dDistributed,dCriminal,
    LEFT.InLexID = RIGHT.InLexID,
    TRANSFORM(rOut,
      SELF := LEFT,
      SELF.#EXPAND(appendPrefix + 'hasCriminal') := (INTEGER1)(RIGHT.arrests_count30 > 0 OR 
        RIGHT.arrests_count90 > 0 OR 
        RIGHT.arrests_count180 > 0 OR 
        RIGHT.arrests_count12 > 0  OR 
        RIGHT.arrests_count24 > 0 OR 
        RIGHT.arrests_count36 > 0 OR 
        RIGHT.arrests_count60 > 0)),
    LEFT OUTER,
    LIMIT(0),KEEP(1), LOCAL)
    + PROJECT(dIn((UNSIGNED)InLexId = 0), TRANSFORM(rOut,
        SELF := LEFT, SELF := []));
				
  RETURN dOut;
ENDMACRO;
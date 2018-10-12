EXPORT macAppendBankruptcyFlag(dIn, inLexID, appendPrefix = '\'\'', UseIndexThreshold=10000000) := FUNCTIONMACRO
  IMPORT BankruptcyV3, hipie_ecl;
  
	LOCAL dDistributed    := DISTRIBUTE(dIn((UNSIGNED)inLexID <> 0), HASH32(inLexID));
  LOCAL dDeduped        := DEDUP(SORT(dDistributed, inLexID, LOCAL), inLexID, LOCAL);
  
  LOCAL dBankruptcy := hipie_ecl.macJoinKey(dDeduped, BankruptcyV3.Key_bankruptcyV3_bocashell,
		'KEYED(LEFT.' + #TEXT(inLexID) + ' = RIGHT.DID)', 
    'RIGHT.' + #TEXT(inLexID) + ' = LEFT.DID', 
    UseIndexThreshold,,true,25000); 
		
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    INTEGER1 #EXPAND(appendPrefix + 'hasBankruptcy');
  END;
	
  LOCAL dOut := JOIN(dDistributed,dBankruptcy,
    LEFT.InLexID = RIGHT.InLexID,
    TRANSFORM(rOut,
      SELF := LEFT,
      SELF.#EXPAND(appendPrefix + 'hasBankruptcy') := (INTEGER1)(RIGHT.bk_count30 > 0 OR 
        RIGHT.bk_count90 > 0 OR 
        RIGHT.bk_count180 > 0 OR 
        RIGHT.bk_count12 > 0  OR 
        RIGHT.bk_count24 > 0 OR 
        RIGHT.bk_count36 > 0 OR 
        RIGHT.bk_count60 > 0)),
    LEFT OUTER,
    LIMIT(0),KEEP(1), LOCAL)
    + PROJECT(dIn((UNSIGNED)InLexId = 0), TRANSFORM(rOut,
        SELF := LEFT, SELF := []));
  RETURN dOut;
ENDMACRO;
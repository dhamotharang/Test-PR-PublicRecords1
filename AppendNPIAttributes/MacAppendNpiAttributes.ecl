EXPORT MacAppendNPIAttributes(inData, npiField, appendPrefix = '\'\'', useIndexThreshold = 5000000) := FUNCTIONMACRO
  IMPORT NPPES, hipie_ecl;
	
	LOCAL dDistributed    := DISTRIBUTE(inData((UNSIGNED)npiField <> 0), HASH32(npiField));
  LOCAL dDeduped        := DEDUP(SORT(dDistributed, npiField, LOCAL), npiField, LOCAL);
	
  LOCAL outRec := RECORD
    RECORDOF(inData);
    STRING1 #EXPAND(appendPrefix + 'EntityTypeCode');
  END;
    
  LOCAL matchedData := hipie_ecl.macJoinKey(dDeduped, NPPES.Key_NPPES_npi,
    'KEYED(LEFT.' + #TEXT(npiField) + ' = RIGHT.npi)', 
    'RIGHT.' + #TEXT(npiField) + ' = LEFT.npi', 
    useIndexThreshold, 
    'INNER', 
    FALSE, //KeepOption
    , //KeepValue
    FALSE, //AtmostOption
    , //AtmostValue
    TRUE //HashOption
  );

  LOCAL matchedData_sorted := SORT(matchedData, npi, -dt_last_seen); 
  LOCAL matchedData_deduped := DEDUP(matchedData_sorted, npi);      

  LOCAL outData := JOIN(dDistributed, matchedData_deduped,
    LEFT.npiField = RIGHT.npiField,
    TRANSFORM(outRec, 
      SELF.#EXPAND(appendPrefix + 'EntityTypeCode') := RIGHT.entity_type_code;
      SELF := LEFT;
    ), 
    LEFT OUTER, 
    HASH
  )
    + PROJECT(inData((UNSIGNED)npiField = 0), TRANSFORM(outRec,
        SELF := LEFT, SELF := []));
      
  RETURN outData;
ENDMACRO;

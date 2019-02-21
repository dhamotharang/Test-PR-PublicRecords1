EXPORT MacAppendNpiAttributes(inData, keyField, npiField, appendPrefix = '\'\'') := FUNCTIONMACRO
  IMPORT AppendNpiAttributes;
  
  outRec := RECORD
    RECORDOF(inData);
    STRING1 #EXPAND(appendPrefix + 'EntityTypeCode');
  END;
  
  joinedRec := RECORD
	  outRec;
		unsigned4 #EXPAND(appendPrefix + 'DateLastSeen');
	END;
	
  joinedData := JOIN(inData, AppendNpiAttributes.Key_Nppes_Npi,
    KEYED(LEFT.npiField = RIGHT.npi),
    TRANSFORM(joinedRec, 
      SELF.#EXPAND(appendPrefix + 'EntityTypeCode') := RIGHT.entity_type_code;
      SELF.#EXPAND(appendPrefix + 'DateLastSeen') := RIGHT.dt_last_seen;
			SELF := LEFT;
		), 
    LEFT OUTER, 
		HASH
	);

  joinedData_sorted := SORT(joinedData, keyField, #EXPAND(appendPrefix + 'DateLastSeen')); 
  joinedData_deduped := DEDUP(joinedData, keyField, RIGHT);      
			
  outData := PROJECT(joinedData_deduped, TRANSFORM(outRec, SELF := LEFT;));  
	
  RETURN outData;
ENDMACRO;
EXPORT MacAppendNPIAttributes(inData, npiField, appendPrefix = '\'\'') := FUNCTIONMACRO
  IMPORT AppendNPIAttributes;
  
  outRec := RECORD
    RECORDOF(inData);
    STRING1 #EXPAND(appendPrefix + 'EntityTypeCode');
  END;
  
  npiRec := RECORD
	  string10 npi;
    string1 entity_type_code;
    unsigned4 dt_last_seen;		
	END;
	
  matchedData := JOIN(inData(npiField <> ''), AppendNPIAttributes.Key_NPPES_NPI,
    KEYED(LEFT.npiField = RIGHT.npi),
    TRANSFORM(npiRec, 
			SELF := RIGHT;
		), 
    INNER, 
		HASH
	);

  matchedData_sorted := SORT(matchedData, npi, -dt_last_seen); 
  matchedData_deduped := DEDUP(matchedData_sorted, npi);      

  outData := JOIN(inData, matchedData_deduped,
    LEFT.npiField = RIGHT.npi,
    TRANSFORM(outRec, 
      SELF.#EXPAND(appendPrefix + 'EntityTypeCode') := RIGHT.entity_type_code;
			SELF := LEFT;
		), 
    LEFT OUTER, 
		HASH
	);
			
  RETURN outData;
ENDMACRO;
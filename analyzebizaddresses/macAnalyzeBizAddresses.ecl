EXPORT macAnalyzeBizAddresses(dIn, inputAddressField, cleanedAddressField, 
  cacheHitField, cleanerHitField, noAddressInputField, noAddressCleanerErrorField, 
  errorCodeDescriptionField, addressType = '0', addressTypeDescription = '\'\'', appendPrefix = '\'\'') := FUNCTIONMACRO
  
  LOCAL rFinal := RECORD
    RECORDOF(dIn);
    STRING      #EXPAND(appendPrefix + 'InputAddress');
    STRING      #EXPAND(appendPrefix + 'CleanedAddress');
    BOOLEAN     #EXPAND(appendPrefix + 'CacheHit');
    BOOLEAN     #EXPAND(appendPrefix + 'CleanerHit');
    BOOLEAN     #EXPAND(appendPrefix + 'NoAddressInput');
    BOOLEAN     #EXPAND(appendPrefix + 'NoAddressCleanerError');
    STRING      #EXPAND(appendPrefix + 'ErrorCodeDescription');  
    INTEGER     #EXPAND(appendPrefix + 'addressType') := (INTEGER)addressType;
		STRING      #EXPAND(appendPrefix + 'addressTypeDescription') := addressTypeDescription;
  END;
  
  LOCAL rFinal tFinal(RECORDOF(dIn) L) := TRANSFORM
    SELF.#EXPAND(appendPrefix + 'InputAddress') := L.inputAddressField;
    SELF.#EXPAND(appendPrefix + 'CleanedAddress') := L.cleanedAddressField;
    SELF.#EXPAND(appendPrefix + 'CacheHit') := L.cacheHitField;
    SELF.#EXPAND(appendPrefix + 'CleanerHit') := L.cleanerHitField;
    SELF.#EXPAND(appendPrefix + 'NoAddressInput'):= L.noAddressInputField;
    SELF.#EXPAND(appendPrefix + 'NoAddressCleanerError') := L.noAddressCleanerErrorField;
    SELF.#EXPAND(appendPrefix + 'ErrorCodeDescription') := L.errorCodeDescriptionField;
    SELF := L;
  END;
  
  LOCAL dOut := PROJECT(dIn, tFinal(LEFT));
  RETURN dOut;
ENDMACRO;
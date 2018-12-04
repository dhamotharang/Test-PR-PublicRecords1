EXPORT macAnalyzeBizAddressesV2(dIn, inputAddressField, cleanedAddressField, 
  cacheHitField, cleanerHitField, noAddressInputField, noAddressCleanerErrorField, 
  errorCodeDescriptionField, primaryRangeField, preDirectionalField, primaryNameField,
  addressSuffixField, postDirectionalField, unitDesignationField, secondaryRangeField, 
  postalCityField, vanityCityField, stateField, zipField, zip4Field,
  countyField, latitudeField, longitudeField,
  inputStreetAddress1Field, inputStreetAddress2Field, inputCityField, inputStateField, inputZipField,
  addressType = '0', addressTypeDescription = '\'\'', appendPrefix = '\'\'') := FUNCTIONMACRO
  
  LOCAL rFinal := RECORD
    RECORDOF(dIn);
    STRING      #EXPAND(appendPrefix + 'InputAddress');
    STRING      #EXPAND(appendPrefix + 'CleanedAddress');
    BOOLEAN     #EXPAND(appendPrefix + 'CacheHit');
    BOOLEAN     #EXPAND(appendPrefix + 'CleanerHit');
    BOOLEAN     #EXPAND(appendPrefix + 'NoAddressInput');
    BOOLEAN     #EXPAND(appendPrefix + 'NoAddressCleanerError');
    STRING      #EXPAND(appendPrefix + 'ErrorCodeDescription');  
    INTEGER     #EXPAND(appendPrefix + 'AddressType') := (INTEGER)addressType;
		STRING      #EXPAND(appendPrefix + 'AddressTypeDescription') := addressTypeDescription;
		STRING      #EXPAND(appendPrefix + 'ErrorClassification');
    STRING      #EXPAND(appendPrefix + 'InputStreetAddress1'); 	
    STRING      #EXPAND(appendPrefix + 'InputStreetAddress2'); 	
    STRING      #EXPAND(appendPrefix + 'InputCity'); 	
    STRING      #EXPAND(appendPrefix + 'InputState'); 	
    STRING      #EXPAND(appendPrefix + 'InputZip'); 	
    STRING10    #EXPAND(appendPrefix + 'PrimaryRange'); 	
		STRING2     #EXPAND(appendPrefix + 'PreDirectional');
		STRING28    #EXPAND(appendPrefix + 'PrimaryName');	
		STRING4     #EXPAND(appendPrefix + 'AddressSuffix'); 
		STRING2     #EXPAND(appendPrefix + 'PostDirectional');
		STRING10    #EXPAND(appendPrefix + 'UnitDesignation');
		STRING8     #EXPAND(appendPrefix + 'SecondaryRange');
		STRING25    #EXPAND(appendPrefix + 'PostalCity');
		STRING25    #EXPAND(appendPrefix + 'VanityCity');
		STRING2     #EXPAND(appendPrefix + 'State');
		STRING5     #EXPAND(appendPrefix + 'Zip');
		STRING4     #EXPAND(appendPrefix + 'Zip4');
		STRING      #EXPAND(appendPrefix + 'County');
		STRING      #EXPAND(appendPrefix + 'Latitude');
		STRING      #EXPAND(appendPrefix + 'Longitude');
  END;
  
  LOCAL rFinal tFinal(RECORDOF(dIn) L) := TRANSFORM
    SELF.#EXPAND(appendPrefix + 'InputAddress') := L.inputAddressField;
    SELF.#EXPAND(appendPrefix + 'CleanedAddress') := L.cleanedAddressField;
    SELF.#EXPAND(appendPrefix + 'CacheHit') := L.cacheHitField;
    SELF.#EXPAND(appendPrefix + 'CleanerHit') := L.cleanerHitField;
    SELF.#EXPAND(appendPrefix + 'NoAddressInput'):= L.noAddressInputField;
    SELF.#EXPAND(appendPrefix + 'NoAddressCleanerError') := L.noAddressCleanerErrorField;
    SELF.#EXPAND(appendPrefix + 'ErrorCodeDescription') := L.errorCodeDescriptionField;
    SELF.#EXPAND(appendPrefix + 'ErrorClassification') := MAP(L.errorCodeDescriptionField = 'No error' => 'No Enhancement Needed', 
      L.errorCodeDescriptionField =  'No address provided in the input' => 'No Input Address', 
      'Input was Enhanced');
		SELF.#EXPAND(appendPrefix + 'InputStreetAddress1') := L.inputStreetAddress1Field;
		SELF.#EXPAND(appendPrefix + 'InputStreetAddress2') := L.inputStreetAddress2Field;
		SELF.#EXPAND(appendPrefix + 'InputCity') := L.inputCityField;
		SELF.#EXPAND(appendPrefix + 'InputState') := L.inputStateField;
		SELF.#EXPAND(appendPrefix + 'InputZip') := L.inputZipField;
		SELF.#EXPAND(appendPrefix + 'PrimaryRange') := L.primaryRangeField;
		SELF.#EXPAND(appendPrefix + 'PreDirectional') := L.preDirectionalField;
		SELF.#EXPAND(appendPrefix + 'PrimaryName') := L.primaryNameField;
		SELF.#EXPAND(appendPrefix + 'AddressSuffix') := L.addressSuffixField;
		SELF.#EXPAND(appendPrefix + 'PostDirectional') := L.postDirectionalField;
		SELF.#EXPAND(appendPrefix + 'UnitDesignation') := L.unitDesignationField;
		SELF.#EXPAND(appendPrefix + 'SecondaryRange') := L.secondaryRangeField;
		SELF.#EXPAND(appendPrefix + 'PostalCity') := L.postalCityField;
		SELF.#EXPAND(appendPrefix + 'VanityCity') := L.vanityCityField;
		SELF.#EXPAND(appendPrefix + 'State') := L.stateField;
		SELF.#EXPAND(appendPrefix + 'Zip') := L.zipField;
		SELF.#EXPAND(appendPrefix + 'Zip4') := L.zip4Field;
		SELF.#EXPAND(appendPrefix + 'County') := L.countyField;
		SELF.#EXPAND(appendPrefix + 'Latitude') := L.latitudeField;
		SELF.#EXPAND(appendPrefix + 'Longitude') := L.longitudeField;
    SELF := L;
  END;
  
  LOCAL dOut := PROJECT(dIn, tFinal(LEFT));
  RETURN dOut;
ENDMACRO;
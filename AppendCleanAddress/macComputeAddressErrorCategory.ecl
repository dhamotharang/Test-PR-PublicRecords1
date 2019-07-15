EXPORT macComputeAddressErrorCategory(InData, InAddressError, RawAddr, RawCity='', RawState='', RawZip='', appendPrefix='Address', rawCityStateZip='') := FUNCTIONMACRO
	LOCAL outLayout := RECORD
		RECORDOF(InData);
		BOOLEAN #EXPAND(appendPrefix + 'NoAddressInput');
		BOOLEAN #EXPAND(appendPrefix + 'NoAddressCleanerError');
		STRING #EXPAND(appendPrefix + 'ErrorCodeDescription');
	END;

	LOCAL outLayout tComputeAddressErrorCategory(RECORDOF(InData) L) := TRANSFORM
		aceAddressErrorCode := (STRING)L.InAddressError[1] = 'E';
		addressErrorFirstChar := (STRING)L.InAddressError[1];
		addressErrorSecondChar := (STRING)L.InAddressError[2];
		addressErrorThirdChar	:= (STRING)L.InAddressError[3];
		addressErrorFourthChar := (STRING)L.InAddressError[4];
		BOOLEAN BlankRawAddr := TRIM(L.RawAddr 
      #IF(#TEXT(RawCity) != '' AND #TEXT(RawState) != '' AND #TEXT(RawZip) != '') 
        + L.RawCity + L.RawState + L.RawZip 
      #ELSE 
        #IF(#TEXT(RawCityStateZip) != '') + L.RawCityStateZip #END 
      #END) = '';
		BOOLEAN TruncatedAddress := (addressErrorFirstChar != 'S' AND NOT aceAddressErrorCode);
		BOOLEAN CityStateZipDifferent := (addressErrorSecondChar NOT IN ['8', '0'] AND NOT aceAddressErrorCode);
		BOOLEAN AddressLineDifferent := (addressErrorThirdChar != '0' AND NOT aceAddressErrorCode);
		BOOLEAN AdditionalAddressInfoDifferent := (addressErrorFourthChar != '0' AND NOT aceAddressErrorCode);
		BOOLEAN BadCityStateZip := ((STRING)L.InAddressError IN ['E212', 'E213', 'E214', 'E216', 'E428', 'E429']);
		BOOLEAN BadAddressLine := ((STRING)L.InAddressError IN ['E302', 'E412', 'E413', 'E420', 'E421', 'E422', 'E423', 'E425', 'E427', 'E430', 'E503', 'E504']);
		BOOLEAN OtherAddressError := ((STRING)L.InAddressError IN ['E101', 'E431', 'E500', 'E501', 'E505', 'E600']);
		SELF.#EXPAND(appendPrefix + 'NoAddressInput') := ((STRING)L.InAddressError IN['E502'] OR BlankRawAddr);
		SELF.#EXPAND(appendPrefix + 'NoAddressCleanerError') := (addressErrorFirstChar = 'S' AND addressErrorSecondChar IN ['8','0'] AND addressErrorThirdChar = '0' AND addressErrorFourthChar = '0');	
		SELF.#EXPAND(appendPrefix + 'ErrorCodeDescription') := MAP(
      SELF.#EXPAND(appendPrefix + 'NoAddressCleanerError') => 'No error',
			SELF.#EXPAND(appendPrefix + 'NoAddressInput') => 'No address provided in the input',
			BadCityStateZip => 'Bad city, state and/or zip',
			BadAddressLine => 'Bad address line components',
			(STRING)L.InAddressError = 'E501' => 'Foreign Address',
			(STRING)L.InAddressError IN ['E600','E505'] => 'USPS marked undeliverable',
			OtherAddressError => 'Other address error',
			TruncatedAddress AND CityStateZipDifferent AND AddressLineDifferent AND AdditionalAddressInfoDifferent => 'Truncated and corrected entire address',
			TruncatedAddress AND CityStateZipDifferent AND AddressLineDifferent => 'Truncated and corrected CSZ and street address',
			TruncatedAddress AND CityStateZipDifferent AND AdditionalAddressInfoDifferent => 'Truncated and corrected CSZ and minor changes',
			TruncatedAddress AND AddressLineDifferent AND AdditionalAddressInfoDifferent => 'Truncated and corrected street address and minor changes',
			CityStateZipDifferent AND AddressLineDifferent AND AdditionalAddressInfoDifferent => 'Corrected entire address',
			TruncatedAddress AND CityStateZipDifferent => 'Truncated and corrected CSZ',
			TruncatedAddress AND AddressLineDifferent => 'Truncated and corrected street address',
			TruncatedAddress AND AdditionalAddressInfoDifferent => 'Truncated and minor changes',
			CityStateZipDifferent AND AddressLineDifferent => 'Corrected street address and CSZ',
			CityStateZipDifferent AND AdditionalAddressInfoDifferent => 'Corrected CSZ and minor changes',
			AddressLineDifferent AND AdditionalAddressInfoDifferent => 'Corrected street address and minor changes',
			TruncatedAddress => 'Truncated and no corrections',
			CityStateZipDifferent => 'Corrected CSZ',
			AddressLineDifferent => 'Corrected street address',
			AdditionalAddressInfoDifferent => 'Minor changes',
			'');
		SELF := L;
	END;
	
	LOCAL outData := PROJECT(inData, tComputeAddressErrorCategory(LEFT));
	RETURN outData;
ENDMACRO;
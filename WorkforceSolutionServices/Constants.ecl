EXPORT Constants := MODULE

	EXPORT ValidationCode := MODULE
		EXPORT UNSIGNED DID_MATCH := 0;
		EXPORT UNSIGNED INPUT_DID_NOTFOUND := 1;  // input PII could not be resolved to LexID
		EXPORT UNSIGNED OUTPUT_DID_NOTFOUND := 2; // gateway output PII could not be resolved to LexID
		EXPORT UNSIGNED DID_MISMATCH := 3; // input/out LexID mismatch
		EXPORT UNSIGNED INVALID_RESPONSE := 4; // gateway had an invalid response
		EXPORT UNSIGNED NO_CALL := 5; // gateway was never called - due to alerts
		EXPORT UNSIGNED NONE := 6;
	END;

	ValidationCodes := DATASET ([
		{ValidationCode.NONE, ''},
		{ValidationCode.DID_MATCH, 'Hit : record exists for input SSN'},
		{ValidationCode.INPUT_DID_NOTFOUND, 'No Hit/No Charge: LN could not find a unique LexID for the customer input information.'},
		{ValidationCode.OUTPUT_DID_NOTFOUND, 'No Hit/No Charge: LN could not find a unique LexID for the output information coming back from the Vendor.'},
		{ValidationCode.DID_MISMATCH, 'No Hit/No Charge: Mismatch. The LexID captured on input did not match the LexID resolved to from the Vendor\'s output.'},
		{ValidationCode.NO_CALL, 'No Hit/No Charge: Consumer Alert in place for this consumer.'},
		{ValidationCode.INVALID_RESPONSE, 'No Hit/No Charge: '}
  	], {UNSIGNED code, STRING description});

	DictValidationCodesDesc := DICTIONARY (ValidationCodes, {code => description});

	EXPORT GetValidationCodeDesc(UNSIGNED validation_code, STRING error_message='') := DictValidationCodesDesc[validation_code].description 
                                                                                  + IF(validation_code=ValidationCode.INVALID_RESPONSE,error_message,'');

END;
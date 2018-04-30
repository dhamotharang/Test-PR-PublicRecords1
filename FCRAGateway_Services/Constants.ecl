IMPORT FCRAGateway_Services;
EXPORT Constants := MODULE

	EXPORT GatewayStatus := MODULE
		EXPORT integer NOCALL := 0;
		EXPORT integer SUCCESS := 200;
		EXPORT integer ERROR := 400;
	END;

	EXPORT ValidationCode := MODULE
		EXPORT integer NONE := 0;
		EXPORT integer DID_MATCH := 100;
		EXPORT integer INPUT_DID_NOTFOUND := 110;  // input PII could not be resolved to LexID
		EXPORT integer OUTPUT_DID_NOTFOUND := 111; // gateway output could not be resolved to LexID
		EXPORT integer DID_MISMATCH := 112; // input/out did mismatch
	END;

	ValidationCodes := DATASET ([
		{ValidationCode.NONE, ''},
		{ValidationCode.DID_MATCH, 'OK'},
		{ValidationCode.INPUT_DID_NOTFOUND, 'Input does not resolve to LexID'},
		{ValidationCode.OUTPUT_DID_NOTFOUND, 'Output does not resolve to LexID'},
		{ValidationCode.DID_MISMATCH, 'Failed to validate consumer LexID'}
  	], {integer code, STRING description});

	DictValidationCodesDesc := DICTIONARY (ValidationCodes, {code => description});

	EXPORT GetValidationCodeDesc(integer validationCode) := DictValidationCodesDesc[validationCode].description;

	EXPORT Debug := MODULE
		EXPORT EquifaxEmsSoapcall := FALSE;
		EXPORT EquifaxEmsGateway := FALSE;
		EXPORT EquifaxEmsRecords := FALSE;
		EXPORT ComplianceData := FALSE;
	END;

END;
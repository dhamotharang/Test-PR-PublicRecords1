EXPORT Constants := MODULE

  EXPORT GatewayStatus := MODULE
    EXPORT INTEGER NOCALL := 0;
    EXPORT INTEGER SUCCESS := 200;
    EXPORT INTEGER ERROR := 400;
  END;

  EXPORT ValidationCode := MODULE
    EXPORT INTEGER NONE := 0;
    EXPORT INTEGER DID_MATCH := 100;
    EXPORT INTEGER INPUT_DID_NOTFOUND := 110;  // input PII could not be resolved to LexID
    EXPORT INTEGER OUTPUT_DID_NOTFOUND := 111; // gateway output could not be resolved to LexID
    EXPORT INTEGER DID_MISMATCH := 112; // input/out did mismatch
    EXPORT INTEGER NO_CALL := 113; // gateway was never called
    EXPORT INTEGER INVALID_RESPONSE := 114; // gateway had an invalid response
    EXPORT INTEGER REMOTE_LINKING_MATCH := 115; // remote linking found a match
  END;

  ValidationCodes := DATASET ([
    {ValidationCode.NONE, ''},
    {ValidationCode.DID_MATCH, 'OK'},
    {ValidationCode.INPUT_DID_NOTFOUND, 'Input does not resolve to LexID.'},
    {ValidationCode.OUTPUT_DID_NOTFOUND, 'Output does not resolve to LexID.'},
    {ValidationCode.DID_MISMATCH, 'Failed to validate consumer LexID.'},
    {ValidationCode.NO_CALL, 'Gateway was not called.'},
    {ValidationCode.INVALID_RESPONSE, 'Gateway had invalid response.'},
    {ValidationCode.REMOTE_LINKING_MATCH, 'Remote Linking was a match.'}
    ], {INTEGER code, STRING description});

  DictValidationCodesDesc := DICTIONARY (ValidationCodes, {code => description});

  EXPORT GetValidationCodeDesc(INTEGER validationCode) := DictValidationCodesDesc[validationCode].description;

  EXPORT Debug := MODULE
    EXPORT ComplianceData := FALSE;
    EXPORT EquifaxEmsSoapcall := FALSE;
    EXPORT EquifaxEmsGateway := FALSE;
    EXPORT EquifaxEmsRecords := FALSE;
    EXPORT TuFraudAlertSoapCall := FALSE;
    EXPORT TuDidvilleVerification := FALSE;
    EXPORT TuFraudAlertRecords := FALSE;
  END;

END;
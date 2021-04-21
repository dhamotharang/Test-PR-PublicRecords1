EXPORT Constants := MODULE

  EXPORT GatewayStatus := MODULE
    EXPORT INTEGER NOCALL := 0;
    EXPORT INTEGER SUCCESS := 200;
    EXPORT INTEGER ERROR := 400;
  END;

  EXPORT Bureaus := MODULE
    EXPORT STRING Equifax    := 'Equifax';
    EXPORT STRING Experian   := 'Experian';
    EXPORT STRING Transunion := 'Transunion';
  END;

  EXPORT ValidationCode := MODULE
    EXPORT INTEGER NONE := 0;
    EXPORT INTEGER DID_MATCH := 100;
    EXPORT INTEGER INPUT_DID_NOTFOUND := 110;  // input PII could not be resolved to LexID
    EXPORT INTEGER OUTPUT_DID_NOTFOUND := 111; // gateway output could not be resolved to LexID
    EXPORT INTEGER DID_MISMATCH := 112; // input/out did mismatch
    EXPORT INTEGER NO_CALL := 113; // gateway was never called
    EXPORT INTEGER INVALID_RESPONSE := 114; // gateway had an invalid response
    EXPORT INTEGER LOCK := 115; // Bureau placed a lock on credit report
    EXPORT INTEGER FREEZE := 116; // Bureau placed a freeze on credit report
    EXPORT INTEGER LOCK_AND_FREEZE := 117; // Bureau placed a lock and freeze on credit report
  END;

  ValidationCodes := DATASET ([
    {ValidationCode.NONE, ''},
    {ValidationCode.DID_MATCH, 'OK'},
    {ValidationCode.INPUT_DID_NOTFOUND, 'Input does not resolve to LexID.'},
    {ValidationCode.OUTPUT_DID_NOTFOUND, 'Output does not resolve to LexID.'},
    {ValidationCode.DID_MISMATCH, 'Failed to validate consumer LexID.'},
    {ValidationCode.NO_CALL, 'Gateway was not called.'},
    {ValidationCode.INVALID_RESPONSE, 'Gateway had invalid response.'},
    {ValidationCode.LOCK, 'Bureau placed a lock on credit report.'},
    {ValidationCode.FREEZE, 'Bureau placed a freeze on credit report.'},
    {ValidationCode.LOCK_AND_FREEZE, 'Bureau placed a lock and freeze on credit report.'}
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

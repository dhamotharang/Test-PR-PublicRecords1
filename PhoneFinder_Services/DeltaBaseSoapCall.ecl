EXPORT DeltaBaseSoapCall(SelectStatements, DeltabaseURL, gatewayTimeout, gatewayRetries, responseRec) := FUNCTIONMACRO		
IMPORT PhoneFinder_Services;
	responseRec soapFailure(PhoneFinder_Services.Layouts.DeltabaseInput le) := TRANSFORM
		SELF.ExceptionMessage := FAILMESSAGE + ' ' + FAILCODE;
		SELF := le;
		SELF := [];
	END;
	SOAPResults := IF(DeltabaseURL != '', 
											SOAPCALL(SelectStatements,
															 DeltabaseURL,
															 'DeltaBasePreparedSql',
															 {SelectStatements},                         
															 DATASET(responseRec),
															 XPATH('DeltaBaseSelectResponse'),
															 onFail(soapFailure(LEFT)),
															 RETRY(gatewayRetries), TIMEOUT(gatewayTimeout)),
											DATASET([], responseRec));
// OUTPUT(SOAPResults);
	RETURN SOAPResults;
ENDMACRO;
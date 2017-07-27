EXPORT DeltaBaseSoapCall(SelectStatements, DeltabaseURL, gatewayTimeout, gatewayRetries, responseRec) := FUNCTIONMACRO		
IMPORT Phones;
	responseRec soapFailure(Phones.Layouts.Deltabase.dInput le) := TRANSFORM
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
	RETURN SOAPResults;
ENDMACRO;
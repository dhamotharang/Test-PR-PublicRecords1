
EXPORT SoapCall_DeltabaseSQL(in_requests, URL, waittime, retries, response_layout) := FUNCTIONMACRO		

  select_statements := PROJECT(in_requests, TRANSFORM(Gateway.Layouts.DeltabaseSQL.input_rec, SELF:=LEFT, SELF:=[]));

	response_layout Failx(Gateway.Layouts.DeltabaseSQL.input_rec le) := TRANSFORM
		SELF.ExceptionMessage := FAILCODE + ':' + FAILMESSAGE + ':' + FAILMESSAGE('soapresponse');
		SELF := le;
		SELF := [];
	END;
  
	SOAPResults := IF(URL != '', 
											SOAPCALL(select_statements,
															 URL,
															 'DeltaBasePreparedSql',
															 {select_statements},                         
															 DATASET(response_layout),
															 XPATH('DeltaBaseSelectResponse'),
															 ONFAIL(Failx(LEFT)),
															 RETRY(retries), 
                               TIMEOUT(waittime)),
											DATASET([], response_layout));
	RETURN SOAPResults;
ENDMACRO;
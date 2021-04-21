IMPORT Gateway, Inquiry_Deltabase, inquiry_acclogs;

EXPORT Inquiry_Deltabase.Layouts.Deltabase_Response SoapCall_Deltabase(DATASET(Inquiry_Deltabase.Layouts.Deltabase_Input) Deltabase_Query, 
													DATASET(Gateway.Layouts.Config) Gateways = Gateway.Constants.void_gateway, 
													INTEGER gatewayTimeout = 2, // The Deltabase has a 2 second timeout
													INTEGER gatewayRetries = 0) := FUNCTION

	Deltabase_URL := TRIM(Gateways (StringLib.StringToLowerCase(ServiceName) = 'delta_inquiry')[1].URL, LEFT, RIGHT);

	MakeGatewayCall := IF(Deltabase_URL <> '', TRUE, FALSE);

	Inquiry_Deltabase.Layouts.Deltabase_Response soapFailure(Inquiry_Deltabase.Layouts.Deltabase_Input le) := TRANSFORM
		SELF.ExceptionMessage := FAILMESSAGE + ' ' + FAILCODE;
		SELF := le;
		SELF := [];
	END;

	SOAP_Results1 := IF(MakeGatewayCall, 
										SOAPCALL(Deltabase_Query,
														 Deltabase_URL,
														 'DeltaBasePreparedSql',
														 {Deltabase_Query},                         
														 DATASET(Inquiry_Deltabase.Layouts.Deltabase_Response),
														 XPATH('DeltaBaseSelectResponse'),
														 onFail(soapFailure(LEFT)),
														 RETRY(gatewayRetries), 
														 TIMEOUT(gatewayTimeout)),
										DATASET([], Inquiry_Deltabase.Layouts.Deltabase_Response));

	// force the soap results to come back before doing the join to the optout key
	deltabase_records := PROJECT(SOAP_Results1.response, TRANSFORM(Inquiry_Deltabase.Layouts.Deltabase_Record, self.company_id := left.company_ID; self := left) );
	
  //get rid of companies which have opted out
  SOAP_Results_OptOut := JOIN(deltabase_records, inquiry_acclogs.key_lookup_company_optout, KEYED((UNSIGNED8)LEFT.Company_ID = RIGHT.Company_ID),
  TRANSFORM(Inquiry_Deltabase.Layouts.Deltabase_Record, SELF := LEFT, SELF := []), atmost(100), LEFT ONLY);
	
	soap_results := project(SOAP_Results1, transform(Inquiry_Deltabase.Layouts.Deltabase_Response,
		self.response := SOAP_Results_OptOut,
		self.recordsreturned := left.recordsreturned;  // hang onto the count of how many were originally returned from the deltabase prior to optoput
		self := left));
	

	
  RETURN(soap_results);
	
END;
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

	SOAP_Results := IF(MakeGatewayCall, 
										SOAPCALL(Deltabase_Query,
														 Deltabase_URL,
														 'DeltaBasePreparedSql',
														 {Deltabase_Query},                         
														 DATASET(Inquiry_Deltabase.Layouts.Deltabase_Response),
														 XPATH('DeltaBaseSelectResponse'),
														 onFail(soapFailure(LEFT)),
														 RETRY(gatewayRetries), TIMEOUT(gatewayTimeout)),
										DATASET([], Inquiry_Deltabase.Layouts.Deltabase_Response));
   
  //get rid of companies which have opted out
  SOAP_Results_OptOut := JOIN(SOAP_Results.Response, inquiry_acclogs.key_lookup_company_optout, KEYED((UNSIGNED8)LEFT.Company_ID = RIGHT.Company_ID),
  TRANSFORM(Inquiry_Deltabase.Layouts.Deltabase_Response, SELF := LEFT, SELF := []), LEFT ONLY);
										
  RETURN(SOAP_Results_OptOut);
END;
IMPORT Gateway, Inquiry_Deltabase, Risk_Indicators, RiskWise, UT;

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
										
	RETURN(SOAP_Results);
END;
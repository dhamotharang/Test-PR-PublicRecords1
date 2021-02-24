import iesp, Gateway;

EXPORT SoapCall_InsuranceNAP(dataset(iesp.phoneheaderscore.t_PhoneHeaderScoreRequest) df, 
														 Gateway.Layouts.Config gateway_cfg,														 
														 integer timeout=1, 
														 integer retries=1,
														 BOOLEAN makeGatewayCall = FALSE) := function

	gateway_URL := gateway_cfg.url;

	iesp.phoneheaderscore.t_PhoneHeaderScoreRequest into_input(iesp.phoneheaderscore.t_PhoneHeaderScoreRequest le) := TRANSFORM
		SELF.seq := le.seq;
		SELF.User.ReferenceCode := gateway_cfg.TransactionId;
		SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
		SELF := le;
		SELF := [];
	END;
	
	input := PROJECT(df, into_input(LEFT));
	
	iesp.phoneheaderscore.t_PhoneHeaderScoreResponseEx errX(iesp.phoneheaderscore.t_PhoneHeaderScoreRequest le) := TRANSFORM
		SELF.Response._Header.Message := FAILMESSAGE;
		SELF.Response._Header.Status := FAILCODE;
		SELF.Response._Header.QueryId := le.seq;//le.User.QueryId;
		SELF := [];
	END;

	soapout := IF(TRIM(gateway_URL) <> '' AND COUNT(input) > 0 AND makeGatewayCall, 
							SOAPCALL(
												input,
												gateway_URL,
												'PhoneHeaderScore',
												{input},  							
												DATASET(iesp.phoneheaderscore.t_PhoneHeaderScoreResponseEx),
												XPATH('PhoneHeaderScoreResponseEx'),
												ONFAIL(errX(LEFT)), 
												TIMEOUT(timeout), 
												RETRY(retries)
											)
								);					

	RETURN soapout;
	
END;
IMPORT iesp, FCRAGateway_Services, Gateway, Royalty;

EXPORT SoapCall_TuFraudAlert(
	DATASET(iesp.tu_fraud_alert.t_TuFraudAlertRequest) ds_tufa_req,
	DATASET(Gateway.Layouts.Config) gateways,
	BOOLEAN makeGatewayCall=FALSE,
	INTEGER waittime=10,
	INTEGER retries=Gateway.Constants.Defaults.RETRIES) := FUNCTION

	//Get the URL for the TUFraudAlert gateway
	tufa_gw := gateways(Gateway.Configuration.IsTuFraudAlert(servicename))[1];

	//This transform adds default values and gateway params required for the gateway ESP.
	iesp.tu_fraud_alert.t_TuFraudAlertRequest setGatewayDefaults(iesp.tu_fraud_alert.t_TuFraudAlertRequest L) := TRANSFORM
		//Set standard gateway parameters.
		SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(tufa_gw);
		SELF.GatewayParams.BatchJobId       := Gateway.Configuration.GetBatchJobId(tufa_gw);
		SELF.GatewayParams.ProcessSpecId    := Gateway.Configuration.GetBatchspecId(tufa_gw);
		SELF.GatewayParams.QueryName        := Gateway.Configuration.GetRoxieQueryName(tufa_gw);
		SELF.GatewayParams.RoyaltyCode      := Royalty.Constants.RoyaltyCode.TU_FRAUD_ALERT;
		SELF.GatewayParams.RoyaltyType      := Royalty.Constants.RoyaltyType.TU_FRAUD_ALERT;
		SELF.GatewayParams.CheckVendorGatewayCall := TRUE;
		SELF.GatewayParams.MakeVendorGatewayCall  := makeGatewayCall;
		SELF.Options.Blind := Gateway.Configuration.GetBlindOption(tufa_gw);
		SELF:=L;
	END;

	//Support a long soap message for failures which contains XML tags.
	extended_response := RECORD (iesp.tu_fraud_alert.t_TuFraudAlertResponseEx)
		STRING soap_message {MAXLENGTH(8000)} := '';
	END;

	//This executes when we get a response with status <> 200
	extended_response failX(iesp.tu_fraud_alert.t_TuFraudAlertRequest L) := TRANSFORM
		SELF.soap_message := FAILMESSAGE('soapresponse');
		SELF := L;
		SELF := [];
	END;

	//Define the soapcall transform. This allows us to save request data to the response.
	extended_response doSoapCall(iesp.tu_fraud_alert.t_TuFraudAlertRequest L) := TRANSFORM

		//Add the gateway parameters and required default values to the request.
		ds_soapReq:= PROJECT(DATASET([L], iesp.tu_fraud_alert.t_TuFraudAlertRequest), setGatewayDefaults(LEFT));
		ds_soapResp:= SOAPCALL(ds_soapReq, tufa_gw.URL, 'TuFraudAlert', iesp.tu_fraud_alert.t_TuFraudAlertRequest,
			TRANSFORM(iesp.tu_fraud_alert.t_TuFraudAlertRequest, SELF := LEFT, SELF := []),
			DATASET(extended_response),XPATH('TuFraudAlertResponseEx'),
			ONFAIL(failx(LEFT)),RETRY(retries),TIMEOUT(waittime),TRIM,LOG);

		//Save the query ID since it's not returned by SOAPCALL
		SELF.response._header.QueryId := L.User.QueryId;

		//Save the response and any soap_message from a non 200 response.
		SELF.response := ds_soapResp[1].response;
		SELF.soap_message := ds_soapResp[1].soap_message;
	END;

	//Make the SOAP call, or just return an empty dataset if we shouldn't make the call.
	soapResp := IF(makeGatewayCall, PROJECT(ds_tufa_req, doSoapCall(LEFT)));

	//This transform parses any data in soap_message and sets the status for royalty tracking.
	iesp.tu_fraud_alert.t_TuFraudAlertResponseEx pickupSoapMessage(extended_response L) := TRANSFORM
		//Parse any soap fault messages and project them to the standard exception layout.
		soapMsg := DATASET([L.soap_message],{STRING line});
		parsedSoapResponse := PARSE(soapMsg,line,FCRAGateway_Services.Layouts.fault_rec,XML('soap:Envelope/soap:Body/soap:Fault'));
		soapFault := PROJECT(parsedSoapResponse, iesp.share.t_WsException);

		//For royalty tracking we count status of 200 as a charge.
		//We are charged as long as we get no error code and a customer data code.
		isResponseInvalid := EXISTS(soapFault) OR L.response.errorControl.RecordCode <> '' OR L.response.CustomerData.RecordCode = '';

		//Set the value for status based on the response.
		SELF.response._header.status := MAP(
			makeGatewayCall = FALSE => FCRAGateway_Services.Constants.GatewayStatus.NOCALL,
			isResponseInvalid => FCRAGateway_Services.Constants.GatewayStatus.ERROR,
			FCRAGateway_Services.Constants.GatewayStatus.SUCCESS
		);

		//Save the soap fault exceptions and put the first soap fault message in the header message for visibility.
		SELF.response._header.Message := soapFault[1].Message;
		SELF.response._header.Exceptions := CHOOSEN(soapFault + L.response._header.Exceptions,
			iesp.Constants.MaxResponseExceptions);
		SELF := L;
	END;

	#IF(FCRAGateway_Services.Constants.Debug.TuFraudAlertSoapCall)
		OUTPUT(makeGatewayCall, NAMED('makeGatewayCall'));
		OUTPUT(tufa_gw, NAMED('tufa_gw'));
		OUTPUT(ds_tufa_req, NAMED('ds_tufa_req'));
		OUTPUT(soapResp, NAMED('soapResp'));
	#END

	//Parse any soap messages and return the response.
	RETURN PROJECT(soapResp, pickupSoapMessage(LEFT));

END;
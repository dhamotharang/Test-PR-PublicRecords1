IMPORT iesp,Royalty;

EXPORT SoapCall_GG2Verification(DATASET(iesp.gg2_iid_intl.t_InstantIDIntl2Request) gg2Req,
																Layouts.Config gateway_cfg,
																INTEGER waittime = Constants.Defaults.WAIT_TIMEOUT, 
																INTEGER retries = Constants.Defaults.RETRIES,
																BOOLEAN makeGatewayCall = FALSE) := FUNCTION

	STRING QueryId := gg2Req[1].User.QueryId;

	extended_response := RECORD(iesp.gg2_response.t_GG2VerificationResponseEx)
		STRING soap_message {MAXLENGTH (8000)} := '';
		DATASET(iesp.share.t_WsException) Exceptions {XPATH('Exceptions/Exception'),MAXCOUNT(iesp.Constants.MaxResponseExceptions)};
	END;

	extended_response failX(iesp.gg2_verify.t_GG2VerificationRequest L) := TRANSFORM	
		SELF.soap_message := FAILMESSAGE('soapresponse');
		SELF := L;
		SELF := [];
	END;

	iesp.gg2_response.t_GG2VerificationResponseEx FormatFail(extended_response L) := TRANSFORM
		faultRec := RECORD
			STRING Source := XMLTEXT('faultactor');
			INTEGER Code := (INTEGER) XMLTEXT('faultcode');
			STRING Location := XMLTEXT('Location');
			STRING Message := XMLTEXT('faultstring');
		END;

		soapMsg := DATASET([L.soap_message],{STRING line});
		parsedSoapResponse := PARSE(soapMsg,line,faultRec,XML('soap:Envelope/soap:Body/soap:Fault'));
		faults := PROJECT(parsedSoapResponse,iesp.share.t_WsException);

		INTEGER errCode := IF(faults[1].Code!=0,faults[1].Code,L.exceptions[1].Code);
		STRING errMessage := IF(faults[1].Message!='',faults[1].Message,L.exceptions[1].Message);

		SELF.response._header.QueryId := QueryId;
		SELF.response._header.GeneralErrorCode := IF(errCode=0,'',(STRING)errCode);
		SELF.response._header.GeneralErrorDescription := errMessage;
		SELF.response._header.Exceptions := CHOOSEN(faults+L.exceptions,iesp.Constants.MaxResponseExceptions);
		SELF := L;
	END;

	soapReq := PROJECT(gg2Req,TRANSFORM(iesp.gg2_verify.t_GG2VerificationRequest,
	
		// Royalty tracking
		SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
		SELF.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
		SELF.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
		SELF.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
		SELF.GatewayParams.RoyaltyCode 			:= Royalty.Functions.GetGG2RoyaltyCode(left.searchby.Country);
		SELF.GatewayParams.RoyaltyType 			:= Royalty.Functions.GetGG2RoyaltyType(left.searchby.Country);	
		
		// Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
		// compatibility on Gateway ESP side in case of non-roxie calls.
		SELF.GatewayParams.CheckVendorGatewayCall := true; 
		SELF.GatewayParams.MakeVendorGatewayCall 	:= makeGatewayCall;				
		SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
		SELF:=LEFT));

	STRING serviceURL := gateway_cfg.URL;
	soapResp := IF(makeGatewayCall AND serviceURL!='',
		SOAPCALL(soapReq,serviceURL,gateway_cfg.ServiceName,
		{soapReq},DATASET(extended_response),
		XPATH('GG2VerificationResponseEx'),ONFAIL(failx(LEFT)),
		RETRY(retries),TIMEOUT(waittime),TRIM,LOG));

	gg2Resp := PROJECT(soapResp,FormatFail(LEFT));

	// output(serviceURL,named('serviceURL'));
	// output(gateway_cfg.ServiceName,named('ServiceName'));
	// output(gg2Req,named('gg2Req'));
	// output(soapReq,named('soapReq'));
	// output(soapResp,named('soapResp'));

	RETURN gg2Resp;
END;
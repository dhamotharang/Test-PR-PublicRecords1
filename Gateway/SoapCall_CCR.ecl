IMPORT doxie, iesp, Gateway, Royalty, STD;

EXPORT SoapCall_CCR(DATASET(iesp.conscredit_req.t_ConsumerCreditReportRequest) ccrReq,
										Gateway.Layouts.Config gateway_cfg,
										BOOLEAN makeGatewayCall=FALSE,
										INTEGER waittime=Gateway.Constants.Defaults.WAIT_TIMEOUT, 
										INTEGER retries=Gateway.Constants.Defaults.RETRIES
										) := FUNCTION

	iesp.conscredit_req.t_ConsumerCreditReportRequest setGatewayParams(ccrReq L) := TRANSFORM
		// Royalty tracking
		SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
		SELF.GatewayParams.BatchJobId       := Gateway.Configuration.GetBatchJobId(gateway_cfg);
		SELF.GatewayParams.ProcessSpecId    := Gateway.Configuration.GetBatchspecId(gateway_cfg);
		SELF.GatewayParams.QueryName        := Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
		SELF.GatewayParams.RoyaltyCode      := Royalty.Constants.RoyaltyCode.EFX_CCR;
		SELF.GatewayParams.RoyaltyType      := Royalty.Constants.RoyaltyType.EFX_CCR;
		SELF.GatewayParams.CheckVendorGatewayCall := TRUE;
		SELF.GatewayParams.MakeVendorGatewayCall  := makeGatewayCall;
		SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
		SELF:=L;
	END;

	soapReq := PROJECT(ccrReq,setGatewayParams(LEFT));

	extended_response := RECORD (iesp.conscredit_resp.t_ConsumerCreditReportResponseEx)
		STRING soap_message {MAXLENGTH(8000)} := '';
	END;

	extended_response failX(iesp.conscredit_req.t_ConsumerCreditReportRequest L) := TRANSFORM	
		SELF.soap_message := FAILMESSAGE('soapresponse');
		SELF := L;
		SELF := [];
	END;

	extended_response doSoapCall(soapReq L) := TRANSFORM
		ds_soapReq:=DATASET([L],iesp.conscredit_req.t_ConsumerCreditReportRequest);
		ds_soapResp:=SOAPCALL(ds_soapReq,gateway_cfg.URL,gateway_cfg.ServiceName,{ds_soapReq},
			DATASET(extended_response),XPATH('ConsumerCreditReportResponseEx'),
			ONFAIL(failx(LEFT)),RETRY(retries),TIMEOUT(waittime),TRIM,LOG);
		SELF.response._header.QueryId:=L.User.QueryId;
		SELF.response:=ds_soapResp[1].response;
		SELF.soap_message:=ds_soapResp[1].soap_message;
	END;

	soapResp := IF(makeGatewayCall,PROJECT(soapReq,doSoapCall(LEFT)),DATASET([],extended_response));

	iesp.conscredit_resp.t_ConsumerCreditReportResponseEx pickupSoapMessage(extended_response L) := TRANSFORM
		faultRec := RECORD  
			STRING  Source   := XMLTEXT('faultactor');
			INTEGER Code     := (INTEGER) XMLTEXT('faultcode');
			STRING  Location := XMLTEXT('Location');
			STRING  Message  := XMLTEXT('faultstring');
		END;
		soapMsg := DATASET([L.soap_message],{STRING line});
		// the SOAP message can be in XML or TEXT
		parsedSoapResponse := MAP(
			STD.Str.Find(soapMsg[1].line,'<soap:Fault>')>0 => PARSE(soapMsg,line,faultRec,XML('soap:Envelope/soap:Body/soap:Fault')),
			L.soap_message!='' => DATASET([{'Roxie',100,'',doxie.ErrorCodes(100)}],faultRec),
			DATASET([],faultRec));
		soapFault := PROJECT(parsedSoapResponse,iesp.share.t_WsException);
		SELF.response._header.Status := soapFault[1].Code;
		SELF.response._header.Message := soapFault[1].Message;
		SELF.response._header.Exceptions := CHOOSEN(soapFault,iesp.Constants.MaxResponseExceptions);
		SELF:=L;
	END;

	RETURN PROJECT(soapResp,pickupSoapMessage(LEFT));
END;
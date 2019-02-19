IMPORT iesp, Gateway, AutoKeyI, Royalty, STD;

EXPORT SoapCall_BriteVerify(DATASET(iesp.briteverify_email.t_BriteVerifyEmailRequest) ds_bv_req,
                            DATASET(Gateway.Layouts.Config) gateways,
                            BOOLEAN makeGatewayCall=FALSE,
                            INTEGER waittime=10,
                            INTEGER retries=Gateway.Constants.Defaults.RETRIES) := FUNCTION

	//Get the URL for the BV email gateway
	bv_gw := gateways(Gateway.Configuration.IsBriteVerifyEmail(servicename))[1];
  ESP_Method := Gateway.Constants.ServiceName.BriteVerifyEmail;

	soap_err := AutoKeyI.errorcodes._codes.SOAP_ERR;
	soap_msg := AutoKeyI.errorcodes._msgs(soap_err);

	//Set the gateway parameters, including royalty codes.
	iesp.briteverify_email.t_BriteVerifyEmailRequest setGatewayParams(iesp.briteverify_email.t_BriteVerifyEmailRequest L) := TRANSFORM
		SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(bv_gw);
		SELF.GatewayParams.BatchJobId       := Gateway.Configuration.GetBatchJobId(bv_gw);
		SELF.GatewayParams.ProcessSpecId    := Gateway.Configuration.GetBatchspecId(bv_gw);
		SELF.GatewayParams.QueryName        := Gateway.Configuration.GetRoxieQueryName(bv_gw);
		SELF.GatewayParams.RoyaltyCode      := Royalty.Constants.RoyaltyCode.BRITE_VERIFY_EMAIL;
		SELF.GatewayParams.RoyaltyType      := Royalty.Constants.RoyaltyType.BRITE_VERIFY_EMAIL;
		SELF.GatewayParams.CheckVendorGatewayCall := TRUE;
		SELF.GatewayParams.MakeVendorGatewayCall  := makeGatewayCall;
		SELF.Options.Blind := Gateway.Configuration.GetBlindOption(bv_gw);
		SELF:=L;
	END;

	//Add the gateway parameters to the request.
	soap_req := PROJECT(ds_bv_req, setGatewayParams(LEFT));

	fault_rec := RECORD  
		STRING  Source   := XMLTEXT('faultactor');
		INTEGER Code     := (INTEGER) XMLTEXT('faultcode');
		STRING  Location := XMLTEXT('Location');
		STRING  Message  := XMLTEXT('faultstring');
	END;

	extended_response_rec := RECORD (iesp.briteverify_email.t_BriteVerifyEmailResponseEx)
		STRING soap_message {MAXLENGTH(8000)} := '';
	END;

	extended_response_rec FailX() := TRANSFORM	
		SELF.soap_message := FAILMESSAGE('soapresponse');
		SELF.response._header.Status := FAILCODE;
		SELF.response._header.Message := FAILMESSAGE;
		SELF := [];
	END;

	extended_response_rec setSoapError():=TRANSFORM
		SELF.response._header.Status := soap_err;
		SELF.response._header.Message := soap_msg;
		SELF.response._header.Exceptions := DATASET([{'Roxie',soap_err,'',soap_msg}],iesp.share.t_WsException);
		SELF:=[];
	END;

	extended_response_rec doSoapCall(iesp.briteverify_email.t_BriteVerifyEmailRequest L) := TRANSFORM
		ds_soapReq := DATASET([L],iesp.briteverify_email.t_BriteVerifyEmailRequest);
    ds_soapResp := SOAPCALL(ds_soapReq,
                          bv_gw.URL,
                          ESP_Method, 
                          iesp.briteverify_email.t_BriteVerifyEmailRequest,
                          TRANSFORM(iesp.briteverify_email.t_BriteVerifyEmailRequest, SELF := LEFT, SELF := []),
                          DATASET(extended_response_rec),
                          XPATH('BriteVerifyEmailResponseEx'),
			                    ONFAIL(FailX()),
                          RETRY(retries),
                          TIMEOUT(waittime),
                          TRIM,LOG);
		SELF.response._header.QueryId:=L.User.QueryId;
		SELF.response:=ds_soapResp[1].response;
		SELF.soap_message:=ds_soapResp[1].soap_message;
		SELF:=[];
	END;

	soap_resp := IF(bv_gw.URL!='', PROJECT(soap_req,doSoapCall(LEFT)), DATASET([setSoapError()]));

	iesp.briteverify_email.t_BriteVerifyEmailResponse pickupSoapMessage(extended_response_rec L) := TRANSFORM
		hasSoapMsg:=L.soap_message!='';
		dsSoapMsg := DATASET([L.soap_message],{STRING line});
		// the SOAP message can be in XML or TEXT
		parsedSoapMessage := MAP( STD.Str.Find(L.soap_message,'<soap:Fault>')>0 => PARSE(dsSoapMsg,line,fault_rec,XML('soap:Envelope/soap:Body/soap:Fault')),
                              hasSoapMsg => DATASET([{'Roxie',soap_err,'',soap_msg}],fault_rec),
                              DATASET([],fault_rec));
		soapFault := PROJECT(parsedSoapMessage,iesp.share.t_WsException);
    
		SELF._header.Status := IF(hasSoapMsg OR L.response._header.status = soap_err, soap_err,
                              Gateway.Constants.defaults.STATUS_SUCCESS);
		SELF._header.Message := IF(hasSoapMsg, soapFault[1].Message, L.response._header.Message);
		SELF._header.Exceptions := IF(hasSoapMsg, CHOOSEN(soapFault,iesp.Constants.MaxResponseExceptions), L.response._header.Exceptions);
		SELF:=L.response;
	END;

	// OUTPUT(soap_req,NAMED('soapRequest'));
	// OUTPUT(soap_resp,NAMED('soapResponse'));

	res := IF(makeGatewayCall, PROJECT(soap_resp, pickupSoapMessage(LEFT)), DATASET([],iesp.briteverify_email.t_BriteVerifyEmailResponse));

  RETURN res;
END;



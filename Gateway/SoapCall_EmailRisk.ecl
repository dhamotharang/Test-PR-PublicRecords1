//soapcall to the emailrisk
IMPORT AutoKeyI, Gateway, iesp, STD;

EXPORT SoapCall_EmailRisk(
  DATASET(iesp.emailrisk.t_EmailRiskRequest) ds_req,
  Gateway.Layouts.Config gateway_cfg,
  BOOLEAN makeGatewayCall = FALSE,
  INTEGER waittime = 5,
  INTEGER retries = 1,
  INTEGER num_threads = 2
  ) := FUNCTION

  make_soap_call := gateway_cfg.url <> '';
  soap_err := AutoKeyI.errorcodes._codes.SOAP_ERR;
  soap_msg := AutoKeyI.errorcodes._msgs(soap_err);

  soap_req := PROJECT(ds_req, TRANSFORM(iesp.emailrisk.t_EmailRiskRequest,
    SELF.User.ReferenceCode := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
    SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
    SELF.GatewayParams.BatchJobId := Gateway.Configuration.GetBatchJobId(gateway_cfg);
    SELF.GatewayParams.ProcessSpecId := Gateway.Configuration.GetBatchSpecId(gateway_cfg);
    SELF.GatewayParams.QueryName := Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
    SELF.GatewayParams.CheckVendorGatewayCall := TRUE;
    SELF.GatewayParams.MakeVendorGatewayCall := makeGatewayCall;
    SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
    SELF := LEFT;
  ));

  extended_response_rec := RECORD (iesp.emailrisk.t_EmailRiskResponseEx)
    STRING soap_message {MAXLENGTH(8000)} := '';
  END;

  extended_response_rec failX() := TRANSFORM
    SELF.soap_message := FAILMESSAGE('soapresponse');
    SELF.response._header.message := FAILMESSAGE;
    SELF.response._header.status := FAILCODE;
    SELF := [];
  END;

  extended_response_rec setSoapError() := TRANSFORM
    SELF.response._header.Status := soap_err;
    SELF.response._header.Message := soap_msg;
    SELF.response._header.Exceptions := DATASET([{'Roxie', soap_err, '', soap_msg}], iesp.share.t_WsException);
    SELF := [];
  END;

  soap_resp := SOAPCALL(
    soap_req,
    gateway_cfg.url,
    gateway_cfg.ServiceName,
    {soap_req},
    DATASET(extended_response_rec),
    XPATH('EmailRiskResponseEx'),
    ONFAIL(failx()),
    PARALLEL(num_threads),
    TIMEOUT(waittime),
    RETRY(retries),
    TRIM
  );

  soap_error := DATASET([setSoapError()]);

  soap_resp_final := IF(make_soap_call, soap_resp, soap_error);

  fault_rec := RECORD
    STRING Source := XMLTEXT('faultactor');
    INTEGER Code := (INTEGER) XMLTEXT('faultcode');
    STRING Location := XMLTEXT('Location');
    STRING Message := XMLTEXT('faultstring');
  END;

  iesp.emailrisk.t_EmailRiskResponse pickupSoapMessage(extended_response_rec L) := TRANSFORM
    hasSoapMsg := L.soap_message != '';
    dsSoapMsg := DATASET([L.soap_message], {STRING line});
    parsedSoapMessage := MAP(STD.Str.Find(L.soap_message, '<soap:Fault>') > 0 => PARSE(dsSoapMsg, line, fault_rec, XML('soap:Envelope/soap:Body/soap:Fault')),
                             hasSoapMsg => DATASET([{'Roxie', soap_err, '', soap_msg}], fault_rec),
                             DATASET([],fault_rec));
    soapFault := PROJECT(parsedSoapMessage, iesp.share.t_WsException);

    SELF._header.Status := IF(hasSoapMsg OR L.response._header.status = soap_err, soap_err,
                              Gateway.Constants.defaults.STATUS_SUCCESS);
    SELF._header.Message := IF(hasSoapMsg, soapFault[1].Message, L.response._header.Message);
    SELF._header.Exceptions := IF(hasSoapMsg, CHOOSEN(soapFault, iesp.Constants.MaxResponseExceptions), L.response._header.Exceptions);
    SELF := L.response;
  END;

  response := IF(makeGatewayCall, PROJECT(soap_resp_final, pickupSoapMessage(LEFT)));

  RETURN response;

END;

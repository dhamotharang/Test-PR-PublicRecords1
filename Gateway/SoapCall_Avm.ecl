IMPORT Doxie, Gateway, iesp, Royalty;

req_layout := iesp.avm_internal_req.t_AVMInternalRequest;
resp_layout := iesp.avm_internal_resp3.t_AVMInternalResponseEx;

EXPORT SoapCall_Avm(
  req_layout request,
  DATASET(Gateway.layouts.config) gateways,

  // Leave waittime at 20, vendor gateway can be slow during testing.
  INTEGER waittime=20,
  INTEGER retries=0
) := FUNCTION

  avm_gw := gateways(Gateway.Configuration.IsAvm(servicename))[1];
  make_soapcall := avm_gw.url <> '';

  req_layout setGatewayParams() := TRANSFORM
    SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(avm_gw);
    SELF.GatewayParams.BatchJobId := Gateway.Configuration.GetBatchJobId(avm_gw);
    SELF.GatewayParams.ProcessSpecId := Gateway.Configuration.GetBatchspecId(avm_gw);
    SELF.GatewayParams.QueryName := Gateway.Configuration.GetRoxieQueryName(avm_gw);
    SELF.GatewayParams.RoyaltyCode := Royalty.Constants.RoyaltyCode.AVM;
    SELF.GatewayParams.RoyaltyType := Royalty.Constants.RoyaltyType.AVM;
    SELF.GatewayParams.CheckVendorGatewayCall := TRUE;
    SELF.GatewayParams.MakeVendorGatewayCall := make_soapcall;
    SELF.Options.Blind := Gateway.Configuration.GetBlindOption(avm_gw);
    SELF := request;
  END;

  req_w_gw := DATASET([setGatewayParams()]);

  // Support soap error long messages.
  extended_layout := record(resp_layout)
    string soap_message {maxlength (8000)} := '';
  END;

  extended_layout failX() := TRANSFORM
    SELF.soap_message := FAILMESSAGE('soapresponse');
    SELF.Response._Header.Status := 22;
    SELF.Response._Header.Message := Doxie.ErrorCodes(22);
    SELF.Response._Header.Exceptions := DATASET([{'', FAILCODE, '', FAILMESSAGE }], iesp.share.t_WsException);
    SELF := [];
  END;

  soap_response := SOAPCALL(req_w_gw,
    avm_gw.url,
    Gateway.Constants.ServiceName.Avm,
    req_layout,
    TRANSFORM(req_layout, SELF := LEFT, SELF := []),
    DATASET(extended_layout),XPATH('AVMInternalResponseEx'),
    ONFAIL(failX()), TIMEOUT(waittime), RETRY(retries),TRIM);

  // This stops SOAPCALL from creating an exception if the gateway url is missing.
  results := IF(make_soapcall, soap_response);

  // OUTPUT(req_w_gw, NAMED('req_w_gw'));
  // OUTPUT(make_soapcall, NAMED('make_soapcall'));
  // OUTPUT(avm_gw, NAMED('avm_gw'));;
  // OUTPUT(soap_response, NAMED('soap_response'));
  // OUTPUT(results, NAMED('soap_results'));

  // Concat the actual message for failure to the failure response.
  RETURN results;
END;

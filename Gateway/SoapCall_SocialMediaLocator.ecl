IMPORT Gateway, iesp, Royalty;

req_layout := iesp.social_media_locator_request.t_SocialMediaLocatorRequest;
resp_layout := iesp.social_media_locator_response.t_SocialMediaLocatorResponseEx;

EXPORT SoapCall_SocialMediaLocator(
  req_layout request,
  DATASET(Gateway.layouts.config) gateways,
  // The waittime of 60 seconds is on purpose, the vendor gateway is very slow.
  INTEGER waittime=60,
  INTEGER retries=0
) := FUNCTION

  sml_gw := gateways(Gateway.Configuration.IsSocialMediaLocator(servicename))[1];
  make_soapcall := sml_gw.url <> '';

  req_layout setGatewayParams() := TRANSFORM
    SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(sml_gw);
    SELF.GatewayParams.BatchJobId       := Gateway.Configuration.GetBatchJobId(sml_gw);
    SELF.GatewayParams.ProcessSpecId    := Gateway.Configuration.GetBatchspecId(sml_gw);
    SELF.GatewayParams.QueryName        := Gateway.Configuration.GetRoxieQueryName(sml_gw);
    SELF.GatewayParams.RoyaltyCode      := Royalty.Constants.RoyaltyCode.SMLOCATOR;
    SELF.GatewayParams.RoyaltyType      := Royalty.Constants.RoyaltyType.SMLOCATOR;
    SELF.GatewayParams.CheckVendorGatewayCall := TRUE;
    SELF.GatewayParams.MakeVendorGatewayCall  := make_soapcall;
    SELF.Options.Blind := Gateway.Configuration.GetBlindOption(sml_gw);
    SELF := request;
  END;

  req_w_gw := DATASET([setGatewayParams()]);

  // Support soap error long messages.
  extended_layout := record(resp_layout)
    string soap_message {maxlength (8000)} := '';
  END;

  extended_layout failX() := TRANSFORM
    SELF.soap_message := FAILMESSAGE('soapresponse');
    SELF.Response._Header.Status  := FAILCODE;
    SELF.Response._Header.Message := FAILMESSAGE;
    SELF := [];
  END;

  soap_response := SOAPCALL(req_w_gw,
    sml_gw.url,
    Gateway.Constants.ServiceName.SocialMediaLocator,
    req_layout,
    TRANSFORM(req_layout, SELF := LEFT, SELF := []),
    DATASET(extended_layout),XPATH('SocialMediaLocatorResponseEx'),
    ONFAIL(failX()), TIMEOUT(waittime), RETRY(retries),TRIM);

  //This stops SOAPCALL from creating an exception if the gateway url is missing.
  results := IF(make_soapcall, soap_response);
  RETURN results;
END;

IMPORT Gateway, iesp, Royalty, STD;

req_layout := iesp.gw_ca_avm_request.t_CaAvmReportRequest;
resp_layout := iesp.gw_ca_avm_response.t_CaAvmReportResponseEx;

EXPORT SoapCall_CaAvmReport(
  req_layout request,
  DATASET(Gateway.layouts.config) gateways,
  INTEGER waittime=10,
  INTEGER retries=0
) := FUNCTION

  ca_avm_gw := gateways(Gateway.Configuration.IsCaAvmReport(servicename))[1];
  product_code := STD.Str.ToUpperCase(request.Options.CaProductCode);
  make_soapcall := ca_avm_gw.url <> '';

  req_layout setGatewayParams() := TRANSFORM
    SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(ca_avm_gw);
    SELF.GatewayParams.BatchJobId := Gateway.Configuration.GetBatchJobId(ca_avm_gw);
    SELF.GatewayParams.ProcessSpecId := Gateway.Configuration.GetBatchspecId(ca_avm_gw);
    SELF.GatewayParams.QueryName := Gateway.Configuration.GetRoxieQueryName(ca_avm_gw);
    SELF.GatewayParams.RoyaltyCode := Royalty.RoyaltyCaAvmReport.royalties[product_code].royalty_type_code;
    SELF.GatewayParams.RoyaltyType := Royalty.RoyaltyCaAvmReport.royalties[product_code].royalty_type;
    SELF.GatewayParams.CheckVendorGatewayCall := TRUE;
    SELF.GatewayParams.MakeVendorGatewayCall := make_soapcall;
    SELF.Options.Blind := Gateway.Configuration.GetBlindOption(ca_avm_gw);

    // Set required defaults. ESP is not used to sending these values.
    SELF.AvmRequest.CompsType := IF(request.AvmRequest.CompsType = '', 'carrier', request.AvmRequest.CompsType);
    SELF.AvmRequest.MarketAnalysis := IF(request.AvmRequest.MarketAnalysis = '', 'all', request.AvmRequest.MarketAnalysis);
    SELF := request;
  END;

  req_w_gw := DATASET([setGatewayParams()]);

  // Support soap error long messages.
  extended_layout := record(resp_layout)
    string soap_message {maxlength (8000)} := '';
  END;

  extended_layout failX() := TRANSFORM
    SELF.soap_message := FAILMESSAGE('soapresponse');
    SELF.Response._Header.Status := FAILCODE;
    SELF.Response._Header.Message := FAILMESSAGE;
    SELF := [];
  END;

  soap_response := SOAPCALL(req_w_gw,
    ca_avm_gw.url,
    Gateway.Constants.ServiceName.CaAvmReport,
    req_layout,
    TRANSFORM(req_layout, SELF := LEFT, SELF := []),
    DATASET(extended_layout),XPATH('CaAvmReportResponseEx'),
    ONFAIL(failX()), TIMEOUT(waittime), RETRY(retries),TRIM);

  //This stops SOAPCALL from creating an exception if the gateway url is missing.
  results := IF(make_soapcall, soap_response);
  RETURN results;
END;

IMPORT Gateway, ut;

req_layout := $.layouts.t_KeyDecryptionRequest;
soap_res := $.layouts.decrypted;

EXPORT FN_SoapCall_KeyDecryption(
  DATASET($.layouts.t_Key) keys,
  string pem_public,
  DATASET(Gateway.layouts.config) gateways,
  INTEGER waittime=100,
  INTEGER retries=0
) := FUNCTION

  // _gw := gateways(Gateway.Configuration.IsCaAvmReport(servicename))[1];
  gw := gateways(servicename = inql_ffd._Constants.decryption_servicename)[1];
  make_soapcall := gw.url <> '';

  req_layout setGatewayParams() := TRANSFORM
    SELF.User.ReferenceCode := 'qqqaaazzz';
    SELF.RSAPublicKeyPEM := pem_public;
    SELF.keys := keys;
    // SELF.Options.Blind := Gateway.Configuration.GetBlindOption(ca_avm_gw);
    SELF := []; //Header
  END;

  ds_request := DATASET([setGatewayParams()]);

  soap_res failX() := TRANSFORM
    SELF.soap_message := FAILMESSAGE('soapresponse');
    SELF.Response._Header.Status := FAILCODE;
    SELF.Response._Header.Message := FAILMESSAGE;
    SELF := [];
  END;

  soap_response := SOAPCALL(ds_request,
    gw.url,
    inql_ffd._Constants.decryption_servicename,
    req_layout,
    TRANSFORM(req_layout, SELF := LEFT),
    DATASET(soap_res),XPATH('KeyDecryptionResponseEx'),
    HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues()),
    ONFAIL(failX()), TIMEOUT(waittime), RETRY(retries), TRIM);

  //This stops SOAPCALL from creating an exception if the gateway url is missing.
  results := IF(make_soapcall, soap_response);

  RETURN results;
END;

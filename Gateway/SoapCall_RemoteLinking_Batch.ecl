IMPORT Gateway, InsuranceHeader_RemoteLinking;

//This is a SOAPCALL to remote_linking which is an internal roxie service.
//We don't need to send parameters relevant to external gateways.
EXPORT SoapCall_RemoteLinking_Batch(
  DATASET(InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout_Batch) request,
  DATASET(Gateway.layouts.config) gateways,
  INTEGER waittime=10,
  INTEGER retries=Gateway.Constants.Defaults.RETRIES
) := FUNCTION

  //Grab the remote linking URL. Remote linking uses neutral roxie.
  rl_gw := gateways(Gateway.Configuration.IsNeutralRoxie(servicename))[1];
  make_soapcall := rl_gw.url <> '';

  //Wrap the request in field "inputdata" as a dataset which is required by the service.
  request_layout := RECORD
    DATASET(InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout_Batch) input_data;
  END;

  request_layout format_request() := TRANSFORM
    SELF.input_data := request;
  END;

  formatted_request := DATASET([format_request()]);

  //Add a field for SOAPCALL errors to the response.
  extended_response := RECORD(InsuranceHeader_RemoteLinking.Layouts.ServiceOutputLayout_Batch)
    STRING fail_message {MAXLENGTH(8000)} := '';
    INTEGER fail_code := 0;
  END;

  extended_response failX() := TRANSFORM
    SELF.fail_message := FAILMESSAGE('soapresponse');
    SELF.fail_code := FAILCODE;
    SELF := [];
  END;

  soap_response := SOAPCALL(formatted_request,
    rl_gw.url,
    InsuranceHeader_RemoteLinking.Constants.HEADER_SERVICE_NAME,
    request_layout,
    TRANSFORM(request_layout, SELF := LEFT, SELF := []),
    DATASET(extended_response),
    ONFAIL(failX()), TIMEOUT(waittime), RETRY(retries));

  //This stops SOAPCALL from creating an exception if the gateway url is missing.
  results := IF(make_soapcall, soap_response);
  RETURN results;
END;
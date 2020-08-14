IMPORT iesp;
EXPORT Exp_SoapCall_Function(DATASET(iesp.experian_vin.t_ExperianVinRequest) vinReq, STRING service_URL, INTEGER waittime=20, INTEGER retries=0) := FUNCTION

  // intermediate layout to accommodate for longer soap messages
  extended_response := RECORD (iesp.experian_vin.t_ExperianVinResponseEx)
    STRING soap_message {MAXLENGTH (8000)} := '';
  END;

  extended_response failX(vinReq L) := TRANSFORM
    SELF.soap_message := FAILMESSAGE('soapresponse');
    SELF := L;
    SELF := [];
  END;

  iesp.experian_vin.t_ExperianVinResponseEx FormatFail(extended_response L) := TRANSFORM
    rec := RECORD
      STRING Source := XMLTEXT('Source');
      INTEGER Code := (INTEGER) XMLTEXT('faultcode');
      STRING Location := XMLTEXT('Location');
      STRING Message := XMLTEXT('faultstring');
    END;
    
    ds := DATASET([L.soap_message],{STRING line});
    parsedSoapResponse := PARSE(ds,line,rec,XML('soap:Envelope/soap:Body/soap:Fault'));
    ds_e := PROJECT(parsedSoapResponse,iesp.share.t_WsException);

    SELF.response._header.Exceptions := CHOOSEN (ds_e, iesp.Constants.MaxResponseExceptions);
    INTEGER errorC := ds_e[1].code;
    SELF.response.response.errorIndicator := IF(errorC=0,'',(STRING)errorC);
    SELF.response._header.Message := ds_e[1].Message;
    SELF := L;
  END;

  STRING serviceName := 'ExperianVIN';
  vinResp := SOAPCALL(vinReq,service_URL,serviceName,{vinReq},
    DATASET(extended_response),XPATH('ExperianVinResponseEx'),
    ONFAIL(failx(LEFT)),RETRY(retries),TIMEOUT(waittime),TRIM,LOG);
  
  RETURN PROJECT(vinResp,FormatFail(LEFT));

END;

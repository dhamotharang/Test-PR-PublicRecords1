IMPORT iesp;
EXPORT Polk_SoapCall_Function(DATASET(iesp.gateway_polk.t_VehicleCheckRequest) Inf, STRING gateway_URL, INTEGER waittime=20, INTEGER retries=0) := FUNCTION

  iesp.gateway_polk.t_VehicleCheckRequest into_in(inf L) := TRANSFORM
    SELF := L;
  END;

  // intermediate layout to accommodate for longer soap messages
  extended_response := RECORD (iesp.gateway_polk.t_VehicleCheckResponseEx)
    STRING soap_message {MAXLENGTH (8000)} := '';
  END;

  extended_response failX(inf L) := TRANSFORM
    SELF.soap_message := FAILMESSAGE('soapresponse');
    SELF:=l;
    SELF := [];
  END;

  iesp.gateway_polk.t_VehicleCheckResponseEx FormatFail(extended_response L) := TRANSFORM
    rec:=RECORD
      STRING Source :=XMLTEXT('Source');
      INTEGER Code := (INTEGER) XMLTEXT('faultcode');
      STRING Location := XMLTEXT('Location');
      STRING Message := XMLTEXT('faultstring');
    END;
    
    ds := DATASET([L.soap_message],{STRING line});
    parsedSoapResponse := parse (ds,line, rec, xml('soap:Envelope/soap:Body/soap:Fault'));
    ds_e:=PROJECT(parsedSoapResponse,iesp.share.t_WsException);

    SELF.response._header.Exceptions:= CHOOSEN (ds_e, iesp.Constants.MaxResponseExceptions);
    INTEGER errorC := ds_e[1].code;
    SELF.response.response.ErrorCode := IF (errorC = 0, '', (STRING)errorC);
    SELF.response._header.Message := ds_e[1].Message;
    SELF:=l;
  END;


  outf := soapcall (inf, gateway_URL, 'VehicleCheck', iesp.gateway_polk.t_VehicleCheckRequest,
                  into_in(LEFT), DATASET(extended_response),
                  XPATH('VehicleCheckResponseEx'),
                  onfail(failx(LEFT)),RETRY(retries),TIMEOUT(waittime),TRIM,LOG
                 );
                 
  RETURN PROJECT (outf, FormatFail (LEFT));

         
END;

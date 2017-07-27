IMPORT iesp;
export Polk_SoapCall_Function(dataset(iesp.gateway_polk.t_VehicleCheckRequest) Inf, string gateway_URL, INTEGER waittime=20, INTEGER retries=0) := function

	iesp.gateway_polk.t_VehicleCheckRequest into_in(inf L) := transform
		self := L;
	end;

  // intermediate layout to accommodate for longer soap messages 
  extended_response := record (iesp.gateway_polk.t_VehicleCheckResponseEx)
    string soap_message {maxlength (8000)} := '';
  end;

	extended_response failX(inf L) := transform	
		self.soap_message := FAILMESSAGE('soapresponse');
		self:=l;
		self := [];
	end;

	iesp.gateway_polk.t_VehicleCheckResponseEx FormatFail(extended_response L) := transform
		rec:=record  
			string Source :=XMLTEXT('Source');
			integer Code := (integer) XMLTEXT('faultcode');
			string Location := XMLTEXT('Location');
			string Message := XMLTEXT('faultstring');
		end;
		
		ds := dataset([L.soap_message],{string line});
		parsedSoapResponse := parse (ds,line, rec, xml('soap:Envelope/soap:Body/soap:Fault'));
		ds_e:=project(parsedSoapResponse,iesp.share.t_WsException);

		self.response._header.Exceptions:= choosen (ds_e, iesp.Constants.MaxResponseExceptions);
		integer errorC := ds_e[1].code;
		self.response.response.ErrorCode := IF (errorC = 0, '', (STRING)errorC);
		self.response._header.Message := ds_e[1].Message;
		self:=l;
	end;


	outf := soapcall (inf, gateway_URL, 'VehicleCheck', iesp.gateway_polk.t_VehicleCheckRequest, 
                  into_in(LEFT), dataset(extended_response),
                  XPATH('VehicleCheckResponseEx'),
                  onfail(failx(LEFT)),RETRY(retries),TIMEOUT(waittime),TRIM,LOG
                 );
								 
  return project (outf, FormatFail (Left));

			   
end;

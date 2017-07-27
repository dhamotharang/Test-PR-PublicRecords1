// replacement for VehicleV2_Services.Polk_SoapCall_Function

IMPORT iesp,Royalty;

export SoapCall_Polk(dataset(iesp.gateway_polk.t_VehicleCheckRequest) Inf, 
										 Layouts.Config gateway_cfg, 
										 integer waittime = Constants.Defaults.WAIT_TIMEOUT_POLK, 
										 integer retries 	= Constants.Defaults.RETRIES,
										 boolean makeGatewayCall = false) := function

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

	iesp.gateway_polk.t_VehicleCheckRequest into_in(inf L) := transform		
		self.User.ReferenceCode := if(L.User.ReferenceCode<>'', L.User.ReferenceCode, gateway_cfg.TransactionId),
		// Royalty tracking
		self.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
		self.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
		self.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchspecId(gateway_cfg);
		self.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
		self.GatewayParams.RoyaltyCode 			:= Royalty.Constants.RoyaltyCode.POLK;
		self.GatewayParams.RoyaltyType 			:= Royalty.Constants.RoyaltyType.POLK;	
		
		// Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
		// compatibility on Gateway ESP side in case of non-roxie calls.
		self.GatewayParams.CheckVendorGatewayCall := true; 
		self.GatewayParams.MakeVendorGatewayCall 	:= makeGatewayCall;
		self.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
		self := L;
	end;
	
	outf := soapcall (inf, 
										gateway_cfg.Url, 
										'VehicleCheck', 
										iesp.gateway_polk.t_VehicleCheckRequest, 
										into_in(LEFT), 
										dataset(extended_response),
										XPATH('VehicleCheckResponseEx'),
										onfail(failx(LEFT)),
										RETRY(retries),
										TIMEOUT(waittime),
										TRIM,
										LOG
									);

	outf_f := project (outf, FormatFail (Left));
	 
	return outf_f;		   
end;

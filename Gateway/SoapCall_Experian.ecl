IMPORT iesp, Royalty;

// replacement for VehicleV2_Services.Exp_SoapCall_Function

EXPORT SoapCall_Experian(DATASET(iesp.experian_vin.t_ExperianVinRequest) vinReq, 
												 Layouts.Config gateway_cfg,
												 integer waittime = Constants.Defaults.WAIT_TIMEOUT_EXPERIAN, 
												 integer retries	= Constants.Defaults.RETRIES,
												 boolean makeGatewayCall = false) := FUNCTION

  // intermediate layout to accommodate for longer soap messages 
  extended_response := record (iesp.experian_vin.t_ExperianVinResponseEx)
    string soap_message {maxlength (8000)} := '';
  end;

	extended_response failX(vinReq L) := TRANSFORM	
    SELF.soap_message := FAILMESSAGE('soapresponse');
		SELF := L;
		SELF := [];
	END;

	iesp.experian_vin.t_ExperianVinResponseEx FormatFail(extended_response L) := TRANSFORM
		rec := RECORD  
			STRING  Source   := XMLTEXT('Source');
			INTEGER Code     := (INTEGER) XMLTEXT('faultcode');
			STRING  Location := XMLTEXT('Location');
			STRING  Message  := XMLTEXT('faultstring');
		END;
		
		ds := DATASET([L.soap_message],{STRING line});
		parsedSoapResponse := PARSE(ds,line,rec,XML('soap:Envelope/soap:Body/soap:Fault'));
		ds_e := PROJECT(parsedSoapResponse,iesp.share.t_WsException);

		SELF.response._header.Exceptions := choosen (ds_e, iesp.Constants.MaxResponseExceptions);
		INTEGER errorC := ds_e[1].code;
		SELF.response.response.errorIndicator := IF(errorC=0,'',(STRING)errorC);
		SELF.response._header.Message := ds_e[1].Message;
		SELF := L;
	END;

	vinReq_r := project(vinReq, 
											transform(iesp.experian_vin.t_ExperianVinRequest,
																self.User.ReferenceCode := if(left.User.ReferenceCode<>'', left.User.ReferenceCode, gateway_cfg.TransactionId),
																// Royalty tracking
																self.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
																self.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
																self.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
																self.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
																self.GatewayParams.RoyaltyCode 			:= Royalty.Constants.RoyaltyCode.EXPERIAN;
																self.GatewayParams.RoyaltyType 			:= Royalty.Constants.RoyaltyType.EXPERIAN;	
																
																// Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
																// compatibility on Gateway ESP side in case of non-roxie calls.
																self.GatewayParams.CheckVendorGatewayCall := true; 
																self.GatewayParams.MakeVendorGatewayCall 	:= makeGatewayCall;
																SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
																self := left));

	STRING serviceName := 'ExperianVIN';
	vinResp := SOAPCALL(vinReq_r,
											gateway_cfg.Url,
											serviceName,
											{vinReq_r},
											DATASET(extended_response),
											XPATH('ExperianVinResponseEx'),
											ONFAIL(failx(LEFT)),
											RETRY(retries),
											TIMEOUT(waittime),
											TRIM,
											LOG);
	
	vinResp_f := PROJECT(vinResp,FormatFail(LEFT));
	
  RETURN vinResp_f;

END;

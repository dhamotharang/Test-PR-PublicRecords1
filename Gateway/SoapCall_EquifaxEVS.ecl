import gateway, iesp, ut, royalty;


export iesp.equifax_evs.t_EquifaxEvsResponseEx SoapCall_EquifaxEVS(dataset(iesp.equifax_evs.t_EquifaxEvsRequest) Inf,		                                   
																			Gateway.Layouts.Config gateway_cfg,
																			boolean call_gateway = false,
																			integer waittime = 5, 
																			integer retries	= 1) := 
function
																				 
	  invalid_gateway := IF(gateway_cfg.url = '',FAIL(dataset([],iesp.equifax_evs.t_EquifaxEvsResponseEx),
															ut.constants_MessageCodes.GATEWAY_URL_MISSING,
															ut.MessageCode(ut.constants_MessageCodes.GATEWAY_URL_MISSING,'')[1].msg));
	
		 soapReq := PROJECT(inf, TRANSFORM(iesp.equifax_evs.t_EquifaxEvsRequest,		
			SELF.User.ReferenceCode := if(LEFT.User.ReferenceCode<>'', LEFT.User.ReferenceCode, gateway_cfg.TransactionId),
			
			// Royalty tracking
			SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
			SELF.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
			SELF.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
			SELF.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
			SELF.GatewayParams.RoyaltyCode 			:= if(LEFT.options.VerifyIncome,
																								 Royalty.Constants.RoyaltyCode.EFX_TWN_VOI_GW,
																								 Royalty.Constants.RoyaltyCode.EFX_TWN_VOE_GW
																								);
			SELF.GatewayParams.RoyaltyType 			:= if(LEFT.options.VerifyIncome,
																								 Royalty.Constants.RoyaltyType.EFX_TWN_VOI_GW,
																								 Royalty.Constants.RoyaltyType.EFX_TWN_VOE_GW
																								);
			
			// Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
			// compatibility on Gateway ESP side in case of non-roxie calls.
			SELF.GatewayParams.CheckVendorGatewayCall := true; 
			SELF.GatewayParams.MakeVendorGatewayCall 	:= call_gateway;				
			SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
			SELF := LEFT;
			SELF := [];
			));

		iesp.equifax_evs.t_EquifaxEvsResponseEx failX(inf L) := transform	
			self.response._header.Message := FAILMESSAGE('soapresponse');
			self.response._header.Status := -1;
			self:=l;
			self := [];
		end;

		rec:=record  
				string Source :=XMLTEXT('Source');
				integer Code := (integer) XMLTEXT('faultcode');
				string Location := XMLTEXT('Location');
				string Message := XMLTEXT('faultstring');
		end;
			
  		iesp.equifax_evs.t_EquifaxEvsResponseEx FormatFinal(iesp.equifax_evs.t_EquifaxEvsResponseEx L) := transform
      			ds := dataset([L.response._header.Message],{string256 line});
      			parsedSoapResponse := parse (ds,line, rec, xml('soap:Envelope/soap:Body/soap:Fault'));
      			ds_e:=project(parsedSoapResponse,iesp.share.t_WsException);
      
      			self.response._header.Exceptions:=ds_e;
      			integer errorC := ds_e[1].code;
      			self.response._header.Message := ds_e[1].Message;
      			self:=l;
      		end;

		
		outf := if (call_gateway,
                soapcall (soapReq, gateway_cfg.url, gateway_cfg.ServiceName, //iesp.equifax_evs.t_EquifaxEvsRequest*/, 
									{soapReq},
                  dataset(iesp.equifax_evs.t_EquifaxEvsResponseEx),
                  XPATH('EquifaxEvsResponseEx'),
                  onfail(failx(LEFT)), RETRY(retries), TIMEOUT(waittime), TRIM, LOG
                 ));
								 
		

/* 	output(call_gateway,named('call_gateway'));	
   	output(soapReq,named('soapReq'));	
   	output(outf,named('outf'));	
*/
	
	
	//return project (outf, FormatFinal (Left));
		return(outf);
		// pass return fields into layout
	end; 

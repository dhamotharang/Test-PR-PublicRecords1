// replacement for InView_Services.Get_Equifax_Bus_Data.EquiFax_Gateway_SoapCall_Function

import gateway, iesp, ut, royalty;

// Test:
// https://lnproxy.seisint.com:9024/WsPrism/BusinessInview?form&ver_=1.61

inview_rec_ex := iesp.gateway_inviewreport.t_InviewReportResponseEx;

export inview_rec_ex SoapCall_Equifax(dataset(iesp.gateway_inviewreport.t_InviewReportRequest) Inf,		                                   
																			Layouts.Config gateway_cfg,
																			boolean call_gateway = false,
																			integer waittime = 20, 
																			integer retries	= 0) := 
function
																				 
	  invalid_gateway := IF(gateway_cfg.url = '',FAIL(dataset([],iesp.gateway_skiptrace.t_SkipTraceSearchResponseEx),
															ut.constants_MessageCodes.GATEWAY_URL_MISSING,
															ut.MessageCode(ut.constants_MessageCodes.GATEWAY_URL_MISSING,'')[1].msg));
	
		soapReq := PROJECT(inf, TRANSFORM(iesp.gateway_inviewreport.t_InviewReportRequest,		
			SELF.User.ReferenceCode := if(LEFT.User.ReferenceCode<>'', LEFT.User.ReferenceCode, gateway_cfg.TransactionId),
			
			// Royalty tracking
			_IncludeBCR 	:= LEFT.options.IncludeBusinessCreditRisk;
			_IncludeBFR 	:= LEFT.options.IncludeBusinessFailureRiskLevel;
			_IncludeBCIR 	:= LEFT.options.IncludeCustomBCIR;
			SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
			SELF.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
			SELF.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
			SELF.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
			SELF.GatewayParams.RoyaltyCode 			:= Royalty.Functions.GetInviewRoyaltyCode(_IncludeBCR, _IncludeBFR , _IncludeBCIR);
			SELF.GatewayParams.RoyaltyType 			:= Royalty.Functions.GetInviewRoyaltyType(_IncludeBCR, _IncludeBFR , _IncludeBCIR);	
			
			// Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
			// compatibility on Gateway ESP side in case of non-roxie calls.
			SELF.GatewayParams.CheckVendorGatewayCall := true; 
			SELF.GatewayParams.MakeVendorGatewayCall 	:= call_gateway;				
			SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
			SELF := LEFT;
			));

		inview_rec_ex failX(inf L) := transform	
			self.response._header.Message := FAILMESSAGE('soapresponse');
			self:=l;
			self := [];
		end;

		inview_rec_ex FormatFail(inview_rec_ex L) := transform
			rec:=record  
				string Source :=XMLTEXT('Source');
				integer Code := (integer) XMLTEXT('faultcode');
				string Location := XMLTEXT('Location');
				string Message := XMLTEXT('faultstring');
			end;
		
			ds := dataset([L.response._header.Message],{string line});
			parsedSoapResponse := parse (ds,line, rec, xml('soap:Envelope/soap:Body/soap:Fault'));
			ds_e:=project(parsedSoapResponse,iesp.share.t_WsException);

			self.response._header.Exceptions:=ds_e;
			integer errorC := ds_e[1].code;
			self.response._header.Message := ds_e[1].Message;
			self:=l;
		end;
		
		outf := if (call_gateway,
                soapcall (soapReq, gateway_cfg.url, 'InviewReport', //iesp.gateway_inviewreport.t_InviewReportRequest, 
									{soapReq},
                  dataset(inview_rec_ex),
                  XPATH('InviewReportResponseEx'),
                  onfail(failx(LEFT)), RETRY(retries), TIMEOUT(waittime), TRIM, LOG
                 ));
		
		return project (outf, FormatFail (Left));
		// pass return fields into layout
	end; // EquiFax_Gateway_SoapCall_Function

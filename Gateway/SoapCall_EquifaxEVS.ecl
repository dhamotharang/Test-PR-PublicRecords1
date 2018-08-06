IMPORT gateway, iesp, ut, royalty;

EXPORT iesp.equifax_evs.t_EquifaxEvsResponseEx SoapCall_EquifaxEVS(DATASET(iesp.equifax_evs.t_EquifaxEvsRequest) Inf,                                       
                                      Gateway.Layouts.Config gateway_cfg,
                                      BOOLEAN call_gateway = FALSE,
                                      INTEGER waittime = 5, 
                                      INTEGER retries  = 1) := 
FUNCTION
                                         
    invalid_gateway := IF(gateway_cfg.url = '',FAIL(DATASET([],iesp.equifax_evs.t_EquifaxEvsResponseEx),
                              ut.constants_MessageCodes.GATEWAY_URL_MISSING,
                              ut.MessageCode(ut.constants_MessageCodes.GATEWAY_URL_MISSING,'')[1].msg));
  
     soapReq := PROJECT(inf, TRANSFORM(iesp.equifax_evs.t_EquifaxEvsRequest,    
      SELF.User.ReferenceCode := if(LEFT.User.ReferenceCode<>'', LEFT.User.ReferenceCode, gateway_cfg.TransactionId),
      
      // Royalty tracking
      SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
      SELF.GatewayParams.BatchJobId       := Gateway.Configuration.GetBatchJobId(gateway_cfg);
      SELF.GatewayParams.ProcessSpecId     := Gateway.Configuration.GetBatchSpecId(gateway_cfg);
      SELF.GatewayParams.QueryName         := Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
      SELF.GatewayParams.RoyaltyCode       := if(LEFT.options.VerifyIncome,
                                                 Royalty.Constants.RoyaltyCode.EFX_TWN_VOI_GW,
                                                 Royalty.Constants.RoyaltyCode.EFX_TWN_VOE_GW
                                                );
      SELF.GatewayParams.RoyaltyType       := if(LEFT.options.VerifyIncome,
                                                 Royalty.Constants.RoyaltyType.EFX_TWN_VOI_GW,
                                                 Royalty.Constants.RoyaltyType.EFX_TWN_VOE_GW
                                                );
      
      // Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
      // compatibility on Gateway ESP side in case of non-roxie calls.
      SELF.GatewayParams.CheckVendorGatewayCall := true; 
      SELF.GatewayParams.MakeVendorGatewayCall   := call_gateway;        
      SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
      SELF := LEFT;
      SELF := [];
    ));

    extended_response := RECORD (iesp.equifax_evs.t_EquifaxEvsResponseEx)
      STRING soap_message {MAXLENGTH(8000)} := '';
    END;

    extended_response failX(iesp.equifax_evs.t_EquifaxEvsRequest L) := TRANSFORM
      SELF.soap_message := FAILMESSAGE('soapresponse');
      SELF := L;
      SELF := [];
    END;

    soapMsg_rec:=RECORD  
        STRING Source :=XMLTEXT('Source');
        INTEGER Code := (integer) XMLTEXT('faultcode');
        STRING Location := XMLTEXT('Location');
        STRING Message := XMLTEXT('faultstring');
    end;

    iesp.equifax_evs.t_EquifaxEvsResponseEx FormatFinal(extended_response L) := TRANSFORM
      soapMsg := DATASET([L.soap_message],{STRING line});
      parsedSoapResponse := PARSE(soapMsg, line, soapMsg_rec, XML('soap:Envelope/soap:Body/soap:Fault'));
      soapFault := PROJECT(parsedSoapResponse,iesp.share.t_WsException);

      SELF.response._header.Message := soapFault[1].Message;
      SELF.response._header.status := IF(EXISTS(soapFault), -1, 0);
      SELF.response._header.Exceptions := CHOOSEN(soapFault, iesp.Constants.MaxResponseExceptions);
      SELF := L;
    END;
  
    outf := IF (call_gateway,
                SOAPCALL (soapReq, gateway_cfg.url, gateway_cfg.ServiceName, //iesp.equifax_evs.t_EquifaxEvsRequest*/, 
                  {soapReq},
                  DATASET(extended_response),
                  XPATH('EquifaxEvsResponseEx'),
                  ONFAIL(failx(LEFT)), RETRY(retries), TIMEOUT(waittime), TRIM, LOG
                 ));
                 
    

/*   output(call_gateway,named('call_gateway'));  
     output(soapReq,named('soapReq'));  
     output(outf,named('outf'));  
*/
  
  
    RETURN PROJECT (outf, FormatFinal (LEFT));
END; 

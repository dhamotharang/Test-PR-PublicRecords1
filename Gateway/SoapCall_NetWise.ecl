IMPORT Doxie, dx_gateway, Gateway, iesp, Royalty;

EXPORT SoapCall_NetWise(DATASET(iesp.net_wise.t_NetWiseQueryRequest) ds_recs_in,
                        Gateway.Layouts.Config gateway_cfg,
                        INTEGER timeout=Gateway.NetwiseSearch.Constants.GW_TIMEOUT,
                        INTEGER retries=Gateway.NetWiseSearch.Constants.GW_RETRIES,
                        BOOLEAN makeGatewayCall = FALSE,
                        Gateway.NetWiseSearch.IParams.SearchParams in_mod //,
                        //BOOLEAN apply_opt_out = FALSE // CCPA opt out use
                       ) := FUNCTION

  // Use a transform to set certain fields.
  iesp.net_wise.t_NetWiseQueryRequest tf_IntoRequest(iesp.net_wise.t_NetWiseQueryRequest L)
                                      := TRANSFORM 
 
    SELF.User.ReferenceCode := if(L.User.ReferenceCode<>'', TRIM(L.User.ReferenceCode), 
                                                            gateway_cfg.TransactionId),

    // Royalty tracking
    SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
    SELF.GatewayParams.BatchJobId       := Gateway.Configuration.GetBatchJobId(gateway_cfg);
    SELF.GatewayParams.ProcessSpecId    := Gateway.Configuration.GetBatchspecId(gateway_cfg);
    SELF.GatewayParams.QueryName        := Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
    SELF.GatewayParams.RoyaltyCode      := Royalty.Constants.RoyaltyCode.NETWISE_EMAIL;
    SELF.GatewayParams.RoyaltyType      := Royalty.Constants.RoyaltyType.NETWISE_EMAIL;

    // Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
    // compatibility on Gateway ESP side in case of non-roxie calls.
    SELF.GatewayParams.CheckVendorGatewayCall := TRUE;
    SELF.GatewayParams.MakeVendorGatewayCall  := makeGatewayCall;

    SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);

    // Need to fill in the correct AppId info ESP is expecting
    SELF.SearchBy.AppId := in_mod.AppId; 
   
    SELF := L;
  END;

	ds_soap_request := PROJECT(ds_recs_in, tf_IntoRequest(LEFT));

  // Used for a gateway soapcall error,  
  // an intermediate layout to accommodate for longer soap messages 
  rec_extended_response := record (iesp.net_wise.t_NetWiseQueryResponseEx)
    string soap_message {maxlength (8000)} := '';
  END;

  rec_extended_response tf_OnFail() := TRANSFORM
    SELF.soap_message             := FAILMESSAGE('soapresponse');
    SELF.Response._Header.Status  := FAILCODE;
    SELF.Response._Header.Message := FAILMESSAGE;
    SELF := [];
  END;

  // Make the actual soapcall
	ds_soapcall_out := IF (makeGatewayCall, 
                         SOAPCALL(ds_soap_request, 
                                  gateway_cfg.url,
                                  'NetWiseQuery', 
                                  {ds_soap_request}, // <--- Note non-standard "{...}" format
                                  DATASET(rec_extended_response),
                                  XPATH('NetWiseQueryResponseEx'),
                                  ONFAIL(tf_OnFail()),
                                  TIMEOUT(timeout), 
                                  RETRY(retries)
                                 )
                        );

  // Handle soapmessage and put the soapcall output back onto the ...ResponseEx
  iesp.net_wise.t_NetWiseQueryResponseEx tf_Format_sc_out(rec_extended_response L) := TRANSFORM

    rec := RECORD  
      STRING  Source   := XMLTEXT('Source');
      INTEGER Code     := (INTEGER) XMLTEXT('faultcode');
      STRING  Location := XMLTEXT('Location');
      STRING  Message  := XMLTEXT('faultstring');
    END;

    ds := DATASET([L.soap_message],{STRING line});
    parsedSoapResponse := PARSE(ds,line,rec,XML('soap:Envelope/soap:Body/soap:Fault'));
    ds_e := PROJECT(parsedSoapResponse,iesp.share.t_WsException);

    SELF.Response._Header.Message := ds_e[1].Message;
    SELF.Response._Header.Exceptions := CHOOSEN(ds_e, iesp.Constants.MaxResponseExceptions);
    SELF := L;
  END;

	ds_final_out := PROJECT(ds_soapcall_out,tf_format_sc_out(LEFT));

  // FOR FUTURE(Phase 2) use when CCPA opt-out coding is implemented???
  /* v--- an example copied from Gateway.SoapCall_Targus
  d_recs_out_clean := dx_gateway.parser_targus.CleanResponse(d_recs_out, mod_access);
  return IF(apply_opt_out, d_recs_out_clean, d_recs_out);
  */
  //apply_opt_out = TRUE; // for initial phase 2 testing???
  // //Project in_mod onto Doxie.IDataAccess to strip off 'gateways' dataset and special ESP_AppID param
  //mod_access := PROJECT(in_mod, Doxie.IDataAccess); 
  //ds_final_out_clean := dx_gateway.parser_netwise.fn_CleanResponse(ds_final_out, mod_access);

  // Outputs for debugging.  Un-comment them as needed!
  //OUTPUT(ds_recs_in,        named('ds_recs_in'));
  //OUTPUT(gateway_cfg,       named('gateway_cfg'));
  //OUTPUT(ds_soap_request,   named('ds_soap_request'));
  //OUTPUT(ds_soapcall_out,   named('ds_soapcall_out'));
  //OUTPUT(ds_final_out,      named('ds_final_out'));
  //OUTPUT(ds_final_out_clean, named('ds_final_out_clean'));

  RETURN ds_final_out;  //phase 1; revise for Phase2, see below
  //RETURN IF(apply_opt_out, ds_final_out_clean, ds_final_out); //phase 2???

END;

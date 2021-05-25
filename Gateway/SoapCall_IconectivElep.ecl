IMPORT Doxie, dx_gateway, Gateway, iesp, PhoneFinder_Services;

EXPORT SoapCall_IconectivElep(DATASET(PhoneFinder_Services.Layouts.IconectivElepRequest_ext) ds_recs_in,
                              PhoneFinder_Services.iParam.SearchParams inMod,
                              DATASET(Gateway.Layouts.Config) ds_Gateways,
                              INTEGER timeout=Gateway.Constants.Defaults.ICONECTIV_ELEP_TIMEOUT,
                              INTEGER retries=Gateway.Constants.Defaults.ICONECTIV_ELEP_RETRIES,
                              UNSIGNED1 num_threads=1,
                              BOOLEAN makeGatewayCall = FALSE,
                              BOOLEAN apply_opt_out = FALSE // CCPA opt out use
                             ) := FUNCTION


  //Project in_mod onto Doxie.IDataAccess so it can be used in the dx_gateway.parser_iconectiv_elep 2 function calls below.
  mod_access := PROJECT(inMod, Doxie.IDataAccess);

  // Store gateway config info when correct service name passed in and set boolean based on non-blank url info.
  ds_gateway_cfg := ds_gateways(Gateway.Configuration.IsIconectivElep(servicename))[1];
  urlIsPresent := ds_gateway_cfg.url <> '';

  UNSIGNED1 NumThreads := IF(num_threads > $.Constants.Defaults.MAX_THREADS, $.Constants.Defaults.MAX_THREADS, num_threads);

  // Check any query input LexId in the gateway request for CCPA opt out
  ds_recs_in_clean := dx_gateway.parser_iconectiv_elep.fn_CleanRequest(ds_recs_in, mod_access);

  ds_recs_in_ready := IF(apply_opt_out, ds_recs_in_clean, ds_recs_in);

  // Use a transform to set certain fields on the actual gateway request layout.
  iesp.iconectiv_elep.t_IconectivElepRequest tf_IntoRequest(PhoneFinder_Services.Layouts.IconectivElepRequest_ext L)
                                             := TRANSFORM 
 
    SELF.User.ReferenceCode := if(L.User.ReferenceCode<>'', TRIM(L.User.ReferenceCode), 
                                                            ds_gateway_cfg.TransactionId),

    SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(ds_gateway_cfg);
    SELF.GatewayParams.BatchJobId       := Gateway.Configuration.GetBatchJobId(ds_gateway_cfg);
    SELF.GatewayParams.ProcessSpecId    := Gateway.Configuration.GetBatchspecId(ds_gateway_cfg);
    SELF.GatewayParams.QueryName        := Gateway.Configuration.GetRoxieQueryName(ds_gateway_cfg);
    // Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
    // compatibility on Gateway ESP side in case of non-roxie calls.
    SELF.GatewayParams.CheckVendorGatewayCall := TRUE;
    SELF.GatewayParams.MakeVendorGatewayCall  := makeGatewayCall;
    // NOTE: Unlike other Gateway.SoapCall_*** coding, no SELF.GatewayParams.RoyaltyCode or *.RoyaltyType fields need set here, 
    //       since product manager (Cindy Loizzo) confirmed we do no pay any royalties for this gateway.

    SELF.Options.Blind := Gateway.Configuration.GetBlindOption(ds_gateway_cfg);
   
    SELF := L; // from L input dataset, assign SearchBy.PhoneNumbers (just 1) dataset and Options.MaxHistoryCount
  END;

  ds_soap_request_in := PROJECT(ds_recs_in_ready, tf_IntoRequest(LEFT));

  // Used for a gateway soapcall error, an intermediate layout to accommodate for longer soap messages.
  rec_extended_response := record (iesp.iconectiv_elep.t_IconectivElepResponseEx)
    string soap_message {maxlength (8000)} := '';
  END;

  rec_extended_response tf_OnFail() := TRANSFORM
    SELF.soap_message             := FAILMESSAGE('soapresponse');
    SELF.Response._Header.Status  := FAILCODE;
    SELF.Response._Header.Message := FAILMESSAGE;
    SELF := [];
  END; 

  // Make the actual soapcall 
  // NOTE: conditonally checking for url value present stops the SOAPCALL from creating an exception if the gateway url is missing.
  ds_soapcall_out := IF (makeGatewayCall and urlIsPresent, 
                         SOAPCALL(ds_soap_request_in,
                                  ds_gateway_cfg.url,
                                  'IconectivElep', // <--- from iesp.iconectiv_elep.t_IconectivElepRequest record name without leading 't_' and trailing 'Request'
                                  {ds_soap_request_in}, // <--- Note non-standard "{...}" format
                                  DATASET(rec_extended_response),
                                  XPATH('IconectivElepResponseEx'), // <--- from iesp.iconectiv_elep.t_IconectivElepResponseEx record name without leading 't_'
                                  ONFAIL(tf_OnFail()),
                                  TIMEOUT(timeout), 
                                  PARALLEL(NumThreads),
                                  RETRY(retries)
                                 )
                        );

  // Handle soapmessage and put the soapcall output back onto the ...ResponseEx layout
  iesp.iconectiv_elep.t_IconectivElepResponseEx tf_Format_sc_out(rec_extended_response L) := TRANSFORM

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

  ds_soapcall_out_respex := PROJECT(ds_soapcall_out, tf_format_sc_out(LEFT));

  // Check gateway response data for CCPA opt out
  ds_soapcall_out_respclean := dx_gateway.parser_iconectiv_elep.fn_CleanResponse(ds_soapcall_out_respex, mod_access);


  // Outputs for debugging.  Un-comment them as needed!
  //OUTPUT(ds_recs_in,          NAMED('scie_ds_recs_in'));
  //OUTPUT(ds_recs_in_clean,    NAMED('scie_ds_recs_in_clean'));
  //OUTPUT(ds_recs_in_ready,    NAMED('scie_ds_recs_in_ready'));
  //OUTPUT(ds_gateway_cfg,      NAMED('scie_ds_gateway_cfg'));
  //OUTPUT(ds_soap_request_in,  NAMED('scie_ds_soap_request_in'));
  //OUTPUT(ds_soapcall_out,     NAMED('scie_ds_soapcall_out'));
  //OUTPUT(ds_soapcall_out_respex,  NAMED('scie_ds_soapcall_out_respex')); 
  //OUTPUT(ds_soapcall_out_respclean, NAMED('scie_ds_soapcall_out_respclean'));

  RETURN IF(apply_opt_out, ds_soapcall_out_respclean, ds_soapcall_out_respex);

END;

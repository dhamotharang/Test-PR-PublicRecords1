import ThreatMetrix, Gateway, data_services;

export SoapCall_ThreatMetrix(dataset(ThreatMetrix.gateway_trustdefender.t_TrustDefenderRequest) Inf,
                             Gateway.Layouts.Config gateway_cfg,
                             boolean makeGatewayCall = FALSE,
                             unsigned1 num_threads=1) := function

  UNSIGNED1 NumThreads := IF(num_threads > $.Constants.Defaults.MAX_THREADS, $.Constants.Defaults.MAX_THREADS, num_threads);

  ThreatMetrix.gateway_trustdefender.t_TrustDefenderRequest into_in(inf L) := transform
    self.User.ReferenceCode := if(L.user.referenceCode <> '', trim(L.user.referenceCode), gateway_cfg.TransactionId);
    self.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
    self.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
    self.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
    self.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);

    // Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward
    // compatibility on Gateway ESP side in case of non-roxie calls.
    self.GatewayParams.CheckVendorGatewayCall := true;
    self.GatewayParams.MakeVendorGatewayCall 	:= makeGatewayCall;
    self.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
    self.Options.TrustDefenderUserAccount.OrgId := TRIM(L.Options.TrustDefenderUserAccount.OrgId);
    self.Options.TrustDefenderUserAccount.ApiKey := TRIM(L.Options.TrustDefenderUserAccount.ApiKey);
    self.Options.Policy := TRIM(L.Options.Policy);
    self.Options.ApiType := TRIM(L.Options.ApiType);
    self.Options.serviceType := TRIM(L.Options.serviceType);
    self.Options.EventType := TRIM(L.Options.EventType);
    self.Options.NoPIIPersistence := L.Options.NoPIIPersistence;
    self.Options.DigitalIdReadOnly := L.Options.DigitalIdReadOnly;
    self := L;
  end;

  ThreatMetrix.gateway_trustdefender.t_TrustDefenderResponseEx failX() := transform
    self.response._header.message := FAILMESSAGE;
    self.response._header.status := FAILCODE;
    self := [];
  end;

  // output(inf,,'~dvstemp::in::trustdefender_gateway_debugging_input_' + thorlib.wuid(), xml);
  // output(inf,named('tmx_gateway_input'));

  // when using the static logical file for testing instead of hitting the gateway again
  // outf := dataset(data_services.foreign_dataland + 'dvstemp::out::tmx_gateway_results_debugging_w20190306-171557', ThreatMetrix.gateway_trustdefender.t_TrustDefenderResponseEx, thor);

  outf := if (makeGatewayCall,
              soapcall(inf,
                      gateway_cfg.url,
                      'TrustDefender',
                      ThreatMetrix.gateway_trustdefender.t_TrustDefenderRequest,
                      into_in(LEFT),
                      dataset(ThreatMetrix.gateway_trustdefender.t_TrustDefenderResponseEx),
                      XPATH('TrustDefenderResponseEx'),
                      onfail(failx()),
                      timeout(1),
                      PARALLEL(NumThreads),
                      TRIM,LOG)
            );

  return outf;

end;

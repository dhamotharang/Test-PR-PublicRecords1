IMPORT ThreatMetrix, Gateway, iesp, PhoneFinder_Services;

EXPORT getThreatMetrixRecords(DATASET(Phones.Layouts.PhoneAcctno) dIn,
                              BOOLEAN CallThreatMetrix = FALSE,
                              DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION

 gateway_cfg	:= dGateways(Gateway.Configuration.IsThreatMetrix(servicename))[1];

 ThreatMetrix.gateway_trustdefender.t_TrustDefenderRequest prep(Phones.Layouts.PhoneAcctno le) := TRANSFORM
	 self.Options.TrustDefenderUserAccount.OrgId := PhoneFinder_Services.Constants.ThreatMetrixConstants.OrgId;
	 self.Options.TrustDefenderUserAccount.ApiKey := PhoneFinder_Services.Constants.ThreatMetrixConstants.ApiKey;
	 self.Options.Policy := PhoneFinder_Services.Constants.ThreatMetrixConstants.Policy;
	 self.Options.ApiType := PhoneFinder_Services.Constants.ThreatMetrixConstants.ApiType;
	 self.Options.serviceType := PhoneFinder_Services.Constants.ThreatMetrixConstants.serviceType;
	 self.Options.NoPIIPersistence := PhoneFinder_Services.Constants.ThreatMetrixConstants.NoPIIPersistence;
	 self.searchby.Identity.TrustDefenderAccount.AccountTelephone := le.phone;
	 self := [];
 end;

 threatmetrix_in := PROJECT(dIn, prep(left));

 makeGatewayCall := CallThreatMetrix AND gateway_cfg.url <>'';

 tm_results := IF(makeGatewayCall, Gateway.SoapCall_ThreatMetrix(threatmetrix_in, gateway_cfg, makeGatewayCall, Phones.Constants.GatewayValues.ThreatMetrixNumThreads));

 RETURN tm_results;

END;
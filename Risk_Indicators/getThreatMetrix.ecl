import ThreatMetrix, Risk_Indicators, Gateway, iesp, Models, riskwise, ut;

export getThreatMetrix(dataset(Risk_Indicators.layouts.layout_trustdefender_in) indata, dataset(Gateway.Layouts.Config) gateways) := function

gateway_cfg	:= gateways(Gateway.Configuration.IsThreatMetrix(servicename))[1];


ThreatMetrix.gateway_trustdefender.t_TrustDefenderRequest prep(indata le) := transform
	
	self.Options.TrustDefenderUserAccount.OrgId := trim(le.OrgId);
	self.Options.TrustDefenderUserAccount.ApiKey := trim(le.ApiKey);
	self.Options.Policy := trim(le.Policy);
	self.Options.ApiType := trim(le.ApiType);
	self.Options.serviceType := trim(le.serviceType);
	self.searchby.RequestParameters.SessionId := trim(le.SessionId);
	self := [];
end;

threatmetrix_in := project(indata, prep(left));



makeGatewayCall := gateway_cfg.url!='' and count(threatmetrix_in)>0;
tm_results := if(makeGatewayCall, Gateway.SoapCall_ThreatMetrix(threatmetrix_in, gateway_cfg, makeGatewayCall), dataset([],ThreatMetrix.gateway_trustdefender.t_TrustDefenderResponseEX));


return tm_results;

end;
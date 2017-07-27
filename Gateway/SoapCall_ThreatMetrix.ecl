import ThreatMetrix, Royalty, Gateway;

export SoapCall_ThreatMetrix(dataset(ThreatMetrix.gateway_trustdefender.t_TrustDefenderRequest) Inf, Gateway.Layouts.Config gateway_cfg, boolean makeGatewayCall = FALSE) := function

//'http://10.176.68.164:7726/WsGatewayEx/?ver_=1.95'; //test gateway
//'http://wsgatewaycert.sc.seisint.com:8090/WsGateway';

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
	self := L;
end;

ThreatMetrix.gateway_trustdefender.t_TrustDefenderResponseEx failX() := transform
	self.response._header.message := FAILMESSAGE;
	self.response._header.status := FAILCODE;
	self := [];
end;

outf := if (makeGatewayCall, soapcall(inf, gateway_cfg.url, 'TrustDefender',ThreatMetrix.gateway_trustdefender.t_TrustDefenderRequest, into_in(LEFT),
			   dataset(ThreatMetrix.gateway_trustdefender.t_TrustDefenderResponseEx),XPATH('TrustDefenderResponseEx'),
			   onfail(failx()), timeout(1)));

return outf;
			   
end;
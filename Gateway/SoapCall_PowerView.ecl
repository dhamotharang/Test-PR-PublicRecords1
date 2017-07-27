import iesp, gateway, Royalty;

export SoapCall_PowerView(dataset(iesp.equifax_sts.t_EquifaxSTSRequest) Input, Gateway.Layouts.Config gateway_cfg, boolean makeGatewayCall = FALSE) := function

//'http://10.176.68.164:7726/WsGatewayEx/?ver_=1.95'; //test gateway

iesp.equifax_sts.t_EquifaxSTSRequest into_in(Input le) := transform
	self.User.QueryId := if(le.user.QueryId <> '', trim(le.user.QueryId), '');
	// Royalty tracking
	self.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
	self.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
	self.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
	self.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
	self.GatewayParams.RoyaltyCode 			:= Royalty.Constants.RoyaltyCode.POWERVIEW;
	self.GatewayParams.RoyaltyType 			:= Royalty.Constants.RoyaltyType.POWERVIEW;	
		
	// Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
	// compatibility on Gateway ESP side in case of non-roxie calls.
	self.GatewayParams.CheckVendorGatewayCall := true; 
	self.GatewayParams.MakeVendorGatewayCall 	:= makeGatewayCall;
	self.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
	self := le;
end;

iesp.equifax_sts.t_EquifaxSTSResponseEx failX() := transform
	self.response._header.message := FAILMESSAGE;
	self.response._header.status := FAILCODE;
	self := [];
end;

results := if (makeGatewayCall, soapcall(Input, gateway_cfg.url, 'EquifaxSTS', iesp.equifax_sts.t_EquifaxSTSRequest, into_in(LEFT),
			   dataset(iesp.equifax_sts.t_EquifaxSTSResponseEx),XPATH('EquifaxSTSResponseEx'),
			   onfail(failx()), timeout(4)));

return results;
  
end;
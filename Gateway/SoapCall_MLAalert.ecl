
import iesp, gateway, Royalty;

export SoapCall_MLAalert(dataset(iesp.equifax_sts.t_EquifaxSTSRequest) Input, Gateway.Layouts.Config gateway_cfg, boolean makeGatewayCall = FALSE) := function

iesp.equifax_sts.t_EquifaxSTSRequest into_in(Input le) := transform
	self.User.QueryId := if(le.user.QueryId <> '', trim(le.user.QueryId), '');
	
	self.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
	self.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
	self.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
	self.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
	self.GatewayParams.RoyaltyCode 			:= Royalty.Constants.RoyaltyCode.MLAALERT;
	self.GatewayParams.RoyaltyType 			:= Royalty.Constants.RoyaltyType.MLAALERT;	
		
	self.GatewayParams.CheckVendorGatewayCall := true; 
	self.GatewayParams.MakeVendorGatewayCall 	:= makeGatewayCall;
	self.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
	self := le;
end;

iesp.equifax_sts.t_EquifaxSTSResponseEx failX(INPUT le) := transform
	self.response._header.message := FAILMESSAGE;
	self.response._header.status := FAILCODE;
  //We need to carry this through because the following joins work off of it, if the request failed, there is still info we need to process.
	self.response._header.QueryID := trim(le.user.QueryId);
	self := [];
end;

results := if (makeGatewayCall, soapcall(Input, gateway_cfg.url, 'EquifaxSTS', iesp.equifax_sts.t_EquifaxSTSRequest, into_in(LEFT),
			   dataset(iesp.equifax_sts.t_EquifaxSTSResponseEx),XPATH('EquifaxSTSResponseEx'),
			   onfail(failx(LEFT)), timeout(4), retry(0)));

return results;
  
end;
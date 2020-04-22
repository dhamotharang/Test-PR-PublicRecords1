import Royalty, Gateway, iesp;

export SoapCall_FirstData(dataset(iesp.first_data.t_FDCheckingIndicatorsRequest) inf, Gateway.Layouts.Config gateway_cfg,
 boolean makeGatewayCall = FALSE) := function


iesp.first_data.t_FDCheckingIndicatorsRequest into_in(inf L) := transform
	self.User.ReferenceCode := if(L.user.referenceCode <> '', trim(L.user.referenceCode), trim(gateway_cfg.TransactionId));
	self.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
	self.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
	self.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
	self.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
  self.GatewayParams.RoyaltyCode 			:= Royalty.Constants.RoyaltyCode.FIRST_DATA;
	self.GatewayParams.RoyaltyType 			:= Royalty.Constants.RoyaltyType.FIRST_DATA;
		
	// Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
	// compatibility on Gateway ESP side in case of non-roxie calls.
	self.GatewayParams.CheckVendorGatewayCall := true; 
	self.GatewayParams.MakeVendorGatewayCall 	:= makeGatewayCall;
	self := L;
end;

iesp.first_data.t_FDCheckingIndicatorsResponseEx  failX() := transform 
	self.response._header.message := FAILMESSAGE;
	self.response._header.status := FAILCODE;
	self := [];
end;

outf := if (makeGatewayCall, soapcall(inf, gateway_cfg.url, 'FDCheckingIndicators', iesp.first_data.t_FDCheckingIndicatorsRequest, into_in(LEFT),
			   dataset(iesp.first_data.t_FDCheckingIndicatorsResponseEx),
         XPATH('FDCheckingIndicatorsResponseEx'),
			   onfail(failx()), timeout(2), retry(0)));

return outf;
			   
end;
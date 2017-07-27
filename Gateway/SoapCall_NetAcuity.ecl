// replacing NetAcuity.NA_SoapCall_Function.
import NetAcuity, Royalty;

export SoapCall_NetAcuity(dataset(netacuity.layout_NA_In) Inf, Gateway.Layouts.Config gateway_cfg, boolean makeGatewayCall = FALSE, boolean Feature4 = False) := function

//'http://wsgatewaycert.sc.seisint.com:8090/WsGateway';

netacuity.layout_NA_In into_in(inf L) := transform
	self.netaddress := trim(L.netaddress);
	self.User.ReferenceCode := if(L.user.referenceCode <> '', trim(L.user.referenceCode), gateway_cfg.TransactionId);
	// Royalty tracking
	self.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
	self.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
	self.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
	self.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
	self.GatewayParams.RoyaltyCode 			:= Royalty.Constants.RoyaltyCode.NETACUITY;
	self.GatewayParams.RoyaltyType 			:= Royalty.Constants.RoyaltyType.NETACUITY;	
		
	// Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
	// compatibility on Gateway ESP side in case of non-roxie calls.
	self.GatewayParams.CheckVendorGatewayCall := true; 
	self.GatewayParams.MakeVendorGatewayCall 	:= makeGatewayCall;
	self.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
	self.Options.Feature4 := Feature4;
	self := L;
end;

netacuity.layout_na_out_v4 failX() := transform
	self.response.header.errmsg := FAILMESSAGE;
	self.response.header.errcode := FAILCODE;
	self := [];
end;

outf := if (makeGatewayCall, soapcall(inf, gateway_cfg.url, 'NetAcuity',netAcuity.Layout_NA_In, into_in(LEFT),
			   dataset(netacuity.layout_NA_Out_v4),XPATH('NetAcuityResponse'),
			   onfail(failx()), timeout(1)));

return outf;
			   
end;

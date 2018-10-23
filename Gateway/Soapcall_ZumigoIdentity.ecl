﻿IMPORT Gateway, Iesp, Phones, Royalty, STD;

EXPORT Soapcall_ZumigoIdentity(DATASET(iesp.zumigo_identity.t_ZIdIdentitySearch) inf, 
																Phones.IParam.inZumigoParams inMod,
																BOOLEAN pMakeGatewayCall = FALSE,
																UNSIGNED pWaitTime = Phones.Constants.GatewayValues.requestTimeout, 
																UNSIGNED pRetries = Phones.Constants.GatewayValues.requestRetries) := FUNCTION
	gateway_cfg	:= inMod.gateways(Gateway.Configuration.IsZumigoIdentity(ServiceName))[1];														
	iesp.zumigo_identity.t_ZumigoIdentityRequest populateZumigoIdentityRequest(iesp.zumigo_identity.t_ZIdIdentitySearch l) := TRANSFORM
		SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
		SELF.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
		SELF.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
		SELF.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
		SELF.GatewayParams.RoyaltyCode 			:= Royalty.Constants.RoyaltyCode.ZUMIGO_IDENTITY;
		SELF.GatewayParams.RoyaltyType 			:= Royalty.Constants.RoyaltyType.ZUMIGO_IDENTITY;	
		SELF.GatewayParams.CheckVendorGatewayCall := TRUE; 
		SELF.GatewayParams.MakeVendorGatewayCall 	:= pMakeGatewayCall;
		SELF.Options.Blind 			 := Gateway.Configuration.GetBlindOption(gateway_cfg);
		SELF.Options.ProductName := If(Gateway.Configuration.GetRoxieQueryName(gateway_cfg)='',inMod.ProductName,
																																													Gateway.Configuration.GetRoxieQueryName(gateway_cfg));	
		SELF.Options.ClientId:=IF(Phones.Constants.Debug.Testing, Phones.Constants.Debug.InternalTestClientID,
																  Phones.Constants.GatewayValues.ClientIDPrefix+trim(inMod.useCase)+'_'+trim(inMod.productCode)+inMod.billingId);
		//Note that Zumigo does not permit NameAddressInfo without NameAddressValidation
		SELF.Options.NameAddressValidation	:= inMod.NameAddressValidation OR inMod.NameAddressInfo;
		SELF.Options.NameAddressInfo		:= inMod.NameAddressInfo;
		SELF.Options.AccountInfo			:= inMod.AccountInfo;
		SELF.Options.AccountStatusInfo		:= inMod.AccountStatusInfo;
		SELF.Options.CarrierInfo			:= inMod.CarrierInfo;
		SELF.Options.CallHandlingInfo		:= inMod.CallHandlingInfo;
		SELF.Options.DeviceInfo				:= inMod.DeviceInfo;
		SELF.Options.DeviceChangeOption		:= inMod.DeviceChangeOption;
		SELF.Options.DeviceHistory			:= inMod.DeviceHistory;
		SELF.SearchBy.Consent.OptInType		:= STD.Str.ToLowerCase(inMod.OptInType);
		SELF.SearchBy.Consent.OptInMethod	:= STD.Str.ToUpperCase(inMod.OptInMethod);
		SELF.SearchBy.Consent.OptInDuration	:= STD.Str.ToUpperCase(inMod.OptInDuration);//IF(notTCPA,inMod.OptInDuration,'');		//inMod.OptInDuration;		
		SELF.SearchBy.Consent.OptinId		:= inMod.OptInId;				
		SELF.SearchBy.Consent.OptInVersionId:= inMod.OptInVersionId;				
		SELF.SearchBy.Consent.OptInTimestamp:= iesp.ECL2ESP.toTimeStamp(inMod.OptInTimestamp);//iesp.ECL2ESP.toTimeStamp(IF(notTCPA,inMod.OptInTimestamp,''));
		SELF.SearchBy.MobileDeviceNumber	:= '1' + l.MobileDeviceNumber;
		SELF.SearchBy.NameAddrValidation	:= l.NameAddrValidation;
		SELF := l;
		SELF := [];
	END;

	iesp.zumigo_identity.t_ZumigoIdentityResponseEx tErrX(iesp.zumigo_identity.t_ZIdIdentitySearch l) := TRANSFORM
		SELF.response._header.Status := FAILCODE;
		SELF.response._header.Message := FAILMESSAGE;
		SELF.response.LineIdentityResponse.MobileDeviceNumber := '1' + l.MobileDeviceNumber;
		SELF := [];
	END;
	outf := IF(pMakeGatewayCall AND  gateway_cfg.url <> '',
								SOAPCALL(inf, 
									gateway_cfg.url,
									gateway_cfg.ServiceName,
									iesp.zumigo_identity.t_ZumigoIdentityRequest, 
									populateZumigoIdentityRequest(LEFT),
									DATASET(iesp.zumigo_identity.t_ZumigoIdentityResponseEx),
									XPATH('ZumigoIdentityResponseEx'),
									ONFAIL(tErrX(LEFT)),
									TIMEOUT(pWaitTime),
									RETRY(pRetries),
									TRIM,
									LOG));	
									
 	#IF(Phones.Constants.Debug.Zumigo)								
   		OUTPUT(outf,NAMED('zumigoSoapResults'));	
   	#END;
	RETURN outf;   
END;
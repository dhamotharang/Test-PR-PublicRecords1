import iesp,Gateway,Phones,Royalty;

/*
IMPORTANT: unwanted calls to both gateways were made without the double condition before the SOAPCALL.
DO NOT REMOVE!!!

ALSO IMPORTANT: QSent GW data is subject to CCPA suppression, which is not done here.
  Calls to QSent gateway should all go through Doxie_Raw.RealTimePhones_Raw. 
  
*/
  
EXPORT SoapCall_QsentV2(DATASET(iesp.gateway_qsent.t_QSentCISSearchRequest) pInF,
												Layouts.Config pGWCfg, 
												pWaitTime = 3, 
												pRetries = 0, 
												BOOLEAN pMakeGatewayCall = FALSE
												) 
		:= FUNCTION
		
		iesp.gateway_qsent.t_QSentCISSearchRequest tToGWIn(iesp.gateway_qsent.t_QSentCISSearchRequest L) := 
		TRANSFORM
			// Royalty tracking
			SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(pGWCfg);
			SELF.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(pGWCfg);
			SELF.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchspecId(pGWCfg);
			SELF.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(pGWCfg);
			SELF.GatewayParams.RoyaltyCode 			:= IF(L.Options.ServiceType=Phones.Constants.ServiceType.IQ411, 
																								Royalty.Constants.RoyaltyCode.QSENT_IQ411,
																								Royalty.Constants.RoyaltyCode.QSENT_PVS);
			SELF.GatewayParams.RoyaltyType 			:= IF(L.Options.ServiceType=Phones.Constants.ServiceType.IQ411, 
																								Royalty.Constants.RoyaltyType.QSENT_IQ411,
																								Royalty.Constants.RoyaltyType.QSENT_PVS);																								
			
			// Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward 
			// compatibility on Gateway ESP side in case of non-roxie calls.
			SELF.GatewayParams.CheckVendorGatewayCall := true; 
			SELF.GatewayParams.MakeVendorGatewayCall 	:= pMakeGatewayCall;
			SELF.Options.Blind := Gateway.Configuration.GetBlindOption(pGWCfg);
			SELF := L;
		END;				
		
		iesp.gateway_qsent.t_QSentCISSearchResponseEx tErrX(iesp.gateway_qsent.t_QSentCISSearchRequest le) := 
		TRANSFORM
       self.response._Header.Message := FAILMESSAGE;
       self.response._Header.Status := FAILCODE;
       self := [];
		END;		
				
		dGWRes := if(pMakeGatewayCall,
									SOAPCALL(pInF, pGWCfg.Url, 'QSentCISSearch',
									iesp.gateway_qsent.t_QSentCISSearchRequest,tToGWIn(LEFT),
									dataset(iesp.gateway_qsent.t_QSentCISSearchResponseEx)
									,XPATH('QSentCISSearchResponseEx')
									,onFail(tErrX(LEFT))
									,timeout(pWaitTime)
									,retry(pRetries)
									,TRIM,LOG
									));
				
		RETURN dGWRes;
	
END;	

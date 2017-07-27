/* Gateway Call to AccuData */
import iesp, Gateway, Royalty;
EXPORT SoapCall_AccuData_ocn(DATASET(iesp.accudata_ocn.t_AccudataOcnRequest) pInF,
											Gateway.Layouts.Config pGWCfg, 
											pWaitTime = 3, 
											pRetries = 0, 
											BOOLEAN pMakeGatewayCall = FALSE
											) 
		:= FUNCTION
	
		iesp.accudata_ocn.t_AccudataOcnRequest tToGWIn(iesp.accudata_ocn.t_AccudataOcnRequest L) := 
		TRANSFORM
			// Royalty tracking
			SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(pGWCfg);
			SELF.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(pGWCfg);
			SELF.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchspecId(pGWCfg);
			SELF.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(pGWCfg);
			SELF.GatewayParams.RoyaltyCode 			:= Royalty.Constants.RoyaltyCode.ACCUDATA_OCN_LNP;
			SELF.GatewayParams.RoyaltyType 			:= Royalty.Constants.RoyaltyType.ACCUDATA_OCN_LNP;																								
			SELF.GatewayParams.CheckVendorGatewayCall := true; 
			SELF.GatewayParams.MakeVendorGatewayCall 	:= pMakeGatewayCall;
			SELF.Options.Blind := Gateway.Configuration.GetBlindOption(pGWCfg); 
			SELF := L;

		END;				
		
		iesp.accudata_ocn.t_AccudataOcnResponseEx tErrX(iesp.accudata_ocn.t_AccudataOcnRequest le) := 
		TRANSFORM
      SELF.response.AccudataReport.ErrorMessage := FAILMESSAGE;
      SELF := [];
		END;		
				
		dGWRes := if(pMakeGatewayCall,
									SOAPCALL(pInF, pGWCfg.Url, 'AccudataOcn',
									iesp.accudata_ocn.t_AccudataOcnRequest,tToGWIn(LEFT),
									dataset(iesp.accudata_ocn.t_AccudataOcnResponseEx)
									,XPATH('AccudataOcnResponseEx')
									,onFail(tErrX(LEFT))
									,timeout(pWaitTime)
									,retry(pRetries)
									,TRIM,LOG
									));
		
		RETURN dGWRes;
	
END;
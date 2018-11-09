IMPORT EquifaxDecisioning, Gateway, Iesp, Royalty; 

EXPORT SoapCall_EquifaxDecisioning(DATASET(iesp.equifax_attributes.t_EquifaxAttributesRequest) gatewayInput,		                                   
                                   Gateway.Layouts.Config gateway_cfg = Gateway.Constants.void_gateway,
                                   BOOLEAN EnableGatewayCall = FALSE,
                                   INTEGER WaitTime = Gateway.Constants.Defaults.WAIT_TIMEOUT_EXPERIAN, 
                                   INTEGER numRetries	= Gateway.Constants.Defaults.RETRIES) := 
  FUNCTION

      iesp.equifax_attributes.t_EquifaxAttributesRequest populateRequest(iesp.equifax_attributes.t_EquifaxAttributesRequest l) := TRANSFORM
      // Royalty tracking
      SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
      SELF.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
      SELF.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
      SELF.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
      SELF.GatewayParams.RoyaltyCode 			:= Royalty.Constants.RoyaltyCode.EFX_ATTR;
      SELF.GatewayParams.RoyaltyType 			:= Royalty.Constants.RoyaltyType.EFX_ATTR;	
      SELF.GatewayParams.CheckVendorGatewayCall := TRUE; 
      SELF.GatewayParams.MakeVendorGatewayCall 	:= TRUE;
      SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
      SELF := l;
    END;

    iesp.equifax_attributes.t_EquifaxAttributesResponseEx xfm_ErrX(iesp.equifax_attributes.t_EquifaxAttributesRequest l) := TRANSFORM
      SELF.response._header.Status := FAILCODE;
      SELF.response._header.Message := FAILMESSAGE;
      SELF := [];
    END;

    gatewayOutput := IF(EnableGatewayCall,
                        SOAPCALL(gatewayInput, 
                                 gateway_cfg.url, 
                                 gateway_cfg.ServiceName,
                                 iesp.equifax_attributes.t_EquifaxAttributesRequest, 
                                 populateRequest(LEFT),
                                 DATASET(iesp.equifax_attributes.t_EquifaxAttributesResponseEx),
                                 XPATH(EquifaxDecisioning.Constants.GATEWAY_XPATH),
                                 ONFAIL(xfm_ErrX(LEFT)),
                                 TIMEOUT(WaitTime),
                                 RETRY(numRetries),
                                 TRIM,
                                 LOG));	

    RETURN gatewayOutput;
	   
  END; // SoapCall_EquifaxDecisioning

 

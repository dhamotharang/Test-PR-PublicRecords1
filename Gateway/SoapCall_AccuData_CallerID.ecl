IMPORT Gateway, Iesp, Phones, Royalty;

EXPORT SoapCall_AccuData_CallerID(DATASET(Phones.Layouts.PhoneAcctno) inPhones, 
																Gateway.Layouts.Config gateway_cfg = Gateway.Constants.void_gateway,
																BOOLEAN pMakeGatewayCall = FALSE,
																UNSIGNED pWaitTime = Phones.Constants.GatewayValues.requestTimeout, 
																UNSIGNED pRetries = Phones.Constants.GatewayValues.requestRetries) := FUNCTION
											
iesp.accudata_accuname.t_AccudataCnamRequest populateRequest(Phones.Layouts.PhoneAcctno l) := TRANSFORM
	// Royalty tracking
	SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
	SELF.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
	SELF.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
	SELF.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
	SELF.GatewayParams.RoyaltyCode 			:= Royalty.Constants.RoyaltyCode.ACCUDATA_CNAM_CNM2;
	SELF.GatewayParams.RoyaltyType 			:= Royalty.Constants.RoyaltyType.ACCUDATA_CNAM_CNM2;	
	SELF.GatewayParams.CheckVendorGatewayCall := TRUE; 
	SELF.GatewayParams.MakeVendorGatewayCall 	:= TRUE;
	SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
	SELF.Options.TransactionType := Phones.Constants.GatewayValues.AccuDataCNAM;
	SELF.Options.ProductName := Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
	SELF.SearchBy.phone := l.phone;
	SELF.SearchBy.RequestId := l.acctno;
	SELF := [];
END;
// OUTPUT(populateRequest(inPhones[1]));
iesp.accudata_accuname.t_AccudataCnamResponseEx tErrX(Phones.Layouts.PhoneAcctno l) := TRANSFORM
	//RQ-16410: Continue passing on phone to filter down to in house data during gateway failures
	SELF.response.AccuDataReport.Phone := l.phone;
	SELF.response._header.Status := FAILCODE;
	SELF.response._header.Message := FAILMESSAGE;
	SELF := [];
END;

outf := IF(pMakeGatewayCall,
							SOAPCALL(inPhones, 
								gateway_cfg.url, 
								'AccudataCnam',
								Phones.Layouts.PhoneAcctno, 
								populateRequest(LEFT),
								DATASET(iesp.accudata_accuname.t_AccudataCnamResponseEx),
								XPATH('AccudataCnamResponseEx'),
								ONFAIL(tErrX(LEFT)),
								TIMEOUT(pWaitTime),
								RETRY(pRetries),
								TRIM,
								LOG));		
	#IF(Phones.Constants.Debug.AccuDataCNAM)								
		OUTPUT(gateway_cfg,NAMED('gateway_cfg'));														
		OUTPUT(outf,NAMED('outf'));	
	#END
RETURN outf;
	   
END;
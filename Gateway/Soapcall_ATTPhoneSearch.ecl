IMPORT Gateway, Iesp, Phones, Royalty;

EXPORT Soapcall_ATTPhoneSearch(DATASET({STRING10 phone}) phonesIn,
	Gateway.Layouts.Config gateway_cfg = Gateway.Constants.void_gateway,
	BOOLEAN pMakeGatewayCall = FALSE,
	UNSIGNED pWaitTime = Phones.Constants.GatewayValues.requestTimeout,
	UNSIGNED pRetries = Phones.Constants.GatewayValues.requestRetries) := FUNCTION
	queryName := Gateway.Configuration.GetRoxieQueryName(gateway_cfg);

iesp.att_iap.t_ATTIapQueryRequest populateATTSearch({STRING10 phone} L):= TRANSFORM
	SELF.SearchBy.EchoData.Custom1 := L.phone;
	SELF.SearchBy.Query.InformationRetrievalService.QueryNumber := L.phone;
	SELF.SearchBy.Query.InformationRetrievalService.IncludeRoutingNumber := TRUE;
	SELF.SearchBy.Query.InformationRetrievalService.IncludeAccountOwner := TRUE;
	SELF.SearchBy.Query.InformationRetrievalService.IncludeCarrierName := TRUE;
	SELF.SearchBy.Query.InformationRetrievalService.IncludeCategory := TRUE;
	SELF.SearchBy.Query.InformationRetrievalService.IncludeLocalAccessAndTransport := TRUE;
	SELF.SearchBy.Query.InformationRetrievalService.IncludeCityState := TRUE;
	SELF.Options.QueryType := Phones.Constants.GatewayValues.QueryType_ATT_DQ_IRS;
	//This was added per project requirements but may be removed later.
	SELF.Options.ProductName := queryName;
	SELF := [];
END;

inf := PROJECT(phonesIn, populateATTSearch(LEFT));

iesp.att_iap.t_ATTIapQueryRequest populateRequest(iesp.att_iap.t_ATTIapQueryRequest l) := TRANSFORM
	// Royalty tracking
	SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
	SELF.GatewayParams.BatchJobId := Gateway.Configuration.GetBatchJobId(gateway_cfg);
	SELF.GatewayParams.ProcessSpecId := Gateway.Configuration.GetBatchSpecId(gateway_cfg);
	SELF.GatewayParams.QueryName := queryName;
	SELF.GatewayParams.RoyaltyCode := Royalty.Constants.RoyaltyCode.ATT_IAP_DQ_IRS;
	SELF.GatewayParams.RoyaltyType := Royalty.Constants.RoyaltyType.ATT_IAP_DQ_IRS;
	SELF.GatewayParams.CheckVendorGatewayCall := TRUE;
	SELF.GatewayParams.MakeVendorGatewayCall := TRUE;
	SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
	SELF := l;
END;

iesp.att_iap.t_ATTIapQueryResponseEx tErrX(iesp.att_iap.t_ATTIapQueryRequest l) := TRANSFORM
	SELF.response._header.Status := FAILCODE;
	SELF.response._header.Message := FAILMESSAGE;
	SELF := [];
END;

outf := IF(pMakeGatewayCall,
	SOAPCALL(inf,
		gateway_cfg.url,
		'AttIapQuery',
		iesp.att_iap.t_ATTIapQueryRequest,
		populateRequest(LEFT),
		DATASET(iesp.att_iap.t_ATTIapQueryResponseEx),
		XPATH('AttIapQueryResponseEx'),
		ONFAIL(tErrX(LEFT)),
		TIMEOUT(pWaitTime),
		RETRY(pRetries),
		TRIM,
		LOG));
RETURN outf;

END;
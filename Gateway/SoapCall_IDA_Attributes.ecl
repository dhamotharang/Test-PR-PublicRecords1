IMPORT iesp, Gateway;

EXPORT SoapCall_IDA_Attributes( DATASET(iesp.ida_report_request.t_IDAReportRequest) Input,
                          Gateway.Layouts.Config gateway_cfg,
                          BOOLEAN makeGatewayCall = FALSE,
                          UNSIGNED Timeout_sec = 3,
                          UNSIGNED Retries = 1
                         ) := FUNCTION

  iesp.ida_report_request.t_IDAReportRequest into_in(iesp.ida_report_request.t_IDAReportRequest le) := TRANSFORM
    SELF.User.ReferenceCode := IF(le.user.referenceCode <> '', TRIM(le.user.referenceCode), gateway_cfg.TransactionId);
    SELF.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
    SELF.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
    SELF.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
    SELF.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);

    // Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward
    // compatibility on Gateway ESP side in case of non-roxie calls.
    SELF.GatewayParams.CheckVendorGatewayCall := TRUE;
    SELF.GatewayParams.MakeVendorGatewayCall 	:= makeGatewayCall;
    
    SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
    
    SELF := le;
  END;

  iesp.ida_report_response.t_IDAReportResponseEx failX() := TRANSFORM
    SELF.response._header.message := FAILMESSAGE;
    SELF.response._header.status := FAILCODE;
    SELF := [];
  END;
  
  
  outg := IF (makeGatewayCall,
              SOAPCALL( Input,
                        gateway_cfg.url,
                        Gateway.Constants.ServiceName.IDAFraud,
                        iesp.ida_report_request.t_IDAReportRequest,
                        into_in(LEFT),
                        DATASET(iesp.ida_report_response.t_IDAReportResponseEx),
                        XPATH('IDAReportResponseEx'),
                        ONFAIL(failx()),
                        TIMEOUT(Timeout_sec),
                        RETRY(Retries),
                        TRIM),
              DATASET([], iesp.ida_report_response.t_IDAReportResponseEx)
            );

  // output(gateway_cfg, named('gateway_cfg'));

  RETURN outg;
  
END;
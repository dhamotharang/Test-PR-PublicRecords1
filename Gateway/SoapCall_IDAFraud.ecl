Import iesp, Gateway;

EXPORT SoapCall_IDAFraud( dataset(iesp.ida_report_request.t_IDAReportRequest) Input,
                          Gateway.Layouts.Config gateway_cfg,
                          boolean makeGatewayCall = FALSE
                         ) := function

  iesp.ida_report_request.t_IDAReportRequest into_in(iesp.ida_report_request.t_IDAReportRequest le) := transform
    self.User.ReferenceCode := if(le.user.referenceCode <> '', trim(le.user.referenceCode), gateway_cfg.TransactionId);
    self.GatewayParams.TxnTransactionId := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
    self.GatewayParams.BatchJobId 			:= Gateway.Configuration.GetBatchJobId(gateway_cfg);
    self.GatewayParams.ProcessSpecId 		:= Gateway.Configuration.GetBatchSpecId(gateway_cfg);
    self.GatewayParams.QueryName 				:= Gateway.Configuration.GetRoxieQueryName(gateway_cfg);

    // Enabling call to external gateway. Additional field CheckVendorGatewayCall to preserve backward
    // compatibility on Gateway ESP side in case of non-roxie calls.
    self.GatewayParams.CheckVendorGatewayCall := true;
    self.GatewayParams.MakeVendorGatewayCall 	:= makeGatewayCall;
    
    self.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
    
    // self.ReportBy.FirstName := Trim();

    self := le;
  end;

  iesp.ida_report_response.t_IDAReportResponseEx failX() := transform
    self.response._header.message := FAILMESSAGE;
    self.response._header.status := FAILCODE;
    self := [];
  end;
  
  
  outf := if (makeGatewayCall,
              soapcall(Input,
                      gateway_cfg.url,
                      Gateway.Constants.ServiceName.IDAFraud,
                      iesp.ida_report_request.t_IDAReportRequest,
                      into_in(LEFT),
                      dataset(iesp.ida_report_response.t_IDAReportResponseEx),
                      XPATH('IDAReportResponseEx'),
                      onfail(failx()),
                      timeout(1),
                      /*PARALLEL(NumThreads),*/
                      TRIM/*,LOG*/)
            );

  // output(gateway_cfg, named('gateway_cfg'));

  return outf;
  
END;
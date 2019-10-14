//soapcall to the emailrisk 
import iesp, Gateway;


export SoapCall_EmailRisk(dataset(iesp.emailrisk.t_EmailRiskRequest)Inf, 
                                  Gateway.Layouts.Config gateway_cfg, 
                                  boolean makeGatewayCall = false):= 
FUNCTION

soap_in:= Project(inf,transform(iesp.emailrisk.t_EmailRiskRequest, 

self.User.ReferenceCode := if(Left.user.referenceCode <> '', trim(Left.user.referenceCode), gateway_cfg.TransactionId);
self.GatewayParams.TxnTransactionId  := Gateway.Configuration.GetTransactionIdX(gateway_cfg);
self.GatewayParams.BatchJobId 			    := Gateway.Configuration.GetBatchJobId(gateway_cfg);
self.GatewayParams.ProcessSpecId 		  :=Gateway.Configuration.GetBatchSpecId(gateway_cfg);
self.GatewayParams.QueryName 				  :=Gateway.Configuration.GetRoxieQueryName(gateway_cfg);
self.GatewayParams.CheckVendorGatewayCall := true; 
self.GatewayParams.MakeVendorGatewayCall 	:= makeGatewayCall;
SELF.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
self.SearchBy.email:= trim(Left.SearchBy.email);
SELF := Left;
SELF := [];
));
     
  iesp.emailrisk.t_EmailRiskResponseEx failX():= transform
  self.response._header.message := FAILMESSAGE;
  self.response._header.status := FAILCODE;
  self := [];
  END;  
  
outf := if (makeGatewayCall, soapcall(soap_in, gateway_cfg.url, gateway_cfg.ServiceName,{soap_in},
            Dataset(iesp.emailrisk.t_EmailRiskResponseEx),
            XPATH('EmailRiskResponseEx'),
            ONFAIL(failx()),TIMEOUT(5),RETRY(1),TRIM ));

// output(inf,named('inf'));       
// output(gateway_cfg.url,named('gateway_url'));
// output(outf,named('outf'));      
  return outf;
  END;

Import risk_indicators, gateway,iesp;


EXPORT get_EmailRisk(dataset(Risk_indicators.Layout_Input) indata,
	 dataset(Gateway.Layouts.Config) Gateways, boolean makegatewaycall)
:=FUNCTION
  
  EmailRisk_in:= project(indata,transform(iesp.emailrisk.t_EmailRiskRequest,
                 self.SearchBy.Email:= trim(left.email_address);
                 self:=Left;
                 self:=[]));

gateway_cfg	:= Gateways(Gateway.Configuration.IsEmailRisk(servicename))[1];
gateway_results:= if(makegatewaycall, Gateway.SoapCall_EmailRisk(EmailRisk_in,gateway_cfg,makegatewaycall));
return(gateway_results);
end;

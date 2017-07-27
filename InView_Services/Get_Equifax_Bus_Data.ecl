import  iesp, ut, gateway;
/* Module to retreive data from the equifax gateway */

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// IMPORTANT SOAPCALL NOTE:
// Don't neglet sending seemingly redundant "call_gateway" parameter: in some circumstances calling a gateway
// cannot be prevented by caller using IF statements (known platform issue),
// so this final check guarantees that gateway won't be called inadvertently.
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

inview_rec_ex := iesp.gateway_inviewreport.t_InviewReportResponseEx;

export Get_Equifax_Bus_Data := module
			
	export Report_View := module	
	   export iesp.gateway_inviewreport.t_InviewReportResponse 
		          equifax_gateway(dataset(iesp.gateway_inviewreport.t_InviewReportRequest) equifax_in,
							            Gateway.Layouts.Config gateway_cfg,
													boolean call_gateway = false
							) := function								   
				 
				gateway_results := Gateway.SoapCall_Equifax(equifax_in, gateway_cfg, call_gateway);
				// this is in the form iesp.gateway_inviewreport.t_InviewReportResponseEx

				gateway_rec := project(gateway_results, transform( 
				               iesp.gateway_inviewreport.t_InviewReportResponse, 
							self.ProductCodes := left.response.ProductCodes,
							self.CustomerSecurityInfo := left.response.CustomerSecurityInfo,
							self.CommercialCreditReport := left.response.CommercialCreditReport,
							self := []
							));

       return gateway_rec;								
		 end;
	end;

end; // module raw
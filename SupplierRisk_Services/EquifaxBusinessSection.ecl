IMPORT AutoStandardI, ut, iesp, TopBusiness_Services, Gateway;

EXPORT EquifaxBusinessSection := MODULE

/* Attribute to fetch data from the equifax gateway */

	EXPORT fn_FullView(
   dataset(TopBusiness_Services.BestSection_Layouts.final) bestInfo
	 ,dataset(SupplierRisk_Services.SupplierRisk_Layouts.rec_input_ids) ds_in_ids
	 ,boolean call_gateway = false
	 ,SupplierRisk_Services.SupplierRisk_Layouts.Report_options in_options
	 ,AutoStandardI.DataRestrictionI.params in_mod
                   ):= FUNCTION 

  // format request for the SOAP call
	
	iesp.gateway_inviewreport.t_InviewReportRequest prep_request() := TRANSFORM
		
		SELF.user.glbpurpose := (STRING) in_mod.glbpurpose;
		SELF.user.dlpurpose := (STRING) in_mod.dppapurpose;
		SELF.user := [];
		
		SELF.ReportBy.CompanyName := bestInfo[1].CompanyName;
		SELF.ReportBy.FEIN := bestInfo[1].tin;
		SELF.ReportBy.PhoneNumber := bestInfo[1].PhoneInfo.Phone10;
		SELF.ReportBy.Address.StreetNumber := bestInfo[1].Address.StreetNumber;
		SELF.ReportBy.Address.StreetPreDirection := bestInfo[1].Address.StreetPreDirection;
		SELF.ReportBy.Address.StreetName := bestInfo[1].Address.StreetName;
		SELF.ReportBy.Address.StreetSuffix := bestInfo[1].Address.StreetSuffix;
		SELF.ReportBy.Address.StreetPostDirection := bestInfo[1].Address.StreetPostDirection;
		SELF.ReportBy.Address.UnitDesignation := bestInfo[1].Address.UnitDesignation;
		SELF.ReportBy.Address.UnitNumber := bestInfo[1].Address.UnitNumber;
		SELF.ReportBy.Address.City := bestInfo[1].Address.City;
		SELF.ReportBy.Address.State := bestInfo[1].Address.State;
		SELF.ReportBy.Address.Zip5 := bestInfo[1].Address.Zip5;
		SELF.ReportBy.Address.Zip4 := bestInfo[1].Address.Zip4;
		SELF.ReportBy := [];
		
		SELF.options.includebusinesscreditrisk := in_options.IncludeBusinessCreditRisk;
		SELF.options.includebusinessfailurerisklevel := in_options.IncludeBusinessFailureRiskLevel;
		SELF.options.includecustombcir := in_options.IncludeCustomBCIR;
		SELF.options := [];
		
		SELF := [];
	END;
	request := DATASET ([prep_request()]);


	
// IMPORTANT SOAPCALL NOTE:
// Don't neglet sending seemingly redundant "call_gateway" parameter: in some circumstances calling a gateway
// cannot be prevented by caller using IF statements (known platform issue),
// so this final check guarantees that gateway won't be called inadvertently.
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  gateway_cfg  := Gateway.Configuration.get()(Gateway.Configuration.IsEquifax(servicename))[1];
	
	gateway_results := Gateway.SoapCall_Equifax (request, gateway_cfg, call_gateway);

	SupplierRisk_Services.SupplierRisk_layouts.Equifax_layout format() := TRANSFORM
				self.ProductCodes := gateway_results[1].response.ProductCodes;
				self.CustomerSecurityInfo := gateway_results[1].response.CustomerSecurityInfo;
				self.CommercialCreditReport := gateway_results[1].response.CommercialCreditReport;
				self._header  := gateway_results[1].response._header;
				self.acctno := ds_in_ids[1].acctno;
				self := [];
	end;
	
	// output(bestinfo,named('sectBestinfo'));
	// output(request,named('request'));
	// output(call_gateway,named('call_gateway'));
	// output(servicename,named('servicename'));
	// output(Gateway.Configuration.get(),named('gateway_get'));
	
  // output(gateway_cfg,named('gateway_cfg'));
	// output(gateway_results,named('gateway_results'));
	
	equifax_final_results := dataset([format()]);
	return equifax_final_results;

	END;
	
END;
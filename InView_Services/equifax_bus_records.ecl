IMPORT ut, iesp, InView_Services, doxie_cbrs, Gateway;
/* Attribute to fetch data from the equifax gateway */
doxie_cbrs.mac_Selection_Declare();

EXPORT equifax_bus_records(dataset(doxie_cbrs.Layout_BH_Best_String) besr,
                           boolean call_gateway = false) := 

MODULE

  // format request for the SOAP call
	iesp.gateway_inviewreport.t_InviewReportRequest prep_request() := TRANSFORM
		
		SELF.user.glbpurpose := (STRING) glb_purpose;
		SELF.user.dlpurpose := (STRING) dppa_purpose;
		SELF.user := [];
		
		SELF.ReportBy.CompanyName := besr[1].company_name;
		SELF.ReportBy.FEIN := besr[1].fein;
		SELF.ReportBy.PhoneNumber := besr[1].phone;
		SELF.ReportBy.Address.StreetNumber := besr[1].prim_range;
		SELF.ReportBy.Address.StreetPreDirection := besr[1].predir;
		SELF.ReportBy.Address.StreetName := besr[1].prim_name;
		SELF.ReportBy.Address.StreetSuffix := besr[1].addr_suffix;
		SELF.ReportBy.Address.StreetPostDirection := besr[1].postdir;
		SELF.ReportBy.Address.UnitDesignation := besr[1].unit_desig;
		SELF.ReportBy.Address.UnitNumber := besr[1].sec_range;
		SELF.ReportBy.Address.City := besr[1].city;
		SELF.ReportBy.Address.State := besr[1].state;
		SELF.ReportBy.Address.Zip5 := besr[1].zip;
		SELF.ReportBy.Address.Zip4 := besr[1].zip4;
		SELF.ReportBy := [];
		
		SELF.options.includebusinesscreditrisk := Include_BusinessCreditRisk;
		SELF.options.includebusinessfailurerisklevel := Include_BusinessFailureRiskLevel;
		SELF.options.includecustombcir := Include_CustomBCIR;
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
	// this is in the form iesp.gateway_inviewreport.t_InviewReportResponseEx
	
	EXPORT records := project(gateway_results,
  													transform (iesp.gateway_inviewreport.t_InviewReportResponse, 
																			self.ProductCodes := left.response.ProductCodes,
																			self.CustomerSecurityInfo := left.response.CustomerSecurityInfo,
																			self.CommercialCreditReport := left.response.CommercialCreditReport,
																			self._header  := left.response._header));

	EXPORT records_count := count(records);

END;
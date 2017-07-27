IMPORT ut, iesp, InView_Services, risk_indicators;
/* Attribute to fetch data from the equifax gateway */
doxie_cbrs.mac_Selection_Declare()

EXPORT equifax_bus_records(dataset(Layout_BH_Best_String) besr) := 

MODULE
  Equifax_gateways_in := 	dataset([] ,risk_indicators.Layout_Gateways_In) : STORED('gateways',few);
	
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
	
	STRING gateway_equifax := Equifax_gateways_in(servicename='inviewreport')[1].url;
	// TESTING STRING gateway_equifax := 'https://webapp_roxie_test:web33436$@securedev.accurint.com/espdev/dev/WsGateway/?ver_=1.7';
	
	SHARED equifax_result := IF(gateway_equifax != '',inView_Services.Get_Equifax_Bus_Data.report_view.equifax_gateway(request,gateway_equifax));	
	
	EXPORT records := equifax_result(Include_EquifaxBus_val);
	EXPORT records_count := count(records);

END;
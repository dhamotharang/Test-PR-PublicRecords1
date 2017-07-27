EXPORT MAC_GetIPs(indata,outdata,gateways,gwOut,wIP) := MACRO
	gwOut := risk_indicators.getNetAcuity(indata,gateways,(UNSIGNED1)Constants.dppa,(UNSIGNED1)Constants.glb);	
	outdata addIP(outdata le, recordof(gwOut) ri) := TRANSFORM
		SELF.result.ipaddressinfo.Continent := ri.continent;
		SELF.result.ipaddressinfo.Country := ri.countrycode;
		SELF.result.ipaddressinfo.routingtype := ri.iproutingmethod;
		SELF.result.ipaddressinfo.topleveldomain := ri.topleveldomain;
		SELF.result.ipaddressinfo.secondleveldomain := ri.secondleveldomain;
		SELF.result.ipaddressinfo.city := ri.ipcity;
		SELF.result.ipaddressinfo.regiondescription := ri.ipregion_description;
		SELF.result.ipaddressinfo.latitude := ri.latitude;
		SELF.result.ipaddressinfo.longitude := ri.longitude;
		//iIA	The input IP address is unknown	Internal	Current Logic
		//iIB	The input IP address is assigned to a different state/province than the bill-to state/province	Internal	Current Logic
		//iIC	The input IP address is assigned to a different postal code than the bill-to postal code	Internal	Current Logic
		//iID	The input IP address is assigned to a different area code than the Bill-to phone number	Internal	Current Logic
		//iIE	The input IP address second-level domain is unknown	Internal	Current Logic
		//iIF	The input IP address is not assigned to the United States	Internal	Current Logic
		//iIG	The input IP address is non-routable over the internet	Internal	Current Logic
		//iIH	The input IP address is not assigned to Canada	Internal	Current Logic
		//iII	The input IP address is assigned to a different state/province than the input state/province 	Internal	Current Logic
		//iIJ	The input address is assigned to a different postal code than the input postal code	Internal	Current Logic
		//iIK	The input IP address is assigned to a different area code than the input phone number	Internal	Current Logic
		ia := DATASET([{'IIA',IntlIID.getRCdesc('IIA')}],iesp.share.t_RiskIndicator);
		ie := DATASET([{'IIE',IntlIID.getRCdesc('IIE')}],iesp.share.t_RiskIndicator);
		ig := DATASET([{'IIG',IntlIID.getRCdesc('IIG')}],iesp.share.t_RiskIndicator);
		SELF.result.riskindicators := MAP(
			Risk_Indicators.rcSet.isCodeIA(le.result.inputecho.ipaddress, ri.ipaddr<>'') => CHOOSEN(le.result.riskindicators,iesp.Constants.MaxCountHRI-1)+ia,
			Risk_Indicators.rcSet.isCodeIE(ri.ipaddr<>'',ri.secondleveldomain,ri.ipType) => CHOOSEN(le.result.riskindicators,iesp.Constants.MaxCountHRI-1)+ie,
			Risk_Indicators.rcSet.isCodeIG(ri.ipType) => CHOOSEN(le.result.riskindicators, iesp.Constants.MaxCountHRI-1)+ig,
			le.result.riskindicators);
		SELF := le;
	END;
	wIP := JOIN(outdata,gwOut,LEFT.result.inputecho.ipaddress=RIGHT.ipaddr,addIP(LEFT,RIGHT),LEFT OUTER);
ENDMACRO;

import risk_indicators, gong, gateway;

export patriotPhoneTypeFlag(string10 p10) := function

	// search telcordia to get service type, then call risk_indicators.PRIIPhoneRiskFlag attribute to check nxx types
	telcordia_recs := risk_indicators.Key_Telcordia_tpm_slim(keyed(npa=p10[1..3]) and keyed(nxx=p10[4..6]) AND KEYED(tb in [p10[7], 'A']));
	
	phonetype := risk_indicators.PRIIPhoneRiskFlag(p10).patriotPhoneType(telcordia_recs[1].nxx_type);
	
	//Search gong by phone number
	p := record
		string10 phone10 := '';
	end;
	indata := dataset([{p10}], p);
	
	Risk_Indicators.Layouts.Layout_Input_Plus_Overrides t_f(indata le) := transform
		self.phone10 := le.phone10;
		self.historydate := 999999;
		self := [];
	end;
	gong_rec := riskwise.getDirsByPhone(project(indata, t_f(left)), Gateway.Constants.void_gateway, 0, 5);
		
	// if phonetype comes back as pots, check gong to find out if it's a business listing, otherwise, isBusiness will be false
	isBusiness := if(phonetype='0', gong_rec[1].business_flag, false);
	
	pt := if(isBusiness, '2', phonetype);
	
	return pt;
end;
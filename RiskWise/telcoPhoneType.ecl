import risk_indicators;
/*
 search telcordia to get point_id and dial_ind, calculate phonetype and return telcordia rec with the phone type attached
*/

export telcoPhoneType(string10 p10) := function

telcordia_recs := risk_indicators.Key_Telcordia_tpm_slim(keyed(npa=p10[1..3]) and keyed(nxx=p10[4..6]) AND KEYED(tb in [p10[7], 'A']));
	
r := record
	risk_indicators.Key_Telcordia_tpm_slim;
	string1 phonetype := '';
	string2 servicetype := '';
end;
	
r addPhoneType(telcordia_recs le) := transform
	self.phonetype := risk_indicators.PRIIPhoneRiskFlag('').telcordiaPhoneType(le.dial_ind, le.point_id);
	self.servicetype := risk_indicators.PRIIPhoneRiskFlag('').telcordiaServiceType(le.nxx_type);
	self := le;
end;

telco := project(telcordia_recs, addPhoneType(left));

r rollit(telco le, telco rt) := transform
	self := rt;
end;

rolled_telco := rollup(telco, true, rollit(left, right));

return rolled_telco;
	
end;
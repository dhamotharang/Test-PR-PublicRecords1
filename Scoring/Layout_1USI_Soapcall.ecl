import risk_indicators;

export Layout_1USI_Soapcall := RECORD
	unsigned4 	seq := 0;
	string4 	tribCode := '';
	string25 	account := '';
	string25 	acctno := '';
    string10 	hphone := '';
    string10 	wphone := '';
    string9 	socs := '';
    string10 	dob := '';
    string6 	income := '';
    string15 	first := '';
    string25 	last := '';
    string40 	cmpy := '';
    string50 	addr := '';
    string30 	city := '';
    string2 	state := '';
    string10 	zip := '';
	unsigned1	DPPAPurpose;
	unsigned1	GLBPurpose;
	integer6	HistoryDateYYYYMM;
	dataset(risk_indicators.Layout_Gateways_In) gateways; 
end;
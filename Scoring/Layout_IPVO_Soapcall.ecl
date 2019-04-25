import risk_indicators;
export Layout_IPVO_Soapcall := record
string	tribcode;  
string	account;  
string	ipaddr; 
integer	DPPAPurpose;
integer	GLBPurpose; 
integer	HistoryDateYYYYMM;
dataset(risk_indicators.Layout_Gateways_In) gateways;
end; 
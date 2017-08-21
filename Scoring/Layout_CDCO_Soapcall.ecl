import riskwise, risk_indicators;

export Layout_CDCO_Soapcall := record
	string		tribcode;
	riskwise.layouts.layout_cdci;
	integer		DPPAPurpose;
	integer		GLBPurpose; 
	integer		HistoryDateYYYYMM;
	dataset(risk_indicators.Layout_Gateways_In) gateways;
end;
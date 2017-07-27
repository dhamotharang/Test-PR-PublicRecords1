import Risk_Indicators;

export Layout_SC1O := RECORD
	STRING30 account := '';
	STRING30 acctno := '';
	STRING32 riskwiseid := '';
	STRING3  score := '';
	STRING2  reason11 := '';
	STRING2  reason21 := '';
	STRING2  reason31 := '';
	STRING2  reason41 := '';
	STRING3  score2 := '';
	STRING2  reason12 := '';
	STRING2  reason22 := '';
	STRING2  reason32 := '';
	STRING2  reason42 := '';
	STRING3  score3 := '';
	STRING2  reason13 := '';
	STRING2  reason23 := '';
	STRING2  reason33 := '';
	STRING2  reason43 := '';
	STRING3  score4 := '';
	STRING2  reason14 := '';
	STRING2  reason24 := '';
	STRING2  reason34 := '';
	STRING2  reason44 := '';
	STRING89 reserved := '';
	DATASET(risk_indicators.Layout_Billing) Billing;
END;
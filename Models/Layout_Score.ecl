import risk_indicators;

export Layout_Score :=
RECORD
	STRING i;
	STRING Description;
	STRING3 index := '';
	dataset(risk_indicators.layouts.layout_reason_codes_plus_seq) reason_codes;
END;
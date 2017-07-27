import Risk_Indicators;

export Layout_ModelOut := RECORD
	UNSIGNED Seq;
	STRING Score;
	dataset(Risk_Indicators.Layout_Desc) ri;
END;
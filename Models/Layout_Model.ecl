import Risk_Indicators;

export Layout_Model :=
RECORD
	STRING30 AccountNumber;
	STRING Description;
	DATASET(Layout_Score) Scores;
END;
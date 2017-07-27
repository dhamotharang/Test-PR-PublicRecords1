EXPORT Layout_ProdRec := RECORD
	BOOLEAN errorFlag := FALSE;
	DATASET(Layout_ParseRec) atoms{maxcount(100)};
END;
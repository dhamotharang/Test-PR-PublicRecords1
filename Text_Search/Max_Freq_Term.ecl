export Max_Freq_Term(DATASET(Layout_DictStats) statFile) := FUNCTION

	maxFreq := EVALUATE(statFile[1], maxFreq);
	
	RETURN maxFreq;
END;
	

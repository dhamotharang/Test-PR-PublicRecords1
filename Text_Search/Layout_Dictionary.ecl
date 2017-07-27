export Layout_Dictionary := RECORD
	Types.Nominal				nominal;
	Types.Freq					freq;      // term freq (mult terms possible per doc)
	Types.Freq        	docFreq;   // doc freq
	Types.NominalSuffix suffix;
	Types.WordType			typ;
	Types.WordStr				word;
END;
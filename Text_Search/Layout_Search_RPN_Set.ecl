EXPORT Layout_Search_RPN_Set := RECORD
	Types.OpCode					opCode;
	Types.Distance				maxLeftWindow;
	Types.Distance				maxRightWindow;
	Types.Distance				maxPhraseLength;
	Types.Stage						stage;
	Types.Distance				phraseLength;
	DATASET(Layout_RPN_Oprnd) inputs{MAXCOUNT(Limits.Max_Terms)};
END;

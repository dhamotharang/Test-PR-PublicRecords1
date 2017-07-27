import Header;

export Layout_LinkHeader := RECORD
	DayBatchHeader.Layout_clean_in indata;
	Header.Layout_Header outdata;
	STRING10 matchCode;
	unsigned8 seq := 0;
END;
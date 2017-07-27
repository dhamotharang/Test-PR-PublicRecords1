export Layout_BatchAddrDID :=
RECORD
	DayBatchHeader.Layout_clean_in;
	unsigned6 did;	
	STRING10 matchLevel;
END;
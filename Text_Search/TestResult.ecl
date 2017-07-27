IMPORT Text_Search;

EXPORT TestResult := RECORD
	Query;
	DATASET(Text_Search.Layout_DocHits) hits{MAXCOUNT(100)};
END;

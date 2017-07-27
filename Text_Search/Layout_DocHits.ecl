
export Layout_DocHits := RECORD
	Types.DocRef	docRef;
	Types.Score   score := 0.0;
	Types.SequenceKeyType seq := 0;
	Types.Section sect := 0;
	DATASET(Layout_SegHit) entries{MAXCOUNT(Limits.Max_DocHits)};
END;
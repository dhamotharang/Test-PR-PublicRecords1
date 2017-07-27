export Layout_Result := RECORD
	INTEGER8		totalCount;
	INTEGER8		thisCount;
	INTEGER8		start;
	INTEGER8		channel; // Not yet available
	DATASET(Layout_ScoredFlat) docs{MAXCOUNT(Limits.Max_Hits)};
END;
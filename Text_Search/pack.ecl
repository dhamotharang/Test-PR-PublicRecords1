EXPORT pack(STRING q, UNSIGNED4 s, DATASET(Layout_DocHits) a) :=
	DATASET([ROW({s, q, a}, TestResult)], TestResult);
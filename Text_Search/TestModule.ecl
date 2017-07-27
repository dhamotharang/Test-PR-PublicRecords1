EXPORT TestModule(STRING40 url,
									STRING100 fn,
									STRING40 srvc = 'Text_Search.SimpleSearch',
									BOOLEAN useGraph=FALSE,
									BOOLEAN compareTermID=FALSE) := MODULE

	EXPORT STRING40 RoxieURL := url;
	EXPORT STRING100 STD_FN := fn;
	EXPORT STRING40 ServiceName := srvc;
	EXPORT BOOLEAN STDExists := FileServices.FileExists(STD_FN);

	SHARED Answer := Text_Search.Layout_DocHits;
	SHARED SegHit := Text_Search.Layout_SegHit;

	SHARED Query toQry(TestInput inp, UNSIGNED4 cnt) := TRANSFORM
		SELF.seq := cnt;
		SELF.query := inp.str;
	END;

	SHARED Message := RECORD
		STRING100 Search;
		BOOLEAN Score;
		UNSIGNED4 Seqnum;
		BOOLEAN Use_Graph;
	END;

	SHARED Message toMsg(Query q, BOOLEAN b) := TRANSFORM
		SELF.Search := q.query;
		SELF.Score := b;
		SELF.Seqnum := q.seq;
		SELF.Use_Graph := useGraph;
	END;

	SHARED CmpResult := RECORD
		BOOLEAN match;
	END;

	EXPORT Diff_TestResult := RECORD
		Query;
		CmpResult;
		STRING50 desc;
	END;
	

	CmpResult cmpMergeHit(SegHit l, SegHit r) := TRANSFORM
		SELF.match := l.kwp = r.kwp AND l.wip = r.wip 
				AND (~compareTermID OR l.termID = r.termID);
	END;

	CmpResult cmpEntries(DATASET(SegHit) l, DATASET(SegHit) r) := TRANSFORM
		rslt := JOIN(l, r, LEFT.seg = RIGHT.seg
											 AND LEFT.kwp = RIGHT.kwp,
											 cmpMergeHit(LEFT, RIGHT), FULL OUTER);
		SELF.match := COUNT(rslt(~match)) = 0;
	END;

	BOOLEAN cmpEachHit(DATASET(Answer) l, DATASET(Answer) r) := FUNCTION
		rslt := JOIN(l, r, LEFT.docRef.src = RIGHT.docRef.src
											 AND LEFT.docRef.doc = RIGHT.docRef.doc
											 AND LEFT.sect = RIGHT.sect,
											 cmpEntries(LEFT.entries, RIGHT.entries)
											 
								 );
	
		RETURN COUNT(rslt(~match)) = 0;
	END;

	STRING50 DIFF_NUMHITS := '#s of hits differ';
	STRING50 DIFF_HITS := 'Hits differ';

	cmpHits(DATASET(Answer) l, DATASET(Answer) r) :=
		IF(COUNT(l) <> COUNT(r), DIFF_NUMHITS,
														 IF(cmpEachHit(l, r), '', DIFF_HITS));

	STRING50 MISSING_Q := 'Missing query';
	STRING50 NEW_Q := 'New query';

	Diff_TestResult cmpTestResult(TestResult t, TestResult s) := TRANSFORM
		SELF.seq := IF(t.seq > 0, t.seq, s.seq);
		SELF.query := IF(LENGTH(t.query) > 0, t.query, s.query);
		SELF.desc := IF(t.seq <= 0, MISSING_Q,
																IF(s.seq <= 0, NEW_Q, cmpHits(t.hits, s.hits)));
		SELF.match := LENGTH(TRIM(SELF.desc)) = 0;
	END;

	SHARED DATASET(Diff_TestResult) diff(DATASET(TestResult) tst, STRING fn) := FUNCTION
		std := IF(STDExists, DATASET(fn, TestResult, THOR), DATASET([], TestResult));
		RETURN SORT(JOIN(tst, std, LEFT.query = RIGHT.query, cmpTestResult(LEFT, RIGHT), FULL OUTER), seq);
	END;
	
	EXPORT search(DATASET(TestInput) inp) := FUNCTION
		queries := PROJECT(inp, toQry(LEFT, COUNTER));
		rslt := SOAPCALL(queries, RoxieURL, ServiceName,
										 Message, toMsg(LEFT, TRUE), DATASET(TestResult));
		RETURN SORT(rslt, seq);
	END;

	EXPORT searchAndCompare(DATASET(TestInput) inp) := FUNCTION
		RETURN diff(search(inp), STD_FN);
	END;
END;
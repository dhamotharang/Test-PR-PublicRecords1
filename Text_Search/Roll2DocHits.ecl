EXPORT Roll2DocHits(DATASET(Layout_MergeWork) ais, BOOLEAN keepHits) := FUNCTION
	// Temp for rollup
	Work1 := RECORD(Layout_MergeWork)
		INTEGER recCount := 0;
		Types.Section sect := 0;
	END;
	d1 := PROJECT(ais, Work1);
	// Data in roll up form, propagate marks and group up
	Work1 countAndMark(Work1 l, Work1 r) := TRANSFORM
		SELF.recCount := IF(l.recCount>Limits.Max_DocHits, 1, l.recCount+1);
		SELF.sect	:= IF(SELF.recCount=1, l.sect+1, l.sect);
		SELF := r;
	END;
	d2 := ITERATE(d1, countAndMark(LEFT,RIGHT));
	d3 := SORTED(d2, src, doc, sect);
	grpdAIS := GROUP(d3, src, doc, sect);
	Layout_DocResolve rollHits(Work1 l, DATASET(Work1) r) :=TRANSFORM
		SELF.docRef	 := l;
		SELF.entries := IF(keepHits, PROJECT(r, Layout_SegHit), 
											 DATASET([{0,0,0,0}], Layout_SegHit));
		SELF := l;
	END;
	recs_0 := ROLLUP(grpdAIS, GROUP, rollHits(LEFT, ROWS(LEFT)));
	recs_1 := UNGROUP(recs_0);
	rslt := DEDUP(recs_1, docRef.src, docRef.doc); 	
	RETURN rslt;
END;
export Rollup_docRefs(DATASET(Layout_ScoredFlat) recs) := FUNCTION

	Work1 := RECORD(Layout_ScoredFlat)
		INTEGER recCount := 0;
		Types.Section sect;
	END;
	d1 := PROJECT(recs, TRANSFORM(Work1, SELF.sect:=0, 
	                                     SELF.recCount := 0, SELF:=LEFT));
	
	Work1 countAndMark(Work1 l, Work1 r) := TRANSFORM
		SELF.recCount := IF(l.recCount>200, 1, l.recCount+1);
		SELF.sect	:= IF(SELF.recCount=1, l.sect+1, l.sect);
		SELF := r;
	END;
	d2 := ITERATE(d1, countAndMark(LEFT,RIGHT));
	d3 := SORTED(d2, docRef, sect);
	
	grpd := GROUP(d3, docRef, sect);
	
	Layout_SegHit slimHit(Work1 l) := TRANSFORM
		SELF := l;
	END;

	Layout_DocHits roll(Work1 l, DATASET(Work1) r) :=TRANSFORM
	  SELF.entries := PROJECT(r, SlimHit(LEFT));
		SELF := l;
		SELF := [];
	END;
	rslt := ROLLUP(grpd, GROUP, roll(LEFT, ROWS(LEFT)));
	RETURN rslt;
END;
	
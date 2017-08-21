// Find the duplicate content for supression
EXPORT Find_Dup := MODULE
	// Find candidate records before looking at field contents
	EXPORT Candidates(DATASET(Layout_Dup.Candidate) candidateRecs) := FUNCTION
		Layout1 := RECORD(Layout_Dup.Candidate)
			UNSIGNED4 candidates;
		END;
		Layout1 setup(Layout_Dup.Candidate l) := TRANSFORM
			SELF.candidates := 1;
			SELF := l;
		END;
		c0 := PROJECT(candidateRecs, setup(LEFT));
		c1 := SORT(c0, src, doc, mask, hashVal);
		Layout1 rollCandidate(Layout1 l, Layout1 r) := TRANSFORM
			SELF.candidates := l.candidates + r.candidates;
			SELF.rid := 0;
			SELF := l;
		END;
		c2 := ROLLUP(c1, rollCandidate(LEFT,RIGHT), src, doc, mask, hashVal);
		dupFields := c2(candidates>1);
		r0 := JOIN(c1, dupFields,
							LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc
							AND LEFT.mask=RIGHT.mask, 
							TRANSFORM(Layout_Dup.Ident, SELF:=LEFT));
		recFields := SORT(r0, src, doc, rid);
		Layout_Dup.Ident rollRID(Layout_Dup.Ident l, Layout_Dup.Ident r) := TRANSFORM
			SELF.mask := l.mask | r.mask;
			SELF := l;
		END;
		RETURN ROLLUP(recFields, rollRID(LEFT,RIGHT), src, doc, rid);
	END;
	
	// Find duplicate content by RID and Field
	EXPORT Content(DATASET(Layout_Dup.Value) valueRecs) := FUNCTION
		Layout1	:= RECORD(Layout_Dup.Value)
			UNSIGNED4		records;
		END;
		Layout1 cvt(Layout_Dup.Value l) := TRANSFORM
			SELF.records := 1;
			SELF := l;
		END;
		v0 := PROJECT(valueRecs, cvt(LEFT));
		v1 := SORT(v0, src, doc, mask, str, rid);
		Layout1 rollValue(Layout1 l, Layout1 r) := TRANSFORM
			SELF.records:= l.records + r.records;
			SELF				:= l;
		END;
		v2 := ROLLUP(v1, rollValue(LEFT, RIGHT), src, doc, mask, str);
		dupValues := v2(records>1);
		r0 := JOIN(v1, dupValues,
							LEFT.src=RIGHT.src AND LEFT.doc=RIGHT.doc
							AND LEFT.mask=RIGHT.mask AND LEFT.rid<>RIGHT.rid,
							TRANSFORM(Layout_Dup.Ident, SELF:=LEFT));
		recValues := SORT(r0, src, doc, rid);
		Layout_Dup.Ident rollRID(Layout_Dup.Ident l, Layout_Dup.Ident r) := TRANSFORM
			SELF.mask := l.mask | r.mask;
			SELF := l;
		END;
		RETURN ROLLUP(recValues, rollRID(LEFT,RIGHT), src, doc, rid);
	END;
END;
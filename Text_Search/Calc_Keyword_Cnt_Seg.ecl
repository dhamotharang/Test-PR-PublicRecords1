export Calc_Keyword_Cnt_Seg(DATASET(Layout_Posting) inv) := FUNCTION
  Layout_Posting segPostings(Layout_Posting l) := TRANSFORM
		SELF.part := l.part;
		SELF.docRef := l.docRef;
		SELF.seg := l.seg;
		SELF.kwp := 1;
		SELF.typ := Types.WordType.Metadata;
		SELF.nominal := Constants.KeywordCountNominal;
		SELF := [];
	END;
	work1 := PROJECT(inv, segPostings(LEFT));
	work1_d := DISTRIBUTED(work1, HASH32(docRef));
	Layout_Posting roll1(Layout_Posting l, Layout_Posting r) := TRANSFORM
		SELF.kwp := l.kwp + r.kwp;
		SELF := l;
	END;
	segs_postings := ROLLUP(work1_d, roll1(LEFT,RIGHT), 
													docRef.src, docRef.doc, seg, LOCAL);
  RETURN(segs_postings);
END;
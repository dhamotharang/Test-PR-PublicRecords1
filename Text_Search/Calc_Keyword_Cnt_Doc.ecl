export Calc_Keyword_Cnt_Doc(DATASET(Layout_Posting) inv) := FUNCTION
	// count of keywords in each doc
  Layout_Posting docPostings(Layout_Posting l) := TRANSFORM
		SELF.part := l.part;
		SELF.docRef := l.docRef;
		SELF.seg := 0;
		SELF.kwp := 1;
		SELF.typ := Types.WordType.Metadata;
		SELF.nominal := Constants.KeywordCountNominal;
		SELF := [];
	END;	
	work1 := PROJECT(inv, docPostings(LEFT));
	work1_d := DISTRIBUTED(work1, HASH32(docRef));
	Layout_Posting roll1(Layout_Posting l, Layout_Posting r) := TRANSFORM
		SELF.kwp := l.kwp + r.kwp;
		SELF := l;
	END;
	doc_postings := ROLLUP(work1_d, roll1(LEFT,RIGHT), 
												docRef.src, docRef.doc, LOCAL);
	RETURN doc_postings;
END;
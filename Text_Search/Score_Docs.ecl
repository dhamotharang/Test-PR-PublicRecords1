EXPORT Score_Docs(DATASET(Layout_MergeWork) ais, 
									DATASET(Layout_TermFreq) freqs, 
									Filename_Info info, 
									SET OF Types.PartitionID partList,
									INTEGER8 avgLen, INTEGER8 docCount,
									BOOLEAN keepHits) := FUNCTION
	ix_nominal := Indx_Nominal3(info);
	// Temp for rollup
	Work1 := RECORD(Layout_Mergework)
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
	
	FreqRec := RECORD
		Types.TermID termID;
		UNSIGNED2 occurs;
		UNSIGNED8 freq;
	END;
	DocRec  := RECORD(Layout_DocResolve)
		UNSIGNED4		 docSize;
		DATASET(FreqRec) terms{MAXCOUNT(Limits.Max_Terms+Limits.Max_Appended_Terms)};
	END;

	FreqRec cvtHit(Work1 l) := TRANSFORM
		SELF.freq := 1;			// safety, even if zero it occurs once.
		SELF.occurs := 1;
		SELF := l;
	END;
	FreqRec rollFreq(FreqRec l, FreqRec r) := TRANSFORM
		SELF.occurs := l.occurs + r.occurs;
		SELF := l;
	END;

	DocRec rollHits(Work1 l, DATASET(Work1) r) :=TRANSFORM
		SELF.docRef.src := l.src;
		SELF.docRef.doc := l.doc;
	  SELF.terms := ROLLUP(SORT(PROJECT(r, cvtHit(LEFT)), termID),
												 LEFT.termID=RIGHT.termID, 
												 rollFreq(LEFT, RIGHT));
		SELF.entries := IF(keepHits, PROJECT(r, Layout_SegHit), 
											 DATASET([{0,0,0,0}], Layout_SegHit));
		SELF.docSize := 1;
		SELF := l;
	END;
	recs_0 := ROLLUP(grpdAIS, GROUP, rollHits(LEFT, ROWS(LEFT)));
	recs_1 := UNGROUP(recs_0);
	DocRec rollTerms(DocRec l, DocRec r) := TRANSFORM
		SELF.entries := l.entries;		// truncate hits, more than max found
		SELF.terms := ROLLUP(MERGE([l.terms, r.terms], SORTED(termID)),
												 LEFT.termID=RIGHT.termID,
												 rollFreq(LEFT,RIGHT));
		SELF := l;
	END;
	recs_2 := ROLLUP(recs_1, rollTerms(LEFT,RIGHT), docRef.src, docRef.doc); 
	DocRec	addSize(DocRec l, ix_nominal indx) := TRANSFORM
		SELF.docSize := IF(indx.kwp > 0, indx.kwp, 1);
		SELF := l;
	END;
	docRecs := JOIN(recs_2, Indx_Nominal3(info),
								 KEYED(RIGHT.typ=Types.WordType.Metadata 
											 AND RIGHT.nominal = Constants.KeywordCountNominal 
											 AND RIGHT.lseg=0 AND LEFT.part=RIGHT.part 
											 AND LEFT.docRef.src=RIGHT.src AND LEFT.docRef.doc=RIGHT.doc) 
								 AND RIGHT.seg=0, addSize(LEFT,RIGHT), LEFT OUTER, ATMOST(1));
	
	TermScore := RECORD
		REAL8 score;
	END;
	TermScore termValue(FreqRec l, Layout_TermFreq r, UNSIGNED4 docSize) := TRANSFORM
		SELF.score := log2_x((docCount-r.freq+0.5)/(r.freq+0.5)) 	// IDF part
										// k = 2, b = 0.75
								 * (l.freq * 3)/(l.freq + 2*(0.25+0.75*docSize/avgLen));
	END;
	Layout_DocResolve procTerms(DocRec l) := TRANSFORM
		SELF.score := SUM(JOIN(l.terms, freqs, 
													 LEFT.termID=RIGHT.termID, 
													 termValue(LEFT,RIGHT, l.docSize)),
											score);
		SELF := l;
	END;
	rslt := PROJECT(docRecs, procTerms(LEFT));
	RETURN rslt;
END;
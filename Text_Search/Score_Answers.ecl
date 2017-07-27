//Produce the doc score record set for document selection
export Score_Answers(DATASET(Layout_AIS) ais, 
										 DATASET(Layout_TermFreq) freqs, 
										 Filename_Info info, 
										 SET OF Types.PartitionID partList,
										 INTEGER8 avgLen, INTEGER8 docCount,
										 BOOLEAN keepHits) := FUNCTION
	Work1 := RECORD
		Types.DocRef docRef;
		INTEGER recCount := 0;
		Types.Section sect;
		Types.TermID  termID;
	END;
	d1 := PROJECT(ais, TRANSFORM(Work1, SELF.sect:=0, 
	                                     SELF.recCount := 0, SELF:=LEFT));
	
	Work1 countAndMark(Work1 l, Work1 r) := TRANSFORM
		SELF.recCount := IF(l.recCount>=Limits.Max_Terms+Limits.Max_Appended_Terms-1, 1, l.recCount+1);
		SELF.sect	:= IF(SELF.recCount=1, l.sect+1, l.sect);
		SELF := r;
	END;
	d2 := ITERATE(d1, countAndMark(LEFT,RIGHT));
	d3 := SORTED(d2, docRef, sect);
	
	grpd := GROUP(d3, docRef, sect);
	
	FreqRec := RECORD
		Types.TermID termID;
		INTEGER8 freq;
	END;
	DocRec  := RECORD
		Types.DocRef docRef;
		DATASET(FreqRec) terms{MAXCOUNT(Limits.Max_Terms++Limits.Max_Appended_Terms)};
	END;

	FreqRec slimHit(Work1 l) := TRANSFORM
		SELF.freq := 1;
		SELF := l;
	END;

	DocRec roll(Work1 l, DATASET(Work1) r) :=TRANSFORM
	  SELF.terms := CHOOSEN(PROJECT(r, SlimHit(LEFT)),Limits.Max_Terms+Limits.Max_Appended_Terms);
		SELF := l;
	END;
	recs := ROLLUP(grpd, GROUP, roll(LEFT, ROWS(LEFT)));

   // get freq of term in each doc
	
	FreqRec sumTerm(FreqRec l, FreqRec r) := TRANSFORM
		SELF.freq := l.freq + r.freq;
		SELF := l;
	END;
	DocRec sumDoc(DocRec l) := TRANSFORM
		SELF.terms := ROLLUP(SORT(l.terms,termID),sumTerm(LEFT,RIGHT),termID);
		SELF := l;
	END;
	h2 := PROJECT(recs, sumDoc(LEFT));
	
	DocRec rollDoc(DocRec l, DocRec r) := TRANSFORM
		SELF.terms := CHOOSEN(l.terms + r.terms, Limits.Max_Terms+Limits.Max_Appended_Terms);
		SELF := l;
	END;
  h3 := ROLLUP(h2, rollDoc(LEFT, RIGHT), docRef.src, docRef.doc);
	counts := PROJECT(h3, sumDoc(LEFT));
	

	ScoreRec := RECORD	
		Types.docRef docRef;
		Types.TermID termID;
		INTEGER freqTermInDoc := 0;
		INTEGER cntTermsInDoc := 0;
		INTEGER8 freqTermInSet := 0; 
		REAL score := 0.0;
	END;
	ScoreRec xt2(DocRec L, FreqRec R) := TRANSFORM
	    SELF.termID := R.termID;
			SELF.freqTermInDoc := r.freq;
			SELF.freqTermInSet := 0;
			SELF := L;
			SELF := [];
	 END;
	 score0 := NORMALIZE(counts, LEFT.terms, xt2(LEFT,RIGHT));
	 ScoreRec getFreq(ScoreRec l, Layout_TermFreq r) := TRANSFORM
		SELF.freqTermInSet := r.freq;
		SELF := l;
	 END;
	 score1 := JOIN(score0, freqs, LEFT.termID=RIGHT.termID,
									getFreq(LEFT,RIGHT), LEFT OUTER, LOOKUP);
	 
   // get termsInDoc 
	 nomNdx := Indx_Nominal3(info);
	 score2 := JOIN(score1, nomNdx, 
									KEYED(RIGHT.typ = Types.WordType.Metadata 
												AND RIGHT.nominal = Constants.KeywordCountNominal 
												AND RIGHT.lseg = 0
												AND RIGHT.part IN partList
	                      AND LEFT.docRef.src = RIGHT.src 
												AND LEFT.docRef.doc = RIGHT.doc
												AND RIGHT.seg=0),
									TRANSFORM(ScoreRec, 
														SELF.cntTermsInDoc:=RIGHT.kwp, SELF:=LEFT),
									LIMIT(Limits.Max_Lookup, 
												FAIL(Limits.Lookup_Code, Limits.Lookup_Msg)));
	 
	 // calc scores according to variation of Okapi/BM25
	 ScoreRec calcScores(ScoreRec L) := TRANSFORM
	    SELF.score := log2_x(docCount/l.freqTermInSet)
			              *((2.0*l.freqTermInSet)/(0.25+(l.cntTermsInDoc/avgLen)));
			SELF := L;
	 END;
			
	 score3 := PROJECT(score2, calcScores(LEFT));
	 	 
   // sum scores for each doc
	Layout_DocScore rollScore(Layout_DocScore l, Layout_DocScore r) := TRANSFORM
		SELF.score := l.score + r.score;
		SELF := l;
	END;
	score4 := PROJECT(score3, Layout_DocScore);
	final_scores := ROLLUP(score4, rollScore(LEFT,RIGHT), 
													docRef.src, docRef.doc);
	 
  RETURN final_scores;
END;
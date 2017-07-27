//Generate the special inversion entries for document length, 
// partitions, et cetera
EXPORT Generate_Special_Entries(DATASET(Layout_Posting) invInput) := MODULE
	// Add in alternates (numeric as string for now)
	Layout_Posting cvtNumeric(Layout_Posting l) := TRANSFORM
		SELF.nominal := 0;
		SELF.suffix	 := 0;
		SELF.typ := Types.WordType.TextStr;
		SELF := l;
	END;
	inv_n := invInput(typ=Types.WordType.Numeric);
	SHARED nstr  := PROJECT(inv_n, cvtNumeric(LEFT));
	
	
	TypeSet := [Types.WordType.TextStr, Types.WordType.Numeric, 
							Types.WordType.Date, Types.WordType.Float, 
							Types.WordType.SSN];
	SHARED inv4DocLen := invInput(typ IN TypeSet);
	// count of keywords in each seg in each doc
	SHARED segs_postings := Text_Search.Calc_Keyword_Cnt_Seg(inv4DocLen);
	
	// count of keywords in each doc
	EXPORT docs_postings := Text_Search.Calc_Keyword_Cnt_Doc(inv4DocLen);
	
	// transform for partition and dictionary build version 
	Layout_Posting mak1(Layout_Posting l, UNSIGNED4 n, UNSIGNED3 s, STRING w) := TRANSFORM
		SELF.nominal := n;
		SELF.typ := Types.WordType.Metadata;
		SELf.part := l.part;
		SELF.suffix := s;		
		SELF.word := w;
		SELF := [];
	END;
	
	// Create partition record
	prec := DEDUP(docs_postings, TRUE, LOCAL);
	part := PROJECT(prec, mak1(LEFT, Constants.PartitionIDNominal, 0, ''));
	

	ver := PROJECT(prec, mak1(LEFT, Constants.DictVersionNominal, 
														Constants.CurrDictVer, (STRING) Constants.DictVersion));
	
	// Create special numbers and dates for range searching
	SET OF Types.WordType rangeTypes := [Types.WordType.Numeric, Types.WordType.Date];
	Layout_Posting cvtRange(Layout_Posting l) := TRANSFORM
		SELF.typ := CASE(l.typ,
									Types.WordType.Numeric		=> Types.WordType.NumericRange,
									Types.WordType.Date				=> Types.WordType.DateRange,
									l.typ);
		SELF.suffix  := IF(l.typ IN rangeTypes,
											(l.nominal + l.suffix),
											l.suffix);
		SELF.nominal := l.nominal+l.suffix - SELF.suffix;
		SELF := l;
	END;
	rangeEntries := PROJECT(invInput(typ IN rangeTypes), cvtRange(LEFT));
	
	
	EXPORT rslt := nstr + segs_postings + docs_Postings + part + ver + rangeEntries;				

END;
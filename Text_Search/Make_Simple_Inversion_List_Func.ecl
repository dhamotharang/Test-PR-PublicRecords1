// The simple process for making a file of postings for the inversion.
// Uses simple documents only.
//
IMPORT Lib_ThorLib;

export Make_Simple_Inversion_List_Func(DATASET(Layout_Simple_Document) ds,
																			FileName_Info info,
																			Types.SourceID source) := FUNCTION

MAC_Doc_Parse_Rule()

Make_dd(STRING d) := IF(LENGTH(d)=1, '0' + d, d);

Layout_Posting p1(Layout_Simple_Document l, 
								INTEGER field) 	:= TRANSFORM
	SELF.word := MAP(
		MATCHED(wordPattern)=> TRIM(MATCHTEXT(wordPattern)),
		MATCHED(textDate)		=> MATCHTEXT(yyyy) + Date_Name.mm(MATCHTEXT(monthName))
														+ Make_dd(MATCHTEXT(dd)),
		MATCHED(mo_dy_yr)		=> INTFORMAT(ConvertDate(MATCHTEXT(mo_dy_yr),FALSE),8,1),
		MATCHED(yr_mo_dy)		=> INTFORMAT(ConvertDate(MATCHTEXT(yr_mo_dy),TRUE), 8,1),
		MATCHED(number)			=> INTFORMAT((UNSIGNED)MATCHTEXT(number), 9,1),
					'');
	SELF.kwp := 0;
	SELF.wip := 1;
	SELF.typ := MAP(
		MATCHED(wordPattern)=>	Types.WordType.TextStr,
		MATCHED(datePattern)=>	Types.WordType.Date,
		MATCHED(number)			=>	Types.WordType.Numeric,
		MATCHED(paraPattern)=>	Types.WordType.Metadata,
		Types.WordType.Unknown);
	SELF.seg := field;
	SELF.docRef.doc := l.docID;
	SELF.docRef.src := source;
	SELF.nominal := MAP(
		MATCHED(wordPattern)=> 0,
		MATCHED(textDate)		=> (((UNSIGNED) SELF.word) DIV 10000)*10000,
		MATCHED(mo_dy_yr)		=> (ConvertDate(MATCHTEXT(mo_dy_yr),FALSE) DIV 10000)*10000,
		MATCHED(yr_mo_dy)		=> (ConvertDate(MATCHTEXT(yr_mo_dy),TRUE) DIV 10000)*10000,
		MATCHED(number)			=> (((UNSIGNED) MATCHTEXT(number)) DIV 16777216)*16777216,
					0);
	SELF.suffix := MAP(
		MATCHED(wordPattern)=> 0,
		MATCHED(textDate)		=> ((UNSIGNED) SELF.word)%10000,
		MATCHED(mo_dy_yr)		=> ConvertDate(MATCHTEXT(mo_dy_yr),FALSE)%10000,
		MATCHED(yr_mo_dy)		=> ConvertDate(MATCHTEXT(yr_mo_dy),TRUE)%10000,
		MATCHED(number)			=> ((UNSIGNED) MATCHTEXT(number))%16777216,
					0);
	SELF.sect := 0;
	SELF.pos := MATCHPOSITION(Doc_Parse_Rule);
	SELF.len := MATCHLENGTH(Doc_Parse_Rule);
	SELF.part := ThorLib.node();
END;

Layout_Posting c1(Layout_Posting l, INTEGER c) := TRANSFORM
	SELF.kwp := c;
	SELF.word := KeywordingFunc(l.word);
	SELF := l;
END;

r1 := PARSE(ds, HeadLine, Doc_Parse_Rule, p1(LEFT, 1), 
						MAX, MATCHED(ALL), MANY);
r2 := PARSE(ds, Body, Doc_Parse_Rule, p1(LEFT, 2),
						MAX, MATCHED(ALL), MANY);
r3 := PARSE(ds, Date, Doc_Parse_Rule, p1(LEFT, 3),
						MAX, MATCHED(ALL), MANY);

r := SORT(DISTRIBUTED(r1+r2+r3, docRef.doc), docRef, seg, pos, LOCAL);
dr := GROUP(r(typ<>Types.WordType.Unknown), docRef, LOCAL);

s := UNGROUP(PROJECT(dr, c1(LEFT,COUNTER)));

// count of keywords in each seg in each doc
segs_postings := Text_Search.Calc_Keyword_Cnt_Seg(s);
	
// count of keywords in each doc
docs_postings := Text_Search.Calc_Keyword_Cnt_Doc(s);

// Create partition record
prec := DEDUP(docs_postings, TRUE, LOCAL);
Layout_Posting makePartRec(Layout_Posting l) := TRANSFORM
	SELF.nominal := Constants.PartitionIDNominal;
	SELF.typ := Types.WordType.Metadata;
	SELf.part := l.part;
	SELF := [];
END;
part := PROJECT(prec, makePartRec(LEFT));

// add the special 'count' postings
t := s & docs_postings & segs_postings & part;
	
RETURN t;

END;
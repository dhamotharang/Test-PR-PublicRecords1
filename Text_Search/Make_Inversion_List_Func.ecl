// The process for making a file of postings for the inversion.
// Uses generic documents only.
//
#OPTION('parseDfaComplexity',10000);
IMPORT LIB_ThorLib, LIB_Word;
export Make_Inversion_List_Func(DATASET(Layout_DocSeg) ds,
																			FileName_Info info,
																			IKeywording kwd) := FUNCTION
																			
	Work_DocSeg := RECORD(Layout_DocSeg)
		Types.SegmentType segType;
	END;
	Work_Posting := RECORD(Layout_Posting)
		Types.SegmentType segType;
		BOOLEAN equivalent := FALSE;
		Types.WordStrV EquivLookupWord;
	END;
	
	Work_SegDef := RECORD
		Types.Segment 			seg;
		Types.SegmentType 	segType;
	END;
	SegListX := File_Segment_Definition(info)(COUNT(seglist)=1);
	
	Work_SegDef makeSegTab(SegListX l) := TRANSFORM
		SELF.segType := l.segType;
		SELF.seg := l.segList[1];		// always just 1
	END;
	SegTab := PROJECT(SegListX, makeSegTab(LEFT));

	Work_DocSeg getSegType(Layout_DocSeg l, Work_SegDef r) := TRANSFORM
		SELF.segType := IF(r.segType=0, Types.SegmentType.TextType, r.segType);		
		SELF := l;
	END;
		
	ws := JOIN(ds, SegTab, LEFT.segment=RIGHT.seg, 
						getSegType(LEFT,RIGHT), LEFT OUTER, LOOKUP);

	fs := DISTRIBUTED(ws, docRef.doc);

	MAC_Doc_Parse_Rule()
	// insert leading zero for day
	Make_dd(STRING d) := IF(LENGTH(d)=1, '0' + d, d);
	// pad out date to force 8 digits
	padZero(STRING str) := (str + '00000000')[1..8];
	//
	STRING multiWds(STRING str) := TRIM(StringLib.StringSubstituteOut(str, '.-', ' '), LEFT, RIGHT);
	STRING getNthWord(STRING str, UNSIGNED1 pos) := TRIM(LIB_Word.Word(str, pos), LEFT, RIGHT);

	Work_Posting p1(Work_DocSeg l) 	:= TRANSFORM
		STRING numStr := MATCHTEXT(number);
		BOOLEAN isSSN := MATCHED(ssnPattern) AND l.segType = Types.SegmentType.SSN;
		STRING ssn_str:= TRIM(STRINGLIB.StringFilterOut(MATCHTEXT(ssnPattern), '-'),LEFT,RIGHT);
		Types.Nominal	numVal := (Types.Nominal) numStr;
		BOOLEAN ForceString := l.segType = Types.SegmentType.TextType AND MATCHED(intg);
		BOOLEAN ForceDate := l.segType = Types.SegmentType.DateType
				AND (numVal BETWEEN 18000000 AND 21000000 OR numVal BETWEEN 1800 AND 2100);
		BOOLEAN mayNeedCnv := ForceString OR MATCHED(specialString);
		STRING matchX := multiWds(MATCHTEXT);
		UNSIGNED1 countWords(STRING instr) := LENGTH(StringLib.StringFilter(instr, ' ')) + 1;
		UNSIGNED1 startAt := StringLib.StringFind(MATCHTEXT, getNthWord(matchX, 1), 1);
		
		SELF.word := MAP(
			MATCHED(ssnPattern)			=>	ssn_str,
			mayNeedCnv	 						=>	matchX,
			ForceDate								=>	padZero(numStr),
			MATCHED(wordPattern)		=>	MATCHTEXT(wordPattern),
			MATCHED(kwdWPuncts)			=>	MATCHTEXT(kwdWPuncts),
			MATCHED(MultiEquiv)			=>	MATCHTEXT(MultiEquiv),
			MATCHED(textDate)				=>	MATCHTEXT(yyyy) + Date_Name.mm(MATCHTEXT(monthName))
																	 + Make_dd(MATCHTEXT(dd)),
			MATCHED(mo_dy_yr)				=>	INTFORMAT(ConvertDate(MATCHTEXT(mo_dy_yr),FALSE),8,0),
			MATCHED(yr_mo_dy)				=>	INTFORMAT(ConvertDate(MATCHTEXT(yr_mo_dy),TRUE), 8,0),
			MATCHED(decimalString)	=>	MATCHTEXT,
			MATCHED(intg)						=>	MATCHTEXT,
						'');
		SELF.seg := l.segment;
		SELF.kwp := 0;
		SELF.wip := MAP(
			mayNeedCnv							=>  countWords(matchX),
			MATCHED(MultiEquiv)			=>	countWords(MATCHTEXT(MultiEquiv))+1, // Add one to allow for insertion of equivalency term
			1);
		SELF.typ := MAP(
			isSSN										=>	Types.WordType.SSN,
			MATCHED(ssnPattern)			=>  Types.WordType.Numeric,
			mayNeedCnv	 						=> 	Types.WordType.TextStr,
			ForceDate								=> 	Types.WordType.Date,
			MATCHED(wordPattern)		=>	Types.WordType.TextStr,
			MATCHED(kwdWPuncts)			=>	Types.WordType.TextStr,
			MATCHED(MultiEquiv)			=>	Types.WordType.MultiEquiv,
			MATCHED(datePattern)		=>	Types.WordType.Date,
			MATCHED(decimalString)	=>	Types.WordType.Numeric,
			MATCHED(intg)						=>	Types.WordType.Numeric,
			MATCHED(paraPattern)		=>	Types.WordType.Metadata,
			Types.WordType.Unknown);
		SELF.docRef := l.docRef;
		SELF.nominal := MAP(
			mayNeedCnv	 						=>	0,
			ForceDate 							=>	(Types.Nominal) padZero(numStr),
			isSSN										=> 	0,
			MATCHED(wordPattern)		=>	0,
			MATCHED(kwdWPuncts)			=>	0,
			MATCHED(MultiEquiv)			=>	0,
			MATCHED(textDate)				=>	(Types.Nominal) SELF.word,
			MATCHED(mo_dy_yr)				=>	ConvertDate(MATCHTEXT(mo_dy_yr),FALSE),
			MATCHED(yr_mo_dy)				=>	ConvertDate(MATCHTEXT(yr_mo_dy),TRUE),
			MATCHED(decimalString)	=>	(Types.Nominal) NumericCollationFormat.StringToNCF(MATCHTEXT),
			MATCHED(intg)						=>	(Types.Nominal) NumericCollationFormat.StringToNCF(MATCHTEXT),
			MATCHED(ssnPattern)			=>	(Types.Nominal) NumericCollationFormat.StringToNCF(ssn_str),
			MATCHED(paraPattern)		=>	Constants.ParagraphNominal,
			0);
		SELF.suffix := 0;
		SELF.sect := l.sect;
		SELF.pos := MATCHPOSITION(Doc_Parse_Rule) + IF(mayNeedCnv AND startAt > 0, startAt - 1, 0);
		SELF.len := MATCHLENGTH(Doc_Parse_Rule) - IF(mayNeedCnv AND startAt > 0, startAt - 1, 0);
		SELF.part := ThorLib.node();
		SELF.segType := l.segType;
		SELF.equivalent := MATCHED(MultiEquiv);
		
		SELF := [];	// for new fields
	END;

	Work_Posting p2(Work_Posting input, UNSIGNED1 cnt) := TRANSFORM
		STRING tmpWd := getNthWord(input.word, cnt);
		STRING equivWd := getNthWord(input.word, cnt-1);
		STRING fullEquiv := input.EquivLookupWord;
		BOOLEAN firstEquivWd := (input.typ = Types.WordType.MultiEquiv AND cnt = 1);
		
		/* When assigning the word,pos,len etc fields below, special rules exist for when the word type is Multi Equiv
       When the type is multiEquiv, the logic is inserting a new word into the dictionary. This phrase will have
			 its own unique nomimal value, for instance for NY, word NewYork is being added. For this reason when the input
			 type is multiEquiv and we are at the first position of the phrases, the logic below will insert a new word. */
		SELF.word := IF(input.typ = Types.WordType.MultiEquiv,
												IF(cnt = 1,fullEquiv,equivWd),
												IF(input.wip > 1,tmpWd,input.word));
		SELF.pos := IF(input.typ = Types.WordType.MultiEquiv,
											IF(cnt < 3, input.pos,input.pos + StringLib.StringFind(input.word, ' ', cnt - 2)),
											IF(input.wip > 1 AND cnt > 1,input.pos + StringLib.StringFind(input.word, ' ', cnt - 1), input.pos));
		
		SELF.len := IF(input.typ = Types.WordType.MultiEquiv,
											IF(cnt = 1, LENGTH(fullEquiv),LENGTH(equivWd)),
											IF(input.wip > 1,LENGTH(tmpWd),input.len));
		SELF.typ := IF(input.typ = Types.WordType.MultiEquiv,
											 IF(cnt = 1, input.typ, Types.WordType.TextStr),
											 input.typ);
		SELF.wip := IF (firstEquivWd,input.wip-1,1);
		SELF.equivalent := IF (input.typ = Types.WordType.MultiEquiv,
															IF(cnt = 1,input.equivalent,FALSE),
															input.equivalent);
		SELF := input;
	END;

	w_inv := PARSE(fs, content, Doc_Parse_Rule, p1(LEFT), MAX, MANY);
	// For equivalent phrases, join with equivalent lookup dataset to add the equivalence word
	w_inv2 := JOIN(w_inv,Equivalence.myd,LEFT.typ = Types.WordType.MultiEquiv AND
																			 StringLib.StringToUpperCase(LEFT.word) = RIGHT.wd,
																			 TRANSFORM(Work_Posting,
																								 SELF.EquivLookupWord := RIGHT.wds[1],
																								 SELF := LEFT),LOOKUP,LEFT OUTER);
	s_inv := w_inv2(typ<>Types.WordType.Unknown);
	s_inv2 := NORMALIZE(s_inv, LEFT.wip, p2(LEFT, COUNTER));
	d_inv := DISTRIBUTED(s_inv2, HASH32(docRef.doc));
	
	// Expand to sequence of keyword goes here

	// number keywords
	Work_Posting c1(Work_Posting l, Work_Posting r) := TRANSFORM
		SELF.kwp := MAP(l.docRef != r.docRef			=> 1,
										l.seg != r.seg						=> l.kwp + Constants.InterSubSegDistance,	//break proximity at seg
										l.sect != r.sect					=> l.kwp + Constants.InterSubSegDistance,	//break proximity at subSeg
										l.pos = r.pos 						=> l.kwp,  //For multi word equivs, equivalence word and first word of phrase have same keyword pos.
										l.kwp + 1);
		SELF.word := kwd.typeWord(r.word, r.segType, r.seg, r.equivalent);
		SELF := r;
	END;
	inv	 	:= ITERATE(d_inv, c1(LEFT,	RIGHT),	LOCAL);

	// expand to set goes here

	// Select posting stream to use
	post := Project(inv, Layout_Posting);

	RETURN post;
END;
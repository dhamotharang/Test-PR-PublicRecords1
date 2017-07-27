// Parse the search request.
EXPORT Parse_Search_Request(FileName_Info info, 
														KeywordingFunc keywordWord,
														STRING srqst,
														ParseQueryFunc pqf = ParseQueryFunc) := FUNCTION

	preProcess(STRING qStr)
		:= REGEXREPLACE('(^|[!#\\$%&\'\\(\\)+,-./:;<=>@\\[\\\\\\]\\^\\{\\|\\}~]|[[:space:]])([[:digit:]]+)([[:alpha:]])([[:alnum:]]*)', 
		                qStr, '$1$2 $3$4');
		
	srch := DATASET([{preProcess(srqst)}], Layout_String);
	SET OF UNSIGNED2 storedAll := ALL : STORED('storedAll'); // work around
	
	// Helpers
	Op	:= Map_Search_Operands;
	normStr(STRING str) := StringLib.StringToUpperCase(TRIM(str, ALL));
	INTEGER extractNumber(STRING s) := (INTEGER) 
															STRINGLIB.StringFilter(s, '0123456789');

	// Segment lists
	segDef := LIMIT(Indx_Segment_Definition(info),Limits.Max_Segments,
									FAIL(Limits.Segments_Code, Limits.Segments_Msg));
	Layout_Segment_Definition cvtSegList(segDef l) := TRANSFORM
		SELF.segName := StringLib.StringFindReplace(StringLib.StringToUpperCase(l.segName), '-', '_');
		SELF := l;
	END;
	// when segnames conflict, prefer the group/concat/alias segments over the rest
	segNorm := DEDUP(SORT(PROJECT(segDef,cvtSegList(LEFT)),segName,-segType), 
										segName);
	segList := SET(segNorm, segName);
	dateList:= SET(segNorm(segType=Types.SegmentType.DateType), segName);
	numericList := SET(segNorm(segType=Types.SegmentType.NumericType), segName);
	isSegName(STRING s) 		:= StringLib.StringToUpperCase(s) IN segList;
	isDateName(STRING s) 		:= StringLib.StringToUpperCase(s) IN dateList;
	isNumericName(STRING s) := StringLib.StringToUpperCase(s) IN numericList;
	SET OF UNSIGNED2 getDef(STRING s) := FUNCTION
		RETURN segNorm(segName=s)[1].segList;
	END;
	//
	
	//Pick up flags 
	p0 := Indx_Nominals(info)(KEYED(typ=Types.WordType.MetaData 
																		AND nominal=Constants.SchemeNominal)
														AND WILD(part));
	schemeRecords := LIMIT(p0, Limits.Max_Parts, 
								FAIL(Limits.Parts_Code, Limits.Parts_Msg), KEYED);
	INTEGER suffixScheme := IF(EXISTS(schemeRecords), 
														 EVALUATE(schemeRecords[1], suffix), 
														 0);												


	pr1 := pqf(srch, isSegName);
	pn := NORMALIZE(pr1, LEFT.atoms, TRANSFORM(RIGHT));

	Layout_Search_RPN cvt(Layout_ParseRec l, INTEGER c, INTEGER scheme) := TRANSFORM
		listA := Dict_Word_List(info, keywordWord, l.A.word, l.A.typ, l.A.filterType, scheme);
		listB := Dict_Word_List(info, keywordWord, l.B.word, l.B.typ, l.B.filterType, scheme);
		SELF.A.segList := IF(l.A.segName='', storedAll, getDef(l.A.segName));
		SELF.A.id := (c*2) - 1;
		SELF.A.terms := listA.Get_Word_List;
		SELF.A.nominals := listA.Get_Nominal_List;
		SELF.A.suffixes := listA.Get_Suffix_List;
		SELF.A.fullNominals := listA.Get_FullNominal_List;
		SELF.A.filterType := l.A.filterType;
		SELF.A.postSort := listA.WildCard OR l.A.filterType<>Types.NominalFilter.IN_Filter;
		SELF.A.freq := listA.Get_Term_Freq;
		SELF.A.searchArg := l.A.word;
		SELF.A.docFreq := listA.Get_Term_DocFreq;
		SELF.A.typ := listA.RevisedType;
		SELF.B.segList := IF(l.B.segName='', storedAll, getDef(l.B.segName));
		SELF.B.id := c*2;
		SELF.B.terms := listB.Get_Word_List;
		SELF.B.nominals := listB.Get_Nominal_List;
		SELF.B.suffixes := listB.Get_Suffix_List;
		SELF.B.fullNominals := listB.Get_FullNominal_List;
		SELF.B.filterType := l.B.filterType;
		SELF.B.postSort := listB.WildCard OR l.B.filterType<>Types.NominalFilter.IN_Filter;
		SELF.B.freq := listB.Get_Term_Freq;
		SELF.B.docFreq := listB.Get_Term_DocFreq;
		SELF.B.searchArg := l.B.word;
		SELF.B.typ := listB.RevisedType;
		SELF.opCode := l.opCode;
		SELF := l;
		SELF := [];
	END;
	rslt := PROJECT(pn, cvt(LEFT, COUNTER, suffixScheme));
	RETURN rslt;
END;
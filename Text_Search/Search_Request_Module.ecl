// A search request object
// Iitial implementation will take a dataset of search strings
//
export Search_Request_Module(FileName_Info info,
															IKeywording kwd, 
															STRING srchRqst,
															BOOLEAN expEqv = TRUE,
															BOOLEAN expDrctWildcard = FALSE) := MODULE
	dictStats := CHOOSEN(Indx_DictStat(info), 1); 
	INTEGER8 docCount := EVALUATE(dictStats[1], maxDocFreq) 	: GLOBAL;
	INTEGER8 wrdCount := EVALUATE(dictStats[1], maxFreq)			: GLOBAL;

	// Parse the search request
	srchN := (UNICODE) srchRqst;	// TO DO: remove the cast
	SET OF UNSIGNED2 storedAll := ALL : STORED('storedAll'); // work around


	// Handling segments
	segMeta := Segment_Metadata(info, TRUE);

	isSegName(STRING s) := segMeta.isSegName(s);
	getDef(STRING s) := segMeta.getDef(s);
	isThisSeg(STRING s, Types.SegmentType t) := segMeta.isType(s, t);
  


	// RPN
	op_Get 						:= Map_Search_Operands.code_GET;
	op_RngGet 				:= Map_Search_Operands.code_RNGGET;
	flt_IN						:= Types.NominalFilter.IN_Filter;
	flt_EQ						:= Types.NominalFilter.EQ_Filter;
	typ_numeric 			:= Types.WordType.Numeric;
	typ_date					:= Types.WordType.Date;
	typ_numericRange	:= Types.WordType.NumericRange;
	typ_dateRange			:= Types.WordType.DateRange;
	rtypes 						:= [typ_numericRange, typ_dateRange];
	EQ_filters				:= [flt_IN, flt_EQ];

	Layout_Search_RPN cvt(Layout_ParseRec l, BOOLEAN isSRNG = FALSE) := TRANSFORM
		eqvs := Equivalence.get(l.A.word)[1];
		drcts := Equivalence.getDirectional(l.A.word)[1];
		BOOLEAN expands := ~l.A.sprsEqv AND expEqv;
		BOOLEAN drctExpands := l.A.drctExp AND expDrctWildcard;
		STRING wd := IF(drctExpands, Equivalence.getDirRepl(drcts), l.A.word);
		UNSIGNED numEqvs := IF(expands, eqvs.numWds, IF(drctExpands, drcts.numWds, 0));
		Types.WordList equivs := IF(expands, eqvs.wds, IF(drctExpands, drcts.wds, []));

		listA2 := Dict_Lookup2(info, kwd, wd, l.A.typ, l.A.filterType,
							l.A.rangeType, l.A.segName, numEqvs, equivs,
							docCount, wrdCount);
		typ := listA2.RevisedType;

		SELF.A.segList := IF(l.A.segName='', storedAll, getDef(l.A.segName));
		SELF.A.id := l.stage;
		SELF.A.terms := listA2.Get_Word_List;
		Get_Suffix_List := listA2.Get_Suffix_List;
		Get_Nominal_List := listA2.Get_Nominal_List;
		SELF.A.nominals := IF(isSRNG, Get_Suffix_List, Get_Nominal_List);
		SELF.A.suffixes := IF(isSRNG, Get_Nominal_List, Get_Suffix_List);
		SELF.A.fullNominals := listA2.Get_FullNominal_List;
		SELF.A.filterType := l.A.filterType;
		SELF.A.deferWildCard := listA2.deferWildCard;
		SELF.A.freq := listA2.Get_Term_Freq;
		SELF.A.searchArg := wd;
		SELF.A.docFreq := listA2.Get_Term_DocFreq;
		SELF.A.typ := IF(isSRNG, CASE(typ, typ_numericRange => typ_numeric,
																			 typ_dateRange => typ_date,
																			 typ), typ);
		SELF.opCode := IF(isSRNG, op_GET, l.opCode);
		SELF := l;
		SELF := [];
	END;

	DATASET(Layout_Search_RPN_Set) myF(DATASET(Layout_ParseRec) input) := FUNCTION
		Layout_Search_RPN_Set cvtOp(Layout_Search_RPN l) := TRANSFORM
			Layout_RPN_Oprnd cvtOprnd(Layout_Search_operand opr) := TRANSFORM
				SELF.leftWindow := l.leftWindow;
				SELF.rightWindow := l.leftWindow;
				SELF := opr;
			END;

			SELF.opCode := l.opCode;
			SELF.maxLeftWindow := l.leftWindow;
			SELF.maxRightWindow := l.rightWindow;
			SELF.stage := l.stage;
			SELF.phraseLength := 0;
			SELF.inputs := DATASET(ROW(cvtOprnd(l.A)));
			SELF.maxPhraseLength := SELF.phraseLength;
		END;


		BOOLEAN isSingleRngGet := COUNT(input) = 1 AND input[1].opCode = op_RngGet;

		r0a := PROJECT(input, cvt(LEFT));
		r0b := PROJECT(input, cvt(LEFT, TRUE));
		RETURN PROJECT(IF(isSingleRngGet, r0b, r0a), cvtOp(LEFT));
	END;

	// Parse the query
	pn := ParseQueryFuncUnicode(srchN, isSegName, isThisSeg, myF, kwd.dictVersion);

	// Update "Max" values
	Layout_Search_RPN_Set m1(Layout_Search_RPN_Set l, Layout_Search_RPN_Set r):=TRANSFORM
		SELF.maxPhraseLength := MAX(l.maxPhraseLength, r.maxPhraseLength);
		SELF := r;
	END;
	r0 := ITERATE(pn, m1(LEFT,RIGHT));

	EXPORT RPN_Search_Request := r0;

END;
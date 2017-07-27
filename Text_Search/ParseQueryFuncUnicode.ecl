/*2011-11-10T18:23:14Z (Keith Dues)
RR 81404 - Modified to correct beg end seperator
*/
DATASET(Layout_Search_RPN_Set) CnvF(DATASET(Layout_ParseRec) input) := FUNCTION
	Layout_Search_RPN_Set toRPN(Layout_ParseRec input) := TRANSFORM
		Layout_RPN_Oprnd toPRNOprnd(Layout_OprndRec oprnd) := TRANSFORM
			eqv := Equivalence.get(oprnd.word)[1];
			drct := Equivalence.getDirectional(oprnd.word)[1];

			SELF.searchArg := IF(input.A.drctExp, Equivalence.getDirRepl(drct), oprnd.word);
			SELF.segList := IF(oprnd.segName <> '', [HASH32(oprnd.segName) % 65536], []);
			SELF.terms := IF(input.A.sprsEqv, IF(input.A.drctExp, drct.wds, []),
																				eqv.wds);
			SELF := oprnd;
			SELF := [];
		END;

		SELF.inputs := ROW(toPRNOprnd(input.A));
		SELF := input;
		SELF := [];
	END;
	RETURN PROJECT(input, toRPN(LEFT));
END;

BOOLEAN Func_segTypeMatch(STRING segN, Types.SegmentType segT) := FUNCTION
	RETURN FALSE;
END;

EXPORT DATASET(Layout_Search_RPN_Set) ParseQueryFuncUnicode(UNICODE qStr,
																														Func_isSegName isSegName = Func_isSegName,
																														Func_segTypeMatch isThisSeg = Func_segTypeMatch,
																														CnvF myconv = CnvF,
																														Types.NominalSuffix dictVer = 0) := FUNCTION

	/* --- Helpers --- */
	WordType := Types.WordType;
	NominalFilter := Types.NominalFilter;
	DateRangeType := Types.DateRangeType;
	OpCode := Types.OpCode;
	Distance := Types.Distance;
	HitCount := Types.HitCount;
	SegmentType := Types.SegmentType;

	dTyp := WordType.Date;
	tTyp := WordType.TextStr;
	nTyp := WordType.Numeric;
	sTyp := WordType.SSN;
	fTyp := WordType.FieldData;
	unkTyp := WordType.Unknown;
	anyNominal := WordType.AnyNominal;
	drTyp := Types.DateRangeType;

	seg_Text_T := SegmentType.TextType;
	seg_Date_T := SegmentType.DateType;
	seg_Numeric_T := SegmentType.NumericType;
	seg_SSN_T := SegmentType.SSN;
	seg_Group_T := SegmentType.GroupSeg;
	seg_Field_T := SegmentType.FieldDataType;

	// find out segment type
	textSet(STRING sn) := isThisSeg(sn, seg_Text_T);
	dateSet(STRING sn) := isThisSeg(sn, seg_Date_T);
	numSet(STRING sn) := isThisSeg(sn, seg_Numeric_T);
	ssnSet(STRING sn) := isThisSeg(sn, seg_SSN_T);
	fldSet(STRING sn) := isThisSeg(sn, seg_Field_T);

	isDateSeg(STRING segN) := dateSet(segN) AND ~numSet(segN);
	isNumSeg(STRING segN) := numSet(segN) AND ~dateSet(segN);
	isSSNSeg(STRING segN) := ssnSet(segN) AND ~(textSet(segN) OR dateSet(segN) OR numSet(segN));
	isAmbgSeg(STRING segN) := dateSet(segN) AND numSet(segN);
	isFieldSeg(STRING segN) := fldSet(segN);

	OP_ID := ENUM(UNSIGNED1, ID_ATL, ID_OR, ID_BUTNOT, ID_W, ID_NOTW, ID_PRE,
													 ID_NOTPRE, ID_WSEG, ID_NOTWSEG, ID_AND, ID_ANDNOT,
													 ID_PHRS, ID_RNGGET, ID_GET, ID_GETFLD);

	mapOpId(OP_ID id) := CASE(id, OP_ID.ID_ATL => Map_Search_Operands.code_ATL,
																OP_ID.ID_OR => Map_Search_Operands.code_OR,
																OP_ID.ID_BUTNOT => Map_Search_Operands.code_BUTNOT,
																OP_ID.ID_W => Map_Search_Operands.code_W,
																OP_ID.ID_NOTW => Map_Search_Operands.code_NOTW,
																OP_ID.ID_PRE => Map_Search_Operands.code_PRE,
																OP_ID.ID_NOTPRE => Map_Search_Operands.code_NOTPRE,
																OP_ID.ID_WSEG => Map_Search_Operands.code_WSEG,
																OP_ID.ID_NOTWSEG => Map_Search_Operands.code_NOTWSEG,
																OP_ID.ID_AND => Map_Search_Operands.code_AND,
																OP_ID.ID_ANDNOT => Map_Search_Operands.code_ANDNOT,
																OP_ID.ID_PHRS => Map_Search_Operands.code_PHRASE,
																OP_ID.ID_RNGGET => Map_Search_Operands.code_RNGGET,
																OP_ID.ID_GETFLD => Map_Search_Operands.code_GETFLD,
																Map_Search_Operands.code_GET);

	toUpper(UNICODE uStr) := UnicodeLib.UnicodeToUpperCase(uStr);
	maybeYear(UNICODE str) := ((UNSIGNED4) str) BETWEEN 1800 AND 2100;


	/* --- Common types --- */
	UNICODE UBL := U'';
	STRING BL := '';
	STRING SL := '/';
	UNICODE USL := U'/';
	STRING HYPN := '-';
	STRING COMMA := ',';
	STRING PERIOD := '.';
	SET OF STRING SPACES := [' ', '\t', '\r', '\n'];

	PATTERN	SP := SPACES;
	PATTERN LP := PATTERN('\\(');
	PATTERN RP := PATTERN('\\)');
	PATTERN QUOT := PATTERN('"');

	// comparison
	STRING KWD_AFT := 'AFT';
	STRING KWD_BEF := 'BEF';
	STRING KWD_IS := 'IS';
	STRING KWD_GT := 'GT';
	STRING KWD_LT := 'LT';
	STRING KWD_EQ := 'EQ';
	STRING KWD_GE := 'GE';
	STRING KWD_LE := 'LE';
	STRING KWD_GEQ := 'GEQ';
	STRING KWD_LEQ := 'LEQ';
	STRING KWD_RNG := 'RNG';
	STRING KWD_BTW := 'BETWEEN';
	STRING KWD_BTWA := 'BTW';
	STRING KWD_N_GT := '>';
	STRING KWD_N_LT := '<';
	STRING KWD_N_EQ := '=';
	STRING KWD_N_GE := '>=';
	STRING KWD_N_LE := '<=';
	STRING KWD_LIKE := 'LIKE';

	SET OF STRING KWDS_GT := [KWD_AFT, KWD_GT, KWD_N_GT];
	SET OF STRING KWDS_LT := [KWD_BEF, KWD_LT, KWD_N_LT];
	SET OF STRING KWDS_EQ := [KWD_IS, KWD_EQ, KWD_N_EQ];
	SET OF STRING KWDS_GE := [KWD_GEQ, KWD_GE, KWD_N_GE];
	SET OF STRING KWDS_LE := [KWD_LEQ, KWD_LE, KWD_N_LE];
	SET OF STRING KWDS_RNG := [KWD_RNG];
	SET OF STRING KWDS_BTW := [KWD_BTW, KWD_BTWA];
	SET OF STRING KWDS_LIKE := [KWD_LIKE];

	PATTERN NUM_CMPR := [KWD_GT, KWD_LT, KWD_EQ, KWD_GE, KWD_GEQ, KWD_LE, KWD_LEQ];
	PATTERN ANY_CMPR := [KWD_N_GT, KWD_N_LT, KWD_N_EQ, KWD_N_GE, KWD_N_LE];
	PATTERN RNG := KWDS_RNG;
	PATTERN BTW := KWDS_BTW;
	PATTERN LIKE := KWDS_LIKE;

	PATTERN number := PATTERN('[[:digit:]]+');
	PATTERN ws := PATTERN('[[:space:]]+');
	PATTERN specialChar	:= PATTERN('[\240-\777]');
	PATTERN alnumChar := PATTERN('[[:alnum:]]') | specialChar;
	PATTERN letter := PATTERN('[[:alpha:]]') | specialChar;
	PATTERN wordN := number? letter alnumChar*;
	PATTERN univChar := PATTERN('\\*|\\?');
	PATTERN anyChar := univChar | alnumChar;
	PATTERN wordWU := univChar anyChar+ | alnumChar+ univChar anyChar*;
	PATTERN word := wordWU | wordN;
	PATTERN btw_and := ws 'AND' ws;
	PATTERN sign := PATTERN('[-+]');
	PATTERN intg := sign? number;
	PATTERN dotNum := PERIOD number;
	PATTERN hyphenNum := HYPN number;
	PATTERN dotNumbers := intg REPEAT(dotNum, 2, ANY);
	PATTERN decimalString := intg dotNum*1;
	PATTERN hyphenNumbers := intg hyphenNum+;
	PATTERN wordDotNumbers := wordN dotNum+;
	PATTERN wordHyphenNumbers := wordN hyphenNum+;
	PATTERN specialString	:= dotNumbers OR hyphenNumbers OR wordDotNumbers OR wordHyphenNumbers;
	PATTERN currency := PATTERN('-?[[:digit:]]{1,3}(,[[:digit:]]{3})+(.[[:digit:]]+)?(?![[:alnum:]])');
	PATTERN intg_dec := decimalString | intg;
	PATTERN simple := specialString | currency | word | intg_dec;
	PATTERN anyNoQuote := PATTERN('[\001-\041\043-\377]');
	PATTERN anyNoApos := PATTERN('[\001-\046\050-\377]');
	PATTERN QuoteChar := '\042';
	PATTERN AposChar := '\047';


	/* --- Segment --- */
	PATTERN segChar := PATTERN('[[:alnum:]]|_|-');
	PATTERN seg := segChar+;
	PATTERN sn := VALIDATE(seg, isSegName((STRING) MATCHUNICODE));
	PATTERN maybeSN := sn ws? LP;


	/* --- Date --- */
	PATTERN DT_CMPR := [KWD_AFT, KWD_BEF, KWD_IS];
	STRING CLN := ':';
	UNICODE UCLN := U':';
	PATTERN dsn := VALIDATE(seg, isDateSeg((STRING) MATCHUNICODE));
	PATTERN maybeDSN := dsn ws? LP;
	PATTERN fourDigits := PATTERN('[[:digit:]]{4}');
	// The same year range check is used in "Make_Inversion_List_Func.
	PATTERN year := VALIDATE(fourDigits, maybeYear(MATCHUNICODE));
	PATTERN oneOrTwoDigits := PATTERN('[[:digit:]]{1,2}');
	PATTERN month := VALIDATE(oneOrTwoDigits, ((UNSIGNED2) MATCHUNICODE) BETWEEN 0 AND 12);
	PATTERN day := VALIDATE(oneOrTwoDigits, ((UNSIGNED2) MATCHUNICODE) BETWEEN 0 AND 31);
	PATTERN month_l := VALIDATE(letter+, Date_Name.isMonth((STRING) MATCHUNICODE));
	PATTERN d_sep := SL | HYPN;
	PATTERN d_stop := PATTERN('(?![[:alnum:]]|-|/)');
	PATTERN l_sep := (COMMA | PERIOD | SP)+;
	PATTERN y_m := year d_sep month;
	PATTERN m_y := month d_sep year;
	PATTERN m_y_l := month_l l_sep year;
	PATTERN y_m_d := y_m d_sep day;
	PATTERN m_d_y := month d_sep day d_sep year;
	PATTERN m_d_y_l := month_l l_sep day l_sep year;
	PATTERN dtExpr := (y_m_d | m_d_y | m_d_y_l | y_m | m_y | m_y_l) d_stop;
	PATTERN dtExprYr := year d_stop;
	PATTERN dtPtAnySN := dsn | sn;
	PATTERN dtPtAnySN_WS := dtPtAnySN ws;
	PATTERN dtPtCmplt := dtPtAnySN_WS? DT_CMPR ws (dtExpr | dtExprYr);
	PATTERN dtPtPrtl := (dtPtAnySN_WS? NUM_CMPR ws | (dtPtAnySN ws?)? ANY_CMPR ws?) dtExpr;
	PATTERN dtPtPrtlYr := (NUM_CMPR ws | ANY_CMPR ws?) dtExprYr;
	PATTERN dtPtCmpltYr := dsn (ws NUM_CMPR ws | ws? ANY_CMPR ws?) dtExprYr;

	// range
	PATTERN y_m_d_rng := y_m_d CLN y_m_d;
	PATTERN m_d_y_rng := m_d_y CLN m_d_y;
	PATTERN y_m_d_btw := y_m_d btw_and y_m_d;
	PATTERN m_d_y_btw := m_d_y btw_and m_d_y;
	PATTERN y_m_rng := y_m CLN y_m;
	PATTERN m_y_rng := m_y CLN m_y;
	PATTERN y_m_btw := y_m btw_and y_m;
	PATTERN m_y_btw := m_y btw_and m_y;
	PATTERN y_rng := year CLN year;
	PATTERN y_btw := year btw_and year;
	PATTERN dtPtRngFull := y_m_d_rng | m_d_y_rng;
	PATTERN dtPtBtwFull := y_m_d_btw | m_d_y_btw;
	PATTERN dtPtBtwFull_L := m_d_y_l btw_and m_d_y_l;
	PATTERN dtPtRngPartial := y_m_rng | m_y_rng;
	PATTERN dtPtBtwPartial := y_m_btw | m_y_btw;
	PATTERN dtPtBtwPartial_L := m_y_l btw_and m_y_l;
	PATTERN dtRngExpr := dtPtRngFull | dtPtRngPartial;
	PATTERN dtBtwExpr := dtPtBtwFull | dtPtBtwFull_L | dtPtBtwPartial | dtPtBtwPartial_L;
	PATTERN dtPtRngCmplt := dtPtAnySN_WS? RNG ws dtRngExpr d_stop;
	PATTERN dtPtBtwCmplt := dtPtAnySN_WS? BTW ws dtBtwExpr d_stop;
	PATTERN dtPtRngYr := RNG ws y_rng d_stop;
	PATTERN dtPtBtwYr := BTW ws y_btw d_stop;
	PATTERN dtPtRngCmpltYr := dsn ws dtPtRngYr;
	PATTERN dtPtBtwCmpltYr := dsn ws dtPtBtwYr;

	// obvious and ambiguous
	PATTERN date := dtPtCmplt | dtPtPrtl | dtPtCmpltYr | dtPtRngCmplt |
									dtPtBtwCmplt | dtPtRngCmpltYr | dtPtBtwCmpltYr | dtExpr;
	PATTERN vagueDate := dtPtPrtlYr | dtPtRngYr | dtPtBtwYr;


	/* --- Numeric expressions --- */
	PATTERN nsn := VALIDATE(seg, isNumSeg((STRING) MATCHUNICODE));
	PATTERN numAnySN := nsn | sn;
	PATTERN numAnySN_WS := numAnySN ws;
	PATTERN numPtCmplt := numAnySN_WS? NUM_CMPR ws (currency |intg_dec);
	PATTERN numPtImmd := (numAnySN ws?)? ANY_CMPR ws? (currency |intg_dec);
	PATTERN numPtRngV := (currency |intg_dec) CLN (currency |intg_dec);
	PATTERN numPtBtwV := (currency |intg_dec) btw_and (currency |intg_dec);
	PATTERN numPtRng := numAnySN_WS? RNG ws numPtRngV;
	PATTERN numPtBtw := numAnySN_WS? BTW ws numPtBtwV;
	PATTERN numeric := numPtCmplt | numPtImmd | numPtRng | numPtBtw;

	/* --- Like expressions --- */
	PATTERN fsn := VALIDATE(seg, isFieldSeg((STRING) MATCHUNICODE));
	PATTERN noQuoteStr := anyNoQuote+;
  PATTERN noAposStr := anyNoApos+;
  PATTERN Like_Arg := QuoteChar NoQuoteStr QuoteChar | AposChar NoAposStr AposChar;
  PATTERN like_clause := LIKE ws+ Like_Arg;
  PATTERN like_expr := fsn ws+ like_clause;


	/* --- SSN --- */
	PATTERN ssnsn := VALIDATE(seg, isSSNSeg((STRING) MATCHUNICODE));
	PATTERN maybeSSNSN := ssnsn ws? LP;
	PATTERN nineDigits := PATTERN('[[:digit:]]{9}');
	PATTERN hyphenedSSN := PATTERN('[[:digit:]]{3}-[[:digit:]]{2}-[[:digit:]]{4}');
	PATTERN s_stop := PATTERN('(?![[:alnum:]])');
	PATTERN ssn := (nineDigits | hyphenedSSN) s_stop;


	/* --- Keywords with punctuation characters --- */
	PATTERN kwdPunct := Equivalence.KwdWithPunctsMerged;
	PATTERN punctEqvs := VALIDATE(kwdPunct, Equivalence.kwdPunctMatch((STRING) MATCHUNICODE, dictVer));
	
	/* --- Equivalent patterns --- */
	PATTERN begsep := FIRST OR ' ' OR LP;
	PATTERN endsep := LAST OR ' ' OR RP;
	PATTERN endsepPeriod := endsep OR Period BEFORE endsep;
	// Equiv patterns must not be wrapped in double qoutes "" and must be preceded by a space/left paren or the first pos and followed by a space/right paren or in the last pos.
	PATTERN MultiEquiv	:= NOCASE(Text_Search.Equivalence.MultiWrdEquivalents) NOT BEFORE quot BEFORE endsepPeriod NOT AFTER quot AFTER begsep;
	PATTERN SingleEquiv	:= NOCASE(Text_Search.Equivalence.SingleWrdEquivalents) NOT BEFORE quot BEFORE endsepPeriod NOT AFTER quot AFTER begsep;

	/* --- Operators --- */
	PATTERN OP_ANDNOT := 'AND' ws? 'NOT';
	PATTERN OP_AND := 'AND';
	PATTERN NOT_PREFIX := 'NOT' ws?;
	PATTERN SL_SEG := ws? SL ws? 'SEG';
	PATTERN SL_NUM := ws? SL ws? number;
	PATTERN	OP_NOTWSEG := NOT_PREFIX 'W' SL_SEG;
	PATTERN	OP_WSEG := 'W' SL_SEG;
	PATTERN	OP_NOTPRE := NOT_PREFIX 'PRE' SL_NUM;
	PATTERN	OP_PRE := 'PRE' SL_NUM;
	PATTERN	OP_PREDOC := 'PREDOC' SL_NUM;
	PATTERN	OP_NOTPREDOC := NOT_PREFIX 'PREDOC' SL_NUM;
	PATTERN	OP_NOTW := NOT_PREFIX 'W' SL_NUM;
	PATTERN	OP_W := 'W' SL_NUM;
	PATTERN	OP_BUTNOT := 'BUT' ws 'NOT';
	PATTERN OP_ATL := 'ATL' SL_NUM ws? LP;
	PATTERN OP_OR := 'OR';
	PATTERN B_OPRTR := OP_ANDNOT | OP_AND | OP_NOTWSEG | OP_WSEG | OP_NOTPRE | OP_PRE |
										 OP_PREDOC | OP_NOTPREDOC | OP_NOTW | OP_W | OP_BUTNOT | OP_OR;
	PATTERN U_OPRTR := OP_ATL;
	PATTERN OPPTN := B_OPRTR ws | U_OPRTR;


	/* --- Escape/Group patterns --- */
	PATTERN special := QUOT | LP | RP;


	/* --- Temporary --- */
	Layout_OprndRec2 := RECORD
		UNICODE					word{MAXLENGTH(255)};
		WordType				typ;
		STRING					segName{MAXLENGTH(255)};
		NominalFilter		filterType;
		DateRangeType		rangeType;
		BOOLEAN					sprsEqv := FALSE;
		BOOLEAN					drctExp := FALSE;
	END;

	OprndRec := RECORD
		Layout_OprndRec2;
		BOOLEAN	isR;
	END;


	/* --- Parse function for unicode --- */
	parseFunc(Layout_String dx) := FUNCTION

		// Utility functions
		UNICODE RE_WS := U'[ \\t\\r\\n]+';
		UNICODE REPL := U' ';

		cleanupWS(UNICODE input) := TRIM(REGEXREPLACE(RE_WS, input, REPL), LEFT, RIGHT);
		convertPuncts(UNICODE input) := UnicodeLib.UnicodeCleanSpaces(REGEXREPLACE(U'[:punct:]+', input, REPL));

		UNSIGNED1 countWords(UNICODE input) := FUNCTION
			/* To make this function to produce an expected result use "cleanupWS" above
			for the input before calling. */
			tmpStr := UnicodeLib.UnicodeFilterOut(input, REPL);
			RETURN LENGTH(input) - LENGTH(tmpStr) + 1;
		END;

		UNICODE extractWord(UNICODE input, UNSIGNED n_th) := FUNCTION
			/* To make this function to produce an expected result use "cleanupWS" above
			for the input before calling. */
			UNSIGNED st := UnicodeLib.UnicodeFind(input, REPL, n_th - 1);
			UNSIGNED en := UnicodeLib.UnicodeFind(input, REPL, n_th);

			RETURN IF(st > 0, IF(en > 0, input[st+1..en-1], input[st+1..]),
												IF(en > 0, input[1..en-1], input));
		END;

		// regular expressions for date
		UNICODE ptn_dv := U'[,. \\t\\r\\n]+';
		UNICODE ptn_dsep := U'[-/]';
		UNICODE ptn_month := U'[:digit:]{1,2}';
		UNICODE ptn_month_l := U'[:alpha:]+';
		UNICODE ptn_day := ptn_month;
		UNICODE ptn_year := U'[:digit:]{4}';
		UNICODE ptn_st := U'^';
		UNICODE ptn_en := U'$';
		UNICODE ptn_op := U'(';
		UNICODE ptn_cp := U')';
		UNICODE ptn_rngSep := UCLN;
		UNICODE ptn_btwAnd := U'[:space:]+AND[:space:]+';
		UNICODE fmt_YMD := ptn_year + ptn_dsep + ptn_month + ptn_dsep + ptn_day;
		UNICODE fmt_MDY := ptn_month + ptn_dsep + ptn_day + ptn_dsep + ptn_year;
		UNICODE fmt_MDY_L := ptn_month_l + ptn_dv + ptn_day + ptn_dv + ptn_year;
		UNICODE fmt_YM := ptn_year + ptn_dsep + ptn_month;
		UNICODE fmt_MY := ptn_month + ptn_dsep + ptn_year;
		UNICODE fmt_MY_L := ptn_month_l + ptn_dv + ptn_year;
		UNICODE ptn_YMD := ptn_st + fmt_YMD + ptn_en;
		UNICODE ptn_MDY := ptn_st + fmt_MDY + ptn_en;
		UNICODE ptn_MDY_L := ptn_st + ptn_op + ptn_month_l + ptn_cp + ptn_dv + ptn_op + ptn_day + ptn_cp + ptn_dv + ptn_op + ptn_year + ptn_cp + ptn_en;
		UNICODE ptn_YM := ptn_st + ptn_op + ptn_year + ptn_cp + ptn_dsep + ptn_op + ptn_month + ptn_cp + ptn_en;
		UNICODE ptn_MY := ptn_st + ptn_op + ptn_month + ptn_cp + ptn_dsep + ptn_op + ptn_year + ptn_cp + ptn_en;
		UNICODE ptn_MY_L := ptn_st + ptn_op + ptn_month_l + ptn_cp + ptn_dv + ptn_op + ptn_year + ptn_cp + ptn_en;
		UNICODE ptn_Y := ptn_st + ptn_year + ptn_en;
		UNICODE ptn_rngYMD := ptn_st + fmt_YMD + ptn_rngSep + fmt_YMD + ptn_en;
		UNICODE ptn_btwYMD := ptn_st + ptn_op + fmt_YMD + ptn_cp + ptn_btwAnd + ptn_op + fmt_YMD + ptn_cp + ptn_en;
		UNICODE ptn_rngMDY := ptn_st + fmt_MDY + ptn_rngSep + ptn_op + fmt_MDY + ptn_en;
		UNICODE ptn_btwMDY := ptn_st + ptn_op + fmt_MDY + ptn_cp + ptn_btwAnd + ptn_op + fmt_MDY + ptn_cp + ptn_en;
		UNICODE ptn_btwMDY_L := ptn_st + ptn_op + fmt_MDY_L + ptn_cp + ptn_btwAnd + ptn_op + fmt_MDY_L + ptn_cp + ptn_en;
		UNICODE ptn_rngYM := ptn_st + ptn_op + fmt_YM + ptn_cp + ptn_rngSep + ptn_op + fmt_YM + ptn_cp + ptn_en;
		UNICODE ptn_btwYM := ptn_st + ptn_op + fmt_YM + ptn_cp + ptn_btwAnd + ptn_op + fmt_YM + ptn_cp + ptn_en;
		UNICODE ptn_rngMY := ptn_st + ptn_op + fmt_MY + ptn_cp + ptn_rngSep + ptn_op + fmt_MY + ptn_cp + ptn_en;
		UNICODE ptn_btwMY := ptn_st + ptn_op + fmt_MY + ptn_cp + ptn_btwAnd + ptn_op + fmt_MY + ptn_cp + ptn_en;
		UNICODE ptn_btwMY_L := ptn_st + ptn_op + fmt_MY_L + ptn_cp + ptn_btwAnd + ptn_op + fmt_MY_L + ptn_cp + ptn_en;
		UNICODE ptn_rngY := ptn_st + ptn_op + ptn_year + ptn_cp + ptn_rngSep + ptn_op + ptn_year + ptn_cp + ptn_en;
		UNICODE ptn_btwY := ptn_st + ptn_op + ptn_year + ptn_cp + ptn_btwAnd + ptn_op + ptn_year + ptn_cp + ptn_en;
		UNICODE ptn_any := U'.+';

		UNICODE U_NYDAY := U'0/0';
		STRING NYDAY := (STRING) U_NYDAY;
		UNICODE U_NYEVE := U'12/31';
		STRING NYEVE := (STRING) U_NYEVE;
		UNICODE U_MINDAY := U'0';
		STRING MINDAY := (STRING) U_MINDAY;

		UNICODE dateValue(UNICODE input, BOOLEAN isMDY) := FUNCTION
			RETURN (UNICODE) ConvertDate((STRING) input, ~isMDY);
		END;

		UNICODE dateLValue(UNICODE input) := FUNCTION
			STRING m := Date_Name.m((STRING) REGEXFIND(ptn_MDY_L, input, 1));
			STRING d := (STRING) REGEXFIND(ptn_MDY_L, input, 2);
			STRING y := (STRING) REGEXFIND(ptn_MDY_L, input, 3);

			RETURN (UNICODE) ConvertDate(m + SL + d + SL + y);
		END;

		UNICODE year_monthValue(UNICODE y, UNICODE m, NominalFilter fltr) := FUNCTION
			UNSIGNED2 year := (UNSIGNED2) y;
			UNSIGNED1 month := (UNSIGNED1) m;
			STRING d := CASE(fltr, NominalFilter.GT_Filter => (STRING) getLastDayOfMonth(month, year),
														 NominalFilter.LE_Filter => (STRING) getLastDayOfMonth(month, year),
														 MINDAY);

			RETURN (UNICODE) ConvertDate((STRING) m + SL + d + SL + (STRING) y);
		END;

		UNICODE yearValue(UNICODE y, NominalFilter fltr) := FUNCTION
			STRING md := CASE(fltr, NominalFilter.GT_Filter => NYEVE,
															NominalFilter.LE_Filter => NYEVE,
														 NYDAY);
			RETURN (UNICODE) ConvertDate(md + SL + (STRING) y);
		END;

		UNICODE toNumExpr(UNICODE l_month) := (UNICODE) TRIM(Date_Name.m((STRING) l_month));

		DateRangeType defaultPartialDateRng := drTyp.YMDRange;

		UNICODE year_monthRng(UNICODE y, UNICODE m) := FUNCTION
			UNSIGNED2 year := (UNSIGNED2) y;
			UNSIGNED1 month := (UNSIGNED1) m;
			UNICODE lastDay := (UNICODE) getLastDayOfMonth(month, year);
			UNICODE ymdRng := y + USL + m + USL + U_MINDAY + UCLN + y + USL + m + USL + lastDay;
			UNICODE mdyRng := m + USL + U_MINDAY + USL + y + UCLN + m + USL + lastDay + USL + y;

			RETURN IF(defaultPartialDateRng = drTyp.YMDRange, ymdRng, mdyRng);
		END;

		UNICODE yearRng(UNICODE y) := FUNCTION
			UNICODE ymdRng := y + USL + U_NYDAY + UCLN + y + USL + U_NYEVE;
			UNICODE mdyRng := U_NYDAY + USL + y + UCLN + U_NYEVE + USL + y;

			RETURN IF(defaultPartialDateRng = drTyp.YMDRange, ymdRng, mdyRng);
		END;

		UNICODE ymToymdRng(UNICODE y, UNICODE m, BOOLEAN isYMD, BOOLEAN lastDay = FALSE) := FUNCTION
			UNSIGNED2 year := (UNSIGNED2) y;
			UNSIGNED1 month := (UNSIGNED1) m;
			UNICODE d := IF(lastDay, (UNICODE) getLastDayOfMonth(month, year), U_MINDAY);
			UNICODE ymd := y + USL + m + USL + d;
			UNICODE mdy := m + USL + d + USL + y;

			RETURN IF(isYMD, ymd, mdy);
		END;

		UNICODE partialToFullDateRange(UNICODE input) := FUNCTION
			BOOLEAN isYMD := REGEXFIND(ptn_rngYM, input);
			UNICODE re1 := IF(isYMD, ptn_rngYM, ptn_rngMY);
			UNICODE re2 := IF(isYMD, ptn_YM, ptn_MY);
			UNICODE l_ym := REGEXFIND(re1, input, 1);
			UNICODE r_ym := REGEXFIND(re1, input, 2);
			UNICODE l1 := REGEXFIND(re2, l_ym, 1);
			UNICODE l2 := REGEXFIND(re2, l_ym, 2);
			UNICODE r1 := REGEXFIND(re2, r_ym, 1);
			UNICODE r2 := REGEXFIND(re2, r_ym, 2);
			UNICODE l_y := IF(isYMD, l1, l2);
			UNICODE l_m := IF(isYMD, l2, l1);
			UNICODE r_y := IF(isYMD, r1, r2);
			UNICODE r_m := IF(isYMD, r2, r1);
			BOOLEAN shouldBeYMD := defaultPartialDateRng = drTyp.YMDRange;

			RETURN ymToymdRng(l_y, l_m, shouldBeYMD) + UCLN + ymToymdRng(r_y, r_m, shouldBeYMD, TRUE);
		END;

		UNICODE yearToFullDateRange(UNICODE input) := FUNCTION
			UNICODE l_y := REGEXFIND(ptn_rngY, input, 1);
			UNICODE r_y := REGEXFIND(ptn_rngY, input, 2);
			UNICODE ymd := l_y + USL + U_NYDAY + UCLN + r_y + USL + U_NYEVE;
			UNICODE mdy := U_NYDAY + USL + l_y + UCLN + U_NYEVE + USL + r_y;

			RETURN IF(defaultPartialDateRng = drTyp.YMDRange, ymd, mdy);
		END;

		UNICODE btwToRng(UNICODE input) := FUNCTION
			UNICODE RE := ptn_st + ptn_op + ptn_any + ptn_cp + ptn_btwAnd + ptn_op + ptn_any + ptn_cp + ptn_en : GLOBAL;

			UNICODE l := REGEXFIND(RE, input, 1, NOCASE);
			UNICODE r := REGEXFIND(RE, input, 2, NOCASE);
			RETURN l + UCLN + r;
		END;

		UNICODE btwLToRng(UNICODE input) := FUNCTION
			UNICODE l := REGEXFIND(ptn_btwMDY_L, input, 1, NOCASE);
			UNICODE r := REGEXFIND(ptn_btwMDY_L, input, 2, NOCASE);
			UNICODE l_m := toNumExpr(REGEXFIND(ptn_MDY_L, l, 1, NOCASE));
			UNICODE l_d := REGEXFIND(ptn_MDY_L, l, 2, NOCASE);
			UNICODE l_y := REGEXFIND(ptn_MDY_L, l, 3, NOCASE);
			UNICODE r_m := toNumExpr(REGEXFIND(ptn_MDY_L, r, 1, NOCASE));
			UNICODE r_d := REGEXFIND(ptn_MDY_L, r, 2, NOCASE);
			UNICODE r_y := REGEXFIND(ptn_MDY_L, r, 3, NOCASE);
			UNICODE ymd := l_y + USL + l_m + USL + l_d + UCLN + r_y + USL + r_m + USL + r_d;
			UNICODE mdy := l_m + USL + l_d + USL + l_y + UCLN + r_m + USL + r_d + USL + r_y;

			RETURN IF(defaultPartialDateRng = drTyp.YMDRange, ymd, mdy);
		END;

		UNICODE btwPartialLToRng(UNICODE input) := FUNCTION
			UNICODE l := REGEXFIND(ptn_btwMY_L, input, 1, NOCASE);
			UNICODE r := REGEXFIND(ptn_btwMY_L, input, 2, NOCASE);
			UNICODE l_m := toNumExpr(REGEXFIND(ptn_MY_L, l, 1, NOCASE));
			UNICODE l_y := REGEXFIND(ptn_MY_L, l, 2, NOCASE);
			UNICODE r_m := toNumExpr(REGEXFIND(ptn_MY_L, r, 1, NOCASE));
			UNICODE r_y := REGEXFIND(ptn_MY_L, r, 2, NOCASE);
			BOOLEAN shouldBeYMD := defaultPartialDateRng = drTyp.YMDRange;

			RETURN ymToymdRng(l_y, l_m, shouldBeYMD) + UCLN + ymToymdRng(r_y, r_m, shouldBeYMD, TRUE);
		END;

		UNICODE btwPartialToFullDateRange(UNICODE input) := FUNCTION
			RETURN partialToFullDateRange(btwToRng(input));
		END;

		UNICODE btwYearToFullDateRange(UNICODE input) := FUNCTION
			RETURN yearToFullDateRange(btwToRng(input));
		END;


		// validation for numeric range
		UNICODE ptn_num := U'[+-]?[:digit:]+\\.?[:digit:]*';
		UNICODE ptn_rngNum := ptn_st + ptn_num + ptn_rngSep + ptn_num + ptn_en;
		UNICODE ptn_btwNum := ptn_st + ptn_num + ptn_btwAnd + ptn_num + ptn_en;

		BOOLEAN numRngOk(UNICODE input) := REGEXFIND(ptn_rngNum, input);


		ExpResult := RECORD(Layout_OprndRec2)
			UNSIGNED1 numWords;
			BOOLEAN		unresolved;
			UNSIGNED1	grpId;
			UNSIGNED1	subGrpId;
		END;


		ExpResult expandExpr(UNICODE expr, SegmentType t, UNSIGNED1 g, UNSIGNED1 sg) := FUNCTION
			UNICODE RE := U'([<=>]+\\s?|\\S+ )(.+)';
			STRING cmprtrStr := (STRING) toUpper(REGEXFIND(RE, expr, 1));
			BOOLEAN noOp := cmprtrStr = BL;
			BOOLEAN isGT := cmprtrStr IN KWDS_GT;
			BOOLEAN isLT := cmprtrStr IN KWDS_LT;
			BOOLEAN isEQ := cmprtrStr IN KWDS_EQ OR noOp;
			BOOLEAN isGE := cmprtrStr IN KWDS_GE;
			BOOLEAN isLE := cmprtrStr IN KWDS_LE;
			UNICODE valStr := IF(noOp, expr, REGEXFIND(RE, expr, 2));
			BOOLEAN isDtSeg := t = seg_Date_T;
			BOOLEAN isSSNSeg := t = seg_SSN_T;
			BOOLEAN isNSeg := t = seg_Numeric_T;
			BOOLEAN isASeg := t = seg_Group_T;
      BOOLEAN isFldSeg := t = seg_Field_T;
			UNSIGNED1 numElems := IF(isASeg, 3, 1);
			UNSIGNED1 gNew := IF(isASeg, g + 1, g);
			UNSIGNED1 sgNew := IF(isASeg, sg + 1, sg);
			UNSIGNED dtFmt := WHICH(REGEXFIND(ptn_Y, valStr),
															REGEXFIND(ptn_rngY, valStr),
															REGEXFIND(ptn_btwY, valStr, NOCASE));
			UNSIGNED numFmt := WHICH(REGEXFIND(ptn_rngNum, valStr),
															 REGEXFIND(ptn_btwNum, valStr, NOCASE));
			WordType typ := MAP(isDtSeg => dTyp,
													isSSNSeg => nTyp,
													isNSeg => nTyp,
                          isFldSeg => fTyp,
													tTyp);
			NominalFilter fType := MAP(isGT => NominalFilter.GT_Filter,
																 isLT => NominalFilter.LT_Filter,
																 isEQ => IF(isNSeg, NominalFilter.EQ_Filter, NominalFilter.RNG_Filter),
																 isGE => NominalFilter.GE_Filter,
																 isLE => NominalFilter.LE_Filter,
																 NominalFilter.RNG_Filter);
			UNICODE dateExpr := CASE(dtFmt, 1 => IF(isEQ, yearRng(valStr), yearValue(valStr, fType)),
																			2 => yearToFullDateRange(valStr),
																			3 => btwYearToFullDateRange(valStr),
																			valStr);
			UNICODE numExpr := CASE(numFmt, 2 => btwToRng(valStr),
																			valStr);
			UNICODE word := MAP(isDtSeg => dateExpr,
													isNSeg => numExpr,
													isASeg => dateExpr + U' OR ' + numExpr,
													valStr);
			DateRangeType rType := IF(fType = NominalFilter.RNG_Filter, defaultPartialDateRng, drTyp.NoRange);

			RETURN ROW({(STRING) word, typ, BL, fType, rType, FALSE, FALSE, numElems, isASeg, gNew, sgNew}, ExpResult);
		END;


		// Date/numeric comparison
		BOOLEAN isEQ(UNICODE cmpOpr) := (STRING) toUpper(cmpOpr) IN KWDS_EQ;
		BOOLEAN isGT(UNICODE cmpOpr) := (STRING) toUpper(cmpOpr) IN KWDS_GT;
		BOOLEAN isLT(UNICODE cmpOpr) := (STRING) toUpper(cmpOpr) IN KWDS_LT;
		BOOLEAN isGE(UNICODE cmpOpr) := (STRING) toUpper(cmpOpr) IN KWDS_GE;
		BOOLEAN isLE(UNICODE cmpOpr) := (STRING) toUpper(cmpOpr) IN KWDS_LE;
		BOOLEAN matchEQ(UNICODE cmpOpr1, UNICODE cmpOpr2, UNICODE cmpOpr3) := isEQ(cmpOpr1) OR isEQ(cmpOpr2) OR isEQ(cmpOpr3);
		BOOLEAN matchGT(UNICODE cmpOpr1, UNICODE cmpOpr2, UNICODE cmpOpr3) := isGT(cmpOpr1) OR isGT(cmpOpr2) OR isGT(cmpOpr3);
		BOOLEAN matchLT(UNICODE cmpOpr1, UNICODE cmpOpr2, UNICODE cmpOpr3) := isLT(cmpOpr1) OR isLT(cmpOpr2) OR isLT(cmpOpr3);
		BOOLEAN matchGE(UNICODE cmpOpr1, UNICODE cmpOpr2, UNICODE cmpOpr3) := isGE(cmpOpr1) OR isGE(cmpOpr2) OR isGE(cmpOpr3);
		BOOLEAN matchLE(UNICODE cmpOpr1, UNICODE cmpOpr2, UNICODE cmpOpr3) := isLE(cmpOpr1) OR isLE(cmpOpr2) OR isLE(cmpOpr3);


		Flags := ENUM(UNSIGNED1, NONE = 0, ESC = 1, SGR = 2, ERR = 128);

		MyToken := RECORD
			UNSIGNED2		seq;
			BOOLEAN			isSpecial;
			BOOLEAN			unresolved;
			UNSIGNED1		numWords;
			UNICODE			tmpVal{MAXLENGTH(255)};
			Flags 			escF;
			BOOLEAN			cmprWithSN;
			UNSIGNED1		opId;
			UNSIGNED2		dist;
			HitCount		atl;
			INTEGER1		level;
			INTEGER1		segLvl;
			INTEGER1		atlLvl;
			UNSIGNED1		grpId;
			UNSIGNED1		subGrpId;
			BOOLEAN			segmented;
			SegmentType	segT;
			OprndRec;
		END;

		UNICODE PARSEERR_BADNUMRNG := U'Invalid numeric range';

		MyToken toTok(Layout_String rds) := TRANSFORM
			BOOLEAN maybeDtSegRstrct := MATCHED(maybeDSN);
			BOOLEAN maybeSSNSegRstrct := MATCHED(maybeSSNSN);
			BOOLEAN maybeOthrSegRstrct := MATCHED(maybeSN);
			BOOLEAN maybeSegRstrct := maybeDtSegRstrct OR maybeSSNSegRstrct OR maybeOthrSegRstrct;
			BOOLEAN maybeYr := MATCHED(simple/number) AND maybeYear(MATCHUNICODE);
			BOOLEAN isATL := MATCHED(OP_ATL);
			BOOLEAN isPREDOC := MATCHED(OP_PREDOC) or MATCHED(OP_NOTPREDOC);
			BOOLEAN isLike := MATCHED(like_expr);
			WordType theType := MAP(MATCHED(date) => dTyp,
															MATCHED(ssn) => sTyp,
															MATCHED(numeric) => nTyp,
															maybeSegRstrct => anyNominal,
															MATCHED(simple/specialString) => tTyp,
															MATCHED(simple/currency) => nTyp,
															MATCHED(simple/word) => tTyp,
															maybeYr => unkTyp,
															MATCHED(simple/intg_dec) => nTyp,
															MATCHED(punctEqvs) => tTyp,
															MATCHED(MultiEquiv) => WordType.MultiEquiv,
															MATCHED(SingleEquiv) => tTyp,
															MATCHED(like_expr) => fTyp,
															unkTyp);
			BOOLEAN isCmprble := theType = dTyp OR theType = nTyp OR theType = fTyp;
			BOOLEAN isEquiv := MATCHED(MultiEquiv) OR MATCHED(SingleEquiv);
			BOOLEAN matchLP := ~maybeSegRstrct AND ~isATL AND MATCHED(LP);
			BOOLEAN matchRP := MATCHED(RP);
			BOOLEAN matchDtSnCmpr := MATCHED(date/dsn);
			BOOLEAN matchNumSnCmpr := MATCHED(numeric/nsn);
			BOOLEAN isNumRng := MATCHED(numeric/RNG);
			BOOLEAN isNumBtw := MATCHED(numeric/BTW);
			BOOLEAN numRngPat := isNumRng OR isNumBtw;
			UNICODE numRngV := MAP(isNumRng => UnicodeLib.UnicodeFilterOut(MATCHUNICODE(numPtRngV), U','),
														 isNumBtw => btwToRng(UnicodeLib.UnicodeFilterOut(MATCHUNICODE(numPtBtwV), U',')),
														 UBL);
			BOOLEAN isNumRngErr := numRngPat AND ~numRngOk(numRngV);
			SELF.isSpecial := MATCHED(special);
			SELF.unresolved := MATCHED(vagueDate) OR MATCHED(simple/specialString) OR maybeYr;
			SELF.escF := MAP(MATCHED(QUOT) => Flags.ESC,
											 isNumRngErr => Flags.ERR,
											 Flags.NONE);
			SELF.cmprWithSN := matchDtSnCmpr OR matchNumSnCmpr OR MATCHED(date/sn) OR MATCHED(numeric/sn)
                      OR MATCHED(like_expr);
			SELF.segName := (STRING) toUpper(MAP(matchDtSnCmpr => MATCHUNICODE(dsn),
																					 matchNumSnCmpr => MATCHUNICODE(nsn),
																					 MATCHED(sn) => MATCHUNICODE(sn),
																					 maybeDtSegRstrct => MATCHUNICODE(dsn),
																					 maybeSSNSegRstrct => MATCHUNICODE(ssnsn),
																					 maybeOthrSegRstrct => MATCHUNICODE(sn),
																					 MATCHED(fsn) => MATCHUNICODE(fsn),
																					 UBL));
			SELF.opId := MAP(isATL => OP_ID.ID_ATL,
											 MATCHED(OP_OR) => OP_ID.ID_OR,
											 MATCHED(OP_BUTNOT) => OP_ID.ID_BUTNOT,
											 MATCHED(OP_W) => OP_ID.ID_W,
											 MATCHED(OP_NOTW) => OP_ID.ID_NOTW,
											 MATCHED(OP_PRE) => OP_ID.ID_PRE,
											 MATCHED(OP_PREDOC) => OP_ID.ID_PRE,
											 MATCHED(OP_NOTPRE) => OP_ID.ID_NOTPRE,
											 MATCHED(OP_NOTPREDOC) => OP_ID.ID_NOTPRE,
											 MATCHED(OP_WSEG) => OP_ID.ID_WSEG,
											 MATCHED(OP_NOTWSEG) => OP_ID.ID_NOTWSEG,
											 MATCHED(OP_AND) => OP_ID.ID_AND,
											 MATCHED(OP_ANDNOT) => OP_ID.ID_ANDNOT,
											 0);
			// the maximum value the user can supply for proximity connectors
			SELF.dist := IF(isATL, 0, 
											MIN((UNSIGNED2) MATCHUNICODE(OPPTN/number),
													IF(isPREDOC, Constants.CrossSegDistance, Constants.InterSubSegDistance-1)));
															
			SELF.atl := (HitCount) MATCHUNICODE(OP_ATL/number);
			SELF.level := IF(matchLP, IF(~matchRP, 1, 0),
																IF(matchRP, -1, 0));
			SELF.typ := theType;
      
			cmpr_like_last := LENGTH(MATCHUNICODE(Like_Arg))-1;
			UNICODE cmpr_like := MATCHUNICODE(Like_Arg)[2..cmpr_like_last];

			UNICODE tmpWd := cleanupWS(MAP(MATCHED(simple/specialString) => convertPuncts(MATCHUNICODE(specialString)),
																		 MATCHED(simple/currency) => UnicodeLib.UnicodeFilterOut(MATCHUNICODE(currency), U','),
																		 MATCHED(simple/word) => MATCHUNICODE(word),
																		 MATCHED(simple/intg_dec) => MATCHUNICODE(intg_dec),
																		 maybeDtSegRstrct => MATCHUNICODE(dsn),
																		 maybeSSNSegRstrct => MATCHUNICODE(ssnsn),
																		 maybeOthrSegRstrct => MATCHUNICODE(sn),
																		 MATCHED(OPPTN/B_OPRTR) => MATCHUNICODE(B_OPRTR),
																		 MATCHED(OPPTN/U_OPRTR) => MATCHUNICODE(U_OPRTR),
																		 MATCHED(ssn/hyphenedSSN) => convertPuncts(MATCHUNICODE(hyphenedSSN)),
																		 MATCHED(like_expr) => cmpr_like,
																		 MATCHUNICODE));

			SELF.word := tmpWd;
			SELF.numWords := IF(MATCHED(like_expr), 1,countWords(tmpWd));  // Like is a single str
			SELF.sprseqv := IF(isEquiv,FALSE,TRUE);
		
			BOOLEAN cmltMDY := MATCHED(date/m_d_y);
			BOOLEAN cmltMDYL := MATCHED(date/m_d_y_l);
			BOOLEAN cmltYMD := MATCHED(date/y_m_d);
			BOOLEAN partialYM := MATCHED(date/m_y) OR MATCHED(date/y_m);
			BOOLEAN partialYML := MATCHED(date/m_y_l);
			BOOLEAN partialY := MATCHED(date/year);
			UNICODE cmpr_dt := MATCHUNICODE(DT_CMPR);
			UNICODE cmpr_dt_any := MATCHUNICODE(date/ANY_CMPR);
			UNICODE cmpr_num_any := MATCHUNICODE(numeric/ANY_CMPR);
			UNICODE cmpr_any := IF(cmpr_dt_any <> UBL, cmpr_dt_any, cmpr_num_any);
			UNICODE cmpr_num := MATCHUNICODE(NUM_CMPR);
			BOOLEAN isCmpEQ := matchEQ(cmpr_dt, cmpr_any, cmpr_num);
			BOOLEAN isCmpGT := matchGT(cmpr_dt, cmpr_any, cmpr_num);
			BOOLEAN isCmpLT := matchLT(cmpr_dt, cmpr_any, cmpr_num);
			BOOLEAN isCmpGE := matchGE(cmpr_dt, cmpr_any, cmpr_num);
			BOOLEAN isCmpLE := matchLE(cmpr_dt, cmpr_any, cmpr_num);
			BOOLEAN isRng := MATCHED(date/RNG) OR MATCHED(date/BTW) OR numRngPat;
			// BOOLEAN isLike := MATCHED(like_expr);
			BOOLEAN isDtEQL := theType = dTyp AND (isCmpEQ OR (~isRng AND cmpr_dt = UBL AND cmpr_any = UBL AND cmpr_num = UBL));
			NominalFilter fType := IF(~isCmprble, NominalFilter.IN_Filter,
																						MAP(isCmpGT => NominalFilter.GT_Filter,
																								isCmpLT => NominalFilter.LT_Filter,
																								isDtEQL => IF(cmltMDY OR cmltMDYL OR cmltYMD,
																																NominalFilter.EQ_Filter,
																																NominalFilter.RNG_Filter),
																								theType = nTyp AND isCmpEQ => NominalFilter.EQ_Filter,
																								isCmpGE => NominalFilter.GE_Filter,
																								isCmpLE => NominalFilter.LE_Filter,
																								isRng => NominalFilter.RNG_Filter,
																								isLike => NominalFilter.Like_Filter,
																								NominalFilter.IN_Filter));

			SELF.filterType := fType;
			SELF.tmpVal := MAP(MATCHED(date/dtPtRngFull) => MATCHUNICODE(dtPtRngFull),
												 MATCHED(date/dtPtBtwFull) => btwToRng(MATCHUNICODE(dtPtBtwFull)),
												 MATCHED(date/dtPtBtwFull_L) => btwLToRng(MATCHUNICODE(dtPtBtwFull_L)),
												 MATCHED(date/dtPtRngYr) => yearToFullDateRange(MATCHUNICODE(y_rng)),
												 MATCHED(date/dtPtBtwYr) => btwYearToFullDateRange(MATCHUNICODE(y_btw)),
												 MATCHED(date/dtPtRngPartial) => partialToFullDateRange(MATCHUNICODE(dtPtRngPartial)),
												 MATCHED(date/dtPtBtwPartial) => btwPartialToFullDateRange(MATCHUNICODE(dtPtBtwPartial)),
												 MATCHED(date/dtPtBtwPartial_L) => btwPartialLToRng(MATCHUNICODE(dtPtBtwPartial_L)),
												 numRngPat => IF(~isNumRngErr, numRngV, PARSEERR_BADNUMRNG),
												 cmltMDY => dateValue(MATCHUNICODE(m_d_y), TRUE),
												 cmltMDYL => dateLValue(MATCHUNICODE(m_d_y_l)),
												 cmltYMD => dateValue(MATCHUNICODE(y_m_d), FALSE),
												 partialYM => IF(isDtEQL, year_monthRng(MATCHUNICODE(year), MATCHUNICODE(month)),
																									year_monthValue(MATCHUNICODE(year), MATCHUNICODE(month), fType)),
												 partialYML => IF(isDtEQL, year_monthRng(MATCHUNICODE(year), toNumExpr(MATCHUNICODE(month_l))),
																									 year_monthValue(MATCHUNICODE(year), toNumExpr(MATCHUNICODE(month_l)), fType)),
												 partialY => IF(isDtEQL, yearRng(MATCHUNICODE(year)),
																								 yearValue(MATCHUNICODE(year), fType)),
												 MATCHED(numeric/currency) => UnicodeLib.UnicodeFilterOut(MATCHUNICODE(currency), U','),
												 MATCHED(numeric/intg_dec) => MATCHUNICODE(intg_dec),
												 MATCHED(ssn/hyphenedSSN) => UnicodeLib.UnicodeFilterOut(MATCHUNICODE(hyphenedSSN), U'-'),
												 MATCHED(like_expr) => cmpr_like,
												 UBL);

			SELF.rangeType := IF(fType = NominalFilter.RNG_Filter,
														MAP(MATCHED(y_m_d_rng) => drTyp.YMDRange,
																MATCHED(y_m_d_btw) => drTyp.YMDRange,
																MATCHED(m_d_y_rng) => drTyp.MDYRange,
																MATCHED(m_d_y_btw) => drTyp.MDYRange,
																defaultPartialDateRng),
														 drTyp.NoRange);
			SELF := [];
		END;


		MyToken setCounter(MyToken tok, UNSIGNED2 cnt) := TRANSFORM
			SELF.seq := cnt;
			SELF := tok;
		END;


		STRING makeParseErrMsg(STRING cause) := Limits.ParseErr_Msg + cause;


		cleanup(DATASET(MyToken) tokens) := FUNCTION
			Pair := RECORD
				BOOLEAN		opX;
				UNSIGNED2	pt;
			END;

			Result := RECORD
				UNSIGNED2			at;
				Flags					esc;
				BOOLEAN				op;
				INTEGER1			depth;
				DATASET(Pair)	unmatched{MAXCOUNT(Limits.Max_Terms/2)};
				DATASET(Pair)	rdn{MAXCOUNT(Limits.Max_Terms)};
			END;

			Result toResult(MyToken tok) := TRANSFORM
				SELF.at := tok.seq;
				SELF.esc := IF(tok.typ = anyNominal, Flags.SGR, tok.escF);
				SELF.op := tok.opId > 0;
				SELF.depth := tok.level;
				SELF.unmatched := [];
				SELF.rdn := [];
			END;

			Result test(Result l, Result r) := TRANSFORM
				BOOLEAN inEsc := (l.esc & Flags.ESC) > 0;
				BOOLEAN inSGR := ((l.esc | r.esc) & Flags.SGR) > 0;
				Flags maskV := IF(~inEsc AND inSGR AND r.depth < 0, r.esc | Flags.SGR, r.esc);
				BOOLEAN needsChk := ~inEsc AND ~inSGR;
				BOOLEAN rop := needsChk AND r.op;
				INTEGER1 rdepth := IF(needsChk, r.depth, 0);
				INTEGER tDepth := l.depth + rdepth;

				SELF.esc := l.esc ^ maskV;
				SELF.depth := IF(tDepth > 0, tDepth, 0);
				SELF.unmatched := MAP(rdepth > 0 => l.unmatched & ROW(TRANSFORM(Pair, SELF.pt := r.at, SELF := [])),
															rdepth < 0 => l.unmatched[1 .. tDepth],
															rop AND tDepth > 0 => l.unmatched[1 .. tDepth-1] & ROW(TRANSFORM(Pair, SELF.opX := TRUE, SELF := l.unmatched[tDepth])),
															l.unmatched);
				SELF.rdn := IF(rdepth < 0 AND tDepth >= 0 AND ~l.unmatched[l.depth].opX, l.rdn & l.unmatched[l.depth] & ROW(TRANSFORM(Pair, SELF.pt := r.at, SELF := [])), l.rdn);
				SELF := r;
			END;

			numbered := PROJECT(tokens, setCounter(LEFT, COUNTER));
			specials := numbered(isSpecial OR typ = anyNominal OR opId > 0);
			rslts := PROJECT(specials, toResult(LEFT));
			rslt2 := DEDUP(ITERATE(rslts, test(LEFT, RIGHT)), TRUE, RIGHT);
			redundants := NORMALIZE(rslt2, LEFT.rdn, TRANSFORM(RIGHT));
			modified := JOIN(numbered, redundants, LEFT.seq = RIGHT.pt,
																						 TRANSFORM(LEFT), LOOKUP, LEFT ONLY);

			BOOLEAN unMatched := EXISTS(NORMALIZE(rslt2, LEFT.unmatched, TRANSFORM(RIGHT)));

			RETURN IF(unMatched, DATASET([], MyToken), IF(EXISTS(redundants), modified,
																																				numbered));
		END;


		MyToken groupThem(MyToken l, MyToken r) := TRANSFORM
			UNSIGNED1 esc := l.escF;
			BOOLEAN isEsc := esc > 0;
			// segment
			BOOLEAN	segMayStart := l.typ = anyNominal;
			BOOLEAN segMayEnd := l.segName <> BL AND r.level < 0 AND l.level = l.segLvl;
			BOOLEAN segStart := ~isEsc AND segMayStart;
			BOOLEAN segEnd := ~isEsc AND segMayEnd;
			// ATL
			BOOLEAN isATL := r.opId = OP_ID.ID_ATL;
			BOOLEAN wasATL := l.opId = OP_ID.ID_ATL;
			BOOLEAN atlMayEnd := l.atl > 0 AND r.level < 0 AND l.level = l.atlLvl;
			BOOLEAN atlStart := ~isEsc AND wasATL;
			BOOLEAN atlEnd := ~isEsc AND atlMayEnd;

			BOOLEAN mayLvlUp := r.level > 0;
			BOOLEAN mayLvlDown := r.level < 0 AND l.level > 0;
			BOOLEAN mayChgLvl := mayLvlUp OR mayLvlDown;
			BOOLEAN chgLevel := ~isEsc AND mayChgLvl AND ~segMayEnd;
			BOOLEAN chgGrpId := ~isEsc AND mayChgLvl AND ~segMayStart AND ~segMayEnd;

			SELF.seq := l.seq + 1;
			SELF.escF := esc ^ r.escF;
			SELF.opId := IF(SELF.escF <> 0, 0, r.opId);
			SELF.atl := IF(~isEsc AND isATL, r.atl, l.atl);
			SELF.level := IF(chgLevel, l.level + r.level, l.level);
			SELF.segLvl := MAP(segStart => l.level,
												 segEnd => 0,
												 l.segLvl);
			SELF.atlLvl := MAP(atlStart => l.level,
												 atlEnd => 0,
												 l.atlLvl);

			STRING tmpSegName := MAP(segEnd => BL,
															 ~isEsc AND (r.segName <> BL OR l.cmprWithSN ) => r.segName,
															 l.segName);
			BOOLEAN isDtSeg := IF(tmpSegName <> BL, isDateSeg(tmpSegName), FALSE);
			BOOLEAN isSSNSeg := IF(tmpSegName <> BL, isSSNSeg(tmpSegName), FALSE);
			BOOLEAN isNSeg := IF(tmpSegName <> BL, isNumSeg(tmpSegName), FALSE);
      BOOLEAN isFSeg := IF(tmpSegName <> BL, isFieldSeg(tmpSegName), FALSE);
			BOOLEAN isAmbSeg := IF(tmpSegName <> BL, isAmbgSeg(tmpSegName), FALSE);
			BOOLEAN isDtOrNumSeg := isDtSeg OR isNSeg OR isAmbSeg;
			SegmentType tmpSegT := MAP(isDtSeg => seg_Date_T,
																 isSSNSeg => seg_SSN_T,
																 isNSeg => seg_Numeric_T,
                                 isFSeg => seg_Field_T,
																 isAmbSeg => seg_Group_T,
																 0);
			BOOLEAN maybeRngExpr := ~isEsc AND r.unresolved AND isDtOrNumSeg AND r.typ = unkTyp;
			BOOLEAN isMultiStrsExpr := ~isEsc AND r.unresolved AND r.typ = tTyp;
			BOOLEAN remainUnresolved := ~isEsc AND r.unresolved AND ~isDtOrNumSeg;
			BOOLEAN unmatchedNumexprAndSeg := r.typ = nTyp AND ~isNSeg AND r.numWords = 1;
			BOOLEAN unmatchedSSNexpr := r.typ = sTyp AND ~isSSNSeg;
			BOOLEAN isKwdWithPuncts := Equivalence.kwdPunctMatch((STRING) r.word, dictVer);
			ExpResult cnvRslt := expandExpr(r.word, tmpSegT, l.grpId, l.subGrpId);
			UNICODE cnvWord := convertPuncts(r.word);
			UNSIGNED2 numCvtdWords := countWords(cnvWord);

			SELF.word := MAP(maybeRngExpr => cnvRslt.word,
											 remainUnresolved => cnvWord,
											 unmatchedSSNexpr => cnvWord,
											 ~isEsc AND r.tmpVal <> UBL => r.tmpVal,
											 unmatchedSSNexpr => cnvWord,
											 isMultiStrsExpr => cnvWord,
											 isEsc => IF(isKwdWithPuncts, r.word, cnvWord),
											 r.word);
			SELF.typ := MAP(maybeRngExpr => cnvRslt.typ,
											remainUnresolved => r.typ,
											SELF.escF <> 0 AND (r.typ = unkTyp OR r.typ = anyNominal) AND r.escF = 0 => tTyp,
											unmatchedSSNexpr => nTyp,
											r.typ);
			SELF.segName := tmpSegName;
			SELF.filterType := IF(maybeRngExpr, cnvRslt.filterType, r.filterType);
			SELF.rangeType := IF(maybeRngExpr, cnvRslt.rangeType, r.rangeType);
			SELF.segmented := tmpSegName <> BL;
			SELF.segT := tmpSegT;
			SELF.numWords := MAP(isEsc AND ~isKwdWithPuncts => numCvtdWords,
													 remainUnresolved => numCvtdWords,
													 maybeRngExpr => cnvRslt.numWords,
													 unmatchedNumexprAndSeg => numCvtdWords,
													 unmatchedSSNexpr => numCvtdWords,
													 isMultiStrsExpr => numCvtdWords,
													 1);
			SELF.unresolved := MAP(isEsc => TRUE,
														 remainUnresolved => r.unresolved,
														 maybeRngExpr => cnvRslt.unresolved,
														 unmatchedSSNexpr => r.tmpVal <> UBL,
														 isMultiStrsExpr);
			SELF.grpId := MAP(maybeRngExpr => cnvRslt.grpId,
												IF(chgGrpId, l.grpId + 1, l.grpId));
			SELF.subGrpId := MAP(maybeRngExpr => cnvRslt.subGrpId,
													 IF(~isEsc AND r.opId > 0 AND ~isATL, l.subGrpId + 1, l.subGrpId));
			SELF := r;
		END;


		MyToken expandWord(MyToken l, UNSIGNED1 cnt) := TRANSFORM
			BOOLEAN unresolved := l.unresolved;

			MyToken simple(UNICODE wd) := TRANSFORM
				UNICODE RE_NUMBER := U'^[:digit:]+$';
				BOOLEAN isNumber := REGEXFIND(RE_NUMBER, wd);

				SELF.word := wd;
				SELF.typ := IF(unresolved, IF(isNumber, nTyp, tTyp), l.typ);
				SELF.unresolved := FALSE;
				SELF.numWords := IF(unresolved, 1, l.numWords);
				SELF := l;
			END;

			MyToken expandAmbiguous(UNICODE wd) := TRANSFORM
				SELF.word := wd;
				SELF.typ := CASE(cnt, 1 => dTyp,
															3 => nTyp,
															unkTyp);
				SELF.filterType := CASE(cnt, 2 => NominalFilter.IN_Filter,
																		 3 => NominalFilter.EQ_Filter,
																		 l.filterType);
				SELF.rangeType := IF(cnt <> 1, drTyp.NoRange,
																			 l.rangeType);
				SELF.opId := IF(cnt = 2, OP_ID.ID_OR, l.opId);
				SELF.level := l.level + 1;
				SELF.subGrpId := IF(cnt = 1, l.subGrpId - 1, l.subGrpId);
				SELF.unresolved := FALSE;
				SELF.numWords := 1;
				SELF := l;
			END;

			UNICODE wd := IF(unresolved, extractWord(l.word, cnt), l.word);
			BOOLEAN makeORed := l.segT = seg_Group_T AND l.numWords = 3;

			SELF := IF(unresolved, IF(makeORed, ROW(expandAmbiguous(wd)),
																					ROW(simple(wd))),
														 l);
		END;


		makeRPNSet(DATASET(MyToken) input) := FUNCTION
			MetaOprndRec := RECORD
				UNSIGNED1	opId;
				UNSIGNED2	dist;
				HitCount	atl;
				UNSIGNED1	level;
				UNSIGNED1	grp;
				UNSIGNED1	seq;
				UNSIGNED1	phrsSeq;
				UNSIGNED1	oprSeq;
				BOOLEAN		isLast;
				BOOLEAN		isCmd;
				OprndRec	opr;
			END;

			MetaOprndRec makeTR(MyToken l, MyToken r) := TRANSFORM
				SELF.atl := l.atl;
				SELF.oprSeq := l.seq;
				SELF.opr.sprsEqv := l.escF <> 0;
				SELF.opr.isR := l.subGrpId = r.subGrpId;
				SELF.opr := l;
				SELF := r;
				SELF := [];
			END;

			MetaOprndRec makeTR2(MyToken input) := TRANSFORM
				SELF.oprSeq := input.seq;
				SELF.opr := input;
				SELF := input;
				SELF := [];
			END;

			MetaOprndRec makeTR3(MyToken input) := TRANSFORM
				SELF.grp := 1;
				SELF.seq := 1;
				SELF.oprSeq := input.seq;
				SELF.opr.sprsEqv := input.escF <> 0;
				SELF.opr.isR := TRUE;
				SELF.opr := input;
				SELF := input;
				SELF := [];
			END;

			MetaOprndRec markAsLast(MetaOprndRec input) := TRANSFORM
				SELF.isLast := TRUE;
				SELF := input;
			END;

			MetaOprndRec markThem(MetaOprndRec l, MetaOprndRec r) := TRANSFORM
				BOOLEAN sameGrp := l.opId = r.opId AND l.level = r.level;
				BOOLEAN isCmd := r.opr.typ = unkTyp;
				BOOLEAN lR := l.opr.isR;
				BOOLEAN rR := r.opr.isR;
				BOOLEAN inPhrase := sameGrp AND l.seq = r.seq AND ((lR AND rR) OR (~lR AND ~rR));

				SELF.grp := IF(sameGrp OR isCmd, l.grp, l.grp + 1);
				SELF.phrsSeq := IF(inPhrase OR isCmd, l.phrsSeq, l.phrsSeq + 1);
				SELF.oprSeq := IF(isCmd, l.oprSeq, l.oprSeq + 1);
				SELF.isCmd := isCmd;
				SELF := r;
			END;

			MetaOprndRec markPossibleStreetDir(MetaOprndRec l, MetaOprndRec r, UNSIGNED1 cnt) := TRANSFORM
				STRING wd := (STRING) UnicodeLib.UnicodeCleanSpaces(r.opr.word);
				BOOLEAN dirWild := REGEXFIND(Equivalence.PatternWildcardDirectional, wd, NOCASE);
				BOOLEAN maybeDirectional := cnt = 2 AND l.opr.typ = nTyp AND r.opr.typ = tTyp AND dirWild;

				SELF.opr.drctExp := maybeDirectional;
				SELF.opr.sprsEqv := IF(maybeDirectional, TRUE, r.opr.sprsEqv);
				SELF := r;
			END;
						
			ElemType := ENUM(UNSIGNED1, T_WD = 0, T_PHRS, T_OP);

			StageInfo := RECORD
				UNSIGNED1	seq;
				ElemType	kind;
				UNSIGNED2	dist;
				HitCount	atl;
			END;

			StageInfo makePhraseStageInfo(UNSIGNED1 seq, UNSIGNED2 d = 0) := TRANSFORM
				SELF.seq := seq;
				SELF.kind := ElemType.T_PHRS;
				SELF.dist := d;
				SELF := [];
			END;

			StageInfo makeOpStageInfo(UNSIGNED1 seq, UNSIGNED2 d = 0) := TRANSFORM
				SELF.seq := IF(seq > 0, seq, ERROR(Limits.ParseErr_Code, makeParseErrMsg('Irregular use of boolean connector detected.')));
				SELF.kind := ElemType.T_OP;
				SELF.dist := d;
				SELF := [];
			END;

			Layout_RPN_Oprnd toLayout_RPN_Oprnd(StageInfo input,
																					Distance opDist = 0,
																					BOOLEAN lr = TRUE) := TRANSFORM
				Distance dist := IF(input.dist <> 0, input.dist, opDist);

				SELF.stageIn := input.seq;
				SELF.leftWindow := dist;
				SELF.rightWindow := IF(lr, dist, 0);
				SELF := input;
				SELF := [];
			END;

			PhraseSet := RECORD
				UNSIGNED1						seq;
				UNSIGNED1						actualSeq;
				UNSIGNED1						numWords;
				DATASET(StageInfo)	phrss{MAXCOUNT(Limits.Max_Terms)};
			END;

			makePhraseSet(GROUPED DATASET(MetaOprndRec) wdRecs, UNSIGNED1 base) := FUNCTION
				PhraseSet toPhraseSet(MetaOprndRec l, DATASET(MetaOprndRec) r) := TRANSFORM
					StageInfo cnv(MetaOprndRec input) := TRANSFORM
						SELF.seq := input.oprSeq;
						SELF.kind := ElemType.T_WD;
						SELF := input;
					END;

					SELF.seq := l.phrsSeq;
					SELF.numWords := COUNT(r);
					SELF.phrss := PROJECT(r, cnv(LEFT));
					SELF := l;
					SELF := [];
				END;

				PhraseSet setActualSeq(PhraseSet l, PhraseSet r, UNSIGNED1 base) := TRANSFORM
					UNSIGNED1 prev := IF(l.actualSeq > 0, l.actualSeq, base);

					SELF.actualSeq := IF(r.numWords > 1, prev + 1, prev);
					SELF := r;
				END;

				tmpSet := ROLLUP(wdRecs, GROUP, toPhraseSet(LEFT, ROWS(LEFT)));
				RETURN ITERATE(tmpSet, setActualSeq(LEFT, RIGHT, base));
			END;

			OperatorRec := RECORD
				UNSIGNED1						opId;
				UNSIGNED1						dist;
				UNSIGNED1						level;
				BOOLEAN							danglingOp;
				BOOLEAN							hasLeft;
				BOOLEAN							hasRight;
				BOOLEAN							isLast;
				UNSIGNED1						seq;
				DATASET(StageInfo)	recs{MAXCOUNT(Limits.Max_Terms)};
			END;

			makeOperatorSet(GROUPED DATASET(MetaOprndRec) oprndRecs,
											DATASET(PhraseSet) phrsSet) := FUNCTION
				OperatorRec makeOperatorRec(MetaOprndRec l, DATASET(MetaOprndRec) r) := TRANSFORM
					StageInfo toStageInfo(MetaOprndRec tr) := TRANSFORM
						SELF.seq := IF(~tr.isCmd, tr.phrsSeq, 0);
						SELF.kind := ElemType.T_PHRS;
						SELF := tr;
					END;

					StageInfo correctSI(StageInfo l, PhraseSet r) := TRANSFORM
						BOOLEAN chg := r.numWords < 2;

						SELF.seq := IF(chg, r.phrss[1].seq, r.actualSeq);
						SELF := IF(chg, r.phrss[1], l);
					END;

					siRec := PROJECT(r, toStageInfo(LEFT));
					corrected := JOIN(siRec, phrsSet, LEFT.seq = RIGHT.seq, correctSI(LEFT, RIGHT), LOOKUP);

					SELF.hasLeft := EXISTS(r(opr.typ <> unkTyp AND ~opr.isR));
					SELF.hasRight := EXISTS(r(opr.typ <> unkTyp AND opr.isR));
					SELF.recs := corrected;
					SELF.danglingOp := NOT EXISTS(corrected);
					SELF.isLast := EXISTS(r(isLast));
					SELF := l;
					SELF := [];
				END;

				OperatorRec setSeq(OperatorRec input, UNSIGNED1 cnt) := TRANSFORM
					SELF.seq := cnt;
					SELF := input;
				END;

				r_recs := ROLLUP(oprndRecs, TRANSFORM(RIGHT), grp, phrsSeq, isCmd);
				oprtrRecs := ROLLUP(r_recs, GROUP, makeOperatorRec(LEFT, ROWS(LEFT)));
				RETURN PROJECT(oprtrRecs, setSeq(LEFT, COUNTER));
			END;

			resortOperatorSet(DATASET(OperatorRec) oprtrSet, UNSIGNED1 base) := FUNCTION
				OprRec := RECORD
					UNSIGNED1	ix;
					UNSIGNED1	level;
					UNSIGNED1	op;
					UNSIGNED1	seq;
				END;

				SeqRec := RECORD
					UNSIGNED1	seq;
				END;

				MetaProdRec := RECORD
					OperatorRec;
					UNSIGNED1				numOprnds;
					DATASET(OprRec)	opStk{MAXCOUNT(Limits.Max_Terms)};
					DATASET(SeqRec)	oprStk{MAXCOUNT(Limits.Max_Terms)};
				END;

				MetaProdRec toMetaProdRec(OperatorRec input) := TRANSFORM
					SELF := input;
					SELF.numOprnds := COUNT(input.recs);
					SELF := [];
				END;

				TmpRec := RECORD
					StageInfo;
					UNSIGNED1	ix;
				END;

				TmpRec toTmpRec(StageInfo input, UNSIGNED1 cnt) := TRANSFORM
					SELF.ix := cnt;
					SELF := input;
				END;

				MetaProdRec reSeq(MetaProdRec input, SET OF UNSIGNED1 order) := TRANSFORM
					UNSIGNED1 ix := order[input.seq] + base;

					SELF.seq := ix;
					SELF := input;
				END;

				MetaProdRec resolve(MetaProdRec l, MetaProdRec r) := TRANSFORM
					UNSIGNED1	numOprOnStk := COUNT(l.oprStk);
					DATASET(SeqRec) newTop := DATASET([{r.seq}], SeqRec);
					DATASET(StageInfo) stackTop := DATASET(ROW(makeOpStageInfo(l.oprStk[numOprOnStk].seq)));
					DATASET(StageInfo) oneBelow := DATASET(ROW(makeOpStageInfo(l.oprStk[numOprOnStk - 1].seq)));
					BOOLEAN hasLeft := r.hasLeft;
					BOOLEAN hasRight := r.hasRight;

					SELF.recs := MAP(~hasLeft AND ~hasRight => oneBelow & stackTop,
													 hasLeft AND hasRight => r.recs,
													 hasLeft => r.recs & stackTop,
													 hasRight => stackTop & r.recs);
					SELF.oprStk := MAP(~hasLeft AND ~hasRight => l.oprStk[1..numOprOnStk-2] & newTop,
														 hasLeft AND hasRight => l.oprStk & newTop,
														 l.oprStk[1..numOprOnStk-1] & newTop);
					SELF := r;
				END;

				MetaProdRec orderOps(MetaProdRec l, MetaProdRec r) := TRANSFORM
					OprRec makeOprRec(MetaProdRec tr, UNSIGNED1 ix) := TRANSFORM
						SELF.ix := ix;
						SELF.op := tr.opId;
						SELF := tr;
					END;

					makePhraseFromOp(DATASET(OprRec) ops) := FUNCTION
						r_ops := SORT(ops, -ix);
						rslt := PROJECT(r_ops, makeOpStageInfo(LEFT.seq));
						RETURN rslt;
					END;

					UNSIGNED1 n := COUNT(l.opStk);
					BOOLEAN noPush := r.hasRight;
					BOOLEAN push := ~r.hasRight;

					mayPopOps := IF(push, l.opStk(level > r.level OR (level = r.level AND op <= r.opId)),
																l.opStk(level > r.level));

					UNSIGNED1 cond := MAP(n > 0 AND EXISTS(mayPopOps) => 1,
																n > 0 AND l.hasRight AND l.opStk[n].level = r.level AND l.opStk[n].op <= r.opId => 2,
																0);

					d_recs := CASE(cond, 1 => makePhraseFromOp(mayPopOps),
															 2 => DATASET(ROW(makeOpStageInfo(l.opStk[n].seq))),
															 DATASET([], StageInfo));
					p_recs := l.recs & d_recs;

					p_opStk := CASE(cond, 1 => IF(push, l.opStk(level < r.level OR (level = r.level AND op > r.opId)),
																							l.opStk(level <= r.level)),
																2 => l.opStk[1..n-1],
																l.opStk);

					theRecs := IF(noPush, p_recs & ROW(makeOpStageInfo(r.seq)), p_recs);

					UNSIGNED1 nn := COUNT(p_opStk);

					theOps := IF(push, p_opStk & DATASET(ROW(makeOprRec(r, nn + 1))), p_opStk);

					UNSIGNED1 nnn := IF(push, nn + 1, nn);

					extra := IF(r.isLast AND nnn > 0, makePhraseFromOp(theOps),
																						DATASET([], StageInfo));

					SELF.opStk := theOps;
					SELF.recs := theRecs & extra;
					SELF := r;
				END;

				tmpR := PROJECT(oprtrSet, toMetaProdRec(LEFT));
				ordO := ITERATE(tmpR, orderOps(LEFT, RIGHT));
				d_tmp := NORMALIZE(DEDUP(ordO, TRUE, RIGHT), LEFT.recs, toTmpRec(RIGHT, COUNTER));
				order := SET(SORT(d_tmp, seq), ix);
				mpRec := SORT(PROJECT(tmpR, reSeq(LEFT, order)), seq);
				r_mpRec := ITERATE(mpRec, resolve(LEFT, RIGHT));
				RETURN PROJECT(r_mpRec, OperatorRec);
			END;

			Layout_ParseRec	toParseRec(MetaOprndRec input) := TRANSFORM
				Layout_OprndRec tmpTx(OprndRec input) := TRANSFORM
					SELF.word := (STRING) input.word;
					SELF := input;
				END;

				EQ_filters := [NominalFilter.IN_Filter, NominalFilter.EQ_Filter] : GLOBAL;
				OP_ID op := MAP(input.opr.filterType=NominalFilter.LIKE_Filter => OP_ID.ID_GETFLD,
												input.opr.filterType IN EQ_filters => OP_ID.ID_GET,
												OP_ID.ID_RNGGET);


				SELF.opCode := mapOpId(op);
				SELF.leftWindow := 0;
				SELF.rightWindow := 0;
				SELF.stage := input.oprSeq;
				SELF.A := ROW(tmpTx(input.opr));
				SELF := input;
			END;

			Layout_Search_RPN_Set cnvPhrase(PhraseSet input) := TRANSFORM
				SELF.opCode := mapOpId(OP_ID.ID_PHRS);
				SELF.stage := input.actualSeq;
				SELF.phraseLength := input.numWords;
				SELF.maxPhraseLength := input.numWords;
				SELF.inputs := PROJECT(input.phrss, toLayout_RPN_Oprnd(LEFT));
				SELF := [];
			END;

			Layout_Search_RPN_Set cnvOperator(OperatorRec input) := TRANSFORM
				OP_ID op := input.opId;
				BOOLEAN lr := op <> OP_ID.ID_PRE AND op <> OP_ID.ID_NOTPRE;

				SELF.opCode := mapOpId(op);
				SELF.stage := input.seq;
				SELF.inputs := PROJECT(input.recs, toLayout_RPN_Oprnd(LEFT, input.dist, lr));
				SELF.maxLeftWindow := MAX(SELF.inputs, leftWindow);
				SELF.maxRightWindow := MAX(SELF.inputs, rightWindow);
				SELF := [];
			END;


			tmpSet := GROUP(SORTED(input, grpId, subGrpId, seq), grpId);
			initial := UNGROUP(SORT(tmpSet, opId, subGrpId, seq));
			tks := initial(opId = 0);
			opz := PROJECT(input(opId > 0), setCounter(LEFT, COUNTER));
			ops := SORT(opz, -level, -segmented, opId, seq);
			t_1 := JOIN(tks, ops, LEFT.grpId = RIGHT.grpId AND
														LEFT.subGrpId BETWEEN RIGHT.subGrpId - 1 AND RIGHT.subGrpId,
														makeTR(LEFT, RIGHT),
														LOOKUP);
			t_2 := JOIN(t_1, ops, LEFT.seq = RIGHT.seq, makeTR2(RIGHT), RIGHT ONLY);
			t_3 := PROJECT(tks, makeTR3(LEFT));
			tmp := IF(EXISTS(ops), SORT(t_1 & t_2, seq, oprSeq), t_3);

			UNSIGNED n := COUNT(tmp);

			mkd_tmp := tmp[1..n-1] & ROW(markAsLast(tmp[n]));
			prepared := ITERATE(mkd_tmp, markThem(LEFT, RIGHT));
			terms := LIMIT(prepared(~isCmd), Limits.Max_Terms, FAIL(Limits.TooManyTerms_Code, Limits.TooManyTerms_Msg));
			g_phrs := GROUP(SORTED(terms, grp, phrsSeq), grp, phrsSeq);
			
			phrs_mkd := UNGROUP(ITERATE(g_phrs, markPossibleStreetDir(LEFT, RIGHT, COUNTER)));
			c_terms := myconv(PROJECT(phrs_mkd, toParseRec(LEFT)));
			phrsSet := makePhraseSet(g_phrs, COUNT(terms));
			c_phrss := PROJECT(phrsSet(numWords > 1), cnvPhrase(LEFT));
		
			t_p := c_terms & c_phrss;
			g_oprtr := GROUP(SORTED(prepared(opId <> 0), grp, oprSeq), grp, isCmd);
			oprtrSet := makeOperatorSet(g_oprtr, phrsSet);
			rs_oprtrSet := resortOperatorSet(oprtrSet, COUNT(t_p));
			c_oprtrSet := PROJECT(rs_oprtrSet, cnvOperator(LEFT));
							
			RETURN t_p & c_oprtrSet;
		END;


		RULE myRule := date | vagueDate | numeric | ssn |
									 maybeDSN | maybeSSNSN | maybeSN | like_expr |
									 MultiEquiv | SingleEquiv | punctEqvs | OPPTN | simple | special;
			
		exprs := PARSE(DATASET(dx), rqst, myRule, toTok(LEFT), MAX, MANY, NOCASE, MAXLENGTH(4000));
		errs := exprs((escF & Flags.Err) <> 0);
		fR := FAIL(MyToken, Limits.ParseErr_Code, makeParseErrMsg((STRING) EVALUATE(errs[1], tmpVal)));

		cleaned := IF(~EXISTS(errs), cleanup(exprs), fR);
		o_exprs := ITERATE(cleaned, groupThem(LEFT, RIGHT));
		g_exprs := NORMALIZE(o_exprs, LEFT.numWords, expandWord(LEFT, COUNTER));

		UNSIGNED numTk := COUNT(g_exprs);
		BOOLEAN good := numTk > 0 AND
			IF(g_exprs[numTk].typ = unkTyp, TRUE,
																			g_exprs[numTk].level = 0 AND g_exprs[numTk].escF = 0);

		// get rid of ATL operators, segment names, LP, RP and QUOT.
		cg_exprs := DEDUP(g_exprs(~isSpecial AND opId <> OP_ID.ID_ATL),
											LEFT.typ = anyNominal AND (STRING) toUpper(LEFT.word) = RIGHT.segName, RIGHT);
		rsltSet := makeRPNSet(cg_exprs);
		
		RETURN IF(good, rsltSet, FAIL(Layout_Search_RPN_Set, Limits.ParseErr_Code, makeParseErrMsg('Search request could not be parsed.')));
	END;

	RETURN parseFunc(ROW(TRANSFORM(Layout_String, SELF.rqst := qStr, SELF := [])));
END;
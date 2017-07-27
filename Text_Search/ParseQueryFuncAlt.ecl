EXPORT DATASET(Layout_ParseRec) ParseQueryFuncAlt(DATASET(Layout_String) queries,
																								 Func_isSegName isSegName = Func_isSegName) := FUNCTION

	Op	:= Map_Search_Operands;

	// Parse patterns

	STRING QUOT := '"';
	STRING LP := '(';
	STRING RP := ')';
	STRING BL := '';
	STRING SL := '/';
	SET OF STRING spaces := [' ', '\t', '\r', '\n'];

	PATTERN	SP						:= spaces;
	PATTERN	digit					:= PATTERN('[0-9]');
	PATTERN CMPR_AFT			:= 'AFT' OR 'GT' OR '>';
	PATTERN CMPR_BEF			:= 'BEF' OR 'LT' OR '<';
	PATTERN CMPR_IS				:= 'IS' OR '=' OR 'EQ';
	PATTERN CMPR_GEQ			:= 'GEQ' OR '>=' OR 'GE';
	PATTERN CMPR_LEQ			:= 'LEQ' OR '<=' OR 'LE';
	PATTERN CMPR_RNG			:= 'RNG';
	PATTERN COMPARATOR		:= CMPR_GEQ OR CMPR_LEQ OR CMPR_AFT OR CMPR_BEF OR CMPR_IS;
	PATTERN	CMND_AND			:= 'AND';
	PATTERN	CMND_OR				:= 'OR';
	PATTERN	CMND_ANDNOT		:= 'AND' SP+ 'NOT';
	PATTERN	CMND_WSEG			:= 'W' SP* SL SP* 'SEG';
	PATTERN	CMND_NOTSEG		:= 'NOT' SP* 'W' SP* SL SP* 'SEG';
	PATTERN	CMND_W				:= 'W' SP* SL SP* digit+;
	PATTERN	CMND_NOTW			:= 'NOT' SP* 'W' SP* SL SP* digit+;
	PATTERN	CMND_PRE			:= 'PRE' SP* SL SP* digit+;
	PATTERN	CMND_NOTPRE		:= 'NOT' SP* 'PRE' SP* SL SP* digit+;
	PATTERN	CMND_BUTNOT		:= 'BUT' SP+ 'NOT';
	TOKEN		OPERATOR			:= CMND_AND OR CMND_OR OR CMND_ANDNOT
												OR CMND_W OR CMND_NOTW
												OR CMND_PRE OR CMND_NOTPRE OR CMND_BUTNOT;
	TOKEN		SEG_OPERATOR	:= CMND_WSEG OR CMND_NOTSEG;

	PATTERN	colon 				:= ':';
	PATTERN apos					:= '\'';
	PATTERN hyphen				:= '-';
	PATTERN star					:= '*';
	PATTERN question			:= '?';
	PATTERN lsb						:= '[';
	PATTERN rsb						:= ']';
	PATTERN esc						:= '\\';
	PATTERN punct					:= PATTERN('[!#$%&+,.:;@^{|}~]');
	PATTERN WhiteSpace		:= SP OR apos OR hyphen OR SL OR punct OR lsb OR rsb OR esc;
	PATTERN WS						:= WhiteSpace+;
	PATTERN	alnumChar			:= PATTERN('[0-9A-Za-z]');
	PATTERN univChar			:= star OR question;
	PATTERN anyChar				:= univChar OR alnumChar;
	PATTERN univPattern		:= univChar anyChar+ OR
													alnumChar+ univChar anyChar*;
	PATTERN segChar				:= PATTERN('[_0-9A-Za-z]');
	PATTERN segChars			:= segChar+;
	PATTERN charSingle		:= PATTERN('[A-Za-z]');
	PATTERN WordPattern		:= charSingle alnumChar*;
	PATTERN	number				:= digit+;
	PATTERN nTerm					:= WordPattern OR univPattern;

	PATTERN yyyy					:= digit digit digit digit;
	PATTERN mm						:= digit digit?;
	PATTERN dd						:= digit digit?;

	PATTERN dateSep				:= PATTERN('[-/]');
	PATTERN yyyymmdd			:= yyyy dateSep mm dateSep dd;
	PATTERN mmddyyyy			:= mm dateSep dd dateSep yyyy;
	RULE yr_mo_dy					:= yyyymmdd;
	RULE mo_dy_yr					:= mmddyyyy;
	PATTERN ymd_range			:= yyyymmdd colon yyyymmdd;
	PATTERN mdy_range			:= mmddyyyy colon mmddyyyy;
	
	RULE snTok						:= VALIDATE(segChars, isSegName(MATCHTEXT));

	Types.NominalFilter Map_Cmpr(STRING cmpr) :=
		CASE(cmpr, 'IS'		=> Types.NominalFilter.EQ_Filter,
							 '='		=> Types.NominalFilter.EQ_Filter,
							 'GT'		=> Types.NominalFilter.GT_Filter,
							 '>'		=> Types.NominalFilter.GT_Filter,
							 'AFT'	=> Types.NominalFilter.GT_Filter,
							 'GE'		=> Types.NominalFilter.GE_Filter,
							 '>='		=> Types.NominalFilter.GE_Filter,
							 'LE'		=> Types.NominalFilter.LE_Filter,
							 '<='		=> Types.NominalFilter.LE_Filter,
							 '<'		=> Types.NominalFilter.LT_Filter,
							 'LT'		=> Types.NominalFilter.LT_Filter,
							 'BEF'	=> Types.NominalFilter.LT_Filter,
							 'RNG'	=> Types.NominalFilter.RNG_Filter,
							 Types.NominalFilter.IN_Filter);

	dTyp := Types.WordType.Date;
	tTyp := Types.WordType.TextStr;
	nTyp := Types.WordType.Numeric;
	drTyp := Types.DateRangeType;

	OprndRec := Layout_OprndRec;
	ParseRec := Layout_ParseRec;
	ProdRec := Layout_ProdRec;

	OprndRec makeOprnd(STRING word, Types.WordType typ, STRING seg = BL,
										 STRING cmpr = BL, drTyp rng = drTyp.NoRange) := TRANSFORM
	  STRING upcaseSeg := StringLib.StringToUpperCase(seg);
		SELF.word 			:= word;
		SELF.typ 				:= typ;
		SELF.filterType := Map_Cmpr(StringLib.StringToUpperCase(cmpr)); 
		SELF.segName    := upcaseSeg;
		SELF.rangeType  := rng;
	END;

	ParseRec TermTerm(Types.OpCode opCode, OprndRec a, OprndRec b,
										INTEGER ld = 0, INTEGER rd = 0) := TRANSFORM
		SELF.opCode := opCode;
		SELF.leftWindow := ld;
		SELF.rightWindow := rd;
		SELF.A := a;
		SELF.B := b;
		SELF := [];
	END;

	ParseRec FileTerm(Types.OpCode opCode, OprndRec b,
										INTEGER ld = 0, INTEGER rd = 0) := TRANSFORM
		SELF.opCode := opCode;
		SELF.leftWindow := ld;
		SELF.rightWindow := rd;
		SELF.A := [];
		SELF.B := b;
		SELF := [];
	END;

	ParseRec TermFile(Types.OpCode opCode, Oprndrec a,
										INTEGER ld = 0, INTEGER rd = 0) := TRANSFORM
		SELF.opCode := opCode;
		SELF.leftWindow := ld;
		SELF.rightWindow := rd;
		SELF.B := [];
		SELF.A := a;
		SELF := [];
	END;

	ParseRec FileFile(types.OpCode opCode, INTEGER ld = 0, INTEGER rd = 0) := TRANSFORM
		SELF.opCode := opCode;
		SELF.leftWindow := ld;
		SELF.rightWindow := rd;
		SELF := [];
	END;

	makeDate(STRING d, BOOLEAN ymd, STRING seg = BL, STRING cmpr = BL) 
		:= makeOprnd((STRING)ConvertDate(d,ymd), dTyp, seg, cmpr);

	makeDateRange(STRING dr, drTyp rngTyp, STRING seg = BL, STRING cmpr = BL) 
		:= makeOprnd(dr, dTyp, seg, cmpr, rngTyp);

	ParseRec distSegName(ParseRec L, string segName) := TRANSFORM
		SELF.A.segName := IF(L.A.word <> BL, segName, BL);
		SELF.B.segName := IF(L.B.word <> BL, segName, BL);
		SELF := L;
	END;

	setSegName(DATASET(ParseRec) recs, STRING segName) := FUNCTION
	  STRING upcaseSeg := StringLib.StringToUpperCase(segName);
	  ret := PROJECT(recs, distSegName(LEFT, upcaseSeg));
		RETURN ret;
	END;

	ProdRule := RULE TYPE(ProdRec);
	AtomRule := RULE TYPE(ParseRec);
	OprndRule := RULE TYPE(OprndRec);


	OprndRule pTerm := 
			nTerm													makeOprnd($1, tTyp)
		|	number												makeOprnd($1, nTyp)
		| yr_mo_dy		 									makeDate($1, TRUE)
		| mo_dy_yr		 									makeDate($1, FALSE);

	OprndRule restrictedTerm :=
			snTok WS? LP WS? number WS? RP		makeOprnd($5, nTyp, $1)
		| snTok WS COMPARATOR WS number			makeOprnd($5, nTyp, $1, $3)
		| snTok WS? LP WS? yr_mo_dy WS? RP	makeDate($5, TRUE, $1)
		| snTok WS COMPARATOR WS yr_mo_dy		makeDate($5, TRUE, $1, $3)
		| snTok WS? LP WS? mo_dy_yr WS? RP	makeDate($5, FALSE, $1)
		| snTok WS COMPARATOR WS mo_dy_yr		makeDate($5, FALSE, $1, $3)
		| snTok WS CMPR_RNG WS mdy_range		makeDateRange($5, drTyp.MDYRange, $1, $3)
		| snTok WS CMPR_RNG WS ymd_range		makeDateRange($5, drTyp.YMDRange, $1, $3);

	OprndRule aTerm := 
		pTerm	|
		restrictedTerm	|
		snTok WS? LP nTerm RP	makeOprnd($4, tTyp, $1)	|
		QUOT pTerm QUOT;

	// --- Common Transform --- //
	ProdRec c_tt(OprndRec l, OprndRec r) := TRANSFORM
		SELF.atoms := ROW(TermFile(Op.code_GET, l)) + ROW(TermFile(Op.code_GET, r)) + ROW(FileFile(Op.code_PHRASE));
	END;

	ProdRec c_phrs(ProdRec l, OprndRec r) := TRANSFORM
		SELF.atoms := l.atoms + ROW(TermFile(Op.code_GET, r)) + ROW(FileFile(Op.code_PHRASE));
	END;

	ProdRec c_FF(Types.OpCode opCode, ProdRec l, ProdRec r) := TRANSFORM
		SELF.atoms := l.atoms + r.atoms + ROW(FileFile(opCode));
	END;

	// --- For PRE/n and W/n --- //
	Types.Distance	getDistance(STRING input) := FUNCTION
		UNSIGNED SL_LEN := LENGTH(SL) : GLOBAL;
		UNSIGNED at := StringLib.StringFind(input, SL, 1);
		STRING numStr := IF(at > 1, TRIM(input[at+SL_LEN..], ALL), BL);

		RETURN (Types.Distance) numStr;
	END;

	ProdRec pw_FF(Types.OpCode opCode, ProdRec l, ProdRec r,
								STRING cmndStr, BOOLEAN leftOnly = TRUE) := TRANSFORM
		Types.Distance dst := getDistance(cmndStr);

		SELF.atoms := l.atoms + r.atoms + ROW(FileFile(opCode, dst, IF(leftOnly, 0, dst)));
	END;

	// --- --- //
	ProdRule tt :=
		pTerm WS? LP pTerm RP	c_tt($1, $4)	|
		pTerm WS pTerm				c_tt($1, $3);

	ProdRule simpleExpr :=
		aTerm	TRANSFORM(ProdRec, SELF.atoms := ROW(TermFile(Op.code_GET, $1)));

	ProdRule phraseExpr :=
		SELF WS pTerm					c_phrs($1, $3)	|
		SELF WS? LP pTerm RP	c_phrs($1, $4)	|
		tt;

	ProdRule quotedExpr :=
		QUOT phraseExpr QUOT	TRANSFORM(ProdRec, SELF.atoms := $2.atoms);

	ProdRule segExpr :=
		snTok WS? LP (USE(ProdRec, srchRqst) | quotedExpr | phraseExpr	PENALTY(1)) RP	TRANSFORM(ProdRec, SELF.atoms := setSegName($4.atoms, $1));

	ProdRule grpExpr1 :=
		LP USE(ProdRec, srchRqst) RP;

	ProdRule cnctablExpr1 :=
		grpExpr1 | segExpr | quotedExpr | phraseExpr	PENALTY(1);

	ProdRule cnctablExpr2 :=
		cnctablExpr1 | simpleExpr;


	px := -2;

	// --- Rule for OR connector --- //
	ProdRule exprOR :=
		SELF WS CMND_OR WS cnctablExpr2	PENALTY(px)	c_FF(Op.code_OR, $1, $5)	|
		cnctablExpr2;

	// --- Rule for BUT NOT connector --- //
	ProdRule exprBUTNOT :=
		SELF WS CMND_BUTNOT WS exprOR	PENALTY(px)	c_FF(Op.code_BUTNOT, $1, $5)	|
		exprOR;

	// --- Rule for W/n connector --- //
	ProdRule exprW :=
		SELF WS CMND_W WS exprBUTNOT	pw_FF(Op.code_W, $1, $5, $3, FALSE)	|
		exprBUTNOT;

	// --- Rule for NOT W/n connector --- //
	ProdRule exprNOTW :=
		SELF WS CMND_NOTW WS exprW	pw_FF(Op.code_NOTW, $1, $5, $3, FALSE)	|
		exprW;

	// --- Rule for PRE/n connector --- //
	ProdRule exprPRE :=
		SELF WS CMND_PRE WS exprNOTW	pw_FF(Op.code_PRE, $1, $5, $3)	|
		exprNOTW;

	// --- Rule for NOT PRE/n connector --- //
	ProdRule exprNOTPRE :=
		SELF WS CMND_NOTPRE WS exprPRE	pw_FF(Op.code_NOTPRE, $1, $5, $3)	|
		exprPRE;

	// --- Rule for WSEG connector --- //
	ProdRule exprWSEG :=
		SELF WS CMND_WSEG WS exprNOTPRE	c_FF(Op.code_WSEG, $1, $5)	|
		exprNOTPRE;

	// --- Rule for NOT WSEG connector --- //
	ProdRule exprNOTWSEG :=
		SELF WS CMND_NOTSEG WS exprWSEG	c_FF(Op.code_NOTWSEG, $1, $5)	|
		exprWSEG;

	// --- Rule for AND connector --- //
	ProdRule exprAND :=
		SELF WS CMND_AND WS exprNOTWSEG	PENALTY(px)	c_FF(Op.code_AND, $1, $5)	|
		exprNOTWSEG;

	// --- Rule for AND NOT connector --- //
	ProdRule exprANDNOT :=
		SELF WS CMND_ANDNOT WS exprAND	c_FF(Op.code_ANDNOT, $1, $5)	|
		exprAND;

	ProdRule srchRqst := WS? exprANDNOT WS?;

	pr1 := PARSE(queries, rqst, srchRqst, TRANSFORM($1), WHOLE, NOCASE, PARSE, BEST);
	
	RETURN NORMALIZE(pr1, LEFT.atoms, TRANSFORM(RIGHT));
END;
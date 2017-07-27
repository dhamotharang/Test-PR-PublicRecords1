/*2011-11-10T18:23:03Z (Keith Dues)
RR 81404 - Modified to correct beg end seperator
*/
EXPORT Freestyle_Parse(FileName_Info info,
															IKeywording kwd, 
															STRING srchRqst) := FUNCTION
	rqstDS := DATASET([{StringLib.StringToUpperCase(srchRqst)}], 
										{STRING rqst{MAXLENGTH(4096)}});
	dx := Indx_Dictionary3(info);
	UNSIGNED4 Low_Threshold := 10000;
	UNSIGNED4 Med_Threshold	:= Limits.Max_1_Search;
	UNSIGNED4 High_Threshold:= 500000;
	UNSIGNED4 Bad_Threshold	:= 10000000;
	UNSIGNED4 Min_Answers   := 1000;
	UNSIGNED4	Min_Candidates:= 1000000;
	dictStats := CHOOSEN(Indx_DictStat(info), 1); 
	INTEGER8 docCount := EVALUATE(dictStats[1], maxDocFreq) 	: GLOBAL;
	INTEGER8 wrdCount := EVALUATE(dictStats[1], maxFreq)			: GLOBAL;
	code_OR 		:= Map_Search_Operands.code_OR;
	code_AND		:= Map_Search_Operands.code_AND;
	code_ANY2		:= Map_Search_Operands.code_ANY2;
	code_ANDOR 	:= Map_Search_Operands.code_ANDOR;
	code_HALF		:= Map_Search_Operands.code_HALF;
	code_ALLBUT1:= Map_Search_Operands.code_ALLBUT1;
	
	// Parse patterns
	PATTERN QUOT 					:= '"';
	PATTERN LP 						:= '(';
	PATTERN RP 						:= ')';
	PATTERN SL 						:= '/';
	PATTERN APOS					:= '\'';
	PATTERN HYPHEN				:= '-';
	PATTERN STAR					:= '*';
	PATTERN QUESTION			:= '?';
	PATTERN LSB						:= '[';
	PATTERN	COLON 				:= ':';
	PATTERN RSB						:= ']';
	PATTERN ESC						:= '\\';
	PATTERN PUNCT					:= PATTERN('[!#$%&+,.:;@^{|}~]');
	PATTERN	SP						:= [' ', '\t', '\r', '\n'];
	PATTERN	Digit					:= PATTERN('[0-9]');
	PATTERN WhiteSpace		:= SP OR APOS OR HYPHEN OR SL OR PUNCT OR LSB 
													OR RSB OR ESC OR LP OR RP OR QUOT OR SL;
	RULE WhiteSpaces			:= WhiteSpace+;

	PATTERN Alpha					:= PATTERN('[A-Za-z]');
	PATTERN zero					:= '0';
	PATTERN nonzero				:= PATTERN('[1-9]');
	PATTERN alphaNumeric	:= alpha OR digit;
	PATTERN anString			:= alphaNumeric+;
	PATTERN alphaString		:= alpha+;
	RULE WordPattern			:= anString;
	RULE kwdWPuncts				:= Equivalence.KwdWithPuncts;
	
	/* --- Equivalent patterns --- */
	STRING PERIOD := '.';
	PATTERN dquote			:= '"';
	PATTERN begsep := FIRST OR ' ' OR LP;
	PATTERN endsep := LAST OR ' ' OR RP;
	PATTERN endsepPeriod := endsep OR Period BEFORE endsep;
	// Multi & Single Equiv pattern must not be wrapped in double qoutes "" and must be preceded by a space or the first pos and followed by a space or in the last pos.
	PATTERN MultiEquiv	:= NOCASE(Text_Search.Equivalence.MultiWrdEquivalents) NOT BEFORE quot BEFORE endsepPeriod NOT AFTER quot AFTER begsep;
	PATTERN SingleEquiv	:= NOCASE(Text_Search.Equivalence.SingleWrdEquivalents) NOT BEFORE quot BEFORE endsepPeriod NOT AFTER quot AFTER begsep;

	PATTERN KwdSSN				:= PATTERN('[Ss][Ss][Nn]');
	PATTERN ssn						:= PATTERN('[[:digit:]]{9}|[[:digit:]]{3}-[[:digit:]]{2}-[[:digit:]]{4}');
	PATTERN ssnPattern		:= KwdSSN SP* LP SP* ssn SP* RP;

	RULE  Rqst_Parse_Rule := MultiEquiv OR SingleEquiv OR kwdWPuncts OR ssnPattern OR WordPattern OR WhiteSpaces;
	
	RqstTerm := RECORD
		Types.WordStr				srchArg;
		Types.WordList			terms{MAXCOUNT(Limits.Max_Wild)};			// empty if stack
		Types.NominalList 	nominals{MAXCOUNT(Limits.Max_Wild)};  // empty if stack
		Types.WordType			typ;
		Types.Freq          freq;
		Types.Freq					docFreq;
	END;
	WorkRqst := RECORD(Layout_Search_RPN_Set)
		RqstTerm term;
	END;
	RqstTerm getTerms(rqstDS l) := TRANSFORM
		STRING wd := IF(MATCHED(ssnPattern),
										StringLib.StringFilterOut(MATCHTEXT(ssnPattern/ssn), '-*?'),
										MATCHTEXT(Rqst_Parse_Rule));
		Types.WordType typ := MAP(MATCHED(ssnPattern)				=> Types.WordType.SSN, 
															MATCHED(wordPattern)			=> Types.WordType.TextStr,
															MATCHED(kwdWPuncts)				=> Types.WordType.TextStr,
															MATCHED(MultiEquiv)				=> Types.WordType.MultiEquiv,
															MATCHED(SingleEquiv)			=> Types.WordType.TextStr,
															Types.WordType.Unknown);
		Types.WordStr		fl := MATCHTEXT(Rqst_Parse_Rule);
		STRING segName := IF(MATCHED(ssnPattern), 'SSN', ' ');
		BOOLEAN useDict := typ <> Types.WordType.Unknown;
		BOOLEAN isEquiv := MATCHED(MultiEquiv) OR MATCHED(SingleEquiv);
		
		filter := Types.NominalFilter.IN_Filter;
		rgFilt := Types.DateRangeType.NoRange;
		eqvs := if (isEquiv,Equivalence.get(fl)[1]);
		numEqvs := eqvs.numWds;
		equivs  := eqvs.wds;
		list2 := Dict_Lookup2(info, kwd, wd, typ, filter, rgFilt, 
										 segName, numEqvs, equivs, docCount, wrdCount);		
		SELF.terms 		:= IF(useDict, list2.Get_Word_List, []);
		SELF.srchArg 	:= fl;
		SELF.typ		 	:= IF(useDict, list2.RevisedType, typ);
		SELF.nominals	:= IF(useDict, list2.Get_Nominal_List, []);
		SELF.freq 		:= IF(useDict, list2.Get_Term_Freq, 0);
		SELF.docFreq  := IF(useDict, list2.Get_Term_DocFreq, 0);
	END;
	t0 := PARSE(rqstDS,rqst,Rqst_Parse_Rule,getTerms(LEFT),MANY,MATCHED(ALL),MAX);
	t1 := t0(typ <> Types.WordType.Unknown AND freq > 0);
	// Conditions on strategy
	BOOLEAN SingleMed	:= COUNT(t1(freq < Med_Threshold)) = 1;
	BOOLEAN HaveLow 	:= EXISTS(t1(freq < Low_Threshold));
	BOOLEAN NoLow			:= NOT HaveLow;
	BOOLEAN EnoughMed	:= NoLow 
									AND SUM(t1(freq<High_Threshold), docFreq) > Min_Candidates; 
	UNSIGNED4	Direct_Threshold := IF(NoLow, Med_Threshold, Low_Threshold);
	BOOLEAN haveMin := (HaveLow OR SingleMed OR EnoughMed) AND
						Min_Answers < SUM(t1(freq < Direct_Threshold), docFreq);
	// Fail if there is not enough information.
	t1a:= IF(COUNT(t1) > 1 OR EVALUATE(t1[1], freq) < Limits.Max_1_Search, t1, 
					FAIL(RqstTerm, Limits.CommonSingle_Code, Limits.CommonSingle_msg));
	t2 := SORT(t1a, freq);
	directTerms 	:= t2(freq<Direct_Threshold);
	candidateTerms:= t2(freq>=Direct_Threshold);
	BOOLEAN AllBad	:= NOT EXISTS(candidateTerms(freq < Bad_Threshold));
	BOOLEAN NoBad		:= NOT EXISTS(candidateTerms(freq>= Bad_Threshold));
	rankingTerms	:= IF(EXISTS(directTerms), candidateTerms);
	pluralityTerms:= IF(NOT haveMin, candidateTerms);
	BOOLEAN AllHigh := NOT EXISTS(pluralityTerms(freq < High_Threshold));
	BOOLEAN NoHigh	:= NOT EXISTS(pluralityTerms(freq>= High_Threshold));
	
	// Make operands and Operation records
	Layout_RPN_Oprnd makeGetOprnd(RqstTerm l, Types.Stage stage) := TRANSFORM
		SELF.filterType := Types.NominalFilter.IN_Filter;
		SELF.id					:= stage;
		SELF.segList		:= ALL;
		SELF.searchArg	:= l.srchArg;
		SELF 						:= l;
		SELF 						:= [];
	END;
	Layout_RPN_Oprnd cvt2Input(Layout_Search_RPN_Set l) := TRANSFORM
		SELF.stageIn		:= l.stage;
		SELF						:= [];
	END;
	WorkRqst makeGet(RqstTerm l) := TRANSFORM
		SELF.opCode := Map_Search_Operands.code_GET;
		SELF.term 	:= l;
		SELF				:= [];
	END;
	WorkStage := RECORD
		Types.Stage stage := 0;
	END;
	WorkRqst stamp(WorkRqst l, WorkStage r) := TRANSFORM
		SELF.stage  := IF(l.stage=0, r.stage + 1, l.stage);
		SELF.inputs := IF(l.stage=0, 
										DATASET([ROW(makeGetOprnd(l.term, r.stage+1))], Layout_RPN_Oprnd), 
										l.inputs);
		SELF 				:= l;
	END;
	WorkStage	adj(WorkRqst l, WorkStage r) := TRANSFORM
		SELF.stage := IF(l.stage=0, r.stage+1, r.stage);
	END;
	WorkRqst makeMerge(Types.OpCode code, UNSIGNED1 stage,
								DATASET(Layout_RPN_Oprnd) inputs) := TRANSFORM
		SELF.opCode := code;
		SELF.stage	:= stage;
		SELF.inputs := inputs;
		SELF				:= [];
	END;
	initRow			:= ROW({0}, WorkStage);
	// low frequency terms and ranking, combined
	direct0			:= PROJECT(directTerms, makeGet(LEFT));
	directOps		:= PROCESS(direct0, initRow, stamp(LEFT,RIGHT), adj(LEFT,RIGHT));
	directInputs:= PROJECT(directOps, cvt2Input(LEFT));
	directLastIn:= MAX(directInputs, stageIn);
	directOp		:= IF(NoLow, code_ANY2, code_OR);
	directMerge	:= DATASET([ROW(makeMerge(directOp, directLastIn+1, directInputs))],
													WorkRqst);
	directGroup	:= IF(COUNT(directOps)>1, directOps & directmerge, directOps);
	directLast	:= DEDUP(directGroup, TRUE, RIGHT);
	directRow		:= PROJECT(directLast, WorkStage)[1];
	directEnd		:= IF(EXISTS(directGroup), directRow, initRow);
	rank0				:= PROJECT(rankingTerms, makeGet(LEFT));
	rankOps     := PROCESS(rank0, directEnd, stamp(LEFT,RIGHT), adj(LEFT,RIGHT));
	rankInputs	:= PROJECT(rankOps, cvt2Input(LEFT));
	rankLastIn	:= MAX(rankInputs, stageIn);
	rankMerge		:= DATASET([ROW(makeMerge(code_OR, rankLastIn+1, rankInputs))],
													WorkRqst);
	rankGroup		:= IF(COUNT(rankOps) > 1, rankOps & rankmerge, rankOps);
	rankLast		:= DEDUP(rankGroup, TRUE, RIGHT);
	rankRow			:= PROJECT(rankLast, WorkStage)[1];
	rankEnd			:= IF(EXISTS(rankGroup), rankRow, directEnd);
	andorInputs	:= PROJECT(directLast & rankLast, cvt2Input(LEFT));
	andorLastIn	:= MAX(andorInputs, stageIn);
	andorMerge	:= DATASET([ROW(makeMerge(code_ANDOR, andorLastIn+1, andorInputs))],
													WorkRqst);
	andorGroup	:= IF(COUNT(andorInputs)>1, andorMerge);
	andorLast		:= DEDUP(andorGroup, TRUE, RIGHT);
	andorRow		:= PROJECT(andorLast, WorkStage)[1];
	andorEnd		:= IF(EXISTS(andorGroup), andorRow, rankEnd);
	// Plurality group
	plural0			:= PROJECT(pluralityTerms, makeGet(LEFT));
	pluralOps		:= PROCESS(plural0, andorEnd, stamp(LEFT,RIGHT), adj(LEFT,RIGHT));
	pluralInputs:= PROJECT(pluralOps, cvt2Input(LEFT));
	pluralLastIn:= MAX(pluralInputs, stageIn);
	//pluralOp		:= IF(AllHigh, code_AND, code_ALLBUT1);
	pluralOp		:= MAP(		NoHigh	=>	code_ANY2,
												NoBad		=>	code_HALF,
												AllHigh	=>	code_AND,
												code_ALLBUT1);
	pluralMerge	:= DATASET([ROW(makeMerge(pluralOp, pluralLastIn+1, pluralInputs))],
													WorkRqst);
	pluralGroup	:= IF(COUNT(pluralOps)>1, pluralOps & pluralMerge);
	pluralLast	:= DEDUP(pluralGroup, TRUE, RIGHT);
	pluralRow		:= PROJECT(pluralLast, WorkStage)[1];
	pluralEnd		:= IF(EXISTS(pluralGroup), pluralRow, andorEnd);
	// high freqs and optional combiner, now do capstone
	finalInputs := PROJECT(andorLast & pluralLast, cvt2Input(LEFT));
	finallastIn	:= MAX(finalInputs, stageIn);
	finalMerge	:= DATASET([ROW(makeMerge(code_OR, finalLastIn+1, finalInputs))],
													WorkRqst);
	finalGroup	:= IF(COUNT(finalInputs) > 1, finalMerge);
	results			:= directGroup & rankGroup & andorGroup & pluralGroup & finalGroup;
	RETURN PROJECT(results, Layout_Search_RPN_Set);
END;
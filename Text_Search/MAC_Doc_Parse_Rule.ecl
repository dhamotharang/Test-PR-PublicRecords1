export MAC_Doc_Parse_Rule := MACRO
	vYMD(STRING x):=Text_Search.isValidDate(x, TRUE);
	vMDY(STRING x):=Text_Search.isValidDate(x, FALSE);

	PATTERN paraPattern		:= '<p>' OR '<p/>';
	PATTERN SP						:= PATTERN(' ');
	PATTERN SPS						:= SP+;
	PATTERN CM						:= ',';
	PATTERN Period				:= '.';
	PATTERN Hyphen				:= '-';
	PATTERN alpha					:= PATTERN('[A-Za-z]');
	PATTERN digit					:= PATTERN('[0-9]');
	PATTERN zero					:= '0';
	PATTERN nonzero				:= PATTERN('[1-9]');
	PATTERN alphaNumeric	:= alpha OR digit;
	PATTERN anString			:= alphaNumeric+;
	PATTERN alphaString		:= alpha+;
	PATTERN WordPattern		:= anString;
	PATTERN otherPattern	:= PATTERN('[:punct:]');
	PATTERN yyyy					:= digit digit digit digit;
	PATTERN mm						:= digit OPT(digit);
	PATTERN dd						:= digit OPT(digit);
	PATTERN dateSep				:= PATTERN('[-/]');
	PATTERN yyyymmdd			:= yyyy dateSep mm dateSep dd;
	PATTERN mmddyyyy			:= mm dateSep dd dateSep yyyy;
	PATTERN yr_mo_dy			:= VALIDATE(yyyymmdd, vYMD(MATCHTEXT));
	PATTERN mo_dy_yr			:= VALIDATE(mmddyyyy, vMDY(MATCHTEXT));
	PATTERN monthName			:= VALIDATE(alphaString, Text_Search.Date_Name.isMonth(MATCHTEXT));
	PATTERN textDate			:= monthName SPS dd cm SPS yyyy;
	PATTERN datePattern		:= yr_mo_dy OR mo_dy_yr OR textDate;
	PATTERN number				:= digit+;
	PATTERN sign					:= PATTERN('[-+]');
	PATTERN intg					:= sign? number;
	PATTERN dotNum				:= Period number;
	PATTERN hyphenNum			:= Hyphen number;
	PATTERN decimalString	:= intg dotNum*1;
	PATTERN dotNumbers		:= intg REPEAT(dotNum, 2, ANY);
	PATTERN hyphenNumbers	:= intg hyphenNum+;
	PATTERN notNum				:= number? alpha alphaNumeric*;
	PATTERN wordDtNums		:= notNum dotNum+;
	PATTERN wordHypNums		:= notNum hyphenNum+;
	PATTERN specialString	:= dotNumbers OR hyphenNumbers OR wordDtNums OR wordHypNums;
	// ssn pattern
	PATTERN nineDigits := PATTERN('[[:digit:]]{9}');
	PATTERN hyphenedSSN := PATTERN('[[:digit:]]{3}-[[:digit:]]{2}-[[:digit:]]{4}');
	PATTERN s_stop := PATTERN('(?![[:alnum:]])');
	PATTERN ssnPattern := (nineDigits | hyphenedSSN) s_stop;

	PATTERN kwdWPuncts		:= Text_Search.Equivalence.KwdWithPuncts;
	PATTERN begsep 				:= FIRST OR PATTERN('[^[:alnum:]]');
	PATTERN endsep 				:= LAST OR PATTERN('[^[:alnum:]]');
	TOKEN		MultiEquiv		:= NOCASE(Text_Search.Equivalence.MultiWrdEquivalents) AFTER begsep BEFORE endsep;
	
	RULE		Doc_Parse_Rule := ssnPattern OR datePattern OR decimalString OR specialString OR intg
															OR MultiEquiv OR kwdWPuncts OR wordPattern
															OR otherPattern OR paraPattern;

ENDMACRO;
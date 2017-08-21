IMPORT LIB_Word;
EXPORT SplitCompoundPostings := MODULE
	// Implementation with sharply reduced memory allocations
	EXPORT StringStats := RECORD
		INTEGER2 other := 0;
		INTEGER2 comma := 0;
		INTEGER2 hyphen := 0;
		INTEGER2 slash := 0;
		INTEGER2 period := 0;
		INTEGER2 space := 0;
		INTEGER2 number := 0;
		INTEGER2 alpha := 0;
		INTEGER2 percent := 0;
		INTEGER2 ampersand := 0;
		INTEGER2 trimLength:= 0;
		INTEGER2 checkedLen:= 0;
	END;
	
	// Quick pass to see what might be worthwhile looking for in the string
	DATA24  getStats(STRING _input) := BEGINC++
	#option pure
		#define XCM  1		/*COMMA  */
		#define XHY  2    /*HYPHEN */
		#define XSL  3    /*SLASH  */
		#define XPR  4    /*PERIOD */
		#define XSP  5    /*SPACE  */
		#define XNM  6    /*NUMBER */
		#define XAL  7    /*ALPHA  */
		#define XPC  8    /*PERCENT*/
		#define XAM  9    /*AMP    */
		#define LAST_CLASS XAM
		#define TRIMLEN   LAST_CLASS+1
		#define CHKLEN    LAST_CLASS+2
		#define STAT_ENTRIES CHKLEN+1
		
		const unsigned char CLASS_TAB[256] = {
			 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*00 0F*/
			 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*10 1F*/
		 XSP,  0,  0,  0,  0,XPC,XAM,  0,  0,  0,  0,  0,XCM,XHY,XPR,XSL, /*20 2F*/
		 XNM,XNM,XNM,XNM,XNM,XNM,XNM,XNM,XNM,XNM,  0,  0,  0,  0,  0,  0, /*30 3F*/
		   0,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL, /*40 4F*/
		 XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,  0,  0,  0,  0,  0, /*50 5F*/
		   0,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,	/*60 6F*/
		 XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,  0,  0,  0,  0, /*70 7F*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*80 8F*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*90 9F*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*A0 AF*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*B0 BF*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*C0 CF*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*D0 DF*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*E0 EF*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0};/*F0 FF*/
		const unsigned char *input = (const unsigned char *) _input;
		short * resp = (short *) __result; // No allocation, use area given
		for (int i=0; i < STAT_ENTRIES; i++) resp[i] = 0;
		short char_class;
		for (int i=0; i< static_cast<int64_t>(len_input); i++) {
		  char_class = CLASS_TAB[input[i]];
			resp[char_class]++;
			if (XSP!=char_class && 0!=char_class) resp[TRIMLEN]++;
		}
		resp[CHKLEN] = len_input;
		// with DATA24, no memory allocation required
		return;
	ENDC++;
	EXPORT StringStats getStringStats(STRING s) := TRANSFER(getStats(s), StringStats);

	// Map for string split
	EXPORT StrType	:= ENUM(UNSIGNED1, Text, Number, Acro, Junk, Multiple);
	EXPORT SplitData := RECORD
		INTEGER2 entries := 0;
		INTEGER2 firstPos := 0;
		INTEGER2 lastPos := 0;
		StrType  typ := StrType.Junk;		
	END;
	DATA7 getSD(STRING _input, INTEGER2 start) := BEGINC++
		typedef struct {
			short  entries;
			short  firstPos;
			short  lastPos;
			unsigned char typ;
		} SplitData;
		typedef struct {
			short tokLen;
			unsigned char typ;	  // TEXT->1, NUMBER->2, ACRO->3, JUNK->4, Multiple->5
		} TokData;
		const unsigned char TEXT = 1;
		const unsigned char NUMBER = 2;
		const unsigned char ACRO = 3;
		const unsigned char JUNK = 4;
		const unsigned char MULTI = 5;
		#define XCM  1		/*COMMA  */
		#define XHY  2    /*HYPHEN */
		#define XSL  3    /*SLASH  */
		#define XPR  4    /*PERIOD */
		#define XSP  5    /*SPACE  */
		#define XNM  6    /*NUMBER */
		#define XAL  7    /*ALPHA  */
		#define XPC  8    /*PERCENT*/
		#define XAM  9    /*AMP    */
		#define LAST_CLASS XAM
		const unsigned char CLASS_TAB[256] = {
			 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*00 0F*/
			 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*10 1F*/
		 XSP,  0,  0,  0,  0,XPC,XAM,  0,  0,  0,  0,  0,XCM,XHY,XPR,XSL, /*20 2F*/
		 XNM,XNM,XNM,XNM,XNM,XNM,XNM,XNM,XNM,XNM,  0,  0,  0,  0,  0,  0, /*30 3F*/
		   0,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL, /*40 4F*/
		 XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,  0,  0,  0,  0,  0, /*50 5F*/
		   0,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,	/*60 6F*/
		 XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,XAL,  0,  0,  0,  0, /*70 7F*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*80 8F*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*90 9F*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*A0 AF*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*B0 BF*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*C0 CF*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*D0 DF*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, /*E0 EF*/
		   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0};/*F0 FF*/
	
		short decimalString(short start, short len, const unsigned char * input) {
			if (start >= len) return 0;
			short periods = 0;
			short thisLen = 0;
			short char_class;
			for (int i=start; i<len; i++) {
				char_class = CLASS_TAB[input[i]];
				if (char_class == XAL) return 0;
				if (char_class==0 || char_class==XSP || char_class==XPC) break;
				if (input[i] == '.') periods++;
				else if (char_class != XNM) return 0;
				thisLen++;
			}
			if (periods > 1) return 0;
			return thisLen;
		}
		short alphaNumericString(short start, short len, const unsigned char * input) {
			short thisLen = 0;
			short char_class;
			for (int i=start; i<len; i++) {
				char_class = CLASS_TAB[input[i]];
				if (char_class!=XAL && char_class!=XNM) break;
				thisLen++;
			}
			return thisLen;
		}
		short whiteSpaceString(short start, short len, const unsigned char * input) {
			short thisLen = 0;
			short char_class;
			for (int i=start; i<len; i++) {
				char_class = CLASS_TAB[input[i]];
				if (char_class!=XAL && char_class!=XNM && char_class!=XHY
					&& char_class!=XPC && char_class!=XAM) thisLen++;
				else break;
			}
			return thisLen;
		}
		short acroString(short start, short len, const unsigned char * input) {
			short thisLen = 0;
			unsigned char period = true;
			short char_class;
			for (int i=start; i<len; i++) {
				char_class = CLASS_TAB[input[i]];
				if (char_class == XAL && period) period = false;
				else if (char_class == XPR && !period) period = true;
				else if (char_class==XSP) break;
				else return 0;
				thisLen++;
			}
			return (thisLen==0) ? 0 : thisLen-1;	// drop trailing period
		}
		void findTok(short start, short len, const unsigned char * input, unsigned char numerics, TokData* td) {
			td->tokLen = 1;
			td->typ = 0;
			short first_char_class = CLASS_TAB[input[start]];
			if (first_char_class == XAL) {
				td->tokLen = acroString(start, len, input);
				if (td->tokLen == 0) {
					td->tokLen = alphaNumericString(start, len, input);
					td->typ = TEXT;
				} else td->typ = ACRO;
			} else if (first_char_class == XNM) {
				if (numerics && (start==0 || CLASS_TAB[input[start-1]]==XSP)) {
					td->tokLen = decimalString(start, len, input);
				} else td->tokLen = 0;
				if (td->tokLen==0) {
					td->tokLen = alphaNumericString(start, len, input);
					td->typ = TEXT;
				} else td->typ = NUMBER;
			} else if (input[start] == '-') {
				if (start+1==len) {
					td->tokLen = 1;
					td->typ = JUNK;
				} else {
					if (numerics && (start==0 || CLASS_TAB[input[start-1]]==XSP)) {
						td->tokLen = decimalString(start+1, len, input) + 1;
					} else td->tokLen = 1;
					if (td->tokLen==1) td->typ = JUNK;
					else td->typ = NUMBER;
				}
			} else if (first_char_class==XPC || first_char_class==XAM) {
				td->tokLen = 1;
				td->typ = TEXT;
			} else {
				td->tokLen = whiteSpaceString(start, len, input);
				td->typ = JUNK;
			} 
      if(td->tokLen < 1) {   // force advance
        td->typ = JUNK;
        td->tokLen = 1;
      }
		}
	#option pure
	#body
		const unsigned char *input = (const unsigned char *) _input;
		TokData td;
		td.typ = JUNK;
		SplitData * sd = (SplitData*) __result;
		sd->entries = 0;
		short pos;
		pos = (start < 0) ? 0   : start;
		while (pos < static_cast<int64_t>(len_input) && (td.typ==JUNK || start < 0)) {
			findTok(pos, len_input, input, false, &td);
			if (td.typ != JUNK) sd->entries++;
			pos += td.tokLen;
		}
		sd->firstPos = (start < 0) ? 1  : pos - td.tokLen + 1;
		sd->lastPos = pos;
		sd->typ = (start < 0)  ? MULTI  : td.typ;
		// With DATA7, no allocation required
		return;
	ENDC++;
	EXPORT SplitData getSplit(STRING s, INTEGER2 p):= TRANSFER(getSD(s,p), SplitData);
		
	STRING YMD_pat1 := '^[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}$';
	STRING YMD_pat2 := '^[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}$';
	SHARED isYMD(STRING s) := REGEXFIND(YMD_pat1, s) OR REGEXFIND(YMD_pat2, s);
	
	STRING MDY_pat1 := '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$';
	STRING MDY_pat2 := '^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$';
	SHARED isMDY(STRING s) := REGEXFIND(MDY_pat1, s) OR REGEXFIND(MDY_pat2, s);

	dtest := isValidDate;
	SHARED isDate(STRING s) := MAP(
																LENGTH(s) < 4									=> FALSE,
																s[2] NOT BETWEEN '0' AND '9'	=> dtest(s, FALSE),
																s[3] NOT BETWEEN '0' AND '9'	=> dtest(s, FALSE),
																dtest(s, TRUE));
																
	STRING num_pat := '^-?[0-9]+[.]?[0-9]*$';
	SHARED isNumber(STRING s) := REGEXFIND(num_pat, s);
	SHARED cvt2NCF(STRING s)	:= NumericCollationFormat.StringToNCF(s);
	
	// Split and type posting records
	EXPORT DATASET(Layout_Posting) TypeAndSplit(DATASET(Layout_Posting) invFile, 
												 DATASET(Layout_Segment_ComposeDef) segDefs) := FUNCTION
		Work_Posting := RECORD(Layout_Posting)
			Types.SegmentType	 segType;
			SplitData split;
			INTEGER2 entry := 0;
			INTEGER2 entries := 0;
		END;
		Work_Posting_Equiv := RECORD(Work_Posting)
		  BOOLEAN							equivPart := FALSE;
			Equivalence.WdSet		precWds := [''];
			Equivalence.WdStr		equivWord := '';
			INTEGER6						postingSeqNum := 0;
			INTEGER1						numEquivParts := 0;
		END;
		
		Work_Posting getSegType(Layout_Posting l, Layout_Segment_ComposeDef r):=TRANSFORM
			SELF.segType := IF(r.segType<>0, r.segType, Types.SegmentType.TextType);
			SELF := l;
		END;
		withSegType := JOIN(invFile, segDefs, LEFT.segName=RIGHT.shortName,
												getSegType(LEFT, RIGHT), LEFT OUTER, LOOKUP, FEW);
		Work_Posting getCount(Work_Posting l) := TRANSFORM
			StringStats stats := getStringStats(l.word);
			isFormatDate := l.segType=Types.SegmentType.DateType 
						AND stats.trimlength BETWEEN 8 AND 10 AND stats.number = stats.trimLength-2
						AND (stats.hyphen=2 OR stats.slash=2) AND isDate(l.word);
			is8DigitDate := l.segType=Types.SegmentType.DateType 
						AND stats.number=8 AND stats.trimLength=8 
						AND TRIM(l.word) BETWEEN '19000000' AND '21000000';
			is4DigitDate := l.segType=Types.SegmentType.DateType 
						AND stats.number=4 AND stats.trimLength=4
						AND TRIM(l.word) BETWEEN '1900' AND '2100';
			isDate := is4DigitDate OR is8DigitDate OR isFormatDate;
			isNumber := l.segType=Types.SegmentType.NumericType 
						AND stats.hyphen BETWEEN 0 AND 1 
						AND stats.period BETWEEN 0 AND 1
						AND stats.period+stats.hyphen+stats.number=stats.trimLength
						AND isNumber(TRIM(l.word,LEFT,RIGHT));
			is1Word  := stats.alpha+stats.number=stats.checkedLen;
			isSSN    := l.segType=Types.SegmentType.SSN
						AND stats.number=9 AND stats.trimLength=9;
      isKeyField := l.segType=Types.SegmentType.ExternalKey;
			isFieldData := l.segType=Types.SegmentType.FieldDataType;
			checkString:= NOT is1Word AND NOT is8DigitDate AND NOT is4DigitDate 
						AND NOT isNumber AND NOT isFormatDate
						AND NOT isSSN AND NOT isKeyField AND NOT isFieldData;
						
			deformatted_date := MAP(isMDY(l.word) => (STRING) Text_Search.ConvertDate(l.word,FALSE),
															isYMD(l.word)	=> (STRING) Text_Search.ConvertDate(l.word,TRUE),
															'');
															
			SELF.split := IF(checkString, getSplit(l.word, -1));
			SELF.entries := IF(checkString, SELF.split.entries, 1);
			SELF.typ := MAP(checkString 			=> Types.WordType.TextStr,
											isDate						=> Types.WordType.Date,
											isSSN							=> Types.WordType.SSN,
											isNumber					=> Types.WordType.Numeric,
                      isKeyField        => Types.WordType.ExtKey,
											isFieldData       => Types.WordType.FieldData,
											Types.WordType.TextStr);
			SELF.word := IF(isFormatDate,deformatted_date,l.word);
			SELF.suffix := 0;
			SELF.nominal:= MAP(isNumber				=> cvt2NCF(TRIM(l.word,LEFT,RIGHT)),
												 is8DigitDate		=> (INTEGER) l.word,
												 is4DigitDate		=> ((INTEGER) l.word) * 10000,
												 isFormatDate		=> (INTEGER) deformatted_date,
                         isKeyField     => Constants.ExternalKeyNominal,
												 0);
			SELF.len := IF(isFormatDate,LENGTH(deformatted_date),l.len);
			SELF := l;
		END;
		mixedPostings := PROJECT(withSegType, getCount(LEFT));
		Work_Posting normSplit(Work_Posting l, INTEGER c) := TRANSFORM
			SELF.entry := c;
			SELF := l;
		END;

		initialMarks := NORMALIZE(mixedPostings, LEFT.entries, normSplit(LEFT, COUNTER));
		Work_Posting splitWord(Work_Posting l, Work_Posting r) := TRANSFORM
      isKeyField := r.segType=Types.SegmentType.ExternalKey;
			isSpecField := r.segType=Types.SegmentType.FieldDataType;
      split := getSplit(r.word, IF(l.entry=l.entries, 0, l.split.lastPos));
      firstPos := IF(isKeyField OR isSpecField, 1, split.firstPos);
      lastPos := IF(isKeyField OR isSpecField, LENGTH(r.word), split.lastPos);
			SELF.split := split;
			SELF.word := StringLib.StringToUpperCase(r.word[firstPos..lastPos]);
			SELF.len := LENGTH(SELF.word);
			SELF := r;		
		END;
		splitPass1 := ITERATE(DISTRIBUTED(initialMarks), splitWord(LEFT,RIGHT), LOCAL);
		
		// Add the multi equiv meta data to each posting to be used later to identify possible equivalents
    equivPass1 := JOIN(splitPass1,Equivalence.EquivSet,StringLib.StringToUpperCase(LEFT.word) = RIGHT.wd and
																				LEFT.segType != Types.SegmentType.FieldDataType AND
																				LEFT.segType != Types.SegmentType.ExternalKey,
																			 TRANSFORM(Work_Posting_Equiv,
																								 SELF.EquivPart := IF(StringLib.StringToUpperCase(LEFT.word) = RIGHT.wd,TRUE,FALSE),
																								 SELF.precWds	:= RIGHT.precWds,
																								 SELF := LEFT),LOOKUP,LEFT OUTER);
		
		Work_Posting_Equiv BuildEquiv(Work_Posting_Equiv L, Work_Posting_Equiv R, INTEGER Cnt) := TRANSFORM
		    SELF.equivWord := IF (not R.equivPart,'',
																	 IF(TRIM(L.equivWord,LEFT,RIGHT) IN R.precWds,L.equivWord + ' ' + TRIM(R.word,LEFT,RIGHT), TRIM(R.word,LEFT,RIGHT)));				
				SELF.postingSeqNum := IF(L.postingSeqNum=0,thorlib.node()+1,L.postingSeqNum+thorlib.nodes());  //Make seqnum unique per thor slave
				SELF.numEquivParts := IF (not R.equivPart,0,
																		 IF(TRIM(L.equivWord,LEFT,RIGHT) IN R.precWds,L.numEquivParts +1, 1));
				SELF := R;
		END;
		// Construct possible multi word equivalents from the posting recordset
		eqp2 := ITERATE(GROUP(DISTRIBUTED(equivPass1,docRef.doc),docRef.doc),BuildEquiv(LEFT,RIGHT,COUNTER));
    equivPass2 := UNGROUP(eqp2);

		// Peform lookup into equivalent dataset to identify and create valid equivalents. These new equivalent postings
		// will be merged into the orignal posting recordset.
		// When a match is found, the sequence number is adjusted to match the posting of the first word in the equivalent.
		 equivPass3 := JOIN(equivPass2,Equivalence.myd,LEFT.equivPart = TRUE AND RIGHT.equivType = 'M' AND
																			 TRIM(LEFT.equivWord,LEFT,RIGHT) = RIGHT.wd,
																			 TRANSFORM(Work_Posting_Equiv,
																								 SELF.word := RIGHT.wds[1],
																								 SELF.len := LENGTH(SELF.word),
																								 SELF.typ := Types.WordType.MultiEquiv;
																								 SELF.wip := LEFT.numEquivParts;
																								 SELF.split.typ := Types.WordType.MultiEquiv;
																								 SELF.postingSeqNum := LEFT.postingSeqNum - (LEFT.numEquivParts * thorlib.nodes()) + thorlib.nodes();
																								 SELF := LEFT),LOOKUP);
		
		// Merge extracted equivalents with data postings recordset.
		equivPass4 := MERGE(equivPass3,equivPass2,SORTED(postingSeqNum),LOCAL)
                : ONWARNING(1031, IGNORE);    // ignore no sort warning, data is sequenced
		
		Work_Posting checkAcroInits(Work_Posting_Equiv l) := TRANSFORM
			INTEGER acroSplits := (LENGTH(TRIM(l.word))+1)/2;
			BOOLEAN isCommonAcroInit := l.word IN Equivalence.kwdWithPuncts;
			BOOLEAN splitMe := l.split.typ=StrType.Acro AND NOT isCommonAcroInit;
			SELF.entries := IF(splitMe, acroSplits, 1);
			SELF := l;
		END;
		acroMarks := PROJECT(equivPass4, checkAcroInits(LEFT));
		Work_Posting splitAcroInit(Work_Posting l, INTEGER c) := TRANSFORM
			INTEGER4 pos := ((c-1)*2) + 1;
			SELF.word := IF(l.entries>1, l.word[pos], l.word);
			SELF := l;
		END;
		splitComplete := NORMALIZE(acroMarks, LEFT.entries, splitAcroInit(LEFT,COUNTER));
		d_inv := PROJECT(splitComplete(typ <> Types.WordType.Unknown), Layout_Posting);
		
		RETURN d_inv;
		
	END;
	
END;

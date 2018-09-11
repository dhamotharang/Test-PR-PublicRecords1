/* *******************************************************************************************************************************
PRTE2_Common.Functions
******************************************************************************************************************************* */
IMPORT STD;

EXPORT Functions := MODULE

		// These pick the first non-empty value and return it.  s1 is preferred but s2 is a backup.
		EXPORT Pick1(STRING s1,STRING s2) := IF(TRIM(s1,left,right)='',TRIM(s2),TRIM(s1));
		EXPORT Pick1Int(INTEGER s1,INTEGER s2) := IF(s1=0,s2,s1);
		EXPORT Pick1Unsign(UNSIGNED s1,UNSIGNED s2) := IF(s1=0,s2,s1);

		// appendIf functions are for taking 2-5 strings, and if they are not blank, appending them with a space/separator.
		SHARED SepIF(STRING sep, STRING s1) := IF(TRIM(s1)='','',sep+TRIM(s1));
		EXPORT appendIf(STRING s1, STRING s2, STRING sep=' ') := TRIM(IF(s1='', s2, IF(s2='',s1, TRIM(s1)+SepIF(sep,s2) )));
		EXPORT appendIf3(STRING s1, STRING s2, STRING s3) := appendIf(appendIf(s1,s2),s3);
		EXPORT appendIf4(STRING s1, STRING s2, STRING s3, STRING s4) := appendIf(appendIf3(s1,s2,s3),s4);
		EXPORT appendIf5(STRING s1, STRING s2, STRING s3, STRING s4, STRING s5) := appendIf(appendIf4(s1,s2,s3,s4),s5);

		// ------------- address related ----------------------------------------------------
		// appendIfUnit('12 Main St','2b','Suite') // will return '12 Main St Suite 2b' - it guards against '#'
		// appendIfUnit('12 Main St','2b')  // will return '12 Main St 2b'  which will clean fine.
		SHARED	UseDesig(STRING S1) := 	STD.STR.FindReplace(S1,'#',' ');
		EXPORT	appendIfUnit(STRING Addr1, STRING ustring='', STRING udesc=' ') := TRIM(IF(ustring='', Addr1, appendIf3(Addr1,UseDesig(udesc),ustring) ));
		// appendIfCSZ('ALPHARETTA','GA','30005')	// returns 'ALPHARETTA, GA 30005'
		EXPORT	appendIfCSZ(STRING s1, STRING s2, STRING s3) := appendIf(appendIf(s1,s2,', '),s3);
		// appendIfz5z4('12345','1111')	// returns '123451111'
		EXPORT	appendIfz5z4(STRING s1, STRING s2)	:= appendIf(s1,s2,'');		// empty space just merge into 1 string

		// useful for creating fake data, IP addresses and creating fake sorts of court case IDs or other similar oddball fields.
		EXPORT	appendIFDot2(STRING s1,STRING s2) := IF(TRIM(s1)<>'' AND TRIM(S2)<>'', TRIM(s1)+'.'+TRIM(s2),Pick1(s1,s2));
		EXPORT	appendIFDot4(STRING s1,STRING s2,STRING s3,STRING s4) := appendIFDot2(appendIFDot2(s1,s2),appendIFDot2(s3,s4));

		// ------------- String cleaning in other ways... ---------------------------------------
		EXPORT	STRING	UPPER(STRING S1) := STD.Str.ToUpperCase(S1);
		EXPORT	STRING	LOWER(STRING S1) := STD.Str.ToLowerCase(S1);
		EXPORT	STRING	replaceControlCharacters(string pStringIn)	:=	REGEXREPLACE('[[:cntrl:]]', pStringIn, ' ');
		EXPORT	STRING	replaceUnprintable(string pStringIn)	:=	REGEXREPLACE('[^[:print:]]', pStringIn, ' ');	

		// Not ready for prime time because we haven't gotten a way to identify suffix values.
		// Swap a string containing First,Middle,Last names - to be Last, First, Middle - 
		// if you don't know if a suffix exists, (EG: it's not in another field) -- not sure how to do this??
		EXPORT FMLSwapLFM(STRING nameFML, STRING suffix) := FUNCTION
				NameSet := STD.Str.SplitWords(nameFML,' ',FALSE);   // won't split a hyphenated last name so safe.
				SuffixExists := NameSet[COUNT(NameSet)]=suffix;
				NameCnt := IF(SuffixExists, COUNT(NameSet)-1, COUNT(NameSet));
				NewL := NameSet[NameCnt];
				NewFM := STD.Str.CombineWords(NameSet[1..NameCnt-1],' ');
				NewLFM := AppendIF(AppendIF(NewL,NewFM, ', '),suffix);
				RETURN NewLFM;
		END;
		
END;
import STD, NID, ut, Address;

/*
21 Jan 2015	Remove state expansion (FixupCO, ExpandStates);

*/

alphanum := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789&$';

Split(string s) := 
							Std.Str.SplitWords(Std.Str.CleanSpaces(Std.Str.SubstituteExcluded(s, alphanum, ' ')), ' ');

/*
varstring concatcpp(set of varstring str) := BEGINC++
//void concat(bool isAllStr, size32_t lenStr, void * str)
//#option pure
#body
	if(lenStr == 0) 
	{
		char *empty = (char *)malloc(1);
		*empty = 0;
		return empty;
	}
	char *temp = (char *)malloc(lenStr);
	memcpy(temp, str, lenStr);
	for (size32_t i = 0; i < lenStr - 1; ++i)
	{
		if (temp[i] == 0)
			temp[i] = ' ';
	}
	temp[lenStr-1] = 0;

	return temp;

ENDC++;
*/

concatds(DATASET({string word}) words) := FUNCTION
				words xcat(words L, words R) := TRANSFORM
																	self.word := L.word + ' ' + R.word;
														END;
				dsCat := ROLLUP(words, true, xcat(LEFT, RIGHT));
				return Std.Str.CleanSpaces(dsCat[1].word);
END;

varstring concatcpp(set of varstring str) := 
			IF(COUNT(str) = 0, '',
				concatds(DATASET(str, {string word})));

string FixupPunct(string s) := 
		REGEXREPLACE(', *(INC.*|CORP.*|L.+|P.+)$',
			REGEXREPLACE('\\( +\\)',
				REGEXREPLACE('""',				// repeated quotes => single quote
					REGEXREPLACE(' ([,)\':"/-])',
						REGEXREPLACE('([(#"/-]) ', 	// no spaces after parens, #, ' " -
							REGEXREPLACE('([A-Z]) \' S(\\b)',
								REGEXREPLACE('(\\$) +(\\d+)',		// concatenate leading $ sign before number
									REGEXREPLACE('(\\$\\d+) +(\\d{2})',		// concatenate decimal number
										REGEXREPLACE('(\\d*) *\\. *(\\d+)', 
											Std.Str.FindReplace(s, '&', ' AND '),
										'$1.$2'),	// fixup decimals
									'$1.$2'),
								'$1$2'),
							'$1\'S$2'),
						'$1'),
					'$1'),
				' '),
			' '),
		' $1');
			
rgxDegreesBracketed := 
 '\\((M.D.|D.M.D.|D.D.S.|D.P.M.|D.V.M.|R.N.|C.P.A.|J.D.|PH.D.|D.O.|M.S.N.)\\)$';

rgx1p := '\\b([A-Z])\\. ';
rgx2p := '\\b([A-Z])\\.([A-Z])\\.';
rgx3p := '\\b([A-Z])\\.([A-Z])\\.([A-Z])\\.';
rgx4p := '\\b([A-Z])\\.([A-Z])\\.([A-Z])\\.([A-Z])\\.';
rgx5p := '\\b([A-Z])\\.([A-Z])\\.([A-Z])\\.([A-Z])\\.([A-Z])\\.';
rgxURL := '\\b(HTTP://|)(WWW\\.)?([A-Z0-9-]+\\.)?([A-Z0-9-]+)\\.(COM|NET|ORG|EDU|INT|MIL|GOV|ARPA|BIZ|AERO|NAME|COOP|INFO|PRO|MUSEUM|TV|US|CO)\\b';

string SlamPeriods(string s) := 
FUNCTION
		s5 := IF(REGEXFIND(rgx5p, s), REGEXREPLACE(rgx5p, s, '$1$2$3$4$5'), s);
		s4 := IF(REGEXFIND(rgx4p, s5), REGEXREPLACE(rgx4p, s5, '$1$2$3$4'), s5);
		s3 := IF(REGEXFIND(rgx3p, s4), REGEXREPLACE(rgx3p, s4, '$1$2$3'), s4);
		s2 := IF(REGEXFIND(rgx2p, s3), REGEXREPLACE(rgx2p, s3, '$1$2'), s3);
		//s1 := IF(REGEXFIND(rgx1p, s2), REGEXREPLACE(rgx1p, s2, '$1 '), s3);
		s1 := STD.Str.FindReplace(s2, '.', ' ');
		//s1 := IF(REGEXFIND(rgxURL, s2), s2, 
		//				STD.Str.FindReplace(s2, ' . ', ''));

	  return s1;
END;
	
string concat(set of varstring str) := STD.Str.Cleanspaces(FixupPunct(concatcpp(str)));
string RemoveNonPrintingChars(string s) := REGEXREPLACE('([^ -~]+)',s,' ');
string EnclosingParentheses(string s) := 
					IF(s[1] = '(' and s[Length(s)]=')',s[2..Length(s)-1],s);
string QuickTrim(string s) := 
					REGEXREPLACE('[ ,+;!?_*&:#%"\'/\\\\-]+$',EnclosingParentheses(s),'');

//rgxLLC := '("?L[.,]? ?L[.,]? ?[CP][.,"]*)((?=\\s)\\s|$)';
rgxLLC := ' ("?L[.,]? ?L[.,]? ?([CP])[.,"]*)((?=\\s)\\s|$)';
rgxLTD := '("?L[.,]? ?T[.,]? ?[D][.,"]*)((?=\\s)\\s|$)';

/*FUNCTION

	t := MAP(
		REGEXFIND(rgxLLC, s) => REGEXREPLACE('"?(L)[.,]? ?(L)[.,]? ?([CP])[.,"]*((?=\\s)\\s|$)', s, '$1$2$3'),
		REGEXFIND(rgxLTD, s) => REGEXREPLACE('"?(L)[.,]? ?(T)[.,]? ?([D])[.,"]*((?=\\s)\\s|$)', s, '$1$2$3'),
		s
		);
	return t;
	
END;
*/

rgxStreet := '^[0-9]+ .+ (ROAD|RD|STREET|ST|AV|AVE|AVENUE|CIRCLE|CIR|DRIVE|DR|PLACE|PL|PATH|LANE|LN|WAY|WY)\\b';		// street address 

ConvertStreetSuffix(string s) := MAP(
		REGEXFIND('\\bRD\\b', s) => REGEXREPLACE('\\b(RD)\\b', s, 'ROAD'),
		REGEXFIND('\\b(AV|AVE)\\b', s) => REGEXREPLACE('\\b(AV|AVE)\\b', s, 'AVENUE'),
		REGEXFIND('\\bDR\\b', s) => REGEXREPLACE('\\b(DR)\\b', s, 'DRIVE'),
		REGEXFIND('\\bST\\b', s) => REGEXREPLACE('\\b(ST)\\b', s, 'STREET'),
		REGEXFIND('\\bLN\\b', s) => REGEXREPLACE('\\b(LN)\\b', s, 'LANE'),
		REGEXFIND('\\bPL\\b', s) => REGEXREPLACE('\\b(PL)\\b', s, 'PLACE'),
		REGEXFIND('\\bWY\\b', s) => REGEXREPLACE('\\b(WY)\\b', s, 'WAY'),
		REGEXFIND('\\bCIR\\b', s) => REGEXREPLACE('\\b(CIR)\\b', s, 'CIRCLE'),
		s);
ConvertDirectional(string s) := MAP(
		REGEXFIND('\\bN\\b', s) => REGEXREPLACE('\\b(N)\\b', s, 'NORTH'),
		REGEXFIND('\\bE\\b', s) => REGEXREPLACE('\\b(E)\\b', s, 'EAST'),
		REGEXFIND('\\bW\\b', s) => REGEXREPLACE('\\b(W)\\b', s, 'WEST'),
		REGEXFIND('\\bS\\b', s) => REGEXREPLACE('\\b(S)\\b', s, 'SOUTH'),
		REGEXFIND('\\bNE\\b', s) => REGEXREPLACE('\\b(NE)\\b', s, 'NORTHEAST'),
		REGEXFIND('\\bNW\\b', s) => REGEXREPLACE('\\b(NW)\\b', s, 'NORTHWEST'),
		REGEXFIND('\\bSE\\b', s) => REGEXREPLACE('\\b(SE)\\b', s, 'SOUTHEAST'),
		REGEXFIND('\\bSW\\b', s) => REGEXREPLACE('\\b(SW)\\b', s, 'SOUTHWEST'),
		s);
		
ConvertStreet(string s) := 
	IF(REGEXFIND(rgxStreet, s),
		 ConvertDirectional(ConvertStreetSuffix(s)), s);


string Standardize(string s) := TRIM(MAP(
	REGEXFIND(rgxLLC, s) => 	// L L C OR LLP
		REGEXREPLACE(rgxLLC, s, ' LL$2 '),	
	REGEXFIND('\\b(L P)$', s) => 	// L P 
		REGEXREPLACE('(L P)$', s, 'LP'),	
	REGEXFIND('\\bL\\.? ?T\\.? ?D\\.?$', s) => 		// LTD
		REGEXREPLACE('\\b(L\\.? ?T\\.? ?D\\.?)$', s, 'LTD'),	
	REGEXFIND('\\bD[ /.-]B[ /.-]A\\.?((?=\\s)\\s|$)',s) => 		// DBA 
		REGEXREPLACE('\\b(D[ /.-]B[ /.-]A\\.?((?=\\s)\\s|$))', s, 'DBA '),	
	REGEXFIND('\\b[NS]\\.?A\\.$', s) => 		// NA OR SA
		REGEXREPLACE('\\b([NS])\\.?A\\.$', s, '$1A'),
	REGEXFIND('\\bN A[,]?$', s) => 		// N A 
		REGEXREPLACE('\\b(N A)[,]?$', s, 'NA'),
	REGEXFIND('\\bP\\.? ?[ACL]\\.?((?=\\s)\\s|$)', s) => 	// PA OR PC OR PL
		REGEXREPLACE('\\b(P\\.? ?([ACL])\\.?((?=\\s)\\s|$))', s, 'P$2 '),
	REGEXFIND('\\bP\\.? ?L\\.? ?L\\.? ?C\\.?$', s) => 	// P L L C
		REGEXREPLACE('\\b(P\\.? ?L\\.? ?L\\.? ?C\\.?)$', s, 'PLLC'),
	REGEXFIND('\\bP\\.? ?L\\.? ?L\\.?$', s) => 	// P L L
		REGEXREPLACE('\\bP\\.? ?L\\.? ?L\\.?$', s, 'PLL'),
	REGEXFIND('\\b(A|L|S)\\.?C\\.?$', s) =>		// L C or S C or A C
		REGEXREPLACE('\\b(A|L|S)\\.?C\\.?$', s, '$1C'),
	REGEXFIND('\\bL\\.?[LP]\\.?$', s) => 		// LP OR LL
		REGEXREPLACE('\\bL\\.?([LP])\\.?$', s, 'L$1'),
	REGEXFIND('\\bP\\.? ?[CS]\\.? ?C\\.?$', s) => 	// PSC (Personal Services Corp) or PCC
		REGEXREPLACE('\\bP\\.? ?([CS])\\.? ?C\\.?$', s, 'P$1C'),
	REGEXFIND('\\bM\\.?D\\.?$', s) => 		// M D 
		REGEXREPLACE('\\b(M)[.]?(D)\\.?$', s, 'MD'),
	REGEXFIND('\\bD\\.?C\\.?$', s) => 		// D C 
		REGEXREPLACE('\\b(D)[.]?(C)\\.?$', s, 'DC'),
	REGEXFIND('\\bPH\\.? *D\\.?$', s) => 		// Ph D 
		REGEXREPLACE('\\b(PH\\.? *D\\.?)$', s, 'PHD'),
	REGEXFIND('\\b(COR|COR P)$', s) => 	// CORP
		REGEXREPLACE('\\b(COR|COR P)$', s, 'CORPORATION'),
	REGEXFIND('\\bTHE$', s) => 	// THE
		'THE ' + REGEXREPLACE('\\b(THE)$', s, ' '),
	s));
	
rgxEndTrust := '^(.+) (TR|TRU|TRUS|TRT)$';

string FixupCO(string s) := 
MAP(
		REGEXFIND('\\bCO[ -]OP\\b',TRIM(s)) => s,
		REGEXFIND('\\bCO$',TRIM(s)) => REGEXREPLACE('\\b(CO)$', TRIM(s), ' COMPANY'),
		REGEXFIND('\\bCO[ ,.]+(LLC|INC|LTD|CORP|LP)',TRIM(s)) => REGEXREPLACE('\\b(CO)\\b', TRIM(s), ' COMPANY '),
		REGEXFIND('\\b[A-Z]+ CO\\b',s) AND
				Address.SpecialNames.IsCountyName(REGEXFIND('\\b([A-Z]+) CO\\b',s, 1)) => s,
				//REGEXREPLACE('\\b(CO)\\b', s, ' COUNTY'),
		REGEXFIND('\\b[A-Z]+ [A-Z]+ CO\\b',s) AND
				Address.SpecialNames.IsCountyName(REGEXFIND('\\b([A-Z]+ [A-Z]+) CO\\b',s, 1)) => s,
				//REGEXREPLACE('\\b(CO)\\b', s, ' COUNTY'), too risky to use county
		REGEXFIND('\\bSTATE OF CO\\b',s) =>
				REGEXREPLACE('\\b(CO)\\b', s, ' COLORADO'),
		REGEXFIND('\\bCO\\b', s) => REGEXREPLACE('\\b(CO)\\b', s, ' COMPANY'),
		s
		);
	
// remove dates/slices at end of line
rgxDate := '(\\(\\d{1,2}[/-]\\d{1,2}[/-]\\d{2,4}\\))$';
rgxSlice := '(\\(\\d{1,2}/\\d{1,2}\\))';
string RemoveNumerics(string s) := MAP(
					REGEXFIND(rgxDate, TRIM(s)) => REGEXREPLACE(rgxDate,TRIM(s),' '),
					REGEXFIND(rgxSlice, s) => REGEXREPLACE(rgxSlice,s,' '),
					s);		

rgxFirm := '^([A-Z]+)[, ]+([A-Z]+) *(&| AND ) *([A-Z]+)[.,/\\\']?$';

StandardFirmName(string s) := 
			REGEXFIND(rgxFirm, s, 1) + ' ' + REGEXFIND(rgxFirm, s, 2) + ' & ' + REGEXFIND(rgxFirm, s, 4);	
		
string OtherFixes2(string s) := MAP(
					REGEXFIND('^ET AL\\b', s) => s,
					REGEXFIND('\\bET AL\\b', s) => REGEXREPLACE('\\b(ET AL)\\b', s, ' '),
					REGEXFIND(rgxDate, TRIM(s)) => REGEXREPLACE(rgxDate,TRIM(s),' '),
					REGEXFIND(rgxSlice, s) => REGEXREPLACE(rgxSlice,s,' '),
					REGEXFIND(rgxFirm, TRIM(s)) => StandardFirmName(TRIM(s)),
					REGEXFIND('^DBA\\b', TRIM(s)) => REGEXREPLACE('^(DBA)\\b',s,' '),
					s);
					
	
string OtherFixes1(string s) := OtherFixes2(MAP(
					REGEXFIND('\\bFIN\'L',s) => REGEXREPLACE('\\b(FIN\'L)', s, 'FINANCIAL'),
					REGEXFIND('\\bNAT\'L',s) => REGEXREPLACE('\\b(NAT\'L)', s, 'NATIONAL'),
					REGEXFIND('\\b(V F W)\\b',s) => REGEXREPLACE('\\b(V F W)\\b', s, 'VETERANS OF FOREIGN WARS'),
					REGEXFIND('\\b(D O T)\\b',s) => REGEXREPLACE('\\b(D O T)\\b', s, 'DEPARTMENT OF TRANSPORTATION'),
					REGEXFIND('\\b(S & L)\\b',s) => REGEXREPLACE('\\b(S & L)\\b', s, 'SAVINGS & LOAN'),
					REGEXFIND('\\b(U S A)\\b',s) => REGEXREPLACE('\\b(U S A)\\b', s, 'USA'),
					REGEXFIND('\\b(F S B)\\b',s) => REGEXREPLACE('\\b(F S B)\\b', s, 'FSB'),
					REGEXFIND('\\b(H O A)\\b',s) => REGEXREPLACE('\\b(H O A)\\b', s, 'H O A'),
					REGEXFIND('\\b(T N T)\\b',s) => REGEXREPLACE('\\b(T N T)\\b', s, 'TNT'),
					REGEXFIND('\\b(S G S)\\b',s) => REGEXREPLACE('\\b(S G S)\\b', s, 'SGS'),
					REGEXFIND('\\b(BK *& *TR)\\b',s) => REGEXREPLACE('\\b(BK *& *TR)\\b', s, 'BANK & TRUST'),
					REGEXFIND('\\b(BANK *& *TR)\\b',s) => REGEXREPLACE('\\b(BANK *& *TR)\\b', s, 'BANK & TRUST'),
					REGEXFIND('\\b(AS (TRUSTEE|AGENT|ADMINISTRATIVE LENDER))\\b',s) => REGEXREPLACE('\\b(AS (TRUSTEE|AGENT|ADMINISTRATIVE LENDER))\\b', s, ' '),
					REGEXFIND(rgxEndTrust,s) => REGEXREPLACE(rgxEndTrust, s, '$1 TRUST'),
				s));
				
string FixLeading0(string s) := IF(REGEXFIND('^0[A-Z]+',s), 'O' + s[2..],s);

rgxCareOf := '(C/O)\\b';
string RemoveCareOfAttn(string s) := MAP(
						REGEXFIND('^'+rgxCareOf, s) => REGEXREPLACE('^'+rgxCareOf, s, ''),	// C/O name,
						REGEXFIND('\\b'+rgxCareOf, s) => s[1..Std.Str.Find(s,'C/O', 1)-1],	// name C/O other name,
						REGEXFIND('.+ %', s) => s[1..Std.Str.Find(s,'%', 1)-1],	// name % other name,
						REGEXFIND('^(CO-ATTN)\\b', s) => REGEXREPLACE('^(CO-ATTN)\\b', s, ''),	// CO-ATTN name,
						REGEXFIND('^(ATTN)\\b', s) => REGEXREPLACE('^(ATTN)\\b', s, ''),	// ATTN name,
						REGEXFIND('\\b(ATTN)\\b', s) => s[1..Std.Str.Find(s,'ATTN', 1)-1],	// name ATTN other name,
						REGEXFIND('^(ATTENTION)\\b', s) => REGEXREPLACE('^(ATTENTION)\\b', s, ''),	// ATTENTION name,
				s);

				
string OtherFixes(string s) := FixupCO(OtherFixes1(RemoveCareOfAttn(RemoveCareOfAttn(FixLeading0(TRIM(s))))));

Layout_Dict := RECORD
	string32 	name  => 
	string32 	value := '';
END;	
	
string lookupWord(Dictionary(Layout_Dict) lookupTable, string s) :=
		TRIM(IF(s in lookupTable,
				lookupTable[s].value,
				s));
				
string ReplaceSingleWord(Dictionary(Layout_Dict) lookupTable, string s) := FUNCTION
	words := Split(s);
	dsWords := DATASET(words, {string word});
	dsFixed := PROJECT(dsWords, TRANSFORM({string word},
			self.Word := lookupWord(lookupTable, left.word);));

	return IF(COUNT(dsFixed)=0,'', concat(SET(dsFixed,word)));
	
END;

//string ReplaceDoubleWord(dataset(Nid.Layout_NameValue) lookupTable, string s) := FUNCTION
//	return ScanWordPairs(lookupTable, s);
//END;

string FixSpelling(string s) := FUNCTION
		
	return ReplaceSingleWord(Nid.MisspellTable, s);
END;

string ExpandStates(string s) := s;

/*FUNCTION
	words := Split(s);
	dsWords := DATASET(words, {string word});
	dsFixed := PROJECT(dsWords, TRANSFORM({string word},
			self.Word := Nid.StateAbbreviations.ExpandStateName(left.word);));

	return IF(COUNT(dsFixed)=0,'', concat(SET(dsFixed,word)));
		
END;
*/

rgxGeoOf := '^(.+) (CITY|STATE|COUNTY|COMMONWEALTH|TOWN|DISTRICT) OF$';

string FinalTouch(string s) := 
				STD.Str.FindReplace(
					STD.Str.FindReplace(s, ' . ', ' '),
				' .,', ',');
				
string clnBizName2(string s) := FUNCTION

	preClean := Std.Str.CleanSpaces(ConvertStreet(QuickTrim(SlamPeriods(Standardize(
												TRIM(OtherFixes(Std.Str.ToUpperCase(RemoveNonPrintingChars(s)))))))));
	
	s_corrected_names 	:= MAP(
			LargePropertyOwners.IsLargePropertyOwner(preClean) => LargePropertyOwners.LargePropertyOwner(preclean),
			REGEXFIND(rgxGeoOf, preClean) => TrimPunct(ExpandStates(REGEXREPLACE(rgxGeoOf, preClean, '$2 OF $1'))),
			TrimPunct(ExpandStates(FixSpelling(preClean)))
			);

	return FinalTouch(s_corrected_names);
	
END;

EXPORT string clnBizName(string s) :=
		if (REGEXFIND(rgxURL, s, nocase), s,			// do not clean URLs
					clnBizName2(s));


//operating as (abbreviated o/a) or trading as (abbreviated T/A)

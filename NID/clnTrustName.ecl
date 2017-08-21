
rgxTrustees := '\\b(TRUSTEE|TRUSTE|TTEE|TTEES|TRS|TRSTE|TRSTES|TRSTEE|TRU|TTE|TE|TR|LESSEE)\\b';

string RemoveTrustee(string s) := REGEXREPLACE('\\(\\)',REGEXREPLACE(rgxTrustees, s, ''),'');

string OtherWords(string s) := MAP(
					REGEXFIND('\\bFAM\\b', s) => REGEXREPLACE('\\b(FAM)\\b', s, 'FAMILY'),
					s);

string OtherFixup(string s) := TrimPunct(RemoveTrustee(OtherWords(s)));

string FixupTrust(string s) := MAP(
					REGEXFIND('\\bREV T\\b', s) => REGEXREPLACE('\\b(REV T)\\b', s, 'REVOCABLE TRUST'),
					REGEXFIND('\\bREV LIV TR\\b', s) => REGEXREPLACE('\\b(REV LIV TR)\\b', s, 'REVOCABLE LIVING TRUST'),
					REGEXFIND('\\bREV LIV\\b', s) => REGEXREPLACE('\\b(REV LIV)\\b', s, 'REVOCABLE LIVING'),
					REGEXFIND('\\bREV TR\\b', s) => REGEXREPLACE('\\b(REV TR)\\b', s, 'REVOCABLE TRUST'),
					REGEXFIND('\\bREV\\b', s) => REGEXREPLACE('\\b(REV)\\b', s, 'REVOCABLE'),
					REGEXFIND('\\bREVOC\\b', s) => REGEXREPLACE('\\b(REVOC)\\b', s, 'REVOCABLE'),
					REGEXFIND('\\bREVOCA\\b', s) => REGEXREPLACE('\\b(REVOCA)\\b', s, 'REVOCABLE'),
					REGEXFIND('\\bRVCBL\\b', s) => REGEXREPLACE('\\b(RVCBL)\\b', s, 'REVOCABLE'),
					REGEXFIND('\\bRVCBLE\\b', s) => REGEXREPLACE('\\b(RVCBLE)\\b', s, 'REVOCABLE'),
					REGEXFIND('\\bRT\\b', s) => REGEXREPLACE('\\b(RT)\\b', s, 'REVOCABLE TRUST'),
					REGEXFIND('\\bRV LV\\b', s) => REGEXREPLACE('\\b(RV LV)\\b', s, 'REVOCABLE LIVING'),
					REGEXFIND('\\bLVG\\b', s) => REGEXREPLACE('\\b(LVG)\\b', s, 'LIVING'),
					REGEXFIND('\\bLIV T\\b', s) => REGEXREPLACE('\\b(LIV T)\\b', s, 'LIVING TRUST'),
					REGEXFIND('\\bLIV\\b', s) => REGEXREPLACE('\\b(LIV)\\b', s, 'LIVING'),
					REGEXFIND('\\bTR\\b', s) => REGEXREPLACE('\\b(TR)\\b', s, 'TRUST'),
					REGEXFIND('\\bTRU\\b', s) => REGEXREPLACE('\\b(TRU)\\b', s, 'TRUST'),
					REGEXFIND('\\bTRUS\\b', s) => REGEXREPLACE('\\b(TRUS)\\b', s, 'TRUST'),
					REGEXFIND('\\bEST\\b', s) => REGEXREPLACE('\\b(EST)\\b', s, 'ESTATE'),
					REGEXFIND('\\bFAM\\b', s) => REGEXREPLACE('\\b(FAM)\\b', s, 'FAMILY'),
					s);

// remove dates/slices at end of line
rgxDate := '(\\(?\\d{1,2}[/-]\\d{1,2}[/-]\\d{2,4}\\)?)';
//rgxDated := '\\(?(DATED|DTD|UTD) +\\d{1,2}[/-]\\d{1,2}[/-]\\d{2,4}\\)?';
rgxDated := '\\(?(DATED|DTD|UTD) +\\d{1,2}[/-] *\\d{1,2} *[/-] *\\d{2,4}\\)?';
rgxSlice := '(\\(\\d{1,2}/\\d{1,2}\\))$';
string RemoveDates(string s) := MAP(
					REGEXFIND(rgxDated, s) => REGEXREPLACE(rgxDated,s,' '),
					REGEXFIND(rgxDate, s) => REGEXREPLACE(rgxDate,s,' '),
					REGEXFIND(rgxSlice, s) => REGEXREPLACE(rgxSlice,s,' '),
					s);
string EnclosingParentheses(string s) := 
					IF(s[1] = '(' and s[Length(s)]=')',s[2..Length(s)-1],s);


EXPORT string clnTrustName(string s) := 
				OtherFixup(FixupTrust(FixupTrust(clnBizName(RemoveDates(EnclosingParentheses(TRIM(s)))))));

export NameCleaner := MODULE

import STD, lib_stringlib, Nid;

/****

ECL based NAME CLEANER
May be used as a direct replacement for the name cleaning servers

FOR EVALUATION ONLY
Please send any comments to Charles Salvo

exported functions:
export string73 CleanPerson73(string name)
export string73 CleanPersonFML73(string name) 
export string73 CleanPersonFML73(string name) 
export string140 CleanDualName140(string dualname)

NEW FUNCTION
export string73 CleanPersonParsed73(string fname, string mname, string lname, string suffix)


****/

/*
		cln_title		:= [1..5];
		cln_fname		:= [6..25];
		cln_mname		:= [26..45];
		cln_lname		:= [46..65];
		cln_suffix	    := [66..70];
		name_score		:= [71..73];
*/                                                                                                                       

TrustWords := Nid.Trusts.TrustWords;                                                                                                               

set of string Trust2Words := ['CHARITABLE REMAINDER','COUNTY TAX',
							'IRREVOCABLE GST','IRREVOCABLE LIVING','INTER VIVOS','JOINT LIVING',
							'FAMILY LIVING', 'FAMILY PROTECTIVE','FAMILY PROTECTION', 'FAMILY REVOCABLE','LF EST','LIFE ESTATE',
							'LIFE TENANT', 'LIVING FAMILY',
							'LIVING SURVIVORS','LIVING WILL','REVOCABLE LIVING','REV LIVING','REV LIV','REVOC LIV','REVOC LVG',
									'LVG REV', 'LIVING REVOCABLE',
									'NONEXEMPT DESCENDANTS','NONEXEMPT FAMILY','NONEXEMPT LIFETIME', 'NONEXEMPT MARITAL',
									'REAL ESTATE',
									'SEPARATE PROPERTY','SPECIAL NEEDS','SUPP NEEDS'];

/*
new cases
OMORI YURIKO L TRUSTEE OF Y L OMORI 1993 FAMILY TRUST     (include date 1993)                                                                                            


*/

TrustAbbreviations := '(TRUST|TRUS|TRU|TRST|TR|TST|TRUSTS|TST|TRS)';
MaritalTrusts := '\\b(TRUST (A|B|I|II|1|2|3|4|5|6|7|8|9))\\b';
TrustTypes := '(CT|LT|NT|PT|RT)';
TrustTypesEX := '\\b(TRUST|TRUS|TRU|TRST|TR|TST|TRUSTS|TR UST|CT|LT|NT|PT|RT)\\b';
TrustMissing := '\\b(IR)?(REVOCABLE|REVOCABL|REVOCAB|REVOCA|REVOC|REV T|REV|LIVING WILL)$';		// TRUST TYPE CUT OFF
RunOnTrust := '\\b((FAMILY|LIVING)TRUST)\\b';
rgxDate := '(\\(?\\d{1,2}[/-]\\d{1,2}[/-]\\d{2,4}\\)?)';
rgxDated := '\\(?(DATED|DTD|UTD) +\\d{1,2}[/-] *\\d{1,2} *[/-] *\\d{2,4}\\)?';
rgxMisc := '\\b(TRUST +(& PT|(1|2|3|4|5) PT|COC|ETAL|ET AL|DTD|/TR|\\(?TR\\)?)|\\(?TRUSTEES\\)?)$';
rgxDateAbbr := '\\b(DATED|DTD|UTD)\\b';
rgxRevLiving := '\\b(REVOCABLE|REVOCABL|REVOCAB|REVOCA|REVOC|REV)( (LIVING|LIVI|LIVIN|LIV|LI|L|T))?$';

rgxSlice := '(\\(\\d{1,2}/\\d{1,2}\\))$';
string RemoveDates(string s) := TRIM(MAP(
					REGEXFIND(rgxDated, s) => REGEXREPLACE(rgxDated,s,' '),
					REGEXFIND(rgxDate, s) => REGEXREPLACE(rgxDate,s,' '),
					REGEXFIND(rgxSlice, s) => REGEXREPLACE(rgxSlice,s,' '),
					REGEXFIND(rgxDateAbbr, s) => REGEXREPLACE(rgxDateAbbr,s,' '),
					s),LEFT,RIGHT);
					
string RemoveThe(string s) :=  TRIM(MAP(
					REGEXFIND('^(THE)\\b', s) => REGEXREPLACE('^(THE)\\b',s,' '),
					REGEXFIND('(, *THE)$', s) => REGEXREPLACE('(, *THE)$',s,' '),
					REGEXFIND('\\b(THE)$', s) => REGEXREPLACE('\\b(THE)$',s,' '),
					s),LEFT,RIGHT);

rgxPunct := '[ (),+!?_*&:#%"\'/\\\\-]+';		//  (),+;!?_*&:#%"'/\-
string QuickTrim(string s) := 
			REGEXREPLACE(rgxPunct+'$',s,'');	
			
rgxEstate := '\\b((LIFE |TRUST )?ESTATE)\\)?$';
string RemoveEstate(string s) := IF(REGEXFIND(rgxEstate, s), QuickTrim(REGEXREPLACE(rgxEstate, s, '')), s);

string StripTrust(string s, integer n) :=
		TRIM(REGEXREPLACE('^THE +(.+)',
			case(n,
				1 => REGEXREPLACE('\\b'+TrustAbbreviations+'$', s, ''),
				2 => REGEXREPLACE('\\b([A-Z]+ +'+TrustAbbreviations+')\\b', s, ''),	// TRUST WORD + Trust
				3 => REGEXREPLACE('\\b('+TrustAbbreviations+' +[A-Z]+)$', s, ''),
				4 => REGEXREPLACE('\\b([A-Z]+ +[A-Z]+ +'+TrustAbbreviations+')\\b', s, ''),
				5 => REGEXREPLACE('\\b((FAMILY|LEGACY|LIVING)? +[0-9]{4} +'+TrustAbbreviations+')', s, ''),
				6 => REGEXREPLACE('\\b('+TrustAbbreviations + '[, ]+' + TrustTypes+')$', s, ''),
				7 => REGEXREPLACE('\\b'+TrustTypes+'$', s, ''),
				8 => REGEXREPLACE(TrustMissing, s, ''),
				9 => REGEXREPLACE(MaritalTrusts, s, ''),
				10 => REGEXREPLACE(RunOnTrust, s, ''),
				101 => REGEXREPLACE(rgxMisc, s, ''),
				11 => REGEXREPLACE('^'+TrustAbbreviations, s, ''),
				s),
			'$1'));
			
			
 rgxMispelledTrust := ' (TRU ST|TRUS, T|TR, UST)$';
 CheckMispelledTrust(string s) := IF(REGEXFIND(rgxMispelledTrust, s), REGEXREPLACE(rgxMispelledTrust, s, ' TRUST'), s);
 string RemoveStutter(string s) := IF(REGEXFIND('\\bTRUST +TRUST\\b',s), REGEXREPLACE('\\bTRUST( +TRUST)\\b', s, ''), s);

export string RemoveTrust(string s1) := FUNCTION
	s := 		RemoveStutter(RemoveEstate(CheckMispelledTrust(RemoveThe(RemoveDates(QuickTrim(s1))))));

	t :=
		IF(REGEXFIND(TrustTypesEX, s),
			MAP(
				REGEXFIND('\\b([A-Z]+ +[A-Z]+) +'+TrustAbbreviations + '\\b', s, 1) in Trust2Words => StripTrust(s, 4),
				REGEXFIND('\\bSECOND +([A-Z]+) +'+TrustAbbreviations + '\\b', s, 1) in TrustWords => 
																			StripTrust(Std.Str.FindReplace(s, 'SECOND', ''), 2),
				REGEXFIND('\\b([A-Z]+) +'+TrustAbbreviations + '\\b', s, 1) in TrustWords => StripTrust(s, 2),
				REGEXFIND('\\b'+TrustAbbreviations+' +([A-Z]+)$', s, 1) in TrustWords => StripTrust(s, 3),
				REGEXFIND('\\b[0-9]{4} +'+TrustAbbreviations+'\\b', s, 1) in TrustWords => StripTrust(s, 5),
				REGEXFIND(rgxMisc, s) => StripTrust(s, 101),
				REGEXFIND('\\b'+TrustAbbreviations+'$', s) => StripTrust(s, 1),
				REGEXFIND('\\b'+TrustAbbreviations+'[, ]+'+TrustTypes+'$', s, 1) in TrustWords => StripTrust(s, 6),
				REGEXFIND('\\b'+TrustTypes+'$', s) => StripTrust(s, 7),
				REGEXFIND(TrustMissing, s) => StripTrust(s, 8),
				REGEXFIND(MaritalTrusts, s) => StripTrust(s, 9),
				REGEXFIND(RunOnTrust, s) => StripTrust(s, 10),
				REGEXFIND('^'+TrustAbbreviations, s) => TRIM(StripTrust(s, 11),LEFT,RIGHT),
				s
				),
			MAP(
				REGEXFIND(TrustMissing, s) => StripTrust(s, 8),
				REGEXFIND(rgxRevLiving, s) => REGEXREPLACE(rgxRevLiving, s, ''),
				s));
	return MAP(
			REGEXFIND('^'+TrustAbbreviations, t) => TRIM(StripTrust(t, 11),LEFT,RIGHT),
			REGEXFIND('\\b'+TrustAbbreviations+'[ ,;()-]+$', t) => TRIM(REGEXREPLACE('\\b'+TrustAbbreviations+'[ ,;()-]+$', t, ''),LEFT,RIGHT),
			REGEXFIND('\\b'+TrustAbbreviations+'\\b', t) => TRIM(REGEXREPLACE('\\b'+TrustAbbreviations+'\\b', t, ''),LEFT,RIGHT),
		t);
END;

shared string73 BuildName(string5 title, string20 fname, string20 mname, string20 lname, string5 suffix, integer2 score=85) :=
	title+fname+mname+lname+suffix+Intformat(score,3,1);


shared string73 NotAName := BuildName('','','','','',0);


shared integer2 NameScore(string name, integer fmt) := 99;

shared string removewhitespace(string s) := STD.Str.CleanSpaces(s);

HasBizWord(string s) := FUNCTION
		w := Std.Str.SplitWords(s, ' ');
		return Address.NameTester.IsBusinessWord(w[1]) OR 
						Address.NameTester.IsBusinessWord(w[2]) OR
						Address.NameTester.IsBusinessWord(w[3]) OR
						Address.NameTester.IsBusinessPhrase(w[1]+' '+w[2]) OR
						Address.NameTester.IsBusinessPhrase(w[2]+' '+w[3]) 
						;
END;

shared boolean IsBusiness(string s) := Address.SpecialNames.IsKnownBusiness(s) OR
																					Address.Business.MatchPattern(s) OR HasBizWord(s);

string70 GetName(string s, integer n, string t, string1 hint='U') := (string5)Persons.Title(s, n, 'U', t) +
							Persons.FormatName(s, n, hint)[6..];
string70 GetName1(string s, integer n, string t, string1 hint='U') := (string5)Persons.Title1(s, n, 'U', t) +
							Persons.FormatName1(s, n, hint)[6..];
string70 GetName2(string s, integer n, string t, string1 hint='U') := (string5)Persons.Title2(s, n, t) +
							Persons.FormatName2(s, n)[6..];
							
export string140 CleanNameEx(string name, string1 hint='U', boolean bSkipTrust = false, string1 nmtype='') := FUNCTION
	t := TRIM(StringLib.StringToUpperCase(NameTester.RemoveNonPrintingChars(name)),LEFT,RIGHT);
	t1 := IF(bSkipTrust,RemoveTrust(t), t);
	s := PrecleanName(t1);
	nametype := nmtype;	//IF(nmtype='T', Address.Business.GetNameType(s), nmtype); 
	n := Persons.PersonalNameFormat(s);
	quality := CASE(nmtype,
								'P' => 'YES',
								'D' => 'DUL',
								'' => if(Persons.IsNameFormatDual(n), 'DUL', 'MAY'),	//validPersonNameFormat
								'T' => IF(IsBusiness(s) Or Nid.Trusts.IsKnownTrust(t), 'NO', Persons.NameQualityText(s)),
								'NO');

	return MAP(
		nametype in ['B','I','U'] => '',
		Persons.validPersonNameFormat(n) and quality in ['YES','MAY'] =>
				GetName(s, n, t, hint),
		//Persons.IsNameFormatDual(n) =>
		quality = 'DUL' AND Persons.ValidDualName(s, n) =>
				GetName1(s, n, t) + GetName2(s, n, t),
			''
		);

End;

export string73 CleanPerson73(string name, string1 hint='U') := FUNCTION
	return (string70)CleanNameEx(name, hint) + '   ';
END;

export string PersonNameFormat(string name) := FUNCTION
	s := PrecleanName(name);
	n := Persons.PersonalNameFormat(s);

	RETURN IF(n=0,'***',Persons.WhichFormat(n));
END;
		
END;


/*
	Special Trust processing
	
*/
import STD;
EXPORT Trusts := MODULE

export set of string TrustWords := ['AGREEMENT','ANNUITY','ANTI',
	'ASSIGNEE','AWARD','BANKERS','BENEFIT','BLIND','BOAT','BOOK','BYPASS','CAPITAL',
	'CHARITY','CHARITABLE','CHILDREN','CHILDRENS','CIVIC','CREDIT',
	'DECD','DECEDENTS','DEDUCTION','DESCENDANTS','DEV','DEVELOPMENT','DISCLAIMED','DISCRETIONARY','DR',
	'ENDOWMENT','ESTATE','EXCHANGE','EXEMPT','EXEMPTION',
	'FAM','FMLY','FAMILY','FAMILYE','FARM','GENERAL','GENERATIONAL','GRANDCHILDREN','GRANDCHILDRENS','GRANTOR','GRANTORS',
	'HERITAGE','HOLDING','HOLDINGS','HOMESTEAD','HOUSING',
	'IN','INCOME','INDENTURE','INHERITANCE','INTER VIVOS','INTERVIVOS','INVESTMENT','INVSTM','IRREV','IRREVOCABL',
	'IRREVOCABLE','IV','JD', 'JOINT','LAND','LEASE','LEGACY','LIFE','LIFETIME',
	'LIV','LIVING','LIVG','LIVN','LVG','LVNG','LOAN','LOVING','MARITAL','MASTER','MD','MS',
	'NEEDS','NONEXEMPT','PENSION','PROPERTY','PROTECTION','PROTECTIVE','PROXY','QUALIFIED','REMAINDER',
	'RE','RESIDENCE','RESIDUARY','RESTATED','REV','REVOC','REVOCABLE','REVOCABL','RVC','RVCBLE','REVOCALBE','SECOND',
	'STATUTORY','SUCCESSOR','SUCC','SUPPLEMENTAL','SURVIVING','SURVIVOR','SURVIVORS','TESTAMENTARY','TESTAMENTORY','THIRD','TRUST','VIVOS','VOLUNTARY',
	// common geo terms
	'AVE','AVENUE','CIRCLE','RD', 'ROAD', 'ST', 'STREET','WAY'
	];
	
export set of string Trust2Words := ['CHARITABLE REMAINDER','COUNTY TAX',
							'IRREVOCABLE GST','IRREVOCABLE LIVING','INTER VIVOS','JOINT LIVING',
							'FAMILY LIVING', 'FAMILY PROTECTIVE','FAMILY PROTECTION', 'FAMILY REVOCABLE','LF EST','LIFE ESTATE',
							'LIFE TENANT', 'LIVING FAMILY',
							'LIVING SURVIVORS','LIVING WILL','REVOCABLE LIVING','REV LIVING','REV LIV','REVOC LIV','REVOC LVG',
									'LVG REV', 'LIVING REVOCABLE',
									'NONEXEMPT DESCENDANTS','NONEXEMPT FAMILY','NONEXEMPT LIFETIME', 'NONEXEMPT MARITAL',
									'REAL ESTATE',
									'SEPARATE PROPERTY','SPECIAL NEEDS','SUPP NEEDS'];
	

export set of string BusTrustWords := ['BANKERS','HOLDING','LAND','NATIONAL', 'INVESTMENT'];

export string rgxTrustAbbreviations := '(TRUST|TRUS|TRU|TRST|TR|TST|TRUSTS|TST|TRS)';
export set of string TrustAbbreviations := ['TRUST','TRUS','TRU','TRST','TR','TST','TRUSTS','TST','TRS'];

rgxMispelledTrust := ' (TRU ST|TRUS, T|TR, UST)$';
export CheckMispelledTrust(string s) := IF(REGEXFIND(rgxMispelledTrust, s), REGEXREPLACE(rgxMispelledTrust, s, ' TRUST'), s);

shared rgxTrust2Begin := '^(\\w+)[.() ]+' + rgxTrustAbbreviations + '\\s+(.+)$';
//shared rgxTrust2End := '^(.+)[ ]+(\\w+)[.() ]+' + rgxTrustAbbreviations + '[/()0-9]*$';
shared rgxTrust2End := '^(.+)[ (]+(\\w+)[.) ]+' + rgxTrustAbbreviations + '[ .#/()0-9]*$';

export IsTrustWord(string rgx, string s, integer w1) :=
				REGEXFIND(rgx, s, w1) IN TrustWords;				

export IsTrust2BeginOrEnd(string s) := FUNCTION
		t := CheckMispelledTrust(s);
		return IsTrustWord(rgxTrust2Begin, t, 1)
			OR		IsTrustWord(rgxTrust2End, t, 2);
END;

export boolean LikelyTrust(string s) := 
	REGEXFIND('([A-Z]+) +(TRUST(S)?|TRUS|TRU|TRST|TR|T, RUST|TR, UST|TRU, ST|TRUS, T|TRU ST|(IR)?REVOCABLE LIVING)$', s, 1) in TrustWords
	OR REGEXFIND('\\b(REVOCABLE|REVOCABL|REVOCAB|REVOCA|REVOC|REV)( (LIVING|LIVI|LIVIN|LIV|LI|L|T))?$',s)
	OR IsTrust2BeginOrEnd(s);

					
// strips two word trusts from beginning or end
export StripTrust2Words(string s) := FUNCTION
		t := CheckMispelledTrust(s);
		return MAP(
			IsTrustWord(rgxTrust2Begin, t, 1) => REGEXFIND(rgxTrust2Begin, t, 3),
			IsTrustWord(rgxTrust2End, t, 2) => REGEXFIND(rgxTrust2End, t, 1),
			t
		);
END;



KnownTrusts := [
'KHI POST-CONSUMMATION TRUST',                                                     
'LEHMAN BROTHERS TRUST',                                                           
'MORGAN STANLEY TRUST',
'MERRYL LYNCH TRUST',
'PROTIUM MASTER GRANTOR TRUST',                                                    
'PROTIUM MASTER GRANTOR TRUST,',                                                    
'SABINE ROYALTY TRUST',                                                            
'USA IN TRUST-QUINAULT NATION'                                                    
];

export IsKnownTrust(string s) := s in KnownTrusts OR Std.Str.StartsWith(s, 'USA IN TRUST');

/***
	remove trust to extract names
***/
//TrustAbbreviations := '(TRUST|TRUS|TRU|TRST|TR|TST|TRUSTS|TST|TRS)';
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

rgxEstate := '\\b(((LIFE |TRUST )?ESTATE)|ESTATE-OF|ESTATE OF)\\)?$';
rgxEstate1 := '^(ESTATE-OF|ESTATE OF)\\b';
string RemoveEstate(string s) := MAP(
						REGEXFIND(rgxEstate, s) => QuickTrim(REGEXREPLACE(rgxEstate, s, '')),
						REGEXFIND(rgxEstate1, s) => QuickTrim(REGEXREPLACE(rgxEstate1, s, '')),
						s);

string StripTrust(string s, integer n) :=
		TRIM(REGEXREPLACE('^THE +(.+)',
			case(n,
				1 => REGEXREPLACE('\\b'+rgxTrustAbbreviations+'$', s, ''),
				2 => REGEXREPLACE('\\b([A-Z]+ +'+rgxTrustAbbreviations+')\\b', s, ''),	// TRUST WORD + Trust
				3 => REGEXREPLACE('\\b('+rgxTrustAbbreviations+' +[A-Z]+)$', s, ''),
				4 => REGEXREPLACE('\\b([A-Z]+ +[A-Z]+ +'+rgxTrustAbbreviations+')\\b', s, ''),
				5 => REGEXREPLACE('\\b((FAMILY|LEGACY|LIVING)? +[0-9]{4} +'+rgxTrustAbbreviations+')', s, ''),
				6 => REGEXREPLACE('\\b('+rgxTrustAbbreviations + '[, ]+' + TrustTypes+')$', s, ''),
				7 => REGEXREPLACE('\\b'+TrustTypes+'$', s, ''),
				8 => REGEXREPLACE(TrustMissing, s, ''),
				9 => REGEXREPLACE(MaritalTrusts, s, ''),
				10 => REGEXREPLACE(RunOnTrust, s, ''),
				101 => REGEXREPLACE(rgxMisc, s, ''),
				11 => REGEXREPLACE('^'+rgxTrustAbbreviations, s, ''),
				s),
			'$1'));
			
			
 string RemoveStutter(string s) := IF(REGEXFIND('\\bTRUST +TRUST\\b',s), REGEXREPLACE('\\bTRUST( +TRUST)\\b', s, ''), s);

export string RemoveTrust(string s1) := FUNCTION
	s := 		RemoveStutter(RemoveEstate(CheckMispelledTrust(RemoveThe(RemoveDates(QuickTrim(s1))))));

	t :=
		IF(REGEXFIND(TrustTypesEX, s),
			MAP(
				REGEXFIND('\\b([A-Z]+ +[A-Z]+) +'+rgxTrustAbbreviations + '\\b', s, 1) in Trust2Words => StripTrust(s, 4),
				REGEXFIND('\\bSECOND +([A-Z]+) +'+rgxTrustAbbreviations + '\\b', s, 1) in TrustWords => 
																			StripTrust(Std.Str.FindReplace(s, 'SECOND', ''), 2),
				REGEXFIND('\\b([A-Z]+) +'+rgxTrustAbbreviations + '\\b', s, 1) in TrustWords => StripTrust(s, 2),
				REGEXFIND('\\b'+rgxTrustAbbreviations+' +([A-Z]+)$', s, 1) in TrustWords => StripTrust(s, 3),
				REGEXFIND('\\b[0-9]{4} +'+rgxTrustAbbreviations+'\\b', s, 1) in TrustWords => StripTrust(s, 5),
				REGEXFIND(rgxMisc, s) => StripTrust(s, 101),
				REGEXFIND('\\b'+rgxTrustAbbreviations+'$', s) => StripTrust(s, 1),
				REGEXFIND('\\b'+rgxTrustAbbreviations+'[, ]+'+TrustTypes+'$', s, 1) in TrustWords => StripTrust(s, 6),
				REGEXFIND('\\b'+TrustTypes+'$', s) => StripTrust(s, 7),
				REGEXFIND(TrustMissing, s) => StripTrust(s, 8),
				REGEXFIND(MaritalTrusts, s) => StripTrust(s, 9),
				REGEXFIND(RunOnTrust, s) => StripTrust(s, 10),
				REGEXFIND('^'+rgxTrustAbbreviations, s) => TRIM(StripTrust(s, 11),LEFT,RIGHT),
				s
				),
			MAP(
				REGEXFIND(TrustMissing, s) => StripTrust(s, 8),
				REGEXFIND(rgxRevLiving, s) => REGEXREPLACE(rgxRevLiving, s, ''),
				s));
	return MAP(
			REGEXFIND('^'+rgxTrustAbbreviations, t) => TRIM(StripTrust(t, 11),LEFT,RIGHT),
			REGEXFIND('\\b'+rgxTrustAbbreviations+'[ ,;()-]+$', t) => TRIM(REGEXREPLACE('\\b'+rgxTrustAbbreviations+'[ ,;()-]+$', t, ''),LEFT,RIGHT),
			REGEXFIND('\\b'+rgxTrustAbbreviations+'\\b', t) => TRIM(REGEXREPLACE('\\b'+rgxTrustAbbreviations+'\\b', t, ''),LEFT,RIGHT),
		t);
END;


END;
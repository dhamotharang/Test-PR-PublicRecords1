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

END;
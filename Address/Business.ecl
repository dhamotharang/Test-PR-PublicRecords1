export Business := MODULE

import lib_stringlib, ut;

export Layout_Results := RECORD
	string80	org;
	boolean		match;
	integer		source;
	string80	phrase;
END;

// business words						
shared SET OF STRING32 businesswords := Address.TokenManagement.SortAndTerminateSet(
			SET(Address.WordTokens(rule=2,~REGEXFIND('[A-Z0-9] [A-Z0-9]',phrase)), phrase));// : GLOBAL;
export boolean IsBusinessWord(string s) := Address.TokenManagement.FindToken(businesswords, s);
// paired words
shared SET OF STRING32 businessphrases := Address.TokenManagement.SortAndTerminateSet(
			SET(Address.WordTokens(rule=2,REGEXFIND('[A-Z0-9] [A-Z0-9]',phrase)), phrase));// : GLOBAL;
export boolean IsBusinessPhrase(string s) := Address.TokenManagement.FindToken(businessphrases, s);

// ambiguous words
shared SET OF STRING32 ambigwords := Address.TokenManagement.SortAndTerminateSet(
			SET(Address.WordTokens(rule=3), phrase));// : GLOBAL;
export boolean IsAmbiguousWord(string s) := Address.TokenManagement.FindToken(ambigwords, s);

// conjunctive phrases
//export SET OF STRING32 conjunctives := Address.TokenManagement.SortAndTerminateSet(
			//SET(Address.WordTokens(rule=7), phrase));// : GLOBAL;
SET OF STRING32 conjunctives := TokenManagement.SortAndTerminateSet(ConjunctiveTokens);
export boolean IsInConjuctives(string s) :=
				TokenManagement.FindToken(conjunctives, s);
				
export boolean HasBusinessWord(string s) := FUNCTION
	tokens := TokenManagement.TokenSet(s, Address.TokenManagement.TokenCount(s));
	return	TokenManagement.AnyTokenInSet(businesswords, tokens) OR
			TokenManagement.AnyDigraphInSet(businessphrases, tokens);
END;


export MatchType := ENUM(integer2, NoMatch=0, Blank, Business, Person, Dual, Unclass, Inv, Hnh);

//shared rgxFMiL := '^\\w+\\W+\\w\\W+\\w+$';
shared rgxFMiL := '^[A-Z]+ +[A-Z] +[A-Z]+$';


shared rgxRemoveSuf := '([A-Z ]+) (I|II|L|SB)';
// remove extraneous suffix from special names
shared RemoveSuffix(string s) := TRIM(IF(REGEXFIND(rgxRemoveSuf,s),REGEXFIND(rgxRemoveSuf,s,1),s));

shared MatchType CheckInvalid(string s) := FUNCTION
	ds := WordSplit(s);
	return MAP(
		EXISTS(ds(word in SpecialNames.unclassifiable_segments)) => MatchType.Inv,
		s IN SpecialNames.unclassifiable_names => MatchType.Inv,
		EXISTS(ds(word in SpecialNames.single_name_segment_obscenities)) => MatchType.Inv,
		s IN SpecialNames.full_name_obscenities => MatchType.Inv,
		MatchType.NoMatch);
END;


boolean CountyCheck(string s) := FUNCTION
	phrase4 := '^([A-Z]+) +([A-Z]+)$';

	return IF(REGEXFIND(phrase4,s),
		 SpecialNames.IsCountyName(REGEXFIND(phrase4, s, 2)) AND
			(SpecialNames.IsStateName(REGEXFIND(phrase4, s, 1)) OR
			REGEXFIND(phrase4, s, 1) IN ['PARKS','WATER','DOT','FAIR',
										'SHERIF','SHERIFF','SHERIFFS']),
		false);
end;

// check for geographic name
shared boolean CheckGeo(string s, string region) := FUNCTION
	name := RemoveSuffix(s);
	RETURN CASE(region,
		'STATE' => SpecialNames.IsStateName(name),
		'CITY' => SpecialNames.IsCityName(name),
		'TOWN' => SpecialNames.IsCityName(name),
		'TOWNSHIP' => SpecialNames.IsCityName(name),
		'AREA' => SpecialNames.IsCityName(name),
		'COUNTY' => SpecialNames.IsCountyName(name) OR CountyCheck(TRIM(s)),
		'BOROUGH' => SpecialNames.IsCountyName(name),
		'PARISH' => SpecialNames.IsParishName(name),
		false
	);
END;

shared MatchType ValidSlashName(string s) := FUNCTION
	name := Persons.FixupSlash(s);
	RETURN MAP(
		Persons.IsPersonalName(name) => MatchType.Person,
		Persons.IsDualName(name) => MatchType.Dual,
		MatchType.Business
	);
END;


shared MatchType ValidIIName(string word) := FUNCTION
	return IF(IsAmbiguousWord(word), MatchType.Business,
				IF(Persons.IsLastName(word), MatchType.Dual, MatchType.Business));
END;


shared set of string ANames := [
	'GRAND','GREAT','GREATER',
	'NEW','NEWER','SUPER','SWEET','SWEETER',
	'TIDY','WINNING','WOMAN','WOMANS','WOMENS','YOUNGER'
	];

shared MatchType IsATypeName(string s) := IF(s in ANames,MatchType.Business, MatchType.NoMatch);

shared set of string RNames := [
	'CARRIER', 'COFFEE', 'CRAFT', 'STONE', 'TOWN'
	];
	
shared CheckRepeated(string s) := IF(s in RNames,MatchType.Inv, MatchType.NoMatch);

export MatchName(MatchType n) := CASE(n,
	MatchType.NoMatch=>'N', MatchType.Blank=>'', MatchType.Business=>'B', 
	MatchType.Person=>'P', MatchType.Dual=>'D', MatchType.Inv=> 'I', MatchType.Unclass=> 'U',
	MatchType.Hnh=>'*', '?');


shared Layout_Results Token_xform(Layout_Results l, Layout_Weighted_Tokens r, integer rule) := TRANSFORM
	self.org := l.org;
	self.match := IF(r.phrase='',false,true);
	self.source := IF(self.match, rule, 0);
	self.phrase := r.phrase;
END;

/*
boolean MatchPattern(string s) := FUNCTION
	RETURN 
		REGEXFIND('^[A-Z]+[0-9.+&]*[A-Z]*$',s) OR
		REGEXFIND('^[A-Z]+\'S\\b',s) OR		// Begins with 'S
		//REGEXFIND('^[B-DF-HJ-NP-TVWXZ]{5,}\\b',s) OR	// begins with word with 5 consonants
		//REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]{5,}\\b',s) OR	// 5 consecutive consonants
		REGEXFIND('\\b([A-Z] ){4,}[A-Z] ',s) OR		// 4 or more consecutive initials
		REGEXFIND('([A-Z]\\.){3,}\\b',s) OR				// 3 consecutive initials with periods
		REGEXFIND('\\b[0-9]{2,}\\b',s) OR
		REGEXFIND('\\b[A-Z]+\'S\\b',s) OR					// possessive TONY'S
		REGEXFIND('^[A-Z0-9\'&-]+$',s) OR
		REGEXFIND('# ?[0-9][0-9A-Z]*\\b',s) OR
		REGEXFIND('^[A-Z]+ +# *[A-Z]?[0-9]+$',s) OR 
		REGEXFIND('\\b[0-9]+[A-Z]+\\b',s) OR	
		REGEXFIND('^[A-Z]+ & [A-Z]+$',s) OR
		REGEXFIND('^[A-Z]+[ ]+AND[ ]+[A-Z]+$',s) OR
		REGEXFIND('\\b[A-Z]+[ ]+AND[ ]+[A-Z]+[ ]+AND\\b',s) OR
		REGEXFIND('^[A-Z] [A-Z] [A-Z]$',s) OR
		REGEXFIND('^[A-Z] [A-Z&] [A-Z&] [A-Z]$',s) OR
		//REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]{7,}$',s) OR	// ends with 7 consonants
		REGEXFIND(' \'N\\b',s) OR
		REGEXFIND('\\bN\' ',s) OR
		REGEXFIND('^[A-Z]+ *\'N +[A-Z]+$',s) OR
		REGEXFIND('^A [A-Z]+ (AND|&) A [A-Z]+$',s) OR	// e.g. A WING AND A PRAYER
		REGEXFIND('^A [A-Z]+ A [A-Z]+$',s) OR			// e.g. A DAISY A DAY
		REGEXFIND('[A-Z]*N\' ',s) OR					// a word ending in N'
		//REGEXFIND('\\bNAT\'L\\b',s) OR					// NAT'L
		REGEXFIND('\\b"?L\\.? ?L\\.? ?[CP]\\.?"?\\b', s) OR	// L L C or LLP
		REGEXFIND('\\bP\\.? ?[AC]\\.?$', s) OR	// PA or PC
		REGEXFIND('\\b[NS]\\. ?A\\.$', s) OR	// NA or SA
		REGEXFIND('\\bP\\.? ?L\\.? ?L\\.? ?C\\.?$', s) OR	// P L L C
		REGEXFIND('\\bL\\.? ?C\\.?$', s) OR	// L C
		REGEXFIND('\\bL\\.? ?T\\.? ?D\\.?$', s) OR	// LTD
		REGEXFIND('\\bP\\.? ?S\\.? ?C\\.?$', s) OR	// PSC (Personal Services Corp)
		REGEXFIND('\\bL\\.? ?P\\.?$', s) OR	// LP
		//
		REGEXFIND('[A-Z]+ +(FOR|WITH|AT|BY|TO|IN|ON) +[A-Z]+', s) OR
		REGEXFIND('^A A A--$',s) OR
		REGEXFIND('\\bA- ',s) OR
		REGEXFIND('^([A-Z]{3,} ){4,}& [A-Z]+$',s) OR	// law firms

		// specific words
		REGEXFIND('^(THE|NO|SECOND|THIRD|UNIV|U OF|NEW|LOS|LAS)\\b', s) OR
		REGEXFIND('(&|\\+) *(FRIENDS|MORE|SON(S)?)\\b',s) OR
		REGEXFIND(' CAB$',s) OR
		REGEXFIND(' A/C\\b',s) OR
		// SPECIFIC COMPANIES
		REGEXFIND('\\bH & R BLOCK\\b',s) OR
		REGEXFIND('^A A$',s) OR
		REGEXFIND('^A T ?& ?T ',s) OR
		REGEXFIND('^A T AND T ',s) OR
		REGEXFIND('^bSALLIE MAE$',s) OR
		REGEXFIND('^bFANNIE MAE$',s) OR
		REGEXFIND('^ST\\.? [A-Z]+\'S\\b',s) OR		// Begins with ST nnn'S
		//REGEXFIND('^(SAINT|ST\\.?) +[A-Z]+ +(CH|CHURCH|SCHOOL|PAR(R)?ISH|CHAPEL|CATHEDRAL|BASILICA|HALL|HOME|MISSION|PRIORY)\\b',s) OR		// ST xxx CHURCH
		//
		REGEXFIND('[A-Z ,-]+&[A-Z ,-]*&',s) OR			// phrase with two ampersands
		//REGEXFIND(',[^&]+,[^&]+,',s) OR						// multiple commas wihout intervening ampersand
		REGEXFIND(',[^&]+,',s) OR						// multiple commas wihout intervening ampersand
		//REGEXFIND('^[A-Z]\\.[A-Z]\\.[A-Z]\\.$',s) OR replace by three initials below
		REGEXFIND('^[A-Z]+ [A-Z]+ [A-Z]+ TRUST$',s) OR
		REGEXFIND('^[A-Z]+ & [A-Z]+ [A-Z]+ TRUST$',s) OR
		REGEXFIND('^[A-Z]+ [A-Z]+ & [A-Z]+ [A-Z]+ TRUST$',s) OR
		REGEXFIND('^[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z]\\.?$',s) OR	// three initials
		REGEXFIND('^[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z]\\.?$',s) OR	// 4 initials
		REGEXFIND('^[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z]\\.?$',s) OR	// 5 initials
		REGEXFIND('^[ ]*[^A-Z]',s) OR
		REGEXFIND('&&\\b',s) OR
		REGEXFIND('-[A-Z]-',s) OR
		REGEXFIND(' -[A-Z]+',s) OR
		REGEXFIND('^([A-Z]+[ ]*,[ ]*){2,}',s) OR	// MOE, LARRY, AND CURLEY
		REGEXFIND('^[A-Z] +& +[A-Z] +[A-Z]+ AND [A-Z]+',s) OR	// A&B word and word
		REGEXFIND('^([A-Z]+) +(&|AND) +\\1+ +[A-Z]+$',s) OR		// 'BRYSON AND BRYSON BUILDERS'
		//
		REGEXFIND('\\bA[ ]+(AND|&)[ ]+P\\b',s) OR
		REGEXFIND('^[A-Z][ ]*(&| AND )[ ]*[A-Z][ ]+[A-Z]+[ ]+[A-Z]+$',s) OR	// intial & initial word word
		REGEXFIND('\\bU S A\\b',s) OR
		REGEXFIND('\\bD[ /.-]B[ /.-]A\\.?\\b',s) OR
		REGEXFIND('^A- ',s) OR
		REGEXFIND('\\bA+ ?\\+ ',s) OR			// A +
		REGEXFIND('^[A-Z] ?\\+ ?[A-Z] +[A-Z]{2,}( ?\\+)?',s) OR		// A & B SMOKES
		REGEXFIND('^A A A ',s) OR
		REGEXFIND('^A B C ',s) OR
		REGEXFIND('^A-[CZ]\\b',s) OR
		REGEXFIND('\\bE-Z\\b',s) OR
		REGEXFIND('\\bA/C\\b',s) OR
		REGEXFIND('\\bF/X\\b',s) OR
		//REGEXFIND('PLEX\\b',s) OR
		REGEXFIND('\\bXTRA[A-Z]*\\b',s) OR						// XTRAORDINAIRE
		REGEXFIND('\\b(R C|M E) CHURCH\\b',s) OR
		//REGEXFIND('^[A-Z]+ +(JR|SR|I|II|III|MR)$',s) OR
		REGEXFIND('^[A-Z]+ +(II|III|MR)$',s) OR
		REGEXFIND('^(MR|MRS|MISS) +[A-Z]+$',s) OR
		REGEXFIND('^[A-Z]+ *& *SON(S)? +[A-Z]+$',s) OR
		REGEXFIND('^[A-Z]+ +AND +SON(S)? +[A-Z]+$',s) OR
		REGEXFIND('^[A-Z]+ +(&|AND) +DAUGHTER(S)? +[A-Z]+$',s) OR
		REGEXFIND('\\bBAR B QUE\\b|\\bB B Q\\b|\\bB\\.B\\.Q\\.?\\b', s) OR
		REGEXFIND('[A-Z]{2,}(ODONTIC|OLOGY|OLOGIST|OLOGICAL|OGRAPHY|OGISTICS|OPHICAL)', s) OR
		REGEXFIND('^(GET|GOT|JUST|OH|GO).+(!|\\?)$', s) OR
		REGEXFIND('^[A-Z] [A-Z] ([A-Z])?/[A-Z]+$', s) OR		// e.g. 'Y E S/ETC'
		REGEXFIND('\\bTROOP [0-9]+\\b', s) OR
		REGEXFIND('\\bNO\\.? *[0-9]+\\b', s) OR
		REGEXFIND('\\bCIRCLE [A-Z]+\\b', s) OR
		REGEXFIND('^BANCO (DE|DI)\\b', s) OR
		REGEXFIND('@ *HOME\\b', s) OR
		REGEXFIND('^C\'EST +', s) OR
		REGEXFIND('\\b[A-Z]+(LLC|CORP|DOTCOM)$',s);
	END;
*/

export boolean MatchPattern(string s) := MAP(
		REGEXFIND('\\b"?L\\.? ?L\\.? ?[CP]\\.?"?\\b', s) => true,	// L L C OR LLP
		REGEXFIND('\\b[A-Z]+\'S\\b',s) => true,					// possessive TONY'S
		REGEXFIND('\\b[0-9]{2,}\\b',s) => true,
		REGEXFIND('^[A-Z]+[0-9.+&]*[A-Z]*$',s) => true,
		REGEXFIND('^(THE|NO|SECOND|THIRD|UNIV|U OF|NEW|LOS|LAS)\\b', s) => true,
		REGEXFIND('\\bL\\.? ?T\\.? ?D\\.?$', s) => true,	// LTD
		REGEXFIND('\\bP(\\.? ?)[ACL]\\.?$', s) => true,	// PA OR PC OR PL
		REGEXFIND('[A-Z]{2,}(ODONTIC|OLOGY|OLOGIST|OLOGICAL|OGRAPHY|OGISTICS|OPHICAL|GRAPHIC|PHYSICS)', s) => true,
		REGEXFIND('^[A-Z-]+ +(1ST|2ND|3RD|4TH)$',s) => true,	
		REGEXFIND('^[A-Z-]+ +[0-9]$',s) => true,	
		REGEXFIND('\\b[0-9]{2,}[A-Z]+\\b',s) => true,	
		REGEXFIND('\\b[0-9][A-Z]{3,}\\b',s) => true,	
		REGEXFIND('^[A-Z]+ +(&|AND) +[A-Z]+$',s) => true,	//  TOM AND JERRY
		REGEXFIND('(&|\\+) *(FRIENDS|MORE|SON(S)?)\\b',s) => true,
		REGEXFIND('[A-Z ,-]+&[A-Z ,-]*&',s) => true,		// phrase with two ampersands
		REGEXFIND('^[^A-Z]',s) => true,
		REGEXFIND('\\b(STORE|TROOP|POST|UNIT|NO|ROUTE|GROUP|PLANT|CENTER|CENTRE|CHAPTER|NUMERO|NUM|AREA|ROOM)\\.? *#?[0-9]+\\b', s) => true,
		REGEXFIND('\\bCIRCLE [A-Z]\\b', s) => true,
		REGEXFIND('\\b[A-Z]+(LLC|DOTCOM)$',s) => true,
		REGEXFIND('\\bD[ /.-]B[ /.-]A\\.?\\b',s) => true,
		REGEXFIND('^([A-Z]+) +(&|AND) +\\1+ +[A-Z]+$',s) => true,		// 'BRYSON AND BRYSON BUILDERS'

//		REGEXFIND(',[^&]+,',s) => true,						// multiple commas wihout intervening ampersand
		REGEXFIND('\\b([A-Z] ){4,}[A-Z] ',s) => true,		// 4 consecutive initials
		REGEXFIND('([A-Z]\\.){3,}\\b',s) => true,				// 3 consecutive initials with periods
//		REGEXFIND('^[A-Z]+\'S\\b',s) => true,		// Begins with 'S
//		REGEXFIND('^ST\\.? +[A-Z]+\'S\\b',s) => true,		// Begins with ST nnn'S
		REGEXFIND('^[A-Z0-9\'&-]+$',s) => true,
		REGEXFIND('# ?[0-9][0-9A-Z]*\\b',s) => true,
		REGEXFIND('^[A-Z]+ +# *[A-Z]?[0-9]+$',s) => true, 
		REGEXFIND('\\b[A-Z]+ +AND +[A-Z]+ +AND\\b',s) => true,
		REGEXFIND('^[A-Z] [A-Z] [A-Z]$',s) => true,
		REGEXFIND('^[A-Z] [A-Z&] [A-Z&] [A-Z]$',s) => true,

		REGEXFIND(' \'N\\b',s) => true,
		REGEXFIND('\\bN\' ',s) => true,
		REGEXFIND('[A-Z]*N\' ',s) => true,					// a word ending in N'
		REGEXFIND('^[A-Z]+ *\'N +[A-Z]+$',s) => true,
		REGEXFIND('^A [A-Z]+ (AND|&) A [A-Z]+$',s) => true,	// e.g. A WING AND A PRAYER
		REGEXFIND('^A [A-Z]+ A [A-Z]+$',s) => true,			// e.g. A DAISY A DAY
		REGEXFIND('^[A-Z] +[A-Z] +[A-Z] +[A-Z]+$',s) => true, // I I I WORD

		REGEXFIND('\\b[NS]\\. ?A\\.$', s) => true,	// NA OR SA
		REGEXFIND('\\bP\\.? ?L\\.? ?L\\.? ?C\\.?$', s) => true,	// P L L C
		REGEXFIND('\\bP\\.? ?L\\.? ?L\\.?$', s) => true,	// P L L
		REGEXFIND('\\b(A|L|S)(\\. ?)C\\.?$', s) => true,	// L C or S C or A C
		REGEXFIND('\\bP\\.? ?[CS]\\.? ?(C\\.?)?$', s) => true,	// PSC (Personal Services Corp) or PCC
		REGEXFIND('\\bL(\\. ?)[LP]\\.?$', s) => true,	// LP OR LL
		//
		REGEXFIND('[A-Z]+ +(FOR|WITH|AT|BY|TO|IN|ON) +[A-Z]+', s) => true,
		REGEXFIND('^A A A--$',s) => true,
		REGEXFIND('\\bA- ',s) => true,
//		REGEXFIND('^([A-Z]{3,} ){4,}& [A-Z]+$',s) => true,	// law firms

		REGEXFIND(' CAB$',s) => true,
		// SPECIFIC COMPANIES
		REGEXFIND('\\bH & R BLOCK\\b',s) => true,
		REGEXFIND('^A T *(&| AND ) *T\\b',s) => true,
//		REGEXFIND('^(SALLIE|FANNIE) MAE$',s) => true,
		//
		REGEXFIND('^[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z]\\.?$',s) => true,	// three initials
		REGEXFIND('^[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z]\\.?$',s) => true,	// 4 initials
		REGEXFIND('^[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z]\\.?$',s) => true,	// 5 initials
		REGEXFIND('&&\\b',s) => true,
		REGEXFIND('-[A-Z]-',s) => true,
		REGEXFIND(' -[A-Z]+',s) => true,
		REGEXFIND('^([A-Z]+ *, *){2,} *(&|AND) +',s) => true,	// MOE, LARRY, AND CURLEY
		REGEXFIND('^[A-Z] +& +[A-Z] +[A-Z]+ AND [A-Z]+',s) => true,	// A&B C and D
		//
//*		REGEXFIND('^[A-Z] *(&| AND ) *[A-Z] +[A-Z]+ +[A-Z]+$',s) => true,	// intial & initial word word
		REGEXFIND('\\bU S A\\b',s) => true,
		REGEXFIND('^A- ',s) => true,
		REGEXFIND('\\bA+ ?\\+ ',s) => true,			// A +
		REGEXFIND('^[A-Z] *\\+ *[A-Z] +[A-Z]{2,}',s) => true,		// A + B SMOKES
		REGEXFIND('^A A A ',s) => true,
		REGEXFIND('^A B C ',s) => true,
		REGEXFIND('\\b(A/C|A-Z|E-Z|F/X)\\b',s) => true,

		REGEXFIND('\\bXTRA[A-Z]*\\b',s) => true,						// XTRAORDINAIRE
		REGEXFIND('\\b(R C|M E) CHURCH\\b',s) => true,
		REGEXFIND('^[A-Z]+ +(II|III|MR)$',s) => true,
		REGEXFIND('^(MR|MRS|MISS) +[A-Z]+$',s) => true,
		REGEXFIND('\\b[WK][A-Z]{2,3}-(AM|FM|TV)\\b',s) => true, // radio,TV

		REGEXFIND('^[A-Z]+ +(&|AND) +(SON|DAUGHTER)(S)? +[A-Z]+$',s) => true,
		REGEXFIND('\\bBAR B QUE\\b|\\bB B Q\\b|\\bB\\.B\\.Q\\.?\\b', s) => true,
		REGEXFIND('^(GET|GOT|JUST|OH|GO).+(!|\\?)$', s) => true,
		REGEXFIND('^[A-Z] [A-Z] ([A-Z])?/[A-Z]+$', s) => true,		// e.g. 'Y E S/ETC'
		REGEXFIND('@ *HOME\\b', s) => true,
		REGEXFIND('([A-Z])\\1+MARINE', s) => true,
		REGEXFIND('!$', s) => true,
		REGEXFIND('^C\'EST ', s) => true,
		false
	);

boolean Check0ForO(string s) := 
	//IF(REGEXFIND('\\b([A-Z]*0[A-Z]+)\\b', s),
	IF(StringLib.StringFind(s, '0', 1) > 0,
		Persons.IsFirstName(StringLib.StringFindReplace(REGEXFIND('\\b([A-Z]+0[A-Z]+)\\b', s, 1),'0','O')),
		false);

boolean MatchRepeatedWord(string s) :=
	IF(REGEXFIND('^([A-Z]+) +[A-Z]+ +\\1$',s) OR		// word xxx word (word is repeated)
		REGEXFIND('^([A-Z]+) +[A-Z]+ +[A-Z] +\\1$',s),	// word xxx y word (word is repeated)
		REGEXFIND('^([A-Z]+) ', s, 1) IN RNames, false);
/*		
boolean CheckTrucking(string s) := MAP(
		REGEXFIND('^[A-Z]\\.? +(&|AND) +[A-Z]\\.? +(TRUCKING|BUILDERS)$',s) => true,	// A & C TRUCKING
		REGEXFIND('^[A-Z]\\.? +[A-Z]\\.? +(&|AND) +[A-Z]\\.? +(TRUCKING|BUILDERS)$',s) => true,	// A B & C TRUCKING
		REGEXFIND('^([A-Z]+) +(&|AND) +\\1 +(TRUCKING|BUILDERS)$',s) => true,	// JONES & JONES TRUCKING
		Persons.IsFirstName(REGEXFIND('^([A-Z]+) +([A-Z]+) +(TRUCKING|BUILDERS)$',s, 1)) AND
		Persons.IsLastName(REGEXFIND('^([A-Z]+) +([A-Z]+) +(TRUCKING|BUILDERS)$',s, 2))
					=> true,	// SAM JONES TRUCKING,
		false);
*/		
boolean CheckParentsOf(string s) := 
		IsBusinessWord(s) OR IsAmbiguousWord(s);


boolean IsConjunctive(string phrase, string s) := FUNCTION
	conjunctive := REGEXFIND(phrase, s, 1) + ' & ' + REGEXFIND(phrase, s, 3);
	alternate := REGEXFIND(phrase, s, 3) + ' & ' + REGEXFIND(phrase, s, 1);
	return IF(REGEXFIND(phrase, s),
				//IF(conjunctive IN conjunctives, true, alternate in conjunctives),
				IF(IsInConjuctives(conjunctive), true, IsInConjuctives(alternate)),
			false);
END;

//boolean CheckName(string s) := FUNCTION
//	name := TRIM(s);
//	RETURN IF(name='', false, Persons.IsProbableName(name));
//END;
boolean CheckName(string s) := 
		//IF(Persons.ValidateName(s) IN
		//[Persons.NameStatus.ProbableName,Persons.NameStatus.PossibleName],
		IF(Persons.ValidateName(s) =
			Persons.NameStatus.ProbableName,
		true,false);

// check for geographic name
boolean IsGeo(string s) := FUNCTION
	phrase0 := '\\b(CITY|TOWN|TOWNSHIP|COUNTY|AREA|PARISH|BOROUGH)\\b';
	phrase1 := '^((\\w+\\W+){1,3}) *(CITY|TOWN|TOWNSHIP|COUNTY|AREA|PARISH|BOROUGH)';
	phrase2 := '^([A-Z]+) *(CITY|TOWN|TOWNSHIP|COUNTY|AREA|PARISH|BOROUGH)\\b';
	phrase3 := '^([A-Z ]+) *(CITY|TOWN|TOWNSHIP|COUNTY|AREA|PARISH|BOROUGH)\\b';
	phrase4 := '^([A-Z]+) +([A-Z]+) +COUNTY\\b';
	return MAP(
		NOT REGEXFIND(phrase0,s) => false,
		REGEXFIND(phrase2,s) => CheckGeo(REGEXFIND(phrase2, s, 1),REGEXFIND(phrase2, s, 2)),
		REGEXFIND(phrase3,s) => CheckGeo(REGEXFIND(phrase3, s, 1),REGEXFIND(phrase3, s, 2)),
		REGEXFIND(phrase4,s) => SpecialNames.IsCountyName(REGEXFIND(phrase4, s, 2)) AND
								(SpecialNames.IsStateName(REGEXFIND(phrase4, s, 1)) OR
									REGEXFIND(phrase4, s, 1) IN ['PARKS','WATER','DOT','FAIR',
										'SHERIF','SHERIFF','SHERIFFS']),
		false);
//					CheckGeo(REGEXFIND(phrase, s, 1),REGEXFIND(phrase, s, 3)),
//					MatchType.NoMatch)
//	phrase := '^((\\w+\\W+){1,3}) *(CITY|TOWN|COUNTY|AREA|PARISH)';
//	matches := IF(REGEXFIND(phrase,s),
//					CheckGeo(REGEXFIND(phrase, s, 1),REGEXFIND(phrase, s, 3)),
//					MatchType.NoMatch);
//	RETURN IF(matches = MatchType.NoMatch, false, true);
END;

set of string placewords :=
		['ARENA','BAPTIST','BRANCH','BUILDERS','CELLARS','CONDO','CONDOS',
		'CHALET','CENTER','CHAPEL','CHURCH','COLONY','COTTAGES','CRAFTS','DAIRY','DELI',
		'FARM','FARMS','GALLERY','GOLF','GRILL','HOLLOW',
		'HOA','HOME','HOMES','HOUSE','KENNEL','KENNELS','LODGE','MALL','MANOR','MARINA','MARINE',
		'MARKET','MOTEL','OFFICE','PLACE','PLAZA','POOL','PRESS',
		'RANCH','SCHOOL','SCHOOLS','SPA','STABLES','STORAGE','TACKLE',
		'SALES','TRUCKING','VILLA','VILLAS','VINEYARD'
		];
rgxGeo := '^([A-Z]+) +(CREEK|GROVE|LAKE|LAKES|POINT|SPRING|SPRINGS)\\b';
rgxGeo1 := '^([A-Z]+) +(CREEK|GROVE|LAKE|LAKES|POINT|SPRING|SPRINGS) +([A-Z]+)\\b';
boolean IsGeoCity(string s) := MAP(
		~REGEXFIND(rgxGeo, s) => false,
		Address.SpecialNames.IsCityName(REGEXFIND(rgxGeo, s, 1) + ' ' +
										REGEXFIND(rgxGeo, s, 2)) => true,
		REGEXFIND(rgxGeo1, s, 3) IN placewords => true,
		~Persons.IsFirstname(REGEXFIND(rgxGeo1, s, 1)) => true,		
		Persons.ValidateName(s) IN 
			[Persons.NameStatus.NotAName,Persons.NameStatus.ImprobableName] => true,
		false);

// e.g. names ending as BUILDERS TRUCKING HOLDINGS
rgxDualNames := '^([A-Z]{2,}) +(&|AND) +([A-Z]{2,})$';
boolean TwoFirstNames(string s) := 
			Address.Persons.IsFirstName(REGEXFIND(rgxDualNames,s, 1)) AND
			Address.Persons.IsFirstName(REGEXFIND(rgxDualNames,s, 3));
			

set of string geowords :=
		['ACRES', 'AFRICA','AMERICA','AREA', 'ASIA','ATLANTIC','AUSTRALIA','AVE','AVENUE',
		'BANK','BASIN','BAY','BEACH','CAROLINA','CITY','COAST','CONDO','COUNTY','CREEK',
		'DAKOTA','END','GAP','HALLOW','LAKE','LAKES','METRO','PACIFIC',
		'PARK','PLACE','PLAINS','POINT','POINTE','RIDGE','RIVER','ROAD',
		'SIDE','SHORE','SQUARE','ST','STATES','STREET','TOWN','VALLEY','VIEW'];

boolean IsGeoDesignation(string s) := MAP(
		s = '' => false,
		s in geowords => true,
		SpecialNames.IsStateName(s) AND s != 'MD' => true,
		Persons.IsFirstName(s) => false,
		SpecialNames.IsCityName(s) => true,
		SpecialNames.IsCountyName(s) => true,
		false);

set of string colors := ['RED','ORANGE','GREEN','BLUE','YELLOW','PURPLE','WHITE','BLACK','BROWN',
			'GREY','GRAY','AZURE','TEAL','PINK'];

rgxTwoWords := '^([A-Z]+) +([A-Z]+)$';
rgxPersonalBusiness := '^([A-Z &\'-]+) +(BUILDERS|HOLDINGS|TRUCKING|GROUP|RANCH|FARMS|HARDWARE)$';
boolean CheckPersonalBusiness(string s) := MAP(
		s = '' => false,
		REGEXFIND('^[A-Z]\\.? +(&|AND) +[A-Z]\\.?$',s) => true,	// A & C TRUCKING
		REGEXFIND('^[A-Z]\\.? +[A-Z]\\.? +(&|AND) +[A-Z]\\.?$',s) => true,	// A B & C TRUCKING
		REGEXFIND('^([A-Z]+) +(&|AND) +\\1$',s) => true,	// JONES & JONES TRUCKING
		REGEXFIND(rgxDualNames,s) => NOT TwoFirstNames(s),  // SAM & BRENDA TRUCKING
		REGEXFIND('^([A-Z]+) +([A-Z])$',s) => false,
		Persons.InvalidNameFormat(s) => true,
		Persons.IsLastNameConfirmed(REGEXFIND('^([A-Z \'-]+)$', s, 1)) => true,
		Persons.IsFirstName(REGEXFIND('^([A-Z]+) +([A-Z]+)$',s, 1)) AND
			Persons.IsLastName(REGEXFIND('^([A-Z]+) +([A-Z]+)$',s, 2))
					=> true,	// SAM JONES TRUCKING,
		IsGeoDesignation(s) => true,
		IsGeoDesignation(RegexFind(rgxTwoWords, s, 2)) => true,
		RegexFind(rgxTwoWords, s, 1) in colors => true,
		false);



set of string saintwords := [
		'ANGLICAN','BASILICA','CATHEDRAL','CH','CHAPEL','CHURCH',
		'HALL','HOME','HOSP','HOSPITAL','MISSION','PARISH','PARRISH','PRIORY','SCHOOL','SEMINARY'
		];
boolean IsSaintWord(string s) := MAP(		
		s = '' => false,
		s in saintwords => true,
		IsAmbiguousWord(s) => true,
		false);

set of string TrustWords := ['ANTI',
	'ASSIGNEE','AWARD','BANKERS','BENEFIT','BOAT','BOOK','CAPITAL',
	'CHARITY','CHARITABLE','CHILDREN','CHILDRENS','CIVIC',
	'CREDIT','DECEDENTS','ENDOWMENT','EXCHANGE','EXEMPTION',
	'FAMILY','FARM','GENERAL','GRANDCHILDREN','GRANTOR','HERITAGE',
	'HOLDING','HOLDINGS','INCOME','INDENTURE','INVESTMENT','INVSTM','IRREV','IRREVOCABLE',
	'JOINT','LEASE','LEGACY','LIVING','MARITAL','MASTER',
	'NATIONAL','NEEDS','PENSION','PROXY','REMAINDER',
	'RESIDUARY','REVOC','REVOCABLE','RVC','STATUTORY'
	];
MatchType CheckTrust(string s, DATASET({string32 word}) words) := MAP(
		REGEXFIND('\\b([A-Z]+) +TRUST', s, 1) in TrustWords => MatchType.Business,
		//REGEXFIND(' ([A-Z]+) +TRUST', s, 1, NOCASE) in GeoWords => MatchType.Business,
		IsGeoDesignation(REGEXFIND('\\b([A-Z]+) +TRUST', s, 1)) => MatchType.Business,
		REGEXFIND('^[A-Z]+ [A-Z]+ [A-Z]+ TRUST$',s) => MatchType.Business,
		REGEXFIND('^[A-Z]+ & [A-Z]+ [A-Z]+ TRUST$',s) => MatchType.Business,
		REGEXFIND('\\bTRUST +[0-9]$',s) => MatchType.Business,
		REGEXFIND('^[A-Z]+ [A-Z]+ & [A-Z]+ [A-Z]+ TRUST$',s) => MatchType.Business,
		REGEXFIND(' TRUST TRUSTY\\b', s) => MatchType.Unclass,
		//Persons.IsStandAloneName(REGEXFIND('^([A-Z \'-]+) +TRUST$', s, 1)) => MatchType.Unclass,
		Persons.IsDualName(REGEXFIND('^([A-Z &\'-]+) +TRUST$', s, 1))	=> MatchType.Unclass,
		REGEXFIND('^[A-Z]+ TRUST$', s) => 
				IF(Address.Persons.IsFirstName(REGEXFIND('^([A-Z]+) ',s,1)),
							MatchType.Person,MatchType.Business),
		REGEXFIND('^[A-Z]+ [A-Z] TRUST$', s) => 
				IF(Address.Persons.IsFirstName(REGEXFIND('^([A-Z]+) ',s,1)),
							MatchType.Person,MatchType.Business),
		CheckName(REGEXFIND('^(.+) TRUST$',s,1)) => MatchType.Unclass,
		COUNT(words(IsAmbiguousWord(word))) > 1 => MatchType.Business,
		//Persons.IsProbableName(s) => MatchType.Person,
		Persons.ValidateName(s) = Persons.NameStatus.ProbableName => MatchType.Person,
		MatchType.Business
		);


// check for trailer
boolean IsTrailer(string s) := 
			IsBusinessWord(REGEXFIND('\\b([A-Z]+)(INC)\\b',s, 1));

	
MatchType CheckSemicolonName(string name) := 
	IF(Persons.IsDualName(stringlib.StringFindReplace(name, ';', '&')),
		MatchType.Dual, MatchType.Inv);

boolean IsLastAmbi(string name) := FUNCTION
	tokens := Persons.NameSplit(name);
	x := COUNT(tokens);
	s := TRIM(tokens[x].word);
	//RETURN IF (x < 4, false, tokens[x].word in Ambiwords);
	RETURN MAP (
		x < 4 => false,
		Persons.IsSuffix(s) => false,
		IsAmbiguousWord(s)
		);
END;		

rgxCityWord := '^((\\w+\\W+){1,3}) *([A-Z]+)$';

			
boolean IsInvalidTaxpayer(string s) :=
		MAP(
			StringLib.StringFind(s, 'TAXPAYER', 1) = 0 => false,
			REGEXFIND('TAXPAYER [0-9A-Z][0-9]+ *OF\\b', s) => true,
			REGEXFIND('TAXPAYER [0-9][0-9A-Z]+ *[0-9A-Z]* *OF\\b', s) => true,
			REGEXFIND('TAXPAYER [A-Z] +[0-9A-Z]* *OF\\b', s) => true,
			REGEXFIND('^[A-Z]+ +[A-Z]* *TAXPAYER$', s) 
				AND Persons.IsFirstName(REGEXFIND('^([A-Z]+) ',s,1)) => true,		
			false
		);

	// of the format name ( term )
	set of string	parenTerms := ['COTRUSTEE','COTRUSTEES',
		'DECEASED','EST','ETAL','HEIRS','L/U','LEASOR','LE','LESSEE','LIFETIME','REF',
		'SURV','SURVIVOR','TE','TR','TRSTE','TRUST','TRUSTE','TRUSTEE','TRUSTEES'
		];
		
	runonwords := '\\b([A-Z]+)(LLC|CORP|INC|COMPANY|INCORPO|FOUNDATION|UNITED|SERVICES)\\b';
	
boolean TestBreakUp(string s) := FUNCTION
	tokens := Address.TokenManagement.TokenSet(s, Address.TokenManagement.TokenCount(s));
	RETURN MAP(
		Address.TokenManagement.AnyTokenInSet(businesswords, tokens) => true,
		Address.TokenManagement.AnyDigraphInSet(businessphrases, tokens) => true,
		MatchPattern(s) => true,
		false);
END;
	
boolean BreakUpName(string s) := 
	IF (REGEXFIND(runonwords, s),
		TestBreakUp(REGEXREPLACE(runonwords, s, '$1')),
		false);

string Preprocess(string s, set of string1 options) := 
	IF('W' in options OR 'S' in options, 
		//REGEXREPLACE('([A-Z]+,[A-Z]+),([A-Z ]+)',
		//	stringlib.StringFindReplace(s, '3RD', 'III'),'$1 $2'),
		Persons.SuffixToAlpha(s),
		s);
		
boolean IsGreekFrat(DATASET({string32 word}) words) := COUNT(words) = 3 AND
			SpecialNames.IsGreekLetter(words[1].word) AND
			SpecialNames.IsGreekLetter(words[2].word) AND
			SpecialNames.IsGreekLetter(words[3].word);


rgxFirm := '^([A-Z]+) +([A-Z]+) *(&| AND ) *([A-Z]+)[.,/\\\']?$';
rgxFirm1 := '^([A-Z]+) +([A-Z]+) *(&| AND ) *(\\1)$';
boolean NoVowels(string s) :=
	REGEXFIND('^[^AEIOUY]{3,}$', s);
boolean TooManyConsonants3(string s) :=
	NoVowels(REGEXFIND(rgxFirm,s,1)) OR
	NoVowels(REGEXFIND(rgxFirm,s,2)) OR
	NoVowels(REGEXFIND(rgxFirm,s,4));
boolean EmbeddedWords(string s) := 
	REGEXFIND('AAA|ARCH|AUTO|BIO|CARE|CENTER|COMP|CRAFT|CRYO|DESIGN|EASY|ECONO|EURO|FIRE|FLEX|HOUSE|INFO|INTER|LAKE|MASTER|MECH|METRO|MULTI|OMNI|PHARM|PLEX|POLY|POWER|PSYCH|SCAPE|SCOPY|SERVICE|SHOP|TECH|TELE|TIONAL|TOWN|TRANS|TRONIC|ULTRA|WARE|WEAR|WORK',s);
boolean EndPhrase(string s) := 
	REGEXFIND('[A-Z]{3,}(ANCE|EX|INC|ING|CO|ABLE|MENT|SHIP|CION|SION|TION|TIONAL|TIONS|CORP|COMPANY|INCORPO|IST|ISTS|ISTIC|FOUNDATION|UNITED|SERVICES|MART|MARTS|SIDE|TIC|TICS|VILLE)\\b',s);

types := ['X','F','L','B'];
string1 GetNameClass(string nm) :=
	types[IF (Persons.IsFirstName(nm),1,0) +
	IF (Persons.IsLastNameEx(nm),2,0) + 1];
	
string3 GetNameTypes(string s) :=
		GetNameClass(REGEXFIND(rgxFirm, s, 1)) +
			GetNameClass(REGEXFIND(rgxFirm, s, 2)) + GetNameClass(REGEXFIND(rgxFirm, s, 4));


boolean LikelyFirmName(string s) := FUNCTION
	t := GetNameTypes(s);
	RETURN MAP(
		StringLib.StringFind(s, 'AND OR', 1) > 0 => false,
		StringLib.StringFind(s, 'AND FRIENDS', 1) > 0 => true,
		REGEXFIND(rgxFirm,s,4) = 'DELI' => true,
		t in ['XXX','XLX','XXL','XLL'] => true,
		REGEXFIND(rgxFirm1, s) => true,
		t[2] = 'F' OR t[3] = 'F' => false,
		t IN ['LFF','LBF','LFB','LBB','BLF','FLF','FLB'] => false,
		t in ['LBL','BBL','BLL','BLB','LLL','LXL','LLX'] => true,
		t IN ['XBB','BBB','XFF','XBF','XFB','XBF','XXF'] => false,
		//t IN ['XXB','XBX'] => false,
		TooManyConsonants3(s) => true,
		EmbeddedWords(s) => true,
		EndPhrase(s) => true,
		false);					// unknown or either
END;
			
boolean IsFirmName(string s) :=
	IF(REGEXFIND(rgxFirm, s),
		LikelyFirmName(s),
		//Persons.ProbableLastName(REGEXFIND(rgxFirm, s, 1)) AND
		//	LikelyLastNames(REGEXFIND(rgxFirm, s, 2),REGEXFIND(rgxFirm, s, 4)),
		false);
		
rgxFL := '^([A-Z]+) +([A-Z]+)$';
rgxFML := '^[A-Z]+ +[A-Z]+ +[A-Z]+$';
boolean TooShort(string s) :=
	LENGTH(REGEXFIND(rgxFL,s,1)) < 3 OR
	LENGTH(REGEXFIND(rgxFL,s,2)) < 3;
boolean TooManyConsonants(string s) :=
	NoVowels(REGEXFIND(rgxFL,s,1)) OR
	NoVowels(REGEXFIND(rgxFL,s,2));
	
boolean FullMatchingName(string s) := FUNCTION
	t := GetNameClass(REGEXFIND(rgxFL,s,1)) +
		GetNameClass(REGEXFIND(rgxFL,s,2));
	//RETURN IF(t='XX',false,true);
	RETURN IF(t[1]='X' or t[2]='X',false,true);
END;
boolean MatchingName(string s) := FUNCTION
	t := GetNameClass(REGEXFIND(rgxFL,s,1)) +
		GetNameClass(REGEXFIND(rgxFL,s,2));
	RETURN IF(t='XX',false,true);
	//RETURN IF(t[1]='X' or t[2]='X',false,true);
END;
boolean LikelyName(string s) :=
	Persons.ValidateName(s) IN [Persons.NameStatus.ProbableName,
									Persons.NameStatus.PossibleName];

/*boolean IsUnlikelyName(string s) := MAP(
	NOT REGEXFIND(rgxFL, s) => false,
	MatchingName(s) => false,
	TooShort(s) => true,
	TooManyConsonants(s) => true,
	EmbeddedWords(s) => true,
	false);
*/
MatchType TwoWordName(string s) := MAP(
	Persons.InvalidNameFormat(s) => MatchType.Inv,
	//MatchingName(s) => MatchType.Person,
	LikelyName(s) => MatchType.Person,
	TooShort(s) => MatchType.Business,
	TooManyConsonants(s) => MatchType.Business,
	EmbeddedWords(s) => MatchType.Business,
	EndPhrase(s) => MatchType.Business,
	//MatchingName(s) => MatchType.Person,
	//
	SpecialNames.IsCityName(s) => MatchType.Business,
	SpecialNames.IsCityName(REGEXFIND(rgxFL,s,1)) => MatchType.Business,
	SpecialNames.IsStateName(REGEXFIND(rgxFL,s,1)) => MatchType.Business,
	SpecialNames.IsCountyName(REGEXFIND(rgxFL,s,1)) => MatchType.Business,
	SpecialNames.IsCityName(REGEXFIND(rgxFL,s,2)) => MatchType.Business,
	SpecialNames.IsStateName(REGEXFIND(rgxFL,s,2)) => MatchType.Business,
	SpecialNames.IsCountyName(REGEXFIND(rgxFL,s,2)) => MatchType.Business,
	MatchType.Person	// otherwise we miss too many names
	);
	
boolean IsFirstAndAmbi(string name) := FUNCTION
	n1 := REGEXFIND(rgxTwoWords,name, 1);
	n2 := REGEXFIND(rgxTwoWords,name, 2);
	RETURN MAP(
			Persons.IsFirstName(n1) AND Persons.IsLastNameEx(n2) => true,
			Persons.IsFirstName(n2) AND Persons.IsLastNameEx(n1) => true,
			Persons.IsFirstName(n1) AND ~IsAmbiguousWord(n2) => true,
			Persons.InvalidNameFormat(name) => false,
			//MatchingName(name) => true,
			TooShort(name) => false,
			TooManyConsonants(name) => false,
			EmbeddedWords(name) => false,
			EndPhrase(name) => false,
//			Persons.IsFirstName(n1) AND IsAmbiguousWord(n2) => true,
			IsAmbiguousWord(n1) AND Persons.IsFirstName(n2) => true,
			Persons.IsLastNameConfirmed(n1) AND Persons.IsLastNameConfirmed(n2) => false,
			IsAmbiguousWord(n1) AND Persons.IsLastNameConfirmed(n2) => true,
			false);
END;

boolean IsAmbiguousBusiness(DATASET({string32 word}) words, string busname, string name) := 
			MAP(
				COUNT(words(IsAmbiguousWord(word))) = 0 => false,
				COUNT(words(IsAmbiguousWord(word))) > 1 => true,
				REGEXFIND('^BABY (BOY|GIRL) ',busname) => false,
				REGEXFIND(rgxTwoWords,busname) => NOT IsFirstAndAmbi(busname),
				IsLastAmbi(busname) => true,
				CASE(Persons.ValidateName(name),
					Persons.NameStatus.ProbableName => false,
					Persons.NameStatus.PossibleName => false,
					Persons.NameStatus.PossibleDualName => false,
					true)
				//SpecialNames.IsCityName(REGEXFIND(rgxCityWord, name, 1)) AND
				//	IsAmbiguousWord(REGEXFIND(rgxCityWord, name, 3)) => true,
				)
			;		
BusEndings := ['L C','L P','P C','P A','S C','N A','S A','P L','L L','A C'];
boolean CheckBusEndings(string s) :=
		REGEXFIND('^.+ ([A-Z] [A-Z])$',s,1) IN BusEndings;
		
string removewhitespace(string s) := BEGINC++
	char *t = (char *)rtlMalloc(lenS);
	
	for (int i = 0; i < lenS; ++i)
	{
		t[i] = s[i] < ' ' ? ' ' : s[i];
	}
	__result = t;
	__lenResult = lenS;
ENDC++;		

MatchType MatchX(string str, set of string1 options) := FUNCTION
	//s := Preprocess(TRIM(StringLib.StringToUpperCase(removewhitespace(str)),LEFT,RIGHT),options);
	s := Preprocess(TRIM(StringLib.StringToUpperCase(REGEXREPLACE('([^ -~]+)',str,' ')),LEFT,RIGHT),options);
	words := WordSplit(s);
	digraphs := WordPairs(words);
	name := Persons.SuffixToAlpha(Persons.FixupName(s));
	tokens := Address.TokenManagement.TokenSet(s, Address.TokenManagement.TokenCount(s));
	hint := MAP(
			'F' in options => 'F',
			'f' in options => 'f',
			'L' in options => 'L',
			'l' in options => 'l',
			'U');
	//n := Persons.PersonalNameFormat(name);
	RETURN MAP(
		//REGEXFIND('^\\s*$',s) => MatchType.Blank,					// blank line
		LENGTH(s) = 0 => MatchType.Blank,					// blank line
		REGEXFIND('[^ -~]',str) => MatchType.Inv,		// non printing characters space to ~ only
		REGEXFIND('^[^A-Z ]+$',s) => MatchType.Inv,	// no alpha characters
		REGEXFIND('\\b([^ A])\\1{5,}\\b',s)	=>MatchType.Inv,	// 6 or more repeated character
		COUNT(words) = 0 => MatchType.Inv,
		SpecialNames.IsInvalidName(s) => MatchType.Inv,
		// Rule 14: check for invalid or obscene patterns
		SpecialNames.IsInvalidToken(tokens) => MatchType.Inv,
		REGEXFIND('^CREDIT[A-Z ]+APPLICANT$', s) => MatchType.Inv,
		IsInvalidTaxpayer(s) => MatchType.Inv,
		//***** UNKNOWN
		StringLib.StringFind(s, 'UNKNOWN', 1) > 0 => 
				IF(EXISTS(digraphs(word in SpecialNames.unknown_allowed_segments)),
							MatchType.Business, MatchType.Inv),
		
		
		// CARDHOLDER
		REGEXFIND('^[A-Z]+ +[A-Z]* *CARDHOLDER$', s) AND ((Persons.IsFirstName(TRIM(words[1].word))) OR
					(TRIM(words[1].word) IN ['TEST', 'BANKBOSTON','SECURED','PURPOSE','SHELL','TWO']))
					=> MatchType.Inv,
		// Rule x: Unclassifiable
		REGEXFIND('^(EST OF|ESTATE OF|ESTATE-OF|ESTATEOF[A-Z]+)\\b', s) => MatchType.Unclass,
		REGEXFIND('\\b(ETUX|UX|ETAL|ET AL|EXECUTOR|T/E|TRUST PT)\\b', s) => MatchType.Unclass,
		// other unclassifiable names
		REGEXFIND('^PARENTS OF [A-Z]+$', s) AND
			NOT CheckParentsOf(REGEXFIND('^PARENTS OF +([A-Z]+)$', s, 1)) => MatchType.Unclass,
		
		// business words
		Address.TokenManagement.AnyTokenInSet(businesswords, tokens) => MatchType.Business,
		Address.TokenManagement.AnyDigraphInSet(businessphrases, tokens) => MatchType.Business,
		//COUNT(ds) = 1 => MatchType.Business,
		COUNT(words) > 10 => MatchType.Business,
		SpecialNames.IsKnownBusiness(RemoveSuffix(s)) => MatchType.Business,
		
		IsGeoCity(s) => MatchType.Business,
		IsGeoDesignation(REGEXFIND('\\b(CENTRAL|NORTH(ERN)?|SOUTH(ERN)?|WEST|EAST) +([A-Z]+)\\b', s, 4))
										=> MatchType.Business,
		IsSaintWord(REGEXFIND('^(SAINT|ST\\.?|SS|STS) +[A-Z ]+ +([A-Z]+)\\b', s, 2))
										=> MatchType.Business,
		//REGEXFIND('\\b(TRUCKING|BUILDERS)$',s) AND CheckTrucking(s) => MatchType.Business,
		//REGEXFIND('^([A-Z &\'-]+) +(BUILDERS|HOLDINGS|TRUCKING|GROUP|RANCH|FARMS)$',s) AND
		//				CheckPersonalBusiness(s) => MatchType.Business,

		CheckPersonalBusiness(REGEXFIND(rgxPersonalBusiness, s, 1)) => MatchType.Business, 
		EXISTS(words(word in SpecialNames.single_name_segment_obscenities)) => MatchType.Inv,
		s IN SpecialNames.full_name_obscenities => MatchType.Inv,
		
		StringLib.StringFind(s, 'CORPORATION', 1) > 0 => MatchType.Business,
		StringLib.StringFind(s, ' CORP.', 1) > 0 => MatchType.Business,
		StringLib.StringFind(s, 'SERVICES', 1) > 0 => MatchType.Business,
		StringLib.StringFind(s, 'UNITED', 1) > 0 => MatchType.Business,
		StringLib.StringFind(s, 'INT\'L',1) > 0 => MatchType.Business,
		//StringLib.StringFind(s, 'ULTRA',1) > 0 => MatchType.Business,
		StringLib.StringFind(s, 'NAT\'L',1) > 0 => MatchType.Business,
		StringLib.StringFind(s, ' - ',1) > 0 => MatchType.Business,
		StringLib.StringFind(s, 'AND A HALF',1) > 0 => MatchType.Business,
		StringLib.StringFind(s, '& A HALF',1) > 0 => MatchType.Business,
		StringLib.StringFind(s, ' A-MINOR',1) > 0 => MatchType.Unclass,

		// check for business patterns
		// Rule 18: unclassifiable
		//REGEXFIND('^EST OF ',s) => MatchType.Unclass,
		REGEXFIND('^(APT|STORE|SUITE) +# *[A-Z0-9]+$',name) => MatchType.Inv, 

		REGEXFIND('\\( *([A-Z/]+) *\\)?$',s,1) in parenTerms => MatchType.Unclass,
		'W' in options and REGEXFIND('^[A-Z]+$',s) => MatchType.Person,
		MatchPattern(s) => MatchType.Business,
		
		// junk matches 
		REGEXFIND('^AND [A-Z]+$',s) OR REGEXFIND('^[A-Z]+ (AND|&)$',s) OR
				REGEXFIND('\\b[A-Z] +OR +(JR|SR)$', s) => MatchType.Inv,
		
		// Rule 15: repeated word: xxx NAME xxx
		MatchRepeatedWord(s) => MatchType.Inv,
		// Rule 9: Initial & Initial word (J & R Tires)
		REGEXFIND('^[A-Z] *(&| AND ) *[A-Z] +([A-Z]+)$', s) => 
				ValidIIName(REGEXFIND('^[A-Z] *(&| AND ) *[A-Z] +([A-Z]+)$', s, 2)),
		// Rule 7: 
		IsConjunctive('\\b([A-Z]+) *(&| AND |\\+) *([A-Z]+)\\b',s) => MatchType.Business,	// word & word
		IsConjunctive('\\b[A-Z]+ *& *[A-Z]+ +([A-Z]+) *(&| AND |\\+) *([A-Z]+)',s) => MatchType.Business,	// A&B word and word
		IsConjunctive('\\b([A-Z]{2,}) +(N|A) +([A-Z]{2,})$',s) => MatchType.Business,	// word N word
		
		IsTrailer(s) => MatchType.Business,
		// Rule 17: match city names
		IsGeo(s) => MatchType.Business,
		
		// other unclassified names
		REGEXFIND('^DIVORCED +[A-Z]+$', s) => MatchType.Unclass,
//$		SpecialNames.IsCityState(s) => MatchType.Unclass,
		// final checks before person
		REGEXFIND('\\bTRUST\\b',s) => CheckTrust(s, words),
		//REGEXFIND('[+*%#@!?\\[]+',s) => MatchType.Inv,	// special characters
		REGEXFIND('[*%#@!?\\[]+',name) => MatchType.Inv,	// special characters
		
		IsAmbiguousBusiness(words, s, name) => MatchType.Business,

		// Rule 8: dual names
		//REGEXFIND('^(MR & MRS|MR AND MRS) +[A-Z]+$',s) => MatchType.Unclass,
		IsFirmName(s) => MatchType.Business,
		Persons.IsDualName(name) => MatchType.Dual,
		
		// Rule 10: match names with slash
		StringLib.StringFindCount(s, '/') = 1 => ValidSlashName(name),

		//REGEXFIND('^[A-Z]+ *\\+ *[A-Z]+$',s) => MatchType.Inv,	// Name + Name
		REGEXFIND('^[A-Z]+ +(ND|RD|AVE)$', s) => MatchType.Inv,
		// Rule 12: "A" type name e.g., A GRAND PLACE
		REGEXFIND('^A ([A-Z]+) [A-Z]+', s, 1) in ANames => MatchType.Business,

		// match personal name
		BreakUpName(s) => MatchType.Business,
		//REGEXFIND('^(MR & MRS|MR MRS|MR AND MRS) +[A-Z ]+$',s) => MatchType.Unclass,
		REGEXFIND('^(EST|DC|DD|NFN|TRT|ITF|MDN|WD|CM|MW|UA|FA|DM|MRMRS|MMS|AKA|A/K/A) ',s) => MatchType.Unclass,
		REGEXFIND('\\b(PT|LT|FT|TE)$',s) => MatchType.Unclass,
		REGEXFIND('^BABY (BOY|GIRL) ',s) => MatchType.Unclass,
		REGEXFIND('^[A-Z]+ +[0-9] +[A-Z]+$',s) => MatchType.Inv,	// name numeral name
		IsGreekFrat(words) => MatchType.Business,
		Check0ForO(s) => MatchType.Inv,
		//StringLib.StringFind(s, ';', 1) > 0 => CheckSemiColonName(name),
		
		//Persons.InvalidNameFormat(name) => MatchType.Inv,
		//Persons.IsJustLastName(name) => MatchType.Unclass,
		//Persons.IsProbableName(name) => MatchType.Person,
		//Persons.PersonalNameFormat(name) > 0 => MatchType.Unclass,
		REGEXFIND('\\b(A LOT|U SAVE)\\b', s) AND
			NOT Persons.IsFirstName(REGEXFIND('^([A-Z]+) +(A LOT|U SAVE)\\b', s, 1))
							=> MatchType.Business,
		//IsUnlikelyName(name) => MatchType.Business
		//REGEXFIND('^[A-Z]+$',name) => MatchType.Business,
		REGEXFIND('^[A-Z]+$',name) AND ~REGEXFIND('^[A-Z]+$',s)
								=> MatchType.Inv,
		REGEXFIND('^[A-Z]{2,} +[A-Z]{2,}$',name) => TwoWordName(name),
		CASE(Persons.ValidateName(name,hint),
			Persons.NameStatus.InvalidNameFormat => MatchType.Inv,
			Persons.NameStatus.StandaloneName => MatchType.Unclass,
			Persons.NameStatus.ProbableName => MatchType.Person,
			Persons.NameStatus.PossibleName => MatchType.Person,
			//Persons.NameStatus.ImprobableName => MatchType.Unclass,
			Persons.NameStatus.PossibleDualName => MatchType.Business,
			MAP(
				REGEXFIND('\\b((MR|DR) (&|AND)? MRS)\\b',s) => MatchType.Unclass,
				REGEXFIND('( AND |&| OR |&/OR )', s) => MatchType.Business,
				REGEXFIND(' A-[A-Z]+',s) => MatchType.Business,
				EmbeddedWords(s) => MatchType.Business,
				EndPhrase(s) => MatchType.Business,
				SpecialNames.IsCityName(s) => MatchType.Business,
				CheckBusEndings(s) => MatchType.Business,
				REGEXFIND(rgxFML, s) => MatchType.Person,
				Persons.HasSuffix(s) => MatchType.Person,
				MatchType.Inv		//MatchType.Hnh	//		Business
			)
		)
		
	);
	END;

export string1 GetNameType(string s, set of string1 options = []) := MatchName(MatchX(s, options));

END;
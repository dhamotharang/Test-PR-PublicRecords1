import lib_stringlib, _Control, ut, lib_DataLib, Data_Services; //, LIB_Word; //IDL_Header,
/*************
This module is used by the name repository to look up likely first and last names
*************/
EXPORT NameTester := MODULE

//shared dsWordTokens := WordTokens;
shared dsWordTokens := DATASET(MAP(Thorlib.Daliservers() in ['10.173.231.12:7070', '10.173.11.12:7070'] => Data_Services.data_location.prefix(), '') + '~thor::nid::aux::businesstokens',Layout_Weighted_Tokens, THOR);
// shared dsWordTokens := DATASET('~thor::nid::aux::businesstokens',Layout_Weighted_Tokens, THOR);

// business words						
shared SET OF STRING32 businesswords := TokenManagement.SortAndTerminateSet(
			SET(dsWordTokens(rule IN [1,2],~REGEXFIND('[A-Z0-9] [A-Z0-9]',phrase)), phrase));// : GLOBAL;
export boolean IsBusinessWord(string s) := TokenManagement.FindToken(businesswords, s);
// paired words
shared SET OF STRING32 businessphrases := TokenManagement.SortAndTerminateSet(
			SET(dsWordTokens(rule IN [1,2],REGEXFIND('[A-Z0-9] [A-Z0-9]',phrase)), phrase));// : GLOBAL;
export boolean IsBusinessPhrase(string s) := TokenManagement.FindToken(businessphrases, s);

export MatchBusinessTokens(set of string32 tokens) :=
		TokenManagement.AnyTokenInSet(businesswords, tokens) OR
		TokenManagement.AnyDigraphInSet(businessphrases, tokens);


// ambiguous words
shared SET OF STRING32 ambigwords := TokenManagement.SortAndTerminateSet(
			SET(dsWordTokens(rule=3), phrase));// : GLOBAL;
export boolean IsAmbiguousWord(string s) := TokenManagement.FindToken(ambigwords, s);

// conjunctive phrases
SET OF STRING32 conjunctives := TokenManagement.SortAndTerminateSet(ConjunctiveTokens);
export boolean IsInConjuctives(string s) :=
				TokenManagement.FindToken(conjunctives, s);                                                                                                     

shared dataland := '~thor40_241::';	//		'~thor40_241::;	//'~thor200_144::';
shared cluster :=  map(Thorlib.Daliservers() in ['10.173.231.12:7070', '10.173.11.12:7070'] => data_services.data_location.prefix() + 'thor_data400::',
									     _Control.ThisEnvironment.name='Dataland' => dataland,
											 '~thor_data400::');
// shared cluster :=  IF(Thorlib.Daliservers()='10.173.11.12:7070',ut.foreign_prod + '~thor_data400::',IF(_Control.ThisEnvironment.name='Dataland', dataland,'~thor_data400::'));

export filename_fnames		:= cluster + 'base::nid::firstnames';
export filename_lnames		:= cluster + 'base::nid::lastnames';

shared layout_name_count := record
		string20 name;
		integer8 male_cnt;
		integer8 female_cnt;
		integer8 fname_cnt;
		integer8 lname_cnt;
		decimal6_3 pct_fname;
		decimal6_3 pct_lname;
		integer8 gender_cnt;
		integer8 placement_cnt;
end;
shared filter := ['AA','NONAME','AND','OK','OR','II','III','JR','SR','NONEOFYOURBU',
			'NFM','NMN'];
export file_all_lnames := DATASET(filename_lnames,layout_name_count, FLAT)
							(LENGTH(TRIM(name)) > 1, name NOT IN filter, ~IsBusinessWord(name));
export file_lnames := file_all_lnames(pct_lname > 0.25);
export file_fnames := DEDUP(
						DATASET(filename_fnames, layout_name_count, FLAT)
						(name NOT IN filter,pct_fname > 0.15, ~IsBusinessWord(name))
							//+ FirstNames.xtranames
							+ file_all_lnames(pct_fname > 0.25),
							name);
					
//shared dsFirstNames := Firstnames;
shared dsFirstNames := DATASET(MAP(Thorlib.Daliservers() in ['10.173.231.12:7070', '10.173.11.12:7070'] => data_services.data_location.prefix(), '') + '~thor::nid::aux::firstnames',{string20 name, string1 gender},THOR);
// shared dsFirstNames := DATASET('~thor::nid::aux::firstnames',{string20 name, string1 gender},THOR);

fnames := SET(file_fnames, name) + SET(dsFirstNames, name);	
//export boolean IsFirstName(string name) := IF(name='', false, name in fnames);
SET OF STRING32 firstnameSet := TokenManagement.SortAndTerminateSet(fnames);	
export boolean IsFirstNameBasic(string name) := TokenManagement.FindToken(firstnameSet, name);

export boolean IsFirstName(string name) := 
		IsFirstNameBasic(name) 
		//OR Nicknames.IsNickName(name) 
		//OR Nid.PreferredNameExists(name)
		OR IndianNames.IsIndianName(name)
		OR ArabicNames.IsArabicName(name) OR hebrewNames.IsHebrewName(name)
		OR OrientalNames.IsOrientalName(name);
		//OR name='NFN';
//export SET OF STRING32 businesswords := Address.TokenManagement.SortAndTerminateSet(
//			SET(PROJECT(Address.WordTokens(rule=2),bxform(LEFT)), phrase));// : GLOBAL;

girls := file_fnames(Length(TRIM(name)) > 1, (female_cnt*100)/(male_cnt+female_cnt) > 50);
setOfGirls := SET(girls,name) + SET(dsFirstNames(gender in ['F','N']), name);
shared SET OF STRING32 femaleNames := TokenManagement.SortAndTerminateSet(setOfGirls);	
boys := file_fnames(Length(TRIM(name)) > 1, (male_cnt*100)/(male_cnt+female_cnt) > 50);
setOfBoys := SET(boys,name) + SET(dsFirstNames(gender in ['M','N']), name);
shared SET OF STRING32 maleNames := TokenManagement.SortAndTerminateSet(setOfBoys);

shared CommonFirstNames := ['ANDREA','AL','AMANDA','ANDREA','ANN','CHERYL','CHRISTINE','CINDY','CYNTHIA',
			'DARRYL','EILEEN','ELAINE','GLORIA',
			'JAN','JANET','JEANNE','JENNIFER','JILL','JUDY','JUDITH','KAREN',
			'MARIE','MARIA','MARIO','MARY','MARILYN','NORMA','PEGGY',
			'SANDRA','SHEILA','SUE','SUSAN','TAMMY'];

lonly := JOIN(file_lnames, CensusSurnames, LEFT.name=RIGHT.name, 
			TRANSFORM({string32	name}, SELF.name := LEFT.name),
			LEFT ONLY)(name NOT IN filter);



census := TABLE(CensusSurnames(name NOT IN filter + CommonFirstNames),{string32	name := CensusSurnames.name});

//lnames := SET(file_lnames, name);	// : GLOBAL;
lnames := SET(census + lonly, name) + ['VERSANT','ACKLIE','WHITTERN','POYLE','PENAGLERT','VASILY','HANIA','BEYHAN','GARETT'];	// : GLOBAL;

/******
The standard list of last names is derived from two sources:
	1) The insurance header
	2) The list of surnames from the 2000 US Census

*******/
SET OF STRING32 lastnames := TokenManagement.SortAndTerminateSet(lnames);	
export boolean IsLastName(string name) := TokenManagement.FindToken(lastnames, name);

set of STRING32 cnames := TokenManagement.SortAndTerminateSet(SET(CensusSurnames,name));
export boolean isCensusName(string name) := TokenManagement.FindToken(cnames, name);

SET of STRING1 genders := 
['U', // unknown
 'M', // male
 'F', // female
 'N'  // either
];
export string1 gender(string name) := FUNCTION
// 0: unknown  1: male  2: female  3: either
	n := MAP(
		LENGTH(name) = 1 => 0,
		TRIM(name) = '' => 0,
		IF(
			TokenManagement.FindToken(maleNames, name) OR
			IndianNames.IsIndianBoysName(name) OR
			ArabicNames.IsArabicBoysName(name) OR
			HebrewNames.IsHebrewBoysName(name) OR
			OrientalNames.IsOrientalBoysName(name)
			,1, 0) 
				+
		IF(
			TokenManagement.FindToken(femaleNames, name) OR
			IndianNames.IsIndianGirlsName(name) OR
			ArabicNames.IsArabicGirlsName(name) OR
			HebrewNames.IsHebrewGirlsName(name) OR
			OrientalNames.IsOrientalGirlsName(name)
			, 2, 0)
		);

    RETURN CASE(n,
		1 => 'M',
		2 => 'F',
		IF(LENGTH(name) > 1, datalib.gender(name),
			genders[n+1])
	);
END;

export string1 genderEx(string fnamex, string mnamex = '') := FUNCTION
	fname := TRIM(fnamex);
	mname := TRIM(mnamex);
	g := gender(fname);
	return IF (g in ['M','F'],g, gender(mname));
END;

rgxLastReversed := 	
	'^([A-Z]+) +(DI|DA|DEL|DES|DE|MC|VON|ST|EL)$';
		
rgxAllConsonants := '\\b([B-DF-HJ-NP-TVWXZ]{3,})\\b';	
rgxManyConsonants := '([B-DF-HJ-NP-TVWXZ]{7,})';	
rgxHonor := 
 '(MD|DMD|DDS|CPA|DR|PHD|ESQ|RN|LN|DO|DC|DPM|DPC|DD|LMT|DVM|PSYD|ASID|CLU|JD|OD|CFP|AA|AS|NP|ARNP|MSW|LCSW|LSW|ACSW|LMHC|LMFT|CMT|LPCC|MA|PT|SJ)';
 
boolean CheckConsonantName(string name) := 
		REGEXFIND('\\b' + rgxHonor + '\\b', name) OR	// could be a honor
		IsLastName(name) OR		// strange last name
		IsFirstName(name) OR		// misspelled first name
		OrientalNames.IsOrientalSurName(name) OR
		name in ['NFN','NMN'];


boolean InvalidConsonantString(string name) := 
	IF(REGEXFIND(rgxAllConsonants, name),
		~CheckConsonantName(REGEXFIND(rgxAllConsonants, name, 1)),
	REGEXFIND(rgxManyConsonants,name));

boolean NameHyphenInitial(string name) := IF(REGEXFIND('\\b[A-Z]{2,}-[A-Z] ', name), 
		NOT IsFirstName(REGEXFIND('\\b([A-Z]{2,})-[A-Z] ', name, 1)),		// GARCIA-R
		false);


export boolean InvalidNameFormat(string name) := 
	REGEXFIND('^[A-Z]+ +(JR|SR|NMN|NMI|II|III|IV)$', name)	OR	// NAME JR
	REGEXFIND('^[A-Z] +[A-Z] +(JR|SR|I|II|III|IV|V)$', name) OR	// A B JR
	REGEXFIND('^(JR|SR|MC|ST|NMN|NMI|ATTN) +[A-Z]+$', name)	OR	// JR NAME
	REGEXFIND('\\b(JR|SR|II|III|IV) +(JR|SR|II|III|IV)$', name)	OR	// JR JR
	REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]+Q\\b', name) OR
	REGEXFIND(rgxLastReversed, name) OR
	REGEXFIND('^[A-Z]+ +[A-Z]* *[A-Z]+[0-9][A-Z]+$',name) OR	// embedded numeral
	REGEXFIND('([A-Z])\\1{3,}',name) OR			// repeated character
	REGEXFIND('^[A-Z] +[A-Z]$', name) OR	// A B
	REGEXFIND('^[A-Z] +[A-Z] +[A-Z]$', name) OR	// A B C
	REGEXFIND('\\b([B-HJ-Z])\\1{2,}', name) OR	// XXX (except AAA and III)
	REGEXFIND('\\b([AI])\\1{4,}', name) OR	// XXX (except AAA and III)
	REGEXFIND('^([A-Z]+) \\1$', name) OR	// DURAN DURAN
	REGEXFIND('^[A-Z]-[A-Z]\\b', name) OR	// ^A-B
	REGEXFIND('\\b[A-Z]-[A-Z]$', name) OR	// A-B$
	NameHyphenInitial(name) OR
	REGEXFIND('\\b(AND|OR)$', name)	OR	// ends with "AND"
	REGEXFIND('^(AND|OR)\\b', name)	OR	// begins with "OR"
	REGEXFIND('\\b(ERROR|ISSUED)\\b', name)	OR	// 
	REGEXFIND('^COOKIE +[A-Z]* +MONSTER$', name) OR 
	REGEXFIND('^I LIKE +[A-Z]*\\b', name)	OR	// 
	REGEXFIND('\\b(LT|FT|DL|JT|HW)\\b',name) OR  // unprocessed abbreviations
	REGEXFIND('^[A-Z][A-Z] [A-Z][A-Z]$',name) OR
	REGEXFIND('^[A-Z]+ [A-Z] (ST|MC)$',name) OR
	REGEXFIND('\\b[0-9]+ [A-Z]+ (ST|STREET|RD|DR|DRIVE)\\b',name) OR
	REGEXFIND('\\b\\d{2,}\\b',name) OR
	InvalidConsonantString(name);

/*
export integer InvalidNameFormatDebug(string name) := MAP(
	REGEXFIND('^[A-Z]+ +(JR|SR|NMN|NMI|II|III|IV)$', name) => 1,	// NAME JR
	REGEXFIND('^[A-Z] +[A-Z] +(JR|SR|I|II|III|IV|V)$', name) => 2,	// A B JR
	REGEXFIND('^(JR|SR|MC|ST|NMN|NMI|ATTN) +[A-Z]+$', name)	=> 3,	// JR NAME
	REGEXFIND('\\b(JR|SR|II|III|IV) +(JR|SR|II|III|IV)$', name)	=> 4,	// JR JR
	REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]+Q\\b', name) => 5,
	REGEXFIND(rgxLastReversed, name) => 6,
	REGEXFIND('^[A-Z]+ +[A-Z]* *[A-Z]+[0-9][A-Z]+$',name) => 7,	// embedded numeral
	REGEXFIND('^[A-Z] +[A-Z]$', name) => 8,	// A B
	REGEXFIND('^[A-Z] +[A-Z] +[A-Z]$', name) => 9,	// A B C
	REGEXFIND('\\b([B-HJ-Z])\\1{2,}', name) => 10,	// XXX (except AAA and III)
	REGEXFIND('\\b([AI])\\1{4,}', name) => 11,	// XXX (except AAA and III)
	REGEXFIND('^([A-Z]+) \\1$', name) => 12,	// DURAN DURAN
	REGEXFIND('^[A-Z]-[A-Z]\\b', name) => 13,	// ^A-B
	REGEXFIND('\\b[A-Z]-[A-Z]$', name) => 14,	// A-B$
	NameHyphenInitial(name) => 15,
	REGEXFIND('\\b(AND|OR)$', name)	=> 15,	// ends with "AND"
	REGEXFIND('^(AND|OR)\\b', name)	=> 16,	// begins with "OR"
	REGEXFIND('\\b(ERROR|ISSUED)\\b', name)	=> 17,	// 
	REGEXFIND('^COOKIE +[A-Z]* +MONSTER$', name) => 18, 
	REGEXFIND('^I LIKE +[A-Z]*\\b', name) => 19,	// 
	REGEXFIND('\\b(LT|FT|DL|JT|HW)\\b',name) => 20,  // unprocessed abbreviations
	REGEXFIND('^[A-Z][A-Z] [A-Z][A-Z]$',name) => 21,
	REGEXFIND('^[A-Z]+ [A-Z] (ST|MC)$',name) => 22,
	REGEXFIND('\\b[0-9]+ [A-Z]+ (ST|STREET|RD|DR|DRIVE)\\b',name) => 23,
	InvalidConsonantString(name) => 24,
	0);
*/
END;
import lib_DataLib, STD, Address; //, LIB_Word; //IDL_Header,
/*************
This module is used by the name repository to look up likely first and last names
*************/
EXPORT NameTester := MODULE

export rWord := RECORD
	string32	word;
END;

//shared dsWordTokens := WordTokens;
/*frn :=  MAP(
         Thorlib.Daliservers() in LogsThor => Data_Services.foreign_prod,
				_Control.ThisEnvironment.name in ['Dataland','Prod_Thor'] => '~',
        '~');
*/
shared dsWordTokens := Address.WordTokens;
								//DATASET(frn +
								//	'thor::nid::aux::businesstokens',Layout_Weighted_Tokens, THOR);	// : GLOBAL(FEW);
shared dsBusinesswords := dsWordTokens(rule IN [1,2],~REGEXFIND('[A-Z0-9] [A-Z0-9]',phrase)); // single words
shared dsBusinessPhrases := dsWordTokens(rule IN [1,2],REGEXFIND('[A-Z0-9] [A-Z0-9]',phrase)); // double words
shared dictBizWords := DICTIONARY(dsBusinesswords, {phrase => rule});
shared dictBizPhrases := DICTIONARY(dsBusinessPhrases, {phrase => rule});

//boolean IsBusinessWord(string s) := EXISTS(dsBusinesswords(phrase=s), KEYED);
export boolean IsBusinessWord(string s) := s in dictBizWords;
export boolean IsBusinessPhrase(string s) := s in dictBizPhrases;

// business words						

//boolean MatchBusinessTokens1(DATASET({string word}) t1, DATASET({string word}) t2) := 
export MatchBusinessTokens(DATASET(rWord) t1, DATASET(rWord) t2) := COUNT(t1(IsBusinessWord(word))) > 0 OR COUNT(t2(IsBusinessPhrase(word))) > 0;
//export MatchBusinessTokens(set of string32 tokens) := IF(COUNT(tokens)=0,false,
//			MatchBusinessTokens1(DATASET(tokens, {string word})));
		//Address.TokenManagement.AnyTokenInSet(businesswords, tokens) OR
		//Address.TokenManagement.AnyDigraphInSet(businessphrases, tokens));
		
//export boolean HasBusinessWord(string s) := 
//	MatchBusinessTokens(Address.TokenManagement.TokenSet(s, Address.TokenManagement.TokenCount(s)));


// ambiguous words
//export boolean IsAmbiguousWord(string s) := TokenManagement.FindToken(ambigwords, s);
shared dsAmbigWords := dsWordTokens(rule =3); 
shared dictAmbigWords := DICTIONARY(dsAmbigWords, {phrase => rule});
export boolean IsAmbiguousWord(string s) := s in dictAmbigWords;

// conjunctive phrases
//SET OF STRING32 conjunctives := TokenManagement.SortAndTerminateSet(ConjunctiveTokens);	// : GLOBAL(FEW);
shared dictConjunctiveTokens := DICTIONARY(DATASET(Address.ConjunctiveTokens,{string phrase}), {phrase => true});
export boolean IsInConjuctives(string s) := s in dictConjunctiveTokens;
//				TokenManagement.FindToken(conjunctives, s);                                                                                                     


shared layout_name_count := record
		string20 name;
		integer8 male_cnt := 0;
		integer8 female_cnt := 0;
		integer8 fname_cnt := 0;
		integer8 lname_cnt := 0;
		decimal6_3 pct_fname := 0;
		decimal6_3 pct_lname := 0;
		integer8 gender_cnt := 0;
		integer8 placement_cnt := 0;
end;
shared rName := record
		string20	name;
end;

shared filter := ['AA','NONAME','AND','OK','OR','II','III','JR','SR','NONEOFYOURBU',
			'NFM','NMN','COMPANY','COMPUTER'];
notfirst := ['LUCKNER'];			// names that slipped through the cracks

//export file_fnames := DEDUP(SORT(DISTRIBUTE(
export file_all_fnames := //DATASET(filename_fnames,layout_name_count, FLAT)
							Nid.FirstNameStats
							(LENGTH(TRIM(name)) > 1, name NOT IN filter+notfirst, ~IsBusinessWord(name));	// : GLOBAL(FEW);
export file_all_lnames := //DATASET(filename_lnames,layout_name_count, FLAT)
							PROJECT(Nid.LastNameStats, recordof(file_all_fnames))
							(LENGTH(TRIM(name)) > 1, name NOT IN filter, ~IsBusinessWord(name));	// : GLOBAL(FEW);
							
export file_fnames := DEDUP(
						//DATASET(filename_fnames, layout_name_count, FLAT)
						file_all_fnames(pct_fname > 0.15)
						//(name NOT IN filter+notfirst,pct_fname > 0.15, ~IsBusinessWord(name))
							//+ FirstNames.xtranames
							+file_all_lnames(pct_fname > 0.25),
							//+ PROJECT(file_all_lnames(pct_fname > 0.25),recordof(zz_csalvo.FirstNameStats)),
							//HASH(name)), name, LOCAL),
							name, ALL);	// : GLOBAL(FEW);
//export file_hifnames := DEDUP(SORT(DISTRIBUTE(			// high percentage first names
export file_hifnames := DEDUP(				// high percentage first names
						//DATASET(filename_fnames, layout_name_count, FLAT)
						file_all_fnames(pct_fname > 0.5),
						//(name NOT IN filter+notfirst,pct_fname > 0.5, ~IsBusinessWord(name)),
							//HASH(name)), name, LOCAL),
							name, ALL);	// : GLOBAL(FEW);

export file_lnames := file_all_lnames(pct_lname > 0.25);

				
//shared dsFirstNames := Firstnames + FirstNames2;
/*export dsFirstNames := DATASET(
				MAP(
         Thorlib.Daliservers() in LogsThor => Data_Services.foreign_prod,
				_Control.ThisEnvironment.name in ['Dataland','Prod_Thor'] => '~',
        '~') +
					'thor::nid::aux::firstnames',{string20 name, string1 gender},THOR);
*/					
shared rFirstNames := {string20 name, string1 gender};
dsFirstNamesPrelim := DEDUP(SORT(DISTRIBUTE(Address.FirstNames+Address.FirstNames2,hash(name))
																	,name,gender,LOCAL),name,gender,LOCAL);
// remove probable last names from the list
shared nm := dsFirstNamesPrelim;

lnm := file_all_lnames;
j1 := JOIN(lnm, nm, left.name = right.name, INNER);
shared k := PROJECT(j1(pct_fname < 0.15), recordof(nm));
shared dictLoPctFnames := DICTIONARY(k, {name => true});	
export dsFirstNames := nm - k;

					
//fnames := SET(file_fnames, name) + SET(dsFirstNames, name);	
dsFnames := DEDUP(TABLE(file_fnames,{file_fnames.name})  + TABLE(dsFirstNames,{dsFirstNames.name}), name, ALL); 
dictFnames := DICTIONARY(dsFNames, {name => true});
export boolean IsFirstNameBasic(string name) := name in dictFnames;
//TokenManagement.FindToken(firstnameSet, name);

//hifnames := SET(file_hifnames, name);	
//SET OF STRING32 hifirstnameSet := TokenManagement.SortAndTerminateSet(hifnames);	// : GLOBAL(FEW);	
dictHiFnames := DICTIONARY(file_hifnames, {name => true});
export boolean IsHiPctFirstName(string name) := name in dictHiFnames;
export boolean IsLoPctFirstName(string name) := name in dictLoPctFnames;


export boolean AAposName(string name) := IF(						//A'ALYSHIA SHANIA SIMS
    name[1..2] = 'A\'', IsFirstNameBasic(name[3..]), false);																																																			

export boolean IsFirstName(string name) := 
		IsFirstNameBasic(name) 
		//OR Nicknames.IsNickName(name) 
		//OR Nid.PreferredNameExists(name)
		OR Address.IndianNames.IsIndianName(name)
		OR Address.ArabicNames.IsArabicName(name) OR Address.hebrewNames.IsHebrewName(name)
		OR Address.OrientalNames.IsOrientalName(name) OR Address.JapaneseNames.IsJapaneseName(name)
		OR AAposName(name);
		//OR name='NFN';

/*
In these cases, the last name may be unrecognizable
*/
export boolean IsEthnicFirstName(string name) := 
		Address.IndianNames.IsIndianName(name)
		OR Address.ArabicNames.IsArabicName(name) OR Address.hebrewNames.IsHebrewName(name)
		OR Address.OrientalNames.IsOrientalName(name) OR Address.JapaneseNames.IsJapaneseName(name)
	;

girls := file_fnames(Length(TRIM(name)) > 1, (female_cnt*100)/(male_cnt+female_cnt) > 50);
//setOfGirls := SET(girls,name) + SET(dsFirstNames(gender in ['F','N']), name);
dsGirls := DEDUP(TABLE(girls,{girls.name})  + TABLE(dsFirstNames(gender in ['F','N']),{dsFirstNames.name}), name, ALL);
shared dictGirls := DICTIONARY(dsGirls, {name => true});
//shared SET OF STRING32 femaleNames := TokenManagement.SortAndTerminateSet(setOfGirls);	
boys := file_fnames(Length(TRIM(name)) > 1, (male_cnt*100)/(male_cnt+female_cnt) > 50);
//setOfBoys := SET(boys,name) + SET(dsFirstNames(gender in ['M','N']), name);
//shared SET OF STRING32 maleNames := TokenManagement.SortAndTerminateSet(setOfBoys);
dsBoys := DEDUP(TABLE(boys,{boys.name})  + TABLE(dsFirstNames(gender in ['M','N']),{dsFirstNames.name}), name, ALL);
shared dictBoys := DICTIONARY(dsBoys, {name => true});

shared CommonFirstNames := ['ANDREA','AL','AMANDA','ANDREA','ANN','CHERYL','CHRISTINE','CINDY','CYNTHIA',
			'DARRYL','EILEEN','ELAINE','GLORIA','JACKIE',
			'JAN','JANET','JEANNE','JENNIFER','JILL','JUDY','JUDITH','KAREN','KEN',
			'MARIE','MARIA','MARIO','MARY','MARILYN','NORMA','PEGGY',
			'SANDRA','SHEILA','SUE','SUSAN','TAMMY','WILLIAM'];

//n1 := PROJECT(file_all_fnames, rName);
//n1 := file_all_fnames + file_all_lnames;
			//DATASET(filename_fnames, layout_name_count, THOR)
			//zz_csalvo.FirstNameStats(LENGTH(TRIM(name)) > 1,name NOT IN filter,~IsBusinessWord(name));
//export idlnames := DEDUP(SORT(DISTRIBUTE(n1(pct_lname > 0.15), hash(name)),name,FEW,LOCAL),name,LOCAL);
//n1 := DATASET(filename_fnames, layout_name_count, THOR)(LENGTH(TRIM(name)) > 1,name NOT IN filter,~IsBusinessWord(name));
n1 := file_all_fnames;
export idlnames := DEDUP(SORT(DISTRIBUTE(n1+file_all_lnames,hash(name)),name,LOCAL),name,LOCAL);

//export census := DISTRIBUTE(Address.CensusSurnames(name NOT IN filter, ~IsBusinessWord(name)),hash(name));
export census := DISTRIBUTE(Nid.CensusSurnames(name NOT IN filter, ~IsBusinessWord(name)),hash(name));
export newnames := JOIN(census, idlnames, LEFT.name=RIGHT.name, 
			TRANSFORM(layout_name_count,
				SELF.name := LEFT.name;
				SELF := LEFT;),
			LEFT ONLY, FEW, LOCAL);
export common := JOIN(idlnames, census, LEFT.name=RIGHT.name, 
			TRANSFORM(layout_name_count,
				SELF.name := LEFT.name;
				SELF := LEFT;),
			INNER, FEW, LOCAL)(pct_lname > 0.15);	// : GLOBAL(FEW);
			


//lnames := SET(file_lnames, name);	// : GLOBAL;
//lnames := SET(common + newnames, name) +
xlnames := DATASET([
 {'VERSANT'},{'ACKLIE'},{'WHITTERN'},{'POYLE'},{'PENAGLERT'},{'VASILY'},{'HANIA'},{'BEYHAN'},{'GARETT'},{'KRCH'},
{'PRAICO'},
{'BANCACO'},
{'BRUTICO'},
{'IUSICO'},
{'DEFRANSISCO'},{'EMR'},
{'FADY'},
{'TESFAZION'},
{'LOOB'},
{'BETANCORP'},
{'AARON'},{'SOKUNBI'},{'DENNIS'}
], layout_name_count);
/*
// Uncategorized surnames, maintained here for now
'AARON',
'SOKUNBI',
'PRAICO',
'BANCACO',
'BRUTICO',
'IUSICO',
'DEFRANSISCO',
'FADY',
'TESFAZION',
'LOOB',
'BETANCORP'
*/
/******
The standard list of last names is derived from two sources:
	1) The insurance header
	2) The list of surnames from the 2000 US Census

*******/
//SET OF STRING32 lastnames := TokenManagement.SortAndTerminateSet(lnames);	
//dictLastNames := DICTIONARY(DATASET(lnames,{string20 name}), {name => true});
dictLastNames := DICTIONARY(common + newnames + xlnames, {name => lname_cnt});
export boolean IsLastName(string name) := name in dictLastNames;

shared rgxHyphenatedSimplename := '^([A-Z]{2,})-([A-Z]{2,})$';
shared rgxCompoundFirstName := '^([A-Z]{2,})(ANN|ANNE|BETH|ELLEN|MAE|LYN|LYNN)$';
// check for hyphenated first names
shared boolean IsFirstNamePart(string name, string partname) :=
	IsFirstNameBasic(partname) and ~IsLastName(name)
		and (partname not in ['MAC','HAM','AB','AM','HEM','LAP','NORM']);
		
export boolean IsFirstNameEx(string name) := MAP(
		IsFirstName(name) => true,
		REGEXFIND('^[A-Z]{2,}-[A-Z]$', name) => IsFirstName(REGEXFIND('^([A-Z]{2,})-[A-Z]$', name, 1)),
		REGEXFIND(rgxHyphenatedSimplename, name) => 
			(IsFirstName(REGEXFIND(rgxHyphenatedSimplename, name, 1)) AND
			IsFirstName(REGEXFIND(rgxHyphenatedSimplename, name, 2))) OR
			IsFirstName(StringLib.StringFilterOut(name,'-')),
		REGEXFIND(rgxCompoundFirstName,name) => 
				IsFirstNamePart(name,REGEXFIND(rgxCompoundFirstName,name,1)),
		REGEXFIND('^[A-Z]{3,}(JR|SR)$',name) => IsFirstName(REGEXFIND('^([A-Z]+)(JR|SR)$',name,1)),
		//name[1..2] in ['LA','DA'] AND LENGTH(name) > 5 => NameTester.IsFirstNameBasic(name[3..]) AND NOT Address.OrientalNames.IsOrientalName(name[3..]),
		false
	);

export boolean IsHyphenatedFirstName(string s) := MAP(
	REGEXFIND('([A-Z]+)-([A-Z]+)', s) => IsFirstName(s) OR
											IsFirstName(REGEXFIND('([A-Z]+)-([A-Z]+)', s, 1)),
	IsFirstname(s));

SET of STRING1 genders := 
['U', // unknown
 'M', // male
 'F', // female
 'N'  // either
];
export string1 gender(string name) := FUNCTION
// 0: unknown  1: male  2: female  3: either
	n := MAP(
		LENGTH(TRIM(name)) <= 1 => 0,
		IF(
			name in dictBoys OR
			Address.IndianNames.IsIndianBoysName(name) OR
			Address.ArabicNames.IsArabicBoysName(name) OR
			Address.HebrewNames.IsHebrewBoysName(name) OR
			Address.OrientalNames.IsOrientalBoysName(name) OR
			Address.JapaneseNames.IsJapaneseBoysName(name)
			,1, 0) 
				+
		IF(
			name in dictGirls OR
			Address.IndianNames.IsIndianGirlsName(name) OR
			Address.ArabicNames.IsArabicGirlsName(name) OR
			Address.HebrewNames.IsHebrewGirlsName(name) OR
			Address.OrientalNames.IsOrientalGirlsName(name) OR
			Address.JapaneseNames.IsJapaneseGirlsName(name)
			, 2, 0)
		);

    RETURN CASE(n,
		1 => 'M',
		2 => 'F',
		IF(LENGTH(TRIM(name)) > 1, datalib.gender(name),
			genders[n+1])
	);
END;

export string1 genderEx(string fnamex, string mnamex = '') := FUNCTION
	fname := TRIM(fnamex);
	mname := TRIM(mnamex);
	g := gender(fname);
	return IF (g in ['M','F'],g, gender(mname));
END;

shared rgxLastReversed := 	
	'^([A-Z]+) +(DI|DA|DEL|DES|DE|MC|VON|ST|EL)$';
shared rgx2DE := '^([A-Z][A-Z]) +(DE|LE)$';		// for certain Chinese names	
		
shared rgxManyConsonants := '([B-DF-HJ-NP-TVWXZ]{7,})';	
shared rgxHonor := 
 '(MD|DMD|DDS|CPA|DR|PHD|ESQ|RN|LN|DO|DC|DPM|DPC|DD|LMT|DVM|PSYD|ASID|CLU|JD|OD|CFP|AA|AS|NP|FNP|ARNP|MSW|LCSW|LSW|ACSW|LMHC|LMFT|CMT|LPCC|MA|PT|SJ)';
 
shared boolean CheckConsonantName(string name) := 
		REGEXFIND('\\b' + rgxHonor + '\\b', name) OR	// could be a honor
		IsLastName(name) OR		// strange last name
		IsFirstName(name) OR		// misspelled first name
		Address.OrientalNames.IsOrientalSurName(name) OR
		name in ['NFN','NMN'];


shared validRepeatedNames := [
'ABRAHAM',
'AHMAD',
'AMR',
'AKOK',
'BOULOS',
'HUSSEIN',
'MAHMOUD',
'MOHAMED',
'MUSLEH',
'NGUYEN',
'OMAR',
'YANG'
];

shared rgxStreet := '^[0-9]+.+ (ROAD|RD|STREET|ST|AVE|AVENUE|DRIVE|DR|PLACE|PATH|LANE|LN|WAY|WY)$';		// street address only


shared boolean NoVowels(string s) :=
	REGEXFIND('^[B-DF-HJ-NP-TVWXZ]{3,}$', s);
//	REGEXFIND('^[^AEIOUY]{3,}$', s);
boolean EmbeddedWords(string s) := 
	REGEXFIND('[A-Z]+(AAA|AUTO|CENTER|COMP|CRAFT|CRYO|DESIGN|EASY|ECONO|EURO|FIRE|FLEX|HOUSE|INFO|INTER|MASTER|MECH|METRO|MULTI|OMNI|PHARM|PLEX|POLY|POWER|PSYCH|SCAPE|SCOPY|SERVICE|SHOP|TECH|TELE|TIONAL|TOWN|TRANS|TRONIC|ULTRA|WARE|WEAR|WORK)[A-Z]+',s);
boolean EndPhrase(string s) := 
	REGEXFIND('[A-Z]{3,}(ANCE|EX|INC|LLC|LLP|ABLE|LAND|MENT|SHIP|CARE|SION|TION|TIONAL|TIONS|TRONIC|TRONICS|CORP|COMPANY|INCORPO|ISTS|ISTIC|FOUNDATION|LAKE|UNITED|SERVICE|SERVICES|SVCS|SCIENCE|SMITHING|MART|MARTS|SIDE|TIC|TICS|VILLE|WORLD|WORK|WORKS)\\b',s);
boolean PrePhrase(string s) := 
	REGEXFIND(
	'\\b(ACCU|AERO|AMERI|ADVANCED|ARCH|AUDIO|AUTO|BANC|BANK|CHEM|COMPU|DATA|ELECTRO|FIRST|HEALTH|INFO|INFRA|INSUR|NEW|NUTRI|OMNI)[A-Z]{2,}'
	,s);		//|BIO|CITI| (too many false hits)
export boolean LikelyBizWord(string word) := PrePhrase(word) OR 
	EmbeddedWords(word) OR EndPhrase(word) or NoVowels(word);
export boolean PossibleBizWord(string word) := LikelyBizWord(word) OR
		REGEXFIND('(CO|ING)$',word);
		
shared rgxLast := '(DI |DA |DEL |DE LA |DE LOS |DES |DE |DELA |DELLA |DELLO |DOS |DU |LA |MC |VON |VAN DEN |VAN DER |VAN DE |VAN |VANDER |VANDEN |ST |SAN |EL |LE |ABU |[ODANL]\')?([A-Z]+[A-Z\'-]+)';
shared rgxLastStrong := '(DI |DA |DEL |DE LA |DELA |DE LOS |DES |DE |DELA |DELLA |DOS |DU |LA |MC |MAC |VON |VAN DEN |VAN DER |VAN DE |VAN DEN |VAN |VANDER |VANDEN |ST |SAN |EL |LE |[ODANL]\'|(A|ABU-EL|ABU|AL|ABDUL|BAR|BEN|BOU|EL|VAN-DEN)-)([A-Z][A-Z-]+)';
shared rgxSpanishLName1 := '([A-Z]+ +(DE LA|DE LOS|DE) +[A-Z]+)';


// determine if name may be multi-part last name
export boolean IsLastNameOnly(string name) := RegexFind('^' + rgxLast + '$', name);
export boolean IsJustLastName(string name) := 
	IF(RegexFind('^' + rgxLastStrong + '$', name),
		NOT IsFirstName(RegexFind('^([A-Z]+) +', name, 1)) and NOT IsLoPctFirstName(RegexFind('^([A-Z]+) +', name, 1)),
		false);
		
shared rgxAllConsonants := '\\b([B-DF-HJ-NP-TVWXZ]{3,})\\b';	

shared boolean InvalidConsonantString(string name) := 
	IF(REGEXFIND(rgxAllConsonants, name),
		~CheckConsonantName(REGEXFIND(rgxAllConsonants, name, 1)),
	REGEXFIND(rgxManyConsonants,name));

shared boolean NameHyphenInitial(string name) := IF(REGEXFIND('\\b[A-Z]{2,}-[A-Z] ', name), 
		NOT IsFirstName(REGEXFIND('\\b([A-Z]{2,})-[A-Z] ', name, 1)),		// GARCIA-R
		false);
		
export boolean InvalidNameFormat(string name) := 
	REGEXFIND('^[A-Z]+ +(JR|SR|NMN|NMI|II|III|IV)$', name)	OR	// NAME JR
	REGEXFIND('^[A-Z] +[A-Z] +(JR|SR|I|II|III|IV|V)$', name) OR	// A B JR
	REGEXFIND('^(JR|SR|MC|ST|NMN|NMI|ATTN|CEO) +[A-Z]+$', name)	OR	// JR NAME
	REGEXFIND('^[A-Z]+[, ]+(JR|SR|II|III|IV|MC|ST|NMN|NMI|ATTN)$', name)	OR	// NAME, JR
	REGEXFIND('\\b(JR|SR|II|III|IV|VI|VII|[0-9]) +(JR|SR|II|III|IV|VI|VII|[0-9])\\b', name)	OR	// JR JR
	REGEXFIND('^[A-Z]+\\b(JR|SR|II|III|IV) +[A-Z]+\\b(JR|SR|II|III|IV)$', name)	OR	// namd JR name JR

	REGEXFIND('\\b[B-DF-HJ-NP-TVWXZ]+Q\\b', name) OR
	(REGEXFIND(rgxLastReversed, name) AND NOT REGEXFIND(rgx2DE, name)) OR
	REGEXFIND('^[A-Z]+ +[A-Z]* *[A-Z]+[0-9][A-Z]+$',name) OR	// embedded numeral
	REGEXFIND('([A-Z])\\1{3,}',name) OR			// repeated character
	REGEXFIND('^[A-Z] +[A-Z]$', name) OR	// A B
	REGEXFIND('^[A-Z] +[A-Z] +[A-Z]$', name) OR	// A B C
	REGEXFIND('^[A-Z] +[A-Z] +[A-Z] [A-Z]{1,2}$', name) OR	// A B C NO
	REGEXFIND('\\b([B-HJ-Z])\\1{2,}', name) OR	// XXX (except AAA and III)
	REGEXFIND('\\b([AI])\\1{4,}', name) OR	// XXX (except AAA and III)
	(REGEXFIND('^([A-Z]+) \\1$', name) AND REGEXFIND('^([A-Z]+)\\b',name,1) NOT IN validRepeatedNames) OR	// DURAN DURAN
	REGEXFIND('^[A-Z]-[A-Z]\\b', name) OR	// ^A-B
	REGEXFIND('\\b[A-Z]-[A-Z]$', name) OR	// A-B$
	NameHyphenInitial(name) OR
	REGEXFIND('\\b(AND|OR)$', name)	OR	// ends with "AND"
	REGEXFIND('^(AND|OR)\\b', name)	OR	// begins with "OR"
	REGEXFIND('\\b(ERROR|ISSUED|BASTARD|BITCH|ASS|PUSSY)\\b', name)	OR	// 
	REGEXFIND('^COOKIE +[A-Z]* +MONSTER$', name) OR 
	REGEXFIND('^GIFT +[A-Z]* +CARD$', name) OR 
	REGEXFIND('^I LIKE +[A-Z]*\\b', name)	OR	// 
	REGEXFIND('^BABY (BOY|DAUGHTER|GIRL)\\b', name)	OR	// 
	REGEXFIND('\\b(LT|FT|NT|DL|JT|HW|AKA)\\b',name) OR  // unprocessed abbreviations
//	REGEXFIND('^[A-Z][A-Z] [A-Z][A-Z]$',name) OR
	REGEXFIND('^[A-Z]+ [A-Z] (ST|MC)$',name) OR
	REGEXFIND(rgxStreet,name) OR
	InvalidConsonantString(name);

shared rgxBasic := '([A-Z]+)';
shared rgxGen := '(JR|SR|I|II|III|IV|V|VI|VII|VIII|IX|2ND|3RD|THRD|03|4TH|5TH|6TH|1|2|3|4|5|6|7|8|9)';
shared rgxSureGen := '(JR|SR|II|III|IV|VI|VII|VIII|IX|2ND|3RD|THRD|03|4TH|5TH|6TH|1|2|3|4|5|6|7|8|9)';
shared rgxSureHonor := 	// no oriental names
 '(MD|DMD|DDS|CNFP|CNM|CNP|CPA|CSW|DR|PHD|ESQ|RN|LN|DC|DPM|DPC|DD|LMT|DVM|PSYD|ASID|CLU|JD|OD|CFP|AA|NP|ARNP|MSW|LCSW|LSW|ACSW|LMHC|LMFT|CMT|LPCC|PT|SJ|MBA|MSD|CTM|DTM|CPS|ADJ|DWP|SEC|VDM|VMD|PA-C|PA|RPA-C|RPA|APA-C|CRNA|MBBS|PNP|RNP|CNS)';
shared rgxSuffix := '(' + rgxGen + '|' + rgxHonor + ')';
shared rgxSureSuffix := '(' + rgxSureGen + '|' + rgxSureHonor + ')';
shared rgxFMLS := '^' + rgxBasic + ' +' + rgxBasic + ' +(' + rgxLast + ') +' + rgxSuffix + '$';
shared rgxFLSorLFS := '^' + rgxBasic + ' +'  + rgxBasic + ' +' + rgxSuffix + '$';

export IsSuffix(string name) := REGEXFIND('^'+rgxSuffix+'$',name);
// uninclude suffixes that could possibly be names
export IsSureSuffix(string name) := REGEXFIND('^'+rgxSureSuffix+'$',name);
export HasSuffix(string name) := REGEXFIND(rgxFMLS,name) OR REGEXFIND(rgxFLSorLFS,name);

export boolean InvalidFirstName(string name) := name in ['NFN','NMN','NMI','NT','ASS','BASTARD'];

shared ShortLastNames := ['NG','OK','OX','UI','KU','DO','JO','RO','UX','KRCH','LI'];
shared BadLastNames := ['ASS','AV','NMN','NMI','NLN','ERROR', 'RET','RE','XX','XY','OR','ET','AKA',
							'MC','ST','HW','FR','CH','SM','ME','AS','LC','EST','COC','NT','PUSSY','BASTARD','BITCH'];

export boolean InvalidLastName(string name) := 
	Length(name) < 2 OR
	Length(name) > 25 OR
	IsSureSuffix(name) OR		// don't consider suffixes as last names
	REGEXFIND('^[A-Z]-[A-Z]$',name) OR		// A-B
	name in  BadLastNames OR
	(name not in ShortLastNames AND REGEXFIND('^[B-DF-HJ-NP-TVWXZ]{2,}$',name)) 
	OR IsBusinessWord(name);

// should replace InvalidLastName when tested
export boolean InvalidLastName1(string name) := 
	Length(name) < 2 OR
	Length(name) > 25 OR
	IsSureSuffix(name) OR		// don't consider suffixes as last names
	REGEXFIND('^[A-Z]-[A-Z]$',name) OR		// A-B
	name in  BadLastNames OR
	(name not in ShortLastNames AND REGEXFIND('^[B-DF-HJ-NP-TVWXZ]{2,}$',name)) 
	;
// likely last name

export boolean IsLastNameEx(string name) := MAP(
	Length(name) < 2 => false,
	IsSureSuffix(name) => false,
	//IsCensusName(name) => true,
	IsLastName(name) => true,
	IsLastNameOnly(name) => true,
	Address.SpanishNames.IsSpanishSurname(name) => true,
	Address.IndianNames.IsIndianSurname(name) => true,
	Address.ArabicNames.IsArabicSurname(name) => true,
	Address.OrientalNames.IsOrientalSurname(name) => true,
	Address.JapaneseNames.IsJapaneseSurname(name) => true,
	name IN ShortLastNames => true,
	name in  BadLastNames => false,

	REGEXFIND('[A-Z]+(WITZ|WICZ|WISCH|SKI|SKIY|SKY|TZKY|VICH|VITCH|VICZ|VITZ|STEIN|SHTEIN|STEAD|STAD|FELD|BACH|MAN|MANN|DOLPH|IAK|OV|OVIC|ROFF|DORF|LIEB|HAUSEN|SCHI|SCHE|SCHO|EVA|OVA|KAYA|ACK|TZKY|ZYK|RECHT|SCHLING|CHUK|ENKO|SHKIN|EK|ESCU|EANU|GONZA|VANDE|QUIST|BAUM)$',name) => true,	// east european endings
	REGEXFIND('[A-Z](OULOS|OYLOS|ELLIS|IDIS|IADIS|OUDAS|OUKAS|AKIS|OUSIS|SIOS|KONIS|OTIS|ATOS|ITIS)$',name) => true,	// greek endings
	REGEXFIND('^(KARA|PAPA|KONDO|SCHN|STEIN)[A-Z]{2,}$',name) => true,		// greek & otherprefixes
	REGEXFIND('[A-Z]{2,}(SON|SEN|FIELD|SHIRE|BERG|BERRY|BERY|BURG|BURY|CROFT|NESS|WELL|INGTON|ELLS|LAND|WARD|FORD|BODY|DALE|OY|ER|TOM|TRY|ARTON|SHAW|DOTTIR|IAMS|VAND|VILL|WILL|WIRTH)$',name)
						AND NOT IsFirstName(name) => true,		// anglo endings
	REGEXFIND('[A-Z](SWAMY|NKA|OOD|UZ|MURTI|MADI|REVA|REZA|ERJEE|ARJUNA|YAMA|IAN|TULLA)$',name) => true,				// asian endings
	REGEXFIND('[B-DF-HJ-NP-TVWXZ](EZ|ES|IZ)$',name) => true,	// possible spanish name
	//REGEXFIND('[B-DF-HJ-NP-TVWXZ](ITO|ELLI|ANO|ONA|TINI|ACCI|ETTO|COLA|ENCIO|ENZO|ENTO|ETTI|AGNI|ISTA|UCCI|UZZO|DELLA)$',name) AND NOT NameTester.IsFirstName(name) => true,	// possible italian name
	REGEXFIND('[A-Z](ITO|ELLI|ANO|ONA|TINI|ACCI|ETTO|COLA|ENCIO|ENZO|ENTO|ETTI|AGNI|ISTA|UCCI|UZZO|DELLA)$',name) AND NOT IsFirstName(name) => true,	// possible italian name
	REGEXFIND('[B-DF-HJ-NP-TVWXZ]{7,}',name) => false,	// consecutive consonants
	name[1] = 'O' AND IsLastName(name[2..]) => true,
	IsLastName(REGEXFIND('^(O|DU|VAN|DE|DI)([A-Z]{2,})$',name,2)) AND name <> 'DEBORAH' => true,

	REGEXFIND('^(MAC|MC)[A-Z]{2,}$',name) => true,		// scottish prefixes
	REGEXFIND('^[A-Z]-[A-Z]$',name) => false,		// A-B
	REGEXFIND(rgxSpanishLName1, name) => true,
	REGEXFIND('^(AL|ABD|ABDUL|BAR|BEN|BOU|EL|ST)[ -][A-Z]+', name) => true,		// arabic/hebrew name: AL-ARABI
	REGEXFIND('^[B-DF-HJ-NP-TVWXZ]{3,}$',name) => false,
	REGEXFIND('^[A-Z]{3,}(JR|SR)$',name) => IsLastName(REGEXFIND('^([A-Z]+)(JR|SR)$',name,1)),
	false);
	
export boolean IsFirstNameOrInitial(string name) :=
	IsFirstNameEx(name) OR (LENGTH(TRIM(name)) = 1);
export boolean IsFirstNameOrInitialOrBlank(string name) :=
	IsFirstNameEx(name) OR (LENGTH(TRIM(name)) <= 1);
	

export rgxDoubleName := '^([A-Z]\'?[A-Z]+)( |-)([A-Z]\'?[A-Z]+)$';
export boolean IsDoubleLastName(string name) :=
					IsLastNameEx(REGEXFIND(rgxDoubleName, name, 1))
							OR IsLastNameEx(REGEXFIND(rgxDoubleName, name, 3));
							
export boolean IsLastNameExOrHyphenated(string name) := 
		IsLastNameEx(name) OR
	      IsDoubleLastName(name);		

export boolean ProbableLastName(string name) := 
	IsLastNameEx(name) OR IsDoubleLastName(name) OR NOT IsFirstName(name);


export boolean IsLastNameConfirmed(string name) := 
	IF(Length(name) < 2 OR
	IsSureSuffix(name),false,			// don't consider suffixes as last names
	IF(IsLastNameEx(name) OR
		//IsLastNameOnly(name) OR
		//IsLastNameHyphenated(name) OR
		IsDoubleLastName(name)
		, true,
	false));
	
export boolean IsValidLastName(string nm) :=
	~InvalidLastName(nm) AND (IsLastNameEx(nm) OR IsDoubleLastName(nm));

			
export IsGeneration(string name) := 
	TRIM(name,LEFT,RIGHT) IN ['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
export IsSureGen(string name) := 
	TRIM(name,LEFT,RIGHT) IN ['JR','SR','II','III','IV','VI','VII','VIII','IX'];
		
export string RemoveDiacritics(string s) := (string)Std.Uni.CleanAccents(s);

//string RemoveInvisible(string s) := STD.Str.FilterOut(s,'\000\032\213\221\222');
string RemoveInvisible(string s) := STD.Str.FilterOut(s,'\000\032');

export string RemoveNonPrintingChars(string s) := REGEXREPLACE('([^ -~]+)', 
												RemoveDiacritics(RemoveInvisible(s)),' ');

END;
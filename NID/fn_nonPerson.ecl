IMPORT STD, Address;

 rgxRemoveSuf := '([A-Z ]+) (I|II|L|SB)';
// remove extraneous suffix from special names
 RemoveSuffix(string s) := TRIM(IF(REGEXFIND(rgxRemoveSuf,s),REGEXFIND(rgxRemoveSuf,s,1),s));

 boolean CountyCheck(string s) := FUNCTION
	phrase4 := '^([A-Z]+) +([A-Z]+)$';
	set of string phrases := [
				'BD','BO','BOARD','BOE','COURT','COURTHOUSE','CT',																
				'DOT','DUMP','EDA','ESD','FAIR','FLOOD','HIWAY','HOME','LAND','LANDFILL','MUD','PAC','PARK','PARKS','POST',
				'PSA','ROADS','ROADWAY',
				'SHERIF','SHERIFF','SHERIFFS','STOCKYARD','STREET','WATER'];

	return MAP (
		Address.SpecialNames.IsCountyName(s) OR Address.SpecialNames.IsStateName(s) OR s in phrases => true,
		REGEXFIND(phrase4,s) =>	 Address.SpecialNames.IsCountyName(REGEXFIND(phrase4, s, 2)) AND
																(Address.SpecialNames.IsStateName(REGEXFIND(phrase4, s, 1)) OR
																REGEXFIND(phrase4, s, 1) IN phrases),
		REGEXFIND('\\b(AGRI|BOARD|CLERK|COMMI|COUR|ASSOC|HEALTH|HOUSING|HWY|INDUS|TREA)', s) => true,
		false);
end;

// check for geographic name
 boolean CheckGeo(string s, string region) := FUNCTION
	name := Std.Str.FindReplace(RemoveSuffix(s),'-', ' ');
	RETURN CASE(region,
		'STATE' => Address.SpecialNames.IsStateName(name),
		'CITY' => Address.SpecialNames.IsCityName(name),
		'TOWN' => Address.SpecialNames.IsCityName(name),
		'TOWNSHIP' => Address.SpecialNames.IsCityName(name),
		'AREA' => Address.SpecialNames.IsCityName(name),
		'COUNTY' => Address.SpecialNames.IsCountyName(name) OR CountyCheck(TRIM(s)),
		'BOROUGH' => Address.SpecialNames.IsCountyName(name),
		'PARISH' => Address.SpecialNames.IsParishName(name),
		false
	);
END;

// Initial & Initial NAME
 MatchType ValidIIName(string name, string word) := MAP(
	$.NameTester.IsAmbiguousWord(word) => MatchType.Business,
	REGEXFIND('^[A-Z] *(&| AND ) *[A-Z]$', name) => MatchType.Inv,
	word = 'ASS' => MatchType.Business,		// J & J Associates
	$.NameTester.IsLastNameEx(word) /*OR NameTester.IsFirstName(word)*/ => MatchType.Dual, 
	$.NameTester.PossibleBizWord(word) => MatchType.Business,
	MatchType.Dual);


 set of string ANames := [
	'GRAND','GREAT','GREATER',
	'NEW','NEWER','SUPER','SWEET','SWEETER',
	'TIDY','WINNING','WOMAN','WOMANS','WOMENS','YOUNGER'
	];

 MatchType IsATypeName(string s) := IF(s in ANames,MatchType.Business, MatchType.NoMatch);

 set of string RNames := [
	'CARRIER', 'COFFEE', 'CRAFT', 'STONE', 'TOWN'
	];
	
 CheckRepeated(string s) := IF(s in RNames,MatchType.Inv, MatchType.NoMatch);

rgxHoa := 
'\\b(ACRES|BAY|CANYON|COURT(S)?|COVE|CREEK(S)?|CROSS(ING)?|DOWNS|FALLS|FARM(S)?|FOUNTAIN|GARDEN(S)?|HILL(S)?|HOLLOW|KNOLL(S)?|LAKE(S)?( [A-Z]+)?|LANE|MANOR|MEADOW(S)?|OAK(S)?|PARK|POINTE|PRAIRIE|RIDGE|SHORE(S)?|TERRACE|TIMBERS|TREE|UNIT [A-Z0-9]+|VIEW|VILLA(S)?|VISTA(S)?|WOODS|[0-9]+)\\b.* (HOA|POA)$';

rgxInmate := '\\b(INMATE # *[A-Z0-9]+)\\b';
rgxBizEndings := '(&| AND ) *(FAB|SPA|SOUND|STORAGE|GR|FEED|TRUCKING|TACKLE|TILE|GEMS|GARDENS|FENCE|RIBS|BISCUIT|BLINDS|HERBS|RENTAL|PETS|DOGS|TOOL|GRILL|WASH|CRAFTS|LABEL|HOBBY|GUN|FLEET|SERVICE|ICE)$';

 boolean MatchPattern(string s) := MAP(
		REGEXFIND('[ ,]("?L[.,]? ?L[.,]? ?[CP][.,"]*)((?=\\s)\\s|$)', s) => true,	// L L C OR LLP
		REGEXFIND('\\b[A-Z]+\'S\\b',s) => true,					// possessive TONY'S
		REGEXFIND('^[A-Z]+[0-9+&]+[A-Z]*$',s) => true,	// was '^[A-Z]+[0-9.+&]*[A-Z]*$'
		REGEXFIND('^(THE|NO|SECOND|THIRD|UNIV|U OF|NEW|LOS|LAS) ', s) => true,
		REGEXFIND('\\bL\\.? ?T\\.? ?D\\.?$', s) => true,	// LTD
		REGEXFIND('\\bP\\.?[CLS]\\.?((?=\\s)\\s|$)', s) => true,	// PC OR PL OR PS
		REGEXFIND(' P\\.A\\.$',s) => true,		// P.A. Professional Association (not Physician's assistant)
		REGEXFIND('^[A-Z]+[ ,.]+P\\.?A\\.?$',s) => true,		// P.A. Professional Association (not Physician's assistant)
		REGEXFIND('(&| AND ) *[A-Z ]+[ ,.]+P\\.?A\\.?$',s) => true,		// P.A. Professional Association (not Physician's assistant)
		REGEXFIND('\\b(M[.]?D[.]?|D[.]?(C|O)[.]?|D[.]?P[.]?M[.]?|D[.]?M[.]?D[.]?|D[.]?D[.]?S[.]?|C[.]?P[.]?A[.]?|O[.]?D[.]?)[ ,]+P[.]?A[.]?$',s) => true,		// P.A. Professional Association (not Physician's assistant)
		REGEXFIND('[A-Z]{2,}(ODONTIC|ODONTICS|OLOGY|OLOGIES|OLOGIST|OLOGICAL|OGRAPHY|GISTICS|OPHICAL|OSCOPY|GRAPHIC|PHYSICS|TRONIC(S)?|SURGERY|DIAGNOSTIC(S)?|DIAGNOSIS|NURSING|THERAPY)\\b', s) => true,
		REGEXFIND('^[A-Z-]+ +(1ST|2ND|3RD|4TH)$',s) => true,	
		REGEXFIND('^[A-Z-]+ +[0-9]$',s) => true,	
		REGEXFIND('\\b[0-9]{2,}[A-Z]+\\b',s) => true,	
		REGEXFIND('\\b[1-9][A-Z]{3,}\\b',s) => true,	
		REGEXFIND('^[A-Z]+ +(&|AND) +[A-Z]+[ ,]*$',s) => true,	//  TOM AND JERRY
		REGEXFIND('(&|\\+| N ) *(FRIENDS|MORE|ASS|ASSC|ASSO|SON(S)?|DAUGHTER(S)?)\\b',s) => true,
		REGEXFIND('[A-Z ,-]+&[A-Z,-]+&[A-Z0-9]',s) => true,		// phrase with two ampersands
//		REGEXFIND('^[^A-Z]',s) => true,
		REGEXFIND('\\b(STORE|TROOP|POST|UNIT|NO|ROUTE|GROUP|PLANT|CENTER|CENTRE|CHAPTER|NUMERO|NUM|AREA|ROOM|BOX|SD|HS|PS|EDWARD JONES|MORGAN STANLEY)\\.? *#?[0-9]+\\b', s) => true,
		REGEXFIND('\\bCIRCLE [A-Z]\\b', s) => true,
		REGEXFIND('\\b[A-Z]+(LLC|DOTCOM)$',s) => true,
		REGEXFIND('\\bD[ /.-]B[ /.-]A\\.?((?=\\s)\\s|$)',s) => true,	// DBA
		//REGEXFIND('^([A-Z]{2,}) +(&|AND) +\\1+ +[A-Z]+$',s) => true,		// 'BRYSON AND BRYSON BUILDERS'
		REGEXFIND('^([A-Z]{2,}) +(&|AND) +\\1+ +(ARCHITEC|ARCHITECT|ATTY|CPA|DDS|DNTS|ESQ|ESQUIRE|LAW|MD|MDS|PRTS)$',s) => true,		// 'BRYSON AND BRYSON DDS'
		REGEXFIND('\\bPA[ /]+(CPA|ATTY|DDS)$',s) => true,		// PA CPA/ATTY etc

//		REGEXFIND(',[^&]+,',s) => true,						// multiple commas wihout intervening ampersand
		REGEXFIND('\\b([A-Z] ){4,}[A-Z] ',s) => true,		// 4 consecutive initials
		REGEXFIND('([A-Z]\\.){3,}\\b',s) => true,				// 3 consecutive initials with periods
//		REGEXFIND('^[A-Z]+\'S\\b',s) => true,		// Begins with 'S
//		REGEXFIND('^ST\\.? +[A-Z]+\'S\\b',s) => true,		// Begins with ST nnn'S
//		REGEXFIND('^[A-Z0-9\'&-]+$',s) => true,
		REGEXFIND(rgxBizEndings, s) => false,					// inserted here for crims
		REGEXFIND(rgxInmate, s) => false,					// inserted here for crims
		REGEXFIND('# ?[0-9][0-9A-Z]*\\b',s) => true,
		REGEXFIND('^[A-Z]+ +# *[A-Z]?[0-9]+$',s) => true, 
		REGEXFIND('\\b[A-Z]+ +AND +[A-Z]+ +AND\\b',s) => true,
		REGEXFIND('^[A-Z] [A-Z] [A-Z]$',s) => true,
		REGEXFIND('^[A-Z] [A-Z&] [A-Z&] [A-Z]$',s) => true,

		REGEXFIND(' \'N\\b',s) => true,
		REGEXFIND('\\bN\' ',s) => true,
		REGEXFIND('[A-Z]*N\' ',s) => true,					// a word ending in N'
		REGEXFIND('^[A-Z]+ *\'N +[A-Z]+$',s) => true,
		REGEXFIND('^[A0-9] +[A-Z]+ (AND|&) (A|AN) +[A-Z]+$',s) => true,	// e.g. A WING AND A PRAYER
		REGEXFIND('^[0-9] +[A-Z] *( AND |&) *(A|AN) +[A-Z]+',s) => true,	// e.g. 3 MEN AND A BABY
		REGEXFIND('^A [A-Z]+ A [A-Z]+$',s) => true,			// e.g. A DAISY A DAY
//		REGEXFIND('^[A-Z] +[A-Z] +[A-Z] +[A-Z]+$',s) => true, // I I I WORD

		REGEXFIND('\\b[NS]\\.?A\\.$', s) => true,	// NA OR SA
		REGEXFIND('\\bP\\.? ?L\\.? ?L\\.? ?C\\.?$', s) => true,	// P L L C
		REGEXFIND('\\bP\\.? ?L\\.? ?L\\.?$', s) => true,	// P L L
		REGEXFIND('\\b(A|L|S)\\.?C\\.?$', s) => true,	// L C or S C or A C
		REGEXFIND('\\bL\\.?[LP][.,"]*$', s) => true,	// LP OR LL
		REGEXFIND('[A-Z]{2,} +[A-Z]{2,} +L P$', s) => true,	// LP 
		REGEXFIND('\\bP\\.? ?[CS]\\.? ?C\\.?$', s) => true,	// PSC (Personal Services Corp) or PCC
		REGEXFIND('\\bU\\.? ?S\\.? ?D\\.?$', s) => true,	// USD (Unified School District)
		//
		REGEXFIND('[A-Z]+ +(FOR|WITH|AT|BY|TO|IN|ON) +[A-Z]+', s) => true,
		REGEXFIND('^A A A--$',s) => true,
		REGEXFIND('\\bA- ',s) => true,

		REGEXFIND(' (CAB|IN)[.,]?$',s) => true,
		// SPECIFIC COMPANIES
		REGEXFIND('\\bH & R BLOCK\\b',s) => true,
		REGEXFIND('^A T *(&| AND ) *T\\b',s) => true,
		//
		REGEXFIND('^[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z]\\.?$',s) => true,	// three initials
		REGEXFIND('^[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z]\\.?$',s) => true,	// 4 initials
		REGEXFIND('^[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z](\\.| ) *[A-Z]\\.?$',s) => true,	// 5 initials
		REGEXFIND('&&\\b',s) => true,
		REGEXFIND('-[A-Z]-',s) => true,
		REGEXFIND(' -[A-Z]+',s) => true,
		REGEXFIND('^([A-Z]+ *, *){2,} +[A-Z]* *(&|AND) +',s) => true,	// MOE, LARRY, AND CURLEY
		REGEXFIND('^[A-Z] +& +[A-Z] +[A-Z]+ AND [A-Z]+',s) => true,	// A&B C and D
		//
//*		REGEXFIND('^[A-Z] *(&| AND ) *[A-Z] +[A-Z]+ +[A-Z]+$',s) => true,	// intial & initial word word
		REGEXFIND('\\bU S A\\b',s) => true,
		REGEXFIND('^A- ',s) => true,
		REGEXFIND('\\bA+ ?\\+ ',s) => true,			// A +
		REGEXFIND('^[A-Z] *\\+ *[A-Z] +[A-Z]{2,}',s) => true,		// A + B SMOKES
		REGEXFIND('^A A A ',s) => true,
		REGEXFIND('^A B C ',s) => true,
		REGEXFIND(' I S D$',s) => true,			// Independent school district
		REGEXFIND('^AAA -',s) => true,
		REGEXFIND('\\b(A/C|A-Z|A/Z|E-Z|F/X)\\b',s) => true,
		
		REGEXFIND('^([A-Z]+) +([A-Z]+) +([A-Z]+) *(&| AND ) *([A-Z]+) CPA$',s) => true,
		

		REGEXFIND('\\bXTRA[A-Z]*\\b',s) => true,						// XTRAORDINAIRE
		REGEXFIND('\\b(A M E|R C|M E|U M|UM|L D S|[A-Z] [A-Z] [A-Z]) +CHURCH\\b',s) => true,
		REGEXFIND('^[A-Z]+ +(II|III|MR)$',s) => true,
//		REGEXFIND('^(MR|MRS|MISS) +[A-Z]+$',s) => true,
		REGEXFIND('\\b[WK][A-Z]{2,3}-(AM|FM|TV)\\b',s) => true, // radio,TV

		REGEXFIND('^[A-Z]+ +(&|AND) +(SON|DAUGHTER)(S)? +[A-Z]+$',s) => true,
		REGEXFIND('\\bBAR B QUE\\b|\\bB B Q\\b|\\bB\\.B\\.Q\\.?\\b', s) => true,
		REGEXFIND('^(GET|GOT|JUST|OH|GO).+(!|\\?)$', s) => true,
		REGEXFIND('^[A-Z] [A-Z] ([A-Z])?/[A-Z]+$', s) => true,		// e.g. 'Y E S/ETC'
		REGEXFIND('@ *HOME\\b', s) => true,
		REGEXFIND('([A-Z])\\1+MARINE', s) => true,
		REGEXFIND('/.+OFFICE', s) => true,
		REGEXFIND('!$', s) => true,
		REGEXFIND('^C\'EST ', s) => true,
		REGEXFIND('^FIRM +[A-Z]+ +LAW$', s) => true,
//		REGEXFIND('\\bLOVE 2 [A-Z]+', s) => true,
		REGEXFIND('\\b[0-9]+ [A-Z]+ (AVE|ST|STREET|RD|DR|DRIVE|ROAD)\\b',s) => true,
		REGEXFIND('^[0-9]+ (AVE|ST|STREET|RD|DR|DRIVE|ROAD)\\b',s) => true,
		REGEXFIND('^(1ST|2ND|3RD|4TH|5TH|FIRST|SECOND|THIRD|FOURTH|FIFTH) (AVE|AVENUE|ST|STREET|RD|ROAD|DR|DRIVE|BANK|FED|HOME|BAPTIST|CHURCH|RATE|CLASS)\\b',s) => true,
		REGEXFIND('^(1ST|2ND|3RD|4TH|FIRST) +([A-Z]+)$',s) => true,
		REGEXFIND('\\b[0-9]+ +[A-Z]+ +[0-9]+ +[A-Z]+\\b',s) => true,
		REGEXFIND('\\bSHERIFF(S)*\\b.*(CITY|COUNTY)\\b',s) => true,
		
		REGEXFIND(' (BIG|LITTLE) [A-Z]\\b',s) => true,
		REGEXFIND('\\b(CAKE|BAKE|BARBER|BOOK|BOTTLE|FEED|GIFT|HOME|PIANO|CANDY|DIVE|PIZZA|SHOE|WINE|WOOD) +(MART|SHOP(S)?|SHOPPE(S)?|SALON|STORE(S)?|SHACK)\\b',s) => true,
		REGEXFIND('\\b(ELEMENTARY|MIDDLE|HIGH|CHRISTIAN|CATHOLIC|DANCE|ART|DRIVERS|SHOE) +(SCHOOL(S)?|SCHOO|SCHO|HS)\\b',s) => true,

		REGEXFIND('^(BUILDERS|HOLDINGS|TRUCKING|GROUP|RANCH|FARMS|HARDWARE|DEV|CATTLE) +[A-Z] +(&|AND) [A-Z]$',s) => true,
		REGEXFIND('\\b(BANK|BUILDERS|HOLDINGS|HOMES|TRUCKING|GROUP|CATTLE|RANCH|FARMS|HARDWARE|DEV)[, ]+(L C|LC|N A|NA|L P|C O|P C|LP|TRUST|[1-9]|I+|IV|V)[,]*$',s) => true,
		REGEXFIND('\\b(US|U S|AMORE|COLE TAYLOR|HOUSEHOLD|IMPERIAL|MARQUETTE|SHAMUT) +(BANK|HOME(S)?|STEEL|TAX)\\b',s) => true,
		REGEXFIND('\\b(AUTO|CAR|EYE|HOME|LAWN|MED) +(CARE|CA RE)\\b',s) => true,
		REGEXFIND('\\b(BB *& *T|SB *& *T|CB *& *S|H *& *R BLOCK|F *& *M) +BANK\\b',s) => true,
		REGEXFIND('\\b(FED|AMERICAN|CALIFORNIA|COLONIAL|IMPERIAL|PACIFIC|WESTERN) [ST] *& *L\\b',s) => true,
		REGEXFIND('\\bFUND ([0-9]|I|II|III|IV|V|VI|VII|VIII|IX|X|XI|XII|XVIII)\\b',s) => true,
		REGEXFIND('^[A-Z-]{3,} +\\d{2,}$',s) => true,	// name number:  probable store number
		REGEXFIND('^[A-Z]+ [A-Z] [A-Z] [A-Z] [A-Z]$',s) => true, 	// SUNTRUST B A N K
		REGEXFIND('^[A-Z]+ +[A-Z]+ *( AND |&) *[A-Z]+ +(MD(S)?|DDS|DPM|ATTY|CPA|VETERINARIANS)?$',s) => true, 	// ROGER KOLPACOFF & MUNDALL MDS
		REGEXFIND('\\bA (GUY|LOCK|WING) *( AND |&) *A (GIRL|SAFE|PRAYER)\\b',s) => true, 	// ROGER KOLPACOFF & MUNDALL MDS
		REGEXFIND('\\b(CARPET|RUG|GOLF|SNOW|NEWS|TAX|SPA|DIESEL|SALES|MOBILE|TRAILER|HOME|LIMO|TRUCKING) +SERVICE\\b', s) => true,
		REGEXFIND(rgxHoa,s) => true,
		false
	);

boolean Check0ForO(string s) := 
	//IF(REGEXFIND('\\b([A-Z]*0[A-Z]+)\\b', s),
	IF(StringLib.StringFind(s, '0', 1) > 0,
		$.NameTester.IsFirstName(StringLib.StringFindReplace(REGEXFIND('\\b([A-Z]+0[A-Z]+)\\b', s, 1),'0','O')),
		false);

boolean MatchRepeatedWord(string s) :=
	IF(REGEXFIND('^([A-Z]+) +[A-Z]+ +\\1$',s) OR		// word xxx word (word is repeated)
		REGEXFIND('^([A-Z]+) +[A-Z]+ +[A-Z] +\\1$',s),	// word xxx y word (word is repeated)
		REGEXFIND('^([A-Z]+) ', s, 1) IN RNames, false);

boolean CheckParentsOf(string s) := 
		$.NameTester.IsBusinessWord(s) OR $.NameTester.IsAmbiguousWord(s);

boolean IsConjunctive(string phrase, string s) := FUNCTION
	conjunctive := REGEXFIND(phrase, s, 1) + ' & ' + REGEXFIND(phrase, s, 3);
	alternate := REGEXFIND(phrase, s, 3) + ' & ' + REGEXFIND(phrase, s, 1);
	return IF(REGEXFIND(phrase, s),
				$.NameTester.IsInConjuctives(conjunctive) OR $.NameTester.IsInConjuctives(alternate),
			false);
END;

		
// check for geographic name
boolean IsGeo(string s1) := FUNCTION
	phrase0 := '\\b(CITY|TOWN|TOWNSHIP|COUNTY|AREA|PARISH|BOROUGH|STATE)\\b';
	phrase1 := '^((\\w+\\W+){1,3}) *(CITY|TOWN|TOWNSHIP|COUNTY|AREA|PARISH|BOROUGH|STATE)';
	phrase2 := '^([A-Z]+) *(CITY|TOWN|TOWNSHIP|COUNTY|AREA|PARISH|BOROUGH|STATE)\\b';
	//phrase3 := '^([A-Z]+) +(CITY|TOWN|TOWNSHIP|COUNTY|AREA|PARISH|BOROUGH|STATE)\\b';
	phrase4 := '(([A-Z]+) +([A-Z]+)) +COUNTY\\b';
	phrase5 := '^SHERIFF & ([A-Z]+) +COUNTY\\b';
	phrase6 := '\\bCOUNTY +([A-Z]+)\\b';
	phrase7 := '\\bCOUNTY +([A-Z]+ [A-Z]+)\\b';
	phrase8 := '^([A-Z]+) +COUNTY$';
	runonPhrase := '\\b(MARSHALL|MARSHAL|SHERIFF|SHERRIFF|CLERK|CONSTABLE|COURT|BANK|TREASURER) *[A-Z]* +COUNTY\\b';
	CountyOf := '\\bCOUNTY (IF|OC|OD|OF|OFD|OFE|OG|OFG|OFK|OGF|OKF|OOF|OPF|OT|OV)\\b';
	s := Std.Str.FindReplace(s1,'-', ' ');
	numtokens := COUNT(Std.Str.SplitWords(s, ' '));
	return MAP(
		NOT REGEXFIND(phrase0,s) => false,
		REGEXFIND(runonPhrase,s) => true,
		REGEXFIND(CountyOf,s) => true,
		numtokens > 3 => true,
		//REGEXFIND(phrase3,s) => CheckGeo(REGEXFIND(phrase3, s, 1),REGEXFIND(phrase3, s, 2)),
		/*REGEXFIND(phrase4,s) => SpecialNames.IsCountyName(REGEXFIND(phrase4, s, 2)) AND
								(SpecialNames.IsStateName(REGEXFIND(phrase4, s, 1)) OR
									REGEXFIND(phrase4, s, 1) IN ['PARKS','WATER','DOT','FAIR',
										'SHERIF','SHERIFF','SHERIFFS']),*/
		REGEXFIND(phrase4,s) => CountyCheck(REGEXFIND(phrase4, s, 1)) OR CheckGeo(REGEXFIND(phrase4, s, 3),'COUNTY'),
		REGEXFIND(phrase5, s) => true,
		REGEXFIND(phrase6, s) => CheckGeo(REGEXFIND(phrase6, s, 1),'COUNTY'),
		REGEXFIND(phrase7, s) => CheckGeo(REGEXFIND(phrase7, s, 1),'COUNTY'),
		REGEXFIND(phrase8,s) and NOT $.NameTester.IsFirstNameEx(REGEXFIND(phrase8,s, 1)) => true,
		REGEXFIND(phrase2,s) => CheckGeo(REGEXFIND(phrase2, s, 1),REGEXFIND(phrase2, s, 2)),
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
		['ACRES','ARENA','BAPTIST','BRANCH','BUILDERS','CELLARS','CONDO','CONDOS',
		'CHALET','CENTER','CHAPEL','CHURCH','CHUCH','COLLEGE','COLONY','COTTAGES','CRAFTS','DAIRY','DELI',
		'FARM','FARMS','GALLERY','GOLF','GRILL','HEIGHTS','HIGHLANDS','HOLLOW',
		'HOA','HOME','HOMES','HOUSE','KENNEL','KENNELS','LODGE','MALL','MANOR','MARINA','MARINE',
		'MARKET','MOTEL','OFFICE','PLACE','PLAZA','POND','POOL','PRESS',
		'RANCH','SCHOOL','SCHOOLS','SPA','STABLES','STORAGE','TACKLE',
		'SALES','TRUCKING','VILLA','VILLAS','VINEYARD'
		];
rgxGeo := '^([A-Z]+) +(CREEK|GROVE|HIGHLANDS|LAKE|LAKES|POINT|SPRING|SPRINGS|STREET|MEADOW)\\b';
rgxGeo1 := '^([A-Z]+) +(CREEK|GROVE|LAKE|LAKES|POINT|SPRING|SPRINGS|STREET|CITY|STATE|MEADOW) +([A-Z]+)\\b';
boolean IsGeoCity(string s, unsigned2 format) := 
	IF(~REGEXFIND(rgxGeo, s), false,
		MAP(
			Address.SpecialNames.IsCityName(REGEXFIND(rgxGeo, s, 1) + ' ' +
										REGEXFIND(rgxGeo, s, 2)) => true,
			REGEXFIND(rgxGeo1, s, 3) IN placewords => true,
			$.NameTester.IsFirstname(REGEXFIND('^([A-Z]+) +([A-Z]+)$', s, 1)) => false,
			REGEXFIND(rgxGeo1, s) AND ~$.NameTester.IsFirstname(REGEXFIND(rgxGeo1, s, 1)) => true,
			~$.mod_NameFormat.IsPossibleName(s, format) AND
				~$.mod_NameFormat.IsPossibleDualName(s, format) => true,
			false));

// e.g. names ending as BUILDERS TRUCKING HOLDINGS
rgxDualNames := '^([A-Z]{2,}) +(&|AND) +([A-Z]{2,})$';
boolean TwoFirstNames(string s) := 
			$.NameTester.IsFirstName(REGEXFIND(rgxDualNames,s, 1)) AND
			$.NameTester.IsFirstName(REGEXFIND(rgxDualNames,s, 3));
			
set of string colors := ['RED','ORANGE','GREEN','BLUE','YELLOW','PURPLE','WHITE','BLACK','BROWN',
			'GREY','GRAY','AZURE','TEAL','PINK'];

set of string geowords :=
		['ACRES', 'AFRICA','ALL','AMERICA','AMERICAN','AREA', 'ASIA','ATLANTIC','AUSTRALIA','AVE','AVENUE',
		'BACK','BANK','BASIN','BAY','BEACH','BEND','BOUND','BORO','BOROUGH','BRANCH','BRIDGE',
		'CAL','CALIF','CAROLINA','CHAPTER','CENTER','CENTRAL','CHAPEL','CHARTER','CHURCH','CIRCLE','CITY','CITIES','COAST','COMMONS','CONDO','COUNTY','CORNER','COURT','CT','COVE','CIVE','CORNER','CORNERS','CREEK','CROSSING','CYPRESS',
		'DAKOTA','DISTRICT','DRIVE','DR','DOWN','DUE','DUNES','ELM','END','FAR','FIRST','FLA','FORK','GAP','GATE','GATEWAY','GO','GULF',
		'HALL','HALLOW','HEIGHTS','HILLS','HIGHLANDS','HOA','INDIES','JERSEY','LAKE','LAKES','LAND','LANE','LN','LODGE','LOOP',
		'MAPLE','MEADOW','MEADOWS','METRO','OAKS','OFFICE','ONE','ORCHARD','OUT','PAC','PACIFIC','PALM',
		'PARK','PK','PARKWAY','PKY','PART','PATH','PEAK','PEAKS','PINE','PINES','PLACE','PLAINS','PLAZA','POINT','POINTE','POINTS','POLE','PORT',
		'REGION','RESERVE','RIDGE','RIVER','ROAD','RD','SCHOOL','SOUND',
		'SEAS','SIDE','SHORE','SHORES','SPRINGS','SQUARE','ST','STATES','STORAGE','STREET','TENN','TERRACE','TER','THICKET','TIER','TOWER','TOWERS','TOWN',
		'UP','US','VALLEY','VIEW','VILLA','VILLAS','WAY','WIND','WOODS'];

boolean IsGeoDesignation(string s) := MAP(
		s = '' => false,
		s in geowords => true,
		Address.SpecialNames.IsStateName(s) AND s != 'MD' => true,
		$.NameTester.IsFirstName(s) => false,
		Address.SpecialNames.IsCityName(s) => true,
		Address.SpecialNames.IsCountyName(s) => true,
		false);
		
	
// for special cases
boolean IsGeoDesignation2(string s) := 
	MAP(
		s = '' => false,
		s in geowords => true,
		REGEXFIND('[0-9]',s) => true,
		Address.SpecialNames.IsStateName(s) AND s NOT IN ['MD','PA'] => true,
		$.NameTester.IsFirstName(s) => false,
		$.NameTester.IsLastName(s) => false,
		$.NameTester.IsAmbiguousWord(s) => true,
		Address.SpecialNames.IsCityName(s) => true,
		Address.SpecialNames.IsCountyName(s) => true,
		false);

rgxTwoWords := '^([A-Z]{2,}) +([A-Z]{2,})$';
rgxThreeWords := '^([A-Z]{2,}) +([A-Z]{2,}) +([A-Z]{2,})$';
rgxFourWords := '^[A-Z]+ +[A-Z]+ +[A-Z]+ [A-Z]+$';
rgxPersonalBusiness := '^([A-Z0-9 ,&\'.-]+) +(BUILDERS|HOLDINGS|HOMES|TRUCKING|CATTLE|RANCH|FARM|FARMS|HARDWARE|DEV)[.,]?$';
boolean CheckPersonalBusiness(string s, boolean isBiz, unsigned2 format) := 
	MAP(
		s = '' => false,
		REGEXFIND('^[A-Z][. ]*(&| AND ) *[A-Z]\\.?$',s) => true,	// A & C TRUCKING
		REGEXFIND('^[A-Z]\\.? +[A-Z][. ]*(&| AND ) *[A-Z]\\.?$',s) => true,	// A B & C TRUCKING
		REGEXFIND('^([A-Z]+) *(&| AND ) *\\1$',s) => true,	// JONES & JONES TRUCKING
		REGEXFIND('^[A-Z][. ]*(&| AND ) *[A-Z]\\.? +[A-Z]+$',s) => true,	// A & C CHESTER TRUCKING
		REGEXFIND('^[A-Z]+ +[A-Z]+ +[A-Z]+$',s) => true,	// Adam Baker Charley TRUCKING
		REGEXFIND('^[0-9]+ *[A-Z]$',s) => true,	// Adam Baker Charley TRUCKING
		REGEXFIND('^[A-Z][ -]+[A-Z]$',s) => true,	// A C FARMS
		REGEXFIND('^\\b(C O)$',s) => true,	// CATTLE C O
		REGEXFIND('^([A-Z]+) +([A-Z])$',s) => isBiz,
		REGEXFIND('^[A-Z]+ *(&| AND ) *[A-Z]+ +[A-Z]+$',s) => true,	// Adam Baker & Charley TRUCKING
		REGEXFIND('^(TRI|ROCKING) ',s) => true,	
		$.NameTester.IsLastName(REGEXFIND('^[A-Z]\\.? +([A-Z]+)$',s, 1)) => true, 	// S JONES TRUCKING
		REGEXFIND(rgxDualNames,s) => if(isBiz, true, NOT TwoFirstNames(s)),  // SAM & BRENDA TRUCKING
		//NameTester.InvalidNameFormat(s) => true,
		$.NameTester.IsLastNameConfirmed(REGEXFIND('^([A-Z \'-]+)$', s, 1)) => true,
		$.mod_NameFormat.validPersonNameFormat(format) => true,

		IsGeoDesignation(s) => true,
		IsGeoDesignation(RegexFind(rgxTwoWords, s, 2)) => true,
		RegexFind(rgxTwoWords, s, 1) in colors => true,
		false);

set of string saintwords := [
		'ANGLICAN','BAPTIST','BASILICA','CATHEDRAL','BYZ','BYZANTINE','CATHOLIC',
		'CH','CHAPEL','CHU','CHUR','CHURC','CHUCH','CHURCH',
		'HALL','HOME','HOSP','HOSPITAL','MISSION','MORAVIAN','PARISH','PARRISH',
		'PRESB','PRESBYTERIAN','PRIORY','SCHOO','SCHOOL','SCHOOLS','SEMINARY'
		];
boolean IsSaintWord(string s) := MAP(		
		s = '' => false,
		s in saintwords => true,
		$.NameTester.IsAmbiguousWord(s) => true,
		false);
string TrimWell(string s) := Std.Str.CleanSpaces(REGEXREPLACE('^([ ,&-]+)',REGEXREPLACE('([ ,&-]+)$',s,' '),' '));

TrustWords := Nid.Trusts.TrustWords;
CoTrustees := '\\bCO[ -]+(TRUSTEE|TRUSTE|TRUSTEES|TRSTEE|TTEE|TRS|TRSTE|TRU|TTE|TR|EXECUT(OR|RIX))\\b';

rgxTrustDated := '\\(?(DATED|DTD|UTD) +\\d{1,2}[/-] *\\d{1,2} *[/-] *\\d{2,4}\\)?';
boolean LikelyTrust(string s) := Nid.Trusts.LikelyTrust(s);

MatchType CheckTrust(string s, DATASET(Address.NameTester.rWord) words, DATASET(Address.NameTester.rWord) digraphs,
													  string name, unsigned2 format) := 
	MAP(
		REGEXFIND('^([A-Z]+) +TRUST$', s, 1) in TrustWords => MatchType.Inv,
		REGEXFIND('^TRUST +([A-Z]+)$', s, 1) in TrustWords => MatchType.Inv,
		REGEXFIND('^TRUST +' + rgxTrustDated + '$', s) => MatchType.Inv,
		$.NameTester.IsFirstname(REGEXFIND('^([A-Z]+) +[A-Z] +TRUST$', s, 1)) => MatchType.Person,

		REGEXFIND('^TRUST +DATED', s) => MatchType.Trust,
		REGEXFIND('^TRUST +(AGREEMENT|AGREEME NT|AGREEMEN)$', s) => MatchType.Inv,
		REGEXFIND('\\bTRUST +(AGREEMENT|AGREEME NT|AGREEMEN)\\b', s) => MatchType.Trust,
		IsConjunctive('\\b([A-Z]+) *(&| AND | OR |\\+) *(TRUST)\\b',s) => MatchType.Business,	// word & TRUST
		REGEXFIND('\\bTRUST (CO(MPANY)?|CORP|INC|LLC|LTD|LLP|NA|N A|INVESTMENT(S)?|HOLDINGS|.+ LLC)\\b', s) => MatchType.Business,
		REGEXFIND('\\b([A-Z]+) *[/]? *TRUST', s, 1) in  Nid.Trusts.BusTrustWords => MatchType.Business,
		REGEXFIND('\\b([A-Z]+) *[/]? *(TRUST|TRUSTS|TRU)\\b', s, 1) in TrustWords => MatchType.Trust,
		REGEXFIND('\\b([A-Z]+) *[/]? *(TRUST|TRUSTS|TRU) DTD\\b', s, 1) in TrustWords => MatchType.Trust,
		REGEXFIND('\\bTRUST +([A-Z]+)', s, 1) in TrustWords => MatchType.Trust,
		REGEXFIND('\\bTRUST +#([A-Z0-9-]+)', s) => MatchType.Trust,
		REGEXFIND('^#([A-Z0-9 -]+)TRUST', s) => MatchType.Inv,
		REGEXFIND('TRUST NO [0-9]', s) => MatchType.Trust,
		REGEXFIND('(UNIT|NO) [A-Z0-9]+ TRUST', s) => MatchType.Trust,
		REGEXFIND('^[A-Z] +[A-Z] +TRUST$', s) => MatchType.Trust,			// A S TRUST
		REGEXFIND('\\b[A-Z]/+[A-Z] +TRUST$', s) => MatchType.Trust,
		REGEXFIND('\\(TRUST\\)$', s) => MatchType.TRUST,		// (TRUST)
		
		REGEXFIND('^[A-Z] +[A-Z] +[A-Z] +TRUST$',s) => MatchType.Trust, // A B C TRUST
		REGEXFIND('\\bTRUST +[0-9]+',s) => MatchType.TRUST,
		REGEXFIND(' TRUST (TRUSTY|TTEE|OFFICER|BENEFICIARY|BENEFICIAR|DATED|PT|COMP|A|B|C|1|2|3|I|II|III)\\b', s) => MatchType.Trust,
		REGEXFIND('^[A-Z]+ +[A-Z]+ +[A-Z]+ +TRUST$',s) => MatchType.Trust,
		REGEXFIND('^[A-Z]+ +TRUST, *[A-Z]+ +[A-Z]+$',s) => MatchType.Trust,
		REGEXFIND('^[A-Z]+ +TRUST, *[A-Z]+$',s) => MatchType.Trust,
//*		$.mod_NameFormat.IsPossibleDualName(REGEXFIND('^([A-Z &\'-]+) +TRUST(S)?$', name, 1))	=> MatchType.Trust,
		REGEXFIND('^[A-Z]+ [A-Z]+ & [A-Z]+ [A-Z]+ TRUST$',s) => MatchType.Business,
		REGEXFIND('^[0-9]+ +[A-Z0-9 ]+ +(AVENUE|AVE|ST|STREET|RD|DR|DRIVE|ROAD|LANE|PLACE|PL).+TRUST',s) => MatchType.Business,
		REGEXFIND('^(1ST|2ND|3RD|4TH|5TH|6TH|1|2|3|4|5|6|7|8|0) +[A-Z ]*.+TRUST',s) => MatchType.Business,
		REGEXFIND('^[A-Z]-[A-Z] +TRUST',s) => MatchType.Trust,
		REGEXFIND('[/-] *TRUST\\b',s) => MatchType.Trust,
		REGEXFIND('\\bTRUST[-] *',s) => MatchType.Trust,
		REGEXFIND('\\bTR UST\\b',s) => MatchType.Trust,
		REGEXFIND('^[A-Z]+, *TRUST',s) => MatchType.Trust,
		REGEXFIND('^THE +.+ +TRUST',s) => MatchType.Trust,
		REGEXFIND('\\b(FAMILY|LEGACY|FUND)? +\\d* +TRUST\\b', s) => MatchType.Trust,		// 1999 TRUST
		REGEXFIND('\\b(FAMILY|LIVING)TRUST\\b', s) => MatchType.Trust,		// run on words TRUST
		REGEXFIND('\\bTRUST +(& PT|COC|ETAL|ET AL|DTD|/TR|TRUSTEES)$', s) => MatchType.Trust,
		LikelyTrust(s) => MatchType.Trust,
		$.NameTester.MatchBusinessTokens(words, digraphs) => MatchType.Business,	

		REGEXFIND('\\b\\d+ +[A-Z]+ +TRUST\\b', s) => MatchType.Trust,	// 5 Windsor Trust
		REGEXFIND('^[A-Z]+ +[A-Z]+ +TRUST$',s) => MatchType.Trust,
		REGEXFIND('^TRUST +[A-Z] +[A-Z]+$',s) => MatchType.Trust,
		REGEXFIND('^[A-Z]+-[A-Z]+$', TrimWell(REGEXREPLACE('\\b(TRUST)\\b', name, ' ')))	=> MatchType.Trust,
		$.mod_NameFormat.IsLikelyNameFormat(name, format) => MatchType.Person,
		MatchType.Trust
		);


// check for trailer
boolean IsTrailer(string s) := 
			$.NameTester.IsBusinessWord(REGEXFIND('\\b([A-Z]+)(INC)\\b',s, 1));


boolean IsLastAmbi(string name, DATASET({string32 word}) tokens) := FUNCTION
	x := COUNT(tokens);
	s := IF(x>0,TRIM(tokens[x].word),'');
	//RETURN IF (x < 4, false, tokens[x].word in Ambiwords);
	RETURN MAP (
		x = 0 => false,
		x < 4 => false,
		$.NameTester.IsSuffix(s) => false,
		$.NameTester.IsAmbiguousWord(s)
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
				AND $.NameTester.IsFirstName(REGEXFIND('^([A-Z]+) ',s,1)) => true,		
			false
		);

		
	runonwords := '\\b([A-Z]+)(LLC|CORP|COMPANY|INCORPO|FOUNDATION|LTD|UNITED|SERVICES|MORTGAGE)\\b';

boolean BreakUpName(string s) := REGEXFIND(runonwords, s);

boolean IsGreekFrat(DATASET({string32 word}) words) := COUNT(words) = 3 AND
			Address.SpecialNames.IsGreekLetter(words[1].word) AND
			Address.SpecialNames.IsGreekLetter(words[2].word) AND
			Address.SpecialNames.IsGreekLetter(words[3].word);


rgxFirm := '^([A-Z]+)[, ]+([A-Z]+) *(&| AND ) *([A-Z]+)[.,/\\\']?$';
rgxFirm1 := '^([A-Z]+)[, ]+([A-Z]+) *(&| AND ) *(\\1)$';
rgxFirm4 := '^([A-Z]{3,})[, ]+([A-Z]{3,})[, ]+([A-Z]{3,}) *(&| AND ) *([A-Z]{3,})$';			// four words
boolean NoVowels(string s) :=
	REGEXFIND('^[^AEIOUY]{3,}$', s);
boolean TooManyConsonants3(string s) :=
	NoVowels(REGEXFIND(rgxFirm,s,1)) OR
	NoVowels(REGEXFIND(rgxFirm,s,2)) OR
	NoVowels(REGEXFIND(rgxFirm,s,4));
boolean EmbeddedWords(string s) := 
	REGEXFIND('[A-Z]+(AAA|AUTO|BIO|CARE|CENTER|COMP|CRAFT|CRYO|DESIGN|EASY|ECONO|EURO|FIRE|FLEX|HOUSE|INFO|INTER|LAKE|MASTER|MECH|METRO|MULTI|OMNI|PHARM|PLEX|POLY|POWER|PSYCH|SCAPE|SCOPY|SERVICE|SHOP|TECH|TELE|TIONAL|TOWN|TRANS|TRONIC|ULTRA|WARE|WEAR|WORK)[A-Z]+',s);
boolean EndPhrase(string s) := 
	REGEXFIND('[A-Z]{3,}(ANCE|EX|INC|ING|CO|LLC|LLP|ABLE|MENT|SHIP|CION|SION|TION|TIONAL|TIONS|TRONIC|TRONICS|CORP|COMPANY|INCORPO|IST|ISTS|ISTIC|FOUNDATION|UNITED|SERVICES|SVCS|SCIENCE|SMITHING|MART|MARTS|SIDE|TIC|TICS|VILLE|WORLD)\\b',s);

KnownFirmName(string s) := Address.SpecialNames.IsKnownFirm(
			REGEXFIND(rgxFirm, s, 1) + ' ' + REGEXFIND(rgxFirm, s, 2) + ' & ' + REGEXFIND(rgxFirm, s, 4));

types := ['X','F','L','B'];
string1 GetNameClass(string nm) :=
	types[IF ($.NameTester.IsFirstName(nm),1,0) +
	IF ($.NameTester.IsLastNameEx(nm),2,0) + 1];
	
string3 GetNameTypes(string s) :=
		GetNameClass(REGEXFIND(rgxFirm, s, 1)) +
			GetNameClass(REGEXFIND(rgxFirm, s, 2)) + GetNameClass(REGEXFIND(rgxFirm, s, 4));
			
NonFirmNames := ['JR','SR','II','III','MC'];

boolean LikelyFirmName(string s) := FUNCTION
	RETURN MAP(
		StringLib.StringFind(s, 'AND OR', 1) > 0 => false,
		REGEXFIND('\\b(AND FRIENDS|MORE|ASS|ASSC|ASSO|SON(S)?|DAUGHTER(S))\\b', s) => true,
		REGEXFIND(rgxFirm,s,4) = 'DELI' => true,
		s[1..4] = 'DRS ' => true,
		//t in ['XXX','XLX','XXL','XLL'] => true,
		REGEXFIND(rgxFirm, s, 1) = 'AAA' => true,
		REGEXFIND(rgxFirm1, s) => true,
		REGEXFIND('^([A-Z]+) +(\\1+) *(&| AND ) *([A-Z]+)[.,/\\\']?$',s) => true,		// MORGAN MORGAN AND JONES
		KnownFirmName(s) => true,
		REGEXFIND(rgxFirm, s, 1) IN NonFirmNames OR REGEXFIND(rgxFirm, s, 2) IN NonFirmNames OR
							REGEXFIND(rgxFirm, s, 4) IN NonFirmNames => false,
//*		NOT Address.Persons.TestDualName(REGEXFIND(rgxFirm, s, 1), REGEXFIND(rgxFirm, s, 2), REGEXFIND(rgxFirm, s, 4)) => true,
		//t[2] = 'F' OR t[3] = 'F' => false,
		//t IN ['LFF','LBF','LFB','LBB','BLF','FLF','FLB'] => false,
		//t in ['LBL','BBL','BLL','BLB','LLL','LXL','LLX'] => true,
		//t IN ['XBB','BBB','XFF','XBF','XFB','XBF','XXF'] => false,
		/*t IN 	['LLL','LLX',	// vary 3
						'LBL',	// vary 2
						'LXL',	// vary 2
						'XLL','XLB','XLX',	// vary 1
						'XXL','XXB','XXX',
						'BLL','BLB','BLX',	// vary 1
						'BXL'] => true,
		t = 'LLB' => NOT NameTester.IsLoPctFirstName(REGEXFIND(rgxFirm, s, 2)),
		t IN ['LFF','LBF','LFB','LBB',
					'LFX','LBX','LXF','LXB',
					'BFF','BBF','BFB','BBB',
					'BFX','BBX','BXF','BXB','BXB','BXX'] => false,*/
		TooManyConsonants3(s) => true,
		$.NameTester.LikelyBizWord(s) => true,
		false);					// unknown or either
END;
			
rgxMrMrs := '\\b((MR|DR) (&|AND)? (MRS|MS))\\b';
boolean IsFirmName(string s, string preCleaned) := 
	MAP(
		REGEXFIND(rgxMrMrs, s) => false,
		REGEXFIND(' *(&|AND ) *(WIFE|JLRS|GUEST(S)?|PARENT(S)?|CHILD(REN?))$', s) => false,
		NOT REGEXFIND('(&| AND )', preCleaned) => false,
		REGEXFIND(rgxFirm, s) => LikelyFirmName(s),
//*		Address.Persons.IsDualName(preCleaned) => false,
		REGEXFIND(rgxFirm4, preCleaned) => true,
		REGEXFIND('^[A-Z] *(&|AND ) *[A-Z] +[A-Z]+$',s) => $.NameTester.LikelyBizWord(s), // A & A biztype
		REGEXFIND('^([A-Z-]{2,} +){3,} *(&|AND ) *[A-Z]+$',s) => true, // MOE LARRY SHEMP & CURLEY
		//REGEXFIND('^[A-Z-]+ *, *[A-Z]+ *(&| AND ) *[A-Z]+$',s) => true, // BAKER,GREENSPAN & BERNSTEIN
		REGEXFIND('^.+ *(&| AND ) *.+ +P[ .]?(A|C)\\.?$',s) => true, // any & any P C or PA
		//REGEXFIND('^[A-Z-]+ *(&| AND ) *[A-Z-]+ +P[ .]?(A|C)\\.?$',s) => true, // BAKER, & GREENSPAN P C
		REGEXFIND('^([A-Z-]+, *){3,} *(&|AND ) *[A-Z]+$',s) => true, // MOE, LARRY, SHEMP & CURLEY
		false);

rgxFL := '^([A-Z]+) +([A-Z]+)$';
rgxFML := '^[A-Z]{3,} +[A-Z]{3,} +[A-Z]{3,}$';
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

boolean IsOrientalName(string name) := 
		Address.OrientalNames.IsOrientalSurname(name) OR Address.OrientalNames.IsOrientalName(name);
		
doubleDouble := '^([A-Z]{2}) +([A-Z]{2})$';
MatchType TestOriental(string s) := 
		IF(IsOrientalName(REGEXFIND(doubleDouble, s, 1)) AND
			IsOrientalName(REGEXFIND(doubleDouble, s, 2)),MatchType.Person,MatchType.Inv);
			
			
MatchType DoubleCheckName(string s) := FUNCTION
		name1 := REGEXFIND('^([A-Z]{2,}) +([A-Z]{2,})$',s,1);
		name2 := REGEXFIND('^([A-Z]{2,}) +([A-Z]{2,})$',s,2);
		return MAP(
			GetNameClass(name1) = 'X' => IF($.NameTester.LikelyBizWord(name1),MatchType.Business,MatchType.Person),
			GetNameClass(name2) = 'X' => IF($.NameTester.LikelyBizWord(name2),MatchType.Business,MatchType.Person),
			MatchType.Person
		);
END;

rgxFaFL := '^[A-Z]+ *(&| AND ) *[A-Z]+ +[A-Z]{2,}$';
rgxFaFML := '^[A-Z]+ *(&| AND ) *[A-Z]+ +[A-Z] +[A-Z]+$';


MatchType TwoWordName(string s, unsigned2 quality) := FUNCTION

	return MAP(
	//MatchingName(s) => MatchType.Person,
	quality = $.NameStatus.ProbableName => MatchType.Person,
	quality = $.NameStatus.PossibleName => MatchType.Person,
	REGEXFIND('^[A-Z]+ +(JR|SR|NMN|NMI|II|III|IV)$', s)	=> MatchType.Inv,	// NAME JR
	REGEXFIND(doubleDouble, s) => TestOriental(s),
//	REGEXFIND(doubleDouble, s) => MatchType.Inv,
	TooShort(s) => MatchType.Business,
	REGEXFIND('\\b([B-Z])\\1{4,}\\b', s) => MatchType.Inv,	// repeated letters
	REGEXFIND('\\b(BASTARD|BITCH|ASS|PUSSY)\\b', s)	=> MatchType.Inv, 
	TooManyConsonants(s) => MatchType.Business,
	EmbeddedWords(s) => MatchType.Business,
	EndPhrase(s) => MatchType.Business,
	//MatchingName(s) => MatchType.Person,
	//
	Address.SpecialNames.IsCityName(s) => MatchType.Business,
	Address.SpecialNames.IsCityName(REGEXFIND(rgxFL,s,1)) => MatchType.Business,
	Address.SpecialNames.IsStateName(REGEXFIND(rgxFL,s,1)) => MatchType.Business,
	Address.SpecialNames.IsCountyName(REGEXFIND(rgxFL,s,1)) => MatchType.Business,
	Address.SpecialNames.IsCityName(REGEXFIND(rgxFL,s,2)) => MatchType.Business,
	Address.SpecialNames.IsStateName(REGEXFIND(rgxFL,s,2)) => MatchType.Business,
	Address.SpecialNames.IsCountyName(REGEXFIND(rgxFL,s,2)) => MatchType.Business,
	quality = $.NameStatus.ImprobableName => DoubleCheckName(s),
	quality IN [$.NameStatus.NotAName, $.NameStatus.InvalidNameFormat,
					$.NameStatus.StandaloneName] => MatchType.Inv,
	MatchType.Person	// otherwise we miss too many names
	);
END;

boolean IsGoodName(string name) := FUNCTION
	n1 := REGEXFIND(rgxTwoWords,name, 1);
	n2 := REGEXFIND(rgxTwoWords,name, 2);
	segs := $.mod_NameFormat.GetNameTypes(n1, n2);
	RETURN MAP(
			segs in ['LL','LX','XL','XX'] => false,
			$.NameTester.IsAmbiguousWord(n2) AND GetNameClass(n1) in ['L','X'] => false,
			$.NameTester.IsFirstName(n1) AND $.NameTester.IsLastNameEx(n2) => true,
			$.NameTester.IsFirstName(n2) AND $.NameTester.IsLastNameEx(n1) => true,
			$.NameTester.IsFirstName(n1) AND $.NameTester.IsAmbiguousWord(n2) => true,
			$.NameTester.InvalidNameFormat(name) => false,
			//MatchingName(name) => true,
			TooShort(name) => false,
			TooManyConsonants(name) => false,
			EmbeddedWords(name) => false,
			EndPhrase(name) => false,
			//NameTester.IsFirstName(n1) AND NameTester.IsAmbiguousWord(n1) => true,
			n1='MARINA' => true,		// temporary fix
			$.NameTester.IsAmbiguousWord(n1) AND $.NameTester.IsFirstName(n2) => true,
			$.NameTester.IsLastNameConfirmed(n1) AND $.NameTester.IsLastNameConfirmed(n2) => false,
			$.NameTester.IsAmbiguousWord(n1) AND $.NameTester.IsLastNameConfirmed(n2) => true,
			false);
END;

boolean IsGoodTriName(string name) := FUNCTION
	segs := $.mod_NameFormat.GetNameTypes(REGEXFIND(rgxThreeWords,name, 1), REGEXFIND(rgxThreeWords,name, 3), REGEXFIND(rgxThreeWords,name, 2));
  return IF(LENGTH(Std.Str.FilterOut(segs, 'FB'))=3, false, true);
END;


boolean IsAmbiguousBusiness(DATASET({string32 word}) words, string busname, string name, unsigned2 format) := 
	MAP(
				COUNT(words($.NameTester.IsAmbiguousWord(word))) = 0 => false,
				COUNT(words($.NameTester.IsAmbiguousWord(word))) > 1 => true,
				//REGEXFIND('^BABY (BOY|GIRL) ',busname) => false,
				$.NameTester.InvalidNameFormat(name) =>true,
				REGEXFIND('^([A-Z]{2,}) +(&|AND) +\\1+ +[A-Z]+$',trim(name)) => true,
				//REGEXFIND('\\bCENTER\\b', busname) => true,
				//REGEXFIND(rgxFourWords,busname) => true,
				REGEXFIND(rgxTwoWords,busname) => NOT IsGoodName(busname),
				REGEXFIND(rgxThreeWords,busname) => NOT IsGoodTriName(busname),
				//Persons.IsPossibleDualName(name) => false,
				$.mod_NameFormat.IsDualName(name, format) => false,
				$.mod_NameFormat.IsLikelyName(name, format) => false,
				IsLastAmbi(busname, words) => true,
				true)
			;

BusEndings := ['L C','L P','P C','P A','P S','S C','N A','S A','P L','L L','A C'];
boolean CheckBusEndings(string s) :=
		REGEXFIND('^.+ ([A-Z] [A-Z])[,]?$',s,1) IN BusEndings;

rgxTooManyConsonants := '\\b[B-DF-HJ-NP-TVWXZ]{7,}\\b';	
rgxTooManyConsonants2 := '\\b[B-DF-HJ-NP-TVWXZ]{5,}\\bB-DF-HJ-NP-TVWXZ]{5,}\\b';

boolean CrazyBizName(string s) := 
	LENGTH(TRIM(s)) > 45 AND
			((Std.Str.FindCount(s, ';') > 2) OR (Std.Str.FindCount(s, '&') > 2));

string TrimRightPunct(string s) := REGEXREPLACE('[ ,&+*/\\x00-\\x1f\\x80-\\xff-]+$',s,'');
string Unquote(string s) := REGEXREPLACE('^\'(.+)\'$', s, '$1');

 
// remove apostropohe at beginning or end of a word
rgxApos1 := '[^A-Z0-9_]\'([A-Z0-9_]+)';
rgxApos2 := '([A-Z0-9_]+)\'( |$)';
string RemoveApostrophe(string s) :=  REGEXREPLACE(rgxApos2, 
																					REGEXREPLACE(rgxApos1, s, ' $1'), ' $1 ');

rgxChurchTypes := 
'(AME|BAPTIST|BRETHREN|CATHOLIC|CATH|CHRIST|CHRISTIAN|CME|EPSIC|FAITH|GRACE|LUTHERAN|METH|NAZARENE|PENT|PRESBYTERIAN|PRESB|PRES|REFORMED|TEMPLE|UM|ZION)';
rgxChurchWords := '(CHURCH|CHURC|CHUR|CHU|CH|FELLOW|PARISH|PARRISH|SCHOO|SCHOOL)';
positionNames :=
'((VICE[- ]?)?PRES(IDENT)?|SEC(RETARY)|SUPERINTENDENT|TREAS(URER)?|CONTROLLER|CHAIRMAN|EXECUT(OR|RIX)|EXECUTIVE DIRECTOR|DIRECTOR|C[.]?F[.]?O|CTO|COO|CEO|V\\.?P\\.? (FINANCE|HR|HUMAN RESOUCRES|SALES|TAX)|(SEN(IOR|\\.)? |EX(EC)?[.]? |E)?V[.]?P[.]?|S[R]?VP|VPHR|GEN(ERAL)? (MGR|MANAGER)|(HR |ASSET )MANAGER)';
positions := '\\b' + positionNames+'$';
rgxStreet := '\\b([0-9]+|[A-Z] [A-Z]|FIRST|SECOND|THIRD|FOURTH|FIFTH|SIXTH|CENTER|NORTH|SOUTH|EAST|WEST).* (ROAD|RD|STREET|ST|AVE|AVENUE|DRIVE|CT|PLACE|PATH|LN|WAY|WY)$';		// street address only
rgxCaseNum := '^(CASE|CIVIL ACTION|PROBATE COURT CASE|PROBATE CASE|BANKRUPTCY|COURT CASE|CIRCUIT COURT CASE) *#[A-Z0-9 ,#&/-]+$';

MatchType NotAName(string name, string s, DATASET({string32 word}) words, unsigned2 format) := 
			MAP(	
				REGEXFIND(rgxTwoWords, name) => MatchType.Person,
				REGEXFIND('^[A-Z]+$',name) => if(NameTester.PossibleBizWord(name),	MatchType.Business,	// single word name
																													MatchType.Inv),
				REGEXFIND('^[A-Z]+ [A-Z]$',name) => MatchType.Inv,	// First Mi
				REGEXFIND('\\b((MR|DR) (&|AND)? MRS)\\b',s) => MatchType.Inv,		//MatchType.Unclass,
				REGEXFIND(CoTrustees, s) => MatchType.Trust,		//MatchType.Unclass,
				$.mod_NameFormat.IsNameFormatDual(format) => MatchType.Dual,
				REGEXFIND('( AND |&| OR |&/OR )', s) => MatchType.Business,
				REGEXFIND(' A-[A-Z]+',s) => MatchType.Business,
				$.NameTester.LikelyBizWord(s) => MatchType.Business,
				Address.SpecialNames.IsCityName(s) => MatchType.Business,
				CheckBusEndings(s) => MatchType.Business,
				REGEXFIND('^(1ST|2ND|3RD|4TH|5TH|6TH|7TH|8TH|9TH)',s) => MatchType.Business,
				REGEXFIND(rgxFML, name) => if($.NameTester.PossibleBizWord(name),	// single word name
																				MatchType.Business,MatchType.Inv),
				REGEXFIND('[*%#@!?\\[]+',name) => MatchType.Inv,	// special characters
				//preferBiz => MatchType.Business,
				REGEXFIND('^[A-Z]{3,4}$',s) => MatchType.Business,
				COUNT(words($.NameTester.IsAmbiguousWord(word))) > 0 => MatchType.Business,
				MatchType.Inv		//MatchType.Hnh	//		Business
			);


EXPORT MatchType fn_nonPerson(string str, string s, string name, unsigned2 quality, unsigned2 format) := FUNCTION

	words := Address.WordSplit(RemoveApostrophe(s));
	digraphs := Address.WordPairs(RemoveApostrophe(s));
	//tokens := TokenManagement.TokenSet(s, numTokens);
	tokens := SET(words, word);
	numTokens := COUNT(tokens);
	hint := 'U';
	//MAP(
	//		Std.str.Contains(options,'f',true) => 'f',
	//		Std.str.Contains(options,'l',true) => 'l',
	//		'U');
	preferBiz := false;	//Std.str.Contains(options,'B',true);

	RETURN MAP(
		//REGEXFIND('^\\s*$',s) => MatchType.Blank,					// blank line
		LENGTH(s) = 0 => MatchType.Blank,					// blank line
		LENGTH(s) >= 150 => MatchType.Inv,					// too long
		REGEXFIND('[^\r\n -~]',s) => MatchType.Inv,		// non printing characters space to ~ only
		REGEXFIND('^[^A-Z ]+$',s) => MatchType.Inv,	// no alpha characters
		REGEXFIND('\\b([^ A])\\1{5,}\\b',s)	=>MatchType.Inv,	// 6 or more repeated character
		COUNT(words) = 0 => MatchType.Inv,
		CrazyBizName(str) => MatchType.Inv,
		Address.SpecialNames.IsInvalidName(s) => MatchType.Inv,
		LikelyTrust(s) => MatchType.Trust,
		LENGTH(Std.Str.Filter(name, '"^~!:')) > 4 => MatchType.Inv,
		// Rule 14: check for invalid or obscene patterns
		Address.SpecialNames.IsInvalidToken(words, digraphs) => MatchType.Inv,
		Address.SpecialNames.IsOverride(s) => $.Conversions.NameTypeToCode(Address.SpecialNames.overrideType(s)),
		REGEXFIND(rgxCaseNum, s) => MatchType.Inv,
		REGEXFIND('^CREDIT[A-Z ]+APPLICANT$', s) => MatchType.Inv,
		REGEXFIND(rgxStreet,s) => MatchType.Inv,
		REGEXFIND('^CEO +[A-Z]+$', TRIM(s)) => MatchType.Inv,
		IsInvalidTaxpayer(s) => MatchType.Inv,
		REGEXFIND('^[0-9]+ +(PERCENT|PER CENT)$', s) => MatchType.Inv,
		//***** UNKNOWN
		StringLib.StringFind(s, 'UNKNOWN', 1) > 0 => 
				IF(EXISTS(digraphs(word in Address.SpecialNames.unknown_allowed_segments)),
							MatchType.Business, MatchType.Inv),
			
		// CARDHOLDER
		REGEXFIND('^[A-Z]+ +[A-Z]* *CARDHOLDER$', s) AND (($.NameTester.IsFirstName(TRIM(words[1].word))) OR
					(TRIM(words[1].word) IN ['TEST', 'BANKBOSTON','SECURED','PURPOSE','SHELL','TWO']))
					=> MatchType.Inv,
		// Rule x: Trusts
		REGEXFIND('\\b(LIFE ESTATE|LIFE ESTAT|LIFE EST|LIF EST|LF EST|LFEST|LFE EST|LIFE ESTS|LIFEESTATE|EST OF|(THE )?ESTATE OF|ESTATE-OF|ESTATEOF[A-Z]*)\\b', s) AND
										NOT REGEXFIND('\\bREAL ESTATE\\b',s) => MatchType.Trust,
		REGEXFIND('\\(ESTATE\\)', s) => MatchType.Trust,
		// other invalid names
		REGEXFIND('^PARENTS OF *[A-Z-]+$', s) AND
			NOT CheckParentsOf(REGEXFIND('^PARENTS OF *([A-Z-]+)$', s, 1)) => MatchType.Inv,		//MatchType.Unclass,
		Address.SpecialNames.IsObsceneToken(words, digraphs) => MatchType.Inv,

		REGEXFIND('\\b(T/E|TRUST PT|A LIFE E|LIVING TST|A LIVING T|LIV TRT|REV TRUS|REV TRT|REV LT|(ROTH|SEP|TRU[, ]ST|ROLLOVER) IRA)\\b|\\bRT$', s) => MatchType.Trust,
		// business words
		NOT REGEXFIND(CoTrustees, s) AND REGEXFIND('\\b(TRUST|TRUS|TRU|TRST|TST|TRUSTS)\\b',s) => CheckTrust(s, words, digraphs, name, format),
		REGEXFIND('\\bEXECUT(OR|RIX) +(OF|FOR)\\b', s) => MatchType.Inv,				//MatchType.Unclass,
		NOT REGEXFIND(CoTrustees, s) AND	NOT REGEXFIND(Positions, s) AND	// avoiding interpreting CO as company
				$.NameTester.MatchBusinessTokens(words, digraphs) => MatchType.Business,
		(REGEXFIND(CoTrustees, s) OR	REGEXFIND(Positions, s)) AND	// avoiding interpreting CO as company
				$.NameTester.MatchBusinessTokens(words(word<>'CO'), digraphs) => MatchType.Business,
				
//		COUNT(words) > 10 => MatchType.Business,
		Address.SpecialNames.IsKnownBusiness(RemoveSuffix(s)) => MatchType.Business,
		Address.SpecialNames.IsKnownBusiness(s) => MatchType.Business,
		
		IsGeoCity(name, format) => MatchType.Business,
		REGEXFIND('\\b' + rgxChurchTypes + ' +' + rgxChurchWords + '\\b',s) => MatchType.Business,
		REGEXFIND('\\b' + rgxChurchWords + ' +' + rgxChurchTypes + '\\b',s) => MatchType.Business,
		IsSaintWord(REGEXFIND('^(SAINT|SAINTS|ST\\.?|SS|STS|FIRST|LIFE) +[A-Z ]+ +([A-Z]+)\\b', s, 2))
										=> MatchType.Business,
		REGEXFIND('^(SAINT|SAINTS|ST\\.?|SS|STS) +[A-Z]+ *( AND |&) *[A-Z]+', s) => MatchType.Business,
		CheckPersonalBusiness(REGEXFIND(rgxPersonalBusiness, s, 1), preferBiz, format) 
				OR CheckPersonalBusiness(REGEXFIND(rgxPersonalBusiness, name, 1), preferBiz, format) => MatchType.Business, 
		
		StringLib.StringFind(s, 'CORPORATION', 1) > 0 OR
		StringLib.StringFind(s, 'MORTGAGE', 1) > 0 OR
		StringLib.StringFind(s, 'CONSTRUCTION', 1) > 0 OR
		StringLib.StringFind(s, ' CORP.', 1) > 0 OR
		StringLib.StringFind(s, 'SERVICES', 1) > 0 OR
		StringLib.StringFind(s, 'UNITED', 1) > 0  OR
		StringLib.StringFind(s, 'INT\'L',1) > 0  OR
		StringLib.StringFind(s, 'NAT\'L',1) > 0  OR
		StringLib.StringFind(s, 'FED\'L',1) > 0  OR
		StringLib.StringFind(s, 'AND A HALF',1) > 0  OR
		StringLib.StringFind(s, '& A HALF',1) > 0 OR
		StringLib.StringFind(s, ' A-MINOR',1) > 0 => MatchType.Business,
			
		// check for business patterns
		// Rule 18: unclassifiable
		REGEXFIND('^(APT|STORE|SUITE) +# *[A-Z0-9]+$',name) => MatchType.Inv, 
		REGEXFIND('^([A-Z]|[A-Z][A-Z]|RMA|IRS|ATTN|POBOX|DRAWR|STE|LOT|ORDER|PMB|RECEIPT|IRA|RA|RA-|SUITE|FILE|CLAIM|PARCEL|PO) *#? *\\d{2,}$',s) => MatchType.Inv,
		
		//Std.str.Contains(options,'W',true) and REGEXFIND('^[A-Z]+$',s) => MatchType.Person,
		// abbreviation NT
		//REGEXFIND('^[0-9]+ +.+ +([A-Z]+) +NT,?$',s, 1) in geowords => MatchType.Inv,
		MatchPattern(s) => MatchType.Business,
		
		// junk matches 
		REGEXFIND('^AND [A-Z]+$',s) OR REGEXFIND('^[A-Z]+ (AND|&)$',s) OR
				REGEXFIND('\\b[A-Z] +OR +(JR|SR)$', s) => MatchType.Inv,
		
		// Rule 15: repeated word: xxx NAME xxx
		MatchRepeatedWord(s) => MatchType.Inv,
		// Rule 9: Initial & Initial word (J & R Tires)
		REGEXFIND('^[A-Z] *(&| AND ) *[A-Z] +([A-Z]{2,}),?$', s) => 
				ValidIIName(name, REGEXFIND('^[A-Z] *(&| AND ) *[A-Z] +([A-Z]+),?$', s, 2)),
		// Rule 7: 
		IsConjunctive('\\b([A-Z]+) *(&| AND | OR |\\+) *([A-Z]+)\\b',s) => MatchType.Business,	// word & word
		IsConjunctive('\\b[A-Z]+ *& *[A-Z]+ +([A-Z]+) *(&| AND |\\+) *([A-Z]+)',s) => MatchType.Business,	// A&B word and word
		IsConjunctive('\\b([A-Z]{2,}) +(N|A|OR) +([A-Z]{2,})\\b',s) => MatchType.Business,	// word N word
		
		IsTrailer(s) => MatchType.Business,
		// Rule 17: match city names
		IsGeo(s) => MatchType.Business,
		IsGeo(name) => MatchType.Business,
		
		// other unclassified names
		REGEXFIND('^DIVORCED +[A-Z]+$', s) => MatchType.Inv,		//MatchType.Unclass,
		REGEXFIND('^ P O A$', s) => MatchType.Inv,		//MatchType.Unclass,
		REGEXFIND('^ETUX +[A-Z]+ +[A-Z]$', TRIM(s)) => MatchType.Inv,		//MatchType.Unclass,
	// final checks before person
		
		REGEXFIND('^BABY (BOY|GIRL) ',s) => MatchType.Inv,		//MatchType.Unclass,

		REGEXFIND(rgxTooManyConsonants,s) OR REGEXFIND(rgxTooManyConsonants2,s) => MatchType.Inv,
	
		REGEXFIND('^[A-Z]+ +(ND|RD|AVE)$', s) => MatchType.Inv,
		// Rule 12: "A" type name e.g., A GRAND PLACE
		REGEXFIND('^A ([A-Z]+) [A-Z]+', s, 1) in ANames => MatchType.Business,

		// match personal name
		BreakUpName(s) => MatchType.Business,
		REGEXFIND('^(TRT|ITF|MDN|MRMRS|MMS|A/K/A) ',s) => MatchType.Inv,		//MatchType.Unclass,


		REGEXFIND('^[A-Z]+ +[0-9] +[A-Z]+$',s) => MatchType.Inv,	// name numeral name
		IsGreekFrat(words) => MatchType.Business,
		REGEXFIND('\\b(A LOT|U SAVE)\\b', s) AND
			NOT $.NameTester.IsFirstName(REGEXFIND('^([A-Z]+) +(A LOT|U SAVE)\\b', s, 1))
							=> MatchType.Business,

		REGEXFIND('^[A-Z]+$',name) AND ~REGEXFIND('^[A-Z]+$',s)
								=> MatchType.Inv,
								
		Max(words, Length(trim(word))) > 25 => MatchType.Inv,
		IsGeoDesignation2(REGEXFIND('\\b([A-Z0-9]+) +(CENTRAL|NORTH(ERN)?|SOUTH(ERN)?|WEST(ERN)?|EAST(ERN)?)\\b', s, 1))
										=> MatchType.Business,
		IsGeoDesignation2(REGEXFIND('\\b(CENTRAL|NORTH(ERN)?|SOUTH(ERN)?|WEST(ERN)?|EAST(ERN)?) +([A-Z]+)\\b', s, 6))
										=> MatchType.Business,
		IsGeoDesignation2(REGEXFIND('^(CENTRAL|NORTH(ERN)?|SOUTH(ERN)?|WEST(ERN)?|EAST(ERN)?) +[A-Z]+ +([A-Z]+)\\b', s, 6))
										=> MatchType.Business,
		NameTester.IsAmbiguousWord(REGEXFIND('\\b([A-Z]+) +SERVICE\\b', TRIM(name), 1)) => MatchType.Business,
		$.mod_NameFormat.IsDualName(name, format) => MatchType.Dual,
		IsFirmName(s, name) => MatchType.Business,
		IsAmbiguousBusiness(words, s, name, format) => MatchType.Business,
		//Address.Persons.IsDualName(name) => MatchType.Dual,
		REGEXFIND('^[A-Z]{2,} *(&| AND ) *+[A-Z]{2,} +L +[CP],?$', s) => MatchType.Business,
		$.NameTester.IsAmbiguousWord(REGEXFIND('^[A-Z]+ *& *[A-Z]+ +([A-Z]+)$',s,1)) => MatchType.Business,
		// from Gong
		REGEXFIND('\\b(UNPUBLISHED|UNLISTED|BLOCKED|FOR)\\b',s) => MatchType.Inv,
		REGEXFIND('^[A-Z]{2,} +[A-Z]{2,}$',name) => TwoWordName(name, quality),
		name = '' => MatchType.Inv,
		STD.Str.FindCount(s, '&') >= 3 => MatchType.Inv,
		REGEXFIND('^[0-9]+[A-Z]+[0-9]+$', name) => MatchType.Inv,
		REGEXFIND('^[0-9]+', s) AND CheckBusEndings(s) => MatchType.Business,
		REGEXFIND('^[A-Z]+ +[A-Z]+ +[A-Z] [A-Z]$', s) AND CheckBusEndings(s) => MatchType.Business,
		
		quality = 0 => NotAName(name, s, words, format),			// Persons.NameStatus.NotAName
		quality <> 0 => $.fn_isPerson(name, quality),
		MatchType.NoMatch);

	END;

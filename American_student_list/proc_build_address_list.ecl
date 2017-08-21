import ut,
			address,
			PromoteSupers,
			idl_header,
			Header_Slimsort,
			AID,
 		  DID_Add,
			lib_StringLib,
			Census_Data,
			Watchdog,
			mdr,
			std;
EXPORT proc_build_address_list(string filedate=(string)std.date.today()) := function

apply_Kaye_rules(ds, field) := functionmacro
	ds txDs(ds L) := transform
		temp := StringLib.StringCleanSpaces(L.field);
		temp1 := IF(REGEXFIND('^SAINT | SAINT ',temp),STD.Str.FindReplace(temp,'SAINT','ST'),temp);
		temp2 := IF(REGEXFIND('^MOUNT | MOUNT ',temp1),STD.Str.FindReplace(temp1,'MOUNT','MT'),temp1);
		temp3 := IF(REGEXFIND('^JUNIOR COLLEGE| JUNIOR COLLEGE| JR COLLEGE',temp2),REGEXREPLACE('^JUNIOR COLLEGE| JUNIOR COLLEGE| JR COLLEGE',temp2,	' COLLEGE'),temp2);
		temp4 := STD.Str.FindReplace(temp3,'ASOCIATION','ASSOCIATION');
		temp5 := STD.Str.FindReplace(temp4,'THEOLOGICAL SEMINARY','SEMINARY');
		temp6 := STD.Str.FindReplace(temp5,'CHINESE CULTURE HEALTH SCIENCES','CHINESE CULTURE');
		temp7 := STD.Str.FindReplace(temp6,'PHARMACY HEALTH SCIENCES','PHARMACY');
		temp8 := IF(REGEXFIND(' SCIENCES | SCIENCES$',temp7),STD.Str.FindReplace(temp7,'SCIENCES','SCIENCE'),temp7);
		temp9 := REGEXREPLACE('COLLEGE TECHNICAL',temp8,	'COLLEGE TECH');
		temp10 := REGEXREPLACE('TECHNICAL COLLEGE',temp9,	'TECH COLLEGE');
		temp11 := REGEXREPLACE('COLLEGE DISTRICT$',temp10,	'COLLEGE');
		temp12 := REGEXREPLACE('ART DESIGN FILM',temp11,	'ART DESIGN');
		temp13 := REGEXREPLACE('UNIVERSITY',temp12,	'UNIVERSITY');
		temp14 := REGEXREPLACE(' ANESTHESIA INC$',temp13,	' ANESTHESIA');
		temp15 := REGEXREPLACE('FLORIDA ONLINE',temp14,	'FLORIDA');
		temp16 := REGEXREPLACE('UNITED STATES',temp15,	'US');
		temp17 := REGEXREPLACE('MIRA COSTA',temp16,	'MIRACOSTA');
		temp18 := IF(REGEXFIND('MAIN CAMPUS',temp17), temp17, REGEXREPLACE(' CAMPUS$',temp17,	''));
		temp19 := REGEXREPLACE('NORAMNDALE',temp18,	'NORMANDALE');
		//CENTRAL CAROLINA TECH COLLEGE, FLORENCE DARLINGTON TECH COLLEGE
		temp20 := REGEXREPLACE('TECHNOLOGY COLLEGE',temp19,	'TECH COLLEGE');
		temp21 := REGEXREPLACE('A M UNIVERSITY',temp20,	'AM UNIVERSITY');
		temp22 := REGEXREPLACE('UNIVERISTY',temp21,	'UNIVERSITY');
		temp23 := REGEXREPLACE(' O R T ',temp22,	' ORT ');
		temp24 := REGEXREPLACE('ALBEMARIE',temp23,	'ALBEMARLE');
		temp25 := REGEXREPLACE(' DU PAGE',temp24,	' DUPAGE');
		temp26 := REGEXREPLACE('JOHN F. KENNEDY',temp25,	'JOHN F KENNEDY');
		temp27 := REGEXREPLACE('^LAWRENCE TECHNICAL',temp26,	'LAWRENCE TECHNOLOGICAL');
		temp28 := REGEXREPLACE('ACADEMY OF ARTS$',temp27,	'ACADEMY OF ART');
		temp29 := REGEXREPLACE(' COLLEGE SYSTEM$',temp28,	' COLLEGE');
		temp30 := REGEXREPLACE('INSTITUTE MUSIC',temp29,	' INSTITUTE OF MUSIC');
		temp31 := REGEXREPLACE('AGRICULTURAL MECHANICAL UNIVERSITY',temp30,	'AM UNIVERSITY');
		temp32 := REGEXREPLACE('QUINEBAUQ',temp31,	'QUINEBAUG');
		temp33 := REGEXREPLACE('AMERIAN INDIAN',temp32,	'AMERICAN INDIAN');
		temp34 := REGEXREPLACE('VERMILLION',temp33,	'VERMILION');

		temp95 := CASE(TRIM(temp34,LEFT,RIGHT),
		               'A T STILL UNIVERSITY' => 'A T STILL UNIVERSITY OF HEALTH SCIENCE',
		               'ALBANY LAW SCHOOL' => 'ALBANY LAW SCHOOL OF UNION COLLEGE',
		               'ALLEGANY COLLEGE' => 'ALLEGANY COLLEGE OF MARYLAND',
		               'ASHLAND COMMUNITY COLLEGE' => 'ASHLAND COMMUNITY TECH COLLEGE',
		               'ASNUNTUCK COMMUNITY TECH COLLEGE' => 'ASNUNTUCK COMMUNITY COLLEGE',
		               'AUGUSTA TECHNICAL COLLEGE' => 'AUGUSTA TECH COLLEGE',
		               'BAINBRIDGE COLLEGE' => 'BAINBRIDGE STATE COLLEGE',
		               'BAYLOR COLLEGE' => 'BAYLOR COLLEGE OF MEDICINE',
		               'BELLEVUE COMMUNITY COLLEGE' => 'BELLEVUE COLLEGE',
									 'BELMONT TECHNICAL COLLEGE' => 'BELMONT COLLEGE',
		               'BLOOMSBURG UNIVERSITY' => 'BLOOMSBURG UNIVERSITY OF PENNSYLVANIA',
		               'BROWARD COMMUNITY COLLEGE' => 'BROWARD COLLEGE',
		               'CALIFORNIA COLLEGE OF ARTS CRAFTS' => 'CALIFORNIA COLLEGE OF ARTS',
		               'CALIFORNIA MARITIME ACADEMY' => 'THE CALIFORNIA MARITIME ACADEMY',
		               'CALHOUN COMMUNITY COLLEGE' => 'JOHN C CALHOUN STATE COMMUNITY COLLEGE',
		               'CARLOS ALBIZU UNIVERSITY' => 'CARLOS ALBIZU UNIVERSITY MIAMI',
		               'CASTLETON STATE COLLEGE' => 'CASTLETON UNIVERSITY',
		               'CATHOLIC THEOLOGICAL UNION' => 'CATHOLIC THEOLOGICAL UNION AT CHICAGO',
		               'CENTRAL PENNSYLVANIA COLLEGE' => 'CENTRAL PENN COLLEGE',
		               'CHAMINADE UNIVERSITY' => 'CHAMINADE UNIVERSITY OF HONOLULU',
		               'CHARLES R DREW UNIVERSITY' => 'CHARLES R DREW UNIVERSITY OF MEDICINE SCIENCE',
		               'CHARLES S MOTT COMMUNITY COLLEGE' => 'MOTT COMMUNITY COLLEGE',
		               'CHATTANOOGA STATE COMMUNITY COLLEGE' => 'CHATTANOGA STATE TECHNICAL COMMUNITY COLLEGE',
		               'COCONINO COUNTY COMM COLLEGE' => 'COCONINO COMMUNITY COLLEGE',
									 'COLLEGE MISERICORDIA' => 'MISERICORDIA UNIVERSITY',
		               'COLUMBIA UNIVERSITY' => 'COLUMBIA UNIVERSITY IN CITY OF NEW YORK',
		               'COMMONWEALTH INSTITUTE OF FUNERAL SERVICE' => 'COMMONWEALTH INSTITUTE FUNERAL SERVICES',
		               'COMMUNITY COLLEGE OF BALTIMORE COUNTY' => 'THE COMMUNITY COLLEGE OF BALTIMORE COUNTY',									 
		               'COSSATOT COMMUNITY COLLEGE OF UNIVERSITY OF ARKANSAS' => 'COSSATOT COMMUNITY COLLEGE',
									 'DAKOTA COLLEGE' => 'DAKOTA COLLEGE AT BOTTINEAU',
		               'DALLAS INSTITUTE OF FUNERAL SERVICE' => 'DALLAS INSTITUTE OF FUNERAL SERVICES',
		               'DARTON STATE COLLEGE' => 'DARTON COLLEGE',
	                 'DELAWARE TECHNICAL COMMUNITY COLLEGE TERRY' => 'DELAWARE TECHNICAL COMMUNITY COLLEGE',
		               'DIXIE STATE UNIVERSITY' => 'DIXIE COLLEGE',
									 'DOMINICAN COLLEGE' => 'DOMINICAN COLLEGE OF BLAUVELT',
		               'DRAKE STATE TECHNICAL COLLEGE' => 'J F DRAKE STATE COMMUNITY TECH COLLEGE',
		               'EAST GEORGIA COLLEGE' => 'EAST GEORGIA STATE COLLEGE',
		               'EDINBORO UNIVERSITY OF PENNSYLVANIA' => 'EDINBORO UNIVERSITY',
			             'EL CAMINO COLLEGE' => 'EL CAMINO COMMUNITY COLLEGE',
			             'ENTERPRISE STATE COLLEGE' => 'ENTERPRISE STATE COMMUNITY COLLEGE',
									 'EUGENE BIBLE COLLEGE' => 'NEW HOPE CHRISTIAN COLLEGE EUGENE',
			             'EVERGREEN STATE COLLEGE' => 'THE EVERGREEN STATE COLLEGE',
			             'FRANCISCAN UNIVERSITY' => 'FRANCISCAN UNIVERSITY OF STEUBENVILLE',
		               'FULLER SEMINARY' => 'FULLER SEMINARY IN CALIFORNIA',
		               'GARRETT COMMUNITY COLLEGE' => 'GARRETT COLLEGE',
		               'GEORGIA INSTITUTE OF TECHNOLOGY MAIN CAMPUS' => 'GEORGIA INSTITUTE OF TECHNOLOGY',
		               'GLOUCESTER COUNTY COLLEGE' => 'ROWAN COLLEGE AT GLOUCESTER COUNTY',
		               'GOLDEN GATE UNIVERSITY SAN FRANCISCO' => 'GOLDEN GATE UNIVERSITY',
		               'GRAYSON COUNTY COLLEGE' => 'GRAYSON COLLEGE',
		               'GREEN RIVER COMMUNITY COLLEGE' => 'GREEN RIVER COLLEGE',
		               'GULF COAST COMMUNITY COLLEGE' => 'GULF COAST STATE COLLEGE',
		               'HARRISBURG AREA COMMUNITY COLLEGE HARRISBURG' => 'HARRISBURG AREA COMMUNITY COLLEGE',
		               'HARRIS STOWE STATE COLLEGE' => 'HARRIS STOWE STATE UNIVERSITY',
		               'HEBREW UNION COLLEGE JEWISH INSTITUTE OF RELIGION' => 'HEBREW UNION COLLEGE',
		               'HELLENIC COLLEGE HOLY CROSS GREEK ORTHODOX SCHOOL OF THEOLOGY' => 'HELLENIC COLLEGE HOLY CROSS',
		               'HENRY FORD COMMUNITY COLLEGE' => 'HENRY FORD COLLEGE',
		               'MESABI RANGE COMMUNITY TECHNICAL COLLEGE' => 'MESABI RANGE COLLEGE',
		               'HIGHLINE COMMUNITY COLLEGE' => 'HIGHLINE COLLEGE',
		               'HUMPHREYS COLLEGE' => 'HUMPHREYS COLLEGE STOCKTON MODESTO CAMPUSES',
		               'HUSSIAN SCHOOL OF ART' => 'HUSSIAN COLLEGE SCHOOL OF ART',
		               'INDEPENDENCE COLLEGE' => 'INDEPENDENCE COLLEGE OF COSMETOLOGY',
		               'INDIAN RIVER COMMUNITY COLLEGE' => 'INDIAN RIVER STATE COLLEGE',
		               'INDIANA UNIVERSITY OF PENNSYLVANIA MAIN CAMPUS' => 'INDIANA UNIVERSITY OF PENNSYLVANIA',
		               'INDIANA WESLEYAN UNIVERSITY MARION' => 'INDIANA WESLEYAN UNIVERSITY',
		               'JACKSONVILLE COLLEGE MAIN CAMPUS' => 'JACKSONVILLE COLLEGE',
		               'JEFFERSON TECHNICAL COLLEGE' => 'JEFFERSON COMMUNITY AND TECHNICAL COLLEGE',
		               'KANSAS CITY COMMUNITY COLLEGE' => 'KANSAS CITY KANSAS COMMUNITY COLLEGE',
		               'KETTERING COLLEGE' => 'KETTERING COLLEGE OF MEDICAL ARTS',
		               'LAKE SUMTER COMMUNITY COLLEGE' => 'LAKE SUMTER STATE COLLEGE',
		               'LAKE WASHINGTON INSTITUTE OF TECHNOLOGY' => 'LAKE WASHINGTON TECH COLLEGE',
									 'LAWSON STATE COMMUNITY COLLEGE BIRMINGHAM' => 'LAWSON STATE COMMUNITY COLLEGE',
									 'LASSEN COMMUNITY COLLEGE' => 'LASSEN COLLEGE',
									 'LINCOLN COLLEGE OF NEW ENGLAND' => 'LINCOLN COLLEGE OF NEW ENGLAND SOUTHINGTON',
		               'LOUISIANA STATE UNIVERSITY AGRICULTURAL MECHANICAL COLLEGE' => 'LOUISIANA STATE UNIVERSITY AM',
		               'LOUISIANA TECHNICAL UNIVERSITY' => 'LOUISIANA TECH UNIVERSITY',
		               'MANSFIELD UNIVERSITY' => 'MANSFIELD UNIVERSITY OF PENNSYLVANIA',
									 'MASSACHUSETTS COLLEGE OF ART' => 'MASSACHUSETTS COLLEGE OF ART DESIGN',
									 'MEMPHIS COLLEGE OF ARTS' => 'MEMPHIS COLLEGE OF ART',
		               'MIAMI DADE COMMUNITY COLLEGE' => 'MIAMI DADE COLLEGE',
		               'MIDDLE GEORGIA COLLEGE' => 'MIDDLE GEORGIA STATE UNIVERSITY',
		               'MOTLOW STATE COMMUNITY COLLEGE' => 'MOTLOW COLLEGE',
		               'MT SAN JACINTO COLLEGE' => 'MT SAN JACINTO COMMUNITY COLLEGE DISTRICT',
		               'NAVAJO COMMUNITY COLLEGE' => 'DINE COLLEGE',
		               'NORTH SEATTLE COMMUNITY COLLEGE' => 'NORTH SEATTLE COLLEGE',
		               'NORTHEAST STATE TECHNICAL COMMUNITY COLLEGE' => 'NORTHEAST STATE COMMUNITY COLLEGE',
		               'NORTHERN NEW MEXICO COMMUNITY COLLEGE' => 'NORTHERN NEW MEXICO COLLEGE',
		               'OWENSBORO COMMUNITY AND TECHNICAL COLLEGE' => 'OWENSBORO COMMUNITY COLLEGE',
		               'PALM BEACH COMMUNITY COLLEGE' => 'PALM BEACH STATE COLLEGE',
		               'PENSACOLA COLLEGE' => 'PENSACOLA STATE COLLEGE',
		               'PHILLIPS COMMUNITY COLLEGE OF THE UNIVERSITY OF ARKANSAS' => 'PHILLIPS COMMUNITY COLLEGE',
		               'PIMA COUNTY COMMUNITY COLLEGE' => 'PIMA COMMUNITY COLLEGE',
		               'PINE TECHNICAL COMMUNITY COLLEGE' => 'PINE TECHNICAL COLLEGE',
		               'POLK COMMUNITY COLLEGE' => 'POLK STATE COLLEGE',
		               'RAMAPO COLLEGE OF NEW JERSEY' => 'RAMAPO COLLEGE',
		               'RANCHO SANTIAGO COMMUNITY COLLEGE DISTRICT OFFICE' => 'RANCHO SANTIAGO COMMUNITY COLLEGE',
		               'RICHARD BLAND COLLEGE OF THE COLLEGE OF WILLIAM AND MARY' => 'RICHARD BLAND COLLEGE',
		               'RICHARD STOCKTON COLLEGE' => 'STOCKTON UNIVERSITY',
		               'RIVERSIDE CITY COLLEGE' => 'RIVERSIDE COMMUNITY COLLEGE',
		               'SALISBURY STATE UNIVERSITY' => 'SALISBURY UNIVERSITY',
		               'SAN JACINTO COLLEGE' => 'SAN JACINTO COMMUNITY COLLEGE',
		               'SAVANNAH TECHNICAL INSTITUTE' => 'SAVANNAH TECHNICAL COLLEGE',
		               'SEATTLE CENTRAL COMMUNITY COLLEGE' => 'SEATTLE CENTRAL COLLEGE',
		               'SEWARD COUNTY COMMUNITY COLLEGE AREA TECHNICAL SCHOOL' => 'SEWARD COUNTY COMMUNITY COLLEGE',
		               'ST JOHNS RIVER COMMUNITY COLLEGE' => 'ST JOHNS RIVER STATE COLLEGE',
									 'STARR KING SCHOOL OF MINISTRY' => 'STARR KING SCHOOL FOR THE MINISTRY',
		               'TRENHOLM STATE TECHNICAL COLLEGE' => 'H COUNCILL TRENHOLM STATE COMMUNITY COLLEGE',
		               'UNIVERSITY OF VIRGINIA MAIN CAMPUS' => 'UNIVERSITY OF VIRGINIA',
									 'UTICA COLLEGE OF COMMERCE' => 'UTICA SCHOOL OF COMMERCE',
		               'VALENCIA COMMUNITY COLLEGE' => 'VALENCIA COLLEGE',
									 'VALLEY FORGE CHRISTIAN COLLEGE' => 'UNIVERSITY OF VALLEY FORGE',
									 'VERMONT COLLEGE' => 'VERMONT COLLEGE OF FINE ARTS',
									 'VILLA JULIE COLLEGE' => 'STEVENSON UNIVERSITY',
									 'VIRGINIA MARTI COLLEGE OF FASHION & ART' => 'VIRGINIA MARTI COLLEGE OF ART AND DESIGN',
									 'VIRGINIA TECH' => 'VIRGINIA TECH CARILION SCHOOL OF MEDICINE',
									 'WASHINGTON UNIVERSITY' => 'WASHINGTON UNIVERSITY IN ST LOUIS',
									 'WEBB INSTITUTE' => 'WEBB INSTITUTE OF NAVAL ARCHITECTURE',
									 'WENTWORTH MILITARY ACADEMY' => 'WENTWORTH MILITARY ACADEMY AND COLLEGE',
									 'WEST GEORGIA TECHNICAL INSTITUTE' => 'WEST GEORGIA TECHNICAL COLLEGE',
									 'WESTERN NEVADA COLLEGE' => 'WESTERN NEVADA COMMUNITY COLLEGE',
									 'WILLIAM PATERSON UNIVERSITY' => 'WILLIAM PATERSON UNIVERSITY OF NEW JERSEY',
									 'YO SAN UNIVERSITY' => 'YO SAN UNIVERSITY OF TRADITIONAL CHINESE MEDICINE',
									 'YORK COLLEGE OF PENNSYLVANIA' => 'YORK COLLEGE PENNSYLVANIA',
									 temp34);
		temp96 := IF(REGEXFIND('^HOLY APOSTLES |$INTERNATIONAL BAPTIST ',temp95) and REGEXFIND(' COLLEGE$',temp95),
								 REGEXREPLACE(' COLLEGE$',temp95,	' COLLEGE SEMINARY'),
								 temp95);
		temp97 := IF(REGEXFIND('^HARRIS STOWE |^ATLANTA METROPOLITAN ',temp96) and REGEXFIND(' STATE COLLEGE$',temp96),
								 REGEXREPLACE(' STATE COLLEGE$',temp96,	' COLLEGE'),
								 temp96);

		//Colleges that have been promoted to university
		temp98 := IF(REGEXFIND('^ACADEMY OF ART |' +
		                       '^ADAMS STATE |' +
													 '^ALDERSON BROADDUS |' +
													 '^ALVERNIA |' +
													 '^AVERETT |' +
													 '^AVILA |' +
													 '^BALDWIN WALLACE |' +
													 '^BASTYR |' +
		                       '^BAY PATH |' +
													 '^BELHAVEN |' +
													 '^BENTLEY |' +
													 '^BLUFFTON |' +
													 '^BRIDGEWATER STATE |' +
													 '^CALDWELL |' +
													 '^CHATHAM |' +
		                       '^CLAFLIN |' +
													 '^CLARKE |' +
													 '^CLEARY |' +
													 '^COPPIN STATE |' +
													 '^DELAWARE VALLEY |' +
													 '^FELICIAN |' +
													 '^FITCHBURG STATE |' +
													 '^FONTBONNE |' +
													 '^FRAMINGHAM STATE |' +
													 '^FRANKLIN PIERCE |' +
													 '^GEORGIAN COURT |' +
													 '^GRAND VIEW |' +
													 '^GWYNEDD MERCY |' +
		                       '^HEIDELBERG |' +
													 '^HOLY NAMES |' +
													 '^HUSSON |' +
		                       '^IMMACULATA |' +
													 '^IOWA WESLEYAN |' +
													 '^LINCOLN CHRISTIAN |' +
													 '^LOURDES |' +
													 '^MALONE |' +
													 '^MANCHESTER |' +
													 '^MARIAN |' +
													 '^MARS HILL |' +
													 '^MERCYHURST |' +
													 '^MIDWAY |' +
													 '^MT MARY |' +
													 '^MT MERCY |' +
													 '^MUSKINGUM |' +
													 '^NEUMANN |' +
													 '^OAKLAND CITY |' +
													 '^OAKWOOD |' +
													 '^OHIO DOMINICAN |' +
													 '^OTTERBEIN |' +
													 '^PALM BEACH ATLANTIC |' +
													 '^REINHARDT |' +
													 '^RIVIER |' +
													 '^ROBERT MORRIS |' +
													 '^ROCKFORD |' +
													 '^SALEM STATE |' +
													 '^SAMUEL MERRITT |' +
													 '^SCHREINER |' +
													 '^SETON HILL |' +
													 '^SHEPHERD |' +
													 '^SOUTHERN VIRGINIA |' +
													 '^SPRING ARBOR |' +
													 '^THOMAS EDISON STATE |' +
													 '^WESTERN NEW ENGLAND |' +
													 '^WESTFIELD STATE |' +
													 '^WHITWORTH |' +
													 '^WORCESTER STATE '
													 ,temp97) AND 
													 REGEXFIND('COLLEGE$',temp97),
		             REGEXREPLACE('COLLEGE$',temp97,	'UNIVERSITY'),
								 temp97);
		temp99 := IF(REGEXFIND('STATE COLLEGE',temp98) and REGEXFIND('COPPIN|FITCHBURG',temp98),
		             REGEXREPLACE('STATE COLLEGE',temp98,	'STATE UNIVERSITY'),
								 temp98);
		SELF.field 	:= temp99;
		SELF				:= L;
	end;
	ds_mod := project(ds,txDs(left));
	return ds_mod;
endmacro;

inputset:=American_student_list.file_american_student_list_address_in;
inputset_college_name := table(inputset,{college_name,cnt:=count(group)},college_name);
//Remove schools that have multiple entries in address list to avoid incorrect matching.
inputset_filtered := join(inputset,inputset_college_name(cnt>1),
													left.college_name=right.college_name,
													left only, all);
modrec	:=	record
string MOD_COLLEGE_NAME;
American_student_list.layout_american_student_list_address_in;
end;
ToupperSet:=project(inputset_filtered,transform(modrec,self.COLLEGE_NAME := trim(std.str.ToUpperCase(Left.COLLEGE_NAME),left,right); self.MOD_COLLEGE_NAME := trim(std.str.ToUpperCase(Left.COLLEGE_NAME),left,right);self:=left));
ToupperSetDist:=distribute(ToupperSet,hash(COLLEGE_NAME));
RemoveSpecialInput:=project(ToupperSetDist,transform(modrec,self.MOD_COLLEGE_NAME := std.str.filterout(Left.MOD_COLLEGE_NAME,'&*\'\"'); self:=left;));
StandardSpaceInput:=project(RemoveSpecialInput,transform(modrec,self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,'-',' ');self:=left;));
RemoveANDInput:=project(StandardSpaceInput,transform(modrec,self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' AND ','');self:=left;));
RemoveTHEInput:=project(RemoveANDInput,transform(modrec,self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' THE ','');self:=left;));
RemoveCENTRALOFFICEInput:=project(RemoveTHEInput,transform(modrec,self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' CENTRAL OFFICE ','');self:=left;));
RemoveADMINISTRATIVEOFFICEInput:=project(RemoveCENTRALOFFICEInput,transform(modrec,self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' ADMINISTRATIVE OFFICE ','');self:=left;));
RemoveDISTRICTOFFICEInput:=project(RemoveADMINISTRATIVEOFFICEInput,transform(modrec,self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' DISTRICT OFFICE ','');self:=left;));
RemoveDISTRICTInput:=project(RemoveDISTRICTOFFICEInput,transform(modrec,self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' DISTRICT ','');self:=left;));
RemoveADMINISTRATIONInput:=project(RemoveDISTRICTInput,transform(modrec,self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' ADMINISTRATION ','');self:=left;));
RemoveOFFICEInput:=project(RemoveADMINISTRATIONInput,transform(modrec,self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' OFFICE ','');self:=left;));
AppleKayeRuleInput := apply_Kaye_rules(RemoveOFFICEInput,MOD_COLLEGE_NAME);
RemoveSpacesInput:=project(AppleKayeRuleInput,transform(modrec,self.MOD_COLLEGE_NAME :=std.str.filterout(Left.MOD_COLLEGE_NAME,' ');self:=left;));

loadfile:=american_student_list.File_American_Student_DID_v2;

CollegeNames:=project(loadfile,transform({string COLLEGE_NAME, string college_code_exploded, string college_type_exploded},self.COLLEGE_NAME:=trim(left.LN_COLLEGE_NAME,left,right);self:=left;));

UniqueNames:=sort(distribute(CollegeNames,hash(COLLEGE_NAME)),COLLEGE_NAME,local);

RollupInfo:=rollup(UniqueNames,Left.COLLEGE_NAME=Right.COLLEGE_NAME,transform({string COLLEGE_NAME, string college_code_exploded, string college_type_exploded},
																																		self.college_code_exploded:=if(Left.college_code_exploded='',Right.college_code_exploded,Left.college_code_exploded);
																																		self.college_type_exploded:=if(Left.college_type_exploded='',Right.college_type_exploded,Left.college_type_exploded);
																																		self:=Left;),local);

RemoveSpecialASL:=project(RollupInfo,transform({string COLLEGE_NAME, string MOD_COLLEGE_NAME, string college_code_exploded, string college_type_exploded},self.MOD_COLLEGE_NAME := std.str.filterout(Left.COLLEGE_NAME,'&*\'\"');self:=left; ));
StandardSpaceASL:=project(RemoveSpecialASL,transform({string COLLEGE_NAME, string MOD_COLLEGE_NAME, string college_code_exploded, string college_type_exploded},self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,'-',' ');self:=left;));
RemoveANDASL:=project(StandardSpaceASL,transform({string COLLEGE_NAME, string MOD_COLLEGE_NAME, string college_code_exploded, string college_type_exploded},self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' AND ','');self:=left;));
RemoveTHEASL:=project(RemoveANDASL,transform({string COLLEGE_NAME, string MOD_COLLEGE_NAME, string college_code_exploded, string college_type_exploded},self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' THE ','');self:=left;));
RemoveCENTRALOFFICEASL:=project(RemoveTHEASL,transform({string COLLEGE_NAME, string MOD_COLLEGE_NAME, string college_code_exploded, string college_type_exploded},self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' CENTRAL OFFICE ','');self:=left;));
RemoveADMINISTRATIVEOFFICEASL:=project(RemoveCENTRALOFFICEASL,transform({string COLLEGE_NAME, string MOD_COLLEGE_NAME, string college_code_exploded, string college_type_exploded},self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' ADMINISTRATIVE OFFICE ','');self:=left;));
RemoveDISTRICTOFFICEASL:=project(RemoveADMINISTRATIVEOFFICEASL,transform({string COLLEGE_NAME, string MOD_COLLEGE_NAME, string college_code_exploded, string college_type_exploded},self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' DISTRICT OFFICE ','');self:=left;));
RemoveDISTRICTASL:=project(RemoveDISTRICTOFFICEASL,transform({string COLLEGE_NAME, string MOD_COLLEGE_NAME, string college_code_exploded, string college_type_exploded},self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' DISTRICT ','');self:=left;));
RemoveADMINISTRATIONASL:=project(RemoveDISTRICTASL,transform({string COLLEGE_NAME, string MOD_COLLEGE_NAME, string college_code_exploded, string college_type_exploded},self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' ADMINISTRATION ','');self:=left;));
RemoveOFFICEASL:=project(RemoveADMINISTRATIONASL,transform({string COLLEGE_NAME, string MOD_COLLEGE_NAME, string college_code_exploded, string college_type_exploded},self.MOD_COLLEGE_NAME :=STD.Str.FindReplace(Left.MOD_COLLEGE_NAME,' OFFICE ','');self:=left;));
AppleKayeRuleASL := apply_Kaye_rules(RemoveOFFICEASL,MOD_COLLEGE_NAME);
RemoveSpacesASL:=project(AppleKayeRuleASL,transform({string COLLEGE_NAME, string MOD_COLLEGE_NAME, string college_code_exploded, string college_type_exploded},self.MOD_COLLEGE_NAME :=std.str.filterout(Left.MOD_COLLEGE_NAME,' ');self:=left;));

MatchingListASL:=join(RemoveSpacesASL(MOD_COLLEGE_NAME<>''),
											RemoveSpacesInput,
											// datalib.StringSimilar100(left.MOD_COLLEGE_NAME,right.MOD_COLLEGE_NAME) <= 30,
											left.MOD_COLLEGE_NAME=right.MOD_COLLEGE_NAME,
											transform(American_student_list.layout_american_student_list_address_matches,
																self.LN_COLLEGE_NAME:=left.COLLEGE_NAME; self.ListName:=right.COLLEGE_NAME; 
																self.ModASLName:=left.MOD_COLLEGE_NAME; self.ModListName:=right.MOD_COLLEGE_NAME;
																self.score:=0;		//datalib.StringSimilar100(left.MOD_COLLEGE_NAME,right.MOD_COLLEGE_NAME);
																self.rawaid:=0;
																self:=left;
																self:=right;
																self:=[]),all);

SortedList:=sort(MatchingListASL,LN_COLLEGE_NAME);

American_student_list.layout_american_student_list_address_matches tLowestScore(American_student_list.layout_american_student_list_address_matches L, American_student_list.layout_american_student_list_address_matches R)	:= transform
	Self.ModASLName:=L.ModASLName;
	Self.Score:=if(L.Score>R.Score,R.Score,L.Score);
	Self.ListName:=if(L.Score>R.Score,R.ListName,L.ListName);
	Self.ModListName:=if(L.Score>R.Score,R.ModListName,L.ModListName);
	Self:=if(L.Score>R.Score,R,L);
end;

FinalList:=rollup(SortedList,Left.LN_COLLEGE_NAME=Right.LN_COLLEGE_NAME,tLowestScore(Left,Right));

unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles;

layout_AIDClean_prep := RECORD
			string77	Append_Prep_Address_Situs;
			string54	Append_Prep_Address_Last_Situs;
			American_student_list.layout_american_student_list_address_matches;
		END;

layout_AIDClean_prep tProjectAIDClean(FinalList pInput) := TRANSFORM

		self.Append_Prep_Address_Situs				:=	Address.fn_addr_clean_prep(pInput.Address, 'first'),
																									
		self.Append_Prep_Address_Last_Situs	:=	Address.fn_addr_clean_prep(pInput.city
																							+	IF(pInput.city <> '',', ','') + pInput.state
																							+	' ' + pInput.origzip, 'last');
		self := pInput;
	END;
	
	rsAIDClean := PROJECT(SortedList /*FinalList */,tProjectAIDClean(LEFT));

AID.MacAppendFromRaw_2Line(rsAIDClean,Append_Prep_Address_Situs,Append_Prep_Address_Last_Situs,RawAID,rsCleanAID,lAIDFlags);

American_student_list.layout_american_student_list_address_matches tProjectClean(rsCleanAID pInput) := TRANSFORM
	  SELF.prim_range           := pInput.aidwork_acecache.prim_range;
    SELF.predir               := pInput.aidwork_acecache.predir;
    SELF.prim_name            := pInput.aidwork_acecache.prim_name;
    SELF.addr_suffix          := pInput.aidwork_acecache.addr_suffix;
    SELF.postdir              := pInput.aidwork_acecache.postdir;
    SELF.unit_desig           := pInput.aidwork_acecache.unit_desig;
    SELF.sec_range            := pInput.aidwork_acecache.sec_range;
    SELF.p_city_name          := pInput.aidwork_acecache.p_city_name;
    SELF.v_city_name          := pInput.aidwork_acecache.v_city_name;
    SELF.st                   := pInput.aidwork_acecache.st;
    SELF.zip                  := pInput.aidwork_acecache.zip5;
    SELF.zip4                 := pInput.aidwork_acecache.zip4;
    SELF.cart                 := pInput.aidwork_acecache.cart;
    SELF.cr_sort_sz           := pInput.aidwork_acecache.cr_sort_sz;
    SELF.lot                  := pInput.aidwork_acecache.lot;
    SELF.lot_order            := pInput.aidwork_acecache.lot_order;
    SELF.dbpc                 := pInput.aidwork_acecache.dbpc;
    SELF.chk_digit            := pInput.aidwork_acecache.chk_digit;
    SELF.rec_type             := pInput.aidwork_acecache.rec_type;
    SELF.county               := pInput.aidwork_acecache.county;
    SELF.geo_lat              := pInput.aidwork_acecache.geo_lat;
    SELF.geo_long             := pInput.aidwork_acecache.geo_long;
    SELF.msa                  := pInput.aidwork_acecache.msa;
    SELF.geo_blk              := pInput.aidwork_acecache.geo_blk;
    SELF.geo_match            := pInput.aidwork_acecache.geo_match;
    SELF.err_stat             := pInput.aidwork_acecache.err_stat;
    SELF.rawaid               := pInput.aidwork_rawaid;
    SELF  := pInput;
		
	END;
	
	rsCleanAIDGood := PROJECT(rsCleanAID, tProjectClean(LEFT));

	//Assign state code to public/state schools
	ASLOnly:=				 join(RemoveSpacesASL(MOD_COLLEGE_NAME<>''),
												RemoveSpacesInput,
												left.MOD_COLLEGE_NAME=right.MOD_COLLEGE_NAME,
												LEFT ONLY,
												ALL);

	School_State_List := DATASET([
																//Public/State schools
																{'ADAMS STATE COLLEGE','OH'}
																,{'AIR FORCE INSTITUTE OF TECHNOLOGY','OH'}
																,{'ALEXANDRIA TECHNICAL COLLEGE','MN'}
																// AMERICAN SAMOA COMMUNITY COLLEGE
																,{'ANOKA HENNEPIN TECHNICAL COLLEGE','MN'}
																,{'ARIZONA STATE UNIVERSITY','AZ'}
																,{'ARKANSAS STATE UNIVERSITY','AR'}
																,{'ARMSTRONG ATLANTIC STATE UNIVERSITY','GA'}
																,{'AUGUSTA STATE UNIVERSITY','GA'}
																,{'BELLEVILLE AREA COLLEGE','IL'}
																,{'BELMONT TECHNICAL COLLEGE','WA'}
																,{'BOWLING GREEN STATE UNIVERSITY','OH'}
																// BREVARD COMMUNITY COLLEGE - FL or NC?
																,{'BURLINGTON COUNTY COLLEGE','NJ'}
																,{'CALIFORNIA POLYTECHNIC STATE UNIVERSITY','CA'}
																,{'CALIFORNIA STATE UNIVERSITY','CA'}
																,{'CENTRAL FLORIDA COMMUNITY COLLEGE','FL'}
																,{'CENTRAL LAKES COLLEGE','MN'}
																,{'CITY COLLEGES OF CHICAGO','IL'}
																,{'CITY UNIVERSITY OF NEW YORK','NY'}
																// CLAYTON COLLEGE - AL, distance learning ?
																,{'COCHISE COLLEGECOCHISE COLLEGE','AZ'}
																,{'COLLEGE OF EASTERN UTAH','UT'}
																// COLLEGE OF OSTEOPATHIC MEDICINE ?
																,{'COLORADO STATE UNIVERSITY','CO'}
																// COMMUNITY COLLEGE OF S. ??
																// CONCORD COLLEGE
																// COOKE COUNTY COLLEGE - Texas ?
																// DAKOTA COLLEGE ND?
																,{'DEKALB TECHNICAL INSTITUTE','GA'}
																,{'DOUGLAS MACARTHUR STATE UNIVERSITY','AL'}
																,{'EASTERN NEW MEXICO UNIVERSITY','NM'}
																// EDISON COLLEGE ?
																,{'FAULKNER STATE COMMUNITY COLLEGE','AL'}
																,{'FERGUS FALLS COMMUNITY COLLEGE','NM'}
																,{'FLORIDA COMMUNITY COLLEGE JACKSONVILLE','FL'}
																,{'FLORIDA NATIONAL COLLEGE','FL'}
																,{'FORT BELKNAP COLLEGE','MT'}
																,{'GAINESVILLE STATE COLLEGE','GA'}
																,{'GARLAND COUNTY COMMUNITY COLLEGE','AR'}
																,{'GEORGE C WALLACE STATE COMMUNITY COLLEGE','AL'}
																,{'GRIFFIN TECHNICAL COLLEGE','GA'}
																,{'GUAM COMMUNITY COLLEGE','GU'}
																,{'GWINETTE TECHNICAL COLLEGE','GA'}
																,{'INDIANA UNIVERSITY','IN'}
																,{'INDIANA UNIVERSITY-PURDUE UNIVERSITY','IN'}
																// JACKSON COMMUNITY COLLEGE - many colleges with this or similar names
																,{'JOHN M PATTERSON STATE TECHNICAL COLLEGE','AL'}
																,{'KENT STATE UNIVERSITY','OH'}
																,{'LA COUNTY MEDICAL CENTER SCHOOL OF NURSING','CA'}
																,{'LAKE CITY COMMUNITY COLLEGE','FL'}
																,{'LAMAR STATE COLLEGE','TX'}
																,{'LAREDO JR COLLEGE','TX'}
																,{'LIMA TECHNICAL COLLEGE','OH'}
																,{'LOCK HAVEN UNIVERSITY OF PENNSYLVANIA','PA'}
																,{'LONGVIEW COMMUNITY COLLEGE','MO'}
																,{'LOUISIANA STATE UNIVERSITY','LA'}
																,{'LOUISIANA TECHNICAL COLLEGE','LA'}
																,{'LOUISIANA TECHNOLOGY COLLEGE','LA'}
																,{'MACON STATE COLLEGE','GA'}
																,{'MANATEE COMMUNITY COLLEGE','FL'}
																,{'MAPLE WOODS COMMUNITY COLLEGE','MO'}
																,{'MEDICAL COLLEGE OF GEORGIA','GA'}
																,{'MESA STATE COLLEGE','CO'}
																// METROPOLITAN COMMUNITY COLLEGE - NE or MO?
																// METROPOLITAN STATE COLLEGE
																,{'MIAMI UNIVERSITY','OH'}
																// MIDDLESEX COLLEGE - NJ, MA, CT?
																,{'MID-SOUTH COMMUNITY COLLEGE','MO'}
																,{'MINNESOTA STATE UNIVERSITY','MN'}
																,{'MISSISSIPPI COUNTY COMMUNITY COLLEGE','AR'}
																,{'MISSOURI STATE UNIVERSITY','MO'}
																,{'MOORHEAD STATE UNIVERSITY','MN'}
																,{'MUSCATINE COMMUNITY COLLEGE','IA'}
																,{'NAVAL POSTGRADUATE SCHOOL','CA'}
																,{'NEW HAMPSHIRE COMMUNITY COLLEGE','NH'}
																,{'NEW HAMPSHIRE COMMUNITY TECHNICAL COLLEGE','NH'}
																,{'NEW HAMPSHIRE TECHNICAL COLLEGE','NH'}
																,{'NEW HAMPSHIRE TECHNICAL INSTITUTE','NH'}
																,{'NEW HAMPSHIRE VOCATIONAL & TECHNICAL COLLEGE','NH'}
																,{'NEW MEXICO HIGHLAND UNIVERSITY','NM'}
																,{'NEW MEXICO STATE UNIVERSITY','NM'}
																,{'NORTH ADAMS STATE COLLEGE','MA'}
																,{'NORTH CAROLINA SCHOOL OF ARTS','NC'}
																,{'NORTH CAROLINA STATE UNIVERSITY','NC'}
																,{'NORTH CENTRAL KANSAS COLLEGE','KS'}
																,{'NORTH DAKOTA STATE UNIVERSITY','ND'}
																,{'NORTH METRO TECHNICAL COLLEGE','GA'}
																,{'NORTHERN MARIANAS COLLEGE','MP'}
																,{'NORTHERN WYOMING COMMUNITY COLLEGE','WY'}
																,{'NORTHWESTERN STATE UNIVERSITY','LA'}
																// NORTHWESTERN TECHNICAL COLLEGE - MN?
																// NORTHWESTERN TECHNICAL INSTITUTE - MI?
																,{'OHIO STATE UNIVERSITY','OH'}
																,{'OHIO UNIVERSITY','OH'}
																,{'OKALOOSA WALTON COMMUNITY COLLEGE','FL'}
																,{'OKLAHOMA STATE UNIVERSITY','OK'}
																// PALAU COMMUNITY COLLEGE - out of country
																,{'PENN VALLEY COMMUNITY COLLEGE','MO'}
																,{'PENNSYLVANIA STATE UNIVERSITY','PA'}
																// PIERCE COLLEGE - CA or WA?
																,{'PURDUE UNIVERSITY','IN'}
																// REDWOODS COMMUNITY COLLEGE - Is it the same as College of the Redwoods?
																,{'RHODES STATE COLLEGE','OH'}
																,{'RUTGERS UNIVERSITY','NJ'}
																,{'SALEM STATE COLLEGE','MA'}
																,{'SALINA COLLEGE OF TECHNOLOGY & AVIATION','KS'}
																,{'SCOTT COMMUNITY COLLEGE','IA'}
																// SEMINOLE COMMUNITY COLLEGE FL or OK?
																,{'SHERIDEN COLLEGE','WY'}
																,{'SHIPPENSBURG UNIVERSITY','PA'}
																,{'SLIPPERY ROCK UNIVERSITY','PA'}
																,{'SOUTH GEORGIA COLLEGE','GA'}
																,{'SOUTH MAINE TECHNICAL COLLEGE','ME'}
																,{'SOUTHEAST COMMUNITY COLLEGE','GA'}
																,{'SOUTHERN ARKANSAS UNIVERSITY','AR'}
																,{'SOUTHERN ILLINOIS UNIVERSITY','IL'}
																,{'SOUTHERN POLYTECHNIC STATE UNIVERSITY','GA'}
																,{'SOUTHERN UNIVERSITY','LA'}
																,{'SOUTHERN UNIVERSITY A&M','LA'}
																// SOUTHWEST COMMUNITY COLLEGE, TN, TX ?
																,{'STARK STATE COLLEGE OF TECHNOLOGY','OH'}
																,{'STATE COLLEGE OF FLORIDA','FL'}
																,{'STATE UNIVERSITY OF NEW YORK','NY'}
																,{'TERRA COMMUNITY COLLEGE','OH'}
																,{'TEXAS A&M UNIVERSITY','TX'}
																,{'TEXAS COLLEGE OF TRADITIONAL CHINESE MEDICINE','TX'}
																// TEXAS UNIVERSITY ??
																// THE CITADEL ??
																,{'TROY STATE UNIVERSITY','AL'}
																,{'TUNXIS COMMUNITY TECHNICAL COLLEGE','CT'}
																,{'UNIFORM SERVICES UNIVERSITY','MD'}
																,{'UNIVERSITY MEDICINE AND DENTISTRY OF NEW JERSEY','NJ'}
																,{'UNIVERSITY OF AKRON','OH'}
																,{'UNIVERSITY OF ALABAMA','AL'}
																,{'UNIVERSITY OF ALASKA','AK'}
																,{'UNIVERSITY OF ARKANSAS COMMUNITY COLLEGE','AR'}
																,{'UNIVERSITY OF CALIFORNIA','CA'}
																,{'UNIVERSITY OF CINCINATTI','OH'}
																,{'UNIVERSITY OF CINCINNATI','OH'}
																,{'UNIVERSITY OF COLORADO','CO'}
																,{'UNIVERSITY OF GUAM','GU'}
																,{'UNIVERSITY OF HAWAII','HI'}
																,{'UNIVERSITY OF ILLINOIS','IL'}
																,{'UNIVERSITY OF LOUISIANA','LA'}
																,{'UNIVERSITY OF MARYLAND','MD'}
																,{'UNIVERSITY OF MASSACHUSETTS','MA'}
																,{'UNIVERSITY OF MICHIGAN','MI'}
																,{'UNIVERSITY OF MINNESOTA','MN'}
																,{'UNIVERSITY OF MISSOURI','MO'}
																,{'UNIVERSITY OF MONTANA','MT'}
																,{'UNIVERSITY OF MONTANA WESTERN','MT'}
																,{'UNIVERSITY OF NEBRASKA','NE'}
																,{'UNIVERSITY OF NEVADA','NV'}
																,{'UNIVERSITY OF NEW HAMPSHIRE','NH'}
																,{'UNIVERSITY OF NEW MEXICO','NM'}
																,{'UNIVERSITY OF NORTH CAROLINA','NC'}
																,{'UNIVERSITY OF NORTHERN CALIFORNIA','CA'}
																,{'UNIVERSITY OF OKLAHOMA','OK'}
																,{'UNIVERSITY OF PITTSBURGH','PA'}
																,{'UNIVERSITY OF PUERTO RICO','PR'}
																,{'UNIVERSITY OF SCIENCE & ARTS','OK'}
																,{'UNIVERSITY OF SOUTH CAROLINA','SC'}
																,{'UNIVERSITY OF SOUTH FLORIDA','FL'}
																,{'UNIVERSITY OF TENNESSEE','TN'}
																,{'UNIVERSITY OF TEXAS','TX'}
																,{'UNIVERSITY OF WASHINGTON','WA'}
																,{'UNIVERSITY OF WEST FLORIDA','FL'}
																,{'UNIVERSITY OF WISCONSIN','WI'}
																,{'VERMILLION COMMUNITY COLLEGE','MN'}
																// VISTA COMMUNITY COLLEGE - TX?
																,{'WAYCROSS COLLEGE','GA'}
																,{'WEST HILLS COLLEGE','CA'}
																,{'WEST VIRGINIA BUSINESS COLLEGE','WV'}
																,{'WEST VIRGINIA CAREER INSTITUTE','PA'}				//Yes, it is at Mount Barddock, PA
																,{'WEST VIRGINIA JUNIOR COLLEGE','WV'}
																,{'WESTCHESTER COMMUNITY COLLEGE','NY'}
																,{'WESTERN CONNECTICUT UNIVERSITY','CT'}
																,{'WESTERN NEVADA COMMUNITY COLLEGE','NV'}
																// WESTERN STATE COLLEGE - ??
																,{'WESTFIELD STATE COLLEGE','MA'}
																,{'WILLIAM PATERSON UNIVERSITY','NJ'}
																,{'WILSON TECHNOLOGY COMMUNITY COLLEGE','NC'}
																,{'WORCESTER STATE COLLEGE','MA'}
																,{'WRIGHT STATE UNIVERSITY','OH'}
																//Private school
																,{'BETHANY UNIVERSITY','CA'}
																,{'BETHUNE COOKMAN COLLEGE','FL'}
																,{'BRIAR CLIFF COLLEGE','NY'}
																,{'CARSON NEWMAN COLLEGE','TN'}
																,{'MOUNT SENARIO','WI'}
																,{'MOUNTAIN STATE UNIVERSITY','WV'}
																,{'LA GRANGE COLLEGE','GA'}
																,{'LAMBUTH UNIVERSITY','TN'}
																,{'LENOIR RHYNE COLLEGE','NC'}
																,{'KNOXVILLE COLLEGE','TN'}
																,{'SOUTHWESTERN BAPTIST THEOLOGICAL SEMINARY','TX'}
																,{'VENNARD COLLEGE','IA'}
																,{'VIRGINIA INTERMONT COLLEGE','VA'}
																,{'WHARTON SCHOOL','PA'}
																,{'WESTCHESTER COMMUNITY COLLEGE','NY'}
																],{STRING name, STRING2 state});

	ASLOnly_State	:=		 join(ASLOnly,
														School_State_List,
														left.COLLEGE_NAME=right.name,
														TRANSFORM({American_student_list.layout_american_student_list_address_matches},
														          SELF.state:=RIGHT.state;
																			SELF.st:=RIGHT.state;
																			self.LN_COLLEGE_NAME:=left.COLLEGE_NAME;
																			self.ModASLName:=left.MOD_COLLEGE_NAME;
																			SELF:=LEFT;
																			SELF:=[]),
														ALL);	
	schools_with_address := rsCleanAIDGood + 	ASLOnly_State;		
	
	PromoteSupers.Mac_SF_BuildProcess(schools_with_address(st<>''),American_student_list.thor_cluster + 'address_list::american_student_list',build_address_list,,,,filedate);
	
	return build_address_list;

end;
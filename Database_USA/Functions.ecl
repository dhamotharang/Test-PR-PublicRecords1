import ut, std;
export Functions := Module;
	//********************************************************************
	//fGetBusTypeDesc: Returns the exploded business type designation 
	//********************************************************************	
  export  string fGetBusTypeDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map(	cd = 'F' => 'FIRM',
								cd = 'I' => 'INDIVIDUAL',
								cd = 'B' => 'BOTH',
								cd = 'D' => 'DEPARTMENT',
								cd = 'P' => 'POINT OF INTEREST',
								'**|'+ cd);
	end;
	
  //********************************************************************
	//fGetGenderDesc: Returns the exploded gender value 
	//********************************************************************	
  export  string fGetGenderDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map(	cd = 'U' =>	'UNSPECIFIED',
								cd = 'M' =>	'MALE',
								cd = 'F' => 'FEMALE',
								'**|'+ cd);
	end;	
	
	
	//********************************************************************
	//fExecutiveTypeDesc: Returns the exploded Exec Source value 
	//********************************************************************	
	export  string fExecutiveTypeDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = 'C' => 'COMPILED',
		            cd = 'E' => 'EXECUTIVE SOURCED NON COMPILED',
								'**|'+ cd);
	end;	
	
	//********************************************************************
	//fDBConsEthnicDesc: Returns the exploded ethnic value 
	//********************************************************************	
	export  string fDBConsEthnicDesc(string code) := function

		cd  := STD.Str.CleanSpaces( Std.Str.ToLowerCase(code));
		return map( cd = 'aam' => 'AFRICAN AMERICAN',
								cd = 'afc' => 'AFRICAN CONTINENTAL',
								cd = 'afg' => 'AFGHAN',
								cd = 'aka' => 'AKAN/ASHANTI',
								cd = 'alb' => 'ALBANIAN',
								cd = 'ale' => 'ALEUT',
								cd = 'alr' => 'ALGERIAN',
								cd = 'anl' => 'ANGOLAN',
								cd = 'ara' => 'ARAB',
								cd = 'arm' => 'ARMENIAN',
								cd = 'asn' => 'OTHER ASIAN/OTHER ORIENTAL',
								cd = 'aus' => 'AUSTRALIAN',
								cd = 'aut' => 'AUSTRIAN',
								cd = 'aze' => 'AZERBAIJANI',
								cd = 'bah' => 'BAHRAINI',
								cd = 'baq' => 'BASQUE',
								cd = 'beg' => 'BELGIAN',
								cd = 'bei' => 'BENINESE',
								cd = 'bel' => 'BYELORUSSIAN/BELORUSSIAN',
								cd = 'ben' => 'BANGLADESHI/BENGALI',
								cd = 'bhu' => 'BHUTANESE',
								cd = 'bos' => 'BOSNIAN/BOSNIAK/BOSNIAN MUSLIM',
								cd = 'brk' => 'BURKINABE (BURKINA FASO)',
								cd = 'brz' => 'BRAZILIAN',
								cd = 'bso' => 'BASOTHO',
								cd = 'bts' => 'BATSWANA (BOTSWANA)',
								cd = 'bul' => 'BULGARIAN',
								cd = 'bun' => 'BURUNDI',
								cd = 'bur' => 'BURMESE (MYANMAR)',
								cd = 'caa' => 'CARIBBEAN AFRICAN AMERICAN',
								cd = 'caf' => 'CENTRAL AFRICAN (CENTRAL AFRICAN REPUBLIC)',
								cd = 'cam' => 'CAMEROONIAN',
								cd = 'chd' => 'CHADIAN',
								cd = 'che' => 'CHECHEN',
								cd = 'chi' => 'CHINESE',
								cd = 'com' => 'COMORAN/COMOROS',
								cd = 'con' => 'CONGOLESE',
								cd = 'cze' => 'CZECH',
								cd = 'dan' => 'DANISH',
								cd = 'div' => 'MALDIVIAN AND TONGAN',
								cd = 'dji' => 'DJIBOUTIAN',
								cd = 'drc' => 'CONGOLESE (DRC)',
								cd = 'dut' => 'DUTCH',
								cd = 'egy' => 'EGYPTIAN',
								cd = 'eng' => 'ENGLISH',
								cd = 'eqg' => 'EQUATORIAL GUINEAN',
								cd = 'est' => 'ESTONIAN',
								cd = 'eth' => 'ETHIOPIAN',
								cd = 'fij' => 'FIJIAN',
								cd = 'fil' => 'FILIPINO/PHILIPPINE',
								cd = 'fin' => 'FINNISH',
								cd = 'fre' => 'FRENCH',
								cd = 'gaa' => 'GHANAIAN',
								cd = 'gab' => 'GABONESE',
								cd = 'gam' => 'GAMBIAN',
								cd = 'geo' => 'GEORGIAN',
								cd = 'ger' => 'GERMAN',
								cd = 'glv' => 'MANX',
								cd = 'gre' => 'GREEK',
								cd = 'gui' => 'GUINEAN (GUINEA-BISSAU)',
								cd = 'guy' => 'GUYANESE',
								cd = 'hat' => 'HAITIAN',
								cd = 'hau' => 'HAUSA',
								cd = 'haw' => 'HAWAIIAN',
								cd = 'heb' => 'HEBREW',
								cd = 'hmn' => 'HMONG',
								cd = 'hrv' => 'CROATIAN',
								cd = 'hun' => 'HUNGARIAN',
								cd = 'ibo' => 'IGBO',
								cd = 'ice' => 'ICELANDIC',
								cd = 'iku' => 'INUIT',
								cd = 'ind' => 'INDONESIAN',
								cd = 'inn' => 'INDIAN/ASIAN INDIAN',
								cd = 'irq' => 'IRAQI',
								cd = 'irs' => 'IRISH',
								cd = 'ita' => 'ITALIAN',
								cd = 'ivo' => 'IVORIAN (IVORY COAST)',
								cd = 'jam' => 'JAMAICAN',
								cd = 'jew' => 'JEWISH',
								cd = 'jpn' => 'JAPANESE',
								cd = 'kaz' => 'KAZAKH',
								cd = 'ken' => 'KENYAN',
								cd = 'khm' => 'KHMER',
								cd = 'kir' => 'KIRGHIZ',
								cd = 'kor' => 'KOREAN',
								cd = 'kur' => 'KURDISH',
								cd = 'kuw' => 'KUWAITI',
								cd = 'lao' => 'LAOTIAN',
								cd = 'lav' => 'LATVIAN',
								cd = 'lby' => 'LIBYAN',
								cd = 'lib' => 'LIBERIAN',
								cd = 'lie' => 'LIECHTENSTEIN',
								cd = 'lit' => 'LITHUANIAN',
								cd = 'ltz' => 'LUXEMBOURGIAN',
								cd = 'mac' => 'MACEDONIAN',
								cd = 'mau' => 'MAURITANIAN',
								cd = 'maw' => 'MALAWIAN',
								cd = 'may' => 'MALAY',
								cd = 'mlg' => 'MALAGASY (MADAGASCAR)',
								cd = 'mli' => 'MALIAN',
								cd = 'mlt' => 'MALTESE',
								cd = 'mol' => 'MOLDAVIAN/MOLDOVAN',
								cd = 'mon' => 'MONGOLIAN',
								cd = 'mor' => 'MOROCCAN',
								cd = 'moz' => 'MOZAMBICAN (MOZAMBIQUE)',
								cd = 'mul' => 'MULTI ETHNIC',
								cd = 'nam' => 'NAMIBIAN',
								cd = 'nat' => 'NATIVE AMERICAN',
								cd = 'nau' => 'NAURUAN',
								cd = 'nep' => 'NEPALESE',
								cd = 'nga' => 'NIGERIAN (NIGERIA)',
								cd = 'ngr' => 'NIGERIEN (NIGER)',
								cd = 'nor' => 'NORWEGIAN',
								cd = 'nze' => 'NEW ZEALAND',
								cd = 'pak' => 'PAKISTANI',
								cd = 'per' => 'PERSIAN',
								cd = 'pil' => 'PILI',
								cd = 'png' => 'PAPUA NEW GUINEAN',
								cd = 'pol' => 'POLISH',
								cd = 'por' => 'PORTUGUESE',
								cd = 'qat' => 'QATARI',
								cd = 'rum' => 'ROMANIAN',
								cd = 'rus' => 'RUSSIAN',
								cd = 'rwa' => 'RWANDAN/RUANDAN',
								cd = 'saf' => 'SOUTH AFRICAN',
								cd = 'sar' => 'SOUTHERN AFRICAN',
								cd = 'sau' => 'SAUDI',
								cd = 'sco' => 'SCOTTISH',
								cd = 'sen' => 'SENEGALESE',
								cd = 'sey' => 'SEYCHELLES',
								cd = 'sin' => 'SRI LANKAN/SINHALESE',
								cd = 'sle' => 'SIERRA LEONEAN',
								cd = 'slo' => 'SLOVAK',
								cd = 'slv' => 'SLOVENIAN',
								cd = 'smo' => 'SAMOAN',
								cd = 'som' => 'SOMALI',
								cd = 'sot' => 'SOTHO (LESOTHO)',
								cd = 'spa' => 'HISPANIC/SPANISH',
								cd = 'srp' => 'SERBIAN',
								cd = 'ssw' => 'SWAZI',
								cd = 'sud' => 'SUDANESE/SOUTH SUDANESE',
								cd = 'sur' => 'SURINAMESE',
								cd = 'swa' => 'SWAHILI',
								cd = 'swe' => 'SWEDISH',
								cd = 'sws' => 'SWISS',
								cd = 'syr' => 'SYRIAN',
								cd = 'tan' => 'TANZANIAN',
								cd = 'tel' => 'TELUGU',
								cd = 'tgk' => 'TAJIK',
								cd = 'tha' => 'THAI',
								cd = 'tib' => 'TIBETAN',
								cd = 'tiw' => 'TAIWANESE',
								cd = 'tol' => 'TOGOLESE',
								cd = 'ton' => 'TONGAN',
								cd = 'tri' => 'TRINIDADIAN',
								cd = 'tuk' => 'TURKMEN',
								cd = 'tun' => 'TUNISIAN',
								cd = 'tur' => 'TURKISH',
								cd = 'ugd' => 'UGANDAN',
								cd = 'ukr' => 'UKRAINIAN',
								cd = 'und' => 'DEFAULT/UNDETERMINED/UNKNOWN',
								cd = 'uzb' => 'UZBEK',
								cd = 'van' => 'VANUATUAN',
								cd = 'vie' => 'VIETNAMESE',
								cd = 'wel' => 'WELSH',
								cd = 'xho' => 'XHOSA',
								cd = 'yem' => 'YEMENI',
								cd = 'yor' => 'YORUBA',
								cd = 'zai' => 'ZAIREAN',
								cd = 'zam' => 'ZAMBIAN',
								cd = 'zim' => 'ZIMBABWEAN',
								cd = 'zul' => 'ZULU',
								'**|'+ cd);
	end;
	
	//********************************************************************
	//fDBConsReligiousDesc: Returns the DB Cons Religious value 
	//********************************************************************	
	export  string fDBConsReligiousDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = 'B' => 'BUDDHIST',
								cd = 'C' => 'CATHOLIC',
								cd = 'E' => 'ETHIOPIAN ORTHODOX',
								cd = 'G' => 'GREEK ORTHODOX',
								cd = 'H' => 'HINDU',
								cd = 'I' => 'ISLAMIC',
								cd = 'J' => 'JEWISH',
								cd = 'K' => 'SIKH',
								cd = 'L' => 'LUTHERAN',
								cd = 'M' => 'MORMON',
								cd = 'O' => 'EASTERN ORTHODOX',
								cd = 'P' => 'PROTESTANT',
								cd = 'S' => 'SHINTO',
								cd = 'X' => 'DEFAULT',
								'**|'+ cd);
	end;
	
	//********************************************************************
	//fDBConsLangPrefDesc: Returns the exploded language preference value 
	//********************************************************************	
	export  string fDBConsLangPrefDesc(string code) := function

		cd  := STD.Str.CleanSpaces( Std.Str.ToLowerCase(code));
		return map(cd = 'afr' => 'AFRIKAANS',
							 cd = 'aka' => 'AKAN/ASHANTI',
							 cd = 'alb' => 'ALBANIAN',
							 cd = 'amh' => 'AMHARIC',
							 cd = 'ara' => 'ARABIC',
							 cd = 'arm' => 'ARMENIAN',
							 cd = 'aze' => 'AZERI',
							 cd = 'baq' => 'BASQUE',
							 cd = 'ben' => 'BENGALI',
							 cd = 'bnt' => 'BANTU',
							 cd = 'bul' => 'BULGARIAN',
							 cd = 'bur' => 'BURMESE',
							 cd = 'can' => 'CANTONESE',
							 cd = 'che' => 'CHECHEN',
							 cd = 'chi' => 'CHINESE',
							 cd = 'com' => 'COMORIAN',
							 cd = 'cze' => 'CZECH',
							 cd = 'dan' => 'DANISH',
							 cd = 'dut' => 'DUTCH/FLEMISH',
							 cd = 'dzo' => 'DZONGKHA',
							 cd = 'eng' => 'ENGLISH (DEFAULT)',
							 cd = 'est' => 'ESTONIAN',
							 cd = 'fin' => 'FINNISH',
							 cd = 'fre' => 'FRENCH',
							 cd = 'gaa' => 'GA',
							 cd = 'geo' => 'GEORGIAN',
							 cd = 'ger' => 'GERMAN',
							 cd = 'gre' => 'GREEK',
							 cd = 'hau' => 'HAUSA',
							 cd = 'heb' => 'HEBREW',
							 cd = 'hin' => 'ASIAN INDIAN (HINDI OR OTHER)',
							 cd = 'hmn' => 'HMONG',
							 cd = 'hun' => 'HUNGARIAN',
							 cd = 'ibo' => 'IBO/IGBO',
							 cd = 'ice' => 'ICELANDIC',
							 cd = 'iku' => 'INUKTITUT',
							 cd = 'ind' => 'INDONESIAN',
							 cd = 'ita' => 'ITALIAN',
							 cd = 'jpn' => 'JAPANESE',
							 cd = 'kaz' => 'KAZAKH',
							 cd = 'khm' => 'KHMER',
							 cd = 'kir' => 'KIRGHIZ',
							 cd = 'kor' => 'KOREAN',
							 cd = 'kur' => 'KURDISH',
							 cd = 'lao' => 'LAOTIAN',
							 cd = 'lav' => 'LATVIAN',
							 cd = 'lit' => 'LITHUANIAN',
							 cd = 'mac' => 'MACEDONIAN',
							 cd = 'may' => 'MALAY',
							 cd = 'mlg' => 'MALAGASY',
							 cd = 'mol' => 'MOLDAVIAN/MOLDOVAN',
							 cd = 'mon' => 'MONGOLIAN',
							 cd = 'nep' => 'NEPALI',
							 cd = 'nor' => 'NORWEGIAN',
							 cd = 'orm' => 'OROMO',
							 cd = 'per' => 'FARSI/PERSIAN',
							 cd = 'pol' => 'POLISH',
							 cd = 'por' => 'PORTUGUESE',
							 cd = 'pus' => 'PASHTU/PASHTO',
							 cd = 'rum' => 'ROMANIAN',
							 cd = 'rus' => 'RUSSIAN',
							 cd = 'sin' => 'SINHALESE',
							 cd = 'slo' => 'SLOVAKIAN',
							 cd = 'slv' => 'SLOVENIAN',
							 cd = 'smo' => 'SAMOAN',
							 cd = 'som' => 'SOMALI',
							 cd = 'sot' => 'SOTHO',
							 cd = 'spa' => 'SPANISH',
							 cd = 'spr' => 'SERBO-CROATIAN',
							 cd = 'ssw' => 'SWAZI',
							 cd = 'swa' => 'SWAHILI',
							 cd = 'swe' => 'SWEDISH',
							 cd = 'tgk' => 'TAJIK',
							 cd = 'tgl' => 'TAGALOG',
							 cd = 'tha' => 'THAI',
							 cd = 'tib' => 'TIBETAN',
							 cd = 'ton' => 'TONGAN',
							 cd = 'tpi' => 'TOK PISIN',
							 cd = 'tsn' => 'TSWANA',
							 cd = 'tuk' => 'TURKMENI/TURKMEN',
							 cd = 'tur' => 'TURKISH',
							 cd = 'und' => 'UNDETERMINED/UNKNOWN',
							 cd = 'urd' => 'URDU',
							 cd = 'uzb' => 'UZBEKI/UZBEK',
							 cd = 'vie' => 'VIETNAMESE',
							 cd = 'xho' => 'XHOSA',
							 cd = 'yor' => 'YORUBA',
							 cd = 'zul' => 'ZULU',
								'**|'+ cd);
	end;
	
	//********************************************************************
	//fDBConsOwnerRenter: Returns the Owner/Renter value
	//********************************************************************	
	export  string fDBConsOwnerRenter(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = 'O' => 'OWNER',
		            cd = 'R' => 'RENTER',
								cd = ' ' => '',
								'**|'+ cd);
	end;	

	//********************************************************************
	//fDBConsDwellingTypeDesc: Returns the Dwelling Unit value
	//********************************************************************	
	export  string fDBConsDwellingTypeDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = 'M' => 'MULTI FAMILY DWELLING UNIT',
		            cd = 'S' => 'SINGLE FAMILY DWELLING UNIT',
								cd = ' '  => '',
								'**|'+ cd);
	end;

	//********************************************************************
	//fDBConsMaritalDesc: Returns the Marital Status Value
	//********************************************************************	
	export  string fDBConsMaritalDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = 'M' => 'MARRIED',
		            cd = 'S' => 'SINGLE',
								cd = 'A' => 'INFERRED MARRIED',
								cd = 'B' => 'INFERRED SINGLE',
								cd = ' ' => '',
								'**|'+ cd);
	end;	
	
	//********************************************************************
	//fDBConsNewParentDesc: Returns the New Parent Value
	//********************************************************************	
	export  string fDBConsNewParentDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = 'A' => 'NEW PARENT - 6 MONTHS OR LESS',
		            cd = 'B' => 'NEW PARENT - 7, 8 OR 9 MONTHS',
								cd = 'C' => 'NEW PARENT - 10, 11 OR 12 MONTHS',
								cd = ' ' => '',
								'**|'+ cd);
	end;	
	
	//********************************************************************
	//fDBConsTeenDriverDesc: Returns the Teen Driver Value
	//********************************************************************	
	export  string fDBConsTeenDriverDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = '1' => 'YES',
								cd = ' ' => '',
								'**|'+ cd);

	end;	
	
		//********************************************************************
	//fDBConsPoliPartyDesc: Returns the Political Party Info
	//********************************************************************	
	export  string fDBConsPoliPartyDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = 'V' => 'VOTER - NO PARTY',
		            cd = 'R' => 'VOTER - REPUBLICAN',
								cd = 'D' => 'VOTER - DEMOCRATIC',
								cd = 'I' => 'VOTER - INDEPENDENT',
								cd = ' ' => '',
								'**|'+ cd);
	end;	
	
		//********************************************************************
	//fDBConsOccupationDesc: Returns the Occupation value
	//********************************************************************	
	export  string fDBConsOccupationDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = '1' => 'PROFESSIONAL / TECHNICAL',
		            cd = '2' => 'ADMINISTRATION / MANAGERIAL',
		            cd = '3' => 'SALES / SERVICE',
		            cd = '4' => 'CLERICAL / WHITE COLLAR',
		            cd = '5' => 'CRAFTSMAN / BLUE COLLAR',
		            cd = '6' => 'STUDENT',
		            cd = '7' => 'HOMEMAKER',
		            cd = '8' => 'RETIRED',
		            cd = '9' => 'FARMER',
		            cd = 'A' => 'MILITARY',
		            cd = 'B' => 'RELIGIOUS',
		            cd = 'C' => 'SELF EMPLOYED',
		            cd = 'D' => 'SELF EMPLOYED - PROFESSIONAL / TECHNICAL',
		            cd = 'E' => 'SELF EMPLOYED - ADMINISTRATION / MANAGERIAL',
		            cd = 'F' => 'SELF EMPLOYED - SALES / SERVICE',
		            cd = 'G' => 'SELF EMPLOYED - CLERICAL / WHITE COLLAR',		
		            cd = 'H' => 'SELF EMPLOYED - CRAFTSMAN / BLUE COLLAR',		
		            cd = 'I' => 'SSELF EMPLOYED - STUDENT',		
		            cd = 'J' => 'SELF EMPLOYED - HOMEMAKER',		
		            cd = 'K' => 'SELF EMPLOYED - RETIREDR',		
		            cd = 'L' => 'SELF EMPLOYED - OTHER',		
		            cd = 'V' => 'EDUCATOR',		
		            cd = 'W' => 'FINANCIAL PROFESSIONAL',		
		            cd = 'X' => 'LEGAL PROFESSIONAL',		
		            cd = 'Y' => 'MEDICAL PROFESSIONAL',	
		            cd = 'Z' => 'OTHER',
								cd = ' ' => '',
								'**|'+ cd);
	end;	
	
	//********************************************************************
	//fDBConsPropertyTypeDesc: Returns the Property Type value
	//********************************************************************	
	export  string fDBConsPropertyTypeDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = 'G' => 'MULTI-FAMILY RESIDENTIAL',
		            cd = 'R' => 'SINGLE FAMILY RESIDENTIAL',
								cd = 'M' => 'MOBILE HOME',
								cd = 'T' => 'TIMESHARE',
								cd = ' ' => '',
								'**|'+ cd);
	end;	
	
	//***********************************************************************
	//fDBConsEducationDesc: Returns the Education level value
	//***********************************************************************	
	export  string fDBConsEducationDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = 'A' => 'COMPLETED HIGH SCHOOL',
		            cd = 'B' => 'COMPLETED COLLEGE',
								cd = 'C' => 'COMPLETED GRADUATE SCHOOL',
								cd = 'D' => 'ATTENDED VOCATIONAL/TECHNICAL',
								cd = 'E' => 'ATTENDED COLLEGE',
								cd = 'F' => 'DID NOT COMPLETE HIGH SCHOOL',
								cd = ' ' => '',
								'**|'+ cd);
	end;	
end;
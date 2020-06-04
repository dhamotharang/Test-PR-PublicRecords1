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
								cd = ' ' => '',
								'**|'+ cd);
	end;
	
  //********************************************************************
	//fGetGenderDesc: Returns the exploded gender value 
	//********************************************************************	
  export  string fGetGenderDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map(	cd = 'U' =>	'UNKNOWN',
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

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = 'A1' => 'AFRICAN AMERICAN - ISLAMIC SURNAME FROM 80% OR GREATER NON-WHITE GEOCODES',
								cd = 'A2' => 'AFRICAN AMERICAN - ISLAMIC SURNAME FROM 70 TO 79% OR GREATER NON-WHITE GEOCODES',
								cd = 'A3' => 'AFRICAN AMERICAN - ISLAMIC SURNAME FROM 60 TO 69% OR GREATER NON-WHITE GEOCODES',
								cd = 'A4' => 'AFRICAN AMERICAN - ISLAMIC SURNAME FROM 50 TO 59% OR GREATER NON-WHITE GEOCODES',
								cd = 'A5' => 'AFRICAN AMERICAN - ISLAMIC SURNAME FROM 40 TO 49% OR GREATER NON-WHITE GEOCODES',
								cd = 'E1' => 'AFRICAN AMERICAN - ENGLISH SURNAME FROM 80% OR GREATER NON-WHITE GEOCODES',
								cd = 'E2' => 'AFRICAN AMERICAN - ENGLISH SURNAME FROM 70 TO 79% OR GREATER NON-WHITE GEOCODES',
								cd = 'E3' => 'AFRICAN AMERICAN - ENGLISH SURNAME FROM 60 TO 69% OR GREATER NON-WHITE GEOCODES',
								cd = 'E4' => 'AFRICAN AMERICAN - ENGLISH SURNAME FROM 50 TO 59% OR GREATER NON-WHITE GEOCODES',
								cd = 'E5' => 'AFRICAN AMERICAN - ENGLISH SURNAME FROM 40 TO 49% OR GREATER NON-WHITE GEOCODES',
								cd = 'F1' => 'AFRICAN AMERICAN - FRENCH SURNAME FROM 80% OR GREATER NON-WHITE GEOCODES',
								cd = 'F2' => 'AFRICAN AMERICAN - FRENCH SURNAME FROM 70 TO 79% OR GREATER NON-WHITE GEOCODES',
								cd = 'F3' => 'AFRICAN AMERICAN - FRENCH SURNAME FROM 60 TO 69% OR GREATER NON-WHITE GEOCODES',
								cd = 'F4' => 'AFRICAN AMERICAN - FRENCH SURNAME FROM 50 TO 59% OR GREATER NON-WHITE GEOCODES',
								cd = 'F5' => 'AFRICAN AMERICAN - FRENCH SURNAME FROM 40 TO 49% OR GREATER NON-WHITE GEOCODES',
								cd = 'I1' => 'AFRICAN AMERICAN - IRISH SURNAME FROM 80% OR GREATER NON-WHITE GEOCODES',
								cd = 'I2' => 'AFRICAN AMERICAN - IRISH SURNAME FROM 70 TO 79% OR GREATER NON-WHITE GEOCODES',
								cd = 'I3' => 'AFRICAN AMERICAN - IRISH SURNAME FROM 60 TO 69% OR GREATER NON-WHITE GEOCODES',
								cd = 'I4' => 'AFRICAN AMERICAN - IRISH SURNAME FROM 50 TO 59% OR GREATER NON-WHITE GEOCODES',
								cd = 'I5' => 'AFRICAN AMERICAN - IRISH SURNAME FROM 40 TO 49% OR GREATER NON-WHITE GEOCODES',
								cd = 'S1' => 'AFRICAN AMERICAN - SCOTTISH SURNAME FROM 80% OR GREATER NON-WHITE GEOCODES',
								cd = 'S2' => 'AFRICAN AMERICAN - SCOTTISH SURNAME FROM 70 TO 79% OR GREATER NON-WHITE GEOCODES',
								cd = 'S3' => 'AFRICAN AMERICAN - SCOTTISH SURNAME FROM 60 TO 69% OR GREATER NON-WHITE GEOCODES',
								cd = 'S4' => 'AFRICAN AMERICAN - SCOTTISH SURNAME FROM 50 TO 59% OR GREATER NON-WHITE GEOCODES',
								cd = 'S5' => 'AFRICAN AMERICAN - SCOTTISH SURNAME FROM 40 TO 49% OR GREATER NON-WHITE GEOCODES',
								cd = 'W1' => 'AFRICAN AMERICAN - WELSH SURNAME FROM 80% OR GREATER NON-WHITE GEOCODES',
								cd = 'W2' => 'AFRICAN AMERICAN - WELSH SURNAME FROM 70 TO 79% OR GREATER NON-WHITE GEOCODES',
								cd = 'W3' => 'AFRICAN AMERICAN - WELSH SURNAME FROM 60 TO 69% OR GREATER NON-WHITE GEOCODES',
								cd = 'W4' => 'AFRICAN AMERICAN - WELSH SURNAME FROM 50 TO 59% OR GREATER NON-WHITE GEOCODES',
								cd = 'W5' => 'AFRICAN AMERICAN - WELSH SURNAME FROM 40 TO 49% OR GREATER NON-WHITE GEOCODES',
								cd = 'D1' => 'AFRICAN AMERICAN - DUTCH SURNAME FROM 80% OR GREATER NON-WHITE GEOCODES',
								cd = 'D2' => 'AFRICAN AMERICAN - DUTCH SURNAME FROM 70 TO 79% OR GREATER NON-WHITE GEOCODES',
								cd = 'D3' => 'AFRICAN AMERICAN - DUTCH SURNAME FROM 60 TO 69% OR GREATER NON-WHITE GEOCODES',
								cd = 'D4' => 'AFRICAN AMERICAN - DUTCH SURNAME FROM 50 TO 59% OR GREATER NON-WHITE GEOCODES',
								cd = 'D5' => 'AFRICAN AMERICAN - DUTCH SURNAME FROM 40 TO 49% OR GREATER NON-WHITE GEOCODES',
								cd = 'U1' => 'AFRICAN AMERICAN - UNDETERMINED SURNAME FROM 80% OR GREATER NON-WHITE GEOCODES',
								cd = 'U2' => 'AFRICAN AMERICAN - UNDETERMINED SURNAME FROM 70 TO 79% OR GREATER NON-WHITE GEOCODES',
								cd = 'U3' => 'AFRICAN AMERICAN - UNDETERMINED SURNAME FROM 60 TO 69% OR GREATER NON-WHITE GEOCODES',
								cd = 'U4' => 'AFRICAN AMERICAN - UNDETERMINED SURNAME FROM 50 TO 59% OR GREATER NON-WHITE GEOCODES',
								cd = 'U5' => 'AFRICAN AMERICAN - UNDETERMINED SURNAME FROM 40 TO 49% OR GREATER NON-WHITE GEOCODES',
								cd = '7B' => 'DJIBOUTI',
								cd = '7G' => 'MAURITANIA',
								cd = '79' => 'RWANDAN',
								cd = '8A' => 'CONGO',
								cd = '8B' => 'CENTRAL AFRICAN REPUBLIC',
								cd = '8C' => 'TOGO',
								cd = '8F' => 'GUYANA',
								cd = '8I' => 'SWAZILAND',
								cd = '8J' => 'ZULU',
								cd = '8K' => 'XHOSA',
								cd = '8L' => 'BASOTHO',
								cd = '8M' => 'SOUTH AFRICAN',
								cd = '8N' => 'LIBERIAN',
								cd = '8O' => 'COMOROS',
								cd = '8P' => 'BENIN',
								cd = '8Q' => 'BURKINA FASO',
								cd = '8R' => 'NIGER',
								cd = '8S' => 'ASHANTI',
								cd = '8T' => 'SWAHILI',
								cd = '8U' => 'UNUSED',
								cd = '8V' => 'MALI',
								cd = '8X' => 'HAUSA',
								cd = '8Y' => 'PILI',
								cd = '80' => 'TONGA',
								cd = '81' => 'SENEGALESE',
								cd = '82' => 'MALAWI',
								cd = '83' => 'SUDANESE',
								cd = '85' => 'UNIQUELY AFRICAN AMERICAN',
								cd = '86' => 'KENYA',
								cd = '87' => 'NIGERIAN',
								cd = '88' => 'GHANA',
								cd = '89' => 'ZAMBIAN',
								cd = '9A' => 'NAMIBIAN',
								cd = '9B' => 'BURUNDI',
								cd = '9C' => 'TANZANIAN',
								cd = '9D' => 'GAMBIAN',
								cd = '9E' => 'SOMALIA',
								cd = '9G' => 'CHAD',
								cd = '9H' => 'GABON',
								cd = '9I' => 'ANGOLAN',
								cd = '9O' => 'LESOTHO',
								cd = '9R' => 'MADAGASCAR',
								cd = '9T' => 'SIERRA LEONE',
								cd = '9W' => 'GUINEA-BISSAU',
								cd = '9Y' => 'EQUATORIAL GUINEA',
								cd = '90' => 'ZAIRE',
								cd = '91' => 'SURINAM',
								cd = '92' => 'MOZAMBIQUE',
								cd = '93' => 'IVORY COAST',
								cd = '94' => 'BHUTANESE',
								cd = '95' => 'ETHIOPIAN',
								cd = '96' => 'UGANDAN',
								cd = '97' => 'BOTSWANIAN',
								cd = '98' => 'CAMEROON',
								cd = '99' => 'ZIMBABWE',
								cd = '31' => 'TURKISH',
								cd = '32' => 'KURDISH',
								cd = '34' => 'PERSIAN',
								cd = '70' => 'ARABIC',
								cd = '75' => 'SAUDI',
								cd = '76' => 'IRAQI',
								cd = '77' => 'LIBYAN',
								cd = '78' => 'EGYPTIAN',
								cd = '8D' => 'BAHRAIN',
								cd = '8E' => 'QATAR',
								cd = '84' => 'MOROCCAN',
								cd = '9M' => 'ALGERIAN',
								cd = '9P' => 'TUNISIAN',
								cd = '9U' => 'KUWAITI',
								cd = '9V' => 'YEMENI',
								cd = '9Z' => 'SYRIAN',
								cd = '44' => 'AZERBAIJANI',
								cd = '45' => 'KAZAKHSTANI',
								cd = '46' => 'AFGHANI',
								cd = '47' => 'PAKISTANI',
								cd = '48' => 'BENGALI',
								cd = '49' => 'INDONESIAN',
								cd = '50' => 'INDIAN',
								cd = '51' => 'MYANMAR',
								cd = '52' => 'MONGOLIAN',
								cd = '53' => 'CHINESE',
								cd = '56' => 'KOREAN',
								cd = '57' => 'JAPANESE',
								cd = '58' => 'THAI',
								cd = '59' => 'MALAY',
								cd = '60' => 'LAOTIAN',
								cd = '61' => 'KHMER',
								cd = '62' => 'VIETNAMESE',
								cd = '63' => 'SRI LANKAN',
								cd = '64' => 'UZBEKISTANI',
								cd = '65' => 'OTHER ASIAN',
								cd = '7D' => 'TELUGON',
								cd = '7E' => 'NEPAL',
								cd = '72' => 'TURKMENISTAN',
								cd = '73' => 'TAJIKISTAN',
								cd = '74' => 'KIRGHIZSTAN',
								cd = '8G' => 'TIBETAN',
								cd = '9J' => 'CHECHNIAN',
								cd = '7A' => 'HINDU',
								cd = '7F' => 'WESTERN SAMOA',
								cd = '8H' => 'FIJI',
								cd = '9N' => 'FILIPINO',
								cd = '9X' => 'PAPUA NEW GUINEA',
								cd = '9Q' => 'HAWAIIAN',
								cd = '01' => 'ENGLISH',
								cd = '02' => 'SCOTTISH',
								cd = '03' => 'DANISH',
								cd = '04' => 'SWEDISH',
								cd = '05' => 'NORWEGIAN',
								cd = '06' => 'FINNISH',
								cd = '07' => 'ICELANDIC',
								cd = '08' => 'DUTCH',
								cd = '09' => 'BELGIUM (FLEMISH & WALLOON)',
								cd = '10' => 'GERMAN',
								cd = '11' => 'AUSTRIAN',
								cd = '12' => 'HUNGARIAN',
								cd = '13' => 'CZECH',
								cd = '14' => 'SLOVAKIAN',
								cd = '15' => 'IRISH',
								cd = '16' => 'WELSH',
								cd = '17' => 'FRENCH',
								cd = '18' => 'SWISS',
								cd = '19' => 'ITALIAN',
								cd = '20' => 'HISPANIC',
								cd = '21' => 'PORTUGUESE',
								cd = '22' => 'POLISH',
								cd = '23' => 'ESTONIAN',
								cd = '24' => 'LATVIAN',
								cd = '25' => 'LITHUANIAN',
								cd = '26' => 'UKRAINIAN',
								cd = '27' => 'GEORGIAN',
								cd = '28' => 'BYELORUSSIAN',
								cd = '29' => 'ARMENIAN',
								cd = '30' => 'RUSSIAN',
								cd = '33' => 'GREEK',
								cd = '35' => 'MOLDAVIAN',
								cd = '36' => 'BULGARIAN',
								cd = '37' => 'ROMANIAN',
								cd = '38' => 'ALBANIAN',
								cd = '40' => 'SLOVENIAN',
								cd = '41' => 'CROATIAN',
								cd = '42' => 'SERBIAN',
								cd = '43' => 'BOSNIAN',
								cd = '66' => 'JEWISH',
								cd = '68' => 'HEBREW',
								cd = '7C' => 'MANX',
								cd = '9F' => 'MACEDONIAN',
								cd = '9S' => 'BASQUE',
								cd = '39' => 'NATIVE AMERICAN',
								cd = '67' => 'ALEUT',
								cd = 'ZZ' => 'MULTI-ETHNIC',
								cd = 'UC' => 'NOT POSSIBLE TO CODE',
								cd = '7H' => 'INUIT',
								cd = '9K' => 'IBO/IGBO',
								cd = '9L' => 'YORUBA',
								'**|'+ cd);
	end;
	
	//********************************************************************
	//fDBConsReligiousDesc: Returns the DB Cons Religious value 
	//********************************************************************	
	export  string fDBConsReligiousDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = 'B' => 'BUDDHIST',
								cd = 'C' => 'CATHOLIC',
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
								'**|'+ cd);
	end;
	
	//********************************************************************
	//fDBConsLangPrefDesc: Returns the exploded language preference value 
	//********************************************************************	
	export  string fDBConsLangPrefDesc(string code) := function

		cd  := ut.CleanSpacesAndUpper(code);
		return map( cd = '01' => 'ENGLISH (DEFAULT)	 ',
								cd = '03' => 'DANISH	 ',
								cd = '04' => 'SWEDISH	 ',
								cd = '05' => 'NORWEGIAN	 ',
								cd = '06' => 'FINNISH	 ',
								cd = '07' => 'ICELANDIC	 ',
								cd = '08' => 'DUTCH	 ',
								cd = '10' => 'GERMAN	 ',
								cd = '09' => 'FLEMISH	 ',
								cd = '12' => 'HUNGARIAN	 ',
								cd = '13' => 'CZECH	 ',
								cd = '14' => 'SLOVAKIAN	 ',
								cd = '17' => 'FRENCH	 ',
								cd = '19' => 'ITALIAN	 ',
								cd = '20' => 'SPANISH	 ',
								cd = '21' => 'PORTUGUESE	 ',
								cd = '22' => 'POLISH	 ',
								cd = '23' => 'ESTONIAN	 ',
								cd = '24' => 'LATVIAN	 ',
								cd = '25' => 'LITHUANIAN	 ',
								cd = '27' => 'GEORGIAN	 ',
								cd = '29' => 'ARMENIAN	 ',
								cd = '30' => 'RUSSIAN	 ',
								cd = '31' => 'TURKISH	 ',
								cd = '32' => 'KURDISH	 ',
								cd = '33' => 'GREEK	 ',
								cd = '34' => 'FARSI	 ',
								cd = '35' => 'MOLDAVIAN	 ',
								cd = '36' => 'BULGARIAN	 ',
								cd = '37' => 'ROMANIAN	 ',
								cd = '38' => 'ALBANIAN	 ',
								cd = '40' => 'SLOVENIAN	 ',
								cd = '41' => 'SERBO-CROATIAN	 ',
								cd = '44' => 'AZERI	 ',
								cd = '45' => 'KAZAKH	 ',
								cd = '46' => 'PASHTO	 ',
								cd = '47' => 'URDU	 ',
								cd = '48' => 'BENGALI	 ',
								cd = '49' => 'INDONESIAN	 ',
								cd = '51' => 'BURMESE	 ',
								cd = '52' => 'MONGOLIAN	 ',
								cd = '53' => 'CHINESE	 ',
								cd = '56' => 'KOREAN	 ',
								cd = '57' => 'JAPANESE	 ',
								cd = '58' => 'THAI	 ',
								cd = '59' => 'MALAY	 ',
								cd = '60' => 'LAOTIAN	 ',
								cd = '61' => 'KHMER	 ',
								cd = '62' => 'VIETNAMESE	 ',
								cd = '63' => 'SINHALESE	 ',
								cd = '64' => 'UZBEKI	 ',
								cd = '68' => 'HEBREW	 ',
								cd = '70' => 'ARABIC	 ',
								cd = '72' => 'TURKMENI	 ',
								cd = '73' => 'TAJIK	 ',
								cd = '74' => 'KIRGHIZ	 ',
								cd = '7A' => 'HINDI	 ',
								cd = '7E' => 'NEPALI	 ',
								cd = '7F' => 'SAMOAN	 ',
								cd = '80' => 'TONGAN	 ',
								cd = '86' => 'OROMO	 ',
								cd = '88' => 'GHA	 ',
								cd = '8G' => 'TIBETAN	 ',
								cd = '8I' => 'SWAZI	 ',
								cd = '8J'	=> 'ZULU	 ',
								cd = '8K' => 'XHOSA	 ',
								cd = '8M' => 'AFRIKAANS	 ',
								cd = '8O' => 'COMORIAN	 ',
								cd = '8S' => 'ASHANTI	 ',
								cd = '8T' => 'SWAHILI	 ',
								cd = '8X' => 'HAUSA	 ',
								cd = '92' => 'BANTU	 ',
								cd = '94' => 'DZONGKHA	 ',
								cd = '95' => 'AMHARIC	 ',
								cd = '97' => 'TSWANA	 ',
								cd = '9E' => 'SOMALI	 ',
								cd = '9F' => 'MACEDONIAN	 ',
								cd = '9N' => 'TAGALOG	 ',
								cd = '9O' => 'SOTHO	 ',
								cd = '9R' => 'MALAGASY	 ',
								cd = '9S' => 'BASQUE	 ',
								cd = '9K' => 'IBO/IGBO	 ',
								cd = '9L' => 'YORUBA	 ',
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
		return map( cd = 'A' => 'WITHIN 1 YEAR UNTIL FULL DRIVERS LICENSE AGE',
		            cd = 'B' => 'REACHED FULL DRIVER\'S LICENSE AGE',
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
		return map( cd = '1' => 'COMPLETED HIGH SCHOOL',
		            cd = '2' => 'COMPLETED COLLEGE',
								cd = '3' => 'COMPLETED GRADUATE SCHOOL',
								cd = '4' => 'ATTENDED VOCATIONAL/TECHNICAL',
								cd = ' ' => '',
								'**|'+ cd);
	end;	
end;
﻿IMPORT AID, ut, NID, codes, Address, Database_USA;

EXPORT Base_In_Database_USA := Database_USA.Files(,true).base.father;

Database_USA.Layouts.Base	fPatchBase(Base_In_Database_USA L) := TRANSFORM
self.NAICS01 := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS01) = 1,ut.CleanSpacesAndUpper(l.NAICS01),'');
self.NAICS02 := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS02) = 1,ut.CleanSpacesAndUpper(l.NAICS02),'');
self.NAICS03 := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS03) = 1,ut.CleanSpacesAndUpper(l.NAICS03),'');
self.NAICS04 := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS04) = 1,ut.CleanSpacesAndUpper(l.NAICS04),'');
self.NAICS05 := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS05) = 1,ut.CleanSpacesAndUpper(l.NAICS05),'');
self.NAICS06 := If(ut.fn_NAICS_functions.fn_validate_NAICSCode(l.NAICS06) = 1,ut.CleanSpacesAndUpper(l.NAICS06),'');
self.dbconsgenderdesc := map(l.db_cons_gender = 'U' =>	'UNSPECIFIED',
															 l.db_cons_gender = 'M' =>	'MALE',
															 l.db_cons_gender = 'F' => 'FEMALE',
															 l.db_cons_gender = ' ' or l.db_cons_gender = '' => '',
															 '**|'+ l.db_cons_gender);
self.db_cons_time_zone_code := map(l.db_cons_time_zone_code = 'E'  => '5',
										 l.db_cons_time_zone_code = 'C'  => '6',
										 l.db_cons_time_zone_code = 'M'  => '7',
										 l.db_cons_time_zone_code = 'P'  => '8',
										 l.db_cons_time_zone_code = 'A'  => '9',
										 l.db_cons_time_zone_code = 'H'  => '10',
										 l.db_cons_time_zone_code = '' or l.db_cons_time_zone_code = ' ' => '',
										 '**|'+ l.TimeZone);
self.dbconsethnicdesc := map( l.db_cons_ethnic_code >=  'A1'  and l.db_cons_ethnic_code <= 'S5' => 'AFRICAN AMERICAN/AFRICAN AMERICAN',
								l.db_cons_ethnic_code >=  'U1'  and l.db_cons_ethnic_code <= 'U5' => 'AFRICAN AMERICAN/AFRICAN AMERICAN',
								l.db_cons_ethnic_code >=  'W1'  and l.db_cons_ethnic_code <= 'W5' => 'AFRICAN AMERICAN/AFRICAN AMERICAN',
								l.db_cons_ethnic_code =  '7B' => 'DJIBOUTIAN',
								l.db_cons_ethnic_code =  '7G' => 'MAURITANIAN',
								l.db_cons_ethnic_code =  '79' => 'RWANDAN/RUANDAN',
								l.db_cons_ethnic_code =  '8A' => 'CONGOLESE',
								l.db_cons_ethnic_code =  '8B' => 'CENTRAL AFRICAN (CENTRAL AFRICAN REPUBLIC)',
								l.db_cons_ethnic_code =  '8C' => 'TOGOLESE',
								l.db_cons_ethnic_code =  '8F' => 'GUYANESE',
								l.db_cons_ethnic_code =  '8I' => 'SWAZI',
								l.db_cons_ethnic_code =  '8J' => 'ZULU',
								l.db_cons_ethnic_code =  '8K' => 'XHOSA',
								l.db_cons_ethnic_code =  '8L' => 'BASOTHO',
								l.db_cons_ethnic_code =  '8M' => 'SOUTH AFRICAN',
								l.db_cons_ethnic_code =  '8N' => 'LIBERIAN',
								l.db_cons_ethnic_code =  '8O' => 'COMORAN/COMOROS',
								l.db_cons_ethnic_code =  '8P' => 'BENINESE',
								l.db_cons_ethnic_code =  '8Q' => 'BURKINABE (BURKINA FASO)',
								l.db_cons_ethnic_code =  '8R' => 'NIGERIEN (NIGER)',
								l.db_cons_ethnic_code =  '8S' => 'AKAN/ASHANTI',
								l.db_cons_ethnic_code =  '8T' => 'SWAHILI',
								l.db_cons_ethnic_code =  '8U' => 'DEFAULT/UNDETERMINED/UNKNOWN',
								l.db_cons_ethnic_code =  '8V' => 'MALIAN',
								l.db_cons_ethnic_code =  '8W' => 'JAMAICAN',
								l.db_cons_ethnic_code =  '8X' => 'HAUSA',
								l.db_cons_ethnic_code =  '8Y' => 'PILIPINO/PHILIPPINE',
								l.db_cons_ethnic_code =  '80' => 'TONGAN',
								l.db_cons_ethnic_code =  '81' => 'SENEGALESE',
								l.db_cons_ethnic_code =  '82' => 'MALAWIAN',
								l.db_cons_ethnic_code =  '83' => 'SUDANESE/SOUTH SUDANESE', 
								l.db_cons_ethnic_code =  '85' => 'AFRICAN AMERICAN/AFRICAN AMERICAN',
								l.db_cons_ethnic_code =  '86' => 'KENYAN',
								l.db_cons_ethnic_code =  '87' => 'NIGERIAN (NIGERIA)',
								l.db_cons_ethnic_code =  '88' => 'GHANAIAN',
								l.db_cons_ethnic_code =  '89' => 'ZAMBIAN',
								l.db_cons_ethnic_code =  '9A' => 'NAMIBIAN',
								l.db_cons_ethnic_code =  '9B' => 'BURUNDI',
								l.db_cons_ethnic_code =  '9C' => 'TANZANIAN',
								l.db_cons_ethnic_code =  '9D' => 'GAMBIAN',
								l.db_cons_ethnic_code =  '9E' => 'SOMALI',
								l.db_cons_ethnic_code =  '9G' => 'CHADIAN',
								l.db_cons_ethnic_code =  '9H' => 'GABONESE',
								l.db_cons_ethnic_code =  '9I' => 'ANGOLAN',
								l.db_cons_ethnic_code =  '9O' => 'SOTHO (LESOTHO)',
								l.db_cons_ethnic_code =  '9R' => 'MALAGASY (MADAGASCAR)',
								l.db_cons_ethnic_code =  '9T' => 'SIERRAI LEONEAN',
								l.db_cons_ethnic_code =  '9W' => 'GUINEAN (GUINEA-BISSAU)',
								l.db_cons_ethnic_code =  '9Y' => 'EQUATORIAL GUINEAN',
								l.db_cons_ethnic_code =  '90' => 'ZAIREAN',
								l.db_cons_ethnic_code =  '91' => 'SURINAMESE',
								l.db_cons_ethnic_code =  '92' => 'MOZAMBICAN (MOZAMBIQUE)',
								l.db_cons_ethnic_code =  '93' => 'IVORIAN (IVORY COAST)',
								l.db_cons_ethnic_code =  '94' => 'BHUTANESE',
								l.db_cons_ethnic_code =  '95' => 'ETHIOPIAN',
								l.db_cons_ethnic_code =  '96' => 'UGANDAN',
								l.db_cons_ethnic_code =  '97' => 'BATSWANA (BOTSWANA)',
								l.db_cons_ethnic_code =  '98' => 'CAMEROONIAN',
								l.db_cons_ethnic_code =  '99' => 'ZIMBABWEAN',
								l.db_cons_ethnic_code =  '31' => 'TURKISH',
								l.db_cons_ethnic_code =  '32' => 'KURDISH',
								l.db_cons_ethnic_code =  '34' => 'PERSIAN',
								l.db_cons_ethnic_code =  '70' => 'ARAB',
								l.db_cons_ethnic_code =  '75' => 'SAUDI',
								l.db_cons_ethnic_code =  '76' => 'IRAQI',
								l.db_cons_ethnic_code =  '77' => 'LIBYAN',
								l.db_cons_ethnic_code =  '78' => 'EGYPTIAN',
								l.db_cons_ethnic_code =  '8D' => 'BAHRAINI',
								l.db_cons_ethnic_code =  '8E' => 'QATARI',
								l.db_cons_ethnic_code =  '84' => 'MOROCCAN',
								l.db_cons_ethnic_code =  '9M' => 'ALGERIAN',
								l.db_cons_ethnic_code =  '9P' => 'TUNISIAN',
								l.db_cons_ethnic_code =  '9U' => 'KUWAITI',
								l.db_cons_ethnic_code =  '9V' => 'YEMENI',
								l.db_cons_ethnic_code =  '9Z' => 'SYRIAN',
								l.db_cons_ethnic_code =  '44' => 'AZERBAIJANI',
								l.db_cons_ethnic_code =  '45' => 'KAZAKH',
								l.db_cons_ethnic_code =  '46' => 'AFGHAN',
								l.db_cons_ethnic_code =  '47' => 'PAKISTANI',
								l.db_cons_ethnic_code =  '48' => 'BANGLADESHI/BENGALI',
								l.db_cons_ethnic_code =  '49' => 'INDONESIAN',
								l.db_cons_ethnic_code =  '50' => 'INDIAN/ASIAN INDIAN',
								l.db_cons_ethnic_code =  '51' => 'BURMESE (MYANMAR)',
								l.db_cons_ethnic_code =  '52' => 'MONGOLIAN',
								l.db_cons_ethnic_code =  '53' => 'CHINESE',
								l.db_cons_ethnic_code =  '56' => 'KOREAN',
								l.db_cons_ethnic_code =  '57' => 'JAPANESE',
								l.db_cons_ethnic_code =  '58' => 'THAI',
								l.db_cons_ethnic_code =  '59' => 'MALAY',
								l.db_cons_ethnic_code =  '60' => 'LAOTIAN',
								l.db_cons_ethnic_code =  '61' => 'KHMER',
								l.db_cons_ethnic_code =  '62' => 'VIETNAMESE',
								l.db_cons_ethnic_code =  '63' => 'SRI LANKAN/SINHALESE',
								l.db_cons_ethnic_code =  '64' => 'UZBEK',
								l.db_cons_ethnic_code =  '65' => 'OTHER ASIAN/OTHER ORIENTAL',
								l.db_cons_ethnic_code =  '7D' => 'TELUGU',
								l.db_cons_ethnic_code =  '7E' => 'NEPALESE',
								l.db_cons_ethnic_code =  '71' => 'BRAZILIAN',
								l.db_cons_ethnic_code =  '72' => 'TURKMEN',
								l.db_cons_ethnic_code =  '73' => 'TAJIK',
								l.db_cons_ethnic_code =  '74' => 'KIRGHIZ',
								l.db_cons_ethnic_code =  '8G' => 'TIBETAN',
								l.db_cons_ethnic_code =  '9J' => 'CHECHAN',
								// 'HINDU',
								l.db_cons_ethnic_code =  '7A' => 'INDIAN/ASIAN INDIAN', 
								l.db_cons_ethnic_code =  '7F' => 'SAMOAN',
								l.db_cons_ethnic_code =  '8H' => 'FIJIAN',
								l.db_cons_ethnic_code =  '9N' => 'FILIPINO/PHILIPPINE',
								l.db_cons_ethnic_code =  '9X' => 'PAPUA NEW GUINEAN',
								l.db_cons_ethnic_code =  '9Q' => 'HAWAIIAN',
								l.db_cons_ethnic_code =  '01' => 'ENGLISH',
								l.db_cons_ethnic_code =  '02' => 'SCOTTISH',
								l.db_cons_ethnic_code =  '03' => 'DANISH',
								l.db_cons_ethnic_code =  '04' => 'SWEDISH',
								l.db_cons_ethnic_code =  '05' => 'NORWEGIAN',
								l.db_cons_ethnic_code =  '06' => 'FINNISH',
								l.db_cons_ethnic_code =  '07' => 'ICELANDIC',
								l.db_cons_ethnic_code =  '08' => 'DUTCH',
								l.db_cons_ethnic_code =  '09' => 'BELGIAN',
								l.db_cons_ethnic_code =  '10' => 'GERMAN',
								l.db_cons_ethnic_code =  '11' => 'AUSTRIAN',
								l.db_cons_ethnic_code =  '12' => 'HUNGARIAN',
								l.db_cons_ethnic_code =  '13' => 'CZECH',
								l.db_cons_ethnic_code =  '14' => 'SLOVAK',
								l.db_cons_ethnic_code =  '15' => 'IRISH',
								l.db_cons_ethnic_code =  '16' => 'WELSH',
								l.db_cons_ethnic_code =  '17' => 'FRENCH',
								l.db_cons_ethnic_code =  '18' => 'SWISS',
								l.db_cons_ethnic_code =  '19' => 'ITALIAN',
								l.db_cons_ethnic_code =  '20' => 'HISPANIC/SPANISH',
								l.db_cons_ethnic_code =  '21' => 'PORTUGUESE',
								l.db_cons_ethnic_code =  '22' => 'POLISH',
								l.db_cons_ethnic_code =  '23' => 'ESTONIAN',
								l.db_cons_ethnic_code =  '24' => 'LATVIAN',
								l.db_cons_ethnic_code =  '25' => 'LITHUANIAN',
								l.db_cons_ethnic_code =  '26' => 'UKRAINIAN',
								l.db_cons_ethnic_code =  '27' => 'GEORGIAN',
								l.db_cons_ethnic_code =  '28' => 'BYELORUSSIAN/BELORUSSIAN',
								l.db_cons_ethnic_code =  '29' => 'ARMENIAN',
								l.db_cons_ethnic_code =  '30' => 'RUSSIAN',
								l.db_cons_ethnic_code =  '33' => 'GREEK',
								l.db_cons_ethnic_code =  '35' => 'MOLDAVIAN/MOLDOVAN',
								l.db_cons_ethnic_code =  '36' => 'BULGARIAN',
								l.db_cons_ethnic_code =  '37' => 'ROMANIAN',
								l.db_cons_ethnic_code =  '38' => 'ALBANIAN',
								l.db_cons_ethnic_code =  '40' => 'SLOVENIAN',
								l.db_cons_ethnic_code =  '41' => 'CROATIAN',
								l.db_cons_ethnic_code =  '42' => 'SERBIAN',
								l.db_cons_ethnic_code =  '43' => 'BOSNIAN/BOSNIAK/BOSNIAN MUSLIM',
								l.db_cons_ethnic_code =  '66' => 'JEWISH',
								l.db_cons_ethnic_code =  '68' => 'HEBREW',
								l.db_cons_ethnic_code =  '7C' => 'MANX',
								l.db_cons_ethnic_code =  '9F' => 'MACEDONIAN',
								l.db_cons_ethnic_code =  '9S' => 'BASQUE',
								l.db_cons_ethnic_code =  '39' => 'NATIVE AMERICAN',
								l.db_cons_ethnic_code =  '67' => 'ALEUT',
								l.db_cons_ethnic_code =  'ZZ' => 'MULTI ETHNIC',
								l.db_cons_ethnic_code =  'UC' => 'DEFAULT/UNDETERMINED/UNKNOWN',
								l.db_cons_ethnic_code =  '7H' => 'INUIT',
								l.db_cons_ethnic_code =  '9K' => 'IGBO',
								l.db_cons_ethnic_code =  '9L' => 'YORUBA',
								l.db_cons_ethnic_code =  '7M' => 'TRINIDADIAN',
								l.db_cons_ethnic_code =  '7N' => 'SOUTHERN AFRICAN',
								l.db_cons_ethnic_code =  '55' => 'TAIWANESE',
								l.db_cons_ethnic_code =  '00' => 'DEFAULT/UNDETERMINED/UNKNOWN',
								'**|'+ l.db_cons_ethnic_code);
self.db_cons_ethnic_code := map( l.db_cons_ethnic_code >=  'A1'  and l.db_cons_ethnic_code <= 'S5' => 'AAM',
								l.db_cons_ethnic_code >=  'U1'  and l.db_cons_ethnic_code <= 'U5' => 'AAM',
								l.db_cons_ethnic_code >=  'W1'  and l.db_cons_ethnic_code <= 'W5' => 'AAM',
								l.db_cons_ethnic_code =  '7B' => 'DJI',
								l.db_cons_ethnic_code =  '7G' => 'MAU',
								l.db_cons_ethnic_code =  '79' => 'RWA',
								l.db_cons_ethnic_code =  '8A' => 'CON',
								l.db_cons_ethnic_code =  '8B' => 'CAF',
								l.db_cons_ethnic_code =  '8C' => 'TOL',
								l.db_cons_ethnic_code =  '8F' => 'GUY',
								l.db_cons_ethnic_code =  '8I' => 'SSW',
								l.db_cons_ethnic_code =  '8J' => 'ZUL',
								l.db_cons_ethnic_code =  '8K' => 'XHO',
								l.db_cons_ethnic_code =  '8L' => 'BSO',
								l.db_cons_ethnic_code =  '8M' => 'SAF',
								l.db_cons_ethnic_code =  '8N' => 'LIB',
								l.db_cons_ethnic_code =  '8O' => 'COM',
								l.db_cons_ethnic_code =  '8P' => 'BEI',
								l.db_cons_ethnic_code =  '8Q' => 'BRK',
								l.db_cons_ethnic_code =  '8R' => 'NGR',
								l.db_cons_ethnic_code =  '8S' => 'AKA',
								l.db_cons_ethnic_code =  '8T' => 'SWA',
								l.db_cons_ethnic_code =  '8U' => 'UND',
								l.db_cons_ethnic_code =  '8V' => 'MLI',
								l.db_cons_ethnic_code =  '8W' => 'JAM',
								l.db_cons_ethnic_code =  '8X' => 'HAU',
								l.db_cons_ethnic_code =  '8Y' => 'PIL',
								l.db_cons_ethnic_code =  '80' => 'TON',
								l.db_cons_ethnic_code =  '81' => 'SEN',
								l.db_cons_ethnic_code =  '82' => 'MAW',
								l.db_cons_ethnic_code =  '83' => 'SUD', 
								l.db_cons_ethnic_code =  '85' => 'AAM',
								l.db_cons_ethnic_code =  '86' => 'KEN',
								l.db_cons_ethnic_code =  '87' => 'NGA',
								l.db_cons_ethnic_code =  '88' => 'GAA',
								l.db_cons_ethnic_code =  '89' => 'ZAM',
								l.db_cons_ethnic_code =  '9A' => 'NAM',
								l.db_cons_ethnic_code =  '9B' => 'BUN',
								l.db_cons_ethnic_code =  '9C' => 'TAN',
								l.db_cons_ethnic_code =  '9D' => 'GAM',
								l.db_cons_ethnic_code =  '9E' => 'SOM',
								l.db_cons_ethnic_code =  '9G' => 'CHD',
								l.db_cons_ethnic_code =  '9H' => 'GAB',
								l.db_cons_ethnic_code =  '9I' => 'ANL',
								l.db_cons_ethnic_code =  '9O' => 'SOT',
								l.db_cons_ethnic_code =  '9R' => 'MLG',
								l.db_cons_ethnic_code =  '9T' => 'SLE',
								l.db_cons_ethnic_code =  '9W' => 'GUI',
								l.db_cons_ethnic_code =  '9Y' => 'EQG',
								l.db_cons_ethnic_code =  '90' => 'ZAI',
								l.db_cons_ethnic_code =  '91' => 'SUR',
								l.db_cons_ethnic_code =  '92' => 'MOZ',
								l.db_cons_ethnic_code =  '93' => 'IVO',
								l.db_cons_ethnic_code =  '94' => 'BHU',
								l.db_cons_ethnic_code =  '95' => 'ETH',
								l.db_cons_ethnic_code =  '96' => 'UGD',
								l.db_cons_ethnic_code =  '97' => 'BTS',
								l.db_cons_ethnic_code =  '98' => 'CAM',
								l.db_cons_ethnic_code =  '99' => 'ZIM',
								l.db_cons_ethnic_code =  '31' => 'TUR',
								l.db_cons_ethnic_code =  '32' => 'KUR',
								l.db_cons_ethnic_code =  '34' => 'PER',
								l.db_cons_ethnic_code =  '70' => 'ARA',
								l.db_cons_ethnic_code =  '75' => 'SAU',
								l.db_cons_ethnic_code =  '76' => 'IRQ',
								l.db_cons_ethnic_code =  '77' => 'LBY',
								l.db_cons_ethnic_code =  '78' => 'EGY',
								l.db_cons_ethnic_code =  '8D' => 'BAH',
								l.db_cons_ethnic_code =  '8E' => 'QAT',
								l.db_cons_ethnic_code =  '84' => 'MOR',
								l.db_cons_ethnic_code =  '9M' => 'ALR',
								l.db_cons_ethnic_code =  '9P' => 'TUN',
								l.db_cons_ethnic_code =  '9U' => 'KUW',
								l.db_cons_ethnic_code =  '9V' => 'YEM',
								l.db_cons_ethnic_code =  '9Z' => 'SYR',
								l.db_cons_ethnic_code =  '44' => 'AZE',
								l.db_cons_ethnic_code =  '45' => 'KAZ',
								l.db_cons_ethnic_code =  '46' => 'AFG',
								l.db_cons_ethnic_code =  '47' => 'PAK',
								l.db_cons_ethnic_code =  '48' => 'BEN',
								l.db_cons_ethnic_code =  '49' => 'IND',
								l.db_cons_ethnic_code =  '50' => 'INN',
								l.db_cons_ethnic_code =  '51' => 'BUR',
								l.db_cons_ethnic_code =  '52' => 'MON',
								l.db_cons_ethnic_code =  '53' => 'CHI',
								l.db_cons_ethnic_code =  '55' => 'TIW',
								l.db_cons_ethnic_code =  '56' => 'KOR',
								l.db_cons_ethnic_code =  '57' => 'JPN',
								l.db_cons_ethnic_code =  '58' => 'THA',
								l.db_cons_ethnic_code =  '59' => 'MAY',
								l.db_cons_ethnic_code =  '60' => 'LAO',
								l.db_cons_ethnic_code =  '61' => 'KHM',
								l.db_cons_ethnic_code =  '62' => 'VIE',
								l.db_cons_ethnic_code =  '63' => 'SIN',
								l.db_cons_ethnic_code =  '64' => 'UZB',
								l.db_cons_ethnic_code =  '65' => 'ASN',
								l.db_cons_ethnic_code =  '7D' => 'TEL',
								l.db_cons_ethnic_code =  '7E' => 'NEP',
								l.db_cons_ethnic_code =  '71' => 'BRZ',
								l.db_cons_ethnic_code =  '72' => 'TUK',
								l.db_cons_ethnic_code =  '73' => 'TGK',
								l.db_cons_ethnic_code =  '74' => 'KIR',
								l.db_cons_ethnic_code =  '8G' => 'TIB',
								l.db_cons_ethnic_code =  '9J' => 'CHE',
								// 'HINDU',
								l.db_cons_ethnic_code =  '7A' => 'INN', 
								l.db_cons_ethnic_code =  '7F' => 'SMO', 
								l.db_cons_ethnic_code =  '7M' => 'TRI',
								l.db_cons_ethnic_code =  '7N' => 'SAR',
								l.db_cons_ethnic_code =  '8H' => 'FIJ',
								l.db_cons_ethnic_code =  '8W' => 'JAM',
								l.db_cons_ethnic_code =  '9N' => 'FIL',
								l.db_cons_ethnic_code =  '9X' => 'PNG',
								l.db_cons_ethnic_code =  '9Q' => 'HAW',
								l.db_cons_ethnic_code =  '01' => 'ENG',
								l.db_cons_ethnic_code =  '02' => 'SCO',
								l.db_cons_ethnic_code =  '03' => 'DAN',
								l.db_cons_ethnic_code =  '04' => 'SWE',
								l.db_cons_ethnic_code =  '05' => 'NOR',
								l.db_cons_ethnic_code =  '06' => 'FIN',
								l.db_cons_ethnic_code =  '07' => 'ICE',
								l.db_cons_ethnic_code =  '08' => 'DUT',
								l.db_cons_ethnic_code =  '09' => 'BEG',
								l.db_cons_ethnic_code =  '10' => 'GER',
								l.db_cons_ethnic_code =  '11' => 'AUS',
								l.db_cons_ethnic_code =  '12' => 'HUN',
								l.db_cons_ethnic_code =  '13' => 'CZE',
								l.db_cons_ethnic_code =  '14' => 'SLO',
								l.db_cons_ethnic_code =  '15' => 'IRS',
								l.db_cons_ethnic_code =  '16' => 'WEL',
								l.db_cons_ethnic_code =  '17' => 'FRE',
								l.db_cons_ethnic_code =  '18' => 'SWS',
								l.db_cons_ethnic_code =  '19' => 'ITA',
								l.db_cons_ethnic_code =  '20' => 'SPA',
								l.db_cons_ethnic_code =  '21' => 'POR',
								l.db_cons_ethnic_code =  '22' => 'POL',
								l.db_cons_ethnic_code =  '23' => 'EST',
								l.db_cons_ethnic_code =  '24' => 'LAV',
								l.db_cons_ethnic_code =  '25' => 'LIT',
								l.db_cons_ethnic_code =  '26' => 'UKR',
								l.db_cons_ethnic_code =  '27' => 'GEO',
								l.db_cons_ethnic_code =  '28' => 'BEL',
								l.db_cons_ethnic_code =  '29' => 'ARM',
								l.db_cons_ethnic_code =  '30' => 'RUS',
								l.db_cons_ethnic_code =  '33' => 'GRE',
								l.db_cons_ethnic_code =  '35' => 'MOL',
								l.db_cons_ethnic_code =  '36' => 'BUL',
								l.db_cons_ethnic_code =  '37' => 'RUM',
								l.db_cons_ethnic_code =  '38' => 'ALB',
								l.db_cons_ethnic_code =  '40' => 'SLV',
								l.db_cons_ethnic_code =  '41' => 'HRV',
								l.db_cons_ethnic_code =  '42' => 'SRP',
								l.db_cons_ethnic_code =  '43' => 'BOS',
								l.db_cons_ethnic_code =  '66' => 'JEW',
								l.db_cons_ethnic_code =  '68' => 'HEB',
								l.db_cons_ethnic_code =  '7C' => 'GLV',
								l.db_cons_ethnic_code =  '9F' => 'MAC',
								l.db_cons_ethnic_code =  '9S' => 'BAQ',
								l.db_cons_ethnic_code =  '39' => 'NAT',
								l.db_cons_ethnic_code =  '67' => 'ALE',
								l.db_cons_ethnic_code =  'ZZ' => 'MUL',
								l.db_cons_ethnic_code =  'UC' => 'UND',
								l.db_cons_ethnic_code =  '7H' => 'IKU',
								l.db_cons_ethnic_code =  '9K' => 'IBO',
								l.db_cons_ethnic_code =  '9L' => 'YOR',
								l.db_cons_ethnic_code =  '00' => 'UND',								
								'**|'+ l.db_cons_ethnic_code);	
self.dbconslangprefdesc := map( l.DB_Cons_Language_Pref = '01' => 'ENGLISH (DEFAULT)',
								l.DB_Cons_Language_Pref = '03' => 'DANISH',
								l.DB_Cons_Language_Pref = '04' => 'SWEDISH',
								l.DB_Cons_Language_Pref = '05' => 'NORWEGIAN',
								l.DB_Cons_Language_Pref = '06' => 'FINNISH',
								l.DB_Cons_Language_Pref = '07' => 'ICELANDIC',
								l.DB_Cons_Language_Pref = '08' => 'DUTCH/FLEMISH',
								l.DB_Cons_Language_Pref = '10' => 'GERMAN',
								l.DB_Cons_Language_Pref = '09' => 'DUTCH/FLEMISH',
								l.DB_Cons_Language_Pref = '12' => 'HUNGARIAN',
								l.DB_Cons_Language_Pref = '13' => 'CZECH',
								l.DB_Cons_Language_Pref = '14' => 'SLOVAKIAN',
								l.DB_Cons_Language_Pref = '17' => 'FRENCH',
								l.DB_Cons_Language_Pref = '19' => 'ITALIAN',
								l.DB_Cons_Language_Pref = '20' => 'SPANISH',
								l.DB_Cons_Language_Pref = '21' => 'PORTUGUESE',
								l.DB_Cons_Language_Pref = '22' => 'POLISH',
								l.DB_Cons_Language_Pref = '23' => 'ESTONIAN',
								l.DB_Cons_Language_Pref = '24' => 'LATVIAN',
								l.DB_Cons_Language_Pref = '25' => 'LITHUANIAN',
								l.DB_Cons_Language_Pref = '27' => 'GEORGIAN',
								l.DB_Cons_Language_Pref = '29' => 'ARMENIAN',
								l.DB_Cons_Language_Pref = '30' => 'RUSSIAN',
								l.DB_Cons_Language_Pref = '31' => 'TURKISH',
								l.DB_Cons_Language_Pref = '32' => 'KURDISH',
								l.DB_Cons_Language_Pref = '33' => 'GREEK',
								l.DB_Cons_Language_Pref = '34' => 'FARSI/PERSIAN',
								l.DB_Cons_Language_Pref = '35' => 'MOLDAVIAN/MOLDOVAN',
								l.DB_Cons_Language_Pref = '36' => 'BULGARIAN',
								l.DB_Cons_Language_Pref = '37' => 'ROMANIAN',
								l.DB_Cons_Language_Pref = '38' => 'ALBANIAN',
								l.DB_Cons_Language_Pref = '40' => 'SLOVENIAN',
								l.DB_Cons_Language_Pref = '41' => 'SERBO-CROATIAN',
								l.DB_Cons_Language_Pref = '44' => 'AZERI',
								l.DB_Cons_Language_Pref = '45' => 'KAZAKH',
								l.DB_Cons_Language_Pref = '46' => 'PASHTU/PASHTO',
								l.DB_Cons_Language_Pref = '47' => 'URDU',
								l.DB_Cons_Language_Pref = '48' => 'BENGALI',
								l.DB_Cons_Language_Pref = '49' => 'INDONESIAN',
								l.DB_Cons_Language_Pref = '50' => 'ASIAN INDIAN (HINDI	OR OTHER)',
								l.DB_Cons_Language_Pref = '51' => 'BURMESE',
								l.DB_Cons_Language_Pref = '52' => 'MONGOLIAN',
								l.DB_Cons_Language_Pref = '53' => 'CHINESE',
								l.DB_Cons_Language_Pref = '54' => 'CANTONESE',
								l.DB_Cons_Language_Pref = '56' => 'KOREAN',
								l.DB_Cons_Language_Pref = '57' => 'JAPANESE',
								l.DB_Cons_Language_Pref = '58' => 'THAI',
								l.DB_Cons_Language_Pref = '59' => 'MALAY',
								l.DB_Cons_Language_Pref = '60' => 'LAOTIAN',
								l.DB_Cons_Language_Pref = '61' => 'KHMER',
								l.DB_Cons_Language_Pref = '62' => 'VIETNAMESE',
								l.DB_Cons_Language_Pref = '63' => 'SINHALESE',
								l.DB_Cons_Language_Pref = '64' => 'UZBEKI/UZBEK',
								l.DB_Cons_Language_Pref = '65' => 'HMONG',
								l.DB_Cons_Language_Pref = '68' => 'HEBREW',
								l.DB_Cons_Language_Pref = '70' => 'ARABIC',
								l.DB_Cons_Language_Pref = '72' => 'TURKMENI/TURKMEN',
								l.DB_Cons_Language_Pref = '73' => 'TAJIK',
								l.DB_Cons_Language_Pref = '74' => 'KIRGHIZ',
								l.DB_Cons_Language_Pref = '7A' => 'ASIAN INDIAN (HINDI	OR OTHER)',
								l.DB_Cons_Language_Pref = '7E' => 'NEPALI',
								l.DB_Cons_Language_Pref = '7F' => 'SAMOAN',
								l.DB_Cons_Language_Pref = '7H' => 'INUKTITUT',
								l.DB_Cons_Language_Pref = '80' => 'TONGAN',
								l.DB_Cons_Language_Pref = '86' => 'OROMO',
								l.DB_Cons_Language_Pref = '88' => 'GA',
								l.DB_Cons_Language_Pref = '8G' => 'TIBETAN',
								l.DB_Cons_Language_Pref = '8I' => 'SWAZI',
								l.DB_Cons_Language_Pref = '8J'	=> 'ZULU',
								l.DB_Cons_Language_Pref = '8K' => 'XHOSA',
								l.DB_Cons_Language_Pref = '8M' => 'AFRIKAANS',
								l.DB_Cons_Language_Pref = '8O' => 'COMORIAN',
								l.DB_Cons_Language_Pref = '8S' => 'AKAN/ASHANTI',
								l.DB_Cons_Language_Pref = '8T' => 'SWAHILI',
								l.DB_Cons_Language_Pref = '8X' => 'HAUSA',
								l.DB_Cons_Language_Pref = '92' => 'BANTU',
								l.DB_Cons_Language_Pref = '94' => 'DZONGKHA',
								l.DB_Cons_Language_Pref = '95' => 'AMHARIC',
								l.DB_Cons_Language_Pref = '97' => 'TSWANA',
								l.DB_Cons_Language_Pref = '9E' => 'SOMALI',
								l.DB_Cons_Language_Pref = '9F' => 'MACEDONIAN',
								l.DB_Cons_Language_Pref = '9J' => 'CHECHEN',
								l.DB_Cons_Language_Pref = '9N' => 'TAGALOG',
								l.DB_Cons_Language_Pref = '9O' => 'SOTHO',
								l.DB_Cons_Language_Pref = '9R' => 'MALAGASY',
								l.DB_Cons_Language_Pref = '9S' => 'BASQUE',
								l.DB_Cons_Language_Pref = '9K' => 'IBO/IGBO',
								l.DB_Cons_Language_Pref = '9L' => 'YORUBA',
								l.DB_Cons_Language_Pref = '9X' => 'TOK PISIN',
								'**|'+ l.DB_Cons_Language_Pref );
								self.DB_Cons_Language_Pref := map( l.DB_Cons_Language_Pref = '01' => 'ENG',
								l.DB_Cons_Language_Pref = '03' => 'DAN',
								l.DB_Cons_Language_Pref = '04' => 'SWE',
								l.DB_Cons_Language_Pref = '05' => 'NOR',
								l.DB_Cons_Language_Pref = '06' => 'FIN',
								l.DB_Cons_Language_Pref = '07' => 'ICE',
								l.DB_Cons_Language_Pref = '08' => 'DUT',
								l.DB_Cons_Language_Pref = '10' => 'GER',
								l.DB_Cons_Language_Pref = '09' => 'DUT',
								l.DB_Cons_Language_Pref = '12' => 'HUN',
								l.DB_Cons_Language_Pref = '13' => 'CZE',
								l.DB_Cons_Language_Pref = '14' => 'SLO',
								l.DB_Cons_Language_Pref = '17' => 'FRE',
								l.DB_Cons_Language_Pref = '19' => 'ITA',
								l.DB_Cons_Language_Pref = '20' => 'SPA',
								l.DB_Cons_Language_Pref = '21' => 'POR',
								l.DB_Cons_Language_Pref = '22' => 'POL',
								l.DB_Cons_Language_Pref = '23' => 'EST',
								l.DB_Cons_Language_Pref = '24' => 'LAV',
								l.DB_Cons_Language_Pref = '25' => 'LIT',
								l.DB_Cons_Language_Pref = '27' => 'GEO',
								l.DB_Cons_Language_Pref = '29' => 'ARM',
								l.DB_Cons_Language_Pref = '30' => 'RUS',
								l.DB_Cons_Language_Pref = '31' => 'TUR',
								l.DB_Cons_Language_Pref = '32' => 'KUR',
								l.DB_Cons_Language_Pref = '33' => 'GRE',
								l.DB_Cons_Language_Pref = '34' => 'PER',
								l.DB_Cons_Language_Pref = '35' => 'MOL',
								l.DB_Cons_Language_Pref = '36' => 'BUL',
								l.DB_Cons_Language_Pref = '37' => 'RUM',
								l.DB_Cons_Language_Pref = '38' => 'ALB',
								l.DB_Cons_Language_Pref = '40' => 'SLV',
								l.DB_Cons_Language_Pref = '41' => 'SPR',
								l.DB_Cons_Language_Pref = '44' => 'AZE',
								l.DB_Cons_Language_Pref = '45' => 'KAZ',
								l.DB_Cons_Language_Pref = '46' => 'PUS',
								l.DB_Cons_Language_Pref = '47' => 'URD',
								l.DB_Cons_Language_Pref = '48' => 'BEN',
								l.DB_Cons_Language_Pref = '49' => 'IND',
								l.DB_Cons_Language_Pref = '50' => 'HIN',
								l.DB_Cons_Language_Pref = '51' => 'BUR',
								l.DB_Cons_Language_Pref = '52' => 'MON',
								l.DB_Cons_Language_Pref = '53' => 'CHI',
								l.DB_Cons_Language_Pref = '54' => 'CAN',
								l.DB_Cons_Language_Pref = '56' => 'KOR',
								l.DB_Cons_Language_Pref = '57' => 'JPN',
								l.DB_Cons_Language_Pref = '58' => 'THA',
								l.DB_Cons_Language_Pref = '59' => 'MAY',
								l.DB_Cons_Language_Pref = '60' => 'LAO',
								l.DB_Cons_Language_Pref = '61' => 'KHM',
								l.DB_Cons_Language_Pref = '62' => 'VIE',
								l.DB_Cons_Language_Pref = '63' => 'SIN',
								l.DB_Cons_Language_Pref = '64' => 'UZB',
								l.DB_Cons_Language_Pref = '65' => 'HMN',
								l.DB_Cons_Language_Pref = '68' => 'HEB',
								l.DB_Cons_Language_Pref = '70' => 'ARA',
								l.DB_Cons_Language_Pref = '72' => 'TUK',
								l.DB_Cons_Language_Pref = '73' => 'TGK',
								l.DB_Cons_Language_Pref = '74' => 'KIR',
								l.DB_Cons_Language_Pref = '7A' => 'HIN',
								l.DB_Cons_Language_Pref = '7E' => 'NEP',
								l.DB_Cons_Language_Pref = '7F' => 'SMO',
								l.DB_Cons_Language_Pref = '7H' => 'IKU',
								l.DB_Cons_Language_Pref = '80' => 'TON',
								l.DB_Cons_Language_Pref = '86' => 'ORM',
								l.DB_Cons_Language_Pref = '88' => 'GAA',
								l.DB_Cons_Language_Pref = '8G' => 'TIB',
								l.DB_Cons_Language_Pref = '8I' => 'SSW',
								l.DB_Cons_Language_Pref = '8J' => 'ZUL',
								l.DB_Cons_Language_Pref = '8K' => 'XHO',
								l.DB_Cons_Language_Pref = '8M' => 'AFR',
								l.DB_Cons_Language_Pref = '8O' => 'COM',
								l.DB_Cons_Language_Pref = '8S' => 'AKA',
								l.DB_Cons_Language_Pref = '8T' => 'SWA',
								l.DB_Cons_Language_Pref = '8X' => 'HAU',
								l.DB_Cons_Language_Pref = '92' => 'BNT',
								l.DB_Cons_Language_Pref = '94' => 'DZO',
								l.DB_Cons_Language_Pref = '95' => 'AMH',
								l.DB_Cons_Language_Pref = '97' => 'TSN',
								l.DB_Cons_Language_Pref = '9E' => 'SOM',
								l.DB_Cons_Language_Pref = '9F' => 'MAC',
								l.DB_Cons_Language_Pref = '9J' => 'CHE',
								l.DB_Cons_Language_Pref = '9N' => 'TGL',
								l.DB_Cons_Language_Pref = '9O' => 'SOT',
								l.DB_Cons_Language_Pref = '9R' => 'MLG',
								l.DB_Cons_Language_Pref = '9S' => 'BAQ',
								l.DB_Cons_Language_Pref = '9K' => 'IBO',
								l.DB_Cons_Language_Pref = '9L' => 'YOR',
								l.DB_Cons_Language_Pref = '9X' => 'TPI',
								'**|'+ l.DB_Cons_Language_Pref );
self.DB_Cons_Children_Present := map(l.DB_Cons_Children_Present = '1' => '1',
                                     l.DB_Cons_Children_Present = 'N' => '0',																		 
                                     l.DB_Cons_Children_Present = '' or l.DB_Cons_Children_Present = ' ' => '',
																		 '**|'+ l.DB_Cons_Children_Present);
self.DB_Cons_Donor_Capacity_Code := map(l.DB_Cons_Donor_Capacity_Code <= '499'                                               => 'A',
																		    l.DB_Cons_Donor_Capacity_Code >= '500'  and l.DB_Cons_Donor_Capacity_Code <= '999'   => 'B',
																		    l.DB_Cons_Donor_Capacity_Code >= '1000' and l.DB_Cons_Donor_Capacity_Code <= '2499'  => 'C',
																		    l.DB_Cons_Donor_Capacity_Code >= '2500' and l.DB_Cons_Donor_Capacity_Code <= '4999'  => 'D',
																		    l.DB_Cons_Donor_Capacity_Code >= '5000'                                              => 'E',
																		    l.DB_Cons_Donor_Capacity_Code = '' or l.DB_Cons_Donor_Capacity_Code = ' '            => '',
																		    '**|'+ l.DB_Cons_Donor_Capacity_Code);
self.DB_Cons_Donor_Capacity_Desc := map(l.DB_Cons_Donor_Capacity_Code <= '499'                                               => 'Up to $499',
																		    l.DB_Cons_Donor_Capacity_Code >= '500'  and l.DB_Cons_Donor_Capacity_Code <= '999'   => '$500 to $999',
																		    l.DB_Cons_Donor_Capacity_Code >= '1000' and l.DB_Cons_Donor_Capacity_Code <= '2499'  => '$1,000 to $2,499',
																		    l.DB_Cons_Donor_Capacity_Code >= '2500' and l.DB_Cons_Donor_Capacity_Code <= '4999'  => '$2,500 to $4,999',
																		    l.DB_Cons_Donor_Capacity_Code >= '5000'                                              => 'Over $5,000',
																		    l.DB_Cons_Donor_Capacity_Code = '' or l.DB_Cons_Donor_Capacity_Code = ' '            => '',
																		    '**|'+ L.DB_Cons_Donor_Capacity_Code);
self.DB_Cons_DiscretIncomeCode := map(l.DB_Cons_DiscretIncome <= '9999'                                           => 'A',
																		  l.DB_Cons_DiscretIncome >= '10000'  and l.DB_Cons_DiscretIncome <= '29999'  => 'B',
																		  l.DB_Cons_DiscretIncome >= '30000'  and l.DB_Cons_DiscretIncome <= '49999'  => 'C',
																		  l.DB_Cons_DiscretIncome >= '50000'  and l.DB_Cons_DiscretIncome <= '69999'  => 'D',
																		  l.DB_Cons_DiscretIncome >= '70000'  and l.DB_Cons_DiscretIncome <= '99999'  => 'E',
																		  l.DB_Cons_DiscretIncome >= '100000' and l.DB_Cons_DiscretIncome <= '124999' => 'F',
																		  l.DB_Cons_DiscretIncome >= '125000' and l.DB_Cons_DiscretIncome <= '149999' => 'G',
																		  l.DB_Cons_DiscretIncome >= '150000'                                         => 'H',
																		  l.DB_Cons_DiscretIncome = '' or l.DB_Cons_DiscretIncome = ' '               => '',
																		  '**|'+ l.DB_Cons_DiscretIncome);
self.DB_Cons_DiscretIncomeDesc:= map(l.DB_Cons_DiscretIncome  <= '9999'                                           => 'Up to $9,999',
																		  l.DB_Cons_DiscretIncome >= '10000'  and l.DB_Cons_DiscretIncome <= '29999'  => '$10,000 to $29,000',
																		  l.DB_Cons_DiscretIncome >= '30000'  and l.DB_Cons_DiscretIncome <= '49999'  => '$30,000 to $49,000',
																		  l.DB_Cons_DiscretIncome >= '50000'  and l.DB_Cons_DiscretIncome <= '69999'  => '$50,000 to $69,000',
																		  l.DB_Cons_DiscretIncome >= '70000'  and l.DB_Cons_DiscretIncome <= '99999'  => '$70,000 to $99,000',
																		  l.DB_Cons_DiscretIncome >= '100000' and l.DB_Cons_DiscretIncome <= '124999' => '$100,000 to $124,000',
																		  l.DB_Cons_DiscretIncome >= '125000' and l.DB_Cons_DiscretIncome <= '149999' => '$125,000 to $149,000',
																		  l.DB_Cons_DiscretIncome >= '150000'                                         => 'Over $150,000',
																		  l.DB_Cons_DiscretIncome = '' or l.DB_Cons_DiscretIncome = ' '               => '',
																		  '**|'+ l.DB_Cons_DiscretIncome);
self.DB_Cons_New_Teen_Driver := map(l.DB_Cons_New_Teen_Driver = 'A' => '1',
																		l.DB_Cons_New_Teen_Driver = 'B' => '1',
																		l.DB_Cons_New_Teen_Driver = ' ' or l.DB_Cons_New_Teen_Driver = '' => '',
																		'**|'+ l.DB_Cons_New_Teen_Driver);
self.DBConsTeenDriverDesc := 
           map( l.DB_Cons_New_Teen_Driver = 'A' => 'YES',
		            l.DB_Cons_New_Teen_Driver = 'B' => 'YES',
								l.DB_Cons_New_Teen_Driver = ' ' or l.DB_Cons_New_Teen_Driver = '' => '',
								'**|'+ l.DB_Cons_New_Teen_Driver);

self.DB_Cons_Education_HH:= map(l.DB_Cons_Education_HH = '1' => 'A',
																l.DB_Cons_Education_HH = '2' => 'B',
																l.DB_Cons_Education_HH = '3' => 'C',
																l.DB_Cons_Education_HH = '4' => 'D',
																l.DB_Cons_Education_HH = ' ' or l.DB_Cons_Education_HH = '' => '',
																'**|'+l.DB_Cons_Education_HH);
self.DB_Cons_Education_Ind := map(l.DB_Cons_Education_Ind = '1' => 'A',
																l.DB_Cons_Education_Ind   = '2' => 'B',
																l.DB_Cons_Education_Ind   = '3' => 'C',
																l.DB_Cons_Education_Ind   = '4' => 'D',
																l.DB_Cons_Education_Ind   = '' or l.DB_Cons_Education_Ind = ' ' => '',
																'**|'+l.DB_Cons_Education_Ind);	
self.DB_Cons_UnsecuredCredCapCode := map(l.DB_Cons_UnsecuredCredCap < '5000'  => 'A',
																						l.DB_Cons_UnsecuredCredCap >= '5000' AND l.DB_Cons_UnsecuredCredCap <= '9999'  => 'B',
																						l.DB_Cons_UnsecuredCredCap >= '10000' AND l.DB_Cons_UnsecuredCredCap <= '24999' => 'C',
																						l.DB_Cons_UnsecuredCredCap >= '25000' AND l.DB_Cons_UnsecuredCredCap <= '49999' => 'D',
																						l.DB_Cons_UnsecuredCredCap >= '50000' AND l.DB_Cons_UnsecuredCredCap <= '99999' => '$50000 TO $99999',
																						l.DB_Cons_UnsecuredCredCap > '99999'  => 'OVER $100000',
																            '**|'+l.DB_Cons_UnsecuredCredCap);												
self.DB_Cons_UnsecuredCredCapDesc := map(l.DB_Cons_UnsecuredCredCap < '5000'  => 'UP TO $4999',
																						l.DB_Cons_UnsecuredCredCap >= '5000' AND l.DB_Cons_UnsecuredCredCap <= '9999' => '$5000 TO $9999',
																						l.DB_Cons_UnsecuredCredCap >= '10000' AND l.DB_Cons_UnsecuredCredCap <= '24999' => '$10000 TO $24999',
																						l.DB_Cons_UnsecuredCredCap >= '25000' AND l.DB_Cons_UnsecuredCredCap <= '49999' => '$25000 TO $49999',
																						l.DB_Cons_UnsecuredCredCap >= '50000' AND l.DB_Cons_UnsecuredCredCap <= '99999' => '$50000 TO $99999',
																						l.DB_Cons_UnsecuredCredCap > '99999'  => 'OVER $100000',
																            '**|'+l.DB_Cons_UnsecuredCredCap);													
self.DB_Cons_Length_Of_Res_Code := map(l.DB_Cons_Length_Of_Res_Code = 'U' => '',
																			 l.DB_Cons_Length_Of_Res_Code);															
self.DB_Cons_Length_Of_Res_Desc := map(l.DB_Cons_Length_Of_Res_Desc = 'UNKNOWN' => '',
																			 l.DB_Cons_Length_Of_Res_Desc);																		
		 SELF := l;
		 SELF := [];		 
	END;  
		
dPatchBase := project(Base_In_Database_USA, fPatchBase(LEFT));	

OUTPUT(dPatchBase,,'~thor_data400::base::database_usa::20200428::data::patched',overwrite,__compressed__,named('dPatchBase')); 
	
// newPatchedBase :=	DATASET('~thor_data400::base::database_usa::20200428::data::patched',Database_USA.Layouts.Base,THOR);
newPatchedBase := dPatchBase;

searchpattern := U8'\\u002A';
distBadDescNewPatchedBase := distribute(newPatchedBase(REGEXFIND(searchpattern,db_cons_ethnic_code)),hash(db_cons_ethnic_code));
sortBadDescNewPatchedBase := sort(distBadDescNewPatchedBase,db_cons_ethnic_code,local);
dedupBadDescNewPatchedBase := dedup(sortBadDescNewPatchedBase,db_cons_ethnic_code,local);

distBadDescNewPatchedBaseCode := distribute(newPatchedBase(REGEXFIND('SWED',db_cons_language_pref)),hash(db_cons_language_pref));
sortBadDescNewPatchedBaseCode := sort(distBadDescNewPatchedBaseCode,db_cons_language_pref,local);
dedupBadDescNewPatchedBaseCode := dedup(sortBadDescNewPatchedBaseCode,db_cons_language_pref,local);

OUTPUT(dedupBadDescNewPatchedBase,,named('badDesc'));
OUTPUT(dedupBadDescNewPatchedBaseCode,,named('badCode'));
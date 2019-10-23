IMPORT corp2;

EXPORT Functions := MODULE

		//****************************************************************************
		//State_Descriptions: returns the us state description.
		//****************************************************************************
		EXPORT State_Description(string s) := FUNCTION

					 uc_s := corp2.t2u(s);

	         RETURN map(uc_s = 'AA'																								=> 'ARMED FORCES AMERICAS EXCEPT CANADA',
											uc_s = 'AE'																								=> 'ARMED FORCES EUROPE, THE MIDDLE EAST AND CANADA',
											uc_s = 'AL'																								=> 'ALABAMA',
											uc_s = 'AK'																								=> 'ALASKA', 
											uc_s = 'AP'																								=> 'ARMED FORCES PACIFIC',
											uc_s = 'ARMED FORCES EUROPE, THE MIDDLE EAST AND CANADA' 	=> uc_s,
											uc_s = 'AR'																								=> 'ARKANSAS', 
											uc_s = 'AS'																								=> 'AMERICAN SAMOA', 
											uc_s = 'AZ'																								=> 'ARIZONA', 
											uc_s = 'CA'																								=> 'CALIFORNIA', 
											uc_s = 'CO'																								=> 'COLORADO', 
											uc_s = 'CT'																								=> 'CONNECTICUT',
											uc_s = 'CZ'																								=> 'CANAL ZONE',											
											uc_s = 'DC'																								=> 'DISTRICT OF COLUMBIA', 
											uc_s = 'DE'																								=> 'DELAWARE', 
											uc_s = 'FL'																								=> 'FLORIDA', 
											uc_s = 'GA'																								=> 'GEORGIA', 
											uc_s = 'GU'																								=> 'GUAM', 
											uc_s = 'HI'																								=> 'HAWAII', 
											uc_s = 'IA'																								=> 'IOWA', 
											uc_s = 'ID'																								=> 'IDAHO', 
											uc_s = 'IL'																								=> 'ILLINOIS', 
											uc_s = 'IN'																								=> 'INDIANA', 
											uc_s = 'KS'																								=> 'KANSAS', 
											uc_s = 'KY'																								=> 'KENTUCKY', 
											uc_s = 'LA'																								=> 'LOUISIANA', 
											uc_s = 'MA'																								=> 'MASSACHUSETTS', 
											uc_s = 'MD'																								=> 'MARYLAND', 
											uc_s = 'ME'																								=> 'MAINE' , 
											uc_s = 'MI'																								=> 'MICHIGAN', 
											uc_s = 'MN'																								=> 'MINNESOTA', 
											uc_s = 'MO'																								=> 'MISSOURI', 
											uc_s = 'MS'																								=> 'MISSISSIPPI', 
											uc_s = 'MT'																								=> 'MONTANA', 
											uc_s = 'NC'																								=> 'NORTH CAROLINA', 
											uc_s = 'ND'																								=> 'NORTH DAKOTA', 
											uc_s = 'NE'																								=> 'NEBRASKA', 
											uc_s = 'NH'																								=> 'NEW HAMPSHIRE', 
											uc_s = 'NJ'																								=> 'NEW JERSEY', 
											uc_s = 'NM'																								=> 'NEW MEXICO', 
											uc_s = 'NV'																								=> 'NEVADA', 
											uc_s = 'NY'																								=> 'NEW YORK', 
											uc_s = 'OH'																								=> 'OHIO', 
											uc_s = 'OK'																								=> 'OKLAHOMA', 
											uc_s = 'OR'																								=> 'OREGON', 
											uc_s = 'PA'																								=> 'PENNSYLVANIA', 
											uc_s = 'PR'																								=> 'PUERTO RICO', 
											uc_s = 'RI'																								=> 'RHODE ISLAND', 
											uc_s = 'SC'																								=> 'SOUTH CAROLINA', 
											uc_s = 'SD'																								=> 'SOUTH DAKOTA', 
											uc_s = 'TN'																								=> 'TENNESSEE', 
											uc_s = 'TX'																								=> 'TEXAS', 
											uc_s = 'US'																								=> 'US', 
											uc_s = 'UT'																								=> 'UTAH', 
											uc_s = 'VA'																								=> 'VIRGINIA', 
											uc_s = 'VI'																								=> 'VIRGIN ISLANDS', 
											uc_s = 'VT'																								=> 'VERMONT', 
											uc_s = 'WA'																								=> 'WASHINGTON', 
											uc_s = 'WI'																								=> 'WISCONSIN', 
											uc_s = 'WV'																								=> 'WEST VIRGINIA', 
											uc_s = 'WY'																								=> 'WYOMING',						
											uc_s = 'XX'																								=> '',
											uc_s = ''   																							=> '',
											'**|'+uc_s
										 );
		END;
    
		//****************************************************************************
		//Country_Description: returns the corp_country_of_formation.
		//****************************************************************************
		EXPORT Country_Description(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
	         RETURN map(uc_s = ''    => '',
		        		      uc_s = 'AFG' => 'AFGHANISTAN',
											uc_s = 'ALA' => 'ÅLAND ISLANDS',
											uc_s = 'ALB' => 'ALBANIA',
											uc_s = 'DZA' => 'ALGERIA',
											uc_s = 'ASM' => 'AMERICAN SAMOA',
											uc_s = 'AND' => 'ANDORRA',
											uc_s = 'AGO' => 'ANGOLA',
											uc_s = 'AIA' => 'ANGUILLA',
											uc_s = 'ATA' => 'ANTARCTICA',
											uc_s = 'ATG' => 'ANTIGUA AND BARBUDA',
											uc_s = 'ARG' => 'ARGENTINA',
											uc_s = 'ARM' => 'ARMENIA',
											uc_s = 'ABW' => 'ARUBA',
											uc_s = 'AUS' => 'AUSTRALIA',
											uc_s = 'AUT' => 'AUSTRIA',
											uc_s = 'AZE' => 'AZERBAIJAN',
											uc_s = 'BHS' => 'BAHAMAS',
											uc_s = 'BHR' => 'BAHRAIN',
											uc_s = 'BGD' => 'BANGLADESH',
											uc_s = 'BRB' => 'BARBADOS',
											uc_s = 'BLR' => 'BELARUS',
											uc_s = 'BEL' => 'BELGIUM',
											uc_s = 'BLZ' => 'BELIZE',
											uc_s = 'BEN' => 'BENIN',
											uc_s = 'BMU' => 'BERMUDA',
											uc_s = 'BTN' => 'BHUTAN',
											uc_s = 'BOL' => 'BOLIVIA',
											uc_s = 'BES' => 'BONAIRE, SINT EUSTATIUS AND SABA',
											uc_s = 'BIH' => 'BOSNIA AND HERZEGOVINA',
											uc_s = 'BWA' => 'BOTSWANA',
											uc_s = 'BVT' => 'BOUVET ISLAND',
											uc_s = 'BRA' => 'BRAZIL',
											uc_s = 'IOT' => 'BRITISH INDIAN OCEAN TERRITORY',
											uc_s = 'BRN' => 'BRUNEI DARUSSALAM',
											uc_s = 'BGR' => 'BULGARIA',
											uc_s = 'BFA' => 'BURKINA FASO',
											uc_s = 'BDI' => 'BURUNDI',
											uc_s = 'CPV' => 'CABO VERDE',
											uc_s = 'KHM' => 'CAMBODIA',
											uc_s = 'CMR' => 'CAMEROON',
											uc_s = 'CAN' => 'CANADA',
											uc_s = 'CYM' => 'CAYMAN ISLANDS',
											uc_s = 'CAF' => 'CENTRAL AFRICAN REPUBLIC',
											uc_s = 'TCD' => 'CHAD',
											uc_s = 'CHL' => 'CHILE',
											uc_s = 'CHN' => 'CHINA',
											uc_s = 'CXR' => 'CHRISTMAS ISLAND',
											uc_s = 'CCK' => 'COCOS (KEELING) ISLANDS',
											uc_s = 'COL' => 'COLOMBIA',
											uc_s = 'COM' => 'COMOROS',
											uc_s = 'COD' => 'CONGO',
											uc_s = 'COG' => 'CONGO',
											uc_s = 'COK' => 'COOK ISLANDS',
											uc_s = 'CRI' => 'COSTA RICA',
											uc_s = 'CIV' => 'COTE D\'IVOIRE',
											uc_s = 'HRV' => 'CROATIA',
											uc_s = 'CUB' => 'CUBA',
											uc_s = 'CUW' => 'CURAÇAO',
											uc_s = 'CYP' => 'CYPRUS',
											uc_s = 'CZE' => 'CZECHIA',
											uc_s = 'DNK' => 'DENMARK',
											uc_s = 'DJI' => 'DJIBOUTI',
											uc_s = 'DMA' => 'DOMINICA',
											uc_s = 'DOM' => 'DOMINICAN REPUBLIC',
											uc_s = 'ECU' => 'ECUADOR',
											uc_s = 'EGY' => 'EGYPT',
											uc_s = 'SLV' => 'EL SALVADOR',
											uc_s = 'GNQ' => 'EQUATORIAL GUINEA',
											uc_s = 'ERI' => 'ERITREA',
											uc_s = 'EST' => 'ESTONIA',
											uc_s = 'ETH' => 'ETHIOPIA',
											uc_s = 'FLK' => 'FALKLAND ISLANDS',
											uc_s = 'FRO' => 'FAROE ISLANDS',
											uc_s = 'FJI' => 'FIJI',
											uc_s = 'FIN' => 'FINLAND',
											uc_s = 'FRA' => 'FRANCE',
											uc_s = 'GUF' => 'FRENCH GUIANA',
											uc_s = 'PYF' => 'FRENCH POLYNESIA',
											uc_s = 'ATF' => 'FRENCH SOUTHERN TERRITORIES',
											uc_s = 'GAB' => 'GABON',
											uc_s = 'GMB' => 'GAMBIA',
											uc_s = 'GEO' => 'GEORGIA',
											uc_s = 'DEU' => 'GERMANY',
											uc_s = 'GHA' => 'GHANA',
											uc_s = 'GIB' => 'GIBRALTAR',
											uc_s = 'GRC' => 'GREECE',
											uc_s = 'GRL' => 'GREENLAND',
											uc_s = 'GRD' => 'GRENADA',
											uc_s = 'GLP' => 'GUADELOUPE',
											uc_s = 'GUM' => 'GUAM',
											uc_s = 'GTM' => 'GUATEMALA',
											uc_s = 'GGY' => 'GUERNSEY',
											uc_s = 'GIN' => 'GUINEA',
											uc_s = 'GNB' => 'GUINEA-BISSAU',
											uc_s = 'GUY' => 'GUYANA',
											uc_s = 'HTI' => 'HAITI',
											uc_s = 'HMD' => 'HEARD ISLAND AND MCDONALD ISLANDS',
											uc_s = 'VAT' => 'HOLY SEE',
											uc_s = 'HND' => 'HONDURAS',
											uc_s = 'HKG' => 'HONG KONG',
											uc_s = 'HUN' => 'HUNGARY',
											uc_s = 'ISL' => 'ICELAND',
											uc_s = 'IND' => 'INDIA',
											uc_s = 'IDN' => 'INDONESIA',
											uc_s = 'IRN' => 'IRAN',
											uc_s = 'IRQ' => 'IRAQ',
											uc_s = 'IRL' => 'IRELAND',
											uc_s = 'IMN' => 'ISLE OF MAN',
											uc_s = 'ISR' => 'ISRAEL',
											uc_s = 'ITA' => 'ITALY',
											uc_s = 'JAM' => 'JAMAICA',
											uc_s = 'JPN' => 'JAPAN',
											uc_s = 'JEY' => 'JERSEY',
											uc_s = 'JOR' => 'JORDAN',
											uc_s = 'KAZ' => 'KAZAKHSTAN',
											uc_s = 'KEN' => 'KENYA',
											uc_s = 'KIR' => 'KIRIBATI',
											uc_s = 'PRK' => 'KOREA',
											uc_s = 'KOR' => 'KOREA',
											uc_s = 'KWT' => 'KUWAIT',
											uc_s = 'KGZ' => 'KYRGYZSTAN',
											uc_s = 'LAO' => 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC',
											uc_s = 'LVA' => 'LATVIA',
											uc_s = 'LBN' => 'LEBANON',
											uc_s = 'LSO' => 'LESOTHO',
											uc_s = 'LBR' => 'LIBERIA',
											uc_s = 'LBY' => 'LIBYA',
											uc_s = 'LIE' => 'LIECHTENSTEIN',
											uc_s = 'LTU' => 'LITHUANIA',
											uc_s = 'LUX' => 'LUXEMBOURG',
											uc_s = 'MAC' => 'MACAO',
											uc_s = 'MKD' => 'MACEDONIA',
											uc_s = 'MDG' => 'MADAGASCAR',
											uc_s = 'MWI' => 'MALAWI',
											uc_s = 'MYS' => 'MALAYSIA',
											uc_s = 'MDV' => 'MALDIVES',
											uc_s = 'MLI' => 'MALI',
											uc_s = 'MLT' => 'MALTA',
											uc_s = 'MHL' => 'MARSHALL ISLANDS',
											uc_s = 'MTQ' => 'MARTINIQUE',
											uc_s = 'MRT' => 'MAURITANIA',
											uc_s = 'MUS' => 'MAURITIUS',
											uc_s = 'MYT' => 'MAYOTTE',
											uc_s = 'MEX' => 'MEXICO',
											uc_s = 'FSM' => 'MICRONESIA',
											uc_s = 'MDA' => 'MOLDOVA',
											uc_s = 'MCO' => 'MONACO',
											uc_s = 'MNG' => 'MONGOLIA',
											uc_s = 'MNE' => 'MONTENEGRO',
											uc_s = 'MSR' => 'MONTSERRAT',
											uc_s = 'MAR' => 'MOROCCO',
											uc_s = 'MOZ' => 'MOZAMBIQUE',
											uc_s = 'MMR' => 'MYANMAR',
											uc_s = 'NAM' => 'NAMIBIA',
											uc_s = 'NRU' => 'NAURU',
											uc_s = 'NPL' => 'NEPAL',
											uc_s = 'NLD' => 'NETHERLANDS',
											uc_s = 'NCL' => 'NEW CALEDONIA',
											uc_s = 'NZL' => 'NEW ZEALAND',
											uc_s = 'NIC' => 'NICARAGUA',
											uc_s = 'NER' => 'NIGER',
											uc_s = 'NGA' => 'NIGERIA',
											uc_s = 'NIU' => 'NIUE',
											uc_s = 'NFK' => 'NORFOLK ISLAND',
											uc_s = 'MNP' => 'NORTHERN MARIANA ISLANDS',
											uc_s = 'NOR' => 'NORWAY',
											uc_s = 'OMN' => 'OMAN',
											uc_s = 'PAK' => 'PAKISTAN',
											uc_s = 'PLW' => 'PALAU',
											uc_s = 'PSE' => 'PALESTINE, STATE OF',
											uc_s = 'PAN' => 'PANAMA',
											uc_s = 'PNG' => 'PAPUA NEW GUINEA',
											uc_s = 'PRY' => 'PARAGUAY',
											uc_s = 'PER' => 'PERU',
											uc_s = 'PHL' => 'PHILIPPINES',
											uc_s = 'PCN' => 'PITCAIRN',
											uc_s = 'POL' => 'POLAND',
											uc_s = 'PRT' => 'PORTUGAL',
											uc_s = 'PRI' => 'PUERTO RICO',
											uc_s = 'QAT' => 'QATAR',
											uc_s = 'REU' => 'RÉUNION',
											uc_s = 'ROU' => 'ROMANIA',
											uc_s = 'RUS' => 'RUSSIAN FEDERATION',
											uc_s = 'RWA' => 'RWANDA',
											uc_s = 'BLM' => 'SAINT BARTHELEMY',
											uc_s = 'SHN' => 'SAINT HELENA, ASCENSION AND TRISTAN DA CUNHA',
											uc_s = 'KNA' => 'SAINT KITTS AND NEVIS',
											uc_s = 'LCA' => 'SAINT LUCIA',
											uc_s = 'MAF' => 'SAINT MARTIN',
											uc_s = 'SPM' => 'SAINT PIERRE AND MIQUELON',
											uc_s = 'VCT' => 'SAINT VINCENT AND THE GRENADINES',
											uc_s = 'WSM' => 'SAMOA',
											uc_s = 'SMR' => 'SAN MARINO',
											uc_s = 'STP' => 'SAO TOME AND PRINCIPE',
											uc_s = 'SAU' => 'SAUDI ARABIA',
											uc_s = 'SEN' => 'SENEGAL',
											uc_s = 'SRB' => 'SERBIA',
											uc_s = 'SYC' => 'SEYCHELLES',
											uc_s = 'SLE' => 'SIERRA LEONE',
											uc_s = 'SGP' => 'SINGAPORE',
											uc_s = 'SXM' => 'SINT MAARTEN',
											uc_s = 'SVK' => 'SLOVAKIA',
											uc_s = 'SVN' => 'SLOVENIA',
											uc_s = 'SLB' => 'SOLOMON ISLANDS',
											uc_s = 'SOM' => 'SOMALIA',
											uc_s = 'ZAF' => 'SOUTH AFRICA',
											uc_s = 'SGS' => 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS',
											uc_s = 'SSD' => 'SOUTH SUDAN',
											uc_s = 'ESP' => 'SPAIN',
											uc_s = 'LKA' => 'SRI LANKA',
											uc_s = 'SDN' => 'SUDAN',
											uc_s = 'SUR' => 'SURINAME',
											uc_s = 'SJM' => 'SVALBARD AND JAN MAYEN',
											uc_s = 'SWZ' => 'SWAZILAND',
											uc_s = 'SWE' => 'SWEDEN',
											uc_s = 'CHE' => 'SWITZERLAND',
											uc_s = 'SYR' => 'SYRIAN ARAB REPUBLIC',
											uc_s = 'TWN' => 'TAIWAN',
											uc_s = 'TJK' => 'TAJIKISTAN',
											uc_s = 'TZA' => 'TANZANIA, UNITED REPUBLIC OF',
											uc_s = 'THA' => 'THAILAND',
											uc_s = 'TLS' => 'TIMOR-LESTE',
											uc_s = 'TGO' => 'TOGO',
											uc_s = 'TKL' => 'TOKELAU',
											uc_s = 'TON' => 'TONGA',
											uc_s = 'TTO' => 'TRINIDAD AND TOBAGO',
											uc_s = 'TUN' => 'TUNISIA',
											uc_s = 'TUR' => 'TURKEY',
											uc_s = 'TKM' => 'TURKMENISTAN',
											uc_s = 'TCA' => 'TURKS AND CAICOS ISLANDS',
											uc_s = 'TUV' => 'TUVALU',
											uc_s = 'UGA' => 'UGANDA',
											uc_s = 'UKR' => 'UKRAINE',
											uc_s = 'ARE' => 'UNITED ARAB EMIRATES',
											uc_s = 'GBR' => 'UNITED KINGDOM OF GREAT BRITAIN AND NORTHERN IRELAND',
											uc_s = 'UMI' => 'UNITED STATES MINOR OUTLYING ISLANDS',
											uc_s = 'USA' => 'UNITED STATES OF AMERICA',
											uc_s = 'URY' => 'URUGUAY',
											uc_s = 'UZB' => 'UZBEKISTAN',
											uc_s = 'VUT' => 'VANUATU',
											uc_s = 'VEN' => 'VENEZUELA',
											uc_s = 'VNM' => 'VIET NAM',
											uc_s = 'VGB' => 'VIRGIN ISLANDS',
											uc_s = 'VIR' => 'VIRGIN ISLANDS',
											uc_s = 'WLF' => 'WALLIS AND FUTUNA',
											uc_s = 'ESH' => 'WESTERN SAHARA',
											uc_s = 'YEM' => 'YEMEN',
											uc_s = 'ZMB' => 'ZAMBIA',
											uc_s = 'ZWE' => 'ZIMBABWE',
											uc_s = 'XFH' => 'CONFEDERATED SALISH AND KOOTENAI TRIBES',
											uc_s = 'XFN' => 'SAC AND FOX NATION',
											uc_s = 'XGT' => 'GTB OTTAWA AND CHIPPEWA',
											uc_s = 'XHB' => 'NOTTAWASEPPI BAND OF HURON POTAWATOMI',
											uc_s = 'XKB' => 'KEWEENAW BAY INDIAN COMMUNITY',
											uc_s = 'XMJ' => 'MESA GRANDE BAND OF DIEGUENO MISSION INDIANS OF THE MESA GRANDE RESERVATION',
											uc_s = 'XMP' => 'MATCH-E-BE-NASH-SHE-WISH BAND OF POTTAWATOMI INDIANS OF MICHIGAN',
											uc_s = 'XPB' => 'POKAGON BAND OF POTAWATOMI INDIANS',
											uc_s = 'XRR' => 'LITTLE RIVER BAND OF OTTAWA INDIANS',
											uc_s = 'XTI' => 'LITTLE TRAVERSE BAY BANDS OF ODAWA INDIANS',
											uc_s = 'XYN' => 'CONFEDERATED TRIBES AND BANDS OF THE YAKAMA NATION',
											 '**|'+uc_s
							 );
		END;

		//****************************************************************************
		//Foreign_Description: returns the country description.
		//****************************************************************************
		EXPORT Foreign_Description(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
	         RETURN CASE(uc_s,
											 ''    => '',
											 '00'	 => 'MICHIGAN',  								//ASK ROSEMARY											 
											 'AB'	 => 'ALBERTA',									//CANADIAN PROVINCE
											 'AN'  => 'ANGOLA',										//FROM SOS WEBSITE
											 'AT'  => 'AUSTRIA',									//FROM SOS WEBSITE
											 'AU'  => 'AUSTRALIA',								//FROM SOS WEBSITE
											 'BA'  => 'BAHAMAS',									//FROM SOS WEBSITE
											 'BC'  => 'BRITISH COLUMBIA',					//CANADIAN PROVINCE
											 'BE'  => 'BELGIUM',									//FROM SOS WEBSITE
											 'BH'  => 'BOZNIA HERZEGOVINA',				//FROM SOS WEBSITE
											 'BM'  => 'ISLANDS OF BERMUDA',				//FROM SOS WEBSITE
											 'BN'  => 'BURNEI DARUSSALAM',				//FROM SOS WEBSITE
											 'BS'  => 'BARBADOS',									//FROM SOS WEBSITE
											 'CI'  => 'CAYMAN ISLANDS',						//FROM SOS WEBSITE
											 'CK'  => 'COOK ISLANDS',							//FROM SOS WEBSITE
											 'CN'  => 'CANADA',										//FROM SOS WEBSITE
											 'DO'  => 'DOMINICAN REPUBLIC',				//FROM SOS WEBSITE
											 'EG'  => 'EGYPT',										//FROM SOS WEBSITE
											 'EN'  => 'ENGLAND',									//FROM SOS WEBSITE
											 'EW'  => 'ENGLAND AND WALES',				//FROM SOS WEBSITE
											 'FI'  => 'FINLAND',									//FROM SOS WEBSITE
											 'FN'  => 'SAC AND FOX NATION',				//FROM SOS WEBSITE
											 'FR'  => 'FRANCE',										//FROM SOS WEBSITE
											 'GR'  => 'GREAT BRITAIN',						//FROM SOS WEBSITE
											 'HD'  => 'HONDURAS',									//FROM SOS WEBSITE
											 'HJ'  => 'HASHIMET JORDANIAN KING',	//FROM SOS WEBSITE
											 'HK'  => 'HONG KONG',								//FROM SOS WEBSITE
											 'II'  => 'INDIA', 										//FROM SOS WEBSITE											 
											 'IQ'  => 'IRAQ',											//FROM SOS WEBSITE
											 'IR'  => 'IRELAND',									//FROM SOS WEBSITE
											 'IS'  => 'ISRAEL',										//FROM SOS WEBSITE 
											 'IT'  => 'ITALY',										//FROM SOS WEBSITE
											 'IV'  => 'ISLAND OF NEVIS',					//FROM SOS WEBSITE
											 'JA'  => 'JAPAN',										//FROM SOS WEBSITE
											 'JM'  => 'JAMAICA',									//FROM SOS WEBSITE
											 'KB'  => 'KEWEENAW BAY INDIAN COMM',	//FROM SOS WEBSITE
											 'KO'  => 'SOUTH KOREA',							//FROM SOS WEBSITE
											 'KR'  => 'REPUBLIC OF KOREA',				//FROM SOS WEBSITE
											 'KW'  => 'KUWAIT',										//FROM SOS WEBSITE
											 'LE'  => 'LEBANON',									//FROM SOS WEBSITE
											 'LI'  => 'LIECHTENSTEIN',						//FROM SOS WEBSITE
											 'LK'  => 'SRI LANKA',								//FROM SOS WEBSITE
											 'LU'  => 'LUXEMBOURG',								//FROM SOS WEBSITE
											 'MB'  => 'MANITOBA',									//CANADIAN PROVINCE				 
											 'MJ'  => 'MESA GRANDE BOM INDIANS',	//FROM SOS WEBSITE
											 'ML'  => 'MALAYSIA',									//FROM SOS WEBSITE
											 'MP'  => 'MEBNSW BAND OF PI',				//FROM SOS WEBSITE
											 'MR'  => 'NORTHERN MARIANA ISLANDS',	//FROM SOS WEBSITE
											 'MX'  => 'MEXICO',										//FROM SOS WEBSITE
											 'NA'  => 'NETHERLANDS ANTILLES',			//FROM SOS WEBSITE
											 'NB'  => 'NEW BRUNSWICK',						//CANADIAN PROVINCE
											 'NF'  => 'NEWFOUNDLAND',							//CANADIAN PROVINCE
											 'NI'  => 'NIGERIA',									//FROM SOS WEBSITE
											 'NL'  => 'NETHERLANDS',							//FROM SOS WEBSITE
											 'NO'  => 'NORWAY',										//FROM SOS WEBSITE
											 'NS'  => 'NOVA SCOTIA',							//CANADIAN PROVINCE
											 'NT'  => 'NORTH WEST TERRITORIES',		//CANADIAN PROVINCE
											 'ON'  => 'ONTARIO',									//CANADIAN PROVINCE
											 'PE'  => 'PRINCE EDWARD ISLAND',			//CANADIAN PROVINCE
											 'PH'  => 'PHILIPPINES',							//FROM SOS WEBSITE
											 'PK'  => 'PAKISTAN',									//FROM SOS WEBSITE
											 'PM'	 => 'PANAMA',										//FROM SOS WEBSITE
											 'PO'  => 'POLAND ',									//FROM SOS WEBSITE
											 'PQ'  => 'QUEBEC',										//CANADIAN PROVINCE
											 'QC'  => 'QUEBEC',										//CANADIAN PROVINCE
											 'RC'  => 'PEOPLES REPUBLIC OF CHINA',//FROM SOS WEBSITE
											 'RM'  => 'REPUBLIC OF MAURITIUS',		//FROM SOS WEBSITE
											 'RS'  => 'REP OF MARSHALL ISLANDS',	//FROM SOS WEBSITE
											 'RT'  => '', 												//RECORD FAILS ON SOS SITE
											 'RV'  => 'SOCIALIST REP. OF VIETNAM',//FROM SOS WEBSITE
											 'SF'  => 'SOUTH AFRICA',							//FROM SOS WEBSITE
											 'SG'  => 'SINGAPORE', 								//FROM SOS WEBSITE
											 'SI'  => 'SIERRA LEONE', 						//FROM SOS WEBSITE
											 'SK'  => 'SASKATCHEWAN',							//CANADIAN PROVINCE
											 'SL'  => 'SAINT LUCIA', 							//FROM SOS WEBSITE
											 'SN'  => 'SWEDEN',										//FROM SOS WEBSITE
											 'SP'  => 'SPAIN',										//FROM SOS WEBSITE
											 'SS'  => 'REPUBLIC OF SEYCHELLES',		//FROM SOS WEBSITE
											 'SU'  => 'SAUDI ARABIA',							//FROM SOS WEBSITE
											 'SW'  => 'SWITZERLAND',							//FROM SOS WEBSITE
											 'SY'  => 'SYRIA',										//FROM SOS WEBSITE
											 'TC'  => 'TURKS & CAICOS ISLANDS',		//FROM SOS WEBSITE
											 'TI'  => 'LITTLE TRAVERSE ODAWA IND',//FROM SOS WEBSITE 											//UNKNOWN											 
											 'TU'  => 'TURKEY',										//FROM SOS WEBSITE
											 'TZ'  => 'UR OF TANZANIA',						//FROM SOS WEBSITE
											 'UE'  => 'UKRAINE',									//FROM SOS WEBSITE
											 'UK'  => 'UNITED KINGDOM',						//FROM SOS WEBSITE
											 'VE'  => 'VENEZUELA',								//FROM SOS WEBSITE
											 'VG'  => 'BRITISH VIRGIN ISLANDS',		//FROM SOS WEBSITE
											 'YT'  => 'YUKON',										//CANADIAN PROVINCE
											 'WG'  => 'WEST GERMANY',							//FROM SOS WEBSITE
											 'YE'  => 'YEMEN',										//FROM SOS WEBSITE
											 'YN'  => 'YAKAMA NATION',						//FROM SOS WEBSITE
											 'ZI'  => 'ZIMBABWE',									//FROM SOS WEBSITE
											 'TURKS & CAICOS ISLANDS' 		=> uc_s,
											 'SOCIALIST REP. OF VIETNAM' 	=> uc_s,	
											 '**|'+uc_s
							 );
		END;
		//****************************************************************************
		//CorpForgnStateCD: returns "corp_forgn_state_cd".
		//****************************************************************************
		EXPORT CorpForgnStateCD(STRING s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
	         RETURN map(State_Description(uc_s)[1..2] 	<> '**' => uc_s,
											Foreign_Description(uc_s)[1..2] <> '**' => uc_s,
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//CorpForgnStateDesc: returns "corp_forgn_state_desc".
		//****************************************************************************
		EXPORT CorpForgnStateDesc(string s) := FUNCTION

					 uc_s := corp2.t2u(s);

	         RETURN map(State_Description(uc_s)[1..2] 	<> '**'	=> State_Description(uc_s),
											Foreign_Description(uc_s)[1..2] <> '**' => Foreign_Description(uc_s),
											'**|'+uc_s
										 );
		END;

			 
		//****************************************************************************
    //CorpAgentCounty: returns the "Corp Agent County".
    //****************************************************************************
    export CorpAgentCounty(string s) := function
		   
		   uc_s := corp2.t2u(s);
			 return map(uc_s in ['0','00']  => '',
									uc_s in ['1','01']	=> 'ALCONA',
								  uc_s in ['2','02']	=> 'ALGER',
								  uc_s in ['3','03']	=> 'ALLEGAN',
								  uc_s in ['4','04']	=> 'ALPENA',
								  uc_s in ['5','05'] 	=> 'ANTRIM',
								  uc_s in ['6','06'] 	=> 'ARENAC',
								  uc_s in ['7','07'] 	=> 'BARAGA',
								  uc_s in ['8','08']  => 'BARRY',
								  uc_s in ['9','09'] 	=> 'BAY',
								  uc_s = '10' 				=> 'BENZIE',
								  uc_s = '11' 				=> 'BERRIEN',
								  uc_s = '12' 				=> 'BRANCH',
								  uc_s = '13' 				=> 'CALHOUN',
								  uc_s = '14' 				=> 'CASS',
								  uc_s = '15' 				=> 'CHARLEVOIX',
								  uc_s = '16' 				=> 'CHEBOYGAN',
								  uc_s = '17' 				=> 'CHIPPEWA',
								  uc_s = '18' 				=> 'CLARE',
								  uc_s = '19' 				=> 'CLINTON',
								  uc_s = '20' 				=> 'CRAWFORD',
								  uc_s = '21' 				=> 'DELTA',
								  uc_s = '22' 				=> 'DICKINSON',
								  uc_s = '23' 				=> 'EATON',
								  uc_s = '24' 				=> 'EMMET',
								  uc_s = '25' 				=> 'GENESEE',
								  uc_s = '26' 				=> 'GLADWIN',
								  uc_s = '27' 				=> 'GOGEBIC',
								  uc_s = '28' 				=> 'GRAND TRAVERSE',
								  uc_s = '29' 				=> 'GRATIOT',
								  uc_s = '30' 				=> 'HILLSDALE',
								  uc_s = '31' 				=> 'HOUGHTON',
								  uc_s = '32' 				=> 'HURON',
								  uc_s = '33' 				=> 'INGHAM',
								  uc_s = '34' 				=> 'IONIA',
								  uc_s = '35' 				=> 'IOSCO',
								  uc_s = '36' 				=> 'IRON',
								  uc_s = '37' 				=> 'ISABELLA',
								  uc_s = '38' 				=> 'JACKSON',
								  uc_s = '39' 				=> 'KALAMAZOO',
								  uc_s = '40' 				=> 'KALKASKA',
								  uc_s = '41' 				=> 'KENT',
								  uc_s = '42' 				=> 'KEWEENAW',
								  uc_s = '43' 				=> 'LAKE',
								  uc_s = '44' 				=> 'LAPEER',
								  uc_s = '45' 				=> 'LEELNAU',
								  uc_s = '46' 				=> 'LENAWEE',
								  uc_s = '47' 				=> 'LIVINGSTON',
								  uc_s = '48' 				=> 'LUCE',
								  uc_s = '49' 				=> 'MACKINAC',
								  uc_s = '50' 				=> 'MACOMB',
								  uc_s = '51' 				=> 'MANISTEE',
								  uc_s = '52' 				=> 'MARQUETTE',
								  uc_s = '53' 				=> 'MASON',
								  uc_s = '54' 				=> 'MECOSTA',
								  uc_s = '55' 				=> 'MENOMINEE',
								  uc_s = '56' 				=> 'MIDLAND',
								  uc_s = '57' 				=> 'MISSAUKEE',
								  uc_s = '58' 				=> 'MONROE',
								  uc_s = '59' 				=> 'MONTCALM',
								  uc_s = '60' 				=> 'MONTMORENCY',
								  uc_s = '61' 				=> 'MUSKEGON',
								  uc_s = '62' 				=> 'NEWAYGO',
								  uc_s = '63' 				=> 'OAKLAND',
								  uc_s = '64' 				=> 'OCEANA',
								  uc_s = '65' 				=> 'OGEMAW',
								  uc_s = '66' 				=> 'ONTONAGON',
								  uc_s = '67' 				=> 'OSCEOLA',
								  uc_s = '68' 				=> 'OSCODA',
								  uc_s = '69' 				=> 'OTSEGO',
								  uc_s = '70' 				=> 'OTTAWA',
								  uc_s = '71' 				=> 'PRESQUE ISLE',
								  uc_s = '72' 				=> 'ROSCOMMON',
								  uc_s = '73' 				=> 'SAGINAW',
								  uc_s = '74' 				=> 'ST. CLAIR',
								  uc_s = '75' 				=> 'ST. JOSEPH',
								  uc_s = '76' 				=> 'SANILAC',
								  uc_s = '77' 				=> 'SCHOOLCRAFT',
								  uc_s = '78' 				=> 'SHIAWASSEE',
								  uc_s = '79' 				=> 'TUSCOLA',
								  uc_s = '80' 				=> 'VAN BUREN',
								  uc_s = '81' 				=> 'WASHTENAW',
								  uc_s = '82' 				=> 'WAYNE',
								  uc_s = '83' 				=> 'WEXFORD',
									uc_s
								 );
    end;
										 	
		//****************************************************************************
    //CorpAgentCountyStr: returns the "Corp Agent County" string.
    //****************************************************************************
    export CorpAgentCountyStr(string s1, string s2, string s3) := function
		   
			 //This function uses the CorpAgentCounty to get the full county name
		   County1 := CorpAgentCounty(s1);
			 County2 := CorpAgentCounty(s2);
   		 County3 := CorpAgentCounty(s3);
			 
			 return if(County1 = '','',corp2.t2u(County1) + if(County2 = '','','; ' + corp2.t2u(County2) + if(County3 = '','','; ' + corp2.t2u(County3))));
    end;									
		
		
		//****************************************************************************
    //CorpOrigOrgStructureCD: returns the "corp_orig_org_structure_desc".
    //****************************************************************************
    export CorpOrigOrgStructureCD(String s) := function
			 uc_s := corp2.t2u(s);
			 return map(uc_s in ['200','0200'] => 'DOMESTIC PROFIT CORPORATION',
								  uc_s in ['201','0201'] => 'PARTNERSHIP ASSOCIATIONS LIMITED',
								  uc_s in ['300','0300'] => 'DOMESTIC NONPROFIT CORPORATION',
								  uc_s in ['400','0400'] => 'DOMESTIC PROFESSIONAL CORPORATION',
								  uc_s in ['402','0402'] => 'DOMESTIC PROFESSIONAL LIMITED LIABILITY COMPANY',
								  uc_s in ['500','0500'] => 'FOREIGN PROFIT CORPORATION',
								  uc_s in ['502','0502'] => 'FOREIGN NONPROFIT CORPORATION',
								  uc_s in ['503','0503'] => 'FOREIGN PROFESSIONAL CORPORATION',
								  uc_s in ['504','0504'] => 'FOREIGN LIMITED LIABILITY COMPANY',
								  uc_s in ['505','0505'] => 'FOREIGN PROFESSIONAL LIMITED LIABILITY COMPANY',
								  uc_s in ['506','0506'] => 'FOREIGN TRUST',
								  uc_s in ['601','0601'] => 'DOMESTIC LIMITED PARTNERSHIP',
								  uc_s in ['602','0602'] => 'FOREIGN LIMITED PARTNERSHIP',
									uc_s in ['801','0801'] => 'DOMESTIC LIMITED LIABILITY COMPANY',
								  ''
								 );
	  end;
		
		//****************************************************************************
    //CorpStatusComment: returns the "corp_status_cmt" (comment).
		//****************************************************************************
		export CorpStatusComment(string s) := function
			 uc_s := corp2.t2u(s);
			 return map(uc_s = ''		  => '',
			            uc_s = 'CN'   => 'CONVERTED',
									uc_s = 'CRCC'	=> 'CANCELLED:  CERTIFICATE OF CANCELLATION',
									uc_s = 'CRCO'	=> 'CANCELLED:  COURT ORDER',
									uc_s = 'CRTE'	=> 'CANCELLED:  TERM EXPIRED',
									uc_s = 'DSCD'	=> 'DISSOLVED:  CERTIFICATE OF DISSOLUTION',
									uc_s = 'DSCO'	=> 'DISSOLVED:  COURT ORDER',
									uc_s = 'DSOL'	=> 'DISSOLVED:  OPERATION OF LAW',
									uc_s = 'DSTE'	=> 'DISSOLVED:  TERM EXPIRED',
									uc_s = 'ECCN'	=> 'EXISTENCE CEASED:  CONSOLIDATION',
									uc_s = 'ECMR'	=> 'EXISTENCE CEASED:  MERGED',
									uc_s = 'EX'	  => 'EXPIRED',
									uc_s = 'NGS'	=> 'IN EXISTENCE BUT NOT IN GOOD STANDING',
									uc_s = 'NR'	  => 'NOT REGISTERED',
									uc_s = 'OT'	  => 'OTHER',
									uc_s = 'RS'	  => 'RESCINDED',
									uc_s = 'RVFC'	=> 'REVOKED:  FAILURE TO COMPLY',
									uc_s = 'RVOL'	=> 'REVOKED:  OPERATION OF LAW',
									uc_s = 'WDCC'	=> 'WITHDRAWN:  CERTIFICATE OF CORRECTION',
									uc_s = 'WDCO'	=> 'WITHDRAWN: COURT ORDER',
									uc_s = 'WDCW'	=> 'WITHDRAWN:  CERTIFICATE OF WITHDRAWAL',
									uc_s = 'XC'	  => 'CONVERSION',
									'**|'+uc_s
								 );
    end;

		//****************************************************************************
		//FilingDesc: returns the "event_filing_desc" and "stock_addl_info"
		//****************************************************************************
		export FilingDesc(String s) := function
			 uc_s := corp2.t2u(s);
			 return map(uc_s in ['2','02'] => 'IDENTIFICATION NUMBER CHANGES',
								  uc_s in ['3','03'] => 'NAME CHANGES',
								  uc_s in ['4','04'] => 'HISTORY TRUE NAME',
								  uc_s in ['5','05'] => 'CHANGE OF AGENT AND/OR OFFICE',
								  uc_s in ['9','09'] => 'ADDITIONAL STOCK AND SPECIAL NOTES RELATED TO CURRENT STOCK',
								  uc_s =  '14'       => 'MERGERS',
								  uc_s =  '23'       => 'STOCK HISTORY',
								  uc_s =  '27'       => 'CONSOLIDATION',
								  uc_s =  '41'       => 'CHANGE OF LIMITED PARTNERSHIP',
								  uc_s =  ''         => '',
									'**|'+uc_s
								 );
    end;

		//****************************************************************************
    //ForeignDomesticInd: returns the "corp_foreign_domestic_ind".
    //****************************************************************************
    export ForeignDomesticInd(String s) := function
			 uc_s := corp2.t2u(s);
			 return map(uc_s in ['DOMESTIC PROFIT CORPORATION','PARTNERSHIP ASSOCIATIONS LIMITED','DOMESTIC NONPROFIT CORPORATION','DOMESTIC PROFESSIONAL CORPORATION',
			                     'DOMESTIC PROFESSIONAL LIMITED LIABILITY COMPANY','DOMESTIC LIMITED PARTNERSHIP','DOMESTIC LIMITED LIABILITY COMPANY']                    => 'D',
								  uc_s in ['FOREIGN PROFIT CORPORATION','FOREIGN NONPROFIT CORPORATION','FOREIGN PROFESSIONAL CORPORATION','FOREIGN LIMITED LIABILITY COMPANY',
									         'FOREIGN PROFESSIONAL LIMITED LIABILITY COMPANY','FOREIGN TRUST','FOREIGN LIMITED PARTNERSHIP']                                           => 'F',
								  ''
								 );
	  end;
		
END;
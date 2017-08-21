IMPORT corp2, corp2_raw_nv;

EXPORT Functions := Module
		
		//********************************************************************
		//FormatNumericValues: Formats numerical values to include commas and
		//             					(optionally) a decimal point.
		//********************************************************************
		EXPORT FormatNumericValues(STRING pMoney,BOOLEAN pDecimalPoint = true) := FUNCTION

				dollar_sign_exist			:= if(stringlib.stringfind(pMoney,'$',1)<>0,true,false); 
				trim_money			  			:= corp2.t2u(stringlib.stringfilter(corp2.t2u(pMoney),'.0123456789'));		
				integerpart							:= (integer)trim_money;
				decimal_loc							:= stringlib.stringfind(trim_money,'.',1);
				fractional_portion			:= if(decimal_loc <> 0,trim_money[stringlib.stringfind(trim_money,'.',1)..],'.00');
				significantdigitexists 	:= if(corp2.t2u(stringlib.stringFilterOut(fractional_portion,'.0'))<>'',true,false); 
				fractional_part					:= if(significantdigitexists,fractional_portion,fractional_portion[1..3]);				
				integer_with_commas 		:= stringlib.stringreverse(regexreplace('([0-9]{3})(?=[0-9])',stringlib.stringreverse((STRING)(INTEGER) integerpart),'$1,'));
				reverse_fractional	 		:= (INTEGER)stringlib.stringreverse((STRING)fractional_portion);
				fractional_fixed				:= if(significantdigitexists,'.'+stringlib.stringreverse((STRING)reverse_fractional),fractional_part);
				fractional_format				:= if(length(fractional_fixed)=2,fractional_fixed+'0',fractional_fixed);
				RETURN if(dollar_sign_exist,'$','')+integer_with_commas + if(pDecimalPoint,fractional_format,'');
				
		END;

		//********************************************************************
		//CorpForeignDomesticInd: Returns "F"-Foreign or "D"-Domestic.
		//********************************************************************	
		EXPORT CorpForeignDomesticInd(STRING s) := FUNCTION
		
					 UC_s := corp2.t2u(s);
					 
					 RETURN  MAP(uc_s = 'DOM NON-PROFIT'				 	 									=> 'D',
											 uc_s = 'DOM NON-PROFIT COOP ASSOCIATION'						=> 'D',
											 uc_s = 'DOM NON-PROFIT COOP CORP'									=> 'D',
											 uc_s = 'DOM NON-PROFIT COOP CORP W/O STOCK'				=> 'D',
											 uc_s = 'DOMESTIC BUSINESS TRUST'										=> 'D',
											 uc_s = 'DOMESTIC CLOSE CORPORATION'								=> 'D',
											 uc_s = 'DOMESTIC CORPORATION'											=> 'D',
											 uc_s = 'DOMESTIC LIMITED PARTNERSHIP'							=> 'D',
											 uc_s = 'DOMESTIC LIMITED-LIABILITY COMPANY'				=> 'D',
											 uc_s = 'DOMESTIC LIMITED-LIABILITY PARTNERSHIP'		=> 'D',
											 uc_s = 'DOMESTIC LTD-LIAB LTD PARTNERSHIP'					=> 'D',									 
											 uc_s = 'DOMESTIC LTD-LIAB LTD PARTNERSHIP (ULPA)'	=> 'D',
											 uc_s = 'DOMESTIC LTD-LIABILITY LTD PARTNERSHIP'		=> 'D',
											 uc_s = 'DOMESTIC NON-PROFIT CORPORATION'						=> 'D',
											 uc_s = 'DOMESTIC NON-PROFIT CORPORATION SOLE'			=> 'D',
											 uc_s = 'DOMESTIC PROFESSIONAL ASSOCIATION'					=> 'D',
											 uc_s = 'DOMESTIC PROFESSIONAL CORPORATION'					=> 'D',
											 uc_s = 'FOREIGN BUSINESS TRUST'										=> 'F',
											 uc_s = 'FOREIGN CLOSE CORPORATION'									=> 'F',
											 uc_s = 'FOREIGN CORPORATION'												=> 'F',
											 uc_s = 'FOREIGN LIMITED PARTNERSHIP'								=> 'F',
											 uc_s = 'FOREIGN LIMITED PARTNERSHIP (ULPA)'				=> 'F',
											 uc_s = 'FOREIGN LIMITED-LIABILITY COMPANY'					=> 'F',
											 uc_s = 'FOREIGN LIMITED-LIABILITY PARTNERSHIP'			=> 'F',
											 uc_s = 'FOREIGN LTD-LIAB LTD PARTNERSHIP (ULPA)'		=> 'F',
											 uc_s = 'FOREIGN LTD-LIABILITY LTD PARTNERSHIP'			=> 'F',
											 uc_s = 'FOREIGN NON-PROFIT'				 	 							=> 'F',									 
											 uc_s = 'FOREIGN NON-PROFIT CORPORATION'						=> 'F',
											 uc_s = 'FOREIGN NON-PROFIT CORPORATION SOLE'				=> 'F',
											 uc_s = 'FOREIGN PROFESSIONAL ASSOCIATION'					=> 'F',
											 uc_s = 'FOREIGN PROFESSIONAL CORPORATION'					=> 'F',
											 ''	
											); 
		END;
		
		//****************************************************************************
		//State_Descriptions: returns the us state description.
		//****************************************************************************
		EXPORT State_Description(string s) := FUNCTION

					 uc_s := corp2.t2u(s);

	         RETURN map(uc_s = 'AA' => 'ARMED FORCES AMERICAS EXCEPT CANADA',
											uc_s = 'AE' => 'ARMED FORCES EUROPE, THE MIDDLE EAST AND CANADA',
											uc_s = 'AL' => 'ALABAMA',
											uc_s = 'AK' => 'ALASKA', 
											uc_s = 'AP' => 'ARMED FORCES PACIFIC',
											uc_s = 'AR' => 'ARKANSAS', 
											uc_s = 'AS' => 'AMERICAN SAMOA', 
											uc_s = 'AZ' => 'ARIZONA', 
											uc_s = 'CA' => 'CALIFORNIA', 
											uc_s = 'CO' => 'COLORADO', 
											uc_s = 'CT' => 'CONNECTICUT',
											uc_s = 'CZ' => 'CANAL ZONE',											
											uc_s = 'DC' => 'DISTRICT OF COLUMBIA', 
											uc_s = 'DE' => 'DELAWARE', 
											uc_s = 'FL' => 'FLORIDA', 
											uc_s = 'GA' => 'GEORGIA', 
											uc_s = 'GU' => 'GUAM', 
											uc_s = 'HI' => 'HAWAII', 
											uc_s = 'IA' => 'IOWA', 
											uc_s = 'ID' => 'IDAHO', 
											uc_s = 'IL' => 'ILLINOIS', 
											uc_s = 'IN' => 'INDIANA', 
											uc_s = 'KS' => 'KANSAS', 
											uc_s = 'KY' => 'KENTUCKY', 
											uc_s = 'LA' => 'LOUISIANA', 
											uc_s = 'MA' => 'MASSACHUSETTS', 
											uc_s = 'MD' => 'MARYLAND', 
											uc_s = 'ME' => 'MAINE' , 
											uc_s = 'MI' => 'MICHIGAN', 
											uc_s = 'MN' => 'MINNESOTA', 
											uc_s = 'MO' => 'MISSOURI', 
											uc_s = 'MS' => 'MISSISSIPPI', 
											uc_s = 'MT' => 'MONTANA', 
											uc_s = 'NC' => 'NORTH CAROLINA', 
											uc_s = 'ND' => 'NORTH DAKOTA', 
											uc_s = 'NE' => 'NEBRASKA', 
											uc_s = 'NH' => 'NEW HAMPSHIRE', 
											uc_s = 'NJ' => 'NEW JERSEY', 
											uc_s = 'NM' => 'NEW MEXICO', 
											uc_s = 'NV' => 'NEVADA', 
											uc_s = 'NY' => 'NEW YORK', 
											uc_s = 'OH' => 'OHIO', 
											uc_s = 'OK' => 'OKLAHOMA', 
											uc_s = 'OR' => 'OREGON', 
											uc_s = 'PA' => 'PENNSYLVANIA', 
											uc_s = 'PR' => 'PUERTO RICO', 
											uc_s = 'RI' => 'RHODE ISLAND', 
											uc_s = 'SC' => 'SOUTH CAROLINA', 
											uc_s = 'SD' => 'SOUTH DAKOTA', 
											uc_s = 'TN' => 'TENNESSEE', 
											uc_s = 'TX' => 'TEXAS', 
											uc_s = 'US' => 'UNITED STATES', 
											uc_s = 'UT' => 'UTAH', 
											uc_s = 'VA' => 'VIRGINIA', 
											uc_s = 'VI' => 'VIRGIN ISLANDS', 
											uc_s = 'VT' => 'VERMONT', 
											uc_s = 'WA' => 'WASHINGTON', 
											uc_s = 'WI' => 'WISCONSIN', 
											uc_s = 'WV' => 'WEST VIRGINIA', 
											uc_s = 'WY' => 'WYOMING',						
											uc_s = 'XX' => '',
											uc_s = ''   => '',
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//Country_Description: returns the country description.
		//****************************************************************************
		EXPORT Country_Description(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
	         RETURN CASE(uc_s,//2-character code countries
											 'AD'	 => 'ANDORRA',
											 'AF'  => 'AFGHANISTAN',
											 'AX'  => 'ALAND ISLANDS',											 
											 'AL'  => 'ALBANIA',
											 'DZ'  => 'ALGERIA',
											 'AI'  => 'ANGUILLA',
											 'AG'  => 'ANTIGUA AND BARBUDA',
											 'AM'  => 'ARMENIA',
											 'AO'  => 'ANGOLA',
											 'AQ'  => 'ANTARCTICA',
											 'AR'  => 'ARGENTINA',
											 'AW'	 => 'ARUBA',
											 'AT'  => 'AUSTRIA',
											 'AU'  => 'AUSTRALIA',
											 'AZ'  => 'AZERBAIJAN',
											 'BS'  => 'BAHAMAS',
											 'BH'	 => 'BAHRAIN',
											 'BD'  => 'BANGLADESH',
											 'BB'  => 'BARBADOS',
											 'BY'  => 'BELARUS',
											 'BE'  => 'BELGIUM',
											 'BZ'  => 'BELIZE',
											 'BJ'  => 'BENIN',
											 'BM'  => 'BERMUDA',
											 'BT'  => 'BHUTAN',
											 'BO'  => 'BOLIVIA',
											 'BA'  => 'BOSNIA AND HERZEGOVINA',
											 'BW'  => 'BOTSWANA',
											 'BV'  => 'BOUVET ISLAND',
											 'BR'  => 'BRAZIL',
											 'IO'  => 'BRITISH INDIAN OCEAN TERRITORY',
											 'BN'  => 'BRUNEI DARUSSALAM',
											 'BG'  => 'BULGARIA',
											 'BF'  => 'BURKINA FASO',
											 'BI'  => 'BURUNDI',
											 'KH'  => 'CAMBODIA',
											 'CM'  => 'CAMEROON',
											 'AB'  => 'CANADA', 		//Alberta											 
											 'BC'  => 'CANADA', 		//British Columbia
											 'CA'  => 'CANADA',
											 'NB'	 => 'CANADA',  		//New Bunswick
											 'NS'	 => 'CANADA',  		//Nova Scotia											 
											 'ON'  => 'CANADA',			//Ontario
											 'CV'  => 'CAPE VERDE',
											 'KY'  => 'CAYMAN ISLANDS',
											 'CF'  => 'CENTRAL AFRICAN REPUBLIC',
											 'TD'  => 'CHAD',
											 'CL'  => 'CHILE',
											 'CN'  => 'CHINA',
											 'CX'  => 'CHRISTMAS ISLAND',
											 'CC'  => 'COCOS (KEELING) ISLANDS',
											 'CO'  => 'COLOMBIA',
											 'KM'  => 'COMOROS',
											 'CD'  => 'CONGO, THE DEMOCRATIC REPUBLIC OF THE',
											 'CG'  => 'CONGO, REPUBLIC OF THE',
											 'CK'  => 'COOK ISLANDS',
											 'CR'  => 'COSTA RICA',
											 'CI'  => 'COTE D\'IVOIRE',
											 'HR'  => 'CROATIA',
											 'CU'  => 'CUBA',
											 'CY'  => 'CYPRUS',
											 'CZ'  => 'CZECH REPUBLIC',
											 'DK'  => 'DENMARK',
											 'DJ'  => 'DJIBOUTI',
											 'DM'  => 'DOMINICA',
											 'DO'  => 'DOMINICAN REPUBLIC',
											 'TP'  => 'EAST TIMOR',
											 'EC'  => 'ECUADOR',
											 'EG'  => 'EGYPT',
											 'SV'  => 'EL SALVADOR',
											 'GQ'  => 'EQUATORIAL GUINEA',
											 'ER'  => 'ERITREA',
											 'EE'  => 'ESTONIA',
											 'ET'  => 'ETHIOPIA',
											 'FK'  => 'FALKLAND ISLANDS (MALVINAS)',
											 'FO'  => 'FAROE ISLANDS',
											 'FJ'  => 'FIJI',
											 'FI'  => 'FINLAND',
											 'FR'  => 'FRANCE',
											 'GF'  => 'FRENCH GUIANA',
											 'PF'  => 'FRENCH POLYNESIA',
											 'TF'  => 'FRENCH SOUTHERN TERRITORIES',
											 'GA'  => 'GABON',
											 'GM'  => 'GAMBIA',
											 'GE'  => 'GEORGIA',
											 'DE'  => 'GERMANY',
											 'GH'  => 'GHANA',
											 'GI'  => 'GIBRALTAR',
											 'GR'  => 'GREECE',
											 'GL'  => 'GREENLAND',
											 'GD'  => 'GRENADA',
											 'GP'  => 'GUADELOUPE',
											 'GT'  => 'GUATEMALA',
											 'GN'  => 'GUINEA',
											 'GW'  => 'GUINEA-BISSAU',
											 'GY'  => 'GUYANA',
											 'HT'  => 'HAITI',
											 'HM'  => 'HEARD AND MCDONALD ISLANDS',
											 'HN'  => 'HONDURAS',
											 'HK'  => 'HONG KONG',
											 'HU'  => 'HUNGARY',
											 'IS'  => 'ICELAND',
											 'IN'  => 'INDIA',
											 'ID'  => 'INDONESIA',
											 'IR'  => 'IRAN, ISLAMIC REPUBLIC OF',
											 'IQ'  => 'IRAQ',
											 'IE'  => 'IRELAND, REPUBLIC OF',
											 'IL'  => 'ISRAEL',
											 'IT'  => 'ITALY',
											 'JM'  => 'JAMAICA',
											 'JP'  => 'JAPAN',
											 'JO'  => 'JORDAN',
											 'KZ'  => 'KAZAKHSTAN',
											 'KE'  => 'KENYA',
											 'KI'  => 'KIRIBATI',
											 'KP'  => 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF',
											 'KR'  => 'KOREA, REPUBLIC OF',
											 'KW'  => 'KUWAIT',
											 'KG'  => 'KYRGYZSTAN',
											 'LA'  => 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC',
											 'LV'  => 'LATVIA',
											 'LB'  => 'LEBANON',
											 'LS'  => 'LESOTHO',
											 'LR'  => 'LIBERIA',
											 'LY'  => 'LIBYAN ARAB JAMAHIRIYA',
											 'LI'  => 'LIECHTENSTEIN',
											 'LT'  => 'LITHUANIA',
											 'LU'  => 'LUXEMBOURG',
											 'MO'  => 'MACAU',
											 'MK'  => 'MACEDONIA, THE FORMER YOGOSLAV REPUBLIC OF',
											 'MG'  => 'MADAGASCAR',
											 'MW'  => 'MALAWI',
											 'MY'  => 'MALAYSIA',
											 'MV'  => 'MALDIVES',
											 'ML'  => 'MALI',
											 'MT'  => 'MALTA',
											 'MH'  => 'MARSHALL ISLANDS',
											 'MQ'  => 'MARTINIQUE',
											 'MR'  => 'MAURITANIA',
											 'MU'  => 'MAURITIUS',
											 'MX'  => 'MEXICO',
											 'FM'  => 'MICRONESIA, FEDERATED STATES OF',
											 'MD'  => 'MOLDOVA, REPUBLIC OF',
											 'MC'  => 'MONACO',
											 'MN'  => 'MONGOLIA',
											 'MS'  => 'MONTSERRAT',
											 'MA'  => 'MOROCCO',
											 'MZ'  => 'MOZAMBIQUE',
											 'MM'  => 'MYANMAR',
											 'NA'  => 'NAMIBIA',
											 'NR'  => 'NAURU',
											 'NP'  => 'NEPAL',
											 'NL'  => 'NETHERLANDS',
											 'AN'  => 'NETHERLANDS ANTILLES',
											 'NT'  => 'NEUTRAL ZONE',
											 'NC'  => 'NEW CALEDONIA',
											 'NZ'  => 'NEW ZEALAND',
											 'NI'  => 'NICARAGUA',
											 'NE'  => 'NIGER',
											 'NG'  => 'NIGERIA',
											 'NU'  => 'NIUE',
											 'NF'  => 'NORFOLK ISLAND',
											 'MP'  => 'NORTHERN MARIANA ISLANDS',
											 'NO'  => 'NORWAY',
											 'OM'  => 'OMAN',
											 'PK'  => 'PAKISTAN',
											 'PW'  => 'PALAU',
											 'PS'  => 'PALESTINIAN TERRITORY, OCCUPID',
											 'PA'  => 'PANAMA',
											 'PG'  => 'PAPUA NEW GUINEA',
											 'PY'  => 'PARAGUAY',
											 'PE'  => 'PERU',
											 'PH'  => 'PHILIPPINES',
											 'PN'  => 'PITCAIRN',
											 'PL'  => 'POLAND',
											 'PT'  => 'PORTUGAL',
											 'PR'  => 'PUERTO RICO',
											 'QA'  => 'QATAR',
											 'RE'  => 'REUNION',
											 'RO'  => 'ROMANIA',
											 'RU'  => 'RUSSIAN FEDERATION',
											 'RW'  => 'RWANDA',
											 'SH'  => 'SAINT HELENA',
											 'KN'  => 'SAINT KITTS AND NEVIS',
											 'LC'  => 'SAINT LUCIA',
											 'PM'  => 'SAINT PIERRE AND MIQUELON',
											 'VC'  => 'SAINT VINCENT AND THE GRENADINES',
											 'WS'  => 'SAMOA',
											 'SM'  => 'SAN MARINO',
											 'ST'  => 'SAO TOME AND PRINCIPE',
											 'SA'  => 'SAUDI ARABIA',
											 'SN'  => 'SENEGAL',
											 'CS'  => 'SERBIA AND MONTENEGRO',
											 'SC'  => 'SEYCHELLES',
											 'SL'  => 'SIERRA LEONE',
											 'SG'  => 'SINGAPORE',
											 'SK'  => 'SLOVAKIA',
											 'SI'  => 'SLOVENIA',
											 'SB'  => 'SOLOMON ISLANDS',
											 'SO'  => 'SOMALIA',
											 'ZA'  => 'SOUTH AFRICA',
											 'GS'  => 'SOURTH GEORGIA AND THE SOUTH SANDWICH ISLANDS',
											 'ES'  => 'SPAIN',
											 'LK'  => 'SRI LANKA',
											 'SD'  => 'SUDAN',
											 'SR'  => 'SURINAME',
											 'SJ'  => 'SVALBARD AND JAN MAYEN ISLANDS',
											 'SZ'  => 'SWAZILAND',
											 'SE'  => 'SWEDEN',
											 'CH'  => 'SWITZERLAND',
											 'SY'  => 'SYRIAN ARAB REPUBLIC',
											 'TW'  => 'TAIWAN (REPUBLIC OF CHINA)',
											 'TJ'  => 'TAJIKISTAN',
											 'TZ'  => 'TANZANIA, UNITED REPUBLIC OF',
											 'TH'  => 'THAILAND',
											 'TL'  => 'TIMOR-LESTE',
											 'TG'  => 'TOGO',
											 'TK'  => 'TOKELAU',
											 'TO'  => 'TONGA',
											 'TT'  => 'TRINIDAD AND TOBAGO',
											 'TN'  => 'TUNISIA',
											 'TR'  => 'TURKEY',
											 'TM'  => 'TURKMENISTAN',
											 'TC'  => 'TURKS AND CAICOS ISLANDS',
											 'TV'  => 'TUVALU',
											 'UG'  => 'UGANDA',
											 'UA'  => 'UKRAINE',
											 'AE'  => 'UNITED ARAB EMIRATES',
											 'GB'  => 'UNITED KINGDOM',
											 'US'  => 'UNITED STATES',
											 'UM'  => 'UNITED STATES MINOR OUTLYING ISLANDS',
											 'UY'  => 'URUGUAY',
											 'SU'  => 'USSR',
											 'UZ'  => 'UZBEKISTAN',
											 'VU'  => 'VANUATU',
											 'VA'  => 'VATICAN CITY STATE (HOLY SEE)',
											 'VE'  => 'VENEZUELA',
											 'VN'  => 'VIET NAM',
											 'VG'  => 'VIRGIN ISLANDS, BRITISH',   
											 'VI'  => 'VIRGIN ISLANDS, U.S.',  											 
											 'WF'  => 'WALLIS AND FUTUNA ISLANDS',
											 'EH'  => 'WESTERN SAHARA',
											 'YE'  => 'YEMEN',
											 'YU'  => 'YUGOSLAVIA',
											 'ZM'  => 'ZAMBIA',
											 'ZW'  => 'ZIMBABWE',
											 'XX'  => '',
											 //3-character code countries
											 'ABW' => 'ARUBA',
											 'AFG' => 'AFGHANISTAN',
											 'AGO' => 'ANGOLA',     
											 'AIA' => 'ANGUILLA',   
											 'ALA' => 'ALAND ISLANDS',             
											 'ALB' => 'ALBANIA',    
											 'AND' => 'ANDORRA',    
											 'ANT' => 'NETHERLANDS ANTILLES',      
											 'ARE' => 'UNITED ARAB EMIRATES',      
											 'ARG' => 'ARGENTINA',  
											 'ARM' => 'ARMENIA',    
											 'ASM' => 'AMERICAN SAMOA',            
											 'ATA' => 'ANTARCTICA', 
											 'ATF' => 'FRENCH SOUTHERN TERRITORIES', 
											 'ATG' => 'ANTIGUA AND BARBUDA',       
											 'AUS' => 'AUSTRALIA',  
											 'AUT' => 'AUSTRIA',    
											 'AZE' => 'AZERBAIJAN', 
											 'BDI' => 'BURUNDI',    
											 'BEL' => 'BELGIUM',    
											 'BEN' => 'BENIN',
											 'BFA' => 'BURKINA FASO',              
											 'BGD' => 'BANGLADESH', 
											 'BGR' => 'BULGARIA',   
											 'BHR' => 'BAHRAIN',    
											 'BHS' => 'BAHAMAS',    
											 'BIH' => 'BOSNIA AND HERZEGOVINA',    
											 'BLR' => 'BELARUS',    
											 'BLZ' => 'BELIZE',     
											 'BMU' => 'BERMUDA',    
											 'BOL' => 'BOLIVIA',    
											 'BRA' => 'BRAZIL',     
											 'BRB' => 'BARBADOS',   
											 'BRN' => 'BRUNEI DARUSSALAM',         
											 'BTN' => 'BHUTAN',     
											 'BVT' => 'BOUVET ISLAND',             
											 'BWA' => 'BOTSWANA',   
											 'CAF' => 'CENTRAL AFRICAN REPUBLIC',
											 'BRC' => 'CANADA',  //British Columbia
											 'CAN' => 'CANADA',
											 'CCK' => 'COCOS (KEELING) ISLANDS',   
											 'CHE' => 'SWITZERLAND',
											 'CHL' => 'CHILE',
											 'CHN' => 'CHINA, MAINLAND',           
											 'CIV' => 'COTE D\'IVOIRE',             
											 'CMR' => 'CAMEROON',   
											 'COD' => 'CONGO, THE DEMOCRATIC REPUBLIC OF THE',
											 'COG' => 'CONGO, REPUBLIC OF THE',
											 'COK' => 'COOK ISLANDS',
											 'COL' => 'COLOMBIA',
											 'COM' => 'COMOROS',
											 'CPV' => 'CAPE VERDE',
											 'CRI' => 'COSTA RICA',
											 'CUB' => 'CUBA',
											 'CXR' => 'CHRISTMAS ISLAND',
											 'CYM' => 'CAYMAN ISLANDS',
											 'CYP' => 'CYPRUS',
											 'CZE' => 'CZECH REPUBLIC',
											 'DEU' => 'GERMANY',
											 'DJI' => 'DJIBOUTI',
											 'DMA' => 'DOMINICA',
											 'DNK' => 'DENMARK',
											 'DOM' => 'DOMINICAN REPUBLIC',
											 'DZA' => 'ALGERIA',
											 'ECU' => 'ECUADOR',
											 'EGY' => 'EGYPT',
											 'ENG' => 'ENGLAND',
											 'ERI' => 'ERITREA',
											 'ESH' => 'WESTERN SAHARA',
											 'ESP' => 'SPAIN',
											 'EST' => 'ESTONIA',
											 'ETH' => 'ETHIOPIA',
											 'FIN' => 'FINLAND',
											 'FJI' => 'FIJI',
											 'FLK' => 'FALKLAND ISLANDS',
											 'FRA' => 'FRANCE',
											 'FRO' => 'FAROE ISLANDS',
											 'FSM' => 'MICRONESIA, FEDERATED STATES OF',
											 'GAB' => 'GABON',
											 'GBR' => 'UNITED KINGDOM',
											 'GEO' => 'GEORGIA',
											 'GHA' => 'GHANA',
											 'GIB' => 'GIBRALTAR',
											 'GIN' => 'GUINEA',
											 'GLP' => 'GUADELOUPE',
											 'GMB' => 'GAMBIA',
											 'GNB' => 'GUINEA-BISSAU',
											 'GNQ' => 'EQUATORIAL GUINEA',
											 'GRB' => 'GREAT BRITIAN',
											 'GRC' => 'GREECE',
											 'GRD' => 'GRENADA',
											 'GRL' => 'GREENLAND',
											 'GTM' => 'GUATEMALA',
											 'GUF' => 'FRENCH GUIANA',
											 'GUM' => 'GUAM',
											 'GUY' => 'GUYANA',
											 'HKG' => 'HONG KONG',
											 'HMD' => 'HEARD ISLAND AND MCDONALD ISLANDS',
											 'HND' => 'HONDURAS',
											 'HRV' => 'CROATIA',
											 'HTI' => 'HAITI',
											 'HUN' => 'HUNGARY',
											 'IDN' => 'INDONESIA',
											 'IND' => 'INDIA',
											 'IOT' => 'BRITISH INDIAN OCEAN TERRITORY',
											 'IRL' => 'IRELAND, REPUBLIC OF',
											 'IRN' => 'IRAN, ISLAMIC REPUBLIC OF',
											 'IRQ' => 'IRAQ',
											 'ISL' => 'ICELAND',
											 'ISR' => 'ISRAEL',
											 'ITA' => 'ITALY',
											 'JAM' => 'JAMAICA',
											 'JOR' => 'JORDAN',
											 'JPN' => 'JAPAN',
											 'KAZ' => 'KAZAKHSTAN', 
											 'KEN' => 'KENYA',
											 'KGZ' => 'KYRGYZSTAN',
											 'KHM' => 'CAMBODIA',
											 'KIR' => 'KIRIBATI',
											 'KNA' => 'SAINT KITTS AND NEVIS',
											 'KOR' => 'KOREA, REPUBLIC OF',
											 'KWT' => 'KUWAIT',
											 'LAO' => 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC',
											 'LBN' => 'LEBANON',
											 'LBR' => 'LIBERIA',
											 'LBY' => 'LIBYAN ARAB JAMAHIRIYA',
											 'LCA' => 'SAINT LUCIA',
											 'LIE' => 'LIECHTENSTEIN',
											 'LKA' => 'SRI LANKA',
											 'LSO' => 'LESOTHO',
											 'LTU' => 'LITHUANIA',
											 'LUX' => 'LUXEMBOURG',
											 'LVA' => 'LATVIA',
											 'MAC' => 'MACAO',
											 'MAR' => 'MOROCCO',
											 'MCO' => 'MONACO',
											 'MDA' => 'MOLDOVA, REPUBLIC OF',
											 'MDG' => 'MADAGASCAR',
											 'MDV' => 'MALDIVES',
											 'MEX' => 'MEXICO',
											 'MHL' => 'MARSHALL ISLANDS',
											 'MKD' => 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF',  
											 'MLI' => 'MALI',
											 'MLT' => 'MALTA',
											 'MMR' => 'MYANMAR',
											 'MNG' => 'MONGOLIA',
											 'MNP' => 'NORTHERN MARIANA ISLANDS',  
											 'MOZ' => 'MOZAMBIQUE', 
											 'MRT' => 'MAURITANIA', 
											 'MSR' => 'MONTSERRAT', 
											 'MTQ' => 'MARTINIQUE', 
											 'MUS' => 'MAURITIUS',  
											 'MWI' => 'MALAWI',
											 'MYS' => 'MALAYSIA',
											 'MYT' => 'MAYOTTE',
											 'NAM' => 'NAMIBIA',
											 'NCL' => 'NEW CALEDONIA',
											 'NER' => 'NIGER',
											 'NFK' => 'NORFOLK ISLAND',
											 'NGA' => 'NIGERIA',
											 'NIC' => 'NICARAGUA',  
											 'NIU' => 'NIUE', 
											 'NLD' => 'NETHERLANDS',
											 'NOR' => 'NORWAY',
											 'NPL' => 'NEPAL',
											 'NRU' => 'NAURU',
											 'NZL' => 'NEW ZEALAND',
											 'OMN' => 'OMAN', 
											 'PAK' => 'PAKISTAN',
											 'PAN' => 'PANAMA',
											 'PCN' => 'PITCAIRN',
											 'PER' => 'PERU', 
											 'PHL' => 'PHILIPPINES',
											 'PLW' => 'PALAU',
											 'PNG' => 'PAPUA NEW GUINEA',
											 'POL' => 'POLAND',
											 'PRI' => 'PUERTO RICO',
											 'PRK' => 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF',
											 'PRT' => 'PORTUGAL',   
											 'PRY' => 'PARAGUAY',   
											 'PSE' => 'PALESTINIAN TERRITORY, OCCUPIED',      
											 'PYF' => 'FRENCH POLYNESIA',          
											 'QAT' => 'QATAR',
											 'REU' => 'REUNION',
											 'ROM' => 'ROMANIA',											 
											 'ROU' => 'ROMANIA',
											 'RUS' => 'RUSSIAN FEDERATION',        
											 'RWA' => 'RWANDA',     
											 'SAU' => 'SAUDI ARABIA',              
											 'SCG' => 'SERBIA AND MONTENEGRO',     
											 'SDN' => 'SUDAN',
											 'SEN' => 'SENEGAL',    
											 'SGP' => 'SINGAPORE',  
											 'SGS' => 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS',
											 'SHN' => 'SAINT HELENA',              
											 'SJM' => 'SVALBARD AND JAN MAYEN',    
											 'SLB' => 'SOLOMON ISLANDS',           
											 'SLE' => 'SIERRA LEONE',              
											 'SLV' => 'EL SALVADOR',
											 'SMR' => 'SAN MARINO', 
											 'SOM' => 'SOMALIA',    
											 'SPM' => 'SAINT PIERRE AND MIQUELON', 
											 'STP' => 'SAO TOME AND PRINCIPE',     
											 'SUR' => 'SURINAME',   
											 'SVK' => 'SLOVAKIA',   
											 'SVN' => 'SLOVENIA',   
											 'SWE' => 'SWEDEN',     
											 'SWZ' => 'SWAZILAND',  
											 'SYC' => 'SEYCHELLES', 
											 'SYR' => 'SYRIAN ARAB REPUBLIC',      
											 'TCA' => 'TURKS AND CAICOS ISLANDS',  
											 'TCD' => 'CHAD', 
											 'TGO' => 'TOGO', 
											 'THA' => 'THAILAND',   
											 'TJK' => 'TAJIKISTAN', 
											 'TKL' => 'TOKELAU',    
											 'TKM' => 'TURKMENISTAN',              
											 'TLS' => 'TIMOR-LESTE',
											 'TON' => 'TONGA',
											 'TTO' => 'TRINIDAD AND TOBAGO',       
											 'TUN' => 'TUNISIA',
											 'TUR' => 'TURKEY',
											 'TUV' => 'TUVALU',
											 'TWN' => 'TAIWAN (REPUBLIC OF CHINA)',
											 'TZA' => 'TANZANIA, UNITED REPUBLIC OF',
											 'UGA' => 'UGANDA',
											 'UKR' => 'UKRAINE',
											 'UMI' => 'UNITED STATES MINOR OUTLYING ISLANDS', 
											 'URY' => 'URUGUAY',
											 'USA' => 'UNITED STATES',
											 'UZB' => 'UZBEKISTAN',
											 'VAT' => 'VATICAN CITY STATE',
											 'VCT' => 'SAINT VINCENT AND THE GRENADINES',
											 'VEN' => 'VENEZUELA',  
											 'VGB' => 'VIRGIN ISLANDS, BRITISH',   
											 'VIR' => 'VIRGIN ISLANDS, U.S.',      
											 'VNM' => 'VIET NAM',
											 'VUT' => 'VANUATU',
											 'WLF' => 'WALLIS AND FUTUNA',
											 'WSM' => 'SAMOA',
											 'YEM' => 'YEMEN',
											 'ZAF' => 'SOUTH AFRICA',              
											 'ZMB' => 'ZAMBIA',     
											 'ZWE' => 'ZIMBABWE',
											 ''   => '',
											 '**|'+uc_s
							 );
		END;

		//********************************************************************
		//CorpForgnStateCD: Returns "corp_forgn_state_cd".
		//********************************************************************	
		EXPORT CorpForgnStateCD(STRING s) := FUNCTION

					 uc_s  := corp2.t2u(s);

					 is2inLTH := IF(LENGTH(uc_s)=2,true,false);
					 
					 RETURN  IF(is2inLTH,
											MAP(State_Description(uc_s) 	<>'**' => uc_s,
													Country_Description(uc_s)	<>'**' => uc_s,
													'**|'+uc_s
												 ),
											''
										 );

		END;
		
		//********************************************************************
		//CorpForgnStateDesc: Returns "corp_forgn_state_desc".
		//********************************************************************	
		EXPORT CorpForgnStateDesc(STRING s) := FUNCTION

					 uc_s  := corp2.t2u(s);
					 
					 RETURN  MAP(State_Description(uc_s)[1..2] 		<>'**' => State_Description(uc_s),
											 Country_Description(uc_s)[1..2]	<>'**' => Country_Description(uc_s),
											 '**|'+uc_s
										  );
		END;

		//********************************************************************
		//CorpLegalName: This function is to be used for Nevada's foreign
		//									 names only.  Most of the foreign company names
		//									 are bad.  E.g. SAME, NAME SAME, IS THE SAME, etc.
		//									 This routine blanks out the company name if 
		//									 an "invalid word(s)" is encountered.  The 
		//									 "validpatterns" tries to override any valid 
		//									 business name that may contain "SAME", etc.
		//Note:  TRANS in validpatterns allows for
		//			 1)"TRANSPORTATION"
		//			 2)"TRANSAMERICA".
		//********************************************************************
		EXPORT CorpLegalName(STRING s) := FUNCTION 
			 uc_s						:= corp2.t2u(s);
			 ValidPatterns	:= '^SAME DAY SERVICE|TRANS';
			 PatternUnknown	:= '^(NAME SAME AS ABOVE|NAME SAME AS|NAME SAME|IS SAME|IS THE SAME|SAME AS|SAME)';
			 RETURN MAP(
									REGEXFIND(ValidPatterns, uc_s,0) <> '' => uc_s,
									REGEXFIND(PatternUnknown,uc_s,0) <> '' => '',
									uc_s
								 );
		END;

		//********************************************************************
		//CorpLNNameTypeCD: Returns the "corp_ln_name_type_cd".
		//********************************************************************	
		EXPORT CorpLNNameTypeCD(STRING s) := FUNCTION
		
					 uc_s := corp2.t2u(s);
					 
					 RETURN  MAP(uc_s = 'TRADE MARK'				 	 							 		 	 		=> '03',
											 uc_s = 'TRADE NAME'				 	 							 		 	 		=> '04',
											 uc_s = 'SERVICE MARK'				 	 							 	 	 		=> '05',
											 uc_s = 'RESERVED NAME'				 	 							 	 			=> '07',
											 '01'
											); 
											
		END;

		//********************************************************************
		//CorpLNNameTypeDesc: Returns the "corp_ln_name_type_desc".
		//********************************************************************	
		EXPORT CorpLNNameTypeDesc(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN  MAP(uc_s = 'TRADE MARK'				 	 							 		 	 		=> 'TRADEMARK',
											 uc_s = 'TRADE NAME'				 	 							 		 	 		=> 'TRADENAME',
											 uc_s = 'SERVICE MARK'				 	 							 	 	 		=> 'SERVICEMARK',
											 uc_s = 'RESERVED NAME'				 	 							 	 			=> 'RESERVED',
											 'LEGAL'
											); 									
		END;

		//********************************************************************
		//CorpOrigOrgStructureDesc: Returns "corp_orig_org_structure_desc".
		//********************************************************************	
		EXPORT CorpOrigOrgStructureDesc(STRING code) := FUNCTION
					 uc_s := corp2.t2u(code);
					 isValidCode :=  MAP(uc_s = 'DOM NON-PROFIT'				 	 									=> TRUE,
															 uc_s = 'DOM NON-PROFIT COOP ASSOCIATION'						=> TRUE,
															 uc_s = 'DOM NON-PROFIT COOP CORP'									=> TRUE,
															 uc_s = 'DOM NON-PROFIT COOP CORP W/O STOCK'				=> TRUE,
															 uc_s = 'DOMESTIC BUSINESS TRUST'										=> TRUE,
															 uc_s = 'DOMESTIC CLOSE CORPORATION'								=> TRUE,
															 uc_s = 'DOMESTIC CORPORATION'											=> TRUE,
															 uc_s = 'DOMESTIC LIMITED PARTNERSHIP'							=> TRUE,
															 uc_s = 'DOMESTIC LIMITED-LIABILITY COMPANY'				=> TRUE,
															 uc_s = 'DOMESTIC LIMITED-LIABILITY PARTNERSHIP'		=> TRUE,
															 uc_s = 'DOMESTIC LTD-LIAB LTD PARTNERSHIP'					=> TRUE,									 
															 uc_s = 'DOMESTIC LTD-LIAB LTD PARTNERSHIP (ULPA)'	=> TRUE,
															 uc_s = 'DOMESTIC LTD-LIABILITY LTD PARTNERSHIP'		=> TRUE,
															 uc_s = 'DOMESTIC NON-PROFIT CORPORATION'						=> TRUE,
															 uc_s = 'DOMESTIC NON-PROFIT CORPORATION SOLE'			=> TRUE,
															 uc_s = 'DOMESTIC PROFESSIONAL ASSOCIATION'					=> TRUE,
															 uc_s = 'DOMESTIC PROFESSIONAL CORPORATION'					=> TRUE,
															 uc_s = 'FOREIGN BUSINESS TRUST'										=> TRUE,
															 uc_s = 'FOREIGN CLOSE CORPORATION'									=> TRUE,
															 uc_s = 'FOREIGN CORPORATION'												=> TRUE,
															 uc_s = 'FOREIGN LIMITED PARTNERSHIP'								=> TRUE,
															 uc_s = 'FOREIGN LIMITED PARTNERSHIP (ULPA)'				=> TRUE,
															 uc_s = 'FOREIGN LIMITED-LIABILITY COMPANY'					=> TRUE,
															 uc_s = 'FOREIGN LIMITED-LIABILITY PARTNERSHIP'			=> TRUE,
															 uc_s = 'FOREIGN LTD-LIAB LTD PARTNERSHIP (ULPA)'		=> TRUE,
															 uc_s = 'FOREIGN LTD-LIABILITY LTD PARTNERSHIP'			=> TRUE,
															 uc_s = 'FOREIGN NON-PROFIT'				 	 							=> TRUE,									 
															 uc_s = 'FOREIGN NON-PROFIT CORPORATION'						=> TRUE,
															 uc_s = 'FOREIGN NON-PROFIT CORPORATION SOLE'				=> TRUE,
															 uc_s = 'FOREIGN PROFESSIONAL ASSOCIATION'					=> TRUE,
															 uc_s = 'FOREIGN PROFESSIONAL CORPORATION'					=> TRUE,
															 FALSE
															); 

					 RETURN  if(isValidCode,uc_s,'');
		END;
		
		//********************************************************************
		//CorpCountryOfFormation: Returns "corp_country_of_formation".
		//********************************************************************	
		EXPORT CorpCountryOfFormation(STRING s) := FUNCTION

					 uc_s  := corp2.t2u(s);
					 
					 RETURN  MAP(State_Description(uc_s)[1..2] 	  <>'**' => 'US',
											 Country_Description(uc_s)[1..2]	<>'**' => Country_Description(uc_s),
											 '**|'+uc_s
										  );
		END;

		//********************************************************************
		//CorpTrademarkClassDesc1: Returns "corp_trademark_class_desc1".
		//********************************************************************	
		EXPORT CorpTrademarkClassDesc1(STRING s) := FUNCTION

					 int_s := (integer)s;
					 
	         RETURN MAP(int_s = 0   => '', //Per CI
										  int_s = 1   => 'RAW OR PARTLY PREPARED MATERIALS',
										  int_s = 2   => 'RECEPTACLES',
										  int_s = 3   => 'BAGGAGE, ANIMAL EQUIPMENT, PORTFOLIOS, AND POCKETBOOKS',
										  int_s = 4   => 'ABRASIVES AND POLISHING MATERIALS',
										  int_s = 5   => 'ADHESIVES',
										  int_s = 6   => 'CHEMICALS AND CHEMICAL COMPOSITIONS',
										  int_s = 7   => 'CORDAGE',
										  int_s = 8   => 'SMOKERS ARTICLES, NOT INCL. TOBACCO PRODUCTS',
										  int_s = 9   => 'EXPLOSIVES, FIREARMS, EQUIPMENTS, AND PROJECTILES',
										  int_s = 10  => 'FERTILIZERS',
										  int_s = 11  => 'INKS AND INKING MATERIALS',
										  int_s = 12  => 'CONSTRUCTION MATERIALS',
										  int_s = 13  => 'HARDWARE AND PLUMBING AND STEAM-FITTING SUPPLIES',
										  int_s = 14  => 'METALS AND METAL CASTINGS AND FORGINGS',
										  int_s = 15  => 'OILS AND GREASES',
										  int_s = 16  => 'PAINTS AND PAINTERS MATERIALS',
										  int_s = 17  => 'TOBACCO PRODUCTS',
										  int_s = 18  => 'MEDICINES AND PHARMACEUTICAL PREPARATIONS',
										  int_s = 19  => 'VEHICLES',
										  int_s = 20  => 'LINOLEUM AND OILED CLOTH',
										  int_s = 21  => 'ELECTRICAL APPARATUS, MACHINES, AND SUPPLIES',
										  int_s = 22  => 'GAMES, TOYS AND SPORTING GOODS',
										  int_s = 23  => 'CUTLERY, MACHINERY, AND TOOLS AND PARTS THEREOF',
										  int_s = 24  => 'LAUNDRY APPLIANCE AND MACHINES',
										  int_s = 25  => 'LOCKS AND SAFES',
										  int_s = 26  => 'MEASURING AND SCIENTIFIC APPLIANCES',
										  int_s = 27  => 'HOROLOGICAL INSTRUMENTS',
										  int_s = 28  => 'JEWELRY AND PRECIOUS-METAL WARE',
										  int_s = 29  => 'BROOMS, BRUSHES, AND DUSTERS',
										  int_s = 30  => 'CROCKERY, EARTHENWARE, AND PORCELAIN',
										  int_s = 31  => 'FILTERS AND REFRIGERATORS',
										  int_s = 32  => 'FURNITURE AND UPHOLSTERY',
										  int_s = 33  => 'GLASSWARE',
										  int_s = 34  => 'HEATING, LIGHTING, AND VENTILATING APPARATUS',
										  int_s = 35  => 'BELTING, HOSE, MACHINERY PACKING AND NON-METALLIC TIERS',
										  int_s = 36  => 'MUSICAL INSTRUMENTS AND SUPPLIES',
										  int_s = 37  => 'PAPER AND STATIONERY',
										  int_s = 38  => 'PRINTS AND PUBLICATIONS',
										  int_s = 39  => 'CLOTHING',
										  int_s = 40  => 'FANCY GOODS, FURNISHINGS, AND NOTIONS',
										  int_s = 41  => 'CANES, PARASOLS, AND UMBRELLAS',
										  int_s = 42  => 'KNITTED, NETTED AND TEXTILE FABRICS, AND SUBSTITUTES THEREFOR',
										  int_s = 43  => 'THREAD AND YARN',
										  int_s = 44  => 'DENTAL, MEDICAL, AND SURGICAL APPLIANCES',
										  int_s = 45  => 'SOFT DRINKS AND CARBONATED WATERS',
										  int_s = 46  => 'FOODS AND INGREDIENTS OF FOODS',
										  int_s = 47  => 'WINES',
										  int_s = 48  => 'MALT BEVERAGES AND LIQUORS',
										  int_s = 49  => 'DISTILLED ALCOHOLIC LIQUORS',
										  int_s = 50  => 'MERCHANDISE NOT OTHERWISE CLASSIFIED',
										  int_s = 51  => 'COSMETICS AND TOILET PREPARATIONS',
										  int_s = 52  => 'DETERGENTS AND SOAPS',
										  int_s = 100 => 'MISCELLANEOUS',
										  int_s = 101 => 'ADVERTISING AND BUSINESS',
										  int_s = 102 => 'FINANCIAL AND INSURANCE',
										  int_s = 103 => 'CONSTRUCTION AND REPAIR',
										  int_s = 104 => 'COMMUNICATIONS',
										  int_s = 105 => 'TRANSPORTATION AND STORAGE',
										  int_s = 106 => 'MATERIAL TREATMENT',
										  int_s = 107 => 'EDUCATION AND ENTERTAINMENT',
										  int_s in [108,110,117,120,180,181] => '', //Per CI.  These are subcodes with no descriptions
											int_s in [220,221,260,281] 				 => '', //Per CI.  These are subcodes with no descriptions
											int_s in [321,381,390] 						 => '', //Per CI.  These are subcodes with no descriptions
											int_s in [420,460,461,472,478,480] => '', //Per CI.  These are subcodes with no descriptions
											int_s in [500] 										 => '', //Per CI.  These are subcodes with no descriptions
											int_s in [999] 										 => '', //Per CI.  These are subcodes with no descriptions
											'**|'+corp2.t2u(s)
										 );
		END;
		
END;
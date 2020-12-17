IMPORT corp2, STD, corp2_mapping;

EXPORT Functions := Module

	//********************************************************************
	//GetTaxPrgDesc: Returns "CORP_TAX_PROGRAM_DESC".
	//********************************************************************		
	EXPORT GetTaxPrgDesc(string code)	:=function

		u_cd:=corp2.t2u(code);

		RETURN case(u_cd,
								'0'  =>'', //don't have decription
								'1'  =>'STOCK CORPORATION', 
								'2'  =>'NON-STOCK CORPORATION',
								'3'  =>'COOP-AG',
								'4'  =>'COOP-MKTGEN',
								'5'  =>'ELECTRIC COOPERATIVE',
								'6'  =>'COOP-TEL',
								'7'  =>'LLC',
								'8'  =>'LLP',
								'9'  =>'OLD LLP',
								'10' =>'BANKS',
								'11' =>'AUTHORIZED CAPITAL STOCK',
								'12' =>'LEGAL RESERVE MUTUAL',
								'16' =>'LIMITED PARTNERSHIP',
								'170'=>'NON-PROFIT CORPORATION',
								''   =>'',
								'**|'+u_cd);
			
	END;

	//********************************************************************
	//StateCode: validates vendor codes and Returns '**' if we receive invalid or new codes from vendor 
	//********************************************************************	
	EXPORT StateCode(string code):= FUNCTION
		  st  := stringlib.stringfilter(corp2.t2u(code),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');

		  Ignore_list       :=['AMST','BRID','CACA','CENT','CEN','DHAK','DUB','F','GRAN','HARY','HM 1','LON','MAHA','MAND',
													 'MANI','MAUR','MINA','MUMB','NDE','NORT','NT','OKI','PEI','PUNJ','REPU',
													 'SAN','TAGU','UAE','UTTA','XX','X','F',''];//per CI , Entries are in this are just typos & ignore all.
													
		  Valid_list       :=['AB','AK','AL','AR','AS','AZ','BA','BC','CA','CB','CI','CO','CR','CT','DC','DE','DU','DO',
												  'FL','FM','GA','GE','GU','HI','IA','ID','IL','IN','IO','KS','KY','KN','LA','LI','LO','LV','LS','LT',
												  'MA','MB','MD','ME','MH','MI','MN','MY','MO','MP','MS','MT','NB','NC','ND','NE','NF','NH','NJ',
												  'NM','NV','NY','NZ','OH','OK','ON','OR','OS','PA','PF','PR','PW','QC','RI','SC','SD',
												  'SK','SO','SU','SW','TN','TO','TX','TW','UT','US','VA','VI','VT','WA','WI','WV','WY'];
												 
												 //3 digit codes from vendor
		  Tdigit_list       :=['ARG','AUS','BEL','BMU','CAN','CYM','CHN','COK','CRI','DEL','VIR','ANT','SWE','GBR','PHL',
													 'MEX','IND','DEU','JPN','CAN','GBR','IRE','VEN','SWI','SGP','MEX','ENG','NEW','FRA','JAP','NOR',
													 'GER','NLD','NZL','PRI','PHL'];	
												 
			RETURN map( st in Ignore_List =>'',												
									st in Valid_list	=> corp2.t2u(code),
									st in Tdigit_list	=> corp2.t2u(code),
								  //per CI We are receiving 3 & 4 digit codes from vendor & correcting some of vendor codes								 
									st in['UNIT','UNI','UNITED STATES','US','USA']=>'US',
									st ='AFGH'=>'AFG',
									st ='ALBE'=>'ALB',
									st ='ANTI'=>'ANT',
									st ='BRIT'=>'BRT',
									st ='BELG'=>'BEL',
									st ='CAN' =>'CAN',
									st ='CAND'=>'CAN',
									st ='CANA'=>'CAN',
									st ='CAYM'=>'CYM',
									st ='CALG'=>'CAN',
									st in['CHE','SWIT']	=>'SWI',
									st ='DELA'=>'DE',								
									st ='DENM'=>'DNK',
									st ='ENGL'=>'ENG',
									st ='DENM'=>'DEN',
									st ='GUAM'=>'GU',
									st ='GUAN'=>'GU',
									st ='ISLA'=>'IS',
									st ='INDI'=>'IND',
									st ='ISRA'=>'ISR',
									st ='JAPA'=>'JA',
									st ='KENY'=>'KEN',
									st ='LUXE'=>'LUX',
									st ='MEXI'=>'MEX',
									st ='MISS'=>'MI',
									st ='NEVA'=>'NV',
									st ='NOVA'=>'NS',
									st ='OHIO'=>'OH',
									st ='ONTA'=>'ON',
									st ='PANA'=>'PAN',
									st ='PHIL'=>'PHL',
									st ='QUEB'=>'QC',
									st ='SING'=>'SGP',
									st ='SCOT'=>'SCO',
									st ='TAIP'=>'TW',
									st ='TEXA'=>'TX',
									st ='TURK'=>'TUR',
									st ='UTAH'=>'UT',
									st ='VIRG'=>'VA',
									st ='WEST'=>'WV',
									st ='WAS'	=>'DC',
									st ='' 		=>'',
									'**|'+corp2.t2u(code)   //scrubing only* StateDesc values
								 ); 
   END;
	 
	//********************************************************************
	//StateDesc: Returns full name 
	//********************************************************************
	EXPORT StateDesc(STRING state) := FUNCTION
		st  := stringlib.stringfilter(corp2.t2u(state),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		RETURN map (st ='AB'	=>'ALBERTA',
								st ='AFG'	=>'AFGHANISTAN',
								st ='AK'	=>'ALASKA',
								st ='AL'	=>'ALABAMA',
								st ='ALB'	=>'ALBANIA',
								st ='ANT'	=>'NETHERLANDS ANTILLES',
								st ='AR'	=>'ARKANSAS',
								st ='ARG'	=>'ARGENTINA',
								st ='AS'	=>'AMERICAN SAMOA',
								st ='AUS'	=>'AUSTRALIA',
								st ='AZ'	=>'ARIZONA',
								st ='BA'	=>'BARBADOS',
								st ='BC'	=>'BRITISH COLUMBIA', 
								st ='BEL'	=>'BELGIUM',
								st ='BMU'	=>'BERMUDA',
								st ='BRT'	=>'BRITIN',
								st ='CA'	=>'CALIFORNIA',
								st ='CAN'	=>'CANADA',
								st ='CAN'	=>'CANADA',                                           
								st ='CB'	=>'COURBEVOIE',
								st ='CHE'	=>'SWITZERLAND',
								st ='CHN'	=>'CHINA',
								st ='CI'	=>'CAYMAN ISLANDS',
								st ='CO'	=>'COLORADO',
								st ='COK'	=>'COOK ISLANDS',
								st ='CR'	=>'COL EL RETONO',
								st ='CRI'	=>'COSTA RICA',
								st ='CT'	=>'CONNECTICUT',
								st ='CYM'	=>'CAYMAN ISLANDS',
								st ='CYM'	=>'CAYMAN',
								st ='DC'	=>'DISTRICT OF COLUMBIA',
								st ='DC'	=>'WASHINGTON',
								st ='DE'	=>'DELAWARE',
								st ='DE'	=>'DELEWARE',
								st ='DEL'	=>'DE',
								st ='DEL'	=>'DELEWARE',
								st ='DEN'	=>'DENMARK',
								st ='DEU'	=>'GERMANY',
								st ='DNK'	=>'DENMARK',
								st ='DO'	=>'DOMINICAN REPUBLIC',
								st ='DO'	=>'DOMINICAN REPUBLIC',
								st ='DU'	=>'DUBLIN',
								st ='ENG'	=>'ENGLAND',
								st ='ENG'	=>'ENGLAND',                                          
								st ='FL'	=>'FLORIDA',
								st ='FM'	=>'FEDERATED STATES OF MICRONESIA',
								st ='FRA'	=>'FRANCE',                                           
								st ='GA'	=>'GEORGIA',
								st ='GBR'	=>'LONDON',                                           
								st ='GBR'	=>'UNITED KINGDOM',
								st ='GE'	=>'GENEVA',
								st ='GER'	=>'GERMANY',                                          
								st ='GU'	=>'GUAM',
								st ='HI'	=>'HAWAII',
								st ='IA'	=>'IOWA',
								st ='ID'	=>'IDAHO',
								st ='IL'	=>'ILLINOIS',
								st ='IN'	=>'INDIANA',
								st ='IND'	=>'INDIA',
								st ='IO'	=>'BRITISH INDIAN OCEAN TERRITORY',
								st ='IRE'	=>'IRELAND',                                          
								st ='IS'	=>'ICELAND',
								st ='ISR'	=>'ISRAL',
								st ='JA'	=>'JAPAN',
								st ='JAP'	=>'JAPAN',                                            
								st ='JPN'	=>'JAPAN',
								st ='KEN'	=>'KENYA',
								st ='KN'	=>'SAINT KITTS AND NEVIS',
								st ='KN'	=>'SAINT KITTS AND NEVIS',
								st ='KS'	=>'KANSAS',
								st ='KY'	=>'KENTUCKY',
								st ='LA'	=>'LOUISIANA',
								st ='LI'	=>'LIECHTENSTEIN',
								st ='LO'	=>'LONDON',
								st ='LS'	=>'LESOTHO',
								st ='LT'	=>'LITHUANIA',
								st ='LUX'	=>'LUXEMBURG',
								st ='LV'	=>'LATVIA',
								st ='LV'	=>'LATVIA',
								st ='MA'	=>'MASSACHUSETTS',
								st ='MB'	=>'MANITOBA',
								st ='MD'	=>'MARYLAND',
								st ='ME'	=>'MAINE',
								st ='MEX'	=>'MEXICO',
								st ='MEX'	=>'MEXICO',                                           
								st ='MH'	=>'MARSHALL ISLANDS',
								st ='MI'	=>'MICHIGAN',
								st ='MI'	=>'MISSISSIPPI',
								st ='MN'	=>'MINNESOTA',
								st ='MO'	=>'MISSOURI',
								st ='MP'	=>'NORTHERN MARIANA ISLANDS',
								st ='MS'	=>'MISSISSIPPI',
								st ='MT'	=>'MONTANA',
								st ='MY'	=>'MALAYSIA',
								st ='MY'	=>'MALAYSIA',
								st ='NB'	=>'NEW BRUNSWICK',
								st ='NC'	=>'NORTH CAROLINA',
								st ='ND'	=>'NORTH DAKOTA',
								st ='NE'	=>'NEBRASKA',
								st ='NEW'	=>'NEW ZELAND',                                       
								st ='NF'	=>'NEW FOUNDLAND',
								st ='NH'	=>'NEW HAMPSHIRE',
								st ='NJ'	=>'NEW JERSEY',
								st ='NLD'	=>'NETHERLANDS',
								st ='NLD'	=>'NETHERLANDS', 
								st ='NM'	=>'NEW MEXICO',
								st ='NOR'	=>'NORWAY',                                           
								st ='NS'	=>'NOVA SCOTIA',
								st ='NV'	=>'NEVADA',
								st ='NY'	=>'NEW YORK',
								st ='NZ'	=>'NEW ZELAND',
								st ='NZL'	=>'NEW ZEALAND',
								st ='NZL'	=>'NEW ZEALAND', 
								st ='OH'	=>'OHIO',
								st ='OK'	=>'OKLAHOMA',
								st ='ON'	=>'ONTARIO',
								st ='OR'	=>'OREGON',
								st ='OS'	=>'OSLO',
								st ='PA'	=>'PENNSYLVANIA',
								st ='PAN'	=>'PANAMA',
								st ='PF'	=>'PFORZHEIM',
								st ='PHL'	=>'PHILIPPINES',
								st ='PR'	=>'PUERTO RICO',
								st ='PRI'	=>'PUERTO RICO', 
								st ='PRI'	=>'PUERTO RICO',
								st ='PW'	=>'PALAU',
								st ='QC'	=>'QUEBEC',
								st ='RI'	=>'RHODE ISLAND',
								st ='SC'	=>'SOUTH CAROLINA',
								st ='SCO'	=>'SCOTLAND',
								st ='SD'	=>'SOUTH DAKOTA',
								st ='SGP'	=>'SINGAPORE',
								st ='SK'	=>'SASKATCHEWAN',
								st ='SO'	=>'SONORA',
								st ='SU'	=>'SURREY',
								st ='SW'	=>'SWITZERLAND',
								st ='SWE'	=>'SWEDEN',
								st ='SWI'	=>'SWITZERLAND',                                      
								st ='TN'	=>'TENNESSEE',
								st ='TO'	=>'TOKYO',
								st ='TUR'	=>'TURKEY',
								st ='TW'	=>'TAIWAN, PROVINCE OF CHINA',
								st ='TX'	=>'TEXAS',
								st ='UK'	=>'SCOTLAND',
								st ='US'	=>'UNITED STATES',
								st ='UT'	=>'UTAH',
								st ='VA'	=>'VIRGINIA',
								st ='VEN'	=>'VENEZUELA',                                        
								st ='VI'	=>'US VIRGIN ISLANDS',
								st ='VI'	=>'VIRGIN ISLANDS',
								st ='VIR'	=>'US VIRGIN ISLANDS',
								st ='VT'	=>'VERMONT',
								st ='WA'	=>'WASHINGTON',
								st ='WAS'	=>'WASHINGTON',
								st ='WI'	=>'WISCONSIN',
								st ='WV'	=>'WEST VIRGINIA',
								st ='WY'	=>'WYOMING',
								st =''    =>'',
								'**|'+ st);	
								
		END;

	//****************************************************************************
	//GetCountryDesc: returns the "Country Description".
	//****************************************************************************
	EXPORT GetCountryDesc(STRING Code) := FUNCTION
		st  := stringlib.stringfilter(corp2.t2u(code),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		RETURN map (  st in ['AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL','GA','HI','ID','IL','IA',
												 'IN','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH',
												 'NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT',
												 'VT','VA','WA','WV','WI','WY','US'] => 'US', 
								// Canadian Provinces
									st in ['AB','BC','MB','NB','NF','NS','NT','ON','PE','PQ','QC','SK','YT']	=> 'CANADA',
									st ='ABW' =>'ARUBA',
									st ='AGO' =>'ANGOLA',
									st ='AFG' =>'AFGHANISTAN',
									st ='AIA' =>'ANGUILLA',
									st ='ALA' =>'ALAND ISLANDS',
									st ='ALB' =>'ALBANIA',
									st ='AND' =>'ANDORRA',
									st ='ANT' =>'NETHERLANDS ANTILLES',
									st ='ARE' =>'UNITED ARAB EMIRATES',
									st ='ARG' =>'ARGENTINA',
									st ='ARM' =>'ARMENIA',
									st ='ASM' =>'AMERICAN SAMOA',
									st ='ATA' =>'ANTARCTICA',
									st ='ATF' =>'FRENCH SOUTHERN TERRITORIES',
									st ='ATG' =>'ANTIGUA AND BARBUDA',
									st ='AUS' =>'AUSTRALIA',
									st ='AUT' =>'AUSTRIA',
									st ='AZE' =>'AZERBAIJAN',
									st ='BAR' =>'BARBADOS',
									st ='BDI' =>'BURUNDI',
									st ='BEL' =>'BELGIUM',
									st ='BEN' =>'BENIN',
									st ='BFA' =>'BURKINA FASO',
									st ='BGD' =>'BANGLADESH',
									st ='BGR' =>'BULGARIA',
									st ='BHR' =>'BAHRAIN',
									st ='BHS' =>'BAHAMAS',
									st ='BIH' =>'BOSNIA AND HERZEGOWINA',
									st ='BLM' =>'SAINT-BARTHELEMY',
									st ='BLR' =>'BELARUS',
									st ='BLZ' =>'BELIZE',
									st ='BMU' =>'BERMUDA',
									st ='BOL' =>'BOLIVIA',
									st ='BRA' =>'BRAZIL',
									st ='BRB' =>'BARBADOS',
									st ='BRN' =>'BRUNEI DARUSSALAM',
									st ='BTN' =>'BHUTAN',
									st ='BVT' =>'BOUVET ISLAND',
									st ='BWA' =>'BOTSWANA',
									st ='CAF' =>'CENTRAL AFRICAN REPUBLIC',
									st ='CAN' =>'CANADA',
									st ='CAY' =>'CAYMAN ISLANDS',
									st ='CCK' =>'COCOS (KEELING) ISLANDS',
									st ='CHE' =>'SWITZERLAND',
									st ='CHL' =>'CHILE',
									st ='CHN' =>'CHINA',
									st ='CIV' =>'COTE DIVOIRE',
									st ='CMR' =>'CAMEROON',
									st ='COD' =>'CONGO, THE DRC',
									st ='COG' =>'CONGO',
									st ='COK' =>'COOK ISLANDS',
									st ='COL' =>'COLOMBIA',
									st ='COM' =>'COMOROS',
									st ='CPV' =>'CAPE VERDE',
									st ='CRI' =>'COSTA RICA',
									st ='CUB' =>'CUBA',
									st ='CXR' =>'CHRISTMAS ISLAND',
									st ='CYM' =>'CAYMAN ISLANDS',
									st ='CYP' =>'CYPRUS',
									st ='CZE' =>'CZECH REPUBLIC',
									st ='DEN' =>'DENMARK',
									st ='DEU' =>'GERMANY',
									st ='DJI' =>'DJIBOUTI',
									st ='DMA' =>'DOMINICA',
									st ='DNK' =>'DENMARK',
									st ='DOM' =>'DOMINICAN REPUBLIC',
									st ='DZA' =>'ALGERIA',
									st ='EAS' =>'EGYPT', 
									st ='ECU' =>'ECUADOR',
									st ='EGY' =>'EGYPT',
									st ='ENG' =>'ENGLAND',
									st ='ERI' =>'ERITREA',
									st ='ESH' =>'WESTERN SAHARA',
									st ='ESP' =>'SPAIN',
									st ='EST' =>'ESTONIA',
									st ='ETH' =>'ETHIOPIA',
									st ='FIN' =>'FINLAND',
									st ='FJI' =>'FIJI',
									st ='FLK' =>'FALKLAND ISLANDS (MALVINAS)',
									st ='FRA' =>'FRANCE',
									st ='FRO' =>'FAROE ISLANDS',
									st ='FSM' =>'MICRONESIA, FEDERATED STATES OF',
									st ='FXX' =>'FRANCE, METROPOLITAN',
									st ='GAB' =>'GABON',
									st ='GBR' =>'LONDON',
									st ='GEO' =>'GEORGIA',
									st ='GER' =>'GERMANY', 
									st ='GHA' =>'GHANA',
									st ='GIB' =>'GIBRALTAR',
									st ='GIN' =>'GUINEA',
									st ='GLP' =>'GUADELOUPE',
									st ='GMB' =>'GAMBIA',
									st ='GNB' =>'GUINEA-BISSAU',
									st ='GNQ' =>'EQUATORIAL GUINEA',
									st ='GRB' =>'UNITED KINGDOM',
									st ='GRC' =>'GREECE',
									st ='GRD' =>'GRENADA',
									st ='GRL' =>'GREENLAND',
									st ='GTM' =>'GUATEMALA',
									st ='GUF' =>'FRENCH GUIANA',
									st ='GUY' =>'GUYANA',									
									st in ['GUM','GUA']=>'GUAM',
									st ='HKG' =>'HONG KONG',
									st ='HMD' =>'HEARD AND MC DONALD ISLANDS',
									st ='HND' =>'HONDURAS',
									st ='HRV' =>'CROATIA',
									st ='HTI' =>'HAITI',
									st ='HUN' =>'HUNGARY',
									st ='IDN' =>'INDONESIA',
									st ='IMN' =>'ISLE OF MAN',
									st ='IND' =>'INDIA',
									st ='IOT' =>'BRITISH INDIAN OCEAN TERRITORY',
									st ='IRE' =>'IRELAND',
									st ='IRL' =>'IRELAND',
									st ='IRN' =>'IRAN',
									st ='IRQ' =>'IRAQ',
									st ='ISL' =>'ICELAND',
									st ='ISR' =>'ISRAEL',
									st ='ITA' =>'ITALY',
									st ='ITL' =>'ITALY',
									st ='JAM' =>'JAMAICA',
									st ='JAP' =>'JAPAN', 
									st ='JEY' =>'JERSEY',
									st ='JOR' =>'JORDAN',
									st ='JPN' =>'JAPAN',
									st ='KAZ' =>'KAZAKHSTAN',
									st ='KEN' =>'KENYA',
									st ='KGZ' =>'KYRGYZSTAN',
									st ='KHM' =>'CAMBODIA',
									st ='KIR' =>'KIRIBATI',
									st ='KN' =>'SAINT KITTS AND NEVIS',
									st ='KNA' =>'SAINT KITTS AND NEVIS',
									st ='KOR' =>'KOREA',
									st ='KWT' =>'KUWAIT',
									st ='LAO' =>'LAOS',
									st ='LBN' =>'LEBANON',
									st ='LBR' =>'LIBERIA',
									st ='LBY' =>'LIBYAN ARAB JAMAHIRIYA',
									st ='LCA' =>'SAINT LUCIA',
									st ='LIE' =>'LIECHTENSTEIN',
									st ='LKA' =>'SRI LANKA',
									st ='LSO' =>'LESOTHO',
									st ='LTU' =>'LITHUANIA',
									st ='LUX' =>'LUXEMBOURG',
									st ='LVA' =>'LATVIA',
									st ='MAC' =>'MACAU',
									st ='MAF' =>'SAINT-MARTIN (FRENCH PART)',
									st ='MAR' =>'MOROCCO',
									st ='MCO' =>'MONACO',
									st ='MDA' =>'MOLDOVA, REPUBLIC OF',
									st ='MDG' =>'MADAGASCAR',
									st ='MDV' =>'MALDIVES',
									st ='MEX' =>'MEXICO',
									st ='MHL' =>'MARSHALL ISLANDS',
									st ='MKD' =>'MACEDONIA',
									st ='MLI' =>'MALI',
									st ='MLT' =>'MALTA',
									st ='MMR' =>'MYANMAR (BURMA)',
									st ='MNE' =>'MONTENEGRO',
									st ='MNG' =>'MONGOLIA',
									st ='MNP' =>'NORTHERN MARIANA ISLANDS',
									st ='MOZ' =>'MOZAMBIQUE',
									st ='MRT' =>'MAURITANIA',
									st ='MSR' =>'MONTSERRAT',
									st ='MTQ' =>'MARTINIQUE',
									st ='MUS' =>'MAURITIUS',
									st ='MWI' =>'MALAWI',
									st ='MYS' =>'MALAYSIA',
									st ='MYT' =>'MAYOTTE',
									st ='NAM' =>'NAMIBIA',
									st ='NCL' =>'NEW CALEDONIA',
									st ='NER' =>'NIGER',
									st ='NEW' =>'NEW ZELAND', 
									st ='NFK' =>'NORFOLK ISLAND',
									st ='NGA' =>'NIGERIA',
									st ='NIC' =>'NICARAGUA',
									st ='NIU' =>'NIUE',
									st ='NLD' =>'NETHERLANDS',
									st ='NOR' =>'NORWAY',
									st ='NOV' =>'NOVA SCOTIA',
									st ='NPL' =>'NEPAL',
									st ='NRU' =>'NAURU',
									st ='NZL' =>'NEW ZEALAND',
									st ='OMN' =>'OMAN',
									st ='PAK' =>'PAKISTAN',
									st ='PAN' =>'PANAMA',
									st ='PCN' =>'PITCAIRN',
									st ='PER' =>'PERU',
									st ='PHI' =>'PHILIPPINES',
									st ='PHL' =>'PHILIPPINES',
									st ='PLW' =>'PALAU',
									st ='PNG' =>'PAPUA NEW GUINEA',
									st ='POL' =>'POLAND',
									st ='PRI' =>'PUERTO RICO',
									st ='PRK' =>'KOREA, D.P.R.O.',
									st ='PRT' =>'PORTUGAL',
									st ='PRY' =>'PARAGUAY',
									st ='PSE' =>'PALESTINIAN TERRITORY, OCCUPIED',
									st ='PYF' =>'FRENCH POLYNESIA',
									st ='QAT' =>'QATAR',
									st ='REU' =>'REUNION',
									st ='ROM' =>'ROMANIA',
									st ='ROU' =>'ROMANIA',
									st ='RUS' =>'RUSSIAN FEDERATION',
									st ='RWA' =>'RWANDA',
									st ='SAU' =>'SAUDI ARABIA',
									st ='SCO' =>'SCOTLAND',
									st ='SDN' =>'SUDAN',
									st ='SEN' =>'SENEGAL',
									st ='SGP' =>'SINGAPORE',
									st ='SGS' =>'SOUTH GEORGIA AND SOUTH S.S.',
									st ='SHN' =>'ST. HELENA',
									st ='SIN' =>'SINGAPORE',
									st ='SJM' =>'SVALBARD AND JAN MAYEN ISLANDS',
									st ='SLB' =>'SOLOMON ISLANDS',
									st ='SLE' =>'SIERRA LEONE',
									st ='SLV' =>'EL SALVADOR',
									st ='SMR' =>'SAN MARINO',
									st ='SOM' =>'SOMALIA',
									st ='SOU' =>'SOUTH AFRICA', 
									st ='SPM' =>'ST. PIERRE AND MIQUELON',
									st ='SRB' =>'SERBIA',
									st ='SSD' =>'SOUTH SUDAN',
									st ='STP' =>'SAO TOME AND PRINCIPE',
									st ='SUR' =>'SURINAME',
									st ='SVK' =>'SLOVAKIA (SLOVAK REPUBLIC)',
									st ='SVN' =>'SLOVENIA',
									st ='SWE' =>'SWEDEN',
									st ='SWI' =>'SWITZERLAND',
									st ='SWZ' =>'SWAZILAND',
									st ='SYC' =>'SEYCHELLES',
									st ='SYR' =>'SYRIAN ARAB REPUBLIC',
									st ='TCA' =>'TURKS AND CAICOS ISLANDS',
									st ='TCD' =>'CHAD',
									st ='TGO' =>'TOGO',
									st ='THA' =>'THAILAND',
									st ='TJK' =>'TAJIKISTAN',
									st ='TKL' =>'TOKELAU',
									st ='TKM' =>'TURKMENISTAN',
									st ='TMP' =>'EAST TIMOR',
									st ='TON' =>'TONGA',
									st ='TTO' =>'TRINIDAD AND TOBAGO',
									st ='TUN' =>'TUNISIA',
									st ='TUR' =>'TURKEY',
									st ='TUV' =>'TUVALU',
									st ='TWN' =>'TAIWAN, PROVINCE OF CHINA',
									st ='TZA' =>'TANZANIA, UNITED REPUBLIC OF',
									st ='US' 	=>'US',
									st ='USA' =>'US',
									st ='UGA' =>'UGANDA',
									st ='UKR' =>'UKRAINE',
									st ='UMI' =>'U.S. MINOR ISLANDS',
									st ='UNI' =>'US',
									st ='UNITEDSTATES' =>'US',
									st ='URU' =>'URUGUAY', 
									st ='URY' =>'URUGUAY',
									st ='US' =>'US',
									st ='USA' =>'US',
									st ='UZB' =>'UZBEKISTAN',
									st ='VAT' =>'HOLY SEE (VATICAN CITY STATE)',
									st ='VCT' =>'SAINT VINCENT AND THE GRENADINES',
									st ='VEN' =>'VENEZUELA',
									st ='VGB' =>'VIRGIN ISLANDS (BRITISH)',
									st ='VIR' =>'VIRGIN ISLANDS (U.S.)',
									st ='VNM' =>'VIET NAM',
									st ='VUT' =>'VANUATU',
									st ='WI' =>'WEST INDIES',
									st ='WLF' =>'WALLIS AND FUTUNA ISLANDS',
									st ='WSM' =>'SAMOA',
									st ='YEM' =>'YEMEN',
									st ='ZAF' =>'SOUTH AFRICA',
									st ='ZMB' =>'ZAMBIA',
									st ='ZWE' =>'ZIMBABWE',
									st in ['','COR','DIS','SHE','U'] =>'',
									'**|'+corp2.t2u(code)
						);
	END;						

		//****************************************************************************
		//StateDescToCode: returns the us state or foreign province or foreign country
		//								 description.
		//****************************************************************************
		EXPORT StateDescToCode(string s) := FUNCTION
					 uc_s  := stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	         RETURN map(uc_s = 'ALABA' 														=> 'AL',
											uc_s = 'ALABAM'														=> 'AL',
											uc_s = 'ALABAMA' 													=> 'AL',
											uc_s = 'ALASKA' 													=> 'AK',
											uc_s = 'ARKANS'														=> 'AR',
											uc_s = 'ARKANSAS'													=> 'AR',
											uc_s = 'AMERICAN SAMOA' 									=> 'AS',
											uc_s = 'ARIZONA' 													=> 'AZ',
											uc_s = 'CALI'															=> 'CA',
											uc_s = 'CALIF'														=> 'CA',
											uc_s = 'CALIFO'														=> 'CA',
											uc_s = 'CALIFOR'													=> 'CA',
											uc_s = 'CALIFORN'													=> 'CA',
											uc_s = 'CALIFORNI'												=> 'CA',
											uc_s = 'CALIFORNA'												=> 'CA',
											uc_s = 'CALIFORNIA' 											=> 'CA',
											uc_s = 'CANAL ZONE' 											=> 'CZ',
											uc_s = 'CAYMAN ISLANDS'										=> 'CAY',
											uc_s = 'COLORAD'													=> 'CO',
											uc_s = 'COLORADO' 												=> 'CO',
											uc_s = 'CONN' 														=> 'CT',
											uc_s = 'CONNECTICU' 											=> 'CT',
											uc_s = 'CONNECTICUT' 											=> 'CT',
											uc_s = 'CANAL ZONE' 											=> 'CZ',
											uc_s = 'DISTRICT OF COLUMBIA' 						=> 'DC',
											uc_s = 'WASHINGTON DC'										=> 'DC',
											uc_s = 'DEL' 															=> 'DE',
											uc_s = 'DELAWARE' 												=> 'DE',											
											uc_s = 'FLA'															=> 'FL',
											uc_s = 'FLOR'															=> 'FL',
											uc_s = 'FLORI'														=> 'FL',
											uc_s = 'FLORIAD'													=> 'FL',
											uc_s = 'FLORID'														=> 'FL',
											uc_s = 'FLORIDA' 													=> 'FL',
											uc_s = 'FEDERATED STATES OF MICRONESIA'		=> 'FM',																						
											uc_s = 'GEO'															=> 'GA',
											uc_s = 'GEOR'															=> 'GA',
											uc_s = 'GEORG'														=> 'GA',
											uc_s = 'GEORGI'														=> 'GA',
											uc_s = 'GEORGIA' 													=> 'GA',
											uc_s = 'GUAM' 														=> 'GU',
											uc_s = 'HAWAII' 													=> 'HI',
											uc_s = 'IOW' 															=> 'IA',
											uc_s = 'IOWA' 														=> 'IA',
											uc_s = 'IDAHO' 														=> 'ID',
											uc_s = 'ILL'															=> 'IL',
											uc_s = 'ILLI'															=> 'IL',
											uc_s = 'ILLIN'														=> 'IL',
											uc_s = 'ILLINO'														=> 'IL',
											uc_s = 'ILLINOIS' 												=> 'IL',
											uc_s = 'IND' 															=> 'IN',
											uc_s = 'INDIAN'														=> 'IN',
											uc_s = 'INDIANA' 													=> 'IN',
											uc_s = 'KANS' 														=> 'KS',
											uc_s = 'KANSAS' 													=> 'KS',
											uc_s = 'KENTUCKY' 												=> 'KY',
											uc_s = 'LOUIS' 														=> 'LA',
											uc_s = 'LOUISIA' 													=> 'LA',
											uc_s = 'LOUISIAN' 												=> 'LA',
											uc_s = 'LOUISIANA' 												=> 'LA',
											uc_s = 'MASSACHUSETTS' 										=> 'MA',
											uc_s = 'MARYLAND' 												=> 'MD',
											uc_s = 'MAINE'														=> 'ME',
											uc_s = 'MICH'															=> 'MI',
											uc_s = 'MICHIG'														=> 'MI',
											uc_s = 'MICHIGAN'													=> 'MI',
											uc_s = 'MINN'															=> 'MN',
											uc_s = 'MINNE'														=> 'MN',
											uc_s = 'MINNESOT'													=> 'MN',
											uc_s = 'MINNESOTA'												=> 'MN',
											uc_s = 'MISSO'														=> 'MO',
											uc_s = 'MISSOU'														=> 'MO',
											uc_s = 'MISSOUR'													=> 'MO',
											uc_s = 'MISSOURI'													=> 'MO',
											uc_s = 'MISSI'														=> 'MS',
											uc_s = 'MISSISSI'													=> 'MS',
											uc_s = 'MISSISSIP'												=> 'MS',
											uc_s = 'MISSISSIPPI'											=> 'MS',
											uc_s = 'MONTANA'													=> 'MT',
											uc_s = 'NORTH C'													=> 'NC',
											uc_s = 'NORTH CA'													=> 'NC',
											uc_s = 'NORTH CAR'												=> 'NC',
											uc_s = 'NORTH CARO'												=> 'NC',
											uc_s = 'NORTH CAROLI'											=> 'NC',
											uc_s = 'NORTH CAROLIN'										=> 'NC',
											uc_s = 'NORTH CAROLINA'										=> 'NC',
											uc_s = 'NORTH DAKOTA'											=> 'ND',
											uc_s = 'NEBRASKA'													=> 'NE',
											uc_s = 'NEW HAMPSHIRE'										=> 'NH',
											uc_s = 'NEW HAMSHIRE'											=> 'NH',
											uc_s = 'JERSEY'														=> 'NJ',
											uc_s = 'NEW JE'														=> 'NJ',
											uc_s = 'NEW JER'													=> 'NJ',
											uc_s = 'NEW JERSE'												=> 'NJ',
											uc_s = 'NEW JERSEY'												=> 'NJ',
											uc_s = 'NEW MEX'													=> 'NM',
											uc_s = 'NEW MEXI'													=> 'NM',
											uc_s = 'NEW MEXICO'												=> 'NM',
											uc_s = 'NEVADA'														=> 'NV',
											uc_s = 'NEW YORK'													=> 'NY',
											uc_s = 'OHI'															=> 'OH',
											uc_s = 'OHIO'															=> 'OH',
											uc_s = 'OKLA'															=> 'OK',
											uc_s = 'OKLAH'														=> 'OK',
											uc_s = 'OKLAHOM'													=> 'OK',
											uc_s = 'OKLAHOMA'													=> 'OK',
											uc_s = 'OREGON'														=> 'OR',
											uc_s = 'PENN'															=> 'PA',
											uc_s = 'PENNS'														=> 'PA',
											uc_s = 'PENNSYLVAN'												=> 'PA',
											uc_s = 'PENNSYLVANI'											=> 'PA',
											uc_s = 'PENNSYLVANIA'											=> 'PA',
											uc_s = 'PUERTO RICO'											=> 'PR',
											uc_s = 'PUERTO RICO, COMMWEALTH'					=> 'PR',
											uc_s = 'RHODE ISLAND'											=> 'RI',
											uc_s = 'SOUTH CAROL'											=> 'SC',
											uc_s = 'SOUTH CAROLI'											=> 'SC',
											uc_s = 'SOUTH CAROLIN'										=> 'SC',
											uc_s = 'SOUTH CAROLINA'										=> 'SC',
											uc_s = 'SOUTH DAKOT'											=> 'SD',
											uc_s = 'SOUTH DAKOTA'											=> 'SD',
											uc_s = 'TENN'															=> 'TN',
											uc_s = 'TENNE'														=> 'TN',
											uc_s = 'TENNESSE'													=> 'TN',
											uc_s = 'TENNESSEE'												=> 'TN',
											uc_s = 'TEX'															=> 'TX',
											uc_s = 'TEEXAS'														=> 'TX',
											uc_s = 'TEXAR'														=> 'TX',
											uc_s = 'TEXAS'														=> 'TX',
											uc_s = 'UNITED STATES'										=> 'US',
											uc_s = 'UTA'														 	=> 'UT',
											uc_s = 'UTAH'														 	=> 'UT',
											uc_s = 'VIRGINIA'													=> 'VA',
											uc_s = 'VIRGIN ISLANDS'										=> 'VI',
											uc_s = 'VERMONT'													=> 'VT',
											uc_s = 'WASH'															=> 'WA',
											uc_s = 'WASHINGTON'												=> 'WA',
											uc_s = 'WISC'															=> 'WI',
											uc_s = 'WISCONSI'													=> 'WI',
											uc_s = 'WISCONSIN'												=> 'WI',
											uc_s = 'WEST VIRGINIA'										=> 'WV',
											uc_s = 'WYOMING'													=> 'WY',
											//Foreign provinces or foreign countries
											uc_s = 'ALBERTA'													=> 'AB',
											uc_s = 'BARBADOS'													=> 'BA',
											uc_s = 'BRITISH COLUMBIA'									=> 'BC',
											uc_s = 'BELGIUM'													=> 'BEL',
											uc_s = 'CANADA'														=> 'CAN',
											uc_s = 'COURBEVOIE'												=> 'CB',
											uc_s = 'COL EL RETONO'										=> 'CR',
											uc_s = 'DUBLIN'														=> 'DU',
											uc_s = 'ENGLAND'													=> 'ENG',
											uc_s = 'FRANCE'														=> 'FRA',
											uc_s = 'GEORGIA' 													=> 'GA',
											uc_s = 'LONDON'														=> 'GBR',
											uc_s = 'GENEVA'														=> 'GE',
											uc_s = 'GERMANY'													=> 'GER',
											uc_s = 'IRELAND'													=> 'IRE',
											uc_s = 'JAPAN'														=> 'JAP',
											uc_s = 'LIECHTENSTEIN'										=> 'LI',
											uc_s = 'LONDON'														=> 'LO',
											uc_s = 'MEXICO'														=> 'MEX',
											uc_s = 'NEW ZELAND'												=> 'NEW',
											uc_s = 'NETHERLANDS'											=> 'NLD',
											uc_s = 'NEW MEXICO'												=> 'NM',
											uc_s = 'NORWAY'														=> 'NOR',
											uc_s = 'OSLO'															=> 'OS',
											uc_s = 'PFORZHEIM'												=> 'PF',
											uc_s = 'PALAU'														=> 'PW',
											uc_s = 'QUEBEC'														=> 'QC',
											uc_s = 'SASKATCHEWAN'											=> 'SK',
											uc_s = 'SONORA'														=> 'SO',
											uc_s = 'SURREY'														=> 'SU',
											uc_s = 'SWITZERLAND'											=> 'SWI',
											uc_s = 'TOKYO'														=> 'TO',
											uc_s = 'VENEZUELA'												=> 'VEN',
											uc_s = ''																	=> '',
											'**'
										 );
		END;

	//********************************************************************
	//CorpActDesc: Returns corp_acts" 
	//********************************************************************	
	EXPORT CorpActDesc(STRING code) := FUNCTION

    //Abbreviated below desc due to corp_acts 50 char common layout length 
		st  := corp2.t2u(code);
		RETURN case(st,
								'0'  =>'OLD CODE S & L ASSOC NEEDS TO BE CREATED',  
								'1'  =>'DOM BUS CORP; 958 OF 1987',
								'2'  =>'DOM PROF CORP; 155 OF 1963',
								'3'  =>'DOM MED CORP; 179 OF 1961',
								'4'  =>'DOM DENT CORP; 471 OF 1961',
								'5'  =>'DOM PROF & MED CORP; 155 OF 1963 & 179 OF 1961',
								'6'  =>'DOM PROF & DENT CORP; 155 OF 1963 & 471 OF 1961',
								'7'  =>'DOM PROF, MED & DENT 155 OF 1963, 179 OF 1961 & 471 OF 1961',
								'8'  =>'DOM PROF, DENT & BUS 155 OF 1963, 471 OF 1961 & 958 OF 1987',
								'9'  =>'DOM BUS & PROF CORP; 958 OF 1987 & 155 OF 1963',
								'11' =>'DOM BUS & DENT CORP; 958 OF 1987 & 471 OF 1961',
								'12' =>'DOM RAILROAD CORP; 30 OF 1959 & 203 OF 1899',
								'88' =>'DOM BUS & MED CORP; 958 OF 1987 & 179 OF 1961',
								'13' =>'DOM BUS CORP; 576 OF 1965',
								'15' =>'DOM PROF CORP; 155 OF 1963',
								'16' =>'DOM MED CORP; 179 OF 1961',
								'17' =>'DOM DENT CORP; 471 OF 1961',
								'18' =>'DOM PROF & MED CORP; 155 OF 1963 & 179 OF 1961',
								'19' =>'DOM PROF & DENT CORP; 155 OF 1963 & 471 OF 1961',
								'20' =>'DOM PROF, MED & DENT 155 OF 1963, 179 OF 1961 & 471 OF 1961',
								'21' =>'DOM PROF, DENT & BUS 155 OF 1963, 471 OF 1961 & 576 OF 1965',
								'22' =>'DOM BUS & PROF CORP; 576 OF 1965 & 155 OF 1963',
								'23' =>'DOM BUS & MED CORP; 576 OF 1965 & 179 OF 1961',
								'24' =>'DOM BUS & DENT CORP; 576 OF 1965 & 471 OF 1961',
								'25' =>'25 DOM RAILROAD CORP 30 OF 1959 & 203 OF 1899',
								'26' =>'DOM NONPROFIT CORP; 1147 OF 1993',
								'27' =>'INDUSTRIAL DEVELOPMENT CORP; 404 OF 1955',
								'28' =>'INSTITUTION CORP; 375 OF 1911',
								'29' =>'PUBLIC BUILDING AUTHORITY CORP; 409 OF 1961',
								'30' =>'DOM NONPROFIT CORP; 176 OF 1963',
								'31' =>'INDUSTRIAL DEVELOPMENT CORP; 404 OF 1955',
								'32' =>'INSTITUTION CORP; 375 OF 1911',
								'33' =>'PUBLIC BUILDING AUTHORITY CORP; 409 OF 1961',
								'34' =>'DOM AGRICULTURAL CO-OP; 153 OF 1939',
								'35' =>'DOM CO-OP MARKETING ASSOCIATION; 116 OF 1921',
								'36' =>'DOM CO-OP GENERAL; 632 OF 1921',
								'37' =>'DOM ELECTRICAL CO-OP; 342 OF 1937',
								'38' =>'DOM TELEPHONE CO-OP; 51 OF 1951',
								'39' =>'DOMESTIC LLC; 1003 OF 1993',
								'40' =>'DOMESTIC LLLP; 912 OF 1997',
								'41' =>'DOMESTIC LLC & MED CORP',
								'43' =>'DOMESTIC LP; 657 OF 1979',
								'46' =>'DOMESTIC LLP; 1518 OF 1999',
								'47' =>'DOMESTIC LLP; 912 OF 1997',
								'10' =>'DOM GENERAL PARTNSHP; 1518 OF 1999',
								'49' =>'FOR BUS CORP; 958 OF 1987',
								'52' =>'FOR PROF CORP; 155 OF 1963',
								'53' =>'FOR MED CORP; 179 OF 1961',
								'54' =>'FOR DENT CORP; 471 OF 1961',
								'55' =>'FOR PROF & MED CORP; 155 OF 1963 & 179 OF 1961',
								'56' =>'FOR PROF & DENT CORP; 155 OF 1963 & 471 OF 1961',
								'57' =>'FOR PROF, MED & DENT 155 OF 1963, 179 OF 1961 & 471 OF 1961',
								'58' =>'FOR PROF, DENT & BUS 155 OF 1963, 471 OF 1961 & 958 OF 1987',
								'59' =>'FOR BUS & PROF CORP; 958 OF 1987 & 155 OF 1963',
								'60' =>'FOR BUS & MED CORP; 958 OF 1987 & 179 OF 1961',
								'61' =>'FOR BUS & DENT CORP; 958 OF 1987 & 471 OF 1961',
								'62' =>'FOR RAILROAD CORP; 30 OF 1959 & 203 OF 1899',
								'63' =>'FOR NONPROFIT CORP; 1147 OF 1993',
								'65' =>'FOR AGRICULTURAL CO-OP; 153 OF 1939',
								'66' =>'FOR CO-OP GENERAL; 632 OF 1921',
								'67' =>'FOR CO-OP MARKETING ASSOCIATION; 116 OF 1921',
								'68' =>'FOR ELECTRICAL CO-OP; 342 OF 1937',
								'69' =>'FOR TELEPHONE CO-OP; 51 OF 1951',
								'70' =>'FOREIGN LLC; 1003 OF 1993',
								'71' =>'FOR LLC & MED CORP; 1003 OF 1993 & 179 OF 1961',
								'73' =>'FOREIGN LLLP; 912 OF 1997',
								'74' =>'FOREIGN LP; 657 OF 1979',
								'75' =>'FOREIGN LLP; 1518 OF 1999',
								'77' =>'FOR GENERAL PARTNSHP; 1518 OF 1999',
								'78' =>'FOR BUS TRUST; 1366 OF 1999',
								'79' =>'UNINCORP NONPROFIT ASSOC; 858 OF 1997',
								'82' =>'BANK; BANK',
								'89' =>'SAVING & LOAN ASSOC SAVING & LOAN ASSOC',
								'99' =>'INSURANCE COMPANY; INSURANCE CO',
								'95' =>'BUSINESS ACT; 958 OF 1987',
								'98' =>'LLC ACT; 1003 OF 1993',
								'96' =>'BUSINESS REGISTRATION; 958 OF 1987',
								'97' =>'LLC REGISTRATION; 30 OF 2001',
								'93' =>'DOMESTIC PUBLIC WATER AUTHORITY; 115 OF 2001',
								'100'=>'DOM LLC & DENT; 338 OF 1997', 
								'101'=>'FOR LLC & DENT; 338 OF 1997', 
								'102'=>'DOM BUS & DENT; 576 OF 1965 & ACT 179 OF 1961', 
								'103'=>'DOM BUS & MED; 576 OF 1965 & ACT 179 OF 1961',
								'104'=>'DOM BUS MED CORP; 2289 OF 2005',
								'105'=>'LP - ACT 15 OF 2007; ACT 15 OF 2007', 
								'106'=>'LP - ACT 15 OF 2007; ACT 15 OF 2007',
								'107'=>'LP - ACT 15 OF 2007; ACT 15 OF 2007', 
								'108'=>'LP - ACT 15 OF 2007; ACT 15 OF 2007', 
								'109'=>'LP - ACT 15 OF 2007; ACT 15 OF 2007',
								'110'=>'LP - ACT 15 OF 2007; ACT 15 OF 2007', 
								'111'=>'LLLP - ACT 15 OF 2007; ACT 15 OF 2007',
								'112'=>'LLLP - ACT 15 OF 2007; ACT 15 OF 2007',
								'**|'+st);

	END;

	//********************************************************************
	//STATUSDESC: Returns "corp_status_desc" 
	//********************************************************************	
	EXPORT StatusDesc(STRING code) := FUNCTION

		st  := corp2.t2u(code);
		RETURN case(st,
								'1'=>'GOOD STANDING',
								'5'=>'NOT CURRENT',
								'6'=>'FORFEITED EXISTENCE',
								'7'=>'DISSOLVED',
								'9'=>'JUDICIALLY DISSOLVED',
								'10'=>'REVOKED',
								'11'=>'EXPIRED',
								'12'=>'WITHDRAWN',
								'13'=>'MERGED ',
								'14'=>'CONVERTED',
								'15'=>'CONSOLIDATED ',
								'16'=>'CANCELLED',
								'17'=>'USED',
								'19'=>'STRICKEN',
								'20'=>'DELETED',
								'21'=>'TRANSFERRED',
								'22'=>'ADMINISTRATIVELY DISSOLVED',
								'23'=>'ADMINISTRATIVELY WITHDRAWN',
								'24'=>'PENDING',
								'25'=>'INACTIVE',
								'26'=>'STATUTORILY DISSOLVED',
								'29'=>'DENIED', 
								'31'=>'FORFEITED CHARTER',
								'32'=>'FORFEITED CHARTER PAID',
								''	=>'',
								'');

	END;

	//********************************************************************
	//OrgStrucDesc: Returns "corp_orig_org_structure_desc" 
	//********************************************************************	
	EXPORT OrgStrucDesc(STRING code) := FUNCTION

		st  := corp2.t2u(code);
		RETURN case(st,
								'1'=>'DOMESTIC FOR PROFIT CORPORATION',
								'2'=>'DOMESTIC FOR PROFIT CORPORATION',
								'3'=>'DOMESTIC NON PROFIT CORPORATION',
								'4'=>'DOMESTIC NON PROFIT CORPORATION',
								'5'=>'DOMESTIC COOPERATIVE(AG, MKT, GEN)',
								'6'=>'DOMESTIC COOPERATIVE(TEL, ELEC)',
								'7'=>'DOMESTIC LIMITED LIABILITY COMPANY',
								'8'=>'DOMESTIC LIMITED LIABILITY PARTNERSHIP',
								'9'=>'DOMESTIC LIMITED PARTNERSHIP',
								'10'=>'DOMESTIC LIMITED LIABILITY LIMITED PARTNERSHIP',
								'11'=>'DOMESTIC GENERAL PARTNERSHIP',
								'13'=>'FOREIGN FOR PROFIT CORPORATION',
								'14'=>'FOREIGN NON PROFIT CORPORATION',
								'15'=>'FOREIGN COOPERATIVE',
								'16'=>'FOREIGN COOPERATIVE',
								'17'=>'FOREIGN LIMITED LIABILITY COMPANY',
								'18'=>'FOREIGN LIMITED LIABILITY LIMITED PARTNERSHIP',
								'19'=>'FOREIGN LIMITED PARTNERSHIP',
								'20'=>'FOREIGN LIMITED LIABILITY PARTNERSHIP',
								'21'=>'FOREIGN GENERAL PARTNERSHIP',
								'22'=>'FOREIGN BUSINESS TRUST',
								'23'=>'UNINCORPORATED NONPROFIT ASSOCIATION',
								'24'=>'BANK',
								'25'=>'INSURANCE COMPANY',
								'30'=>'DOMESTIC PUBLIC WATER AUTHORITY',
								'31'=>'FOREIGN PUBLIC WATER AUTHORITY',
								'33'=>'HOME INSPECTOR',
								'320'=>'DOMESTIC SERIES LLC',
								'330'=>'DOMESTIC PROTECTED SERIES',
								'401'=>'INTL STUDENT EXCHANGE VISITOR PLACEMENT ORG REG(ISEVPO)',
								'501'=>'',
								''	 =>'',
								'');

	END;


	EXPORT SuffixDesc(STRING code) := FUNCTION

		st  := corp2.t2u(code);
		RETURN map( st='1'	=>'SR',
							  st='2'	=>'JR',
								st='3'	=>'I',
								st='4'	=>'II',
								st='5'	=>'III',
								st='6'	=>'IV',
								st='7'	=>'V',
								st='8'	=>'VI',
								st='9'	=>'X',
								st='10' =>'X',
								st='SR' =>'SR',
							  st='JR' =>'JR',
								st='I'  =>'I',
								st='II' =>'II',
								st='III'=>'III',
								st='IV' =>'IV',
								st in ['V','V.']=>'V',	
								st='VI' =>'VI',
								st='X'  =>'X',
								ST=''		=>'',
						'');

	END;

	//********************************************************************
	//TitleDesc: Returns officer's title
	//********************************************************************	
	EXPORT TitleDesc(STRING ID) := FUNCTION
	
				 UC_ID  := corp2.t2u(ID);
				 RETURN map(UC_ID in ['7','19','31','43','55','67','76','158','181','205']=>'ASSISTANT SEC',
										UC_ID in ['8','20','32','44','56','68','77','159','182','206']=>'ASSISTANT TREAS',
										UC_ID in ['126','127','128','230']=>'ASSISTANT VP',
										UC_ID in ['9','21','33','45','57','142','207','234']=>'CEO',
										UC_ID in ['11','23','35','47','59','143','208','235']=>'CFO',
										UC_ID in ['129','134','135','137','236']=>'CHAIRMAN',
										UC_ID in ['220','222','239','241','243']=>'CONTACT PERSON',
										UC_ID in ['131','132','133','148','233']=>'CONTROLLER',
										UC_ID in ['10','22','34','46','58','209']=>'COO',
										UC_ID in ['1','13','25','37','49','61','70','83','92','115','150','160','183']=>'DIRECTOR',
										UC_ID='117'=>'EXECUTIVE',
										UC_ID in ['12','24','36','48','60','69','78','82','91','97']=>'GENERAL MANAGER',
										UC_ID in ['106','119','151','161','171','184','193','210','101','110','172','194','157','162','180','191']=>'GENERAL PARTNERS',
										UC_ID in ['130','136','144','145','149','169','170','192','202','203','204','216','217','219','221','237','238','240','242','244','245','246','247']=>'INCORPORATOR/ORGANIZER',
										UC_ID in ['124','125','163','185']=>'INCORPORATORS',
										UC_ID in ['100','109','173','195']=>'LIMITED PARTNER',
										UC_ID in ['79','88','147']=>'MANAGER',
										UC_ID in ['81','90','152']=>'MANAGING MEMBER',
										UC_ID in ['99','108','174','196']=>'MANAGING PARTNER',
										UC_ID in ['62','71','80','89','116','146','164','186']=>'MEMBER',
										UC_ID in ['224','226']=>'OWNER',
										UC_ID in ['98','107','175','197']=>'PARTNER',
										UC_ID in ['3','15','27','39','51','63','72','84','93','102','111','120','138','153','165','176','187','198','211','228','248','252','256','281','285','289']=>'PRESIDENT',
										UC_ID in ['225','227']=>'PREVIOUS OWNER',
										UC_ID in ['5','17','29','41','53','65','74','86','95','104','113','122','140','154','166','177','188','199','212','231','249','253','257','282','286','290']=>'SECRETARY',
										UC_ID in ['2','14','26','38','50','118','213']=>'SHAREHOLDER',
										UC_ID in ['6','18','30','42','54','66','75','87','96','105','114','123','141','155','167','178','189','200','214','232','250','254','258','283','287','291']=>'TREASURER',
										UC_ID='218'=>'TRUSTEES', 
										UC_ID='281'=>'PRESIDENT',
										UC_ID='282'=>'SECRETARY',
										UC_ID='283'=>'TREASURER',
										UC_ID='16'=>'VICE-PRESIDENT',
										UC_ID='284'=>'VICE-PRESIDENT',
										UC_ID='285'=>'PRESIDENT',
										UC_ID='286'=>'SECRETARY',
										UC_ID='287'=>'TREASURER',
										UC_ID='288'=>'VICE-PRESIDENT',
										UC_ID='289'=>'PRESIDENT',
										UC_ID='290'=>'SECRETARY',
										UC_ID='291'=>'TREASURER',
										UC_ID='292'=>'VICE-PRESIDENT',
										UC_ID='293'=>'TAX PREPARER',
										UC_ID='294'=>'TAX PREPARER',
										UC_ID='297'=>'TAX PREPARER',
										UC_ID='298'=>'TAX PREPARER',
										UC_ID='299'=>'TAX PREPARER',
										UC_ID='302'=>'TAX PREPARER',
										UC_ID='303'=>'TAX PREPARER',
										UC_ID='304'=>'TAX PREPARER',
										UC_ID='305'=>'TAX PREPARER',
										UC_ID='1503'=>'PRESIDENT',
										UC_ID='1514'=>'INCORPORATOR/ORGANIZER',
										UC_ID='1518'=>'TAX PREPARER',
										UC_ID='1521'=>'BENEFIT DIRECTOR',
										UC_ID='1522'=>'BENEFIT OFFICER',
										UC_ID='3050'=>'PRINCIPAL', 
										UC_ID='3703'=>'PRESIDENT',
										UC_ID='3704'=>'VICE-PRESIDENT',
										UC_ID='3705'=>'SECRETARY',
										UC_ID='3706'=>'TREASURER',
										UC_ID='3709'=>'CEO',
										UC_ID='4050'=>'PRINCIPAL',
										UC_ID='4051'=>'TAX PREPARER',
										UC_ID='4052'=>'CONTROLLER',
										UC_ID='8070'=>'TAX PREPARER',
										UC_ID='9079'=>'TAX PREPARER',
										UC_ID='10300'=>'MEMBER',
										UC_ID='13502'=>'CONTROLLER',
										UC_ID='13504'=>'PRESIDENT',
										UC_ID='13506'=>'SECRETARY',
										UC_ID='13507'=>'TREASURER',
										UC_ID='13510'=>'INCORPORATOR/ORGANIZER',
										UC_ID='13512'=>'TAX PREPARER',
										UC_ID='30135'=>'CHAIRMAN',
										UC_ID='30300'=>'CONTROLLER',
										UC_ID='30301'=>'TAX PREPARER',
										UC_ID='37010'=>'CFO',
										UC_ID='37011'=>'CFO',
										UC_ID='65535'=>'VICE-PRESIDENT',
										UC_ID in ['260','261','262','263','264','265','266','267','268','269','270','271','272','273','274','275','276','277','278','279','280','UNKNOWN',''] =>'',
										'**|'+UC_ID);
	END;


	//********************************************************************
	//FixAddress: Returns a fixed address that is "comma delimited".
	//						This routine parses out the address for those records
	//						where the entire address exists in a single field.  This 
	//						routine trys to parse out the address/city/state/zip,
	//						for preparation of the call to â€œCorp2_Mapping.fCleanAddressâ€.
	//********************************************************************
	EXPORT FixAddress(string s) := function

			uc_s				:= corp2.t2u(s);
			revdata 		:= STD.Str.Reverse(uc_s);	//reverse the address line that contains the entire comma delimited address
																						//note: by reversing, this places the zip code first (if it exists) and then the state (if it exists)
			splitaddr		:= stringlib.splitwords(revdata,',',false); //split the address by comm
			wc 					:= stringlib.countwords(revdata,',',false); //count the words
			part1				:= STD.Str.Reverse(splitaddr[1]);  	//now re-reverse each part 
			part2				:= STD.Str.Reverse(splitaddr[2]);		//now re-reverse each part
			part3				:= STD.Str.Reverse(splitaddr[3]);		//now re-reverse each part

			tempstate1	:= stringlib.stringfilter(part1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); //see which part has the state
			tempstate2	:= stringlib.stringfilter(part2,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); //see which part has the state

			exclude1		:= STD.Str.FindReplace(revdata,  splitaddr[1],''); //keep the remaining value after excluding each part
			exclude2		:= STD.Str.FindReplace(exclude1, splitaddr[2],''); //trying to eliminate the zip code & state if it exists
			exclude3		:= STD.Str.FindReplace(exclude2, splitaddr[3],'');

			state1 			:= map(tempstate1<>'' and StateDescToCode(tempstate1)[1..2]	<>'**' => StateDescToCode(tempstate1),
												 tempstate1<>'' and StateCode(tempstate1)[1..2]				<>'**' => tempstate1,
												 ''
												);
			state2 			:= map(tempstate2<>'' and StateDescToCode(tempstate2)[1..2]	<>'**' => StateDescToCode(tempstate2),
												 tempstate2<>'' and StateCode(tempstate2)[1..2]				<>'**' => tempstate2,
												 ''
												);
			state				:= map(state1<>'' => stringlib.stringfilter(state1,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'), //based upon which part had the state, map that part
												 state2<>'' => stringlib.stringfilter(state2,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'), //based upon which part had the state, map that part
												 ''
												);
			street			:= map(state1<>'' => regexreplace('(\\,)*$',STD.Str.Reverse(exclude2),''), //remove ending "comma" if it exists
												 state2<>'' => regexreplace('(\\,)*$',STD.Str.Reverse(exclude3),''), //remove ending "comma" if it exists
												 ''
												);									
			city				:= map(state1<>'' => part2,  //based upon which part had the state, will map the next part 
												 state2<>'' => part3,	 //based upon which part had the state, will map the next part 
												 ''
												);
			zip					:= stringlib.stringfilter(part1,'0123456789'); //the numeric values in part1 are assumed to be a zip code

			//Note: The splitwords doesn't handle a "null" value so placing "NONE" as a place holder here.
			finalstreet	:= if(corp2.t2u(street) = '','NONE',corp2.t2u(street));
			finalcity		:= if(corp2.t2u(city) = '','NONE',corp2.t2u(city));
			finalstate	:= if(corp2.t2u(state) = '','NONE',corp2.t2u(state));
			finalzip		:= if(corp2.t2u(zip) = '','NONE',corp2.t2u(zip));

			RETURN finalstreet+'|'+finalcity+'|'+finalstate+'|'+finalzip;
			
	END;

	//********************************************************************
	//bad_address_List: A list of known bad addresses
	//********************************************************************
	EXPORT bad_address_List :=['X','BUSINESS ADDRESS SAME AS','SAME AS AGENT','SAME AS ABOVE','SEE PRINCIPAL OFFICE','SAME','SAAME','N/A','NONE'];

	//********************************************************************
	//FixCity: Returns a parsed out city when "not comma delimited".
	//********************************************************************
	EXPORT FixCity(STRING city, STRING addr1) := FUNCTION
	
			RETURN map(corp2.t2u(city) in bad_address_List								=> '',
								 StateDescToCode(addr1)[1..2]<>'**'									=> '',
								 StateCode(addr1)[1..2]<>'**'												=> '',															 
								 StateDescToCode(city)[1..2]<>'**'									=> '',
								 StateCode(city)[1..2]<>'**'												=> '',
								 regexfind('[0-9]{5}\\-*[0-9]{0,4}$',addr1,0) <> ''	=> regexreplace('[0-9]{5}\\-*[0-9]{0,4}$',addr1,''),
								 corp2.t2u(city)
								);
	END;
	
	//********************************************************************
	//FixZip: Returns a parsed out zip when "not comma delimited".
	//********************************************************************
	EXPORT FixZip(STRING zip, STRING addr1) := FUNCTION
			
			RETURN map(corp2.t2u(zip) in bad_address_List										=> '',
								 regexfind('[0-9]{5}\\-*[0-9]{0,4}$',addr1,0) <> ''		=> regexfind('[0-9]{5}\\-*[0-9]{0,4}$',addr1,0),
								 StateDescToCode(zip)[1..2]<>'**'											=> '',
								 StateCode(zip)[1..2]<>'**'														=> '',
								 corp2.t2u(zip)
								);
	END;


	//********************************************************************
	//CleanedAddr1: Returns a cleaned address1 when "not comma delimited".
	//********************************************************************
	EXPORT CleanedAddr1(STRING vendorzip, STRING zip, STRING addr1) := FUNCTION
			uc_addr1 := corp2.t2u(stringlib.stringfilterout(addr1,'*?><)($')); //remove question mark characters from address

			RETURN map(uc_addr1 in [bad_address_List]							=> '', //blank out addr1 if a "bad address" (e.g. SAME, NONE, etc)
								 StateDescToCode(uc_addr1)[1..2]<>'**'			=> '', //blank out addr1 if only a state desc exists
								 StateCode(uc_addr1)[1..2]<>'**'						=> '', //blank out addr1 if only a state code exists
								 regexfind(' SAME AS ABOVE$',uc_addr1,0)<>''=> regexreplace(' SAME AS ABOVE$',uc_addr1,''), //remove "same as above" from the end of addr1
								 corp2.t2u(vendorzip)='' and zip<>''				=> regexreplace(zip,uc_addr1,''), //remove zip from addr1
								 uc_addr1
								);	
	END;

	//********************************************************************
	//FixState: Returns a parsed out state when "not comma delimited".
	//********************************************************************
	EXPORT FixState(STRING vendorzip, STRING zip, STRING state, STRING addr1) := FUNCTION			
			temp_add1													:= CleanedAddr1(vendorzip,zip,addr1);	//retrieve a "cleaned" addr1
			
			LastWord													:= STD.STR.GetNthWord(temp_add1,STD.STR.CountWords(temp_add1,' ')); //get the last word in addr1
			Last2Words												:= STD.STR.GetNthWord(temp_add1,STD.STR.CountWords(temp_add1,' ')-1) + ' ' + LastWord; //get the next to last word in addr1
			
			LastWordFound1										:= if(StateDescToCode(LastWord)[1..2]<>'**',StateDescToCode(LastWord),''); //check if the last word is a state description
			LastWordFound2										:= if(StateCode(LastWord)[1..2]<>'**',StateCode(LastWord),''); //check if the last word is a state code

			Last2WordsFound1									:= if(StateDescToCode(Last2Words)[1..2]<>'**',StateDescToCode(Last2Words),''); //check if the last two words is a state description
			Last2WordsFound2									:= if(StateCode(Last2Words)[1..2]<>'**',StateCode(Last2Words),''); //check if the last two words is a state code.

			RETURN map(corp2.t2u(state) in bad_address_List													=> '', //blank out state if a "bad state" (e.g. SAME, NONE, etc)
								 StateDescToCode(addr1)[1..2]<>'**'														=> StateDescToCode(addr1), //map state if addr1 contains only a state description
								 StateCode(addr1)[1..2]<>'**'																	=> StateCode(addr1), //map state if addr1 contains only a state code
								 LastWordFound1 <> ''																					=> stringlib.stringfilter(corp2.t2u(LastWordFound1),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'), //map the last word if it is a state description
								 LastWordFound2 <> ''																					=> stringlib.stringfilter(corp2.t2u(LastWordFound2),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'), //map the last word if it is a state code
								 Last2WordsFound1 <> ''																				=> stringlib.stringfilter(corp2.t2u(Last2WordsFound1),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'), //map the last two words if it is a state description
								 Last2WordsFound2 <> ''																				=> stringlib.stringfilter(corp2.t2u(Last2WordsFound2),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'), //map the last two words if it is a state code
								 StateDescToCode(state)[1..2]<>'**'														=> StateDescToCode(state), //if a state description exists, map if a valid state
								 StateCode(state)[1..2]<>'**'																	=> StateCode(state), //if a state code exists, map if a valid state
								 corp2.t2u(stringlib.stringfilter(state,' 0123456789')) = '' 	=> '', //blank out state if all digits 								 
								 stringlib.stringfilter(corp2.t2u(state),' ABCDEFGHIJKLMNOPQRSTUVWXYZ') //otherwise, map state (remove all digits and special characters
								);
	END;
	
	//********************************************************************
	//FixAddr1: Returns a parsed out address1/city when "not comma delimited".
	//********************************************************************
	EXPORT FixAddr1(STRING vendorzip, STRING zip, STRING vendorstate, STRING state, STRING addr1) := FUNCTION
			
			end_of_addr_pattern 							:= ' AVENUE | AVE | BUILDING | BLDG | BLVD | BOULEVARD | BROADWAY | COVE | DRIVE | DR | FLOOR | LANE | PARKWAY | PLACE | PLAZA | ROAD | RD| STREET | ST | TOWER | WAY ';

			temp_add1													:= CleanedAddr1(vendorzip,zip,addr1);	//retrieve a "cleaned" addr1

			LastWord													:= STD.STR.GetNthWord(temp_add1,STD.STR.CountWords(temp_add1,' ')); //get the last word in addr1
			Last2Words												:= STD.STR.GetNthWord(temp_add1,STD.STR.CountWords(temp_add1,' ')-1) + ' ' + LastWord; //get the next to last word in addr1

			LastWordFound1										:= if(StateDescToCode(LastWord)[1..2]<>'**',StateDescToCode(LastWord),''); //check if the last word is a state description
			LastWordFound2										:= if(StateCode(LastWord)[1..2]<>'**',StateCode(LastWord),''); //check if the last word is a state code

			Last2WordsFound1									:= if(StateDescToCode(Last2Words)[1..2]<>'**',StateDescToCode(Last2Words),''); //check if the last two words is a state description
			Last2WordsFound2									:= if(StateCode(Last2Words)[1..2]<>'**',StateCode(Last2Words),''); //check if the last two words is a state code.

			RemoveStateInAddr1								:= if(corp2.t2u(vendorstate)='' and state<>'', //if the raw data had a blank state but state existed in addr1, then remove state from addr1
																							map(Last2WordsFound1 <> '' and Last2WordsFound1 <> Last2Words		=> regexreplace(Last2Words+'$',corp2.t2u(temp_add1),''), //e.g. NEW YORK and NY			
																									LastWordFound1 	 <> '' or LastWordFound2 	  <> ''						=> regexreplace(LastWord+'$',corp2.t2u(temp_add1),''),
																									Last2WordsFound1 <> '' or Last2WordsFound2  <> ''  					=> regexreplace(Last2Words+'$',corp2.t2u(temp_add1),''),
																									temp_add1
																									),
																							temp_add1
																						 );
																						 
			splitaddr		:= stringlib.splitwords(RemoveStateInAddr1,' ',false);
			wc 					:= stringlib.countwords(RemoveStateInAddr1,' ',false); //word count
			
			address			:= if(corp2.t2u(vendorstate)='' and state<>'', //if the raw data had a blank state but state existed in addr1, then remove state from addr1
												map(Last2WordsFound1 <> '' and Last2WordsFound1 <> Last2Words		=> regexreplace(Last2Words+'$',corp2.t2u(temp_add1),''), //e.g. NEW YORK and NY			
														LastWordFound1 	 <> '' or LastWordFound2 	  <> ''						=> regexreplace(LastWord+'$',corp2.t2u(temp_add1),''),
														Last2WordsFound1 <> '' or Last2WordsFound2  <> ''  					=> regexreplace(Last2Words+'$',corp2.t2u(temp_add1),''),
														temp_add1
														),
												temp_add1
											 );
		
			eoa						:= regexfind(end_of_addr_pattern,address,0);//see if an "end of address" word exists
			eoa_length  	:= length(eoa); //get length of "end of address" word
			eoa_loc 			:= STD.Str.Find(address,eoa,1); //get location of "end of address" word
			
			temp_addr1		:= if(eoa_length<>0,address[1..eoa_loc+eoa_length-1],address); 
			temp_city			:= if(eoa_length<>0,address[eoa_loc+eoa_length..],'');
			//Reversing the city in order to find the first position a numeric value occurs
			reverse_city	:= if(corp2.t2u(temp_city)<>'',STD.Str.Reverse(temp_city),STD.Str.Reverse(temp_addr1));
			//Checking for digits within the city; represents suite numbers that belong to the address
			//The regexfind returns the numeric value that it finds (the value is returned in reverse order), if it exists
			digits_in_city:= regexfind('[0-9]{1,}',reverse_city,0);
			//If digits are found in the city, the city starts in position 1 to the location where the digits were found(minus 1)
			//Note:  the reversing of the city here returns the city with the correct name
			ReverseCity		:= if(digits_in_city<>'',STD.Str.Reverse(reverse_city[1..STD.Str.Find(reverse_city,digits_in_city,1)-1]),STD.Str.Reverse(reverse_city));
			//If digits are found in the city, the "suite" information belongs to the street and is concatenated to the address
			//Note:  the reversing of the "suite" information here returns the information in the correct order
			ReverseStreet	:= if(digits_in_city<>'',
													map(corp2.t2u(temp_city)='' =>STD.Str.Reverse(reverse_city[STD.Str.Find(reverse_city,digits_in_city,1)..]),
															temp_addr1 + STD.Str.Reverse(reverse_city[STD.Str.Find(reverse_city,digits_in_city,1)..])
															),
													temp_addr1
												 );
			//if only digits exist in the street address, then not a suite number													 
			finaladdr1		:= if(STD.Str.Filter(corp2.t2u(ReverseStreet),'ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '',temp_addr1,corp2.t2u(ReverseStreet));
			finalcity			:= if(STD.Str.Filter(corp2.t2u(ReverseStreet),'ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '','',corp2.t2u(ReverseCity));

			RETURN finaladdr1+'|'+finalcity;
	END;
							 
END;		
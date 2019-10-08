IMPORT corp2, corp2_mapping, ut;

EXPORT Functions := MODULE
	
	//********************************************************************
		//Forgn_State_Code: Returns state codes  (corp_forgn_state_cd)
	//********************************************************************	
	EXPORT Forgn_State_Code(STRING code) :=FUNCTION
		st  := corp2.t2u(code);
		RETURN MAP (// Map only if it's a US state or territory (except Georgia), else blank it out.  DF-25656
								st in ['AL','ALABAMA'] 						  => 'AL',
								st in ['AK','ALASKA'] 						  => 'AK', 
								st in ['AS','AMERICAN SAMOA'] 			=> 'AS',
								st in ['AZ','ARIZONA'] 						  => 'AZ',
								st in ['AT','ARKANSAS'] 					  => 'AR',
								st in ['CA','CALIFORNIA'] 					=> 'CA',
								st in ['CO','COLORADO'] 					  => 'CO',
								st in ['CT','CONNECTICUT'] 					=> 'CT',
								st in ['DE','DELAWARE'] 						=> 'DE',
								st in ['DC','DISTRICT OF COLUMBIA']	=> 'DC',
								st in ['FL','FLORIDA'] 							=> 'FL',
								st in ['GU','GUAM'] 								=> 'GU',
								st in ['HI','HAWAII'] 							=> 'HI',
								st in ['ID','IDAHO'] 							 	=> 'ID',
								st in ['IL','ILLINOIS'] 						=> 'IL',
								st in ['IN','INDIANA'] 							=> 'IN',
								st in ['IA','IOWA'] 							 	=> 'IA',
								st in ['KS','KANSAS'] 							=> 'KS',
								st in ['KY','KENTUCKY'] 						=> 'KY',
								st in ['LA','LOUISIANA'] 						=> 'LA',
								st in ['ME','MAINE'] 								=> 'ME',
								st in ['MD','MARYLAND'] 						=> 'MD',
								st in ['MA','MASSACHUSETTS'] 				=> 'MA',
								st in ['MI','MICHIGAN'] 						=> 'MI',
								st in ['MN','MINNESOTA'] 						=> 'MN',
								st in ['MS','MISSISSIPPI'] 					=> 'MS',
								st in ['MO','MISSOURI'] 						=> 'MO',
								st in ['MT','MONTANA'] 							=> 'MT',
								st in ['NE','NEBRASKA'] 						=> 'NE',
								st in ['NV','NEVADA'] 							=> 'NV',
								st in ['NH','NEW HAMPSHIRE'] 				=> 'NH',
								st in ['NJ','NEW JERSEY'] 					=> 'NJ',
								st in ['NM','NEW MEXICO'] 					=> 'NM',
								st in ['NY','NEW YORK'] 						=> 'NY',
								st in ['NC','NORTH CAROLINA'] 			=> 'NC',
								st in ['OD','NORTH DAKOTA'] 				=> 'ND',  
								st in ['OH','OHIO'] 								=> 'OH',
								st in ['OK','OKLAHOMA'] 						=> 'OK',
								st in ['OR','OREGON'] 							=> 'OR',
								st in ['PA','PENNSYLVANIA'] 				=> 'PA',
								st in ['PR','PUERTO RICO'] 					=> 'PR',
								st in ['RI','RHODE ISLAND'] 				=> 'RI',
								st in ['SC','SOUTH CAROLINA'] 			=> 'SC',
								st in ['SD','SOUTH DAKOTA'] 				=> 'SD',
								st in ['TN','TENNESSEE'] 						=> 'TN',
								st in ['TX','TEXAS'] 								=> 'TX',
								st in ['US','UNITED STATES'] 				=> 'US',
								st in ['UT','UTAH'] 							 	=> 'UT',
								st in ['VT','VERMONT'] 							=> 'VT',
								st in ['VI','VIRGIN ISLANDS'] 			=> 'VI',
								st in ['VA','VIRGINIA'] 						=> 'VA',
								st in ['WA','WASHINGTON'] 					=> 'WA',
								st in ['WV','WEST VIRGINIA'] 				=> 'WV',
								st in ['WI','WISCONSIN'] 						=> 'WI',
								st in ['WY','WYOMING'] 							=> 'WY',
								'');
	End;
	
	//************************************************************************
		//Forgn_State_Desc: Returns state descriptions  (corp_forgn_state_desc)
	//************************************************************************	
	EXPORT  STRING Forgn_State_Desc(STRING state) := FUNCTION
		st  := corp2.t2u(state);
		RETURN MAP (// Map only if it's a US state or territory (except Georgia), else blank it out.  DF-25656
								st in ['AL','ALABAMA'] 														  => 'ALABAMA',
								st in ['AK','ALASKA'] 						 								  => 'ALASKA', 
								st in ['AS','AMERICAN SAMOA'] 											=> 'AMERICAN SAMOA',
								st in ['AZ','ARIZONA'] 						  								=> 'ARIZONA',
								st in ['AR','ARKANSAS'] 					  								=> 'ARKANSAS',
								st in ['CA','CALIFORNIA'] 													=> 'CALIFORNIA',
								st in ['CO','COLORADO'] 					 								  => 'COLORADO',
								st in ['CT','CONNECTICUT'] 													=> 'CONNECTICUT',
								st in ['DE','DELAWARE'] 														=> 'DELAWARE',
								st in ['DC','DISTRICT OF COLUMBIA']									=> 'DISTRICT OF COLUMBIA',
								st in ['FL','FLORIDA'] 															=> 'FLORIDA',
								st in ['GU','GUAM'] 																=> 'GUAM',
								st in ['HI','HAWAII'] 															=> 'HAWAII',
								st in ['ID','IDAHO'] 															 	=> 'IDAHO',
								st in ['IL','ILLINOIS'] 														=> 'ILLINOIS',
								st in ['IN','INDIANA'] 															=> 'INDIANA',
								st in ['IA','IOWA'] 															 	=> 'IOWA',
								st in ['KS','KANSAS'] 															=> 'KANSAS',
								st in ['KY','KENTUCKY'] 														=> 'KENTUCKY',
								st in ['LA','LOUISIANA'] 														=> 'LOUISIANA',
								st in ['ME','MAINE'] 																=> 'MAINE',
								st in ['MD','MARYLAND'] 														=> 'MARYLAND',
								st in ['MA','MASSACHUSETTS'] 												=> 'MASSACHUSETTS',
								st in ['MI','MICHIGAN'] 														=> 'MICHIGAN',
								st in ['MN','MINNESOTA'] 														=> 'MINNESOTA',
								st in ['MS','MISSISSIPPI'] 													=> 'MISSISSIPPI',
								st in ['MO','MISSOURI'] 														=> 'MISSOURI',
								st in ['MT','MONTANA'] 															=> 'MONTANA',
								st in ['NE','NEBRASKA'] 														=> 'NEBRASKA',
								st in ['NV','NEVADA'] 															=> 'NEVADA',
								st in ['NH','NEW HAMPSHIRE'] 												=> 'NEW HAMPSHIRE',
								st in ['NJ','NEW JERSEY'] 													=> 'NEW JERSEY',
								st in ['NM','NEW MEXICO'] 													=> 'NEW MEXICO',
								st in ['NY','NEW YORK'] 														=> 'NEW YORK',
								st in ['NC','NORTH CAROLINA'] 											=> 'NORTH CAROLINA',
								st in ['ND','NORTH DAKOTA'] 												=> 'NORTH DAKOTA',  
								st in ['OH','OHIO'] 																=> 'OHIO',
								st in ['OK','OKLAHOMA'] 														=> 'OKLAHOMA',
								st in ['OR','OREGON'] 															=> 'OREGON',
								st in ['PA','PENNSYLVANIA'] 												=> 'PENNSYLVANIA',
								st in ['PR','PUERTO RICO'] 													=> 'PUERTO RICO',
								st in ['RI','RHODE ISLAND'] 												=> 'RHODE ISLAND',
								st in ['SC','SOUTH CAROLINA'] 											=> 'SOUTH CAROLINA',
								st in ['SD','SOUTH DAKOTA'] 												=> 'SOUTH DAKOTA',
								st in ['TN','TENNESSEE'] 														=> 'TENNESSEE',
								st in ['TX','TEXAS'] 																=> 'TEXAS',
								st in ['US','UNITED STATES'] 												=> 'UNITED STATES',
								st in ['UT','UTAH'] 							 									=> 'UTAH',
								st in ['VT','VERMONT'] 															=> 'VERMONT',
								st in ['VI','VIRGIN ISLANDS'] 											=> 'VIRGIN ISLANDS',
								st in ['VA','VIRGINIA'] 														=> 'VIRGINIA',
								st in ['WA','WASHINGTON'] 													=> 'WASHINGTON',
								st in ['WV','WEST VIRGINIA'] 												=> 'WEST VIRGINIA',
								st in ['WI','WISCONSIN'] 														=> 'WISCONSIN',
								st in ['WY','WYOMING'] 															=> 'WYOMING',
								'');
	END;

	//************************************************************************
		//formationCountry: Returns country descriptions (corp_country_of_formation)
	//************************************************************************								
	EXPORT formationCountry(STRING fState, STRING fCountry) := FUNCTION
				 uc_s     := corp2.t2u(fState);
				 uc_c     := corp2.t2u(fCountry);
				 
				 USstates := ['AL','ALABAMA',	 			'AK','ALASKA', 					'AZ','ARIZONA',			'AR','ARKANSAS', 	
											'CA','CALIFORNIA',		'CO','COLORADO',			  'CT','CONNECTICUT',	'DE','DELAWARE', 	
											'DC','DISTRICT OF COLUMBIA','FL','FLORIDA',		'GA','GEORGIA',			'HI','HAWAII', 		
											'ID','IDAHO',				 	'IL','ILLINOIS',				'IN','INDIANA',			'IA','IOWA',	
											'KS','KANSAS',				'KY','KENTUCKY',				'LA','LOUISIANA',		'ME','MAINE',	
											'MD','MARYLAND',		  'MA','MASSACHUSETTS',		'MI','MICHIGAN',		'MN','MINNESOTA',
											'MS','MISSISSIPPI',		'MO','MISSOURI',				'MT','MONTANA',			'NE','NEBRASKA',
											'NV','NEVADA',				'NH','NEW HAMPSHIRE',		'NJ','NEW JERSEY',	'NM','NEW MEXICO',	
											'NY','NEW YORK',			'NC','NORTH CAROLINA',	'ND','NORTH DAKOTA','OH','OHIO',	
											'OK','OKLAHOMA',		 	'OR','OREGON',					'PA','PENNSYLVANIA','RI','RHODE ISLAND',
											'SC','SOUTH CAROLINA','SD','SOUTH DAKOTA',		'TN','TENNESSEE',		'TX','TEXAS',		
											'US','UNITED STATES',	'UT','UTAH',						'VT','VERMONT',			'VA','VIRGINIA',
											'WA','WASHINGTON',		'WV','WEST VIRGINIA',		'WI','WISCONSIN',		'WY','WYOMING'];				 
		     
				 // Sometimes a country name is in foreignstate.  Here are the values received that way to date:
				 selectCountries :=['ARMED FORCES EUROPE',		'AUSTRALIA',				'BAHAMAS, THE',						'BELGIUM',
														'BELIZE',									'BENIN',						'BERMUDA',								'BRAZIL',
														'BRITISH VIRGIN ISLANDS',	'CAMEROON',					'CANADA',									'CAYMAN ISLANDS',
														'CHILE',									'CHINA',						'COLOMBIA',								'COSTA RICA',
														'DENMARK',								'DOMINICAN REPUBLIC','ETHIOPIA',							'FRANCE',
														'GERMANY',								'GHANA',						'GUAM',										'GUATEMALA',
														'HAITI',									'HONG KONG S.A.R.',	'INDIA',									'IRAN',
														'ISRAEL',									'ITALY',						'JAMAICA',								'JORDAN',
														'KENYA',									'KOREA, SOUTH',			'LIBERIA',								'MALTA',
														'MARSHALL ISLANDS',				'MEXICO',						'MOROCCO',								'NAVAJO NATION',
														'NETHERLANDS',						'NEW ZEALAND',			'NIGERIA',								'NORWAY',
														'PANAMA',									'PHILIPPINES',			'PORTUGAL',								'PUERTO RICO',
														'ROMANIA',								'RUSSIA',						'SAINT KITTS AND NEVIS',	'SAMOA',
														'SENEGAL',								'SINGAPORE',				'SOUTH AFRICA',						'SPAIN',
														'SWEDEN',									'SWITZERLAND',			'TRINIDAD AND TOBAGO',		'TURKEY',
														'UNITED ARAB EMIRATES',		'UNITED KINGDOM',		'UNITED STATES VIRGIN ISLANDS','URUGUAY',
														'VENEZUELA',							'VIETNAM',					'WINNEBAGO TRIBE OF NEBRASKA'];
				 unknowns        :=['CIU','UNK','CIN','NEV'];
				 
				 RETURN MAP(uc_c = ''          and uc_s = ''          			=> '',
										uc_c = ''          and uc_s in USstates     		=> 'US',
				            uc_c = 'USA'       and uc_s in [USstates,'']  	=> 'US',
										uc_c in unknowns   and uc_s in USstates         => 'US',
										uc_c = ''          and uc_s = 'BAHAMAS, THE'    => 'BAHAMAS',
										uc_c = 'ECUADOR'   and uc_s = 'CANADA'          => 'CANADA',
										uc_c in ['','USA'] and uc_s = 'KOREA, SOUTH'    => 'SOUTH KOREA',
								    uc_c in ['','USA'] and uc_s in selectCountries	=> uc_s,

										// Below, map country names and abbreviations received to date in foreigncountry
										uc_c in ['AFGHANISTAN']  												=> 'AFGHANISTAN',
										uc_c in ['AFRICA','AF']  												=> 'AFRICA',
										uc_c in ['ALBANIA']  														=> 'ALBANIA',
										uc_c in ['ALBERTA','AB']  											=> 'ALBERTA, CANADA',
										uc_c in ['ALGERIA']  														=> 'ALGERIA',
										uc_c in ['ANDORRA']  														=> 'ANDORRA',
										uc_c in ['ANGOLA']  														=> 'ANGOLA',
										uc_c in ['ANTIGUA AND BARBUDA','AG','ATG']  		=> 'ANTIGUA AND BARBUDA',
										uc_c in ['ARGENTINA']  													=> 'ARGENTINA',
										uc_c in ['ARMED FORCES AFRICA, CANADA, EUROPE, OR MIDDLE EAST','AE'] => 'ARMED FORCES AFRICA, CANADA, EUROPE, OR MIDDLE EAST',
										uc_c in ['ARMED FORCES AMERICAS EXCEPT CANADA','AA'] => 'ARMED FORCES AMERICAS EXCEPT CANADA',
										uc_c in ['ARMED FORCES EUROPE']  								=> 'ARMED FORCES EUROPE',
										uc_c in ['ARMED FORCES PACIFIC','AP']  					=> 'ARMED FORCES PACIFIC',
										uc_c in ['ARMENIA']  														=> 'ARMENIA',
										uc_c in ['ARUBA','AW']  												=> 'ARUBA',
										uc_c in ['AUSTRALIA','AU','AUS']  							=> 'AUSTRALIA',
										uc_c in ['AUSTRIA','AUT']  											=> 'AUSTRIA',
										uc_c in ['AZERBAIJAN']  												=> 'AZERBAIJAN',
										uc_c in ['BAHAMAS','BAH','BHS','BS','BAHAMAS, THE']	=> 'BAHAMAS',
										uc_c in ['BAHRAIN']  														=> 'BAHRAIN',
										uc_c in ['BANGLADESH','BGD']  									=> 'BANGLADESH',
										uc_c in ['BARBADOS','BB','BR','BRB']  					=> 'BARBADOS',
										uc_c in ['BELARUS']  														=> 'BELARUS',
										uc_c in ['BELGIUM','BEL','BL']  								=> 'BELGIUM',
										uc_c in ['BELIZE','BLZ']  											=> 'BELIZE',
										uc_c in ['BENIN']  															=> 'BENIN',
										uc_c in ['BERMUDA','BM','BER','BMU','BRM']  		=> 'BERMUDA',
										uc_c in ['BHUTAN']  														=> 'BHUTAN',
										uc_c in ['BOLIVIA']  														=> 'BOLIVIA',
										uc_c in ['BOSNIA AND HERZEGOVINA']  						=> 'BOSNIA AND HERZEGOVINA',
										uc_c in ['BOTSWANA']  													=> 'BOTSWANA',
										uc_c in ['BRAZIL','BRA']  											=> 'BRAZIL',
										uc_c in ['BRITISH COLUMBIA','BC']  							=> 'BRITISH COLUMBIA',
										uc_c in ['BRITISH INDIAN OCEAN TERRITORY','IOT'] => 'BRITISH INDIAN OCEAN TERRITORY',
										uc_c in ['BRITISH VIRGIN ISLANDS','BVI','VGB', 'VG'] => 'BRITISH VIRGIN ISLANDS',
										uc_c in ['BRITISH WEST INDIES','BW']  					=> 'BRITISH WEST INDIES',
										uc_c in ['BRUNEI']  														=> 'BRUNEI',
										uc_c in ['BULGARIA','BGR']  										=> 'BULGARIA',
										uc_c in ['BURKINA FASO']  											=> 'BURKINA FASO',
										uc_c in ['BURMA']  															=> 'BURMA',
										uc_c in ['BURUNDI','BDI']  											=> 'BURUNDI',
										uc_c in ['CABO VERDE']  												=> 'CABO VERDE',
										uc_c in ['CAMBODIA','KHM']  										=> 'CAMBODIA',
										uc_c in ['CAMEROON']  													=> 'CAMEROON',
										uc_c in ['CANADA','CAN','CN','CD']  						=> 'CANADA',
										uc_c in ['CANAL ZONE','CZ']  										=> 'CANAL ZONE',
										uc_c in ['CAYMAN ISLANDS','CAY','CYM']  				=> 'CAYMAN ISLANDS',
										uc_c in ['CENTRAL AFRICAN REPUBLIC','CAR'] 			=> 'CENTRAL AFRICAN REPUBLIC',
										uc_c in ['CHAD']  															=> 'CHAD',
										uc_c in ['CHILE','CHL']  												=> 'CHILE',
										uc_c in ['CHINA','CH','CHN']  									=> 'CHINA',
										uc_c in ['COLOMBIA','CB','COL']  								=> 'COLOMBIA',
										uc_c in ['DOMINICAN REPUBLIC','DOM']  					=> 'DOMINICAN REPUBLIC',
										uc_c in ['COMOROS']  														=> 'COMOROS',
										uc_c in ['CONGO','COG']  												=> 'CONGO',
										uc_c in ['COOK ISLANDS','CI','COK']  						=> 'COOK ISLANDS',
										uc_c in ['COSTA RICA','CRI']  									=> 'COSTA RICA',
										uc_c in ['COTE D\'IVOIRE','CIV']  							=> 'COTE D\'IVOIRE',
										uc_c in ['CROATIA']  														=> 'CROATIA',
										uc_c in ['CUBA']  															=> 'CUBA',
										uc_c in ['CYPRUS','CYP']  											=> 'CYPRUS',
										uc_c in ['CZECH REPUBLIC','CZE']  							=> 'CZECH REPUBLIC',
										uc_c in ['CZECHIA']  														=> 'CZECHIA',
										uc_c in ['DENMARK','DEN','DNK']  								=> 'DENMARK',
										uc_c in ['DJIBOUTI']  													=> 'DJIBOUTI',
										uc_c in ['DOMINICA']  													=> 'DOMINICA',
										uc_c in ['ECUADOR','ECU']  											=> 'ECUADOR',
										uc_c in ['EGYPT','EGY']  												=> 'EGYPT',
										uc_c in ['EL SALVADOR']  												=> 'EL SALVADOR',
										uc_c in ['ENGLAND','ENG']  											=> 'ENGLAND',
										uc_c in ['EQUATORIAL GUINEA'] 									=> 'EQUATORIAL GUINEA',
										uc_c in ['ERITREA']  														=> 'ERITREA',
										uc_c in ['ESTONIA']  														=> 'ESTONIA',
										uc_c in ['ESWATINI']  													=> 'ESWATINI',
										uc_c in ['ETHIOPIA']  													=> 'ETHIOPIA',
										uc_c in ['EUROPE','EU']  												=> 'EUROPE',
										uc_c in ['FEDERATED STATES OF MICRONESIA','FM'] => 'FEDERATED STATES OF MICRONESIA',
										uc_c in ['FIJI']  															=> 'FIJI',
										uc_c in ['FINLAND','FIN']  											=> 'FINLAND',
										uc_c in ['FRANCE','FR','FRA']  									=> 'FRANCE',
										uc_c in ['GABON']  															=> 'GABON',
										uc_c in ['GAMBIA']  														=> 'GAMBIA',
										uc_c in ['GEORGIA']  														=> 'GEORGIA',
										uc_c in ['GERMANY','DEU','GR','GER']  					=> 'GERMANY',
										uc_c in ['GHANA','GHA']  												=> 'GHANA',
										uc_c in ['GREAT BRITAIN','GB','GBR']  					=> 'GREAT BRITAIN',
										uc_c in ['GREECE','GRC','GRE']  								=> 'GREECE',
										uc_c in ['GRENADA']  														=> 'GRENADA',
										uc_c in ['GUAM','GU','GUM']  										=> 'GUAM',
										uc_c in ['GUATEMALA','GTM']  										=> 'GUATEMALA',
										uc_c in ['GUINEA']  														=> 'GUINEA',
										uc_c in ['GUINEA-BISSAU']  											=> 'GUINEA-BISSAU',
										uc_c in ['GUYANA']  														=> 'GUYANA',
										uc_c in ['HAITI','HTI']  												=> 'HAITI',
										uc_c in ['HONDURAS','HON']  										=> 'HONDURAS',
										uc_c in ['HONG KONG S.A.R.']  									=> 'HONG KONG S.A.R.',
										uc_c in ['HONG KONG','HK','HKG']  							=> 'HONG KONG',
										uc_c in ['HUNGARY','HUN']  											=> 'HUNGARY',
										uc_c in ['ICELAND','ISL']  											=> 'ICELAND',
										uc_c in ['INDIA','II','IND']  									=> 'INDIA',
										uc_c in ['INDONESIA','IDN']  										=> 'INDONESIA',
										uc_c in ['IRAN']  															=> 'IRAN',
										uc_c in ['IRAQ']  															=> 'IRAQ',
										uc_c in ['IRELAND','IE','IRE','IRL']  					=> 'IRELAND',
										uc_c in ['ISRAEL','ISR']  											=> 'ISRAEL',
										uc_c in ['ITALY','IT','ITA']  									=> 'ITALY',
										uc_c in ['JAMAICA','JM','JAM']  								=> 'JAMAICA',
										uc_c in ['JAPAN','JA','JP','JAP','JPN']  				=> 'JAPAN',
										uc_c in ['JORDAN']  														=> 'JORDAN',
										uc_c in ['KAZAKHSTAN','KAZ']  									=> 'KAZAKHSTAN',
										uc_c in ['KENYA','KEN']  												=> 'KENYA',
										uc_c in ['KIRIBATI']  													=> 'KIRIBATI',
										uc_c in ['KOREA','KOR']  												=> 'KOREA',
										uc_c in ['KOSOVO']  														=> 'KOSOVO',
										uc_c in ['KUWAIT']  														=> 'KUWAIT',
										uc_c in ['KYRGYZSTAN']  												=> 'KYRGYZSTAN',
										uc_c in ['LAO PEOPLES DEMOCRATIC REPUBLIC','LAO']	=> 'LAO PEOPLES DEMOCRATIC REPUBLIC',
										uc_c in ['LAOS']  															=> 'LAOS',
										uc_c in ['LATVIA']  														=> 'LATVIA',
										uc_c in ['LEBANON']  														=> 'LEBANON',
										uc_c in ['LESOTHO']  														=> 'LESOTHO',
										uc_c in ['LIBERIA','LBR']  											=> 'LIBERIA',
										uc_c in ['LIBYA','LIB']  												=> 'LIBYA',
										uc_c in ['LIECHTENSTEIN','LIE']  								=> 'LIECHTENSTEIN',
										uc_c in ['LITHUANIA']  													=> 'LITHUANIA',
										uc_c in ['LUXEMBOURG','LUX','LX']  							=> 'LUXEMBOURG',
										uc_c in ['MACEDONIA']  													=> 'MACEDONIA',
										uc_c in ['MADAGASCAR']  												=> 'MADAGASCAR',
										uc_c in ['MALAWI']  														=> 'MALAWI',
										uc_c in ['MALAYSIA']  													=> 'MALAYSIA',
										uc_c in ['MALDIVES','MV']  											=> 'MALDIVES',
										uc_c in ['MALI','MLI']  												=> 'MALI',
										uc_c in ['MALTA']  															=> 'MALTA',
										uc_c in ['MARSHALL ISLANDS','MH','MHL'] 				=> 'MARSHALL ISLANDS',
										uc_c in ['MARTINIQUE','MTQ']  									=> 'MARTINIQUE',
										uc_c in ['MAURITANIA'] 													=> 'MAURITANIA',
										uc_c in ['MAURITIUS','MUS']  										=> 'MAURITIUS',
										uc_c in ['MAYOTTE']  														=> 'MAYOTTE',
										uc_c in ['MEXICO','MEX','MX']  									=> 'MEXICO',
										uc_c in ['MICRONESIA']  												=> 'MICRONESIA',
										uc_c in ['MOLDOVA']  														=> 'MOLDOVA',
										uc_c in ['MONACO']  														=> 'MONACO',
										uc_c in ['MONGOLIA']  													=> 'MONGOLIA',
										uc_c in ['MONTENEGRO']  												=> 'MONTENEGRO',
										uc_c in ['MOROCCO']  														=> 'MOROCCO',
										uc_c in ['MOZAMBIQUE']  												=> 'MOZAMBIQUE',
										uc_c in ['MYANMAR']  														=> 'MYANMAR ',
										uc_c in ['NAMIBIA','NA']  											=> 'NAMIBIA',
										uc_c in ['NAURU']  															=> 'NAURU',
										uc_c in ['NAVAJO NATION']  											=> 'NAVAJO NATION',
										uc_c in ['NEPAL','NPL']  												=> 'NEPAL',
										uc_c in ['NETHERLANDS ANTILLES','ANT']  				=> 'NETHERLANDS ANTILLES',
										uc_c in ['NETHERLANDS','NET','NLD','NTH','NL']	=> 'NETHERLANDS',
										uc_c in ['NEW ZEALAND','NZL']  									=> 'NEW ZEALAND',
										uc_c in ['NICARAGUA']  													=> 'NICARAGUA',
										uc_c in ['NIGER']  															=> 'NIGER',
										uc_c in ['NIGERIA','NGA']  											=> 'NIGERIA',
										uc_c in ['NORTH KOREA']  												=> 'NORTH KOREA',
										uc_c in ['NORTH MACEDONIA']  										=> 'NORTH MACEDONIA',
										uc_c in ['NORTHERN MARIANA ISLANDS','MP']  			=> 'NORTHERN MARIANA ISLANDS',
										uc_c in ['NORWAY','NOR']  											=> 'NORWAY',
										uc_c in ['NOVA SCOTIA, CANADA','NS']  					=> 'NOVA SCOTIA, CANADA',
										uc_c in ['OMAN']  															=> 'OMAN',
										uc_c in ['ONTARIO','ONT','ON']  								=> 'ONTARIO, CANADA',
										uc_c in ['OTHER ASIA','OA']  										=> 'OTHER ASIA',
										uc_c in ['OTHER S&C AMERICAN','SA']  						=> 'OTHER S&C AMERICAN',
										uc_c in ['OUT OF COUNTRY','OC']  								=> 'OUT OF COUNTRY',
										uc_c in ['PAKISTAN','PK','PAK']  								=> 'PAKISTAN',
										uc_c in ['PALAU']  															=> 'PALAU',
										uc_c in ['PALESTINE']  													=> 'PALESTINE',
										uc_c in ['PANAMA','PAN','PN']  									=> 'PANAMA',
										uc_c in ['PAPUA NEW GUINEA']  									=> 'PAPUA NEW GUINEA',
										uc_c in ['PARAGUAY','PY']  											=> 'PARAGUAY',
										uc_c in ['PERU','PER']  												=> 'PERU',
										uc_c in ['PHILIPPINES','PH','PHL']  						=> 'PHILIPPINES',
										uc_c in ['PITCAIRN','PN']  											=> 'PITCAIRN',
										uc_c in ['POLAND','PL','POL']  									=> 'POLAND',
										uc_c in ['PORTUGAL','PRT']  										=> 'PORTUGAL',
										uc_c in ['PUERTO RICO','PR','PRI']  						=> 'PUERTO RICO',
										uc_c in ['QATAR','QAT']  												=> 'QATAR',
										uc_c in ['QUEBEC','QUE','QC']  									=> 'QUEBEC',
										uc_c in ['ROMANIA','ROM']  											=> 'ROMANIA',
										uc_c in ['RUSSIA','RUS']  											=> 'RUSSIA',
										uc_c in ['RWANDA']  														=> 'RWANDA',
										uc_c in ['SAINT KITTS AND NEVIS','KNA']  				=> 'SAINT KITTS AND NEVIS',
										uc_c in ['SAINT LUCIA','LCA']  									=> 'SAINT LUCIA',
										uc_c in ['SAINT MARTIN FRENCH PART','MF'] 			=> 'SAINT MARTIN FRENCH PART',
										uc_c in ['SAINT VINCENT AND THE GRENADINES','VCT'] => 'SAINT VINCENT AND THE GRENADINES',
										uc_c in ['SAMOA']  															=> 'SAMOA',
										uc_c in ['SAN MARINO']  												=> 'SAN MARINO',
										uc_c in ['SAO TOME AND PRINCIPE']  							=> 'SAO TOME AND PRINCIPE',
										uc_c in ['SAUDI ARABIA']  											=> 'SAUDI ARABIA',
										uc_c in ['SCOTLAND','SL']  											=> 'SCOTLAND',
										uc_c in ['SENEGAL','SEN']  											=> 'SENEGAL',
										uc_c in ['SERBIA']  														=> 'SERBIA',
										uc_c in ['SEYCHELLES']  												=> 'SEYCHELLES',
										uc_c in ['SIERRA LEONE']  											=> 'SIERRA LEONE',
										uc_c in ['SINGAPORE','SGP','SIN']  							=> 'SINGAPORE',
										uc_c in ['SLOVAKIA','SVK']  										=> 'SLOVAKIA',
										uc_c in ['SLOVENIA']  													=> 'SLOVENIA',
										uc_c in ['SOLOMON ISLANDS']  										=> 'SOLOMON ISLANDS',
										uc_c in ['SOMALIA']  														=> 'SOMALIA',
										uc_c in ['SOUTH AFRICA','ZAF']  								=> 'SOUTH AFRICA',
										uc_c in ['SOUTH KOREA','KOREA, SOUTH']  				=> 'SOUTH KOREA',
										uc_c in ['SOUTH SUDAN']  												=> 'SOUTH SUDAN',
										uc_c in ['SPAIN','ESP']  												=> 'SPAIN',
										uc_c in ['SRI LANKA','LKA']  										=> 'SRI LANKA',
										uc_c in ['SUDAN']  															=> 'SUDAN',
										uc_c in ['SURINAME']  													=> 'SURINAME',
										uc_c in ['SWAZILAND'] 													=> 'SWAZILAND',
										uc_c in ['SWEDEN','SWE']  											=> 'SWEDEN',
										uc_c in ['SWITZERLAND','CH','CHE','SWI']  			=> 'SWITZERLAND',
										uc_c in ['SYRIA']  															=> 'SYRIA',
										uc_c in ['TAIWAN','TWN']  											=> 'TAIWAN',
										uc_c in ['TAJIKISTAN']  												=> 'TAJIKISTAN',
										uc_c in ['TANZANIA','TZA']  										=> 'TANZANIA',
										uc_c in ['THAILAND']  													=> 'THAILAND',
										uc_c in ['TIMOR-LESTE']  												=> 'TIMOR-LESTE',
										uc_c in ['TOGO']  															=> 'TOGO',
										uc_c in ['TONGA']  															=> 'TONGA',
										uc_c in ['TRINIDAD AND TOBAGO']  								=> 'TRINIDAD AND TOBAGO',
										uc_c in ['TUNISIA']  														=> 'TUNISIA',
										uc_c in ['TURKEY','TUR']  											=> 'TURKEY',
										uc_c in ['TURKMENISTAN']  											=> 'TURKMENISTAN',
										uc_c in ['TURKS AND CAICOS ISLANDS','TCA']  		=> 'TURKS AND CAICOS ISLANDS',
										uc_c in ['TUVALU']  														=> 'TUVALU',
										uc_c in ['UGANDA']  														=> 'UGANDA',
										uc_c in ['UKRAINE']  														=> 'UKRAINE',
										uc_c in ['UNITED ARAB EMIRATES','UAE','ARE'] 		=> 'UNITED ARAB EMIRATES',
										uc_c in ['UNITED KINGDOM','UK']  								=> 'UNITED KINGDOM',
										uc_c in ['UNITED STATES MINOR OUTLYING','UMI']  => 'UNITED STATES MINOR OUTLYING',
										uc_c in ['UNITED STATES VIRGIN ISLANDS']  			=> 'US VIRGIN ISLANDS',
										uc_c in ['URUGUAY','URY']  											=> 'URUGUAY',
										uc_c in ['US','USA']  													=> 'US',
										uc_c in ['UZBEKISTAN']  												=> 'UZBEKISTAN',
										uc_c in ['VANUATU']  														=> 'VANUATU',
										uc_c in ['VATICAN CITY (HOLY SEE)']  						=> 'VATICAN CITY (HOLY SEE)',
										uc_c in ['VENEZUELA','VEN']  										=> 'VENEZUELA',
										uc_c in ['VIETNAM','VNM']  											=> 'VIETNAM',
										uc_c in ['VIRGIN ISLANDS','VI','VIR']  					=> 'VIRGIN ISLANDS',
										uc_c in ['WINNEBAGO TRIBE OF NEBRASKA']  				=> 'WINNEBAGO TRIBE OF NEBRASKA',
										uc_c in ['YEMEN']  															=> 'YEMEN',
										uc_c in ['ZAMBIA','ZMB']  											=> 'ZAMBIA',
										uc_c in ['ZIMBABWE','ZWE']  										=> 'ZIMBABWE',
										uc_c in ['','PW','UN']                          => '',
										// Capture new foreignstate/foreigncountry combinations that aren't accounted for yet
										'**| foreignstate: ' + uc_s + ' |foreigncountry: ' + uc_c);
														
	END;

	//*****************************************************************************************
		//PreCleanAddressCountry: Returns pre-cleaned country for use with:
		//										    corp_address1, corp_ra_address, and corp_agent_country
	//*****************************************************************************************								
	EXPORT PreCleanAddressCountry(STRING addrCountry) := FUNCTION
				 uc_c     := corp2.t2u(addrCountry);
 				 Counties := ['APPLING','ATKINSON','BACON','BAKER','BALDWIN','BANKS','BARROW','BARTOW','BEN HILL',
											'BERRIEN','BIBB','BLECKLEY','BRANTLEY','BROOKS','BRYAN','BULLOCH','BURKE','BUTTS',
											'CALHOUN','CAMDEN','CANDLER','CARROLL','CATOOSA','CHARLTON','CHATHAM','CHATTAHOOCHEE',
											'CHATTOOGA','CHEROKEE','CLARKE','CLAY','CLAYTON','CLINCH','COBB','COFFEE','COLQUITT',
											'COLUMBIA','COOK','COWETA','CRAWFORD','CRISP','DADE','DAWSON','DECATUR','DEKALB','DODGE',
											'DOOLY','DOUGHERTY','DOUGLAS','EARLY','ECHOLS','EFFINGHAM','ELBERT','EMANUEL','EVANS',
											'FANNIN','FAYETTE','FLOYD','FORSYTH','FRANKLIN','FULTON','GILMER','GLASCOCK','GLYNN',
											'GORDON','GRADY','GREENE','GWINNETT','HABERSHAM','HALL','HANCOCK','HARALSON','HARRIS',
											'HART','HEARD','HENRY','HOUSTON','IRWIN','JACKSON','JASPER','JEFF DAVIS','JEFFERSON',
											'JENKINS','JOHNSON','JONES','LAMAR','LANIER','LAURENS','LEE','LIBERTY','LINCOLN','LONG',
											'LOWNDES','LUMPKIN','MACON','MADISON','MARION','MCDUFFIE','MCINTOSH','MERIWETHER','MILLER',
											'MITCHELL','MONROE','MONTGOMERY','MORGAN','MURRAY','MUSCOGEE','NEWTON','OCONEE','OGLETHORPE',
											'PAULDING','PEACH','PICKENS','PIERCE','PIKE','POLK','PULASKI','PUTNAM','QUITMAN','RABUN',
											'RANDOLPH','RICHMOND','ROCKDALE','SCHLEY','SCREVEN','SEMINOLE','SPALDING','STEPHENS','STEWART',
											'SUMTER','TALBOT','TALIAFERRO','TATTNALL','TAYLOR','TELFAIR','TERRELL','THOMAS','TIFT',
											'TOOMBS','TOWNS','TREUTLEN','TROUP','TURNER','TWIGGS','UNION','UPSON','WALKER','WALTON',
											'WARE','WARREN','WASHINGTON','WAYNE','WEBSTER','WHEELER','WHITE','WHITFIELD','WILCOX',
											'WILKES','WILKINSON','WORTH'];										
				 RETURN MAP(uc_c = 'CONV_INVALID_COUNTRY' 											          => '',
				            uc_c = 'BAHAMAS, THE' 																        => 'BAHAMAS',
										uc_c = 'GAMBIA, THE' 																	        => 'GAMBIA',
									  uc_c = 'KOREA, SOUTH' 																        => 'SOUTH KOREA',
									  uc_c = 'VIR VIRGIN ISLANDS'                                   => 'VIRGIN ISLANDS',
									  uc_c in [Counties, 'GA','GEORGIA','USA','US','UNITED STATES'] => 'US',
										uc_c);
														
	END;	
	
  //********************************************************************
		//Phone_No: cleans phone numbers and Returns a hyphenated 7 or 10 digit number 
	//********************************************************************	
  EXPORT PhoneNo(STRING Phone) := FUNCTION

		ph           := (STRING)(INTEGER)ut.CleanPhone(phone); // we have first 3 digits are zeros in phones EX:0003456789 ,0000000000
    phone_number := IF(TRIM(ph)<>'0',IF(LENGTH(ph) = 10, ph[1..3]+'-'+ph[4..6]+'-'+ph[7..10], IF(LENGTH(ph)=7	,	ph[1..3]+'-'+ph[4..7],ph)),''); //only 10 digit and 7 digit will be hyphenated other numbers will not !
		RETURN phone_number;
		
  END;
	
    //********************************************************************
      //Below date utility to fix the slashed dates into YYYYMMDD
		//********************************************************************
    EXPORT fix_Date(STRING d):= FUNCTION
		
 			dt:= ut.date_slashed_mmddyyyy_to_yyyymmdd(d);
			RETURN dt;

		END;
	
	  //********************************************************************
      //Valid BusinessTypeDesc values are contained in dom_BusinessTypeDesc and for_BusinessTypeDesc.
			//   These lists are used in both CorpOrigOrgStructureDesc and ForeignDomesticInd
			//   and only need to be updated and maintained in this one place
		//********************************************************************
	  EXPORT dom_BusinessTypeDesc := ['CABLE/VIDEO FRANCHISE', 							      // DF-20387										
																		'COOPERATIVE MARKETING ASSOCIATION',        // DF-20387
																		'DEVELOPMENT AUTHORITY', 							      // DF-20387
																		'DOCUMENT ORDER',
																		'DOMESTIC BANK',
																		'DOMESTIC CORPORATION',
																		'DOMESTIC CREDIT UNION',
																		'DOMESTIC ELECTRIC MEMBERSHIP CORPORATION', // DF-25656
																		'DOMESTIC FORPROFIT COOP',
																		'DOMESTIC INSURANCE COMPANY',
																		'DOMESTIC LIMITED LIABILITY COMPANY',
																		'DOMESTIC LIMITED LIABILITY LIMITED PARTNERSHIP',
																		'DOMESTIC LIMITED LIABILITY PARTNERSHIP',
																		'DOMESTIC LIMITED PARTNERSHIP',
																		'DOMESTIC NON-ENTITY NONFILING',
																		'DOMESTIC NON-FILING ENTITY',
																		'DOMESTIC NONPROFIT CORPORATION',
																		'DOMESTIC PROFESSIONAL CORPORATION',
																		'DOMESTIC PROFESSIONAL PA',
																		'DOMESTIC PROFIT CORPORATION',
																		'DOMESTIC UNKNOWN',
																		'MARKETING ASSOCIATION',
																		'MUTUAL AID RESOURCE PACT',
																		'NAME RESERVATION',
																		'NAVIGATION COMPANY', 										  // DF-25656
																		'PRIVATE CHILD SUPPORT COLLECTOR', 					// DF-20387
																		'RAILROAD COMPANY', 												// DF-25656
																		'TRANSPORTATION/TELECOMMUNICATION/RAILROAD',
																		'TRUST ESTATE', 														// DF-25656
																		'VIDEO FRANCHISE'];												  // DF-25656
	  EXPORT for_BusinessTypeDesc := ['ALIEN CORPORATION (RICO)',
																		'FIDUCIARY - FOREIGN ENTITY TRUSTEE',       // DF-25656
																		'FOREIGN BANK',
																		'FOREIGN CORPORATION',
																		'FOREIGN CREDIT UNION',
																		'FOREIGN INSURANCE COMPANY',
																		'FOREIGN LIMITED COOPERATIVE ASSOCIATION',
																		'FOREIGN LIMITED LIABILITY COMPANY',
																		'FOREIGN LIMITED LIABILITY LIMITED PARTNERSHIP',
																		'FOREIGN LIMITED LIABILITY PARTNERSHIP',
																		'FOREIGN LIMITED PARTNERSHIP',
																		'FOREIGN NONPROFIT CORPORATION',
																		'FOREIGN NON-QUALIFYING ENTITY',
																		'FOREIGN PROFESSIONAL CORPORATION',
																		'FOREIGN PROFIT CORPORATION',
																		'FOREIGN UNKNOWN'];
	
	
		//****************************************************************************
		//CorpOrigOrgStructureDesc: returns the "corp_orig_org_structure_desc".
		//												  input: s -> bus_type
		//****************************************************************************
		EXPORT CorpOrigOrgStructureDesc(STRING s) := FUNCTION
					 RETURN	IF(corp2.t2u(s) in [dom_BusinessTypeDesc, for_BusinessTypeDesc]
							  	  ,corp2.t2u(s) 
										,'**|'+corp2.t2u(s));  //scrubbing for new business types

		END;
		
		//****************************************************************************
		//ProfitIndicator: returns "Y" or "N".
		//								 input: s -> bus_type
		//****************************************************************************
		EXPORT ProfitIndicator(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN	MAP(uc_s = 'DOMESTIC FORPROFIT COOP'									      => 'Y',
											uc_s = 'DOMESTIC NONPROFIT CORPORATION'									=> 'N',
											uc_s = 'DOMESTIC PROFIT'									              => 'Y',
											uc_s = 'DOMESTIC PROFIT CORPORATION'                    => 'Y',
											uc_s = 'FOREIGN NONPROFIT CORPORATION'									=> 'N',
											uc_s = 'FOREIGN PROFIT CORPORATION'									    => 'Y',
											'' 																													 
										 );

		END;
		
		//****************************************************************************
		//CorpStatusDesc: returns the "corp_status_desc".
		//												  input: s -> EntityStatus
		//****************************************************************************
		EXPORT CorpStatusDesc(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN	MAP(uc_s = 'ABANDONED' 										=> uc_s,
											uc_s = 'ACTIVE'								        => uc_s,
											uc_s = 'ACTIVE PENDING'							  => uc_s,
											uc_s = 'ACTIVE/COMPLIANCE'						=> uc_s,
											uc_s = 'ACTIVE/NONCOMPLIANCE'				  => uc_s,
											uc_s = 'ACTIVE/OWES CURRENT YEAR AR'	=> uc_s,
											uc_s = 'ADMIN. DISSOLVED'						  => uc_s,
											uc_s = 'ADMIN. DISSOLVED/NONPAYMENT'  => uc_s,
											uc_s = 'CANCELLED'									  => uc_s,
											uc_s = 'CONSOLIDATED'							    => uc_s,
											uc_s = 'CONVERTED'	                  => uc_s,
											uc_s = 'DISAPPROVED FILING'				    => uc_s,
											uc_s = 'DISSOLVED'									  => uc_s,
											uc_s = 'DO NOT USE DISAPPROVED'				=> uc_s,
											uc_s = 'ELECTION TO LLC/LP'						=> uc_s,
											uc_s = 'EXPIRED'									    => uc_s,
											uc_s = 'FLAWED/DEFICIENT'						  => uc_s,
											uc_s = 'HOLD'									        => uc_s,
											uc_s = 'INACTIVE'									    => uc_s,
											uc_s = 'JUDICIAL DISSOLUTION'					=> uc_s,
											uc_s = 'MERGED'									      => uc_s,
											uc_s = 'NAME RESERVATION REJECTED'		=> uc_s,
											uc_s = 'NONCOMPLIANCE/NONPAYMENT'     => uc_s,
											uc_s = 'NON-QUALIFYING/NON-FILING'    => uc_s,
											uc_s = 'PENDING'									    => uc_s,
											uc_s = 'PENDING CANCELLATION'					=> uc_s,
											uc_s = 'PENDING CONVERSION'						=> uc_s,
											uc_s = 'PENDING DISSOLUTION'					=> uc_s,
											uc_s = 'PENDING MERGER'				        => uc_s,
											uc_s = 'PENDING TERMINATION'				 	=> uc_s,
											uc_s = 'PENDING WITHDRAWAL'	          => uc_s,
											uc_s = 'REDEEMED'					            => uc_s,
											uc_s = 'REJECTED'									    => uc_s,
											uc_s = 'REVOKED'									    => uc_s,
										  uc_s = 'SEE NOTEPAD'									=> uc_s,
											uc_s = 'TERMINATED'							      => uc_s,
											uc_s = 'TO BE DISSOLVED'						  => uc_s,
											uc_s = 'UNDER INVESTIGATION'          => uc_s,
											uc_s = 'VOID'									        => uc_s,
											uc_s = 'WITHDRAWN'									  => uc_s,
											uc_s = 'WITHDRAWN/MERGED'						  => uc_s,
											'**|'+uc_s 															//scrubbing for new entity status
										 );
	         END;

		//****************************************************************************
		//ForeignDomesticInd: returns the "corp_foreign_domestic_ind".
		//									  input: bt -> BusinessTypeDesc
		//									  input: fc -> ForeignCountry
		//****************************************************************************
		EXPORT ForeignDomesticInd(STRING bt, STRING fc) := FUNCTION
					RETURN MAP(corp2.t2u(bt) IN dom_BusinessTypeDesc                               => 'D',
										 corp2.t2u(bt) IN for_BusinessTypeDesc                               => 'F',
										 corp2.t2u(fc) NOT IN ['USA','US','UNITED STATES','GA','GEORGIA',''] => 'F',
										 '');
		END;

END;		
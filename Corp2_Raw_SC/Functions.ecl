IMPORT corp2, corp2_mapping, corp2_raw_sc;

EXPORT Functions := Module

		//****************************************************************************
		//Valid_US_State: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT Valid_US_State(string s) := FUNCTION
					 RETURN map (corp2.t2u(s) in ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA',
																				'GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA',
																				'MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND',
																				'MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT',
																				'VT','VI','VA','WA','WV','WI','WY','AE','AP','AA','CZ',
																				'ALABAMA','ALASKA','ARKANSAS','AMERICAN SAMOA','ARIZONA','CALIFORNIA',
																				'COLORADO','CONNECTICUT','DISTRICT OF COLUMBIA','DELAWARE','FLORIDA', 
																				'GEORGIA','GUAM','HAWAII','IOWA','IDAHO','ILLINOIS','INDIANA','KANSAS', 
																				'KENTUCKY','LOUISIANA','MASSACHUSETTS','MARYLAND','MAINE','MICHIGAN',
																				'MINNESOTA','MISSOURI','MISSISSIPPI','MONTANA','NORTH CAROLINA',
																				'NORTH DAKOTA','NEBRASKA','NEW HAMPSHIRE','NEW JERSEY','NEW MEXICO', 
																				'NEVADA','NEW YORK','OHIO','OKLAHOMA','OREGON','PENNSYLVANIA','PUERTO RICO',
																				'RHODE ISLAND','SOUTH CAROLINA','SOUTH DAKOTA','TENNESSEE','TEXAS', 
																				'US','UTAH','VIRGINIA','VIRGIN ISLANDS','VERMONT','WASHINGTON',
																				'WISCONSIN','WEST VIRGINIA','WYOMING',''] => true,false);
		END;
		
		//****************************************************************************
		//State_Description: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT State_Description(string s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'AL' => 'ALABAMA',
											uc_s = 'AK' => 'ALASKA', 
											uc_s = 'AR' => 'ARKANSAS', 
											uc_s = 'AS' => 'AMERICAN SAMOA', 
											uc_s = 'AZ' => 'ARIZONA', 
											uc_s = 'CA' => 'CALIFORNIA', 
											uc_s = 'CO' => 'COLORADO', 
											uc_s = 'CT' => 'CONNECTICUT', 
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
											uc_s = 'US' => 'US',
											uc_s = 'UT' => 'UTAH', 
											uc_s = 'VA' => 'VIRGINIA', 
											uc_s = 'VI' => 'VIRGIN ISLANDS', 
											uc_s = 'VT' => 'VERMONT', 
											uc_s = 'WA' => 'WASHINGTON', 
											uc_s = 'WI' => 'WISCONSIN', 
											uc_s = 'WV' => 'WEST VIRGINIA', 
											uc_s = 'WY' => 'WYOMING',
											uc_s = ''   => '',
											'**|'+uc_s
										 );
		END;
		
		//****************************************************************************
		//Country_Description: returns the country based upon the input.  The codes
		//										 left blank are unknown.
		//****************************************************************************
		EXPORT Country_Description(string s) := FUNCTION
					 
					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(
											uc_s = 'AUS' 																			=>  'AUSTRALIA',
											uc_s = 'BAH'																		  =>  'BAHAMAS',
											uc_s = 'BAR' 																			=>  'BARBADOS',
											uc_s = 'BANGALORE INDIA'													=>	'INDIA',
											uc_s = 'BAHAMAS'																	=>	'BAHAMAS', 
											uc_s = 'BARBADOS'																	=>	'BARBADOS', 
											uc_s = 'BC CANADA'																=>	'CANADA', 
											uc_s = 'BELGIUM'																	=>	'BELGIUM', 
											uc_s = 'BELIZE'																		=>	'BELIZE', 
											uc_s = 'BERLIN GRERMANY'													=>	'GERMANY', 
											uc_s = 'BERMUDA'																	=>	'BERMUDA',
											UC_S = 'VANCOUVER BRITISH COLUMBIA'								=>	'CANADA', 
											uc_s = 'BRISTISH COLUMBIA'												=>	'CANADA', 
											uc_s = 'BRITISH COLUMBIA CANADA'									=>	'CANADA', 
											uc_s = 'BRITISH COLUMBIA CA'											=>	'CANADA', 
											uc_s = 'BRITISH COLUMBIA'													=>	'CANADA',
											uc_s = 'BRITISH VIRGIN ISLANDS'										=>	'BRITISH VIRGIN ISLANDS', 
											uc_s = 'BRITISH VIRGIN ISLAND'										=>	'BRITISH VIRGIN ISLANDS', 
											uc_s = 'BRITISH VIRGIN ISLS'											=>	'BRITISH VIRGIN ISLANDS', 
											uc_s = 'BRITISH VIRGIN ISL'												=>	'BRITISH VIRGIN ISLANDS', 
											uc_s = 'BRITISH VIRIGIN ISLANDS'									=>	'BRITISH VIRGIN ISLANDS', 											
											uc_s = 'BEL' 																			=>  'BELGIUM',
											uc_s = 'BER' 																			=>  'BERMUDA',
											uc_s = 'BRI' 																			=>  'BRITIAN',
											uc_s = 'BUS'																			=>  '',
											uc_s = 'CAN' 																			=>  'CANADA',
											uc_s = 'ALBERTA CANADA'														=>  'CANADA', 
											uc_s = 'ALBERTA CA'																=>  'CANADA', 
											uc_s = 'ALBERTA'																	=>  'CANADA', 											
											uc_s = 'AMSTERDAM THE NETHERLANDS'								=>	'NETHERLANDS', 
											uc_s = 'ANGUILLA WEST INDIES'											=>	'WEST INDIES',
											uc_s = 'AUSTRALIA'																=>	'AUSTRALIA', 
											uc_s = 'AUSTRIA'																	=>	'AUSTRIA',
											uc_s = 'CANADA QUEBEC'														=>	'CANADA', 
											uc_s = 'CANADA'																		=>	'CANADA', 
											uc_s = 'CANADA BRITISH COLA'											=>	'CANADA', 
											uc_s = 'CAN'																			=>	'CANADA', 											
											uc_s = 'CAY' 																			=>  'CAYMAN ISLANDS',
											uc_s = 'CATAWBA INDIAN NATION'										=>	'CATAWBA INDIAN NATION', 
											uc_s = 'CATAWBA INDIAN NATIO'											=>	'CATAWBA INDIAN NATION', 
											uc_s = 'CATWABA INDIAN NATIO'											=>	'CATAWBA INDIAN NATION', 
											uc_s = 'CAYMAN ISLANDS'														=>	'CAYMAN ISLANDS', 
											uc_s = 'CAYMAN ISLAND'														=>	'CAYMAN ISLANDS', 											
											uc_s = 'CHE' 																			=>  'CHEROKEE NATION',
											uc_s = 'CHEROKEE NATION'													=>	'CHEROKEE NATION', 
											uc_s = 'CHI' 																			=>  '',
											uc_s = 'CHILE'																		=>	'CHILE', 
											uc_s = 'CHINA'																		=>	'CHINA',
											uc_s = 'CN'																				=>	'CN',
											uc_s = 'COC' 																			=>  'COC',
											uc_s = 'COL'																			=>	'', 
											uc_s = 'COO'																			=>	'',											
											uc_s = 'COOK ISLANDS'															=>	'COOK ISLANDS', 
											uc_s = 'COS'																			=>	'',
											uc_s = 'COSTA RICA'																=>	'COSTA RICA', 												
											uc_s = 'CZE' 																			=>  'CZECH REPUBLIC',
											uc_s = 'CZECH REPUBLIC'														=>	'CZECH REPUBLIC', 
											uc_s = 'DEN' 																			=>  'DENMARK',
											uc_s = 'DENMARK'																	=>	'DENMARK', 
											uc_s = 'ECU' 																			=>  'ECUADOR',
											uc_s = 'ECUADOR'																	=>	'ECUADOR', 
											uc_s = 'ENGLAND WALES'														=>	'ENGLAND AND WALES', 
											uc_s = 'ENGLAND AND WALES'												=>	'ENGLAND AND WALES',
											uc_s = 'ENG'																			=>  'ENGLAND',
											uc_s = 'ENGLAND UNITED KINGDOM'										=>	'ENGLAND', 
											uc_s = 'ENGLAND'																	=>	'ENGLAND', 
											uc_s = 'FIN' 																			=>  'FINLAND',
											uc_s = 'FINLAND'																	=>	'FINLAND', 											
											uc_s = 'FRA' 																			=>  'FRANCE',
											uc_s = 'FRANCE'																		=>	'FRANCE', 
											uc_s = 'GER' 																			=>  'GERMANY',
											uc_s = 'GERMANY'																	=>	'GERMANY', 
											uc_s = 'GIB' 																			=>  'GIBRALTAR',
											uc_s = 'GIBRALTAR'																=>	'GIBRALTAR', 
											uc_s = 'GRE' 																			=>  'GREECE',
											uc_s = 'GREAT BRITAIN'														=>	'GREAT BRITAIN', 
											uc_s = 'GUA' 																			=>  'GUATEMALA',
											uc_s = 'GUAM'																			=>	'GUAM', 
											uc_s = 'HON' 																			=>  'HONDURAS',
											uc_s = 'HONG KONG'																=>	'HONG KONG', 
											uc_s = 'HUN' 																			=>  'HUNGARY',
											uc_s = 'HUNGARY'																	=>	'HUNGARY', 
											uc_s = 'IND' 																			=>  'INDIA',
											uc_s = 'INDIA'																		=>	'INDIA', 
											uc_s = 'INDONESIA'																=>	'INDONESIA',
											uc_s = 'INTERNATIONAL'														=>	'',
											uc_s = 'IO'																				=>	'IO',
											uc_s = 'IRE' 																			=>  'IRELAND',
											uc_s = 'IRELAND'																	=>	'IRELAND', 
											uc_s = 'ISR' 																			=>  'ISRAEL',
											uc_s = 'ISRAEL'																		=>	'ISRAEL',
											uc_s = 'IT' 																			=>  'IT',
											uc_s = 'ITA' 																			=>  'ITALY',
											uc_s = 'ITALY'																		=>	'ITALY', 
											uc_s = 'JAP' 																			=>  'JAPAN',
											uc_s = 'JAPAN'																		=>	'JAPAN', 											
											uc_s = 'KOR' 																			=>  'KOREA',
											uc_s = 'KOREA'																		=>	'KOREA', 
											uc_s = 'KUWAIT'																		=>	'KUWAIT', 											
											uc_s = 'LIB' 																			=>  'LIBERIA',
											uc_s = 'LIBERIA'																	=>	'LIBERIA', 
											uc_s = 'LUX' 																			=>  'LUXEMBURG',
											uc_s = 'LUXEMBOURG'																=>	'LUXEMBURG', 
											uc_s = 'LUXEMBURG'																=>	'LUXEMBURG',
											uc_s = 'MAHARASHTRA INDIA'												=>	'INDIA', 
											uc_s = 'MANITOBA CANADA'													=>	'CANADA',  											
											uc_s = 'MAU' 																			=>  'MAURITIUS',
											uc_s = 'MAURITIUS'																=>	'MAURITIUS', 
											uc_s = 'MEX' 																			=>  'MEXICO',
											uc_s = 'MEXICO'																		=>	'MEXICO',										
											uc_s = 'MON' 																			=>  'MONACO',
											uc_s = 'MONACO'																		=>	'MONACO', 
											uc_s = 'MOR' 																			=>  'MOROCCO',
											uc_s = 'MOROCCO'																	=>	'MOROCCO',
											uc_s = 'NASSAU BAHAMAS'														=>	'BAHAMAS', 
											uc_s = 'NET' 																			=>  'NETHERLANDS',
											uc_s = 'ANTILEES'																	=> 	'CURACAO', 
											uc_s = 'CURACAO NETHERLANDS'											=> 	'NETHERLANDS', 
											uc_s = 'NETHERLAND ANTILLES'											=> 	'NETHERLANDS', 
											uc_s = 'NETHERLANDS ANTILLES'											=> 	'NETHERLANDS', 
											uc_s = 'NETHERLANDS ANT'													=> 	'NETHERLANDS', 
											uc_s = 'NETH'																			=> 	'NETHERLANDS', 
											uc_s = 'NETH ANT'																	=> 	'NETHERLANDS', 
											uc_s = 'NETH ANTILLES'														=> 	'NETHERLANDS', 
											uc_s = 'NETHERLANDS'															=> 	'NETHERLANDS',
											uc_s = 'NEVIS'																		=> 	'ST KITTS AND NEVIS', 
											uc_s = 'NEWFOUNDLAND'															=> 	'NEWFOUNDLAND', 
											uc_s = 'NEW BRUNSWICK CANADA'											=> 	'CANADA', 
											uc_s = 'NEW BRUNSWICK'														=> 	'CANADA', 											
											uc_s = 'NIG' 																			=>  'NIGERIA',
											uc_s = 'NIGERIA'																	=> 	'NIGERIA', 
											uc_s = 'NOV' 																			=>  'NOVA SCOTIA', 
											uc_s = 'NOVA SCOTIA'															=> 	'NOVA SCOTIA', 
											uc_s = 'NOVIA SCOTIA'															=> 	'NOVA SCOTIA',
											uc_s = 'NS'																				=>	'NS',
											uc_s = 'ONTARIO CANADA'														=> 	'CANADA', 
											uc_s = 'ONTARIO'																	=> 	'CANADA',
											uc_s = 'ORTARIO CANADA'														=> 	'CANADA',
											uc_s = 'QUEBEC CANADA'														=> 	'CANADA',
											uc_s = 'QUEBEC'																		=>	'CANADA',
											uc_s = 'PANAMA'																		=> 	'PANAMA',
											uc_s = 'PAN' 																			=>  'PANAMA',
											uc_s = 'PHI' 																			=>  'PHILIPPINES',
											uc_s = 'PHILIPPINES'															=> 	'PHILIPPINES', 
											uc_s = 'POL' 																			=>  'POLAND',
											uc_s = 'POLAND'																		=> 	'POLAND', 
											uc_s = 'PROVINCE OF ALBERTA'											=> 	'CANADA',
											uc_s = 'PROVINCE OF ONTARIO CANADA'								=> 	'CANADA',											
											uc_s = 'PROV OF MANITOBA'													=>	'CANADA',						
											uc_s = 'PUE' 																			=>  'PUERTO RICO',
											uc_s = 'PUERTO RICO'															=> 	'PUERTO RICO', 
											uc_s = 'QAT' 																			=>  'QATAR',
											uc_s = 'QATAR'																		=> 	'QATAR',											
											uc_s = 'ROM' 																			=>  'ROMANIA',
											uc_s = 'ROMANIA'																	=> 	'ROMANIA',
											uc_s = 'RP'																				=>	'RP',
											uc_s = 'S AFRICA'																	=> 	'SOUTH AFRICA', 
											uc_s = 'SAI' 																			=>  '',
											uc_s = 'SAN JUAN PUERTO RICO'											=> 	'PUERTO RICO',
											uc_s = 'SCO' 																			=>  'SCOTLAND', 
											uc_s = 'SCOTLAND'																	=> 	'SCOTLAND', 
											uc_s = 'SIN' 																			=>  'SINGAPORE',
											uc_s = 'SINGAPORE'																=> 	'SINGAPORE', 
											uc_s = 'SLO' 																			=>  'SLOVENIA',
											uc_s = 'SLOVENIA'																	=> 	'SLOVENIA',
											uc_s = 'SOU' 																			=>  '',
											uc_s = 'SOUTH AFRICA'															=> 	'SOUTH AFRICA', 
											uc_s = 'SOUTH KOREA'															=> 	'SOUTH KOREA', 
											uc_s = 'SPAIN'																		=> 	'SPAIN', 
											uc_s = 'ST LUCIA'																	=> 	'SAINT LUCIA',
											uc_s = 'SPA' 																			=>  'SPAIN',
											uc_s = 'SWE' 																			=>  'SWEDEN',
											uc_s = 'SWEDEN'																		=> 	'SWEDEN',
											uc_s = 'SWI' 																			=>  'SWITZERLAND',
											uc_s = 'SWITZERLAND'															=> 	'SWITZERLAND',
											uc_s = 'THE NETHERLANDS'													=> 	'NETHERLANDS', 
											uc_s = 'THE PHILIPPINES'													=> 	'PHILIPPINES', 
											uc_s = 'THE YSLETA DEL SUR PUEBLO'								=> 	'YSLETA DEL SUR PUEBLO', 
											uc_s = 'THAILAND'																	=> 	'THAILAND',											
											uc_s = 'TUR' 																			=>  'TURKEY',
											uc_s = 'TURKS AND CAICOS ISLANDS'									=> 	'TURKS AND CAICOS ISLANDS',
											uc_s = 'UK'																				=>  'UNITED KINGDOM',
											uc_s = 'UNI' 																			=>  '',
											uc_s = 'UNITED ARAB EMIRATES'											=> 	'UNITED ARAB EMIRATES', 
											uc_s = 'UNITED KINGDOMENG'												=> 	'UNITED KINGDOM', 
											uc_s = 'UNITED KINGDOM'														=> 	'UNITED KINGDOM', 
											uc_s in ['US','USA','UNITED STATES']							=> 	'US',
											uc_s = 'URU' 																			=>  'URUGUAY',
											uc_s = 'URUGUAY'																	=> 	'URUGUAY', 
											uc_s = 'VEN' 																			=>  'VENZULA',
											uc_s = 'VENEZUELA'																=> 	'VENEZUELA', 
											uc_s = 'VICTORIA AUSTRALIA'												=> 	'AUSTRALIA',
											uc_s = 'VICENZA ITALY'														=>  'ITALY',
											uc_s = 'WES' 																			=>  '',
											uc_s = 'WEST GERMANY'															=> 	'WEST GERMANY', 
											uc_s = 'WEST INDIES'															=> 	'WEST INDIES',											
											uc_s = 'YAK' 																			=>  'YAKAMA NATION',
											uc_s = 'YAKAMA NATION WA'													=> 	'YAKAMA NATION',
											uc_s = 'YSL' 																			=>  'YSLETA DEL SUR PUEBLO',
											uc_s in ['IR','MT','TBD','VT']										=> 	'',//NO DEFINITION GIVEN
											'**|'+uc_s
											);

		END;

		//****************************************************************************
		//State_Name_To_Code: returns the state code.
		//****************************************************************************
		EXPORT State_Name_To_Code(STRING s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'AK'																				=>	'AK', 
											uc_s = 'ALABALMA'																	=>	'AL', 
											uc_s = 'ALABAMA'																	=>	'AL', 
											uc_s = 'ALABANA'																	=>	'AL', 
											uc_s = 'ALABMAM'																	=>	'AL', 
											uc_s = 'ALAKSA'																		=>	'AK', 
											uc_s = 'ALAMABA'																	=>	'AL', 
											uc_s = 'ALASKA'																		=>	'AK', 
											uc_s = 'ALA'																			=>	'AL', 
											uc_s = 'ALBAMA'																		=>	'AL', 
											uc_s = 'AL'																				=>	'AL', 
											uc_s = 'ARIZONA'																	=>	'AZ', 
											uc_s = 'ARIZ'																			=>	'AZ', 
											uc_s = 'ARKANSAS'																	=>	'AR', 
											uc_s = 'ARK'																			=>	'AR', 
											uc_s = 'AR'																				=>	'AR', 
											uc_s = 'AZ'																				=>	'AZ', 
											uc_s = 'BALTIMORE MARYLAND'												=>	'MD', 
											uc_s = 'BRUNSWICK COUNTY NC'											=>	'NC', 
											uc_s = 'CAIFORNIA'																=>	'CA', 
											uc_s = 'CALFORNIA'																=>	'CA', 
											uc_s = 'CALIFORINIA'															=>	'CA', 
											uc_s = 'CALIFORNIA'																=>	'CA', 
											uc_s = 'CALIF'																		=>	'CA', 
											uc_s = 'CALI'																			=>	'CA', 
											uc_s = 'CALF'																			=>	'CA', 
											uc_s = 'CALIORNIA'																=>	'CA', 
											uc_s = 'CAL'																			=>	'CA', 
											uc_s = 'CAPE MAY COUNTY NEW JERSEY'								=>	'NJ', 
											uc_s = 'CA'																				=>	'CA', 
											uc_s = 'CHICAGO'																	=>	'IL',
											uc_s = 'CHI'																			=>	'??', 
											uc_s = 'CLAIFORNIA'																=>	'CA', 
											uc_s = 'CLIFORNIA'																=>	'CA', 
											uc_s = 'COBB COUNTY GA'														=>	'GA', 
											uc_s = 'COC'																			=>	'', 
											uc_s = 'COLORADO'																	=>	'CO', 
											uc_s = 'COLORDAO'																	=>	'CO', 
											uc_s = 'COLORDO'																	=>	'CO', 
											uc_s = 'COLO'																			=>	'CO', 
											uc_s = 'COLUMBIA'																	=>	'SC', 
											uc_s = 'COMMONWEATH OF PENNSYLVANIA'							=>	'PA', 
											uc_s = 'CONNECTICUTT'															=>	'CT', 
											uc_s = 'CONNECTICUT'															=>	'CT', 
											uc_s = 'CONNETICUT'																=>	'CT', 
											uc_s = 'CONN'																			=>	'CT', 
											uc_s = 'COVINGTON GEORGIA'												=>	'GA', 
											uc_s = 'CO'																				=>	'CO', 
											uc_s = 'CT'																				=>	'CT', 
											uc_s = 'DALAWARE'																	=>	'DE', 
											uc_s = 'DALEWARE'																	=>	'DE', 
											uc_s = 'DC'																				=>	'DC', 
											uc_s = 'DDIST OF COLUMBIA'												=>	'DC', 
											uc_s = 'DEALWARE'																	=>	'DE', 
											uc_s = 'DEAWARE'																	=>	'DE', 
											uc_s = 'DELAWAE'																	=>	'DE', 
											uc_s = 'DELAWARAE'																=>	'DE', 
											uc_s = 'DELAWARE USA'															=>	'DE', 
											uc_s = 'DELAWARE'																	=>	'DE', 
											uc_s = 'DELAWAR'																	=>	'DE', 
											uc_s = 'DELAWAWARE'																=>	'DE', 
											uc_s = 'DELAWRAE'																	=>	'DE', 
											uc_s = 'DELAWRE'																	=>	'DE', 
											uc_s = 'DELAWWARE'																=>	'DE', 
											uc_s = 'DELEWARE USA'															=>	'DE', 
											uc_s = 'DELEWARE'																	=>	'DE', 
											uc_s = 'DELWARE'																	=>	'DE', 
											uc_s = 'DEL'																			=>	'DE',
											uc_s = 'DELA'																			=>	'DE',
											uc_s = 'DE'																				=>	'DE', 
											uc_s = 'DIST COLA'																=>	'DC', 
											uc_s = 'DIST OF COLA'															=>	'DC', 
											uc_s = 'DIST OF COLUMBIA'													=>	'DC', 
											uc_s = 'DISTRIC OF COLUMBIA'											=>	'DC', 
											uc_s = 'DISTRICT OF COLUMBIA'											=>	'DC', 
											uc_s = 'DLEAWARE'																	=>	'DE', 
											uc_s = 'DOUGLAS COUNTY GEORGIA'										=>	'GA', 
											uc_s = 'D'																				=>	'', 
											uc_s = 'EASLEY'																		=>	'SC',																				
											uc_s = 'FLA'																			=>	'FL', 
											uc_s = 'FLOIDA'																		=>	'FL', 
											uc_s = 'FLORDA'																		=>	'FL', 
											uc_s = 'FLORDIA'																	=>	'FL', 
											uc_s = 'FLORIDA USA'															=>	'FL', 
											uc_s = 'FLORIDA US'																=>	'FL', 
											uc_s = 'FLORIDA'																	=>	'FL', 
											uc_s = 'FLORIDSA'																	=>	'FL', 
											uc_s = 'FL'																				=>	'FL', 
											uc_s = 'FORIDA'																		=>	'FL', 
											uc_s = 'FORT MILLSOUTH CAROLINA'									=>	'SC', 
											uc_s = 'FORT MILL'																=>	'SC', 
											uc_s = 'FULTON COUNTY GEORGIA'										=>	'GA', 
											uc_s = 'FULTON COUNTY'														=>	'GA', 
											uc_s = 'GA'																				=>	'GA', 
											uc_s = 'GEO'																			=>	'GA', 
											uc_s = 'GEARGIA'																	=>	'GA', 
											uc_s = 'GEORGAI'																	=>	'GA', 
											uc_s = 'GEORGIA'																	=>	'GA', 
											uc_s = 'GEORGIQ'																	=>	'GA', 
											uc_s = 'GEORGIS'																	=>	'GA', 
											uc_s = 'GEORIA'																		=>	'GA', 
											uc_s = 'GEORIGA'																	=>	'GA', 
											uc_s = 'GEPRGIA'																	=>	'GA', 
											uc_s = 'GERGIA'																		=>	'GA', 
											uc_s = 'GEROGIA'																	=>	'GA', 
											uc_s = 'GOERGIA'																	=>	'GA', 
											uc_s = 'GREENSBORO GA'														=>	'GA', 
											uc_s = 'GREENVILLE'																=>	'SC', 
											uc_s = 'GREENWOOD'																=>	'SC',
											uc_s = 'GROEGIA'																	=>	'GA', 
											uc_s = 'H CAROLINA'																=>	'', 
											uc_s = 'HAWAII'																		=>	'HI', 
											uc_s = 'HENRY CO VA'															=>	'VA',
											uc_s = 'HILTON HEAD ISLAND'												=>	'SC',
											uc_s = 'HHI'																			=>	'SC', 
											uc_s = 'HI'																				=>	'HI',																				
											uc_s = 'HORRY'																		=>	'SC', 
											uc_s = 'IA'																				=>	'IA',
											uc_s = 'ID'																				=>	'ID', 
											uc_s = 'IDAHO'																		=>	'ID', 
											uc_s = 'ILINOIS'																	=>	'IL', 
											uc_s = 'ILLINIOS'																	=>	'IL', 
											uc_s = 'ILLINOIS'																	=>	'IL', 
											uc_s = 'ILLINOI'																	=>	'IL', 
											uc_s = 'ILLIONOIS'																=>	'IL', 
											uc_s = 'ILLNOIS'																	=>	'IL', 
											uc_s = 'ILL'																			=>	'IL', 
											uc_s = 'IL'																				=>	'IL', 
											uc_s = 'INDIANA'																	=>	'IN', 
											uc_s = 'INDIANNA'																	=>	'IN', 
											uc_s = 'IND'																			=>	'IN', 
											uc_s = 'INIDANA'																	=>	'IN', 
											uc_s = 'INIDIANA'																	=>	'IN', 
											uc_s = 'INIDIA'																		=>	'IN', 
											uc_s = 'IN'																				=>	'IN', 
											uc_s = 'IOWAS'																		=>	'IA', 
											uc_s = 'IOWA'																			=>	'IA', 
											uc_s = 'JEW JERSEY'																=>	'NJ', 
											uc_s = 'KANSAS'																		=>	'KS', 
											uc_s = 'KAN'																			=>	'KS', 
											uc_s = 'KENTUCKY'																	=>	'KY', 
											uc_s = 'KENTUKY'																	=>	'KY', 
											uc_s = 'KENTURCKY'																=>	'KY', 
											uc_s = 'KS'																				=>	'KS', 
											uc_s = 'KY'																				=>	'KY', 
											uc_s = 'LA'																				=>	'LA',
											uc_s = 'LATTA'																		=>	'SC',																				
											uc_s = 'LEESVILLE'																=>	'SC', 
											uc_s = 'LEXINGTON KY'															=>	'KY', 
											uc_s = 'LIM'																			=>	'SC', 
											uc_s = 'LOS ANGELES CALIFORNIA'										=>	'CA', 
											uc_s = 'LOS ANGELES'															=>	'CA', 
											uc_s = 'LOUISANA'																	=>	'LA', 
											uc_s = 'LOUISIANA'																=>	'LA', 
											uc_s = 'LOUISIAN'																	=>	'LA', 
											uc_s = 'LOUSIANA'																	=>	'LA', 
											uc_s = 'LP'																				=>	'', 
											uc_s = 'MAARYLAND'																=>	'MD', 
											uc_s = 'MAINE'																		=>	'ME', 
											uc_s = 'MARYALND'																	=>	'MD', 
											uc_s = 'MARYLAND'																	=>	'MD', 
											uc_s = 'MARYLANG'																	=>	'MD', 
											uc_s = 'MARYLND'																	=>	'MD', 
											uc_s = 'MASSACHESETTS'														=>	'MA', 
											uc_s = 'MASSACHSETTS'															=>	'MA', 
											uc_s = 'MASSACHUSETS'															=>	'MA', 
											uc_s = 'MASSACHUSETTES'														=>	'MA', 
											uc_s = 'MASSACHUSETTS'														=>	'MA', 
											uc_s = 'MASSACHUSETTTS'														=>	'MA', 
											uc_s = 'MASSACHUSSETS'														=>	'MA', 
											uc_s = 'MASSACHUSSETTS'														=>	'MA', 
											uc_s = 'MASSACUSETTS'															=>	'MA', 
											uc_s = 'MASSAHCUSETTS'														=>	'MA', 
											uc_s = 'MASSUCHUSETTS '														=>	'MA',
											uc_s = 'MASS'																			=>	'MA', 
											uc_s = 'MAYRLAND'																	=>	'MD', 
											uc_s = 'MA'																				=>	'MA', 
											uc_s = 'MD'																				=>	'MD', 
											uc_s = 'MECHANICSVILLE VIRGINIA'									=>	'VA', 
											uc_s = 'MECKLENBURG NC'														=>	'NC', 
											uc_s = 'ME'																				=>	'ME', 
											uc_s = 'MICHAGAN'																	=>	'MI', 
											uc_s = 'MICHICAN'																	=>	'MI', 
											uc_s = 'MICHIGAN'																	=>	'MI', 
											uc_s = 'MICH'																			=>	'MI', 
											uc_s = 'MINESOTA'																	=>	'MN', 
											uc_s = 'MINESSOTA'																=>	'MN', 
											uc_s = 'MINNEOSTA'																=>	'MN', 
											uc_s = 'MINNESOTA'																=>	'MN', 
											uc_s = 'MINNESTOA'																=>	'MN', 
											uc_s = 'MINN'																			=>	'MN', 
											uc_s = 'MIN'																			=>	'MN', 																				
											uc_s = 'MISSIOURI'																=>	'MO', 
											uc_s = 'MISSISSIPPI'															=>	'MS', 
											uc_s = 'MISSISSPPI'																=>	'MS', 
											uc_s = 'MISSORI'																	=>	'MO', 
											uc_s = 'MISSOUIRI'																=>	'MO', 
											uc_s = 'MISSOUIR'																	=>	'MO', 
											uc_s = 'MISSOURI'																	=>	'MO', 
											uc_s = 'MISS'																			=>	'MS', 
											uc_s = 'MI'																				=>	'MI', 
											uc_s = 'MN'																				=>	'MN', 
											uc_s = 'MOBILE COUNTY ALABAMA'										=>	'AL', 
											uc_s = 'MONTANA'																	=>	'MT', 
											uc_s = 'MONTGOMERY COUNTY MARYLAND'								=>	'MD', 
											uc_s = 'MO'																				=>	'MO',
											uc_s = 'MS'																				=>	'MS',
											uc_s = 'MT PLEASANT'															=>	'SC', 
											uc_s = 'MYRTLE BEACH'															=>	'SC', 
											uc_s = 'N MB'																			=>	'SC',																		
											uc_s = 'N CAROLINA'																=>	'NC',
											uc_s = 'N ORTH CAROLINA'													=>	'NC',
											uc_s = 'NAVADA'																		=>	'NV', 
											uc_s = 'NCAROLINA'																=>	'NC', 
											uc_s = 'NC'																				=>	'NC', 
											uc_s = 'ND'																				=>	'ND', 
											uc_s = 'NEBRASKA'																	=>	'NE', 
											uc_s = 'NEB'																			=>	'NE', 
											uc_s = 'NEDAVA'																		=> 	'NV', 
											uc_s = 'NER JERSEY'																=> 	'NJ', 																	
											uc_s = 'NEVADA'																		=> 	'NV', 
											uc_s = 'NEVEADA'																	=> 	'NV', 
											uc_s = 'NEVEDA'																		=> 	'NV', 
											uc_s = 'NEV'																			=> 	'NV', 
											uc_s = 'NEW HAMPSHIRE'														=> 	'NH', 
											uc_s = 'NEW HAMPSIRE'															=> 	'NH', 
											uc_s = 'NEW JERSERY'															=> 	'NJ', 
											uc_s = 'NEW JERSEY'																=> 	'NJ', 
											uc_s = 'NEW JEWSEY'																=> 	'NJ', 
											uc_s = 'NEW MEVICO'																=> 	'NM',
											uc_s = 'NEW MEXICO'																=> 	'NM', 
											uc_s = 'NEW NERSEY'																=> 	'NJ', 
											uc_s = 'NEW YOEK'																	=> 	'NY', 
											uc_s = 'NEW YORK CITY'														=> 	'NY', 
											uc_s = 'NEW YORK STATE'														=> 	'NY', 
											uc_s = 'NEW YORK'																	=> 	'NY', 
											uc_s = 'NEW YRK'																	=> 	'NY', 
											uc_s = 'NEWJERSEY'																=> 	'NJ', 
											uc_s = 'NEWYORK'																	=> 	'NY', 
											uc_s = 'NE'																				=> 	'NE', 
											uc_s = 'NH'																				=> 	'NH', 
											uc_s = 'NJ'																				=> 	'NJ', 
											uc_s = 'NM'																				=> 	'NM', 
											uc_s = 'NONORTH CAROLINA'													=> 	'NC', 
											uc_s = 'NORHT CAROLINA'														=> 	'NC', 
											uc_s = 'NORT CAROLINA'														=> 	'NC', 
											uc_s = 'NORTH C AROLINA'													=> 	'NC', 
											uc_s = 'NORTH CAORLINA'														=> 	'NC', 
											uc_s = 'NORTH CARAOLINA'													=> 	'NC', 
											uc_s = 'NORTH CARLINA'														=> 	'NC', 
											uc_s = 'NORTH CAROILNA'														=> 	'NC', 
											uc_s = 'NORTH CAROINA'														=> 	'NC', 
											uc_s = 'NORTH CAROLIA'														=> 	'NC', 
											uc_s = 'NORTH CAROLIINA'													=> 	'NC', 
											uc_s = 'NORTH CAROLINA GUILFORD COUNTY'						=> 	'NC', 
											uc_s = 'NORTH CAROLINAH'													=> 	'NC', 
											uc_s = 'NORTH CAROLINA'														=> 	'NC', 
											uc_s = 'NORTH CAROLINNA'													=> 	'NC', 
											uc_s = 'NORTH CAROLNA'														=> 	'NC', 
											uc_s = 'NORTH CAROLIN'														=> 	'NC',
											uc_s = 'NORTH CAROLINS'														=> 	'NC',
											uc_s = 'NORTH CAROLNIA'														=> 	'NC', 
											uc_s = 'NORTH CAROLONA'														=> 	'NC', 
											uc_s = 'NORTH CCAROLINA'													=> 	'NC', 
											uc_s = 'NORTH CENTRAL'														=> 	'', 
											uc_s = 'NORTH CHARLESTON'													=> 	'SC', 
											uc_s = 'NORTH COLUMBIA'														=> 	'SC', 
											uc_s = 'NORTH COROLINA'														=> 	'NC', 
											uc_s = 'NORTH DAKOTA'															=> 	'ND', 
											uc_s = 'NORTH DOKOTA'															=> 	'ND', 
											uc_s = 'NORTHCAROLINA'														=> 	'NC', 
											uc_s = 'NOTRTH CAROLINA'													=> 	'NC',
											uc_s = 'NROTH CAROLINA'														=> 	'NC', 
											uc_s = 'NRTH CAROLINA'														=> 	'NC', 
											uc_s = 'NV'																				=> 	'NV', 
											uc_s = 'NY STATE'																	=> 	'NY', 
											uc_s = 'NY'																				=> 	'NY', 
											uc_s = 'OAKLAHOMA'																=> 	'OK', 
											uc_s = 'OHIO'																			=> 	'OH', 
											uc_s = 'OHO'																			=> 	'OH', 
											uc_s = 'OH'																				=> 	'OH', 
											uc_s = 'OKALHOMA'																	=> 	'OK', 
											uc_s = 'OKLAHOMA'																	=> 	'OK', 
											uc_s = 'OKLAHOMOA'																=> 	'OK', 
											uc_s = 'OKLA'																			=> 	'OK', 
											uc_s = 'OK'																				=> 	'OK', 
											uc_s = 'ORANGE COUNTY FL'													=> 	'FL', 
											uc_s = 'OREGAN'																		=> 	'OR', 
											uc_s = 'OREGON'																		=> 	'OR', 
											uc_s = 'ORGEON'																		=> 	'OR',
											uc_s = 'ORE'																			=> 	'OR',
											uc_s = 'ORLANDO FLORIDA'													=> 	'FL', 
											uc_s = 'OR'																				=> 	'OR', 
											uc_s = 'OUTH CAROLINA'														=> 	'SC', 
											uc_s = 'PASCO COUNTY FL'													=> 	'FL', 
											uc_s = 'PA'																				=> 	'PA', 
											uc_s = 'PENNSLYVANIA'															=> 	'PA', 
											uc_s = 'PENNSLYVANVIA'														=> 	'PA', 
											uc_s = 'PENNSYIVANIA'															=> 	'PA', 
											uc_s = 'PENNSYLANIA'															=> 	'PA', 
											uc_s = 'PENNSYLAVANIA'														=> 	'PA', 
											uc_s = 'PENNSYLVAINIA'														=> 	'PA', 
											uc_s = 'PENNSYLVANIA'															=> 	'PA', 
											uc_s = 'PENNSYLVANIS'															=> 	'PA', 
											uc_s = 'PENNSYLVANNIA'														=> 	'PA', 
											uc_s = 'PENNSYLVIA'																=> 	'PA', 
											uc_s = 'PENNSYLVNIA'															=> 	'PA', 
											uc_s = 'PENNSYSLVANIA'														=> 	'PA', 
											uc_s = 'PENNSYVANIA'															=> 	'PA', 
											uc_s = 'PENNSYVLVANIA'														=> 	'PA', 
											uc_s = 'PENNYLVANIA'															=> 	'PA', 
											uc_s = 'PENNYSLVANIA'															=> 	'PA', 
											uc_s = 'PENNYSYLVANIA'														=> 	'PA', 
											uc_s = 'PENN'																			=> 	'PA', 
											uc_s = 'PENSYLVANIA'															=> 	'PA',
											uc_s = 'PENSILVANNIA'															=> 	'PA',											
											uc_s = 'PEN'																			=> 	'PA', 
											uc_s = 'PIMA COUNTY ARIZONA'											=> 	'AZ', 
											uc_s = 'PITTSBURGH PENNSYLVANIA'									=> 	'PA', 
											uc_s = 'PO BOX TABERNASH CO'											=> 	'CO',
											uc_s = 'PR'																				=>  'PR',
											uc_s = 'QSOUTH CAROLINA'													=> 	'SC', 
											uc_s = 'RI'																				=>	'RI', 
											uc_s = 'RHODE ISLAND AND PROVIDENCE PLANTATIONS'	=>	'RI', 
											uc_s = 'RHODE ISLAND'															=>	'RI', 
											uc_s = 'RHOSE ISLAND'															=>	'RI', 
											uc_s = 'RICHMOND VA'															=> 	'VA', 
											uc_s = 'ROCKINGHAM COUNTY VIRGINIA'								=> 	'VA', 
											uc_s = 'ROUND O'																	=> 	'SC', 
											uc_s = 'SAC FOX NATION'														=> 	'OK',
											uc_s = 'SAI' 																			=>  '',
											uc_s = 'SAINT LOUIS MISSOURI'											=> 	'MO', 
											uc_s = 'SCD'																			=> 	'SC',
											uc_s = 'SC'																				=> 	'SC', 
											uc_s = 'SD'																				=> 	'SD', 
											uc_s = 'SEATTLE WASHINGTON'												=> 	'WA', 
											uc_s = 'SEQUATCHIE TN'														=> 	'TN',
											uc_s = 'SOU'																			=> 	'', 
											uc_s = 'SOTH CAROLINA'														=> 	'SC', 
											uc_s = 'SOUTH CAORLINA'														=> 	'SC', 
											uc_s = 'SOUTH CAROCLINA'													=> 	'SC', 
											uc_s = 'SOUTH CAROLINA'														=> 	'SC', 
											uc_s = 'SOUTH CAROLIN'														=> 	'SC', 
											uc_s = 'SOUTH CAROLI'															=> 	'SC', 
											uc_s = 'SOUTH CAROL'															=> 	'SC', 
											uc_s = 'SOUTH CARO'																=> 	'SC', 
											uc_s = 'SOUTH CCAROLINA'													=> 	'SC',
											uc_s = 'SOUTH DAKORA'															=> 	'SD', 
											uc_s = 'SOUTH DAKOTA'															=> 	'SD', 
											uc_s = 'SOUTHCAROLINA'														=> 	'SC', 
											uc_s = 'SSOUTH CAROLINA'													=> 	'SC', 
											uc_s = 'STROUDSBURG PENNSYLVANIA'									=> 	'PA', 
											uc_s = 'SUTH CAROLINA'														=> 	'SC',  
											uc_s = 'TEAS'																			=> 	'TX', 
											uc_s = 'TEC'																			=> 	'TX', 
											uc_s = 'TENEESSEE'																=> 	'TN', 
											uc_s = 'TENESSEE'																	=> 	'TN', 
											uc_s = 'TENNEESSEE'																=> 	'TN', 
											uc_s = 'TENNESEE'																	=> 	'TN', 
											uc_s = 'TENNESSEE'																=> 	'TN', 
											uc_s = 'TENNESSE'																	=> 	'TN', 
											uc_s = 'TENN'																			=> 	'TN', 
											uc_s = 'TEXAS'																		=> 	'TX', 
											uc_s = 'TEX'																			=> 	'TX', 
											uc_s = 'TN'																				=> 	'TN', 
											uc_s = 'TX'																				=> 	'TX', 
											uc_s = 'UNITED STATES OF AMERICA'									=> 	'US', 
											uc_s = 'UNITED STATES'														=> 	'US', 
											uc_s = 'US COMPTROLLER OF CURRENCY'								=> 	'US',
											uc_s = 'US OFFICE OF COMPTROLLER OF CURRENCY'			=> 	'US', 
											uc_s = 'US OFFICE OF THE OCC'											=> 	'US', 
											uc_s = 'US VIRGIN ISLANDS'												=> 	'VI', 
											uc_s = 'USA'																			=> 	'US', 
											uc_s = 'US'																				=> 	'US', 
											uc_s = 'UTAH'																			=> 	'UT', 
											uc_s = 'UT'																				=> 	'UT', 
											uc_s = 'V IRGINIA'																=> 	'VA', 
											uc_s = 'VA'																				=> 	'VA', 
											uc_s = 'VERMONT'																	=> 	'VT', 
											uc_s = 'VIR'																			=> 	'VA', 
											uc_s = 'VIGINIA'																	=> 	'VA', 
											uc_s = 'VIRGIN ISLANDS'														=> 	'VI', 
											uc_s = 'VIRGINA'																	=> 	'VA', 
											uc_s = 'VIRGINIA'																	=> 	'VA', 
											uc_s = 'VIRGININA'																=> 	'VA', 
											uc_s = 'VIRGNIA'																	=> 	'VA', 
											uc_s = 'VIRIGINIA'																=> 	'VA', 
											uc_s = 'VIRIGNIA'																	=> 	'VA', 
											uc_s = 'VRGINIA'																	=> 	'VA', 
											uc_s = 'VRIGINIA'																	=> 	'VA', 
											uc_s = 'W VA'																			=> 	'WV', 
											uc_s = 'W VIRGINIA'																=> 	'WV', 
											uc_s = 'WASHINGTON DC'														=> 	'DC',
											uc_s = 'WASH D C'																	=> 	'DC',
											uc_s = 'WASH DC'																	=> 	'DC',
											uc_s = 'WASHINGTON STAATE'												=> 	'WA', 
											uc_s = 'WASHINGTON STATE'													=> 	'WA', 
											uc_s = 'WASHINGTON'																=> 	'WA', 
											uc_s = 'WASHINTON'																=> 	'WA', 
											uc_s = 'WASH'																			=> 	'WA', 
											uc_s = 'WASINGTON'																=> 	'WA', 
											uc_s = 'WA'																				=> 	'WA',
											uc_s = 'WEST VIIRGINIA'														=> 	'WV', 
											uc_s = 'WEST VIRGINA'															=> 	'WV', 
											uc_s = 'WEST VIRGINIA'														=> 	'WV', 
											uc_s = 'WEST VIRIGINIA'														=> 	'WV', 
											uc_s = 'WEST VIRIGNIA'														=> 	'WV', 
											uc_s = 'WINCONSIN'																=> 	'WI', 
											uc_s = 'WISCONSIN'																=> 	'WI', 																
											uc_s = 'WISCONSON'																=> 	'WI', 
											uc_s = 'WISC'																			=> 	'WI', 
											uc_s = 'WIS'																			=> 	'WI', 
											uc_s = 'WI'																				=> 	'WI', 
											uc_s = 'WVA'																			=> 	'WV', 
											uc_s = 'WV'																				=> 	'WV', 
											uc_s = 'WY'																				=> 	'WY',
											uc_s = 'WYOMIING'																	=> 	'WY', 
											uc_s = 'WYOMING'																	=> 	'WY', 
											uc_s = 'WYO'																			=> 	'WY', 
											uc_s = ''																					=> 	'', 
											'**|'+uc_s
										 );

		END;
		
		//****************************************************************************
		//State_or_Country: returns the "state or country".
		//****************************************************************************
		EXPORT State_or_Country(STRING s) := FUNCTION

					 invalid_words1 			:= 'AUTHORITY|CORPORATION|FEDERAL REPUBLIC OF|REP OF|REPUBLIC OF|KINGDOM OF|STATE OF|';
					 invalid_words2 			:= 'THE COMMON WELATH OF|THE COMMONWEALTH OF|COMMENWEALTH OF|COMMONWEALTH OF|COMMONWEALTH|';
					 invalid_words3				:= 'COMMON WEATH OF|COUNTRY OF|ISLANDS OF|ISLAND OF';
					 invalid_words				:= invalid_words1 + invalid_words2 + invalid_words3;
					 
					 uc_s									:= corp2.t2u(regexreplace(invalid_words,corp2.t2u(s),''));

					 state_or_country 		:= 	map(State_Name_To_Code(uc_s)[1..2]   <> '**' =>	State_Name_To_Code(uc_s),
																				Country_Description(uc_s)[1..2]  <> '**' => Country_Description(uc_s),
																				'**|'+uc_s
																			 );
										
					 RETURN state_or_country;

		END;

		//****************************************************************************
		//Address: returns the "addr, city, state, & zip (if they exist)"
		//Note: A lot of addresses do not have SC after the city or a zip code.  The
		//      address contains either county or city at the end of the address.
		//
		//			This function attempts to part the address into street, city, state,
		//			and zip.
		//****************************************************************************
		EXPORT City_State(STRING s) := FUNCTION		

					 uc_s 					:= corp2.t2u(s);
		
					 revaddress			:= stringlib.stringreverse(uc_s);  																		//places city in front of address 

					 streetnumber 	:= stringlib.stringreverse(regexfind('([0-9])+' ,revaddress,0));			//find street or box number
					 endofaddrloc		:= stringlib.stringfind(uc_s,streetnumber,1) + length(streetnumber);
					 addcomma				:= uc_s[1..endofaddrloc-1]+','+uc_s[endofaddrloc..];									//add comma after street or box number
					 addressparts		:= stringlib.splitwords(addcomma,',',false);
					 wc					 		:= count(addressparts);
					 city						:= addressparts[wc];
					 streetaddress	:= addressparts[wc-1];
					 
					 RETURN streetaddress+'|'+city;

		END;		

		//****************************************************************************
		//GetWholeAddress: returns the remaining "addr" after removing city & state.
		//****************************************************************************
		EXPORT GetWholeAddress(STRING state, STRING city, STRING addr) := FUNCTION
		
					 removecommas		:= stringlib.stringfilterout(addr,',');
					 removestate	 	:= regexreplace(state+'$',corp2.t2u(removecommas),'');
					 removecity		 	:= regexreplace(city+'$',corp2.t2u(removestate),'');

					 RETURN	regexreplace('\\,$',corp2.t2u(removecity),'');

		END;

		//****************************************************************************
		//CorrectMispelledWords: returns the address after filtering invalid characters
		//											 and correcting bad spellings.
		//****************************************************************************
		EXPORT CorrectMispelledWords(STRING addr) := FUNCTION
					 
					 filteredvalues				:= ' -&/",#\\\'()ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

					 replace_right_paren	:= corp2.t2u(stringlib.stringfindreplace(addr,'(',','));									//replace "(" with a comma for parsing purposes
					 replace_left_paren		:= corp2.t2u(stringlib.stringfindreplace(replace_right_paren,')',','));		//replace ")" with a comma for parsing purposes
					 filter_valid_chars		:= corp2.t2u(stringlib.stringfilter(replace_left_paren,filteredvalues));	//remove any non-permissible character
					 replace_back_slash		:= corp2.t2u(stringlib.stringfindreplace(filter_valid_chars,'\\','/'));		//Had to fix invalid "backslash" in address eg.g 1\2 is now 1/2
					 spell_correction1		:= regexreplace('ISL(AND)*',replace_back_slash,'ISLAND');												//standardize "ISLAND"
					 spell_correction2		:= regexreplace('GRNVL',spell_correction1,'GREENVILLE');												//standardize "GREENVILLE"
					 spell_correction3		:= regexreplace('HHI',spell_correction2,'HILTON HEAD ISLAND');									//standardize "HILTON HEAD ISLAND"
					 spell_correction4		:= regexreplace(' HD',spell_correction3,' HEAD');																//standardize "HEAD"
					 spell_correction5		:= regexreplace('HILTONG|HILTN',spell_correction4,'HILTON');										//standardize "HILTON"
					 spell_correction6		:= regexreplace(' MB',spell_correction5,' MYRTLE BEACH');												//standardize "MYRTLE BEACH"
					 spell_correction7		:= regexreplace('MYRLTE|MYRLE|MYRTEL',spell_correction6,'MYRTLE');							//standardize "MYRTLE"
					 spell_correction8		:= regexreplace('SURSIDE|SUFRSIDE',spell_correction7,'SURFSIDE');			 					//standardize "SURFSIDE"
					 spell_correction9		:= regexreplace('YOUNGES',spell_correction8,'YONGES');													//standardize "YONGES"
					 spell_correction10		:= regexreplace('WADMALOW',spell_correction9,'WADMALAW');												//standardize "WADMALAW"
					 
					 RETURN corp2.t2u(spell_correction10);

		END;
		
		//****************************************************************************
		//AddComma2Address: returns the the address after searching for possible 
		//									terminating words to the street address portion of the 
		//								  address.  Exception handling is handled later.
		//****************************************************************************
		EXPORT AddComma2Address(STRING addr) := FUNCTION

					 uc_addr := corp2.t2u(addr);
					 
						//AddComm2Addr: attempts to place a "comma" before the city for parsing purposes.
					 RETURN if (regexfind(',',uc_addr,0)='',
											map(regexfind(' AV ',uc_addr,0)													<>'' => regexreplace(' AV ',uc_addr,' AV, '),
													regexfind(' AVE ',uc_addr,0)												<>'' => regexreplace(' AVE ',uc_addr,' AVE, '),
													regexfind(' AVE EXT ',uc_addr,0)										<>'' => regexreplace(' AVE EXT ',uc_addr,' AVE EXT, '),																									
													regexfind(' AVENUE ',uc_addr,0)											<>'' => regexreplace(' AVENUE ',uc_addr,' AVENUE, '),
													regexfind(' BLDG ',uc_addr,0)												<>'' => regexreplace(' BLDG ',uc_addr,' BLDG, '),
													regexfind(' BLVD ',uc_addr,0)												<>'' => regexreplace(' BLVD ',uc_addr,' BLVD, '),
													regexfind(' BOULEVARD ST ',uc_addr,0)								<>'' => regexreplace(' BOULEVARD ST ',uc_addr,' BOULEVARD ST, '),																									
													regexfind(' BOULEVARD ',uc_addr,0)									<>'' => regexreplace(' BOULEVARD ',uc_addr,' BOULEVARD, '),
													regexfind(' CAUSEWAY ',uc_addr,0)										<>'' => regexreplace(' CAUSEWAY ',uc_addr,' CAUSEWAY, '),
													regexfind(' CAY RD ',uc_addr,0)											<>'' => regexreplace(' CAY RD ',uc_addr,' CAY RD, '),
													regexfind(' CAY ',uc_addr,0)												<>'' => regexreplace(' CAY ',uc_addr,' CAY, '),
													regexfind(' CIR ',uc_addr,0)												<>'' => regexreplace(' CIR ',uc_addr,' CIR, '),
													regexfind(' CIRCLE ',uc_addr,0)											<>'' => regexreplace(' CIRCLE ',uc_addr,' CIRCLE, '),
													regexfind(' CT ',uc_addr,0)													<>'' => regexreplace(' CT ',uc_addr,' CT, '),
													regexfind(' DR STE ([A-Za-z0-9-]+)',uc_addr,0)			<>'' => regexreplace(' DR STE ([0-9]+)',uc_addr,' DR STE $1,$2'),
													regexfind(' DR ',uc_addr,0)													<>'' => regexreplace(' DR ',uc_addr,' DR, '),
													regexfind(' DRIVE ',uc_addr,0)											<>'' => regexreplace(' DRIVE ',uc_addr,' DRIVE, '),
													regexfind(' ED ',uc_addr,0)													<>'' => regexreplace(' ED ',uc_addr,' ED, '),		//Mispelled "RD"
													regexfind(' EXCHANGE ',uc_addr,0)										<>'' => regexreplace(' EXCHANGE ',uc_addr,' EXCHANGE, '),
													regexfind(' FRONT ',uc_addr,0)											<>'' => regexreplace(' FRONT ',uc_addr,' FRONT, '),                    
													regexfind(' HIGHWAY ([a-zA-Z]+)',uc_addr,0)					<>'' => regexreplace(' HIGHWAY ([a-zA-Z]+)',uc_addr,' HIGHWAY, $1'),
													regexfind(' HIGHWAY ([0-9]+)',uc_addr,0)						<>'' => regexreplace(' HIGHWAY ([0-9]+)',uc_addr,' HIGHWAY $1,$2'),
													regexfind(' HWY ([a-zA-Z]+)',uc_addr,0)							<>'' => regexreplace(' HWY ([a-zA-Z]+)',uc_addr,' HWY, $1'),
													regexfind(' HWY ([0-9]+)',uc_addr,0)								<>'' => regexreplace(' HWY ([0-9]+)',uc_addr,' HWY $1,$2'),
													regexfind(' LANE ',uc_addr,0)												<>'' => regexreplace(' LANE ',uc_addr,' LANE, '),
													regexfind(' LN ',uc_addr,0)													<>'' => regexreplace(' LN ',uc_addr,' LN, '),
													regexfind(' PARKWAY ',uc_addr,0)										<>'' => regexreplace(' PARKWAY ',uc_addr,' PARKWAY, '),
													regexfind(' PIKE ',uc_addr,0)												<>'' => regexreplace(' PIKE ',uc_addr,' PIKE, '),
													regexfind(' PKWY ',uc_addr,0)												<>'' => regexreplace(' PKWY ',uc_addr,' PKWY, '),
													regexfind(' PL ',uc_addr,0)													<>'' => regexreplace(' PL ',uc_addr,' PL, '),
													regexfind(' PLACE RD ',uc_addr,0)										<>'' => regexreplace(' PLACE RD ',uc_addr,' PLACE RD, '),
													regexfind(' PL TWO SHELTER CENTER ',uc_addr,0)			<>'' => regexreplace(' PL TWO SHELTER CENTER ',uc_addr,' PL TWO SHELTER CENTER, '),
													regexfind(' PL TWO SHELTER CTR ',uc_addr,0)					<>'' => regexreplace(' PL TWO SHELTER CTR ',uc_addr,' PL TWO SHELTER CTR, '),
													regexfind(' PLACE TWO SHELTER CENTER ',uc_addr,0)		<>'' => regexreplace(' PLACE TWO SHELTER CENTER ',uc_addr,' PLACE TWO SHELTER CENTER, '),
													regexfind(' PLACE TWO SHELTER CTR ',uc_addr,0)			<>'' => regexreplace(' PLACE TWO SHELTER CTR ',uc_addr,' PLACE TWO SHELTER CTR, '),
													regexfind(' PLACE SUBDIVISION ',uc_addr,0)					<>'' => regexreplace(' PLACE SUBDIVISION ',uc_addr,' PLACE SUBDIVISION, '),																									
													regexfind(' PLACE ',uc_addr,0)											<>'' => regexreplace(' PLACE ',uc_addr,' PLACE, '),
													regexfind(' PLAZA MALL ',uc_addr,0)									<>'' => regexreplace(' PLAZA MALL ',uc_addr,' PLAZA MALL, '),																									
													regexfind(' PLAZA ',uc_addr,0)											<>'' => regexreplace(' PLAZA ',uc_addr,' PLAZA, '),
													regexfind(' RD APT ([A-Za-z0-9-]+)',uc_addr,0)			<>'' => regexreplace(' RD APT ([A-Za-z0-9-]+)',uc_addr,' RD APT $1,$2'),
													regexfind(' RD ',uc_addr,0)													<>'' => regexreplace(' RD ',uc_addr,' RD, '),
													regexfind(' ROAD ',uc_addr,0)												<>'' => regexreplace(' ROAD ',uc_addr,' ROAD, '),
													regexfind(' (,)+ ( )* ROUND O ',uc_addr,0)					<>'' => regexreplace(' (,)+ ( )* ROUND O ',uc_addr,' , ROUND O, '),																									
													regexfind(' ROUND O ',uc_addr,0)										<>'' => regexreplace(' ROUND O ',uc_addr,' , ROUND O, '),
													regexfind(' SCHOOL ',uc_addr,0)											<>'' => regexreplace(' SCHOOL ',uc_addr,' SCHOOL, '),
													regexfind(' SQUARE ',uc_addr,0)											<>'' => regexreplace(' SQUARE ',uc_addr,' SQUARE, '),
													regexfind(' ST STE ([A-Za-z0-9-]+)',uc_addr,0)			<>'' => regexreplace(' ST STE ([0-9]+)',uc_addr,' ST STE $1,$2'),
													regexfind(' ST (#)*([0-9]+)',uc_addr,0)							<>'' => regexreplace(' ST (#)*([0-9]+)',uc_addr,' ST $1$2,$3'),																									
													regexfind(' ST ',uc_addr,0)													<>'' => regexreplace(' ST ',uc_addr,' ST, '),
													regexfind(' STE ([a-zA-Z]+)',uc_addr,0)							<>'' => regexreplace(' STE ([a-zA-Z]+)',uc_addr,' STE, $1'),
													regexfind(' STE ([0-9]+)',uc_addr,0)								<>'' => regexreplace(' STE ([0-9]+)',uc_addr,' STE $1,$2'),
													regexfind(' STREET ',uc_addr,0)											<>'' => regexreplace(' STREET ',uc_addr,' STREET, '),
													regexfind(' SUBDIVISION ',uc_addr,0)								<>'' => regexreplace(' SUBDIVISION ',uc_addr,' SUBDIVISION, '),
													regexfind(' TRAIL ',uc_addr,0)											<>'' => regexreplace(' TRAIL ',uc_addr,' TRAIL, '),
													regexfind(' TRL ',uc_addr,0)												<>'' => regexreplace(' TRL ',uc_addr,' TRL, '),																									
													regexfind(' WAY ',uc_addr,0)												<>'' => regexreplace(' WAY ',uc_addr,' WAY, '),
													regexfind('^HWY ([a-zA-Z]+)',uc_addr,0)							<>'' => regexreplace('^HWY ([a-zA-Z]+)',uc_addr,'HWY, $1'),
													regexfind('^HWY ([0-9]+)',uc_addr,0)								<>'' => regexreplace('^HWY ([0-9]+)',uc_addr,'HWY $1,$2'),
													regexfind('^PO BOX ([a-zA-Z]+)',uc_addr,0)					<>'' => regexreplace('^PO BOX ([a-zA-Z]+)',uc_addr,'PO BOX $1,'),
													regexfind('^PO BOX ([0-9]+)',uc_addr,0)							<>'' => regexreplace('^PO BOX ([0-9]+)',uc_addr,'PO BOX  $1,$2'),
													uc_addr
												 ),
											uc_addr
										 );

		END;
		
		//****************************************************************************
		//StandardizeStateCode: returns the standardized state code for South Carolina
		//										  and a comma is inserted in front of it for parsing purposes.
		//											Also, if SC isn't found but a 2 character code is found
		//											at the end of the address it is assumed to be the state
		//											code and a comma will be inserted infront of it.
		//****************************************************************************
		EXPORT StandardizeStateCode(STRING addr) := FUNCTION

					 uc_addr := corp2.t2u(addr);

					 RETURN map(regexfind('( )*(\\,)*( )*S C$',uc_addr,0) <> '' 						=> regexreplace('( )*(\\,)*( )*S C$',uc_addr,',SC'), 						//standardize format
										  regexfind('( )*(\\,)*( )*SC$' ,uc_addr,0) <> '' 						=> regexreplace('( )*(\\,)*( )*SC$',uc_addr,',SC'), 						//standardize format						
										  regexfind('( )*(\\,)*( )*SX$' ,uc_addr,0) <> '' 						=> regexreplace('( )*(\\,)*( )*SX$',uc_addr,',SC'), 						//standardize format																	 
										  regexfind('(,)+( )*([a-zA-Z]{2})$',uc_addr,0) <>''					=> regexreplace('(,)+( )*([a-zA-Z]{2})$',uc_addr,'$1 $2 $3'),		//standardize format by adding comma before state																							 
										  regexfind('( )+([a-zA-Z]{2})$',uc_addr,0) <>''							=> regexreplace('( )+([a-zA-Z]{2})$',uc_addr,'$1,$2'),					//standardize format by adding comma before state
										  regexfind('( )*(\\,)*( )*SOUTH CAROLINA$',uc_addr,0) <> '' 	=> regexreplace('( )*(\\,)*( )*SOUTH CAROLINA$',uc_addr,',SC'),	//standardize format
										  regexfind('NAME$',uc_addr,0) 					<> ''									=> '',  																												//when "NAME" exists, no address exists
										  regexfind('REGISTERATION$',uc_addr,0) <> ''									=> '',  																												//when "REGISTERATION" exists, no address exists
										  regexfind('REGISTRATION$',uc_addr,0) 	<> ''									=> '',  																												//when "REGISTRATION" exists, no address exists
										  regexfind('RESERVATION$',uc_addr,0) 	<> ''									=> '',  																												//when "RESERVATION" exists, no address exists
										  regexfind('RESERVE NAME$',uc_addr,0) 	<> ''									=> '',  																												//when "RESERVE NAME" exists, no address exists
										  regexfind('RESERVED$',uc_addr,0) 			<> ''									=> '',  																												//when "RESERVED" exists, no address exists
										  regexfind('RESIGNATION$',uc_addr,0) 	<> ''									=> '',  																												//when "RESIGNATION" exists, no address exists
										  regexfind('RESIGNED$',uc_addr,0) 			<> ''									=> '',  																												//when "RESIGNED" exists, no address exists
										  uc_addr
										 );

		END;
		
		//****************************************************************************
		//CityExceptionHandling: returns the fixed city.  Found that BEACH or ISLAND
		//											 existed as the city and at the end of the street
		//											 address was the name of the beach or island.  This
		//											 routine searches for "known" beach and island names
		//											 and fixes them here.
		//****************************************************************************
		EXPORT CityExceptionHandling(STRING city, STRING addr) := FUNCTION

					 uc_city := corp2.t2u(city);
					 uc_addr := corp2.t2u(addr);

					 RETURN map(
											 uc_city = 'BEACH' 			and regexfind('CRESCENT$',uc_addr,0)<>'' 						=> 'CRESCENT BEACH',
											 uc_city = 'BEACH' 			and regexfind('EDISTO$',uc_addr,0)<>'' 							=> 'EDISTO BEACH',
											 uc_city = 'BEACH' 			and regexfind('FOLLY$',uc_addr,0)<>'' 							=> 'FOLLY BEACH',
											 uc_city = 'BEACH' 			and regexfind('GARDEN uc_city$',uc_addr,0)<>'' 			=> 'GARDEN CITY BEACH',
											 uc_city = 'BEACH' 			and regexfind('JOHN(.{0,1})S$',uc_addr,0)<>'' 			=> 'JOHNS BEACH',
											 uc_city = 'BEACH' 			and regexfind('N MYRTLE$',uc_addr,0)<>'' 						=> 'N MYRTLE BEACH',
											 uc_city = 'BEACH' 			and regexfind('NORTH MYRTLE$',uc_addr,0)<>''				=> 'NORTH MYRTLE BEACH',
											 uc_city = 'BEACH' 			and regexfind('S MYRTLE$',uc_addr,0)<>'' 						=> 'S MYRTLE BEACH',
											 uc_city = 'BEACH' 			and regexfind('SOUTH MYRTLE$',uc_addr,0)<>'' 				=> 'SOUTH MYRTLE BEACH',
											 uc_city = 'BEACH' 			and regexfind('S LITCHFIELD$',uc_addr,0)<>'' 				=> 'S LITCHFIELD BEACH',
											 uc_city = 'BEACH' 			and regexfind('SOUTH LITCHFIELD$',uc_addr,0)<>'' 		=> 'SOUTH LITCHFIELD BEACH',
											 uc_city = 'BEACH' 			and regexfind('LITCHFIELD$',uc_addr,0)<>'' 					=> 'LITCHFIELD BEACH',
											 uc_city = 'BEACH' 			and regexfind('MYRTLE$',uc_addr,0)<>'' 							=> 'MYRTLE BEACH',
											 uc_city = 'BEACH' 			and regexfind('PAWLEY(.{0,1})(S)*$',uc_addr,0)<>''	=> 'PAWLEYS BEACH',
											 uc_city = 'BEACH' 			and regexfind('SURFSIDE$',uc_addr,0)<>'' 						=> 'SURFSIDE BEACH',
											 uc_city = 'ISLAND' 		and regexfind('BEECH$',uc_addr,0)<>'' 							=> 'BEECH ISLAND',
											 uc_city = 'ISLAND' 		and regexfind('COOSAW$',uc_addr,0)<>'' 							=> 'COOSAW ISLAND',						
											 uc_city = 'ISLAND' 		and regexfind('EDISTO$',uc_addr,0)<>'' 							=> 'EDISTO ISLAND',
											 uc_city = 'ISLAND' 		and regexfind('FRIPP$',uc_addr,0)<>'' 							=> 'FRIPP ISLAND',
											 uc_city = 'ISLAND' 		and regexfind('HARBOR$',uc_addr,0)<>'' 							=> 'HARBOR ISLAND',
											 uc_city = 'ISLAND' 		and regexfind('HELENA$',uc_addr,0)<>'' 							=> 'HELENA ISLAND',
											 uc_city = 'ISLAND' 		and regexfind('HILTON HEAD$',uc_addr,0)<>'' 				=> 'HILTON HEAD ISLAND',
											 uc_city = 'ISLAND' 		and regexfind('JAMES$',uc_addr,0)<>'' 							=> 'JAMES ISLAND',
											 uc_city = 'ISLAND' 		and regexfind('JOHN(.{0,1})(S)*$',uc_addr,0)<>'' 		=> 'JOHNS ISLAND',
											 uc_city = 'ISLAND' 		and regexfind('KIAWAH$',uc_addr,0)<>'' 							=> 'KIAWAH ISLAND',
											 uc_city = 'ISLAND' 		and regexfind('LADY(.{0,1})(S)*$',uc_addr,0)<>'' 		=> 'LADYS ISLAND',
											 uc_city = 'ISLAND' 		and regexfind('PAWLEY(.{0,1})(S)*$',uc_addr,0)<>''	=> 'PAWLEYS ISLAND',
											 uc_city = 'ISLAND' 		and regexfind('SEABROOK$',uc_addr,0)<>'' 						=> 'SEABROOK ISLAND',
											 uc_city = 'ISLAND' 		and regexfind('SULLIVAN(.{0,1})S$',uc_addr,0)<>''		=> 'SULLIVANS ISLAND',																							 
											 uc_city = 'ISLAND' 		and regexfind('WADMALAW$',uc_addr,0)<>'' 						=> 'WADMALAW ISLAND',
											 uc_city = 'ISLAND' 		and regexfind('YONGES$',uc_addr,0)<>'' 							=> 'YONGES ISLAND',
											 uc_city = 'PLEASANT' 	and regexfind('MT$',uc_addr,0)<>'' 									=> 'MT PLEASANT',
											 uc_city																							 
											);
		END;
		
		//****************************************************************************
		//AddrExceptionHandling: returns the fixed addr.  Found that BEACH or ISLAND
		//											 existed as the city and at the end of the street
		//											 address was the name of the beach or island.  This
		//											 routine searches for "known" beach and island names
		//											 and removes them here from the address since they 
		//											 were added to the city name in the CityExceptionHandling
		//											 function.
		//****************************************************************************
		EXPORT AddrExceptionHandling(STRING city, STRING addr) := FUNCTION

					 uc_city := corp2.t2u(city);
					 uc_addr := corp2.t2u(addr);

					 RETURN map(
											 uc_city = 'BEACH' 			and regexfind('CRESCENT$',uc_addr,0)<>'' 						=> regexreplace('CRESCENT$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('EDISTO$',uc_addr,0)<>'' 							=> regexreplace('EDISTO$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('FOLLY$',uc_addr,0)<>'' 							=> regexreplace('FOLLY$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('GARDEN CITY$',uc_addr,0)<>'' 				=> regexreplace('GARDEN CITY$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('JOHN(.{0,1})S$',uc_addr,0)<>'' 			=> regexreplace('JOHN(.{0,1})S$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('N MYRTLE$',uc_addr,0)<>'' 						=> regexreplace('N MYRTLE$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('NORTH MYRTLE$',uc_addr,0)<>''				=> regexreplace('NORTH MYRTLE$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('S MYRTLE$',uc_addr,0)<>'' 						=> regexreplace('S MYRTLE$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('SOUTH MYRTLE$',uc_addr,0)<>'' 				=> regexreplace('SOUTH MYRTLE$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('S LITCHFIELD$',uc_addr,0)<>'' 				=> regexreplace('S LITCHFIELD$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('SOUTH LITCHFIELD$',uc_addr,0)<>'' 		=> regexreplace('SOUTH LITCHFIELD$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('LITCHFIELD$',uc_addr,0)<>'' 					=> regexreplace('LITCHFIELD$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('MYRTLE$',uc_addr,0)<>'' 							=> regexreplace('MYRTLE$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('PAWLEY(.{0,1})S$',uc_addr,0)<>'' 		=> regexreplace('PAWLEY(.{0,1})S$',uc_addr,''),
											 uc_city = 'BEACH' 			and regexfind('SURFSIDE$',uc_addr,0)<>'' 						=> regexreplace('SURFSIDE$',uc_addr,''),
											 uc_city = 'ISLAND' 		and regexfind('BEECH$',uc_addr,0)<>'' 							=> regexreplace('BEECH$',uc_addr,''),
											 uc_city = 'ISLAND'			and regexfind('COOSAW$',uc_addr,0)<>'' 							=> regexreplace('COOSAW$',uc_addr,''),
											 uc_city = 'ISLAND' 		and regexfind('EDISTO$',uc_addr,0)<>'' 							=> regexreplace('EDISTO$',uc_addr,''),
											 uc_city = 'ISLAND' 		and regexfind('FRIPP$',uc_addr,0)<>'' 							=> regexreplace('FRIPP$',uc_addr,''),
											 uc_city = 'ISLAND' 		and regexfind('HARBOR$',uc_addr,0)<>'' 							=> regexreplace('HARBOR$',uc_addr,''),
											 uc_city = 'ISLAND' 		and regexfind('HELENA$',uc_addr,0)<>'' 							=> regexreplace('HELENA$',uc_addr,''),
											 uc_city = 'ISLAND' 		and regexfind('HILTON HEAD$',uc_addr,0)<>'' 				=> regexreplace('HILTON HEAD$',uc_addr,''),
											 uc_city = 'ISLAND' 		and regexfind('JAMES$',uc_addr,0)<>'' 							=> regexreplace('JAMES$',uc_addr,''),
											 uc_city = 'ISLAND' 		and regexfind('JOHN(.{0,1})S$',uc_addr,0)<>'' 			=> regexreplace('JOHN(.{0,1})S$',uc_addr,''),
											 uc_city = 'ISLAND' 		and regexfind('KIAWAH$',uc_addr,0)<>'' 							=> regexreplace('KIAWAH$',uc_addr,''),
											 uc_city = 'ISLAND' 		and regexfind('LADY(.{0,1})(S)*$',uc_addr,0)<>''		=> regexreplace('LADY(.{0,1})(S)*$',uc_addr,''),																							 
											 uc_city = 'ISLAND' 		and regexfind('PAWLEY(.{0,1})S$',uc_addr,0)<>'' 		=> regexreplace('PAWLEY(.{0,1})S$',uc_addr,''),
											 uc_city = 'ISLAND' 		and regexfind('SEABROOK$',uc_addr,0)<>'' 						=> regexreplace('SEABROOK$',uc_addr,''),
											 uc_city = 'ISLAND' 		and regexfind('SULLIVAN(.{0,1})S$',uc_addr,0)<>'' 	=> regexreplace('SULLIVAN(.{0,1})S$',uc_addr,''),																							 
											 uc_city = 'ISLAND' 		and regexfind('WADMALAW$',uc_addr,0)<>'' 						=> regexreplace('WADMALAW$',uc_addr,''),
											 uc_city = 'ISLAND' 		and regexfind('YONGES$',uc_addr,0)<>'' 							=> regexreplace('YONGES$',uc_addr,''),
											 uc_city = 'PLEASANT' 	and regexfind('MT$',uc_addr,0)<>'' 									=> regexreplace('MT$',uc_addr,''),
											 uc_addr
											);		
		END;

		//****************************************************************************
		//Address: returns the "addr, city, state, & zip (if they exist)".  They are
		//				 delimited by a "pipe".
		//		
		//Note: 	 A lot of addresses do not have SC after the city or a zip code.
		//      	 The address contains either county or city at the end of the address.
		//
		//				 This module attempts to part the address into street, city, state,
		//				 and zip.
		//
		//				 This is a module because it allows for ease of testing.		
		//****************************************************************************
		EXPORT Address(STRING state_origin, STRING state_desc, STRING s) := MODULE
						EXPORT filteredvalues				:= ' -&/",#\\\'()ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
						EXPORT uc_state_origin 			:= corp2.t2u(state_origin);
						EXPORT uc_state_desc	 			:= corp2.t2u(state_desc);
						EXPORT uc_s									:= CorrectMispelledWords(corp2.t2u(s));
						
						//Attempts to place a "comma" before the city for parsing purposes
						EXPORT AddComma2Addr				:= AddComma2Address(uc_s);
						//Map zip, if it exists, at the end of the input string.						
						EXPORT Zip									:= Corp2_Mapping.fCleanZip(state_origin,state_desc,AddComma2Addr).Zip;
						//Remove zip from input
						EXPORT RemovedZip						:= if(zip <> '',corp2.t2u(stringlib.stringexcludelastword(AddComma2Addr)),corp2.t2u(AddComma2Addr));
																							
						//Parse the address by space and also by comma and get their associated word counts
						EXPORT standardizedAddr			:= regexreplace('\\,$',corp2.t2u(StandardizeStateCode(removedZip)),'');
						EXPORT wc_by_space				 	:= if(count(stringlib.splitwords(standardizedAddr,' ',false)) > 1,count(stringlib.splitwords(standardizedAddr,' ',false)),0);	//Get word count by space
						EXPORT addr_parts_by_space	:= if(wc_by_space<>0,stringlib.splitwords(standardizedAddr,' ',false),['']);																								//Split address by space
						EXPORT wc_by_comma		 			:= if(count(stringlib.splitwords(standardizedAddr,',',false)) > 1,count(stringlib.splitwords(standardizedAddr,',',false)),0);	//Get word count by comma
						EXPORT addr_parts_by_comma 	:= if(wc_by_comma<>0,stringlib.splitwords(standardizedAddr,',',false),['']);																								//Split address by comma

						//Identify how state was found (via space parsing or comma parsing)
						EXPORT StateFoundBySpace		:= if(State_or_Country(addr_parts_by_space[wc_by_space])[1..2] not in ['**',''],true,false);
						EXPORT StateFoundByComma		:= if(State_or_Country(addr_parts_by_comma[wc_by_comma])[1..2] not in ['**',''],true,false);

						//Identify if a valid state (this could also mean a valid "country".
						EXPORT isValidState					:= map(StateFoundBySpace => true,  
																							 StateFoundByComma => true,
																							 false
																							);
																							
						//Store the original "state" value that was used to validate in the state_or_country function
						EXPORT StateParsedValue			:= map(StateFoundByComma => addr_parts_by_comma[wc_by_comma],
																							 StateFoundBySpace => addr_parts_by_space[wc_by_space],
																							 ''
																							);
						//Store the value returned from state_or_country function
						EXPORT StateReturned				:= map(StateFoundByComma => State_or_Country(addr_parts_by_comma[wc_by_comma]),  
																							 StateFoundBySpace => State_or_Country(addr_parts_by_space[wc_by_space]),
																							 ''
																							);

						//Determine if the the value parsed is a US State
						EXPORT isUSState						:= if(State_Name_To_Code(StateParsedValue) = StateReturned or Valid_US_State(StateParsedValue),true,false);

						//Store the remaining address after the state is removed
						EXPORT RemainingAddr				:= if(StateParsedValue=StateReturned or isUSState,regexreplace(StateParsedValue,standardizedAddr,''),standardizedAddr);
						
						//Default to 'SC' if no valid state is found.  Found that the city or county is being used instead of state
						EXPORT TempState1				 		:= if(isValidState,StateReturned,'SC');

						//Now that state has been identified, it is added to original address (if it didn't already exist)
						EXPORT NewStandardizedAddr 	:= map(isValidState and length(corp2.t2u(TempState1))<>2	=> RemainingAddr+','+TempState1,	//foreign address
																							 isValidState and TempState1 <> StateParsedValue 					=> RemainingAddr+','+TempState1,
																							 isValidState <> true and StateParsedValue = ''						=> RemainingAddr+',SC',
																							 standardizedAddr
																							);
																							
						//Re-Parse the address by comma and get the associated word count
						EXPORT NewAddrParts	 				:= map(count(stringlib.splitwords(NewStandardizedAddr,',',false)) > 1	=> stringlib.splitwords(NewStandardizedAddr,',',false),
																							 stringlib.splitwords(NewStandardizedAddr,' ',false)
																							);
						EXPORT New_wc				 				:= map(count(stringlib.splitwords(NewStandardizedAddr,',',false)) > 1	=> count(stringlib.splitwords(NewStandardizedAddr,',',false)),
																							 count(stringlib.splitwords(NewStandardizedAddr,' ',false))
																							);
						EXPORT TempCity1				 		:= NewAddrParts[new_wc-1];
						EXPORT TempAddr1				 		:= if(isValidState,regexreplace('\\,$',corp2.t2u(NewAddrParts[new_wc-2]),''),regexreplace(TempCity1,corp2.t2u(standardizedAddr),''));
						EXPORT TempState2						:= if(corp2.t2u(TempCity1) = 'SC','SC',corp2.t2u(TempState1));
						EXPORT TempCity2						:= map(corp2.t2u(TempCity1) = 'SC' 								=> corp2.t2u(stringlib.splitwords(City_State(TempAddr1),'|',false)[2]),
																							  stringlib.stringfilter(TempCity1,'0123456789') <> '' => corp2.t2u(stringlib.splitwords(addr_parts_by_space[wc_by_space],',',false)[1]),
																							  corp2.t2u(TempCity1)
																							 );
						EXPORT City_wc							:= stringlib.countwords(TempCity2,' ',false);
						
						//The number of words in city should not be greater than 2 (unless it is a beach or island) 
						EXPORT Evaluate_City				:= if(length(corp2.t2u(TempState1))=2 and city_wc > 2 and regexfind('BEACH|ISLAND',TempCity2,0)='',stringlib.stringgetnthword(TempCity2,city_wc),TempCity2);

						EXPORT TempAddr2						:= map(corp2.t2u(TempCity1) = 'SC' 									 																								=> stringlib.splitwords(City_State(TempAddr1),'|',false)[1],
																							 stringlib.stringfilter(TempCity1,'0123456789') <> '' and length(corp2.t2u(Evaluate_City))<>1	=> regexreplace(Evaluate_City,TempCity1,''),
																							 corp2.t2u(TempAddr1)
																							);
																							
						//Exception handling: This validates that the entire address was used, if not (because the address is long), the function "GetWholeAddress"
						//										will try and remove the city and state from the address.
						EXPORT TempAddr3						:= if(TempAddr2[1] = NewStandardizedAddr[1], //is the whole address captured?
																							regexreplace('\\,$',corp2.t2u(TempAddr2),''),
																							GetWholeAddress(TempState2,Evaluate_City,NewStandardizedAddr)
																						 );

						//Exception handling: City should not have no more than two words UNLESS
						// 										1) it is outside of the US (e.g. VANCOUVER BRITISH COLUMBIA)
						//  									2) is contains BEACH or ISLAND												
						//										Also, make sure what is being concatenated doesn't match the value already in the address field
						EXPORT TempAddr4						:= if(city_wc > 2 and length(TempState2)=2 and regexfind('BEACH|ISLAND',TempCity2,0)='' and corp2.t2u(TempAddr3)<>corp2.t2u(stringlib.stringexcludelastword(TempCity2)),
																							corp2.t2u(TempAddr3)+' '+corp2.t2u(stringlib.stringexcludelastword(TempCity2)),
																							TempAddr3
																						 );
																						 
						EXPORT City									:= CityExceptionHandling(Evaluate_City,TempAddr4);
																							
						//Exception handling: Cases exist where the city contains only BEACH or ISLAND.  If true, will map the correct name in city and remove from the address (done here). 
						EXPORT Addr									:=  corp2.t2u(AddrExceptionHandling(Evaluate_City,TempAddr4));

						//Exception handling: Do not output state is the address and city is blank (e.g. for 																						 
						EXPORT State								:= if(corp2.t2u(addr) = '' and corp2.t2u(Evaluate_City)='','',corp2.t2u(TempState2));

		END;

		//*************************************************************************
		//CorpForProfitInd: returns the "corp_for_profit_ind".
		//					 		 input: s -> corptypecode
		//****************************************************************************
		EXPORT CorpForProfitInd(STRING s, STRING t='') := FUNCTION
					 
					 LeaveBlank := ['ASM','BEN','CORP','FIC','FMR','LLC','LLP','LP','REG','RES','UNAVAILABLE',''];

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),'-ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 RETURN map(uc_s in LeaveBlank			=> '',
											uc_s = 'BOP' 						=> 'Y',
											uc_s = 'BUS' 						=> 'Y',
											uc_s = 'CORP' 					=> 'Y',
											uc_s = 'ELE' 						=> 'N',
											uc_s = 'ELE-CORP' 			=> 'Y',
											uc_s = 'FIC-CORP' 			=> 'Y',
											uc_s = 'SPB' 						=> 'Y',											
											uc_s = 'SPD' 						=> 'Y',
											'*' //scrubbed
										 );
														 
		END;

		//****************************************************************************
		//CorpLNNameTypeCD: returns the "corp_ln_name_type_cd".
		//					 		 input: s -> corptypecode
		//****************************************************************************
		EXPORT CorpLNNameTypeCD(STRING s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),'-ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
					 
					 RETURN map(uc_s = 'ASM' => '06',
											uc_s = 'CORP'=> '01',
											uc_s = 'ELE' => '01',
											uc_s = 'FIC' => 'F',
											uc_s = 'FMR' => 'P',
											uc_s = 'LLC' => '01',
											uc_s = 'LLP' => '01',
											uc_s = 'LP'  => '01',
											uc_s = 'BEN' => '01',
											uc_s = 'GPC' => '01',
											uc_s = 'RES' => '07',
											uc_s = 'REG' => '09',											
											'**|'+uc_s //scrubbed
										 );
														 
		END;
					 
		//****************************************************************************
		//CorpLNNameTypeDesc: returns the "corp_ln_name_type_desc".
		//						 input: s -> corptypecode
		//****************************************************************************
		EXPORT CorpLNNameTypeDesc(STRING s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),'-ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 RETURN map(uc_s = 'ASM' => 'ASSUMED',
											uc_s = 'CORP'=> 'LEGAL',
											uc_s = 'ELE' => 'LEGAL',
											uc_s = 'FIC' => 'FICTITIOUS BUSINESS NAME',
											uc_s = 'FMR' => 'PRIOR',
											uc_s = 'LLC' => 'LEGAL',
											uc_s = 'LLP' => 'LEGAL',
											uc_s = 'LP'  => 'LEGAL',
											uc_s = 'BEN' => 'LEGAL',
											uc_s = 'GPC' => 'LEGAL',
											uc_s = 'RES' => 'RESERVED',
											uc_s = 'REG' => 'REGISTRATION',										
											'**|'+uc_s //scrubbed
										 );
		END;
		
		//****************************************************************************
		//CorpLNNameTypeCD_AT: returns the "corp_ln_name_type_cd".
		//					    input: s -> associatedtype
		//Note: All known codes are referenced here to indicate not all
		//      codes are being used.		
		//****************************************************************************
		EXPORT CorpLNNameTypeCD_AT(STRING s) := FUNCTION
					
					 uc_s := corp2.t2u(s);

					 RETURN map(uc_s = 'ASM'           =>'06',
											uc_s = 'FIC'           =>'F',
											uc_s = 'FMR'           =>'P',
											uc_s = 'REG'           =>'',  //DO NOT MAP
											uc_s = 'RES'           =>'',  //DO NOT MAP
											uc_s = 'UNAVAILABLE'   =>'',  //DO NOT MAP
											'**|'+uc_s //scrubbed
										 );
		END;
		
		//****************************************************************************
		//CorpLNNameTypeDesc_AT: returns the "corp_ln_name_type_desc".
		//						    input: s -> associatedtype
		//Note: All known codes are referenced here to indicate not all
		//      codes are being used.
		//****************************************************************************
		EXPORT CorpLNNameTypeDesc_AT(STRING s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
					 RETURN map(uc_s = 'ASM'           =>'ASSUMED',
											uc_s = 'FIC'           =>'FICTITIOUS BUSINESS NAME',
											uc_s = 'FMR'           =>'PRIOR',
											uc_s = 'REG'           =>'',  //DO NOT MAP
											uc_s = 'RES'           =>'',  //DO NOT MAP
											uc_s = 'UNAVAILABLE'   =>'',  //DO NOT MAP
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//CorpOrigOrgStructureCD: returns the "corp_orig_org_structure_cd".
		//								 input: s -> corptypecode
		//****************************************************************************
		EXPORT CorpOrigOrgStructureCD(STRING s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),'-ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 RETURN map(uc_s in ['ASM' ,'FIC','FMR','REG','RES','UNAVAILA','UNAVAILABLE']=>'',
											uc_s = 'BEN'							=> 'BEN', 
											uc_s = 'CORP'							=> 'CORP', 
											uc_s = 'ELE'							=> 'ELE', 
											uc_s = 'GPC'							=> 'GPC', 
											uc_s = 'LLC'							=> 'LLC', 
											uc_s = 'LLP'							=> 'LLP', 
											uc_s = 'LP'							  => 'LP',
											uc_s = ''									=> '',
											uc_s //scrubbing
										 );

		END;

		//****************************************************************************
		//CorpOrigOrgStructureDesc: returns the "corp_orig_org_structure_desc".
		//									 input: s -> corptypecode
		//****************************************************************************
		EXPORT CorpOrigOrgStructureDesc(STRING s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),'-ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 RETURN map(uc_s in ['ASM' ,'FIC','FMR','REG','RES','UNAVAILA','UNAVAILABLE']=>'',
											uc_s = 'BEN'							=> 'BENEFIT CORPORATION', 
											uc_s = 'CORP'							=> 'CORPORATION', 
											uc_s = 'ELE'							=> 'NONPROFIT', 
											uc_s = 'GPC'							=> 'GENERAL PARTNERSHIP', 
											uc_s = 'LLC'							=> 'LIMITED LIABILITY COMPANY', 
											uc_s = 'LLP'							=> 'LIMITED LIABILITY PARTNERSHIP', 
											uc_s = 'LP'							  => 'LIMITED PARTNERSHIP',
											uc_s = ''									=> '',
											'**|'+uc_s //scrubbing
										 );

		END;
		
		//********************************************************************
		//CorpForgnStateCD: Returns "corp_forgn_state_cd".
		//Note: Since corp_forgn_state_cd can only hold a max length of 3, any
		//		  value greater than 3 the original value is returned with the **
		//			removed.
		//Note: Scrubs will fail on the foreign description field.  Retaining
		//			code for debugging purposes.
		//********************************************************************	
		EXPORT CorpForgnStateCD(STRING s) := FUNCTION

					 uc_s  			:= corp2.t2u(s);
					 
					 statecdlth	:= LENGTH(uc_s);

					 RETURN MAP(uc_s in ['INT']											 => '',
											statecdlth < 4 and uc_s[1..2] <>'**' => uc_s,
											statecdlth > 3 and uc_s[1..2] <>'**' => '',  //e.g. MEXICO should return blank
											uc_s[4..]  //return code that is located after **|
										 );
		END;

		//********************************************************************
		//CorpForgnStateDesc: Returns "corp_forgn_state_desc".
		//Note: Scrubs will fail on the foreign description field.  Retaining
		//			code for debugging purposes.		
		//********************************************************************	
		EXPORT CorpForgnStateDesc(STRING s) := FUNCTION

					 uc_s  			:= corp2.t2u(s);
					 
					 statecdlth	:= LENGTH(uc_s);
					 
					 RETURN MAP(statecdlth = 2 and State_Description(uc_s)[1..2] 	<>'**' => State_Description(uc_s),
											Country_Description(uc_s)[1..2]										<>'**' => Country_Description(uc_s),
											uc_s //contains **| from a previous call to State_or_Country
										 );
		END;
		
		//****************************************************************************
		//CorpRAFullName: returns the "corp_ra_full_name".
		//				 input: s -> agentname
		//****************************************************************************
		EXPORT CorpRAFullName(STRING s) := FUNCTION
					 uc_s 						:= corp2.t2u(s);

					 CleanedWords		:= regexreplace(corp2_raw_sc.fGetRegExPattern.FullName.InvalidWords,uc_s,'');
					 CleanedChars		:= regexreplace(corp2_raw_sc.fGetRegExPattern.FullName.InvalidChars,CleanedWords,'');
					 CleanedName 		:= corp2.t2u(CleanedChars);
					 
					 RETURN  CleanedName;
					 
		END;
		
		//****************************************************************************
		//CorpRAAddlInfo: returns the "corp_ra_addl_info".
		//				 input: s -> agentname
		//****************************************************************************
		EXPORT CorpRAAddlInfo(STRING s) := FUNCTION
					 uc_s 					:= corp2.t2u(s);
					 findpattern		:='AGENT RESIGNED|RESIGNATION OF AGENT|RESIGNATION|RESIGNED|NO AGENT|ADDRESS';
					 RETURN	if(regexfind(findpattern,uc_s,0)<>'',uc_s,'');
		END;
		
		//****************************************************************************
		//CorpStatusDesc: returns the "corp_status_desc".
		//				 input: s -> status
		//****************************************************************************
		EXPORT CorpStatusDesc(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN map(uc_s = 'DIS'			=> 'DISSOLVED',
											uc_s = 'FOR' 			=> 'FORFEITURE',
											uc_s = 'GDS'  		=> 'GOOD STANDING',
											uc_s = 'MER' 			=> 'MERGED',
											uc_s = 'NAG' 			=> 'NO AGENT',
											uc_s = 'NOAFFECT' => 'NO AFFECT ON ENTITY STATUS WHEN FILED',
											uc_s = 'REG' 			=> 'REGISTERED',
											uc_s = 'REI' 			=> 'REINSTATED',
											uc_s = 'RES' 			=> 'RESERVATION',
											''
										 );

		END;

		//****************************************************************************
		//EventFilingDesc: returns the "event_filing_desc".
		//					input: s -> txn_id
		//****************************************************************************
		EXPORT EventFilingDesc(STRING s1, STRING s2 ) := FUNCTION
					 uc_s  := corp2.t2u(s1);
					 uc_c  := corp2.t2u(s2);
					 RETURN map(uc_s = 'ABR' 							=> 'ANNUAL BENEFIT CORPORATION',
											uc_s = 'AGT' 							=> 'AGENT',
											uc_s = 'AMD' 							=> 'AMENDMENT',					
											uc_s = 'ANG' 							=> 'HIGH GROWTH SMALL BUSINESS',
											uc_s = 'ANP' and uc_c in['CORP','ELE']=>'ARTICLES OF INCORPORATION', // Per CI:due to discrepancy for 'ANP' on the stateÃ¢â‚¬â„¢s site ,we are looking to check for corptypecode code to populate desc!
											uc_s = 'ANP' and uc_c = 'LLC' =>'ORGANIZATION',
											uc_s = 'ANP' and uc_c = 'RES' =>'NAME RESERVATION',
											uc_s = 'ASM' 							=> 'ASSUMED NAME',
											uc_s = 'AUT' 							=> 'AUTHORITY',
											uc_s = 'BAR' 							=> '',//NO EXAMPLE FOUND, DO NOT MAP.
											uc_s = 'BOR' 							=> 'BUSINESS OPPORTUNITY',
											uc_s = 'CON' 							=> 'CONVERSION',
											uc_s = 'CDG' 							=> 'GOOD STANDING CERTIFICATE',
											uc_s = 'COP' 							=> 'COOPERATIVE PETITION', 
											uc_s = 'COR' 							=> 'CORRECTION',					
											uc_s = 'CPT' 							=> '', //UNDEFINED ON THE STATE SITE; DO NOT MAP.  
											uc_s = 'DBA' 							=> 'DOING BUSINESS AS',				
											uc_s = 'DIS' 							=> 'DISSOLUTION',					
											uc_s = 'DLC' 							=> 'DOMESTIC LLC',				
											uc_s = 'DLP' 							=> 'DOMESTIC LLP',
											uc_s = 'ELA' 							=> 'ELEEMOSYNARY AMENDMENT',		
											uc_s = 'ELD' 							=> 'ELEEMOSYNARY DISSOLUTION',		
											uc_s = 'ELE' 							=> 'ELEEMOSYNARY INCORPORATION',		
											uc_s = 'ELR' 							=> 'ELEEMOSYNARY RELIGIOUS',			
											uc_s = 'ERR' 							=> 'FORFEITURE IN ERROR',			
											uc_s = 'FAM' 							=> 'FOREIGN AMENDMENT',
											uc_s = 'FIC' 							=> 'FICTITIOUS NAME',
											uc_s = 'FLC' 							=> 'FOREIGN LLC',											
											uc_s = 'FLP' 							=> 'FOREIGN LLP',											
											uc_s = 'FNE' 							=> 'APPLICATION FOR USE OF AN INDISTINGUISHABLE NAME', 
											uc_s = 'FOR' 							=> 'FORFEITURE',
											uc_s = 'GDS' 							=> 'GOOD STANDING',
											uc_s = 'INC' 							=> 'INCORPORATION',
											uc_s = 'INT' 							=> 'INTENT',
											uc_s = 'JDN' 							=> 'JUDICIAL DISSOLUTION',
											uc_s = 'LIM' 							=> 'LIMITED PARTNERSHIP',
											uc_s = 'LLC' 							=> 'LIMITED LIABILITY COMPANY',
											uc_s = 'LLP' 							=> 'DOMESTIC LLP',
											uc_s = 'LPA' 							=> 'LIMITED PARTNERSHIP AMENDMENT',
											uc_s = 'LPR' 							=> 'LLP RENEWAL',
											uc_s = 'MER' 							=> 'MERGER',
											uc_s = 'MIL'							=> 'ARTICLES OF INCORPORATION FOR A MILITARY CORPORATION',
											uc_s = 'MSC' 							=> 'MERGER SURVIVOR',
											uc_s = 'NAG' 							=> 'NO AGENT, NOT IN GOOD STANDING',
											uc_s = 'NAL' 							=> 'ADMINISTRATIVE DISSOLUTION',
											uc_s = 'NEW' 							=> 'CORPORATION',
											uc_s = 'PSC' 							=> 'PUBLIC SERVICE DISTRICT CONVERSION',
											uc_s = 'PSD' 							=> 'PUBLIC SERVICE DISTRICT CONVERSION',
											uc_s = 'REG'						  => 'REGISTRATION',
											uc_s = 'REI' 							=> 'REINSTATEMENT',
											uc_s = 'RES'	 						=> 'RESERVATION',											
											uc_s = 'RNW'							=> 'CHANGE OF AGENT OR OFFICE',
											uc_s = 'ROA'							=> 'REGISTRATION OF AGENT',
											uc_s = 'SHX' 							=> 'ARTICLES OF MERGER OR SHARE EXCHANGE',
											uc_s = 'SPC' 							=> 'ADMINISTRATIVE DISSOLUTION IN ERROR',
											uc_s = 'SPD' 							=> 'SPECIAL PURPOSE DISTRICT',
											uc_s = 'SPR' 							=> 'AMENDMENT',
											uc_s = 'WDR' 							=> 'WITHDRAWAL',
											uc_s =''                  =>'',
											if(uc_c not in ['CORP','ELE','LLC','RES',''] ,'**|'+uc_s+' '+uc_c,'**|'+uc_s)
										 );
		END;

END;
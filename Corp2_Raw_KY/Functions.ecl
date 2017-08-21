IMPORT corp2, corp2_mapping, lib_stringlib;

EXPORT Functions := Module

		//****************************************************************************
		//Valid_US_State_Codes: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT Valid_US_State_Codes(string s) := FUNCTION
					 RETURN map (corp2.t2u(s) in ['AK','AL','AR','AS','AZ','CA','CO','CT','CZ','DC','DE','FL','GA','GU','HI',
																				'IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MI','MN','MO','MS','MT','NC',
																				'NH','NJ','NM','NV','NY','OH','OK','OR','PA','PR','RI','SC','SD','TN','TT',
																				'ND','NE','TX','US','UT','VA','VI','VT','WA','WI','WV','WY',''] => true,false);
		END;
					
		//****************************************************************************
		//State_Description: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT State_Code_Translation(string s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = ''		=> '',
											uc_s = 'AA' => 'ARMED FORCES AMERICAS EXCEPT CANADA',
											uc_s = 'AE'	=> 'ARMED FORCES EUROPE, THE MIDDLE EAST AND CANADA',
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
											uc_s = 'TT' => 'TRUST TERRITORIES',
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
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//Foreign_Code_Translation: returns whether the code is valid or not.
		//****************************************************************************
		EXPORT Foreign_Code_Translation(string s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'AA'				=> 'ANTARCTICA',
											uc_s = 'AB'     	=> 'ALBERTA',
											uc_s = 'AL'				=> 'ALBERTA',
											uc_s = 'AD' 			=> 'AD',			//Unknown Territory
											uc_s = 'AT' 			=> 'AUSTRIA',
											uc_s = 'AU' 			=> 'AUSTRALIA',
											uc_s = 'BA'				=> 'BAHAMAS',
											uc_s = 'BC' 			=> 'BRITISH COLUMBIA',
											uc_s = 'BE'				=> 'BELGIUM',
											uc_s = 'BI'				=> 'BELIZE',											
											uc_s = 'BU'				=> 'BERMUDA',
											uc_s = 'BV' 			=> 'BRITISH VIRGIN ISLANDS',
											uc_s = 'BVI' 			=> 'BRITISH VIRGIN ISLANDS',
											uc_s = 'BZ' 			=> 'BRAZIL',
											uc_s = 'CAN' 			=> 'CANADA',
											uc_s = 'CD' 			=> 'CANADA',
											uc_s = 'CH'				=> 'CHINA',
											uc_s = 'CI'				=> 'CAYMAN ISLANDS',
											uc_s = 'CN'				=> 'CANADA',
											uc_s = 'CR'				=> 'CZECH REPUBLIC',
											uc_s = 'CY'				=> 'CYPRUS',
											uc_s = 'DD'				=> '',				//Unknown Territory
											uc_s = 'DU'				=> 'ARUBA',
											uc_s = 'EC' 			=> 'ECUADOR',
											uc_s = 'EG' 			=> 'ENGLAND',
											uc_s = 'EN' 			=> 'ENGLAND',
											uc_s = 'FC'				=> '',				//Unknown Territory
											uc_s = 'FI'				=> 'FINLAND',
											uc_s = 'FN'				=> 'FRANCE',
											uc_s = 'FR' 			=> 'FRANCE',
											uc_s = 'GB' 			=> 'GREAT BRITAIN',
											uc_s = 'GE' 			=> 'GERMANY',
											uc_s = 'H2'    		=> 'CANADA',
											uc_s = 'HK' 			=> 'HONG KONG',
											uc_s = 'IE' 			=> 'IRELAND',
											uc_s = 'II' 			=> 'INDIA',
											uc_s = 'IR'				=> 'IRELAND',
											uc_s = 'IS'				=> 'ISRAEL',
											uc_s = 'IT' 			=> 'ITALY',
											uc_s = 'JA' 			=> 'JAPAN',
											uc_s = 'JP' 			=> 'JAPAN',
											uc_s = 'KO' 			=> 'KOREA',
											uc_s = 'LA'				=> 'LATIVIA',
											uc_s = 'LB' 			=> 'LUXEMBOURG',
											uc_s = 'LG' 			=> 'LUXEMBOURG',
											uc_s = 'LI' 			=> 'LIECHTENSTEIN',
											uc_s = 'LK' 			=> 'SRI LANKA',
											uc_s = 'LU' 			=> 'LUXEMBOURG',
											uc_s = 'LV'				=> 'LATVIA',
											uc_s = 'LX' 			=> 'LUXEMBOURG',
											uc_s = 'MB'				=> 'MANITOBA',
											uc_s = 'MU'				=> 'MAURITIUS',
											uc_s = 'MX'				=> 'MEXICO',
											uc_s = 'NA'				=> 'NETHERLANDS',
											uc_s = 'NB' 			=> 'NEW BRUNSWICK',
											uc_s = 'NE'				=> 'ANTILLES',
											uc_s = 'NF' 			=> 'NEWFOUNDLAND',
											uc_s = 'NO' 			=> 'NORWAY',
											uc_s = 'NS'				=> 'NOVA SCOTIA',
											uc_s = 'NT'				=> 'NETHERLANDS',
											uc_s = 'NZ' 			=> 'NEW ZEALAND',
											uc_s = 'ON' 			=> 'ONTARIO',
											uc_s = 'OT' 			=> 'ONTARIO',											
											uc_s = 'PE' 			=> 'PRINCE EDWARD ISLAND',
											uc_s = 'PER'			=> 'PERU',
											uc_s = 'PH'				=> 'PHILIPPINES',
											uc_s = 'PI'				=> 'PHILIPPINES',											
											uc_s = 'PN'				=> 'PANAMA',
											uc_s = 'PR'				=> 'PUERTO RICO',
											uc_s = 'PQ' 			=> 'QUEBEC',
											uc_s = 'QB'				=> 'QUEBEC',											
											uc_s = 'QC'				=> 'QUEBEC',
											uc_s = 'QE'				=> 'QUEBEC',
											uc_s = 'QU'				=> 'QUEBEC',
											uc_s = 'RN'				=> 'NIGERIA',
											uc_s = 'RS' 			=> 'RUSSIA',
											uc_s = 'RO'				=> 'ROMANIA',
											uc_s = 'RP' 			=> 'PHILIPPINES',
											uc_s = 'RU' 			=> 'RUSSIA',
											uc_s = 'SA'				=> 'SAUDI ARABIA',
											uc_s = 'SE' 			=> 'SWEDEN',
											uc_s = 'SF'				=> '',				//Unknown Territory											
											uc_s = 'SK'				=> 'SASKATCHEWAN',
											uc_s = 'SP'				=> 'SPAIN',
											uc_s = 'SS'				=> 'SCOTLAND',
											uc_s = 'SW' 			=> 'SWITZERLAND',
											uc_s = 'SZ'				=> 'SWITZERLAND',
											uc_s = 'TA'				=> 'TAMIL NADU',
											uc_s = 'TC' 			=> 'TURKS AND CAICOS ISLANDS',
											uc_s = 'TW'				=> 'TAIWAN',
											uc_s = 'UA'				=> 'UNITED ARAB EMIRATES',
											uc_s = 'UK' 			=> 'UNITED KINGDOM',
											uc_s = 'UR' 			=> 'UKRAINE',											
											uc_s = 'US' 			=> 'US',
											uc_s = 'USA' 			=> 'US',
											uc_s = 'VI' 			=> 'VIRGIN ISLANDS',
											uc_s = 'WG' 			=> 'WEST GERMANY',
											uc_s = 'WN' 			=> 'WEST INDIES',
											uc_s = 'XX'				=> '',				//Unknown Territory
											uc_s = 'YT' 			=> 'YUKON',
											uc_s = 'ZA'				=> 'SOUTH AFRICA',
											uc_s = 'YY'				=> '', 				//Unknown Territory
											uc_s = ''					=> '',											
											'**|'+uc_s
										 );
		END;
		
		//****************************************************************************
		//Foreign_Desc_Translation: returns whether the description is valid or not.
		//****************************************************************************
		EXPORT Foreign_Desc_Translation(string s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'ANTARCTICA'									=> 'AA',
											uc_s = 'AUSTRIA' 										=> 'AT',
											uc_s = 'AUSTRALIA' 									=> 'AU',
											uc_s = 'BELGIUM'										=> 'BE',
											uc_s = 'BERMUDA'										=> 'BU',
											uc_s = 'BRITISH VIRGIN ISLANDS' 		=> 'BV',
											uc_s = 'BRAZIL'			 								=> 'BZ',
											uc_s = 'CANADA'     								=> 'CD',
											uc_s = 'COTE D\'LVOIRE'							=> 'CI',
											uc_s = 'CYPRUS'											=> 'CY',
											uc_s = 'ECUADOR'										=> 'EC',
											uc_s = 'ENGLAND' 										=> 'EN',
											uc_s = 'FINLAND'										=> 'FI',
											uc_s = 'FOREIGN'										=> 'FN',
											uc_s = 'FRANCE' 										=> 'FR',
											uc_s = 'GREAT BRITAIN' 							=> 'GB',
											uc_s = 'GERMANY' 										=> 'GE',
											uc_s = 'HONG KONG' 									=> 'HK',
											uc_s = 'IRELAND' 										=> 'IE',
											uc_s = 'INDIA'						 					=> 'II',
											uc_s = 'ITALY'						 					=> 'IT',
											uc_s = 'JAPAN' 											=> 'JP',
											uc_s = 'KOREA'								 			=> 'KO',
											uc_s = 'LATIVIA'										=> 'LA',
											uc_s = 'LIBERIA' 										=> 'LI',
											uc_s = 'LUXEMBOURG'						 			=> 'LU',
											uc_s = 'MAURITIUS'									=> 'MU',
											uc_s = 'MEXICO'											=> 'MX',
											uc_s = 'ANTILLES'										=> 'NE',
											uc_s = 'NORWAY' 										=> 'NO',
											uc_s = 'NETHERLANDS'								=> 'NT',
											uc_s = 'NEW ZEALAND' 								=> 'NZ',
											uc_s = 'PERU'												=> 'PER',
											uc_s = 'PHILIPPINES'								=> 'PH',
											uc_s = 'NIGERIA'										=> 'RN',
											uc_s = 'RUSSIA'								 			=> 'RU',
											uc_s = 'SAUDI ARABIA'								=> 'SA',
											uc_s = 'SRI LANKA'									=> 'LK',
											uc_s = 'SWEDEN'											=> 'SE',
											uc_s = 'SWAZILAND' 									=> 'SW',
											uc_s = 'SWITZERLAND'								=> 'CH',
											uc_s = 'TURKS AND CAICOS ISLANDS'		=> 'TC',
											uc_s = 'UNITED ARAB EMIRATES'				=> 'UA',
											uc_s = 'UNITED KINGDOM' 						=> 'UK',
											uc_s = 'US' 												=> 'US',
											uc_s = 'VIRGIN ISLANDS' 						=> 'VI',
											uc_s = 'WEST GERMANY' 							=> 'WG',
											uc_s = 'WEST INDIES'								=> 'WN',
											uc_s = ''														=> '',											
											'**|'+uc_s
										 );
		END;
		
		//****************************************************************************
		//Clean_Foreign_Description: returns whether the description is valid or not.
		//****************************************************************************
		EXPORT Clean_Foreign_Description(string s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'AMSTERDAM' 								=> uc_s,
											uc_s = 'AUSTRALIA' 								=> uc_s,
											uc_s = 'AUSTRIA'     							=> uc_s,
											uc_s = 'BAHAMA ISLAND' 						=> 'BAHAMA ISLANDS',
											uc_s = 'BAHAMA ISLANDS' 					=> uc_s,
											uc_s = 'BAHAMAS' 									=> uc_s,
											uc_s = 'BARBADOS' 								=> uc_s,
											uc_s = 'BELGIUM' 									=> uc_s,
											uc_s = 'BERMUDA'									=> uc_s,
											uc_s = 'BRITISH COLUMBI' 					=> 'BRITISH COLUMBIA',
											uc_s = 'BRITISH VIRGIN'	 					=> 'BRITISH VIRGIN ISLANDS',
											uc_s = 'CANADA' 									=> uc_s,
											uc_s = 'CANDA' 										=> 'CANADA',
											uc_s = 'CAYMAN ISLAND' 						=> 'CAYMAN ISLANDS',
											uc_s = 'CAYMAN ISLANDS' 					=> uc_s,
											uc_s = 'CHIHUAHUA MEXICO' 				=> uc_s,
											uc_s = 'CHINA' 										=> uc_s,
											uc_s = 'CURACAO'								 	=> uc_s,
											uc_s = 'CYPRUS' 									=> uc_s,
											uc_s = 'ENGLAND' 									=> uc_s,
											uc_s = 'ENGLAND AND WALES' 				=> uc_s,
											uc_s = 'FED CHARTERED' 						=> uc_s,
											uc_s = 'FOREIGN'									=> uc_s,
											uc_s = 'FRANCE' 									=> uc_s,
											uc_s = 'GERMANY' 									=> uc_s,
											uc_s = 'GREAT BRITAIN' 						=> uc_s,
											uc_s = 'GREAT BRITAN' 						=> 'GREAT BRITAIN',
											uc_s = 'GUERNSEY'									=> uc_s,
											uc_s = 'HONG KONG' 								=> uc_s,
											uc_s = 'INDIA' 										=> uc_s,
											uc_s = 'IRELAND' 									=> uc_s,
											uc_s = 'ISLE OF MAN' 							=> uc_s,
											uc_s = 'ITALY'										=> uc_s,
											uc_s = 'JAPAN' 										=> uc_s,
											uc_s = 'LATIVIA'									=> uc_s,
											uc_s = 'KOREA' 										=> uc_s,
											uc_s = 'LUXEMBOURG' 							=> uc_s,
											uc_s = 'LUXEMBURG' 								=> 'LUXEMBOURG',
											uc_s = 'MAURITIUS'								=> uc_s,
											uc_s = 'MEXICO' 									=> uc_s,
											//uc_s = 'NA' 											=> '',
											uc_s = 'NETH ANTILLES' 						=> uc_s,
											uc_s = 'NETHERLANDS' 							=> uc_s,
											uc_s = 'NEW ZEALAND' 							=> uc_s,
											uc_s = 'NOVA SCOTIA'							=> uc_s,
											uc_s = 'ONTARIO' 									=> uc_s,
											uc_s = 'PANAMA' 									=> uc_s,
											uc_s = 'PARAGUAY' 								=> uc_s,
											uc_s = 'PHILIPPINES' 							=> uc_s,
											uc_s = 'PHILLIPPINES' 						=> 'PHILIPPINES',											
											uc_s = 'PUERTO RICO' 							=> uc_s,
											uc_s = 'QUEBEC' 									=> uc_s,
											uc_s = 'RUSSIA'										=> uc_s,
											uc_s = 'SCOTLAND UNITED KINGDOM' 	=> uc_s,
											uc_s = 'SEYCHELLES' 							=> uc_s,
											uc_s = 'SPAIN' 										=> uc_s,
											uc_s = 'SWEDEN' 									=> uc_s,
											uc_s = 'SWAZILAND'								=> uc_s,
											uc_s = 'SWITZERLAND' 							=> uc_s,
											uc_s = 'SWITZERLANDER' 						=> 'SWITZERLAND',
											uc_s = 'TAIWAN' 									=> uc_s,
											uc_s = 'U S GOVERNMENT'						=> 'US',
											uc_s = 'UNITED ARAB EMIRATES'			=> uc_s,
											uc_s = 'UNITED KINGDOM' 					=> uc_s,
											uc_s = 'UNITED STATES' 						=> 'US',
											uc_s = 'UNITES STATES' 						=> 'US',
											uc_s = 'URUGUAY' 									=> uc_s,
											uc_s = 'USA' 											=> 'US',
											uc_s = 'VIRGIN ISLANDS' 					=> uc_s,
											uc_s = 'WEST INDIA' 							=> uc_s,
											uc_s = 'WEST INDIES' 							=> uc_s,
											uc_s = ''													=> '',											
											'**|'+uc_s
										 );											
		END;

		//****************************************************************************
		//CorpForgnStateCD: returns "corp_forgn_state_cd".
		//****************************************************************************
		EXPORT CorpForgnStateCD(string s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
					 
					 fix_bad_codes := map(uc_s = 'LO' => 'LA', //known bad code
																uc_s
															 );

	         RETURN map(fix_bad_codes = 'WILDER'															=> 'KY',
											State_Code_Translation(fix_bad_codes)[1..2] 	<> '**' => uc_s,
											Foreign_Code_Translation(fix_bad_codes)[1..2] <> '**' => uc_s,
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//CorpForgnStateDesc: returns "corp_forgn_state_desc".
		//****************************************************************************
		EXPORT CorpForgnStateDesc(string s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 fix_bad_codes := map(uc_s = 'LO' => 'LOUISIANA', //known bad code
																uc_s
															 );

	         RETURN map(fix_bad_codes = 'WILDER'															=> 'KENTUCKY',
											Foreign_Code_Translation(fix_bad_codes)	= ''   				=> '',											
											Valid_US_State_Codes(fix_bad_codes)									 	=> State_Code_Translation(uc_s),					 
											Foreign_Code_Translation(fix_bad_codes)[1..2] <> '**' => Foreign_Code_Translation(uc_s),
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//RemoveStateInCity: returns a "cleaned city".
		//****************************************************************************
		EXPORT RemoveStateInCity(string city) := FUNCTION

					 uc_city 		:= corp2.t2u(city);
					 citychars	:= corp2.t2u(stringlib.stringfilter(uc_city,' \'-(),\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
					 iscanadiancity := if(regexfind(' CANADA|^CANADA|CANADA$',uc_city,0) <> '',true,false);

					 RETURN map(regexfind(' ALABAMA$| AL$',citychars,0) <> '' 									=> regexreplace(' ALABAMA$| AL$',citychars,''),
											regexfind(' ALASKA$| AK$',citychars,0) <> '' 										=> regexreplace(' ALASKA$| AK$',citychars,''),
											regexfind(' ARKANSAS$| AR$',citychars,0) <> '' 									=> regexreplace(' ARKANSAS$| AR$',citychars,''),
											regexfind(' ARIZONA$| AZ$',citychars,0) <> '' 									=> regexreplace(' ARIZONA$| AZ$',citychars,''),
											regexfind(' CALIFORNIA$| CA$',citychars,0) <> ''								=> regexreplace(' CALIFORNIA$| CA$',citychars,''),
											regexfind(' COLORADO$| CO$',citychars,0) <> ''									=> regexreplace(' COLORADO$| CO$',citychars,''),
											regexfind(' CONNECTICUT$| CT$',citychars,0) <> ''								=> regexreplace(' CONNECTICUT$| CT$',citychars,''),
											regexfind(' DISTRICT OF COLUMBIA$| DC$',citychars,0) <> ''			=> regexreplace(' DISTRICT OF COLUMBIA$| DC$',citychars,''),
											regexfind(' DELAWARE$| DE$',citychars,0) <> ''									=> regexreplace(' DELAWARE$| DE$',citychars,''),
											regexfind(' FLORIDA$| FLA$| FL$',citychars,0) <> ''				 			=> regexreplace(' FLORIDA$| FLA$| FL$',citychars,''),
											regexfind(' GEORGIA$| GA$',citychars,0) <> ''						 	 			=> regexreplace(' GEORGIA$| GA$',citychars,''),
											regexfind(' HAWAII$| HI$',citychars,0) <> ''						 	 			=> regexreplace(' HAWAII$| HI$',citychars,''),
											regexfind(' IOWA$| IA$',citychars,0) <> ''						 	 				=> regexreplace(' IOWA$| IA$',citychars,''),
											regexfind(' IDAHO$| ID$',citychars,0) <> ''						 	 				=> regexreplace(' IDAHO$| ID$',citychars,''),
											regexfind(' ILLINOIS$| ILL$| IL$',citychars,0) <> ''						=> regexreplace(' ILLINOIS$| ILL$| IL$',citychars,''),
											regexfind(' INDIANA$| IND$| IN$',citychars,0) <> ''							=> regexreplace(' INDIANA$| IND$| IN$',citychars,''),
											regexfind(' KANSAS$| KS$',citychars,0) <> ''										=> regexreplace(' KANSAS$| KS$',citychars,''),
											regexfind(' KENTUCKY$| KY$',citychars,0) <> ''									=> regexreplace(' KENTUCKY$| KY$',citychars,''),
											regexfind(' LOUISIANA$| LA$',citychars,0) <> ''									=> regexreplace(' LOUISIANA$| LA$',citychars,''),
											regexfind(' MASSACHUSETTS$| MA$',citychars,0) <> ''							=> regexreplace(' MASSACHUSETTS$| MA$',citychars,''),
											regexfind(' MARYLAND$| MD$',citychars,0) <> ''									=> regexreplace(' MARYLAND$| MD$',citychars,''),
											regexfind(' MAINE$| ME$',citychars,0) <> ''											=> regexreplace(' MAINE$| ME$',citychars,''),
											regexfind(' MICHIGAN$| MI$',citychars,0) <> ''									=> regexreplace(' MICHIGAN$| MI$',citychars,''),
											regexfind(' MINNESOTA$| ,M$',citychars,0) <> ''									=> regexreplace(' MINNESOTA$| MN$',citychars,''),
											regexfind(' MISSOURI$| MO$',citychars,0) <> ''									=> regexreplace(' MISSOURI$| MO$',citychars,''),
											regexfind(' MISSISSIPPI$| MS$',citychars,0) <> ''								=> regexreplace(' MISSISSIPPI$| MS$',citychars,''),
											regexfind(' MONTANA$| MT$',citychars,0) <> ''										=> regexreplace(' MONTANA$| MT$',citychars,''),
											regexfind(' NORTH CAROLINA$| NC$',citychars,0) <> ''						=> regexreplace(' NORTH CAROLINA$| NC$',citychars,''),
											regexfind(' NORTH DAKOTA$| ND$',citychars,0) <> ''							=> regexreplace(' NORTH DAKOTA$| ND$',citychars,''),
											regexfind(' NEBRASKA$| NE$',citychars,0) <> ''									=> regexreplace(' NEBRASKA$| NE$',citychars,''),
											regexfind(' NEW HAMPSHIRE$| NH$',citychars,0) <> ''							=> regexreplace(' NEW HAMPSHIRE$| NH$',citychars,''),
											regexfind(' NEW JERSEY$| NJ$| N J$',citychars,0) <> ''					=> regexreplace(' NEW JERSEY$| NJ$| N J$',citychars,''),
											regexfind(' NEW MEXICO$| NM$',citychars,0) <> ''								=> regexreplace(' NEW MEXICO$| NM$',citychars,''),
											regexfind(' NEVADA$| NV$',citychars,0) <> ''										=> regexreplace(' NEVADA$| NV$',citychars,''),
											regexfind(' NEW YORK$| NY$| N Y$',citychars,0) <> ''						=> regexreplace(' NEW YORK$| NY$| N Y$',citychars,''),
											regexfind(' OHIO$| OH$',citychars,0) <> ''				 							=> regexreplace(' OHIO$| OH$',citychars,''),
											regexfind(' OKLAHOMA$| OK$',citychars,0) <> ''				 					=> regexreplace(' OKLAHOMA$| OK$',citychars,''),
											regexfind(' OREGON$| OR$',citychars,0) <> ''				 						=> regexreplace(' OREGON$| OR$',citychars,''),
											regexfind(' PENNSYLVANIA$| PENN$| PA$',citychars,0) <> ''				=> regexreplace(' PENNSYLVANIA$| PENN$| PA$',citychars,''),
											regexfind(' PUERTO RICO$| PR$',citychars,0) <> ''								=> regexreplace(' PUERTO RICO$| PR$',citychars,''),
											regexfind(' RHODE ISLAND$| RI$',citychars,0) <> ''							=> regexreplace(' RHODE ISLAND$| RI$',citychars,''),
											regexfind(' SOUTH CAROLINA$| SC$| S C$',citychars,0) <> ''			=> regexreplace(' SOUTH CAROLINA$| SC$| S C$',citychars,''),
											regexfind(' SOUTH DAKOTA$| SD$| S D$',citychars,0) <> ''				=> regexreplace(' SOUTH DAKOTA$| SD$| S D$',citychars,''),
											regexfind(' TENNESSEE$| TENN$| TN$',citychars,0) <> ''	 				=> regexreplace(' TENNESSEE$| TENN$| TN$',citychars,''),
											regexfind(' TEXAS$| TX$',citychars,0) <> ''	 		 					 			=> regexreplace(' TEXAS$| TX$',citychars,''),
											regexfind(' UTAH$| UT$',citychars,0) <> ''	 		 					 			=> regexreplace(' UTAH$| UT$',citychars,''),
											regexfind(' VERMONT$| VT$',citychars,0) <> ''	 									=> regexreplace(' VERMONT$| VT$',citychars,''),
											regexfind(' WASHINGTON$| WA$',citychars,0) <> ''	 							=> regexreplace(' WASHINGTON$| WA$',citychars,''),
											regexfind(' WISCONSIN$| WI$',citychars,0) <> ''	 					 			=> regexreplace(' WISCONSIN$| WI$',citychars,''),
											regexfind(' W VIRGINIA$| W VIR$| WV$',citychars,0) <> ''	 			=> regexreplace(' W VIRGINIA$| W VIR$| WV$',citychars,''),
											regexfind('^WEST VIRGINIA$| WEST VIRGINIA$',citychars,0) <> '' 	=> regexreplace('^WEST VIRGINIA$| WEST VIRGINIA$',citychars,''),
											regexfind(' VIRGINIA$| VIR$| VA$',citychars,0) <> ''	 					=> regexreplace(' VIRGINIA$| VIR$| VA$',citychars,''),
											regexfind(' WYOMING$| WY$',citychars,0) <> ''	 									=> regexreplace(' WYOMING$| WY$',citychars,''),
											regexfind('^ST ',citychars,0) <> '' and iscanadiancity					=> corp2.t2u(stringlib.stringfilter(stringlib.splitwords(citychars,',',true)[1],' -ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
											regexfind(' CANADA|^CANADA',uc_city,0) <> ''										=> corp2.t2u(stringlib.stringfilter(stringlib.splitwords(uc_city,' ',true)[1],' -ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
											regexfind(' IRELAND$',citychars,0) <> ''	 											=> regexreplace(' IRELAND$',citychars,''),
											regexfind('^LONDON ',uc_city,0) <> ''														=> corp2.t2u(stringlib.stringfilter(stringlib.splitwords(uc_city,' ',true)[1],' -ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
											regexfind(' SCOTLAND$',citychars,0) <> ''	 											=> regexreplace(' SCOTLAND$',citychars,''),
											uc_city
										 );

		END;
		
		//****************************************************************************
		//CorrectSpelling: returns a "cleaned city".
		//****************************************************************************
		EXPORT CorrectSpelling(string city) := FUNCTION

					 uc_city 		:= corp2.t2u(city);
					 citychars	:= corp2.t2u(stringlib.stringfilter(uc_city,' \'-(),\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 RETURN map(regexfind('^BERLING',citychars,0) <> ''										=> regexreplace('^BERLING',citychars,'BERLIN'),
											regexfind('^CAGARY',citychars,0) <> ''									  => regexreplace('^CAGARY',citychars,'CALGARY'),
											regexfind('^CANEYVIL,LE',citychars,0) <> '' 							=> regexreplace('^CANEYVIL,LE',citychars,'CANEYVILLE'),
											regexfind('^CINNATI|CINCINANTI',citychars,0) <> ''				=> regexreplace('^CINNATI|CINCINANTI',citychars,'CINCINNATI'),
											regexfind('^CY NICOSIA',citychars,0) <> ''								=> regexreplace('^CY NICOSIA',citychars,'NICOSIA'),
											regexfind('^NICOSA',citychars,0) <> ''										=> regexreplace('^NICOSA',citychars,'NICOSIA'),
											regexfind('^NICOSIA-CYPRESS',citychars,0) <> ''						=> regexreplace('^NICOSIA-CYPRESS',citychars,'NICOSIA-CYPRUS'),											
											regexfind('^FRANKFORTK',citychars,0) <> ''						 		=> regexreplace('^FRANKFORTK',citychars,'FRANKFORT'),
											regexfind('^FT, MITCHELL',citychars,0) <> '' 							=> regexreplace('^FT, MITCHELL',citychars,'FT MITCHELL'),
											regexfind(' ISLA$',citychars,0) <> ''						 					=> regexreplace(' ISLA$',citychars,' ISLANDS'),
											regexfind('^LEXINGT0N',uc_city,0) <> ''								 		=> regexreplace('^LEXINGT0N',uc_city,'LEXINGTON'),
											regexfind('^LEXINGTONK',citychars,0) <> ''								=> regexreplace('^LEXINGTONK',citychars,'LEXINGTON'),
											regexfind('^LONDON GREAT BRITAIN',citychars,0) <> ''		  => regexreplace('^LONDON GREAT BRITAIN',citychars,'LONDON GREAT BRITAIN'),
											regexfind('^LOUISVILLEK',citychars,0) <> ''								=> regexreplace('^LOUISVILLEK',citychars,'LOUISVILLE'),
											regexfind('^LUXEMBURG',citychars,0) <> ''									=> regexreplace('^LUXEMBURG',citychars,'LUXEMBOURG'),
											regexfind('^NAKAMURAKU',citychars,0) <> ''								=> regexreplace('^NAKAMURAKU',citychars,'NAKAMURAKU'),
											regexfind(' NETHERLAN$',citychars,0) <> ''								=> regexreplace(' NETHERLAN$',citychars,' NETHERLANDS'),
											regexfind('^ST, ',citychars,0) <> '' 											=> regexreplace('^ST, ',citychars,'ST '),
											uc_city
										 );
		END;
		
		//****************************************************************************
		//InvalidCity: returns a "blank" city.
		//****************************************************************************
		EXPORT InvalidCity(string city) := FUNCTION

					 uc_city 		:= corp2.t2u(city);
					 citychars	:= corp2.t2u(stringlib.stringfilter(uc_city,' \'-(),\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
					 badcity		:= '^8\\-MARCH|^BLZ |^H5$|^KRS|^\\(KRS|^\\( KRS|^L3M|^L4K|^L5N6P6$|^NE3|^NR |^R3T 1Y2|^R-2';
					 
					 RETURN map(regexfind('^ATTENTION |^ATTN |^ATT ',citychars,0) <> ''						=> '', //INVALID: CITY IS A PERSON'S NAME
											regexfind('^P( )*O( )*BOX(.)*',citychars,0) <> ''									=> '', //INVALID: AN ADDRESS
											regexfind(' RD$| ST$',citychars,0) <> ''													=> '', //INVALID: A ROAD OR STREET
											regexfind('^%',uc_city,0) <> ''																		=> '', //INVALID: A PERSON'S NAME
											regexfind(badcity,uc_city,0) <> ''																=> '', //INVALID: A FOREIGN ZIP CODE
											corp2.t2u(stringlib.stringfilterout(uc_city,' -0123456789')) = '' => '', //INVALID: A POSTAL CODE
											uc_city
										 );
		END;		
		
		//****************************************************************************
		//CleanCity: returns a cleaned "pocity".
		//****************************************************************************
		EXPORT CleanCity(string city, string state, string zip) := FUNCTION

					 uc_city 				:= corp2.t2u(city);
					 uc_state 			:= corp2.t2u(state);
					 uc_zip 				:= corp2.t2u(zip);
					 iscanadiancity := if(regexfind(' CANADA|^CANADA|CANADA$',uc_city,0) <> '',true,false);
					 fixedspelling	:= CorrectSpelling(uc_city);
					 removedstate		:= if(uc_state = '',RemoveStateInCity(fixedspelling),fixedspelling);
					 cleanedcity		:= InvalidCity(removedstate);

					 cleancity		:= map(regexfind('^CY-',uc_city,0) <> ''														=> corp2.t2u(stringlib.stringfilter(stringlib.splitwords(uc_city,' ',true)[2],' \'-()ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
															 regexfind('^D-',uc_city,0) <> ''														  => corp2.t2u(stringlib.stringfilter(stringlib.splitwords(uc_city,' ',true)[2],' \'-()ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
															 regexfind('^N=',uc_city,0) <> ''															=> corp2.t2u(stringlib.stringfilter(regexreplace('^N=',uc_city,''),' \'-()ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
															 regexfind('^R R #',uc_city,0) <> ''													=> corp2.t2u(stringlib.stringfilter(regexreplace('^R R #',uc_city,''),' \'-()ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
															 regexfind('^RT #',uc_city,0) <> ''														=> corp2.t2u(stringlib.stringfilter(regexreplace('^RT #',uc_city,''),' \'-()ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
															 regexfind('^RT [0-9] ',uc_city,0) <> ''											=> corp2.t2u(stringlib.stringfilter(regexreplace('^RT [0-9] ',uc_city,''),' \'-()ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
															 regexfind('^BOX ',uc_city,0) <> ''														=> corp2.t2u(stringlib.stringfilter(regexreplace('^BOX',uc_city,''),' \'-()ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
															 regexfind('^BRITISH COLUMBIA',uc_city,0) <> ''								=> 'BRITISH COLUMBIA',
															 regexfind('^ST ',uc_city,0) <> '' and iscanadiancity					=> corp2.t2u(stringlib.stringfilter(stringlib.splitwords(uc_city,',',true)[1],' -ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
															 iscanadiancity																								=> corp2.t2u(stringlib.stringfilter(stringlib.splitwords(uc_city,' ',true)[1],' \'-()ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
															 regexfind('^LONDON ',uc_city,0) <> ''												=> corp2.t2u(stringlib.stringfilter(stringlib.splitwords(uc_city,' ',true)[1],' \'-()ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
															 regexfind('^CHESTER',uc_city,0) <> '' and uc_state in ['UK']	=> corp2.t2u(stringlib.stringfilter(stringlib.splitwords(uc_city,' ',true)[1],' \'-()ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
															 regexfind('^MIDDLESEX',uc_city,0)<>'' and uc_state in ['EN']	=> corp2.t2u(stringlib.stringfilter(stringlib.splitwords(uc_city,' ',true)[1],' \'-()ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
															 stringlib.stringfind(cleanedcity,',',1) <> 0 								=> corp2.t2u(stringlib.stringfilter(stringlib.splitwords(cleanedcity,',',true)[1],' \'-()ABCDEFGHIJKLMNOPQRSTUVWXYZ')),
															 corp2.t2u(stringlib.stringfilter(cleanedcity,' \'-()&ABCDEFGHIJKLMNOPQRSTUVWXYZ'))
														  );
															
					 RETURN regexreplace('(-)*$',cleancity,''); //remove dashes at end of string
		END;

		//****************************************************************************
		//StateCodeInCity: returns the "state code".
		//****************************************************************************
		EXPORT StateCodeInCity(string city) := FUNCTION

					 uc_city 		:= corp2.t2u(city);
		
					 RETURN map(regexfind(' ALABAMA$| AL$',uc_city,0) <> '' 											=> 'AL',
											regexfind(' ALASKA$| AK$',uc_city,0) <> '' 							 					=> 'AK',
											regexfind(' ARKANSAS$| AR$',uc_city,0) <> '' 											=> 'AR',
											regexfind(' ARIZONA$| AZ$',uc_city,0) <> '' 											=> 'AZ',
											regexfind(' CALIFORNIA$| CA$',uc_city,0) <> '' 							 			=> 'CA',
											regexfind(' COLORADO$| CO$',uc_city,0) <> '' 							 				=> 'CO',
											regexfind(' CONNECTICUT$| CT$',uc_city,0) <> '' 							 		=> 'CT',
											regexfind(' DISTRICT OF COLUMBIA$| D C$| DC$',uc_city,0) <> '' 	 	=> 'DC',
											regexfind(' DELAWARE$| DE$',uc_city,0) <> ''  							 			=> 'DE',
											regexfind(' FLORIDA$| FLA$| FL$',uc_city,0) <> '' 				 				=> 'FL',
											regexfind(' GEORGIA$| GA$',uc_city,0) <> '' 										 	=> 'GA',
											regexfind(' GUAM$| GU$',uc_city,0) <> '' 										 			=> 'GU',
											regexfind(' HAWAII$| HI$',uc_city,0) <> '' 										 		=> 'HI',
											regexfind(' IOWA$| IA$',uc_city,0) <> '' 										 			=> 'IA',
											regexfind(' IDAHO$| ID$',uc_city,0) <> '' 										 		=> 'ID',
											regexfind(' ILLINOIS$| ILL$| IL$',uc_city,0) <> '' 							 	=> 'IL',
											regexfind(' INDIANA$| IN$',uc_city,0) <> '' 						 	 				=> 'IN',
											regexfind(' KANSAS$| KS$',uc_city,0) <> '' 												=> 'KS',
											regexfind(' KENTUCKY$| KY$',uc_city,0) <> '' 											=> 'KY',
											regexfind(' LOUISIANA$| LA$',uc_city,0) <> '' 										=> 'LA',
											regexfind(' MASSACHUSETTS$| MA$',uc_city,0) <> '' 								=> 'MA',
											regexfind(' MARYLAND$| MD$',uc_city,0) <> '' 											=> 'MD',
											regexfind(' MAINE$| ME$',uc_city,0) <> '' 												=> 'ME',
											regexfind(' MICHIGAN$| MI$',uc_city,0) <> '' 											=> 'MI',
											regexfind(' MINNESOTA$| MN$',uc_city,0) <> '' 										=> 'MN',
											regexfind(' MISSOURI$| MO$',uc_city,0) <> '' 											=> 'MO',
											regexfind(' MISSISSIPPI$| MS$',uc_city,0) <> '' 									=> 'MS',
											regexfind(' MONTANA$| MT$',uc_city,0) <> '' 											=> 'MT',
											regexfind(' NORTH CAROLINA$| NC$',uc_city,0) <> '' 								=> 'NC',
											regexfind(' NORTH DAKOTA$| ND$',uc_city,0) <> '' 									=> 'ND',
											regexfind(' NEBRASKA$| NE$',uc_city,0) <> '' 											=> 'NE',
											regexfind(' NEW HAMPSHIRE$| NH$',uc_city,0) <> '' 								=> 'NH',
											regexfind(' NEW JERSEY$| NJ$| N J$',uc_city,0) <> '' 			 				=> 'NJ',
											regexfind(' NEW MEXICO$| NH$',uc_city,0) <> '' 										=> 'NM',
											regexfind(' NEVADA$| NH$',uc_city,0) <> '' 												=> 'NV',
											regexfind(' NEW YORK$| NY$| N Y$',uc_city,0) <> '' 							  => 'NY',
											regexfind(' OHIO$| OH$',uc_city,0) <> '' 				 					 				=> 'OH',
											regexfind(' OKLHOMA$| OK$',uc_city,0) <> '' 				 					 		=> 'OK',
											regexfind(' OREGON$| OR$',uc_city,0) <> '' 				 					 			=> 'OR',
											regexfind(' PENN$| PA$',uc_city,0) <> '' 				 					 				=> 'PA',
											regexfind(' PUERTO RICO$| PR$',uc_city,0) <> '' 									=> 'PR',
											regexfind(' RHODE ISLAND$| RI$',uc_city,0) <> '' 									=> 'RI',
											regexfind(' SOUTH CAROLINA$| SC$| S C$',uc_city,0) <> '' 	 				=> 'SC',
											regexfind(' SOUTH DAKOTA$| SD$',uc_city,0) <> '' 									=> 'SD',
											regexfind(' TENNESSEE$| TENN$| TN$',uc_city,0) <> '' 	 		 				=> 'TN',
											regexfind(' TEXAS$| TX$',uc_city,0) <> '' 	 		 					 				=> 'TX',
											regexfind(' UTAH$| UT$',uc_city,0) <> '' 													=> 'UT',											
											regexfind(' W VIRGINIA$| W VIR$| WV$',uc_city,0) <> '' 	 	 				=> 'WV',
											regexfind('^WEST VIRGINIA$| WEST VIRGINIA$',uc_city,0) <> ''		  => 'WV',
											regexfind(' VIRGIN ISLANDS$| VI$',uc_city,0) <> '' 								=> 'VI',
											regexfind(' VIRGINIA$| VIR$| VA$',uc_city,0) <> '' 	 	 		 				=> 'VA',
											regexfind(' VERMONT$| VT$',uc_city,0) <> '' 											=> 'VT',
											regexfind(' WASHINGTON$| WA$',uc_city,0) <> '' 	 					 				=> 'WA',
											regexfind(' WISCONSIN$| WI$',uc_city,0) <> '' 	 					 				=> 'WI',
											regexfind(' WYOMING$| WY$',uc_city,0) <> '' 											=> 'WY',
											''
											);
		END;


		//****************************************************************************
		//StateCodeInStateZip: returns the "state code".
		//****************************************************************************
		EXPORT StateCodeInStateZip(string state, string zip) := FUNCTION

					 uc_state 	:= corp2.t2u(state);
					 uc_zip 		:= corp2.t2u(zip);
					 state_zip	:= uc_state + ' ' + uc_zip;

					 RETURN map(regexfind('NE JERSEY$|N JERSEY$|N J$',state_zip,0) <> ''						=> 'NJ',
											regexfind('NEW YORK$|NE YORK$|N Y$',state_zip,0) <> ''							=> 'NY',
											regexfind('S CAROLINA$|S C$|S CAR$',state_zip,0) <> ''							=> 'SC',
											regexfind('W VIRGINIA$|W VA$|',state_zip,0) <> '' 	 	 							=> 'WV',
											regexfind('WE VIRGINIA$|WE VIR$|WE VA$',state_zip,0) <> ''					=> 'WV',
											''
											);
		END;

		//****************************************************************************
		//CleanState: returns a cleaned "state".'
		//****************************************************************************
		EXPORT CleanState(string city, string state, string zip) := FUNCTION

					 uc_city 		:= corp2.t2u(city);
					 citychars	:= corp2.t2u(stringlib.stringfilter(uc_city,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
					 uc_state 	:= corp2.t2u(state);
					 statechars	:= corp2.t2u(stringlib.stringfilter(uc_state,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));					 
					 uc_zip 		:= corp2.t2u(zip);
					 zipchars		:= corp2.t2u(stringlib.stringfilter(uc_zip,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 Canada			:= 'CANADA|ALBERTA|NOVA SCOTIA|ONTARIO|TORONTO|CALGARY';
					 
					 tempstate	:= map(corp2.t2u(uc_city+uc_state+uc_zip) = ''															 => '',
														 regexfind('^ATTENTION |^ATTN |^ATT ',citychars,0) <> ''							 => '',
														 regexfind(Canada,citychars,0) <> '' and statechars in ['CA','AL'] 		 => 'CD',
														 regexfind('^35|^36',zipchars,0) <> '' 																 => 'AL',													 
														 regexfind('^38|^39',zipchars,0) <> ''																 => 'MS',														 
														 regexfind('^02',zipchars,0) <> ''																		 => 'RI',
														 regexfind('^43|^44|^45',zipchars,0) <> ''														 => 'OH',
														 regexfind('^46|^47',zipchars,0) <> ''																 => 'IN',
														 regexfind('^60|^61|^62',zipchars,0) <> ''														 => 'IL',
														 regexfind('^40|^41|^42',zipchars,0) <> ''														 => 'KY',
														 regexfind('^27|^28',zipchars,0) <> ''																 => 'NC',
														 regexfind('^03',zipchars,0) <> ''																 		 => 'NH',
														 regexfind('^07|^08',zipchars,0) <> ''														 		 => 'NJ',
														 regexfind('^43|^44|^45',zipchars,0) <> ''														 => 'OH',
														 regexfind('^15|^16|^17|^18|^196',zipchars,0) <> ''										 => 'PA',
														 regexfind('^N\\/A',uc_zip,0) <> '' and statechars in ['R']			 			 => 'RU',
														 regexfind('^29',zipchars,0) <> '' 																		 => 'SC',
														 regexfind('^57',zipchars,0) <> '' 																		 => 'SD',
														 regexfind('^05',zipchars,0) <> ''																		 => 'VT',
														 regexfind('^24|^25|^26',zipchars,0) <> ''														 => 'WV',
														 regexfind('^NEW YORK',citychars,0) <> ''															 => 'NY',
														 Valid_US_State_Codes(statechars)							 												 => statechars,
														 regexfind(' FINLAND$',citychars,0) <> ''															 => 'FI',
														 regexfind(' GERMANY$',citychars,0) <> ''															 => 'GE',
														 regexfind('^INNSBRUCK$',citychars,0) <> '' and uc_state = 'YY'				 => 'AT',	
														 regexfind(' INDIA$',citychars,0) <> ''															 	 => 'II',
														 regexfind('^LIAONING PROVINCE$',citychars,0) <> '' and uc_state = 'YY'=> 'CH',
														 regexfind(' LUXEMBOURG$|LUXEMBURG$',citychars,0) <> ''								 => 'LU',
														 regexfind('^MAKATI CITY',citychars,0) <> '' and uc_state = 'YY'			 => 'PH',
														 regexfind(' PHILLIPPINES$|PHILIPPINES',citychars,0) <> ''						 => 'PH',
														 regexfind('^SAN BORJA$',citychars,0) <> '' and uc_state = 'YY'				 => 'PER',
														 regexfind('^SEINAJOKI$',citychars,0) <> '' and uc_state = 'YY'				 => 'FI',														 
														 regexfind(' SWEDEN$',citychars,0) <> ''															 => 'SE',
														 regexfind('^UNITED KINGDOM$',citychars,0) <> '' and uc_state = 'XX'	 => 'GB',
														 regexfind('^VANCOURVER$',citychars,0) <> '' and uc_state = 'XX'	 		 => 'CD',
														 regexfind('^WILMINGTON$',citychars,0) <> '' and uc_state = 'DD'	 		 => 'DE',
														 Foreign_Code_Translation(statechars)[1..2] <> '**'			 							 => statechars,
														 Clean_Foreign_Description(uc_zip)[1..2] <> '**' 											 => uc_zip,
														 ''
													 );

	         RETURN map(tempstate in [''] and StateCodeInCity(citychars) not in ['']													=> StateCodeInCity(citychars),
											tempstate in [''] and StateCodeInStateZip(statechars,zipchars) not in ['']						=> StateCodeInStateZip(statechars,zipchars),					 
											tempstate in [''] and statechars in ['XX']																						=> '',											
											tempstate in ['','ST']																			 									 				=> '',
											Foreign_Desc_Translation(tempstate)[1..2] not in ['**',''] 	 									 				=> Foreign_Desc_Translation(tempstate),
											length(corp2.t2u(tempstate)) <> 2 and length(statechars) = 2 									 				=> statechars,
											corp2.t2u(stringlib.stringfilter(tempstate,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))
											);
		END;
		
		//****************************************************************************
		//Country: returns a derived field named "country".
		//****************************************************************************
		EXPORT Country(string city, string state, string zip) := FUNCTION

					 uc_city 			 := corp2.t2u(city);
					 citychars		 := corp2.t2u(stringlib.stringfilter(uc_city,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
					 uc_state 		 := corp2.t2u(CleanState(city,state,zip));
					 uc_zip 			 := corp2.t2u(zip);
					 zipchars			 := corp2.t2u(stringlib.stringfilter(uc_zip,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         tempcountry	 := map(regexfind('^ATTENTION |^ATTN |^ATT ',citychars,0) <> ''											=> '',
																regexfind('SRILANKA',zipchars,0) <> ''													=> 'SRI LANKA',
																uc_state in ['SA'] and zipchars in ['ARABIA']			 							=> 'SAUDIA ARABIA',
																uc_state in ['UR'] and zipchars in ['UKRAINE']	 								=> 'UKRAINE',
																uc_state in ['WE'] and zipchars in ['INDIES']		 								=> 'WEST INDIES',
																Valid_US_State_Codes(uc_state)							 										=> 'US',
																Foreign_Code_Translation(uc_state)[1..2] <> '**' 								=> Foreign_Code_Translation(uc_state),
																Clean_Foreign_Description(uc_zip)[1..2] <> '**' 								=> Foreign_Code_Translation(uc_zip),
																stringlib.stringfind(uc_city,'-',1) <> 0 												=> corp2.t2u(stringlib.splitwords(uc_city,'-',true)[2]),
																''
															 );
															 
	         RETURN map(corp2.t2u(tempcountry) = 'BOMBAY' => 'INDIA',
											corp2.t2u(tempcountry) = 'LONDON' => 'ENGLAND',
											corp2.t2u(tempcountry) = 'KY' 		=> 'US',
											corp2.t2u(tempcountry)
											);

		END;																				 

		//****************************************************************************
		//CleanZip: returns a cleaned "zip".
		//****************************************************************************
		EXPORT CleanZip(string city, string state, string zip) := FUNCTION

					 uc_city 		:= corp2.t2u(city);
					 citychars	:= corp2.t2u(stringlib.stringfilter(uc_city,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));					 
					 uc_state 	:= corp2.t2u(state);
					 uc_zip 		:= corp2.t2u(zip);
					 zipchars		:= corp2.t2u(stringlib.stringfilter(uc_zip,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
					 zipfiltered:= corp2.t2u(stringlib.stringfilterout(uc_zip,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
					 zipclean		:= corp2.t2u(stringlib.stringfilter(uc_zip,' -0123456789'));
					 zipincity	:= corp2.t2u(stringlib.stringfilter(uc_city,' -0123456789'));
					 isallzeros := if(corp2.t2u(stringlib.stringfilterout(uc_zip,'0- '))='',true,false);
					 
	         tempzip		:= map(corp2.t2u(uc_city+uc_state+uc_zip) = ''										=> '',
														 regexfind('^ATTENTION |^ATTN |^ATT ',citychars,0) <> ''		=> '',
														 regexfind('^CY-',citychars,0) <> ''												=> corp2.t2u(stringlib.splitwords(uc_city,' ',true)[1]),
														 uc_zip[3] in ['-']																					=> uc_zip,
														 regexfind('^N\\/A',uc_zip,0) <> ''													=> '',
														 uc_zip not in [''] and isallzeros													=> '',
														 uc_zip not in [''] and zipfiltered in ['']									=> '',
														 length(zipincity) in [5,9]																	=> zipincity,
														 uc_zip
													  );

	         RETURN regexreplace('^(-)*|(-)*$',tempzip,''); //remove dashes at the beginning or end of string

		END;

		//****************************************************************************
		//CorpStatusDesc: returns "corp_status_desc".
		//****************************************************************************
		EXPORT CorpStatusDesc(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
					 RETURN	map(uc_s = 'A' =>'ACTIVE',
										  uc_s = 'C' =>'UNKNOWN',
										  uc_s = 'D' =>'DELETED',
										  uc_s = 'F' =>'REAL NAME OF FOREIGN ORG. FILED UNDER A FICTITIOUS NAME',
										  uc_s = 'G' =>'ON FILE',
										  uc_s = 'I' =>'INACTIVE',
										  uc_s = 'N' =>'NOT VERIFIED',
										  uc_s = 'V' =>'FILING VOIDED FOR BAD PAYMENT',
										  uc_s = 'X' =>'PENDING DISSOLUTION',
										  'UNKNOWN'
										);
		END;
		
		//****************************************************************************
		//CorpOrigOrgStructureCD: returns "corp_orig_org_structure_cd".
		//****************************************************************************
		EXPORT CorpOrigOrgStructureCD(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
					 RETURN map(uc_s in ['ACA','ACC','AKL','ALC','ALL','ANN','ASC','ASP',
															 'AST','GPA','LPA','NCR','REG','RES',''] 					=> '',//Not to be mapped, but accounting for here for scrub purposes
											uc_s in ['KY']																						=> '',//Bad type1 code; do not map
											uc_s in ['BDC','BTR','COP','CRU','FBT','FCA','FCC','FCO',
															 'FCP','FGP','FLC','FLL','FLP','FMI','FNB','FNG',
															 'FNL','FNP','FNT','FPS','FSP','FST','KBT','KCA',
															 'KCO','KCP','KLA','KLC','KLL','KLP','KMI','KNG',
															 'KNL','KNP','KPS','KRR','KSP','KST','KUN','PSC']	=> uc_s,
											'**|'+uc_s 			//Mapping new code; Will be rejected by scrubs
										);
		END;

		//****************************************************************************
		//CorpOrigOrgStructureDesc: returns "corp_orig_org_structure_desc".
		//****************************************************************************
		EXPORT CorpOrigOrgStructureDesc(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
					 RETURN map(uc_s = 'BDC'=>'BUSINESS DEVELOPMENT CORPORATION',
											uc_s = 'BTR'=>'BUSINESS TRUST',
											uc_s = 'COP'=>'COOPERATIVE CORPORATION',
											uc_s = 'CRU'=>'CREDIT UNION',
											uc_s = 'FBT'=>'FOREIGN BUSINESS TRUST',
											uc_s = 'FCA'=>'FORIGN LIMITED COOPERATIVE ASSN',
											uc_s = 'FCC'=>'FEDERALLY CHARTERED COMPANY',
											uc_s = 'FCO'=>'FOREIGN CORPORATION',
											uc_s = 'FCP'=>'FOREIGN COOPERATIVE CORPORATION',
											uc_s = 'FGP'=>'FOREIGN GENERAL PARTNERSHIP CA',
											uc_s = 'FLC'=>'FOREIGN LIMITED LIABILITY COMPANY',
											uc_s = 'FLL'=>'FOREIGN LIMITED LIABILITY PARTNERSHIP',
											uc_s = 'FLP'=>'FOREIGN LIMITED PARTNERSHIP',
											uc_s = 'FMI'=>'FOREIGN MUTUAL INSURANCE COMPANY',
											uc_s = 'FNB'=>'FOREIGN NATIONAL BANK',
											uc_s = 'FNG'=>'FOREIGN RUPA PARTNERSHIP',
											uc_s = 'FNL'=>'FOREIGN RUPA LIMITED LIABILITY PARTNERSHIP',
											uc_s = 'FNP'=>'FOREIGN ULPA LIMITED PARTNERSHIP',
											uc_s = 'FNT'=>'FOREIGN NEW BUSINESS TRUST',
											uc_s = 'FPS'=>'FOREIGN PROFESSIONAL SERVICES CORPORATION',
											uc_s = 'FSP'=>'FOREIGN SOLE PROPRIETORSHIP',
											uc_s = 'FST'=>'FOREIGN STATUTORY TRUST',
											uc_s = 'KBT'=>'KENTUCKY BUSINESS TRUST',
											uc_s = 'KCA'=>'KENTUCKY LIMITED COOPERATIVE ASSN',
											uc_s = 'KCO'=>'KENTUCKY CORPORATION',
											uc_s = 'KCP'=>'KENTUCKY COOPERATIVE CORPORATION',
											uc_s = 'KLA'=>'KENTUCKY LEGISLATIVE ACT',
											uc_s = 'KLC'=>'KENTUCKY LIMITED LIABILITY COMPANY',
											uc_s = 'KLL'=>'KENTUCKY LIMITED LIABILITY PARTNERSHIP',
											uc_s = 'KLP'=>'KENTUCKY LIMITED PARTNERSHIP',
											uc_s = 'KMI'=>'KENTUCKY MUTUAL INSURANCE COMPANY',
											uc_s = 'KNG'=>'KENTUCKY RUPA PARTNERSHIP',
											uc_s = 'KNL'=>'KENTUCKY RUPA LIMITED LIABILITY PARTNERSHIP',
											uc_s = 'KNP'=>'KENTUCKY ULPA LIMITED PARTNERSHIP',
											uc_s = 'KPS'=>'KENTUCKY PROFESSIONAL SERVICES CORPORATION',
											uc_s = 'KRR'=>'KENTUCKY RETENTION ACT',
											uc_s = 'KSP'=>'KENTUCKY SOLE PROPRIETORSHIP',
											uc_s = 'KST'=>'KENTUCKY STATUTORY TRUST',
											uc_s = 'KUN'=>'UNINCORPORATED NON-PROFIT ASSN',
											uc_s = 'PSC'=>'PROFESSIONAL SERVICES CORPORATION',
											uc_s = 'KY' =>'',												 			 //Bad type1 code; do not map
											uc_s in ['ACA','ACC','AKL','ALC','ALL','ANN','ASC','ASP','AST',
															 'GPA','LPA','NCR','REG','RES']	=>'',  //Known codes not to be mapped, but accounting for here for scrub purposes
											'**|'+uc_s
										);
		END;

		//****************************************************************************
		//ContTitle1Desc: returns "cont_title1_desc".
		//****************************************************************************
		EXPORT ContTitle1Desc(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
					 RETURN case(uc_s,
											'P' => 'PRESIDENT',
											'V' => 'VICE PRESIDENT',
											'S' => 'SECRETARY',
											'T' => 'TREASURER',
											'D' => 'DIRECTOR',
											'M' => 'MEMBER',
											'N' => 'MANAGER',
											'L' => 'SOLE OFFICER',
											'C' => 'CHAIRMAN',
											'H' => 'SHAREHOLDER',
											'E' => 'CHIEF EXECUTIVE OFFICER',
											'@' => 'OFFICER',
											'U' => 'UNKNOWN',
											'I' => 'INCORPORATOR',
											'O' => 'ORGANIZER',
											'G' => 'GENERAL PARTNER',
											'X' => 'ARP SIGNATURE',
											'A' => 'ACCOUNTANT',
											'R' => 'ASSISTANT SECRETARY',
											'B' => 'ASSISTANT TREASURER',
											'F' => 'CFO',
											'Y' => 'CERTIFIED PUBLIC ACCOUNTANT',
											'J' => 'CHIEF OPERATIONS OFFICER',
											'K' => 'CLERK',
											'Q' => 'CHIEF INFORMATION OFFICER',
											'W' => 'EXECUTIVE',
											'Z' => 'GENERAL MANAGER',
											'1' => 'LIMITED PARTNER',
											'2' => 'MANAGING MEMBER',
											'3' => 'MANAGING PARTNER',
											'4' => 'MANAGING AGENT',
											'5' => 'PARTNER',
											'6' => 'NO TITLE',
											'7' => 'INITIAL DIRECTOR',
											'8' => 'REGISTERED AGENT',
											''
										);
		END;
		
		//****************************************************************************
		//StockSharesIssued: returns "stock_shares_issued".
		//****************************************************************************
		EXPORT StockSharesIssued(string s) := FUNCTION
					 
					 returnvalue := map(stringlib.stringfilterout(s,'0123456789')=''	=> (string)(integer)s,
															stringlib.stringfind(s,',',1)<>0 							=> (string)(integer)stringlib.stringfilter(s,'0123456789'),
															corp2.t2u(s)
														 );
					 RETURN if(returnvalue in ['','0'],'',returnvalue);
					 
		END;	
		
END;
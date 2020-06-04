IMPORT corp2, corp2_raw_nv, ut, corp2_mapping;

EXPORT Functions := Module
		
		EXPORT state_origin 					:= 'NV';
		EXPORT state_desc	 						:= 'NEVADA';
					 
		//********************************************************************
		//cleanName: Cleans up known issues with different Name fields
		//********************************************************************		
		EXPORT cleanName(string s) := FUNCTION
						 
					 ucName := corp2.t2u(s);	
					 
				   ucNameMap :=  MAP(corp2.t2u(stringlib.stringFilterOut(ucName,'.X')) = ''           => '',
														 ucName in ['-',
																				'LISTED',
																				'NOMINEE',
																				'NON-LISTED',         
																				'NO DIRECTORS LISTED', 
																				'NONE LISTED', 
																				'POSITION',
																				'POSITION VACANT',   
																				'OPEN POSITION',       
																				'(OPEN POSITION)',     
																				'POSITION OPEN',       
																				'POSITION VACANT',
																				'REMOVED',
																				'RESIGNED',
																				'XXXXXXXXXXXXXXXX THIS IS NOT A MARK COMPUTER ERRORXXXXXXXXXXXXXXX',
																				'XXX ERROR AT PROCESSING NO MARK ON FILE XXXX',
																				'VACANT',
																				'**VACANT**',
																				'VACANT - TO BE FILLE',
																				'TEMPORARY VACANT',
																				'.RESIGNED',
																				'.NOT REQUIRED',
																				'.NOT ASSIGNED']																					    => '',
														 stringlib.stringfind(ucName,'(NOMINEE)',1) <> 0                  => regexreplace('\\(NOMINEE\\)',ucName,''),
														 stringlib.stringfind(ucName,'- NOMINEE',1) <> 0                  => regexreplace('\\- NOMINEE',ucName,''),
														 stringlib.stringfind(ucName,'-NOMINEE',1) <> 0                   => regexreplace('\\-NOMINEE',ucName,''),
														 stringlib.stringfind(ucName,'(RESIGNED)',1) <> 0                 => regexreplace('\\(RESIGNED\\)',ucName,''),
														 stringlib.stringfind(ucName,'- RESIGNED',1) <> 0                 => regexreplace('\\- RESIGNED',ucName,''),
														 stringlib.stringfind(ucName,'-RESIGNED',1) <> 0                  => regexreplace('\\-RESIGNED',ucName,''),
														 stringlib.stringfind(ucName,'RESIGNED -',1) <> 0                 => regexreplace('RESIGNED \\-',ucName,''),
														 stringlib.stringfind(ucName,'TERMINATED -',1) <> 0               => regexreplace('TERMINATED \\-',ucName,''),
														 ucName);  
											 
				RETURN Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,ucNameMap).BusinessName; // Some are business names
		END;		
		
		//********************************************************************
		//cleanLegalName: Cleans up known issues with Legal name fields
		//********************************************************************		
		EXPORT cleanLegalName(string s) := FUNCTION
					 
					 ucName := corp2.t2u(s);
		
					 tempName := if(corp2.t2u(stringlib.stringFilterOut(ucName,'.X')) <> '' and 
												  corp2.t2u(ucName) not in ['XXXXXXXXXXXXXXXX THIS IS NOT A MARK COMPUTER ERRORXXXXXXXXXXXXXXX',
																												 'XXX ERROR AT PROCESSING NO MARK ON FILE XXXX']                                                                                                                                                                                                                                                                                                                  
												 ,ucName,'');
												
				RETURN Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,tempName).BusinessName;  
		END;
		
		//********************************************************************
		//cleanForeignName: Cleans up known issues with Foreign Name
		//********************************************************************		
		EXPORT cleanForeignName(string s) := FUNCTION

					 ucName := corp2.t2u(s);
					 
				   ucNameMap :=  MAP(stringlib.stringfilterout(ucName,' 0123456789') = ''           => '',
														 ucName in [ut.Set_State_Abbrev,
																				ut.Set_State_Names,
																				Corp2_Raw_NV.set_of_Countries,
																				', L.P.',
																				', LLC',
																				'`',
																				'501C3',
																				'CALIFORNIA (CA)', 
																				'COMMENT ONLY A CERTIFIED COPY OF DISSOLUTION FROM HOME STATE FILED',
																				'DELAWARE (DE)',
																				'IS SAME',
																				'IS THE SAME',
																				'L.L.C.',
																				'LLC',
																				'MIAMI FLORIDA',
																				'MODIFIED NAME SEE COMMENTS FOR',
																				'MODIFIED NAME... SEE COMMENT SCREEN FOR ACTUAL',
																				'MODIFIED NAME...SEE COMMENT SCREEN FOR',
																				'NAME IS THE SAME',
																				'NAME SAME',
																				'SAME AS ABOVE',
																				'SAME AS HOME STATE LLC CANCELLED',
																				'SAME AS',
																				'SAME EXCEPT L.L.C.',
																				'SAME EXCEPT LLC',
																				'SAME IN THE HOME STATE',
																				'SAME',
																				'THE SAME']																					=> '',
														 stringlib.stringfind(ucName,'LLATION FILED ',1) <> 0 => '',
														 ucName[1..5] = 'SAME ' and ucName[6..] in ut.Set_State_Abbrev  => '', 
														 ucName[1..5] = 'SAME ' and ucName[6..] in ut.Set_State_Names   => '',
														 ucName[1..11] = 'HOME STATE ' and ucName[12..] in Corp2_Raw_NV.set_of_Countries    => '',
														 ucName[1..14] = 'HOME STATE IS ' and ucName[15..] in Corp2_Raw_NV.set_of_Countries => '',
														 ucName[1..10] = 'ACTUAL IS '                 									=> ucName[11..],
														 ucName[1..26] = 'ACTUAL NAME IN HOME STATE ' 									=> ucName[27..],
														 ucName[1..15] = 'ACTUAL NAME IS '            									=> ucName[16..],
														 ucName[1..7]  = 'ACTUAL '                    									=> ucName[8..],
														 ucName[1..31] = 'CORP NAME IN THE HOME STATE IS '              => ucName[32..],
														 ucName[1..14] = 'HOME STATE IS '             									=> ucName[15..],
														 ucName[1..12] = 'HOME STATE; '               									=> ucName[13..],
														 ucName[1..16] = 'HOME STATE NAME '           									=> ucName[17..],
														 ucName[1..16] = 'HOME STATE NAME/'           									=> ucName[17..],
														 ucName[1..11] = 'HOME STATE '                									=> ucName[12..],
														 ucName[1..3]  = 'IS '                        									=> ucName[4..],
														 ucName[1..21] = 'MODIFIED NAME ABOVE. '      									=> ucName[22..],
														 ucName[1..17] = 'MODIFIED NAME IS '          									=> ucName[18..],
														 ucName[1..14] = 'MODIFIED NAME '             									=> ucName[15..],
														 ucName[1..15] = 'MODIFIED NAME; '            									=> ucName[16..],
														 ucName[1..10] = 'NAME HOME '                 									=> ucName[11..],
														 ucName[1..26] = 'NAME IN THE HOME STATE IS ' 									=> ucName[27..],
														 ucName[1..23] = 'NAME IN THE HOME STATE '    									=> ucName[24..],
														 ucName[1..22] = 'NAME IS HOME STATE IS '     									=> ucName[23..],
														 ucName[1..19] = 'NAME IS HOME STATE '                          => ucName[20..],
														 ucName[1..15] = 'THE HOME STATE '                              => ucName[16..],
														 ucName[1..7]  = 'THE IS '                                      => ucName[8..],
														 ucName);  
											 
				RETURN ucNameMap;
		END;
		
		//********************************************************************************
		// Known and valid corp_types from the vendor
		//********************************************************************************
		EXPORT Valid_Legal_Types :=    ['COMMERCIAL REGISTERED AGENT',
																		'DOMESTIC BUSINESS TRUST',
																		'DOMESTIC CLOSE CORPORATION',
																		'DOMESTIC CORPORATION',   
																		'DOMESTIC CORPORATION SOLE',
																		'DOMESTIC LIMITED-LIABILITY COMPANY',
																		'DOMESTIC LIMITED PARTNERSHIP (87A)',
																		'DOMESTIC LIMITED PARTNERSHIP (88)',
																		'DOMESTIC LIMITED-LIABILITY PARTNERSHIP',
																		'DOM LTD-LIABILITY LTD PARTNERSHIP (87A)',
																		'DOM LTD-LIABILITY LTD PARTNERSHIP (88)',
																		'DOM NONPROFIT COOP CORP W OR W/O STOCK',
																		'DOMESTIC NONPROFIT COOP CORP W/O STOCK',
																		'DOMESTIC NONPROFIT CORPORATION',
																		'DOMESTIC PROFESSIONAL CORPORATION',
																		'DOMESTIC PROFESSIONAL LLC',
																		'FOREIGN BUSINESS TRUST',
																		'FOREIGN CLOSE CORPORATION', 
																		'DOMESTIC COOPERATIVE ASSOCIATION',
																		'FOREIGN CORPORATION',   
																		'FOREIGN CORPORATION SOLE (80)', 
																		'FOREIGN ENTITIES NOT REQ TO REGISTER NV',
																		'FOREIGN LIMITED-LIABILITY COMPANY',
																		'FOREIGN LIMITED PARTNERSHIP (87A)',
																		'FOREIGN LIMITED PARTNERSHIP (88)',
																		'FOREIGN LIMITED-LIABILITY PARTNERSHIP',
																		'FOREIGN LLLP (87A)',
																		'FOREIGN LLLP (88)',
																		'FOREIGN NONPROFIT CORPORATION',
																		'FOREIGN PROFESSIONAL CORPORATION', 
																		'GENERAL IMPROVEMENT DISTRICT',
																		'GENERAL IMPROVEMENT DISTRICTS',
																		'GENERIC ENTITY', 
																		'PARTNERSHIP AUTHORITY',
																		'RAILROADS',
																		'TELEPHONES & TELEGRAPH'];
			EXPORT Valid_NameRes_Type := ['NAME RESERVATION'];
																
																
		//********************************************************************
		//NameTypeDesc: Returns the "corp_ln_name_type_desc".
		//********************************************************************	
		EXPORT NameTypeDesc(STRING s) := FUNCTION
		
				 RETURN  MAP(corp2.t2u(s) in Valid_Legal_Types  		=> 'LEGAL',
										 corp2.t2u(s) in Valid_NameRes_Type			=> 'RESERVED',
										 '**|'+corp2.t2u(s)); 											
		END;

		//********************************************************************
		//CorpOrigOrgStructureDesc: Returns "corp_orig_org_structure_desc".
		//********************************************************************	
		EXPORT CorpOrigOrgStructureDesc(STRING s) := FUNCTION
					
				RETURN  IF(corp2.t2u(s) in [Valid_Legal_Types, Valid_NameRes_Type]
				           ,corp2.t2u(s)
									 ,'**|'+corp2.t2u(s)); 			
		END;

		//********************************************************************
		//CorpStatusDesc: Returns the "corp_status_desc".
		//********************************************************************	
		EXPORT CorpStatusDesc(STRING s) := FUNCTION
		
				 RETURN  MAP(corp2.t2u(s) in ['ACTIVE',
																			'ADMINISTRATIVE HOLD',
																			'CANCELLED',
																			'CONVERTED OUT',
																			'DEFAULT',
																			'DELETED',
																			'DISSOLVED',
																			'EXPIRED',
																			'ILOPENDING',
																			'ILOREJECT',
																			'MERGE DISSOLVED',
																			'MERGED', 
																			'PENDING',
																			'PENDING CANCELLATION', 
																			'PENDING CONVERSION ',
																			'PENDING DISSOLUTION',
																			'PENDING MERGER',
																			'PENDING WITHDRAWAL',
																			'PERMANENTLY REVOKED',
																			'REGISTERED', 
																			'REMOVED BY STATUTE',
																			'RESERVED',
																			'REVOKED',
																			'TERMINATED',
																			'WITHDRAWN']  		=> corp2.t2u(s),
										 corp2.t2u(s)   = 'CONVERTED'   		=> 'CONVERTED OUT',
										 '**|'+corp2.t2u(s)); 											
		END;
		
		//********************************************************************
		//ContTitle: Returns the "cont_title1_desc".
		//********************************************************************	
		EXPORT ContTitle(STRING s) := FUNCTION
		
				 RETURN  case(corp2.t2u(s),
											'AUTHORIZED SIGNER' => 'AUTHORIZED SIGNER',
											'DIRECTOR' 					=> 'DIRECTOR', 
											'EXECOFF' 					=> 'EXECUTIVE OFFICER',
											'GENPART' 					=> 'GENERAL PARTNER',
											'GPLP' 							=> 'GENERAL PARTNER',
											'INCORPORATOR' 			=> 'INCORPORATOR',
											'MANAGER' 					=> 'MANAGER',
											'MEMBER' 						=> 'MEMBER',
											'MMEMBER' 					=> 'MANAGING MEMBER',
											'MPARTNER' 					=> 'MANAGING PARTNER',
											'OFFICER' 					=> 'OFFICER',
											'OTHER' 						=> 'OTHER',
											'PARTNER' 					=> 'PARTNER',
											'PRESIDENT' 				=> 'PRESIDENT',
											'SECRETARY' 				=> 'SECRETARY',
											'SUBSCRIBER' 				=> 'SUBSCRIBER',
											'SUCCESSOR' 				=> 'SUCCESSOR',
											'TREASURER' 				=> 'TREASURER',
											'TRUSTEE' 					=> 'TRUSTEE',
										  '**|'+corp2.t2u(s)); 											
		END;
		
		//********************************************************************
		//CorpForgnStateDesc: Returns "corp_forgn_state_desc".
		//********************************************************************	
		EXPORT CorpForgnStateDesc(STRING s) := FUNCTION

					 uc_s  := corp2.t2u(s);

					 RETURN  CASE(uc_s,
												'AL' => 'ALABAMA',
												'AK' => 'ALASKA', 
												'AR' => 'ARKANSAS', 
												'AZ' => 'ARIZONA', 
												'CA' => 'CALIFORNIA', 
												'CO' => 'COLORADO', 
												'CT' => 'CONNECTICUT', 
												'DC' => 'DISTRICT OF COLUMBIA', 
												'DE' => 'DELAWARE', 
												'FL' => 'FLORIDA', 
												'GA' => 'GEORGIA', 
												'HI' => 'HAWAII', 
												'IA' => 'IOWA', 
												'ID' => 'IDAHO', 
												'IL' => 'ILLINOIS', 
												'IN' => 'INDIANA', 
												'KS' => 'KANSAS', 
												'KY' => 'KENTUCKY', 
												'LA' => 'LOUISIANA', 
												'MA' => 'MASSACHUSETTS', 
												'MD' => 'MARYLAND', 
												'ME' => 'MAINE' , 
												'MI' => 'MICHIGAN', 
												'MN' => 'MINNESOTA', 
												'MO' => 'MISSOURI', 
												'MS' => 'MISSISSIPPI', 
												'MT' => 'MONTANA', 
												'NC' => 'NORTH CAROLINA', 
												'ND' => 'NORTH DAKOTA', 
												'NE' => 'NEBRASKA', 
												'NH' => 'NEW HAMPSHIRE', 
												'NJ' => 'NEW JERSEY', 
												'NM' => 'NEW MEXICO', 
												'NV' => 'NEVADA', 
												'NY' => 'NEW YORK', 
												'OH' => 'OHIO', 
												'OK' => 'OKLAHOMA', 
												'OR' => 'OREGON', 
												'PA' => 'PENNSYLVANIA', 
												'RI' => 'RHODE ISLAND', 
												'SC' => 'SOUTH CAROLINA', 
												'SD' => 'SOUTH DAKOTA', 
												'TN' => 'TENNESSEE', 
												'TX' => 'TEXAS', 
												'US' => 'UNITED STATES', 
												'UT' => 'UTAH', 
												'VA' => 'VIRGINIA', 
												'VT' => 'VERMONT', 
												'WA' => 'WASHINGTON', 
												'WI' => 'WISCONSIN', 
												'WV' => 'WEST VIRGINIA', 
												'WY' => 'WYOMING',
												// Armed Forces
												'AA' => 'US ARMED FORCES AMERICAS',
												'AE' =>	'US ARMED FORCES EUROPE',
												'AP' => 'US ARMED FORCES PACIFIC',
												// U.S. Territories
												'AS' => 'AMERICAN SAMOA', 
												'FM' => 'FEDERATED STATES OF MICRONESIA',
												'GU' => 'GUAM', 
												'MH' => 'MARSHALL ISLANDS',
												'MP' => 'COMMONWEALTH OF THE NORTHERN MARIANA ISLANDS',
												'PW' => 'PALAU',
												'PR' => 'PUERTO RICO',
												'VI' => 'VIRGIN ISLANDS', 
												// Canadian Provinces and Territories
												'AB' => 'ALBERTA',
												'BC' => 'BRITISH COLUMBIA',
												'MB' => 'MANITOBA',
												'NB' => 'NEW BRUNSWICK',
												'NL' => 'NEWFOUNDLAND AND LABRADOR',
												'NS' => 'NOVA SCOTIA',
												'ON' => 'ONTARIO',
												'PE' => 'PRINCE EDWARD ISLAND',
												'QC' => 'QUEBEC',
												'SK' => 'SASKATCHEWAN',
												'NT' => 'NORTHWEST TERRITORIES',
												'NU' => 'NUNAVUT',
												'YT' => 'YUKON',
												'**|'+uc_s);
		END;

		//****************************************************************************
		//Country_Description: returns the country description.
		//****************************************************************************
		EXPORT Country_Description(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
	         RETURN MAP(uc_s in ['AL','AK','AR','AZ','CA','CO','CT','DC','DE','FL',   
															 'GA','HI','IA','ID','IL','IN','KS','KY','LA','MA', 
															 'MD','ME','MI','MN','MO','MS','MT','NC','ND','NE', 
															 'NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI', 
															 'SC','SD','TN','TX','US','UT','VA','VT','WA','WI', 
															 'WV','WY','AA','AE','AP','AS','FM','GU','MH','MP',
															 'PW','PR','VI']                      => 'US',
											uc_s in ['AB','BC','MB','NB','NL','NS','ON',
															 'PE','QC','SK','NT','NU','YT']			  => 'CANADA',
											uc_s = ''                                     => '',
											'**|'+uc_s);
		END;

		//****************************************************************************
		//CountryCodeTable: returns the country description. (ISO Country Codes)
		//****************************************************************************
		EXPORT CountryCodeTable(string s) := FUNCTION

		 uc_s := corp2.t2u(s);	
		 
		 RETURN map(uc_s = 'AFG' => 'AFGHANISTAN',
								uc_s = 'ABW' => 'ARUBA',
								uc_s = 'AGO' => 'ANGOLA',
								uc_s = 'AIA' => 'ANGUILLA',
								uc_s = 'ALA' => 'ÅLAND ISLANDS',
								uc_s = 'ALB' => 'ALBANIA',
								uc_s = 'AND' => 'ANDORRA',
								uc_s = 'ARE' => 'UNITED ARAB EMIRATES (THE)',
								uc_s = 'ARG' => 'ARGENTINA',
								uc_s = 'ARM' => 'ARMENIA',
								uc_s = 'ASM' => 'AMERICAN SAMOA',
								uc_s = 'ATA' => 'ANTARCTICA',
								uc_s = 'ATF' => 'FRENCH SOUTHERN TERRITORIES (THE)',
								uc_s = 'ATG' => 'ANTIGUA AND BARBUDA',
								uc_s = 'AUS' => 'AUSTRALIA',
								uc_s = 'AUT' => 'AUSTRIA',
								uc_s = 'AZE' => 'AZERBAIJAN',
								uc_s = 'BDI' => 'BURUNDI',
								uc_s = 'BEL' => 'BELGIUM',
								uc_s = 'BEN' => 'BENIN',
								uc_s = 'BES' => 'BONAIRE, SINT EUSTATIUS AND SABA',
								uc_s = 'BFA' => 'BURKINA FASO',
								uc_s = 'BGD' => 'BANGLADESH',
								uc_s = 'BGR' => 'BULGARIA',
								uc_s = 'BHR' => 'BAHRAIN',
								uc_s = 'BHS' => 'BAHAMAS (THE)',
								uc_s = 'BIH' => 'BOSNIA AND HERZEGOVINA',
								uc_s = 'BLM' => 'SAINT BARTHÉLEMY',
								uc_s = 'BLR' => 'BELARUS',
								uc_s = 'BLZ' => 'BELIZE',
								uc_s = 'BMU' => 'BERMUDA',
								uc_s = 'BOL' => 'BOLIVIA (PLURINATIONAL STATE OF)',
								uc_s = 'BRA' => 'BRAZIL',
								uc_s = 'BRB' => 'BARBADOS',
								uc_s = 'BRN' => 'BRUNEI DARUSSALAM',
								uc_s = 'BTN' => 'BHUTAN',
								uc_s = 'BVT' => 'BOUVET ISLAND',
								uc_s = 'BWA' => 'BOTSWANA',
								uc_s = 'CAF' => 'CENTRAL AFRICAN REPUBLIC (THE)',
								uc_s = 'CAN' => 'CANADA',
								uc_s = 'CCK' => 'COCOS (KEELING) ISLANDS (THE)',
								uc_s = 'CHE' => 'SWITZERLAND',
								uc_s = 'CHL' => 'CHILE',
								uc_s = 'CHN' => 'CHINA',
								uc_s = 'CIV' => 'CÔTE D\'IVOIRE',
								uc_s = 'CMR' => 'CAMEROON',
								uc_s = 'COD' => 'CONGO (THE DEMOCRATIC REPUBLIC OF THE)',
								uc_s = 'COG' => 'CONGO (THE)',
								uc_s = 'COK' => 'COOK ISLANDS (THE)',
								uc_s = 'COL' => 'COLOMBIA',
								uc_s = 'COM' => 'COMOROS (THE)',
								uc_s = 'CPV' => 'CABO VERDE',
								uc_s = 'CRI' => 'COSTA RICA',
								uc_s = 'CUB' => 'CUBA',
								uc_s = 'CUW' => 'CURAÇAO',
								uc_s = 'CXR' => 'CHRISTMAS ISLAND',
								uc_s = 'CYM' => 'CAYMAN ISLANDS (THE)',
								uc_s = 'CYP' => 'CYPRUS',
								uc_s = 'CZE' => 'CZECHIA',
								uc_s = 'DEU' => 'GERMANY',
								uc_s = 'DJI' => 'DJIBOUTI',
								uc_s = 'DMA' => 'DOMINICA',
								uc_s = 'DNK' => 'DENMARK',
								uc_s = 'DOM' => 'DOMINICAN REPUBLIC (THE)',
								uc_s = 'DZA' => 'ALGERIA',
								uc_s = 'ECU' => 'ECUADOR',
								uc_s = 'EGY' => 'EGYPT',
								uc_s = 'ERI' => 'ERITREA',
								uc_s = 'ESH' => 'WESTERN SAHARA*',
								uc_s = 'ESP' => 'SPAIN',
								uc_s = 'EST' => 'ESTONIA',
								uc_s = 'ETH' => 'ETHIOPIA',
								uc_s = 'FIN' => 'FINLAND',
								uc_s = 'FJI' => 'FIJI',
								uc_s = 'FLK' => 'FALKLAND ISLANDS (THE) [MALVINAS]',
								uc_s = 'FRA' => 'FRANCE',
								uc_s = 'FRO' => 'FAROE ISLANDS (THE)',
								uc_s = 'FSM' => 'MICRONESIA (FEDERATED STATES OF)',
								uc_s = 'GAB' => 'GABON',
								uc_s = 'GBR' => 'UNITED KINGDOM OF GREAT BRITAIN AND NORTHERN IRELAND (THE)',
								uc_s = 'GEO' => 'GEORGIA',
								uc_s = 'GGY' => 'GUERNSEY',
								uc_s = 'GHA' => 'GHANA',
								uc_s = 'GIB' => 'GIBRALTAR',
								uc_s = 'GIN' => 'GUINEA',
								uc_s = 'GLP' => 'GUADELOUPE',
								uc_s = 'GMB' => 'GAMBIA (THE)',
								uc_s = 'GNB' => 'GUINEA-BISSAU',
								uc_s = 'GNQ' => 'EQUATORIAL GUINEA',
								uc_s = 'GRC' => 'GREECE',
								uc_s = 'GRD' => 'GRENADA',
								uc_s = 'GRL' => 'GREENLAND',
								uc_s = 'GTM' => 'GUATEMALA',
								uc_s = 'GUF' => 'FRENCH GUIANA',
								uc_s = 'GUM' => 'GUAM',
								uc_s = 'GUY' => 'GUYANA',
								uc_s = 'HKG' => 'HONG KONG',
								uc_s = 'HMD' => 'HEARD ISLAND AND MCDONALD ISLANDS',
								uc_s = 'HND' => 'HONDURAS',
								uc_s = 'HRV' => 'CROATIA',
								uc_s = 'HTI' => 'HAITI',
								uc_s = 'HUN' => 'HUNGARY',
								uc_s = 'IDN' => 'INDONESIA',
								uc_s = 'IMN' => 'ISLE OF MAN',
								uc_s = 'IND' => 'INDIA',
								uc_s = 'IOT' => 'BRITISH INDIAN OCEAN TERRITORY (THE)',
								uc_s = 'IRL' => 'IRELAND',
								uc_s = 'IRN' => 'IRAN (ISLAMIC REPUBLIC OF)',
								uc_s = 'IRQ' => 'IRAQ',
								uc_s = 'ISL' => 'ICELAND',
								uc_s = 'ISR' => 'ISRAEL',
								uc_s = 'ITA' => 'ITALY',
								uc_s = 'JAM' => 'JAMAICA',
								uc_s = 'JEY' => 'JERSEY',
								uc_s = 'JOR' => 'JORDAN',
								uc_s = 'JPN' => 'JAPAN',
								uc_s = 'KAZ' => 'KAZAKHSTAN',
								uc_s = 'KEN' => 'KENYA',
								uc_s = 'KGZ' => 'KYRGYZSTAN',
								uc_s = 'KHM' => 'CAMBODIA',
								uc_s = 'KIR' => 'KIRIBATI',
								uc_s = 'KNA' => 'SAINT KITTS AND NEVIS',
								uc_s = 'KOR' => 'KOREA (THE REPUBLIC OF)',
								uc_s = 'KWT' => 'KUWAIT',
								uc_s = 'LAO' => 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC (THE)',
								uc_s = 'LBN' => 'LEBANON',
								uc_s = 'LBR' => 'LIBERIA',
								uc_s = 'LBY' => 'LIBYA',
								uc_s = 'LCA' => 'SAINT LUCIA',
								uc_s = 'LIE' => 'LIECHTENSTEIN',
								uc_s = 'LKA' => 'SRI LANKA',
								uc_s = 'LSO' => 'LESOTHO',
								uc_s = 'LTU' => 'LITHUANIA',
								uc_s = 'LUX' => 'LUXEMBOURG',
								uc_s = 'LVA' => 'LATVIA',
								uc_s = 'MAC' => 'MACAO',
								uc_s = 'MAF' => 'SAINT MARTIN (FRENCH PART)',
								uc_s = 'MAR' => 'MOROCCO',
								uc_s = 'MCO' => 'MONACO',
								uc_s = 'MDA' => 'MOLDOVA (THE REPUBLIC OF)',
								uc_s = 'MDG' => 'MADAGASCAR',
								uc_s = 'MDV' => 'MALDIVES',
								uc_s = 'MEX' => 'MEXICO',
								uc_s = 'MHL' => 'MARSHALL ISLANDS (THE)',
								uc_s = 'MKD' => 'NORTH MACEDONIA',
								uc_s = 'MLI' => 'MALI',
								uc_s = 'MLT' => 'MALTA',
								uc_s = 'MMR' => 'MYANMAR',
								uc_s = 'MNE' => 'MONTENEGRO',
								uc_s = 'MNG' => 'MONGOLIA',
								uc_s = 'MNP' => 'NORTHERN MARIANA ISLANDS (THE)',
								uc_s = 'MOZ' => 'MOZAMBIQUE',
								uc_s = 'MRT' => 'MAURITANIA',
								uc_s = 'MSR' => 'MONTSERRAT',
								uc_s = 'MTQ' => 'MARTINIQUE',
								uc_s = 'MUS' => 'MAURITIUS',
								uc_s = 'MWI' => 'MALAWI',
								uc_s = 'MYS' => 'MALAYSIA',
								uc_s = 'MYT' => 'MAYOTTE',
								uc_s = 'NAM' => 'NAMIBIA',
								uc_s = 'NCL' => 'NEW CALEDONIA',
								uc_s = 'NER' => 'NIGER (THE)',
								uc_s = 'NFK' => 'NORFOLK ISLAND',
								uc_s = 'NGA' => 'NIGERIA',
								uc_s = 'NIC' => 'NICARAGUA',
								uc_s = 'NIU' => 'NIUE',
								uc_s = 'NLD' => 'NETHERLANDS (THE)',
								uc_s = 'NOR' => 'NORWAY',
								uc_s = 'NPL' => 'NEPAL',
								uc_s = 'NRU' => 'NAURU',
								uc_s = 'NZL' => 'NEW ZEALAND',
								uc_s = 'OMN' => 'OMAN',
								uc_s = 'PAK' => 'PAKISTAN',
								uc_s = 'PAN' => 'PANAMA',
								uc_s = 'PCN' => 'PITCAIRN',
								uc_s = 'PER' => 'PERU',
								uc_s = 'PHL' => 'PHILIPPINES (THE)',
								uc_s = 'PLW' => 'PALAU',
								uc_s = 'PNG' => 'PAPUA NEW GUINEA',
								uc_s = 'POL' => 'POLAND',
								uc_s = 'PRI' => 'PUERTO RICO',
								uc_s = 'PRK' => 'KOREA (THE DEMOCRATIC PEOPLE\'S REPUBLIC OF)',
								uc_s = 'PRT' => 'PORTUGAL',
								uc_s = 'PRY' => 'PARAGUAY',
								uc_s = 'PSE' => 'PALESTINE, STATE OF',
								uc_s = 'PYF' => 'FRENCH POLYNESIA',
								uc_s = 'QAT' => 'QATAR',
								uc_s = 'REU' => 'RÉUNION',
								uc_s = 'ROU' => 'ROMANIA',
								uc_s = 'RUS' => 'RUSSIAN FEDERATION (THE)',
								uc_s = 'RWA' => 'RWANDA',
								uc_s = 'SAU' => 'SAUDI ARABIA',
								uc_s = 'SDN' => 'SUDAN (THE)',
								uc_s = 'SEN' => 'SENEGAL',
								uc_s = 'SGP' => 'SINGAPORE',
								uc_s = 'SGS' => 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS',
								uc_s = 'SHN' => 'SAINT HELENA, ASCENSION AND TRISTAN DA CUNHA',
								uc_s = 'SJM' => 'SVALBARD AND JAN MAYEN',
								uc_s = 'SLB' => 'SOLOMON ISLANDS',
								uc_s = 'SLE' => 'SIERRA LEONE',
								uc_s = 'SLV' => 'EL SALVADOR',
								uc_s = 'SMR' => 'SAN MARINO',
								uc_s = 'SOM' => 'SOMALIA',
								uc_s = 'SPM' => 'SAINT PIERRE AND MIQUELON',
								uc_s = 'SRB' => 'SERBIA',
								uc_s = 'SSD' => 'SOUTH SUDAN',
								uc_s = 'STP' => 'SAO TOME AND PRINCIPE',
								uc_s = 'SUR' => 'SURINAME',
								uc_s = 'SVK' => 'SLOVAKIA',
								uc_s = 'SVN' => 'SLOVENIA',
								uc_s = 'SWE' => 'SWEDEN',
								uc_s = 'SWZ' => 'ESWATINI',
								uc_s = 'SXM' => 'SINT MAARTEN (DUTCH PART)',
								uc_s = 'SYC' => 'SEYCHELLES',
								uc_s = 'SYR' => 'SYRIAN ARAB REPUBLIC (THE)',
								uc_s = 'TCA' => 'TURKS AND CAICOS ISLANDS (THE)',
								uc_s = 'TCD' => 'CHAD',
								uc_s = 'TGO' => 'TOGO',
								uc_s = 'THA' => 'THAILAND',
								uc_s = 'TJK' => 'TAJIKISTAN',
								uc_s = 'TKL' => 'TOKELAU',
								uc_s = 'TKM' => 'TURKMENISTAN',
								uc_s = 'TLS' => 'TIMOR-LESTE',
								uc_s = 'TON' => 'TONGA',
								uc_s = 'TTO' => 'TRINIDAD AND TOBAGO',
								uc_s = 'TUN' => 'TUNISIA',
								uc_s = 'TUR' => 'TURKEY',
								uc_s = 'TUV' => 'TUVALU',
								uc_s = 'TWN' => 'TAIWAN (PROVINCE OF CHINA)',
								uc_s = 'TZA' => 'TANZANIA, THE UNITED REPUBLIC OF',
								uc_s = 'UGA' => 'UGANDA',
								uc_s = 'UKR' => 'UKRAINE',
								uc_s = 'UMI' => 'UNITED STATES MINOR OUTLYING ISLANDS (THE)',
								uc_s = 'URY' => 'URUGUAY',
								uc_s = 'USA' => 'US',
								uc_s = 'UZB' => 'UZBEKISTAN',
								uc_s = 'VAT' => 'HOLY SEE (THE)',
								uc_s = 'VCT' => 'SAINT VINCENT AND THE GRENADINES',
								uc_s = 'VEN' => 'VENEZUELA (BOLIVARIAN REPUBLIC OF)',
								uc_s = 'VGB' => 'VIRGIN ISLANDS (BRITISH)',
								uc_s = 'VIR' => 'VIRGIN ISLANDS (U.S.)',
								uc_s = 'VNM' => 'VIET NAM',
								uc_s = 'VUT' => 'VANUATU',
								uc_s = 'WLF' => 'WALLIS AND FUTUNA',
								uc_s = 'WSM' => 'SAMOA',
								uc_s = 'YEM' => 'YEMEN',
								uc_s = 'YUG' => 'YUGOSLAVIA',
								uc_s = 'ZAF' => 'SOUTH AFRICA',
								uc_s = 'ZMB' => 'ZAMBIA',
								uc_s = 'ZWE' => 'ZIMBABWE',
								uc_s);
    END;
		
		//****************************************************************************
		//exemptionCodes: returns the exemption code description
		//****************************************************************************
		EXPORT exemptionCodes(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
	         RETURN MAP(uc_s in ['000',''] => '',
											uc_s = '001'       => 'STATUTORY EXEMPTIONS: GOVERNMENTAL ENTITY',
											uc_s = '002' 			 => 'STATUTORY EXEMPTIONS: NONPROFIT ORGANIZATION UNDER 26 U.S.C. SECTION 501(C)',
											uc_s = '003' 			 => 'STATUTORY EXEMPTIONS: HOME-BASED BUSINESS WITH NET EARNINGS NOT MORE THAN 66 2/3 % OF THE AVERAGE ANNUAL WAGE',
											uc_s = '004' 			 => 'STATUTORY EXEMPTIONS: NATURAL PERSON WHOSE SOLE BUSINESS IS THE RENTAL OF FOUR (4) OR FEWER DWELLING UNITS',
											uc_s = '005' 			 => 'STATUTORY EXEMPTIONS: MOTION PICTURE PRODUCTION COMPANY',
											uc_s = '006' 			 => 'STATUTORY EXEMPTIONS: INSURANCE COMPANY PURSUANT TO NRS 680B.020',
											uc_s = '007'			 => 'STATUTORY EXEMPTIONS: NONPROFIT ENTITY',
											'**|'+uc_s);
		END;		

		//********************************************************************
		//TMClass: Returns "corp_trademark_class_desc1".
		//********************************************************************	
		EXPORT TMClass(STRING s) := FUNCTION

					 int_s := (integer)s;
					 
	         RETURN MAP(int_s = 1   => '1. RAW OR PARTLY PREPARED MATERIALS',									
										  int_s = 2   => '2. RECEPTACLES',									
										  int_s = 3   => '3. BAGGAGE, ANIMAL EQUIPMENT, PORTFOLIOS, AND POCKETBOOKS',									
										  int_s = 4   => '4. ABRASIVES AND POLISHING MATERIALS',									
										  int_s = 5   => '5. ADHESIVES',									
										  int_s = 6   => '6. CHEMICALS AND CHEMICAL COMPOSITIONS',									
										  int_s = 7   => '7. CORDAGE',									
										  int_s = 8   => '8. SMOKERS\' ARTICLES, NOT INCLUDING TOBACCO PRODUCTS',									
										  int_s = 9   => '9. EXPLOSIVES, FIREARMS, EQUIPMENT, AND PROJECTILES',									
										  int_s = 10  => '10. FERTILIZERS',									
										  int_s = 11  => '11. INKS AND INKING MATERIALS',									
										  int_s = 12  => '12. CONSTRUCTION MATERIALS',									
										  int_s = 13  => '13. HARDWARE AND PLUMBING AND STEAM-FITTING SUPPLIES',									
										  int_s = 14  => '14. METALS AND METAL CASTINGS AND FORGINGS',									
										  int_s = 15  => '15. OILS AND GREASES',									
										  int_s = 16  => '16. PAINTS AND PAINTERS\' MATERIALS',									
										  int_s = 17  => '17. TOBACCO PRODUCTS',									
										  int_s = 18  => '18. MEDICINES AND PHARMACEUTICAL PREPARATIONS',								
										  int_s = 19  => '19. VEHICLES',									
										  int_s = 20  => '20. LINOLEUM AND OILED CLOTH',									
										  int_s = 21  => '21. ELECTRICAL APPARATUS, MACHINES, AND SUPPLIES',									
										  int_s = 22  => '22. GAMES, TOYS, AND SPORTING GOODS',									
										  int_s = 23  => '23. CUTLERY, MACHINERY, AND TOOLS AND PARTS THEREOF',									
										  int_s = 24  => '24. LAUNDRY APPLIANCE AND MACHINES',									
										  int_s = 25  => '25. LOCKS AND SAFES',									
										  int_s = 26  => '26. MEASURING AND SCIENTIFIC APPLIANCES',									
										  int_s = 27  => '27. HOROLOGICAL INSTRUMENTS',									
										  int_s = 28  => '28. JEWELRY AND PRECIOUS-METAL WARE',									
										  int_s = 29  => '29. BROOMS, BRUSHES, AND DUSTERS',									
										  int_s = 30  => '30. CROCKERY, EARTHENWARE, AND PORCELAIN',									
										  int_s = 31  => '31. FILTERS AND REFRIGERATORS',									
										  int_s = 32  => '32. FURNITURE AND UPHOLSTERY',									
										  int_s = 33  => '33. GLASSWARE',									
										  int_s = 34  => '34. HEATING, LIGHTING, AND VENTILATING APPARATUS',									
										  int_s = 35  => '35. BELTING, HOSE, MACHINERY PACKING AND NON-METALLIC TIERS',								
										  int_s = 36  => '36. MUSICAL INSTRUMENTS AND SUPPLIES',									
										  int_s = 37  => '37. PAPER AND STATIONERY',									
										  int_s = 38  => '38. PRINTS AND PUBLICATIONS', 									
										  int_s = 39  => '39. CLOTHING',									
										  int_s = 40  => '40. FANCY GOODS, FURNISHINGS, AND NOTIONS',									
										  int_s = 41  => '41. CANES, PARASOLS, AND UMBRELLAS',									
										  int_s = 42  => '42. KNITTED, NETTED AND TEXTILE FABRICS, AND SUBSTITUTES THEREFOR',									
										  int_s = 43  => '43. THREAD AND YARN',									
										  int_s = 44  => '44. DENTAL, MEDICAL, AND SURGICAL APPLIANCES',								
										  int_s = 45  => '45. SOFT DRINKS AND CARBONATED WATERS',									
										  int_s = 46  => '46. FOODS AND INGREDIENTS OF FOODS',									
										  int_s = 47  => '47. WINES',									
										  int_s = 48  => '48. MALT BEVERAGES AND LIQUORS',									
										  int_s = 49  => '49. DISTILLED ALCOHOLIC LIQUORS',									
										  int_s = 50  => '50. MERCHANDISE NOT OTHERWISE CLASSIFIED',									
										  int_s = 51  => '51. COSMETICS AND TOILET PREPARATIONS',									
										  int_s = 52  => '52. DETERGENTS AND SOAPS',									
										  int_s = 90  => '90. DATA MISMATCH - ACTIVE RECORD',									
										  int_s = 99  => '99. DATA MISMATCH, NOT ACTIVE', 									
										  int_s = 100 => '100. MISCELLANEOUS',									
										  int_s = 101 => '101. ADVERTISING AND BUSINESS',									
										  int_s = 102 => '102. FINANCIAL AND INSURANCE',									
										  int_s = 103 => '103. CONSTRUCTION AND REPAIR',									
										  int_s = 104 => '104. COMMUNICATIONS',									
										  int_s = 105 => '105. TRANSPORTATION AND STORAGE',									
										  int_s = 106 => '106. MATERIAL TREATMENT',									
										  int_s = 107 => '107. EDUCATION AND ENTERTAINMENT',
											corp2.t2u(s) = '' => '',
										  // int_s in [0,108,110,117,120,180,181,220,221,260,281,          //Per CI.  These are subcodes
																// 321,381,390,420,460,461,472,478,480,500,999] => '', // with no descriptions
											'**|'+corp2.t2u(s)
										 );
		END;
		
		//********************************************************************
		//FormatNumericValues: Formats numerical values to include commas and
		//             					(optionally) a decimal point.
		//********************************************************************
		EXPORT FormatNumericValues(STRING pInValue,BOOLEAN pDecimalPoint = true) := FUNCTION

				dollar_sign_exist			  := if(stringlib.stringfind(pInValue,'$',1)<>0,true,false); 
				trim_money			  			:= corp2.t2u(stringlib.stringfilter(corp2.t2u(pInValue),'.0123456789'));		
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
		
END;
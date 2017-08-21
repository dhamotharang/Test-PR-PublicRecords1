IMPORT corp2, ut, Corp2_mapping;

EXPORT Functions := MODULE

    //****************************************************************************
		//CleanText: 		This function cleans the incoming data by using regex to look
		//							for one of the following:
		//							NONE, NONE GIVEN, UNKNOWN, MS, MS., NA or N/A.
		//****************************************************************************
		EXPORT CleanText(STRING s) := FUNCTION
			uc_s 	 := corp2.t2u(ut.fn_RemoveSpecialChars(s));
			result  := MAP(REGEXFIND('^NONE$|^NONE GIVEN$| NONE |^UNKNOWN$|^N\\/A$|^N/A$',uc_s,0)<>'' 	=>'',
										 REGEXFIND('^MS(\\.)* ',uc_s,0)<>'' 																		=> REGEXREPLACE('^MS(\\.)*',uc_s,''),
										 uc_s
										);
			RETURN corp2.t2u(result);
		END;
		
		//****************************************************************************
		//CorpAddlInfo: returns the "corp_addl_info"
		//
		//NOTE: 				No CI instructions exist for this field named corp_addl_info.
		//							However, in order to not affect keys this field is being mapped.
		//							This logic can be removed when new keys are created from the
		//							new corp fields.  This was made a function for easy removal.
		//****************************************************************************							
		EXPORT CorpAddlInfo(STRING DBA,STRING FN,  STRING PN, STRING MF, STRING CPF,
											  STRING PF, STRING ARRF,STRING MAF,STRING RAF,STRING OFN) := FUNCTION
			uc_dba 	:= IF(corp2.t2u(dba) = 'Y','DOING BUSINESS AS: YES ','');
			uc_fn	 	:= IF(corp2.t2u(fn)  = 'Y','HOME STATE NAME: YES ','');
			uc_pn	 	:= IF(corp2.t2u(pn)  = 'Y','PARTNERSHIP: YES ','');
			uc_mf	 	:= IF(corp2.t2u(mf)  = 'Y','MANUFACTURER: YES ','');
			uc_cpf 	:= IF(corp2.t2u(cpf) = 'Y','CONFIDENTIAL DATA: YES ','');
			uc_pf	 	:= IF(corp2.t2u(pf)  = 'Y','FOR PROFIT: YES ','');
			uc_arrf := IF(corp2.t2u(arrf)= 'Y','ANNUAL REPORT REQUIRED: YES ','');
			uc_maf 	:= IF(corp2.t2u(maf) = 'Y','MERGER ALLOWED: YES ','');
			uc_raf 	:= IF(corp2.t2u(raf) = 'Y','RESIDENT AGENT: YES ','');
			uc_ofn 	:= IF(corp2.t2u(ofn) = 'Y' AND (INTEGER)ofn <> 0,'OLD FEIN: YES ','');
			RETURN corp2.t2u(uc_dba+uc_fn+uc_pn+uc_mf+uc_cpf+uc_pf+uc_arrf+uc_maf+uc_raf+uc_ofn);
		END;
		
		//****************************************************************************
		//CorpFedTaxID: returns the "corp_fed_tax_id"
		//****************************************************************************
		EXPORT CorpFedTaxID(STRING s) := FUNCTION
			 uc_s 		:= corp2.t2u(s);
			 clean_s 	:= corp2.t2u(stringlib.stringfilter(uc_s,'0123456789'));

			 //The search pattern is looking for the following:
			 //1) A string of nine numbers of the same digit.  E.g. 000000000 or 111111111
			 //2) A string of "123456789" (which is also an invalid federal tax id 
			 searchpattern := '^(0{9})*(1{9})*(2{9})*(3{9})*(4{9})*(5{9})*(6{9})*(7{9})*(8{9})*(9{9})*(123456789)*$';
			 cleaned_fein := MAP(REGEXFIND(searchpattern,uc_s,0) <> '' => '',
													(INTEGER)uc_s = 0											 => '',
													 LENGTH(clean_s) <> 9									 => '',
													 clean_s[1..2]+'-'+clean_s[3..]
													);
			 RETURN cleaned_fein;
		END;

		//****************************************************************************
		//CleanName: returns the "corp_legal_name" or "corp_ra_full_name"
		//
		//NOTE:  				 This regex looks within the legal name for anything beginning and
		//			 				 ending with parens that contains the word FICHE.  If this exists, 
		//			 				 it is to be removed from the legal name.  (PER CI instructions)
		//    
		//			 				 If DOING BUSINESS AS or DOING BUSINESS BY exists in the agent's name
		//			 				 field, then the name is made up of the agent's address fields.
		//****************************************************************************		
		EXPORT CorpRAFullName(STRING state_origin, STRING state_desc, STRING name, STRING addr) := FUNCTION
			  uc_name := corp2.t2u(ut.fn_removespecialchars(name));
				uc_addr := corp2.t2u(ut.fn_removespecialchars(addr));
			  result  := MAP (REGEXFIND('DOING BUSINESS AS( )*(\\:)*',uc_name,0)<>'' => REGEXREPLACE('DOING BUSINESS AS( )*(\\:)*',uc_name+' '+uc_addr,''),
												REGEXFIND('DOING BUSINESS BY( )*(\\:)*',uc_name,0)<>'' => REGEXREPLACE('DOING BUSINESS BY( )*(\\:)*',uc_name+' '+uc_addr,''),
												uc_name
										   );
			  outname := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,result).BusinessName;
			  RETURN corp2.t2u(outname);
		END;

		//****************************************************************************
		//CorpNameComment: returns the "corp_name_comment"
		//
		//NOTE: 					 No CI instructions exist for this field named corp_name_comment.
		//								 However, in order to not affect keys this field is being mapped.
		//								 This logic can be removed when new keys are created from the
		//								 new corp fields.  This was made a function for easy removal.
		//****************************************************************************						
		EXPORT CorpNameComment(STRING s) := FUNCTION
				uc_s := corp2.t2u(s);
				RETURN IF(uc_s = 'Y','CONSENT: YES','');
		END;                                     

		//****************************************************************************
		//StateCodeTranslation: returns the us state description.
		//****************************************************************************
		EXPORT StateCodeTranslation(string s) := FUNCTION
		
					 uc_s 			:= corp2.t2u(stringlib.stringfilterout(s,'0123456789'));
					 
					 RETURN CASE(uc_s,
											'AL'=>'ALABAMA',
											'AK'=>'ALASKA',
											'AS'=>'AMERICAN SAMOA',
											'AZ'=>'ARIZONA',
											'AR'=>'ARKANSAS',
											'CA'=>'CALIFORNIA',
											'CO'=>'COLORADO',
											'CT'=>'CONNECTICUT',
											'DE'=>'DELAWARE',
											'DC'=>'DISTRICT OF COLUMBIA',
											'FM'=>'FEDERATED STATES OF MICRONESIA',
											'FL'=>'FLORIDA',
											'GA'=>'GEORGIA',
											'GU'=>'GUAM',
											'HI'=>'HAWAII',
											'ID'=>'IDAHO',
											'IL'=>'ILLINOIS',
											'IN'=>'INDIANA',
											'IA'=>'IOWA',
											'KS'=>'KANSAS',
											'KY'=>'KENTUCKY',
											'LA'=>'LOUISIANA',
											'ME'=>'MAINE',
											'MH'=>'MARSHALL ISLANDS',
											'MD'=>'MARYLAND',
											'MA'=>'MASSACHUSETTS',
											'MI'=>'MICHIGAN',
											'MN'=>'MINNESOTA',
											'MS'=>'MISSISSIPPI',
											'MO'=>'MISSOURI',
											'MT'=>'MONTANA',
											'NE'=>'NEBRASKA',
											'NV'=>'NEVADA',
											'NH'=>'NEW HAMPSHIRE',
											'NJ'=>'NEW JERSEY',
											'NM'=>'NEW MEXICO',
											'NY'=>'NEW YORK',
											'NC'=>'NORTH CAROLINA ',
											'ND'=>'NORTH DAKOTA ',
											'MP'=>'NORTHERN MARIANA ISLANDS ',
											'OH'=>'OHIO ',
											'OK'=>'OKLAHOMA ',
											'OR'=>'OREGON ',
											'PW'=>'PALAU ',
											'PA'=>'PENNSYLVANIA ',
											'PR'=>'PUERTO RICO ',
											'RI'=>'RHODE ISLAND ',
											'SC'=>'SOUTH CAROLINA ',
											'SD'=>'SOUTH DAKOTA ',
											'TN'=>'TENNESSEE ',
											'TX'=>'TEXAS ',
											'UT'=>'UTAH ',
											'VT'=>'VERMONT ',
											'VI'=>'VIRGIN ISLANDS ',
											'VA'=>'VIRGINIA ',
											'WA'=>'WASHINGTON ',
											'WV'=>'WEST VIRGINIA ',
											'WI'=>'WISCONSIN ',
											'WY'=>'WYOMING ',
											'AE'=>'ARMED FORCES EUROPE, THE MIDDLE EAST AND CANADA',
											'AP'=>'ARMED FORCES PACIFIC ',
											'AA'=>'ARMED FORCES AMERICAS EXCEPT CANADA',
											'CZ'=>'CANAL ZONE',
											'**'
										 );
		END;

		//****************************************************************************
		//ValidProvinceCode: returns the Provice Code for Cananda.
		//****************************************************************************
		EXPORT ValidProvinceCode(STRING s) := FUNCTION

				uc_s 			:= corp2.t2u(stringlib.stringfilterout(s,'0123456789'));
				
				RETURN CASE(uc_s,
								'AB'=>	'ALBERTA',
								'BC'=>	'BRITISH COLUMBIA',
								'MB'=>	'MANITOBA',
								'NB'=>	'NEW BRUNSWICK',
								'NF'=>	'NEWFOUNDLAND',
								'NT'=>	'NORTHWEST TERRITORIES',
								'NS'=>	'NOVA SCOTIA',
								'ON'=>	'ONTARIO',
								'PE'=>	'PRINCE EDWARD ISLAND',
								'QC'=>	'QUEBEC',
								'QU'=>  'QUEBEC',
								'SK'=>	'SASKATCHEWAN',
								'YT'=>	'YUKON TERRITORY',
								'**'
								);
		END;

		//****************************************************************************
		//ValidCountryCode: returns the description for the country's code.
		//****************************************************************************
		EXPORT ValidCountryCode(STRING s) := FUNCTION

				uc_s 			:= corp2.t2u(stringlib.stringfilterout(s,'0123456789'));
				
				RETURN CASE(uc_s,
						'ABW'=>	'ARUBA',
						'AFG'=>	'AFGHANISTAN',
						'AGO'=>	'ANGOLA',
						'AIA'=>	'ANGUILLA',
						'ALB'=>	'ALBANIA',
						'AND'=>	'ANDORRA',
						'ANT'=>	'NETHERLANDS ANTILLES',
						'ARE'=>	'UNITED ARAB EMIRATES',
						'ARG'=>	'ARGENTINA',
						'ARM'=>	'ARMENIA',
						'ASM'=>	'AMERICAN SAMOA',
						'ATA'=>	'ANTARCTICA',
						'ATF'=>	'FRENCH SOUTHERN TERRITORIES',
						'ATG'=>	'ANTIGUA AND BARBUDA',
						'AUS'=>	'AUSTRALIA',
						'AUT'=>	'AUSTRIA',
						'AZE'=>	'AZERBAIJAN',
						'BDI'=>	'BURUNDI',
						'BE' => 'BERMUDA',
						'BEL'=>	'BELGIUM',
						'BEN'=>	'BENIN',
						'BFA'=>	'BURKINA FASO',
						'BGD'=>	'BANGLADESH',
						'BGR'=>	'BULGARIA',
						'BHR'=>	'BAHRAIN',
						'BHS'=>	'BAHAMAS',
						'BIH'=>	'BOSNIA AND HERZEGOWINA',
						'BLR'=>	'BELARUS',
						'BLZ'=>	'BELIZE',
						'BMU'=>	'BERMUDA',
						'BOL'=>	'BOLIVIA',
						'BRA'=>	'BRAZIL',
						'BRB'=>	'BARBADOS',
						'BRN'=>	'BRUNEI DARUSSALAM',
						'BTN'=>	'BHUTAN',
						'BVT'=>	'BOUVET ISLAND',
						'BWA'=>	'BOTSWANA',
						'CAF'=>	'CENTRAL AFRICAN REPUBLIC',
						'CA' => 'CANADA',
						'CAN'=>	'CANADA',
						'CCK'=>	'COCOS (KEELING) ISLANDS',
						'CHE'=>	'SWITZERLAND',
						'CHL'=>	'CHILE',
						'CHN'=>	'CHINA',
						'CIV'=>	'COTE D\'IVOIRE', //Note: \ is escape character for single quote
						'CMR'=>	'CAMEROON',
						'COD'=>	'THE DEMOCRATIC REPUBLIC OF THE CONGO',
						'COG'=>	'CONGO',
						'COK'=>	'COOK ISLANDS',
						'COL'=>	'COLOMBIA',
						'COM'=>	'COMOROS',
						'CPV'=>	'CAPE VERDE',
						'CRI'=>	'COSTA RICA',
						'CUB'=>	'CUBA',
						'CXR'=>	'CHRISTMAS ISLAND',
						'CYM'=>	'CAYMAN ISLANDS',
						'CYP'=>	'CYPRUS',
						'CZE'=>	'CZECH REPUBLIC',
						'DEU'=>	'GERMANY',
						'DJI'=>	'DJIBOUTI',
						'DMA'=>	'DOMINICA',
						'DNK'=>	'DENMARK',
						'DOM'=>	'DOMINICAN REPUBLIC',
						'DZA'=>	'ALGERIA',
						'ECU'=>	'ECUADOR',
						'EGY'=>	'EGYPT',
						'ERI'=>	'ERITREA',
						'ESH'=>	'WESTERN SAHARA',
						'ESP'=>	'SPAIN',
						'EST'=>	'ESTONIA',
						'ETH'=>	'ETHIOPIA',
						'FF' => 'FOREIGN COUNTRY',
						'FIN'=>	'FINLAND',
						'FJI'=>	'FIJI',
						'FLK'=>	'FALKLAND ISLANDS (MALVINAS)',
						'FRA'=>	'FRANCE',
						'FRO'=>	'FAROE ISLANDS',
						'FSM'=>	'FEDERATED STATES OF MICRONESIA',
						'FXX'=>	'METROPOLITAN FRANCE',
						'GAB'=>	'GABON',
						'GBR'=>	'UNITED KINGDOM',
						'GE' => 'GERMANY',
						'GEO'=>	'GEORGIA',
						'GG' => 'GERMANY',
						'GHA'=>	'GHANA',
						'GIB'=>	'GIBRALTAR',
						'GIN'=>	'GUINEA',
						'GLP'=> 'GUADELOUPE',
						'GMB'=>	'GAMBIA',
						'GNB'=>	'GUINEA-BISSAU',
						'GNQ'=>	'EQUATORIAL GUINEA',
						'GRC'=>	'GREECE',
						'GRD'=>	'GRENADA',
						'GRL'=>	'GREENLAND',
						'GTM'=>	'GUATEMALA',
						'GUF'=>	'FRENCH GUIANA',
						'GUM'=>	'GUAM',
						'GUY'=>	'GUYANA',
						'HKG'=>	'HONG KONG',
						'HMD'=>	'HEARD AND MC DONALD ISLANDS',
						'HND'=>	'HONDURAS',
						'HRV'=>	'CROATIA (LOCAL NAME: HRVATSKA)',
						'HTI'=>	'HAITI',
						'HUN'=>	'HUNGARY',
						'IDN'=>	'INDONESIA',
						'IND'=>	'INDIA',
						'IOT'=>	'BRITISH INDIAN OCEAN TERRITORY',
						'IRL'=>	'IRELAND',
						'IRN'=>	'IRAN (ISLAMIC REPUBLIC OF)',
						'IRQ'=>	'IRAQ',
						'ISL'=>	'ICELAND',
						'ISR'=>	'ISRAEL',
						'IT' =>	'ITALY',
						'ITA'=>	'ITALY',
						'ITL'=> 'ITALY',
						'JAM'=>	'JAMAICA',
						'JOR'=>	'JORDAN',
						'JPN'=>	'JAPAN',
						'KAZ'=>	'KAZAKHSTAN',
						'KEN'=>	'KENYA',
						'KGZ'=>	'KYRGYZSTAN',
						'KHM'=>	'CAMBODIA',
						'KIR'=>	'KIRIBATI',
						'KNA'=>	'SAINT KITTS AND NEVIS',
						'KOR'=>	'REPUBLIC OF KOREA',
						'KWT'=>	'KUWAIT',
						'LAO'=>	'LAO PEOPLE\'S DEMOCRATIC REPUBLIC', //Note: \ is escape character for single quote
						'LBN'=>	'LEBANON',
						'LBR'=>	'LIBERIA',
						'LBY'=>	'LIBYAN ARAB JAMAHIRIYA',
						'LCA'=>	'SAINT LUCIA',
						'LIE'=>	'LIECHTENSTEIN',
						'LKA'=>	'SRI LANKA',
						'LSO'=>	'LESOTHO',
						'LTU'=>	'LITHUANIA',
						'LUX'=>	'LUXEMBOURG',
						'LVA'=>	'LATVIA',
						'MAC'=>	'MACAU',
						'MAR'=>	'MOROCCO',
						'MCO'=>	'MONACO',
						'MDA'=>	'REPUBLIC OF MOLDOVA',
						'MDG'=>	'MADAGASCAR',
						'MDV'=>	'MALDIVES',
						'MEX'=>	'MEXICO',
						'MHL'=>	'MARSHALL ISLANDS',
						'MKD'=>	'THE FORMER YUGOSLAV REPUBLIC OF MACEDONIA',
						'MLI'=>	'MALI',
						'MLT'=>	'MALTA',
						'MMR'=>	'MYANMAR',
						'MNG'=>	'MONGOLIA',
						'MNP'=>	'NORTHERN MARIANA ISLANDS',
						'MOZ'=>	'MOZAMBIQUE',
						'MRT'=>	'MAURITANIA',
						'MSR'=>	'MONTSERRAT',
						'MTQ'=>	'MARTINIQUE',
						'MUS'=>	'MAURITIUS',
						'MWI'=>	'MALAWI',
						'MYS'=>	'MALAYSIA',
						'MYT'=>	'MAYOTTE',
						'NAM'=>	'NAMIBIA',
						'NCL'=>	'NEW CALEDONIA',
						'NER'=>	'NIGER',
						'NFK'=>	'NORFOLK ISLAND',
						'NGA'=>	'NIGERIA',
						'NIC'=>	'NICARAGUA',
						'NIU'=>	'NIUE',
						'NLD'=>	'NETHERLANDS',
						'NOR'=>	'NORWAY',
						'NPL'=>	'NEPAL',
						'NRU'=>	'NAURU',
						'NZ' => 'NEW ZEALAND',
						'NZL'=>	'NEW ZEALAND',
						'OMN'=>	'OMAN',
						'PAK'=>	'PAKISTAN',
						'PAN'=>	'PANAMA',
						'PCN'=>	'PITCAIRN',
						'PER'=>	'PERU',
						'PHL'=>	'PHILIPPINES',
						'PLW'=>	'PALAU',
						'PNG'=>	'PAPUA NEW GUINEA',
						'POL'=>	'POLAND',
						'PR' => 'PUERTO RICO',
						'PRI'=>	'PUERTO RICO',
						'PRK'=>	'DEMOCRATIC PEOPLE\'S REPUBLIC OF KOREA',  //Note: \ is escape character for single quote
						'PRT'=>	'PORTUGAL',
						'PRY'=>	'PARAGUAY',
						'PYF'=>	'FRENCH POLYNESIA',
						'QAT'=>	'QATAR',
						'REU'=>	'REUNION',
						'ROM'=>	'ROMANIA',
						'RUS'=>	'RUSSIAN FEDERATION',
						'RWA'=>	'RWANDA',
						'SAU'=>	'SAUDI ARABIA',
						'SDN'=>	'SUDAN',
						'SEN'=>	'SENEGAL',
						'SGP'=>	'SINGAPORE',
						'SGS'=>	'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS',
						'SHN'=>	'ST. HELENA',
						'SJM'=>	'SVALBARD AND JAN MAYEN ISLANDS',
						'SLB'=>	'SOLOMON ISLANDS',
						'SLE'=>	'SIERRA LEONE',
						'SLV'=>	'EL SALVADOR',
						'SMR'=>	'SAN MARINO',
						'SOM'=>	'SOMALIA',
						'SPM'=>	'ST. PIERRE AND MIQUELON',
						'STP'=>	'SAO TOME AND PRINCIPE',
						'SUR'=>	'SURINAME',
						'SVK'=>	'SLOVAKIA (SLOVAK REPUBLIC)',
						'SVN'=>	'SLOVENIA',
						'SW' => 'SWEDEN',
						'SWE'=>	'SWEDEN',
						'SWZ'=>	'SWAZILAND',
						'SYC'=>	'SEYCHELLES',
						'SYR'=>	'SYRIAN ARAB REPUBLIC',
						'TCA'=>	'TURKS AND CAICOS ISLANDS',
						'TCD'=>	'CHAD',
						'TGO'=>	'TOGO',
						'THA'=>	'THAILAND',
						'TJK'=>	'TAJIKISTAN',
						'TKL'=>	'TOKELAU',
						'TKM'=>	'TURKMENISTAN',
						'TMP'=>	'EAST TIMOR',
						'TON'=>	'TONGA',
						'TTO'=>	'TRINIDAD AND TOBAGO',
						'TUN'=>	'TUNISIA',
						'TUR'=>	'TURKEY',
						'TUV'=>	'TUVALU',
						'TWN'=>	'TAIWAN, PROVINCE OF CHINA',
						'TZA'=> 'UNITED REPUBLIC OF TANZANIA',
						'UGA'=>	'UGANDA',
						'UK' => 'UNITED KINGDOM',
						'UKR'=>	'UKRAINE',
						'UMI'=>	'UNITED STATES MINOR OUTLYING ISLANDS',
						'URY'=>	'URUGUAY',
						'USA'=>	'US',
						'UZB'=>	'UZBEKISTAN',
						'VAT'=>	'HOLY SEE (VATICAN CITY STATE)',
						'VCT'=>	'SAINT VINCENT AND THE GRENADINES',
						'VEN'=>	'VENEZUELA',
						'VGB'=>	'VIRGIN ISLANDS (BRITISH)',
						'VIR'=>	'VIRGIN ISLANDS (U.S.)',
						'VNM'=>	'VIETNAM',
						'VUT'=>	'VANUATU',
						'WLF'=>	'WALLIS AND FUTUNA ISLANDS',
						'WSM'=>	'YEMEN',
						'YUG'=>	'YUGOSLAVIA',
						'ZAF'=>	'SOUTH AFRICA',
						'ZMB'=>	'ZAMBIA',
						'**'
						);
		END;
		
		//****************************************************************************
		//KnownBadCodes: returns a blank for these know bad state codes.  Not to 
		//							 reject records if these codes exist or all numerics. 
		//****************************************************************************
		EXPORT KnownBadCodes(STRING s) := FUNCTION
		
				uc_s 			:= corp2.t2u(stringlib.stringfilterout(s,'0123456789'));
				
				RETURN MAP(uc_s in ['']											  => true,
									 uc_s in ['A']											=> true,
									 uc_s in ['BE','C','CI']						=> true,
									 uc_s in ['D','DA']									=> true,
									 uc_s in ['E','EL']									=> true,
									 uc_s in ['FR']											=> true,
									 uc_s in ['JO']											=> true,
									 uc_s in ['MM']											=> true,
									 uc_s in ['N','NA','NN','NO']				=> true,
									 uc_s in ['Q','QJ']									=> true,
									 uc_s in ['S']											=> true,
									 uc_s in ['T','TE']									=> true,
									 uc_s in ['V']											=> true,
									 uc_s in ['Y']											=> true,
									 uc_s in ['Z']											=> true,
									 false
									);

		END;

		//********************************************************************
		//CorpForgnStateCD: Returns "corp_forgn_state_cd".
		//********************************************************************	
		EXPORT CorpForgnStateCD(STRING state_origin,STRING state_desc,STRING jurisdiction) := FUNCTION
					 uc_s  			:= corp2.t2u(jurisdiction);
					 fixed_s 		:= Corp2_Mapping.fCleanState(state_origin,state_desc,jurisdiction).State;

					 RETURN  MAP(StateCodeTranslation(uc_s)[1..2] <> '**'  	 => corp2.t2u(uc_s),
											 ValidProvinceCode(uc_s)[1..2] <> '**' 			 => corp2.t2u(uc_s),
											 ValidCountryCode(uc_s)[1..2] <> '**'  			 => corp2.t2u(uc_s),
											 KnownBadCodes(uc_s)												 => '',
											 fixed_s = 'US'															 => '',
											 '**|'+uc_s											 
											);
		END;

		//********************************************************************
		//CorpForgnStateDesc: Returns "corp_forgn_state_desc".
		//********************************************************************	
		EXPORT CorpForgnStateDesc(STRING state_origin,STRING state_desc,STRING jurisdiction) := FUNCTION
		
					 uc_s  			:= corp2.t2u(jurisdiction);
					 fixed_s 		:= Corp2_Mapping.fCleanState(state_origin,state_desc,jurisdiction).State;

					 RETURN  MAP(StateCodeTranslation(uc_s)[1..2] <> '**'  	 => StateCodeTranslation(uc_s),
											 ValidProvinceCode(uc_s)[1..2] <> '**' 			 => ValidProvinceCode(uc_s),
											 ValidCountryCode(uc_s)[1..2] <> '**'  			 => ValidCountryCode(uc_s),
											 KnownBadCodes(uc_s)  											 => '',
											 fixed_s = 'US'															 => '',
											 '**|'+uc_s
											);										
		END;
		
		//********************************************************************
		//LookupHistoryTypeCodes: Returns "event_filing_desc".
		//Note:  Here is a ruler that can be used to indicate if the length is
		//			 too long (it is 60 characters in length):
		//'123456789012345678901234567890123456789012345678901234567890',
		//********************************************************************	
		EXPORT LookupHistoryTypeCodes(STRING s) := FUNCTION

					 uc_s 			:= corp2.t2u(stringlib.stringfilter(s,'0123456789'));
														 				
					 RETURN CASE(uc_s,
											'000' => '', //Do not map, per CI
											'001' => 'AGREEMENT OF ASSOCIATION',
											'002' => 'AMENDED FOREIGN CORPORATIONS CERTIFICATE',
											'003' => 'AMENDMENTS TO LIMITED PARTNERSHIP CERTIFICATE',
											'004' => 'ANNUAL REPORT',           
											'005' => 'APPLICATION FOR REGISTRATION',            
											'006' => 'APPLICATION FOR REVIVAL', 
											'007' => 'ARTICLES OF AMENDMENT',   
											'008' => 'ARTICLES OF CONSOLIDATION - DOMESTIC AND DOMESTIC',
											'009' => 'ARTICLES OF MERGER - DOMESTIC AND DOMESTIC', 
											'010' => 'ARTICLES OF VOLUNTARY DISSOLUTION', 
											'011' => 'ARTICLES OF MERGER OF PARENT AND SUBSIDIARY CORPORATIONS',
											'012' => 'ARTICLES OF MERGER OF TRUST AND CORPORATION',
											'013' => 'ARTICLES OF ORGANIZATION',
											'014' => 'AMENDMENT OF TRUST',      
											'015' => 'CERTIFICATE OF APPOINTMENT OF RESIDENT AGENT', 
											'016' => 'CERTIFICATE OF CANCELLATION',             
											'017' => 'CERTIFICATE OF CHANGE OF ADDRESS OF RESIDENT AGENT',      
											'018' => 'CERTIFICATE OF CHANGE OF DIRECTORS OR OFFICERS',   
											'019' => 'CERTIFICATE OF CHANGE OF DIRECTORS OR OFFICERS (RESIGNATION)',
											'020' => 'CERTIFICATE OF CHANGE OF FISCAL YEAR END',
											'021' => 'CERTIFICATE OF CHANGE OF PRINCIPAL OFFICE',  
											'022' => 'CERTIFICATE OF CONSOLIDATION',            
											'023' => 'CERTIFICATE OF CORRECTION',               
											'024' => 'CERTIFICATE OF ORGANIZATION',             
											'025' => 'CERTIFICATE OF REGULATORY BOARD',         
											'026' => 'CERTIFICATE OF RESIGNATION OF RESIDENT AGENT', 
											'027' => 'CERTIFICATE OF REVOCATION OF APPOINTMENT OF RESIDENT AGENT',  
											'028' => 'CERT OF VOTE OF DIRECTORS ESTABLISHING. CLASS OR SERIES OF STOCK',											
											'029' => 'CERTIFICATE OF WITHDRAWAL',               
											'030' => 'DECLARATION OF TRUST',    
											'031' => 'DISSOLUTION BY COURT ORDER OR BY THE SOC',
											'032' => 'CERTIFICATE OF MERGER',   
											'033' => 'EXHIBIT TO FOREIGN PROFESSIONAL CORPORATION CERTIFICATE', 
											'034' => 'FOREIGN CORPORATION CERTIFICATE',         
											'035' => 'FOREIGN LIMITED PARTNERSHIP REGISTRATION',
											'036' => 'ISSUE OF CAPITAL STOCK',  
											'037' => 'LIMITED PARTNERSHIP CERTIFICATE',         
											'038' => 'NOTICE OF MEETING',       
											'039' => 'REGISTRATION AMENDMENT',  
											'040' => 'REPORT OF VOLUNTARY ASSOCIATIONS AND TRUSTS',
											'041' => 'RESTATED ARTICLES OF ORGANIZATION',       
											'042' => 'REVOCATION BY SOC',       
											'043' => 'TERMINATION OF TRUST',    
											'044' => 'CERTIFICATE OF REGISTRATION',             
											'045' => 'RESTATED CERTIFICATE OF ORGANIZATION',    
											'046' => 'CERTIFICATE OF AMENDMENT',
											'047' => 'ARTICLES OF CONSOLIDATION  - FOREIGN AND DOMESTIC',
											'048' => 'ARTICLES OF MERGER - FOREIGN AND DOMESTIC',  
											'049' => 'ANNUAL REPORT - PROFESSIONAL',            
											'050' => 'ARTICLES OF DOMESTICATION',               
											'051' => 'ARTICLES OF CHARTER SURRENDER',           
											'052' => 'ARTICLES OF NON-PROFIT CONVERSION',       
											'055' => 'ARTICLES OF ENTITY CONVERSION',           
											'058' => 'ARTICLES OF MERGER - DOMESTIC AND FOREIGN',  
											'059' => 'ARTICLES OF MERGER - FOREIGN AND FOREIGN',
											'060' => 'CERTIFICATE OF CONVERSION',               
											'062' => 'ARTICLES OF SHARE EXCHANGE',              
											'064' => 'ART. OF VOL. DISS. OF CORP THAT HASN\'T ISSUED SHARES OR COMMENCED BUS.',
											'065' => 'MISCELLANEOUS INFORMATION',               
											'067' => 'REVOCATION OF DISSOLUTION',               
											'068' => 'REINSTATEMENT FOLLOWING ADMINISTRATIVE DISSOLUTION',
											'069' => 'REINSTATEMENT FOLLOWING ADMINISTRATIVE DISSOLUTION',
											'070' => 'TRANSFER OF AUTHORITY',   
											'071' => 'ADMINISTRATIVE DISSOLUTION',              
											'074' => 'STATEMENT OF CHANGE OF SUPPLEMENTAL INFORMATION',  
											'075' => 'STATEMENT OF APPOINTMENT OF REGISTERED AGENT', 
											'076' => 'STATEMENT OF CHANGE OF REGISTERED AGENT / REGISTERED OFFICE', 
											'077' => 'STATEMENT OF CHG. OF REG. OFFICE ADDR. BY AGENT',
											'078' => 'STATEMENT OF RESIGNATION OF REGISTERED AGENT', 
											'079' => 'ARTICLES OF CORRECTION',
											'081' => 'CERTIFICATE OF MERGER', 
											'085' => 'CORP FICHE', 
											'086' => 'STATEMENT OF CHG. OF RESIDENT OFFICE ADDRESS',
										  '087' => 'STATEMENT OF CHG. OF RESIDENT OFFICE ADDR BY AGENT',
											'088' => 'STATEMENT OF RESIGNATION OF RESIDENT AGENT',											
											'099' => 'INTERNAL NOTICE',         
											'100' => 'DISSOLUTION',             
											'101' => 'FEES PAID',               
											'102' => 'GOOD STANDING',           
											'103' => 'LONG LEGAL',              
											'104' => 'LONG LEGAL WITH AMENDMENTS',              
											'105' => 'LONG LEGAL WITH OFFICERS AND AMENDMENTS', 
											'106' => 'LONG LEGAL WITH GENERAL PARTNERS',        
											'107' => 'MERGER',                  
											'108' => 'NON-EXISTENCE',           
											'109' => 'REGISTRATION',            
											'110' => 'REGISTRATION WITH ONE NAME CHANGE',       
											'111' => 'REVOCATION',              
											'112' => 'REVOCATION / RE-QUALIFICATION',           
											'113' => 'SHORT LEGAL',             
											'114' => 'SHORT WITH ONE NAME CHANGE',              
											'115' => 'SHORT LEGAL WITH TWO OR MORE CHANGES',    
											'116' => 'SHORT LEGAL WITH OFFICERS',               
											'117' => 'WITHDRAWAL',              
											'118' => 'CERTIFICATE(S) REQUEST',  
											'119' => 'DELINQUENCY',             
											'120' => 'CANCELLATION',            
											'121' => 'NON-REGISTRATION',        
											'122' => 'REVOCATION / RE-QUALIFICATION GOOD STANDING',
											'123' => 'REVOCATION / RE-QUALIFICATION WITH NAME CHANGES',  
											'124' => 'LONG LEGAL WITH NO AMENDMENTS',           
											'135' => 'UCC - 1',                 
											'136' => 'UCC - 3 DBA',             
											'137' => 'UCC - 3 TRANSMITTING UTILITY',            
											'139' => 'UCC - 3 TERMINATION',     
											'140' => 'UCC - 11 SEARCH REQUEST', 
											'141' => 'UCC - 3 CONTINUATION',    
											'142' => 'UCC - 3 AMENDMENT',       
											'143' => 'UCC - 3 ASSIGNEMENT',     
											'144' => 'UCC - 3 PARTIAL RELEASE', 
											'145' => 'UCC - 3 SUBORDINATION',   
											'149' => 'UCC -3 TERMINATION DBA',  
											'150' => 'UCC - 3 ENVIRONMENTAL LIEN',              
											'160' => 'CORPORATIONS PUBLIC BROWSE AND SEARCH',   
											'170' => 'CERTIFIED COPY',
											'180' => 'ARTICLES OF MERGER - DOMESTIC AND UNREGISTERED FOREIGN',
											'181' => 'ARTICLES OF MERGER - FOREIGN AND UNREGISTERED FOREIGN',
											'182' => 'ARTICLES OF CONSOLIDATION - DOMESTIC AND UNREGISTERED FOREIGN',
											'183' => 'ARTICLES OF CONSOLIDATION - FOREIGN AND UNREGISTERED FOREIGN',	
											'184' => 'CERTIFICATE OF MERGER - UNREGISTERED FOREIGN', 
											'185' => 'CERTIFICATE OF CONSOLIDATION - UNREGISTERED FOREIGN',
											'186' => 'CERTIFICATE OF ISSUANCE',
											'187' => 'DISSOLUTION BY COURT ORDER OR BY THE SOC',
											'188'	=> 'ORDER OF NOTICE',
											'189' => 'MOTION',
											'600' => 'ON-LINE ORDER BOOKSTORE',
											'998' => 'NOTICE',
											'999' => 'INTERNAL NOTICE',
											'' 		=> '', 
											'**|'+uc_s
										 );
		END;

		//********************************************************************
		//LookupStockTypeCodes: Returns "corp_forgn_state_desc".
		//********************************************************************	
		EXPORT LookupStockTypeCodes(STRING s) := FUNCTION
		
					 uc_s 			:= corp2.t2u(stringlib.stringfilterout(s,'0123456789'));
				
					 RETURN CASE(uc_s,
											'CNP' => 'COMMON NO PAR',
											'CWP' => 'COMMON WITH PAR',
											'NA'	=> '', //known invalid stock class
											'PNP' => 'PREFERRED NO PAR',
											'PWP' => 'PREFERRED WITH PAR',
											'STK' => 'STOCK',
											''		=> '',  		
											'**|'+uc_s
										 );
		END;

		//********************************************************************
		//LookupInactiveTypeCodes: Returns "corp_forgn_state_desc".
		//********************************************************************	
		EXPORT LookupInactiveTypeCodes(STRING s) := FUNCTION

					 uc_s 			:= corp2.t2u(stringlib.stringfilterout(s,'0123456789'));
				
					 RETURN CASE(uc_s,
											'0' 	=> '', //invalid type per CI
											'A'		=> '', //invalid type per CI
											'C' 	=> 'CONSOLIDATED',
											'E' 	=> 'DISSOLVED',
											'F'		=> '', //invalid type per CI
											'I' 	=> 'INVOLUNTARY DISSOLUTION BY SOC',
											'L' 	=> 'LIQUIDATION',
											'M' 	=> 'MERGED OUT OF EXISTENCE',
											'N' 	=> 'CONSOLIDATION',
											'O' 	=> 'DISSOLUTION BY COURT ORDER',
											'R' 	=> 'REVIVED',
											'S'		=> 'CONVERTED',
											'T' 	=> 'TERMINATION OF TRUST',
											'U'   => 'SURRENDER',
											'V' 	=> 'VOLUNTARY DISSOLUTION',
											'W' 	=> 'WITHDRAWN',
											'Y'   => '', //invalid type per CI
											'Z'   => '', //invalid type per CI
											''		=> '',
											'**|'+uc_s
										 );
		END;
		
		//********************************************************************
		//LookupEntityTypeCodes: Returns "corp_forgn_state_desc".
		//********************************************************************	
		EXPORT LookupEntityTypeCodes(STRING s) := FUNCTION
		
					 uc_s 			:= corp2.t2u(s);
					 
					 RETURN CASE(uc_s,
											'CEMETERY CORPORATION' 																				=> '1015',
											'CERTIFICATES' 																								=> '5010',
											'CERTIFIED COPIES'																						=> '5011',												
											'CHURCH CORPORATION' 																					=> '1014',
											'CO-OPERATIVE BANK' 																					=> '1011',
											'CREDIT UNION' 																								=> '1016',
											'DOMESTIC BENEFIT CORPORATION' 																=> '',
											'DOMESTIC LIMITED LIABILITY COMPANY (LLC)' 										=> '0801',
											'DOMESTIC LIMITED PARTNERSHIP (LP)' 													=> '0601',
											'DOMESTIC PROFIT CORPORATION' 																=> '0200',
											'EMPLOYEE CO-OPERATIVE' 																			=> '1019',
											'FICHE (CORP)' 																								=> '8500',
											'FICHE (UCC)' 																								=> '8000',											
											'FOREIGN CORPORATION' 																				=> '0500',
											'FOREIGN DBA' 																								=> '1017',
											'FOREIGN LIMITED LIABILITY COMPANY (LLC)' 										=> '0802',
											'FOREIGN LIMITED PARTNERSHIP (LP)' 														=> '0602',
											'GAS AND ELECTRIC COMPANIES' 																	=> '1013',
											'HOSPITAL' 																										=> '1023',
											'HOUSING CO-OPERATIVE' 																				=> '1020',
											'INSURANCE' 																									=> '1021',
											'LIBRARY ASSOCIATION' 																				=> '1018',
											'LIMITED URBAN DEVELOPMENT'																		=> '1022',
											'MERCANTILE CO-OPERATIVE' 																		=> '',
											'NONPROFIT CORPORATION' 																			=> '0300',
											'OTHER MISCELLANEOUS' 																				=> '',
											'PROFESSIONAL BENEFIT CORPORATION' 														=> '',
											'PROFESSIONAL CORPORATION' 																		=> '0400',
											'REGISTERED DOMESTIC LIMITED LIABILITY PARTNERSHIP (LLP)' 		=> '0703',
											'REGISTERED FOREIGN LIMITED LIABILITY PARTNERSHIP (LLP)' 			=> '0705',
											'REGISTERED PROFESSIONAL LIMITED LIABILITY PARTNERSHIP (LLP)' => '0704',
											'RELIGIOUS (CHAPTER 180)'																			=> '1025',
											'SAVINGS BANK'																								=> '1012',
											'SCHOOL'																											=> '1024',
											'TRUST COMPANY'																								=> '1010',
											'UNIFORM COMMERCIAL CODE (UCC)'																=> '0100',
											'UNKNOWN'																											=> '0000',											
											'UTILITY (WATER)'																							=> '1026',
											'VOLUNTARY ASSOCIATIONS AND TRUSTS'														=> '0900',
											''																														=> '',
											'**|'+uc_s
										 );
		END;
		//****************************************************************************
		//LookupEntityTypeDesc: returns the entity description if it is valid.
		//****************************************************************************
		EXPORT LookupEntityTypeDesc(STRING s) := FUNCTION
				uc_s := corp2.t2u(s);
				
				isValidDesc := CASE( uc_s,
														'CEMETERY CORPORATION' 																				=> true,
														'CERTIFICATES' 																								=> false,
														'CERTIFIED COPIES'																						=> false,											
														'CHURCH CORPORATION' 																					=> true,
														'CO-OPERATIVE BANK' 																					=> true,
														'CREDIT UNION' 																								=> true,
														'DOMESTIC BENEFIT CORPORATION' 																=> true,
														'DOMESTIC LIMITED LIABILITY COMPANY (LLC)' 										=> true,
														'DOMESTIC LIMITED PARTNERSHIP (LP)' 													=> true,
														'DOMESTIC PROFIT CORPORATION' 																=> true,
														'EMPLOYEE CO-OPERATIVE' 																			=> true,
														'FICHE (CORP)' 																								=> false,
														'FICHE (UCC)' 																								=> false,
														'FOREIGN CORPORATION' 																				=> true,
														'FOREIGN DBA' 																								=> true,
														'FOREIGN LIMITED LIABILITY COMPANY (LLC)' 										=> true,
														'FOREIGN LIMITED PARTNERSHIP (LP)' 														=> true,
														'GAS AND ELECTRIC COMPANIES' 																	=> true,
														'HOSPITAL' 																										=> true,
														'HOUSING CO-OPERATIVE' 																				=> true,
														'INSURANCE' 																									=> true,
														'LIBRARY ASSOCIATION' 																				=> true,
														'LIMITED URBAN DEVELOPMENT'																		=> true,
														'MERCANTILE CO-OPERATIVE' 																		=> true,
														'NONPROFIT CORPORATION' 																			=> true,
														'OTHER MISCELLANEOUS' 																				=> true,
														'PROFESSIONAL BENEFIT CORPORATION' 														=> true,
														'PROFESSIONAL CORPORATION' 																		=> true,
														'REGISTERED DOMESTIC LIMITED LIABILITY PARTNERSHIP (LLP)' 		=> true,
														'REGISTERED FOREIGN LIMITED LIABILITY PARTNERSHIP (LLP)' 			=> true,
														'REGISTERED PROFESSIONAL LIMITED LIABILITY PARTNERSHIP (LLP)' => true,
														'RELIGIOUS (CHAPTER 180)'																			=> true,
														'SAVINGS BANK'																								=> true,
														'SCHOOL'																											=> true,
														'TRUST COMPANY'																								=> true,
														'UNIFORM COMMERCIAL CODE (UCC)'																=> false,
														'UNKNOWN'																											=> false,
														'UTILITY (WATER)'																							=> true,
														'VOLUNTARY ASSOCIATIONS AND TRUSTS'														=> true,
														 false
														);
				RETURN IF(isValidDesc,uc_s,'');
		END;

END;
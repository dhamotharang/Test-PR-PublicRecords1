IMPORT corp2,corp2_mapping,ut;

EXPORT Functions := MODULE

		//****************************************************************************
		//StateCodeTranslation: returns the us state description.
		//****************************************************************************
		EXPORT StateCodeTranslation(STRING s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
	         RETURN map(uc_s = 'AL' => 'ALABAMA',
											uc_s = 'AK' => 'ALASKA', 
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
		//StateDescriptionTranslation: returns the us state code.
		//****************************************************************************
		EXPORT StateDescriptionTranslation(STRING s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
	         RETURN map(uc_s = 'ALABAMA' 													=> 'AL',
											uc_s = 'ALASKA' 													=> 'AK', 
											uc_s = 'ARKANSAS'													=> 'AR', 
											uc_s = 'AMERICAN SAMOA' 									=> 'AS',
											uc_s = 'ARIZONA' 													=> 'AZ', 
											uc_s = 'CALIFORNIA' 											=> 'CA',
											uc_s = 'CAYMAN ISLANDS'										=> 'KY',											
											uc_s = 'COLORADO' 												=> 'CO',
											uc_s = 'CONNECTICUT' 											=> 'CT',
											uc_s = 'CANAL ZONE' 											=> 'CZ',							
											uc_s = 'DISTRICT OF COLUMBIA' 						=> 'DC',
											uc_s = 'DELAWARE' 												=> 'DE',
										  uc_s = 'FEDERATED STATES OF MICRONESIA'		=> 'FM',											
											uc_s = 'FLORIDA' 													=> 'FL',
											uc_s = 'GEORGIA' 													=> 'GA',
											uc_s = 'GUAM' 														=> 'GU',
											uc_s = 'HAWAII' 													=> 'HI',
											uc_s = 'IOWA' 														=> 'IA',
											uc_s = 'IDAHO' 														=> 'ID',
											uc_s = 'ILLINOIS' 												=> 'IL',
											uc_s = 'INDIANA' 													=> 'IN',
											uc_s = 'KANSAS' 													=> 'KS',
											uc_s = 'KENTUCKY' 												=> 'KY',
											uc_s = 'LOUISIANA' 												=> 'LA',
											uc_s = 'MASSACHUSETTS' 										=> 'MA',
											uc_s = 'MARYLAND' 												=> 'MD',
											uc_s = 'MAINE'														=> 'ME',
											uc_s = 'MICHIGAN'													=> 'MI', 
											uc_s = 'MINNESOTA'												=> 'MN',
											uc_s = 'MISSOURI'													=> 'MO',
											uc_s = 'MISSISSIPPI'											=> 'MS',
											uc_s = 'MONTANA'													=> 'MT',
											uc_s = 'NORTH CAROLINA'										=> 'NC',
											uc_s = 'NORTH DAKOTA'											=> 'ND',
											uc_s = 'NEBRASKA'													=> 'NE',
											uc_s = 'NEW HAMPSHIRE'										=> 'NH',
											uc_s = 'NEW HAMSHIRE'											=> 'NH',
											uc_s = 'NEW JERSEY'												=> 'NJ',
											uc_s = 'NEW MEXICO'												=> 'NM',
											uc_s = 'NEVADA'														=> 'NV',
											uc_s = 'NEW YORK'													=> 'NY',
											uc_s = 'OHIO'															=> 'OH',
											uc_s = 'OKLAHOMA'													=> 'OK',
											uc_s = 'OREGON'														=> 'OR',
											uc_s = 'PENNSYLVANIA'											=> 'PA',
											uc_s = 'PUERTO RICO'											=> 'PR',
											uc_s = 'PUERTO RICO, COMMWEALTH'					=> 'PR',															
											uc_s = 'RHODE ISLAND'											=> 'RI',
											uc_s = 'SOUTH CAROLINA'										=> 'SC',
											uc_s = 'SOUTH DAKOTA'											=> 'SD',
											uc_s = 'TENNESSEE'												=> 'TN',
											uc_s = 'TEXAS'														=> 'TX',
											uc_s = 'UNITED STATES'										=> 'US',
											uc_s = 'UTAH'														 	=> 'UT',
											uc_s = 'VIRGINIA'													=> 'VA',
											uc_s = 'VIRGIN ISLANDS'										=> 'VI',
											uc_s = 'VERMONT'													=> 'VT',
											uc_s = 'WASHINGTON'												=> 'WA',
											uc_s = 'WISCONSIN'												=> 'WI',
											uc_s = 'WEST VIRGINIA'										=> 'WV',
											uc_s = 'WYOMING'													=> 'WY',
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//CountryDescriptionTranslation: returns the country code.
		//****************************************************************************
		EXPORT CountryDescriptionTranslation(STRING stateorigin, STRING stateorigindesc, STRING s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
					 RETURN map(uc_s = 'MARSHALL ISLANDS'                        											        => 'MH',
											uc_s = 'REPUBLIC OF KOREA'                               											=> 'KO',
											uc_s = 'NORTHERN MARIANA ISLANDS'                        											=> 'MP',
											uc_s = 'PALAU'                                          											=> 'PW',
											uc_s = 'ARMED FORCES EUROPE, THE MIDDLE EAST AND CANADA' 											=> 'AE',
											uc_s = 'ARMED FORCES PACIFIC'                            											=> 'AP',
											uc_s = 'ARMED FORCES AMERICAS EXCEPT CANADA'             											=> 'AA',
											uc_s = 'ARUBA'                                           											=> 'AD',
											uc_s = 'AUSTRALIA'                                       											=> 'AU',
											uc_s = 'BRITISH COLUMBIA'                                											=> 'BC',
											uc_s = 'BELGUID'                                         											=> 'BELGIUM',
											uc_s = 'BAHAMAS'                                         											=> 'BI',
											uc_s = 'ECUADOR'                                         											=> 'EC',
											uc_s = 'ENGLAND'                                         											=> 'EN',
											uc_s = 'FEDERATED CHARTERED'                             											=> 'FC',
											uc_s = 'FRANCE'                                          											=> 'FR',
											uc_s = 'GERMANY'                                        										 	=> 'GE',
											uc_s = 'GUERNSEY'                                        											=> 'GG',
											uc_s = 'ONTARIO, CANADA'                                 											=> 'ON',
											uc_s = 'HONG KONG'                                       											=> 'HK',
											uc_s = 'INDIA'                                           											=> 'IN',
											uc_s = 'ITALY'                                           											=> 'IT',
											uc_s = 'JAPAN'                                           											=> 'JA',
											uc_s = 'KOREA'                                           											=> 'KO',
											uc_s = 'LIECHTENSTEIN'                                   											=> 'LI',
											uc_s = 'LUXEMBOURG'                                      											=> 'LU',
											uc_s = 'NETHERLANDS ANTILLES'                            											=> 'NA',
											uc_s = 'CANADA'                                          											=> 'NC',
											uc_s = 'PARAGUAY'                                        											=> 'PG',
											uc_s = 'PANAMA'                                          											=> 'RP',
											uc_s = 'SCOTLAND'                                        											=> 'SL',
											uc_s = 'SWITZERLAND'                                     											=> 'SW',
											uc_s = 'THAILAND'																															=> 'THA',
											uc_s = 'TURKS AND CAICOS ISLANDS'                        											=> 'TC',
											uc_s = 'UNITED KINGDON'                                  											=> 'UK',
											uc_s = 'URAGUAY'                                         											=> 'UR',
											uc_s = 'BRITISH WEST INDIES'                             											=> 'WN',
											Corp2_Mapping.fCleanCountry(stateorigin,stateorigindesc,,uc_s).Country = 'US' => 'US',
											'**|'+uc_s
										 );
		END;
		
		//****************************************************************************
		//CountryDescription: returns the "Country Description".
		//****************************************************************************
		EXPORT CountryCodeTranslation(STRING stateorigin, STRING stateorigindesc, STRING s) := FUNCTION

			 uc_s := corp2.t2u(s);
			 
			 RETURN MAP(uc_s = '' 																																		=> '',
									uc_s = 'ABW' 	 																																=> 'NETHERLAND ANTILLES',
									uc_s = 'ANT' 	 																																=> 'CURACAO',
								  uc_s = 'ARE' 	 																																=> 'UNITED ARAB EMIRATES',
								  uc_s = 'ARG' 	 																																=> 'ARGENTINA',
								  uc_s = 'AUS' 	 																																=> 'AUSTRALIA',
								  uc_s = 'AUT' 	 																																=> 'AUSTRIA',
								  uc_s = 'BEL' 	 																																=> 'BELGIUM',
								  uc_s = 'BHS' 	 																																=> 'BAHAMAS',
								  uc_s = 'BLR' 	 																																=> 'BELARUS',
								  uc_s = 'BLZ' 	 																																=> 'BELIZE',
								  uc_s = 'BMU' 	 																																=> 'BERMUDA',
									uc_s = 'BRB' 	 																																=> 'BARBADOS',
								  uc_s = 'CAN' 	 																																=> 'CANADA',
								  uc_s = 'CHE' 	 																																=> 'SWITZERLAND',
								  uc_s = 'CHL' 	 																																=> 'CHILE',
									uc_s = 'CHN' 	 																																=> 'CHINA',
								  uc_s = 'COL' 	 																																=> 'D.C. COLOMBIA',
								  uc_s = 'CRI' 	 																																=> 'COSTA RICA',
								  uc_s = 'CUB' 	 																																=> 'CUBA',
								  uc_s = 'CYM' 	 																																=> 'GRAND CAYMAN',
									uc_s = 'CYP' 	 																																=> 'CYPRUS',
								  uc_s = 'CZE' 	 																																=> 'CZECH REPUBLIC',
								  uc_s = 'DEU' 	 																																=> 'GERMANY',
								  uc_s = 'DNK' 	 																																=> 'DENMARK',
								  uc_s = 'ECU' 	 																																=> 'REPUBLIC OF ECUADOR',
								  uc_s = 'ESP' 	 																																=> 'ESPANA',
								  uc_s = 'FIN' 	 																																=> 'FINLAND',
								  uc_s = 'FRA' 	 																																=> 'FRANCE',
								  uc_s = 'GBR' 	 																																=> 'ENGLAND',
								  uc_s = 'GEO' 	 																																=> 'REPUBLIC OF GEORGIA',							
								  uc_s = 'GRC' 	 																																=> 'GREECE',
								  uc_s = 'GTM' 	 																																=> 'GUATEMALA',
								  uc_s = 'HKG' 	 																																=> 'HONG KONG',
									uc_s = 'HND' 	 																																=> 'HONDURAS',
									uc_s = 'HUN' 	 																																=> 'HUNGARY',
									uc_s = 'IDN' 	 																																=> 'INDONESIA',
								  uc_s = 'IND' 																																	=> 'INDIA',
									uc_s = 'IRL' 	 																																=> 'IRELAND',
									uc_s = 'IRN' 	 																																=> 'IRAN',
									uc_s = 'IRQ' 	 																																=> 'IRAQ',
									uc_s = 'ISL' 	 																																=> 'ICELAND',
									uc_s = 'ISR' 	 																																=> 'ISRAEL',
									uc_s = 'ITA' 	 																																=> 'ITALY',
									uc_s = 'KOR' 	 																																=> 'REPUBLIC OF KOREA',
								  uc_s = 'JPN' 	 																																=> 'JAPAN',
								  uc_s = 'LBN' 	 																																=> 'LEBANON',
								  uc_s = 'LBR' 	 																																=> 'LIBERIA',
								  uc_s = 'LIE' 	 																																=> 'LIECHTENSTEIN',
								  uc_s = 'LUX' 	 																																=> 'LUXEMBOURG',
								  uc_s = 'MAC' 	 																																=> 'MACAU, CHINA',
								  uc_s = 'MCO' 	 																																=> 'MONACO',
								  uc_s = 'MEX' 	 																																=> 'MEXICO',
								  uc_s = 'MHL' 	 																																=> 'MAJURO',
								  uc_s = 'MLT' 	 																																=> 'MALTA',
								  uc_s = 'MNP' 	 																																=> 'NORTHERN MARIANA ISLANDS',
								  uc_s = 'MYS' 	 																																=> 'MALAYSIA',
									uc_s = 'NGA' 	 																																=> 'NIGERIA',
									uc_s = 'NIC' 	 																																=> 'NICARAGUA',
									uc_s = 'NLD' 	 																																=> 'NETHERLANDS',
									uc_s = 'NOR' 	 																																=> 'NORWAY',
									uc_s = 'OMN' 	 																																=> 'OMAN',
									uc_s = 'PAN' 	 																																=> 'REPUBLIC OF PANAMA',
									uc_s = 'PER' 	 																																=> 'PERU',
								  uc_s = 'PHL' 	 																																=> 'PHILIPPINES',
								  uc_s = 'PRI' 	 																																=> 'PUERTO RICO',
								  uc_s = 'PRY' 	 																																=> 'PARAGUAY',
								  uc_s = 'RUS' 	 																																=> 'RUSSIA',
									uc_s = 'SGP' 	 																																=> 'SINGAPORE',
								  uc_s = 'SLV' 	 																																=> 'EL SALVADOR',
								  uc_s = 'SVN' 	 																																=> 'SLOVENIA',
								  uc_s = 'SWE' 	 																																=> 'SWEDEN',
									uc_s = 'THA'																																	=> 'THAILAND',
								  uc_s = 'TCA' 	 																																=> 'TURKS AND CAICOS ISLANDS',
								  uc_s = 'TUR' 	 																																=> 'TURKEY',
								  uc_s = 'UMI' 	 																																=> 'UNITED STATES MINOR OUTLYING ISLANDS',
								  uc_s = 'URY' 	 																																=> 'URUGUAY',
									uc_s = 'UZB' 																																	=> 'UZBEKISTAN',
								  uc_s = 'VCT' 	 																																=> 'SAINT VINCENT AND THE GRENADINES',
								  uc_s = 'VEN' 	 																																=> 'VENEZUELA',
								  uc_s = 'VGB' 	 																																=> 'BRITISH VIRGIN ISLANDS',
								  uc_s = 'VIR' 	 																																=> 'UNITED STATES VIRGIN ISLANDS',
								  uc_s = 'ZAF'																																	=> 'SOUTH AFRICA',
									Corp2_Mapping.fCleanCountry(stateorigin,stateorigindesc,,uc_s).Country = 'US' => 'US',									
									'**|'+uc_s
								 ); 
		END;
	 
		//********************************************************************
		//CorpForgnStateCD: Returns "corp_forgn_state_cd".
		//********************************************************************	
		EXPORT CorpForgnStateCD(STRING stateorigin, STRING stateorigindesc, STRING s) := FUNCTION

					 uc_s  		:= corp2.t2u(s);

					 RETURN MAP(stringlib.stringfind(uc_s,'UNKNOWN',1)																	<> 0   => '',
											StateDescriptionTranslation(uc_s)[1..2] 																<>'**' => StateDescriptionTranslation(uc_s),
											CountryDescriptionTranslation(stateorigin,stateorigindesc,uc_s)[1..2]		<>'**' => CountryDescriptionTranslation(stateorigin,stateorigindesc,uc_s),
											'**|'+uc_s
										 );

			END;

		//********************************************************************
		//CorpForgnStateDesc: Returns "corp_forgn_state_desc".
		//********************************************************************	
		EXPORT CorpForgnStateDesc(STRING stateorigin, STRING stateorigindesc, STRING s) := FUNCTION

					 uc_s  := corp2.t2u(s);

					 RETURN MAP(stringlib.stringfind(uc_s,'UNKNOWN',1)																<> 0   => '',
											StateDescriptionTranslation(uc_s)[1..2] 															<>'**' => uc_s,
											CountryDescriptionTranslation(stateorigin,stateorigindesc,uc_s)[1..2]	<>'**' => uc_s,
											'**|'+uc_s
										 );
			END;
		
   //********************************************************************
   //CorpNameComment: returns the "corp_name_comment" field.
   //********************************************************************					
   EXPORT CorpNameComment(STRING10 indate,STRING desc) := FUNCTION
					uc_indate	:= corp2.t2u(indate);
					uc_desc		:= if(corp2.t2u(desc)<>'','AMENDMENT NUMBER: ' + corp2.t2u(desc),'');
					cleandate	:= Corp2_Mapping.fValidateDate(regexreplace('-',uc_indate,''),'CCYYMMDD').PastDate;
					return map(cleandate <> '' and uc_desc <> '' => 'NAME CHANGED: ' + cleandate + ';' + uc_desc,
										 cleandate <> '' and uc_desc =  '' => 'NAME CHANGED: ' + cleandate,
										 cleandate =  '' and uc_desc <> '' => uc_desc,
										 ''
										 );
   END;

   //********************************************************************
   //CorpAddlInfo: returns the "corp_addl_info" field.
   //********************************************************************					
   EXPORT CorpAddlInfo(STRING date1, STRING date2) := FUNCTION
			
			date1_desc   := 'FIRST USED IN LOUISIANA: ';
			date2_desc   := 'FIRST USED DATE: ';
			
			date1_exists := if(Corp2_Mapping.fValidateDate(date1,'CCYYMMDD').PastDate <> '',true,false);
			date2_exists := if(Corp2_Mapping.fValidateDate(date2,'CCYYMMDD').PastDate <> '',true,false);
			
			RETURN map(date1_exists and date2_exists => date1_desc + ut.date_YYYYMMDDtoDateSlashed(date1) + ' ' + date2_desc+ut.date_YYYYMMDDtoDateSlashed(date2),
								 date1_exists									 => date1_desc + ut.date_YYYYMMDDtoDateSlashed(date1),
								 date2_exists									 => date2_desc + ut.date_YYYYMMDDtoDateSlashed(date2),
								 ''
								);

   END;

   //********************************************************************
   //CorpOrigOrgStructureDesc: returns the "corp_orig_org_structure_desc"
	 //													 field.
   //********************************************************************					
   EXPORT CorpOrigOrgStructureDesc(STRING s) := FUNCTION	
	 			 
				 uc_s := corp2.t2u(s);

				 RETURN case(uc_s,
					'A' 	=> 'NON-LOUISIANA APPOINTMENT OF AGENT',
					'B' 	=> 'LOUISIANA BANK ASSOCIATION',
					'C' 	=> 'LOUISIANA CO-OP',
					'D' 	=> 'LOUISIANA BUSINESS CORPORATION',
					'E'   => 'AGENT FOR SERVICE INDEMNITY TRUST',
					'F' 	=> 'NON-LOUISIANA BUSINESS CORPORATION (FOREIGN)',
					'G' 	=> 'LOUISIANA NON-PROFIT LIMITED LIABILITY COMPANY',
					'H' 	=> 'LOUISIANA HOMESTEAD',
					'I'		=> 'COLLECTION AGENCY',
					'J' 	=> 'LOUISIANA PARTNERSHIP',
					'K' 	=> 'LOUISIANA LIMITED LIABILITY COMPANY',
					'L' 	=> 'NON-LOUISIANA PARTNERSHIP (FOREIGN)',
					'M' 	=> 'NON-LOUISIANA LIMITED QUALIFICATION OF CORPORATION (FOREIGN)',
					'N' 	=> 'LOUISIANA NON-PROFIT CORPORATION',
					'P' 	=> 'NON-LOUISIANA REAL ESTATE BROKER (FOREIGN)',
					'Q' 	=> 'NON-LOUISIANA LIMITED LIABILITY COMPANY (FOREIGN)',
					'R' 	=> 'LOUISIANA REAL ESTATE INVESTMENT TRUST',
					'S' 	=> 'LOUISIANA SAVINGS AND LOAN ASSOCIATION',
					'T'	  => 'STATE VIDEO CABLE FRANCHISE',
					'U'		=> 'UNINCORPORATED ASSOCIATION',
					'V' 	=> 'NON-LOUISIANA NON-PROFIT LIMITED LIABILITY COMPANY (FOREIGN)',
					'W' 	=> 'LOUISIANA CHURCH',
					'X' 	=> 'NON-LOUISIANA NON-PROFIT CORPORATION & CO-OP(FOREIGN)',
					'Y' 	=> 'LOUISIANA REGISTERED LIMITED LIABILITY PARTNERSHIP',
					'Z' 	=> 'NON-LOUISIANA REAL ESTATE INVESTMENT TRUST (FOREIGN)',
					'AA'	=> 'DOMESTIC BENEFIT CORPORATION',
					'BB'	=> 'DOMESTIC PUBLIC BENEFIT CORPORATION',
					'EE'	=> 'HOME SERVICE CONTRACT PROVIDER',					
					uc_s
					);
					
   END;

   //********************************************************************
   //This FUNCTION returns the Corp Orig Business Type Description.
   //********************************************************************					
   EXPORT CorpOrigBusTypeDesc(STRING s) := FUNCTION
	 
     s1:=regexreplace('</Class><Class>',s,'; ',nocase);
     s2:=regexreplace('<RegisteredEntityClasses><Class>',s1,'');
     s3:=regexreplace('</Class></RegisteredEntityClasses>',s2,'');
	   s4:=regexreplace('&amp;',s3,'&');
		 
		 RETURN if(stringlib.stringfind(s4,'MISCELLANEOUS',2)> 0,regexreplace('; MISCELLANEOUS',s4,''),s4);
		 
   END;

	 //****************************************************************************
   //EventFilingDesc: returns the "event_filing_desc".
   //****************************************************************************
   EXPORT EventFilingDesc(STRING s) := FUNCTION
	 
			 uc_s := corp2.t2u(s);

			 RETURN MAP(uc_s = '1308'			=> 'DOMESTIC LLC CHANGE OF AGENT/DOMICILE',
									uc_s = '1350'			=> 'FOREIGN LLC STATEMENT OF CHANGE',
									uc_s = '12104'		=> 'DOMICILE, AGENT CHANGE OR RESIGNATION OF AGENT FOR BUSINESS CORPORATION',
									uc_s = '12236'		=> 'DOMICILE, AGENT CHANGE OR RESIGNATION OF AGENT FOR NON-PROFIT CORPORATION',
									uc_s = '12308'		=> 'STATEMENT OF CHANGE OR CHANGE PRINCIPAL BUSINESS OFFICE FOR NON-LOUISIANA  CORPORATION AND PARTNERSHIP',
									uc_s = '12502'		=> 'DOMICILE, AGENT CHANGE OR RESIGN OF AGENT',
									uc_s = '70FAR'		=> '1970-1974 DOMESTIC ANNUAL REPORTS',
									uc_s = '75FAR'		=> '1975-1980 DOMESTIC ANNUAL REPORTS',
									uc_s = 'ABAND'		=> 'ABANDONMENT',
									uc_s = 'AC867'		=> 'RESOLUTION OF BOARD OF DIRECTORS REGARDING TAX FILINGS',
									uc_s = 'ADDRE'		=> 'CHANGE OF ADDRESS',
									uc_s = 'ADMIN'		=> 'ADMINISTRATIVE TERMINATION',
									uc_s = 'AFDIS'		=> 'AFFIDAVIT TO DISSOLVE',
									uc_s = 'AGREE'		=> 'NON-LOUISIANA PARTNERSHIP FILES AGREEMENT',
									uc_s = 'AMEND'		=> 'AMENDMENT',
									uc_s = 'AMENM'		=> 'AMENDMENT TO A MERGER',
									uc_s = 'ARTDS'		=> 'NO AMENDMENT FILED FOR THIS TYPE',
									uc_s = 'BANKR'		=> 'BANKRUPT',
									uc_s = 'C'				=> 'AMENDMENT NOT VERIFIED',
									uc_s = 'CANCL'		=> 'CANCELLED',
									uc_s = 'CHART'		=> 'CHARTER',
									uc_s = 'CHGCH'		=> 'WHEN A NON-PROFIT CORPORATION CHANGES TO A BUSINESS CORPORATION',
									uc_s = 'CHGST'		=> 'CHANGE STATE OF INCORPORATION',
									uc_s = 'CHOFF'		=> 'APPOINTING, CHANGING OR RESIGNATION OF OFFICER',
									uc_s = 'CLEAR'		=> 'DEPARTMENT OF REVENUE TAX CLEARANCE',
									uc_s = 'CMERG'		=> 'COURT ORDER CANCEL MERGER',
									uc_s = 'CODE'			=> 'AMENDMENT TYPES FOR CORPORATIONS AND PARTNERSHIPS',
									uc_s = 'CONSO'		=> 'CONSOLIDATION',
									uc_s = 'CONVT'		=> 'CONVERT \'J\' TO \'Y\'',
									uc_s = 'COURT'		=> 'ANY OTHER COURT ORDERED FILING',
									uc_s = 'CREIN'		=> 'CANCEL REINSTATEMENT',
									uc_s = 'CRTLQ'		=> 'COURT ORDERED LIQUIDATION',
									uc_s = 'DISPN'		=> 'INCOMPLETE DISSOLUTION PROCEEDINGS',
									uc_s = 'DISSO'		=> 'DISSOLUTION',
									uc_s = 'EADMN'		=> 'ADMINISTRATIVELY TERMINATED IN ERROR',
									uc_s = 'EREVO'		=> 'REVOKED IN ERROR',
									uc_s = 'EXCEA'		=> 'CORPORATIONS\' TERM OF EXISTENCE CEASES',
									uc_s = 'EZTRM'		=> 'SIMPLIFIED TERMINATION',
									uc_s = 'GENRP'		=> 'GENERAL REPORT',
									uc_s = 'LQCRT'		=> 'LIQUIDATORS CERTIFICATE',
									uc_s = 'MERGE'		=> 'MERGER',
									uc_s = 'MISC?'		=> 'MISCELLANEOUS CATEGORY',
									uc_s = 'NMCHG'		=> 'NAME CHANGE',
									uc_s = 'NOFDI'		=> 'NOTICE OF DISSOLUTION',
									uc_s = 'OWNER'		=> 'DISCLOSURE OF OWNERSHIP',
									uc_s = 'POFAT'		=> 'POWER OF ATTORNEY',
									uc_s = 'POSRE'		=> '', //NO DESCRIPTION
									uc_s = 'RECAN'		=> 'RESCINDING CANCELLATION OF CHARTER',
									uc_s = 'REINS'		=> 'REINSTATEMENT',
									uc_s = 'RENEW'		=> 'RENEW REGISTRATION FOR LLP',
									uc_s = 'REREV'		=> 'RESCINDING REVOCATION',
									uc_s = 'RESTA'		=> 'RESTATED ARTICLES',
									uc_s = 'REVOK'		=> 'REVOKED',
									uc_s = 'RS51C'		=> 'RESOLUTION REGARDING UNEQUAL SHARES OF STOCK',
									uc_s = 'SHEXC'		=> 'SHARE EXCHANGE',
									uc_s = 'STBID'		=> 'STATE BID RESOLUTION',
									uc_s = 'SUPIR'		=> 'SUPPLEMENTAL INITIAL REPORT',
									uc_s = 'SUPLQ'		=> 'SUPPLEMENTAL LIQUIDATOR CERTIFICATE',
									uc_s = 'SUPND'		=> 'SUPPLEMENTAL NOTICE OF DISSOLUTION',
									uc_s = 'SUPWD'		=> 'SUPPLEMENTAL WITHDRAWAL',
									uc_s = 'SUSPD'		=> 'SUSPENDED',
									uc_s = 'TERMD'		=> 'TERMINATION OF DISSOLUTION',
									uc_s = 'TERMI'		=> 'TERMINATED',
									uc_s = 'TERMM'		=> 'TERMINATE MERGER',
									uc_s = 'TERMR'		=> 'COURT CANCELLATION OF REVOCATION',
									uc_s = 'TERMW'		=> 'TERMINATION OF WITHDRAWAL',
									uc_s = 'VOID'			=> 'VOID',
									uc_s = 'WDPND'		=> 'WITHDRAWAL PENDING',
									uc_s = 'WITHD'		=> 'WITHDRAWAL',
									uc_s in ['09 AR','70 AR','83 AR','92 AR','95 AR'] => '',
									uc_s in ['ANNRP','O4 AR','O7 AR','POSRE']					=> '',									
									''
								 );

   END;

END;
IMPORT corp2, corp2_mapping;

EXPORT Functions := Module

		//****************************************************************************
		//CorpLNNameTypeCD: returns the "corp_ln_name_type_cd".
		//Input: nt => nametypeid
		//Input: ct => corporationtypeid		
		//****************************************************************************
		EXPORT CorpLNNameTypeCD(STRING nt, STRING ct) := FUNCTION

				uc_nt := corp2.t2u(nt);
				uc_ct := corp2.t2u(ct);

				is_Tradename_or_Reserved := if(uc_ct in ['63','75'] and uc_nt not in ['2','14'],true,false);

				RETURN map(is_Tradename_or_Reserved and uc_ct in ['63'] => '04',
									 is_Tradename_or_Reserved and uc_ct in ['75'] => '07',				
									 uc_nt in ['1','13'] 													=> '01',
									 uc_nt in ['2'] 															=> '03',
									 uc_nt in ['14'] 															=> '07',
									 uc_nt in ['3','15','18']											=> 'P',
									 uc_nt
								  );
		END;

		//****************************************************************************
		//CorpLNNameTypeDesc: returns the "corp_ln_name_type_desc".
		//Input: nt 	=> nametypeid
		//Input: ct 	=> corporationtypeid
		//Input: ntd 	=> nametypedesc				
		//****************************************************************************
		EXPORT CorpLNNameTypeDesc(STRING nt, STRING ct, STRING ntd) := FUNCTION

				uc_nt  := corp2.t2u(nt);
				uc_ct  := corp2.t2u(ct);
				uc_ntd := corp2.t2u(ntd);

				is_Tradename_or_Reserved := if(uc_ct in ['63','75'] and uc_nt not in ['2','14'],true,false);

				RETURN map(is_Tradename_or_Reserved and uc_ct in ['63'] => 'TRADE NAME',
									 is_Tradename_or_Reserved and uc_ct in ['75'] => 'RESERVED',				
									 uc_nt in ['1','13'] 													=> uc_ntd,
									 uc_nt in ['2'] 															=> uc_ntd,
									 uc_nt in ['14'] 															=> uc_ntd,
									 uc_nt in ['3','15','18']											=> uc_ntd,
									 uc_ntd
								  );
		END;

		//****************************************************************************
		//State_Description: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT State_Description(STRING s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'AA' => 'ARMED FORCES AMERICAS EXCEPT CANADA',
											uc_s = 'AE' => 'ARMED FORCES EUROPE',
											uc_s = 'AP' => 'ARMED FORCES PACIFIC',
											uc_s = 'AL' => 'ALABAMA',
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
											uc_s = 'US' => 'UNITED STATES', 
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
		//Fix_State: returns corrected state/province.
		//****************************************************************************
		EXPORT Fix_State(STRING city, STRING state) := FUNCTION

					 uc_city	 := corp2.t2u(stringlib.stringfilter(corp2.t2u(city),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));
					 uc_state	 := corp2.t2u(stringlib.stringfilter(corp2.t2u(state),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 de_cities := ['DOVER','WILINGTON'];

	         RETURN map(uc_state = 'ALBERTA'											=> 'AB',
											uc_state = 'BRITISH COLUMBIA'							=> 'NB',
											uc_state = 'INDIA'												=> 'IND',
											uc_state = 'NEW BRUNSWICK'								=> 'NB',
											uc_state = 'MAHARASHTRA'									=> 'MH',
											uc_state = 'MANITOBA'											=> 'MB',
											uc_state = 'ONTARIO'											=> 'ON',
											uc_state = 'QUEBEC'												=> 'QC',
											uc_state = 'QU'														=> 'QU',
											uc_state = 'USVI'													=> 'VI',
											uc_state = 'VICTORIA'											=> 'BC',
											uc_state in ['','XX']											=> '',
											uc_state = 'DL' and uc_city in de_cities 	=> 'DE',
											State_Description(uc_state)[1..2]<>'**'		=> uc_state,
											'**|'+uc_state
										 );
		END;

		//****************************************************************************
		//Fix_State: returns corrected state/province.
		//****************************************************************************
		EXPORT Fix_Country(STRING state) := FUNCTION

					 uc_state	 := corp2.t2u(stringlib.stringfilter(corp2.t2u(state),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_state = ''																				=> '',
											uc_state = 'AUS'																		=> 'AUSTRALIA',
											uc_state = 'AUT'																		=> 'AUSTRIA',
											uc_state = 'BEL'																		=> 'BELGIUM',
											uc_state = 'BRA'																		=> 'BRAZIL',
											uc_state = 'CAN'																		=> 'CANADA',
											uc_state = 'CZE'																		=> 'CZECH',
											uc_state = 'ESP'																		=> 'SPAIN',
											uc_state = 'FRA'																		=> 'FRANCE',
											uc_state = 'GBR'																		=> 'GREAT BRITIAN',
											uc_state = 'IND'																		=> 'INDIA',
											uc_state = 'IRL'																		=> 'IRELAND',
											uc_state = 'ITA'																		=> 'ITALY',
											uc_state = 'JPN'																		=> 'JAPAN',
											uc_state = 'NLD'																		=> 'NETHERLANDS',
											uc_state = 'PHL'																		=> 'PHILIPPINES',
											uc_state = 'SWE'																		=> 'SWEDEN',
											uc_state = 'TWN'																		=> 'TAIWAN',
											uc_state = 'USA'																		=> 'US',
											uc_state = 'VIR'																		=> 'VIRGIN ISLANDS',
											uc_state = 'ALBANIA'																=> uc_state,
											uc_state = 'BERMUDA'																=> uc_state,
											uc_state = 'CANADA'																	=> uc_state,
											uc_state = 'CHINA'																	=> uc_state,
											uc_state = 'SWITZERLAND'														=> uc_state,
											uc_state = 'UNITED KINGDOM'													=> uc_state,
											uc_state = 'UNITED STATES'													=> 'US',
											uc_state = 'UNITED STATES MINOR OUTLYING ISLANDS'		=> uc_state,
											uc_state = 'URUGUAY'																=> uc_state,
											'**|'+uc_state
										 );
		END;

		//****************************************************************************
		//Fix_Country_Of_Incorporation: returns corrected state or country.
		//****************************************************************************
		EXPORT Fix_Country_Of_Incorporation(STRING s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'LBERTA CANADA'									=> 'ALBERTA CANADA',
											uc_s = 'BRIT VIRGIN ISLANDS' 						=> 'BRITISH VIRGIN ISLANDS',
											uc_s = 'BRITISH VIRGIN ISLAN' 					=> 'BRITISH VIRGIN ISLANDS',
											uc_s = 'BRITISH VIRGIN ISLES' 					=> 'BRITISH VIRGIN ISLANDS',
											uc_s = 'BRITISH VIRGIN ISLNS' 					=> 'BRITISH VIRGIN ISLANDS',
											uc_s = 'FORIDA'													=> 'FLORIDA',
											uc_s = 'GEROGIA'												=> 'GEORGIA',
											uc_s = 'GEORGEIA'												=> 'GEORGIA',
											uc_s = 'GEORGA'													=> 'GEORGIA',
											uc_s = 'N C'														=> 'NC',
											uc_s = 'ENGLAND AND WALES UNITED KING' 	=> 'ENGLAND AND WALES UNITED KINGDOM',
											uc_s = 'LOUISANA'												=> 'LOUISIANA',
											uc_s = 'DMICHIGAN'											=> 'MICHIGAN',
											uc_s = 'NFW YORK'												=> 'NEW YORK',
											uc_s = 'DURHAM'													=> 'NORTH CAROLINA',
											uc_s = 'N CAROLINA'											=> 'NORTH CAROLINA',
											uc_s = 'NORTH CAROLIA'									=> 'NORTH CAROLINA',		
											uc_s = 'KOHIO'													=> 'OHIO',
											uc_s = 'PENNSYLVANNIA'  								=> 'PENNSYLVANIA',
											uc_s = 'PENJSYLVANIA'  									=> 'PENNSYLVANIA',		
											uc_s = 'RHODEISLAND'										=> 'RHODE ISLAND',
											uc_s = 'RHODE ISLANDS'									=> 'RHODE ISLAND',		
											uc_s = 'TENNESSES'											=> 'TENNESSEE',
											uc_s = 'VERMKONT'												=> 'VERMONT',
											uc_s = 'VERONT'													=> 'VERMONT',
											uc_s = 'VRIGINIA'												=> 'VIRGINIA',
											State_Description(uc_s)[1..2]<>'**'			=> uc_s,
											'**|'+uc_s											
										 );
		END;
		
		//****************************************************************************
		//CorpAddressTypeCD: returns the address type code.
		//****************************************************************************
		EXPORT CorpAddressTypeCD(STRING s) := FUNCTION
		
				RETURN map (corp2.t2u(s) = ''   => '',
										corp2.t2u(s) = '1'	=> 'M',
										corp2.t2u(s) = '6'	=> 'PM',
										corp2.t2u(s) = '7'	=> 'L',
										corp2.t2u(s) = '8'	=> 'B',
										corp2.t2u(s) = '9'	=> 'PP',
										corp2.t2u(s) = '10'	=> 'R',
										corp2.t2u(s) = '11'	=> 'PR',
										corp2.t2u(s) = '14'	=> 'PRM',
										corp2.t2u(s) = '15'	=> 'O',
										corp2.t2u(s) = '16'	=> 'Q',
										corp2.t2u(s) = '17'	=> 'W',
										corp2.t2u(s) = '18'	=> 'U',
										corp2.t2u(s) = '19'	=> 'PU',
										corp2.t2u(s) = '24'	=> 'A',
										'**|'+corp2.t2u(s)
									 );
		END;

		//****************************************************************************
		//CorpAddressTypeCD: returns returns the address type description.
		//****************************************************************************
		EXPORT CorpAddressTypeDesc(STRING s) := FUNCTION
		
				RETURN map (corp2.t2u(s) = ''   => '',
										corp2.t2u(s) = '1'	=> 'MAILING',
										corp2.t2u(s) = '6'	=> 'PREVIOUS MAILING',
										corp2.t2u(s) = '7'	=> 'LISTING',
										corp2.t2u(s) = '8'	=> 'BUSINESS',
										corp2.t2u(s) = '9'	=> 'PREVIOUS BUSINESS',
										corp2.t2u(s) = '10'	=> 'REGISTERED OFFICE',
										corp2.t2u(s) = '11'	=> 'PREVIOUS REGISTERED OFFICE',
										corp2.t2u(s) = '14'	=> 'PREVIOUS REGISTERED MAILING',
										corp2.t2u(s) = '15'	=> 'OTHER',
										corp2.t2u(s) = '16'	=> 'QUICK ACCOUNT',
										corp2.t2u(s) = '17'	=> 'WITHDRAWAL',
										corp2.t2u(s) = '18'	=> 'UCC',
										corp2.t2u(s) = '19'	=> 'PREVIOUS UCC',
										corp2.t2u(s) = '24'	=> 'ANNUAL REPORT',
										'**|'+corp2.t2u(s)
									 );
		END;

		//****************************************************************************
		//CorpOrigBusTypeDesc: returns corp_orig_bus_type_desc.
		//Note: If only special characters and/or digits, blank out.
		//****************************************************************************
		EXPORT CorpOrigBusTypeDesc(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 isValidDesc := if(corp2.t2u(stringlib.stringfilterout(uc_s,' .-`!@#$%^&*()-=+_0123456789')) <> '',true,false);
					 RETURN if(isValidDesc,regexreplace('(\\.)*(\\@)*$',uc_s,''),'');
		END;

		//****************************************************************************
		//StockClass: returns the stock class. 
		//Note: Since stock class is only 20 in length, the incoming vendor data is
		//			modified before being mapped.
		//****************************************************************************
		EXPORT StockClass(STRING s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
	         RETURN map(uc_s = '99 SEE CERT'										=> '99 SEE CERT',
											uc_s = 'COMMON'													=> 'COMMON',
											uc_s = 'COMMON CLASS A NON VOTING'			=> 'CMM CLS A NONVOTING',
											uc_s = 'COMMON CLASS A VOTING' 					=> 'CMM CLS A VOTING',
											uc_s = 'COMMON CLASS B NON VOTING'			=> 'CMM CLS B NONVOTING',
											uc_s = 'COMMON CLASS B VOTING'					=> 'CMM CLS B VOTING',
											uc_s = 'COMMON CLASS C'									=> 'CMM CLS C',
											uc_s = 'COMMON CLASS C VOTING'					=> 'CMM CLS C VOTING',
											uc_s = 'COMMON NON VOTING'							=> 'CMM CLS NONVOTING',
											uc_s = 'COMMON VOTING'									=> 'CMM VOTING',
											uc_s = 'PREFERRED'											=> 'PREFERRED',
											uc_s = 'PREFERRED CLASS A NON VOTING'	  => 'PREF CLS A NONVOTING',
											uc_s = 'PREFERRED CLASS A VOTING' 	 		=> 'PREF CLS A VOTING',
											uc_s = 'PREFERRED CLASS B NON VOTING' 	=> 'PREF CLS B NONVOTING',
											uc_s = 'PREFERRED CLASS B VOTING'  			=> 'PREF CLS B VOTING',
											uc_s = 'PREFERRED CLASS C'  						=> 'PREF CLS C',
											uc_s = 'PREFERRED CLASS C VOTING'  			=> 'PREF CLS C VOTING',
											uc_s = 'PREFERRED NON VOTING'  					=> 'PREF NONVOTING',
											uc_s = 'UNDECLARED'											=> 'UNDECLARED',
											uc_s
										 );
		END;

		//****************************************************************************
		//ARComment: returns the "ar_comment". 
		//Input:		 effectivedate
		//****************************************************************************
		EXPORT ARComment(STRING d) := FUNCTION
				effectivedate 					:= Corp2_Mapping.fValidateDate(d,'CCYY-MM-DD').GeneralDate;
				effectivedateformatted 	:= if(effectivedate<>'',effectivedate[5..6]+'/'+effectivedate[7..8]+'/'+effectivedate[1..4],'');
				RETURN if(corp2.t2u(effectivedateformatted)<>'','EFFECTIVE DATE OF ANNUAL REPORT: '+effectivedateformatted,'');
		END;

END;
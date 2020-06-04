IMPORT corp2, corp2_mapping, ut;

EXPORT Functions := Module

    //****************************************************************************
		//CorpLNNameTypeCD: returns the "corp_ln_name_type_cd".
		//Input: cd => businesstype
		//****************************************************************************
		EXPORT CorpLNNameTypeCD(STRING cd) := FUNCTION

				uc_cd:= corp2.t2u(cd);

				RETURN map(uc_cd in ['DOMESTIC LIMITED LIABILITY COMPANY','FOREIGN PROFIT CORPORATION',
				                     'FOREIGN LIMITED LIABILITY COMPANY','DOMESTIC PROFIT CORPORATION',
														 'DOMESTIC PROFESSIONAL LIMITED LIABILITY COMPANY',
														 'DOMESTIC PROFESSIONAL PROFIT CORPORATION',
														 'DOMESTIC NONPROFIT CORPORATION','DOMESTIC LIMITED LIABILITY PARTNERSHIP',
														 'FOREIGN LIMITED PARTNERSHIP','FOREIGN PROFESSIONAL PROFIT CORPORATION',
														 'FOREIGN NONPROFIT CORPORATION','FOREIGN LIMITED LIABILITY PARTNERSHIP',
														 'DOMESTIC LIMITED PARTNERSHIP','DOMESTIC CONSUMER COOPERATIVE',
														 'FOREIGN PROFESSIONAL LIMITED LIABILITY COMPANY',
														 'DOMESTIC BENEFIT CORPORATION','CORRESPONDENCE'] 													  => '01',
									 uc_cd = 'FORCED DBA'                                     															=> '03',
									 uc_cd = 'TRADE NAME'                                     															=> '05',
									 uc_cd = 'FOREIGN REGISTERED CORPORATE NAME'	                                          => '11',
									 '**|'+uc_cd
								  );
		 END;
		 
		 //****************************************************************************
		//CorpForeignDomesticInd: returns the "corp_foreign_domestic_ind".
		//Input: nt => businesstype
		//****************************************************************************
		EXPORT CorpForeignDomesticInd(STRING ind) := FUNCTION

				uc_ind := corp2.t2u(ind);

				RETURN map(uc_ind in ['DOMESTIC LIMITED LIABILITY COMPANY','DOMESTIC PROFIT CORPORATION',
														  'TRADE NAME','DOMESTIC PROFESSIONAL LIMITED LIABILITY COMPANY',
														  'DOMESTIC PROFESSIONAL PROFIT CORPORATION','DOMESTIC NONPROFIT CORPORATION',
														  'DOMESTIC LIMITED LIABILITY PARTNERSHIP','FORCED DBA',
														  'DOMESTIC LIMITED PARTNERSHIP','DOMESTIC CONSUMER COOPERATIVE',
														 	'DOMESTIC BENEFIT CORPORATION','CORRESPONDENCE'] 													   => 'D',
									 uc_ind in ['FOREIGN PROFIT CORPORATION','FOREIGN LIMITED LIABILITY COMPANY',
															'FOREIGN LIMITED PARTNERSHIP','FOREIGN PROFESSIONAL PROFIT CORPORATION',
															'FOREIGN NONPROFIT CORPORATION','FOREIGN LIMITED LIABILITY PARTNERSHIP',
															'FOREIGN PROFESSIONAL LIMITED LIABILITY COMPANY',
															'FOREIGN REGISTERED CORPORATE NAME'] 													               => 'F',
									 uc_ind  = ''                                                                            => '',
									 '**|'+uc_ind
								  );
		 END;
    
		//********************************************************************
		//Phone_No: cleans phone numbers and Returns a hyphenated 7 or 10 digit number 
		//********************************************************************	
		EXPORT PhoneNo(STRING Phone) := FUNCTION
      ph             := stringlib.stringfilterout(phone,')( - ');
			phone_number   := (INTEGER)ut.CleanPhone(ph); // we have first 3 digits are zeros in phones EX:0003456789 ,0000000000
			cln_phone_nmbr := if(phone_number <> 0, (string) phone_number, '');
			RETURN cln_phone_nmbr;
				
		END;
		
		//****************************************************************************
		//State_Description: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT State_Description(STRING s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'ARMED FORCES AMERICAS EXCEPT CANADA' => 'AA', 
											uc_s = 'ARMED FORCES EUROPE'                 => 'AE',
											uc_s = 'ARMED FORCES PACIFIC'                => 'AP',
											uc_s = 'ALABAMA'                             => 'AL',
											uc_s = 'ALASKA'                              => 'AK', 
											uc_s = 'ARKANSAS'                            => 'AR', 
											uc_s = 'AMERICAN SAMOA'                      => 'AS', 
											uc_s = 'ARIZONA'                             => 'AZ', 
											uc_s = 'CALIFORNIA'                          => 'CA', 
											uc_s = 'COLORADO'                            => 'CO', 
											uc_s = 'CONNECTICUT'                         => 'CT',          
											uc_s = 'DISTRICT OF COLUMBIA'                => 'DC', 
											uc_s = 'DELAWARE'                            => 'DE', 
											uc_s = 'FLORIDA'                             => 'FL', 
											uc_s = 'GEORGIA'                             => 'GA', 
											uc_s = 'GUAM'                                => 'GU', 
											uc_s = 'HAWAII'                              => 'HI', 
											uc_s = 'IOWA'                                => 'IA', 
											uc_s = 'IDAHO'                               => 'ID', 
											uc_s = 'ILLINOIS'                            => 'IL', 
											uc_s = 'INDIANA'                             => 'IN', 
											uc_s = 'KANSAS'                              => 'KS', 
											uc_s = 'KENTUCKY'                            => 'KY', 
											uc_s = 'LOUISIANA'                           => 'LA', 
											uc_s = 'MASSACHUSETTS'                       => 'MA', 
											uc_s = 'MARYLAND'                            => 'MD', 
											uc_s = 'MAINE'                               => 'ME', 
											uc_s = 'MICHIGAN'                            => 'MI', 
											uc_s = 'MINNESOTA'                           => 'MN', 
											uc_s = 'MISSOURI'                            => 'MO', 
											uc_s = 'MISSISSIPPI'                         => 'MS', 
											uc_s = 'MONTANA'                             => 'MT', 
											uc_s = 'NORTH CAROLINA'                      => 'NC', 
											uc_s = 'NORTH DAKOTA'                        => 'ND', 
											uc_s = 'NEBRASKA'                            => 'NE', 
											uc_s = 'NEW HAMPSHIRE'                       => 'NH', 
											uc_s = 'NEW JERSEY'                          => 'NJ', 
											uc_s = 'NEW MEXICO'                          => 'NM', 
											uc_s = 'NEVADA'                              => 'NV', 
											uc_s = 'NEW YORK'                            => 'NY', 
											uc_s = 'OHIO'                                => 'OH', 
											uc_s = 'OKLAHOMA'                            => 'OK', 
											uc_s = 'OREGON'                              => 'OR', 
											uc_s = 'PENNSYLVANIA'                        => 'PA', 
											uc_s = 'PUERTO RICO'                         => 'PR', 
											uc_s = 'RHODE ISLAND'                        => 'RI', 
											uc_s = 'SOUTH CAROLINA'                      => 'SC', 
											uc_s = 'SOUTH DAKOTA'                        => 'SD', 
											uc_s = 'TENNESSEE'                           => 'TN', 
											uc_s = 'TEXAS'                               => 'TX', 
											uc_s = 'UTAH'                                => 'UT', 
											uc_s = 'VIRGINIA'                            => 'VA', 
											uc_s = 'VIRGIN ISLANDS'                      => 'VI', 
											uc_s = 'VERMONT'                             => 'VT', 
											uc_s = 'WASHINGTON'                          => 'WA', 
											uc_s = 'WISCONSIN'                           => 'WI', 
											uc_s = 'WEST VIRGINIA'                       => 'WV', 
											uc_s = 'WYOMING'                             => 'WY',
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

END;
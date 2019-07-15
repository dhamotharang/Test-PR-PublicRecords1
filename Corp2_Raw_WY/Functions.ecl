IMPORT corp2, corp2_mapping, corp2_raw_wy, std, ut;

EXPORT Functions := MODULE

		//****************************************************************************
		//StateCodeTranslation: returns the us state description.
		//****************************************************************************
		EXPORT StateCodeTranslation(string s) := FUNCTION

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
		//StateDescriptionTranslation: returns the us state description.
		//****************************************************************************
		EXPORT StateDescriptionTranslation(string s) := FUNCTION

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
		//CountryCodeTranslation: returns the country description.
		//****************************************************************************
		EXPORT CountryCodeTranslation(string s) := FUNCTION

					 uc_s := corp2.t2u(s);

					 RETURN MAP(uc_s = 'AD'				=> 'ARUBA',
										  uc_s = 'AU'				=> 'AUSTRALIA',
										  uc_s = 'BC'				=> 'BRITISH COLUMBIA',
										  uc_s = 'BE'				=> 'BELGIUM',
										  uc_s = 'BI'				=> 'BAHAMAS',
											uc_s = 'BM'       => 'BERMUDA',
										  uc_s = 'CO'				=> 'COLOMBIA',
											uc_s = 'DK'				=> 'DENMARK',
										  uc_s = 'EC'				=> 'ECUADOR',
										  uc_s = 'EN'				=> 'ENGLAND',
										  uc_s = 'FC'				=> 'FEDERATED CHARTERED',
										  uc_s = 'FR'				=> 'FRANCE',
										  uc_s = 'GE'				=> 'GERMANY',
										  uc_s = 'GG'				=> 'GUERNSEY',
										  uc_s = 'ON'				=> 'ONTARIO, CANADA',
										  uc_s = 'HK'				=> 'HONG KONG',
										  uc_s = 'IN'				=> 'INDIA',
										  uc_s = 'IT'				=> 'ITALY',
										  uc_s = 'JA'				=> 'JAPAN',
											uc_s = 'KN'				=> 'ST. KITTS AND NEVIS',
										  uc_s = 'KO'				=> 'KOREA',
										  uc_s = 'LI'				=> 'LIECHTENSTEIN',
										  uc_s = 'LU'				=> 'LUXEMBOURG',
											uc_s = 'MX'				=> 'MEXICO',
										  uc_s = 'NA'				=> 'NETHERLANDS ANTILLES',
										  uc_s = 'NC'				=> 'CANADA',
										  uc_s = 'PG'				=> 'PARAGUAY',
											uc_s = 'PH'				=> 'PHILIPPINES',
										  uc_s = 'RP'				=> 'PANAMA',
										  uc_s = 'SL'				=> 'SCOTLAND',
										  uc_s = 'SW'				=> 'SWITZERLAND',
										  uc_s = 'TC'				=> 'TURKS AND CAICOS ISLANDS',
										  uc_s = 'UK'				=> 'UNITED KINGDON',
										  uc_s = 'UR'				=> 'URAGUAY',
										  uc_s = 'US'				=> '',
											uc_s = 'VG'				=> 'VIRGIN ISLANDS, BRITISH',
										  uc_s = 'WN'				=> 'BRITISH WEST INDIES',
											uc_s = 'ZA'   		=> 'SOUTH AFRICA',
											uc_s = ''   			=> '',
											'**|'+uc_s
										);			
		END;
		
		//****************************************************************************
		//CountryDescriptionTranslation: returns the country description.
		//****************************************************************************
		EXPORT CountryDescriptionTranslation(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
					 RETURN MAP(uc_s = 'ARUBA'                                           => 'AD',
										  uc_s = 'AUSTRALIA'                                       => 'AU',
										  uc_s = 'BAHAMAS'                                         => 'BI',
										  uc_s = 'BELGIUM'																				 => 'BE',
											uc_s = 'BERMUDA'																				 => 'BM',
										  uc_s = 'BRITISH COLUMBIA'                                => 'BC',
										  uc_s = 'BRITISH WEST INDIES'                             => 'WN',
										  uc_s = 'COLOMBIA'																				 => 'CO',
											uc_s = 'DENMARK'																				 => 'DK',
										  uc_s = 'ECUADOR'                                         => 'EC',
										  uc_s = 'ENGLAND'                                         => 'EN',
										  uc_s = 'FEDERAL CHARTER'       			                     => 'FC',
										  uc_s = 'FEDERATED CHARTERED'                             => 'FC',									
										  uc_s = 'FRANCE'                                          => 'FR',
										  uc_s = 'GERMANY'                                         => 'GE',
										  uc_s = 'GUERNSEY'                                        => 'GG',
										  uc_s = 'ONTARIO, CANADA'                                 => 'ON',
										  uc_s = 'HONG KONG'                                       => 'HK',
										  uc_s = 'HONG KONG SAR'                                   => 'HK',										
										  uc_s = 'INDIA'                                           => 'IN',
										  uc_s = 'ITALY'                                           => 'IT',
										  uc_s = 'JAPAN'                                           => 'JA',
										  uc_s = 'KOREA'                                           => 'KO',
										  uc_s = 'LIECHTENSTEIN'                                   => 'LI',
										  uc_s = 'LUXEMBOURG'                                      => 'LU',
											uc_s = 'MEXICO'																					 => 'MX',											
										  uc_s = 'NETHERLANDS ANTILLES'                            => 'NA',
										  uc_s = 'CANADA'                                          => 'NC',
										  uc_s = 'PARAGUAY'                                        => 'PG',
										  uc_s = 'PANAMA'                                          => 'RP',
											uc_s = 'PHILIPPINES'																		 => 'PH',
											uc_s = 'ST. KITTS AND NEVIS'														 => 'KN',											
										  uc_s = 'SCOTLAND'                                        => 'SL',
											uc_s = 'SOUTH AFRICA'																		 => 'ZA',
										  uc_s = 'SWITZERLAND'                                     => 'SW',
											uc_s = 'TRIBAL'																					 => '',
										  uc_s = 'TURKS AND CAICOS ISLANDS'                        => 'TC',
										  uc_s = 'UNITED KINGDON'                                  => 'UK',
										  uc_s = 'UNITED KINGDOM'                                  => 'UK',											
										  uc_s = 'UNITED STATES'                                   => '',
										  uc_s = 'URUGUAY'                                         => 'UR',											
											uc_s = 'UNITED ARAB EMIRATES'														 => 'AE',
											uc_s = 'US'                                              => '',
										  uc_s = 'USA'                                             => '',
											uc_s = 'VIRGIN ISLANDS, BRITISH'												 => 'VG',
											uc_s = ''   																						 => '',											
											'**|'+uc_s
										);			
		END;
                                                      
		//********************************************************************
		//CorpForgnStateCD: Returns "corp_forgn_state_cd".
		//********************************************************************	
		EXPORT CorpForgnStateCD(STRING s) := FUNCTION

					 uc_s  				 := corp2.t2u(s);
					 knownbadcodes := ['N'];
					 
					 fixed_s 	:= MAP(uc_s = 'NEW HAMSHIRE' => 'NEW HAMPSHIRE',
													 uc_s in knownbadcodes => '',
													 uc_s
													);

					 RETURN MAP(StateDescriptionTranslation(fixed_s)[1..2] 		<>'**' => StateDescriptionTranslation(fixed_s),
											CountryDescriptionTranslation(fixed_s)[1..2]	<>'**' => CountryDescriptionTranslation(fixed_s),
											'**|'+fixed_s
										 );

			END;

		//********************************************************************
		//CorpForgnStateDesc: Returns "corp_forgn_state_desc".
		//********************************************************************	
		EXPORT CorpForgnStateDesc(STRING s) := FUNCTION

					 uc_s  := corp2.t2u(s);
					 knownbadcodes := ['N'];

					 fixed_s 	:= MAP(uc_s = 'NEW HAMSHIRE' => 'NEW HAMPSHIRE',
													 uc_s in knownbadcodes => '',					 
													 uc_s in ['US','USA']	 =>	'',					
													 uc_s
													);

					 RETURN MAP(StateDescriptionTranslation(fixed_s)[1..2] 		<>'**' => fixed_s,
											CountryDescriptionTranslation(fixed_s)[1..2]	<>'**' => fixed_s,
											'**|'+fixed_s
										 );
			END;
			
		//********************************************************************
		//CorpTermExistExp: Returns "corp_term_exist_exp".
		//********************************************************************	
		EXPORT CorpTermExistExp(STRING code, STRING typ, STRING dt) := FUNCTION

					 uc_code  := corp2.t2u(code);
					 uc_typ	  := corp2.t2u(typ);
					 uc_dt	  := corp2.t2u(dt);

					 RETURN  map(code = 'N' and uc_typ = 'EXPIRES - 30 YEARS' => '30',
											 code = 'N' and uc_typ = 'EXPIRES - 50 YEARS' => '50',
											 code = 'N' and uc_typ = 'EXPIRES - 99 YEARS' => '99',
											 code = 'D'  																  => Corp2_Mapping.fValidateDate(uc_dt,'MM/DD/CCYY').GeneralDate,
											 ''
											);
											
			END;
			
		//********************************************************************
		//CorpRAAddlInfo: Returns "corp_ra_addl_info".
		//********************************************************************	
		EXPORT CorpRAAddlInfo(STRING county, STRING ra, STRING orgname) := FUNCTION

					 uc_county  := corp2.t2u(county);
					 uc_ra	  	:= corp2.t2u(ra);
					 uc_orgname	:= corp2.t2u(orgname);

					 addl_info1 := if(uc_county 	not in [''],'AGENT COUNTY: ' + uc_county,'');
					 addl_info2 := if(uc_ra 			not in [''],'REGISTERED AGENT STANDING: '+uc_ra,'');			
					 addl_info3 := if(uc_orgname 	not in ['','NO AGENT'],'AGENT ORGANIZATION NAME: '+uc_orgname,'');			

					 addlinfo 	:= if(corp2.t2u(addl_info1)<>'',corp2.t2u(addl_info1)+';','')+
												 if(corp2.t2u(addl_info2)<>'',corp2.t2u(addl_info2)+';','')+  
												 if(corp2.t2u(addl_info3)<>'',corp2.t2u(addl_info3)+';','');

					 return regexreplace('\\;$',addlinfo,'');

		END;			

		//****************************************************************************
		//ContFullName: returns the "cont_full_name"
		//
		//NOTE: Checks to see if the data within the input parm contains invalid names
		//			and if only one character in length.
		//****************************************************************************
		EXPORT ContFullName(STRING stateorigin, STRING statedesc, STRING pname) := FUNCTION

				   uc_stateorigin 	  := corp2.t2u(stateorigin);
				   uc_statedesc 	  	:= corp2.t2u(statedesc);
				   uc_pname  					:= corp2.t2u(pname);
					 
					 name								:= if(length(uc_pname)=1,'',uc_pname);
					 invalid_words1			:= ['ABOVE','ABOVE AND','ABOVE PLUS','SAME AS ABOVE','AS ABOVE'];
					 invalid_words2			:= ['SEE FILE','SEE FICHE','SEE AR FICHE','SEE A/R','SEE ANNUAL REPORT','SEE ATTACHED'];
					 invalid_words3			:= ['AS PRES','AS SECR','AS VP','AS SEC','AS SECRETARY'];
					 invalid_words4			:= ['LIST ON FILE WITH SECRETARY OF STATE'];
					 
					 result_name				:= map(name in [invalid_words1,invalid_words2,invalid_words3,invalid_words4] 					=> '',
																		 regexfind('^SAME$|^NO AGENT$|^ET.AL$|^JR,MD$|^MD$|^III$|^VACANT$',name,0)<>''	=> '',
																		 name
																	 );
										 
					 RETURN Corp2_Mapping.fCleanBusinessName(uc_stateorigin,uc_statedesc,result_name).BusinessName;
										 
		END;
		
		//****************************************************************************
		//Addr1: returns the "addr1"
		//****************************************************************************
		EXPORT Addr1(STRING state_origin, STRING state_desc, STRING addr1, STRING addr2, STRING addr3, STRING city, STRING state, STRING zip) := FUNCTION

					 uc_addr1				:= corp2.t2u(addr1);
					 uc_addr2				:= corp2.t2u(addr2);
					 uc_addr3				:= corp2.t2u(addr3);
					 uc_city				:= corp2.t2u(city);
					 uc_state				:= corp2.t2u(state);
					 uc_zip					:= corp2.t2u(zip);
					
					 fullAddress		:= corp2.t2u(stringlib.stringfilterout(uc_addr1+' '+uc_addr2+' '+uc_addr3,'.,-'));
					 tempaddr				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,uc_addr1+' '+uc_addr2+' '+uc_addr3,,uc_city,uc_state,uc_zip).AddressLine2;	
					 
					 RETURN if(uc_city = '',uc_addr1,stringlib.stringfindreplace(fullAddress,corp2.t2u(stringlib.stringfilterout(tempaddr,'.,')),''));	

		END;
		
		//****************************************************************************
		//City: returns the "city"
		//****************************************************************************
		EXPORT City(STRING state_origin, STRING state_desc, STRING addr1, STRING addr2, STRING addr3, STRING lastname, STRING middlename) := FUNCTION

					 uc_lastname		:= corp2.t2u(lastname);
					 uc_middlename	:= corp2.t2u(middlename);					 
					 uc_addr1				:= corp2.t2u(addr1);
					 uc_addr2				:= corp2.t2u(addr2);
					 uc_addr3				:= corp2.t2u(addr3);
					
					 fullAddress		:= corp2.t2u(stringlib.stringfilterout(uc_addr1+' '+uc_addr2+' '+uc_addr3,'.,-'));					 

					 RETURN if(uc_lastname = state_origin,uc_middlename,Corp2_Mapping.fCleanCity(state_origin,state_desc,,fullAddress,'').City);

		END;
		
		//****************************************************************************
		//State: returns the "state"
		//****************************************************************************
		EXPORT State(STRING state_origin, STRING state_desc, STRING addr1, STRING addr2, STRING addr3, STRING lastname) := FUNCTION

					 uc_lastname			:= corp2.t2u(lastname);
					 uc_addr1					:= corp2.t2u(addr1);
					 uc_addr2					:= corp2.t2u(addr2);
					 uc_addr3					:= corp2.t2u(addr3);
				 	
					 fullAddress			:= corp2.t2u(stringlib.stringfilterout(uc_addr1+' '+uc_addr2+' '+uc_addr3,'.,-'));
					 nowordsinaddr		:= stringlib.stringwordcount(fullAddress);	
					 getlastword			:= stringlib.stringgetnthword(fullAddress,nowordsinaddr);
					 state			 			:= if(uc_lastname = state_origin,uc_lastname,Corp2_Mapping.fCleanState(state_origin,state_desc,,fullAddress).State);

					 RETURN if(fullAddress <> '' and state = ''
									  ,if(StateCodeTranslation(getlastword)[1..2]<>'**' and length(getlastword) = 2
											 ,getlastword
											 ,''
											 )
									  ,if(StateCodeTranslation(state)[1..2]<>'**' and length(state) = 2
											 ,state
											 ,''
											 )
									  );		
		END;
		
		
		//****************************************************************************
		//StockSharesIssued: returns the "stock_shares_issued"
		//****************************************************************************
		EXPORT StockSharesIssued(STRING s) := FUNCTION

		  uc_s := corp2.t2u(s);
			
			RETURN map( stringlib.stringfind(uc_s,'NONE',1) 		 			<> 0 => '',
									stringlib.stringfind(uc_s,'-',1) 		 					<> 0 => '',
									stringlib.stringfind(uc_s,'UNLIMIT',1)  			<> 0 => 'UNLIMITED',
									stringlib.stringfind(uc_s,'UNLMITED',1)  			<> 0 => 'UNLIMITED',
									stringlib.stringfind(uc_s,'UNLIMTIED',1)  		<> 0 => 'UNLIMITED',
									stringlib.stringfind(uc_s,'ULIMITED',1)  			<> 0 => 'UNLIMITED',
									stringlib.stringfind(uc_s,'UMLIMITED',1)  		<> 0 => 'UNLIMITED',
									stringlib.stringfind(uc_s,'UNIMITED',1)  			<> 0 => 'UNLIMITED',
									stringlib.stringfind(uc_s,'UNLIMINTED',1) 		<> 0 => 'UNLIMITED',
									stringlib.stringfind(uc_s,'UNLIMTED',1)	 			<> 0 => 'UNLIMITED',
									stringlib.stringfind(uc_s,'UNLMIMTED',1)	 		<> 0 => 'UNLIMITED',
									stringlib.stringfind(uc_s,'SEEFILE',1) 				<> 0 => 'SEE FILE',
									stringlib.stringfind(uc_s,'SEENOTES',1) 			<> 0 => 'SEE NOTES',
									stringlib.stringfind(uc_s,'SEEPUBLICNOTES',1) <> 0 => 'SEE PUBLIC NOTES',
									stringlib.stringfind(uc_s,'SEEPUBLICNOTE',1)  <> 0 => 'SEE PUBLIC NOTE',
									uc_s
								);
		END;
		
		//"find_SpecialChars" function returns "FOUND" verbiage when corp legal names consists foreign characters
		EXPORT find_SpecialChars(string C) := function
		
     S            := corp2.t2u(c);  
		 ForeignChars	:= if(REGEXFIND('Ý', S) OR REGEXFIND('Ü', S) OR REGEXFIND('Û', S) OR REGEXFIND('Ú', S) OR 
												REGEXFIND('Ù', S) OR REGEXFIND('Ö',	S) OR REGEXFIND('Õ', S) OR REGEXFIND('Ô', S) OR
												REGEXFIND('Ó', S) OR REGEXFIND('Ò',	S) OR REGEXFIND('Ñ', S) OR REGEXFIND('Ï', S) OR
												REGEXFIND('Î', S) OR REGEXFIND('Í',	S) OR REGEXFIND('Ì', S) OR REGEXFIND('Ë', S) OR
												REGEXFIND('Ê', S) OR REGEXFIND('É',	S) OR REGEXFIND('È', S) OR REGEXFIND('Å', S) OR
												REGEXFIND('Ä', S) OR REGEXFIND('Ã',	S) OR REGEXFIND('Â', S) OR REGEXFIND('Á', S) OR
												REGEXFIND('À', S) OR REGEXFIND('À', S) OR REGEXFIND('Á', S) OR REGEXFIND('Â', S) OR				
												REGEXFIND('Ã', S) OR REGEXFIND('Ä', S) OR REGEXFIND('Å', S) OR REGEXFIND('È', S) OR 
												REGEXFIND('É', S) OR REGEXFIND('Ê', S) OR REGEXFIND('Ë', S) OR REGEXFIND('Ì', S) OR 
												REGEXFIND('Í', S) OR REGEXFIND('Î', S) OR REGEXFIND('Ï', S) OR REGEXFIND('Ñ', S) OR 
												REGEXFIND('Ò', S) OR REGEXFIND('Ó', S) OR REGEXFIND('Ô', S) OR REGEXFIND('Õ', S) OR 
												REGEXFIND('Ö', S) OR REGEXFIND('Ù', S) OR REGEXFIND('Ú', S) OR REGEXFIND('Û', S) OR 
												REGEXFIND('Ü', S) OR REGEXFIND('Ý', S), 'FOUND', 'NOTFOUND'
											 );
			
	    return ForeignChars;
																	
		end;
		
		//"fix_ForeignChar" function returns WY state-site matching leagal name after replacing "foreign character patterns" with match "sate site character patterns"
		//Ex: From raw vendor input "PAPÃ© D.W., INC." TO	'PAPÉ D.W., INC.'
		EXPORT fix_ForeignChar(STRING s) := FUNCTION

		  uc_s  := corp2.t2u(s);
		  l_name:= map( regexfind('ÃŒ', uc_s, 0)      <> ''=>regexreplace('ÃŒ', uc_s, 'Ü'),
										regexfind('Â©', uc_s, 0)      <> ''=>regexreplace('Â©', uc_s, 'É'),
										regexfind('Ã¤', uc_s, 0)      <> ''=>regexreplace('Ã¤', uc_s, 'Ä'),
										regexfind('Ã¨', uc_s, 0) 		  <> ''=>regexreplace('Ã¨', uc_s, 'È'),
										regexfind('Ã£O', uc_s, 0)     <> ''=>regexreplace('Ã£O', uc_s, 'Ã'),
										regexfind('Ã§Ã£O', uc_s, 0)   <> ''=>regexreplace('Ã§Ã£O', uc_s, 'Ã'),
										regexfind('Ã¶', uc_s, 0) 		  <> ''=>regexreplace('Ã¶', uc_s, 'Ö'),																
										regexfind('Ã³', uc_s, 0) 		  <> ''=>regexreplace('Ã³', uc_s, 'Ó'),																
										regexfind('Ã©', uc_s, 0) 		  <> ''=>regexreplace('Ã©', uc_s, 'É'),	
										regexfind('Ã‰', uc_s, 0) 		  <> ''=>regexreplace('Ã‰', uc_s, 'É'),	
										regexfind('Ã±', uc_s, 0) 		  <> ''=>regexreplace('Ã±', uc_s, 'Ñ'),
										regexfind('Ã³', uc_s, 0) 		  <> ''=>regexreplace('Ã³', uc_s, 'Ó'),
										regexfind('Ä', uc_s, 0) 		  <> ''=>regexreplace('Ä', uc_s, '?'),
										regexfind('Ã£', uc_s, 0) 		  <> ''=>regexreplace('Ã£', uc_s, 'Ã'),
										regexfind('Ã¼', uc_s, 0) 		  <> ''=>regexreplace('Ã¼', uc_s, 'Ü'),
										regexfind('Ã–', uc_s, 0) 		  <> ''=>regexreplace('Ã–', uc_s, 'Ö'),
										regexfind('Ã', uc_s, 0) 		  <> ''=>regexreplace('Ã', uc_s, 'Á'),
										regexfind('Ãª', uc_s, 0) 		  <> ''=>regexreplace('Ãª'	, uc_s, 'Ê'),
										regexfind('Ãº', uc_s, 0) 		  <> ''=>regexreplace('Ãº', uc_s, 'Ú'),
										regexfind('Ã“', uc_s, 0) 		  <> ''=>regexreplace('Ã“', uc_s, 'Ó'),
										regexfind('Ã‰', uc_s, 0) 		  <> ''=>regexreplace('Ã‰', uc_s, 'É'),
										regexfind('Â”Œ', uc_s, 0) 	  <> ''=>regexreplace('Â”Œ', uc_s, '?'),
										regexfind('Ã«', uc_s, 0) 		  <> ''=>regexreplace('Ã«', uc_s, 'Ë'),
										regexfind('Â¡', uc_s, 0)      <> ''=>regexreplace('Â¡', uc_s, ''),
										regexfind('Â¢', uc_s, 0)      <> ''=>regexreplace('Â¢', uc_s, ''),
										regexfind('Â€¢', uc_s, 0) 	  <> ''=>regexreplace('Â€¢', uc_s, ''),
										regexfind('Â', uc_s, 0)       <> ''=>regexreplace('Â', uc_s, ''), 
										regexfind('©', uc_s, 0)   	  <> ''=>regexreplace('©', uc_s, ''),
										regexfind('Â€™S', uc_s, 0)    <> ''=>regexreplace('Â€™S', uc_s, ''),
										uc_s);
									
				return ut.fn_RemoveSpecialChars((string)Std.Uni.CleanAccents(l_name))	;
				
   	END;
		
END;
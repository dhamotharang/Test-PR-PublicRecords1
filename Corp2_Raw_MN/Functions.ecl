IMPORT corp2, corp2_mapping, corp2_raw_mn;

EXPORT Functions := Module

		//****************************************************************************
		//Valid_US_State: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT Valid_US_State(string s) := FUNCTION
					 RETURN map (corp2.t2u(s) in ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA',
																						  'GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA',
																						  'MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND',
																						  'MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT',
																						  'VT','VI','VA','WA','WV','WI','WY','AE','AP','AA','CZ',''] => true,false);
		END;

		//****************************************************************************
		//State_Codes: returns the state code.
		//****************************************************************************
		EXPORT State_Codes(string s) := FUNCTION
					 
					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'ALABAMA' 							=> 'AL',
											uc_s = 'ALASKA' 							=> 'AK', 
											uc_s = 'ARKANSAS' 						=> 'AR', 
											uc_s = 'AMERICAN SAMOA' 			=> 'AS', 
											uc_s = 'ARIZONA' 							=> 'AZ', 
											uc_s = 'CALIFORNIA' 					=> 'CA', 
											uc_s = 'COLORADO' 						=> 'CO', 
											uc_s = 'CONNECTICUT' 					=> 'CT', 
											uc_s = 'DISTRICT OF COLUMBIA' => 'DC', 
											uc_s = 'DELAWARE' 						=> 'DE', 
											uc_s = 'FLORIDA' 							=> 'FL', 
											uc_s = 'GEORGIA' 							=> 'GA', 
											uc_s = 'GUAM' 								=> 'GU', 
											uc_s = 'HAWAII' 							=> 'HI', 
											uc_s = 'IOWA' 								=> 'IA', 
											uc_s = 'IDAHO' 								=> 'ID', 
											uc_s = 'ILLINOIS' 						=> 'IL', 
											uc_s = 'INDIANA'	 						=> 'IN', 
											uc_s = 'KANSAS' 							=> 'KS', 
											uc_s = 'KENTUCKY' 						=> 'KY', 
											uc_s = 'LOUISIANA' 						=> 'LA', 
											uc_s = 'MASSACHUSETTS' 				=> 'MA', 
											uc_s = 'MARYLAND'							=> 'MD', 
											uc_s = 'MAINE' 								=> 'ME', 
											uc_s = 'MICHIGAN' 						=> 'MI', 
											uc_s = 'MINNESOTA' 						=> 'MN', 
											uc_s = 'MISSOURI' 						=> 'MO', 
											uc_s = 'MISSISSIPPI' 					=> 'MS', 
											uc_s = 'MONTANA' 							=> 'MT', 
											uc_s = 'NORTH CAROLINA' 			=> 'NC', 
											uc_s = 'NORTH DAKOTA' 				=> 'ND', 
											uc_s = 'NEBRASKA' 						=> 'NE', 
											uc_s = 'NEW HAMPSHIRE' 				=> 'NH', 
											uc_s = 'NEW JERSEY' 					=> 'NJ', 
											uc_s = 'NEW MEXICO' 					=> 'NM', 
											uc_s = 'NEVADA' 							=> 'NV', 
											uc_s = 'NEW YORK' 						=> 'NY', 
											uc_s = 'OHIO' 								=> 'OH', 
											uc_s = 'OKLAHOMA' 						=> 'OK', 
											uc_s = 'OREGON' 							=> 'OR', 
											uc_s = 'PENNSYLVANIA' 				=> 'PA', 
											uc_s = 'PUERTO RICO'					=> 'PR', 
											uc_s = 'RHODE ISLAND' 				=> 'RI', 
											uc_s = 'SOUTH CAROLINA' 			=> 'SC', 
											uc_s = 'SOUTH DAKOTA'		 			=> 'SD', 
											uc_s = 'TENNESSEE' 						=> 'TN', 
											uc_s = 'TEXAS' 								=> 'TX', 
											uc_s = 'UNITED STATES' 				=> 'US', 
											uc_s = 'UTAH' 								=> 'UT', 
											uc_s = 'VIRGINIA' 						=> 'VA', 
											uc_s = 'VIRGIN ISLAND'				=> 'VI',
											uc_s = 'VIRGIN ISLANDS' 			=> 'VI',		
											uc_s = 'VERMONT' 							=> 'VT', 
											uc_s = 'WASHINGTON' 					=> 'WA', 
											uc_s = 'WISCONSIN' 						=> 'WI', 
											uc_s = 'WEST VIRGINIA' 				=> 'WV', 
											uc_s = 'WYOMING' 							=> 'WY',
											''
										 );
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
		//Country_Description: returns the country based upon the input.  The codes
		//										 left blank are unknown.
		//****************************************************************************
		EXPORT Country_Description(string s) := FUNCTION
					 
					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(
											uc_s = 'ANAMBRA-NIGERIA'												  => uc_s,
											uc_s = 'BANGLADESH'															  => uc_s,                                               
											uc_s = 'BARBADOS'																  => uc_s,                                                 
											uc_s = 'BELGIUM'																  => uc_s,                                                  
											uc_s = 'BELIZE'																	  => uc_s,                                                   
											uc_s = 'BERMUDA'																  => uc_s,                                                  
											uc_s = 'CANADA'																	  => uc_s,                                                   
											uc_s = 'CAYMAN ISLANDS'													  => uc_s,                                           
											uc_s = 'CHINA'																	  => uc_s,                                                    
											uc_s = 'COLOMBIA'																  => uc_s,                                                 
											uc_s = 'COMMONWEALTH OF THE BAHAMAS'						  => uc_s,                              
											uc_s = 'COSTA RICA'															  => uc_s,                                               
											uc_s = 'CURACAO'																  => uc_s,                                                  
											uc_s = 'ECUADOR'																  => uc_s,                                                 
											uc_s = 'ENGLAND'																  => uc_s,
											uc_s = 'ENGLAND AND WALES'											  => uc_s,                                        
											uc_s = 'ETHIOPIA'																  => uc_s,                                                 
											uc_s = 'GERMANY'																  => uc_s,                                                  
											uc_s = 'GHANA'																	  => uc_s,                                                    
											uc_s = 'GUATEMALA'															  => uc_s,                                                
											uc_s = 'HO CHUNK NATION'												  => uc_s,                                         
											uc_s = 'HONDURAS'																  => uc_s,                                                 
											uc_s = 'HONG KONG'															  => uc_s,                                                
											uc_s = 'INDIA'																	  => uc_s,                                                    
											uc_s = 'IRELAND'																  => uc_s,                                                  
											uc_s = 'ISRAEL'																	  => uc_s,                                                   
											uc_s = 'ITALY'																	  => uc_s,                                                    
											uc_s = 'JAMAICA'																  => uc_s,                                                  
											uc_s = 'JAPAN'																	  => uc_s,                                                    
											uc_s = 'KENYA'																	  => uc_s,                                                    
											uc_s = 'KUWAIT'																	  => uc_s,                                                   
											uc_s = 'LATVIA'																	  => uc_s,                                                   
											uc_s = 'LIBERIA'																  => uc_s,                                                  
											uc_s = 'LOWER SIOUX INDIAN COMMUNITY'						  => uc_s,                             
											uc_s = 'LUXEMBOURG'															  => uc_s,                                               
											uc_s = 'MALAWI'																	  => uc_s,                                                   
											uc_s = 'MALAYSIA'																  => uc_s,                                                 
											uc_s = 'MARSHALL ISLANDS'												  => uc_s,                                         
											uc_s = 'MEXICO'																	  => uc_s,                                                  
											uc_s = 'MILLE LACS BAND OF OJIBWE'							  => uc_s,                                
											uc_s = 'MISSISSAUGA ONTARIO'										  => uc_s,                                      
											uc_s = 'NEPAL'																	  => uc_s,                                                    
											uc_s = 'NETHERLANDS'														  => uc_s,                                              
											uc_s = 'NEW ZEALAND'														  => uc_s,                                              
											uc_s = 'NIGERI'																	  => uc_s,                                                  
											uc_s = 'NORWAY'																	  => uc_s,                                                   
											uc_s = 'NOVA SCOTIA'														  => uc_s,                                              
											uc_s = 'ONEIDA TRIBE OF INDIANS OF WISCONSIN'		  => uc_s,                     
											uc_s = 'PERU'																		  => uc_s,                                                     
											uc_s = 'PHILIPPINES'														  => uc_s,                                              
											uc_s = 'RED LAKE BAND OF CHIPPEWA INDIANS'			  => uc_s,                        
											uc_s = 'REPUBLIC OF PANAMA'												=> uc_s,                                       
											uc_s = 'REPUBLIC OF SEYCHELLES'										=> uc_s,                                   
											uc_s = 'SAC & FOX NATION'													=> uc_s,                                         
											uc_s = 'SAUDI ARABIA'															=> uc_s,                                            
											uc_s = 'SCOTLAND'																	=> uc_s,                                                
											uc_s = 'SHAKOPEE MDEWAKANTON SIOUX COMMUNITY'			=> uc_s,                     
											uc_s = 'SINGAPORE'																=> uc_s,                                                
											uc_s = 'SISSETON WAHPETON SIOUX TRIBE'						=> uc_s,                            
											uc_s = 'SLOVENIA'																	=> uc_s,                                                 
											uc_s = 'SOMALIA'																	=> uc_s,                                                  
											uc_s = 'SOUTH KOREA'															=> uc_s,                                              
											uc_s = 'SPAIN'																		=> uc_s,                                                   
											uc_s = 'SRI LANKA'																=> uc_s,                                                
											uc_s = 'SWEDEN'																		=> uc_s,                                                  
											uc_s = 'SWITZERLAND'															=> uc_s,                                              
											uc_s = 'TANZANIA'																	=> uc_s,                                                 
											uc_s = 'THAILAND'																	=> uc_s,                                                 
											uc_s = 'TURKEY'																		=> uc_s,                                                   
											uc_s = 'TURKS AND CAICOS ISLANDS'									=> uc_s,                                 
											uc_s = 'UNITED ARAB EMIRATES'											=> uc_s,                                     
											uc_s = 'UNITED KINGDOM'														=> uc_s,                                           
											uc_s = 'URUGUAY'																	=> uc_s,                                                  
											uc_s = 'VIETNAM'																	=> uc_s,
											uc_s = 'VIRGIN ISLANDS OF THE UNITED STATES'			=> uc_s,                      
											uc_s = 'WEST AFRICA'															=> uc_s,                                              
											uc_s = 'WEST INDIES'															=> uc_s,                                              
											uc_s = 'WHITE EARTH BAND OF OJIBWE'								=> uc_s,                               
											uc_s = 'WHITE EARTH INDIAN RESERVATION'						=> uc_s,                           
											'**|'+uc_s
											);
		END;
		
		//****************************************************************************
		//State_or_Country: returns the "state or country".
		//****************************************************************************
		EXPORT State_or_Country(STRING s) := FUNCTION
		
					 invalidWords					:= 'US|UNITED STATES|UNKNOWN';
						
					 uc_s 								:= corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 wc_by_comma		 			:= if(count(stringlib.splitwords(uc_s,',',false)) > 1,count(stringlib.splitwords(uc_s,',',false)),0);	//Get word count by comma
					 addr_parts_by_comma 	:= if(wc_by_comma<>0,stringlib.splitwords(uc_s,',',false),['']);																			//Split address by comma

					 state_or_country 		:= 	map(State_Codes(uc_s)[1..2]   					<> '**' => uc_s,
																				State_Description(uc_s)[1..2]   		<> '**' => State_Description(uc_s),
																				regexfind(invalidWords,uc_s,0) 			<> '' 	=> '',
																				wc_by_comma						 							<> 0		=> addr_parts_by_comma[wc_by_comma],
																				Country_Description(uc_s)[1..2]   	<> '**' => uc_s,
																				'**|'+uc_s
																			 );

					 RETURN state_or_country;

		END;		
		
		//****************************************************************************
		//AddressTypeCode: returns the "Address Type Code".
		//****************************************************************************
		EXPORT AddressTypeCode(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN MAP(uc_s = '2'		=> uc_s,
											uc_s = '4' 	 	=> uc_s,
											uc_s = '5' 	 	=> uc_s,
											uc_s = '7' 	 	=> uc_s,
											uc_s = '8' 	 	=> uc_s,
											uc_s = '9' 	 	=> uc_s,
											uc_s = '11' 	=> uc_s,
											uc_s = '16' 	=> uc_s,
											uc_s = '18' 	=> uc_s,
											uc_s = '9999' => uc_s,
											''
										 );
				END;
				
		//****************************************************************************
		//AddressTypeDesc: returns the "Address Type Description".
		//****************************************************************************
		EXPORT AddressTypeDesc(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN MAP(uc_s = '2'		=> 'BUSINESS',
											uc_s = '3' 		=> 'REGISTERED OFFICE',
											uc_s = '4' 		=> 'HOME OFFICE',
											uc_s = '5' 		=> 'PRINCIPAL OFFICE',
											uc_s = '6' 	 	=> 'CONTACT ADDRESS',
											uc_s = '7' 	 	=> 'BUSINESS',
											uc_s = '8' 	 	=> 'DESIGNATED OFFICE',
											uc_s = '9' 	 	=> 'PROCESS',
											uc_s = '11' 	=> 'MAILING',
											uc_s = '14' 	=> 'CONTACT ADDRESS',
											uc_s = '16' 	=> 'PRINCIPAL OFFICE MAILING',
											uc_s = '17' 	=> 'CONTACT ADDRESS',
											uc_s = '18' 	=> 'DESIGNATED OFFICE MAILING',
											uc_s = '19' 	=> 'REGISTERED AGENT MAILING ADDRESS',
											uc_s = '21' 	=> 'REGISTERED OFFICE',
											uc_s = '204'  => 'REGISTERED OFFICE',							 
											uc_s = '9999' => 'MAILING',
											''
										 );
		END;

		//****************************************************************************
		//ContTitle1Desc: returns the "cont_title1_desc".
		//****************************************************************************
		EXPORT ContTitle1Desc(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN MAP(
											uc_s ='1'			=>'NAMEHOLDER',
											uc_s ='2'			=>'MARKHOLDER',
											uc_s ='3'			=>'TRUSTEE',
											uc_s ='5'			=>'FIRST BOARD OF DIRECTORS',
											uc_s ='6'			=>'GENERAL PARTNER',
											uc_s ='7'			=>'ORGANIZER',
											uc_s ='8'			=>'INCORPORATOR',
											uc_s ='9'			=>'BUSINESS CONTACT',
											uc_s ='11'		=>'FILING CONTACT',
											uc_s ='12'		=>'PRESIDENT',
											uc_s ='13'		=>'MANAGER',
											uc_s ='14'		=>'CHIEF EXECUTIVE OFFICER',
											uc_s ='15'		=>'VICE PRESIDENT',
											uc_s ='16'		=>'SECRETARY',
											uc_s ='17'		=>'TREASURER',
											uc_s ='18'		=>'SIGNATOR',
											''
										 ); 
		END;

		//****************************************************************************
		//ContTypeDesc: returns the "cont_type_desc".
		//****************************************************************************
		EXPORT ContTypeDesc(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN MAP(uc_s in ['1','2']												=>'OWNER',
											uc_s in ['3','5','7','8','9','11','18']	=>'CONTACT',
											uc_s in ['6','13']											=>'MEMBER/MANAGER/PARTNER',
											uc_s in ['12','14','15','16','17']			=>'OFFICER',
											''
										); 
		END;

		//****************************************************************************
		//CorpAddlInfo: returns the "corp_addl_info".
		//****************************************************************************
		EXPORT CorpAddlInfo(STRING mark1stuseddt,STRING marklogo) := FUNCTION
					 mark_use_date			:= Corp2_Mapping.fValidateDate(mark1stuseddt).PastDate;
					 first_use_date 		:= if(mark_use_date<>'','DATE FIRST USED: '+mark_use_date[5..6]+'/'+mark_use_date[7..8]+'/'+mark_use_date[1..4],'');
					 logo 							:= if(corp2.t2u(marklogo)<>'', 'LOGO: '+corp2.t2u(marklogo),'');
					 addl_concatfields	:= corp2.t2u(trim(first_use_date)+';'+trim(logo));				
					 addl_tempexp1			:= regexreplace('[;]*$',addl_concatfields,'',NOCASE);
					 corp_addl_info			:= regexreplace('^[;]*',addl_tempexp1,'',NOCASE);
					 RETURN regexreplace('[;]+' ,corp_addl_info,';',NOCASE);
		END;

		//****************************************************************************
		//CorpForProfitInd: returns the "corp_for_profit_ind".
		//****************************************************************************
		EXPORT CorpForProfitInd(STRING s, STRING flag) := FUNCTION
					 uc_s 			:= corp2.t2u(s);
					 uc_flag 		:= corp2.t2u(flag);			 
					 RETURN MAP(uc_s in ['41','42']											=>'N', //not for profit
											uc_s in ['44'] and uc_flag = '1'				=>'N', //not for profit
											uc_s in ['44'] and uc_flag = '0'				=>'Y', //for profit
											''
										 );
		END;

		//****************************************************************************
		//EntityDesc: returns the "Corporation Entity Description".
		//****************************************************************************
		EXPORT EntityDesc(STRING busTypeCD,STRING isLLLPartnership,STRING isProf,STRING MarkClassNo,STRING ServDesc) := FUNCTION
					 LLL_Partnership 				:= if(corp2.t2u(busTypeCD) in['48','49','50','52'] and trim(isLLLPartnership)='1','LIMITED LIABILITY LIMITED PARTNERSHIP','');
					 Classification_Number 	:= if(corp2.t2u(MarkClassNo)<>'', 'CLASSIFICATION NUMBER: ' + corp2.t2u(MarkClassNo),'');
					 Services_Desc          := if(corp2.t2u(ServDesc)<>'', 'USED WITH: ' + corp2.t2u(ServDesc),'');
					 Is_Professional_ind    := if(corp2.t2u(isProf)='1', 'PROFESSIONAL ORGANIZATION','');
					 entity_concatFields		:= corp2.t2u(corp2.t2u(LLL_Partnership)+';'+corp2.t2u(Classification_Number)+';'+corp2.t2u(Services_Desc) +';'+ corp2.t2u(Is_Professional_ind)) ;				
					 entity_tempExp1				:= regexreplace('[;]*$',entity_concatFields,'',NOCASE);
					 corp_entity_desc				:= regexreplace('^[;]*',entity_tempExp1,'',NOCASE);		
					 RETURN regexreplace('[;]+' ,corp_entity_desc,';',NOCASE);
		END;

		//****************************************************************************
		//ForeignDomesticIndicator: returns "F"-Foreign or "D"-Domestic.
		//****************************************************************************
		EXPORT ForeignDomesticIndicator(STRING s, STRING isLLLPartnership) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN MAP(
											uc_s = '38' 														=> 'D',
											uc_s = '39' 														=> 'F',
											uc_s = '41' 														=> 'D',
											uc_s = '42' 														=> 'F',
											uc_s = '43' 														=> 'F',
											uc_s = '44' 														=> 'D',
											uc_s = '46'															=> 'F',
											uc_s = '48'															=> 'D',
											uc_s = '49'															=> 'F',
											uc_s = '50' 														=> 'D',
											uc_s = '52'															=> 'F',
											uc_s = '66' 														=> 'D',
											uc_s = '104' 														=> 'D',
											''
										 );
		END;

		//****************************************************************************
		//NameTypeCode: returns the "corp_ln_name_type_cd".
		//****************************************************************************
		EXPORT NameTypeCode(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN MAP(
										 uc_s = '38' 	=> '01',
										 uc_s = '39' 	=> '01',
										 uc_s = '41' 	=> '01',
										 uc_s = '42' 	=> '01',
										 uc_s = '43' 	=> '01',
										 uc_s = '44' 	=> '01',
										 uc_s = '46'	=> '01',
										 uc_s = '48'	=> '01',
										 uc_s = '49'	=> '01',
										 uc_s = '50'	=> '01',
										 uc_s = '52'	=> '01',
										 uc_s = '57'	=> '03',
										 uc_s = '59' 	=> '06',
										 uc_s = '60' 	=> '07',
										 uc_s = '66' 	=> '01',
										 uc_s = '104' => '01',
										 ''
										); 
		END;

		//********************************************************************
		//NameTypeDesc: Returns the "corp_ln_name_type_desc".
		//********************************************************************	
		EXPORT NameTypeDesc(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN MAP(
							 uc_s = '38' 	 		=> 'LEGAL',
							 uc_s = '39' 	 		=> 'LEGAL',
							 uc_s = '41' 	 		=> 'LEGAL',
							 uc_s = '42' 	 		=> 'LEGAL',
							 uc_s = '43' 	 		=> 'LEGAL',
							 uc_s = '44' 	 		=> 'LEGAL',
							 uc_s = '46'	 		=> 'LEGAL',
							 uc_s = '48'	 		=> 'LEGAL',
							 uc_s = '49'	 		=> 'LEGAL',
							 uc_s = '50'	 		=> 'LEGAL',
							 uc_s = '52'	 		=> 'LEGAL',
							 uc_s = '57'	 		=> 'TRADEMARK',
							 uc_s = '59' 	 		=> 'ASSUMED NAME',
							 uc_s = '60' 	 		=> 'RESERVED',
							 uc_s = '66' 	 		=> 'LEGAL',
							 uc_s = '104'  		=> 'LEGAL',
							 ''
							); 
		END;

		//****************************************************************************
		//OrgStructureCode: returns the "corp orig org structure code".
		//****************************************************************************
		EXPORT OrgStructureCode(STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 RETURN MAP(uc_s = '38'  => '',			//do not map per CI
											uc_s = '39'  => '',			//do not map per CI
											uc_s = '41'  => '41',
											uc_s = '42'  => '42',
											uc_s = '43'  => '43',
											uc_s = '44'  => '44',
											uc_s = '46'	 => '46',
											uc_s = '48'	 => '48',
											uc_s = '49'	 => '49',
											uc_s = '50'	 => '50',
											uc_s = '52'	 => '52',							 
											uc_s = '57'	 => '',			//do not map per CI
											uc_s = '59'  => '',			//do not map per CI
											uc_s = '60'  => '',			//do not map per CI
											uc_s = '66'  => '66',
											uc_s = '104' => '104',
											''
										 ); 
		END;

		//****************************************************************************
		//OrgStructureDesc: returns the "corp orig org structure description".
		//****************************************************************************
		EXPORT OrgStructureDesc(STRING isLLLPartnership = '0',STRING s) := FUNCTION
					 uc_s := corp2.t2u(s);
					 UC_flag := corp2.t2u(isLLLPartnership);
					 RETURN MAP(uc_s = '38'  													=> '',			//do not map per CI
											uc_s = '39'  													=> '',			//do not map per CI
											uc_s = '41'  													=> 'NONPROFIT CORPORATION (DOMESTIC)',
											uc_s = '42' 													=> 'NONPROFIT CORPORATION (FOREIGN)',
											uc_s = '43'  													=> 'BUSINESS CORPORATION (FOREIGN)',
											uc_s = '44'  													=> 'LIMITED LIABILITY COMPANY (DOMESTIC)',
											uc_s = '46'	 													=> 'LIMITED LIABILITY COMPANY (FOREIGN)',
											uc_s = '48'	and trim(UC_flag) = '0' 	=> 'LIMITED PARTNERSHIP (DOMESTIC)',
											uc_s = '48'	and trim(UC_flag) = '1' 	=> 'LIMITED LIABILITY LIMITED PARTNERSHIP (DOMESTIC)',	
											uc_s = '49'	and trim(UC_flag) = '0' 	=> 'LIMITED PARTNERSHIP (FOREIGN)',
											uc_s = '49'	and trim(UC_flag) = '1' 	=> 'LIMITED LIABILITY LIMITED PARTNERSHIP (FOREIGN)',								 
											uc_s = '50'	and trim(UC_flag) = '0' 	=> 'LIMITED LIABILITY PARTNERSHIP (DOMESTIC)',
											uc_s = '50'	and trim(UC_flag) = '1' 	=> 'LIMITED LIABILITY LIMITED PARTNERSHIP (DOMESTIC)',							 
											uc_s = '52'	and trim(UC_flag) = '0' 	=> 'LIMITED LIABILITY PARTNERSHIP (FOREIGN)',
											uc_s = '52'	and trim(UC_flag) = '1' 	=> 'LIMITED LIABILITY LIMITED PARTNERSHIP (FOREIGN)',							 
											uc_s = '57'													 	=> '',			//do not map per CI
											uc_s = '59'  													=> '',			//do not map per CI
											uc_s = '60'  													=> '',			//do not map per CI
											uc_s = '66' 												  => 'BUSINESS CORPORATION (DOMESTIC)',
											uc_s = '104' 													=> 'COOPERATIVE (DOMESTIC)',
											''
										 ); 
		END;

		//****************************************************************************
		//StockAuthorizedNbr: returns the "Stock Authorized Number".
		//Note:  A value that contains a $ value is not a valid stock authorized
		//			 number.
		//****************************************************************************
		EXPORT StockAuthorizedNbr(STRING s) := FUNCTION
			ValidPattern	  := 'TRIL|MIL|BIL|ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN';
			InValidPattern  := 'NONE|.COM|.NET';

			uc_s := stringlib.stringfilterout(corp2.t2u(s),'#%[]');
			
			isAllAlpha  := if(stringlib.stringfilterout(uc_s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '',true,false);
			check1 			:= if(length(uc_s)=1 OR length(uc_s)=2 AND isAllAlpha,'',uc_s);
			check2 			:= map(regexfind(InValidPattern,check1,0) 						 <> '' => '', 		//check if an invalid pattern exists
												 isAllAlpha and regexfind(ValidPattern,check1,0) =  '' => '', 		//if all alpha, see if a valid pattern exists (no valid pattern exists here)
												 isAllAlpha and regexfind(ValidPattern,check1,0) <> '' => check1, //if all alpha, see if a valid pattern exists (a  valid pattern exists here)
												 stringlib.stringfilterout(check1,'0,.$/')    	 = ''	 => '',			//check if all zeroes
												 check1																														//return validated stock number
												);	
			RETURN check2;
			
		END;

END;
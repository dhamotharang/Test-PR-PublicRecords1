IMPORT corp2, corp2_mapping;

EXPORT Functions := MODULE
		//****************************************************************************
		//State_Codes: returns the state code.
		//****************************************************************************
		EXPORT State_Desc_Translation(string s) := FUNCTION
					 
					 uc_s := corp2.t2u(s);

	         RETURN map(uc_s = 'ALABAMA' 																				=> 'AL',
											uc_s = 'ALASKA' 																				=> 'AK', 
											uc_s = 'ARKANSAS' 																			=> 'AR', 
											uc_s = 'AMERICAN SAMOA' 																=> 'AS', 
											uc_s = 'ARIZONA' 																				=> 'AZ',
											uc_s = 'ARMED FORCES (AMERICAS EXCEPT CANADA)'					=> 'AA',
											uc_s = 'ARMED FORCES EUROPE THE MIDDLE EAST AND CANADA'	=> 'AE',
											uc_s = 'ARMED FORCES PACIFIC'														=> 'AP',
											uc_s = 'CALIFORNIA' 																		=> 'CA', 
											uc_s = 'CANAL ZONE' 																		=> 'CZ',
											uc_s = 'COLORADO' 																			=> 'CO', 
											uc_s = 'CONNECTICUT'													 					=> 'CT',
											uc_s = 'DAVIDSON COUNTY'																=> 'TN', 
											uc_s = 'DISTRICT OF COLUMBIA'														=> 'DC', 
											uc_s = 'DELAWARE' 																			=> 'DE', 
										  uc_s = 'FEDERATED STATES'																=> 'FM',
											uc_s = 'FLORIDA' 																				=> 'FL', 
											uc_s = 'GEORGIA'													 							=> 'GA', 
											uc_s = 'GUAM' 																					=> 'GU', 
											uc_s = 'HAWAII'																					=> 'HI', 	
											uc_s = 'IOWA' 																					=> 'IA', 
											uc_s = 'IDAHO' 																					=> 'ID', 
											uc_s = 'ILLINOIS' 																			=> 'IL', 
											uc_s = 'INDIANA'														 						=> 'IN', 
											uc_s = 'KANSAS' 																				=> 'KS', 
											uc_s = 'KENTUCKY'														 						=> 'KY', 
											uc_s = 'LOUISIANA' 																			=> 'LA', 
											uc_s = 'MASSACHUSETTS' 																	=> 'MA', 
											uc_s = 'MARYLAND'																				=> 'MD', 
											uc_s = 'MAINE' 																					=> 'ME', 
											uc_s = 'MICHIGAN' 																			=> 'MI', 
											uc_s = 'MINNESOTA'													 						=> 'MN', 
											uc_s = 'MISSOURI' 																			=> 'MO', 
											uc_s = 'MISSISSIPPI' 																		=> 'MS', 
											uc_s = 'MONTANA' 																				=> 'MT', 
											uc_s = 'NORTH CAROLINA' 																=> 'NC', 
											uc_s = 'NORTH DAKOTA' 																	=> 'ND', 
											uc_s = 'NEBRASKA' 																			=> 'NE', 
											uc_s = 'NEW HAMPSHIRE'													 				=> 'NH', 
											uc_s = 'NEW JERSEY' 																		=> 'NJ', 
											uc_s = 'NEW MEXICO'														 					=> 'NM', 
											uc_s = 'NEVADA' 																				=> 'NV', 
											uc_s = 'NEW YORK'														 						=> 'NY', 
											uc_s = 'OHIO' 																					=> 'OH', 
											uc_s = 'OKLAHOMA' 																			=> 'OK', 
											uc_s = 'OREGON' 																				=> 'OR', 
											uc_s = 'PENNSYLVANIA' 																	=> 'PA', 
											uc_s = 'RHODE ISLAND'																 		=> 'RI', 
											uc_s = 'SOUTH CAROLINA' 																=> 'SC', 
											uc_s = 'SOUTH DAKOTA'															 			=> 'SD', 
											uc_s = 'TENNESSEE' 																			=> 'TN', 
											uc_s = 'TEXAS' 																					=> 'TX', 
											uc_s = 'UNITED STATES' 																	=> 'US', 
											uc_s = 'UNITED STATES OF AMERICA'												=> 'US',											
											uc_s = 'USA' 																						=> 'US', 
											uc_s = 'UTAH' 																					=> 'UT', 
											uc_s = 'VIRGINIA' 																			=> 'VA', 
											uc_s = 'VIRGIN ISLANDS' 																=> 'VI',		
											uc_s = 'VERMONT' 																				=> 'VT', 
											uc_s = 'WASHINGTON' 																		=> 'WA', 
											uc_s = 'WISCONSIN' 																			=> 'WI', 
											uc_s = 'WEST VIRGINIA'													 				=> 'WV', 
											uc_s = 'WYOMING' 																				=> 'WY',
											uc_s = ''																								=> '',
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//Foreign_Desc_Translation: returns whether the description is valid or not.
		//****************************************************************************
		EXPORT Foreign_Desc_Translation(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
											
					 RETURN map(uc_s = 'AUSTRALIA' 																											=> 'AUS',
											uc_s = 'AUSTRIA' 																												=> 'AUT',
											uc_s = 'BAHAMAS, THE' 																									=> 'BHS',
											uc_s = 'BANGLADESH' 																										=> 'BGD',
											uc_s = 'BARBADOS' 																											=> 'BRB',
											uc_s = 'BELGIUM' 																												=> 'BEL',
											uc_s = 'BELIZE' 																												=> 'BLZ',
											uc_s = 'BERMUDA' 																												=> 'BMU',
											uc_s = 'CANADA' 																												=> 'CAN',
											uc_s = 'CAYMAN ISLANDS' 																								=> 'CYM',
											uc_s = 'CHINA' 																													=> 'CHN',
											uc_s = 'COLOMBIA'																												=> 'COL',
											uc_s = 'CURACAO' 																												=> 'CUW',
											uc_s = 'DOMINICA' 																											=> 'DM',
											uc_s = 'ENGLAND' 																												=> 'GBR',
											uc_s = 'FINLAND' 																												=> 'FIN',
											uc_s = 'FRANCE' 																												=> 'FRA',
											uc_s = 'GERMANY' 																												=> 'DEU',
											uc_s = 'GHANA' 																													=> 'GHA',										
										  uc_s = 'GIBRALTAR' 																											=> 'GIB',
										  uc_s = 'GUATEMALA' 																											=> 'GTM',
										  uc_s = 'HONG KONG SAR' 																									=> 'HKG',
											uc_s = 'IRELAND' 																												=> 'IRL',
										  uc_s = 'INDIA' 																													=> 'IND',
										  uc_s = 'JAPAN' 																													=> 'JPN',
											uc_s = 'KOREA (SOUTH)' 																									=> 'KOR',
										  uc_s = 'LUXEMBOURG' 																										=> 'LUX',
											uc_s = 'MEXICO' 																												=> 'MEX',
											uc_s = 'NETHERLANDS ANTILLES' 																					=> 'ANT',
											uc_s = 'NETHERLANDS, THE' 																							=> 'NLD',
											uc_s = 'NEW CALEDONIA' 																									=> 'NCL',
											uc_s = 'NIGERIA' 																												=> 'NGA',
											uc_s = 'OTHER' 																													=> 'OTH',
										  uc_s = 'PANAMA' 																												=> 'PAN',
											uc_s = 'PERU' 																													=> 'PER',
											uc_s = 'PHILIPPINES' 																										=> 'PHL',
											uc_s = 'PUERTO RICO' 																										=> 'PRI',
											uc_s = 'ROMANIA' 																												=> 'ROU',
											uc_s = 'SAC AND FOX NATION' 																						=> 'US',
											uc_s = 'SCOTLAND, UK' 																									=> 'GBR',
											uc_s = 'SINGAPORE' 																											=> 'SGP',
											uc_s = 'SPAIN' 																													=> 'ESP',
											uc_s = 'SRI LANKA' 																											=> 'LKA',											
											uc_s = 'SWEDEN' 																												=> 'SWE',
											uc_s = 'SWITZERLAND' 																										=> 'CHE',
											uc_s = 'TAIWAN' 																												=> 'TWN',
											uc_s = 'TOGO' 																													=> 'TGO',
											uc_s = 'TRIBAL'																													=> 'TRB',
											uc_s = 'URUGUAY' 																												=> 'URY',
										  uc_s = 'UNITED ARAB EMIRATES' 																					=> 'ARE',
										  uc_s = 'UNITED KINGDOM'																									=> 'GBR',
											uc_s = 'VIRGIN ISLANDS, BRITISH' 																				=> 'VGB',
											uc_s = 'WEST GERMANY'																										=> 'DEU',								
											uc_s = 'YAKAMA NATION' 																									=> 'US',
										  '**|'+uc_s
										 );
										 
		END;

		//****************************************************************************
		//CorpForgnStateCD: returns "corp_forgn_state_cd".
		//****************************************************************************
		EXPORT CorpForgnStateCD(STRING s) := FUNCTION

					 uc_s := corp2.t2u(s);
																
	         RETURN map(State_Desc_Translation(uc_s)[1..2] 	 <> '**' => State_Desc_Translation(uc_s),
											Foreign_Desc_Translation(uc_s)[1..2] <> '**' => Foreign_Desc_Translation(uc_s),
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//CorpForgnStateDesc: returns "corp_forgn_state_desc".
		//****************************************************************************
		EXPORT CorpForgnStateDesc(string s) := FUNCTION

					 uc_s := corp2.t2u(s);

	         RETURN map(uc_s in ['DAVIDSON COUNTY']									 => 'TENNESSEE', 
											State_Desc_Translation(uc_s)[1..2] 	 <> '**' => uc_s,					 
											Foreign_Desc_Translation(uc_s)[1..2] <> '**' => uc_s,
											'**|'+uc_s
										 );
		END;

		//********************************************************************
		//CorpLNNameTypeCD: This function returns the "corp_ln_name_type_cd". 
		//********************************************************************
		EXPORT CorpLNNameTypeCD(STRING s) := FUNCTION 

			uc_s		:= corp2.t2u(s);
			
			RETURN map(uc_s = 'LIMITED LIABILITY COMPANY'			=> '01',
								 uc_s = 'FOR-PROFIT CORPORATION' 				=> '01',
								 uc_s = 'NONPROFIT CORPORATION' 				=> '01',
								 uc_s = 'RESERVED NAME' 								=> '07',
								 uc_s = 'LIMITED LIABILITY PARTNERSHIP' => '01',
								 uc_s = 'GENERAL PARTNERSHIP' 					=> '01',
								 uc_s = 'LIMITED PARTNERSHIP' 					=> '01',
								 uc_s = 'LP 1988 ACT'										=> '01',
								 uc_s = 'FOREIGN REGISTERED NAME' 			=> '11',
								 uc_s = 'FOREIGN NAME' 									=> '12',
								 '**'
								);
		END;

		//********************************************************************
		//CorpLNNameTypeDesc: This function returns the "corp_ln_name_type_desc". 
		//********************************************************************
		EXPORT CorpLNNameTypeDesc(STRING s) := FUNCTION 

			uc_s		:= corp2.t2u(s);
			
			RETURN map(uc_s = 'LIMITED LIABILITY COMPANY'			=> 'LEGAL',
								 uc_s = 'FOR-PROFIT CORPORATION' 				=> 'LEGAL',
								 uc_s = 'NONPROFIT CORPORATION' 				=> 'LEGAL',
								 uc_s = 'RESERVED NAME' 								=> 'RESERVED',
								 uc_s = 'LIMITED LIABILITY PARTNERSHIP' => 'LEGAL',
								 uc_s = 'GENERAL PARTNERSHIP' 					=> 'LEGAL',
								 uc_s = 'LIMITED PARTNERSHIP' 					=> 'LEGAL',
								 uc_s = 'LP 1988 ACT'										=> 'LEGAL',
								 uc_s = 'FOREIGN NAME' 									=> uc_s,
								 uc_s = 'FOREIGN REGISTERED NAME' 			=> uc_s,
								 '**|'+uc_s
								);
		END;

		//********************************************************************
		//CorpOrigOrgStructureDesc: This function returns the 
		//													"corp_orig_org_structure_desc". 
		//********************************************************************
		EXPORT CorpOrigOrgStructureDesc(STRING s) := FUNCTION 

			uc_s		:= corp2.t2u(s);
			
			RETURN map(uc_s = 'LIMITED LIABILITY COMPANY'			=> uc_s,
								 uc_s = 'FOR-PROFIT CORPORATION' 				=> uc_s,
								 uc_s = 'NONPROFIT CORPORATION' 				=> uc_s,
								 uc_s = 'RESERVED NAME' 								=> '',
								 uc_s = 'LIMITED LIABILITY PARTNERSHIP' => uc_s,
								 uc_s = 'GENERAL PARTNERSHIP' 					=> uc_s,
								 uc_s = 'LIMITED PARTNERSHIP' 					=> uc_s,
								 uc_s = 'LP 1988 ACT'										=> uc_s,
								 uc_s = 'FOREIGN NAME' 									=> '',
								 uc_s = 'FOREIGN REGISTERED NAME' 			=> '',								 
								 '**|'+uc_s
								);
		END;

		//********************************************************************
		//GetMonthDesc: This function returns the "name of the month". 
		//********************************************************************
		EXPORT GetMonthDesc(STRING s) := FUNCTION
		
			mm 					:= (STRING)intformat((INTEGER)s,2,1);

			month_desc 	:= case( mm,
													'01' => 'JANUARY',
													'02' => 'FEBRUARY',
													'03' => 'MARCH',
													'04' => 'APRIL',
													'05' => 'MAY',
													'06' => 'JUNE',
													'07' => 'JULY',
													'08' => 'AUGUST',
													'09' => 'SEPTEMBER',
													'10' => 'OCTOBER',
													'11' => 'NOVEMBER',
													'12' => 'DECEMBER',
													'');
			RETURN month_desc;
		
		END;
		
		//********************************************************************
		//CorpStatusComment: This function returns the "corp_status_comment". 
		//********************************************************************
		EXPORT CorpStatusComment(STRING ar, STRING ra, STRING other) := FUNCTION 
			 uc_ar								:= corp2.t2u(ar);
			 uc_ra								:= corp2.t2u(ra);
			 uc_other							:= corp2.t2u(other);

			 standing_1						:= if(uc_ar<>'',if(uc_ra<>'' or uc_other <>'','; ',''),'');					
			 standing_2        		:= if(uc_ra<>'','STANDING REGISTERED AGENT: ' + uc_ra,if(uc_other<>'','; ',''));
			 standing_3  					:= if(uc_other<>'','STANDING OTHER: ' + uc_other,'');
       
			 all_standing		  		:= standing_1 + '; ' + standing_2 + '; ' + standing_3;
       
			 clean_all_standing1 	:= regexreplace('(; ){2,}',all_standing,'; ');
			 clean_all_standing2  := regexreplace('(; ?$)',clean_all_standing1,'');													 
			 clean_all_standing3  := regexreplace('^(; ?)',clean_all_standing2,'');						
						
			 RETURN clean_all_standing3;

		END;

		//********************************************************************
		//CorpAddlInfo: This function returns the "corp_addl_info". 
		//********************************************************************
		EXPORT CorpAddlInfo(STRING eff_date, STRING man_type, STRING mem_cnt, STRING pub_ben, STRING mth) := FUNCTION 
			 uc_eff_date					:= Corp2_Mapping.fValidateDate(eff_date,'MM/DD/CCYY').GeneralDate;
			 uc_man_type					:= corp2.t2u(man_type);
			 uc_mem_cnt						:= corp2.t2u(mem_cnt);
			 uc_pub_ben						:= corp2.t2u(pub_ben);
			 uc_mth								:= corp2.t2u(mth);

			 addl_info1           := if(uc_eff_date<>'','DELAYED EFFECTIVE DATE: ' + uc_eff_date[5..6] + '/' + uc_eff_date[7..8] + '/' + uc_eff_date[1..4],'' );														
			 addl_info2           := if(uc_man_type<>'','MANAGED BY: ' + uc_man_type,'');													   													   		
			 addl_info3           := if(uc_mem_cnt not in ['0','N',''],'NO. OF MEMBERS: ' + uc_mem_cnt,'');														
			 addl_info4           := if(uc_pub_ben = 'Y','PUBLIC BENEFIT: ' + uc_pub_ben,'');														
			 addl_info5           := if(GetMonthDesc(uc_mth)<>'','FISCAL YEAR END CLOSE: ' + GetMonthDesc(uc_mth),'');			

			 all_addl_info 				:= addl_info1 +'; ' +addl_info2 +'; ' + addl_info3 + '; ' + addl_info4 + '; ' + addl_info5;

			 clean_all_addl_info1 := regexreplace('(; ){2,}',all_addl_info,'; ');			
			 clean_all_addl_info2 := regexreplace('(; ?$)',clean_all_addl_info1,'');
			 clean_all_addl_info3 := regexreplace('^(; ?)',clean_all_addl_info2,'');
						
			 RETURN clean_all_addl_info3;

		END;
														
END;
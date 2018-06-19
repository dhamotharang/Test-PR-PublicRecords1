IMPORT corp2_mapping, corp2, ut;

EXPORT Functions := MODULE

		//****************************************************************************
		//CorpAddress1TypeCD: returns the "corp_address1_type_cd".
		//****************************************************************************
		export CorpAddress1TypeCD(string s) := function
					 uc_s := corp2.t2u(s);
					 return map(uc_s = 'MAILING ADDRESS'							=> 'M',
											uc_s = 'PRINCIPAL PLACE OF BUSINESS'	=> 'B',
											uc_s = 'RECORDS OFFICE'								=> 'F',
											''
										  );
		end;
		
		//****************************************************************************
		//CorpAddress1TypeDesc: returns the "corp_address1_type_cd".
		//****************************************************************************
		export CorpAddress1TypeDesc(string s) := function
					 uc_s := corp2.t2u(s);
					 return map(uc_s = 'MAILING ADDRESS'							=> 'MAILING',
											uc_s = 'PRINCIPAL PLACE OF BUSINESS'	=> 'BUSINESS',
											uc_s = 'RECORDS OFFICE'								=> 'FILING',
											''
										  );
		end;

		//****************************************************************************
		//ContTitle1Desc: returns the "cont_title1_desc".
		//****************************************************************************
		export ContTitle1Desc(string s) := function
					 uc_s := corp2.t2u(s);
					 return map(uc_s in ['APPLICANT','AUTHORIZED REPRESENTATIVE'] => uc_s,
										  uc_s in ['CORRESPONDENT'] 												=> uc_s,				
										  uc_s in ['GENERAL PARTNER'] 											=> uc_s,	
										  uc_s in ['INDIVIDUAL WITH DIRECT KNOWLEDGE'] 			=> uc_s,
										  uc_s in ['MANAGER','MANAGING PARTNER','MEMBER'] 	=> uc_s,				
										  uc_s in ['NONFILEABLE CORRESPONDENT']							=> uc_s,				
										  uc_s in ['PARTNER','PRESIDENT'] 									=> uc_s,				
										  uc_s in ['REGISTRANT'] 														=> uc_s,				
										  uc_s in ['SECRETARY'] 														=> uc_s,				
										  uc_s in ['TRUSTEE'] 															=> uc_s,
										  'CONTACT'
										);
		end;
		
		//****************************************************************************
		//ContFullName: returns the "cont_full_name".
		//
		//Note:  The input parm "suffix" (named individual_suffix in the raw file), 
		//			 can contain address data, professional titles, name titles (e.g. JR.),
		//			 and also a last name.  This routine tries to identify if the suffix
		//       is a "bad" last name.  When a name exists and the suffix is valid,
		//       the suffix is attached to the name.  Otherwise we are sending the
		//       busname if it exists.
		//****************************************************************************
		export ContFullName(string name, string suffix, string busname) := function
					 uc_name 						 := corp2.t2u(name);
					 uc_suffix  				 := regexreplace('\\.',corp2.t2u(suffix),'');
					 uc_busname  				 := corp2.t2u(busname);
					 
					 PatternInvalidWords1 := '^ASSIST SEC|^ATTORNEY|^ATTY|^ATT|CFO$|^DIRECTOR|^MRS|^MR|^MS|^PO BOX|^PO|^TRUSTEE|^TTEE|';
					 PatternInvalidWords2 := '^UNITED STATES OF AMERICA|^VICE PRES';
					 PatternInvalidWords  := PatternInvalidWords1 + PatternInvalidWords2;
					 
			     //PatternInvalidWords	:= ['1ST','2ND','3RD','4TH','I','V'];
					 
					 hasName							:= if(uc_name <> '',true,false);
					 hasBusName						:= if(uc_busname <> '',true,false);

					 //Check if the suffix matches the last word in name (found the last name in both "name" and "suffix")
					 //Trying to remove that here.
					 wordcount						:= stringlib.countwords(uc_name,' ',allow_blanks := false);
					 lastword							:= stringlib.stringgetnthword(uc_name,wordcount);			 
					 
					 hasInvalidCharacters := if(stringlib.stringfilter(uc_suffix,'0123456789#&(*+_-=/\\][`_') <> '',true,false);                                                 
					 hasInvalidLength 		:= if(length(uc_suffix)=1 and uc_suffix not in ['I','V'],true,false);
					 hasInvalidWords			:= if(regexfind(PatternInvalidWords,uc_suffix,0) <> '',true,false);
					 suffixIsSame					:= if(uc_suffix = lastword,true,false);			 
					 suffixIsInvalid			:= if(hasInvalidCharacters or hasInvalidLength or hasInvalidWords or suffixIsSame,true,false);
					 suffixIsValid				:= if(suffixIsInvalid,false,true);

					 return map(hasName 	and suffixIsValid		=> uc_name + ' ' + uc_suffix,
											hasName 	and suffixIsInvalid	=> uc_name,
											hasBusName										=> uc_busname,
											''
										);
		end;
		
		//****************************************************************************
		//CorpForgnDomesticInd: returns the "corp_foreign_domestic_ind".
		//****************************************************************************
		export CorpForgnDomesticInd(string s) := function
					 uc_s := corp2.t2u(s);
					 return map(uc_s = 'DOMESTIC LIMITED LIABILITY COMPANY'									=> 'D',
											uc_s = 'DOMESTIC BUSINESS CORPORATION'											=> 'D',
											uc_s = 'DOMESTIC NONPROFIT CORPORATION'											=> 'D',
											uc_s = 'FOREIGN BUSINESS CORPORATION'												=> 'F',
											uc_s = 'FOREIGN LIMITED LIABILITY COMPANY'									=> 'F',
											uc_s = 'DOMESTIC PROFESSIONAL CORPORATION'									=> 'D',
											uc_s = 'DOMESTIC LIMITED PARTNERSHIP'												=> 'D',
											uc_s = 'FOREIGN LIMITED PARTNERSHIP'												=> 'F',
											uc_s = 'FOREIGN NONPROFIT CORPORATION'											=> 'F',
											uc_s = 'DOMESTIC REGISTERED LIMITED LIABILITY PARTNERSHIP'	=> 'D',
											uc_s = 'DOMESTIC BUSINESS TRUST'														=> 'D',
											uc_s = 'FOREIGN PROFESSIONAL CORPORATION'										=> 'F',
											uc_s = 'FOREIGN REGISTERED LIMITED LIABILITY PARTNERSHIP'		=> 'F',
											uc_s = 'FOREIGN BUSINESS TRUST'															=> 'F',
											uc_s = 'FOREIGN INDUSTRIAL LOAN'														=> 'F',
											uc_s = 'DOMESTIC INDUSTRIAL LOAN'														=> 'D',
											''
										);
		end;
		
		//****************************************************************************
		//CorpForProfitInd: returns the "corp_for_profit_ind".
		//****************************************************************************
		export CorpForProfitInd(string s) := function
					 uc_s := corp2.t2u(s);
					 return map(uc_s = 'DOMESTIC NONPROFIT CORPORATION'											=> 'N',
											uc_s = 'FOREIGN NONPROFIT CORPORATION'											=> 'N',
											uc_s = 'DISTRICT IMPROVEMENT NONPROFIT'											=> 'N',
											uc_s = 'DISTRICT IMPROVEMENT PROFIT'												=> 'Y',											
											''
										 );
		end;

    //****************************************************************************
		//CorpLNNameTypeCD: returns the "corp_ln_name_type_cd".
		//											input: nt -> name_type
		//														 bt -> bus_type
		//****************************************************************************
		export CorpLNNameTypeCD(string nt,string bt) := function
					 uc_nt := corp2.t2u(nt);
					 uc_bt := corp2.t2u(bt);
					 return map(uc_bt = 'ASSUMED BUSINESS NAME' 	=> '06',									
											uc_bt = 'RESERVED NAME'						=> '07',
											uc_bt = 'REGISTERED NAME'					=> '09',									
											uc_nt = 'ENTITY NAME' 						=> '01',
											uc_nt = 'DOING BUSINESS AS'				=> '02',
											uc_nt = 'FOREIGN NAME'	 					=> '10',
											uc_nt = 'MISFILED NAME'						=> 'I',									
											''
										 );
		end;
		
		
		//****************************************************************************
		//CorpLNNameTypeDesc: returns the "corp_ln_name_type_desc".
		//												input: nt -> name_type
		//														 	 bt -> bus_type
		//****************************************************************************
		export CorpLNNameTypeDesc(string nt,string bt) := function
					 uc_nt := corp2.t2u(nt);
					 uc_bt := corp2.t2u(bt);
					 return map(uc_bt = 'ASSUMED BUSINESS NAME' 	=> 'ASSUMED',									
											uc_bt = 'RESERVED NAME'						=> 'RESERVED',
											uc_bt = 'REGISTERED NAME'					=> 'REGISTRATION',									
											uc_nt = 'ENTITY NAME' 						=> 'LEGAL',
											uc_nt = 'DOING BUSINESS AS'				=> 'DBA',
											uc_nt = 'FOREIGN NAME'	 					=> 'FOREIGN',
											uc_nt = 'MISFILED NAME'						=> 'OTHER',									
											''
										);
		end;
		
		//****************************************************************************
		//CorpOrigOrgStructureDesc: returns the "corp_orig_org_structure_desc".
		//												input: s -> bus_type
		//****************************************************************************
		export CorpOrigOrgStructureDesc(string s) := function
					 uc_s := corp2.t2u(s);
					 return	map(uc_s = 'ASSUMED BUSINESS NAME' 															=> '',  //known business type
											uc_s = 'DOMESTIC LIMITED LIABILITY COMPANY'									=> uc_s,
											uc_s = 'DOMESTIC BUSINESS CORPORATION'											=> uc_s,
											uc_s = 'DOMESTIC NONPROFIT CORPORATION'											=> uc_s,
											uc_s = 'FOREIGN BUSINESS CORPORATION'												=> uc_s,
											uc_s = 'FOREIGN LIMITED LIABILITY COMPANY'									=> uc_s,
											uc_s = 'DOMESTIC PROFESSIONAL CORPORATION'									=> uc_s,
											uc_s = 'DOMESTIC LIMITED PARTNERSHIP'												=> uc_s,
											uc_s = 'FOREIGN LIMITED PARTNERSHIP'												=> uc_s,
											uc_s = 'FOREIGN NONPROFIT CORPORATION'											=> uc_s,
											uc_s = 'DOMESTIC REGISTERED LIMITED LIABILITY PARTNERSHIP'	=> uc_s,
											uc_s = 'COOPERATIVE'																				=> uc_s,
											uc_s = 'DOMESTIC BUSINESS TRUST'														=> uc_s,
											uc_s = 'FOREIGN PROFESSIONAL CORPORATION'										=> uc_s,
											uc_s = 'FOREIGN REGISTERED LIMITED LIABILITY PARTNERSHIP'		=> uc_s,
											uc_s = 'DISTRICT IMPROVEMENT NONPROFIT'											=> uc_s,
											uc_s = 'FOREIGN BUSINESS TRUST'															=> uc_s,
											uc_s = 'RESERVED NAME'																			=> '',  //known business type
											uc_s = 'REGISTERED NAME'																		=> '',  //known business type
											uc_s = 'ACT OF GOVERNMENT'																	=> uc_s,
											uc_s = 'DISTRICT IMPROVEMENT PROFIT'												=> uc_s,
											uc_s = 'FOREIGN INDUSTRIAL LOAN'														=> uc_s,
											uc_s = 'DOMESTIC INDUSTRIAL LOAN'														=> uc_s,
											'**|'+uc_s 																													//scrubbing for new business types
										 );

		end;
		
		//****************************************************************************
		//CorpRAFullName: returns the "corp_ra_full_name".
		//
		//Note:  The input parm "suffix" (named individual_suffix in the raw file), 
		//			 can contain address data, professional titles, name titles (e.g. JR.),
		//			 and also a last name.  This routine tries to identify if the suffix
		//       is a "bad" last name.  When a name exists and the suffix is valid,
		//       the suffix is attached to the name.  Otherwise we are sending the
		//       busname if it exists.
		//****************************************************************************
		export CorpRAFullName(string state_origin, string state_desc, string name, string suffix, string busname) := function
					 uc_name 						 := corp2.t2u(name);
					 uc_suffix  				 := regexreplace('\\.',corp2.t2u(suffix),'');
					 uc_busname  				 := corp2.t2u(busname);
					 
					 PatternInvalidWords1 := '^ASSIST SEC|^ATTORNEY|^ATTY|^ATT|^DIRECTOR|^MRS|^MR|^MS|^PO BOX|^PO|^TRUSTEE|^TTEE|';
					 PatternInvalidWords2 := '^UNITED STATES OF AMERICA|^VICE PRES';
					 PatternInvalidWords  := PatternInvalidWords1 + PatternInvalidWords2;
					 
					 hasName							:= if(uc_name <> '',true,false);
					 hasBusName						:= if(uc_busname <> '',true,false);

					 //Check if the suffix matches the last word in name (found the last name in both "name" and "suffix")
					 //Trying to remove that here.
					 wordcount						:= stringlib.countwords(uc_name,' ',allow_blanks := false);
					 lastword							:= stringlib.stringgetnthword(uc_name,wordcount);
							
					 hasInvalidCharacters := if(stringlib.stringfilter(uc_suffix,'0123456789#&(*+_-=/\\][`_') <> '',true,false);                                                 
					 hasInvalidLength 		:= if(length(uc_suffix)=1 and uc_suffix not in ['I','V'],true,false);
					 hasInvalidWords			:= if(regexfind(PatternInvalidWords,uc_suffix,0) <> '',true,false);
					 suffixIsSame					:= if(uc_suffix = lastword,true,false);
					 suffixIsInvalid			:= if(hasInvalidCharacters or hasInvalidLength or hasInvalidWords or suffixIsSame,true,false);
					 suffixIsValid				:= if(suffixIsInvalid,false,true);

					 businessname				  := map(hasName 	and suffixIsValid		=> uc_name + ' ' + uc_suffix,
																			 hasName 	and suffixIsInvalid	=> uc_name,
																			 hasBusName										=> uc_busname,
																			 ''
																			);
																			
					 return Corp2_mapping.fCleanBusinessName(state_origin,state_desc,businessname).BusinessName;
										
		end;
		
		//****************************************************************************
		//CorpRegisteredCounties: returns the "corp_registered_counties".
		//****************************************************************************
		export CorpRegisteredCounties(string county1,	string county2,	string county3,	string county4,	string county5,
																	string county6,	string county7,	string county8,	string county9,	string county10,
																	string county11,string county12,string county13,string county14,string county15,
																	string county16,string county17,string county18,string county19,string county20,
																	string county21,string county22,string county23,string county24,string county25,
																	string county26,string county27,string county28,string county29,string county30,
																	string county31,string county32,string county33,string county34,string county35,
																	string county36) := function

					 uc_1 	:= corp2.t2u(county1);  	uc_2 	:= corp2.t2u(county2);   	uc_3 	:= corp2.t2u(county3);		uc_4 	:= corp2.t2u(county4);		uc_5 	:= corp2.t2u(county5);
					 uc_6 	:= corp2.t2u(county6);  	uc_7 	:= corp2.t2u(county7);    uc_8 	:= corp2.t2u(county8);		uc_9 	:= corp2.t2u(county9);		uc_10 := corp2.t2u(county10);
					 uc_11 	:= corp2.t2u(county11);  	uc_12 := corp2.t2u(county12);   uc_13 := corp2.t2u(county13);		uc_14 := corp2.t2u(county14);		uc_15 := corp2.t2u(county15);
					 uc_16 	:= corp2.t2u(county16);  	uc_17 := corp2.t2u(county17);   uc_18 := corp2.t2u(county18);		uc_19 := corp2.t2u(county19);		uc_20 := corp2.t2u(county20);
					 uc_21 	:= corp2.t2u(county21);  	uc_22 := corp2.t2u(county22);   uc_23 := corp2.t2u(county23);		uc_24 := corp2.t2u(county24);		uc_25 := corp2.t2u(county25);
					 uc_26 	:= corp2.t2u(county26);  	uc_27 := corp2.t2u(county27);   uc_28 := corp2.t2u(county28);		uc_29 := corp2.t2u(county29);		uc_30 := corp2.t2u(county30);
					 uc_31 	:= corp2.t2u(county31);  	uc_32 := corp2.t2u(county32);   uc_33 := corp2.t2u(county33);		uc_34 := corp2.t2u(county34);		uc_35 := corp2.t2u(county35);
					 uc_36 	:= corp2.t2u(county36);

					 return corp2.t2u(uc_1 + if(uc_2  <> '',','+uc_2, '')	+ if(uc_3  <> '',','+uc_3, '') + if(uc_4  <> '',','+uc_4, '') + if(uc_5  <> '',','+uc_5, '')
																 + if(uc_6  <> '',','+uc_6, '')	+ if(uc_7  <> '',','+uc_7, '') + if(uc_8  <> '',','+uc_8, '') + if(uc_9  <> '',','+uc_9, '')
																 + if(uc_10 <> '',','+uc_10,'') + if(uc_11 <> '',','+uc_11,'') + if(uc_12 <> '',','+uc_12,'') + if(uc_13 <> '',','+uc_13,'')
																 + if(uc_14 <> '',','+uc_14,'') + if(uc_15 <> '',','+uc_15,'') + if(uc_16 <> '',','+uc_16,'') + if(uc_17 <> '',','+uc_17,'')
																 + if(uc_18 <> '',','+uc_18,'') + if(uc_19 <> '',','+uc_19,'') + if(uc_20 <> '',','+uc_20,'') + if(uc_21 <> '',','+uc_21,'')
																 + if(uc_22 <> '',','+uc_22,'') + if(uc_23 <> '',','+uc_23,'') + if(uc_24 <> '',','+uc_24,'') + if(uc_25 <> '',','+uc_25,'')
																 + if(uc_26 <> '',','+uc_26,'') + if(uc_27 <> '',','+uc_27,'') + if(uc_28 <> '',','+uc_28,'') + if(uc_29 <> '',','+uc_29,'')
																 + if(uc_30 <> '',','+uc_30,'') + if(uc_31 <> '',','+uc_31,'') + if(uc_32 <> '',','+uc_32,'') + if(uc_33 <> '',','+uc_33,'')
																 + if(uc_34 <> '',','+uc_34,'') + if(uc_35 <> '',','+uc_35,'') + if(uc_36 <> '',','+uc_36,'')
														);

		end;

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
											uc_s = 'UTAH' 																					=> 'UT', 
											uc_s = 'VIRGINIA' 																			=> 'VA', 
											uc_s = 'VIRGIN ISLANDS' 																=> 'VI',		
											uc_s = 'VERMONT' 																				=> 'VT', 
											uc_s = 'WASHINGTON' 																		=> 'WA', 
											uc_s = 'WISCONSIN' 																			=> 'WI', 
											uc_s = 'WEST VIRGINIA'													 				=> 'WV', 
											uc_s = 'WINNEBAGO TRIBE OF NEBRASKA'										=> 'WTN',                              
											uc_s = 'WYOMING' 																				=> 'WY',
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//Foreign_Desc_Translation: returns whether the description is valid or not.
		//****************************************************************************
		EXPORT Foreign_Desc_Translation(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
											
					 RETURN map(uc_s = ''																																=> '',
											uc_s = 'AFGHANISTAN'																										=> 'AFG',
										  uc_s = 'AFRICA' 																												=> 'ZAF',
										  uc_s = 'ALBERTA, CANADA' 																								=> 'AB', 
										  uc_s = 'AMERICAN INDIAN NATION' 																				=> 'US',
										  uc_s = 'ANTIGUA' 																												=> 'ATG',    
										  uc_s = 'ARGENTINA' 																											=> 'ARG',									
										  uc_s = 'ARUBA' 																													=> 'ABW',      
										  uc_s = 'AUSTRALIA' 																											=> 'AUS',
										  uc_s = 'BAHAMAS' 																												=> 'BHS',    
										  uc_s = 'BARBADOS' 																											=> 'BRB',
										  uc_s = 'BELGIUM' 																												=> 'BEL',
										  uc_s = 'BELIZE' 																												=> 'BLZ',
										  uc_s = 'BERMUDA' 																												=> 'BMU',
										  uc_s = 'BLUE LAKE RANCHERIA INDIAN TRIBE' 															=> 'US',
										  uc_s = 'BRITISH COLUMBIA, CANADA' 																			=> 'BC',        
										  uc_s = 'BRITISH VIRGIN ISLANDS' 																				=> 'VGB',
										  uc_s = 'BRITISH WEST INDIES' 																						=> 'BWI',
										  uc_s = 'CANADA' 																												=> 'CAN',
										  uc_s = 'CAYMAN ISLANDS' 																								=> 'CAY',  
										  uc_s = 'CHEROKEE NATION INDIAN TRIBE' 																	=> 'US',    
										  uc_s = 'CHILE' 																													=> 'CHL',      
										  uc_s = 'CHINA' 																													=> 'CHN',
										  uc_s = 'COEUR D\'ALENE TRIBE' 																					=> 'US',   
										  uc_s = 'COLUMBIA' 																											=> 'COL',
										  uc_s = 'CONF SALISH/KOOTENAI TRIBES' 																		=> 'US',     
										  uc_s = 'CONFEDERATED TRIBES OF COOS, LOWER UMPQUA AND SIUSLAW INDIANS'	=> 'US',
										  uc_s = 'CONFEDERATED TRIBES OF SILETZ INDIANS OF OREGON'								=> 'US',
										  uc_s = 'CONFEDERATED TRIBES OF WARM SPRINGS RESERVATION OF OREGON'			=> 'US',
										  uc_s = 'COOK ISLANDS' 																									=> 'COK',
										  uc_s = 'COQUILLE INDIAN TRIBE' 																					=> 'US', 
										  uc_s = 'CURACAO' 																												=> 'CUW',    
										  uc_s = 'CYPRUS' 																												=> 'CYP',     
										  uc_s = 'CZECH REPUBLIC' 																								=> 'CZE',  
										  uc_s = 'DENMARK' 																												=> 'DNK',    
										  uc_s = 'DOMINICAN REPUBLIC' 																						=> 'DOM',
										  uc_s = 'EUROPE' 																												=> 'EUR',											
										  uc_s = 'FINLAND' 																												=> 'FIN',    
										  uc_s = 'FRANCE' 																												=> 'FRA',
										  uc_s = 'GERMANY' 																												=> 'DEU',
										  uc_s = 'GHANA' 																													=> 'GHA',      
										  uc_s = 'GREAT BRITAIN' 																									=> 'GBR',											
										  uc_s = 'GREECE' 																												=> 'GRC',     
										  uc_s = 'GUATEMALA' 																											=> 'GTM',
										  uc_s = 'HONG KONG' 																											=> 'HKG',
										  uc_s = 'ICELAND' 																												=> 'ISL', 
										  uc_s = 'INDIA' 																													=> 'IND',
										  uc_s = 'INDONESIA' 																											=> 'IDN',
										  uc_s = 'IRELAND' 																												=> 'IRL',											
										  uc_s = 'ITALY' 																													=> 'ITA',      
										  uc_s = 'JAPAN' 																													=> 'JPN',											
										  uc_s = 'KOREA' 																													=> 'KOR',
										  uc_s = 'KYRGYZ REPUBLIC' 																								=> 'KGZ', 
										  uc_s = 'LIBERIA' 																												=> 'LBR',
										  uc_s = 'LUXEMBOURG' 																										=> 'LUX',											
										  uc_s = 'MALAYSIA' 																											=> 'MYS',   
										  uc_s = 'MANITOBA, CANADA' 																							=> 'MB',
										  uc_s = 'MARSHALL ISLANDS' 																							=> 'MHL',
										  uc_s = 'MAURITIUS' 																											=> 'MUS',  
										  uc_s = 'MEXICO' 																												=> 'MEX',
										  uc_s = 'NETHERLANDS' 																										=> 'NLD',
										  uc_s = 'NETHERLANDS ANTILLES' 																					=> 'NLD',
										  uc_s = 'NEW BRUNSWICK, CANADA'																					=> 'NB',
										  uc_s = 'NEW ZEALAND' 																										=> 'NZL',
										  uc_s = 'NEWFOUNDLAND AND LABRADOR' 																			=> 'NF',
										  uc_s = 'NIGERIA' 																												=> 'NGA',
										  uc_s = 'NORWAY' 																												=> 'NOR',     
										  uc_s = 'NOVA SCOTIA' 																										=> 'NS',
										  uc_s = 'NOVA SCOTIA, CANADA' 																						=> 'NS',
										  uc_s = 'ONTARIO, CANADA' 																								=> 'ON', 
										  uc_s = 'OTHER ASIA' 																										=> 'OA',
										  uc_s = 'OTHER S&C AMERICAN' 																						=> 'SA',
										  uc_s = 'PANAMA' 																												=> 'PAN',											
										  uc_s = 'PHILIPPINES' 																										=> 'PHL', 
										  uc_s = 'PORTUGAL' 																											=> 'PRT',   
										  uc_s = 'PRINCE EDWARD ISLAND' 																					=> 'PE',
										  uc_s = 'PUERTO RICO' 																										=> 'PRI',
										  uc_s = 'QUEBEC, CANADA'																									=> 'PQ',  
										  uc_s = 'REPUBLIC OF THE MARSHALL ISLANDS' 															=> 'MH',
										  uc_s = 'RUSSIA' 																												=> 'RUS',     
										  uc_s = 'SAINT LUCIA' 																										=> 'LCA',
										  uc_s = 'SASKATCHEWAN, CANADA' 																					=> 'SK',
										  uc_s = 'SCOTLAND' 																											=> 'SCT',												
										  uc_s = 'SINGAPORE' 																											=> 'SGP',  
										  uc_s = 'SLOVAKIA' 																											=> 'SVN',   
										  uc_s = 'SOUTH AFRICA' 																									=> 'ZAF',    
										  uc_s = 'SPAIN' 																													=> 'ESP',      
										  uc_s = 'ST. KITTS/NEVIS' 																								=> 'KNA', 
										  uc_s = 'SWEDEN' 																												=> 'SWE',     
										  uc_s = 'SWITZERLAND' 																										=> 'CHE',
										  uc_s = 'TAIWAN' 																												=> 'TWN',     
										  uc_s = 'TONGA' 																													=> 'TON',      
										  uc_s = 'TURKS/CAICOS ISLANDS' 																					=> 'TCA',
										  uc_s = 'UKRAINE' 																												=> 'UKR',    
										  uc_s = 'UNITED ARAB EMIRATES' 																					=> 'ARE',
										  uc_s = 'UNITED KINGDOM' 																								=> 'UKM',											
										  uc_s = 'UNITED STATES' 																									=> 'US',											
										  uc_s = 'UNITED STATES OF AMERICA'																				=> 'US',
										  uc_s = 'UNKNOWN JURISDICTION' 																					=> '',
										  uc_s = 'VENEZUELA' 																											=> 'VEN',  
										  uc_s = 'VIETNAM' 																												=> 'VNM',    
										  uc_s = 'WEST GERMANY' 																									=> 'DEU',    
										  uc_s = 'YAKAMA NATION' 																									=> 'US',   
										  uc_s = 'YAKIMA INDIAN NATION' 																					=> 'US',
										  '**|'+uc_s
										 ); 
		END;

		//****************************************************************************
		//CorpForgnStateCD: returns "corp_forgn_state_cd".
		//****************************************************************************
		EXPORT CorpForgnStateCD(STRING s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
					 fixed_spelling := map(uc_s = 'PHILLIPINES' => 'PHILIPPINES',
																 uc_s
																);
																
	         RETURN map(State_Desc_Translation(fixed_spelling)[1..2] 	 <> '**' => State_Desc_Translation(fixed_spelling),
											Foreign_Desc_Translation(fixed_spelling)[1..2] <> '**' => Foreign_Desc_Translation(fixed_spelling),
											'**|'+uc_s
										 );
		END;

		//****************************************************************************
		//CorpForgnStateDesc: returns "corp_forgn_state_desc".
		//****************************************************************************
		EXPORT CorpForgnStateDesc(string s) := FUNCTION

					 uc_s := corp2.t2u(s);
					 
					 fixed_spelling := map(uc_s = 'PHILLIPINES' => 'PHILIPPINES',
																 uc_s
																);

	         RETURN map(State_Desc_Translation(fixed_spelling)[1..2] <> '**'	 => fixed_spelling,					 
											Foreign_Desc_Translation(fixed_spelling)[1..2] <> '**' => fixed_spelling,
											'**|'+uc_s
										 );
		END;

END;
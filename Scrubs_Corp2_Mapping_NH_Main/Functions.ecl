IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//valid_address1_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_address1_type_cd(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidCD			 		  	:= map(uc_code in ['B','M',''] => true,false);
					 RETURN if(isValidCD,1,0);
		END;
		
		//****************************************************************************
		//valid_address1_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_address1_type_desc(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidDesc		 		  	:= map(uc_code in ['BUSINESS','MAILING'] 	=> true,
																				 uc_code in [''] 										=> true,
																				 false
																				);
					 RETURN if(isValidDesc,1,0);
		END;		

		//****************************************************************************
		//valid_ra_address_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_ra_address_type_cd(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidCD			 		  	:= map(uc_code in ['R','M',''] => true,false);
					 RETURN if(isValidCD,1,0);
		END;
		
		//****************************************************************************
		//valid_ra_address_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_ra_address_type_desc(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidDesc				  	:= map(uc_code in ['REGISTERED OFFICE'] 						=> true,
																				 uc_code in ['MAILING ADDRESS'] 	            => true,
																				 uc_code in [''] 															=> true,
																				 false
																				);
					 RETURN if(isValidDesc,1,0);
		END;
		
		//****************************************************************************
		//valid_contact_address_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_contact_address_type_cd(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidCD			 		  	:= map(uc_code in ['T',''] => true,false);
					 RETURN if(isValidCD,1,0);
		END;
		
		//****************************************************************************
		//valid_contact_address_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_contact_address_type_desc(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidDesc				  	:= map(uc_code in ['CONTACT'] 						=> true,
																				 uc_code in ['']										=> true,
																				 false
																				);
					 RETURN if(isValidDesc,1,0);
		END;			

		//****************************************************************************
		//valid_address_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_address_type_cd(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidCD			 		  	:= map(uc_code in ['T',''] => true,false);
					 RETURN if(isValidCD,1,0);
		END;

		//****************************************************************************
		//valid_address_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_address_type_desc(STRING s) := FUNCTION
					 uc_s 									:= corp2.t2u(s);
					 isValidDesc			 		  := map(uc_s in ['BUSINESS','MAILING','REGISTERED OFFICE',''] => true,false
																				);
						RETURN if(isValidDesc,1,0);
		END;
		
		//****************************************************************************
		//valid_corp_status_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_corp_status_desc(STRING s) := FUNCTION
					 uc_s 						 	 := corp2.t2u(s);
					 isValidDesc			 	 := map(uc_s in ['ACCEPTANCE INACTIVE','ACTIVE','ADMIN DISS LLP-CC-NP','ADMINISTRATIVE DISSOLUTION',
																							 'ADMINISTRATIVE DISSOLUTION LLP-CC-NP','ADMIN. SUSPENSION','ADMINISTRATIVE SUSPENSION',
																							 'ADMINISTRATIVELY DISSOLVED NAME PROTECTION','ADMINISTRATIVELY SUSPENDED',
																							 'ADMINISTRATIVELY SUSPENDED NAME','CONSOLIDATED INACTIVE','CONVERTED','CREATION INACTIVE',
																							 'DISSOLVED','DISSOLVED NAME PROTECTED','DOMESTIC BANK','DOMESTIC FOUNDATION','EXPIRED',
																							 'EXPIRED PENDING','FOREIGN BANK','FORFEITED','FUTURE EFFECTIVE','GOOD STANDING','HOLD',
																							 'INACTIVE','MERGED','NON-QUALIFIED','NOT IN GOOD STANDING','PARENT/OWNER DISSOLVED',
                                               'PENDING DISSOLUTION','REJECTED','REJECTION NAME PROTECTED','RESERVED NAME',
																							 'RESERVED NAME CANCELLED','RESERVED NAME EXPIRED','TRANSACTION INACTIVE','WITHDRAWN',
																							 'WITHDRAWN BY MERGER',''] => true,false
																		 );
						RETURN if(isValidDesc,1,0);
		END;
		
		
		//****************************************************************************
		//valid_corp_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_corp_type_desc(STRING s) := FUNCTION
					 uc_s			  						:= corp2.t2u(s);
					 isValidDesc			 		  := map(uc_s in ['DOMESTIC LIMITED LIABILITY COMPANY','FOREIGN PROFIT CORPORATION',
																								  'FOREIGN LIMITED LIABILITY COMPANY','DOMESTIC PROFIT CORPORATION',
																								  'DOMESTIC PROFESSIONAL LIMITED LIABILITY COMPANY',
																								  'DOMESTIC PROFESSIONAL PROFIT CORPORATION',
																								  'DOMESTIC NONPROFIT CORPORATION','DOMESTIC LIMITED LIABILITY PARTNERSHIP',
																								  'FOREIGN LIMITED PARTNERSHIP','FOREIGN PROFESSIONAL PROFIT CORPORATION',
																								  'FOREIGN NONPROFIT CORPORATION','FOREIGN LIMITED LIABILITY PARTNERSHIP',
																								  'DOMESTIC LIMITED PARTNERSHIP','DOMESTIC CONSUMER COOPERATIVE',
																								  'FOREIGN PROFESSIONAL LIMITED LIABILITY COMPANY',
																								  'DOMESTIC BENEFIT CORPORATION','CORRESPONDENCE',
																									'FORCED DBA','TRADE NAME','FOREIGN REGISTERED CORPORATE NAME',''] => true,false
																				);
						RETURN if(isValidDesc,1,0);
		END;

		//****************************************************************************
		//valid_forgn_us_state_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT valid_forgn_us_state_cd(STRING s) := FUNCTION

			 uc_s := corp2.t2u(s);
					 
			 RETURN map(uc_s in ['AL','AK','AR','AS','AZ'] 								=> true,
									uc_s in ['CA','CO','CT','CZ']											=> true,
									uc_s in ['DC','DE']																=> true,
									uc_s in ['FL']																		=> true,
									uc_s in ['GA','GU']																=> true,
									uc_s in ['HI']																		=> true,
									uc_s in ['IA','ID','IL','IN']			 								=> true,
									uc_s in ['KS','KY']																=> true, 
									uc_s in ['LA']																		=> true,
									uc_s in ['MA','MD','ME','MI','MN','MO','MS','MT'] => true,
									uc_s in ['NC','ND','NE','NH','NJ','NM','NV','NY'] => true,
									uc_s in ['OH','OK','OR']													=> true,
									uc_s in ['PA','PR']																=> true,
									uc_s in ['RI']																	 	=> true,
									uc_s in ['SC','SD']																=> true,
									uc_s in ['TN','TX']															  => true,
									uc_s in ['US','UT']																=> true,
									uc_s in ['VA','VI','VT']													=> true,
									uc_s in ['WA','WI','WV','WY']											=> true,
									uc_s in ['']  																		=> true,
									false
								 );
		END;

		//****************************************************************************
		//valid_forgn_non_us_state_cd: returns true or false based upon the incoming
		//																code.
		//****************************************************************************
		EXPORT valid_forgn_non_us_state_cd(STRING s) := FUNCTION

			 uc_s := corp2.t2u(s);
			 
			 RETURN map(uc_s in ['AD','AU']								=> true,
									uc_s in ['BC','BE','BI','BM']			=> true,
									uc_s in ['CO']										=> true,
									uc_s in ['DK']										=> true,
									uc_s in ['EC','EN']								=> true,
									uc_s in ['FC','FR']								=> true,
									uc_s in ['GE','GG']								=> true,
									uc_s in ['ON']										=> true,
									uc_s in ['HK']										=> true,
									uc_s in ['IN','IT']								=> true,
									uc_s in ['JA']										=> true,
									uc_s in ['KN','KO']								=> true,
									uc_s in ['LI','LU']								=> true,
									uc_s in ['MX']										=> true,
									uc_s in ['NA','NC']								=> true,
									uc_s in ['PG','PH']								=> true,
									uc_s in ['RP']										=> true,
									uc_s in ['SL','SW']								=> true,
									uc_s in ['TC']										=> true,
									uc_s in ['UK','UR']								=> true,
									uc_s in ['VG']										=> true,
									uc_s in ['WN']										=> true,
									uc_s in ['ZA']   									=> true,
									false
								 );
								 
		END;

		//********************************************************************
		//valid_corp_forgn_state_cd: returns true or false based upon the
		//															incoming code.
		//********************************************************************	
		EXPORT valid_corp_forgn_state_cd(STRING s) := FUNCTION

			 uc_s  			:= corp2.t2u(s);
					 
			 isValidCD :=  map(valid_forgn_us_state_cd(uc_s)			=> true,
												//valid_forgn_non_us_state_cd(uc_s)	=> true,
												 false
											  );
			 RETURN if(isValidCD,1,0);

		END;		

		//****************************************************************************
		//valid_forgn_us_state_desc: returns true or false based upon the incoming
		//															code.
		//****************************************************************************
		EXPORT valid_forgn_us_state_desc(STRING s) := FUNCTION

			 uc_s := corp2.t2u(s);
					 
			 RETURN map(uc_s in ['ALABAMA','ALASKA','ARKANSAS','AMERICAN SAMOA','ARIZONA',
													 'CALIFORNIA','CANAL ZONE','CAYMAN ISLANDS','COLORADO','CONNECTICUT',
													 'DELAWARE','DISTRICT OF COLUMBIA','FLORIDA','GEORGIA','GUAM','HAWAII',
													 'IDAHO','ILLINOIS','INDIANA','IOWA','KANSAS','KENTUCKY' ,'LOUISIANA',
													 'MAINE','MARYLAND','MASSACHUSETTS','MICHIGAN','MINNESOTA','MISSISSIPPI',
													 'MISSOURI','MONTANA','NEBRASKA','NEVADA','NORTH CAROLINA','NORTH DAKOTA',
													 'NEW HAMPSHIRE','NEW JERSEY','NEW MEXICO','NEW YORK','OHIO','OKLAHOMA',
													 'OREGON','PENNSYLVANIA','PUERTO RICO','RHODE ISLAND','SOUTH CAROLINA',
													 'SOUTH DAKOTA','TENNESSEE','TEXAS','UNITED STATES','UTAH','VERMONT',
													 'VIRGIN ISLANDS','VIRGINIA','WASHINGTON','WEST VIRGINIA','WISCONSIN',
													 'WYOMING',''] => true,false);
		END;

		//****************************************************************************
		//valid_forgn_non_us_state_desc: returns true or false based upon the
		//																  incoming code.
		//****************************************************************************
		EXPORT valid_forgn_non_us_state_desc(STRING s) := FUNCTION

			 uc_s := corp2.t2u(s);

			 RETURN map(uc_s in ['ALBANIA','ANDORRA','ARMENIA','AUSTRALIA','BANGLADESH','BARBADOS',
													 'BELGIUM','BELIZE','BERMUDA','BRAZIL','CANADA','CHINA',
													 'CZECH REPUBLIC','DENMARK','FRANCE','GERMANY','GUATEMALA','HONG KONG',
													 'HUNGARY','INDIA','IRELAND','ISRAEL','ITALY','JAPAN',
													 'MEXICO','NEPAL','NETHERLANDS','NORWAY','PAKISTAN','PANAMA',
													 'PHILIPPINES','PUERTO RICO','QATAR','REUNION','SAUDI ARABIA','SINGAPORE',
													 'SLOVAKIA (SLOVAK REPUBLIC','SPAIN','SWEDEN','SWITZERLAND',
													 'TURKEY','UNITED ARAB EMIRATES','UNITED KINGDOM','UNITED STATES',
													 'UNITED STATES MINOR OUTLYING ISLANDS','URUGUAY','USA','UZBEKISTAN','VIET NAM',
													 'VIRGIN ISLANDS (U.S)',''] => true,false
								 );

		END;

		//********************************************************************
		//valid_corp_forgn_state_desc: returns true or false based upon the
		//															  incoming code.
		//********************************************************************	
		EXPORT valid_corp_forgn_state_desc(STRING s) := FUNCTION

			 uc_s  				:= corp2.t2u(s);
					 
			 isValidDesc 	:= MAP(valid_forgn_us_state_desc(uc_s)			=> true,
													 valid_forgn_non_us_state_desc(uc_s)	=> true,
													 false
													);
			 
			 RETURN if(isValidDesc,1,0);

		END;
		
		//****************************************************************************
		//valid_name_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_name_type_cd(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidCD			 		  	:= map(uc_code in ['P','01','03','05','10','11',''] => true,false);

					 RETURN if(isValidCD,1,0);
		END;

		//****************************************************************************
		//valid_name_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_name_type_desc(STRING s) := FUNCTION
					 uc_s 									:= corp2.t2u(s);
					 isValidDesc			 		  := map(uc_s in ['HOME STATE','LEGAL','DBA','PRIOR',
																									'TRADENAME','FOREIGN REGISTERED NAME',''] => true,false
																				);
						RETURN if(isValidDesc,1,0);
		END;	

END;
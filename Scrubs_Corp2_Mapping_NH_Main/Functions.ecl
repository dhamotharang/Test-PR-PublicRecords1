IMPORT corp2;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//valid_address1_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_address1_type_cd(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidCD			 		  	:= map(uc_code in ['A','B','L','M','O','PM','PP','PU','Q','U','W',''] => true,false);
					 RETURN if(isValidCD,1,0);
		END;
		
		//****************************************************************************
		//valid_address1_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_address1_type_desc(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidDesc		 		  	:= map(uc_code in ['ANNUAL REPORT','BUSINESS','LISTING'] 	=> true,
																				 uc_code in ['MAILING','OTHER','PREVIOUS MAILING'] 	=> true,
																				 uc_code in ['PREVIOUS BUSINESS','PREVIOUS UCC'] 		=> true,
																				 uc_code in ['QUICK ACCOUNT','UCC','WITHDRAWAL'] 		=> true,
																				 uc_code in [''] 																		=> true,
																				 false
																				);
					 RETURN if(isValidDesc,1,0);
		END;		

		//****************************************************************************
		//valid_ra_address_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_ra_address_type_cd(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidCD			 		  	:= map(uc_code in ['PR','PRM','R',''] => true,false);
					 RETURN if(isValidCD,1,0);
		END;
		
		//****************************************************************************
		//valid_ra_address_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_ra_address_type_desc(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidDesc				  	:= map(uc_code in ['REGISTERED OFFICE'] 						=> true,
																				 uc_code in ['PREVIOUS REGISTERED MAILING'] 	=> true,
																				 uc_code in ['PREVIOUS REGISTERED OFFICE'] 		=> true,
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
		//valid_addresstypeid: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_addresstypeid(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidCD			 		  	:= map(uc_code in ['1','6','7','8','9','10','11','14','15','16','17','18','19','24',''] => true,false);
					 RETURN if(isValidCD,1,0);
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
					 isValidDesc			 		  := map(uc_s in ['BUSINESS','CONTACT','MAILING','PREVIOUS REGISTERED MAILING',
																									'PREVIOUS REGISTERED OFFICE','REGISTERED OFFICE',
																									''] => true,false
																				);
						RETURN if(isValidDesc,1,0);
		END;
		
		//****************************************************************************
		//valid_corp_status_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_corp_status_cd(STRING code) := FUNCTION
					 uc_code 						 := corp2.t2u(code);
					 isValidCD			 		 := map(uc_code in ['1','2','3','4','5','7','8','9','11','24',
																									'25','26','27','28','29','30','31','33','34',
																									'35','36','37','38','39','40','41','42',''] => true,false
																		 );
						RETURN if(isValidCD,1,0);
		END;
		
		//****************************************************************************
		//valid_corp_status_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_corp_status_desc(STRING s) := FUNCTION
					 uc_s 						 	 := corp2.t2u(s);
					 isValidDesc			 	 := map(uc_s in ['ABANDONED','ACCEPTANCE INACTIVE','ACTIVE','ADMIN DISS LLP-CC-NP',
																							 'ADMIN DISSOLUTION','ADMIN. SUSPENSION','CONSOLIDATED INACTIVE',
																							 'CREATION INACTIVE','CONVERTED','DISSOLVED','DOMESTICATED','EXPIRED',
																							 'FORFEITED','GOOD STANDING','IN PROCESS','INACTIVE','MERGED',
																							 'NON-QUALIFIED','NOT IN GOOD STANDING','OBJECTION','PARENT/OWNER DISSOLVED',
																							 'PENDING','RESERVED NAME','SURRENDERED','TRANSACTION INACTIVE',
																							 'WITHDRAWN','WITHDRAWN BY MERGER',''] => true,false
																		 );
						RETURN if(isValidDesc,1,0);
		END;
		
		//****************************************************************************
		//valid_corp_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_corp_type_cd(STRING code) := FUNCTION
					 uc_code 						 := corp2.t2u(code);
					 isValidCD			 		 := map(uc_code in ['12','16','18','19','20','25','26','58',
																									'63','71','72','73','74','75','76','77',
																									'78','79','80','82','83','84','87','88',''] => true,false
																		 );

						RETURN if(isValidCD,1,0);
		END;
		
		//****************************************************************************
		//valid_corp_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_corp_type_desc(STRING s) := FUNCTION
					 uc_s			  						:= corp2.t2u(s);
					 isValidDesc			 		  := map(uc_s in ['AGRICULTURAL COOP','BANK','BUILDING AND LOAN (BANK)',
																									'CONSUMER COOPERATIVES','CORPORATION','FEDERALLY CHARTERED',
																									'FOREIGN BUSINESS TRUST','FOREIGN CORP REGISTERED NAME', 
																									'GUARANTY SAVINGS','INSURANCE COMPANY','LIMITED LIABILITY COMPANY', 
																									'LIMITED LIABILITY PARTNERSHIP','LIMITED PARTNERSHIP','MERCHANT BANK',
																									'MUTUAL HOLDING COMPANY','NH INVESTMENT TRUSTS','NON-PROFIT CORPORATION',
																									'PARTNERSHIP','PROFESSIONAL ASSOCIATION','PROFESSIONAL LIMITED LIABILITY COMPANY',
																									'PROFESSIONAL LIMITED LIABILITY PARTNERSHIP','STATE CHARTERED (LEGISLATIVE)',
																									'TRADE NAME','TRUST COMPANY',''] => true,false
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
					 isValidCD			 		  	:= map(uc_code in ['P','01','03','04','07',''] => true,false);

					 RETURN if(isValidCD,1,0);
		END;

		//****************************************************************************
		//valid_name_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_name_type_desc(STRING s) := FUNCTION
					 uc_s 									:= corp2.t2u(s);
					 isValidDesc			 		  := map(uc_s in ['HOME STATE','LEGAL','PREV HOME STATE','PREV LEGAL',
																									'PREV TRADE NAME','RESERVED','TRADE NAME',''] => true,false
																				);
						RETURN if(isValidDesc,1,0);
		END;	

		//****************************************************************************
		//valid_party_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_party_type_cd(STRING code) := FUNCTION
					 uc_code								:= corp2.t2u(code);
					 isValidCD			 		  	:= map(uc_code in ['1000','1001','1007','1021','1022','1023',
																										'1024','1025','1027','1030','2000','2001',
																										'2002','2003','2004','2005','2008','2009',
																										'3000','3001','3002','3003','3004',''] => true,false
																				);
					 RETURN if(isValidCD,1,0);
		END;


		//****************************************************************************
		//valid_party_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT valid_party_type_desc(STRING s) := FUNCTION
					 uc_s 									:= corp2.t2u(s);
					 isValidDesc			 		  := map(uc_s in ['ASSISTANT SECRETARY','ASSISTANT TREASURER','ATTORNEY-IN-FACT',
																									'AUTHORIZED PARTY','CHAIRMAN OF THE BOARD OF DIRECTORS',
																									'COURT-APPOINTED FIDUCIARY','DIRECTOR ONLY','DIRECTOR NAME',
																									'INCORPORATOR NAME','MANAGER NAME','MEMBER NAME','ORGANIZER',
																									'OTHER','OTHER FIDUCIARY','GENERAL PARTNER','PARTNER NAME',
																									'PRESIDENT','REGISTERED AGENT WITH POWER OF ATTORNEY','REGISTRANT',
																									'SECRETARY','TREASURER','TRUSTEE','VICE PRESIDENT',''] => true,false
																				);
						RETURN if(isValidDesc,1,0);
		END;

END;
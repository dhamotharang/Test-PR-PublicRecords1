IMPORT corp2, corp2_raw_wy;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_ln_name_type_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_ln_name_type_cd(STRING s, STRING recordorigin) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 uc_ro 		:= corp2.t2u(recordorigin);
			 
			isValidCD := if(uc_ro = 'C',
											map(uc_s in ['01','03','04','07','P'] 								=> true,
												  false
											),
											true //For contact records, corp_ln_name_type_cd doesn't have to exist
										 );

			 RETURN if(isValidCD,1,0);

		END;

		//****************************************************************************
		//invalid_ln_name_type_desc: 	returns true or false based upon the incoming
		//														code.
		//****************************************************************************
		EXPORT invalid_ln_name_type_desc(STRING s, STRING recordorigin) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
			 uc_ro 		:= corp2.t2u(recordorigin);
					 
			isValidDesc := if(uc_ro = 'C',
												map(uc_s in ['LEGAL','PRIOR','RESERVED']						=> true,
														uc_s in ['TRADEMARK','TRADENAME'] 							=> true,
														false
													 ),
												true //For contact records, corp_ln_name_type_desc doesn't have to exist
											 );


			 RETURN if(isValidDesc,1,0);

		END;

		//****************************************************************************
		//valid_forgn_us_state_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT valid_forgn_us_state_cd(STRING s) := FUNCTION

			 uc_s 		:= corp2.t2u(s);
					 
			isValidCD := map(uc_s in ['AL','AK','AR','AS','AZ'] 								=> true,
											 uc_s in ['CA','CO','CT','CZ']											=> true,
											 uc_s in ['DC','DE']																=> true,
											 uc_s in ['FL']																			=> true,
											 uc_s in ['GA','GU']																=> true,
											 uc_s in ['HI']																			=> true,
											 uc_s in ['IA','ID','IL','IN']			 								=> true,
											 uc_s in ['KS','KY']																=> true, 
											 uc_s in ['LA']																			=> true,
											 uc_s in ['MA','MD','ME','MI','MN','MO','MS','MT'] 	=> true,
											 uc_s in ['NC','ND','NE','NH','NJ','NM','NV','NY'] 	=> true,
											 uc_s in ['OH','OK','OR']														=> true,
											 uc_s in ['PA','PR']																=> true,
											 uc_s in ['RI']																	 		=> true,
											 uc_s in ['SC','SD']																=> true,
											 uc_s in ['TN','TX']															  => true,
											 uc_s in ['US','UT']																=> true,
											 uc_s in ['VA','VI','VT']														=> true,
											 uc_s in ['WA','WI','WV','WY']											=> true,
											 uc_s in ['']  																			=> true,
											 false
										  );

			 RETURN if(isValidCD,1,0);

		END;


		//****************************************************************************
		//valid_forgn_non_us_state_cd: returns true or false based upon the incoming
		//														 code.
		//****************************************************************************
		EXPORT valid_forgn_non_us_state_cd(STRING s) := FUNCTION

			uc_s 			:= corp2.t2u(s);
			 
			isValidCD := map(uc_s in ['AD','AE','AU']						=> true,
											 uc_s in ['BC','BE','BI','BM']			=> true,
											 uc_s in ['CO']											=> true,
											 uc_s in ['DK']											=> true,
											 uc_s in ['EC','EN']								=> true,
											 uc_s in ['FC','FR']								=> true,
											 uc_s in ['GE','GG']								=> true,
											 uc_s in ['ON']											=> true,
											 uc_s in ['HK']											=> true,
											 uc_s in ['IN','IT']								=> true,
											 uc_s in ['JA']											=> true,
											 uc_s in ['KN','KO']								=> true,
											 uc_s in ['LI','LU']								=> true,
											 uc_s in ['MX']											=> true,
											 uc_s in ['NA','NC']								=> true,
											 uc_s in ['PG','PH']								=> true,
											 uc_s in ['RP']											=> true,
											 uc_s in ['SL','SW']								=> true,
											 uc_s in ['TC']											=> true,
											 uc_s in ['UK','UR']								=> true,
											 uc_s in ['VG']											=> true,
											 uc_s in ['WN']											=> true,
											 uc_s in ['ZA']   									=> true,
											 false
										  );

			 RETURN if(isValidCD,1,0);

		END;
																
																
		//********************************************************************
		//valid_corp_forgn_state_cd: returns true or false based upon the
		//													 incoming code.
		//********************************************************************	
		EXPORT valid_corp_forgn_state_cd(STRING s) := FUNCTION

			uc_s  		:= corp2.t2u(s);
					 
			isValidCD := map(valid_forgn_us_state_cd(uc_s)<>0			=> true,
											 valid_forgn_non_us_state_cd(uc_s)<>0	=> true,
											 false
										  );

			 RETURN if(isValidCD,1,0);

		END;		
			
		//****************************************************************************
		//valid_forgn_us_state_desc: returns true or false based upon the incoming
		//													 code.
		//****************************************************************************
		EXPORT valid_forgn_us_state_desc(STRING s) := FUNCTION

			uc_s 				:= corp2.t2u(s);
					 
			isValidDesc	:= map(uc_s in ['ALABAMA','ALASKA','ARKANSAS','AMERICAN SAMOA','ARIZONA',
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

			 RETURN if(isValidDesc,1,0);
			 
		END;
		
		//****************************************************************************
		//valid_forgn_non_us_state_desc: returns true or false based upon the
		//															 incoming code.
		//****************************************************************************
		EXPORT valid_forgn_non_us_state_desc(STRING s) := FUNCTION

			 uc_s := corp2.t2u(s);

			isValidDesc	:= map(uc_s in ['ARUBA','AUSTRALIA','BAHAMAS','BELGIUM','BERMUDA','BRITISH COLUMBIA'
																	,'BRITISH WEST INDIES','COLOMBIA','DENMARK','ECUADOR','ENGLAND','FEDERAL CHARTER'
																	,'FEDERATED CHARTERED','FRANCE','GERMANY','GUERNSEY','ONTARIO, CANADA','HONG KONG'
																	,'HONG KONG SAR','INDIA','ITALY','JAPAN','KOREA','LIECHTENSTEIN','LUXEMBOURG'
																	,'MEXICO','NETHERLANDS ANTILLES','CANADA','PARAGUAY','PANAMA','PHILIPPINES'	
																	,'ST. KITTS AND NEVIS','SCOTLAND','SOUTH AFRICA','SWITZERLAND','TRIBAL','TURKS AND CAICOS ISLANDS'
																	,'UNITED KINGDOM','URUGUAY','UNITED ARAB EMIRATES','VIRGIN ISLANDS, BRITISH']	=> true,false);

			 RETURN if(isValidDesc,1,0);
		
		END;
                                                      
		//********************************************************************
		//valid_corp_forgn_state_desc: returns true or false based upon the
		//														 incoming code.
		//********************************************************************	
		EXPORT valid_corp_forgn_state_desc(STRING s) := FUNCTION

			 uc_s  			:= corp2.t2u(s);
					 
			 isValidCD 	:= MAP(valid_forgn_us_state_desc(uc_s)<>0			=> true,
												 valid_forgn_non_us_state_desc(uc_s)<>0	=> true,
												 false
											  );
			 
			 RETURN if(isValidCD,1,0);

		END;		
		
END;
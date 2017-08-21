IMPORT corp2, corp2_mapping, corp2_raw_me, ut;

EXPORT Functions := Module

		//****************************************************************************
		//State_Description: returns whether the state is a valid us state.
		//****************************************************************************
		EXPORT State_Description(STRING s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'AL' => 'ALABAMA',
											uc_s = 'AK' => 'ALASKA', 
											uc_s = 'AR' => 'ARKANSAS', 
											uc_s = 'AS' => 'AMERICAN SAMOA', 
											uc_s = 'AZ' => 'ARIZONA', 
											uc_s = 'BI' => 'BAHAMA ISLANDS',
											uc_s = 'CA' => 'CALIFORNIA',
											uc_s = 'CI' => 'CAYMAN ISLANDS',											
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
		//Country_Description: returns whether the country is a valid country.
		//****************************************************************************
		EXPORT Country_Description(STRING s) := FUNCTION

					 uc_s := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

	         RETURN map(uc_s = 'AB'	 => 'ALBERTA',
											uc_s = 'AUS' => 'AUSTRALIA', 
											uc_s = 'BAR' => 'BARBADOS', 
											uc_s = 'BC'  => 'BRITISH COLUMBIA', 
											uc_s = 'BEL' => 'BELGIUM', 
											uc_s = 'BER' => 'BERMUDA', 
											uc_s = 'BRZ' => 'BRAZIL',
											uc_s = 'BWI' => 'BRITISH WEST INDIES',
											uc_s = 'CAN' => 'CANADA', 
											uc_s = 'CHI' => 'CHANNEL ISLANDS', 
											uc_s = 'CI'  => 'CAYMAN ISLANDS',
											uc_s = 'CKN' => 'CHEROKEE NATION',
											uc_s = 'CR'  => 'COSTA RICA', 
											uc_s = 'COK' => 'COOK ISLANDS',
											uc_s = 'CUB' => 'CUBA',
											uc_s = 'DK'  => 'DENMARK',
											uc_s = 'ENG' => 'ENGLAND', 
											uc_s = 'FIN' => 'FINLAND', 
											uc_s = 'FRA' => 'FRANCE', 
											uc_s = 'GER' => 'GERMANY', 
											uc_s = 'HUN' => 'HUNGARY', 
											uc_s = 'ICE' => 'ICELAND',
											uc_s = 'IND' => 'INDIA', 
											uc_s = 'IR'  => 'IRAN', 
											uc_s = 'IRE' => 'IRELAND', 
											uc_s = 'ISR' => 'ISRAEL',
											uc_s = 'IT'  => 'ITALY', 
											uc_s = 'JPN' => 'JAPAN', 
											uc_s = 'KOR' => 'REPUBLIC OF KOREA',
											uc_s = 'LIE' => 'PRIN OF LIECHTENSTEIN', 											
											uc_s = 'LUX' => 'LUXEMBOURG',
											uc_s = 'MAN' => 'MANITOBA',
											uc_s = 'MAU' => 'REPUBLIC OF MAURITIUS',
											uc_s = 'MB'  => 'MANITOBA',
											uc_s = 'MEX' => 'MEXICO',
											uc_s = 'MH'  => 'MARSHALL ISLANDS',
											uc_s = 'NA'  => '',
											uc_s = 'NAN' => 'NETHERLANDS ANTILLES', 
											uc_s = 'NB'  => 'NEW BRUNSWICK',
											uc_s = 'NET' => 'THE NETHERLANDS',
											uc_s = 'NF'  => 'NORFOLK ISLAND',
											uc_s = 'NFL' => 'NEWFOUNDLAND',
											uc_s = 'NOR' => 'NORWAY', 
											uc_s = 'NS'  => 'NOVA SCOTIA', 
											uc_s = 'ON'  => 'ONTARIO',
											uc_s = 'ONT' => 'ONTARIO', 
											uc_s = 'PAN' => 'PANAMA', 
											uc_s = 'PEI' => 'PRINCE EDWARD ISLAND',
											uc_s = 'PHI' => 'PHILIPPINES',
											uc_s = 'POL' => 'POLAND',
											uc_s = 'PQ'	 => 'QUEBEC',
											uc_s = 'PRC' => 'PEOPLES REPUBLIC OF CHINA',
											uc_s = 'QC'  => 'QUEBEC',
											uc_s = 'SCT' => 'SCOTLAND',
											uc_s = 'SGP' => 'SINGAPORE',
											uc_s = 'SJR' => 'STATES OF JERSEY',
											uc_s = 'SK'  => 'SASKATCHEWAN', 
											uc_s = 'SP'  => 'SPAIN',
											uc_s = 'SW'  => 'SWEDEN',
											uc_s = 'SZ'  => 'SWAZILAND',
											uc_s = 'TCI' => 'TURKS AND CAICOS ISLANDS',
											uc_s = 'UK'  => 'UNITED KINGDOM',
											uc_s = 'UAE' => 'UNITED ARAB EMIRATES',
											uc_s = 'USA' => 'US', 
											uc_s = 'UY'  => 'URUGUAY',
											uc_s = 'WG'  => 'WEST GERMANY', 
											uc_s = ''    => '',
											'**|'+uc_s
										 );

		END;

		//****************************************************************************
		//CorpForgnStateDesc: Returns "corp_forgn_state_desc".
		//****************************************************************************		
		EXPORT CorpForgnStateDesc(STRING s) := FUNCTION

			uc_s  := corp2.t2u(s);
			
			RETURN map(stringlib.stringfind(State_Description(uc_s),'**',1) 	= 0 => State_Description(uc_s),
								 stringlib.stringfind(Country_Description(uc_s),'**',1) = 0 => Country_Description(uc_s),
								 '**|'+uc_s
								);

		END;

		//****************************************************************************
		//CorpCountryOfFormation: Returns "corp_country_of_formation".
		//****************************************************************************		
		EXPORT CorpCountryOfFormation(STRING s) := FUNCTION

			uc_s  := corp2.t2u(s);
			
			RETURN map(stringlib.stringfind(State_Description(uc_s),'**',1) 	= 0 => 'US',
								 stringlib.stringfind(Country_Description(uc_s),'**',1) = 0 => Country_Description(uc_s),
								 '**|'+uc_s
								);

		END;

		//****************************************************************************
		//CorpOrigOrgStructureDesc: Returns "corp_orig_org_structure_desc".
		//****************************************************************************		
		EXPORT CorpOrigOrgStructureDesc(STRING s) := FUNCTION

			uc_s  := corp2.t2u(s);
			
			RETURN case(uc_s,
									'B'		=>'BANK CORPORATION',
									'C'		=>'APPOINTMENT OF SERVICE OF PROCESS',
									'D'		=>'BUSINESS CORPORATION',
									'F'		=>'BUSINESS CORPORATION (FOREIGN)',
									'I'		=>'INSURANCE CORPORATION',
									'L'		=>'LOCAL INDEPENDENT CHURCH (TITLE 13 MRSA, CHAPTER 93)',
									'N'		=>'NONPROFIT CORPORATION (TITLE 13 MRSA, CHAPTER 81)',
									'P'		=>'PENDING WORK',
									'R'		=>'',	//'NAME REGISTRATION (BUSINESS)'
									'CP'	=>'COOPERATIVE CORPORATION',
									'CR'	=>'', //'NAME REGISTRATION (LIMITED LIABILITY COMPANY)'
									'DC'	=>'LIMITED LIABILITY COMPANY (DOMESTIC)',
									'DP'	=>'LIMITED LIABILITY PARTNERSHIP (DOMESTIC)',
									'FC'	=>'LIMITED LIABILITY COMPANY (FOREIGN)',
									'FP'	=>'LIMITED LIABILITY PARTNERSHIP (FOREIGN)',
									'GP'	=>'GENERAL PARTNERSHIP',
									'LF'	=>'LIMITED PARTNERSHIP (FOREIGN)',
									'LN'	=>'', //'RESERVED NAME (LIMITED PARTNERSHIP)'
									'LP'	=>'LIMITED PARTNERSHIP',
									'LR'	=>'', //'NAME REGISTRATION (LIMITED PARTNERSHIP)'
									'ND'	=>'NONPROFIT CORPORATION (TITLE 13-B MRSA)',
									'NF'	=>'NONPROFIT CORPORATION (FOREIGN)',
									'NR'	=>'', //'NAME REGISTRATION (NONPROFIT)',
									'PR'	=>'', //'NAME REGISTRATION (LIMITED LIABILITY PARTNERSHIP)'
									'RC'	=>'', //'RESERVED NAME (LIMITED LIABILITY COMPANY)'
									'RD'	=>'', //'RESERVED NAME (BUSINESS)'
									'RI'	=>'', //'INTERIM RESERVED NAME'
									'RN'	=>'', //'RESERVED NAME (NONPROFIT)'
									'RP'	=>'', //'RESERVED NAME (LIMITED LIABILITY PARTNERSHIP)'
									'RR'	=>'', //'RAILROAD CORPORATION'
									'**|'+uc_s
									);
		END;
		
		//****************************************************************************
		//CorpStatusDesc: Returns "corp_status_desc".
		//****************************************************************************		
		EXPORT CorpStatusDesc(STRING s) := FUNCTION

			uc_s  := corp2.t2u(s);
			
			RETURN case(uc_s,
									'ABD'		=>'ABANDONMENT OF DOMESTICATION',
									'ADI'		=>'ADMINISTRATIVELY DISSOLVED',
									'CAN'		=>'CANCELLED',
									'CON'		=>'CONSOLIDATED',
									'COV'		=>'CONVERSION',
									'DEA'		=>'INACTIVE-UNKNOWN REASON',
									'DIS'		=>'DISSOLVED',
									'EXC'		=>'EXCUSED',
									'EXP'		=>'EXPIRED',
									'FIE'		=>'FILED IN ERROR',
									'FIL'		=>'GOOD STANDING',
									'GP'		=>'GENERAL PARTNERSHIP OPTIONAL FILING - NO STATUS WITH SOS',
									'INF'		=>'INFORMATIONAL STATUS',
									'MER'		=>'MERGED',
									'NGS'		=>'NOT IN GOOD STANDING',
									'QUA'		=>'QUALIFIED (FORMERLY REGISTERED)',
									'RDM'		=>'REDOMESTICATION',
									'REV'		=>'REVOKED',
									'RIV'		=>'REVIVAL - LEGALLY EXISTING',
									'RNN'		=>'RENUNCIATION OF LIMITED LIABILITY PARTNERSHIP',
									'SUR'		=>'AUTHORITY SURRENDERED',
									'SUS'		=>'SUSPENDED',
									'TAO'		=>'REMOVED - ADMINISTRATIVE ORDER',
									'TCO'		=>'REMOVED - COURT ORDER',
									'TIF'		=>'REMOVED - INSUFFICIENT FUNDS',
									'VGS'		=>'GOOD STANDING',
									''			=>'',
									'**|'+uc_s
								 );

		END;

		//****************************************************************************
		//LNNameTypeCD: Returns "corp_ln_name_type_cd".
		//Note: nt => name_type
		//			id => corp_id[9..10]
		//****************************************************************************		
		EXPORT LNNameTypeCD(STRING nt, STRING id) := FUNCTION

			uc_nt  := corp2.t2u(nt);
			uc_id  := corp2.t2u(id);

			RETURN map(corp2.t2u(uc_nt) <> 'R' and uc_id = 'R' 	=> '07',
								 corp2.t2u(uc_nt) =  'L' 									=> '01',
								 corp2.t2u(uc_nt) =  'F' 									=> 'P',
								 corp2.t2u(uc_nt) =  'A' 									=> '06',
								 corp2.t2u(uc_nt) =  'N'									=> '06',							
								 corp2.t2u(uc_nt) =  'R' 									=> '07',
								 corp2.t2u(uc_nt) =  'G' 									=> '09',
								 ''
								);
		END;
		
		//****************************************************************************
		//LNNameTypeDesc: Returns "corp_ln_name_type_desc".
		//****************************************************************************		
		EXPORT LNNameTypeDesc(STRING nt, STRING id) := FUNCTION

			uc_nt  := corp2.t2u(nt);
			uc_id  := corp2.t2u(id);

			RETURN map(corp2.t2u(uc_nt) <> 'R' and uc_id = 'R' 	=> 'RESERVED',
								 corp2.t2u(uc_nt) =  'L' 									=> 'LEGAL',
								 corp2.t2u(uc_nt) =  'F' 									=> 'PRIOR',
								 corp2.t2u(uc_nt) =  'A' 									=> 'ASSUMED',
								 corp2.t2u(uc_nt) =  'N' 									=> 'ASSUMED',								 
								 corp2.t2u(uc_nt) =  'R' 									=> 'RESERVED',
								 corp2.t2u(uc_nt) =  'G' 									=> 'REGISTRATION',
								 ''
								);
		END;
		
		//****************************************************************************
		//IncDate: Returns "corp_inc_date".
		//****************************************************************************		
		EXPORT IncDate(STRING incorp_date, STRING qual_date, STRING file_date) := FUNCTION
		  
			incorpDate	:= Corp2_Mapping.fValidateDate(incorp_date,'CCYYMMDD').PastDate;
			qualDate		:= Corp2_Mapping.fValidateDate(qual_date,'CCYYMMDD').PastDate;
			fileDate		:= Corp2_Mapping.fValidateDate(file_date,'CCYYMMDD').PastDate;
			
			intIncorpDate := (integer)incorpDate;
			intQualDate 	:= (integer)qualDate;
			//intFileDate 	:= (integer)fileDate;

			RETURN map(incorpDate	 =  '' and qualDate =  '' and fileDate <> ''  																 	=>	fileDate,
								 incorpDate	 =  '' and qualDate <> '' and fileDate =  ''  																 	=>	qualDate,
								 incorpDate  =  '' and qualDate <> '' and fileDate <> ''  																 	=>	fileDate,
								 incorpDate  <> '' and qualDate =  '' and fileDate =  '' 	 											 						=>	incorpDate,
								 incorpDate  <> '' and qualDate =  '' and fileDate <> '' 																	 	=>	incorpDate,
								 incorpDate  <> '' and qualDate <> '' and fileDate =  '' and intIncorpDate >= intQualDate 	=>	incorpDate,
								 incorpDate  <> '' and qualDate <> '' and fileDate =  '' and intIncorpDate <= intQualDate 	=>	qualDate,
								 ''
							  );
		END;

		//****************************************************************************
		//ForgnDate: Returns "corp_forgn_date".
		//****************************************************************************		
		EXPORT ForgnDate(STRING incorp_date, STRING qual_date, STRING file_date) := FUNCTION
		  
			incorpDate	:= Corp2_Mapping.fValidateDate(incorp_date,'CCYYMMDD').PastDate;
			qualDate		:= Corp2_Mapping.fValidateDate(qual_date,'CCYYMMDD').PastDate;
			fileDate		:= Corp2_Mapping.fValidateDate(file_date,'CCYYMMDD').PastDate;
			
			intIncorpDate := (integer)incorpDate;
			intQualDate 	:= (integer)qualDate;

			RETURN map(
								 incorpDate	 =  '' and qualDate =  '' and fileDate <> '' =>	fileDate,			
								 incorpDate	 =  '' and qualDate <> '' and fileDate =  '' =>	qualDate,
								 incorpDate  =  '' and qualDate <> '' and fileDate <> '' =>	qualDate,
								 incorpDate  <> '' and qualDate =  '' and fileDate =  '' =>	incorpDate,
								 incorpDate  <> '' and qualDate =  '' and fileDate <> '' =>	fileDate,
								 incorpDate  <> '' and qualDate <> '' and fileDate =  '' =>	qualDate,
								 incorpDate  <> '' and qualDate <> '' and fileDate <> '' =>	qualDate,
								 ''
							  );
		END;
		
		//****************************************************************************
		//FilingDate: Returns "corp_filing_date".
		//****************************************************************************		
		EXPORT FilingDate(STRING qual_date, STRING file_date, STRING corp_type) := FUNCTION

			qualDate		:= Corp2_Mapping.fValidateDate(qual_date,'CCYYMMDD').PastDate;
			fileDate		:= Corp2_Mapping.fValidateDate(file_date,'CCYYMMDD').PastDate;
	
			RETURN map(fileDate <> '' and corp_type = 'LP'	=>	fileDate,
								 qualDate
							  );
		END;

		//****************************************************************************
		//FilingDesc: Returns "corp_filing_desc".
		//****************************************************************************		
		EXPORT FilingDesc(STRING qual_date, STRING file_date, STRING corp_type) := FUNCTION
			
			qualDate		:= Corp2_Mapping.fValidateDate(qual_date,'CCYYMMDD').PastDate;
			fileDate		:= Corp2_Mapping.fValidateDate(file_date,'CCYYMMDD').PastDate;

	
			RETURN map(fileDate <> '' and corp_type = 'LP'	=>	'CERTIFICATE OF LIMITED PARTNERSHIP',
								 qualDate <> '' 											=>	'FOREIGN STATE QUALIFICATION',
								 ''
							  );								
		END;

		//****************************************************************************
		//CorpAddlInfo: returns the "corp_addl_info".
		//****************************************************************************
		EXPORT CorpAddlInfo(STRING closeflag,
												STRING fiduciaryflag,
												STRING paflag,
												STRING publicmutual,
												STRING directorto,
												STRING directorfrom,
												STRING membersflag,
												STRING corpid) := FUNCTION

						uc_closeflag 			:= corp2.t2u(closeflag);

						uc_fiduciaryflag 	:= if(corp2.t2u(fiduciaryflag)<>'','FIDUCIARY;','');
						uc_paflag 				:= if(corp2.t2u(paflag)<>'','PROFESSIONAL ASSOCIATION;','');
						uc_publicmutual 	:= IF(corp2.t2u(publicmutual)<>'','PUBLIC BENEFIT;','');

						uc_directorto 		:= corp2.t2u(directorto);
						to_isdigits				:= ut.isNumeric(uc_directorto);

						uc_directorfrom 	:= corp2.t2u(directorfrom);
						from_isdigits			:= ut.isNumeric(uc_directorfrom);

						uc_membersflag 		:= corp2.t2u(membersflag);
						uc_corpid 				:= corp2.t2u(corpid);

						managedby					:= map(
																		uc_directorto = '' and uc_directorfrom = '' 																			 	=> 'MANAGED BY', 
																		to_isdigits and from_isdigits and (integer)uc_directorto < (integer)uc_directorfrom => 'MANAGED BY', 
																		uc_directorto = uc_directorfrom and to_isdigits and from_isdigits										=> 'MANAGED BY ' + (STRING)(integer)uc_directorfrom,
																		not to_isdigits and from_isdigits											  													  => 'MANAGED BY ' + (STRING)(integer)uc_directorfrom,
																		to_isdigits and not from_isdigits 																									=> 'MANAGED BY ' + (STRING)(integer)uc_directorto,
																		to_isdigits and from_isdigits 																											=> 'MANAGED BY ' + (STRING)(integer)uc_directorfrom + '-' + (STRING)(integer)uc_directorto,
																		''
																	 );	
						
						managedbydesc			:= map(uc_closeflag = 'C' => ' MANAGERS',
																		 uc_closeflag = 'N' => ' DIRECTORS',
																		 uc_closeflag = 'Y' => ' MANAGED BY SHAREHOLDERS',
																		 uc_closeflag = 'I' and uc_membersflag = 'Y' and uc_corpid[9..10] = 'DC' => 'MANAGED BY MEMBERS',
																		 ''
																		);
																		
						directordesc			:= if(uc_closeflag in ['C','N'], managedby + managedbydesc,managedbydesc);

						CorpAddlInfo			:= corp2.t2u(uc_fiduciaryflag + uc_paflag + uc_publicmutual + directordesc);

						RETURN regexreplace('[;]*$',CorpAddlInfo,'',nocase);

		END;
					
		//****************************************************************************
		//CorpAddlInfo: returns the "corp_directors_from_to".
		//****************************************************************************
		EXPORT CorpDirectorsFromTo(STRING directorto, STRING directorfrom) := FUNCTION

						uc_directorto 		:= corp2.t2u(directorto);
						to_isdigits				:= ut.isNumeric(uc_directorto);

						uc_directorfrom 	:= corp2.t2u(directorfrom);
						from_isdigits			:= ut.isNumeric(uc_directorfrom);

						RETURN map((integer)uc_directorto <> 0 and (integer)uc_directorto = (integer)uc_directorfrom	 	=> (string)(integer)uc_directorfrom,
												to_isdigits and from_isdigits and (integer)uc_directorto < (integer)uc_directorfrom => (string)(integer)uc_directorto + '-' + (string)(integer)uc_directorfrom,
												to_isdigits and from_isdigits and (integer)uc_directorto > (integer)uc_directorfrom => (string)(integer)uc_directorfrom + '-' + (string)(integer)uc_directorto,
												not to_isdigits and from_isdigits	and (integer)uc_directorfrom <> 0 							  => (string)(integer)uc_directorfrom,
												to_isdigits and not from_isdigits	and (integer)uc_directorto <> 0 									=> (string)(integer)uc_directorto,
												''
											 );	
		END;
		
END;
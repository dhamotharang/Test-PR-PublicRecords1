#option('skipFileFormatCrcCheck', 1);

import ut, lib_stringlib, _validate, Address, corp2, _control, versioncontrol;

export MO := MODULE;

	export Layouts_Raw_Input := MODULE;


		export CORPORATION := record,MAXLENGTH(1000)
			string PITEMID;
			string CORP_ID;
			string CORP_TYPE;                  
			string CORP_STATUS;                
			string CORP_NUM;                   
			string CORP_CITIZENSHIP;           
			string CORP_DATE_FORMED;           
			string CORP_DISSOLVE_DATE;         
			string CORP_DURATION;              
			string CORP_COUNTY_OF_INC;         
			string CORP_STATE_OF_INC;          
			string CORP_COUNTRY_OF_INC;        
			string CORP_PURPOSE;               
			string CORP_PROFESSION;            
			string CORP_AGENT_NAME;            
		end;
		
		export ADDRESS := record,MAXLENGTH(800)
			string ADDR_ID;  
			string PITEMID;                  
			string ADDR_TYPE;                  
			string ADDR_LINE_1;              
			string ADDR_LINE_2;              
			string ADDR_LINE_3;              
			string ADDR_CITY;                
			string ADDR_STATE;               
			string ADDR_ZIP;                 
			string ADDR_COUNTY;              
			string ADDR_COUNTRY;
		end;
		
		export FILING := record,MAXLENGTH(800)
			string 	FILN_ID; 
			string 	PITEMID;                   
			string 	FILN_DOC_ID;                
			string 	FILN_DOC_TYPE;              
			string 	FILN_FILING_DATE;           
			string 	FILN_EFFECTIVE_DATE;
		end;

		export MERGER := record,MAXLENGTH(800)
			string 	MERG_ID;
			string 	PITEMID;
			string 	PITEMID2;               
			string 	MERG_DATE;                  
		end;
			
		export NAME := record,MAXLENGTH(800)				
			string 	NAME_ID;    
			string 	PITEMID;                
			string 	NAME_NAME;                  
			string 	NAME_TYPE;                  
			string 	NAME_TITLE;                 
			string 	NAME_SALUTATION;            
			string 	NAME_PREFIX;                
			string 	NAME_LAST_NAME;             
			string 	NAME_MIDDLE_NAME;           
			string 	NAME_FIRST_NAME;            
			string 	NAME_SUFFIX;  
		end;
		
		
		export CorpNameAddr := record,MAXLENGTH(2000)
			string 	PITEMID;
			string 	CORP_ID;
			string 	CORP_TYPE;                  
			string 	CORP_STATUS;                
			string 	CORP_NUM;                   
			string 	CORP_CITIZENSHIP;           
			string 	CORP_DATE_FORMED;           
			string 	CORP_DISSOLVE_DATE;         
			string 	CORP_DURATION;              
			string 	CORP_COUNTY_OF_INC;         
			string 	CORP_STATE_OF_INC;          
			string 	CORP_COUNTRY_OF_INC;        
			string 	CORP_PURPOSE;               
			string 	CORP_PROFESSION;            
			string 	CORP_AGENT_NAME; 
			string 	NAME_ID;    
			string 	NAME_NAME;                  
			string 	NAME_TYPE;                  
			string 	NAME_TITLE;                 
			string 	NAME_SALUTATION;            
			string 	NAME_PREFIX;                
			string 	NAME_LAST_NAME;             
			string 	NAME_MIDDLE_NAME;           
			string 	NAME_FIRST_NAME;            
			string 	NAME_SUFFIX;  
			string 	ADDR_ID;  
			string 	ADDR_TYPE;                  
			string 	ADDR_LINE_1;              
			string 	ADDR_LINE_2;              
			string 	ADDR_LINE_3;              
			string 	ADDR_CITY;                
			string 	ADDR_STATE;               
			string 	ADDR_ZIP;                 
			string 	ADDR_COUNTY;              
			string 	ADDR_COUNTRY;
		end;
		
	
		export CorpName := record,MAXLENGTH(2000)
			string 	PITEMID;
			string 	CORP_ID;
			string 	CORP_TYPE;                  
			string 	CORP_STATUS;                
			string 	CORP_NUM;                   
			string 	CORP_CITIZENSHIP;           
			string 	CORP_DATE_FORMED;           
			string 	CORP_DISSOLVE_DATE;         
			string 	CORP_DURATION;              
			string 	CORP_COUNTY_OF_INC;         
			string 	CORP_STATE_OF_INC;          
			string 	CORP_COUNTRY_OF_INC;        
			string 	CORP_PURPOSE;               
			string 	CORP_PROFESSION;            
			string 	CORP_AGENT_NAME; 
			string 	NAME_ID;    
			string 	NAME_NAME;                  
			string 	NAME_TYPE;                  
			string 	NAME_TITLE;                 
			string 	NAME_SALUTATION;            
			string 	NAME_PREFIX;                
			string 	NAME_LAST_NAME;             
			string 	NAME_MIDDLE_NAME;           
			string 	NAME_FIRST_NAME;            
			string 	NAME_SUFFIX;  
		end;
		
		export CorpFiln := record,MAXLENGTH(2000)
			string 	PITEMID;
			string 	CORP_ID;
			string 	CORP_TYPE;                  
			string 	CORP_STATUS;                
			string 	CORP_NUM;                   
			string 	CORP_CITIZENSHIP;           
			string 	CORP_DATE_FORMED;           
			string 	CORP_DISSOLVE_DATE;         
			string 	CORP_DURATION;              
			string 	CORP_COUNTY_OF_INC;         
			string 	CORP_STATE_OF_INC;          
			string 	CORP_COUNTRY_OF_INC;        
			string 	CORP_PURPOSE;               
			string 	CORP_PROFESSION;            
			string 	CORP_AGENT_NAME;
      string 	FILN_ID; 
			string 	FILN_DOC_ID;                
			string 	FILN_DOC_TYPE;              
			string 	FILN_FILING_DATE;           
			string 	FILN_EFFECTIVE_DATE;
		end;
		
	end; // end of Layouts_Raw_Input module
	
	export Files_Raw_Input := MODULE;
	
		// vendor file definition
		export corporation (string fileDate) := dataset('~thor_data400::in::corp2::'+fileDate+'::corporation::mo',
														layouts_Raw_Input.corporation,CSV(HEADING(1),SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n', '\n'])));
		
		export address (string fileDate)     := dataset('~thor_data400::in::corp2::'+fileDate+'::address::mo',
														layouts_Raw_Input.address,CSV(HEADING(1),SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));
														
		export filing (string fileDate)      := dataset('~thor_data400::in::corp2::'+fileDate+'::filing::mo',
		                                                layouts_Raw_Input.filing,CSV(HEADING(1),SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));
														
		export merger (string fileDate)      := dataset('~thor_data400::in::corp2::'+fileDate+'::merger::mo',
		                                                layouts_Raw_Input.merger,CSV(HEADING(1),SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));
														
		export name (string fileDate)        := dataset('~thor_data400::in::corp2::'+fileDate+'::name::mo',
														layouts_Raw_Input.name,CSV(HEADING(1),SEPARATOR([',']), quote('"'), TERMINATOR(['\r\n', '\n'])));												
	end;
	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
		SetNameTypes := ['1','2','3','5','10','13','14','15','18','19'];
		
		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		
		trimFilterUpper(string s, string r) := function
			return trim(StringLib.StringFilterOut(stringlib.StringtoUpperCase(s),r),left,right);
		end;
	
	
		//Explosion Table declarations
		docTypeLayout := record
			string typeCode;
			string typeDesc;
		end;

		docTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::' + fileDate + '::DocumentType_Table::mo',docTypeLayout,CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		
		nameTypeLayout := record
			string typeCode;
			string typeDesc;
		end;

		nameTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::' + fileDate + '::NameType_Table::mo',nameTypeLayout,CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		
		addrTypeLayout := record
			string typeCode;
			string typeDesc;
		end;

		addrTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::' + fileDate + '::AddressType_Table::mo',addrTypeLayout,CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));

		corpTypeLayout := record
			string typeCode;
			string typeDesc;
		end;
		
		corpTypeTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::' + fileDate + '::CorporationType_Table::mo',corpTypeLayout,CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));

		corpStatusLayout := record
			string statusCode;
			string statusDesc;
		end;

		corpStatusTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::' + fileDate + '::CorporationStatus_Table::mo',corpStatusLayout,CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		
	
		reformatDate(string inDate) := function
			string DateOnly 	:= trim(regexreplace('00:00:00',inDate,''),left,right);
			string clean_inDate := StringLib.StringRepad(StringLib.StringFilterOut(DateOnly,'"'),8);
			string2 outMM 		:= if(	clean_inDate[2] = '/' or clean_inDate[2] = '-',
										'0'+ clean_inDate[1],
										clean_inDate[1..2]);
			string2 outDD 		:= if(	clean_inDate[length(clean_inDate)-6] = '/' or clean_inDate[length(clean_inDate)-6] = '-',
										'0'+ clean_inDate[length(clean_inDate)-5],
										clean_inDate[length(clean_inDate)-6..length(clean_inDate)-5]);
			string8 newDate 	:= clean_inDate[length(clean_inDate)-3..]+outMM+outDD;	
			return newDate;	
		end;
		
		CleanDate(string inDate) := function
			string DateOnly 	:= trim(inDate,left,right)[1..10];
			string clean_inDate := StringLib.StringFilterOut(DateOnly,'"-');
			return clean_inDate;	
		end;
	
//---------------------  Corporation File Mapping --------------------//	

		corp2_mapping.Layout_CorpPreClean MO_corpTransform(Layouts_Raw_Input.CorpNameAddr input) := transform
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;
			
			self.corp_key						:= '29-' + trim(input.corp_id,left,right);
			self.corp_vendor					:= '29';
			self.corp_state_origin				:= 'MO';
			
			self.corp_process_date				:= fileDate;
			
			
			cleanCorpNum						:= trimFilterUpper(input.corp_num,'"');

			self.corp_orig_sos_charter_nbr		:= cleanCorpNum,
																										  
			self.corp_src_type				    := 'SOS';
			
			self.corp_legal_name				:= trimFilterUpper(input.name_name,'"');

			self.corp_ln_name_type_cd			:= if (trim(input.name_type,left,right) IN SetNameTypes, input.Name_type, '');
			
			self.corp_address1_type_cd			:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														trimfilterUpper(input.Addr_type,'"'),
														''
													   );
			
		
			self.corp_address1_line1			:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														trimFilterUpper(input.ADDR_LINE_1,'"'),
														''
													   ); 

			self.corp_address1_line2			:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														trimFilterUpper(input.ADDR_LINE_2,'"'),
														''
													   ); 

			self.corp_address1_line3			:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														trimFilterUpper(input.ADDR_LINE_3,'"'),
														''
													   );  

			self.corp_address1_line4			:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														if( trimFilterUpper(input.ADDR_CITY,'"') = '',
															trimFilterUpper(input.ADDR_STATE,'"'),
															trimFilterUpper(input.ADDR_CITY,'"')
														   ),
														''
													   );  

			self.corp_address1_line5			:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														if( trimFilterUpper(input.ADDR_CITY,'"') = '',
															trimFilterUpper(input.ADDR_ZIP,'"'),
															trimFilterUpper(input.ADDR_STATE,'"')
														   ),
														''
													   ); 

			self.corp_address1_line6			:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														if(	trimFilterUpper(input.ADDR_CITY,'"') = '',
															trimFilterUpper(input.ADDR_COUNTY,'"'),
															trimFilterUpper(input.ADDR_ZIP,'"')
															),
														''
													   ); 
	
			
			// self.corp_address1_type_cd			:= if (trim(input.ADDR_1_TYPE,left,right) <> '10',
														// input.addr_1_type,
														// if (trim(input.ADDR_2_TYPE,left,right) <> '10',
																// input.ADDR_2_TYPE,
																// ''
															// )
													   // );
			
		
			// self.corp_address1_line1			:= if (trim(input.ADDR_1_TYPE,left,right) <> '10',
														// trimFilterUpper(input.ADDR_1_LINE_1,'"'),
														// if (trim(input.ADDR_2_TYPE,left,right) <> '10',
																// trimFilterUpper(input.ADDR_2_LINE_1,'"'),
																// ''
															// )
													   // );
															
			

			// self.corp_address1_line2			:= if (trim(input.ADDR_1_TYPE,left,right) <> '10',
														// trimFilterUpper(input.ADDR_1_LINE_2,'"'),
														// if (trim(input.ADDR_2_TYPE,left,right) <> '10',
																// trimFilterUpper(input.ADDR_2_LINE_2,'"'),
																// ''
															// )
													   // );
			// self.corp_address1_line3			:= if (trim(input.ADDR_1_TYPE,left,right) <> '10',
														// trimFilterUpper(input.ADDR_1_LINE_3,'"'),
														// if (trim(input.ADDR_2_TYPE,left,right) <> '10',
																// trimFilterUpper(input.ADDR_2_LINE_3,'"'),
																// ''
															// )
													   // ); 

			// self.corp_address1_line4			:= if (trim(input.ADDR_1_TYPE,left,right) <> '10',
														// if(trimFilterUpper(input.ADDR_1_CITY,'"') = '',
															// trimFilterUpper(input.ADDR_1_STATE,'"'),
															// trimFilterUpper(input.ADDR_1_CITY,'"')
														   // ),
														// if (trim(input.ADDR_2_TYPE,left,right) <> '10',
															// if(	trimFilterUpper(input.ADDR_2_CITY,'"') = '',
																// trimFilterUpper(input.ADDR_2_STATE,'"'),
																// trimFilterUpper(input.ADDR_2_CITY,'"')
														       // ),
															// ''
														    // )
														// );

			// self.corp_address1_line5			:= if (trim(input.ADDR_1_TYPE,left,right) <> '10',
														// if( trimFilterUpper(input.ADDR_1_CITY,'"') = '',
															// trimFilterUpper(input.ADDR_1_ZIP,'"'),
															// trimFilterUpper(input.ADDR_1_STATE,'"')
														   // ),
														// if (trim(input.ADDR_2_TYPE,left,right) <> '10',
															// if(	trimFilterUpper(input.ADDR_2_CITY,'"') = '',
																// trimFilterUpper(input.ADDR_2_ZIP,'"'),
																// trimFilterUpper(input.ADDR_2_STATE,'"')
															   // ),
															// ''
														   // )
													   // ); 

			// self.corp_address1_line6			:= if (trim(input.ADDR_1_TYPE,left,right) <> '10',
														// if(	trimFilterUpper(input.ADDR_1_CITY,'"') = '',
															// trimFilterUpper(input.ADDR_1_COUNTY,'"'),
															// trimFilterUpper(input.ADDR_1_ZIP,'"')
															// ),
														// if (trim(input.ADDR_2_TYPE,left,right) <> '10',
															// if(	trimFilterUpper(input.ADDR_2_CITY,'"') = '',
																// trimFilterUpper(input.ADDR_2_COUNTY,'"'),
																// trimFilterUpper(input.ADDR_2_ZIP,'"')
															  // ),
															// ''
														   // )
														// ); 

		
			self.corp_status_cd					:= trimUpper(input.corp_status);
			
			clean_dissolved						:= cleanDate(input.corp_dissolve_date);

			self.corp_status_date				:= if(	_validate.date.fIsValid(clean_dissolved) and 
														_validate.date.fIsValid(clean_dissolved,_validate.date.rules.DateInPast),
														clean_dissolved,
														''
													  );
			
			self.corp_inc_state					:= if ( trimFilterUpper(input.corp_state_of_inc,'"') = 'MO',
															'MO',
															'');

			self.corp_inc_county				:= if (not corp2.Rewrite_Common.IsUnknown(corp2.Rewrite_Common.PatternUnknown,trimFilterUpper(input.corp_county_of_inc,'"')),
															trimFilterUpper(input.corp_county_of_inc,'"'),
															''
													   );
			
			cleanDate_formed					:= CleanDate(input.corp_date_formed); 

			self.corp_inc_date					:= if ((trimFilterUpper(input.corp_state_of_inc,'"') = 'MO' or 
														trimFilterUpper(input.corp_state_of_inc,'"') = '' and
														trimFilterUpper(input.corp_country_of_inc,'"') = '') and
														_validate.date.fIsValid(cleanDate_formed) and 
														_validate.date.fIsValid(cleanDate_formed,_validate.date.rules.DateInPast),
															cleanDate_formed,
															''
													   );
													   
			cleanDuration						:= StringLib.StringFilterOut(input.corp_duration,'"');
			
			self.corp_term_exist_cd				:= if ( trimFilterUpper(input.corp_citizenship,'"') = 'D' AND
														trimUpper(cleanDuration) = 'PERPETUAL',
															'P',
															if( _validate.date.fIsValid(reFormatDate(input.corp_duration)),
																	'D',
																	''
															   )
														);

			self.corp_term_exist_exp			:= if( _validate.date.fIsValid(reFormatDate(input.corp_duration)) and 
													   trimFilterUpper(input.corp_citizenship,'"') = 'D',
														reFormatDate(input.corp_duration),
														''
													  );

			self.corp_term_exist_desc			:= if( 	trimFilterUpper(input.corp_citizenship,'"') = 'D' AND
														trimUpper(cleanDuration) ='PERPETUAL',
															'PERPETUAL', 
															if( _validate.date.fIsValid(reFormatDate(input.corp_duration)),
																'EXPIRATION DATE',
																''
															   )
													  );


			self.corp_foreign_domestic_ind		:= trimFilterUpper(input.corp_citizenship,'"');
			
			ForgnStateCode						:= if( trimFilterUpper(input.corp_state_of_inc,'"') <> 'MO' and 
														trimFilterUpper(input.corp_state_of_inc,'"') <> '',
														trimFilterUpper(input.corp_state_of_inc,'"'),
														''
													  );

			self.corp_forgn_state_cd			:= ForgnStateCode;
													  
			ForgnStateDesc						:= map(ForgnStateCode = 'AL' =>'ALABAMA',
													   ForgnStateCode = 'AK' =>'ALASKA',
													   ForgnStateCode = 'AS' =>'AMERICAN SAMOA',
													   ForgnStateCode = 'AZ' =>'ARIZONA',
													   ForgnStateCode = 'AR' =>'ARKANSAS',
													   ForgnStateCode = 'CA' =>'CALIFORNIA',
													   ForgnStateCode = 'CO' =>'COLORADO',
													   ForgnStateCode = 'CT' =>'CONNECTICUT',
													   ForgnStateCode = 'DE' =>'DELAWARE',
													   ForgnStateCode = 'DC' =>'DISTRICT OF COLUMBIA',
													   ForgnStateCode = 'FM' =>'FEDERATED STATES OF MICRONESIA',
													   ForgnStateCode = 'FL' =>'FLORIDA',
													   ForgnStateCode = 'GA' =>'GEORGIA',
													   ForgnStateCode = 'GU' =>'GUAM',
													   ForgnStateCode = 'HI' =>'HAWAII',
													   ForgnStateCode = 'ID' =>'IDAHO',
													   ForgnStateCode = 'IL' =>'ILLINOIS',
													   ForgnStateCode = 'IN' =>'INDIANA',
													   ForgnStateCode = 'IA' =>'IOWA',
													   ForgnStateCode = 'KS' =>'KANSAS',
													   ForgnStateCode = 'KY' =>'KENTUCKY',
													   ForgnStateCode = 'LA' =>'LOUISIANA',
													   ForgnStateCode = 'ME' =>'MAINE',
													   ForgnStateCode = 'MH' =>'MARSHALL ISLANDS',
													   ForgnStateCode = 'MD' =>'MARYLAND',
													   ForgnStateCode = 'MA' =>'MASSACHUSETTS',
													   ForgnStateCode = 'MI' =>'MICHIGAN',
													   ForgnStateCode = 'MN' =>'MINNESOTA',
													   ForgnStateCode = 'MS' =>'MISSISSIPPI',
													   ForgnStateCode = 'MO' =>'MISSOURI',
													   ForgnStateCode = 'MT' =>'MONTANA',
													   ForgnStateCode = 'NE' =>'NEBRASKA',
													   ForgnStateCode = 'NV' =>'NEVADA',
													   ForgnStateCode = 'NH' =>'NEW HAMPSHIRE',
													   ForgnStateCode = 'NJ' =>'NEW JERSEY',
													   ForgnStateCode = 'NM' =>'NEW MEXICO',
													   ForgnStateCode = 'NY' =>'NEW YORK',
													   ForgnStateCode = 'NC' =>'NORTH CAROLINA',
													   ForgnStateCode = 'ND' =>'NORTH DAKOTA',
													   ForgnStateCode = 'MP' =>'NORTHERN MARIANA ISLANDS',
													   ForgnStateCode = 'OH' =>'OHIO',
													   ForgnStateCode = 'OK' =>'OKLAHOMA',
													   ForgnStateCode = 'OR' =>'OREGON',
													   ForgnStateCode = 'PW' =>'PALAU',
													   ForgnStateCode = 'PA' =>'PENNSYLVANIA',
													   ForgnStateCode = 'PR' =>'PUERTO RICO',
													   ForgnStateCode = 'RI' =>'RHODE ISLAND',
													   ForgnStateCode = 'SC' =>'SOUTH CAROLINA',
													   ForgnStateCode = 'SD' =>'SOUTH DAKOTA',
													   ForgnStateCode = 'TN' =>'TENNESSEE',
													   ForgnStateCode = 'TX' =>'TEXAS',
													   ForgnStateCode = 'UT' =>'UTAH',
													   ForgnStateCode = 'VT' =>'VERMONT',
													   ForgnStateCode = 'VI' =>'VIRGIN ISLANDS',
													   ForgnStateCode = 'VA' =>'VIRGINIA',
													   ForgnStateCode = 'WA' =>'WASHINGTON',
													   ForgnStateCode = 'WV' =>'WEST VIRGINIA',
													   ForgnStateCode = 'WI' =>'WISCONSIN',
													   ForgnStateCode = 'WY' =>'WYOMING',
													   ForgnStateCode = 'AE' =>'ARMED FORCES EUROPE THE MIDDLE EAST AND CANADA',
													   ForgnStateCode = 'AP' =>'ARMED FORCES PACIFIC',
													   ForgnStateCode = 'AA' =>'ARMED FORCES (AMERICAS EXCEPT CANADA)',
													   ForgnStateCode = 'CZ' =>'CANAL ZONE',
													   ForgnStateCode); 
													  
			self.corp_forgn_state_desc 			:= if (trimFilterUpper(input.corp_country_of_inc,'"') <> '',
															trimFilterUpper(input.corp_country_of_inc,'"'),
															ForgnStateDesc
													   );
															

			self.corp_forgn_date				:= if(	trimFilterUpper(input.corp_state_of_inc,'"') <> 'MO' and
														trimFilterUpper(input.corp_state_of_inc,'"') <> '' and
														_validate.date.fIsValid(cleanDate_formed) and 
														_validate.date.fIsValid(cleanDate_formed,_validate.date.rules.DateInPast),
														cleanDate_formed,
														''
													  );

			self.corp_forgn_term_exist_cd		:= if ( trimFilterUpper(input.corp_citizenship,'"') ='F' AND
														trimUpper(cleanDuration) = 'PERPETUAL',
															'P',
															if( _validate.date.fIsValid(reFormatDate(input.corp_duration)) and
																trimFilterUpper(input.corp_citizenship,'"') = 'F',
																	'D',
																	''
															   )
													   );

			self.corp_forgn_term_exist_exp		:= if( _validate.date.fIsValid(reFormatDate(input.corp_duration)) and
													   trimUpper(input.corp_citizenship) = 'F',
															reFormatDate(input.corp_duration),
															''
													  );

			self.corp_forgn_term_exist_desc		:= if( trimFilterUpper(input.corp_citizenship,'"') = 'F' AND
													   trimUpper(cleanDuration) = 'PERPETUAL',
															'PERPETUAL', 
															if( _validate.date.fIsValid(reFormatDate(input.corp_duration)) and
																trimFilterUpper(input.corp_citizenship,'"') = 'F',
																'EXPIRATION DATE',
																''
															   )
													  );


			self.corp_orig_org_structure_desc 	:= trimFilterUpper(input.corp_purpose + input.corp_profession,'"');

			self.corp_orig_bus_type_cd			:= input.corp_type;
															
			self.corp_ra_name					:= if (trimFilterUpper(input.corp_agent_name,'"') <> '####',
														trimFilterUpper(input.corp_agent_name,'"'),
														''
													   );
			
			self.corp_ra_address_type_cd		:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														'10',
														''
													   ); 
			self.corp_ra_address_type_desc		:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														'REG OFFICE',
														''
													   );
			self.corp_ra_address_line1			:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														trimFilterUpper(input.ADDR_LINE_1,'"'),
														''
													   ); 
			self.corp_ra_address_line2			:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														trimFilterUpper(input.ADDR_LINE_2,'"'),
														''
													   );  
			self.corp_ra_address_line3			:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														trimFilterUpper(input.ADDR_LINE_3,'"'),
														''
													   );  
			self.corp_ra_address_line4			:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														if( trimFilterUpper(input.ADDR_CITY,'"') = '',
															trimFilterUpper(input.ADDR_STATE,'"'),
															trimFilterUpper(input.ADDR_CITY,'"')
														   ),
														''
													   );  
			self.corp_ra_address_line5			:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														if( trimFilterUpper(input.ADDR_CITY,'"') = '',
															trimFilterUpper(input.ADDR_ZIP,'"'),
															trimFilterUpper(input.ADDR_STATE,'"')
														   ),
														''
													   ); 
			self.corp_ra_address_line6			:= if (trimfilterUpper(input.ADDR_TYPE,'"') <> '10',
														if(	trimFilterUpper(input.ADDR_CITY,'"') = '',
															trimFilterUpper(input.ADDR_COUNTY,'"'),
															trimFilterUpper(input.ADDR_ZIP,'"')
															),
														''
													   ); 
	
		
			self 								:= [];
				
		
		end; // end transform
		
//------------------------------- Event File Mapping --------------------//		
		
		Corp2.Layout_Corporate_Direct_Event_In MO_EventTransform(Layouts_Raw_Input.CorpFiln input) := transform,skip( 	trim(input.filn_doc_type,left,right) = '127' or
																														trim(input.filn_doc_type,left,right) = '152' or
																														trim(input.filn_doc_type,left,right) = '250' or
																														trim(input.filn_doc_type,left,right) = '251' or
																														trim(input.filn_doc_type,left,right) = '261')
			Self.corp_key                   := '29-' +trim(input.corp_id, left, right);
			Self.corp_vendor                :='29';
			Self.corp_state_origin          := 'MO';
			
			cleanCorpNum					:= trimFilterUpper(input.corp_num,'"');
			self.corp_sos_charter_nbr		:= cleanCorpNum;
												  
			Self.corp_process_date          := FileDate;
			
			CleanFilingDate                 := cleanDate(input.FILN_FILING_DATE) ;
			CleanEffDate	                := cleanDate(input.FILN_EFFECTIVE_DATE) ;
			
			self.event_filing_date			:= if(	_validate.date.fIsValid(CleanFilingDate) and 
			                                        _validate.date.fIsValid(CleanFilingDate,_validate.date.rules.DateInpast),
														CleanFilingDate,
	                                                    if(	_validate.date.fIsValid(cleanEffDate) and 
														    _validate.date.fIsValid(cleanEffDate,_validate.date.rules.DateInpast),
																cleanEffDate,
																''
															)
												 );	
												 
			self.event_date_type_cd         :=if(	_validate.date.fIsValid(cleanFilingDate) and 
			                                        _validate.date.fIsValid(cleanFilingDate,_validate.date.rules.DateInpast),
														'FIL',
	                                                    if(	_validate.date.fIsValid(cleanEffDate) and 
														    _validate.date.fIsValid(cleanEffDate,_validate.date.rules.DateInpast),
															'EFF',
															''
														   ) 
												 );			
			doc_no                        	:=['127','152','250','251','261'];
			self.event_filing_cd            :=IF(trim(input.FILN_DOC_TYPE, left, right) ~in doc_no,input.FILN_DOC_TYPE,'');
			
			self							:=[];
		end; // end of MO_EventTransform
		
		
//--------------------------------- AR file mapping ----------------------//
		
				
		Corp2.Layout_Corporate_Direct_AR_In MO_arTransform(Layouts_Raw_Input.CorpFiln input) := transform,skip( trim(input.filn_doc_type,left,right) <> '127' and
																												trim(input.filn_doc_type,left,right) <> '152' and
																												trim(input.filn_doc_type,left,right) <> '250' and
																												trim(input.filn_doc_type,left,right) <> '251' and
																												trim(input.filn_doc_type,left,right) <> '261')
			Self.corp_key 					:= '29-' +trim(input.corp_id, left, right);
			Self.corp_vendor 				:= '29';
			Self.corp_state_origin 			:= 'MO';
			Self.corp_process_date 			:= FileDate;
			
			cleanCorpNum					:= trimFilterUpper(input.corp_num,'"');
			self.corp_sos_charter_nbr 		:= cleanCorpNum;
												
			CleanFilingDate                 := cleanDate(input.FILN_FILING_DATE) ;
						
			self.ar_report_dt				:= if(	trim(input.filn_filing_date,left,right) <> '' and 
													_validate.date.fIsValid(CleanFilingDate) and 
													_validate.date.fIsValid(CleanFilingDate,_validate.date.rules.DateInPast),
														CleanFilingDate,														
														''
												  );
			self.ar_comment                 := map(  
                                                    trim(input.filn_doc_type,left,right) = '127' => 'ANNUAL REPORT DOMESTIC',
                                                    trim(input.filn_doc_type,left,right) = '152' => 'ANNUAL REPORT FOREIGN',
                                                    trim(input.filn_doc_type,left,right) = '250' => 'STATEMENT OF CORRECTION ANNUAL REPORT DOMESTIC',
                                                    trim(input.filn_doc_type,left,right) = '251' => 'STATEMENT OF CORRECTION ANNUAL REPORT FOREIGN',
                                                    trim(input.filn_doc_type,left,right) = '261' => 'DISSOLUTION NOTIFICATION FOR ANNUAL REPORT',                                                                                                                                                                       
													''
                                                   );
			self							:=[];
		end; // end of MO_ARTransform
		
		
//--------------------------- Explosion Table Logic -----------------------//
		
		Corp2.Layout_Corporate_Direct_Corp_In findCorpStatus(Corp2.Layout_Corporate_Direct_Corp_In  input, corpStatusLayout r ) := transform
			self.corp_status_desc   		:= StringLib.StringFilterOut(r.statusDesc,'"');
			self         			 		:= input;
			self                        	:= [];
		end; // end transform
  	
		corp2_mapping.Layout_CorpPreClean findCorpType(corp2_mapping.Layout_CorpPreClean  input, corpTypeLayout r ) := transform
			self.corp_orig_bus_type_desc	:= StringLib.StringFilterOut(r.typeDesc,'"');
			self         			 		:= input;
			self                           	:= [];
		end; // end transform
  	
		corp2_mapping.Layout_CorpPreClean findNameType(corp2_mapping.Layout_CorpPreClean  input, nameTypeLayout r ) := transform
			self.corp_ln_name_type_desc     := StringLib.StringFilterOut(r.typeDesc,'"');
			self         			 		:= input;
			self                           	:= [];
		end; // end transform
		
		corp2_mapping.Layout_CorpPreClean findAddrType(corp2_mapping.Layout_CorpPreClean  input, addrTypeLayout r ) := transform
			self.corp_address1_type_desc    := StringLib.StringFilterOut(r.typeDesc,'"');
			self         			 		:= input;
			self                           	:= [];
		end; // end transform
		
		Corp2.Layout_Corporate_Direct_Event_In findDocType(Corp2.Layout_Corporate_Direct_Event_In  input, docTypeLayout r ) := transform
			self.event_desc          		:= StringLib.StringFilterOut(r.typeDesc,'"');
			self         			 		:= input;
			self                           	:= [];
		end; // end transform

	
//---------------------------- Vendor File Merges ---------------------------//	

		// Layouts_Raw_Input.CorpNameAddr MergeCorpNameAddr(Layouts_Raw_Input.CorpName l, Layouts_Raw_Input.Address r ) := transform
			// self 					:= l;
			// self					:= r;
			// self					:= [];
		// end; // end transform
		
		// Layouts_Raw_Input.CorpNameAddr MergeCorpName(Layouts_Raw_Input.Corporation l, Layouts_Raw_Input.Name r ) := transform
			// self 					:= l;
			// self					:= r;
		// end; // end transform

		Layouts_Raw_Input.CorpNameAddr MergeCorpNameAddr(Layouts_Raw_Input.CorpName l, Layouts_Raw_Input.Address r ) := transform
			self 					:= l;
			self					:= r;
		end; // end transform
		
		Layouts_Raw_Input.CorpName MergeCorpName(Layouts_Raw_Input.Corporation l, Layouts_Raw_Input.Name r ) := transform
			self 					:= l;
			self					:= r;
		end; // end transform
		
			
		joinCorpWithName := join(Files_Raw_Input.corporation(fileDate), Files_Raw_Input.name(fileDate),
							trim(left.Pitemid,left,right) = right.pitemid,
							MergeCorpName(left,right),
							left outer);
							
		joinCorpNameAddr := join(joinCorpWithName, Files_Raw_Input.address(fileDate),
							trim(left.Pitemid,left,right) = right.pitemid,
							MergeCorpNameAddr(left,right),
							left outer);

//---------------------------- Clean Name and Addresses ---------------------//

		
		corp2.layout_corporate_direct_corp_in CleanCorpNameAddr(corp2_mapping.Layout_CorpPreClean input) := transform
			string73 tempname 					:= if (input.corp_ra_name = '', '',Address.CleanPersonFML73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix,'');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score,'');	
	

			
			string182 clean_address1 			:= Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' + 														                        
												trim(input.corp_address1_line2,left,right),left,right),														                   
												trim(trim(input.corp_address1_line3,left,right) + ', ' +
												trim(input.corp_address1_line4,left,right) + ' ' +
												trim(input.corp_address1_line5,left,right) +
												trim(input.corp_address1_line6,left,right),left,right));

			self.corp_addr1_prim_range    		:= clean_address1[1..10];
			self.corp_addr1_predir 	      		:= clean_address1[11..12];
			self.corp_addr1_prim_name 	  		:= clean_address1[13..40];
			self.corp_addr1_addr_suffix   		:= clean_address1[41..44];
			self.corp_addr1_postdir 	    	:= clean_address1[45..46];
			self.corp_addr1_unit_desig 	  		:= clean_address1[47..56];
			self.corp_addr1_sec_range 	  		:= clean_address1[57..64];
			self.corp_addr1_p_city_name	  		:= clean_address1[65..89];
			self.corp_addr1_v_city_name	  		:= clean_address1[90..114];
			self.corp_addr1_state 				:= clean_address1[115..116];
			self.corp_addr1_zip5 		    	:= clean_address1[117..121];
			self.corp_addr1_zip4 		    	:= clean_address1[122..125];
			self.corp_addr1_cart 		    	:= clean_address1[126..129];
			self.corp_addr1_cr_sort_sz 	 		:= clean_address1[130];
			self.corp_addr1_lot 		      	:= clean_address1[131..134];
			self.corp_addr1_lot_order 	  		:= clean_address1[135];
			self.corp_addr1_dpbc 		    	:= clean_address1[136..137];
			self.corp_addr1_chk_digit 	  		:= clean_address1[138];
			self.corp_addr1_rec_type		  	:= clean_address1[139..140];
			self.corp_addr1_ace_fips_st	  		:= clean_address1[141..142];
			self.corp_addr1_county 	  			:= clean_address1[143..145];
			self.corp_addr1_geo_lat 	    	:= clean_address1[146..155];
			self.corp_addr1_geo_long 	    	:= clean_address1[156..166];
			self.corp_addr1_msa 		      	:= clean_address1[167..170];
			self.corp_addr1_geo_blk				:= clean_address1[171..177];
			self.corp_addr1_geo_match 	  		:= clean_address1[178];
			self.corp_addr1_err_stat 	    	:= clean_address1[179..182];			
	
						
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' + 														                        
												trim(input.corp_ra_address_line2,left,right),left,right),														                   
												trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
												trim(input.corp_ra_address_line4,left,right) + ' ' +
												trim(input.corp_ra_address_line5,left,right) +
												trim(input.corp_ra_address_line6,left,right),left,right));

			self.corp_ra_prim_range    			:= clean_address[1..10];
			self.corp_ra_predir 	      		:= clean_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_address[41..44];
			self.corp_ra_postdir 	    		:= clean_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_address[47..56];
			self.corp_ra_sec_range 	  			:= clean_address[57..64];
			self.corp_ra_p_city_name	  		:= clean_address[65..89];
			self.corp_ra_v_city_name	  		:= clean_address[90..114];
			self.corp_ra_state 			      	:= clean_address[115..116];
			self.corp_ra_zip5 		      		:= clean_address[117..121];
			self.corp_ra_zip4 		      		:= clean_address[122..125];
			self.corp_ra_cart 		      		:= clean_address[126..129];
			self.corp_ra_cr_sort_sz 	 		:= clean_address[130];
			self.corp_ra_lot 		      		:= clean_address[131..134];
			self.corp_ra_lot_order 	  			:= clean_address[135];
			self.corp_ra_dpbc 		      		:= clean_address[136..137];
			self.corp_ra_chk_digit 	  			:= clean_address[138];
			self.corp_ra_rec_type		  		:= clean_address[139..140];
			self.corp_ra_ace_fips_st	  		:= clean_address[141..142];
			self.corp_ra_county 	  			:= clean_address[143..145];
			self.corp_ra_geo_lat 	    		:= clean_address[146..155];
			self.corp_ra_geo_long 	    		:= clean_address[156..166];
			self.corp_ra_msa 		      		:= clean_address[167..170];
			self.corp_ra_geo_blk				:= clean_address[171..177];
			self.corp_ra_geo_match 	  			:= clean_address[178];
			self.corp_ra_err_stat 	    		:= clean_address[179..182];
			
			self								:= input;
			self								:= [];
		end;
		
		// Layouts_Raw_Input.CorpNameAddr MergeCorpNameAddr(Layouts_Raw_Input.CorpNameAddr L, Layouts_Raw_Input.Address R, INTEGER C) := TRANSFORM
		
			// self.ADDR_1_TYPE 	:= IF (C=1, R.addr_type, L.addr_1_type);                  
			// self.ADDR_1_LINE_1 	:= IF (C=1, R.addr_line_1, L.addr_1_line_1);               
			// self.ADDR_1_LINE_2	:= IF (C=1, R.addr_line_2, L.addr_1_line_2);             
			// self.ADDR_1_LINE_3 	:= IF (C=1, R.addr_line_3, L.addr_1_line_3);              
			// self.ADDR_1_CITY	:= IF (C=1, R.addr_city, L.addr_1_city);               
			// self.ADDR_1_STATE	:= IF (C=1, R.addr_state, L.addr_1_state);
			// self.ADDR_1_ZIP		:= IF (C=1, R.addr_zip, L.addr_1_zip);                
			// self.ADDR_1_COUNTY	:= IF (C=1, R.addr_county, L.addr_1_county);               
			// self.ADDR_1_COUNTRY	:= IF (C=1, R.addr_country, L.addr_1_country);  

			// self.ADDR_2_TYPE 	:= IF (C=2, R.addr_type, L.addr_2_type);                  
			// self.ADDR_2_LINE_1 	:= IF (C=2, R.addr_line_1, L.addr_2_line_1);               
			// self.ADDR_2_LINE_2	:= IF (C=2, R.addr_line_2, L.addr_2_line_2);             
			// self.ADDR_2_LINE_3 	:= IF (C=2, R.addr_line_3, L.addr_2_line_3);              
			// self.ADDR_2_CITY	:= IF (C=2, R.addr_city, L.addr_2_city);               
			// self.ADDR_2_STATE	:= IF (C=2, R.addr_state, L.addr_2_state);
			// self.ADDR_2_ZIP		:= IF (C=2, R.addr_zip, L.addr_2_zip);                
			// self.ADDR_2_COUNTY	:= IF (C=2, R.addr_county, L.addr_2_county);               
			// self.ADDR_2_COUNTRY	:= IF (C=2, R.addr_country, L.addr_2_country); 
			// self.numRows		:= c;

			// SELF := L;
		// END;
				
			
		// joinCorpWithName := join(Files_Raw_Input.corporation(fileDate), Files_Raw_Input.name(fileDate),
							// trim(left.Pitemid,left,right) = right.pitemid,
							// MergeCorpName(left,right),
							// left outer);
				
						
		// joinCorpNameAddr := denormalize(joinCorpWithName, Files_Raw_Input.address(fileDate),
							// trim(left.Pitemid,left,right) = right.pitemid,
							// MergeCorpNameAddr(left,right,COUNTER));
							
		
		// RollupAddress	 := rollup(joinCorpNameAddr,left.PITEMID=right.PITEMID,tRollupMultAddr(left,right));
							
		mappedMO := project(joinCorpNameAddr, MO_corpTransform(left));	

		joinNameType := 	join(mappedMO,nameTypeTable,
							trim(left.corp_ln_name_type_cd,left,right) = right.typeCode,
							findNameType(left,right),
							left outer, lookup);

		
		joinAddressType := 	join(joinNameType,addrTypeTable,
							trim(left.corp_address1_type_cd,left,right) = right.typeCode,
							findAddrType(left,right),
							left outer, lookup);

		joinCorpType := 	join(joinAddressType,corpTypeTable,
							trim(left.corp_orig_bus_type_cd,left,right) = right.typeCode,
							findCorpType(left,right),
							left outer, lookup);
		
				
		CleanCorp:= project (joinCorpType,CleanCorpNameAddr(left));	
		

		joinCorpStatus := join(CleanCorp,corpStatusTable,
					trim(left.corp_status_cd,left,right) = right.statusCode,
					findCorpStatus(left,right),
					left outer, lookup);
				
						
		MergeFilesForCorp := output(joinCorpStatus,,'~thor_data400::in::corp2::'+version+'::corp_mo',__COMPRESSED__,overwrite);

		
		Layouts_Raw_Input.CorpFiln MergeCorpFining(Layouts_Raw_Input.Corporation l, Layouts_Raw_Input.filing r ) := transform
			self 					:= l;
			self					:= r;
		end; // end transform
		
					
		joinCorpWithFiling := join(Files_Raw_Input.corporation(fileDate), Files_Raw_Input.filing(fileDate),
							trim(left.Pitemid,left,right) = right.pitemid,
							MergeCorpFining(left,right),
							left outer);
							
		mapEvent := project(joinCorpWithFiling, MO_EventTransform(left));	
		

		a := join(	mapEvent,DocTypeTable,
					trim(left.event_filing_cd,left,right) = right.TypeCode,
					findDocType(left,right),
					left outer, lookup);
					
		b := project(joinCorpWithFiling, MO_ARTransform(left));
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_mo'	,a							,event_out,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_mo'		,b							,ar_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_mo'	,joinCorpStatus	,corp_out	,,,pOverwrite);
		                                                                                                                                                       
		mappedMO_Filing := parallel(
			 corp_out	
			,event_out							
			,ar_out									
	 );  

		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('mo',filedate,pOverwrite := pOverwrite))
			,mappedMO_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_mo')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_mo')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event','~thor_data400::in::corp2::'+version+'::event_mo')
			)
		);

		return result;
	end;					 
	
end; // end of MO module
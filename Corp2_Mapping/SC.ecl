import ut, lib_stringlib, _validate, Address, corp2, lib_datalib, _control, versioncontrol;

export SC := MODULE;
	
	export Layouts_Raw_Input := MODULE;

		export CorpName := record
			string CORP_ID;
			string CORP_NAME;
			string NAME_TYPE;
			string EXP_DATE;
			string CORP_COMP_NAME;
			string lf;
		end;

		export CorpTxn := record
			string CORP_ID;
			string FILE_DATE;
			string TXN_ID;
			string TXN_COMMENT;
			// string TXN_DATE;
			string lf;
		end;

		export CorpFile := record
			string CORP_ID;
			string CORP_INC_NAME;
			string REG_AGENT_NAME;
			string ADDR_1;
			string ADDR_2;
			string CITY;
			string STATE;
			string ZIP;
			string ZIP_PLUS_4;
			string FILE_DATE;
			string EFF_DATE;
			string EXP_DATE;
			string DISSOLVED_DATE;
			string STATUS;
			string DOM_FOR_CODE;
			string CORP_TYPE;
			string INCORP_STATE;
			string lf;
		end;
	
	end; // end of Layouts_Raw_Input module
	
	export Files_Raw_Input := MODULE;
	
		export corpFile(string FileDate)		:= distribute(dataset('~thor_data400::in::corp2::'+filedate+'::corpFile::sc',	
																	layouts_Raw_Input.CorpFile,
																	CSV(HEADING(1),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']),QUOTE('"'))),
															  hash32(corp_id)
															  );
										  
		export corpNameFile(string FileDate)	:= distribute(dataset('~thor_data400::in::corp2::'+filedate+'::corpNameFile::sc',	
																	layouts_Raw_Input.CorpName,
																	CSV(HEADING(1),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']),QUOTE('"'))),
															  hash32(corp_id)
															  );
										  
		export corpTxnFile(string FileDate)		:= distribute(dataset('~thor_data400::in::corp2::'+filedate+'::corpTxnFile::sc',	
																	layouts_Raw_Input.CorpTxn,
																	CSV(HEADING(1),SEPARATOR([',']), TERMINATOR(['\r\n', '\n']),QUOTE('"'))),
															  hash32(corp_id)
															  );										  
	
	end;

	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
		TrimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		
		CorpFileLookups := record
			string CORP_ID;
			string CORP_INC_NAME;
			string REG_AGENT_NAME;
			string ADDR_1;
			string ADDR_2;
			string CITY;
			string STATE;
			string ZIP;
			string ZIP_PLUS_4;
			string FILE_DATE;
			string EFF_DATE;
			string EXP_DATE;
			string DISSOLVED_DATE;
			string STATUS;
			string DOM_FOR_CODE;
			string CORP_TYPE;
			string INCORP_STATE;
			string stdStateCode;
			string forgnStateDesc;
		end;		
		
		corp2_mapping.Layout_CorpPreClean corpMasterTransform(corpFileLookups input) := transform

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '45-' + trimUpper(input.corp_id);
			self.corp_vendor					:= '45';
			self.corp_state_origin				:= 'SC';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.corp_id);
			self.corp_src_type					:= 'SOS';
			
			self.corp_legal_name				:= trimUpper(input.corp_inc_name); 														
			self.corp_ln_name_type_cd			:= '01';
			self.corp_ln_name_type_desc			:='LEGAL';
			
			self.corp_inc_state					:= if( trimUpper(input.stdStateCode) = 'SC',
														'SC',
														''
												       );
												   
			self.corp_forgn_state_cd            := if( 	trimUpper(input.stdStateCode) <> 'SC' and
														trimUpper(input.stdStateCode) <> '',
															trimUpper(input.stdStateCode),
															''
													  );
												   
			self.corp_forgn_state_desc          := if( 	trimUpper(input.stdStateCode) <> 'SC' and
														trimUpper(input.stdStateCode) <> '',
															trimUpper(input.forgnStateDesc),
															''
												      );
													  
			cleanCorpType						:= trimUpper(input.corp_type);
											
			self.corp_orig_org_structure_cd		:= cleanCorpType;
			
			self.corp_orig_org_structure_desc	:= map(	cleanCorpType = 'BOP' 			=> 'BUSINESS OPPORTUNITY',
														cleanCorpType = 'BUS'			=> 'BUSINESS PROFIT ENTITY',
														cleanCorpType = 'CORP'			=> 'CORPORATION FOR PROFIT',
														cleanCorpType = 'ELE'			=> 'ELEEMOSYNARY NONPROFIT',
														cleanCorpType = 'ELE - CORP'	=> 'ELEEMOSYNARY FOR PROFIT',
														cleanCorpType = 'LIM'			=> 'LIMITED PARTNERSHIP',
														cleanCorpType = 'LLC'			=> 'LIMITED LIABILITY COMPANY',
														cleanCorpType = 'LLP'			=> 'LIMITED LIABILITY PARTNERSHIP',
														cleanCorpType = 'LP'			=> 'LIMITED PARTNERSHIP',
														cleanCorpType = 'REG'			=> 'REGISTRATION',
														cleanCorpType = 'REG - CORP'	=> 'REGISTRATION FOR CORPORATION',
														cleanCorpType = 'REG - LLC'		=> 'REGISTRATION FOR LIMITED LIABILITY',
														cleanCorpType = 'RES'			=> 'RESERVATION',
														cleanCorpType = 'RES - CORP'	=> 'RESERVATION FOR CORPORATION',
														cleanCorpType = 'RES - ELE'		=> 'RESERVATION FOR ELEEMOSYNARY',
														cleanCorpType = 'RES - LLC'		=> 'RESERVATION FOR LIMITED LIABILITY',
														''
														);
														
			self.corp_inc_date					:= if (	trim(input.file_date,left,right) <> '' and
														trimUpper(input.stdStateCode) = 'SC' and
														_validate.date.fIsValid(input.file_date) and
														_validate.date.fIsValid(input.file_date,_validate.date.rules.DateInPast),
															trim(input.file_date,left,right),
															''
												       );
												   
			self.corp_forgn_date	            := if (	trim(input.file_date,left,right) <> '' and
														trimUpper(input.stdStateCode) <> 'SC' and
														_validate.date.fIsValid(input.file_date) and
														_validate.date.fIsValid(input.file_date,_validate.date.rules.DateInPast),
															trim(input.file_date,left,right),
															''
												       );
													   
			cleanStatus							:= trimUpper(input.status);
													   
			self.corp_status_cd					:= cleanStatus;
			self.corp_status_desc				:= map(	cleanStatus = 'DIS' => 'DISSOLVED',
														cleanStatus = 'FOR' => 'FORFEITURE',
														cleanStatus = 'GDS' => 'GOOD STANDING',
														cleanStatus = 'INT' => 'INTENT',
														cleanStatus = 'MER' => 'MERGER',
														cleanStatus = 'NAG' => 'NO AGENT',
														cleanStatus = 'REG' => 'NAME REGISTRATION',
														cleanStatus = 'REI' => 'REINSTATEMENT',
														cleanStatus = 'RES' => 'RESERVATION',
														''
													   );
			self.corp_status_date				:= if (	cleanStatus = 'DIS' and 
														_validate.date.fIsValid(input.dissolved_date) and
														_validate.date.fIsValid(input.dissolved_date,_validate.date.rules.DateInPast),
															input.dissolved_date,
															''
													   );
													  
            self.corp_foreign_domestic_ind		:= map(	input.dom_for_code = '1' => 'D',
														input.dom_for_code = '2' => 'F',
														''
												       );
													   
            self.corp_term_exist_cd				:= if (	input.dom_for_code = '1' and
														trim(input.exp_date,left,right) <> '',
															'D',
															''
													   );
													   
            self.corp_term_exist_exp			:= if (	input.dom_for_code = '1' and
														trim(input.exp_date,left,right) <> '',
															trim(input.exp_date,left,right),
															''
													   );
													   
            self.corp_term_exist_desc			:= if (	input.dom_for_code = '1' and
														trim(input.exp_date,left,right) <> '',
															'EXPIRATION DATE',
															''
													   );
													   
            self.corp_forgn_term_exist_cd		:= if (	input.dom_for_code = '2'and
														trim(input.exp_date,left,right) <> '',
															'D',
															''
													   );
													   
            self.corp_forgn_term_exist_exp		:= if (	input.dom_for_code = '2'and
														trim(input.exp_date,left,right) <> '',
															trim(input.exp_date,left,right),
															''
													   );
													   
            self.corp_forgn_term_exist_desc		:= if ( input.dom_for_code = '2'and
														trim(input.exp_date,left,right) <> '',
															'EXPIRATION DATE',
															''
													   );	
													   
			self.corp_ra_name					:= if (	trimUpper(input.reg_agent_name) <> 'NAME REGISTRATION' and
														trimUpper(input.reg_agent_name) <> 'RESERVED NAME',
														trimUpper(input.reg_agent_name),
														''
													   );

													  
			self.corp_ra_address_line1 			:= trimUpper(input.addr_1);
														
													   
			self.corp_ra_address_line2			:= trimUpper(input.addr_2);
														
			self.corp_ra_address_line3			:= trimUpper(input.city);
														
			self.corp_ra_address_line4			:= trimUpper(input.state);
											
			self.corp_ra_address_line5			:= if ((string)((integer)input.zip) <> '0',
														if((string)((integer)input.zip_plus_4) <> '0',
															trim(input.zip,left,right) + trim(input.zip_plus_4,left,right),
															input.zip
														   ),
														''
													   );
														
							   			
			self := [];
						
		end; 	
		
		corp2_mapping.Layout_CorpPreClean corpOtherNameTransform(Layouts_Raw_Input.corpName input) := transform

			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '45-' + trimUpper(input.corp_id);
			self.corp_vendor					:= '45';
			self.corp_state_origin				:= 'SC';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.corp_id);
			self.corp_src_type					:= 'SOS';
			
			self.corp_legal_name				:= trimUpper(input.corp_name); 														
			
			cleanNameType						:= trimUpper(input.name_type);
			
			self.corp_ln_name_type_cd			:= cleanNameType;
			self.corp_ln_name_type_desc			:= map(	cleanNameType = 'ASM' => 'ASSUMED NAME',
														cleanNameType = 'FLC' => 'FOREIGN LIMITED LIABILITY COMPANY',
														cleanNameType = 'AUT' => 'AUTHORITY',						
														cleanNameType = 'FMR' => 'FORMER',
														cleanNameType = 'DBA' => 'DOING BUSINESS AS',					
														cleanNameType = 'INC' => 'INCORPORATION',
														cleanNameType = 'DIS' => 'DISSOLUTION',						
														cleanNameType = 'LIM' => 'LIMITED PARTNERSHIP',
														cleanNameType = 'DLC' => 'DOMESTIC LIMITED LIABILITY COMPANY',		
														cleanNameType = 'MER' => 'MERGER',
														cleanNameType = 'DLP' => 'DOMESTIC LIMITED LIABILITY PARTNERSHIP',
														cleanNameType = 'REG' => 'REGISTRATION',
														cleanNameType = 'ELE' => 'ELEEMOSYNARY (NON-PROFIT)',
														cleanNameType = 'RES' => 'RESERVATION',
														cleanNameType = 'FIC' => 'FICTITIOUS NAME',	
														''
													  );
													  
            self.corp_term_exist_cd				:= if (TRIM(input.exp_date,left,right) <> '',
														'D',
														''
													   );
													   
            self.corp_term_exist_exp			:= if (TRIM(input.exp_date,left,right) <> '',
														input.exp_date,
														''
													   );
													   
            self.corp_term_exist_desc			:= if (TRIM(input.exp_date,left,right) <> '',
														'EXPIRATION DATE',
														''
													   );													  
			
			
			self								:= [];
		end;
		
		Corp2.Layout_Corporate_Direct_Event_In EventTransform(Layouts_raw_input.corpTxn  input):=transform	
		
			self.corp_key						:= '45-' + trimUpper(input.corp_id);	
			self.corp_vendor					:= '45';		
		
			self.corp_state_origin				:= 'SC';
			self.corp_process_date				:= fileDate;

			self.corp_sos_charter_nbr			:= trimUpper(input.corp_id);
			
			self.event_filing_date				:= if (	trim(input.FILE_DATE,left,right) <> '' and 
														_validate.date.fIsValid(input.FILE_DATE) and
														_validate.date.fIsValid(input.FILE_DATE,_validate.date.rules.DateInPast),
															trim(input.FILE_DATE,left,right),
															''
													   );
			cleanTxnID							:= trimUpper(input.txn_id);
			self.event_filing_cd				:= cleanTxnID;
			self.event_filing_desc				:= map (	cleanTxnID = 'AGT' => 'AGENT',
															cleanTxnID = 'FLP' => 'FOREIGN LLP',
															cleanTxnID = 'AMD' => 'AMENDMENT',					
															cleanTxnID = 'FOR' => 'FORFEITURE',
															cleanTxnID = 'AUT' => 'AUTHORITY',					
															cleanTxnID = 'INC' => 'INCORPORATION',
															cleanTxnID = 'COR' => 'CORRECTION',					
															cleanTxnID = 'INT' => 'INTENT',
															cleanTxnID = 'DBA' => 'DOING BUSINESS AS',				
															cleanTxnID = 'LAR' => 'LLC ANNUAL REPORT',
															cleanTxnID = 'DIS' => 'DISSOLUTION',					
															cleanTxnID = 'LIM' => 'LIMITED PARTNERSHIP',
															cleanTxnID = 'DLC' => 'DOMESTIC LLC',				
															cleanTxnID = 'LPA' => 'LIMITED PARTNERSHIP AMENDMENT',
															cleanTxnID = 'DLP' => 'DOMESTIC LLP',				
															cleanTxnID = 'LPR' => 'LLP RENEWAL',
															cleanTxnID = 'ELA' => 'ELEEMOSYNARY AMENDMENT',		
															cleanTxnID = 'NAG' => 'NO AGENT, NOT IN GOOD STANDING',
															cleanTxnID = 'ELD' => 'ELEEMOSYNARY DISSOLUTION',		
															cleanTxnID = 'PSC' => 'PUBLIC SERVICE DISTRICT CONVERSION',
															cleanTxnID = 'ELE' => 'ELEEMOSYNARY INCORPORATION',		
															cleanTxnID = 'REG' => 'REGISTRATION',
															cleanTxnID = 'ELR' => 'ELEEMOSYNARY RELIGIOUS',			
															cleanTxnID = 'REI' => 'REINSTATEMENT',
															cleanTxnID = 'ERR' => 'FORFEITURE IN ERROR',			
															cleanTxnID = 'RES' => 'RESERVATION',
															cleanTxnID = 'FAM' => 'FOREIGN AMENDMENT',			
															cleanTxnID = 'SPD' => 'SPECIAL PURPOSE DISTRICT',
															cleanTxnID = 'FIC' => 'FICTITIOUS NAME',				
															cleanTxnID = 'WDR' => 'WITHDRAWAL',
															cleanTxnID = 'FLC' => 'FOREIGN LLC',
															''
														);
            self.event_desc						:= trimUpper(input.txn_comment);
			self								:= [];
		end;
		
		Corp2.Layout_Corporate_Direct_Corp_In CleanCorpAddrName(corp2_mapping.Layout_CorpPreClean input) := transform		
			string73 tempname 					:= if(input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');
			
		
			string182 clean_ra_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' +
																				trim(input.corp_ra_address_line2,left,right),
																				left,right
																				),
														                   trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
																				trim(input.corp_ra_address_line4,left,right) + ' ' +
																				trim(input.corp_ra_address_line5,left,right),
																				left,right
																				)
																		   );	
																				
			self.corp_ra_prim_range    			:= clean_ra_address[1..10];
			self.corp_ra_predir 	      		:= clean_ra_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_ra_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_ra_address[41..44];
			self.corp_ra_postdir 	    		:= clean_ra_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_ra_address[47..56];
			self.corp_ra_sec_range 	  			:= clean_ra_address[57..64];
			self.corp_ra_p_city_name	  		:= clean_ra_address[65..89];
			self.corp_ra_v_city_name	  		:= clean_ra_address[90..114];
			self.corp_ra_state 			      	:= clean_ra_address[115..116];
			self.corp_ra_zip5 		      		:= clean_ra_address[117..121];
			self.corp_ra_zip4 		      		:= clean_ra_address[122..125];
			self.corp_ra_cart 		      		:= clean_ra_address[126..129];
			self.corp_ra_cr_sort_sz 	 		:= clean_ra_address[130];
			self.corp_ra_lot 		      		:= clean_ra_address[131..134];
			self.corp_ra_lot_order 	  			:= clean_ra_address[135];
			self.corp_ra_dpbc 		      		:= clean_ra_address[136..137];
			self.corp_ra_chk_digit 	  			:= clean_ra_address[138];
			self.corp_ra_rec_type		  		:= clean_ra_address[139..140];
			self.corp_ra_ace_fips_st	  		:= clean_ra_address[141..142];
			self.corp_ra_county 	  			:= clean_ra_address[143..145];
			self.corp_ra_geo_lat 	    		:= clean_ra_address[146..155];
			self.corp_ra_geo_long 	    		:= clean_ra_address[156..166];
			self.corp_ra_msa 		      		:= clean_ra_address[167..170];
			self.corp_ra_geo_blk				:= clean_ra_address[171..177];
			self.corp_ra_geo_match 	  			:= clean_ra_address[178];
			self.corp_ra_err_stat 	    		:= clean_ra_address[179..182];
			
			self								:= input;
			self 								:= [];
		end;
		
	
		//--------------------  State code explosion ---------------------
		
		ForgnStateDescLayout := record,MAXLENGTH(100)
			string code;
			string stdcode;
			string desc;
		end; 
	
		ForgnStateTable := dataset(_dataset().foreign_prod + 'thor_data400::lookup::corp2::forgnstatedesc::sc', ForgnStateDescLayout, CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
		
		CorpFileLookups findStateCode(Layouts_Raw_Input.corpFile input, ForgnStateDescLayout r ) := transform
			self.forgnStateDesc   	:= r.Desc;
			self.stdStateCode		:= r.stdcode;
			self         		  	:= input;
		end;
	
		PopforgnStateDesc := join(	Files_raw_input.corpFile(filedate), ForgnStateTable,
									trim(left.incorp_state,left,right) = right.code,
									findStateCode(left,right),
									left outer, lookup
								  );
		
		CorpMaster		:= project(PopforgnStateDesc, corpMasterTransform(left));
		
		CorpOther		:= project(Files_Raw_Input.corpNameFile(filedate), corpOtherNameTransform(left));
		
		AllCorps		:= distribute(corpMaster + corpOther, hash32(corp_key));

		AllCorpsSrted 	:= sort(AllCorps,corp_key,LOCAL);
			
		cleanCorp 		:= project(AllCorpsSrted, CleanCorpAddrName(left));			  

		mapEvent		:= project(Files_Raw_Input.corpTxnFile(fileDate), EventTransform(left));
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_sc'	,cleanCorp	,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_sc' ,MapEvent 	,event_out	,,,pOverwrite);
		                                
		mapSCCorpFiling := parallel(                                                                                                                              
											 corp_out	
											,event_out
									 );		
	 
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('sc',filedate,pOverwrite := pOverwrite))
			,mapSCCorpFiling
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_sc')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event'	,'~thor_data400::in::corp2::'+version+'::event_sc')
			)
		);
					 
		return result;
	end;					 
	
end; 
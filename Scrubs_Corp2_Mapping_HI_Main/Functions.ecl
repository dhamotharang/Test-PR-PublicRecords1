IMPORT corp2, scrubs;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_corp_key: returns true or false based upon the incoming code.
		//									 
		//NOTE: The purpose of this routine is to validate the corp_key for HI.  The
		//			file number must be all numeric or this function will return false. 
		//****************************************************************************
		EXPORT invalid_corp_key(STRING code) := FUNCTION
					 uc_code			:= corp2.t2u(code);
					 codeparts 		:= stringlib.splitwords(uc_code,'-',false);
					 state_fips 	:= trim(codeparts[1],left,right);
					 file_suffix 	:= trim(codeparts[2],left,right);
					 file_number 	:= trim(codeparts[3],left,right);

					 isValidCorpKey := map(regexfind('\\T',uc_code,0) <> '' => false,  //Any charter number with a "T" in it is a "Temporary Record"
																 file_number = '' 								=> false,
																 file_suffix = '' 								=> false,
																 state_fips  = '' 								=> false,
																 state_fips = '15' and stringlib.stringfilterout(file_number,'0123456789')='' => true,
																 false
																);
																
					RETURN if(isValidCorpKey,1,0);
					
		END;
		
		//****************************************************************************
		//invalid_corp_sos_charter_nbr: returns true or false based upon the incoming
		//									 						code.
		//NOTE: The purpose of this routine is to validate the corp_key for HI.  The
		//			file number must be all numeric or this function will return false. 
		//****************************************************************************
		EXPORT invalid_corp_sos_charter_nbr(STRING code) := FUNCTION
		
					 uc_code			:= corp2.t2u(code);
					 codeparts 		:= stringlib.splitwords(uc_code,' ',false);
					 file_number 	:= trim(codeparts[1],left,right);			 
					 file_suffix 	:= trim(codeparts[2],left,right);
					 
					 isValidCorpSosCharterNbr := map(regexfind('\\T',uc_code,0) <> '' => false,  //Any charter number with a "T" in it is a "Temporary Record"
																					 file_number = '' 								=> false,
																					 file_suffix = '' 								=> false,
																					 stringlib.stringfilterout(file_number,'0123456789')='' => true,
																					 false
																					);
																					
					RETURN if(isValidCorpSosCharterNbr,1,0);
					
		END;		
		
		//****************************************************************************
		//invalid_corp_term_exist_exp: returns true or false based upon the incoming
		//									 					 string value "s".
		//NOTE: The purpose of this routine is to validate the corp_term_exist_exp
		//			field for HI.  Typically it is a date.  However, for HI it can be a
		//			date or a numeric value representing the number of years.
		//****************************************************************************
		EXPORT invalid_corp_term_exist_exp(STRING s) := FUNCTION
		
					 uc_s							:= corp2.t2u(s);
					 
					 isValidDate			:= if(Scrubs.fn_valid_GeneralDate(uc_s)>0,true,false);
					 
					 isNumberOfYears	:= if(Stringlib.StringFilterout(uc_s,'0123456789')='',true,false);

					 RETURN if(isValidDate or isNumberOfYears,1,0);
					 
		END;

		//****************************************************************************
		//invalid_ln_name_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_ln_name_type_cd(STRING s, STRING recordorigin) := FUNCTION
		
					 uc_s							:= corp2.t2u(s);
					 uc_ro 						:= corp2.t2u(recordorigin);

					 isValidCode			:= if(uc_ro = 'C',
																	map(uc_s in ['01','03','04','05','X1','X2'] => true,
																			false
																		 ),
																	true //For contact records, corp_ln_name_type_cd doesn't have to exist
																 );																	 
					 RETURN if(isValidCode,1,0);
					 
		END;

		//****************************************************************************
		//invalid_ln_name_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_ln_name_type_desc(STRING s, STRING recordorigin) := FUNCTION

					 uc_s 			 := corp2.t2u(s);
					 uc_ro 			 := corp2.t2u(recordorigin);                 

					 isValidDesc := if(uc_ro = 'C',
														 map(uc_s in ['CROSS REFERENCE NAME','LEGAL','SECOND CROSS REFERENCE NAME'] => true,
																 uc_s in ['SERVICEMARK','TRADEMARK','TRADENAME'] 												=> true,														 
																 false
																),
														 true //For contact records, corp_ln_name_type_desc doesn't have to exist
														);
														
					 RETURN if(isValidDesc,1,0);
					 
		END;

		//****************************************************************************
		//invalid_address_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_address_type_cd(STRING s, STRING recordorigin) := FUNCTION
		
					 uc_s							:= corp2.t2u(s);
					 uc_ro 						:= corp2.t2u(recordorigin);

					 isValidCode			:= if(uc_ro = 'C',
																	map(uc_s in ['','B','M','R','TM'] => true,
																			false
																		 ),
																	true //For contact records, address type code doesn't have to exist
																 );
																 
					 RETURN if(isValidCode,1,0);
					 
		END;

		//****************************************************************************
		//invalid_address_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_address_type_desc(STRING s, STRING recordorigin) := FUNCTION
		
					 uc_s							:= corp2.t2u(s);
					 uc_ro 						:= corp2.t2u(recordorigin);

					 isValidDesc			:= if(uc_ro = 'C',
																	map(uc_s in ['','BUSINESS','MAILING','REGISTERED OFFICE','TRADENAME/TRADEMARK/SERVICEMARK MAILING'] => true,
																			false
																		 ),
																	true //For contact records, address type desc doesn't have to exist
																 );
																 
					 RETURN if(isValidDesc,1,0);
					 
		END;

		//****************************************************************************
		//invalid_term_exist_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_term_exist_cd(STRING s) := FUNCTION
		
					 uc_s							:= corp2.t2u(s);
					 					 
					 isValidCode			:= map(uc_s in ['','D','N','P'] => true,
																	 false
																	);
																	 
					 RETURN if(isValidCode,1,0);
					 
		END;
		
		//****************************************************************************
		//invalid_term_exist_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_term_exist_desc(STRING s) := FUNCTION
		
					 uc_s							:= corp2.t2u(s);
					 					 
					 isValidCode			:= map(uc_s in ['','EXPIRATION DATE','NUMBER OF YEARS','PERPETUAL'] => true,
																	 false
																	);
																	 
					 RETURN if(isValidCode,1,0);
					 
		END;
		
		//****************************************************************************
		//invalid_corp_filing_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_corp_filing_desc(STRING s) := FUNCTION
		
					 uc_s							:= corp2.t2u(s);
					 					 
					 isValidDesc			:= map(uc_s in ['','CERTIFICATION','ORGANIZATION','REGISTRATION'] => true,
																	 false
																	);
																	 
					 RETURN if(isValidDesc,1,0);
					 
		END;
		
		//****************************************************************************
		//invalid_filesuffix: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_filesuffix(STRING s) := FUNCTION
		
					 uc_s							:= corp2.t2u(s);
					 
					 isValidCode			:= map(uc_s in [''] 																=> true,
																	 uc_s in ['A2','CA','C5','C6','D1','D2','D9'] => true,
																	 uc_s in ['F1','F2','G5','G6','K5','K6']			=> true,
																	 uc_s in ['L5','L6','P1','Q5','Q6','R7','ZZ'] => true,
																	 false
																	);
																	 
					 RETURN if(isValidCode,1,0);
					 
		END;
		
		//****************************************************************************
		//invalid_companytype: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_companytype(STRING s) := FUNCTION
		
					 uc_s		 := corp2.t2u(stringlib.stringfilter(corp2.t2u(s),' ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

					 isValidDesc			:=  map(uc_s in ['']																					=> true,
																		uc_s in ['AGRICULTUREFISH COOP']											=> true,
																		uc_s in ['INDIVIDUALREGISTERED CRA']									=> true,
																		uc_s in ['DOMESTIC LIMITED LIABILITY COMPANY LLC']		=> true,
																		uc_s in ['FOREIGN LIMITED LIABILITY COMPANY LLC']			=> true,
																		uc_s in ['DOMESTIC PROFIT CORPORATION']								=> true,
																		uc_s in ['DOMESTIC NONPROFIT CORPORATION']						=> true,
																		uc_s in ['CORPORATION SOLE']													=> true,
																		uc_s in ['FOREIGN PROFIT CORPORATION']								=> true,
																		uc_s in ['FOREIGN NONPROFIT CORPORATION']							=> true,
																		uc_s in ['GENERAL DOMESTIC PARTNERSHIP']							=> true,
																		uc_s in ['GENERAL FOREIGN PARTNERSHIP']								=> true,
																		uc_s in ['DOMESTIC LIMITED LIABILITY PARTNERSHIP']		=> true,
																		uc_s in ['FOREIGN LIMITED LIABILITY PARTNERSHIP']			=> true,
																		uc_s in ['DOMESTIC LIMITED PARTNERSHIP']							=> true,
																		uc_s in ['FOREIGN LIMITED PARTNERSHIP']								=> true,
																		uc_s in ['DOMESTIC PROFESSIONAL CORPORATION']					=> true,
																		uc_s in ['DOMESTIC PROFESSIONAL LLP']									=> true,
																		uc_s in ['FOREIGN PROFESSIONAL LLP']									=> true,
																		uc_s in ['NAME RESERVATION']													=> true,
																		uc_s in ['DOMESTIC LLLP']															=> true,
																		uc_s in ['FOREIGN LLLP']															=> true,
																		uc_s in ['TEMPORARY TRANSACTION']											=> true,
																		uc_s in ['UNREGISTERED OWNER']												=> true,
																		uc_s in ['COOPERATIVE']												        => true,
																		false
																		);
																		
					 RETURN if(isValidDesc,1,0);
																		
		END;

		//****************************************************************************
		//invalid_cont_type_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_cont_type_cd(STRING s, STRING recordorigin) := FUNCTION
		
					 uc_s							:= corp2.t2u(s);
					 uc_ro 						:= corp2.t2u(recordorigin);

					 isValidCode			:= if(uc_ro = 'T',
																	map(uc_s in ['02','F','M'] => true,
																			false
																		 ),
																	true //For corporation records, contact type code doesn't have to exist
																 );
																 
					 RETURN if(isValidCode,1,0);
					 
		END;
		
		//****************************************************************************
		//invalid_cont_type_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_cont_type_desc(STRING s, STRING recordorigin) := FUNCTION
		
					 uc_s							:= corp2.t2u(s);
					 uc_ro 						:= corp2.t2u(recordorigin);

					 isValidDesc			:= if(uc_ro = 'T',					 					 
																	map(uc_s in ['OFFICER','MEMBER/MANAGER/PARTNER','REGISTRANT'] => true,
																			false
																		 ),																			
																	true //For corporation records, contact type desc doesn't have to exist
																 );
																 
					 RETURN if(isValidDesc,1,0);
					 
		END;
		
		//****************************************************************************
		//invalid_corp_llc_managed_desc: returns true or false based upon the incoming
		//															 code.
		//****************************************************************************
		EXPORT invalid_corp_llc_managed_desc(STRING s) := FUNCTION
		
					 uc_s							:= corp2.t2u(s);

					 isValidDesc			:= map(uc_s in ['','MEMBER MANAGED','MANAGER MANAGED'] => true,
																	 false
																	);
																	 
					 RETURN if(isValidDesc,1,0);
					 
		END;
		
		//****************************************************************************
		//invalid_corp_name_status_desc: returns true or false based upon the incoming
		//															 code.
		//****************************************************************************
		EXPORT invalid_corp_name_status_desc(STRING s) := FUNCTION
		
					 uc_s							:= corp2.t2u(s);
					 					 
					 isValidDesc			:= map(uc_s in ['','ACTIVE','EXPIRED','CANCELLED','REVOKED'] => true,
																	 false
																	);
																	 
					 RETURN if(isValidDesc,1,0);
					 
		END;
		
		//****************************************************************************
		//invalid_corp_status_desc: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_corp_status_desc(STRING s) := FUNCTION
		
					 uc_s							:= corp2.t2u(s);
					 					 	
					 isValidDesc			:= map(uc_s in [''] 																	=> true,
																	 uc_s in ['ANNUAL REPORT 1 YEAR DELINQUENT'] 		=> true,
																	 uc_s in ['ANNUAL REPORT 2 YEARS DELINQUENT'] 	=> true,
																	 uc_s in ['ACTIVE'] 														=> true,
																	 uc_s in ['ADMINISTRATIVELY TERMINATED'] 				=> true,
																	 uc_s in ['CHECK BOUNCED'] 											=> true,
																	 uc_s in ['CANCELLED'] 													=> true,
																	 uc_s in ['CONSOLIDATED'] 											=> true,
																	 uc_s in ['CONVERTED'] 													=> true,
																	 uc_s in ['DISSOLVED'] 													=> true,
																	 uc_s in ['EXPIRED'] 														=> true,
																	 uc_s in ['HELD'] 															=> true,
																	 uc_s in ['INVOLUNTARILY CANCELLED'] 						=> true,
																	 uc_s in ['INVOLUNTARILY DISSOLVED'] 						=> true,
																	 uc_s in ['INVOLUNTARILY REVOKED'] 							=> true,
																	 uc_s in ['MERGED'] 														=> true,
																	 uc_s in ['NEW'] 																=> true,
																	 uc_s in ['NAME CHANGE'] 												=> true,
																	 uc_s in ['PURGED'] 														=> true,
																	 uc_s in ['RECORDS FROZEN'] 										=> true,
																	 uc_s in ['REVOKED'] 														=> true,
																	 uc_s in ['SUSPENDED'] 													=> true,
																	 uc_s in ['TERMINATED'] 												=> true,
																	 uc_s in ['WITHDRAWN'] 													=> true,
																	 false
																	);
																	 
					 RETURN if(isValidDesc,1,0);											
		END;
		
END;
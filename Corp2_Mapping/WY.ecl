 import ut, lib_stringlib, _validate, Address, corp2, _control, versioncontrol;

export WY := MODULE;

	export Layouts_Raw_Input := MODULE;
	
	
	//vendor data starts
	export PARTY  := record
		string20 	PARTY_ID;
		string50 	PARTY_TYPE;
		string20 	SOURCE_ID;
		string50 	SOURCE_TYPE;
		string256 	ORG_NAME;
		string50 	FIRST_NAME;
		string30 	MIDDLE_NAME;
		string100 	LAST_NAME;
		string100 	INDIVIDUAL_TITLE;
		string256 	ADDR1;
		string100 	ADDR2;
		string100 	ADDR3;
		string60 	CITY;
		string60 	COUNTY;
		string50 	STATE;
		string30 	POSTAL_CODE;
		string100 	COUNTRY;
		
	end;
	
	
	export FILING_ANNUAL_REPORT  := record
	
		string20 	FILING_ANNUAL_REPORT_ID;
		string20 	FILING_ID;
		string50 	STATUS;
		string20 	ANNUAL_REPORT_NUM;
		string4 	FILING_YEAR;
		string20 	FILING_DATE;
		string20 	LICENSE_TAX_AMT;
	
	end;
	
	export FILING  := record
	
		string20 	FILING_ID;
		string50 	FILING_TYPE;
		string50 	FILING_SUBTYPE;
		string50 	WORD_DESIGN_TYPE;
		string50 	DURATION_TERM_TYPE;
		string50 	STATUS;
		string50 	SUB_STATUS;
		string50 	STANDING_TAX;
		string50	STANDING_RA;
		string50	STANDING_OTHER;
		string50 	PURPOSE;
		string50 	APPLICANT_TYPE;
		string20 	FILING_NUM;
		string256 	FILING_NAME;
		string256 	OLD_NAME;
		string256 	FICTITIOUS_NAME;
		string1		DOMESTIC_YN;
		string20 	FILING_DATE;
		string20 	DELAYED_EFFECTIVE_DATE;
		string20 	EXPIRATION_DATE;
		string20 	INACTIVE_DATE;
		string20 	RA_RESIGN_CERT_LETTER_DATE;
		string1 	CONVERTED_YN;
		string128 	CONVERTED_FROM;
		string256 	CONVERTED_FROM_NAME;
		string20	CONVERTED_DATE;
		string1 	ISSUE_ON_RECORD_YN;
		string128 	TRANSFERED_TO;
		string20 	TRANSFERED_DATE;
		string128 	FORMATION_LOCALE;
		string128 	CONTINUED_FROM_LOCALE;
		string50 	DOMESTICATED_FROM_LOCALE;
		string20 	FORM_HOME_JURIS_DATE;
		string20 	COMMON_SHARES;
		string20 	COMMON_PAR_VALUE;
		string20 	PREFERRED_SHARES;
		string20 	PREFERRED_PAR_VALUE;
		string1 	ADDITIONAL_STOCK_YN;
		string128 	PRINCIPLE_ADDR1;
		string128 	PRINCIPLE_ADDR2;
		string128 	PRINCIPLE_ADDR3;
		string80 	PRINCIPLE_CITY;
		string50 	PRINCIPLE_STATE;
		string50 	PRINCIPLE_POSTAL_CODE;
		string128 	PRINCIPLE_COUNTRY;
		string128 	MAIL_ADDR1;
		string128 	MAIL_ADDR2;
		string128 	MAIL_ADDR3;
		string80 	MAIL_CITY;
		string50 	MAIL_STATE;
		string50 	MAIL_POSTAL_CODE;
		string128 	MAIL_COUNTRY;
		string50 	STATE_OF_ORG;
		string20 	ORG_DATE;
		string1 	REG_US_OFFICE_YN;
		string20 	REG_US_DATE;
		string30 	REG_US_SERIAL_NUM;
		string30 	REG_US_STATUS;
		string1 	REG_US_APP_REFUSED_YN;
		string20 	FIRST_USED_ANYWHERE_DATE;
		string20 	FIRST_USED_WYO_DATE;
		string1 	AR_EXEMPT_YN;
		string1000 	TRADEMARK_KEYWORDS;

	end;

	export FILINGPARTY  := record
	    
	
		string20 	FILING_ID;
		string50 	FILING_TYPE;
		string50 	FILING_SUBTYPE;
		string50 	WORD_DESIGN_TYPE;
		string50 	DURATION_TERM_TYPE;
		string50 	STATUS;
		string50 	SUB_STATUS;
		string50 	STANDING_TAX;
		string50	STANDING_RA;
		string50	STANDING_OTHER;
		string50 	PURPOSE;
		string50 	APPLICANT_TYPE;
		string20 	FILING_NUM;
		string256 	FILING_NAME;
		string256 	OLD_NAME;
		string256 	FICTITIOUS_NAME;
		string1		DOMESTIC_YN;
		string20 	FILING_DATE;
		string20	DELAYED_EFFECTIVE_DATE;
		string20 	EXPIRATION_DATE;
		string20	INACTIVE_DATE;
		string20 	RA_RESIGN_CERT_LETTER_DATE;
		string1 	CONVERTED_YN;
		string128 	CONVERTED_FROM;
		string256 	CONVERTED_FROM_NAME;
		string20	CONVERTED_DATE;
		string1 	ISSUE_ON_RECORD_YN;
		string128 	TRANSFERED_TO;
		string20 	TRANSFERED_DATE;
		string128 	FORMATION_LOCALE;
		string128 	CONTINUED_FROM_LOCALE;
		string50 	DOMESTICATED_FROM_LOCALE;
		string20 	FORM_HOME_JURIS_DATE;
		string20 	COMMON_SHARES;
		string20 	COMMON_PAR_VALUE;
		string20 	PREFERRED_SHARES;
		string20 	PREFERRED_PAR_VALUE;
		string1 	ADDITIONAL_STOCK_YN;
		string128 	PRINCIPLE_ADDR1;
		string128 	PRINCIPLE_ADDR2;
		string128 	PRINCIPLE_ADDR3;
		string80 	PRINCIPLE_CITY;
		string50 	PRINCIPLE_STATE;
		string50 	PRINCIPLE_POSTAL_CODE;
		string128 	PRINCIPLE_COUNTRY;
		string128 	MAIL_ADDR1;
		string128 	MAIL_ADDR2;
		string128 	MAIL_ADDR3;
		string80 	MAIL_CITY;
		string50 	MAIL_STATE;
		string50 	MAIL_POSTAL_CODE;
		string128 	MAIL_COUNTRY;
		string50 	STATE_OF_ORG;
		string20 	ORG_DATE;
		string1 	REG_US_OFFICE_YN;
		string20 	REG_US_DATE;
		string30 	REG_US_SERIAL_NUM;
		string30 	REG_US_STATUS;
		string1 	REG_US_APP_REFUSED_YN;
		string20 	FIRST_USED_ANYWHERE_DATE;
		string20 	FIRST_USED_WYO_DATE;
		string1 	AR_EXEMPT_YN;
		string1000 	TRADEMARK_KEYWORDS;
		string20 	PARTY_ID;
		string50 	PARTY_TYPE;
		string20 	SOURCE_ID;
		string50 	SOURCE_TYPE;
		string256 	ORG_NAME;
		string50 	FIRST_NAME;
		string30 	MIDDLE_NAME;
		string100 	LAST_NAME;
		string100 	INDIVIDUAL_TITLE;
		string256 	ADDR1;
		string100 	ADDR2;
		string100 	ADDR3;
		string60 	CITY;
		string60 	COUNTY;
		string50 	STATE;
		string30 	POSTAL_CODE;
		string100 	COUNTRY;
	end;//vendor data ends
	

end;//end of Layouts_Raw_Input module

	export Files_Raw_Input := MODULE;
	
		export FILING (string fileDate)           			 := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::FILING::WY',
														     layouts_Raw_Input.FILING,CSV(HEADING(1),SEPARATOR(['|']), MAXLENGTH(100000), TERMINATOR(['\r\n', '\n'])))
															 (trim(filing_id,left,right)<>'');	
																			 
		export FILING_ANNUAL_REPORT (string fileDate)        := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::FILING_ANNUAL_REPORT::WY',
														     layouts_Raw_Input.FILING_ANNUAL_REPORT,CSV(HEADING(1),SEPARATOR(['|']), MAXLENGTH(100000), TERMINATOR(['\r\n', '\n'])));
															 
		export PARTY (string fileDate)        				 := dataset(ut.foreign_prod+'thor_data400::in::corp2::'+fileDate+'::PARTY::WY',
														     layouts_Raw_Input.PARTY,CSV(HEADING(1),SEPARATOR(['|']), MAXLENGTH(100000), TERMINATOR(['\r\n', '\n'])));
	end;	


  export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
	
		  PartyWithFiling  := record
				string20 	FILING_ID;
				string20 	FILING_NUM;
				string256 FILING_NAME;
				string20 	PARTY_ID;
				string50 	PARTY_TYPE;
				string20 	SOURCE_ID;
				string50 	SOURCE_TYPE;
				string256 ORG_NAME;
				string50 	FIRST_NAME;
				string30 	MIDDLE_NAME;
				string100 LAST_NAME;
				string100 INDIVIDUAL_TITLE;
				string256 ADDR1;
				string100 ADDR2;
				string100 ADDR3;
				string60 	CITY;
				string60 	COUNTY;
				string50 	STATE;
				string30 	POSTAL_CODE;
				string100 COUNTRY;
		end;

		
		

	corp2_mapping.Layout_CorpPreClean WY_corpMainTransform(layouts_raw_input.FILINGPARTY  input):= transform, skip(trim(input.PARTY_ID,left,right) = '')
		
	

	

		self.dt_vendor_first_reported		:= fileDate;
		self.dt_vendor_last_reported		:= fileDate;
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		self.corp_ra_dt_first_seen			:= fileDate;
		self.corp_ra_dt_last_seen			:= fileDate;
		self.corp_key						:= '56-' +trim(input.FILING_ID, left, right);
		
		self.corp_vendor					:= '56';
		
		self.corp_state_origin				:= 'WY';
		self.corp_process_date				:= fileDate;

		self.corp_orig_sos_charter_nbr		:=  input.FILING_NUM;
		self.corp_src_type					:= 'SOS';

		

		

		self.corp_legal_name				:= if ( trim(stringlib.StringtoUpperCase(input.Filing_Type),left,right) ='TRADE NAME', trim(stringlib.StringtoUpperCase(input.Filing_Name),left,right),trim(stringlib.StringtoUpperCase(input.Filing_Name),left,right));

		self.corp_ln_name_type_cd			:= if ( trim(stringlib.StringtoUpperCase(input.Filing_Type),left,right) ='TRADE NAME','04','01');

		self.corp_ln_name_type_desc			:= if ( trim(stringlib.StringtoUpperCase(input.Filing_Type),left,right) ='TRADE NAME','TRADENAME','LEGAL');



		

		

		self.corp_address1_type_cd			:= if (	trim(input.PRINCIPLE_ADDR1,left,right) <> '' or
													trim(input.PRINCIPLE_CITY,left,right) <> '' or
													trim(input.PRINCIPLE_STATE,left,right) <> '' or
													trim(input.PRINCIPLE_POSTAL_CODE,left,right) <> '','B','');


		self.corp_address1_type_desc		:= if (	trim(input.PRINCIPLE_ADDR1,left,right) <> '' or
													trim(input.PRINCIPLE_CITY,left,right) <> '' or
													trim(input.PRINCIPLE_STATE,left,right) <> '' or
													trim(input.PRINCIPLE_POSTAL_CODE,left,right) <> '','BUSINESS','');

		self.corp_address1_line1			:= trim(stringlib.StringtoUpperCase(input.PRINCIPLE_ADDR1),left, right);
		self.corp_address1_line2			:= trim(stringlib.StringtoUpperCase(input.PRINCIPLE_ADDR2),left, right);
		self.corp_address1_line3			:= trim(stringlib.StringtoUpperCase(input.PRINCIPLE_ADDR3),left, right);
		self.corp_address1_line4			:= trim(stringlib.StringtoUpperCase(input.PRINCIPLE_CITY),left, right);
		self.corp_address1_line5			:= trim(stringlib.StringtoUpperCase(input.PRINCIPLE_STATE),left, right);
		self.corp_address1_line6			:= trim(stringlib.StringtoUpperCase(input.PRINCIPLE_POSTAL_CODE),left, right);

		
		self.corp_address2_type_cd			:= if (	trim(input.MAIL_ADDR1,left,right) <> '' or
													trim(input.MAIL_CITY,left,right) <> '' or
													trim(input.MAIL_STATE,left,right) <> '' or
													trim(input.MAIL_POSTAL_CODE,left,right) <> '','M','');

		self.corp_address2_type_desc		:= if (	trim(input.MAIL_ADDR1,left,right) <> '' or
													trim(input.MAIL_CITY,left,right) <> '' or
													trim(input.MAIL_STATE,left,right) <> '' or
													trim(input.MAIL_POSTAL_CODE,left,right) <> '','MAILING','');

		self.corp_address2_line1			:= trim(stringlib.StringtoUpperCase(input.MAIL_ADDR1),left, right);
		self.corp_address2_line2			:= trim(stringlib.StringtoUpperCase(input.MAIL_ADDR2),left, right);                                                                                                                             
		self.corp_address2_line3			:= trim(stringlib.StringtoUpperCase(input.MAIL_ADDR3),left, right);
		self.corp_address2_line4			:= trim(stringlib.StringtoUpperCase(input.MAIL_CITY),left, right);
		self.corp_address2_line5			:= trim(stringlib.StringtoUpperCase(input.MAIL_STATE),left, right);
		self.corp_address2_line6			:= trim(stringlib.StringtoUpperCase(input.MAIL_POSTAL_CODE),left, right);

				
		filingDate							:= if ( trim( input.filing_DATE,left,right) <> '',
														input.filing_DATE[7..10] +
														input.filing_DATE[1..2] +
														input.filing_DATE[4..5],'');

		
		self.corp_filing_date				:= if ( filingDate<> '' and
													_validate.date.fIsValid(filingDate) and
													_validate.date.fIsValid(filingDate,_validate.date.rules.DateInPast),filingDate,'');  


												  
	
		self.corp_filing_desc				:= if(filingDate <> '' , 'FILING', '' );
												  
		
		self.corp_status_desc				:= trim(stringlib.StringtoUpperCase(input.STATUS),left, right);

		inactiveDate						:= if ( trim( input.INACTIVE_DATE,left,right) <> '',
														input.INACTIVE_DATE[7..10] +
														input.INACTIVE_DATE[1..2] +
														input.INACTIVE_DATE[4..5],'');
		

		self.corp_status_date				:= if ( inactiveDate <> '' and
													_validate.date.fIsValid(inactiveDate) and
													_validate.date.fIsValid(inactiveDate,_validate.date.rules.DateInPast),inactiveDate,'');  
													
        self.corp_status_comment            :=if(input.standing_other<>'','STANDING OTHER: '+trim(stringlib.StringtoUpperCase(input.standing_other),left,right),'');
		self.corp_standing					:= map(	trim(stringlib.StringtoUpperCase(input.STANDING_TAX),left,right) = 'GOOD' =>'Y',
													trim(stringlib.StringtoUpperCase(input.STANDING_TAX),left,right) = 'DELINQUENT' => 'N','');
									
		
		self.corp_inc_state					:= if (trim(stringlib.StringtoUpperCase(input.STATE_OF_ORG),left,right) = 'WYOMING','WY','');

		filingDateOrg						:= if ( trim( input.ORG_DATE,left,right) <> '',
														input.ORG_DATE[7..10] +
														input.ORG_DATE[1..2] +
														input.ORG_DATE[4..5],'');

		filingDateOrgInc					:= if ( filingDateOrg <> '' and
													_validate.date.fIsValid(filingDateOrg) and
														_validate.date.fIsValid(filingDateOrg,_validate.date.rules.DateInPast),filingDateOrg,'');  




		

		self.corp_inc_date				:= if (filingDateOrgInc <> '' ,filingDateOrgInc,'');  



		
		
		term_cd								:= Map(	trim(input.Expiration_Date,left, right)<>'' =>'D',
																	trim(Stringlib.stringToUpperCase(input.Duration_TERM_TYPE),left,right) = 'PERPETUAL' => 'P',
																	trim(Stringlib.stringToUpperCase(input.Duration_TERM_TYPE),left,right) = 'EXPIRES' => 'N',
																	trim(Stringlib.stringToUpperCase(input.Duration_TERM_TYPE),left,right) = 'EXPIRES - 30 YEARS' => 'N',
																	trim(Stringlib.stringToUpperCase(input.Duration_TERM_TYPE),left,right) = 'EXPIRES - 50 YEARS' => 'N',
																	trim(Stringlib.stringToUpperCase(input.Duration_TERM_TYPE),left,right) = 'EXPIRES - 99 YEARS' => 'N','');

		term_desc							:= Map(	trim(input.Expiration_Date,left, right)<> '' => 'EXPIRATION DATE',
																	trim(Stringlib.stringToUpperCase(input.Duration_TERM_TYPE),left,right) = 'PERPETUAL' => 'PERPETUAL',
																	trim(Stringlib.stringToUpperCase(input.Duration_TERM_TYPE),left,right) = 'EXPIRES' => 'NUMBER OF YEARS',																						
																	trim(Stringlib.stringToUpperCase(input.Duration_TERM_TYPE),left,right) = 'EXPIRES - 30 YEARS' => 'NUMBER OF YEARS',
																	trim(Stringlib.stringToUpperCase(input.Duration_TERM_TYPE),left,right) = 'EXPIRES - 50 YEARS' => 'NUMBER OF YEARS',
																	trim(Stringlib.stringToUpperCase(input.Duration_TERM_TYPE),left,right) = 'EXPIRES - 99 YEARS' => 'NUMBER OF YEARS','');	

		self.corp_term_exist_cd				:= if (trim(Stringlib.stringToUpperCase(input.Domestic_YN),left,right) = 'Y', term_cd,'');
	
		self.corp_term_exist_desc			:= if (trim(Stringlib.stringToUpperCase(input.Domestic_YN),left,right) = 'Y', term_desc,'');

		expireDate							:= if ( trim(input.expiration_date) <> '',
														input.expiration_date[7..10] +
														input.expiration_date[1..2] +
														input.expiration_date[4..5],'');

		expiration_date						:= if (expireDate <> '' and
													_validate.date.fIsValid(expireDate),
														expireDate,'');  																										 
	
		
	
		self.corp_term_exist_exp			:= if(trim(Stringlib.stringToUpperCase(input.Domestic_YN),left,right) = 'Y',
																				if (Stringlib.stringToUpperCase(term_cd)= 'D',
																							expiration_date,
																							if (trim(stringlib.StringtoUpperCase(input.Duration_Term_Type),left,right) <> 'PERPETUAL',
																										stringlib.StringtoUpperCase(input.Duration_Term_Type) ,
																										''
																									)
																						),
																				''	
																				);	
	
		
														
	
														

		self.corp_foreign_domestic_ind		:=  map(trim(stringlib.StringtoUpperCase(input.DOMESTIC_YN),left,right) = 'Y' => 'D',
												trim(stringlib.StringtoUpperCase(input.DOMESTIC_YN),left,right) = 'N' => 'F','');

		

		self.corp_forgn_state_desc			:= if (trim(stringlib.StringtoUpperCase(input.STATE_OF_ORG),left,right) <> 'WYOMING', stringlib.StringtoUpperCase(input.STATE_OF_ORG),'');//Only if not WYOMING
		
	

		
		self.corp_forgn_date				:= if (trim(input.STATE_OF_ORG,left,right) <> 'WYOMING',filingDateOrgInc,'');  
		
		
		self.corp_forgn_term_exist_cd		:= if (trim(Stringlib.stringToUpperCase(input.Domestic_YN),left,right) = 'N', term_cd,'');		


		self.corp_forgn_term_exist_exp		:= if(trim(Stringlib.stringToUpperCase(input.Domestic_YN),left,right) = 'N',
													if (Stringlib.stringToUpperCase(term_cd)= 'D',
															expiration_date,
															Stringlib.StringToUpperCase(input.Duration_Term_Type) 
														),
													''	
												  );



		self.corp_forgn_term_exist_desc		:= if (trim(Stringlib.stringToUpperCase(input.Domestic_YN),left,right) = 'N', Stringlib.StringToUpperCase(term_desc),'');


		

		

		self.corp_orig_org_structure_desc	:= map(	trim(stringlib.StringtoUpperCase(input.FILING_TYPE),left,right)='NONPROFIT CORPORATION'=>'NONPROFIT CORPORATION',
			                              			trim(stringlib.StringtoUpperCase(input.FILING_TYPE),left,right)='LIMITED PARTNERSHIP'=>'LIMITED PARTNERSHIP',
																		trim(stringlib.StringtoUpperCase(input.FILING_TYPE),left,right)='PROFIT CORPORATION'=>'PROFIT CORPORATION',
																		trim(stringlib.StringtoUpperCase(input.FILING_TYPE),left,right)='LIMITED LIABILITY COMPANY'=>'LIMITED LIABILITY COMPANY',
																		trim(stringlib.StringtoUpperCase(input.FILING_TYPE),left,right)='LIMITED PARTNERSHIP'=>'LIMITED PARTNERSHIP',
																		trim(stringlib.StringtoUpperCase(input.FILING_TYPE),left,right)='REGISTERED LIMITED LIABILITY PARTNERSHIP'=>'REGISTERED LIMITED LIABILITY PARTNERSHIP',''
																	);

		
		
		

										  

	
	self.corp_orig_bus_type_desc		:= if(	trim(stringlib.StringtoUpperCase(input.PURPOSE),left, right) <>'' and 
												trim(stringlib.StringtoUpperCase(input.APPLICANT_TYPE),left, right)<>'',
													trim(stringlib.StringtoUpperCase(input.PURPOSE),left, right) +': ' + trim(stringlib.StringtoUpperCase(input.APPLICANT_TYPE),left, right),
													if(	trim(stringlib.StringtoUpperCase(input.PURPOSE),left, right) <>'', 
															trim(stringlib.StringtoUpperCase(input.PURPOSE),left, right),
															if(	trim(stringlib.StringtoUpperCase(input.APPLICANT_TYPE),left, right) <> '',
																	trim(stringlib.StringtoUpperCase(input.APPLICANT_TYPE),left, right),
																	''
															   )
													   )
											  );


		
	


		self.corp_addl_info					:= if ( trim(input.CONVERTED_FROM,left,right) <> '', map(	trim(stringlib.StringtoUpperCase(input.FILING_TYPE),left,right)='NONPROFIT CORPORATION'=>'CONVERTED FROM: NONPROFIT CORPORATION',
			                              												trim(stringlib.StringtoUpperCase(input.FILING_TYPE),left,right)='LIMITED PARTNERSHIP'=>'CONVERTED FROM: LIMITED PARTNERSHIP',
																				trim(stringlib.StringtoUpperCase(input.FILING_TYPE),left,right)='PROFIT CORPORATION'=>'CONVERTED FROM: PROFIT CORPORATION',
																				trim(stringlib.StringtoUpperCase(input.FILING_TYPE),left,right)='LIMITED LIABILITY COMPANY'=>'CONVERTED FROM: LIMITED LIABILITY COMPANY',
																				trim(stringlib.StringtoUpperCase(input.FILING_TYPE),left,right)='LIMITED PARTNERSHIP'=>'CONVERTED FROM: LIMITED PARTNERSHIP',
																				trim(stringlib.StringtoUpperCase(input.FILING_TYPE),left,right)='REGISTERED LIMITED LIABILITY PARTNERSHIP'=>'CONVERTED FROM: REGISTERED LIMITED LIABILITY PARTNERSHIP',''
																	),
											'');
	

			

				



		setTitles							:= ['Jr.','Jr','Sr.','Sr','||','|||','||||','IV','JR','JR.'];
	

		self.corp_ra_name					:= if(stringlib.StringtoUpperCase(trim(input.party_type,left,right)) = 'REGISTERED AGENT',
												  if(trim(input.org_name,left,right) <> '', stringlib.StringtoUpperCase(input.org_name),
												     if(trim(input.INDIVIDUAL_TITLE,left,right) IN setTitles, 
												        trim(stringlib.StringtoUpperCase(input.FIRST_NAME),left,right) + ' ' + 
											            trim(stringlib.StringtoUpperCase(input.MIDDLE_NAME),left,right) + ' ' +
											            trim(stringlib.StringtoUpperCase(input.LAST_NAME),left,right) + ' ' +
											            trim(stringlib.StringtoUpperCase(input.INDIVIDUAL_TITLE),left,right),
											            trim(stringlib.StringtoUpperCase(input.FIRST_NAME),left,right) + ' ' + 
											            trim(stringlib.StringtoUpperCase(input.MIDDLE_NAME),left,right) + ' ' +
											            trim(stringlib.StringtoUpperCase(input.LAST_NAME),left,right))
												  ),'');

		filingResignDate					:= if ( trim( input.RA_RESIGN_CERT_LETTER_DATE,left,right) <> '',
											input.RA_RESIGN_CERT_LETTER_DATE[7..10] +
											input.RA_RESIGN_CERT_LETTER_DATE[1..2] +
											input.RA_RESIGN_CERT_LETTER_DATE[4..5],'');

		filingResignDateOrg					:= if ( filingResignDate <> '' and
											_validate.date.fIsValid(filingResignDate) and
											_validate.date.fIsValid(filingResignDate,_validate.date.rules.DateInPast),filingResignDate,'');  


		
		self.corp_ra_resign_date			:= if (trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right) = 'REGISTERED AGENT',filingResignDateOrg,'');

		
		
		

		self.corp_ra_address_type_cd		:= '';
		self.corp_ra_address_type_desc		:= if (trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right) = 'REGISTERED AGENT' AND 
											trim(input.ADDR1,left,right) <> '' ,'REGISTERED OFFICE','');

		self.corp_ra_address_line1			:= if (trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right) = 'REGISTERED AGENT' ,stringlib.StringtoUpperCase(input.ADDR1),'');
		self.corp_ra_address_line2			:= if (trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right) = 'REGISTERED AGENT' ,stringlib.StringtoUpperCase(input.ADDR2),'');
		self.corp_ra_address_line3			:= if (trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right) = 'REGISTERED AGENT' ,stringlib.StringtoUpperCase(input.ADDR3),'');
		self.corp_ra_address_line4			:= if (trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right) = 'REGISTERED AGENT' ,stringlib.StringtoUpperCase(input.CITY),'');
		self.corp_ra_address_line5			:= if (trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right) = 'REGISTERED AGENT'  ,stringlib.StringtoUpperCase(input.STATE),'');
		self.corp_ra_address_line6			:= if (trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right) = 'REGISTERED AGENT'  ,stringlib.StringtoUpperCase(input.POSTAL_CODE),'');
		corp_ra_addl_info1					:= if (trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right) = 'REGISTERED AGENT' and 
												trim(stringlib.StringtoUpperCase(input.COUNTY),left,right) <> '' ,'AGENT COUNTY: ' + stringlib.StringtoUpperCase(input.COUNTY),'');

		corp_ra_addl_info2                  :=if(input.standing_ra<>'','REGISTERED AGENT STANDING: '+trim(stringlib.StringtoUpperCase(input.STANDING_RA),left,right),'');
		concatFields						 := 	trim(corp_ra_addl_info1,left,right) + ';' + 
   														trim(corp_ra_addl_info2,left,right);  
   		
   				
   		tempExp								 := regexreplace('[;]*$',concatFields,'',NOCASE);
   		tempExp2							 := regexreplace('^[;]*',tempExp,'',NOCASE);

		self.corp_ra_addl_info        		:= regexreplace('[;]+',tempExp2,';',NOCASE);
		self								:=[];

	end;//end of corp transform

	corp2_mapping.Layout_CorpPreClean WY_corpOldNameTransform(layouts_raw_input.FILING  input):= transform, skip(trim(input.OLD_NAME,left,right) = '')
		
		self.dt_vendor_first_reported		:= fileDate;
		self.dt_vendor_last_reported		:= fileDate;
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		self.corp_ra_dt_first_seen			:= fileDate;
		self.corp_ra_dt_last_seen			:= fileDate;
		self.corp_key						:= '56-' +trim(input.FILING_ID, left, right);
		
		self.corp_vendor					:= '56';
		
		self.corp_state_origin				:= 'WY';
		self.corp_process_date				:= fileDate;

		self.corp_orig_sos_charter_nbr			:=  input.FILING_NUM;
			self.corp_src_type					:= 'SOS';

		self.corp_legal_name				:= trim(stringlib.StringtoUpperCase(input.OLD_Name),left,right);

		self.corp_ln_name_type_cd			:= 'P';

		self.corp_ln_name_type_desc			:= 'PRIOR';

		convertedDate						:= if ( trim( input.CONVERTED_DATE,left,right) <> '',
											input.CONVERTED_DATE[7..10] +
											input.CONVERTED_DATE[1..2] +
											input.CONVERTED_DATE[4..5],'');

		

		self.corp_filing_date				:= if ( convertedDate <> '' and
											_validate.date.fIsValid(convertedDate) and
											_validate.date.fIsValid(convertedDate,_validate.date.rules.DateInPast),convertedDate,'');  


		
		self.corp_filing_desc				:= if (trim(convertedDate,left,right) <> '','CONVERTED','');

		
		
		self								:=[];


	
	end;
	
	corp2_mapping.Layout_CorpPreClean WY_corpFictitiousTransform(layouts_raw_input.FILING  input):= transform, skip(trim(stringlib.StringtoUpperCase(input.FICTITIOUS_NAME),left,right) = '')

		self.dt_vendor_first_reported			:= fileDate;
		self.dt_vendor_last_reported			:= fileDate;
		self.dt_first_seen				:= fileDate;
		self.dt_last_seen				:= fileDate;
		self.corp_ra_dt_first_seen			:= fileDate;
		self.corp_ra_dt_last_seen			:= fileDate;
		self.corp_key						:= '56-' +trim(input.FILING_ID, left, right);
	
		self.corp_vendor					:= '56';
		
		self.corp_state_origin				:= 'WY';
		self.corp_process_date				:= fileDate;

	
	self.corp_orig_sos_charter_nbr				:= input.FILING_NUM;
	self.corp_src_type					:= 'SOS';
		self.corp_legal_name				:= trim(stringlib.StringtoUpperCase(input.FICTITIOUS_NAME),left,right);

		self.corp_ln_name_type_cd			:= 'FIC';

		self.corp_ln_name_type_desc			:= 'FICTITIOUS';

				
		self								:=[];

	
	end;

	corp2_mapping.Layout_CorpPreClean WY_corpTrademarkTransform(layouts_raw_input.FILING  input):= transform, skip(trim(stringlib.StringtoUpperCase(input.TRADEMARK_KEYWORDS),left,right) = '')
		self.dt_vendor_first_reported		:= fileDate;
		self.dt_vendor_last_reported		:= fileDate;
		self.dt_first_seen					:= fileDate;
		self.dt_last_seen					:= fileDate;
		self.corp_ra_dt_first_seen			:= fileDate;
		self.corp_ra_dt_last_seen			:= fileDate;
		self.corp_key						:= '56-' +trim(input.FILING_ID, left, right);
		
		self.corp_vendor					:= '56';
		
		self.corp_state_origin				:= 'WY';
		self.corp_process_date				:= fileDate;

	
		self.corp_orig_sos_charter_nbr			:=  input.FILING_NUM;
		

		
		

		

		self.corp_name_comment				:= 'TRADEMARK KEYWORDS: ' + trim(stringlib.StringtoUpperCase(input.TRADEMARK_KEYWORDS),left,right);

		
		
		self.corp_src_type					:= 'SOS';
		
		self								:=[];

	
	end;


	corp2_mapping.Layout_ContPreClean WY_contTransform(PartyWithFiling input):= transform, skip(trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right) = 'REGISTERED AGENT' or trim(input.PARTY_ID,left,right) = '' or NOT ut.isNumeric(input.source_id))
		contTypeCD							:= map(	trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='PRESIDENT'=>'F',
			                              trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='VICE PRESIDENT'=>'F',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='SECRETARY'=>'F',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='TREASURER'=>'F',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='DIRECTOR'=>'T',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='INCORPORATOR'=>'T',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='TRUSTEE'=>'T',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='ORGANIZER'=>'T',			 	
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='ON BEHALF OF NAME'=>'T',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='PARTNER'=>'M',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='MEMBER/MANAGER'=>'M',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='MEMBER'=>'M',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='MANAGER'=>'M',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='LIMITED PARTNER'=>'M',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='GENERAL PARTNER'=>'M',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='NAME OF PERSON RESERVING NAME'=>'01',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='APPLICANT'=>'I',''
																	);
		
		contTypeDesc						:= map(	trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='PRESIDENT'=> 'OFFICER',
			                              trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='VICE PRESIDENT'=> 'OFFICER',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='SECRETARY'=> 'OFFICER',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='TREASURER'=> 'OFFICER',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='DIRECTOR'=> 'CONTACT',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='INCORPORATOR'=> 'CONTACT',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='TRUSTEE'=> 'CONTACT',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='ORGANIZER'=> 'CONTACT',			 	
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='ON BEHALF OF NAME'=> 'CONTACT',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='PARTNER'=>'MEMBER/MANAGER/PARTNER',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='MEMBER/MANAGER'=>'MEMBER/MANAGER/PARTNER',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='MEMBER'=>'MEMBER/MANAGER/PARTNER',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='MANAGER'=>'MEMBER/MANAGER/PARTNER',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='LIMITED PARTNER'=>'MEMBER/MANAGER/PARTNER',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='GENERAL PARTNER'=>'MEMBER/MANAGER/PARTNER',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='NAME OF PERSON RESERVING NAME'=> 'RESERVER',
																		trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right)='APPLICANT'=> 'APPLICANT',''
																	);
	
		
		setTitles								:= ['JR.','JR','SR.','SR','||','|||','||||','IV'];
		IgnoredTitles						:= ['MR.','MR','MRS.','MRS','S','PHD','PH.D','DR.','DR','ESQ.','ESQ'];
		
		self.dt_first_seen			:= fileDate;
		self.dt_last_seen				:= fileDate;

		self.corp_key						:= '56-' +trim(input.FILING_ID, left, right);
		self.corp_vendor				:= '56' ;
		self.corp_state_origin	:= 'WY';
		self.corp_process_date	:= fileDate;
		self.corp_orig_sos_charter_nbr		:= input.FILING_NUM;
		
		self.cont_type_cd				:= contTypeCD;

		self.cont_type_desc			:= contTypeDesc;
		
		self.corp_legal_name		:= if ( trim(stringlib.StringtoUpperCase(input.Filing_Name),left,right)<>'',
																			trim(stringlib.StringtoUpperCase(input.Filing_Name),left,right),
																			''
																	 );

		strName1     						:= if (	trim(input.ORG_NAME,left,right) <> '',
																			trim(stringlib.StringtoUpperCase(input.ORG_NAME),left,right),
																			trim(	trim(stringlib.StringtoUpperCase(input.FIRST_NAME),left,right) + ' ' + 
																						trim(stringlib.StringtoUpperCase(input.MIDDLE_NAME),left,right) + ' ' +
																						trim(stringlib.StringtoUpperCase (input.LAST_NAME),left,right),
																						left,right
																					)
																		);
																		
		self.cont_name     			:= if (	trim(strName1,left,right) <> '' and 
                                    trim(stringlib.StringtoUpperCase(strName1),left,right) <> 'SAME AS PRES' and
																		trim(stringlib.StringtoUpperCase(strName1),left,right) <> 'SAME AS VP',
																			if ( trim( stringlib.StringtoUpperCase(input.INDIVIDUAL_TITLE),left,right) IN setTitles, 
                                              trim(	strName1 + ' ' + 
																										trim(stringlib.StringtoUpperCase (input.INDIVIDUAL_TITLE),left,right),
																										left,right
																									 ),
																							strName1
																					),
																			''
																		);

		self.cont_title1_desc				:= trim(stringlib.StringtoUpperCase(input.PARTY_TYPE),left,right);
		self.cont_title2_desc				:= if (trim(stringlib.StringtoUpperCase(input.INDIVIDUAL_TITLE),left,right) Not IN setTitles and
																					trim(stringlib.StringtoUpperCase(input.INDIVIDUAL_TITLE),left,right) Not IN IgnoredTitles,
																						trim(stringlib.StringtoUpperCase(input.INDIVIDUAL_TITLE),left,right),
																						''
																				 );
		
		self.cont_address_type_cd			:= if (	trim(input.ADDR1,left,right) <> '' or
																					trim(input.CITY,left,right) <> '' or
																					trim(input.STATE,left,right) <> '' or
																					trim(input.POSTAL_CODE,left,right) <> '',
																						'T',
																						''
																					);

		self.cont_address_type_desc			:= if (	trim(input.ADDR1,left,right) <> '' or
																						trim(input.CITY,left,right) <> '' or
																						trim(input.STATE,left,right) <> '' or
																						trim(input.POSTAL_CODE,left,right) <> '',
																							'CONTACT',
																							''
																					);

		self.cont_address_line1				:= trim(stringlib.StringtoUpperCase(input.ADDR1),left,right);
		self.cont_address_line2				:= trim(stringlib.StringtoUpperCase(input.ADDR2),left,right);
		self.cont_address_line3				:= trim(stringlib.StringtoUpperCase(input.ADDR3),left,right);
		self.cont_address_line4				:= trim(stringlib.StringtoUpperCase(input.CITY),left,right);
		self.cont_address_line5				:= trim(stringlib.StringtoUpperCase(input.STATE),left,right);
		self.cont_address_line6				:= trim(stringlib.StringtoUpperCase(input.POSTAL_CODE),left,right);
	
		self													:=[];
                                                                                                                            
	end;

	Corp2.Layout_Corporate_Direct_Stock_In WY_StockTransform(layouts_raw_input.FILING input):=transform

		self.corp_key									:= '56-' +trim(input.FILING_ID, left, right);		
		self.corp_vendor							:= '56';		
		
		self.corp_state_origin				:= 'WY';
		self.corp_process_date				:= fileDate;

		self.corp_sos_charter_nbr			:= input.FILING_NUM;
		
		self.stock_type						:= map(	trim(input.COMMON_SHARES,left,right) <>'' =>'COMMON',
																					trim(input.PREFERRED_SHARES,left,right) <> '' => 'PREFERRED',
																					''
																			  );
			
	
		self.stock_shares_issued			:= map(	trim(input.COMMON_SHARES,left,right) <>'' => input.COMMON_SHARES,
																					trim(input.PREFERRED_SHARES,left,right) <> '' => input.PREFERRED_SHARES,
																					''
																				);
		
		self.stock_par_value				:= map(	trim(input.COMMON_PAR_VALUE,left,right) <>'' => input.COMMON_PAR_VALUE,
																					trim(input.PREFERRED_PAR_VALUE,left,right) <> '' => input.PREFERRED_PAR_VALUE,
																					''
																				);

		self.stock_addl_info				:= if ( trim(input.additional_stock_yn,left,right) <> '', 
																						'ADDITIONAL STOCK: ' + stringlib.StringtoUpperCase(input.additional_stock_yn),
																						''
																				 ); 
		
		self								:=[];

	end;

	Corp2.Layout_Corporate_Direct_AR_In WY_ArTransform(layouts_raw_input.FILING_ANNUAL_REPORT  input):=transform

		self.corp_key									:= '56-' +trim(input.FILING_ID, left, right);		
		self.corp_vendor							:= '56';		
		
		self.corp_state_origin				:= 'WY';
		self.corp_process_date				:= fileDate;

		self.corp_sos_charter_nbr			:= input.ANNUAL_REPORT_NUM;

		self.ar_year						:= if( trim(input.FILING_YEAR,left,right) <>'',input.FILING_YEAR,'');

		arFilingDate						:= if ( trim( input.FILING_DATE,left,right) <> '',
																						input.FILING_DATE[7..10] +
																						input.FILING_DATE[1..2] +
																						input.FILING_DATE[4..5],
																						''
																					);

		self.ar_filed_dt					:= if ( arFilingDate <> '' and
																					_validate.date.fIsValid(arFilingDate) and arFilingDate <> '18000101' and
																					_validate.date.fIsValid(arFilingDate,_validate.date.rules.DateInPast),
																						arFilingDate,
																						''
																				);  

		self.ar_report_nbr					:= if(trim(input.ANNUAL_REPORT_NUM,left,right) <>'',
																					input.ANNUAL_REPORT_NUM,
																					''
																			  );
		
		self.ar_tax_amount_paid				:= if(trim(input.license_tax_amt,left,right) <>'',
																					input.license_tax_amt,
																					''
																				);

		self.ar_comment						:= if(trim(input.status,left,right) <> '',
																					'ANNUAL REPORT STATUS: ' + stringlib.StringtoUpperCase(input.status),
																					''
																				);
	
		self								:=[];

	end;	

	Corp2.Layout_Corporate_Direct_Cont_In CleanContNameAddr(corp2_mapping.Layout_ContPreClean input) := transform
			string73 tempname 					:= if (input.cont_name = '', '',Address.CleanPersonFML73(input.cont_name));
			pname 											:= Address.CleanNameFields(tempName);
			cname 											:= DataLib.companyclean(input.cont_name);
			keepPerson 							:= Corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 						:= Corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1					:= if(keepPerson, pname.title, '');
			self.cont_fname1 					:= if(keepPerson, pname.fname, '');
			self.cont_mname1 					:= if(keepPerson, pname.mname, '');
			self.cont_lname1 					:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 				:= if(keepPerson, pname.name_suffix,'');
			self.cont_score1 					:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 					:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 				:= if(keepBusiness, pname.name_score,'');	
			
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' +													                        
																																	trim(input.cont_address_line2,left,right) + ' ' +	
																																	trim(input.cont_address_line3,left,right),
																																	left,right
																																	), 
																														 trim(input.cont_address_line4,left,right) + ', ' +
																														 trim(input.cont_address_line5,left,right) + ' ' +
																														 trim(input.cont_address_line6,left,right)
																														 );
			self.cont_prim_range    		:= clean_address[1..10];
			self.cont_predir 	      		:= clean_address[11..12];
			self.cont_prim_name 	  		:= clean_address[13..40];
			self.cont_addr_suffix   		:= clean_address[41..44];
			self.cont_postdir 	    		:= clean_address[45..46];
			self.cont_unit_desig 	  		:= clean_address[47..56];
			self.cont_sec_range 	  		:= clean_address[57..64];
			self.cont_p_city_name	  		:= clean_address[65..89];
			self.cont_v_city_name	  		:= clean_address[90..114];
			self.cont_state 			    := clean_address[115..116];
			self.cont_zip5 		      		:= clean_address[117..121];
			self.cont_zip4 		      		:= clean_address[122..125];
			self.cont_cart 		      		:= clean_address[126..129];
			self.cont_cr_sort_sz 	 		:= clean_address[130];
			self.cont_lot 		      		:= clean_address[131..134];
			self.cont_lot_order 	  		:= clean_address[135];
			self.cont_dpbc 		      		:= clean_address[136..137];
			self.cont_chk_digit 	  		:= clean_address[138];
			self.cont_rec_type		  		:= clean_address[139..140];
			self.cont_ace_fips_st	  		:= clean_address[141..142];
			self.cont_county 	  			:= clean_address[143..145];
			self.cont_geo_lat 	    		:= clean_address[146..155];
			self.cont_geo_long 	    		:= clean_address[156..166];
			self.cont_msa 		      		:= clean_address[167..170];
			self.cont_geo_blk				:= clean_address[171..177];
			self.cont_geo_match 	  		:= clean_address[178];
			self.cont_err_stat 	    		:= clean_address[179..182];
			self							:= input;
			self							:= [];
		end;

		corp2.layout_corporate_direct_corp_in CleanCorpNameAddr(corp2_mapping.Layout_CorpPreClean input) := transform
			string73 tempname 					:= if (	input.corp_ra_name = '', 
																						'',
																						Address.CleanPersonFML73(input.corp_ra_name)
																				 );
			string182 clean_address1 		:= Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' +													                        
																																	trim(input.corp_address1_line2,left,right) + ' ' +	
																																	trim(input.corp_address1_line3,left,right),
																																	left,right
																																	), 
																															trim(input.corp_address1_line4,left,right) + ', ' +
																															trim(input.corp_address1_line5,left,right) + ' ' +
																															trim(input.corp_address1_line6,left,right)
																															);
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
	

			self.corp_addr1_prim_range 			:= clean_address1[1..10];
			self.corp_addr1_predir 	   			:= clean_address1[11..12];
			self.corp_addr1_prim_name 			:= clean_address1[13..40];
			self.corp_addr1_addr_suffix 		:= clean_address1[41..44];
			self.corp_addr1_postdir 	  		:= clean_address1[45..46];
			self.corp_addr1_unit_desig 			:= clean_address1[47..56];
			self.corp_addr1_sec_range 			:= clean_address1[57..64];
			self.corp_addr1_p_city_name			:= clean_address1[65..89];
			self.corp_addr1_v_city_name			:= clean_address1[90..114];
			self.corp_addr1_state 				:= clean_address1[115..116];
			self.corp_addr1_zip5 		   		:= clean_address1[117..121];
			self.corp_addr1_zip4 		   		:= clean_address1[122..125];
			self.corp_addr1_cart 		   		:= clean_address1[126..129];
			self.corp_addr1_cr_sort_sz 			:= clean_address1[130];
			self.corp_addr1_lot 		   		:= clean_address1[131..134];
			self.corp_addr1_lot_order 			:= clean_address1[135];
			self.corp_addr1_dpbc 		   	    := clean_address1[136..137];
			self.corp_addr1_chk_digit 			:= clean_address1[138];
			self.corp_addr1_rec_type			:= clean_address1[139..140];
			self.corp_addr1_ace_fips_st			:= clean_address1[141..142];
			self.corp_addr1_county 	  			:= clean_address1[143..145];
			self.corp_addr1_geo_lat 	 	    := clean_address1[146..155];
			self.corp_addr1_geo_long 	 	    := clean_address1[156..166];
			self.corp_addr1_msa 		   	    := clean_address1[167..170];
			self.corp_addr1_geo_blk			    := clean_address1[171..177];
			self.corp_addr1_geo_match 	        := clean_address1[178];
			self.corp_addr1_err_stat 	        := clean_address1[179..182];
			
			
			string182 clean_address2 		    := Address.CleanAddress182(trim(trim(input.corp_address2_line1,left,right) + ' ' +													                        
																																	trim(input.corp_address2_line2,left,right) + ' ' +	
																																	trim(input.corp_address2_line3,left,right),
																																	left,right
																																	), 
																															trim(input.corp_address2_line4,left,right) + ', ' +
																															trim(input.corp_address2_line5,left,right) + ' ' +
																															trim(input.corp_address2_line6,left,right)
																															);
										
			self.corp_addr2_prim_range  	:= clean_address2[1..10];
			self.corp_addr2_predir 	    	:= clean_address2[11..12];
			self.corp_addr2_prim_name 		:= clean_address2[13..40];
			self.corp_addr2_addr_suffix 	:= clean_address2[41..44];
			self.corp_addr2_postdir 	 	 := clean_address2[45..46];
			self.corp_addr2_unit_desig 		:= clean_address2[47..56];
			self.corp_addr2_sec_range 		:= clean_address2[57..64];
			self.corp_addr2_p_city_name		:= clean_address2[65..89];
			self.corp_addr2_v_city_name		:= clean_address2[90..114];
			self.corp_addr2_state 			:= clean_address2[115..116];
			self.corp_addr2_zip5 		    := clean_address2[117..121];
			self.corp_addr2_zip4 		    := clean_address2[122..125];
			self.corp_addr2_cart 		    := clean_address2[126..129];
			self.corp_addr2_cr_sort_sz 		:= clean_address2[130];
			self.corp_addr2_lot 		    := clean_address2[131..134];
			self.corp_addr2_lot_order 		:= clean_address2[135];
			self.corp_addr2_dpbc 		    := clean_address2[136..137];
			self.corp_addr2_chk_digit 		:= clean_address2[138];
			self.corp_addr2_rec_type		:= clean_address2[139..140];
			self.corp_addr2_ace_fips_st		:= clean_address2[141..142];
			self.corp_addr2_county 	  		:= clean_address2[143..145];
			self.corp_addr2_geo_lat 	 	:= clean_address2[146..155];
			self.corp_addr2_geo_long 	 	:= clean_address2[156..166];
			self.corp_addr2_msa 		   	:= clean_address2[167..170];
			self.corp_addr2_geo_blk			:= clean_address2[171..177];
			self.corp_addr2_geo_match 		:= clean_address2[178];
			self.corp_addr2_err_stat 	  	:= clean_address2[179..182];			
	
			string182 clean_address			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' +													                        
																																	trim(input.corp_ra_address_line2,left,right) + ' ' +	
																																	trim(input.corp_ra_address_line3,left,right),
																																	left,right
																																	), 
																															trim(input.corp_ra_address_line4,left,right) + ', ' +
																															trim(input.corp_ra_address_line5,left,right) + ' ' +
																															trim(input.corp_ra_address_line6,left,right)
																															);
			
			self.corp_ra_prim_range   		:= clean_address[1..10];
			self.corp_ra_predir 	    	:= clean_address[11..12];
			self.corp_ra_prim_name 	  		:= clean_address[13..40];
			self.corp_ra_addr_suffix  		:= clean_address[41..44];
			self.corp_ra_postdir 	    	:= clean_address[45..46];
			self.corp_ra_unit_desig 		:= clean_address[47..56];
			self.corp_ra_sec_range 	  		:= clean_address[57..64];
			self.corp_ra_p_city_name		:= clean_address[65..89];
			self.corp_ra_v_city_name		:= clean_address[90..114];
			self.corp_ra_state 			   	:= clean_address[115..116];
			self.corp_ra_zip5 		    	:= clean_address[117..121];
			self.corp_ra_zip4 		    	:= clean_address[122..125];
			self.corp_ra_cart 		    	:= clean_address[126..129];
			self.corp_ra_cr_sort_sz 		:= clean_address[130];
			self.corp_ra_lot 		      	:= clean_address[131..134];
			self.corp_ra_lot_order 	  		:= clean_address[135];
			self.corp_ra_dpbc 		      	:= clean_address[136..137];
			self.corp_ra_chk_digit 	  		:= clean_address[138];
			self.corp_ra_rec_type		  	:= clean_address[139..140];
			self.corp_ra_ace_fips_st	 	:= clean_address[141..142];
			self.corp_ra_county 	  		:= clean_address[143..145];
			self.corp_ra_geo_lat 	    	:= clean_address[146..155];
			self.corp_ra_geo_long 	    	:= clean_address[156..166];
			self.corp_ra_msa 		      	:= clean_address[167..170];
			self.corp_ra_geo_blk			:= clean_address[171..177];
			self.corp_ra_geo_match 	  		:= clean_address[178];
			self.corp_ra_err_stat 	    	:= clean_address[179..182];
			
			self							:= input;
			self							:= [];
		end;
		
		PartyAR 								:= Files_Raw_Input.PARTY(fileDate)(trim(stringlib.StringtoUpperCase(SOURCE_TYPE),left,right)='ANNUAL REPORT');

		PartyNonAR 								:= Files_Raw_Input.PARTY(fileDate)(trim(stringlib.StringtoUpperCase(SOURCE_TYPE),left,right)<>'ANNUAL REPORT');	
		
		ArSorted								:= sort(Files_Raw_Input.FILING_ANNUAL_REPORT(fileDate),filing_id,-filing_year);
		

		Layouts_Raw_Input.FILINGPARTY  MergeFilingWithParty(Layouts_Raw_Input.FILING l, Layouts_Raw_Input.PARTY r ) := transform

			self 								:= l;
			self								:= r;
			self								:= [];
		end; 


		PartyWithFiling  MergePartyWithFiling(Layouts_Raw_Input.PARTY l, Layouts_Raw_Input.FILING r ) := transform
				self 							:= l;
				self							:= r;
		end; 		


		Layouts_Raw_Input.PARTY MergePartyWithAR(Layouts_Raw_Input.PARTY l, Layouts_Raw_Input.FILING_ANNUAL_REPORT r):=transform
			self.SOURCE_ID 						:= r.FILING_ID;
			self								:= l;
		end;
		
		Layouts_Raw_Input.FILING_ANNUAL_REPORT  rollupXform(Layouts_Raw_Input.FILING_ANNUAL_REPORT l, Layouts_Raw_Input.FILING_ANNUAL_REPORT r) := transform
				self.filing_year    			:= if(l.Filing_year > r.filing_year, l.filing_year, r.filing_year);
				self.filing_annual_report_id 	:= if(l.Filing_year > r.filing_year, l.filing_annual_report_id , r.filing_annual_report_id);
				self.filing_date				:= if(l.Filing_year > r.filing_year, l.filing_date,  r.filing_date);
				self 							:= l;
		end;

		KeepCurrentAR := rollup(ArSorted,rollupXform(LEFT,RIGHT),filing_id);

		JoinParty2AR 							:= join(PartyAR, KeepCurrentAR,
													left.source_ID =  right.filing_annual_report_id,
													MergePartyWithAR(left, right),
													inner
													);
											
		allParty								:= JoinParty2AR + PartyNonAR;
		
		distParty								:= distribute(allParty, hash64(source_id));
		sortParty								:= sort(distParty,source_id, local);
		
		joinFilingWithParty 					:= join(Files_Raw_Input.FILING(fileDate),Files_Raw_Input.PARTY(fileDate),
																		trim(left.filing_id, left, right) = right.source_id,
																		MergeFilingWithParty(left,right),
																		left outer
																		);
										
		joinPartyWithFiling						:= join(sortParty,Files_Raw_Input.FILING(fileDate),
																		trim(left.source_id, left, right) = trim(right.filing_id,left,right),
																		MergePartyWithFiling(left,right),
																		left outer
																		);
											

		MapMainCorp 							:= project(joinFilingWithParty , WY_corpMainTransform(left));

		MapOldNameCorp							:= project(Files_Raw_Input.FILING(fileDate), WY_corpOldNameTransform(left));
		
		MapFictitiousCorp						:= project(Files_Raw_Input.FILING(fileDate), WY_corpFictitiousTransform(left));

		MapTrademarkCorp						:= project(Files_Raw_Input.FILING(fileDate), WY_corpTrademarkTransform(left));

		MapCont									:= project(joinPartyWithFiling, WY_contTransform(left));

		MapStock								:= project(Files_Raw_Input.FILING(fileDate), WY_StockTransform(left));
	
		MapAr									:= project(Files_Raw_Input.FILING_ANNUAL_REPORT(fileDate), WY_ArTransform(left));

		AllCorp 								:= distribute(MapMainCorp + MapOldNameCorp + MapFictitiousCorp + MapTrademarkCorp, hash32(corp_key));
		
		MapCorp 								:= Sort(AllCorp,corp_key,local);

		cleanCont 								:= project(MapCont , CleanContNameAddr(left));
		
		cleanCorp 								:= project(MapCorp , CleanCorpNameAddr(left));

		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_wy'	,cleanCorp,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_wy'	,cleanCont,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_wy'	,MapStock	,stock_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_wy'		,MapAr		,ar_out		,,,pOverwrite);
                                                                                                                                                         
		mappedWY_Filing 						:= parallel(
			 corp_out	
			,cont_out	
			,stock_out
			,ar_out		
	);
							
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('wy',filedate,pOverwrite := pOverwrite))
			,mappedWY_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_wy')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_wy')						  
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_wy')											
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_wy')
			)
		);
							
		return result;
  end;    
end; //oct18
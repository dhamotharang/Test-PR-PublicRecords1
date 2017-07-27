 import Corp2,ut,lib_stringlib, _validate, Address, _control, versioncontrol;
 export TN := module;    
       	   
	export Layouts_Raw_Input := MODULE;
	
      export Filing := record
		string	CONTROL_NO	;
		string	FILING_TYPE	;
		string	BUSINESS_TYPE	;
		string	DURATION_TERM_TYPE	;
		string	STATUS	;
		string	STANDING_AR	;
		string	STANDING_RA	;
		string	STANDING_OTHER	;
		string	FILING_NAME	;
		string	DOMESTIC_YN	;
		string	FILING_DATE	;
		string	DELAYED_EFFECTIVE_DATE	;
		string	EXPIRATION_DATE	;
		string	INACTIVE_DATE	;
		string	FORMATION_LOCALE	;
		string	FORM_HOME_JURIS_DATE	;
		string	COMMON_SHARES	;
		string	PRINCIPLE_ADDR1	;
		string	PRINCIPLE_ADDR2	;
		string	PRINCIPLE_ADDR3	;
		string	PRINCIPLE_CITY	;
		string	PRINCIPLE_STATE	;
		string	PRINCIPLE_POSTAL_CODE	;
		string	PRINCIPLE_COUNTRY	;
		string	MAIL_ADDR1	;
		string	MAIL_ADDR2	;
		string	MAIL_ADDR3	;
		string	MAIL_CITY	;
		string	MAIL_STATE	;
		string	MAIL_POSTAL_CODE	;
		string	MAIL_COUNTRY	;
		string	AR_EXEMPT_YN	;
		string	MANAGED_BY_TYPE	;
		string	MEMBER_COUNT	;
		string	PUBLIC_BENEFIT_YN	;
		string	RELIGIOUS_BENEFIT_YN	;
		string	AR_DUE_DATE	;
		string	FYC_MONTH_NO	;
		end;
	
	export Filing_Name := record
		string	FILING_NAME_ID	;
		string	CONTROL_NO	;
		string	NAME_TYPE	;
		string	NAME	;
		end;
	
	export Party := record
		string	CONTROL_NO	;
	    string	PARTY_ID	;		
		string	PARTY_TYPE	;
		string	SOURCE_ID	;
		string	SOURCE_TYPE	;
		string	ORG_NAME	;
		string	FIRST_NAME	;
		string	MIDDLE_NAME	;
		string	LAST_NAME	;
		string	INDIVIDUAL_TITLE	;
		string	ADDR1	;
		string	ADDR2	;
		string	ADDR3	;
		string	CITY	;
		string	COUNTY	;
		string	STATE	;
		string	POSTAL_CODE	;
		string	COUNTRY	;
		end;
		
	export Annual_Report := record
	    string	FILING_ANNUAL_REPORT_ID	;
		string	CONTROL_NO	;
		string	AR_STATUS	;
		string	ANNUAL_REPORT_NUM	;
		string	FILING_YEAR	;
		string	AR_FILING_DATE	;
		string	LICENSE_TAX_AMT	;
		end;
		
	export Filing_FilingName := record
		Filing;
		Filing_Name and not control_no;
		end;
	  
	export Filing_FilingName_Party := record
		Filing_FilingName;
		Party and not control_no;
		end;
	  
	export Filing_AnnualReport := record
	    integer position := 0;
		Filing;
		Annual_Report and not control_no;
		end;
	end;
	
   	export Files_Raw_Input := MODULE;
	
		export Filing(string fileDate)       := dataset('~thor_data400::in::corp2::'+fileDate+'::filing::tn',Layouts_Raw_Input.filing,
														csv(separator('|'), heading(1), quote('"')));
		export FilingName(string fileDate)   := dataset('~thor_data400::in::corp2::'+fileDate+'::filing_name::tn',Layouts_Raw_Input.filing_name,
														csv(separator('|'), heading(1), quote('"')));
		export Party(string fileDate)        := dataset('~thor_data400::in::corp2::'+fileDate+'::party::tn',Layouts_Raw_Input.party,
														csv(separator('|'), heading(1), quote('"')));
		export AnnualReport(string fileDate)   := dataset('~thor_data400::in::corp2::'+fileDate+'::annual_report::tn',Layouts_Raw_Input.annual_report,
														csv(separator('|'), heading(1), quote('"')));		
	end;	
		   						
		
	trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end;
			
	getMonth(string s) := function
			mm := (string)intformat((integer)s,2,1);
			month := case(mm,
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
		return month;
		end;
		
    export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function
   
  
		
	    corp2_mapping.Layout_CorpPreClean CorpTransform01(layouts_raw_input.Filing_FilingName_Party input) := transform
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='47-'+trim(input.control_no,left,right);
			self.corp_vendor					  :='47';
		    self.corp_state_origin                :='TN';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.control_no,left,right);
			self.corp_src_type                    :='SOS';
			self.corp_legal_name                  :=trimUpper(input.filing_name);		  
			self.corp_ln_name_type_cd             :='01';
			self.corp_ln_name_type_desc           :='LEGAL';
			self.corp_name_comment                := if(trimUpper(input.name_type)='FOREIGN NAME',
														'FOREIGN NAME: ' + trimUpper(input.name),
														'');
			B_Addr_Present                        := trim(input.principle_addr1 +
													      input.principle_addr2 +
														  input.principle_addr3 +
														  input.principle_city +
														  input.principle_state +
														  input.mail_postal_code,all);													
			M_Addr_Present                        := trim(input.mail_addr1 +
													      input.mail_addr2 +
														  input.mail_addr3 +
														  input.mail_city +
														  input.mail_state +
														  input.mail_postal_code,all);														 
         	self.corp_address1_type_cd            :=if(B_Addr_Present<>'',
			                                           'B',
													   '');													   
			self.corp_address1_type_desc          := if(B_Addr_Present<>'',
			                                           'BUSINESS',
													   '');																
			self.corp_address2_type_cd            := if(M_Addr_Present<>'',
			                                            'M',
													    '');													   
			self.corp_address2_type_desc          := if(M_Addr_Present<>'',
			                                            'MAILING',
													    '');													   
			self.corp_address1_line1              := trimUpper(input.Principle_Addr1);
			self.corp_address1_line2              := trimUpper(input.Principle_Addr2) + ' ' + 
													 trimUpper(input.Principle_Addr3);
			self.corp_address1_line3              := trimUpper(input.Principle_City)  + 
													 if(trim(input.Principle_City +
															 input.Principle_State,left,right)<>'',
														     ', ',
															 '') +
													 trimUpper(input.Principle_State) + ' ' +
													 if((integer)input.Principle_Postal_Code<>0,
														trimUpper(input.Principle_Postal_Code),
														'');
			self.corp_address1_line4              := if(trimUpper(input.Principle_Country)<>'USA',
														trimUpper(input.Principle_Country),
														'');														
            self.corp_address2_line1              := trimUpper(input.Mail_Addr1);
			self.corp_address2_line2              := trimUpper(input.Mail_Addr2) + ' ' + 
													 trimUpper(input.Mail_Addr3);
			self.corp_address2_line3              := trimUpper(input.Mail_City) + 
													 if(trim(input.Mail_City +
															 input.Mail_State,left,right)<>'',
														     ', ',
															 '') +													
													 trimUpper(input.Mail_State) + ' ' +
													 if((integer)input.Mail_Postal_Code<>0,
														trimUpper(input.Mail_Postal_Code),
														'');
			self.corp_address2_line4              := if(trimUpper(input.Mail_Country)<>'USA',
														trimUpper(input.Mail_Country),
														'');    
            self.corp_status_desc                 :=trimUpper(input.Status);
			newDate1                              := if(trim(input.inactive_date,left,right)<>'',
														input.inactive_date[7..10] +
														input.inactive_date[1..2] +
														input.inactive_date[4..5],
														'');
			self.corp_status_date                 :=if(_validate.date.fIsValid(newDate1) and 
													   _validate.date.fIsValid((newDate1),_validate.date.rules.DateInPast),
													   newDate1,
													   '' );
			standing_1							  := if(trimUpper(input.standing_ar)<>'',
														'STANDING ANNUAL REPORT: ' + trimUpper(input.standing_ar),
														if(trimUpper(input.standing_ra)<>'' or trimUpper(input.standing_other)<>'',
															'; ',
															''));					
			standing_2                            := if(trimUpper(input.standing_ra)<>'',
														'STANDING REGISTERED AGENT: ' + trimUpper(input.standing_ra),
														if(trimUpper(input.standing_other)<>'',
															'; ',
															''));
			standing_3  						  := if(trimUpper(input.standing_other)<>'',
														'STANDING OTHER: ' + trimUpper(input.standing_other),
														'');
            all_standing			  			  := standing_1 + '; ' +
													 standing_2 + '; ' +
													 standing_3;
            clean_all_standing1 				  := regexreplace('(; ){2,}',all_standing,'; ');
			clean_all_standing2                   := regexreplace('(; ?$)',clean_all_standing1,'');													 
			clean_all_standing3                   := regexreplace('^(; ?)',clean_all_standing2,'');
            self.corp_status_comment			  := clean_all_standing3;			
			self.corp_foreign_domestic_ind        := case(trimUpper(input.Domestic_YN),
													   'Y' => 'D',
													   'N' => 'F',
													   '');													   			            																	
			newDate2                              := if(trim(input.filing_date,left,right)<>'',
														input.filing_date[7..10] +
														input.filing_date[1..2] +
														input.filing_date[4..5],
														'');
			self.corp_inc_date                    :=if(_validate.date.fIsValid(newDate2) and 
													   _validate.date.fIsValid((newDate2),_validate.date.rules.DateInPast),
													   newDate2,
													   '' );            
            self.corp_inc_state                   := if(regexfind(' COUNTY',input.formation_locale,nocase),
													 'TN',
													 '');
			self.corp_inc_county                  := if(regexfind(' COUNTY',input.formation_locale,nocase),
														trimUpper(regexreplace(' COUNTY',input.formation_locale,'',nocase)),
														'');	
            self.corp_forgn_state_desc			  := if(regexfind(' COUNTY',input.formation_locale,nocase),
													 '',
													 trimUpper(input.formation_locale));																																						 
            newDate3                              := if(trim(input.form_home_juris_date,left,right)<>'',
														input.form_home_juris_date[7..10] +
														input.form_home_juris_date[1..2] +
														input.form_home_juris_date[4..5],
														'');													 
			self.corp_forgn_date                  :=if(self.corp_forgn_state_desc<>'' and
													   _validate.date.fIsValid(newDate3), 													   
													   newDate3,
													   '' );         
			newDate4                              := if(trim(input.delayed_effective_date,left,right)<>'',
														input.delayed_effective_date[7..10] +
														input.delayed_effective_date[1..2] +
														input.delayed_effective_date[4..5],
														'');
            addl_info1                            := if(_validate.date.fIsValid(newDate4), 													   
													    'DELAYED EFFECTIVE DATE: ' + newDate4[5..8] + newDate4[1..4],
													    '' );														
            addl_info2                            := if(trim(input.managed_by_type)<>'', 													   
													    'MANAGED BY: ' + trimUpper(input.managed_by_type),
													    '');													   													   		
            addl_info3                            := if(trim(input.member_count,left,right)<>'', 													   
													    'NO. OF MEMBERS: ' + trimUpper(input.member_count),
													    '');														
            addl_info4                            := if(trim(input.public_benefit_yn,left,right)<>'', 													   
													    'PUBLIC BENEFIT: ' + trimUpper(input.public_benefit_yn),
													    '');														
			addl_info5                            := if(getMonth(input.fyc_month_no)<>'', 													   
													    'FISCAL YEAR END CLOSE: ' + getMonth(input.fyc_month_no),
													    '');			
			all_addl_info 						  := addl_info1 +
													 '; ' +
													 addl_info2 +
													 '; ' +
													 addl_info3 +
													 '; ' +
												 	 addl_info4 +
													 '; ' +
													 addl_info5;
			clean_all_addl_info1 				  := regexreplace('(; ){2,}',all_addl_info,'; ');			
			clean_all_addl_info2 				  := regexreplace('(; ?$)',clean_all_addl_info1,'');
			clean_all_addl_info3 				  := regexreplace('^(; ?)',clean_all_addl_info2,'');
            self.corp_addl_info                   := clean_all_addl_info3;																																		
			self.corp_orig_org_structure_desc     := trimUpper(input.filing_type);													
			self.corp_orig_bus_type_desc          :=trimUpper(input.business_type);														
		    self.corp_ra_name               := trimUpper(input.org_name    + ' ' +
														 input.first_name  + ' ' +
														 input.middle_name + ' ' +
														 input.last_name); 														 
			self.corp_ra_title_desc			:= trimUpper(input.individual_title);					    
            self.corp_ra_address_line1      := trimUpper(input.addr1);
			self.corp_ra_address_line2      := trimUpper(input.addr2) + ' ' +
											   trimUpper(input.addr3);
			self.corp_ra_address_line3      := trimUpper(input.city) + 
											   if(trim(input.City +
													   input.State,left,right)<>'',
													   ', ',
													   '') +			
											   trimUpper(input.state) + ' ' +
											   if((integer) input.postal_code<>0,
			                                      trimUpper(input.postal_code),
												  '');
			self.corp_ra_address_line4      := trimUpper(input.county);
			self.corp_ra_address_line5      := if(trimUpper(input.Country)<>'USA',
												  trimUpper(input.Country),
												  '');
			self.corp_ra_address_type_cd   	:= if(self.corp_ra_address_line1<>'' or 
												  self.corp_ra_address_line2<>'' or
			                                      self.corp_ra_address_line3<>'' or 
										          self.corp_ra_address_line4<>'' or
												  self.corp_ra_address_line5<>'',
												  'G',
												  '');
			self.corp_ra_address_type_desc  :=if(self.corp_ra_address_line1<>'' or 
												 self.corp_ra_address_line2<>'' or
			                                     self.corp_ra_address_line3<>'' or 
												 self.corp_ra_address_line4<>'' or
												 self.corp_ra_address_line5<>'',
												 'REGISTERED OFFICE',
												 '');
			self.corp_entity_desc			 := if(trimUpper(input.religious_benefit_yn)='Y',
												   'RELIGIOUS BENEFIT',
												   '');
			testForDate1                      := regexfind('\\d\\d/\\d\\d/\\d\\d\\d\\d',input.duration_term_type,0);
			newDate5                         := if(trim(testForDate1,left,right)<>'' and
											       _validate.date.fIsValid(testForDate1[7..10] +
																	       testForDate1[1..2] +
																	       testForDate1[4..5]),
													testForDate1[7..10] +
													testForDate1[1..2]  +
													testForDate1[4..5],
													'');													
			testForDate2                      := regexfind('\\d\\d/\\d\\d/\\d\\d\\d\\d',input.expiration_date,0);
			newDate6                         := if(trim(testForDate2,left,right)<>'' and
											       _validate.date.fIsValid(testForDate2[7..10] +
																	       testForDate2[1..2] +
																	       testForDate2[4..5]),
													testForDate2[7..10] +
													testForDate2[1..2]  +
													testForDate2[4..5],
													'');
			self.corp_term_exist_cd  		 := map(regexfind('perpetual',input.duration_term_type,nocase)=>'P',
													newDate5<>''=>'D',
													newDate6<>''=>'D',
													'');																
			self.corp_term_exist_exp         := map(newDate5<>''=>newDate5,
													newDate6<>''=>newDate6,
													'');													
			self.corp_term_exist_desc        := map(regexfind('perpetual',input.duration_term_type,nocase)=>'PERPETUAL',
													newDate5<>''=>'EXPIRATION DATE',
													newDate6<>''=>'EXPIRATION DATE',
													'');
		    self                             := [];		
			end; 

			corp2.layout_corporate_direct_corp_in CorpTransform02(layouts_raw_input.Filing_FilingName_Party input) := transform								
     	    self.dt_first_seen					  :=fileDate;
			self.dt_last_seen					  :=fileDate;
			self.dt_vendor_first_reported		  :=fileDate;
			self.dt_vendor_last_reported		  :=fileDate;
			self.corp_ra_dt_first_seen			  :=fileDate;
			self.corp_ra_dt_last_seen			  :=fileDate;
			self.corp_key					      :='47-'+trim(input.control_no,left,right);
			self.corp_vendor					  :='47';
		    self.corp_state_origin                :='TN';
			self.corp_process_date				  := fileDate;    
     	    self.corp_orig_sos_charter_nbr        :=trim(input.control_no,left,right);
			self.corp_legal_name                  :=trimUpper(input.name);		  
			self.corp_ln_name_type_cd             :='06';
			self.corp_ln_name_type_desc           :='ASSUMED';
		    self                             	  := [];		
			end; 		
	    
		
	     Corp2.Layout_Corporate_Direct_AR_In AnnualReportTransform(Layouts_Raw_Input.Filing_AnnualReport input):=transform
			self.corp_key					:= '47-'+trim(input.control_no,left,right);
			self.corp_vendor				:= '47';
			self.corp_state_origin			:= 'TN';
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr		:= trim(input.control_no,left,right);
			self.ar_year                    := trim(input.filing_year,left,right);		
            self.ar_filed_dt                := if(input.ar_filing_date<>'' and
											       _validate.date.fIsValid(input.ar_filing_date),
													input.ar_filing_date,
													'');
            testDate2                        := if(input.position=1,
												   trim(input.ar_due_date,left,right),											   
												   '');
			self.ar_due_dt                   := if(testDate2<>'' and
											       _validate.date.fIsValid(testDate2[7..10] +
																	       testDate2[1..2] +
																	       testDate2[4..5]),
													testDate2[7..10] +
													testDate2[1..2]  +
													testDate2[4..5],
													'');
		   self.ar_tax_amount_paid         := if(trim(input.license_tax_amt,left,right)<>'',
												 '$' + trim(input.license_tax_amt,left,right),
												 '');										  
           self.ar_comment                 := if(trimUpper(input.ar_exempt_yn) in ['Y','N'] and input.position=1,
				                                 'ANNUAL REPORT EXEMPT: ' + trimUpper(input.ar_exempt_yn),
											     '');
		   self                            := [];
		   end; 		 		 		 
		
		
	     Corp2.Layout_Corporate_Direct_Stock_In StockTransform(layouts_raw_input.Filing input):=transform,
															   skip((integer)input.common_shares=0)
			self.corp_key					      := '47-'+trim(input.control_no,left,right);
			self.corp_vendor				      := '47';
			self.corp_state_origin			      := 'TN';
			self.corp_process_date			      := fileDate;
			self.corp_sos_charter_nbr		      := trim(input.control_no,left,right);			
			self.stock_shares_issued              := trim(input.common_shares,left,right);
        	self                                  := [];						
			end;  
		
		 
		 //---------------------------- Clean corp Name and Addresses ---------------------//
		 corp2.layout_corporate_direct_corp_in CleanCorpRecs(corp2_mapping.Layout_CorpPreClean input) := transform
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
									
			string182 clean_address2 			:= Address.CleanAddress182(trim(trim(input.corp_address2_line1,left,right) + ' ' + 														                        
												trim(input.corp_address2_line2,left,right),left,right),														                   
												trim(trim(input.corp_address2_line3,left,right) + ', ' +
												trim(input.corp_address2_line4,left,right) + ' ' +
												trim(input.corp_address2_line5,left,right) +
												trim(input.corp_address2_line6,left,right),left,right));

			self.corp_addr2_prim_range    		:= clean_address2[1..10];
			self.corp_addr2_predir 	      		:= clean_address2[11..12];
			self.corp_addr2_prim_name 	  		:= clean_address2[13..40];
			self.corp_addr2_addr_suffix   		:= clean_address2[41..44];
			self.corp_addr2_postdir 	    	:= clean_address2[45..46];
			self.corp_addr2_unit_desig 	  		:= clean_address2[47..56];
			self.corp_addr2_sec_range 	  		:= clean_address2[57..64];
			self.corp_addr2_p_city_name	  		:= clean_address2[65..89];
			self.corp_addr2_v_city_name	  		:= clean_address2[90..114];
			self.corp_addr2_state 				:= clean_address2[115..116];
			self.corp_addr2_zip5 		    	:= clean_address2[117..121];
			self.corp_addr2_zip4 		    	:= clean_address2[122..125];
			self.corp_addr2_cart 		    	:= clean_address2[126..129];
			self.corp_addr2_cr_sort_sz 	 		:= clean_address2[130];
			self.corp_addr2_lot 		      	:= clean_address2[131..134];
			self.corp_addr2_lot_order 	  		:= clean_address2[135];
			self.corp_addr2_dpbc 		    	:= clean_address2[136..137];
			self.corp_addr2_chk_digit 	  		:= clean_address2[138];
			self.corp_addr2_rec_type		  	:= clean_address2[139..140];
			self.corp_addr2_ace_fips_st	  		:= clean_address2[141..142];
			self.corp_addr2_county 	  			:= clean_address2[143..145];
			self.corp_addr2_geo_lat 	    	:= clean_address2[146..155];
			self.corp_addr2_geo_long 	    	:= clean_address2[156..166];
			self.corp_addr2_msa 		      	:= clean_address2[167..170];
			self.corp_addr2_geo_blk				:= clean_address2[171..177];
			self.corp_addr2_geo_match 	  		:= clean_address2[178];
			self.corp_addr2_err_stat 	    	:= clean_address2[179..182];			
															
			string182 clean_address_ra 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' + 														                        
												trim(input.corp_ra_address_line2,left,right),left,right),														                   
												trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
												trim(input.corp_ra_address_line4,left,right) + ' ' +
												trim(input.corp_ra_address_line5,left,right) +
												trim(input.corp_ra_address_line6,left,right),left,right));

			self.corp_ra_prim_range    			:= clean_address_ra[1..10];
			self.corp_ra_predir 	      		:= clean_address_ra[11..12];
			self.corp_ra_prim_name 	  			:= clean_address_ra[13..40];
			self.corp_ra_addr_suffix   			:= clean_address_ra[41..44];
			self.corp_ra_postdir 	    		:= clean_address_ra[45..46];
			self.corp_ra_unit_desig 	  		:= clean_address_ra[47..56];
			self.corp_ra_sec_range 	  			:= clean_address_ra[57..64];
			self.corp_ra_p_city_name	  		:= clean_address_ra[65..89];
			self.corp_ra_v_city_name	  		:= clean_address_ra[90..114];
			self.corp_ra_state 			      	:= clean_address_ra[115..116];
			self.corp_ra_zip5 		      		:= clean_address_ra[117..121];
			self.corp_ra_zip4 		      		:= clean_address_ra[122..125];
			self.corp_ra_cart 		      		:= clean_address_ra[126..129];
			self.corp_ra_cr_sort_sz 	 		:= clean_address_ra[130];
			self.corp_ra_lot 		      		:= clean_address_ra[131..134];
			self.corp_ra_lot_order 	  			:= clean_address_ra[135];
			self.corp_ra_dpbc 		      		:= clean_address_ra[136..137];
			self.corp_ra_chk_digit 	  			:= clean_address_ra[138];
			self.corp_ra_rec_type		  		:= clean_address_ra[139..140];
			self.corp_ra_ace_fips_st	  		:= clean_address_ra[141..142];
			self.corp_ra_county 	  			:= clean_address_ra[143..145];
			self.corp_ra_geo_lat 	    		:= clean_address_ra[146..155];
			self.corp_ra_geo_long 	    		:= clean_address_ra[156..166];
			self.corp_ra_msa 		      		:= clean_address_ra[167..170];
			self.corp_ra_geo_blk				:= clean_address_ra[171..177];
			self.corp_ra_geo_match 	  			:= clean_address_ra[178];
			self.corp_ra_err_stat 	    		:= clean_address_ra[179..182];			
			self								:= input;
			self								:= [];
		 end; 
				
        Filings 	  := distribute(Files_Raw_Input.Filing(filedate),hash(control_no));
		FilingNames   := distribute(Files_Raw_Input.FilingName(filedate),hash(control_no));
		Partys        := distribute(Files_Raw_Input.Party(filedate),hash(control_no));
		AnnualReports := distribute(Files_Raw_Input.AnnualReport(filedate),hash(control_no));
				
		Layouts_Raw_Input.Filing_FilingName join_Filing_FilingName(Filings L,FilingNames R) := transform
			    self 					:= L;
			    self					:= R;			
				end; 
		
		joinedFiling_FilingName := join(Filings,FilingNames,
									trim(left.control_no,left,right) = trim(right.control_no,left,right),
									join_Filing_FilingName(left,right),
									left outer,local);
		 
		Layouts_Raw_Input.Filing_FilingName_Party  join_Filing_FilingName_Party(joinedFiling_FilingName L,Partys R) := transform
			    self 					:= L;
			    self					:= R;			
				end; 
		
		joinedFiling_FilingName_Party := join(joinedFiling_FilingName,Partys,
									trim(left.control_no,left,right) = trim(right.control_no,left,right),
									join_Filing_FilingName_Party(left,right),
									left outer,local);	 
		
		Layouts_Raw_Input.Filing_AnnualReport join_Filing_AnnualReport(Filings L,AnnualReports R) := transform
			    self 					:= L;
				self.ar_filing_date     := trim(R.ar_filing_date,left,right)[7..10] +
										   trim(R.ar_filing_date,left,right)[1..2]  +
										   trim(R.ar_filing_date,left,right)[4..5];
			    self					:= R;			
				end; 
		
		joinedFiling_AnnualReport := join(Filings,AnnualReports,
									trim(left.control_no,left,right) = trim(right.control_no,left,right),
									join_Filing_AnnualReport(left,right),
									right outer,local);
		
	
		Layouts_Raw_Input.Filing_AnnualReport assignAR(Layouts_Raw_Input.Filing_AnnualReport L,
												Layouts_Raw_Input.Filing_AnnualReport R,
												integer cntr) := transform
					self.position := cntr;
					self          := R;
					end;
												 
		sortedAR    := sort(joinedFiling_AnnualReport,control_no,-ar_filing_date);						
	    groupedAR   := group(sortedAR,control_no);
        AnnReportsTemp1 := iterate(groupedAR,assignAR(left,right,counter));
		AnnReportsTemp2 := group(AnnReportsTemp1);
		
		//Build record types
	    Corps1 := project(joinedFiling_FilingName_Party,CorpTransform01(left));
		Corps2 := project(joinedFiling_FilingName_Party(trimUpper(name_type)='ASSUMED NAME'),
						  CorpTransform02(left));
		
		AnnReports := project(AnnReportsTemp2,AnnualReportTransform(left));						       						 
		
		Stocks := project(Filings,StockTransform(left));
		
		//Clean Names/Addresses in Corps1 records
		cleanCorps := project(Corps1,CleanCorpRecs(left));
		allCorps   := sort(cleanCorps + Corps2,corp_orig_sos_charter_nbr);
						               				
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_tn'	,allCorps	 ,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_tn'	,AnnReports	 ,ar_out		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_tn'	,Stocks		 ,cont_out		,,,pOverwrite);
		                                                                                                                                                      
		 mappedtn_Filing := parallel(
			 corp_out	
			,ar_out		
			,cont_out);								
	
									 
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('tn',filedate,pOverwrite := pOverwrite))
			,mappedtn_Filing
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_tn')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_tn')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock'	,'~thor_data400::in::corp2::'+version+'::stock_tn')
			)
		);      
         return result;
   end;				 
   
 end;  
	
   
	   
	   
	   
	   
	  
	  
	  
 	  
	  
	  
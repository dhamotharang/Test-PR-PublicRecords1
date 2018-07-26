 import corp2,corp2_raw_tn,scrubs,scrubs_corp2_mapping_tn_ar,scrubs_corp2_mapping_tn_main,
				scrubs_corp2_mapping_tn_stock,std,tools,ut,versioncontrol;
 
 export TN := module;  
 
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function

		state_origin 						:= 'TN';
		state_fips	  					:= '47';	
		state_desc	 						:= 'TENNESSEE'; 

    Filings 	  						:= dedup(sort(distribute(Corp2_Raw_TN.Files(filedate,puseprod).Input.Filing.Logical,hash(control_no)),record,local),record,local)      	: independent; 
		FilingNames   					:= dedup(sort(distribute(Corp2_Raw_TN.Files(filedate,puseprod).Input.FilingName.Logical,hash(control_no)),record,local),record,local) 	: independent;
		Parties        					:= dedup(sort(distribute(Corp2_Raw_TN.Files(filedate,puseprod).Input.Party.Logical,hash(control_no)),record,local),record,local) 				: independent;
		AnnualReports 					:= dedup(sort(distribute(Corp2_Raw_TN.Files(filedate,puseprod).Input.AnnualReport.Logical,hash(control_no)),record,local),record,local) : independent;
													 
		//Do Joins for Corporation File	 
		CorporationFile			 		:= join(Filings,Parties,
																		corp2.t2u(left.control_no) = corp2.t2u(right.control_no),
																		transform(Corp2_Raw_TN.Layouts.Temp_Filing_Party,
																		self := left;	self := right; ),
																		left outer,	local ) : independent;
		
		//Do Joins for AnnualReports File
		AddAR2Filing 	:= join(Filings,AnnualReports,
																		corp2.t2u(left.control_no) = corp2.t2u(right.control_no),
																		transform(Corp2_Raw_TN.Layouts.Temp_Filing_AnnualReport,
																		self := left;	self := right; ),
																		inner, local ) : independent;

		groupedAR   						:= group(sort(AddAR2Filing,control_no,-ar_filing_date),control_no);						
    ARFile 			            := group(iterate(groupedAR, transform(Corp2_Raw_TN.Layouts.Temp_Filing_AnnualReport,
																							self.position := counter;
																							self := right;)	)	) : independent;
															
		//********************************************************************
		//This begins the MAIN Mapping.
		//********************************************************************	
		Corp2_mapping.LayoutsCommon.Main CorpTransform01(Corp2_Raw_TN.Layouts.Temp_Filing_Party l) := transform
			self.dt_vendor_first_reported							 	:= (integer)fileDate;
			self.dt_vendor_last_reported							 	:= (integer)fileDate;
			self.dt_first_seen												 	:= (integer)fileDate;
			self.dt_last_seen													 	:= (integer)fileDate;
			self.corp_ra_dt_first_seen								 	:= (integer)fileDate;
			self.corp_ra_dt_last_seen									 	:= (integer)fileDate;
			self.corp_key															 	:= state_fips +'-' + corp2.t2u(l.control_no);
			self.corp_vendor 													 	:= state_fips;
			self.corp_state_origin		 								 	:= state_origin;
			self.corp_process_date 										 	:= fileDate;
			self.corp_orig_sos_charter_nbr		 				 	:= corp2.t2u(l.control_no);
			self.corp_legal_name 											 	:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.filing_name).BusinessName;  
			self.corp_ln_name_type_cd             		 	:= Corp2_Raw_TN.Functions.CorpLNNameTypeCD(l.filing_type);
			self.corp_ln_name_type_desc  		          	:= Corp2_Raw_TN.Functions.CorpLNNameTypeDesc(l.filing_type);
			
			// If record has a principle address put it in corp_address1, if not put mail address in corp_address1
			prinExists := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.principle_addr1,l.principle_addr2+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).ifAddressExists, true, false);
			mailExists := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.mail_addr1,l.mail_addr2 + l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).ifAddressExists, true, false);
			
			self.corp_address1_type_cd								 	:= if(prinExists ,'B' ,if(mailExists,'M',''));
			self.corp_address1_type_desc							 	:= if(prinExists ,'BUSINESS' ,if(mailExists,'MAILING',''));
			self.corp_address1_line1							  	 	:= if(prinExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).AddressLine1
																												,if(mailExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2 + l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).AddressLine1	,''));
			self.corp_address1_line2									 	:= if(prinExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).AddressLine2
																												,if(mailExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2 + l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).AddressLine2	,''));																												
			self.corp_address1_line3									 	:= if(prinExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).AddressLine3
																												,if(mailExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2 + l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).AddressLine3	,''));																												
			self.corp_prep_addr1_line1									:= if(prinExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).PrepAddrLine1
																												,if(mailExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).PrepAddrLine1 ,''));																												
			self.corp_prep_addr1_last_line							:= if(prinExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.principle_addr1,l.principle_addr2+l.principle_addr3,l.principle_city,l.principle_state,l.principle_postal_code,l.principle_country).PrepAddrLastLine
																												,if(mailExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).PrepAddrLastLine	,''));
																														
			self.corp_address2_type_cd								 	:= if(prinExists and mailExists ,'M' ,'');
			self.corp_address2_type_desc							 	:= if(prinExists and mailExists ,'MAILING' ,'');
			self.corp_address2_line1							  	 	:= if(prinExists and mailExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2 + l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).AddressLine1,'');
			self.corp_address2_line2									 	:= if(prinExists and mailExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2 + l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).AddressLine2,'');
			self.corp_address2_line3									 	:= if(prinExists and mailExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2 + l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).AddressLine3,'');
			self.corp_prep_addr2_line1									:= if(prinExists and mailExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).PrepAddrLine1,'');
			self.corp_prep_addr2_last_line							:= if(prinExists and mailExists ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.mail_addr1,l.mail_addr2+l.mail_addr3,l.mail_city,l.mail_state,l.mail_postal_code,l.mail_country).PrepAddrLastLine,'');
			
			self.corp_filing_date												:= if(corp2.t2u(l.formation_locale) not in [state_origin,state_desc,''],Corp2_Mapping.fValidateDate(l.form_home_juris_date,'MM/DD/CCYY').PastDate,'');	
			self.corp_filing_desc												:= if(corp2.t2u(self.corp_filing_date)<>'','HOME STATE','');
      self.corp_status_desc           		       	:= corp2.t2u(l.status);
			self.corp_status_date				  						 	:= Corp2_Mapping.fValidateDate(l.inactive_date,'MM/DD/CCYY').GeneralDate;											   			            																	
			self.corp_inc_state 		                  	:= state_origin;
			self.corp_term_exist_cd 		 		 						:= map(stringlib.stringfilter(l.duration_term_type,'0123456789')<>'' => 'N',
																												 corp2.t2u(l.duration_term_type) = 'PERPETUAL'                 => 'P',
																												 '');																										 
			self.corp_term_exist_exp  		       				:= if(stringlib.stringfilter(l.duration_term_type,'0123456789')<>'',stringlib.stringfilter(l.duration_term_type,'0123456789'),'');
			self.corp_term_exist_desc     		   				:= case(self.corp_term_exist_cd, 'N'=>'NUMBER OF YEARS', 'P'=>'PERPETUAL', '');
			
			Dom_or_For := case(corp2.t2u(l.domestic_yn), 'Y'=>'D', 'N'=>'F', 'D'); // per Rosemary, default to Domestic
			self.corp_foreign_domestic_ind   		      	:= Dom_or_For;
			self.corp_inc_date					  				 			:= if(Dom_or_For = 'D' ,Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate,'');
			self.corp_forgn_date				  						 	:= if(Dom_or_For = 'F' ,Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate,'');
			self.corp_forgn_state_cd		  						 	:= if(Dom_or_For = 'F' and corp2.t2u(l.formation_locale) not in [state_origin,state_desc,''] ,Corp2_Raw_TN.Functions.CorpForgnStateCD(l.formation_locale),'');
      self.corp_forgn_state_desc			  					:= if(Dom_or_For = 'F' and corp2.t2u(l.formation_locale) not in [state_origin,state_desc,''] ,Corp2_Raw_TN.Functions.CorpForgnStateDesc(l.formation_locale),'');
					  
			//This is an overloaded field.
			self.corp_addl_info                   			:= Corp2_Raw_TN.Functions.CorpAddlInfo(l.delayed_effective_date,l.managed_by_type,l.member_count,l.public_benefit_yn,l.fyc_month_no);
			self.corp_orig_org_structure_desc   		  	:= Corp2_Raw_TN.Functions.CorpOrigOrgStructureDesc(l.filing_type);
			self.corp_for_profit_ind										:= case(corp2.t2u(l.filing_type), 'FOR-PROFIT CORPORATION'=>'Y', 'NONPROFIT CORPORATION'=>'N', '');
			self.corp_orig_bus_type_desc       		  		:= corp2.t2u(l.business_type);
			self.corp_entity_desc			 									:= if(corp2.t2u(l.religious_benefit_yn)='Y','RELIGIOUS BENEFIT','');			
			//Note: Only org_name is populated or first/middle/last name is populated but not both. Plus this handles when
			//			the org_name is spilled over in the first_name field.
		  self.corp_ra_fname													:= if(corp2.t2u(l.first_name)  <>'NO AGENT',corp2.t2u(l.first_name)  ,'');
			self.corp_ra_mname													:= if(corp2.t2u(l.middle_name) <>'NO AGENT',corp2.t2u(l.middle_name) ,'');
			self.corp_ra_lname													:= if(corp2.t2u(l.last_name)   <>'NO AGENT',corp2.t2u(l.last_name)   ,'');
			self.corp_ra_full_name           						:= corp2.t2u(if(corp2.t2u(l.org_name) <>'NO AGENT',l.org_name,'') + ' ' + 
																															 self.corp_ra_fname + ' ' + self.corp_ra_mname + ' ' + self.corp_ra_lname);
			self.corp_ra_address_type_cd						  	:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2+l.addr3,l.city,l.state,l.postal_code,l.country).ifAddressExists,'R','');
			self.corp_ra_address_type_desc							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2+l.addr3,l.city,l.state,l.postal_code,l.country).ifAddressExists,'REGISTERED OFFICE','');
			self.corp_ra_address_line1							  	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+l.addr3,l.city,l.state,l.postal_code,l.country).AddressLine1;
			self.corp_ra_address_line2									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+l.addr3,l.city,l.state,l.postal_code,l.country).AddressLine2;
			self.corp_ra_address_line3									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+l.addr3,l.city,l.state,l.postal_code,l.country).AddressLine3;
			self.ra_prep_addr_line1											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+l.addr3,l.city,l.state,l.postal_code,l.country).PrepAddrLine1;
			self.ra_prep_addr_last_line									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2+l.addr3,l.city,l.state,l.postal_code,l.country).PrepAddrLastLine;
			self.corp_agent_county											:= corp2.t2u(l.county);
			self.corp_agent_country											:= Corp2_Mapping.fCleanCountry(state_origin,state_desc,,l.country).Country;
			self.corp_agent_status_desc									:= corp2.t2u(l.standing_ra);			
			self.corp_delayed_effective_date						:= Corp2_Mapping.fValidateDate(l.delayed_effective_date,'MM/DD/CCYY').GeneralDate;
			self.corp_fiscal_year_month									:= if((integer)l.fyc_month_no<>0,Corp2_Raw_TN.Functions.GetMonthDesc((string)(integer)l.fyc_month_no),'');
			self.corp_management_desc										:= if(corp2.t2u(l.managed_by_type) not in ['N','USA'],corp2.t2u(l.managed_by_type),'');
			self.corp_name_reservation_expiration_date 	:= if(corp2.t2u(l.filing_type) in ['RESERVED NAME'],Corp2_Mapping.fValidateDate(l.expiration_date,'MM/DD/CCYY').GeneralDate,'');
			self.corp_nbr_of_initial_llc_members				:= if(corp2.t2u(l.member_count) not in ['0','N'],(string)(integer)l.member_count,'');
			self.corp_public_mutual_corporation					:= if(corp2.t2u(l.public_benefit_yn) = 'Y','PUBLIC BENEFIT','');
			self.corp_standing_other										:= corp2.t2u(l.standing_other);
			self.recordorigin														:= 'C';
		  self   		                         					:= [];
		end;

	  MapCorporationFile 	:= project(CorporationFile,CorpTransform01(left));

		//********************************************************************
		//Map the "Assumed Name" data to MAIN.
		//********************************************************************	
		
		//Join FilingNames to Filings	 
		jFilingNames_Filings 		:= join(FilingNames, Filings,
																		corp2.t2u(left.control_no) = corp2.t2u(right.control_no),
																		transform(Corp2_Raw_TN.Layouts.Temp_FilingNames,
																		self := left;	self := right; ),
																		left outer,	local ) : independent;
		
		
		Corp2_mapping.LayoutsCommon.Main CorpTransform02(Corp2_Raw_TN.Layouts.Temp_FilingNames l) := transform
			self.dt_vendor_first_reported						:= (integer)fileDate;
			self.dt_vendor_last_reported						:= (integer)fileDate;
			self.dt_first_seen											:= (integer)fileDate;
			self.dt_last_seen												:= (integer)fileDate;
			self.corp_ra_dt_first_seen							:= (integer)fileDate;
			self.corp_ra_dt_last_seen								:= (integer)fileDate;
			self.corp_key														:= state_fips +'-' + corp2.t2u(l.control_no);
			self.corp_vendor 												:= state_fips;
			self.corp_state_origin 									:= state_origin;
			self.corp_process_date 									:= fileDate;
			self.corp_orig_sos_charter_nbr 					:= corp2.t2u(l.control_no);
			self.corp_legal_name 										:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.name).BusinessName;  
			self.corp_ln_name_type_cd             	:= case(corp2.t2u(l.name_type), 'FOREIGN NAME'=>'F', 'ASSUMED NAME'=>'06', '');
			self.corp_ln_name_type_desc           	:= if(corp2.t2u(l.name_type) = 'ASSUMED NAME' ,'ASSUMED' ,corp2.t2u(l.name_type));
      self.corp_inc_state                   	:= state_origin;
			self.corp_home_state_name								:= if(corp2.t2u(l.name_type) = 'FOREIGN NAME'
																										,Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.filing_name).BusinessName
																										,'');
			Dom_or_For := case(corp2.t2u(l.domestic_yn), 'Y'=>'D', 'N'=>'F', 'D'); // per Rosemary, default to Domestic
			self.corp_inc_date					  				 	:= if(Dom_or_For = 'D' ,Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate,'');
			self.corp_forgn_date				  					:= if(Dom_or_For = 'F' ,Corp2_Mapping.fValidateDate(l.filing_date,'MM/DD/CCYY').PastDate,'');
			self.recordorigin												:= 'C';			
		  self   		                         			:= [];		
		end;
		
		MapAssumedNames		 	:= project(jFilingNames_Filings,CorpTransform02(left));
		
		MapMain 						:= dedup(sort(distribute(MapCorporationFile + MapAssumedNames,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		//This begins the AR Mapping.
		//********************************************************************	
		Corp2_mapping.LayoutsCommon.AR FilingsTransform(Corp2_Raw_TN.Layouts.FilingLayoutIn l) := transform
			self.corp_key													:= state_fips +'-' + corp2.t2u(l.control_no);
			self.corp_vendor 											:= state_fips;
			self.corp_state_origin 								:= state_origin;
			self.corp_process_date 								:= fileDate;
			self.corp_sos_charter_nbr 						:= corp2.t2u(l.control_no);			
			self.ar_due_dt                   			:= Corp2_Mapping.fValidateDate(l.ar_due_date,'MM/DD/CCYY').GeneralDate;
			//This is an overloaded field until ar_exempt is customer facing.
			self.ar_comment                 			:= if(corp2.t2u(l.ar_exempt_yn) in ['Y','N'],'ANNUAL REPORT EXEMPT: ' + corp2.t2u(l.ar_exempt_yn),'');
			self.ar_status												:= corp2.t2u(l.standing_ar);
			self.ar_exempt												:= if(corp2.t2u(l.ar_exempt_yn) in ['Y','N'],corp2.t2u(l.ar_exempt_yn),'');
		  self                            			:= [];
		end;

		MapFilings 						:= project(Filings,FilingsTransform(left));
		FilingsMapped 				:= MapFilings(corp2.t2u(ar_due_dt + ar_comment + ar_status + ar_exempt)<>'');

		Corp2_mapping.LayoutsCommon.AR ARTransform(Corp2_Raw_TN.Layouts.Temp_Filing_AnnualReport l) := transform
			self.corp_key													:= state_fips +'-' + corp2.t2u(l.control_no);
			self.corp_vendor 											:= state_fips;
			self.corp_state_origin 								:= state_origin;
			self.corp_process_date 								:= fileDate;
			self.corp_sos_charter_nbr 						:= corp2.t2u(l.control_no);			
			self.ar_year                    			:= corp2.t2u(l.filing_year);		
			self.ar_filed_dt					  				  := Corp2_Mapping.fValidateDate(l.ar_filing_date,'MM/DD/CCYY').PastDate;
			self.ar_report_nbr                   	:= corp2.t2u(l.annual_report_nbr);
			self.ar_status												:= corp2.t2u(l.status);
		  self                            			:= [];
		end;

		ARMapped	:= project(ARFile,ARTransform(left))(corp2.t2u(ar_year + ar_filed_dt + ar_report_nbr + ar_status)<>'');
		MapAR     := dedup(sort(distribute(ARMapped + FilingsMapped,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		//This begins the Stock Mapping.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Stock StockTransform(Corp2_Raw_TN.Layouts.FilingLayoutIn l) := transform,
		skip(corp2.t2u(l.common_shares) in ['','0'] or corp2.t2u(l.control_no) = '')
			self.corp_key													:= state_fips +'-' + corp2.t2u(l.control_no);
			self.corp_vendor											:= state_fips;
			self.corp_state_origin								:= state_origin;			
			self.corp_process_date								:= fileDate;
			self.corp_sos_charter_nbr							:= corp2.t2u(l.control_no);
			self.stock_shares_issued              := if(corp2.t2u(l.common_shares) not in ['02/06/2001', '08/19/2010'],corp2.t2u(l.common_shares),''); //per CI :dates for shares are errors
			self.stock_type												:= 'COMMON';
      self                                  := [];
		end;
				
		Stocks		 := project(Filings,StockTransform(left));
		MapStock   := dedup(sort(distribute(Stocks,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// SCRUB AR 
		//********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_TN_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//outputs reports
		AR_ErrorSummary			 		:= output(AR_U.SummaryStats, named('AR_ErrorSummary_TN'+filedate));
		AR_ScrubErrorReport 	 	:= output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_TN'+filedate));
		AR_SomeErrorValues		 	:= output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_TN'+filedate));
		AR_IsScrubErrors		 	 	:= if(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 		:= AR_U.OrbitStats();

		//outputs files
		AR_CreateBitmaps			 	:= output(AR_N.BitmapInfile,,'~thor_data::corp_tn_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitmap		 	:= output(AR_T);

    //Submits Profile's stats to Orbit
    AR_SubmitStats          := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_TN_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_TN_AR').SubmitStats;

		AR_ScrubsWithExamples 	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_TN_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_TN_AR').CompareToProfile_with_Examples;
		AR_ScrubsAlert				 	:= AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	 		:= Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					 		:= FileServices.SendEmailAttachData(Corp2.Email_Notification_Lists.spray
																															 ,'Scrubs CorpAR_TN Report' //subject
																															 ,'Scrubs CorpAR_TN Report' //body
																															 ,(data)AR_ScrubsAttachment
																															 ,'text/csv'
																															 ,'CorpTNARScrubsReport.csv'
																															 ,
																															 ,
																															 ,Corp2.Email_Notification_Lists.spray);

		AR_Badrecords				 		:= AR_N.ExpandedInFile(	
																									 corp_key_Invalid							  			<> 0 or
																									 corp_vendor_Invalid 									<> 0 or
																									 corp_state_origin_Invalid 					 	<> 0 or
																									 corp_process_date_Invalid						<> 0 or
																									 corp_sos_charter_nbr_Invalid 				<> 0 or
																									 ar_year_Invalid 											<> 0 or
																									 ar_due_dt_Invalid	 									<> 0 or
																									 ar_filed_dt_Invalid	 								<> 0 or
																									 ar_report_dt_Invalid 								<> 0 or
																									 ar_exempt_Invalid 										<> 0
																									);
																								 																	
		AR_Goodrecords				 := AR_N.ExpandedInFile(
																									corp_key_Invalid							  			= 0 and
																									corp_vendor_Invalid 									= 0 and
																									corp_state_origin_Invalid 					 	= 0 and
																									corp_process_date_Invalid						  = 0 and
																									corp_sos_charter_nbr_Invalid 					= 0 and
																									ar_year_Invalid 											= 0 and
																									ar_due_dt_Invalid	 										= 0 and
																									ar_filed_dt_Invalid	 									= 0 and
																									ar_report_dt_Invalid 									= 0 and
																									ar_exempt_Invalid 										= 0
																								 );
	
		AR_FailBuild					 := if(count(AR_Goodrecords) = 0,true,false);

		AR_Approvedrecords		 := project(AR_Goodrecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));

		AR_ALL								 := sequential(if(count(AR_Badrecords) <> 0
																					 ,if(poverwrite
																							,output(AR_Badrecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_tn',overwrite,__compressed__)
																							,output(AR_Badrecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_tn',__compressed__)
																							)
																					 )
																				,output(AR_ScrubsWithExamples, all, named('CorpARTNScrubsReportWithExamples'+filedate))
																				//Send Alerts if Scrubs exceeds thresholds
																				,if(count(AR_ScrubsAlert) > 0, AR_MailFile, output('CORP2_MAPPING.TN - No "AR" Corp Scrubs Alerts'))
																				,AR_ErrorSummary
																				,AR_ScrubErrorReport
																				,AR_SomeErrorValues		
																				,AR_SubmitStats
																			 );

		//********************************************************************
		// SCRUB MAIN
		//********************************************************************		
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_TN_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_TN'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_TN'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_TN'+filedate));
		Main_IsScrubErrors		 		:= if(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//outputs files
		Main_CreateBitmaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_tn_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitmap			:= output(Main_T);

    //Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_TN_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_TN_Main').SubmitStats;

		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_TN_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_TN_Main').CompareToProfile_with_Examples;
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(Corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_TN Report' //subject
																																 ,'Scrubs CorpMain_TN Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpTNMainScrubsReport.csv'
																																 ,
																																 ,
																																 ,Corp2.Email_Notification_Lists.spray);

		Main_Badrecords					:= Main_N.ExpandedInFile(	
																										 dt_vendor_first_reported_Invalid 			<> 0 or
																										 dt_vendor_last_reported_Invalid 				<> 0 or
																										 dt_first_seen_Invalid 									<> 0 or
																										 dt_last_seen_Invalid 									<> 0 or
																										 corp_ra_dt_first_seen_Invalid 					<> 0 or
																										 corp_ra_dt_last_seen_Invalid 					<> 0 or
																										 corp_key_Invalid 											<> 0 or
																										 corp_vendor_Invalid 										<> 0 or
																										 corp_state_origin_Invalid 					 		<> 0 or
																										 corp_process_date_Invalid						  <> 0 or
																										 corp_orig_sos_charter_nbr_Invalid 			<> 0 or
																										 corp_legal_name_Invalid 								<> 0 or
																										 corp_ln_name_type_cd_Invalid						<> 0 or
																										 corp_ln_name_type_desc_Invalid					<> 0 or
																										 corp_address1_type_cd_Invalid					<> 0 or
																										 corp_address1_type_desc_Invalid				<> 0 or
																										 corp_inc_state_Invalid									<> 0 or
																										 corp_inc_date_Invalid 									<> 0 or
																										 corp_term_exist_cd_Invalid							<> 0 or
																										 corp_term_exist_exp_Invalid						<> 0 or
																										 corp_term_exist_desc_Invalid						<> 0 or
																										 corp_foreign_domestic_ind_Invalid			<> 0 or
																										 corp_forgn_state_cd_Invalid 						<> 0 or
																										 corp_forgn_state_desc_Invalid 					<> 0 or
																										 corp_orig_org_structure_desc_Invalid		<> 0 or
																										 corp_forgn_date_Invalid 								<> 0 or
																										 corp_for_profit_ind_Invalid						<> 0 or
																										 corp_ra_address_type_cd_Invalid				<> 0 or
																										 corp_ra_address_type_desc_Invalid			<> 0 or
																										 recordorigin_Invalid										<> 0																														
																									  );
																										 																	
		Main_Goodrecords				:= Main_N.ExpandedInFile(	
																										 dt_vendor_first_reported_Invalid 			= 0 and
																										 dt_vendor_first_reported_Invalid 			= 0 and
																										 dt_vendor_last_reported_Invalid 				= 0 and
																										 dt_first_seen_Invalid 									= 0 and
																										 dt_last_seen_Invalid 									= 0 and
																										 corp_ra_dt_first_seen_Invalid 					= 0 and
																										 corp_ra_dt_last_seen_Invalid 					= 0 and
																										 corp_key_Invalid 											= 0 and
																										 corp_vendor_Invalid 										= 0 and
																										 corp_state_origin_Invalid 					 		= 0 and
																										 corp_process_date_Invalid						  = 0 and
																										 corp_orig_sos_charter_nbr_Invalid 			= 0 and
																										 corp_legal_name_Invalid 								= 0 and
																										 corp_ln_name_type_cd_Invalid						= 0 and
																										 corp_ln_name_type_desc_Invalid					= 0 and
																										 corp_address1_type_cd_Invalid					= 0 and
																										 corp_address1_type_desc_Invalid				= 0 and
																										 corp_inc_state_Invalid									= 0 and
																										 corp_inc_date_Invalid 									= 0 and
																										 corp_term_exist_cd_Invalid							= 0 and
																										 corp_term_exist_exp_Invalid						= 0 and
																										 corp_term_exist_desc_Invalid						= 0 and
																										 corp_foreign_domestic_ind_Invalid			= 0 and
																										 corp_forgn_state_cd_Invalid 						= 0 and
																										 corp_forgn_state_desc_Invalid 					= 0 and
																										 corp_orig_org_structure_desc_Invalid		= 0 and
																										 corp_forgn_date_Invalid 								= 0 and
																										 corp_for_profit_ind_Invalid						= 0 and
																										 corp_ra_address_type_cd_Invalid				= 0 and
																										 corp_ra_address_type_desc_Invalid			= 0 and
																										 recordorigin_Invalid										= 0	
																										);

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_TN_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_TN_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 				> Scrubs_Corp2_Mapping_TN_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_TN_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_TN_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
																		count(Main_Goodrecords) = 0																																																																																											 => true,
																		false
																	);

		Main_Approvedrecords		:= project(Main_Goodrecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));


		Main_ALL		 						:= sequential(if(count(Main_Badrecords) <> 0
																						,if(poverwrite
																							 ,output(Main_Badrecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_tn',overwrite,__compressed__)
																							 ,output(Main_Badrecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_tn',__compressed__)
																							 )
																						)
																				,output(Main_ScrubsWithExamples, all, named('CorpMainTNScrubsReportWithExamples'+filedate))
																				//Send Alerts if Scrubs exceeds thresholds
																				,if(count(Main_ScrubsAlert) > 0, Main_MailFile, output('CORP2_MAPPING.TN - No "MAIN" Corp Scrubs Alerts'))
																				,Main_ErrorSummary
																				,Main_ScrubErrorReport
																				,Main_SomeErrorValues	
																				,Main_SubmitStats
																		);
						
		//********************************************************************
		// SCRUB STOCK
		//********************************************************************	
		Stock_F := MapStock;
		Stock_S := Scrubs_Corp2_Mapping_TN_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//outputs reports
		Stock_ErrorSummary			 		:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_TN'+filedate));
		Stock_ScrubErrorReport 	 		:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_TN'+filedate));
		Stock_SomeErrorValues		 		:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_TN'+filedate));
		Stock_IsScrubErrors		 	 		:= if(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats				 		:= Stock_U.OrbitStats();

		//outputs files
		Stock_CreateBitmaps					:= output(Stock_N.BitmapInfile,,'~thor_data::corp_tn_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitmap				:= output(Stock_T);

    //Submits Profile's stats to Orbit
    Stock_SubmitStats           := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_TN_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_TN_Stock').SubmitStats;

		Stock_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_TN_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_TN_Stock').CompareToProfile_with_Examples;
		Stock_ScrubsAlert						:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment			:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile							:= FileServices.SendEmailAttachData(Corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpStock_TN Report' //subject
																																	 ,'Scrubs CorpStock_TN Report' //body
																																	 ,(data)Stock_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpTNEventScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,Corp2.Email_Notification_Lists.spray);

		Stock_Badrecords						:= Stock_N.ExpandedInFile(	
																													corp_key_Invalid							  			<> 0 or
																													corp_vendor_Invalid 									<> 0 or
																													corp_state_origin_Invalid 					 	<> 0 or
																													corp_process_date_Invalid						  <> 0 or
																													corp_sos_charter_nbr_Invalid					<> 0 or
																													stock_type_Invalid	 									<> 0 or
																													stock_shares_issued_Invalid	 					<> 0
																												);

		Stock_Goodrecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  				= 0 and
																												corp_vendor_Invalid 										= 0 and
																												corp_state_origin_Invalid 					 		= 0 and
																												corp_process_date_Invalid						  	= 0 and
																												corp_sos_charter_nbr_Invalid						= 0 and
																												stock_type_Invalid	 										= 0 and
																												stock_shares_issued_Invalid							= 0
																											 );	
		
		Stock_FailBuild						:= if(count(Stock_Goodrecords) = 0,true,false);

		Stock_Approvedrecords			:= project(Stock_Goodrecords,transform(Corp2_Mapping.LayoutsCommon.Stock,self := left));

		Stock_ALL									:= sequential(if(count(Stock_Badrecords) <> 0
																							,if(poverwrite
																								 ,output(Stock_Badrecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_tn',overwrite,__compressed__)
																								 ,output(Stock_Badrecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_tn',__compressed__)
																								 )
																					 )
																					,output(Stock_ScrubsWithExamples, all, named('CorpStockTNScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,if(count(Stock_ScrubsAlert) > 0, Stock_MailFile, output('CORP2_MAPPING.TN - No "Stock" Corp Scrubs Alerts'))
																					,Stock_ErrorSummary
																					,Stock_ScrubErrorReport
																					,Stock_SomeErrorValues	
																					,Stock_SubmitStats
																					);
																					
		//********************************************************************
		// UPDATE
		//********************************************************************	
		Fail_Build						:= if(AR_FailBuild = true or Main_FailBuild = true or Stock_FailBuild = true,true,false);
		IsScrubErrors					:= if(AR_IsScrubErrors = true or Main_IsScrubErrors = true or Stock_IsScrubErrors = true,true,false);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::AR_' 		+ state_origin, AR_Approvedrecords		, write_ar,,,pOverwrite); 
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_Approvedrecords	, write_main,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Stock_' 	+ state_origin, Stock_Approvedrecords	, write_stock,,,pOverwrite);

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::AR_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite); 
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Stock_' 	+ state_origin, Stock_F	, write_fail_stock,,,pOverwrite);

		mapTN := sequential (if(pShouldSpray = true,Corp2_Mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
												,AR_All
												,Main_All
												,Stock_All
												,if(fail_Build <> true	 
													 ,sequential (write_ar
																			 ,write_main
																			 ,write_stock
																			 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::ar'			,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_'		+state_origin)
																			 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																			 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_'	+state_origin)
																			 ,if (count(Main_Badrecords) <> 0 or count(AR_Badrecords) <> 0 or count(Stock_Badrecords)<>0
																					 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_Badrecords)<>0,count(AR_Badrecords)<>0,,count(Stock_Badrecords)<>0,count(Main_Badrecords),count(AR_Badrecords),,count(Stock_Badrecords),count(Main_Approvedrecords),count(AR_Approvedrecords),,count(Stock_Approvedrecords)).recordsRejected																				 
																					 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_Badrecords)<>0,count(AR_Badrecords)<>0,,count(Stock_Badrecords)<>0,count(Main_Badrecords),count(AR_Badrecords),,count(Stock_Badrecords),count(Main_Approvedrecords),count(AR_Approvedrecords),,count(Stock_Approvedrecords)).mappingSuccess																				 
																					 )
																			 ,if (IsScrubErrors
																					 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,,Stock_IsScrubErrors).FieldsInvalidPerScrubs
																					 )
																			 ) //if fail_Build <> true																			
													 ,sequential (write_fail_ar
																			 ,write_fail_main
																			 ,write_fail_stock												 
																			 ,Corp2_Mapping.Send_Email(state_origin,version).mappingfailed
																			 ) //if fail_Build = true
													 )
											);

		isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-60) and ut.date_math(filedate,60),true,false);
		return sequential (if(isFileDateValid
												 ,mapTN
												 ,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																		 ,fail('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																		 )
												 )
											);

		end;	// end of Update function
	
end;
import corp2, corp2_mapping, corp2_raw_nv, scrubs_corp2_mapping_nv_ar, scrubs, scrubs_corp2_mapping_nv_event,
			 scrubs_corp2_mapping_nv_main, scrubs_corp2_mapping_nv_stock, tools, ut, versioncontrol, std;
 
export NV := module 

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function

		state_origin 						:= 'NV';
		state_fips	  					:= '32';	
		state_desc	 						:= 'NEVADA';

		Corporations := dedup(sort(distribute(Corp2_Raw_NV.Files(fileDate,puseprod).input.Corporation.Logical,hash(corp2.t2u(corp_id))),record,local),record,local)(corp2.t2u(corp_type) <> 'COURT-APPOINTED NONRES GUARDIAN OF ADULT') : independent;	
		RA					 := dedup(sort(distribute(Corp2_Raw_NV.Files(fileDate,puseprod).input.RA.Logical,hash(corp2.t2u(ra_id))),record,local),record,local) : independent;
		Officers		 := dedup(sort(distribute(Corp2_Raw_NV.Files(fileDate,puseprod).input.Officers.Logical,hash(corp2.t2u(corp_id))),record,local),record,local) : independent;
		Actions			 := dedup(sort(distribute(Corp2_Raw_NV.Files(fileDate,puseprod).input.Actions.Logical,hash(corp2.t2u(corp_id))),record,local),record,local) : independent;
		Stock				 := dedup(sort(distribute(Corp2_Raw_NV.Files(fileDate,puseprod).input.Stock.Logical,hash(corp2.t2u(corp_id))),record,local),record,local) : independent;
		TM					 := dedup(sort(distribute(Corp2_Raw_NV.Files(fileDate,puseprod).input.TM.Logical,hash(corp2.t2u(TM_ID))),record,local),record,local) : independent;
		TMActions		 := dedup(sort(distribute(Corp2_Raw_NV.Files(fileDate,puseprod).input.TMActions.Logical,hash(corp2.t2u(EntityID))),record,local),record,local) : independent;
													
		//********************************************************************
		// Map MAIN - CORPORATIONS from Corporations file
		//********************************************************************
		/* Normalize RA file on the three sets of RA info:  RA, Mailing and CRA Authority */							 
	  Corp2_Raw_NV.Layouts.TempNormRALayout normTrf(Corp2_Raw_NV.Layouts.RALayoutIn l, unsigned1 cnt) := transform
	      ,skip ((cnt=2 and corp2.t2u(l.mailing_addr1+l.mailing_addr2+l.mailing_city+l.mailing_st+l.mailing_zip) = '') OR
							 (cnt=2 and corp2.t2u(l.mailing_addr1+l.mailing_addr2+l.mailing_city+l.mailing_st+l.mailing_zip) = corp2.t2u(l.addr1+l.addr2+l.city+l.st+l.zip)) OR
			         (cnt=3 and corp2.t2u(l.cra_authority_name+l.cra_authority_addr1+l.cra_authority_addr2+l.cra_authority_city+l.cra_authority_st+l.cra_authority_zip) = '') OR
							 (cnt=3 and corp2.t2u(l.cra_authority_name+l.cra_authority_addr1+l.cra_authority_addr2+l.cra_authority_city+l.cra_authority_st+l.cra_authority_zip) = corp2.t2u(l.name+l.addr1+l.addr2+l.city+l.st+l.zip)) OR
							 (cnt=3 and corp2.t2u(l.cra_authority_name+l.cra_authority_addr1+l.cra_authority_addr2+l.cra_authority_city+l.cra_authority_st+l.cra_authority_zip) = corp2.t2u(l.name+l.mailing_addr1+l.mailing_addr2+l.mailing_city+l.mailing_st+l.mailing_zip)))	
			self.norm_name    := choose(cnt ,l.name     ,l.name            ,l.cra_authority_name);
			self.norm_addr1   := choose(cnt ,l.addr1    ,l.mailing_addr1   ,l.cra_authority_addr1);  
			self.norm_addr2   := choose(cnt ,l.addr2    ,l.mailing_addr2   ,l.cra_authority_addr2);  															 
			self.norm_city	  := choose(cnt ,l.city  	  ,l.mailing_city    ,l.cra_authority_city);
			self.norm_st      := choose(cnt ,l.st       ,l.mailing_st      ,l.cra_authority_st);
			self.norm_zip     := choose(cnt ,l.zip      ,l.mailing_zip     ,l.cra_authority_zip);
			self.norm_country := choose(cnt ,''         ,l.mailing_country ,'');
			self.norm_phone   := choose(cnt ,l.phone_no ,l.phone_no        ,l.cra_authority_phone);
			self.norm_type    := choose(cnt ,'RA'       ,'MAIL'            ,'CRA'); 
			self			        := l;
		end;
		normRA	:= normalize(RA, 3, normTrf(left, counter))(corp2.t2u(norm_name) <> 'TERMINATED');		
		
		/* Join Corporations with normalized RA */
		CorpWithRA := join(distribute(Corporations, hash(corp2.t2u(ra_id))), normRA,
															corp2.t2u(left.ra_id) = corp2.t2u(right.ra_id),
															transform(Corp2_Raw_NV.Layouts.TempCorpRALayout,
																				self := right; self := left; self := [];),
															left outer, local) : independent;
		
		/* Map MAIN - CORPORATIONS from CorpWithRA */
		Corp2_mapping.LayoutsCommon.Main CorpTrf(Corp2_Raw_NV.Layouts.TempCorpRALayout l) := transform
			self.dt_vendor_first_reported					 := (integer)fileDate;
			self.dt_vendor_last_reported					 := (integer)fileDate;
			self.dt_first_seen										 := (integer)fileDate;
			self.dt_last_seen											 := (integer)fileDate;
			self.corp_ra_dt_first_seen						 := (integer)fileDate;
			self.corp_ra_dt_last_seen							 := (integer)fileDate;			
			self.corp_key 												 := state_fips + '-' + corp2.t2u(l.corp_id);
			self.corp_vendor 											 := state_fips;
			self.corp_state_origin 								 := state_origin;
			self.corp_inc_state 									 := state_origin;
			self.corp_process_date 								 := fileDate;
			self.corp_orig_sos_charter_nbr 				 := corp2.t2u(l.corp_no);
    	self.corp_legal_name 									 := Corp2_Raw_NV.Functions.CleanLegalName(l.corp_name);
			self.corp_ln_name_type_desc 					 := Corp2_Raw_NV.Functions.NameTypeDesc(l.corp_type);
			self.corp_ln_name_type_cd 						 := case(self.corp_ln_name_type_desc, 'LEGAL'=>'01', 'RESERVED'=>'07', '**');
			self.corp_status_desc 								 := Corp2_Raw_NV.Functions.CorpStatusDesc(l.corp_status);
			self.corp_orig_org_structure_desc 		 := Corp2_Raw_NV.Functions.CorpOrigOrgStructureDesc(l.corp_type);	
			self.corp_foreign_domestic_ind 				 := if(corp2.t2u(l.corp_type)[1..7] = 'FOREIGN' ,'F' ,'D');
			self.corp_for_profit_ind 							 := if(regexfind('NONPROFIT',corp2.t2u(l.corp_type)) ,'N' ,'');
			self.corp_status_date 								 := Corp2_mapping.fValidateDate(l.status_changed_dt).PastDate;
			self.corp_status_comment 							 := if(corp2.t2u(l.is_on_admin_hold)='T','IS ON ADMINISTRATIVE HOLD', '');
			self.corp_inc_date 										 := if(corp2.t2u(l.qualifying_state) in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');			
			self.corp_term_exist_exp 							 := Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate;
			self.corp_term_exist_cd 							 := if(self.corp_term_exist_exp <> '','D','');
			self.corp_term_exist_desc 						 := if(self.corp_term_exist_exp <> '','EXPIRATION DATE','');
			self.corp_forgn_state_cd 							 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''] ,corp2.t2u(l.qualifying_state) ,'');
			self.corp_forgn_state_desc 						 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_Raw_NV.Functions.CorpForgnStateDesc(l.qualifying_state),'');
			self.corp_forgn_date									 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');		
			self.corp_country_of_formation				 := Corp2_Raw_NV.Functions.Country_Description(l.qualifying_state);
			self.corp_llc_managed_desc             := if(corp2.t2u(l.managed_by) in ['MANAGERS','MANAGING MEMBER','']
			                                             ,corp2.t2u(l.managed_by) ,'**|'+corp2.t2u(l.managed_by));
			self.corp_internal_nbr                 := corp2.t2u(l.nv_business_id);
			self.corp_ra_resign_date							 := Corp2_mapping.fValidateDate(l.ra_resigned_dt).PastDate;																						 
      self.corp_addl_info										 := if(corp2.t2u(l.managed_by) <> '' ,'MANAGED BY: ' + corp2.t2u(l.managed_by), '') +
																								if(Corp2_Raw_NV.Functions.exemptionCodes(l.exemption_code) <> ''
																									 ,if(corp2.t2u(l.managed_by) <> ''
																									     ,'; '+Corp2_Raw_NV.Functions.exemptionCodes(l.exemption_code)
																											 ,Corp2_Raw_NV.Functions.exemptionCodes(l.exemption_code))
																									 ,''); 
		  self.corp_ra_full_name                 := Corp2_Raw_NV.Functions.cleanName(l.norm_name); 																						 
			self.corp_ra_address_type_cd	 				 := if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.norm_addr1,l.norm_addr2,l.norm_city,l.norm_st,l.norm_zip).ifAddressExists
			                                             ,map(l.norm_type = 'RA'   => 'R',
																									      l.norm_type = 'MAIL' => 'M',
																												l.norm_type = 'CRA'  => 'CR',
																												'')
																									 ,'');		
			self.corp_ra_address_type_desc 				 := case(self.corp_ra_address_type_cd,
			                                               'R'  => 'REGISTERED OFFICE',
																										 'M'  => 'REGISTERED AGENT MAILING ADDRESS',
																										 'CR' => 'COMMERCIAL REGISTERED AGENT AUTHORITY\'S ADDRESS',
																										 '');																					 
      self.corp_ra_address_line1 					 	 := if(self.corp_ra_address_type_cd <> '',Corp2_mapping.fCleanAddress(state_origin,state_desc,l.norm_addr1,l.norm_addr2,l.norm_city,l.norm_st,l.norm_zip,l.norm_country).AddressLine1 ,'');
      self.corp_ra_address_line2 						 := if(self.corp_ra_address_type_cd <> '',Corp2_mapping.fCleanAddress(state_origin,state_desc,l.norm_addr1,l.norm_addr2,l.norm_city,l.norm_st,l.norm_zip,l.norm_country).AddressLine2 ,'');
	    self.corp_ra_address_line3 						 := if(self.corp_ra_address_type_cd <> '',Corp2_mapping.fCleanAddress(state_origin,state_desc,l.norm_addr1,l.norm_addr2,l.norm_city,l.norm_st,l.norm_zip,l.norm_country).AddressLine3 ,'');
      self.ra_prep_addr_line1 						   := if(self.corp_ra_address_type_cd <> '',Corp2_mapping.fCleanAddress(state_origin,state_desc,l.norm_addr1,l.norm_addr2,l.norm_city,l.norm_st,l.norm_zip,l.norm_country).PrepAddrLine1 ,'');
      self.ra_prep_addr_last_line 					 := if(self.corp_ra_address_type_cd <> '',Corp2_mapping.fCleanAddress(state_origin,state_desc,l.norm_addr1,l.norm_addr2,l.norm_city,l.norm_st,l.norm_zip,l.norm_country).PrepAddrLastLine ,'');
			self.corp_agent_county		 						 := corp2.t2u(l.mailing_county); 
			self.corp_ra_phone_number  						 := ut.cleanPhone(l.norm_phone);
			self.corp_ra_fax_nbr									 := ut.cleanPhone(l.fax_no);
      self.corp_ra_email_address 						 := corp2.t2u(l.email_address); 
			self.corp_ra_addl_info                 := if(l.agent_type <> '' ,'AGENT TYPE: ' + corp2.t2u(l.agent_type) ,'');
	    
	    tempCountry := Corp2_Raw_NV.Functions.CountryCodeTable(l.reservation_owner_country);
			self.corp_address1_type_cd					 	 := if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2,l.reservation_owner_city,l.reservation_owner_st,l.reservation_owner_zip,tempCountry).ifAddressExists,'B','');
			self.corp_address1_type_desc					 := if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2,l.reservation_owner_city,l.reservation_owner_st,l.reservation_owner_zip,tempCountry).ifAddressExists,'BUSINESS','');
			self.corp_address1_line1 							 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2,l.reservation_owner_city,l.reservation_owner_st,l.reservation_owner_zip,tempCountry).AddressLine1;
      self.corp_address1_line2 							 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2,l.reservation_owner_city,l.reservation_owner_st,l.reservation_owner_zip,tempCountry).AddressLine2;
      self.corp_address1_line3             	 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2,l.reservation_owner_city,l.reservation_owner_st,l.reservation_owner_zip,tempCountry).AddressLine3;
			self.corp_prep_addr1_line1 						 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2,l.reservation_owner_city,l.reservation_owner_st,l.reservation_owner_zip,tempCountry).PrepAddrLine1;
			self.corp_prep_addr1_last_line 				 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2,l.reservation_owner_city,l.reservation_owner_st,l.reservation_owner_zip,tempCountry).PrepAddrLastLine;			
			self.recordorigin											 := 'C';
			self 																	 := [];
		end;

		MapCorp := project(CorpWithRA,CorpTrf(left));	
														
		//********************************************************************
		// Map MAIN - CORPORATIONS from Corporations file for Foreign Names
		//********************************************************************											
	  Corp2_mapping.LayoutsCommon.Main CorpFTrf(Corp2_Raw_NV.Layouts.CorporationsLayoutIn l) := transform,
		 skip(Corp2_Raw_NV.Functions.CleanLegalName(Corp2_Raw_NV.Functions.cleanForeignName(l.corp_foreign_name)) = '')
			self.dt_vendor_first_reported					 := (integer)fileDate;
			self.dt_vendor_last_reported					 := (integer)fileDate;
			self.dt_first_seen										 := (integer)fileDate;
			self.dt_last_seen											 := (integer)fileDate;
			self.corp_ra_dt_first_seen						 := (integer)fileDate;
			self.corp_ra_dt_last_seen							 := (integer)fileDate;			
			self.corp_key 												 := state_fips + '-' + corp2.t2u(l.corp_id);
			self.corp_vendor 											 := state_fips;
			self.corp_state_origin 								 := state_origin;
			self.corp_inc_state 									 := state_origin;
			self.corp_process_date 								 := fileDate;
			self.corp_orig_sos_charter_nbr 				 := corp2.t2u(l.corp_no);
    	self.corp_legal_name 									 := Corp2_Raw_NV.Functions.CleanLegalName(Corp2_Raw_NV.Functions.cleanForeignName(l.corp_foreign_name));
			self.corp_ln_name_type_cd 						 := '10';		
			self.corp_ln_name_type_desc 					 := 'FOREIGN';
			self.corp_inc_date 										 := if(corp2.t2u(l.qualifying_state) in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');			
	    self.corp_forgn_date									 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');		
			self.recordorigin											 := 'C';
			self 																	 := l;
			self 																	 := [];
		end;												
		MapCorpForeignNames	:= project(Corporations,CorpFTrf(left));
														
		//********************************************************************
		// Map MAIN - CORPORATIONS from TM file (Trademarks)
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main CorpTMTrf(Corp2_Raw_NV.Layouts.TMLayoutIn l) := transform
			self.dt_vendor_first_reported					 := (integer)fileDate;
			self.dt_vendor_last_reported					 := (integer)fileDate;
			self.dt_first_seen										 := (integer)fileDate;
			self.dt_last_seen											 := (integer)fileDate;
			self.corp_ra_dt_first_seen						 := (integer)fileDate;
			self.corp_ra_dt_last_seen							 := (integer)fileDate;			
			self.corp_key 												 := state_fips + '-' + corp2.t2u(l.tm_id);
			self.corp_vendor 											 := state_fips;
			self.corp_state_origin 								 := state_origin;
			self.corp_inc_state 									 := state_origin;
			self.corp_process_date 								 := fileDate;
			self.corp_orig_sos_charter_nbr 				 := corp2.t2u(l.Trademark_Number);
   		self.corp_legal_name 									 := Corp2_Raw_NV.Functions.CleanLegalName(l.trademark_name);
			self.corp_ln_name_type_cd 					   := case(corp2.t2u(l.trademark_type),
																											'TRADEMARK'    => '03',
																											'TRADE NAME'   => '04',
																											'SERVICE MARK' => '05',
																											'**');
			self.corp_ln_name_type_desc 					 := case(corp2.t2u(l.trademark_type),
																											'TRADEMARK'    => 'TRADEMARK',
																											'TRADE NAME'   => 'TRADENAME',
																											'SERVICE MARK' => 'SERVICEMARK',
																											'**|'+ corp2.t2u(l.trademark_type));
			self.corp_filing_date                  := Corp2_mapping.fValidateDate(l.Creation_Date).PastDate;
			self.corp_status_date 								 := Corp2_mapping.fValidateDate(l.Status_Changed_Date).PastDate;
			self.corp_status_comment               := if(corp2.t2u(l.IsOnAdminHold) = 'T' ,'IS ON ADMINISTRATIVE HOLD' ,'');
			self.corp_term_exist_exp 							 := Corp2_mapping.fValidateDate(l.Expired_Date).GeneralDate;
			self.corp_term_exist_cd 							 := if(self.corp_term_exist_exp <> '','D','');
			self.corp_term_exist_desc 						 := if(self.corp_term_exist_exp <> '','EXPIRATION DATE','');
			self.corp_forgn_state_cd 							 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''] ,corp2.t2u(l.qualifying_state) ,'');
			self.corp_forgn_state_desc 						 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_Raw_NV.Functions.CorpForgnStateDesc(l.qualifying_state),'');
			self.corp_trademark_class_desc1        := Corp2_Raw_NV.Functions.TMClass(l.Classification_Code);
			self.corp_status_desc                  := if(corp2.t2u(l.trademark_status) in ['ACTIVE','CANCELLED','EXPIRED','ADMINISTRATIVE HOLD','']
			                                            ,corp2.t2u(l.trademark_status) ,'**|'+corp2.t2u(l.trademark_status));
			self.corp_trademark_status             := case(corp2.t2u(l.trademark_status),
																											'ACTIVE' 							=> 'A',
																											'CANCELLED'						=> 'C',
																											'EXPIRED' 						=> 'E',
																											'ADMINISTRATIVE HOLD' => 'H',
																											'');
			self.corp_trademark_filing_date        := Corp2_mapping.fValidateDate(l.Creation_Date).PastDate;
			self.corp_trademark_expiration_date    := Corp2_mapping.fValidateDate(l.Expired_Date).GeneralDate;
			self.recordorigin											 := 'C';
			self 																	 := [];
		end;

		MapCorpTM := project(TM,CorpTMTrf(left));
		
		//********************************************************************
		// Map MAIN - CONTACTS from Corporations file  
		//********************************************************************		
		Corp2_mapping.LayoutsCommon.Main ContCorpTrf(Corp2_Raw_NV.Layouts.CorporationsLayoutIn l) := transform,
		 skip(Corp2_Raw_NV.Functions.cleanName(l.reservation_owner_name) = '') 
			self.dt_vendor_first_reported					 := (integer)fileDate;
			self.dt_vendor_last_reported					 := (integer)fileDate;
			self.dt_first_seen										 := (integer)fileDate;
			self.dt_last_seen											 := (integer)fileDate;
			self.corp_ra_dt_first_seen						 := (integer)fileDate;
			self.corp_ra_dt_last_seen							 := (integer)fileDate;			
			self.corp_key 												 := state_fips + '-' + corp2.t2u(l.corp_id);
			self.corp_vendor 											 := state_fips;
			self.corp_state_origin 								 := state_origin;
			self.corp_inc_state 									 := state_origin;
			self.corp_process_date 								 := fileDate;
			self.corp_orig_sos_charter_nbr 				 := corp2.t2u(l.corp_no);
			self.corp_legal_name 									 := Corp2_Raw_NV.Functions.CleanLegalName(l.corp_name);
			self.cont_type_cd		 									 := 'O';
			self.cont_type_desc 									 := 'OWNER';																				
			self.cont_full_name										 := Corp2_Raw_NV.Functions.cleanName(l.reservation_owner_name);
			self.recordorigin											 := 'T';
			self 																	 := [];
		end;
		
		MapContCorp	:= project(Corporations,ContCorpTrf(left))(cont_full_name <> '');

		//********************************************************************
		// Map MAIN - CONTACTS from Officers file  
		//********************************************************************	
		/* Join Officers with Corporations */
		OfficersWithCorp := join(Officers, Corporations,
															corp2.t2u(left.corp_id) = corp2.t2u(right.corp_id),
															transform(Corp2_Raw_NV.Layouts.TempOfficersCorpLayout,
																				self := right; self := left; self := [];),
															inner, local) : independent;
		
		/* Map MAIN - CONTACTS from OfficersWithCorp */
		Corp2_mapping.LayoutsCommon.Main ContOffTrf(Corp2_Raw_NV.Layouts.TempOfficersCorpLayout l) := transform,
		 skip(corp2.t2u(l.last_name + l.first_name + l.middle_initial) = '')
				self.dt_vendor_first_reported					 := (integer)fileDate;
				self.dt_vendor_last_reported					 := (integer)fileDate;
				self.dt_first_seen										 := (integer)fileDate;
				self.dt_last_seen											 := (integer)fileDate;
				self.corp_ra_dt_first_seen						 := (integer)fileDate;
				self.corp_ra_dt_last_seen							 := (integer)fileDate;			
				self.corp_key 												 := state_fips + '-' + corp2.t2u(l.corp_id);
				self.corp_vendor 											 := state_fips;
				self.corp_state_origin 								 := state_origin;
				self.corp_inc_state 									 := state_origin;
				self.corp_process_date 								 := fileDate;
				self.corp_orig_sos_charter_nbr 				 := corp2.t2u(l.corp_no);
				self.corp_legal_name 									 := Corp2_Raw_NV.Functions.CleanLegalName(l.corp_name);
				self.cont_type_cd		 									 := if(corp2.t2u(l.officer_type) <> '' ,'T' ,'');
				self.cont_type_desc 									 := if(corp2.t2u(l.officer_type) <> '' ,'CONTACT' ,'');		
			  self.cont_fname												 := Corp2_Raw_NV.Functions.cleanName(l.first_name);
        self.cont_mname												 := Corp2_Raw_NV.Functions.cleanName(l.middle_initial);
        self.cont_lname												 := Corp2_Raw_NV.Functions.cleanName(l.last_name);
			  self.cont_full_name										 := corp2.t2u(self.cont_fname+' '+self.cont_mname+' '+self.cont_lname);
				self.cont_title1_desc                  := Corp2_Raw_NV.Functions.ContTitle(l.officer_type);
				self.cont_status_cd 									 := map(corp2.t2u(l.inactive) 		= 'T' 	=> 'T',
																											corp2.t2u(l.terminated) 	= 'T' 	=> 'T',
																											corp2.t2u(l.resigned) 		= 'T' 	=> 'T',
																											'');
				self.cont_status_desc 								 := map(corp2.t2u(l.inactive) 		= 'T' 	=> 'INACTIVE',
																											corp2.t2u(l.terminated)		= 'T' 	=> 'TERMINATED',
																											corp2.t2u(l.resigned) 		= 'T' 	=> 'RESIGNED',
																											'ACTIVE');
				tempCountry := Corp2_Raw_NV.Functions.CountryCodeTable(l.country);
				self.cont_address_type_cd					 		 := if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip,tempCountry).ifAddressExists,'T','');
				self.cont_address_type_desc						 := if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip,tempCountry).ifAddressExists,'CONTACT','');
				self.cont_address_line1 							 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip,tempCountry).AddressLine1;
				self.cont_address_line2 							 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip,tempCountry).AddressLine2;
				self.cont_address_line3             	 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip,tempCountry).AddressLine3;
				self.cont_prep_addr_line1 						 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip,tempCountry).PrepAddrLine1;
				self.cont_prep_addr_last_line 				 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip,tempCountry).PrepAddrLastLine;			
				self.cont_address_county               := corp2.t2u(l.county);
				self.cont_country                      := tempCountry;
				self.cont_email_address                := corp2.t2u(l.email_address);
				self.recordorigin											 := 'T';
				self 																	 := [];
		end;
		
		MapContOfficers	:= project(OfficersWithCorp,ContOffTrf(left))(cont_full_name <> '');
	
		//********************************************************************
		// Map MAIN - CONTACTS from TM file (Trademarks)  
		//********************************************************************		
		Corp2_mapping.LayoutsCommon.Main ContTMTrf(Corp2_Raw_NV.Layouts.TMLayoutIn l) := transform,
		 skip(Corp2_Raw_NV.Functions.cleanName(l.reservation_owner_name) = '')
				self.dt_vendor_first_reported					 := (integer)fileDate;
				self.dt_vendor_last_reported					 := (integer)fileDate;
				self.dt_first_seen										 := (integer)fileDate;
				self.dt_last_seen											 := (integer)fileDate;
				self.corp_ra_dt_first_seen						 := (integer)fileDate;
				self.corp_ra_dt_last_seen							 := (integer)fileDate;			
				self.corp_key 												 := state_fips + '-' + corp2.t2u(l.tm_id);
				self.corp_vendor 											 := state_fips;
				self.corp_state_origin 								 := state_origin;
				self.corp_inc_state 									 := state_origin;
				self.corp_process_date 								 := fileDate;
				self.corp_orig_sos_charter_nbr 				 := corp2.t2u(l.Trademark_Number);
				self.corp_legal_name 									 := Corp2_Raw_NV.Functions.CleanLegalName(l.trademark_name);
				self.cont_type_cd		 									 := 'O';
				self.cont_type_desc 									 := 'OWNER';																			
				self.cont_full_name										 := Corp2_Raw_NV.Functions.cleanName(l.reservation_owner_name);
	
				tempCountry := Corp2_Raw_NV.Functions.CountryCodeTable(l.reservation_owner_country);
		    self.cont_address_type_cd					 		 := if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.reservation_owner_address_1 + ' ' + l.reservation_owner_address_2,,l.reservation_owner_city,l.reservation_owner_state,l.reservation_owner_zip,tempCountry).ifAddressExists,'T','');
				self.cont_address_type_desc						 := if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.reservation_owner_address_1 + ' ' + l.reservation_owner_address_2,,l.reservation_owner_city,l.reservation_owner_state,l.reservation_owner_zip,tempCountry).ifAddressExists,'CONTACT','');
				self.cont_address_line1 							 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_address_1 + ' ' + l.reservation_owner_address_2,,l.reservation_owner_city,l.reservation_owner_state,l.reservation_owner_zip,tempCountry).AddressLine1;
				self.cont_address_line2 							 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_address_1 + ' ' + l.reservation_owner_address_2,,l.reservation_owner_city,l.reservation_owner_state,l.reservation_owner_zip,tempCountry).AddressLine2;
				self.cont_address_line3             	 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_address_1 + ' ' + l.reservation_owner_address_2,,l.reservation_owner_city,l.reservation_owner_state,l.reservation_owner_zip,tempCountry).AddressLine3;
				self.cont_prep_addr_line1 						 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_address_1 + ' ' + l.reservation_owner_address_2,,l.reservation_owner_city,l.reservation_owner_state,l.reservation_owner_zip,tempCountry).PrepAddrLine1;
				self.cont_prep_addr_last_line 				 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_address_1 + ' ' + l.reservation_owner_address_2,,l.reservation_owner_city,l.reservation_owner_state,l.reservation_owner_zip,tempCountry).PrepAddrLastLine;					
				self.cont_country                      := tempCountry;
				self.recordorigin											 := 'T';
				self 																	 := [];
		end;
		
		MapContTM	:= project(TM,ContTMTrf(left))(cont_full_name <> '');

		MapMain	:= dedup(sort(distribute(
												MapCorp + MapCorpForeignNames + MapCorpTM + MapContCorp + MapContOfficers + MapContTM
										,hash(corp_key)),record,local),record,local) : independent;
	
		//********************************************************************	
		// Map STOCK
		//******************************************************************** 
		/* Join Stock with Corporations */
		CorpWithStock := join(Corporations, Stock,
													corp2.t2u(left.corp_id) = corp2.t2u(right.corp_id),
													transform(Corp2_Raw_NV.Layouts.TempStockCorpLayout,
																		self := left; self := right; self := [];),
													left outer, local) : independent;	
		
		BOOLEAN _is_valid (string pStockAttr) := if(corp2.t2u(stringlib.stringFilterOut(pStockAttr,'.0'))<>'',true,false); 
    
		/* Map STOCK from CorpWithStock */
		Corp2_mapping.LayoutsCommon.Stock StockTrf(Corp2_Raw_NV.Layouts.TempStockCorpLayout L) := transform,
	   skip(corp2.t2u(l.corp_id) = '' or corp2.t2u(l.corp_no) = '' or
		      corp2.t2u(stringlib.stringFilterOut(corp2.t2u(l.no_par_share_count + l.par_share_value + l.par_share_count + l.capital_amt),'.0'))='')
			self.corp_key							:= state_fips + '-' + corp2.t2u(l.corp_id);		
			self.corp_vendor 					:= state_fips;
			self.corp_state_origin 		:= state_origin;
			self.corp_process_date 		:= fileDate;
			self.corp_sos_charter_nbr := corp2.t2u(l.corp_no);
			self.stock_authorized_nbr	:= if(_is_valid(l.no_par_share_count),Corp2_Raw_NV.Functions.FormatNumericValues(l.no_par_share_count,true),'');
			self.stock_par_value 			:= if(_is_valid(Corp2_Raw_NV.Functions.FormatNumericValues(l.par_share_value)),Corp2_Raw_NV.Functions.FormatNumericValues(l.par_share_value,true),''); 		
      self.stock_nbr_par_shares := if(_is_valid(l.par_share_count),Corp2_Raw_NV.Functions.FormatNumericValues(l.par_share_count,false),'');
		  self.stock_total_capital 	:= if(_is_valid(l.capital_amt),Corp2_Raw_NV.Functions.FormatNumericValues(l.capital_amt,true),'');
			self											:= l;
			self 											:= [];
    end;

		MapStock 	:= dedup(sort(distribute(project(CorpwithStock,StockTrf(left)),hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************	
		// Map AR from Actions file
		//******************************************************************** 
		/* Join Actions with Corporations */
		CorpWithActions := join(Corporations, Actions,
													corp2.t2u(left.corp_id) = corp2.t2u(right.corp_id),
													transform(Corp2_Raw_NV.Layouts.TempActionsLayout,
																		self := right; self := left; self := [];),
													left outer, local) : independent;
													
		// ** Mapping from the Actions file in two separate transforms.  First time through, only AR_DUE_DT will be mapped.
		//    Then in the second transform, the other AR fields will be mapped.  This is necessary so that the records
		//    will display properly online **
		
		/* Transform #1 - Map AR from CorpWithActions -- ar_due_dt only */
		Corp2_mapping.LayoutsCommon.AR AR1Trf(Corp2_Raw_NV.Layouts.TempActionsLayout L) := transform,
		 skip(corp2.t2u(l.corp_id) = '' or corp2.t2u(l.corp_no) = '' or
		      corp2.t2u(l.action_type) not in ['ANNUAL LIST'] or
					Corp2_mapping.fValidateDate(l.annual_lo_due_dt).GeneralDate = '')
			self.corp_key							:= state_fips + '-' + corp2.t2u(l.corp_id);		
			self.corp_vendor 					:= state_fips;
			self.corp_state_origin 		:= state_origin;
			self.corp_process_date 		:= fileDate;
			self.corp_sos_charter_nbr := corp2.t2u(l.corp_no);
			self.ar_due_dt						:= Corp2_mapping.fValidateDate(l.annual_lo_due_dt).GeneralDate;
			self											:= l;
			self 											:= [];
    end;

    MapAR1 := project(CorpwithActions,AR1Trf(left));
	
		/* Transform #2 - Map AR from CorpWithActions -- WITHOUT ar_due_dt */
		Corp2_mapping.LayoutsCommon.AR AR2Trf(Corp2_Raw_NV.Layouts.TempActionsLayout L) := transform,
		 skip(corp2.t2u(l.corp_id) = '' or corp2.t2u(l.corp_no) = '' or
					corp2.t2u(l.action_type) not in ['ANNUAL LIST'] or
		      corp2.t2u(l.action_dt + l.document_no + l.action_notes + l.action_type) = '')
			self.corp_key							:= state_fips + '-' + corp2.t2u(l.corp_id);		
			self.corp_vendor 					:= state_fips;
			self.corp_state_origin 		:= state_origin;
			self.corp_process_date 		:= fileDate;
			self.corp_sos_charter_nbr := corp2.t2u(l.corp_no);
			self.ar_filed_dt 					:= Corp2_mapping.fValidateDate(l.action_dt).PastDate;
			self.ar_report_nbr 				:= corp2.t2u(l.document_no);
			self.ar_comment 					:= regexreplace('(\\-)+',corp2.t2u(l.action_notes),'-');
			self.ar_type 							:= corp2.t2u(l.action_type);
			self											:= l;
			self 											:= [];
    end;

    MapAR2 := project(CorpwithActions,AR2Trf(left));
		
	  MapAR := dedup(sort(distribute(MapAR1 + MapAR2,hash(corp_key)),record,local),record,local) : independent;	
		
		//********************************************************************
		// Map EVENTS from Actions file
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Events EventsTrf(Corp2_Raw_NV.Layouts.TempActionsLayout L ,unsigned1 ctr) := transform,
		 skip(corp2.t2u(l.corp_id) = '' or corp2.t2u(l.corp_no) = '' or
		      corp2.t2u(l.action_type) in ['ANNUAL LIST'] or
		      (ctr=1 and Corp2_mapping.fValidateDate(l.action_dt).PastDate = '' and corp2.t2u(l.action_type + l.action_notes) = '') or
					(ctr=2 and Corp2_mapping.fValidateDate(l.effective_dt).GeneralDate = ''))
			self.corp_key							      := state_fips + '-' + corp2.t2u(l.corp_id);		
			self.corp_vendor 					      := state_fips;
			self.corp_state_origin 		      := state_origin;
			self.corp_process_date 		      := fileDate;
			self.corp_sos_charter_nbr       := corp2.t2u(l.corp_no);
			self.event_filing_reference_nbr := corp2.t2u(l.document_no);				
			self.event_filing_date 					:= choose(ctr, Corp2_mapping.fValidateDate(l.action_dt).PastDate,
																								     Corp2_mapping.fValidateDate(l.effective_dt).GeneralDate);		
			self.event_date_type_cd					:= if(self.event_filing_date <> '' ,choose(ctr, 'FIL', 'EFF') ,'');
			self.event_date_type_desc				:= if(self.event_filing_date <> '' ,choose(ctr, 'FILING', 'EFFECTIVE') ,'');
			self.event_filing_desc 					:= corp2.t2u(l.action_type);
			self.event_desc 								:= regexreplace('(\\-)+',corp2.t2u(l.action_notes),'-');
			self 													 := []; 
		end;

		MapActionsEvent := Normalize(CorpwithActions ,2 ,EventsTrf(left, counter));
		
		//********************************************************************
		// Map EVENTS from TM Actions file (Trademark Actions)
		//********************************************************************
		/* Join TM Actions with Trademark */
		TMwithTMActions := join(TM, TMActions,
													corp2.t2u(left.tm_id) = corp2.t2u(right.entityid),
													transform(Corp2_Raw_NV.Layouts.TempTMActionsLayout,
																		self := right; self := left; self := [];),
													left outer, local) : independent;	
		
		Corp2_mapping.LayoutsCommon.Events TMEventsTrf(Corp2_Raw_NV.Layouts.TempTMActionsLayout L) := transform,
		 skip(corp2.t2u(l.tm_id) = '' or corp2.t2u(l.trademark_number) = '' or
		      corp2.t2u(l.document_number + Corp2_mapping.fValidateDate(l.action_date).PastDate + l.action_type + l.action_notes) = '')
			self.corp_key										:= state_fips + '-' + corp2.t2u(l.tm_id);		
			self.corp_vendor 								:= state_fips;
			self.corp_state_origin 					:= state_origin;
			self.corp_process_date 					:= fileDate;
			self.corp_sos_charter_nbr 			:= corp2.t2u(l.trademark_number);
			self.event_filing_reference_nbr := corp2.t2u(l.document_number);				
			self.event_filing_date 					:= Corp2_mapping.fValidateDate(l.action_date).PastDate;			
			self.event_date_type_cd					:= if(self.event_filing_date <> '' ,'FIL' ,'');
			self.event_date_type_desc				:= if(self.event_filing_date <> '' ,'FILING' ,'');
			self.event_desc 								:= corp2.t2u(l.action_type + 
																									 (if(corp2.t2u(l.action_type)<>'' and corp2.t2u(l.action_notes)<>'','; ','')) + 
																									 l.action_notes);
			self 														:= []; 
		end;

		MapTMActionsEvent 	:= project(TMwithTMActions,TMEventsTrf(left));
		
		MapEvent	:= dedup(sort(distribute(MapActionsEvent + MapTMActionsEvent ,hash(corp_key)),record,local),record,local) : independent;

	
		//********************************************************************
		// SCRUB AR 
		//********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_mapping_NV_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//outputs reports
		AR_ErrorSummary			 		:= output(AR_U.SummaryStats, named('AR_ErrorSummary_NV'+filedate));
		AR_ScrubErrorReport 	 	:= output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_NV'+filedate));
		AR_SomeErrorValues		 	:= output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_NV'+filedate));
		AR_IsScrubErrors		 	 	:= if(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 		:= AR_U.OrbitStats();

		//outputs files
		AR_CreateBitmaps			 	:= output(AR_N.BitmapInfile,,'~thor_data::corp_nv_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitmap		 	:= output(AR_T);

		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NV_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_NV_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NV_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_NV_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 	:= AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	 		:= Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					 		:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																															 ,'Scrubs CorpAR_NV Report' //subject
																															 ,'Scrubs CorpAR_NV Report' //body
																															 ,(data)AR_ScrubsAttachment
																															 ,'text/csv'
																															 ,'CorpNVARScrubsReport.csv'
																														);

		AR_Badrecords				 		:= AR_N.ExpandedInFile(	
																									 corp_key_Invalid							  			<> 0 or
																									 corp_vendor_Invalid 									<> 0 or
																									 corp_state_origin_Invalid 					 	<> 0 or
																									 corp_process_date_Invalid						<> 0 or
																									 corp_sos_charter_nbr_Invalid 				<> 0 or
																									 ar_filed_dt_Invalid 									<> 0 or
																									 ar_report_nbr_Invalid	 							<> 0 or
																									 ar_due_dt_Invalid                    <> 0 or
																									 ar_type_Invalid 											<> 0
																									);
																									 																	
		AR_Goodrecords				 := AR_N.ExpandedInFile(
																									corp_key_Invalid							  			= 0 and
																									corp_vendor_Invalid 									= 0 and
																									corp_state_origin_Invalid 					 	= 0 and
																									corp_process_date_Invalid						  = 0 and
																									corp_sos_charter_nbr_Invalid 					= 0 and
																									ar_filed_dt_Invalid 									= 0 and
																									ar_report_nbr_Invalid	 								= 0 and
																									ar_due_dt_Invalid                     = 0 and
																									ar_type_Invalid 											= 0
																								 );

		AR_FailBuild					 := if(count(AR_Goodrecords) = 0,true,false);

		AR_Approvedrecords		 := project(AR_Goodrecords,transform(Corp2_mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 := sequential(if(count(AR_Badrecords) <> 0
																					 ,if (poverwrite
																							 ,output(AR_Badrecords,,Corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_nv',overwrite,__compressed__)
																							 ,output(AR_Badrecords,,Corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_nv',__compressed__)
																							 )
																					 )
																				,output(AR_ScrubsWithExamples, all, named('CorpARNVScrubsReportWithExamples'+filedate))
																				//Send Alerts if Scrubs exceeds thresholds
																				,if(count(AR_ScrubsAlert) > 0, AR_MailFile, output('CORP2_mapPING.NV - No "AR" Corp Scrubs Alerts'))
																				,AR_ErrorSummary
																				,AR_ScrubErrorReport
																				,AR_SomeErrorValues			
																				,AR_SubmitStats
																			 );
																			
		//********************************************************************
		// SCRUB EVENT
		//********************************************************************	
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_mapping_NV_Event.Scrubs;							// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 												// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//outputs reports
		Event_ErrorSummary					:= output(Event_U.SummaryStats, named('Event_ErrorSummary_NV'+filedate));
		Event_ScrubErrorReport 			:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_NV'+filedate));
		Event_SomeErrorValues				:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_NV'+filedate));
		Event_IsScrubErrors		 			:= if(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats						:= Event_U.OrbitStats();

		//outputs files
		Event_CreateBitmaps					:= output(Event_N.BitmapInfile,,'~thor_data::corp_nv_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitmap				:= output(Event_T);

		//Submits Profile's stats to Orbit
		Event_SubmitStats 			 := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NV_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_NV_Event').SubmitStats;
		Event_ScrubsWithExamples := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NV_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_NV_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert						:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment			:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpEvent_NV Report' //subject
																																	 ,'Scrubs CorpEvent_NV Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpNVEventScrubsReport.csv'
																																);

		Event_Badrecords				 		:= Event_N.ExpandedInFile(	
																												  corp_key_Invalid							  			<> 0 or
																												  corp_vendor_Invalid 									<> 0 or																						
																												  corp_state_origin_Invalid 					 	<> 0 or
																												  corp_process_date_Invalid						  <> 0 or
																												  corp_sos_charter_nbr_Invalid 				  <> 0 or
																												  event_filing_reference_nbr_Invalid		<> 0 or																															 
																												  event_filing_date_Invalid						  <> 0 or
																												  event_date_type_cd_Invalid						<> 0 or
																												  event_date_type_desc_Invalid		 			<> 0																															 
																												 );

		Event_Goodrecords						:= Event_N.ExpandedInFile(	
																												  corp_key_Invalid							  			= 0 and
																												  corp_vendor_Invalid 									= 0 and																				
																												  corp_state_origin_Invalid 					 	= 0 and
																												  corp_process_date_Invalid						  = 0 and
																												  corp_sos_charter_nbr_Invalid 				  = 0 and
																												  event_filing_reference_nbr_Invalid		= 0 and																															 
																												  event_filing_date_Invalid		 				  = 0 and
																												  event_date_type_cd_Invalid						= 0 and
																												  event_date_type_desc_Invalid		 			= 0																																
																											   );

		Event_FailBuild					  := if(count(Event_Goodrecords) = 0,true,false);

		Event_Approvedrecords			:= project(Event_Goodrecords,transform(Corp2_mapping.LayoutsCommon.Events,self := left));
		

		Event_ALL									:= sequential(if(count(Event_Badrecords) <> 0
																							,if (poverwrite
																									,output(Event_Badrecords,,Corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_nv',overwrite,__compressed__)
																									,output(Event_Badrecords,,Corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_nv',__compressed__)
																									)
																							)
																					 ,output(Event_ScrubsWithExamples, all, named('CorpEventNVScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,if(count(Event_ScrubsAlert) > 0, Event_MailFile, output('CORP2_mapPING.NV - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues	
																					 ,Event_SubmitStats
																				);

		//********************************************************************
		// SCRUB MAIN
		//********************************************************************		
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_mapping_NV_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_NV'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_NV'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_NV'+filedate));
		Main_IsScrubErrors		 		:= if(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//outputs files
		Main_CreateBitmaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_nv_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitmap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NV_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_NV_Main').SubmitStats;
		Main_ScrubsWithExamples := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NV_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_NV_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpMain_NV Report' //subject
																																 ,'Scrubs CorpMain_NV Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpNVMainScrubsReport.csv'
																																);

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
																										 corp_status_date_Invalid								<> 0 or
																										 corp_status_comment_Invalid						<> 0 or
																										 corp_status_desc_Invalid								<> 0 or
																										 corp_orig_org_structure_desc_Invalid		<> 0 or
																										 corp_filing_date_Invalid								<> 0 or
																										 corp_llc_managed_desc_Invalid					<> 0 or
																										 corp_trademark_expiration_date_Invalid	<> 0 or
																										 corp_trademark_filing_date_Invalid			<> 0 or
																										 corp_trademark_class_desc1_Invalid			<> 0 or
																										 corp_inc_date_Invalid 									<> 0 or
																										 corp_term_exist_cd_Invalid							<> 0 or
																										 corp_term_exist_exp_Invalid						<> 0 or
																										 corp_foreign_domestic_ind_Invalid			<> 0 or																															
																										 corp_forgn_state_cd_Invalid 						<> 0 or
																										 corp_forgn_state_desc_Invalid 					<> 0 or
																										 corp_forgn_date_Invalid 								<> 0 or
																										 corp_for_profit_ind_Invalid						<> 0 or
																										 corp_ra_resign_date_Invalid						<> 0 or
																										 corp_ra_address_type_desc_Invalid			<> 0 or
																										 corp_country_of_formation_Invalid			<> 0 or
																										 corp_addl_info_Invalid                 <> 0 or
																										 cont_title1_desc_Invalid               <> 0 or
																										 recordorigin_Invalid										<> 0																														
																									  );
																										 																	
		Main_Goodrecords				:= Main_N.ExpandedInFile(	
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
																										 corp_status_date_Invalid								= 0 and
																										 corp_status_comment_Invalid						= 0 and
																										 corp_status_desc_Invalid			          = 0 and
																										 corp_orig_org_structure_desc_Invalid	  = 0 and
																										 corp_filing_date_Invalid			          = 0 and
																										 corp_llc_managed_desc_Invalid			    = 0 and
																										 corp_trademark_expiration_date_Invalid	= 0 and
																										 corp_trademark_filing_date_Invalid			= 0 and
																										 corp_trademark_class_desc1_Invalid			= 0 and
																										 corp_inc_date_Invalid 									= 0 and
																										 corp_term_exist_cd_Invalid							= 0 and
																										 corp_term_exist_exp_Invalid						= 0 and
																										 corp_foreign_domestic_ind_Invalid			= 0 and
																										 corp_forgn_state_cd_Invalid 						= 0 and
																										 corp_forgn_state_desc_Invalid					= 0 and
																										 corp_forgn_date_Invalid 								= 0 and
																										 corp_for_profit_ind_Invalid						= 0 and
																										 corp_ra_resign_date_Invalid						= 0 and
																										 corp_ra_address_type_desc_Invalid			= 0 and
																										 corp_country_of_formation_Invalid			= 0 and
																										 corp_addl_info_Invalid                 = 0 and
																										 cont_title1_desc_Invalid               = 0 and
																										 recordorigin_Invalid										= 0
																										);

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_mapping_NV_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_mapping_NV_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 				> Scrubs_Corp2_mapping_NV_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_mapping_NV_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_mapping_NV_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
																		count(Main_Goodrecords) = 0																																																																																											 => true,
																		false
																	);

		Main_Approvedrecords		:= project(Main_Goodrecords,transform(Corp2_mapping.LayoutsCommon.Main,self := left));


		Main_ALL		 						:= sequential(if(count(Main_Badrecords) <> 0
																						,if (poverwrite
																								,output(Main_Badrecords,,Corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_nv',overwrite,__compressed__)
																								,output(Main_Badrecords,,Corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_nv',__compressed__)
																								)
																						)
																				,output(Main_ScrubsWithExamples, all, named('CorpMainNVScrubsReportWithExamples'+filedate))
																				//Send Alerts if Scrubs exceeds thresholds
																				,if(count(Main_ScrubsAlert) > 0, Main_MailFile, output('CORP2_mapPING.NV - No "MAIN" Corp Scrubs Alerts'))
																				,Main_ErrorSummary
																				,Main_ScrubErrorReport
																				,Main_SomeErrorValues			
																				,Main_SubmitStats
																		);
						
	//********************************************************************
  // SCRUB STOCK
  //********************************************************************	
		Stock_F := MapStock;
		Stock_S := Scrubs_Corp2_mapping_NV_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//outputs reports
		Stock_ErrorSummary			 		:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_NV'+filedate));
		Stock_ScrubErrorReport 	 		:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_NV'+filedate));
		Stock_SomeErrorValues		 		:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_NV'+filedate));
		Stock_IsScrubErrors		 	 		:= if(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats				 		:= Stock_U.OrbitStats();

		//outputs files
		Stock_CreateBitmaps					:= output(Stock_N.BitmapInfile,,'~thor_data::corp_nv_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitmap				:= output(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			 := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NV_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_NV_Stock').SubmitStats;
		Stock_ScrubsWithExamples := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NV_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_NV_Stock').CompareToProfile_with_Examples;

		Stock_ScrubsAlert						:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment			:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpStock_NV Report' //subject
																																	 ,'Scrubs CorpStock_NV Report' //body
																																	 ,(data)Stock_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpNVEventScrubsReport.csv'
																																	);

		Stock_Badrecords						:= Stock_N.ExpandedInFile(	
																													corp_key_Invalid							  			<> 0 or
																													corp_vendor_Invalid 									<> 0 or
																													corp_state_origin_Invalid 					 	<> 0 or
																													corp_process_date_Invalid						  <> 0 or
																													corp_sos_charter_nbr_Invalid					<> 0 or
																													stock_authorized_nbr_Invalid					<> 0 or
																													stock_par_value_Invalid								<> 0 or
																													stock_nbr_par_shares_Invalid	 				<> 0 or
																													stock_total_capital_Invalid	 					<> 0
																												);

		Stock_Goodrecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  				= 0 and
																												corp_vendor_Invalid 										= 0 and
																												corp_state_origin_Invalid 					 		= 0 and
																												corp_process_date_Invalid						  	= 0 and
																												corp_sos_charter_nbr_Invalid						= 0 and
																												stock_authorized_nbr_Invalid						= 0 and																																
																												stock_par_value_Invalid									= 0 and
																												stock_nbr_par_shares_Invalid	 					= 0 and
																												stock_total_capital_Invalid	 						= 0
																											 );	
		
		Stock_FailBuild						:= if(count(Stock_Goodrecords) = 0,true,false);

		Stock_Approvedrecords			:= project(Stock_Goodrecords,transform(Corp2_mapping.LayoutsCommon.Stock,self := left));

		Stock_ALL									:= sequential(if(count(Stock_Badrecords) <> 0
																							,if (poverwrite
																									,output(Stock_Badrecords,,Corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_nv',overwrite,__compressed__)
																									,output(Stock_Badrecords,,Corp2_mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_nv',__compressed__)
																									)
																					 )
																					,output(Stock_ScrubsWithExamples, all, named('CorpStockNVScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,if(count(Stock_ScrubsAlert) > 0, Stock_MailFile, output('CORP2_mapPING.NV - No "Stock" Corp Scrubs Alerts'))
																					,Stock_ErrorSummary
																					,Stock_ScrubErrorReport
																					,Stock_SomeErrorValues
																					,Stock_SubmitStats
																					);
	
	//********************************************************************
  // UPDATE
  //********************************************************************	
	
	Fail_Build						:= if(AR_FailBuild = true or Event_FailBuild = true or Main_FailBuild = true or Stock_FailBuild = true,true,false);
	IsScrubErrors					:= if(AR_IsScrubErrors = true or Event_IsScrubErrors = true or Main_IsScrubErrors = true or Stock_IsScrubErrors = true,true,false);

	VersionControl.macBuildNewLogicalFile(Corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::AR_' 		+ state_origin, AR_Approvedrecords		, write_ar,,,pOverwrite); 
	VersionControl.macBuildNewLogicalFile(Corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Event_' 	+ state_origin, Event_Approvedrecords	, write_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_Approvedrecords	, write_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Stock_' 	+ state_origin, Stock_Approvedrecords	, write_stock,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::AR_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite); 
	VersionControl.macBuildNewLogicalFile(Corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Stock_' 	+ state_origin, Stock_F	, write_fail_stock,,,pOverwrite);

	mapNV := sequential (if(pShouldSpray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											,AR_All
											,Event_All
											,Main_All
											,Stock_All
											,if(fail_Build <> true	 
												 ,sequential (write_ar
																		 ,write_event
																		 ,write_main
																		 ,write_stock
																		 ,fileservices.addsuperfile(Corp2_mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_mapping._Dataset().NameMapped +'::sprayed::ar'			,Corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_'		+state_origin)
																		 ,fileservices.addsuperfile(Corp2_mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_mapping._Dataset().NameMapped +'::sprayed::event'	,Corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_'	+state_origin)
																		 ,fileservices.addsuperfile(Corp2_mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																		 ,fileservices.addsuperfile(Corp2_mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_mapping._Dataset().NameMapped +'::sprayed::stock'	,Corp2_mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_'	+state_origin)
																		 ,if (count(Main_Badrecords) <> 0 or count(AR_Badrecords) <> 0 or count(Event_Badrecords) <> 0 or count(Stock_Badrecords)<>0
																				 ,Corp2_mapping.Send_Email(state_origin,version,count(Main_Badrecords)<>0,count(AR_Badrecords)<>0,count(Event_Badrecords)<>0,count(Stock_Badrecords)<>0,count(Main_Badrecords),count(AR_Badrecords),count(Event_Badrecords),count(Stock_Badrecords),count(Main_Approvedrecords),count(AR_Approvedrecords),count(Event_Approvedrecords),count(Stock_Approvedrecords)).recordsRejected																				 
																				 ,Corp2_mapping.Send_Email(state_origin,version,count(Main_Badrecords)<>0,count(AR_Badrecords)<>0,count(Event_Badrecords)<>0,count(Stock_Badrecords)<>0,count(Main_Badrecords),count(AR_Badrecords),count(Event_Badrecords),count(Stock_Badrecords),count(Main_Approvedrecords),count(AR_Approvedrecords),count(Event_Approvedrecords),count(Stock_Approvedrecords)).mappingSuccess																				 
																				 )
																		 ,if (IsScrubErrors
																				 ,Corp2_mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,Event_IsScrubErrors,Stock_IsScrubErrors).FieldsInvalidPerScrubs
																				 )
																		 ) //if fail_Build <> true																			
												 ,sequential (write_fail_ar
																		 ,write_fail_event
																		 ,write_fail_main
																		 ,write_fail_stock												 
																		 ,Corp2_mapping.Send_Email(state_origin,version).mappingfailed
																		 ) //if fail_Build = true
												 )
										);

		isFileDateValid := if((STRING8)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		return sequential (if (isFileDateValid
													,mapNV
													,sequential (Corp2_mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																			,fail('Corp2_mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																			)
													)
											);

	end;	// end of Update function

end; //end NV module
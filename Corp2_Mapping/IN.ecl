Import _Control, Corp2, Corp2_Raw_IN, Scrubs, Scrubs_Corp2_Mapping_IN_Main, Scrubs_Corp2_Mapping_IN_Event, Tools, UT, VersionControl, Std;

export IN := MODULE;
	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) := function
		
		state_origin			:= 'IN'	;
		state_fips	 			:= '18';	
		state_desc	 			:= 'INDIANA';		
		CorpAgents				:= dedup(sort(distribute(Corp2_Raw_IN.Files(filedate,pUseProd).input.CorpAgents.Logical,hash(Agen_Business_ID)),record,local),record,local):independent;
		CorpCorporations	:= dedup(sort(distribute(Corp2_Raw_IN.Files(filedate,pUseProd).input.CorpCorporations.Logical,hash(Corp_Business_ID)),record,local),record,local):independent;
		CorpFilings				:= dedup(sort(distribute(Corp2_Raw_IN.Files(filedate,pUseProd).input.CorpFilings.Logical,hash(fili_business_id)),record,local),record,local):independent;
		CorpMergers				:= dedup(sort(distribute(Corp2_Raw_IN.Files(filedate,pUseProd).input.CorpMergers.Logical,hash(Merg_Surv_Business_ID,Merg_Non_Surv_Business_ID)),record,local),record,local):independent;
		CorpNames					:= dedup(sort(distribute(Corp2_Raw_IN.Files(filedate,pUseProd).input.CorpNames.Logical,hash(name_business_id)),record,local),record,local):independent;
		CorpOfficers			:= dedup(sort(distribute(Corp2_Raw_IN.Files(filedate,pUseProd).input.CorpOfficers.Logical,hash(offi_business_id)),record,local),record,local):independent;
		
	//Get merg_surv_business_id for all the name records of the non survivor businesses
		jCorpNameMerg1 		:= join(CorpNames, CorpMergers,
															corp2.t2u(left.name_business_id) = corp2.t2u(right.merg_non_surv_business_id),
															transform(Corp2_Raw_IN.Layouts.Temp_CorpNamesMergersLayoutIn,
																				self.merg_surv_business_id   := right.merg_surv_business_id;
																				self.merg_creation_date      := right.merg_creation_date;
																				self                         := left;
																			 )
														 );
											
		//Match the merg_surv_business_id with the appropriate name
		jNameMergSurv    := join(jCorpNameMerg1, CorpNames,
											 			 corp2.t2u(left.merg_surv_business_id) = corp2.t2u(right.name_business_id),
														 transform(Corp2_Raw_IN.Layouts.Temp_CorpNamesMergersLayoutIn,
																			 self.merg_surv_business_name := right.name_name;
																			 self                         := left;
																		  ),left outer
													  );
												 
		//Get merg_non_surv_business_id for all the name records of the survivor businesses
		jCorpNameMerg2   := join(CorpNames, CorpMergers,
														 corp2.t2u(left.name_business_id) = corp2.t2u(right.merg_surv_business_id),
														 transform(Corp2_Raw_IN.Layouts.Temp_CorpNamesMergersLayoutIn,
																			 self.merg_non_surv_business_id   := right.merg_non_surv_business_id;
																			 self.merg_creation_date          := right.merg_creation_date;
																			 self                             := left;
																		  )
														);

		jNameMergNonSurv := join(jCorpNameMerg2, CorpNames,
														 corp2.t2u(left.merg_non_surv_business_id) = corp2.t2u(right.name_business_id),
														 transform(Corp2_Raw_IN.Layouts.Temp_CorpNamesMergersLayoutIn,
																			 self.merg_non_surv_business_name := right.name_name;
																			 self                             := left;
																			),left outer
														);

		ds_NameMerg       := dedup(sort(jNameMergSurv + jNameMergNonSurv,RECORD,LOCAL),RECORD,LOCAL);	
		
		joinCorpAgents 		:= join(CorpCorporations, CorpAgents,
															corp2.t2u(left.Corp_Business_ID) = corp2.t2u(right.Agen_Business_ID),
															transform(Corp2_Raw_IN.Layouts.Temp_CorpAgentsLayoutIn,
																				self := left;
																				self := right;
																			 ),left outer
															);
															
		joinCorpAgentMergNames := join(joinCorpAgents,ds_NameMerg,
																corp2.t2u(left.Corp_Business_ID) = corp2.t2u(right.name_business_id),
																transform(Corp2_Raw_IN.Layouts.Temp_CorpAgentMergersNamesLayoutIn,
																					 self := left;
																					 self := right;
																				  ),left outer
																);
																					 
		Corp2_mapping.LayoutsCommon.Main in_corp1Transform_Business(Corp2_Raw_IN.Layouts.Temp_CorpAgentMergersNamesLayoutIn l,integer ctr):= transform
		 
		  legal_list 						:= ['2','3','4','5','6','7','8','9','10','11','14','15','16','17','18','19',
			                          '20','21','22','23','30','32','33','34','35','36','37','39','40','41','42',
																'45','46'];
			Reserved_list 				:= ['26'];
			foreign_list 					:= ['14','15','16','17','18','19','20','21','22','23','30','33','35','37','40','42'];
			domestic_list					:= ['2','3','4','5','6','7','8','9','10','11','32','34','36','39','41','45','46'];
			status_list       		:= ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16',
			                          '17','18','19','20','21','22','23','24','25','26','27'];
			
			self.dt_vendor_first_reported					:= (integer)filedate;
			self.dt_vendor_last_reported					:= (integer)filedate;
			self.dt_first_seen										:= (integer)filedate;
			self.dt_last_seen											:= (integer)filedate;
			self.corp_ra_dt_first_seen						:= (integer)filedate;
			self.corp_ra_dt_last_seen							:= (integer)filedate;
			self.corp_process_date				  			:= filedate;    		
			self.corp_key					      					:= state_fips + '-' + corp2.t2u(l.corp_business_id);
			self.corp_vendor					  					:= state_fips;
			self.corp_state_origin            		:= state_origin;
			self.corp_inc_state                   := state_origin;
			self.corp_orig_sos_charter_nbr        := corp2.t2u(l.corp_business_id);
			temp_corp_legal_name                  := if(Regexfind('^NAME$|^TEST$|TEST BETH|TEST DOM|TEST ENHANCEMENTS|^TESTING$|TESTANGEL|TESTFEB|^TESTING LICENSE SITE|^TESTING LIMITED LIABILITY|^TEST[S|X|Z]{1,}|PLEASE IGNORE|TEST NON PROFIT|TEST NQ|^TEST (.)\\1',l.corp_name,nocase),'',corp2.t2u(l.corp_name));
			self.corp_legal_name                  := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,temp_corp_legal_name).BusinessName;
			self.corp_ln_name_type_cd         		:= map(corp2.t2u(l.corp_entity_type) in legal_list    => '01',
																									 corp2.t2u(l.corp_entity_type) in Reserved_list => '07',
																									 '');
			self.corp_ln_name_type_desc           := map(corp2.t2u(l.corp_entity_type) in legal_list    => 'LEGAL',
																									 corp2.t2u(l.corp_entity_type) in Reserved_list => 'RESERVED',
																									 '');
			self.corp_orig_org_structure_cd       := if(corp2.t2u(l.corp_entity_type) not in [Reserved_list,'27'],corp2.t2u(l.corp_entity_type),'');
			self.corp_orig_org_structure_desc  		:= Corp2_Raw_IN.Functions.fgetOrgStructDesc(self.corp_orig_org_structure_cd);
			self.corp_foreign_domestic_ind				:= map(corp2.t2u(l.corp_entity_type) in domestic_list => 'D',
																									 corp2.t2u(l.corp_entity_type) in foreign_list  => 'F',
																									 '');
			self.corp_for_profit_ind							:= map(corp2.t2u(l.corp_entity_type) in ['5','17']  => 'Y',
																									 corp2.t2u(l.corp_entity_type) in ['10','22'] => 'N',
																									 '');
			self.corp_status_cd                   := if(trim(l.corp_status_code,left, right) not in status_list,'',trim(l.corp_status_code,left, right));
			self.corp_status_desc                 := Corp2_Raw_IN.Functions.fgetCorpStatusDesc(self.corp_status_cd);		
			self.corp_acts						  					:= Corp2_Raw_IN.Functions.fgetCorpActs(l.corp_filing_act);	
			self.corp_inc_date                    := if(corp2.t2u(l.corp_orig_inc_state) in ['',state_origin], Corp2_Mapping.fValidateDate(l.corp_creation_date[1..10]).GeneralDate,'');
			self.corp_forgn_date                  := if(corp2.t2u(l.corp_orig_inc_state) not in ['',state_origin], Corp2_Mapping.fValidateDate(l.corp_creation_date[1..10]).GeneralDate,'');
			self.corp_filing_date                 := choose(ctr,Corp2_Mapping.fValidateDate(l.corp_orig_inc_date[1..10]).PastDate,Corp2_Mapping.fValidateDate(l.merg_creation_date[1..10]).PastDate);
			self.corp_filing_desc                 := choose(ctr,if(self.corp_filing_date <> '' ,'HOME STATE',''),
			                                                    if(self.corp_filing_date <> '' ,'MERGER EFFECTIVE DATE',''));
			self.corp_term_exist_exp              := Corp2_Mapping.fValidateDate(l.corp_expiration_date).GeneralDate;
			self.corp_term_exist_cd               := if(self.corp_term_exist_exp <> '','D','P');
			self.corp_term_exist_desc             := if(self.corp_term_exist_exp <> '','EXPIRATION DATE','PERPETUAL');
			self.corp_status_date                 := Corp2_Mapping.fValidateDate(l.Corp_Inactive_Date[1..10]).PastDate; 
			self.corp_forgn_state_cd              := if(corp2.t2u(l.corp_orig_inc_state) not in ['' ,state_origin],Corp2_Raw_IN.Functions.Get_State_Code(l.corp_orig_inc_state),'');
			self.corp_forgn_state_desc            := if(corp2.t2u(l.corp_orig_inc_state) not in ['' ,state_origin],Corp2_Raw_IN.Functions.fGetStateDesc(l.corp_orig_inc_state),'');
			temp_Corp_city                        := if(Regexfind('INDPLS',l.corp_city,nocase),'INDIANAPOLIS',corp2.t2u(l.corp_city));
			self.corp_address1_type_cd						:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.corp_address_line1,l.corp_address_line2,temp_Corp_city,l.corp_state,l.corp_zip_code ).ifAddressExists, 'B', '');
			self.corp_address1_type_desc					:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.corp_address_line1,l.corp_address_line2,temp_Corp_city,l.corp_state,l.corp_zip_code ).ifAddressExists, 'BUSINESS', '');																								
			self.corp_address1_line1							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corp_address_line1,l.corp_address_line2,temp_Corp_city,l.corp_state,l.corp_zip_code ).AddressLine1;
			self.corp_address1_line2				 			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corp_address_line1,l.corp_address_line2,temp_Corp_city,l.corp_state,l.corp_zip_code + l.corp_zip_extension).AddressLine2;
			self.corp_address1_line3				 			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corp_address_line1,l.corp_address_line2,temp_Corp_city,l.corp_state,l.corp_zip_code).AddressLine3;
			self.corp_prep_addr1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corp_address_line1,l.corp_address_line2,temp_Corp_city,l.corp_state,l.corp_zip_code ).PrepAddrLine1;
			self.corp_prep_addr1_last_line				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corp_address_line1,l.corp_address_line2,temp_Corp_city,l.corp_state,l.corp_zip_code).PrepAddrLastLine;
			self.corp_ra_full_name                := if(Regexfind('^RESIGNED|AGENT RESIGNED|^\\*{1,} REGISTERED AGENT|TEST NEW RA|^TESTER$|TEST PERSON|TEST BETH|TEST[Z]{1,}|\\*RESIGNED',l.agen_name,nocase), '',
																								   Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.agen_name).BusinessName
																									 );	
			self.corp_agent_status_desc           := map(Regexfind('RESIGNED',l.agen_name,nocase)                  => 'RESIGNED',
			                                             Regexfind('REGISTERED AGENT RESIGNED',l.agen_name,nocase) => 'REGISTERED AGENT RESIGNED',
																									 Regexfind('AGENT RESIGNED',l.agen_name,nocase)            => 'AGENT RESIGNED',
			                                              '');
			self.corp_ra_effective_date           := Corp2_Mapping.fValidateDate(l.agen_creation_date[1..10]).GeneralDate;
			temp_ra_city                        	:= if(Regexfind('INDPLS',l.agen_city,nocase),'INDIANAPOLIS',corp2.t2u(l.agen_city));
			self.corp_ra_address_type_cd		  		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agen_address_line1,l.agen_address_line2,temp_ra_city,l.agen_state,l.agen_zip_code).ifAddressExists,'R','');
			self.corp_ra_address_type_desc		  	:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.agen_address_line1,l.agen_address_line2,temp_ra_city,l.agen_state,l.agen_zip_code).ifAddressExists,'REGISTERED OFFICE','');
			self.corp_ra_address_line1			 	  	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agen_address_line1,l.agen_address_line2,temp_ra_city,l.agen_state,l.agen_zip_code).AddressLine1;
			self.corp_ra_address_line2			 	  	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agen_address_line1,l.agen_address_line2,temp_ra_city,l.agen_state,l.agen_zip_code + l.agen_zip_extension).AddressLine2;
			self.corp_ra_address_line3				  	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agen_address_line1,l.agen_address_line2,temp_ra_city,l.agen_state,l.agen_zip_code).AddressLine3;
			self.ra_prep_addr_line1						  	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agen_address_line1,l.agen_address_line2,temp_ra_city,l.agen_state,l.agen_zip_code).PrepAddrLine1;
			self.ra_prep_addr_last_line				  	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.agen_address_line1,l.agen_address_line2,temp_ra_city,l.agen_state,l.agen_zip_code).PrepAddrLastLine;
  		self.corp_merger_effective_date			  := Corp2_Mapping.fValidateDate(l.merg_creation_date[1..10]).PastDate;
			self.Corp_Survivor_Corporation_Id     := corp2.t2u(l.merg_surv_business_id);
			self.Corp_Merged_Corporation_Id       := corp2.t2u(l.merg_non_surv_business_id);
			self.Corp_Merger_Name                 := map(self.Corp_Survivor_Corporation_Id <> '' => corp2.t2u(l.merg_surv_business_name),
			                                             self.Corp_Merged_Corporation_Id <> ''   => corp2.t2u(l.merg_non_surv_business_name),
																									 '');
			self.Corp_Merger_Indicator            := map(self.Corp_Survivor_Corporation_Id <> '' => 'S',
			                                             self.Corp_Merged_Corporation_Id <> ''   => 'N',
																									 '');
			self.corp_llc_managed_desc            := map(corp2.t2u(l.corp_managers) = 'FALSE' => 'LLC DOES NOT HAVE MANAGERS',
																									 corp2.t2u(l.corp_managers) = 'TRUE'  => 'LLC HAS MANAGERS','');
		  self.corp_addl_info			              := map(corp2.t2u(l.corp_managers) = 'FALSE' => 'LLC DOES NOT HAVE MANAGERS',
																									 corp2.t2u(l.corp_managers) = 'TRUE'  => 'LLC HAS MANAGERS','');
			self.recordorigin											:= 'C';
			self                                  := [];
			
		end; 

		MapCorpAgents 	:= normalize(joinCorpAgentMergNames, if(left.corp_orig_inc_date[1..10] <> '' and  left.merg_creation_date[1..10] <>'' ,2,1),in_corp1Transform_Business(left, counter));
															
    jCorpNameCorp 		:= join(CorpNames, CorpCorporations,
		  												corp2.t2u(left.name_business_id) = corp2.t2u(right.Corp_Business_ID),
															transform(Corp2_Raw_IN.Layouts.Temp_CorpNamesCorpsLayoutIn,
																				self.corp_creation_date      := right.corp_creation_date;
																				self.corp_orig_inc_state     := right.corp_orig_inc_state;
																				self                         := left;
																			 ),left outer
														 );
											
		
		Corp2_mapping.LayoutsCommon.Main in_corp2Transform_Business(Corp2_Raw_IN.Layouts.Temp_CorpNamesCorpsLayoutIn l):=transform,
		skip(corp2.t2u(l.name_business_id)='' or corp2.t2u(l.name_name_type) = '' or corp2.t2u(l.name_name)='')//only Assumed or Former Name will be collected from this transform 
			
			self.dt_vendor_first_reported					:= (integer)filedate;
			self.dt_vendor_last_reported					:= (integer)filedate;
			self.dt_first_seen										:= (integer)filedate;
			self.dt_last_seen											:= (integer)filedate;
			self.corp_ra_dt_first_seen						:= (integer)filedate;
			self.corp_ra_dt_last_seen							:= (integer)filedate;
			self.corp_key					      					:= state_fips + '-' + corp2.t2u(l.name_business_id);
			self.corp_vendor					  					:= state_fips;
			self.corp_state_origin            		:= state_origin	;
			self.corp_inc_state                   := state_origin;	
			self.corp_process_date				  			:= filedate;    
			self.corp_orig_sos_charter_nbr        := corp2.t2u(l.name_business_id);
			self.corp_name_comment                := map(trim(l.name_name_type,left,right) = '3'  => 'RESERVED EXPIRE',
																									 trim(l.name_name_type,left,right) = '5'  => 'ASSUMED CANCELLED',
																									 '');
			self.corp_ln_name_type_cd             := map(trim(l.name_name_type,left,right) = '1'  => '11',
																									 trim(l.name_name_type,left,right) = '2'  => '07',
																									 trim(l.name_name_type,left,right) = '4'  => '06',
																									 trim(l.name_name_type,left,right) = '6'  => 'F',
																									 trim(l.name_name_type,left,right) = '7'  => 'P',
																									 trim(l.name_name_type,left,right) = '8'  => '14',
																									 trim(l.name_name_type,left,right) = '9'  => '15',
																									 trim(l.name_name_type,left,right) = '10' => '16',
																									 '');
			self.corp_ln_name_type_desc           := map(trim(l.name_name_type,left,right) = '1'  => 'FOREIGN LEGAL',
																									 trim(l.name_name_type,left,right) = '2'  => 'RESERVED',
																									 trim(l.name_name_type,left,right) = '4'  => 'ASSUMED',
																									 trim(l.name_name_type,left,right) = '6'  => 'FICTITIOUS',
																									 trim(l.name_name_type,left,right) = '7'  => 'PRIOR',
																									 trim(l.name_name_type,left,right) = '8'  => 'SERIES LEGAL',
																									 trim(l.name_name_type,left,right) = '9'  => 'FOREIGN SERIES',
																									 trim(l.name_name_type,left,right) = '10' => 'FICTITIOUS SERIES',
																									 '');	
			self.corp_legal_name                  := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.name_name).BusinessName;	
	    self.corp_name_status_cd              := map(trim(l.name_name_type,left,right) = '3'  => '12',
																									 trim(l.name_name_type,left,right) = '5'  => '13',
																									 '');
	    self.corp_name_status_desc            := map(trim(l.name_name_type,left,right) = '3'  => 'RESERVED EXPIRE',
																									 trim(l.name_name_type,left,right) = '5'  => 'ASSUMED CANCELLED',
																									 '');
			self.corp_inc_date                    := if(corp2.t2u(l.corp_orig_inc_state) in ['',state_origin], Corp2_Mapping.fValidateDate(l.corp_creation_date[1..10]).GeneralDate,'');
			self.corp_forgn_date                  := if(corp2.t2u(l.corp_orig_inc_state) not in ['',state_origin], Corp2_Mapping.fValidateDate(l.corp_creation_date[1..10]).GeneralDate,'');
			self.corp_inc_county                  := corp2.t2u(l.name_county);
			self.corp_name_effective_date         := Corp2_Mapping.fValidateDate(l.name_creation_date).GeneralDate;
			self.recordorigin											:= 'C';
			self                                  := [];
			
		end; 

		MapCorpNames 		 := project(jCorpNameCorp,in_corp2Transform_Business(left))(corp2.t2u(corp_ln_name_type_cd + corp_inc_county + corp_name_effective_date)<>'');
   
	  joinCorpOfficers := join(CorpCorporations,CorpOfficers,
														 corp2.t2u(left.Corp_Business_ID)= corp2.t2u(right.offi_business_id) ,
														 transform(Corp2_Raw_IN.Layouts.Temp_CorpOfficersLayoutIn,
																			 self := left;
																			 self := right;
																			),inner);
		
		Corp2_mapping.LayoutsCommon.Main in_contactTransform(Corp2_Raw_IN.Layouts.Temp_CorpOfficersLayoutIn  l):=	transform,
		skip(corp2.t2u(l.Corp_Business_ID)='' or corp2.t2u(l.offi_name + l.corp_owner_name)='')
		
			self.dt_vendor_first_reported						:= (integer)filedate;
			self.dt_vendor_last_reported						:= (integer)filedate;
			self.dt_first_seen											:= (integer)filedate;
			self.dt_last_seen												:= (integer)filedate;
			self.corp_ra_dt_first_seen							:= (integer)filedate;
			self.corp_ra_dt_last_seen								:= (integer)filedate;
			self.corp_key					  								:= state_fips +'-'+ corp2.t2u(l.Corp_Business_ID);
			self.corp_vendor					  						:= state_fips;
			self.corp_state_origin            			:= state_origin	;
			self.corp_inc_state                   	:= state_origin;	
			self.corp_process_date			  					:= filedate;
			self.corp_orig_sos_charter_nbr    			:= corp2.t2u(l.Corp_Business_ID);
			self.corp_legal_name              			:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.corp_name).BusinessName;
			self.cont_title1_desc             			:= Corp2_Raw_IN.Functions.fgetcontTitle(L.offi_position_type);										  
			self.cont_type_cd												:= if(self.cont_title1_desc <> '','F','');
			self.cont_type_desc											:= if(self.cont_title1_desc <> '','OFFICER','');
			self.cont_full_name                   	:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.offi_name).BusinessName;
			temp_cont_city                        	:= if(Regexfind('INDPLS',l.offi_city,nocase),'INDIANAPOLIS',corp2.t2u(l.offi_city));
			self.cont_address_type_cd								:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.offi_address_line1,l.offi_address_line2,temp_cont_city,l.offi_state,l.offi_zip_code).ifAddressExists,'T', '');
			self.cont_address_type_desc							:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.offi_address_line1,l.offi_address_line2,temp_cont_city,l.offi_state,l.offi_zip_code).ifAddressExists,'CONTACT', '');
			self.cont_address_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.offi_address_line1,l.offi_address_line2,temp_cont_city,l.offi_state,l.offi_zip_code).AddressLine1;
			self.cont_address_line2									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.offi_address_line1,l.offi_address_line2,temp_cont_city,l.offi_state,l.offi_zip_code + trim(l.offi_zip_extension,left,right)).AddressLine2;
			self.cont_address_line3									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.offi_address_line1,l.offi_address_line2,temp_cont_city,l.offi_state,l.offi_zip_code).AddressLine3;																					  
			self.cont_prep_addr_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.offi_address_line1,l.offi_address_line2,temp_cont_city,l.offi_state,l.offi_zip_code).PrepAddrLine1;
			self.cont_prep_addr_last_line						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.offi_address_line1,l.offi_address_line2,temp_cont_city,l.offi_state,l.offi_zip_code).PrepAddrLastLine;
			self.cont_effective_date             		:= Corp2_Mapping.fValidateDate(l.offi_creation_date).GeneralDate;
			self.recordorigin												:= 'T';
			self                              			:= [];
			
		end; 
		
		MapCont 	:= project(joinCorpOfficers,in_contactTransform(left));
	
		AllCorps 	:= dedup(sort(distribute(MapCorpAgents + 
																			 MapCorpNames + 
																			 MapCont,hash(corp_key))
														 ,record,local)
											 ,record,local) : independent;
	
	  MapCorp   := AllCorps(corp_legal_name <> '');
		
		Corp2_Mapping.LayoutsCommon.AR in_arTransform(Corp2_Raw_IN.Layouts.CorpFilingsLayoutIn  l):=transform,
		skip(corp2.t2u(l.fili_business_id) = '' OR corp2.t2u(l.fili_filing_type) not in ['21','10006'] )  
		
			self.corp_key					      					:= state_fips +'-'+corp2.t2u(l.fili_business_id);
			self.corp_vendor					  					:= state_fips;
			self.corp_state_origin            		:= state_origin;
			self.corp_process_date			      		:= filedate;
			self.corp_sos_charter_nbr		      		:= corp2.t2u(l.fili_business_id);
			self.ar_report_nbr               			:= corp2.t2u(l.fili_filing_num);
			self.ar_filed_dt                      := Corp2_Mapping.fValidateDate(l.fili_filing_date[1..10]).pastDate;
			self.ar_type                          := if(corp2.t2u(l.fili_filing_type)='10006', 'ANNUAL BENEFIT REPORT', 'BUSINESS ENTITY REPORT');
			self.ar_comment                       := corp2.t2u(l.fili_comment);
			self                                  := [];
			
		end; 

		MapAR 	:= project(CorpFilings, in_arTransform(left))(corp2.t2u(ar_report_nbr + ar_filed_dt) <> '');
		dedupAR := dedup(sort(distribute(MapAR,hash(corp_key)),record,local),record,local) : independent;

    joinCorpFilings := join(CorpFilings, CorpCorporations,
														 corp2.t2u(left.fili_business_id) = corp2.t2u(right.Corp_Business_ID),
														 transform(Corp2_Raw_IN.Layouts.Temp_CorpFilingsLayoutIn,
																			 self.corp_entity_type := right.corp_entity_type;
																			 self := left;
																			),left outer
																			 ,lookup ,local
									         ) : INDEPENDENT;			
													 
		Corp2_Mapping.LayoutsCommon.Events eventTransform(Corp2_Raw_IN.Layouts.Temp_CorpFilingsLayoutIn l,integer ctr) := transform,
		skip(corp2.t2u(l.fili_business_id)='' or corp2.t2u(l.fili_filing_type) in ['21','10006'] )
		
			self.corp_key					    						:= state_fips +'-'+ corp2.t2u(l.fili_business_id);
			self.corp_vendor					  					:= state_fips;
			self.corp_state_origin            		:= state_origin;
			self.corp_process_date			    			:= filedate;
			self.corp_sos_charter_nbr		    			:= corp2.t2u(l.fili_business_id);			 
			self.event_filing_cd                	:= corp2.t2u(l.fili_filing_type);
			self.event_filing_desc                := Corp2_Raw_IN.Functions.fgetFiling_desc(l.corp_entity_type,l.fili_filing_type);
			self.event_filing_reference_nbr     	:= corp2.t2u(l.fili_filing_num);
			CleanFilingDate                 			:= Corp2_Mapping.fValidateDate(l.fili_filing_date).pastDate;
			cleanEffDate 													:= Corp2_Mapping.fValidateDate(l.fili_effective_date).GeneralDate;
			self.event_filing_date         				:= choose(ctr,CleanFilingDate,cleanEffDate);
			self.event_date_type_cd         			:= choose(ctr,'FIL','EFF');					
			self.event_date_type_desc       			:= choose(ctr,'FILING','EFFECTIVE');
			self.event_desc		    								:= corp2.t2u(l.fili_comment);
			self													  			:= [];
			
		end;
	
		mapEvent 				:= normalize(joinCorpFilings, 
		                             if(Corp2_Mapping.fValidateDate(left.fili_filing_date).pastDate <> ''  and  Corp2_Mapping.fValidateDate(left.fili_effective_date).GeneralDate <> '' and 
																		Corp2_Mapping.fValidateDate(left.fili_filing_date).pastDate <> Corp2_Mapping.fValidateDate(left.fili_effective_date).GeneralDate,2,1
																		),
																 eventTransform(left, counter)
																);		
		dsMapEvent 			:= mapEvent(corp2.t2u(event_filing_date + event_filing_cd + event_filing_reference_nbr + event_desc) <> '');
		dedupMapEvents 	:= dedup(sort(distribute(dsMapEvent,hash(corp_key)),record,local),record,local) : independent;
		
		//--------------------------------------------------------------------	
				//Scrubs for MAIN
		//--------------------------------------------------------------------
		Main_F 										:= MapCorp;
		Main_S 										:= Scrubs_Corp2_Mapping_IN_Main.Scrubs; 				     // Scrubs module
		Main_N 										:= Main_S.FromNone(Main_F); 											  // Generate the error flags
		Main_T 										:= Main_S.FromBits(Main_N.BitmapInfile);     		 	 // Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U 										:= Main_S.FromExpanded(Main_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_IN'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_IN'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_IN'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_IN_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
	
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_IN Report' //subject
																																	 ,'Scrubs CorpMain_IN Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpINMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );
																													 
		EXPORT Main_BadRecords			:= Main_N.ExpandedInFile(dt_vendor_first_reported_Invalid 			<> 0 or
																													dt_vendor_last_reported_Invalid 			<> 0 or
																													dt_first_seen_Invalid 							  <> 0 or
																													dt_last_seen_Invalid 									<> 0 or
																													corp_ra_dt_first_seen_Invalid 			  <> 0 or
																													corp_ra_dt_last_seen_Invalid 			    <> 0 or
																													corp_key_Invalid 											<> 0 or
																													corp_supp_key_Invalid 							  <> 0 or
																													corp_vendor_Invalid 									<> 0 or
																													corp_state_origin_Invalid 						<> 0 or
																													corp_process_date_Invalid 						<> 0 or
																													corp_orig_sos_charter_nbr_Invalid 		<> 0 or
																													corp_legal_name_Invalid 							<> 0 or
																													corp_ln_name_type_cd_Invalid 					<> 0 or
																													corp_address1_effective_date_Invalid 	<> 0 or
																													corp_filing_date_Invalid 							<> 0 or
																													corp_status_cd_Invalid 								<> 0 or
																													corp_inc_state_Invalid 								<> 0 or
																													corp_inc_date_Invalid 								<> 0 or
																													corp_fed_tax_id_Invalid 							<> 0 or
																													corp_term_exist_cd_Invalid 						<> 0 or
																													corp_term_exist_exp_Invalid 					<> 0 or
																													corp_term_exist_desc_Invalid 					<> 0 or
																													corp_foreign_domestic_ind_Invalid 		<> 0 or
																													corp_forgn_state_cd_Invalid 					<> 0 or
																													corp_forgn_state_desc_Invalid 				<> 0 or
																													corp_forgn_date_Invalid 							<> 0 or
																													corp_orig_org_structure_cd_Invalid 		<> 0 or
																													corp_orig_org_structure_desc_Invalid 	<> 0 or
																													corp_for_profit_ind_Invalid 					<> 0 or
																													corp_acts_Invalid 										<> 0 or
																													cont_title1_desc_Invalid 							<> 0 or
																													corp_llc_managed_ind_Invalid 					<> 0 or
																													recordorigin_Invalid 									<> 0 
																											);	
																														
		EXPORT Main_GoodRecords				:= Main_N.ExpandedInFile(	dt_vendor_last_reported_Invalid 			= 0 and
																														dt_first_seen_Invalid 							  = 0 and
																														dt_last_seen_Invalid 									= 0 and
																														corp_ra_dt_first_seen_Invalid 			  = 0 and
																														corp_ra_dt_last_seen_Invalid 			    = 0 and
																														corp_key_Invalid 											= 0 and
																														corp_supp_key_Invalid 							  = 0 and
																														corp_vendor_Invalid 									= 0 and
																														corp_state_origin_Invalid 						= 0 and
																														corp_process_date_Invalid 						= 0 and
																														corp_orig_sos_charter_nbr_Invalid 		= 0 and
																														corp_legal_name_Invalid 							= 0 and
																														corp_ln_name_type_cd_Invalid 					= 0 and
																														corp_address1_effective_date_Invalid 	= 0 and
																														corp_filing_date_Invalid 							= 0 and
																														corp_status_cd_Invalid 								= 0 and
																														corp_inc_state_Invalid 								= 0 and
																														corp_inc_date_Invalid 								= 0 and
																														corp_fed_tax_id_Invalid 							= 0 and
																														corp_term_exist_cd_Invalid 						= 0 and
																														corp_term_exist_exp_Invalid 					= 0 and
																														corp_term_exist_desc_Invalid 					= 0 and
																														corp_foreign_domestic_ind_Invalid 		= 0 and
																														corp_forgn_state_cd_Invalid 					= 0 and
																														corp_forgn_state_desc_Invalid 				= 0 and
																														corp_forgn_date_Invalid 							= 0 and
																														corp_orig_org_structure_cd_Invalid 		= 0 and
																														corp_orig_org_structure_desc_Invalid 	= 0 and
																														corp_for_profit_ind_Invalid 					= 0 and
																														corp_acts_Invalid 										= 0 and
																														cont_title1_desc_Invalid 							= 0 and
																														corp_llc_managed_ind_Invalid 					= 0 and
																														recordorigin_Invalid 									= 0 
																											);		

		Main_ApprovedRecords 					:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
		
		EXPORT Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_IN_Main.Threshold_Percent.CORP_KEY										 => true,
																					corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_IN_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																					corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_IN_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																					count(Main_GoodRecords) = 0																																																																																											 => true,																		
																					false
																				);
	Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_IN',overwrite,__compressed__,named('Sample_Rejected_MainRecs_IN'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_IN'+filedate))
																													 )
																							)
																				)
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainINScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0,Main_SendEmailFile, OUTPUT('CORP2_MAPPING.IN - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues																	 
																	//,Main_AlertsCSVTemplate
																		,Main_SubmitStats				
																	);

//********************************************************************
// SCRUB EVENT
//********************************************************************	
	Event_F := dedupMapEvents;
	Event_S := Scrubs_Corp2_Mapping_IN_Event.Scrubs;						// Scrubs module
	Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
	Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
	Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
	
	//Outputs reports
	Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_IN'+filedate));
	Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_IN'+filedate));
	Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_IN'+filedate));
	Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

	// Orbit Stats
	Event_OrbitStats					:= Event_U.OrbitStats();

	//Outputs files
	Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_IN_event_scrubs_bits',overwrite,compressed);	//long term storage
	Event_TranslateBitMap			:= output(Event_T);
	//Creates Profile's alert template for Orbit - Can be copied & imported into Orbit; Only required first time & if scrub rules change
	Event_AlertsCSVTemplate	  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').ProfileAlertsTemplate;
	//Submits Profile's stats to Orbit
	Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').SubmitStats;

	Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+ state_origin+'_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp2_'+ state_origin+'_Event').CompareToProfile_with_Examples;
	
	Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
	Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
	Event_MailFile						:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpEvent_IN Report' //Subject
																																 ,'Scrubs CorpEvent_IN Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpINEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

 Event_BadRecords		  := event_N.ExpandedInFile(corp_key_Invalid 							  <> 0 or
																								corp_vendor_Invalid 					  <> 0 or
																								corp_state_origin_Invalid 		  <> 0 or
																								corp_process_date_Invalid		    <> 0 or
																								corp_sos_charter_nbr_Invalid    <> 0 or
																								corp_state_origin_Invalid   	  <> 0 or
																								event_filing_cd_Invalid 			  <> 0 or
																								event_filing_desc_Invalid 			<> 0
																								);
																																										
	Event_GoodRecords	  := event_N.ExpandedInFile(corp_key_Invalid 											= 0 and
																								corp_vendor_Invalid 									= 0 and
																								corp_state_origin_Invalid 					 	= 0 and
																								corp_process_date_Invalid						  = 0 and
																								corp_sos_charter_nbr_Invalid 					= 0 and
																								corp_state_origin_Invalid 						= 0 and
																								event_filing_cd_Invalid 							= 0 and
																								event_filing_desc_Invalid 						= 0
																								);
																								
	Event_FailBuild						:= if(count(Event_GoodRecords) = 0,true,false);													
	Event_ApprovedRecords			:= project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));
	
	Event_RejFile_Exists			:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' + state_origin),true,false);			
	Event_ALL									:= sequential(IF(count(Event_BadRecords)<> 0
																						 ,if(poverwrite
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_IN',overwrite,__compressed__,named('Sample_Rejected_Event_Recs_IN'+filedate))
																								,sequential (IF(Event_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin)),
																														 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin,__compressed__,named('Sample_Rejected_Event_Recs_IN'+filedate))
																														)
																								)
																						)
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventINScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.IN - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues																			 
																					 //,Event_AlertsCSVTemplate
																					 ,Event_SubmitStats
																					);


//==========================================VERSION CONTROL====================================================
	IsScrubErrors	:= IF(Event_IsScrubErrors = TRUE OR Main_IsScrubErrors = TRUE,TRUE,FALSE);
	versionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_' + state_origin		,Main_ApprovedRecords	,main_out		,,,pOverwrite);		
	versionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_' + state_origin		,Event_ApprovedRecords,event_out	,,,pOverwrite);
	versionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_' + state_origin			,dedupAR							,ar_out			,,,pOverwrite);
		
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' 	+ state_origin	,Main_F	 ,write_fail_main  ,,,pOverwrite); 
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::event_' 	+ state_origin	,Event_F	,write_fail_event  ,,,pOverwrite); 
			
	mapIN:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
												//,Corp2_Raw_IN.Build_Bases(filedate,version,pUseProd).All // Determined building of bases is not needed
												,main_out
												,event_out
												,ar_out									
												,IF(Main_FailBuild <> true or Event_FailBuild <> true
														,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_IN')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_IN')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_IN')																		 
 																				,if (count(Main_BadRecords) <> 0 or  count(Event_BadRecords) <> 0  
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(dedupAR),count(Event_ApprovedRecords)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(dedupAR),count(Event_ApprovedRecords)).MappingSuccess																				 
																						 )
																			,if(IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,false,Event_IsScrubErrors,false).FieldsInvalidPerScrubs
																				 )			 
																			)
														 ,sequential( write_fail_main		//if it fails on  main file threshold ,still writing mapped files!
																				 ,write_fail_event
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
											   ,Event_All
												 ,Main_All	
										);
										
		//Validating the filedate entered is within 30 days			
    isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		result		 			:= if ( isFileDateValid
														,mapIN
														,sequential (Corp2_Mapping.Send_Email(state_origin ,filedate).InvalidFileDateParm
																				 ,FAIL('Corp2_Mapping.IN failed.  An invalid filedate was passed in as a parameter.')
																				)
														);
		return result;

 end;	// end of Update function

end;  // end of Module
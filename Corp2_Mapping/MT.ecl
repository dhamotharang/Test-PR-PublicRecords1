import _control,corp2,corp2_mapping,corp2_raw_mt,scrubs, scrubs_corp2_mapping_mt_main,tools,ut,versioncontrol,std;

Export MT := module;  
	
	Export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := Function

		state_origin			:= 'MT';
		state_fips	 			:= '30';
		state_desc	 			:= 'MONTANA';
		
		// Vendor Input Files 
		f01_Business       	 	 := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.f01_Business,          hash(businessentitytypecd,businessentityno)),record,local),record,local): independent;
		f02_BusinessName       := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.f02_BusinessName,      hash(businessentitytypecd,businessentityno)),record,local),record,local): independent;
		f03_OfficerPartner     := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.f03_OfficerPartner,    hash(businessentitytypecd,businessentityno)),record,local),record,local): independent;
		f04_OfficerShareholder := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.f04_OfficerShareholder,hash(businessentitytypecd,businessentityno)),record,local),record,local): independent;
		f05_RelatedBusiness    := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.f05_RelatedBusiness,   hash(businessentitytypecd,businessentityno)),record,local),record,local): independent;
		f06_AgentOwner       	 := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.f06_AgentOwner,        hash(businessentitytypecd,businessentityno)),record,local),record,local): independent;
		f07_AssumedBusName     := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.f07_AssumedBusName,    hash(businessentitytypecd,businessentityno)),record,local),record,local): independent;
		f08_ForeignBusiness    := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.f08_ForeignBusiness,   hash(businessentitytypecd,businessentityno)),record,local),record,local): independent;
		f09_Trademarks       	 := dedup(sort(distribute(Corp2_Raw_MT.Files(fileDate,puseprod).Input.f09_Trademarks,        hash(businessentitytypecd,businessentityno)),record,local),record,local): independent;
		
		
		//********************************************************************
		// Perform Joins to create file that Corporations will be mapped from
		//********************************************************************
		Business									 := join(f01_Business, f02_BusinessName,
																			 corp2.t2u(left.businessentitytypecd) = corp2.t2u(right.businessentitytypecd) and
																			 corp2.t2u(left.businessentityno) = corp2.t2u(right.businessentityno),
																			 transform(corp2_raw_mt.layouts.TempBusinessLayoutIn,
																								 self := left; self := right; self := [];),
																			 left outer,	local);

		Corporations   						 := join(Business, f08_ForeignBusiness,
																			 corp2.t2u(left.businessentitytypecd) = corp2.t2u(right.businessentitytypecd) and
																			 corp2.t2u(left.businessentityno) = corp2.t2u(right.businessentityno),
																			 transform(corp2_raw_mt.layouts.TempBusinessLayoutIn,
																								 self.kf_qual_file_dt     			:= right.kf_qual_file_dt;
																								 self.kf_st_addr_ln1 						:= right.kf_st_addr_ln1;
																								 self.kf_city_nm       					:= right.kf_city_nm;
																								 self.kf_state_nm_shr        		:= right.kf_state_nm_shr;
																								 self.kf_zip_cd_x        				:= right.kf_zip_cd_x;
																								 self.kf_addr_ln4    						:= right.kf_addr_ln4;
																								 self.kf_jurs_cntry     				:= right.kf_jurs_cntry;
																								 self.kf_tot_busn_rect     			:= right.kf_tot_busn_rect;
																								 self.kf_mt_busn_rect 					:= right.kf_mt_busn_rect;
																								 self.kf_tot_prop_val       		:= right.kf_tot_prop_val;
																								 self.kf_mt_prop_val        		:= right.kf_mt_prop_val;
																								 self.kf_pct_empl_mt        		:= right.kf_pct_empl_mt;																						 
																								 self := left; self := right; self := [];),
																				left outer,	local);

  	CorporationRA  							:= join(Corporations, f06_AgentOwner(businessentitytypecd in ['C','D','E','F','L','N']),
																			  corp2.t2u(left.businessentitytypecd) = corp2.t2u(right.businessentitytypecd) and
																			  corp2.t2u(left.businessentityno) = corp2.t2u(right.businessentityno),
																			  transform(corp2_raw_mt.layouts.TempBusinessLayoutIn,
																				          self.kd_agnt_ownr_nm              := right.kd_agnt_ownr_nm;
																									self.kd_st_addr_ln1               := right.kd_st_addr_ln1;
																									self.kd_st_addr_ln2               := right.kd_st_addr_ln2;
																									self.kd_city_nm                   := right.kd_city_nm;
																									self.kd_state_nm_shr              := right.kd_state_nm_shr;
																									self.kd_zip_cd_x                  := right.kd_zip_cd_x;
																									self.agentStatusCode              := right.businessstatuscd;
																								  self := left; self := right; self := [];),
																				 left outer, local);
																				
		CorpAssumedBusName      	 := join(CorporationRA, f07_AssumedBusName,
																			 corp2.t2u(left.businessentitytypecd) = corp2.t2u(right.businessentitytypecd) and
																			 corp2.t2u(left.businessentityno) = corp2.t2u(right.businessentityno),																			 transform(Corp2_Raw_MT.Layouts.TempBusinessLayoutIn,
																								 self.ke_abn_cnty			 							:= right.ke_abn_cnty;
																								 self.ke_abn_fst_use_mt			 				:= right.ke_abn_fst_use_mt;
																								 self.ke_fold_loc			 							:= right.ke_fold_loc;
																								 self.ke_abn_purp_desc			 				:= right.ke_abn_purp_desc;
																								 self := left; self := right; self := [];),
																			 left outer, local) : independent;

		All_Corporations			    	:= join(CorpAssumedBusName, f09_Trademarks,
																			 corp2.t2u(left.businessentitytypecd) = corp2.t2u(right.businessentitytypecd) and
																			 corp2.t2u(left.businessentityno) = corp2.t2u(right.businessentityno),
																			 transform(Corp2_Raw_MT.Layouts.TempBusinessLayoutIn,
																								 self.kg_tm_fst_use_mt   			 			:= right.kg_tm_fst_use_mt;
																								 self.kg_tm_fst_use_any   			 		:= right.kg_tm_fst_use_any;
																								 self.kg_tm_rnwl_dt   			 				:= right.kg_tm_rnwl_dt;
																								 self.kg_tm_cls1           		 			:= right.kg_tm_cls1;
																								 self.kg_tm_cls2           		 			:= right.kg_tm_cls2;
																								 self.kg_tm_cls3           		 			:= right.kg_tm_cls3;
																								 self.kg_tm_cls4           		 			:= right.kg_tm_cls4;
																								 self.kg_tm_cls5          		 			:= right.kg_tm_cls5;
																								 self.kg_tm_cls6          		 			:= right.kg_tm_cls6;
																								 self.kg_tm_cls7          					:= right.kg_tm_cls7;
																								 self.kg_tm_goods_desc 				 			:= right.kg_tm_goods_desc;
																								 self.kg_tm_use_desc        				:= right.kg_tm_use_desc;
																								 self.kg_fold_loc        	 					:= right.kg_fold_loc;
																								 self := left; self := right; self := [];),
																				 left outer, local) : independent;


		//********************************************************************
		// MAIN Corporations mapping
		//********************************************************************	
		corp2_mapping.LayoutsCommon.Main CorporationTransform(Corp2_Raw_MT.Layouts.TempBusinessLayoutIn l) := transform		
				self.dt_vendor_first_reported								:= (unsigned4)fileDate;
				self.dt_vendor_last_reported								:= (unsigned4)fileDate;
				self.dt_first_seen													:= (unsigned4)fileDate;
				self.dt_last_seen														:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen									:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen										:= (unsigned4)fileDate;			
				self.corp_key																:= state_fips + '-' + corp2.t2u(l.ka_busn_enty_char + l.ka_busn_enty_no);
				self.corp_vendor														:= state_fips;
				self.corp_state_origin											:= state_origin;			
				self.corp_process_date											:= fileDate;
				self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.ka_busn_enty_char + l.ka_busn_enty_no);									  									
				self.corp_legal_name                				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.kb_busn_enty_nm).BusinessName;
				self.corp_ln_name_type_cd           				:= map(corp2.t2u(l.ka_busn_enty_char) in ['C','D','E','F','L','N','P'] => '01',
																													 corp2.t2u(l.ka_busn_enty_char) = 'T' 													 => '03',
																													 corp2.t2u(l.ka_busn_enty_char) = 'A' 													 => '06',
																													 corp2.t2u(l.ka_busn_enty_char)); 
				self.corp_ln_name_type_desc								  := case(self.corp_ln_name_type_cd, '01'=>'LEGAL', '03'=>'TRADEMARK', '06'=>'ASSUMED BUSINESS NAME', ''); 
				self.corp_address1_type_cd          				:= if(corp2_mapping.faddressexists(state_origin,state_desc,l.kf_st_addr_ln1,,l.kf_city_nm,l.kf_state_nm_shr,l.kf_zip_cd_x,l.kf_addr_ln4).ifaddressexists,'B','');
				self.corp_address1_type_desc          			:= if(corp2_mapping.faddressexists(state_origin,state_desc,l.kf_st_addr_ln1,,l.kf_city_nm,l.kf_state_nm_shr,l.kf_zip_cd_x,l.kf_addr_ln4).ifaddressexists,'BUSINESS','');
				self.corp_address1_line1            				:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.kf_st_addr_ln1,,l.kf_city_nm,l.kf_state_nm_shr,l.kf_zip_cd_x,l.kf_addr_ln4).AddressLine1;
				self.corp_address1_line2            				:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.kf_st_addr_ln1,,l.kf_city_nm,l.kf_state_nm_shr,l.kf_zip_cd_x,l.kf_addr_ln4).AddressLine2;
				self.corp_address1_line3            				:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.kf_st_addr_ln1,,l.kf_city_nm,l.kf_state_nm_shr,l.kf_zip_cd_x,l.kf_addr_ln4).AddressLine3;
				self.corp_prep_addr1_line1            		 	:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.kf_st_addr_ln1,,l.kf_city_nm,l.kf_state_nm_shr,l.kf_zip_cd_x,l.kf_addr_ln4).PrepAddrLine1;
				self.corp_prep_addr1_last_line          	 	:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.kf_st_addr_ln1,,l.kf_city_nm,l.kf_state_nm_shr,l.kf_zip_cd_x,l.kf_addr_ln4).PrepAddrLastLine;
				
				// Per Rosemary, made changes to the mapping of corp_inc_date, corp_forgn_date, and corp_filing_date
				incrpDt         := corp2_mapping.fvalidatedate(l.ka_incrp_dt,'MMDDCCYY').PastDate;
				qual_OR_incrpDt := if( corp2_mapping.fvalidatedate(l.kf_qual_file_dt,'MMDDCCYY').PastDate <> ''
															,corp2_mapping.fvalidatedate(l.kf_qual_file_dt,'MMDDCCYY').PastDate
															,incrpDt);
				filDt					  := corp2_mapping.fvalidatedate(l.ka_file_dt,'CCYYMMDD').PastDate;
															
				self.corp_inc_date                          := map( corp2.t2u(l.ka_jurs_stt) = state_origin and corp2.t2u(l.ka_busn_enty_char) not in ['L','P']                 => incrpDt
																													 ,corp2.t2u(l.ka_jurs_stt) = '' and corp2.t2u(l.ka_busn_enty_char) not in ['E','F','N','L','P','C','D']       => incrpDt
																													 ,corp2.t2u(l.ka_jurs_stt) in [state_origin,''] and corp2.t2u(l.ka_busn_enty_char) in ['L','P','C','D']       => filDt
																													 ,'' );
				self.corp_forgn_date                        := map( corp2.t2u(l.ka_jurs_stt) = '' and corp2.t2u(l.ka_busn_enty_char) in ['E','F','N'] and qual_OR_incrpDt <> '' => qual_OR_incrpDt
																													 ,corp2.t2u(l.ka_jurs_stt) = '' and corp2.t2u(l.ka_busn_enty_char) in ['E','F','N'] and qual_OR_incrpDt = ''  => filDt
																													 ,corp2.t2u(l.ka_jurs_stt) not in [state_origin,''] and corp2.t2u(l.ka_busn_enty_char) not in ['L','P']       => qual_OR_incrpDt
																													 ,corp2.t2u(l.ka_jurs_stt) not in [state_origin,''] and corp2.t2u(l.ka_busn_enty_char) in ['L','P']           => filDt
																													 ,'');
				self.corp_filing_date                       := if(corp2.t2u(l.ka_busn_enty_char) in ['A','T']
																													,corp2_mapping.fvalidatedate(l.ka_file_dt,'CCYYMMDD').PastDate
																													,if(corp2.t2u(l.ka_jurs_stt) not in [state_origin,'']
																															,corp2_mapping.fvalidatedate(l.ka_incrp_dt,'MMDDCCYY').PastDate
																															,''));	
				self.corp_filing_desc               			 	:= if(corp2.t2u(l.ka_busn_enty_char) <> 'A' and self.corp_filing_date <> '' 
																															,'HOME STATE REGISTRATION DATE' ,'');
				self.corp_foreign_domestic_ind						 	:= map(corp2.t2u(l.ka_busn_enty_char) in ['C','D']     																									 => 'D',
																													 corp2.t2u(l.ka_busn_enty_char) in ['E','F','N'] 																									 => 'F',
																													 corp2.t2u(l.ka_busn_enty_char) in ['L','P'] and corp2.t2u(l.ka_jurs_stt) in [state_origin,'']     => 'D',
																													 corp2.t2u(l.ka_busn_enty_char) in ['L','P'] and corp2.t2u(l.ka_jurs_stt) not in [state_origin,''] => 'F',
																													 '');
				self.corp_forgn_state_cd            			 	:= if(corp2.t2u(l.ka_jurs_stt) not in [state_origin,''] ,corp2.t2u(l.ka_jurs_stt) ,'');
				self.corp_forgn_state_desc          			 	:= corp2_raw_mt.functions.StateCodeTranslation(self.corp_forgn_state_cd);			
				self.corp_status_cd													:= if(corp2.t2u(l.ka_busn_sts) = '' ,corp2.t2u(l.ka_busn_sts_rsn) ,corp2.t2u(l.ka_busn_sts));
				self.corp_status_desc												:= map(corp2.t2u(l.ka_busn_sts) in ['A','ACT'] => 'ACTIVE',
																													 corp2.t2u(l.ka_busn_sts) in ['C','CAN'] => 'CANCELLED',
																													 corp2.t2u(l.ka_busn_sts) in [''] 			 => corp2_raw_mt.functions.StatusReasonCodeTable(l.ka_busn_sts_rsn),
																													 '');
				self.corp_standing                  				:= if(corp2.t2u(l.ka_busn_sts_rsn) in ['GDS','GSD','LGS'],'Y','');
				self.corp_status_comment            				:= if(corp2.t2u(l.ka_busn_sts) in ['A','ACT'] ,corp2_raw_mt.functions.StatusReasonCodeTable(l.ka_busn_sts_rsn) ,'');
				self.corp_inc_state                 			 	:= state_origin;
				self.corp_term_exist_cd             			 	:= map(corp2.t2u(l.ka_trm_exst_corp) in ['TERM']												 				 	 => '',
																													 corp2.t2u(l.ka_trm_exst_corp) in ['INFINITE','NO LIMIT','PEPR','PERP',
																																														 'PERPETUAL','PRPE','UNLIMITE','UNLIMITED']=> 'P',
																												   corp2_mapping.fvalidatedate(l.ka_enty_expr_dt,'MMDDCCYY').GeneralDate <> '' => 'D',
																													 (integer)l.ka_trm_exst_corp <> 0																						 => 'N',
																												   '');
				self.corp_term_exist_exp            		 	 	:= case(self.corp_term_exist_cd,
																														'P' => '',
																													  'D' => corp2_mapping.fvalidatedate(l.ka_enty_expr_dt,'MMDDCCYY').GeneralDate,
																													  'N' => if((integer)l.ka_trm_exst_corp <> 0, (string)(integer)l.ka_trm_exst_corp, ''),
																													  '');
				self.corp_term_exist_desc           			 	:= case(self.corp_term_exist_cd,
																														'P' => 'PERPETUAL',
																													  'D' => 'EXPIRATION DATE',
																													  'N' => 'NUMBER OF YEARS',
																													  '');				
				self.corp_orig_org_structure_cd     				:= if(corp2.t2u(l.businessentitytypecd) not in ['A','T'] ,corp2.t2u(l.ka_busn_enty_char) ,'');
				self.corp_orig_org_structure_desc   				:= corp2_raw_mt.functions.CorpOrigOrgStructureDesc(self.corp_orig_org_structure_cd);
				self.corp_orig_bus_type_cd         					:= if(corp2.t2u(l.ka_corp_typ) = '00' ,'' ,corp2.t2u(l.ka_corp_typ));  
				self.corp_orig_bus_type_desc        			 	:= corp2_raw_mt.functions.CorpOrigBusTypeDesc(self.corp_orig_bus_type_cd, if(corp2.t2u(l.ka_jurs_stt) in [state_origin,''],'D','F'));  
			  self.corp_acts															:= if(corp2.t2u(stringlib.stringfilterout(l.ka_mca_statute,'0 ')) <> '' ,corp2.t2u(l.ka_mca_statute) ,'');
				self.corp_ra_full_name               				:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.kd_agnt_ownr_nm).BusinessName;
				self.corp_agent_status_cd										:= corp2.t2u(l.agentStatusCode); 
				self.corp_agent_status_desc									:= case(corp2.t2u(l.agentStatusCode), 'A'=>'ACTIVE', 'C'=>'INACTIVE', '');
				self.corp_ra_address_type_cd        				:= if(corp2_mapping.faddressexists(state_origin,state_desc,l.kd_st_addr_ln1,l.kd_st_addr_ln2,l.kd_city_nm,l.kd_state_nm_shr,l.kd_zip_cd_x).ifaddressexists,'R','');
				self.corp_ra_address_type_desc      				:= if(self.corp_ra_address_type_cd<>'','REGISTERED OFFICE','');
				self.corp_ra_address_line1		      				:= if(self.corp_ra_address_type_cd<>'',corp2_mapping.fcleanaddress(state_origin,state_desc,l.kd_st_addr_ln1,l.kd_st_addr_ln2,l.kd_city_nm,l.kd_state_nm_shr,l.kd_zip_cd_x).AddressLine1,'');
				self.corp_ra_address_line2		      				:= if(self.corp_ra_address_type_cd<>'',corp2_mapping.fcleanaddress(state_origin,state_desc,l.kd_st_addr_ln1,l.kd_st_addr_ln2,l.kd_city_nm,l.kd_state_nm_shr,l.kd_zip_cd_x).AddressLine2,'');
				self.corp_ra_address_line3		      				:= if(self.corp_ra_address_type_cd<>'',corp2_mapping.fcleanaddress(state_origin,state_desc,l.kd_st_addr_ln1,l.kd_st_addr_ln2,l.kd_city_nm,l.kd_state_nm_shr,l.kd_zip_cd_x).AddressLine3,'');															
				self.ra_prep_addr_line1         					  := if(self.corp_ra_address_type_cd<>'',corp2_mapping.fcleanaddress(state_origin,state_desc,l.kd_st_addr_ln1,l.kd_st_addr_ln2,l.kd_city_nm,l.kd_state_nm_shr,l.kd_zip_cd_x).PrepAddrLine1,'');
				self.ra_prep_addr_last_line      					  := if(self.corp_ra_address_type_cd<>'',corp2_mapping.fcleanaddress(state_origin,state_desc,l.kd_st_addr_ln1,l.kd_st_addr_ln2,l.kd_city_nm,l.kd_state_nm_shr,l.kd_zip_cd_x).PrepAddrLastLine,'');
       	self.corp_dissolved_date										:= corp2_mapping.fvalidatedate(l.ka_dsl_invl_intn_dt,'MMDDCCYY').PastDate;
				self.corp_name_effective_date								:= corp2_mapping.fvalidatedate(l.ke_abn_fst_use_mt,'MMDDCCYY').GeneralDate; 
				self.corp_registered_counties								:= corp2_raw_mt.functions.CountyTable(l.ke_abn_cnty);
				self.corp_name_status_desc									:= case(corp2.t2u(l.businessstatuscd), 'A'=>'ACTIVE', 'C'=>'INACTIVE', '');
				self.corp_comment                           := if(corp2.t2u(l.kg_tm_use_desc) <> '', 'MANNER OF USE: ' + corp2.t2u(l.kg_tm_use_desc), '');
				self.corp_purpose														:= corp2_raw_mt.functions.CorpPurpose(l.ka_busn_purp_cd);  
				// Note: corp_comment & corp_purpose are new, not displayable fields so those fields will also go into corp_entity_desc like in the old mapper
				self.corp_entity_desc               				:= corp2_raw_mt.functions.CorpEntityDesc(l.kg_tm_goods_desc,self.corp_comment,self.corp_purpose);
				self.corp_trademark_first_use_date_in_state := corp2_mapping.fvalidatedate(l.kg_tm_fst_use_mt,'MMDDCCYY').PastDate;
				self.corp_trademark_first_use_date          := corp2_mapping.fvalidatedate(l.kg_tm_fst_use_any,'MMDDCCYY').PastDate;
        self.corp_trademark_renewal_date            := corp2_mapping.fvalidatedate(l.kg_tm_rnwl_dt,'MMDDCCYY').PastDate;				
				self.corp_trademark_class_desc1             := corp2_raw_mt.functions.TradeMarkClassCodeTable(l.kg_tm_cls1);
				self.corp_trademark_class_desc2             := corp2_raw_mt.functions.TradeMarkClassCodeTable(l.kg_tm_cls2);
				self.corp_trademark_class_desc3             := corp2_raw_mt.functions.TradeMarkClassCodeTable(l.kg_tm_cls3);
				self.corp_trademark_class_desc4             := corp2_raw_mt.functions.TradeMarkClassCodeTable(l.kg_tm_cls4);
				self.corp_trademark_class_desc5             := corp2_raw_mt.functions.TradeMarkClassCodeTable(l.kg_tm_cls5);
				self.corp_trademark_class_desc6             := corp2_raw_mt.functions.TradeMarkClassCodeTable(l.kg_tm_cls6);
				// Note: corp_dissolved_date, corp_trademark_first_use_date_in_state, corp_trademark_class_desc1 - 6, and corp_registered_counties
				//       are new, not displayable fields so those fields will also go into corp_addl_info like in the old mapper
				self.corp_addl_info												 	:= corp2_raw_mt.functions.CorpAddlInfo(l.ke_abn_purp_desc,l.ka_dsl_invl_intn_dt,l.kg_tm_fst_use_mt,
																																													 self.corp_trademark_class_desc1,self.corp_trademark_class_desc2,
																																													 self.corp_trademark_class_desc3,self.corp_trademark_class_desc4,
																																													 self.corp_trademark_class_desc5,self.corp_trademark_class_desc6,
																																													 self.corp_registered_counties);
				self.recordorigin													  := 'C';
				self																			  := l;
				self 																			  := [];
		end;
		
		MapCorp := project(All_Corporations, CorporationTransform(left));


		//********************************************************************
		// Perform Joins to create file that Contacts will be mapped from
		//********************************************************************
		
		Cont_RelBus  				 := project(f05_RelatedBusiness(businessentitytypecd ='C' and kh_busn_enty_rlt = 'L'),
																					transform(corp2_raw_mt.layouts.TempContactLayoutIn,
																					self.temp_title_cd           := 'RM';
																					self.temp_cont_address_line1 := left.kh_regis_mgr_addr_ln1;
																					self.temp_cont_address_line2 := left.kh_regis_mgr_addr_ln2;
																					self.temp_cont_city					 := left.kh_regis_mgr_city_nm;
																					self.temp_cont_state				 := left.kh_regis_mgr_state_nm_shr;
																					self.temp_cont_zip					 := left.kh_regis_mgr_zip_cd_x;
																					self.temp_cont_country			 := left.kh_regis_mgr_addr_ln4;
																					self := left; self := [];) );
			
		Cont_AgentOwner			 := project(f06_AgentOwner(businessentitytypecd in ['A','T','P']),
																					transform(corp2_raw_mt.layouts.TempContactLayoutIn,
																					self.temp_rectype							:= 'OWNER';																					
																					self.temp_cont_full_name			:= left.kd_agnt_ownr_nm;
																					self.temp_title_cd						:= '';
																					self.temp_cont_address_line1	:= left.kd_st_addr_ln1;
																					self.temp_cont_address_line2	:= left.kd_st_addr_ln2;
																					self.temp_cont_city						:= left.kd_city_nm;
																					self.temp_cont_state					:= left.kd_state_nm_shr;
																					self.temp_cont_zip						:= left.kd_zip_cd_x;
																					self.temp_cont_country				:= '';
																					self.temp_addl_info						:= map(corp2.t2u(left.kd_owner_type) = 'A' => 'OWNER TYPE: ASSOCIATION',
																																							 corp2.t2u(left.kd_owner_type) = 'C' => 'OWNER TYPE: CORPORATION',
																																							 corp2.t2u(left.kd_owner_type) = 'I' => 'OWNER TYPE: INDIVIDUAL',
																																							 corp2.t2u(left.kd_owner_type) = 'L' => 'OWNER TYPE: LIMITED LIABILITY COMPANY',
																																							 corp2.t2u(left.kd_owner_type) = 'O' => 'OWNER TYPE: OTHER',
																																							 corp2.t2u(left.kd_owner_type) = 'P' => 'OWNER TYPE: PARTNERSHIP',
																																							 '');
																					self := left; self := [];) );

		Cont_OfficerPart  	 := project(f03_OfficerPartner,
																					transform(corp2_raw_mt.layouts.TempContactLayoutIn,
																					self.temp_rectype							:= 'OFFICER';
																					self.temp_cont_full_name			:= trim(left.kk_name_first) + ' ' + trim(left.kk_name_initial) + ' ' + trim(left.kk_name_last);
																					self.temp_title_cd						:= left.kk_ofc_nm_typ;
																					self.temp_cont_address_line1	:= left.kk_st_addr_ln1;
																					self.temp_cont_address_line2	:= '';
																					self.temp_cont_city						:= left.kk_city_nm;
																					self.temp_cont_state					:= left.kk_state_nm_shr;
																					self.temp_cont_zip						:= left.kk_zip_cd_x;
																					self.temp_cont_country				:= left.kk_addr_ln4;
																					self.temp_addl_info						:= left.kk_indv_mgr_dscn_dt;
																					self := left; self := [];) );

		All_Contacts	 						 := Cont_RelBus + Cont_AgentOwner + Cont_OfficerPart;	

		//Join Corporation data with the Contact data 
		Contacts									 := join(Corporations, All_Contacts,
																			 corp2.t2u(left.businessentitytypecd) = corp2.t2u(right.businessentitytypecd) and
																			 corp2.t2u(left.businessentityno) = corp2.t2u(right.businessentityno),
																			 transform(corp2_raw_mt.layouts.TempContactLayoutIn,
																			           self.temp_rectype                := right.temp_rectype;
																								 self.temp_cont_full_name					:= if(right.temp_title_cd = 'RM', left.kb_busn_enty_nm, right.temp_cont_full_name);
																								 self.temp_title_cd               := right.temp_title_cd;
																								 self.temp_cont_address_line1			:= right.temp_cont_address_line1;
																								 self.temp_cont_address_line2			:= right.temp_cont_address_line2;
																								 self.temp_cont_city							:= right.temp_cont_city;
																								 self.temp_cont_state							:= right.temp_cont_state;
																								 self.temp_cont_zip								:= right.temp_cont_zip;
																								 self.temp_cont_country						:= right.temp_cont_country;
																								 self.temp_addl_info						  := right.temp_addl_info;
																								 self.kh_regis_mgr_dscn_dt        := right.kh_regis_mgr_dscn_dt;
																								 self := left; self := right; self := []; ),
																				 inner, local);


		//********************************************************************
		// MAIN Contacts mapping
		//********************************************************************
		corp2_mapping.LayoutsCommon.Main ContactTransform(Corp2_Raw_MT.Layouts.TempContactLayoutIn l) := transform
		  ,skip(corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.temp_cont_full_name).BusinessName in 
							['','VACANT','OPERATES WITHOUT','ABBREVIATED LIST','1 NONE STATED','NONE STATED','3 NONE STATED',
							 '2 NONE STATED','NONE LISTED','WITHOUT OPERATES','4 NONE STATED','*','ABBREVIATED LI ST',
							 'SAME AS SECR','OPERATES W/OUT','STATED NONE','NOT APPLICABLE','NOT REQUIRED','NONE NONE',
							 '2 NONE LISTED','1 NONE LISTED','3 NONE LISTED','DIRECTORS OPERATE WITHOUT'])
				self.dt_vendor_first_reported								:= (unsigned4)fileDate;
				self.dt_vendor_last_reported								:= (unsigned4)fileDate;
				self.dt_first_seen													:= (unsigned4)fileDate;
				self.dt_last_seen														:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen									:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen										:= (unsigned4)fileDate;			
				self.corp_key																:= state_fips + '-' + corp2.t2u(l.businessentitytypecd + l.businessentityno);
				self.corp_vendor														:= state_fips;
				self.corp_state_origin											:= state_origin;			
				self.corp_process_date											:= fileDate;
				self.corp_orig_sos_charter_nbr							:= corp2.t2u(l.businessentitytypecd + l.businessentityno);									  									
				self.corp_legal_name                				:= corp2_mapping.fcleanBusinessName(state_origin,state_desc,l.kb_busn_enty_nm).BusinessName;
				self.corp_inc_state                 				:= state_origin;
				self.cont_type_cd  		        							:= map(l.temp_rectype = 'OWNER' /* retained from old mapper */																        => 'O',
																													 l.temp_rectype = 'OFFICER' and corp2.t2u(l.temp_title_cd) in ['A','G','L','3','4','5','6','7'] => 'M',
																													 l.temp_rectype = 'OFFICER' and corp2.t2u(l.temp_title_cd) in ['D','P','Q','S','T','U','1','2']	=> 'O',
																													 '');	
				self.cont_type_desc  		    								:= map(l.temp_rectype = 'OWNER' /* retained from old mapper */=> 'OWNER',
																													 l.temp_rectype = 'OFFICER' and self.cont_type_cd = 'M' => 'MEMBERS/MANAGER/PARTNER',
																													 l.temp_rectype = 'OFFICER' and self.cont_type_cd = 'O' => 'OFFICER',
																													 '');
				self.cont_full_name    	 	        					:= corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.temp_cont_full_name).BusinessName;
				self.cont_status_cd													:= corp2.t2u(l.businessstatuscd);  
				self.cont_status_desc												:= case(corp2.t2u(l.businessstatuscd), 'A'=>'ACTIVE', 'C'=>'INACTIVE', '');																													 
				self.cont_title1_desc		    								:= corp2_raw_mt.functions.ContTitle1Desc(l.temp_title_cd);
				self.cont_address_type_cd          					:= if(corp2_mapping.faddressexists(state_origin,state_desc,l.temp_cont_address_line1,l.temp_cont_address_line2,l.temp_cont_city,l.temp_cont_state,l.temp_cont_zip,l.temp_cont_country).ifaddressexists,if(l.temp_title_cd = 'RM','RM','T'),'');
				self.cont_address_type_desc          				:= if(corp2_mapping.faddressexists(state_origin,state_desc,l.temp_cont_address_line1,l.temp_cont_address_line2,l.temp_cont_city,l.temp_cont_state,l.temp_cont_zip,l.temp_cont_country).ifaddressexists,if(l.temp_title_cd = 'RM','REGISTERED MANAGER ADDRESS','CONTACT'),'');		
				self.cont_address_line1	            				:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.temp_cont_address_line1,l.temp_cont_address_line2,l.temp_cont_city,l.temp_cont_state,l.temp_cont_zip,l.temp_cont_country).AddressLine1;
				self.cont_address_line2	            				:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.temp_cont_address_line1,l.temp_cont_address_line2,l.temp_cont_city,l.temp_cont_state,l.temp_cont_zip,l.temp_cont_country).AddressLine2;
				self.cont_address_line3	            				:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.temp_cont_address_line1,l.temp_cont_address_line2,l.temp_cont_city,l.temp_cont_state,l.temp_cont_zip,l.temp_cont_country).AddressLine3;
				self.cont_prep_addr_line1	            			:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.temp_cont_address_line1,l.temp_cont_address_line2,l.temp_cont_city,l.temp_cont_state,l.temp_cont_zip,l.temp_cont_country).PrepAddrLine1;
				self.cont_prep_addr_last_line	           	 	:= corp2_mapping.fcleanaddress(state_origin,state_desc,l.temp_cont_address_line1,l.temp_cont_address_line2,l.temp_cont_city,l.temp_cont_state,l.temp_cont_zip,l.temp_cont_country).PrepAddrLastLine;
				self.cont_country                           := corp2_mapping.fCleanCountry(state_origin,state_desc,l.temp_cont_state,l.temp_cont_country).country;
				self.cont_addl_info             						:= if(l.temp_addl_info[1..11] = 'OWNER TYPE:'
																													,l.temp_addl_info
																													,if(corp2_mapping.fvalidatedate(l.temp_addl_info,'CCYYMMDD').PastDate <> '' /* retained from old mapper */
																															,'DISSOCIATION DATE: ' + corp2_mapping.fvalidatedate(l.temp_addl_info,'CCYYMMDD').PastDate
																															,''));
				self.cont_effective_date                    := corp2_mapping.fvalidatedate(l.kh_regis_mgr_dscn_dt,'CCYYMMDD').GeneralDate;
				self.cont_effective_cd                      := if(self.cont_effective_date <> '' ,'I' ,'');
				self.cont_effective_desc                    := if(self.cont_effective_date <> '' ,'INACTIVE' ,'');
				self.recordorigin														:= 'T';				
				self                            						:= l;
				self																				:= [];
		end;
		
		MapCont	:= project(Contacts,ContactTransform(left));	


		//********************************************************************
		// AR mapping
		//********************************************************************
		corp2_mapping.LayoutsCommon.AR ARTransform(Corp2_Raw_MT.Layouts.FileBusinessLayoutIn l) := transform,
		skip(corp2_mapping.fvalidatedate(l.ka_ar_lst_dt,'MMDDCCYY').PastDate = '' and
		     corp2_mapping.fvalidatedate(l.ka_ar_lst_file_dt,'MMDDCCYY').PastDate = '')
				self.corp_key							  := state_fips+'-'+corp2.t2u(l.businessentitytypecd) + corp2.t2u(l.businessentityno);
				self.corp_vendor						:= state_fips;		
				self.corp_state_origin			:= state_origin;
				self.corp_process_date			:= fileDate;
				self.corp_sos_charter_nbr		:= corp2.t2u(l.businessentitytypecd) + corp2.t2u(l.businessentityno);
				self.ar_report_dt           := corp2_mapping.fvalidatedate(l.ka_ar_lst_dt,'MMDDCCYY').PastDate;				
				self.ar_filed_dt            := corp2_mapping.fvalidatedate(l.ka_ar_lst_file_dt,'MMDDCCYY').PastDate;
			  self												:= [];
		end;
		
		AllAR 			:= project(f01_Business((integer)corp2.t2u(businessentityno) <> 0 ), ARTransform(left));
	
		//********************************************************************
		// STOCK mapping
		//********************************************************************
		corp2_mapping.LayoutsCommon.Stock StockTransform(Corp2_Raw_MT.Layouts.FileOfficerShareholderLayoutIn l) := transform
				self.corp_key								:= state_fips+'-'+corp2.t2u(l.businessentitytypecd) + corp2.t2u(l.businessentityno);
				self.corp_vendor						:= state_fips;		
				self.corp_state_origin			:= state_origin;
				self.corp_process_date			:= fileDate;
				self.corp_sos_charter_nbr		:= corp2.t2u(l.businessentitytypecd) + corp2.t2u(l.businessentityno);
				self.stock_type             := case(corp2.t2u(l.kj_auth_sh_cls), 'C'=>'COMMON', 'O'=>'OTHER', 'P'=>'PREFERRED' ,'');
				self.stock_class            := corp2_raw_mt.functions.stockClass(l.kj_auth_sh_sers);
				self.stock_addl_info     		:= if(corp2.t2u(l.kj_auth_sh_pv) in ['N','P']
																					,'AUTHORIZED SHARES: ' + case(corp2.t2u(l.kj_auth_sh_pv), 'N'=>'NO PAR VALUE', 'PAR VALUE') 
																					,'');			
        // Note: The old mapper mapped these fields, but they won't be mapped now since the vendor fields
				//   only contain unreadable characters: stock_authorized_nbr, stock_shares_issued, stock_par_value
				self																				:= [];
		end;
		
		AllStock	 	:= project(f04_OfficerShareholder((integer)corp2.t2u(businessentityno) <> 0 ),StockTransform(left));
		
		
	//-----------------------------------------------------------//
	// Build the Final Mapped Files
	//-----------------------------------------------------------//
		mapMain	 := dedup(sort(distribute(MapCorp + MapCont,hash(corp_key)) ,record,local) ,record,local) : independent;
		mapAR		 := dedup(sort(distribute(AllAR,hash(corp_key))             ,record,local) ,record,local) : independent;
		mapStock := dedup(sort(distribute(AllStock,hash(corp_key))          ,record,local) ,record,local) : independent;


	//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_MT_Main.Scrubs;        // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_MT'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_MT'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_MT'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_mt_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
    
		//Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MT_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MT_Main').SubmitStats;

		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MT_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MT_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpMain_MT Report' //subject
																																	 ,'Scrubs CorpMain_MT Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpMTMainScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );		
																																 
		Main_BadRecords := Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 			  			 <> 0 or
																							dt_vendor_last_reported_invalid 							 <> 0 or
																							dt_first_seen_invalid 												 <> 0 or
																							dt_last_seen_invalid 									  			 <> 0 or
																							corp_ra_dt_first_seen_invalid 								 <> 0 or
																							corp_ra_dt_last_seen_invalid 					  			 <> 0 or
																							corp_key_invalid 											  			 <> 0 or
																							corp_vendor_invalid 													 <> 0 or
																							corp_state_origin_invalid 					 					 <> 0 or
																							corp_process_date_invalid						    			 <> 0 or
																							corp_orig_sos_charter_nbr_invalid 						 <> 0 or
																							corp_legal_name_invalid 											 <> 0 or
																							corp_inc_state_invalid												 <> 0 or	
																						  corp_ln_name_type_cd_invalid									 <> 0 or
																							corp_filing_date_invalid 			  							 <> 0 or
																							corp_inc_date_invalid 												 <> 0 or
																							corp_forgn_date_invalid 											 <> 0 or
																							corp_foreign_domestic_ind_invalid			  			 <> 0 or
																							corp_forgn_state_desc_invalid  							 	 <> 0 or	
																							corp_term_exist_cd_invalid										 <> 0 or
																							corp_term_exist_exp_invalid						  			 <> 0 or
																							corp_orig_org_structure_cd_invalid						 <> 0 or
																							corp_orig_bus_type_cd_invalid			      			 <> 0 or
																							corp_purpose_invalid						        			 <> 0 or
																							corp_status_desc_invalid						    			 <> 0 or
																							corp_status_comment_invalid						  			 <> 0 or
																							corp_trademark_class_desc1_invalid						 <> 0 or
																							corp_trademark_class_desc2_invalid						 <> 0 or
																							corp_trademark_class_desc3_invalid						 <> 0 or
																							corp_trademark_class_desc4_invalid						 <> 0 or
																							corp_trademark_class_desc5_invalid						 <> 0 or
																							corp_trademark_class_desc6_invalid						 <> 0 or
																							corp_ra_resign_date_invalid						  			 <> 0 or
																							corp_dissolved_date_invalid						  			 <> 0 or
																							corp_name_effective_date_invalid							 <> 0 or
																							corp_ra_addl_info_invalid                      <> 0 or
																							corp_agent_status_cd_invalid				           <> 0 or
																							corp_trademark_first_use_date_in_state_invalid <> 0 or
																							corp_trademark_first_use_date_invalid					 <> 0 or
																							corp_trademark_renewal_date_invalid						 <> 0 or
																							corp_registered_counties_invalid			  			 <> 0 or
																							cont_status_cd_invalid                  			 <> 0 or
																						  cont_title1_desc_invalid                			 <> 0 or
																							recordorigin_invalid													 <> 0	);

		Main_GoodRecords	:= Main_T.ExpandedInFile(dt_vendor_first_reported_invalid 			  		 = 0 and
																							dt_vendor_last_reported_invalid 							 = 0 and
																							dt_first_seen_invalid 												 = 0 and
																							dt_last_seen_invalid 									  			 = 0 and
																							corp_ra_dt_first_seen_invalid 								 = 0 and
																							corp_ra_dt_last_seen_invalid 					 			   = 0 and
																							corp_key_invalid 											  			 = 0 and
																							corp_vendor_invalid 													 = 0 and
																							corp_state_origin_invalid 					 					 = 0 and
																							corp_process_date_invalid						   			   = 0 and
																							corp_orig_sos_charter_nbr_invalid 						 = 0 and
																							corp_legal_name_invalid 											 = 0 and
																							corp_inc_state_invalid												 = 0 and	
																						  corp_ln_name_type_cd_invalid									 = 0 and
																							corp_filing_date_invalid 			  							 = 0 and
																							corp_inc_date_invalid 												 = 0 and
																							corp_forgn_date_invalid 											 = 0 and
																							corp_foreign_domestic_ind_invalid			  			 = 0 and
																							corp_forgn_state_desc_invalid  								 = 0 and	
																							corp_term_exist_cd_invalid										 = 0 and
																							corp_term_exist_exp_invalid						  			 = 0 and
																							corp_orig_org_structure_cd_invalid						 = 0 and
																							corp_orig_bus_type_cd_invalid			      			 = 0 and
																							corp_purpose_invalid						        			 = 0 and
																							corp_status_desc_invalid						    		   = 0 and
																							corp_status_comment_invalid						  			 = 0 and
																							corp_trademark_class_desc1_invalid						 = 0 and
																							corp_trademark_class_desc2_invalid						 = 0 and
																							corp_trademark_class_desc3_invalid						 = 0 and
																							corp_trademark_class_desc4_invalid						 = 0 and
																							corp_trademark_class_desc5_invalid						 = 0 and
																							corp_trademark_class_desc6_invalid						 = 0 and
																							corp_ra_resign_date_invalid						  			 = 0 and
																							corp_dissolved_date_invalid						  			 = 0 and
																							corp_name_effective_date_invalid							 = 0 and
																							corp_ra_addl_info_invalid                      = 0 and
																							corp_agent_status_cd_invalid				    			 = 0 and
																							corp_trademark_first_use_date_in_state_invalid = 0 and
																							corp_trademark_first_use_date_invalid					 = 0 and
																							corp_trademark_renewal_date_invalid						 = 0 and
																							corp_registered_counties_invalid			  			 = 0 and
																							cont_status_cd_invalid                  			 = 0 and
																						  cont_title1_desc_invalid                			 = 0 and
																							recordorigin_invalid													 = 0	);																					 																	
		
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_MT_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_MT_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_MT_Main.Threshold_Percent.CORP_KEY      						=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_MT 		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::Main_MT',overwrite,__compressed__,named('Sample_Rejected_MainRecs_MT'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_MT'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainMTScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.MT - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues
																		,Main_SubmitStats);
																			 
	
 //-------------------- Version Control -----------------------------------------------------//	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_mt'			,Main_ApprovedRecords ,main_out		     ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_mt'			,MapStock	            ,stock_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_mt'				,MapAR		            ,ar_out			     ,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_mt'	,MapMain              ,write_fail_main ,,,pOverwrite);		
		
	mapMT:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
											 	,main_out
												,ar_out
												,stock_out										
												,IF(Main_FailBuild <> true 
												  	,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_MT')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::Main_MT')																		 
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_MT')
																				,if (count(Main_BadRecords) <> 0  
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR),,count(mapStock)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR),,count(mapStock)).MappingSuccess																				 
																						 )	 
																			)
														 ,sequential( write_fail_main //if it fails on main file threshold ,still writing mapped files!
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,if (Main_IsScrubErrors 
														,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors).FieldsInvalidPerScrubs)
												,Main_MT	
										);
															
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-31) and ut.date_math(filedate,31),true,false);
		return sequential (if (isFileDateValid 
														,mapMT
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.MT failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End MT Module
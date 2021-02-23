IMPORT corp2, corp2_mapping, corp2_raw_va, scrubs, scrubs_corp2_mapping_va_event,
			 scrubs_corp2_mapping_va_main, scrubs_corp2_mapping_va_stock, std,
			 tools, ut, versioncontrol;

EXPORT VA := MODULE; 

	EXPORT Update(STRING fileDate, STRING version, BOOLEAN pShouldSpray = Corp2_Mapping._Dataset().bShouldSpray, BOOLEAN pOverwrite = FALSE, pUseProd = Tools._Constants.IsDataland) := FUNCTION

		state_origin			:= 'VA';
		state_fips	 			:= '51';	
		state_desc	 			:= 'VIRGINIA';
		
    CorpsFile		 			:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.Corps.logical,HASH(corps_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		BTFile	 				  := DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.BT.logical,HASH(bt_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		GPFile 						:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.GP.logical,HASH(gp_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		LPFile 						:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.LP.logical,HASH(lp_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		AmendmtFile 			:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.Amendment.logical,HASH(amend_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		OfficersFile 			:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.Officer.logical,HASH(offc_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		NamesHistFile    	:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.NamesHist.logical,HASH(nmhist_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		MergersFile  			:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.Merger.logical,HASH(merg_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		ReservedFile 			:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.ResrvdName.logical,HASH(res_number)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		LLCFile      			:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.LLC.logical,HASH(llc_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		PSAFile      			:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.PSA.logical,HASH(psa_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		
		//********************************************************************
		//Join the CORPORATION file with the MERGERS file
		//******************************************************************** 	
			
		joinCorpsMrge	:= JOIN(CorpsFile, MergersFile,
													corp2.t2u(LEFT.corps_entity_id) = corp2.t2u(RIGHT.merg_entity_id),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempCorpsLayoutIn,
																		SELF.merg_type         := corp2.t2u(RIGHT.merg_type);
																		SELF.merg_eff_date     := corp2.t2u(RIGHT.merg_eff_date);
																		SELF.merg_surv_id      := corp2.t2u(RIGHT.merg_surv_id);
																		SELF						 	     := LEFT;
																		SELF						 		   := [];
																	 ),
													LEFT OUTER
												 ) : INDEPENDENT;			
												 
		//********************************************************************
		//JOIN the LP file with the MERGERS file
		//******************************************************************** 	
		
		joinLPMrge	:= JOIN(LPFile, MergersFile,
													corp2.t2u(LEFT.lp_entity_id) = corp2.t2u(RIGHT.merg_entity_id),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempLPLayoutIn,
																		SELF.merg_type         := corp2.t2u(RIGHT.merg_type);
																		SELF.merg_eff_date     := corp2.t2u(RIGHT.merg_eff_date);
																		SELF.merg_surv_id      := corp2.t2u(RIGHT.merg_surv_id);
																		SELF						 	     := LEFT;
																		SELF						 		   := [];
																	 ),
													LEFT OUTER
												 ) : INDEPENDENT;			
												 
		//********************************************************************
		//Join the LLC file with the MERGERS file
		//*******************************************************************
		
		joinLLCMrge	:= JOIN(LLCFile, MergersFile,
													corp2.t2u(LEFT.llc_entity_id) = corp2.t2u(RIGHT.merg_entity_id),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempLLCLayoutIn,
																		SELF.merg_type         := corp2.t2u(RIGHT.merg_type);
																		SELF.merg_eff_date     := corp2.t2u(RIGHT.merg_eff_date);
																		SELF.merg_surv_id      := corp2.t2u(RIGHT.merg_surv_id);
																		SELF						 	     := LEFT;
																		SELF						 		   := [];
																	 ),
													LEFT OUTER
												 ) : INDEPENDENT;			
												 
													 
		//********************************************************************
		//PROJECT the AMENDMENT records for use in creating Event and
		//Stock records.	
		//******************************************************************** 
		Corp2_Raw_VA.Layouts.TempNormAmendLayoutIn transAmendment(Corp2_Raw_VA.Layouts.AmendmentLayoutIn l) := TRANSFORM
			SELF.amend_type         := corp2.t2u(l.amend_type1) +
			                           IF(corp2.t2u(l.amend_type2) <> '', '; ' + corp2.t2u(l.amend_type2), '') +
																 IF(corp2.t2u(l.amend_type3) <> '', '; ' + corp2.t2u(l.amend_type3), '') +
																 IF(corp2.t2u(l.amend_type4) <> '', '; ' + corp2.t2u(l.amend_type4), '') +
																 IF(corp2.t2u(l.amend_type5) <> '', '; ' + corp2.t2u(l.amend_type5), '') +
																 IF(corp2.t2u(l.amend_type6) <> '', '; ' + corp2.t2u(l.amend_type6), '') +
																 IF(corp2.t2u(l.amend_type7) <> '', '; ' + corp2.t2u(l.amend_type7), '') +
																 IF(corp2.t2u(l.amend_type8) <> '', '; ' + corp2.t2u(l.amend_type8), '');
			SELF.amend_stock_class  := corp2.t2u(l.amend_stock1);
			SELF.amend_stock_abbrv  := REGEXREPLACE('\\(.{1,}\\)',SELF.amend_stock_class,'');
			SELF.amend_stock_shares := REGEXFIND('\\(\\d{1,}\\)',SELF.amend_stock_class,0);
			SELF 							      := l;
			SELF							      := [];
		END;
		 
		AmendNormal 		:= PROJECT(AmendmtFile, transAmendment(LEFT));
			 
		AmendEvents 		:= AmendNormal(TRIM(amend_type,LEFT,RIGHT) <> '');
			 
		AmendStocks 		:= AmendNormal(TRIM(amend_stock_class,LEFT,RIGHT) <> '');							
				
											 
		//********************************************************************
		//JOIN the CORPORATION & OFFICERS file 
		//******************************************************************** 	
		joinOffcrCorps	:= JOIN(OfficersFile, CorpsFile, 
														corp2.t2u(LEFT.offc_entity_id) = corp2.t2u(RIGHT.corps_entity_id) ,
														TRANSFORM(Corp2_Raw_VA.Layouts.TempOfficersCorpsLayoutIn,
																			SELF.corp_legal_name  := corp2.t2u(RIGHT.corps_name);
																			SELF						 	    := LEFT;
																			SELF						 		  := [];
																		 ),
														RIGHT OUTER
													 ) : INDEPENDENT;	
		
		fltrOffcrCorps := joinOffcrCorps(corp2.t2u(offc_entity_id) <> '');	
		//**************************************************************
		// MAIN MAPPING - CORPORATION File
		//**************************************************************
		Corp2_Mapping.LayoutsCommon.Main CorpsFileTrans(Corp2_Raw_VA.Layouts.TempCorpsLayoutIn l) := TRANSFORM
			SELF.dt_vendor_first_reported				:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported				:= (INTEGER)fileDate;
			SELF.dt_first_seen									:= (INTEGER)fileDate;
			SELF.dt_last_seen										:= (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen					:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen						:= (INTEGER)fileDate;			
			SELF.corp_key												:= state_fips + '-' + corp2.t2u(l.corps_entity_id);
			SELF.corp_vendor										:= state_fips;
			SELF.corp_state_origin							:= state_origin;			
			SELF.corp_process_date							:= fileDate;
			SELF.corp_orig_sos_charter_nbr			:= corp2.t2u(l.corps_entity_id);
			SELF.corp_legal_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.corps_name).BusinessName;
			SELF.corp_ln_name_type_cd       		:= '01';                                                                                                                                                    
			SELF.corp_ln_name_type_desc     		:= 'LEGAL'; 
			//Per CI do not map FN or US when in the corp_state field
			valid_state                         := IF(corp2.t2u(l.corps_state) NOT IN ['FN','US'],l.corps_state,'');
			SELF.corp_address1_type_cd					:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,valid_state,l.corps_zip).ifAddressExists,'B','');
			SELF.corp_address1_type_desc				:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,valid_state,l.corps_zip).ifAddressExists,'BUSINESS','');
			SELF.corp_address1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,valid_state,l.corps_zip).AddressLine1;
			SELF.corp_address1_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,valid_state,l.corps_zip).AddressLine2;
			SELF.corp_address1_line3						:= IF(corp2_raw_va.functions.Special_Codes(l.corps_incorp_state) or trim(self.corp_address1_line1 + self.corp_address1_line2,all)='','',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,valid_state,l.corps_zip).AddressLine3);
			SELF.corp_address1_effective_date		:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,valid_state,l.corps_zip).ifAddressExists,Corp2_Mapping.fValidateDate(l.corps_po_eff_date,'CCYY-MM-DD').GeneralDate,'');
			SELF.corp_status_desc								:= corp2_raw_va.functions.CorpStatusDesc(l.corps_status);			
			SELF.corp_status_date								:= Corp2_Mapping.fValidateDate(l.corps_status_date,'CCYY-MM-DD').PastDate;	
			SELF.corp_status_comment						:= corp2.t2u(l.corps_StatusReason);	
			SELF.corp_standing							    := IF(corp2.t2u(l.corps_StatusReason)='ACTIVE AND IN GOOD STANDING','Y',''); 
			SELF.corp_inc_state									:= state_origin;		
			SELF.corp_inc_date									:= IF(corp2.t2u(l.corps_incorp_state) = state_origin,Corp2_Mapping.fValidateDate(l.corps_incorp_date,'CCYY-MM-DD').PastDate,'');										   																							
			SELF.corp_term_exist_exp						:= Corp2_Mapping.fValidateDate(l.corps_duration,'CCYY-MM-DD').GeneralDate;
			SELF.corp_term_exist_cd							:= MAP(SELF.corp_term_exist_exp <> ''	            => 'D',
 																								 corp2.t2u(l.corps_duration) = '9999-12-31' => 'P',
																								 ''
																								 );
			SELF.corp_term_exist_desc						:= MAP(SELF.corp_term_exist_exp <> ''	            => 'EXPIRATION DATE',
																						     corp2.t2u(l.corps_duration) = '9999-12-31' => 'PERPETUAL',
																								 ''
																								 );
			SELF.corp_foreign_domestic_ind			:= IF(corp2.t2u(l.corps_incorp_state) IN [state_origin,''],'D','F');
			SELF.corp_forgn_state_cd						:= IF(corp2.t2u(l.corps_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.corps_incorp_state) IN ['FN','US']    => '',	
																								    corp2_raw_va.functions.Special_Codes(l.corps_incorp_state)        => '',
																										corp2_raw_va.functions.Valid_US_State_Codes(l.corps_incorp_state)	=> corp2.t2u(l.corps_incorp_state),
																										'**'
																									 ),''
																							  );
			SELF.corp_forgn_state_desc          := IF(corp2.t2u(l.corps_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.corps_incorp_state) IN ['FN','US']		 => '',																								
																										corp2_raw_va.functions.Special_Codes(l.corps_incorp_state)  			 => corp2.t2u(l.corps_incorp_state),
																										corp2_raw_va.functions.Valid_US_State_Codes(l.corps_incorp_state)  => corp2_raw_va.functions.State_Code_Translation(l.corps_incorp_state),
																										corp2_raw_va.functions.State_Code_Translation(l.corps_incorp_state)
																									 ),''
																							 );																					 
			SELF.corp_forgn_date								:= IF(corp2.t2u(l.corps_incorp_state) <> state_origin,Corp2_Mapping.fValidateDate(l.corps_incorp_date,'CCYY-MM-DD').PastDate,'');
			SELF.corp_orig_org_structure_desc 	:= MAP(corp2.t2u(l.corps_stock_ind) = 'S' => 'STOCK CORPORATION',
																								 corp2.t2u(l.corps_stock_ind) = 'N' => 'NON-STOCK CORPORATION',																								 
																								 ''
																								);
			Bar_pos         							      := StringLib.StringFind(trim(l.corps_industry_code,left,right),'-',1);//ex:20 - Banks And Credit Unions
			SELF.corp_orig_bus_type_cd					:= if(Bar_pos<>0,corp2.t2u(l.corps_industry_code[1..Bar_pos-1]),trim(l.corps_industry_code,all));			
			SELF.corp_orig_bus_type_desc   	   	:= if(Bar_pos<>0,corp2.t2u(l.corps_industry_code[Bar_pos+1..]),corp2_Raw_VA.Functions.CorpOrigBusTypeDesc(l.corps_industry_code)); 
			//OVERLOADED - The assessment information is placed here since there is no specific field for it.
			SELF.corp_addl_info									:= IF(corp2.t2u(l.corps_assess_ind) IN ['0','1','2','3','4'],'ASSESSMENT: ' + corp2_raw_va.functions.Corps_Assess_Ind_Translation(l.corps_assess_ind),'');
			SELF.corp_ra_full_name							:= IF(corp2.t2u(l.corps_ra_name)<>'EXEMPT FROM FILING',Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.corps_ra_name).BusinessName,'');
			SELF.corp_ra_effective_date					:= Corp2_Mapping.fValidateDate(l.corps_ra_eff_date,'CCYY-MM-DD').GeneralDate;
      SELF.corp_ra_address_type_cd   			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.corps_ra_street1,l.corps_ra_street2,l.corps_ra_city,l.corps_ra_state,l.corps_ra_zip).ifAddressExists,'R','');			
			SELF.corp_ra_address_type_desc			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.corps_ra_street1,l.corps_ra_street2,l.corps_ra_city,l.corps_ra_state,l.corps_ra_zip).ifAddressExists,'REGISTERED OFFICE','');
			SELF.corp_ra_address_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_ra_street1,l.corps_ra_street2,l.corps_ra_city,l.corps_ra_state,l.corps_ra_zip).AddressLine1;	
			SELF.corp_ra_address_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_ra_street1,l.corps_ra_street2,l.corps_ra_city,l.corps_ra_state,l.corps_ra_zip).AddressLine2;
			SELF.corp_ra_address_line3					:= if(trim(self.corp_ra_address_line1 + self.corp_ra_address_line2,all)='','',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_ra_street1,l.corps_ra_street2,l.corps_ra_city,l.corps_ra_state,l.corps_ra_zip).AddressLine3);																					 
			SELF.corp_prep_addr1_line1      		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,valid_state,l.corps_zip).PrepAddrLine1;																																		
			SELF.corp_prep_addr1_last_line 			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,valid_state,l.corps_zip).PrepAddrLastLine;
			SELF.ra_prep_addr_line1         		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_ra_street1,l.corps_ra_street2,l.corps_ra_city,l.corps_ra_state,l.corps_ra_zip).PrepAddrLine1;
			SELF.ra_prep_addr_last_line     		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_ra_street1,l.corps_ra_street2,l.corps_ra_city,l.corps_ra_state,l.corps_ra_zip).PrepAddrLastLine;
			//Since the vendor has not sent us a table with the correct RA County information we will not map it at this time
			//SELF.corp_agent_county							:= corp2_raw_va.functions.CorpRALocation(l.corps_ra_loc);			
			SELF.corp_agent_status_desc					:= corp2_raw_va.functions.CorpAgentStatusDesc(l.corps_ra_status);
			      //OVERLOADED - The ra status information is placed here since it is a status and not a title.			
			SELF.corp_ra_addl_info              := IF(SELF.corp_agent_status_desc <> '','AGENT\'S STATUS: ' + SELF.corp_agent_status_desc,'');
			SELF.corp_merger_effective_date			:= Corp2_Mapping.fValidateDate(l.merg_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_merged_corporation_id			:= corp2.t2u(l.merg_surv_id);
			SELF.corp_merger_indicator					:= MAP(corp2.t2u(l.merg_type) = 'N'  => 'N',
																								 corp2.t2u(l.merg_type) = 'S'  => 'S',
																								 ''
																								 );
			SELF.recordorigin										:= 'C';
			SELF 																:= [];
		END;		

		mapped_Main_CorpsFile := PROJECT(joinCorpsMrge,CorpsFileTrans(LEFT)) : INDEPENDENT;
		
		//**************************************************************
		// MAIN MAPPING - BT File
		//**************************************************************
		Corp2_Mapping.LayoutsCommon.Main BTFileTrans(Corp2_Raw_VA.Layouts.BTLayoutIn l) := TRANSFORM
			
			SELF.dt_vendor_first_reported				:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported				:= (INTEGER)fileDate;
			SELF.dt_first_seen									:= (INTEGER)fileDate;
			SELF.dt_last_seen										:= (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen					:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen						:= (INTEGER)fileDate;			
			SELF.corp_key												:= state_fips + '-' + corp2.t2u(l.bt_entity_id);
			SELF.corp_vendor										:= state_fips;
			SELF.corp_state_origin							:= state_origin;			
			SELF.corp_process_date							:= fileDate;
			SELF.corp_orig_sos_charter_nbr			:= corp2.t2u(l.bt_entity_id);
			SELF.corp_legal_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.bt_name).BusinessName;
			SELF.corp_ln_name_type_cd       		:= '01';                                                                                                                                                    
			SELF.corp_ln_name_type_desc     		:= 'LEGAL'; 
			//Per CI do not map FN or US when in the corp_state field
			valid_state                         := IF(corp2.t2u(l.bt_state) NOT IN ['FN','US'],l.bt_state,'');
			SELF.corp_address1_type_cd					:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.bt_street1,l.bt_street2,l.bt_city,valid_state,l.bt_zip).ifAddressExists,'B','');
			SELF.corp_address1_type_desc				:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.bt_street1,l.bt_street2,l.bt_city,valid_state,l.bt_zip).ifAddressExists,'BUSINESS','');
			SELF.corp_address1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.bt_street1,l.bt_street2,l.bt_city,valid_state,l.bt_zip).AddressLine1;
			SELF.corp_address1_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.bt_street1,l.bt_street2,l.bt_city,valid_state,l.bt_zip).AddressLine2;
			SELF.corp_address1_line3						:= IF(corp2_raw_va.functions.Special_Codes(l.bt_incorp_state)or trim(self.corp_address1_line1 + self.corp_address1_line2,all)='','',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.bt_street1,l.bt_street2,l.bt_city,valid_state,l.bt_zip).AddressLine3);
			SELF.corp_address1_effective_date		:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.bt_street1,l.bt_street2,l.bt_city,valid_state,l.bt_zip).ifAddressExists,Corp2_Mapping.fValidateDate(l.bt_PrinOffEff_Date,'CCYY-MM-DD').GeneralDate,'');
			SELF.corp_status_desc								:= corp2_raw_va.functions.CorpStatusDesc(l.bt_status);			
			SELF.corp_status_date								:= Corp2_Mapping.fValidateDate(l.bt_status_date,'CCYY-MM-DD').PastDate;
			SELF.corp_status_comment						:= corp2.t2u(l.bt_StatusReason);
			SELF.corp_inc_state									:= state_origin;		
			SELF.corp_inc_date									:= IF(corp2.t2u(l.bt_incorp_state) = state_origin,Corp2_Mapping.fValidateDate(l.bt_incorp_date,'CCYY-MM-DD').PastDate,'');										   																							
			SELF.corp_term_exist_exp						:= Corp2_Mapping.fValidateDate(l.bt_duration,'CCYY-MM-DD').GeneralDate;
			SELF.corp_term_exist_cd							:= MAP(SELF.corp_term_exist_exp <> ''	            => 'D',
 																								 corp2.t2u(l.bt_duration) = '9999-12-31' => 'P',

																								 ''
																								 );
			SELF.corp_term_exist_desc						:= MAP(SELF.corp_term_exist_exp <> ''	            => 'EXPIRATION DATE',
																						     corp2.t2u(l.bt_duration) = '9999-12-31' => 'PERPETUAL',
																								 ''
																								 );
			SELF.corp_foreign_domestic_ind			:= IF(corp2.t2u(l.bt_incorp_state) IN [state_origin,''],'D','F');
			SELF.corp_forgn_state_cd						:= IF(corp2.t2u(l.bt_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.bt_incorp_state) IN ['FN','US']    => '',	
																								    corp2_raw_va.functions.Special_Codes(l.bt_incorp_state)        => '',
																										corp2_raw_va.functions.Valid_US_State_Codes(l.bt_incorp_state)	=> corp2.t2u(l.bt_incorp_state),
																										'**'
																									 ),''
																							  );
			SELF.corp_forgn_state_desc          := IF(corp2.t2u(l.bt_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.bt_incorp_state) IN ['FN','US']		 => '',																								
																										corp2_raw_va.functions.Special_Codes(l.bt_incorp_state)  			 => corp2.t2u(l.bt_incorp_state),
																										corp2_raw_va.functions.Valid_US_State_Codes(l.bt_incorp_state) => corp2_raw_va.functions.State_Code_Translation(l.bt_incorp_state),
																										corp2_raw_va.functions.State_Code_Translation(l.bt_incorp_state)
																									 ),''
																							 );																			 
			SELF.corp_forgn_date								:= IF(corp2.t2u(l.bt_incorp_state) <> state_origin,Corp2_Mapping.fValidateDate(l.bt_incorp_date,'CCYY-MM-DD').PastDate,'');
  		SELF.corp_orig_org_structure_desc 	:= 'BUSINESS TRUST';
			Bar_pos         							      := StringLib.StringFind(trim(l.bt_industry_code,left,right),'-',1);//ex:20 - Banks And Credit Unions
			SELF.corp_orig_bus_type_cd					:= if(Bar_pos<>0,corp2.t2u(l.bt_industry_code[1..Bar_pos-1]),trim(l.bt_industry_code,all));			
			SELF.corp_orig_bus_type_desc   	   	:= if(Bar_pos<>0,corp2.t2u(l.bt_industry_code[Bar_pos+1..]),corp2_Raw_VA.Functions.CorpOrigBusTypeDesc(l.bt_industry_code)); 
			//OVERLOADED - The assessment information is placed here since there is no specific field for it.
			SELF.corp_addl_info									:= IF(corp2.t2u(l.bt_assess_ind) IN ['0','1','2','3','4'],'ASSESSMENT: ' + corp2_raw_va.functions.Corps_Assess_Ind_Translation(l.bt_assess_ind),'');
			SELF.corp_ra_full_name							:= IF(corp2.t2u(l.bt_ra_name)<>'EXEMPT FROM FILING',Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.bt_ra_name).BusinessName,'');
			SELF.corp_ra_effective_date					:= Corp2_Mapping.fValidateDate(l.bt_ra_eff_date,'CCYY-MM-DD').GeneralDate;
      SELF.corp_ra_address_type_cd   			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.bt_ra_street1,l.bt_ra_street2,l.bt_ra_city,l.bt_ra_state,l.bt_ra_zip).ifAddressExists,'R','');			
			SELF.corp_ra_address_type_desc			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.bt_ra_street1,l.bt_ra_street2,l.bt_ra_city,l.bt_ra_state,l.bt_ra_zip).ifAddressExists,'REGISTERED OFFICE','');
			SELF.corp_ra_address_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.bt_ra_street1,l.bt_ra_street2,l.bt_ra_city,l.bt_ra_state,l.bt_ra_zip).AddressLine1;	
			SELF.corp_ra_address_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.bt_ra_street1,l.bt_ra_street2,l.bt_ra_city,l.bt_ra_state,l.bt_ra_zip).AddressLine2;
			SELF.corp_ra_address_line3					:= if(trim(self.corp_ra_address_line1 + self.corp_ra_address_line2,all)='','',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.bt_ra_street1,l.bt_ra_street2,l.bt_ra_city,l.bt_ra_state,l.bt_ra_zip).AddressLine3);																					 
			SELF.corp_prep_addr1_line1      		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.bt_street1,l.bt_street2,l.bt_city,valid_state,l.bt_zip).PrepAddrLine1;																																		
			SELF.corp_prep_addr1_last_line 			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.bt_street1,l.bt_street2,l.bt_city,valid_state,l.bt_zip).PrepAddrLastLine;
			SELF.ra_prep_addr_line1         		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.bt_ra_street1,l.bt_ra_street2,l.bt_ra_city,l.bt_ra_state,l.bt_ra_zip).PrepAddrLine1;
			SELF.ra_prep_addr_last_line     		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.bt_ra_street1,l.bt_ra_street2,l.bt_ra_city,l.bt_ra_state,l.bt_ra_zip).PrepAddrLastLine;
			SELF.corp_agent_status_desc					:= corp2_raw_va.functions.CorpAgentStatusDesc(l.bt_ra_status);
			      //OVERLOADED - The ra status information is placed here since it is a status and not a title.			
			SELF.corp_ra_addl_info              := IF(SELF.corp_agent_status_desc <> '','AGENT\'S STATUS: ' + SELF.corp_agent_status_desc,'');
		  SELF.corp_merger_indicator					:= corp2.t2u(l.bt_Merger_Ind) ;
			SELF.recordorigin										:= 'C';
			SELF 																:= [];
		END;	
		
		mapped_Main_BTFile := PROJECT(BTFile,BTFileTrans(LEFT)) : INDEPENDENT;
		
		//**************************************************************
		// MAIN MAPPING - LP File
		//**************************************************************
		Corp2_Mapping.LayoutsCommon.Main LPFileTrans(Corp2_Raw_VA.Layouts.TempLPLayoutIn l) := TRANSFORM
			SELF.dt_vendor_first_reported				:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported				:= (INTEGER)fileDate;
			SELF.dt_first_seen									:= (INTEGER)fileDate;
			SELF.dt_last_seen										:= (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen					:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen						:= (INTEGER)fileDate;			
			SELF.corp_key												:= state_fips + '-' + corp2.t2u(l.lp_entity_id);
			SELF.corp_vendor										:= state_fips;
			SELF.corp_state_origin							:= state_origin;			
			SELF.corp_process_date							:= fileDate;
			SELF.corp_orig_sos_charter_nbr			:= corp2.t2u(l.lp_entity_id);
			SELF.corp_legal_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.lp_name).BusinessName;
			SELF.corp_ln_name_type_cd       		:= '01';                                                                                                                                                    
			SELF.corp_ln_name_type_desc     		:= 'LEGAL'; 
			//Per CI do not map FN or US when in the corp_state field
			valid_state                         := IF(corp2.t2u(l.lp_state) NOT IN ['FN','US'],l.lp_state,'');
			SELF.corp_address1_type_cd					:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,valid_state,l.lp_zip).ifAddressExists,'B','');
			SELF.corp_address1_type_desc				:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,valid_state,l.lp_zip).ifAddressExists,'BUSINESS','');
			SELF.corp_address1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,valid_state,l.lp_zip).AddressLine1;
			SELF.corp_address1_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,valid_state,l.lp_zip).AddressLine2;
			SELF.corp_address1_line3						:= IF(corp2_raw_va.functions.Special_Codes(l.lp_incorp_state)or trim(self.corp_address1_line1 + self.corp_address1_line2,all)='','',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,valid_state,l.lp_zip).AddressLine3);
			SELF.corp_address1_effective_date		:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,valid_state,l.lp_zip).ifAddressExists,Corp2_Mapping.fValidateDate(l.lp_po_eff_date,'CCYY-MM-DD').GeneralDate,'');
			SELF.corp_status_desc								:= corp2_raw_va.functions.CorpStatusDesc(l.lp_status);			
			SELF.corp_status_date								:= Corp2_Mapping.fValidateDate(l.lp_status_date,'CCYY-MM-DD').PastDate;		
			SELF.corp_status_comment						:= corp2.t2u(l.lp_StatusReason);
			SELF.corp_inc_state									:= state_origin;		
			SELF.corp_inc_date									:= IF(corp2.t2u(l.lp_incorp_state) = state_origin,Corp2_Mapping.fValidateDate(l.lp_incorp_date,'CCYY-MM-DD').PastDate,'');										   																							
			SELF.corp_term_exist_exp						:= Corp2_Mapping.fValidateDate(l.lp_duration,'CCYY-MM-DD').GeneralDate;
			SELF.corp_term_exist_cd							:= MAP(SELF.corp_term_exist_exp <> ''	         => 'D',
 																								 corp2.t2u(l.lp_duration) = '9999-12-31' => 'P',
																								 ''
																								 );
			SELF.corp_term_exist_desc						:= MAP(SELF.corp_term_exist_exp <> ''	         => 'EXPIRATION DATE',
																						     corp2.t2u(l.lp_duration) = '9999-12-31' => 'PERPETUAL',
																								 ''
																								 );
			SELF.corp_foreign_domestic_ind			:= IF(corp2.t2u(l.lp_incorp_state) IN [state_origin,''],'D','F');
			SELF.corp_forgn_state_cd						:= IF(corp2.t2u(l.lp_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.lp_incorp_state) IN ['FN','US']    => '',	
																								    corp2_raw_va.functions.Special_Codes(l.lp_incorp_state)        => '',
																										corp2_raw_va.functions.Valid_US_State_Codes(l.lp_incorp_state)	=> corp2.t2u(l.lp_incorp_state),
																										'**'
																									 ),''
																							  );
			SELF.corp_forgn_state_desc          := IF(corp2.t2u(l.lp_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.lp_incorp_state) IN ['FN','US']		 => '',																								
																										corp2_raw_va.functions.Special_Codes(l.lp_incorp_state)  			 => corp2.t2u(l.lp_incorp_state),
																										corp2_raw_va.functions.Valid_US_State_Codes(l.lp_incorp_state) => corp2_raw_va.functions.State_Code_Translation(l.lp_incorp_state),
																										corp2_raw_va.functions.State_Code_Translation(l.lp_incorp_state)
																									 ),''
																							 );																		 
			SELF.corp_forgn_date								:= IF(corp2.t2u(l.lp_incorp_state) <> state_origin,Corp2_Mapping.fValidateDate(l.lp_incorp_date,'CCYY-MM-DD').PastDate,'');
			SELF.corp_orig_org_structure_desc 	:= 'LIMITED PARTNERSHIP';
			Bar_pos         							      := StringLib.StringFind(trim(l.lp_industry_code,left,right),'-',1);//ex:20 - Banks And Credit Unions
			SELF.corp_orig_bus_type_cd					:= if(Bar_pos<>0,corp2.t2u(l.lp_industry_code[1..Bar_pos-1]),trim(l.lp_industry_code,all));			
			SELF.corp_orig_bus_type_desc   	   	:= if(Bar_pos<>0,corp2.t2u(l.lp_industry_code[Bar_pos+1..]),corp2_Raw_VA.Functions.CorpOrigBusTypeDesc(l.lp_industry_code)); 
			//OVERLOADED - The assessment information is placed here since there is not  a specific field for it.
			SELF.corp_addl_info									:= IF(corp2.t2u(l.lp_assess_ind) IN ['0','1','2','3','4'],'ASSESSMENT: ' + corp2_raw_va.functions.Corps_Assess_Ind_Translation(l.lp_assess_ind),'');
			SELF.corp_ra_full_name							:= IF(corp2.t2u(l.lp_ra_name)<>'EXEMPT FROM FILING',Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.lp_ra_name).BusinessName,'');
			SELF.corp_ra_effective_date					:= Corp2_Mapping.fValidateDate(l.lp_ra_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_ra_address_type_cd  			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_ra_street1,l.lp_ra_street2,l.lp_ra_city,l.lp_ra_state,l.lp_ra_zip).ifAddressExists,'R','');
			SELF.corp_ra_address_type_desc			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_ra_street1,l.lp_ra_street2,l.lp_ra_city,l.lp_ra_state,l.lp_ra_zip).ifAddressExists,'REGISTERED OFFICE','');
			SELF.corp_ra_address_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_ra_street1,l.lp_ra_street2,l.lp_ra_city,l.lp_ra_state,l.lp_ra_zip).AddressLine1;	
			SELF.corp_ra_address_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_ra_street1,l.lp_ra_street2,l.lp_ra_city,l.lp_ra_state,l.lp_ra_zip).AddressLine2;
			SELF.corp_ra_address_line3					:= if(trim(self.corp_ra_address_line1 + self.corp_ra_address_line2,all)='','',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_ra_street1,l.lp_ra_street2,l.lp_ra_city,l.lp_ra_state,l.lp_ra_zip).AddressLine3);																					 
			SELF.corp_prep_addr1_line1      		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,valid_state,l.lp_zip).PrepAddrLine1;																																		
			SELF.corp_prep_addr1_last_line 			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,valid_state,l.lp_zip).PrepAddrLastLine;
			SELF.ra_prep_addr_line1         		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_ra_street1,l.lp_ra_street2,l.lp_ra_city,l.lp_ra_state,l.lp_ra_zip).PrepAddrLine1;
			SELF.ra_prep_addr_last_line     		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_ra_street1,l.lp_ra_street2,l.lp_ra_city,l.lp_ra_state,l.lp_ra_zip).PrepAddrLastLine;
			//Since the vendor has not sent us a table with the correct RA County information we will not map it at this time
			//SELF.corp_agent_county							:= corp2_raw_va.functions.CorpRALocation(l.lp_ra_loc);			
			SELF.corp_agent_status_desc					:= corp2_raw_va.functions.CorpAgentStatusDesc(l.lp_ra_status);
			      //OVERLOADED - The ra status description is placed here since it is not a ra title.			
			SELF.corp_ra_addl_info              := IF(SELF.corp_agent_status_desc <> '','AGENT\'S STATUS: ' + SELF.corp_agent_status_desc,'');
			SELF.corp_merger_effective_date			:= Corp2_Mapping.fValidateDate(l.merg_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_merged_corporation_id			:= corp2.t2u(l.merg_surv_id);
			SELF.corp_merger_indicator					:= MAP(corp2.t2u(l.merg_type) = 'N'  => 'N',
																								 corp2.t2u(l.merg_type) = 'S'  => 'S',
																								 ''
																								 );
			SELF.recordorigin										:= 'C';
			SELF 																:= [];
		END;		

		mapped_Main_LPFile := PROJECT(joinLPMrge,LPFileTrans(LEFT)) : INDEPENDENT;
		
		//**************************************************************
		// MAIN MAPPING - GP File
		//**************************************************************
		Corp2_Mapping.LayoutsCommon.Main GPFileTrans(Corp2_Raw_VA.Layouts.GPLayoutIn l) := TRANSFORM
			SELF.dt_vendor_first_reported				:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported				:= (INTEGER)fileDate;
			SELF.dt_first_seen									:= (INTEGER)fileDate;
			SELF.dt_last_seen										:= (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen					:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen						:= (INTEGER)fileDate;			
			SELF.corp_key												:= state_fips + '-' + corp2.t2u(l.gp_entity_id);
			SELF.corp_vendor										:= state_fips;
			SELF.corp_state_origin							:= state_origin;			
			SELF.corp_process_date							:= fileDate;
			SELF.corp_orig_sos_charter_nbr			:= corp2.t2u(l.gp_entity_id);
			SELF.corp_legal_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.gp_name).BusinessName;
			SELF.corp_ln_name_type_cd       		:= '01';                                                                                                                                                    
			SELF.corp_ln_name_type_desc     		:= 'LEGAL'; 
			//Per CI do not map FN or US when in the corp_state field
			valid_state                         := IF(corp2.t2u(l.gp_state) NOT IN ['FN','US'],l.gp_state,'');
			SELF.corp_address1_type_cd					:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.gp_street1,l.gp_street2,l.gp_city,valid_state,l.gp_zip).ifAddressExists,'B','');
			SELF.corp_address1_type_desc				:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.gp_street1,l.gp_street2,l.gp_city,valid_state,l.gp_zip).ifAddressExists,'BUSINESS','');
			SELF.corp_address1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_street1,l.gp_street2,l.gp_city,valid_state,l.gp_zip).AddressLine1;
			SELF.corp_address1_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_street1,l.gp_street2,l.gp_city,valid_state,l.gp_zip).AddressLine2;
			SELF.corp_address1_line3						:= IF(corp2_raw_va.functions.Special_Codes(l.gp_incorp_state)or trim(self.corp_address1_line1 + self.corp_address1_line2,all)='','',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_street1,l.gp_street2,l.gp_city,valid_state,l.gp_zip).AddressLine3);
			SELF.corp_address1_effective_date		:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.gp_street1,l.gp_street2,l.gp_city,valid_state,l.gp_zip).ifAddressExists,Corp2_Mapping.fValidateDate(l.gp_PrinOffEff_Date,'CCYY-MM-DD').GeneralDate,'');
			SELF.corp_status_desc								:= corp2_raw_va.functions.CorpStatusDesc(l.gp_status);			
			SELF.corp_status_date								:= Corp2_Mapping.fValidateDate(l.gp_status_date,'CCYY-MM-DD').PastDate;			
			SELF.corp_inc_state									:= state_origin;		
			SELF.corp_status_comment						:= corp2.t2u(l.gp_StatusReason);	
			SELF.corp_inc_date									:= IF(corp2.t2u(l.gp_incorp_state) = state_origin,Corp2_Mapping.fValidateDate(l.gp_PrinOffEff_Date,'CCYY-MM-DD').PastDate,'');										   																							
			SELF.corp_term_exist_exp						:= Corp2_Mapping.fValidateDate(l.gp_duration,'CCYY-MM-DD').GeneralDate;
			SELF.corp_term_exist_cd							:= MAP(SELF.corp_term_exist_exp <> ''	         => 'D',
 																								 corp2.t2u(l.gp_duration) = '9999-12-31' => 'P',

																								 ''
																								 );
			SELF.corp_term_exist_desc						:= MAP(SELF.corp_term_exist_exp <> ''	         => 'EXPIRATION DATE',
																						     corp2.t2u(l.gp_duration) = '9999-12-31' => 'PERPETUAL',
																								 ''
																								 );
			SELF.corp_foreign_domestic_ind			:= IF(corp2.t2u(l.gp_incorp_state) IN [state_origin,''],'D','F');
			SELF.corp_forgn_state_cd						:= IF(corp2.t2u(l.gp_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.gp_incorp_state) IN ['FN','US']    => '',	
																								    corp2_raw_va.functions.Special_Codes(l.gp_incorp_state)        => '',
																										corp2_raw_va.functions.Valid_US_State_Codes(l.gp_incorp_state)	=> corp2.t2u(l.gp_incorp_state),
																										'**'
																									 ),''
																							  );
			SELF.corp_forgn_state_desc          := IF(corp2.t2u(l.gp_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.gp_incorp_state) IN ['FN','US']		 => '',																								
																										corp2_raw_va.functions.Special_Codes(l.gp_incorp_state)  			 => corp2.t2u(l.gp_incorp_state),
																										corp2_raw_va.functions.Valid_US_State_Codes(l.gp_incorp_state) => corp2_raw_va.functions.State_Code_Translation(l.gp_incorp_state),
																										corp2_raw_va.functions.State_Code_Translation(l.gp_incorp_state)
																									 ),''
																							 );																				 
			SELF.corp_forgn_date								:= IF(corp2.t2u(l.gp_incorp_state) <> state_origin,Corp2_Mapping.fValidateDate(l.gp_PrinOffEff_Date,'CCYY-MM-DD').PastDate,'');
			SELF.corp_orig_org_structure_desc 	:= 'GENERAL PARTNERSHIP';
			Bar_pos         							      := StringLib.StringFind(trim(l.gp_industry_code,left,right),'-',1);//ex:20 - Banks And Credit Unions
			SELF.corp_orig_bus_type_cd					:= if(Bar_pos<>0,corp2.t2u(l.gp_industry_code[1..Bar_pos-1]),trim(l.gp_industry_code,all));			
			SELF.corp_orig_bus_type_desc   	   	:= if(Bar_pos<>0,corp2.t2u(l.gp_industry_code[Bar_pos+1..]),corp2_Raw_VA.Functions.CorpOrigBusTypeDesc(l.gp_industry_code)); 
			//OVERLOADED - The assessment information is placed here since there is not  a specific field for it.
			SELF.corp_addl_info									:= IF(corp2.t2u(l.gp_assess_ind) IN ['0','1','2','3','4'],'ASSESSMENT: ' + corp2_raw_va.functions.Corps_Assess_Ind_Translation(l.gp_assess_ind),'');
			SELF.corp_ra_full_name							:= IF(corp2.t2u(l.gp_ra_name)<>'EXEMPT FROM FILING',Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.gp_ra_name).BusinessName,'');
			SELF.corp_ra_effective_date					:= Corp2_Mapping.fValidateDate(l.gp_ra_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_ra_address_type_cd  			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.gp_ra_street1,l.gp_ra_street2,l.gp_ra_city,l.gp_ra_state,l.gp_ra_zip).ifAddressExists,'R','');
			SELF.corp_ra_address_type_desc			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.gp_ra_street1,l.gp_ra_street2,l.gp_ra_city,l.gp_ra_state,l.gp_ra_zip).ifAddressExists,'REGISTERED OFFICE','');
			SELF.corp_ra_address_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_ra_street1,l.gp_ra_street2,l.gp_ra_city,l.gp_ra_state,l.gp_ra_zip).AddressLine1;	
			SELF.corp_ra_address_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_ra_street1,l.gp_ra_street2,l.gp_ra_city,l.gp_ra_state,l.gp_ra_zip).AddressLine2;
			SELF.corp_ra_address_line3					:= if(trim(self.corp_ra_address_line1 + self.corp_ra_address_line2,all)='','',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_ra_street1,l.gp_ra_street2,l.gp_ra_city,l.gp_ra_state,l.gp_ra_zip).AddressLine3);																					 
			SELF.corp_prep_addr1_line1      		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_street1,l.gp_street2,l.gp_city,valid_state,l.gp_zip).PrepAddrLine1;																																		
			SELF.corp_prep_addr1_last_line 			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_street1,l.gp_street2,l.gp_city,valid_state,l.gp_zip).PrepAddrLastLine;
			SELF.ra_prep_addr_line1         		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_ra_street1,l.gp_ra_street2,l.gp_ra_city,l.gp_ra_state,l.gp_ra_zip).PrepAddrLine1;
			SELF.ra_prep_addr_last_line     		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.gp_ra_street1,l.gp_ra_street2,l.gp_ra_city,l.gp_ra_state,l.gp_ra_zip).PrepAddrLastLine;
			SELF.corp_agent_status_desc					:= corp2_raw_va.functions.CorpAgentStatusDesc(l.gp_ra_status);
			//OVERLOADED - The ra status description is placed here since it is not a ra title.			
			SELF.corp_ra_addl_info              := IF(SELF.corp_agent_status_desc <> '','AGENT\'S STATUS: ' + SELF.corp_agent_status_desc,'');
			SELF.corp_merger_indicator					:= corp2.t2u(l.gp_Merger_Ind);
			SELF.recordorigin										:= 'C';
			SELF 																:= [];
		END;		

		mapped_Main_GPFile := PROJECT(GPFile,GPFileTrans(LEFT)) : INDEPENDENT;
		
		//**************************************************************
		// MAIN MAPPING - LLC File
		//**************************************************************
		Corp2_Mapping.LayoutsCommon.Main LLCFileTrans(Corp2_Raw_VA.Layouts.TempLLCLayoutIn l) := TRANSFORM
			SELF.dt_vendor_first_reported				:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported				:= (INTEGER)fileDate;
			SELF.dt_first_seen									:= (INTEGER)fileDate;
			SELF.dt_last_seen										:= (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen					:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen						:= (INTEGER)fileDate;			
			SELF.corp_key												:= state_fips + '-' + corp2.t2u(l.llc_entity_id);
			SELF.corp_vendor										:= state_fips;
			SELF.corp_state_origin							:= state_origin;			
			SELF.corp_process_date							:= fileDate;
			SELF.corp_orig_sos_charter_nbr			:= corp2.t2u(l.llc_entity_id);
			SELF.corp_legal_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.llc_name).BusinessName;
			SELF.corp_ln_name_type_cd       		:= '01';                                                                                                                                                    
			SELF.corp_ln_name_type_desc     		:= 'LEGAL'; 
			//Per CI do not map FN or US when in the corp_state field
			valid_state                         := IF(corp2.t2u(l.llc_state) NOT IN ['FN','US'],l.llc_state,'');
			SELF.corp_address1_type_cd					:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,valid_state,l.llc_zip).ifAddressExists,'B','');
			SELF.corp_address1_type_desc				:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,valid_state,l.llc_zip).ifAddressExists,'BUSINESS','');
			SELF.corp_address1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,valid_state,l.llc_zip).AddressLine1;
			SELF.corp_address1_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,valid_state,l.llc_zip).AddressLine2;
			SELF.corp_address1_line3						:= IF(corp2_raw_va.functions.Special_Codes(l.llc_incorp_state)or trim(self.corp_address1_line1 + self.corp_address1_line2,all)='','',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,valid_state,l.llc_zip).AddressLine3);
			SELF.corp_address1_effective_date		:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,valid_state,l.llc_zip).ifAddressExists,Corp2_Mapping.fValidateDate(l.llc_po_eff_date,'CCYY-MM-DD').GeneralDate,'');
			SELF.corp_status_desc								:= corp2_raw_va.functions.CorpStatusDesc(l.llc_status);			
			SELF.corp_status_date								:= Corp2_Mapping.fValidateDate(l.llc_status_date,'CCYY-MM-DD').PastDate;	
			SELF.corp_status_comment						:= corp2.t2u(l.llc_StatusReason);	
			SELF.corp_standing							    := IF(corp2.t2u(l.llc_StatusReason)='ACTIVE AND IN GOOD STANDING','Y',''); 
			SELF.corp_inc_state									:= state_origin;		
			SELF.corp_inc_date									:= IF(corp2.t2u(l.llc_incorp_state) = state_origin,Corp2_Mapping.fValidateDate(l.llc_incorp_date,'CCYY-MM-DD').PastDate,'');										   																							
			SELF.corp_term_exist_exp						:= Corp2_Mapping.fValidateDate(l.llc_duration,'CCYY-MM-DD').GeneralDate;
			SELF.corp_term_exist_cd							:= MAP(SELF.corp_term_exist_exp <> ''	          => 'D',
 																								 corp2.t2u(l.llc_duration) = '9999-12-31' => 'P',
																								 ''
																								 );
			SELF.corp_term_exist_desc						:= MAP(SELF.corp_term_exist_exp <> ''	          => 'EXPIRATION DATE',
																						     corp2.t2u(l.llc_duration) = '9999-12-31' => 'PERPETUAL',
																								 ''
																								 );
			SELF.corp_foreign_domestic_ind			:= IF(corp2.t2u(l.llc_incorp_state) IN [state_origin,''],'D','F');
			SELF.corp_forgn_state_cd						:= IF(corp2.t2u(l.llc_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.llc_incorp_state) IN ['FN','US']    => '',	
																								    corp2_raw_va.functions.Special_Codes(l.llc_incorp_state)        => '',
																										corp2_raw_va.functions.Valid_US_State_Codes(l.llc_incorp_state)	=> corp2.t2u(l.llc_incorp_state),
																										'**'
																									 ),''
																							  );
			SELF.corp_forgn_state_desc          := IF(corp2.t2u(l.llc_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.llc_incorp_state) IN ['FN','US']		 => '',																								
																										corp2_raw_va.functions.Special_Codes(l.llc_incorp_state)  			 => corp2.t2u(l.llc_incorp_state),
																										corp2_raw_va.functions.Valid_US_State_Codes(l.llc_incorp_state)  => corp2_raw_va.functions.State_Code_Translation(l.llc_incorp_state),
																										corp2_raw_va.functions.State_Code_Translation(l.llc_incorp_state)
																									 ),''
																							 );																			 
			SELF.corp_forgn_date								:= IF(corp2.t2u(l.llc_incorp_state) <> state_origin,Corp2_Mapping.fValidateDate(l.llc_incorp_date,'CCYY-MM-DD').PastDate,'');
			SELF.corp_orig_org_structure_desc 	:= 'LIMITED LIABILITY COMPANY';
			Bar_pos         							      := StringLib.StringFind(trim(l.llc_industry_code,left,right),'-',1);//ex:20 - Banks And Credit Unions
			SELF.corp_orig_bus_type_cd					:= if(Bar_pos<>0,corp2.t2u(l.llc_industry_code[1..Bar_pos-1]),trim(l.llc_industry_code,all));			
			SELF.corp_orig_bus_type_desc   	   	:= if(Bar_pos<>0,corp2.t2u(l.llc_industry_code[Bar_pos+1..]),corp2_Raw_VA.Functions.CorpOrigBusTypeDesc(l.llc_industry_code)); 
			//OVERLOADED - The assessment information is placed here since there is no specific field for this information.
			SELF.corp_addl_info									:= IF(corp2.t2u(l.llc_assess_ind) IN ['0','1','2','3','4'],'ASSESSMENT: ' + corp2_raw_va.functions.Corps_Assess_Ind_Translation(l.llc_assess_ind),'');
			SELF.corp_ra_full_name							:= IF(corp2.t2u(l.llc_ra_name)<>'EXEMPT FROM FILING',Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.llc_ra_name).BusinessName,'');
			SELF.corp_ra_effective_date					:= Corp2_Mapping.fValidateDate(l.llc_ra_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_ra_address_type_cd  			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.llc_ra_street1,l.llc_ra_street2,l.llc_ra_city,l.llc_ra_state,l.llc_ra_zip).ifAddressExists,'R','');
			SELF.corp_ra_address_type_desc			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.llc_ra_street1,l.llc_ra_street2,l.llc_ra_city,l.llc_ra_state,l.llc_ra_zip).ifAddressExists,'REGISTERED OFFICE','');
			SELF.corp_ra_address_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_ra_street1,l.llc_ra_street2,l.llc_ra_city,l.llc_ra_state,l.llc_ra_zip).AddressLine1;	
			SELF.corp_ra_address_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_ra_street1,l.llc_ra_street2,l.llc_ra_city,l.llc_ra_state,l.llc_ra_zip).AddressLine2;
			SELF.corp_ra_address_line3					:= if(trim(self.corp_ra_address_line1 + self.corp_ra_address_line2,all)='','',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_ra_street1,l.llc_ra_street2,l.llc_ra_city,l.llc_ra_state,l.llc_ra_zip).AddressLine3);																					 
			SELF.corp_prep_addr1_line1      		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,valid_state,l.llc_zip).PrepAddrLine1;																																		
			SELF.corp_prep_addr1_last_line 			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,valid_state,l.llc_zip).PrepAddrLastLine;
			SELF.ra_prep_addr_line1         		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_ra_street1,l.llc_ra_street2,l.llc_ra_city,l.llc_ra_state,l.llc_ra_zip).PrepAddrLine1;
			SELF.ra_prep_addr_last_line     		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_ra_street1,l.llc_ra_street2,l.llc_ra_city,l.llc_ra_state,l.llc_ra_zip).PrepAddrLastLine;
			//Since the vendor has not sent us a table with the correct RA County information we will not map it at this time
			//SELF.corp_agent_county							:= corp2_raw_va.functions.CorpRALocation(l.llc_ra_loc);				
			SELF.corp_agent_status_desc					:= corp2_raw_va.functions.CorpAgentStatusDesc(l.llc_ra_status);
			      //OVERLOADED - The ra status is placed here since it is no a ra title.			
			SELF.corp_ra_addl_info              := IF(SELF.corp_agent_status_desc <> '','AGENT\'S STATUS: ' + SELF.corp_agent_status_desc,'');
			SELF.corp_merger_effective_date			:= Corp2_Mapping.fValidateDate(l.merg_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_merged_corporation_id			:= corp2.t2u(l.merg_surv_id);
			SELF.corp_merger_indicator					:= MAP(corp2.t2u(l.merg_type) = 'N'  => 'N',
																								 corp2.t2u(l.merg_type) = 'S'  => 'S',
																								 ''
																								 );
			SELF.recordorigin										:= 'C';
			SELF 																:= [];
		END;		

		mapped_Main_LLCFile := PROJECT(joinLLCMrge,LLCFileTrans(LEFT)) : INDEPENDENT;
		
		//**************************************************************
		// MAIN MAPPING - PSA File
		//**************************************************************
		Corp2_Mapping.LayoutsCommon.Main PSAFileTrans(Corp2_Raw_VA.Layouts.PSALayoutIn l) := TRANSFORM
			SELF.dt_vendor_first_reported				:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported				:= (INTEGER)fileDate;
			SELF.dt_first_seen									:= (INTEGER)fileDate;
			SELF.dt_last_seen										:= (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen					:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen						:= (INTEGER)fileDate;			
			SELF.corp_key												:= state_fips + '-' + corp2.t2u(l.psa_entity_id);
			SELF.corp_vendor										:= state_fips;
			SELF.corp_state_origin							:= state_origin;			
			SELF.corp_process_date							:= fileDate;
			SELF.corp_orig_sos_charter_nbr			:= corp2.t2u(l.psa_entity_id);
			SELF.corp_legal_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.psa_name).BusinessName;
			SELF.corp_ln_name_type_cd       		:= '01';                                                                                                                                                    
			SELF.corp_ln_name_type_desc     		:= 'LEGAL'; 
			//Per CI do not map FN or US when in the corp_state field
			valid_state                         := IF(corp2.t2u(l.psa_state) NOT IN ['FN','US'],l.psa_state,'');
			SELF.corp_address1_type_cd					:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.psa_street1,l.psa_street2,l.psa_city,valid_state,l.psa_zip).ifAddressExists,'B','');
			SELF.corp_address1_type_desc				:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.psa_street1,l.psa_street2,l.psa_city,valid_state,l.psa_zip).ifAddressExists,'BUSINESS','');
			SELF.corp_address1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.psa_street1,l.psa_street2,l.psa_city,valid_state,l.psa_zip).AddressLine1;
			SELF.corp_address1_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.psa_street1,l.psa_street2,l.psa_city,valid_state,l.psa_zip).AddressLine2;
			SELF.corp_address1_line3						:= IF(corp2_raw_va.functions.Special_Codes(l.psa_incorp_state)or trim(self.corp_address1_line1 + self.corp_address1_line2,all)='','',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.psa_street1,l.psa_street2,l.psa_city,valid_state,l.psa_zip).AddressLine3);
			SELF.corp_address1_effective_date		:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.psa_street1,l.psa_street2,l.psa_city,valid_state,l.psa_zip).ifAddressExists,Corp2_Mapping.fValidateDate(l.psa_PrinOffEff_Date,'CCYY-MM-DD').GeneralDate,'');
			SELF.corp_status_desc								:= corp2_raw_va.functions.CorpStatusDesc(l.psa_status);			
			SELF.corp_status_date								:= Corp2_Mapping.fValidateDate(l.psa_status_date,'CCYY-MM-DD').PastDate;	
			SELF.corp_status_comment						:= corp2.t2u(l.psa_StatusReason);	
			SELF.corp_standing							    := IF(corp2.t2u(l.psa_StatusReason)='ACTIVE AND IN GOOD STANDING','Y',''); 
			SELF.corp_inc_state									:= state_origin;		
			SELF.corp_inc_date									:= IF(corp2.t2u(l.psa_incorp_state) = state_origin,Corp2_Mapping.fValidateDate(l.psa_incorp_date,'CCYY-MM-DD').PastDate,'');										   																							
			SELF.corp_term_exist_exp						:= Corp2_Mapping.fValidateDate(l.psa_duration,'CCYY-MM-DD').GeneralDate;
			SELF.corp_term_exist_cd							:= MAP(SELF.corp_term_exist_exp <> ''	          => 'D',
 																								 corp2.t2u(l.psa_duration) = '9999-12-31' => 'P',
																								 ''
																								 );
			SELF.corp_term_exist_desc						:= MAP(SELF.corp_term_exist_exp <> ''	          => 'EXPIRATION DATE',
																						     corp2.t2u(l.psa_duration) = '9999-12-31' => 'PERPETUAL',
																								 ''
																								 );
			SELF.corp_foreign_domestic_ind			:= IF(corp2.t2u(l.psa_incorp_state) IN [state_origin,''],'D','F');
			SELF.corp_forgn_state_cd						:= IF(corp2.t2u(l.psa_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.psa_incorp_state) IN ['FN','US']    => '',	
																								    corp2_raw_va.functions.Special_Codes(l.psa_incorp_state)        => '',
																										corp2_raw_va.functions.Valid_US_State_Codes(l.psa_incorp_state)	=> corp2.t2u(l.psa_incorp_state),
																										'**'
																									 ),''
																							  );
			SELF.corp_forgn_state_desc          := IF(corp2.t2u(l.psa_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.psa_incorp_state) IN ['FN','US']		 => '',																								
																										corp2_raw_va.functions.Special_Codes(l.psa_incorp_state)  			 => corp2.t2u(l.psa_incorp_state),
																										corp2_raw_va.functions.Valid_US_State_Codes(l.psa_incorp_state)  => corp2_raw_va.functions.State_Code_Translation(l.psa_incorp_state),
																										corp2_raw_va.functions.State_Code_Translation(l.psa_incorp_state)
																									 ),''
																							 );																					 
			SELF.corp_forgn_date								:= IF(corp2.t2u(l.psa_incorp_state) <> state_origin,Corp2_Mapping.fValidateDate(l.psa_incorp_date,'CCYY-MM-DD').PastDate,'');
			SELF.corp_orig_org_structure_desc 	:= 'PUBLIC SERVICE AUTHORITY';
			Bar_pos         							      := StringLib.StringFind(trim(l.psa_industry_code,left,right),'-',1);//ex:20 - Banks And Credit Unions
			SELF.corp_orig_bus_type_cd					:= if(Bar_pos<>0,corp2.t2u(l.psa_industry_code[1..Bar_pos-1]),trim(l.psa_industry_code,all));			
			SELF.corp_orig_bus_type_desc   	   	:= if(Bar_pos<>0,corp2.t2u(l.psa_industry_code[Bar_pos+1..]),corp2_Raw_VA.Functions.CorpOrigBusTypeDesc(l.psa_industry_code)); 
			//OVERLOADED - The assessment information is placed here since there is no specific field for this information.
			SELF.corp_addl_info									:= IF(corp2.t2u(l.psa_assess_ind) IN ['0','1','2','3','4'],'ASSESSMENT: ' + corp2_raw_va.functions.Corps_Assess_Ind_Translation(l.psa_assess_ind),'');
			SELF.corp_ra_full_name							:= IF(corp2.t2u(l.psa_ra_name)<>'EXEMPT FROM FILING',Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.psa_ra_name).BusinessName,'');
			SELF.corp_ra_effective_date					:= Corp2_Mapping.fValidateDate(l.psa_ra_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_ra_address_type_cd  			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.psa_ra_street1,l.psa_ra_street2,l.psa_ra_city,l.psa_ra_state,l.psa_ra_zip).ifAddressExists,'R','');
			SELF.corp_ra_address_type_desc			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.psa_ra_street1,l.psa_ra_street2,l.psa_ra_city,l.psa_ra_state,l.psa_ra_zip).ifAddressExists,'REGISTERED OFFICE','');
			SELF.corp_ra_address_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.psa_ra_street1,l.psa_ra_street2,l.psa_ra_city,l.psa_ra_state,l.psa_ra_zip).AddressLine1;	
			SELF.corp_ra_address_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.psa_ra_street1,l.psa_ra_street2,l.psa_ra_city,l.psa_ra_state,l.psa_ra_zip).AddressLine2;
			SELF.corp_ra_address_line3					:= if(trim(self.corp_ra_address_line1 + self.corp_ra_address_line2,all)='','',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.psa_ra_street1,l.psa_ra_street2,l.psa_ra_city,l.psa_ra_state,l.psa_ra_zip).AddressLine3);																					 
			SELF.corp_prep_addr1_line1      		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.psa_street1,l.psa_street2,l.psa_city,valid_state,l.psa_zip).PrepAddrLine1;																																		
			SELF.corp_prep_addr1_last_line 			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.psa_street1,l.psa_street2,l.psa_city,valid_state,l.psa_zip).PrepAddrLastLine;
			SELF.ra_prep_addr_line1         		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.psa_ra_street1,l.psa_ra_street2,l.psa_ra_city,l.psa_ra_state,l.psa_ra_zip).PrepAddrLine1;
			SELF.ra_prep_addr_last_line     		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.psa_ra_street1,l.psa_ra_street2,l.psa_ra_city,l.psa_ra_state,l.psa_ra_zip).PrepAddrLastLine;
			SELF.corp_agent_status_desc					:= corp2_raw_va.functions.CorpAgentStatusDesc(l.psa_ra_status);
			      //OVERLOADED - The ra status is placed here since it is no a ra title.			
			SELF.corp_ra_addl_info              := IF(SELF.corp_agent_status_desc <> '','AGENT\'S STATUS: ' + SELF.corp_agent_status_desc,'');
			SELF.corp_merger_indicator					:= corp2.t2u(l.psa_Merger_Ind);
			SELF.recordorigin										:= 'C';
			SELF 																:= [];
		END;		

		mapped_Main_PSAFile := PROJECT(PSAFile,PSAFileTrans(LEFT)) : INDEPENDENT;
		
		//**************************************************************
		// MAIN MAPPING - NAMES File
		//**************************************************************
		jNamesHistFile	:= join(NamesHistFile, CorpsFile, 
														corp2.t2u(left.nmhist_entity_id) = corp2.t2u(right.corps_entity_id),
														transform(Corp2_Raw_VA.Layouts.NamesHist_TempLay, 
																			 self.corps_entity_id   := right.corps_entity_id;
																			 self.corps_incorp_date := right.corps_incorp_date;
																			 self := left; self := right; ),
														local) : independent;
														
		Corp2_Mapping.LayoutsCommon.Main NamesHistFileTrans(Corp2_Raw_VA.Layouts.NamesHist_TempLay l) := TRANSFORM
			SELF.dt_vendor_first_reported				:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported				:= (INTEGER)fileDate;
			SELF.dt_first_seen									:= (INTEGER)fileDate;
			SELF.dt_last_seen										:= (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen					:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen						:= (INTEGER)fileDate;			
			SELF.corp_key												:= state_fips + '-' + corp2.t2u(l.nmhist_entity_id);
			SELF.corp_vendor										:= state_fips;
			SELF.corp_state_origin							:= state_origin;			
			SELF.corp_process_date							:= fileDate;
			SELF.corp_orig_sos_charter_nbr			:= corp2.t2u(l.nmhist_entity_id);
			SELF.corp_legal_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.nmhist_entity_name).BusinessName;
			SELF.corp_ln_name_type_cd       		:= MAP(corp2.t2u(l.nmhist_name_status) = '50' => 'F',
																								 corp2.t2u(l.nmhist_name_status) = '70' => 'P',                                                    
																								 ''
																								);		                                                                                                                                              
			SELF.corp_ln_name_type_desc     		:= MAP(corp2.t2u(l.nmhist_name_status) = '50' => 'FBN',
																								 corp2.t2u(l.nmhist_name_status) = '70' => 'PRIOR',                                                    
																								 ''
																								);		
			SELF.corp_inc_state									:= state_origin;		
			SELF.corp_name_effective_date    		:= Corp2_Mapping.fValidateDate(l.nmhist_name_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_inc_date									:= IF(corp2.t2u(l.corps_incorp_state) = state_origin,Corp2_Mapping.fValidateDate(l.corps_incorp_date,'CCYY-MM-DD').PastDate,'');										   																							
			SELF.corp_forgn_date								:= IF(corp2.t2u(l.corps_incorp_state) <> state_origin,Corp2_Mapping.fValidateDate(l.corps_incorp_date,'CCYY-MM-DD').PastDate,'');
			SELF.recordorigin										:= 'C';
			SELF 																:= [];
		END;		
		
		mapped_Main_NamesHistFile := PROJECT(jNamesHistFile,NamesHistFileTrans(LEFT)) : INDEPENDENT;


		//**************************************************************
		// MAIN MAPPING - RESERVED File
		//**************************************************************
		jReservedFile	:= join(ReservedFile, CorpsFile, 
													corp2.t2u(left.res_number) = corp2.t2u(right.corps_entity_id),
													transform(Corp2_Raw_VA.Layouts.Reserved_TempLay, 
																		 self.corps_entity_id   := right.corps_entity_id;
																		 self.corps_incorp_date := right.corps_incorp_date;
																		 self := left; self := right;),
													local) : independent;
													
		Corp2_Mapping.LayoutsCommon.Main ResrvdFileTrans(Corp2_Raw_VA.Layouts.Reserved_TempLay l) := TRANSFORM
			SELF.dt_vendor_first_reported				      := (INTEGER)fileDate;
			SELF.dt_vendor_last_reported				      := (INTEGER)fileDate;
			SELF.dt_first_seen									      := (INTEGER)fileDate;
			SELF.dt_last_seen										      := (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen					      := (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen						      := (INTEGER)fileDate;			
			SELF.corp_key												      := state_fips + '-' + corp2.t2u(l.res_number);
			SELF.corp_vendor										      := state_fips;
			SELF.corp_state_origin							      := state_origin;			
			SELF.corp_process_date							      := fileDate;
			SELF.corp_orig_sos_charter_nbr			      := corp2.t2u(l.res_number);
			SELF.corp_legal_name								      := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.res_name).BusinessName;
			SELF.corp_ln_name_type_cd       	      	:= MAP(corp2.t2u(l.res_status) = '60' => '09',
																											 corp2.t2u(l.res_status) = '61' => '07',                                                    
																											 ''
																											);		                                                                                                                                              
			SELF.corp_ln_name_type_desc            		:= MAP(corp2.t2u(l.res_status) = '60' => 'REGISTRATION',
																											 corp2.t2u(l.res_status) = '61' => 'RESERVED',                                                    
																											 ''
																											);		
			SELF.corp_inc_state									       := state_origin;		
			SELF.Corp_Name_Reservation_Expiration_Date := Corp2_Mapping.fValidateDate(l.res_exp_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_term_exist_exp						       := Corp2_Mapping.fValidateDate(l.res_exp_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_term_exist_cd							       := IF(SELF.corp_term_exist_exp <> '','D','');
			SELF.corp_term_exist_desc						       := IF(SELF.corp_term_exist_exp <> '','EXPIRATION DATE','');
			SELF.recordorigin										       := 'C';
			SELF 																       := [];
		END;		
		
		mapped_Main_ResvdFile := PROJECT(jReservedFile,ResrvdFileTrans(LEFT)) : INDEPENDENT;
			
		//**************************************************************
		// MAIN MAPPING for CONTACTS - CORPORATION & OFFICERS Files
		//**************************************************************
    Corp2_Mapping.LayoutsCommon.Main  Main_OfficersFileTrans(Corp2_Raw_VA.Layouts.TempOfficersCorpsLayoutIn l) := transform
			SELF.dt_vendor_first_reported								:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported								:= (INTEGER)fileDate;
			SELF.dt_first_seen													:= (INTEGER)fileDate;
			SELF.dt_last_seen														:= (INTEGER)fileDate;		
			SELF.corp_ra_dt_first_seen									:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen										:= (INTEGER)fileDate;		
			SELF.corp_key																:= state_fips + '-' + corp2.t2u(l.offc_entity_id);
			SELF.corp_vendor														:= state_fips;
			SELF.corp_state_origin											:= state_origin;											
			SELF.corp_process_date											:= fileDate;
			SELF.corp_orig_sos_charter_nbr							:= corp2.t2u(l.offc_entity_id);
			SELF.corp_legal_name												:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.corp_legal_name).BusinessName;
			SELF.corp_inc_state													:= state_origin;
			SELF.cont_full_name													:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.offc_last_name +', '+l.offc_first_name+' '+l.offc_middle_name).BusinessName;
			SELF.cont_title1_desc												:= corp2.t2u(l.offc_title);
			SELF.cont_type_cd														:= IF(SELF.cont_full_name <> '','F','');				
			SELF.cont_type_desc													:= IF(SELF.cont_full_name <> '','OFFICER','');
			SELF.recordorigin														:= 'T';																										
			SELF 																				:= [];						
		END;	

		mapped_Main_OfficersCont 	:= PROJECT(fltrOffcrCorps,Main_OfficersFileTrans(LEFT)) : INDEPENDENT;
		
		//**************************************************************
		// MAIN MAPPING for CONTACTS - RESERVED NAMES Files
		//**************************************************************
		Corp2_Mapping.LayoutsCommon.Main Main_ReservedContTransform(Corp2_Raw_VA.Layouts.ReservedLayoutIn l) := transform
			SELF.dt_vendor_first_reported								:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported								:= (INTEGER)fileDate;
			SELF.dt_first_seen													:= (INTEGER)fileDate;
			SELF.dt_last_seen														:= (INTEGER)fileDate;		
			SELF.corp_ra_dt_first_seen									:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen										:= (INTEGER)fileDate;
			SELF.corp_key																:= state_fips + '-' + corp2.t2u(l.res_number);
			SELF.corp_vendor														:= state_fips;
			SELF.corp_state_origin											:= state_origin;						
			SELF.corp_process_date											:= fileDate;
			SELF.corp_orig_sos_charter_nbr							:= corp2.t2u(l.res_number);
			SELF.corp_legal_name												:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.res_name).BusinessName;
			SELF.corp_inc_state													:= state_origin;																												
			SELF.cont_full_name													:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.res_requestor).BusinessName;
      SELF.cont_type_cd														:= MAP(corp2.t2u(l.res_status) = '60' => '02',
																												 corp2.t2u(l.res_status) = '61' => '01',                                                    
																												 ''
																												);				
			SELF.cont_type_desc													:= MAP(corp2.t2u(l.res_status) = '60' => 'REGISTRANT',
																												 corp2.t2u(l.res_status) = '61' => 'RESERVER',                                                    
																												 ''
																												);																			 
			
			SELF.cont_address_type_cd										:= MAP(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.res_street1,l.res_street2,l.res_city,l.res_state,l.res_zip).ifAddressExists and corp2.t2u(l.res_status) = '60' => '02',
																												 Corp2_Mapping.fAddressExists(state_origin,state_desc,l.res_street1,l.res_street2,l.res_city,l.res_state,l.res_zip).ifAddressExists and corp2.t2u(l.res_status) = '61' => '01',                                                    
																												 ''
																												);				
			SELF.cont_address_type_desc									:= MAP(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.res_street1,l.res_street2,l.res_city,l.res_state,l.res_zip).ifAddressExists and corp2.t2u(l.res_status) = '60' => 'REGISTRANT',
																												 Corp2_Mapping.fAddressExists(state_origin,state_desc,l.res_street1,l.res_street2,l.res_city,l.res_state,l.res_zip).ifAddressExists and corp2.t2u(l.res_status) = '61' => 'RESERVER',                                                    
																												 ''
																												);
			SELF.cont_address_line1											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.res_street1,l.res_street2,l.res_city,l.res_state,l.res_zip).AddressLine1;										 
      SELF.cont_address_line2											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.res_street1,l.res_street2,l.res_city,l.res_state,l.res_zip).AddressLine2;
			SELF.cont_address_line3											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.res_street1,l.res_street2,l.res_city,l.res_state,l.res_zip).AddressLine3;
			SELF.cont_prep_addr_line1      							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.res_street1,l.res_street2,l.res_city,l.res_state,l.res_zip).PrepAddrLine1;																																		
			SELF.cont_prep_addr_last_line 							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.res_street1,l.res_street2,l.res_city,l.res_state,l.res_zip).PrepAddrLastLine;
			SELF.recordorigin														:= 'T';																										
			SELF 																				:= [];						
		END;
		
		mapped_Main_ReservedCont := PROJECT(ReservedFile,Main_ReservedContTransform(LEFT)) : INDEPENDENT;			

 		mapped_All_Main					 := mapped_Main_CorpsFile + mapped_Main_LPFile       + mapped_Main_LLCFile      + mapped_Main_NamesHistFile + 
																mapped_Main_ResvdFile + mapped_Main_OfficersCont + mapped_Main_ReservedCont +
																mapped_Main_BTFile    + mapped_Main_GPFile       + mapped_Main_PSAFile ;

   		//mapped_All_Main					 := mapped_Main_BTFile    + mapped_Main_GPFile       + mapped_Main_PSAFile ; 
		AllMain        					 := DEDUP(SORT(mapped_All_Main,RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;		
		
		//**************************************************************
		// MAIN MAPPING for EVENTS 
		//**************************************************************
		
		//Filter out "known" bad records that that are not to be rejected by scrubs per the data insight team.
		mapMain									 := Corp2_Raw_VA.Filter.Main(AllMain);
		Corporations						 := mapMain(recordorigin = 'C');
		
		//To eliminate orphan "events" that do not have an associated corporation record,
		//joining with Corporations (the corporation records within mapMain). 
		AmendNormEvents					 := JOIN(Corporations,AmendEvents,
															  		 corp2.t2u(LEFT.corp_key[4..]) = corp2.t2u(RIGHT.amend_entity_id),
																		 TRANSFORM(Corp2_Raw_VA.Layouts.TempNormAmendLayoutIn,
																							 SELF := RIGHT;
																							 ),
																		 LEFT OUTER,
																		 LOCAL
																			);

		//********************************************************************
		//EVENT File Mapping from the AmendFile.
		//
		//Note: The Amend file contains all three (3) types of corporation
		//			data: Corporation, Limited Parnership, and Limited Liability
		//			Company.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Events Event_AmendNormTrans(Corp2_Raw_VA.Layouts.TempNormAmendLayoutIn l) := TRANSFORM
			SELF.corp_key																:= state_fips + '-' + corp2.t2u(l.amend_entity_id);
			SELF.corp_vendor														:= state_fips;
			SELF.corp_state_origin											:= state_origin;								
			SELF.corp_process_date											:= fileDate;
			SELF.corp_sos_charter_nbr										:= corp2.t2u(l.amend_entity_id);
			SELF.event_filing_date            					:= Corp2_Mapping.fValidateDate(l.amend_date,'CCYY-MM-DD').PastDate;
			SELF.event_date_type_cd           					:= IF(SELF.event_filing_date <> '','FIL','');
			SELF.event_date_type_desc         					:= IF(SELF.event_filing_date <> '','FILING','');
			SELF.event_filing_desc            					:= corp2.t2u(l.amend_type);	
			SELF.event_desc            					        := corp2.t2u(l.amend_stock_class);	//amend_stock1 has been mapped to amend_stock_class
			SELF 																				:= [];						
		END;

	
		mapped_Event_AmendFile		 := PROJECT(AmendNormEvents(corp2.t2u(corp_key) <> '51-'),Event_AmendNormTrans(LEFT));
		
		//********************************************************************
		//Event File Mapping from the mergersFile
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Events Event_MergersFileTrans(Corp2_Raw_VA.Layouts.MergersLayoutIn l) := TRANSFORM,
		SKIP(corp2.t2u(l.merg_entity_id)	    = '' OR 
		     (Corp2_Mapping.fValidateDate(l.merg_eff_date,'CCYY-MM-DD').PastDate = '' AND
				  corp2.t2u(l.merg_type) 				  = '' AND
				  corp2.t2u(l.merg_surv_id) 			= '')
				)
			SELF.corp_key																:= state_fips + '-' + corp2.t2u(l.merg_entity_id);
			SELF.corp_vendor														:= state_fips;
			SELF.corp_state_origin											:= state_origin;
			SELF.corp_process_date											:= fileDate;
			SELF.corp_sos_charter_nbr										:= corp2.t2u(l.merg_entity_id);
			SELF.event_filing_date            					:= Corp2_Mapping.fValidateDate(l.merg_eff_date,'CCYY-MM-DD').PastDate;
			SELF.event_date_type_cd           					:= 'MER';
			SELF.event_date_type_desc         					:= 'MERGER';
			SELF.event_desc                   					:= MAP(corp2.t2u(l.merg_type) = 'N' AND corp2.t2u(l.merg_surv_id) <> '' => 'MERGED TO: ' 			+ corp2.t2u(l.merg_surv_id),
																												 corp2.t2u(l.merg_type) = 'S' AND corp2.t2u(l.merg_surv_id) <> '' => 'SURVIVING CORP: ' + corp2.t2u(l.merg_surv_id),
																												 ''
																											  );
			SELF 																				:= [];						
		END;		

		mapped_Event_MergersFile := PROJECT(MergersFile,Event_MergersFileTrans(LEFT));
    mapped_All_Events        := mapped_Event_AmendFile + mapped_Event_MergersFile;
		
		mapEvents      					 := DEDUP(SORT(DISTRIBUTE(mapped_All_Events,HASH(corp_key)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;

    //********************************************************************
		//STOCK File Mapping from the corpsFile
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock  Stock_CorpsStockTrans(Corp2_Raw_VA.Layouts.CorpsLayoutIn l) := TRANSFORM,
		 SKIP(corp2.t2u(l.corps_total_shares)	IN ['','0'])
			SELF.corp_key											:= state_fips + '-' + corp2.t2u(l.corps_entity_id);
			SELF.corp_vendor									:= state_fips;
			SELF.corp_state_origin						:= state_origin;
			SELF.corp_process_date						:= fileDate;
			SELF.corp_sos_charter_nbr					:= corp2.t2u(l.corps_entity_id);
			SELF.stock_shares_issued          := corp2.t2u(l.corps_total_shares);	
			SELF.stock_class                  := corp2.t2u(l.corps_stock1);
			SELF 															:= [];
		END;

		mapped_Stock_CorpsFile    := PROJECT(CorpsFile,Stock_CorpsStockTrans(LEFT));

    //********************************************************************
		//STOCK File Mapping from the LPFile
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock  Stock_LPStockTrans(Corp2_Raw_VA.Layouts.LPLayoutIn l) := TRANSFORM,
		 SKIP(corp2.t2u(l.lp_total_shares) IN ['','0'])
			SELF.corp_key											:= state_fips + '-' + corp2.t2u(l.lp_entity_id);
			SELF.corp_vendor									:= state_fips;
			SELF.corp_state_origin						:= state_origin;
			SELF.corp_process_date						:= fileDate;
			SELF.corp_sos_charter_nbr					:= corp2.t2u(l.lp_entity_id);
			SELF.stock_shares_issued          := corp2.t2u(l.lp_total_shares);
			SELF.stock_class                  := corp2.t2u(l.lp_stock1);
			SELF 															:= [];
		END;

		mapped_Stock_LPFile     := PROJECT(LPFile,Stock_LPStockTrans(LEFT));
		
		//********************************************************************
		//STOCK File Mapping from the LLCFile
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock  Stock_LLCStockTrans(Corp2_Raw_VA.Layouts.LLCLayoutIn l) := TRANSFORM,
		 SKIP(corp2.t2u(l.llc_total_shares)	IN ['','0'])
			SELF.corp_key											:= state_fips + '-' + corp2.t2u(l.llc_entity_id);
			SELF.corp_vendor									:= state_fips;
			SELF.corp_state_origin						:= state_origin;
			SELF.corp_process_date						:= fileDate;
			SELF.corp_sos_charter_nbr					:= corp2.t2u(l.llc_entity_id);
			SELF.stock_shares_issued          := corp2.t2u(l.llc_total_shares);	
			SELF.stock_class                  := corp2.t2u(l.llc_stock1);
			SELF 															:= [];
		END;

		mapped_Stock_LLCFile  := PROJECT(LLCFile,Stock_LLCStockTrans(LEFT));
		
		//********************************************************************
		//STOCK File Mapping from the AmendFile that has been normalized
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock Stock_AmendStockNormTrans(Corp2_Raw_VA.Layouts.TempNormAmendLayoutIn l) := TRANSFORM
			SELF.corp_key											:= state_fips + '-' + corp2.t2u(l.amend_entity_id);
			SELF.corp_vendor									:= state_fips;
			SELF.corp_state_origin						:= state_origin;
			SELF.corp_process_date						:= fileDate;
			SELF.corp_sos_charter_nbr					:= corp2.t2u(l.amend_entity_id);
			SELF.stock_class                  := corp2.t2u(l.amend_stock_class);
			SELF.stock_change_date          	:= IF(l.amend_type = 'AMENDMENT OF STOCK',Corp2_Mapping.fValidateDate(l.amend_date,'CCYY-MM-DD').PastDate,'');
			SELF 															:= [];
		END;

		mapped_Stock_AmendFile 	:= PROJECT(AmendStocks,	Stock_AmendStockNormTrans(LEFT));
		
		//********************************************************************
		//STOCK File Mapping from the BTFile that has been normalized
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock  Stock_BTStockTrans(Corp2_Raw_VA.Layouts.BTLayoutIn l) := TRANSFORM,
		SKIP(corp2.t2u(l.bt_total_shares)	IN ['','0'])
			SELF.corp_key											:= state_fips + '-' + corp2.t2u(l.bt_entity_id);
			SELF.corp_vendor									:= state_fips;
			SELF.corp_state_origin						:= state_origin;
			SELF.corp_process_date						:= fileDate;
			SELF.corp_sos_charter_nbr					:= corp2.t2u(l.bt_entity_id);
			SELF.stock_shares_issued          := corp2.t2u(l.bt_total_shares);	
		//	SELF.stock_class                  := corp2.t2u(l.llc_stock1);
			SELF 															:= [];
		END;

		mapped_Stock_BTFile  := PROJECT(BTFile,Stock_BTStockTrans(LEFT));
		
		//********************************************************************
		//STOCK File Mapping from the GPFile that has been normalized
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock  Stock_GPStockTrans(Corp2_Raw_VA.Layouts.GPLayoutIn l) := TRANSFORM,
		SKIP(corp2.t2u(l.gp_total_shares)	IN ['','0'])
			SELF.corp_key											:= state_fips + '-' + corp2.t2u(l.gp_entity_id);
			SELF.corp_vendor									:= state_fips;
			SELF.corp_state_origin						:= state_origin;
			SELF.corp_process_date						:= fileDate;
			SELF.corp_sos_charter_nbr					:= corp2.t2u(l.gp_entity_id);
			SELF.stock_shares_issued          := corp2.t2u(l.gp_total_shares);
			SELF 															:= [];
		END;

		mapped_Stock_GPFile       := PROJECT(GPFile,Stock_GPStockTrans(LEFT));
	
		//********************************************************************
		//STOCK File Mapping from the PSAFile that has been normalized
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock  Stock_PSAStockTrans(Corp2_Raw_VA.Layouts.PSALayoutIn l) := TRANSFORM,
		SKIP(corp2.t2u(l.psa_total_shares)	IN ['','0'])
			SELF.corp_key											:= state_fips + '-' + corp2.t2u(l.psa_entity_id);
			SELF.corp_vendor									:= state_fips;
			SELF.corp_state_origin						:= state_origin;
			SELF.corp_process_date						:= fileDate;
			SELF.corp_sos_charter_nbr					:= corp2.t2u(l.psa_entity_id);
			SELF.stock_shares_issued          := corp2.t2u(l.psa_total_shares);	
			SELF 															:= [];
		END;

		mapped_Stock_PSAFile    := PROJECT(PSAFile,Stock_PSAStockTrans(LEFT));		
		
	  mapped_All_Stock				:= mapped_Stock_CorpsFile + mapped_Stock_LPFile + mapped_Stock_LLCFile + mapped_Stock_AmendFile +
															 mapped_Stock_BTFile    + mapped_Stock_GPFile + mapped_Stock_PSAFile ;

															 
		//mapped_All_Stock				:=  mapped_Stock_BTFile    + mapped_Stock_GPFile + mapped_Stock_PSAFile ;	
															 
		mapStocks      					:= DEDUP(SORT(DISTRIBUTE(mapped_All_Stock,HASH(corp_key)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;

	//********************************************************************
  // SCRUB EVENT
  //********************************************************************	
		Event_F := mapEvents;
		Event_S := Scrubs_Corp2_Mapping_VA_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary				:= OUTPUT(Event_U.SummaryStats, NAMED('Event_ErrorSummary_VA'+filedate));
		Event_ScrubErrorReport 		:= OUTPUT(CHOOSEN(Event_U.AllErrors, 1000), NAMED('Event_ScrubErrorReport_VA'+filedate));
		Event_SomeErrorValues			:= OUTPUT(CHOOSEN(Event_U.BadValues, 1000), NAMED('Event_SomeErrorValues_VA'+filedate));
		Event_IsScrubErrors		 		:= IF(COUNT(Event_U.AllErrors)<> 0,TRUE,FALSE);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= OUTPUT(Event_N.BitmapInfile,,'~thor_data::corp_va_event_scrubs_bits',OVERWRITE,COMPRESSED);	//long term storage
		Event_TranslateBitMap			:= OUTPUT(Event_T);

		//Submits Profile's stats to Orbit
		Event_SubmitStats 			 := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_VA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_VA_Event').SubmitStats;
		Event_ScrubsWithExamples := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_VA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_VA_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpEvent_VA Report' //subject
																																 ,'Scrubs CorpEvent_VA Report' //body
																																 ,(DATA)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpVAEventScrubsReport.csv'
																																 );

		Event_BadRecords				 	:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 OR
																												corp_vendor_Invalid 									<> 0 OR																						
																												corp_state_origin_Invalid 					 	<> 0 OR
																												corp_process_date_Invalid							<> 0 OR
																												corp_sos_charter_nbr_Invalid 					<> 0 OR
																												event_filing_date_Invalid 						<> 0 
																												
																											 );																									 

		Event_GoodRecords					:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 AND
																												corp_vendor_Invalid 									= 0 AND																				
																												corp_state_origin_Invalid 					 	= 0 AND
																												corp_process_date_Invalid						  = 0 AND
																												corp_sos_charter_nbr_Invalid 					= 0 AND
																												event_filing_date_Invalid							= 0 
																												
																											);

		Event_FailBuild						:= IF(COUNT(Event_GoodRecords) = 0,TRUE,FALSE);

		Event_ApprovedRecords			:= PROJECT(Event_GoodRecords,TRANSFORM(Corp2_Mapping.LayoutsCommon.Events,SELF := LEFT));
		

		Event_ALL									:= SEQUENTIAL(IF(COUNT(Event_BadRecords) <> 0
																											,IF (poverwrite
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,OVERWRITE,__COMPRESSED__)
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,__COMPRESSED__)
																													)
																											)
																									 ,OUTPUT(Event_ScrubsWithExamples, ALL, NAMED('CorpEventVAScrubsReportWithExamples'+filedate))
																									 //Send Alerts if Scrubs exceeds thresholds
																									 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.VA - No "EVENT" Corp Scrubs Alerts'))
																									 ,Event_ErrorSummary
																									 ,Event_ScrubErrorReport
																									 ,Event_SomeErrorValues			
																									 ,Event_SubmitStats
																								);

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := mapMain;
		Main_S := Scrubs_Corp2_Mapping_VA_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= OUTPUT(Main_U.SummaryStats, NAMED('Main_ErrorSummary_VA'+filedate));
		Main_ScrubErrorReport 		:= OUTPUT(CHOOSEN(Main_U.AllErrors, 1000), NAMED('Main_ScrubErrorReport_VA'+filedate));
		Main_SomeErrorValues			:= OUTPUT(CHOOSEN(Main_U.BadValues, 1000), NAMED('Main_SomeErrorValues_VA'+filedate));
		Main_IsScrubErrors		 		:= IF(COUNT(Main_U.AllErrors) <> 0,TRUE,FALSE);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= OUTPUT(Main_N.BitmapInfile,,'~thor_data::corp_va_main_scrubs_bits',OVERWRITE,COMPRESSED);	//long term storage
		Main_TranslateBitMap			:= OUTPUT(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_VA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_VA_Main').SubmitStats;
		Main_ScrubsWithExamples := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_VA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_VA_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpMain_VA Report' //subject
																																 ,'Scrubs CorpMain_VA Report' //body
																																 ,(DATA)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpVAMainScrubsReport.csv'
																															);

		Main_BadRecords						:= Main_N.ExpandedInFile(	
																											 dt_vendor_first_reported_Invalid					 			<> 0 OR
																											 dt_vendor_last_reported_Invalid 								<> 0 OR
																											 dt_first_seen_Invalid 													<> 0 OR
																											 dt_last_seen_Invalid 													<> 0 OR
																											 corp_ra_dt_first_seen_Invalid 									<> 0 OR
																											 corp_ra_dt_last_seen_Invalid 									<> 0 OR
																											 corp_key_Invalid 															<> 0 OR
																											 corp_vendor_Invalid 														<> 0 OR
																											 corp_state_origin_Invalid 									 		<> 0 OR
																											 corp_process_date_Invalid										  <> 0 OR
																											 corp_orig_sos_charter_nbr_Invalid 							<> 0 OR
																											 corp_legal_name_Invalid 												<> 0 OR	
																											 corp_ln_name_type_cd_Invalid 									<> 0 OR
																											 corp_ln_name_type_desc_Invalid 								<> 0 OR
																											 corp_address1_type_cd_Invalid 									<> 0 OR
																											 corp_address1_type_desc_Invalid 								<> 0 OR
																											 corp_address1_effective_date_Invalid 					<> 0 OR
																											 corp_status_date_Invalid 											<> 0 OR
																											 corp_status_desc_Invalid                       <> 0 OR
																											 corp_inc_state_Invalid 		 										<> 0 OR
																											 corp_inc_date_Invalid 													<> 0 OR
																											 corp_term_exist_cd_Invalid 										<> 0 OR
																											 corp_term_exist_exp_Invalid 										<> 0 OR
																											 corp_term_exist_desc_Invalid 									<> 0 OR
																											 corp_foreign_domestic_ind_Invalid 							<> 0 OR
																											 corp_forgn_state_cd_Invalid 										<> 0 OR
																											 corp_forgn_state_desc_Invalid									<> 0 OR
																											 corp_forgn_date_Invalid 												<> 0 OR
																											 corp_orig_bus_type_cd_Invalid 									<> 0 OR
																											 corp_ra_effective_date_Invalid 							 	<> 0 OR
																											 corp_agent_status_desc_Invalid                 <> 0 OR
																											 corp_agent_assign_date_Invalid                 <> 0 OR
																											 corp_name_effective_date_Invalid               <> 0 OR
																											 corp_name_reservation_expiration_date_Invalid 	<> 0
																										);
																										 																	
		Main_GoodRecords				:= Main_N.ExpandedInFile(
																											 dt_vendor_first_reported_Invalid					 			= 0 AND
																											 dt_vendor_last_reported_Invalid 								= 0 AND
																											 dt_first_seen_Invalid 													= 0 AND
																											 dt_last_seen_Invalid 													= 0 AND
																											 corp_ra_dt_first_seen_Invalid 									= 0 AND
																											 corp_ra_dt_last_seen_Invalid 									= 0 AND
																											 corp_key_Invalid 															= 0 AND
																											 corp_vendor_Invalid 														= 0 AND
																											 corp_state_origin_Invalid 									 		= 0 AND
																											 corp_process_date_Invalid										  = 0 AND
																											 corp_orig_sos_charter_nbr_Invalid 							= 0 AND
																											 corp_legal_name_Invalid 												= 0 AND	
																											 corp_ln_name_type_cd_Invalid 									= 0 AND
																											 corp_ln_name_type_desc_Invalid                 = 0 AND
																											 corp_address1_type_cd_Invalid 									= 0 AND
																											 corp_address1_type_desc_Invalid 								= 0 AND
																											 corp_address1_effective_date_Invalid 					= 0 AND
																											 corp_status_date_Invalid 											= 0 AND
																											 corp_status_desc_Invalid                       = 0 AND
																											 corp_inc_state_Invalid 												= 0 AND
																											 corp_inc_date_Invalid 													= 0 AND
																											 corp_term_exist_cd_Invalid 										= 0 AND
																											 corp_term_exist_exp_Invalid 										= 0 AND
																											 corp_term_exist_desc_Invalid 									= 0 AND
																											 corp_foreign_domestic_ind_Invalid 							= 0 AND
																											 corp_forgn_state_cd_Invalid 										= 0 AND
																											 corp_forgn_state_desc_Invalid									= 0 AND
																											 corp_forgn_date_Invalid 												= 0 AND
																											 corp_orig_bus_type_cd_Invalid 									= 0 AND
																											 corp_ra_effective_date_Invalid 							 	= 0 AND
																											 corp_agent_status_desc_Invalid                 = 0 AND
																											 corp_agent_assign_date_Invalid                 = 0 AND
																											 corp_name_effective_date_Invalid               = 0 AND
																											 corp_name_reservation_expiration_date_Invalid 	= 0																										 
																								  );

		Main_FailBuild					:= MAP( Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_key_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 										> Scrubs_Corp2_Mapping_VA_Main.Threshold_Percent.CORP_KEY										 => TRUE,
																		Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 	> Scrubs_Corp2_Mapping_VA_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => TRUE,
																		Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 				> Scrubs_Corp2_Mapping_VA_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	 => TRUE,
																		Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 						> Scrubs_Corp2_Mapping_VA_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => TRUE,
																		Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 							> Scrubs_Corp2_Mapping_VA_Main.Threshold_Percent.CORP_INC_DATE 						 	 => TRUE,
																	  COUNT(Main_GoodRecords) = 0																																																																																											 => TRUE,																		
																		FALSE
																	);

		Main_ApprovedRecords		:= PROJECT(Main_GoodRecords,TRANSFORM(Corp2_Mapping.LayoutsCommon.Main,SELF := LEFT));


		Main_ALL		 			:= SEQUENTIAL( IF(COUNT(Main_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,OVERWRITE,__COMPRESSED__)
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__COMPRESSED__)
																									)
																							)
																					,OUTPUT(Main_ScrubsWithExamples, all, named('CorpMainVAScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.VA - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues	
																					,Main_SubmitStats
																			);

	//********************************************************************
  // SCRUB STOCK
  //********************************************************************	
		Stock_F := mapStocks;
		Stock_S := Scrubs_Corp2_Mapping_VA_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Stock_ErrorSummary			 	:= OUTPUT(Stock_U.SummaryStats, NAMED('Stock_ErrorSummary_VA'+filedate));
		Stock_ScrubErrorReport 	 	:= OUTPUT(CHOOSEN(Stock_U.AllErrors, 1000), NAMED('Stock_ScrubErrorReport_VA'+filedate));
		Stock_SomeErrorValues		 	:= OUTPUT(CHOOSEN(Stock_U.BadValues, 1000), NAMED('Stock_SomeErrorValues_VA'+filedate));
		Stock_IsScrubErrors		 	 	:= IF(COUNT(Stock_U.AllErrors)<> 0,TRUE,FALSE);

		// Orbit Stats
		Stock_OrbitStats				 	:= Stock_U.OrbitStats();

		//Outputs files
		Stock_CreateBitMaps				:= OUTPUT(Stock_N.BitmapInfile,,'~thor_data::corp_va_scrubs_bits',OVERWRITE,COMPRESSED);	//long term storage
		Stock_TranslateBitMap			:= OUTPUT(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			 := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_VA_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_VA_Stock').SubmitStats;
		Stock_ScrubsWithExamples := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_VA_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_VA_Stock').CompareToProfile_with_Examples;

		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpStock_VA Report' //subject
																																 ,'Scrubs CorpStock_VA Report' //body
																																 ,(DATA)Stock_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpVAEventScrubsReport.csv'
																																);

		Stock_BadRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 OR
																												corp_vendor_Invalid 									<> 0 OR
																												corp_state_origin_Invalid 					 	<> 0 OR
																												corp_process_date_Invalid						  <> 0 OR
																												corp_sos_charter_nbr_Invalid					<> 0 OR
																											  stock_shares_issued_Invalid						<> 0 
																											 );
																												
		Stock_GoodRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 AND
																												corp_vendor_Invalid 									= 0 AND
																												corp_state_origin_Invalid 					 	= 0 AND
																												corp_process_date_Invalid						  = 0 AND
																												corp_sos_charter_nbr_Invalid					= 0 AND
																											  stock_shares_issued_Invalid						= 0 
																											 );
																														
		Stock_FailBuild						:= IF(COUNT(Stock_GoodRecords) = 0,TRUE,FALSE);

		Stock_ApprovedRecords			:= PROJECT(Stock_GoodRecords,TRANSFORM(Corp2_Mapping.LayoutsCommon.Stock,SELF := LEFT));

		Stock_ALL									:= SEQUENTIAL( IF(COUNT(Stock_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,__compressed__)
																									)
																							)
																					,output(Stock_ScrubsWithExamples, all, named('CorpStockVAScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Stock_ScrubsAlert) > 0, Stock_MailFile, OUTPUT('CORP2_MAPPING.VA - No "Stock" Corp Scrubs Alerts'))
																					,Stock_ErrorSummary
																					,Stock_ScrubErrorReport
																					,Stock_SomeErrorValues	
																					,Stock_SubmitStats
																					);	

	//********************************************************************
  // UPDATE
  //********************************************************************

	Fail_Build						:= IF(Event_FailBuild = TRUE OR Main_FailBuild = TRUE OR Stock_FailBuild = TRUE,TRUE,FALSE);
	IsScrubErrors					:= IF(Event_IsScrubErrors = TRUE OR Main_IsScrubErrors = TRUE OR Stock_IsScrubErrors = TRUE,TRUE,FALSE);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Stock_' 	+ state_origin, Stock_ApprovedRecords, write_stock,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Stock_' 	+ state_origin, Stock_F	, write_fail_stock,,,pOverwrite);

	mapVA:= sequential ( IF(pshouldspray = TRUE,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											// ,Corp2_Raw_VA.Build_Bases(filedate,version,puseprod).ALL // Determined building of bases is not needed
											,Event_All
											,Main_All
											,Stock_All									
											,IF(Fail_Build <> TRUE	 
												 ,SEQUENTIAL (write_event
																		 ,write_main
																		 ,write_stock	
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_'	+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_'	+state_origin)
																		 ,IF(COUNT(Main_BadRecords) <> 0 OR COUNT(Event_BadRecords) <> 0 OR COUNT(Stock_BadRecords)<>0
																		 	 ,Corp2_Mapping.Send_Email(state_origin,version,COUNT(Main_BadRecords)<>0,,COUNT(Event_BadRecords)<>0,COUNT(Stock_BadRecords)<>0,COUNT(Main_BadRecords),,COUNT(Event_BadRecords),COUNT(Stock_BadRecords),COUNT(Main_ApprovedRecords),,COUNT(Event_ApprovedRecords),COUNT(Stock_ApprovedRecords)).RecordsRejected																				 
																		 	 ,Corp2_Mapping.Send_Email(state_origin,version,COUNT(Main_BadRecords)<>0,,COUNT(Event_BadRecords)<>0,COUNT(Stock_BadRecords)<>0,COUNT(Main_BadRecords),,COUNT(Event_BadRecords),COUNT(Stock_BadRecords),COUNT(Main_ApprovedRecords),,COUNT(Event_ApprovedRecords),COUNT(Stock_ApprovedRecords)).MappingSuccess																				 
																		 	 )
																		 ,IF(IsScrubErrors
																		 	 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,FALSE,Event_IsScrubErrors,Stock_IsScrubErrors).FieldsInvalidPerScrubs
																			 )
																		 ) //if Fail_Build <> true																			
												 ,SEQUENTIAL (write_fail_event
																		 ,write_fail_main
																		 ,write_fail_stock												 
																		 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
										);
										
	isFileDateValid := IF((STRING)std.date.today() BETWEEN ut.date_math(filedate,-30) AND ut.date_math(filedate,30),TRUE,FALSE);
	RETURN SEQUENTIAL (	 IF(isFileDateValid
													,mapVA
													,SEQUENTIAL (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																			,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																			)
													)
										);

	END;	// end of Update function

END;  // end of Module
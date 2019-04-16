import corp2, corp2_mapping, corp2_raw_nv, scrubs_corp2_mapping_nv_ar, scrubs, scrubs_corp2_mapping_nv_event,
			 scrubs_corp2_mapping_nv_main, scrubs_corp2_mapping_nv_stock, tools, ut, versioncontrol, std;
 
export NV := module 

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function

		state_origin 						:= 'NV';
		state_fips	  					:= '32';	
		state_desc	 						:= 'NEVADA';

		CorporationRAID					:= dedup(sort(distribute(Corp2_Raw_NV.Files(fileDate,puseprod).input.Corporation.Logical,hash(corp2.t2u(ra_id))),record,local),record,local) : independent;
		CorporationCorpID				:= dedup(sort(distribute(Corp2_Raw_NV.Files(fileDate,puseprod).input.Corporation.Logical,hash(corp2.t2u(corp_id))),record,local),record,local) : independent;	
		RA											:= dedup(sort(distribute(Corp2_Raw_NV.Files(fileDate,puseprod).input.RA.Logical,hash(corp2.t2u(ra_id))),record,local),record,local) : independent;
		Officers								:= dedup(sort(distribute(Corp2_Raw_NV.Files(fileDate,puseprod).input.Officers.Logical,hash(corp2.t2u(corp_id))),record,local),record,local) : independent;
		Actions									:= dedup(sort(distribute(Corp2_Raw_NV.Files(fileDate,puseprod).input.Actions.Logical,hash(corp2.t2u(corp_id))),record,local),record,local) : independent;
		Stock										:= dedup(sort(distribute(Corp2_Raw_NV.Files(fileDate,puseprod).input.Stock.Logical,hash(corp2.t2u(corp_id))),record,local),record,local) : independent;

		//Adding corp_key here since there are corporation records that do not have an associated RA or Officer record.
		ds_CorporationRAID 					 := project(CorporationRAID,
																					  transform(Corp2_Raw_NV.Layouts.TempCorpRALayout,
																										  self.corp_key		:= state_fips +'-' + left.corp_id;
																											self 						:= left;
																										  self 						:= [];
																										 )
																					 ) : independent;

		//join Corporation with RA data
		ds_CorpRA										:= join(ds_CorporationRAID,RA,
																				left.ra_id = right.ra_id,
																				transform(Corp2_Raw_NV.Layouts.TempCorpRALayout,
																									self.rawRA_country		:= Corp2_mapping.fCleancountry(state_origin,state_desc,right.st).country;
																									self.mailing_zip			:= Corp2_mapping.fCleanZip(state_origin,state_desc,right.mailing_addr1,right.mailing_addr2,right.mailing_city,right.mailing_st,right.mailing_zip,right.mailing_country).zip;
																									self.mailing_country	:= Corp2_mapping.fCleancountry(state_origin,state_desc,right.mailing_st,right.mailing_country).country;
																									self 									:= right;
																									self 									:= left;
																									self 									:= [];																				
																								 ),
																			  left outer,
																			  local
																		   ) : independent;

		ds_CorpRA_Corpid						:= distribute(ds_CorpRA,hash(corp2.t2u(corp_id))) : independent;

		//join Corporation & Officers data															
		ds_Corp_Officers						:= join(ds_CorpRA_Corpid,Officers,
																			  left.corp_id = right.corp_id,
																			  transform(Corp2_Raw_NV.Layouts.TempCorpOfficersLayout,
																									self.zip							:= Corp2_mapping.fCleanZip(state_origin,state_desc,right.addr1,right.addr2,right.city,right.st,right.zip,right.country).zip;
																								  self.country 					:= Corp2_mapping.fCleancountry(state_origin,state_desc,right.st,right.country).country;
																								  self 									:= right;
																								  self 									:= left;
																								  self 									:= [];		
																								 ),
																			  inner,
																			  local
																			 ) : independent;

		//join Corporation with Actions data	
		ds_CorpActions						  := join(Actions,CorporationCorpID,
																			  left.corp_id = right.corp_id,
																			  transform(Corp2_Raw_NV.Layouts.TempCorpActionsLayout,
																								  self.corp_key					:= state_fips + '-' + left.corp_id;																				
																								  self 									:= left;
																								  self 									:= right;
																								),
																			  left outer,
																			  local
																			 ) : independent;

		//join Corporation with Stock data
		ds_CorpStock						    := join (CorporationCorpID,Stock,
																				 left.corp_id = right.corp_id,
																				 transform(Corp2_Raw_NV.Layouts.TempCorpStockLayout,
																									 self.corp_key				:= state_fips + '-' + left.corp_id;
																									 self 								:= left;
																									 self 								:= right;
																									),
																				 left outer,
																				 local
																				) : independent;
																						
		//********************************************************************
		// PROCESS CORPORATE MASTER (MAIN) DATA
		//********************************************************************
		//////////////////////////////////////////////////////////////////////
		// 1) ds_CorpRA_Reserved_Mark:
		//		Contains corporation and contact data (reservation_owner_name).
		//		These are identified by corp_category in ['MARK','RESERVED NAME'].
		//    These records have no associated RA or OFFICER record.
		//////////////////////////////////////////////////////////////////////
		ds_CorpRA_Reserved_Mark							:= ds_CorpRA_Corpid(corp2.t2u(corp_category) in ['MARK','RESERVED NAME']);  
		ds_CorpRA_NonReserved_NonMark				:= ds_CorpRA_Corpid(corp2.t2u(corp_category) not in ['MARK','RESERVED NAME']);
		ds_CorpRA_With_Foreign_Names				:= ds_CorpRA_Corpid(corp2.t2u(corp_foreign_name)<> '');	

		Corp2_mapping.LayoutsCommon.Main CorpRAReservedMarkTransform(Corp2_Raw_NV.Layouts.TempCorpRALayout l) := transform
			self.dt_vendor_first_reported					 := (integer)fileDate;
			self.dt_vendor_last_reported					 := (integer)fileDate;
			self.dt_first_seen										 := (integer)fileDate;
			self.dt_last_seen											 := (integer)fileDate;
			self.corp_ra_dt_first_seen						 := (integer)fileDate;
			self.corp_ra_dt_last_seen							 := (integer)fileDate;			
			self.corp_key 												 := l.corp_key;
			self.corp_vendor 											 := state_fips;
			self.corp_state_origin 								 := state_origin;
			self.corp_process_date 								 := fileDate;
			self.corp_orig_sos_charter_nbr 				 := corp2.t2u(l.corp_no);
			self.corp_legal_name 									 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.corp_name).BusinessName;
			self.corp_ln_name_type_cd 						 := Corp2_Raw_NV.Functions.CorpLNNameTypeCD(l.corp_type);
			self.corp_ln_name_type_desc 					 := Corp2_Raw_NV.Functions.CorpLNNameTypeDesc(l.corp_type);
			self.corp_status_desc 								 := corp2.t2u(l.corp_status);
			self.corp_status_date 								 := Corp2_mapping.fValidateDate(l.status_changed_dt).PastDate;
			self.corp_standing										 := if(corp2.t2u(l.corp_status) = 'ACTIVE','Y','');
			self.corp_status_comment 							 := if(corp2.t2u(l.is_on_admin_hold)='T','IS ON ADMINISTRATIVE HOLD', '');
			self.corp_inc_state 									 := state_origin;
			self.corp_inc_date 										 := if(corp2.t2u(l.qualifying_state) in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');			
			self.corp_term_exist_cd 							 := if(Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate <> '','D','');
			self.corp_term_exist_exp 							 := if(Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate <> '',Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate,'');
			self.corp_term_exist_desc 						 := if(Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate <> '','EXPIRATION DATE','');
			self.corp_foreign_domestic_ind 				 := Corp2_Raw_NV.Functions.CorpForeignDomesticInd(l.corp_type);
			self.corp_forgn_state_cd 							 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_Raw_NV.Functions.CorpForgnStateCD(l.qualifying_state),'');
			self.corp_forgn_state_desc 						 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_Raw_NV.Functions.CorpForgnStateDesc(l.qualifying_state),'');
			self.corp_forgn_date									 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');		
			self.corp_orig_org_structure_desc 		 := Corp2_Raw_NV.Functions.CorpOrigOrgStructureDesc(l.corp_type);																						
			self.corp_for_profit_ind 							 := if(regexfind('NON-PROFIT',corp2.t2u(l.corp_type)),'N','');
			self.corp_addl_info										 := if(corp2.t2u(l.managed_by) <> '','MANAGED BY: ' + corp2.t2u(l.managed_by),'');
			self.corp_country_of_formation				 := Corp2_Raw_NV.Functions.CorpCountryOfFormation(l.qualifying_state);
			self.corp_management_desc							 := corp2.t2u(l.managed_by);
			self.corp_trademark_class_desc1				 := Corp2_Raw_NV.Functions.CorpTrademarkClassDesc1(l.classification);
			self.recordorigin											 := 'C';
			self 																	 := [];
		end;

		ds_CorpRAReservedMark				 			 			 := project(ds_CorpRA_Reserved_Mark,CorpRAReservedMarkTransform(left));

		Corp2_mapping.LayoutsCommon.Main ContRAReservedMarkTransform(Corp2_Raw_NV.Layouts.TempCorpRALayout l) := transform
			self.dt_vendor_first_reported					 := (integer)fileDate;
			self.dt_vendor_last_reported					 := (integer)fileDate;
			self.dt_first_seen										 := (integer)fileDate;
			self.dt_last_seen											 := (integer)fileDate;
			self.corp_ra_dt_first_seen						 := (integer)fileDate;
			self.corp_ra_dt_last_seen							 := (integer)fileDate;			
			self.corp_key 												 := l.corp_key;
			self.corp_vendor 											 := state_fips;
			self.corp_state_origin 								 := state_origin;
			self.corp_process_date 								 := fileDate;
			self.corp_orig_sos_charter_nbr 				 := corp2.t2u(l.corp_no);
			self.corp_legal_name 									 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.corp_name).BusinessName;
			self.corp_ln_name_type_cd 						 := Corp2_Raw_NV.Functions.CorpLNNameTypeCD(l.corp_type);
			self.corp_ln_name_type_desc 					 := Corp2_Raw_NV.Functions.CorpLNNameTypeDesc(l.corp_type);
			self.corp_status_desc 								 := corp2.t2u(l.corp_status);
			self.corp_status_date 								 := Corp2_mapping.fValidateDate(l.status_changed_dt).PastDate;
			self.corp_standing										 := if(corp2.t2u(l.corp_status) = 'ACTIVE','Y','');
			self.corp_status_comment 							 := if(corp2.t2u(l.is_on_admin_hold)='T','IS ON ADMINISTRATIVE HOLD', '');
			self.corp_inc_state 									 := state_origin;
			self.corp_inc_date 										 := if(corp2.t2u(l.qualifying_state) in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');			
			self.corp_term_exist_cd 							 := if(Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate <> '','D','');
			self.corp_term_exist_exp 							 := if(Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate <> '',Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate,'');
			self.corp_term_exist_desc 						 := if(Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate <> '','EXPIRATION DATE','');
			self.corp_foreign_domestic_ind 				 := Corp2_Raw_NV.Functions.CorpForeignDomesticInd(l.corp_type);
			self.corp_forgn_state_cd 							 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_Raw_NV.Functions.CorpForgnStateCD(l.qualifying_state),'');
			self.corp_forgn_state_desc 						 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_Raw_NV.Functions.CorpForgnStateDesc(l.qualifying_state),'');			
			self.corp_forgn_date									 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');		
			self.corp_orig_org_structure_desc 		 := Corp2_Raw_NV.Functions.CorpOrigOrgStructureDesc(l.corp_type);
			self.corp_for_profit_ind 							 := if(regexfind('NON-PROFIT',corp2.t2u(l.corp_type)),'N','');
			self.corp_addl_info										 := if(corp2.t2u(l.managed_by) <> '','MANAGED BY: ' + corp2.t2u(l.managed_by),'');
			self.cont_type_cd		 									 := if(Corp2_mapping.fCleanPersonName(state_origin,state_desc,'','',l.reservation_owner_name).LastName<>'','O','');
			self.cont_type_desc 									 := if(Corp2_mapping.fCleanPersonName(state_origin,state_desc,'','',l.reservation_owner_name).LastName<>'','OWNER','');																				
			self.cont_full_name										 := map(corp2.t2u(stringlib.stringfilterout(l.reservation_owner_name,'.#-\\'))='' => '', //blank out if only special chars exist
																										corp2.t2u(stringlib.stringfilterout(l.reservation_owner_name,'X')) 	  ='' => '', //blank out if only X's exist
																										corp2.t2u(l.reservation_owner_name)
																									 );
			self.cont_address_type_cd					 		 := if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2,l.reservation_owner_city,l.reservation_owner_st,l.reservation_owner_zip).ifAddressExists,'T','');
			self.cont_address_type_desc						 := if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2,l.reservation_owner_city,l.reservation_owner_st,l.reservation_owner_zip).ifAddressExists,'CONTACT','');
			self.cont_address_line1 							 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2).AddressLine1;
      self.cont_address_line2 							 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2,l.reservation_owner_city,l.reservation_owner_st,l.reservation_owner_zip,l.reservation_owner_country).AddressLine2;
			temp_address_line3 										 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2,l.reservation_owner_city,l.reservation_owner_st,l.reservation_owner_zip,l.reservation_owner_country).AddressLine3;
			self.cont_address_line3 							 := if(length(temp_address_line3)=3,
																									 Corp2_Raw_NV.Functions.CorpCountryOfFormation(temp_address_line3),
																									 temp_address_line3
																									);
			self.cont_email_address 							 := corp2.t2u(l.email_address);
			self.corp_trademark_class_desc1				 := Corp2_Raw_NV.Functions.CorpTrademarkClassDesc1(l.classification);
			self.cont_prep_addr_line1 						 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2,l.reservation_owner_city,l.reservation_owner_st,l.reservation_owner_zip,l.reservation_owner_country).PrepAddrLine1;
			self.cont_prep_addr_last_line 				 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.reservation_owner_addr1,l.reservation_owner_addr2,l.reservation_owner_city,l.reservation_owner_st,l.reservation_owner_zip,l.reservation_owner_country).PrepAddrLastLine;			
			self.recordorigin											 := 'T';
			self 																	 := [];
		end;
		
		ds_ContRAReservedMark				 			 			 := project(ds_CorpRA_Reserved_Mark,ContRAReservedMarkTransform(left));

		//////////////////////////////////////////////////////////////////////
		// 2) Process the RA records.  These records are identified by
		//		corp_category not in ['MARK','RESERVED NAME'].  Since the RA
		//    file has two different RA addresses, the file is normalized.
		//////////////////////////////////////////////////////////////////////
		Corp2_mapping.LayoutsCommon.Main CorpRANonReservedNonMarkTransform(Corp2_Raw_NV.Layouts.TempCorpRALayout l, unsigned1 c) := transform,
			skip(c = 2 and Corp2_mapping.fAddressExists(state_origin,state_desc,l.mailing_addr1,l.mailing_addr2,l.mailing_city,l.mailing_st,l.mailing_zip).ifAddressExists <> true)
			self.dt_vendor_first_reported					 := (integer)fileDate;
			self.dt_vendor_last_reported					 := (integer)fileDate;
			self.dt_first_seen										 := (integer)fileDate;
			self.dt_last_seen											 := (integer)fileDate;
			self.corp_ra_dt_first_seen						 := (integer)fileDate;
			self.corp_ra_dt_last_seen							 := (integer)fileDate;
			self.corp_key 												 := l.corp_key;
			self.corp_vendor 											 := state_fips;
			self.corp_state_origin 								 := state_origin;
			self.corp_process_date 								 := fileDate;
			self.corp_orig_sos_charter_nbr 				 := corp2.t2u(l.corp_no);
			self.corp_legal_name 									 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.corp_name).BusinessName;
			self.corp_ln_name_type_cd 						 := Corp2_Raw_NV.Functions.CorpLNNameTypeCD(l.corp_type);
			self.corp_ln_name_type_desc 					 := Corp2_Raw_NV.Functions.CorpLNNameTypeDesc(l.corp_type);
			self.corp_status_desc 								 := corp2.t2u(l.corp_status);
			self.corp_status_date 								 := Corp2_mapping.fValidateDate(l.status_changed_dt).PastDate;
			self.corp_standing										 := if(corp2.t2u(l.corp_status) = 'ACTIVE','Y','');
			self.corp_status_comment 							 := if(corp2.t2u(l.is_on_admin_hold)='T','IS ON ADMINISTRATIVE HOLD', '');
			self.corp_inc_state 									 := state_origin;
			self.corp_inc_date 										 := if(corp2.t2u(l.qualifying_state)in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');
			self.corp_term_exist_cd 							 := if(Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate <> '','D','');
			self.corp_term_exist_exp 							 := if(Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate <> '',Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate,'');
			self.corp_term_exist_desc 						 := if(Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate <> '','EXPIRATION DATE','');
			self.corp_foreign_domestic_ind 				 := Corp2_Raw_NV.Functions.CorpForeignDomesticInd(l.corp_type);
			self.corp_forgn_state_cd 							 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_Raw_NV.Functions.CorpForgnStateCD(l.qualifying_state),'');
			self.corp_forgn_state_desc 						 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_Raw_NV.Functions.CorpForgnStateDesc(l.qualifying_state),'');
			self.corp_forgn_date									 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');		
			self.corp_orig_org_structure_desc 		 := Corp2_Raw_NV.Functions.CorpOrigOrgStructureDesc(l.corp_type);
			self.corp_for_profit_ind 							 := if(regexfind('NON-PROFIT',corp2.t2u(l.corp_type)),'N','');
			self.corp_addl_info										 := if(corp2.t2u(l.managed_by)<>'','MANAGED BY: '+corp2.t2u(l.managed_by),'');
			self.corp_ra_full_name								 := Corp2_mapping.fCleanPersonName(state_origin,state_desc,'','',l.name).LastName;
			self.corp_ra_title_desc								 := if(Corp2_mapping.fCleanPersonName(state_origin,state_desc,'','',l.name).LastName<>'','REGISTERED AGENT','');
			self.corp_ra_resign_date							 := if(Corp2_mapping.fValidateDate(l.ra_resigned_dt).PastDate <> '',Corp2_mapping.fValidateDate(l.ra_resigned_dt).PastDate,'');
      self.corp_ra_address_type_cd	 				 := choose(C,if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip).ifAddressExists,'R',''),
																												 if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.mailing_addr1,l.mailing_addr2,l.mailing_city,l.mailing_st,l.mailing_zip).ifAddressExists,'R','')
																											);      
			self.corp_ra_address_type_desc 				 := choose(C,if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip).ifAddressExists,'REGISTERED OFFICE',''),
																												 if(Corp2_mapping.fAddressExists(state_origin,state_desc,l.mailing_addr1,l.mailing_addr2,l.mailing_city,l.mailing_st,l.mailing_zip).ifAddressExists,'REGISTERED AGENT MAILING ADDRESS','')
																											);
      self.corp_ra_address_line1 					 	 := choose(C,Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip).AddressLine1,
																												 Corp2_mapping.fCleanAddress(state_origin,state_desc,l.mailing_addr1,l.mailing_addr2,l.mailing_city,l.mailing_st,l.mailing_zip,l.mailing_country).AddressLine1
																											);
      self.corp_ra_address_line2 						 := choose(C,Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip).AddressLine2,
																												 Corp2_mapping.fCleanAddress(state_origin,state_desc,l.mailing_addr1,l.mailing_addr2,l.mailing_city,l.mailing_st,l.mailing_zip,l.mailing_country).AddressLine2
																											);
      self.corp_ra_address_line3 						 := choose(C,Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip).AddressLine3,
																												 Corp2_mapping.fCleanAddress(state_origin,state_desc,l.mailing_addr1,l.mailing_addr2,l.mailing_city,l.mailing_st,l.mailing_zip,l.mailing_country).AddressLine3
																											);
      self.corp_ra_phone_number  						 := corp2.t2u(l.phone_no);
			self.corp_ra_fax_nbr									 := corp2.t2u(l.fax_no);
      self.corp_ra_email_address 						 := corp2.t2u(l.email_address); 
		  self.ra_prep_addr_line1         			 := choose(C,Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip).PrepAddrLine1,
																												 Corp2_mapping.fCleanAddress(state_origin,state_desc,l.mailing_addr1,l.mailing_addr2,l.mailing_city,l.mailing_st,l.mailing_zip,l.mailing_country).PrepAddrLine1);
			self.ra_prep_addr_last_line      	 		 := choose(C,Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip).PrepAddrLastLine,
																												 Corp2_mapping.fCleanAddress(state_origin,state_desc,l.mailing_addr1,l.mailing_addr2,l.mailing_city,l.mailing_st,l.mailing_zip,l.mailing_country).PrepAddrLastLine
																											);
      self.corp_agent_county		 						 := choose(C,'',
																												 corp2.t2u(l.mailing_county)
																											);
			self.corp_country_of_formation				 := Corp2_Raw_NV.Functions.CorpCountryOfFormation(l.qualifying_state);
			self.corp_management_desc							 := corp2.t2u(l.managed_by);
			self.corp_trademark_class_desc1				 := Corp2_Raw_NV.Functions.CorpTrademarkClassDesc1(l.classification);
			self.recordorigin											 := 'C';			
			self 																	 := [];
		end;
		
		ds_CorpRANonReservedNonMark		 			 		 := normalize(ds_CorpRA_NonReserved_NonMark,2,CorpRANonReservedNonMarkTransform(left,counter));

		//////////////////////////////////////////////////////////////////////
		// 3) Process the corporation records that contains a foreign name.
		//    Instead of normalizing, the foreign names are filtered on 
 		//    corp_foreign_name and a new record is created in the main file.
		//////////////////////////////////////////////////////////////////////
		Corp2_mapping.LayoutsCommon.Main CorpRAWithForeignNamesTransform(Corp2_Raw_NV.Layouts.TempCorpRALayout l) := transform,
		skip(Corp2_Raw_NV.Functions.CorpLegalName(l.corp_foreign_name) = '')
			self.dt_vendor_first_reported					 := (integer)fileDate;
			self.dt_vendor_last_reported					 := (integer)fileDate;
			self.dt_first_seen										 := (integer)fileDate;
			self.dt_last_seen											 := (integer)fileDate;
			self.corp_ra_dt_first_seen						 := (integer)fileDate;
			self.corp_ra_dt_last_seen							 := (integer)fileDate;
			self.corp_key 												 := l.corp_key;
			self.corp_vendor 											 := state_fips;
			self.corp_state_origin 								 := state_origin;
			self.corp_process_date 								 := fileDate;
			self.corp_orig_sos_charter_nbr 				 := corp2.t2u(l.corp_no);
			self.corp_legal_name 									 := Corp2_Raw_NV.Functions.CorpLegalName(l.corp_foreign_name);
			self.corp_ln_name_type_cd 						 := '10';
			self.corp_ln_name_type_desc 					 := 'FOREIGN NAME';
			self.corp_inc_state										 := state_origin;		
			self.corp_inc_date 										 := if(corp2.t2u(l.qualifying_state) in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');			
			self.corp_forgn_date									 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');		
			self.recordorigin											 := 'C';
			self 																	 := l;
			self 																	 := [];
		end;
	
		ds_CorpRAWithForeignNames			 			 		 := project(ds_CorpRA_With_Foreign_Names,CorpRAWithForeignNamesTransform(left));

		//////////////////////////////////////////////////////////////////////
		// 4) Process the OFFICER records. 
		//////////////////////////////////////////////////////////////////////
		Corp2_mapping.LayoutsCommon.Main CorpOfficersTransform(Corp2_Raw_NV.Layouts.TempCorpOfficersLayout l) := transform
			self.dt_vendor_first_reported					 := (integer)fileDate;
			self.dt_vendor_last_reported					 := (integer)fileDate;
			self.dt_first_seen										 := (integer)fileDate;
			self.dt_last_seen											 := (integer)fileDate;
			self.corp_ra_dt_first_seen						 := (integer)fileDate;
			self.corp_ra_dt_last_seen							 := (integer)fileDate;
			self.corp_key 												 := l.corp_key;
			self.corp_vendor 											 := state_fips;
			self.corp_state_origin 								 := state_origin;
			self.corp_process_date 								 := fileDate;
			self.corp_orig_sos_charter_nbr 				 := corp2.t2u(l.corp_no);
			self.corp_legal_name 									 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.corp_name).BusinessName;
			self.corp_ln_name_type_cd 						 := Corp2_Raw_NV.Functions.CorpLNNameTypeCD(l.corp_type);
			self.corp_ln_name_type_desc 					 := Corp2_Raw_NV.Functions.CorpLNNameTypeDesc(l.corp_type);
			self.corp_status_desc 								 := corp2.t2u(l.corp_status);
			self.corp_status_date 								 := Corp2_mapping.fValidateDate(l.status_changed_dt).PastDate;
			self.corp_standing										 := if(corp2.t2u(l.corp_status)='ACTIVE','Y','');
			self.corp_status_comment 							 := if(corp2.t2u(l.is_on_admin_hold)='T','IS ON ADMINISTRATIVE HOLD','');
			self.corp_inc_state 									 := state_origin;
			self.corp_inc_date 										 := if(corp2.t2u(l.qualifying_state)in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');
			self.corp_term_exist_cd 							 := if(Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate <> '','D','');
			self.corp_term_exist_exp 							 := if(Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate <> '',Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate,'');
			self.corp_term_exist_desc 						 := if(Corp2_mapping.fValidateDate(l.expired_dt).GeneralDate <> '','EXPIRATION DATE','');
			self.corp_foreign_domestic_ind 				 := Corp2_Raw_NV.Functions.CorpForeignDomesticInd(l.corp_type);
			self.corp_forgn_state_cd 							 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_Raw_NV.Functions.CorpForgnStateCD(l.qualifying_state),'');
			self.corp_forgn_state_desc 						 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_Raw_NV.Functions.CorpForgnStateDesc(l.qualifying_state),'');			
			self.corp_forgn_date									 := if(corp2.t2u(l.qualifying_state) not in [state_origin,''],Corp2_mapping.fValidateDate(l.creation_dt).PastDate,'');		
			self.corp_orig_org_structure_desc 		 := Corp2_Raw_NV.Functions.CorpOrigOrgStructureDesc(l.corp_type);
			self.corp_for_profit_ind 							 := if(regexfind('NON-PROFIT',corp2.t2u(l.corp_type)),'N','');
			self.corp_addl_info										 := if(corp2.t2u(l.managed_by) <> '','MANAGED BY: ' + corp2.t2u(l.managed_by),'');
			self.cont_type_cd		 									 := if(l.officer_type <> '','T','');
			self.cont_type_desc 									 := if(l.officer_type <> '','CONTACT','');																												
      self.cont_fname												 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.first_name).BusinessName;			//can be a company name
      self.cont_mname												 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.middle_initial).BusinessName;	//can be a company name
      self.cont_lname												 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.last_name).BusinessName; 			//can be a company name
			self.cont_full_name										 := corp2.t2u(self.cont_fname+' '+self.cont_mname+' '+self.cont_lname);
      self.cont_title1_desc 								 :=	map(corp2.t2u(l.officer_type) = 'GPLP' 		 => 'GENERAL PARTNER',
																										corp2.t2u(l.officer_type) = 'MMEMBER'  => 'MANAGING MEMBER',
																										corp2.t2u(l.officer_type) = 'MPARTNER' => 'MANAGING PARTNER',
																										corp2.t2u(l.officer_type)
																									 );
      self.cont_status_cd 									 := map(corp2.t2u(l.inactive) 		= 'T' 	=> 'T',
																									  corp2.t2u(l.terminated) 	= 'T' 	=> 'T',
																									  corp2.t2u(l.resigned) 		= 'T' 	=> 'T',
																									  ''
																									 );
      self.cont_status_desc 								 := map(corp2.t2u(l.inactive) 		= 'T' 	=> 'INACTIVE',
																									  corp2.t2u(l.terminated)		= 'T' 	=> 'TERMINATED',
																									  corp2.t2u(l.resigned) 		= 'T' 	=> 'RESIGNED',
																									  'ACTIVE'
																									  );																									 
			self.cont_address_type_cd							 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip).ifAddressExists,'T','');				
			self.cont_address_type_desc						 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip).ifAddressExists,'CONTACT','');
			self.cont_address_line1 							 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip,l.country).AddressLine1;
      self.cont_address_line2 							 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip,l.country).AddressLine2;
			temp_address_line3 										 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip,l.country).AddressLine3;
			self.cont_address_line3 							 := if(length(temp_address_line3)=3,
																									 Corp2_Raw_NV.Functions.CorpCountryOfFormation(temp_address_line3),
																									 temp_address_line3
																									);			
			self.cont_address_county							 := corp2.t2u(l.county);
			self.cont_email_address 							 := corp2.t2u(l.email_address);
			self.corp_country_of_formation				 := Corp2_Raw_NV.Functions.CorpCountryOfFormation(l.qualifying_state);
			self.corp_management_desc							 := corp2.t2u(l.managed_by);
			self.cont_country											 := Corp2_mapping.fCleanCountry(state_origin,state_desc,l.st,l.country).Country;
			self.corp_trademark_class_desc1				 := Corp2_Raw_NV.Functions.CorpTrademarkClassDesc1(l.classification);
			self.cont_prep_addr_line1     				 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip,l.country).PrepAddrLine1;
			self.cont_prep_addr_last_line 				 := Corp2_mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.st,l.zip,l.country).PrepAddrLastLine;
			self.recordorigin											 := 'T';
			self 																	 := [];
		end;

		ds_CorpOfficers			:= project(ds_Corp_Officers,CorpOfficersTransform(left));
		ds_AllCorp					:= ds_CorpRAReservedMark + ds_ContRAReservedMark + ds_CorpRANonReservedNonMark + ds_CorpRAWithForeignNames + ds_CorpOfficers;
		MapMain							:= dedup(sort(distribute(ds_AllCorp,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// PROCESS CORPORATE ANNUAL REPORT DATA
		//********************************************************************
		ds_ActionsAR			 	:= ds_CorpActions(corp2.t2u(action_type) in ['ANNUAL LIST']);

		Corp2_mapping.LayoutsCommon.AR XformActions2LayoutsCommonAR(Corp2_Raw_NV.Layouts.TempCorpActionsLayout L) := transform			
			self.corp_key													:= l.corp_key;			
			self.corp_vendor 											:= state_fips;
			self.corp_state_origin 								:= state_origin;
			self.corp_process_date 								:= fileDate;
			self.corp_sos_charter_nbr 						:= corp2.t2u(l.corp_no);	
			self.ar_due_dt												:= Corp2_mapping.fValidateDate(l.annual_lo_due_dt).GeneralDate;
			self.ar_filed_dt 											:= Corp2_mapping.fValidateDate(l.action_dt).PastDate;
			self.ar_report_nbr 										:= corp2.t2u(l.document_no);
			self.ar_comment 											:= regexreplace('(\\-)+',corp2.t2u(l.action_notes),'-');
			self.ar_type 													:= corp2.t2u(l.action_type);
			self																	:= l;
			self 																	:= [];
		end;

    ds_CorpAR_proj			:= project(ds_ActionsAR,XformActions2LayoutsCommonAR(left));
		ds_CorpAR			 			:= ds_CorpAR_proj(ar_filed_dt <>'' or ar_type <> '' or ar_report_nbr <> '' or ar_comment <> '');
		MapAR								:= dedup(sort(distribute(ds_CorpAR,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// PROCESS CORPORATE EVENT DATA
		//********************************************************************
    ds_ActionsNonAR	 		:= ds_CorpActions(corp2.t2u(action_type) not in ['ANNUAL LIST']);

		Corp2_mapping.LayoutsCommon.Events XformActions2LayoutsCommonEvents(Corp2_Raw_NV.Layouts.TempCorpActionsLayout L) := transform		
			self.corp_key													 := l.corp_key;			
			self.corp_vendor 											 := state_fips;
			self.corp_state_origin 								 := state_origin;
			self.corp_process_date 								 := fileDate;
			self.corp_sos_charter_nbr 						 := corp2.t2u(l.corp_no);
			self.event_filing_reference_nbr 			 := corp2.t2u(l.document_no);				
			self.event_filing_date 								 := map(Corp2_mapping.fValidateDate(l.action_dt).PastDate			 	<>'' => Corp2_mapping.fValidateDate(l.action_dt).PastDate,
																										Corp2_mapping.fValidateDate(l.effective_dt).GeneralDate <>'' => Corp2_mapping.fValidateDate(l.effective_dt).GeneralDate,
																										''
																									 );			
			self.event_date_type_cd								 := map(Corp2_mapping.fValidateDate(l.action_dt).PastDate			 	<>'' => 'FIL',
																									  Corp2_mapping.fValidateDate(l.effective_dt).GeneralDate <>'' => 'EFF',
																										''
																									 );
			self.event_date_type_desc							 := map(Corp2_mapping.fValidateDate(l.action_dt).PastDate			 	<>'' => 'FILING',
																										Corp2_mapping.fValidateDate(l.effective_dt).GeneralDate <>'' => 'EFFECTIVE',
																										''
																									 );
			self.event_filing_desc 								 := corp2.t2u(l.action_type);
			self.event_desc 											 := regexreplace('(\\-)+',corp2.t2u(l.action_notes),'-');
			self 																	 := []; 
		end;

		ds_CorpEvent_proj 	:= project(ds_ActionsNonAR,XformActions2LayoutsCommonEvents(left));
		ds_CorpEvent	 			:= ds_CorpEvent_proj(event_filing_reference_nbr<>'' or event_date_type_cd <> '' or event_date_type_desc <> '' or event_filing_date <> '' or event_filing_desc <> '' or event_desc <> '');
		MapEvent						:= dedup(sort(distribute(ds_CorpEvent,hash(corp_key)),record,local),record,local) : independent;
																
		//********************************************************************	
		// PROCESS CORP STOCK DATA
		//******************************************************************** 
		BOOLEAN _is_valid (string pStockAttr) := if(corp2.t2u(stringlib.stringFilterOut(pStockAttr,'.0'))<>'',true,false); 
 
		Corp2_mapping.LayoutsCommon.Stock XformStock2LayoutsCommonStock(Corp2_Raw_NV.Layouts.TempCorpStockLayout L) := transform
			self.corp_key													:= l.corp_key;			
			self.corp_vendor 											:= state_fips;
			self.corp_state_origin 								:= state_origin;
			self.corp_process_date 								:= fileDate;
			self.corp_sos_charter_nbr 						:= corp2.t2u(l.corp_no);
			self.stock_authorized_nbr 						:= if(_is_valid(l.no_par_share_count),Corp2_Raw_NV.Functions.FormatNumericValues(l.no_par_share_count,true),'');
			self.stock_par_value 								  := if(_is_valid(Corp2_Raw_NV.Functions.FormatNumericValues(l.par_share_value)),Corp2_Raw_NV.Functions.FormatNumericValues(l.par_share_value,true),''); 		
      self.stock_nbr_par_shares 						:= if(_is_valid(l.par_share_count),Corp2_Raw_NV.Functions.FormatNumericValues(l.par_share_count,true),'');
		  self.stock_total_capital 							:= if(_is_valid(l.capital_amt),Corp2_Raw_NV.Functions.FormatNumericValues(l.capital_amt,true),'');
			self																	:= l;
			self 																	:= [];
    end;

		ds_CorpStock_proj	 := project(ds_CorpStock,XformStock2LayoutsCommonStock(left));
		ds_CorpStock_filt	 := ds_CorpStock_proj(stock_par_value <>'' or stock_nbr_par_shares <> '' or stock_authorized_nbr <> '' or stock_total_capital <> '');	
		MapStock 			 		 := dedup(sort(distribute(ds_CorpStock_filt,hash(corp_key)),record,local),record,local) : independent;
  
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
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NV_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_NV_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NV_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_NV_AR').CompareToProfile_with_Examples;

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
		Event_SubmitStats 			 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NV_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_NV_Event').SubmitStats;
		Event_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NV_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_NV_Event').CompareToProfile_with_Examples;

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
		Main_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NV_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_NV_Main').SubmitStats;
		Main_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NV_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_NV_Main').CompareToProfile_with_Examples;

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
																										 corp_standing_Invalid									<> 0 or
																										 corp_status_comment_Invalid						<> 0 or
																										 corp_inc_date_Invalid 									<> 0 or
																										 corp_term_exist_cd_Invalid							<> 0 or
																										 corp_term_exist_exp_Invalid						<> 0 or
																										 corp_foreign_domestic_ind_Invalid			<> 0 or																															
																										 corp_forgn_state_cd_Invalid 						<> 0 or
																										 corp_forgn_state_desc_Invalid 					<> 0 or
																										 corp_forgn_date_Invalid 								<> 0 or
																										 corp_for_profit_ind_Invalid						<> 0 or
																										 corp_ra_title_desc_Invalid							<> 0 or																														
																										 corp_ra_resign_date_Invalid						<> 0 or
																										 corp_ra_address_type_desc_Invalid			<> 0 or
																										 corp_country_of_formation_Invalid			<> 0 or
																										 corp_trademark_class_desc1_Invalid			<> 0 or
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
																										 corp_standing_Invalid									= 0 and
																										 corp_status_comment_Invalid						= 0 and
																										 corp_inc_date_Invalid 									= 0 and
																										 corp_term_exist_cd_Invalid							= 0 and
																										 corp_term_exist_exp_Invalid						= 0 and
																										 corp_foreign_domestic_ind_Invalid			= 0 and
																										 corp_forgn_state_cd_Invalid 						= 0 and
																										 corp_forgn_state_desc_Invalid					= 0 and
																										 corp_forgn_date_Invalid 								= 0 and
																										 corp_for_profit_ind_Invalid						= 0 and
																										 corp_ra_title_desc_Invalid							= 0 and
																										 corp_ra_resign_date_Invalid						= 0 and
																										 corp_ra_address_type_desc_Invalid			= 0 and
																										 corp_country_of_formation_Invalid			= 0 and
																										 corp_trademark_class_desc1_Invalid			= 0 and
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
		Stock_SubmitStats 			 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NV_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_NV_Stock').SubmitStats;
		Stock_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NV_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_NV_Stock').CompareToProfile_with_Examples;

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
											// ,Corp2_Raw_NV.Build_Bases(filedate,version,puseprod).All  // Determined building of bases is not needed
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